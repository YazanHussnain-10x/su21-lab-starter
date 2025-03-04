#include "model_test.h"
#include "arch_test.h"

RVTEST_ISA("RV64I")

# Test code region
.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN
#ifdef TEST_CASE_1

    RVTEST_CASE(1,"//check ISA:=regex(.*64.*); check ISA:=regex(.*I.*); def rvtest_mtrap_routine=True; def rvtest_strap_routine=True; def TEST_CASE_1=True",sv64)

RVTEST_SIGBASE( x13,signature_x13_1)


main:
# -------------------------------------------------------------------------

#ifdef rvtest_mtrap_routine							// Verification of existance of rvtest_mtrap_routine
	LI a4, 0xceed
	RVTEST_SIGUPD(x13,a4)
#endif
#ifdef rvtest_strap_routine					         	// Verification of existance of rvtest_strap_routine
	LI a4, 0xbeed
	RVTEST_SIGUPD(x13,a4)
#endif

# -------------------------Set the all mem PMP-----------------------------	

	ALL_MEM_PMP							        // set the permissions of all memory 
	csrw satp, zero								// write zero to the satp (bare mode)
	
# -------------------------------------------------------------------------

	.set va,       	 0x020000000000						// 39 bits of VA address
	.set pa,       	 0x80000000000000 					// 56 bits of PA address (such that ppn0==0 and ppn1==0)
	.set va_data,  	 0x028000000000						// 39 bits of VA address 
	.set pa_data,  	 0x82000000000000					// 56 bits of PA address 

# -------------------------Storing 0XCAFEBEEF at pa_data-----------------

        LI( a0,pa_data)                                                         // Loads the address of phyical address of the pa_data
        LI(a1,0xBEEFDEADCAFEBEEF)                                               // Loads 0xCAFEBEEF in a1
        SREG a1,0(a0)                                                           // Stores a1 at pa_data
	
# -------------------------Set the PTE for level2 for sv48-----------------
								                // level2 PTE setup for pa (0x0900000000 -> 0x80000000000000)	
	LI (a0, pa)                                                             // loads the PA address in a0
	LI a1, ( PTE_D | PTE_A | PTE_X | PTE_W | PTE_R | PTE_V )                // sets the permission bits
	PTE_SETUP_RV64(a0, a1, t0, t1, va, LEVEL3, sv48)                        // setup the PTE for level2 for sv48
 										// level2 PTE setup for pa (0x0980000000 -> pa_data)
	LI( a0,pa_data)								// loads the PA address in a0 
	LI a1, ( PTE_D | PTE_A | PTE_X | PTE_W | PTE_R | PTE_V) 			// sets the permission bits
	PTE_SETUP_RV64(a0, a1, t0, t1, va_data, LEVEL3, sv48)                   // setup the PTE for level2 for sv48



# -------------------------Set the SATP for virtulization------------------

	SATP_SETUP_RV64 (sv48)                                                  // set the SATP for virtualization

# -------------------------Save area logic----------------------------------
	/* Save Virtual addresses in of Code and Data 
	in their respective S-mode save area */
	/****** code ******/
	LI (t0, va)                                                             // load the virtual address of vm_en in t0
	LI (t1, pa)                                                             // load the physical address of vm_en in t1
	sub t0, t0, t1                                                          // (VA-PA) Note: VA > PA 
	csrr sp, mscratch                                                       // load the value of mscratch in sp
	add t1,sp,t0                                                            // add the offset to the base address of save area
	csrw sscratch, t1                                                       // write the address of save area in sscratch
	LREG t1, code_bgn_off+0*sv_area_sz(sp)                                  // load the address of code_bgn_off in t1
	add t2, t1, t0                                                          // add the offset to the base address of save area
	SREG t2, code_bgn_off+1*sv_area_sz(sp)                                  // write the address of code_bgn_off in sscratch
	/******* data *******/
	// update save area
	LI (t0, va_data)                                                        // load the virtual address of rvtest_data in t0
	LI (t1, pa_data)                                                    	// load the physical address of rvtest_data in t1
	sub t0, t0, t1                                                          // (VA-PA) Note: VA > PA 
	LREG t1, data_bgn_off+0*sv_area_sz(sp)                                  // load the address of data_bgn_off in t1
	add  t2, t1,t0                                                          // add the offset to the base address of save area
	SREG t2, data_bgn_off+1*sv_area_sz(sp)                                  // write the address of data_bgn_off in sscratch
	// vmem
	LI (t0, va_data)                                                        // load the virtual address of rvtest_data in t0
	LI (t1, pa_data)                                                   	// load the physical address of rvtest_data in t1
	sub t0, t0, t1                                                          // (VA-PA) Note: VA > PA
	LREG t1, vmem_bgn_off+0*sv_area_sz(sp)                                  // load the address of vmem_bgn_off in t1
	add t2, t1, t0                                                          // add the offset to the base address of save area
	SREG t2, vmem_bgn_off+1*sv_area_sz(sp)                                  // write the address of vmem_bgn_off in sscratch
	sfence.vma                                                              // flush the TLB
	
	RVTEST_GOTO_LOWER_MODE	Smode		                                // Switching to S mode

# -------------------------virtulization enabled-------------------------------

vm_en:
	LI (t0, va_data)                                          
	nop
	nop          
	LREG x2, 0(t0)                                                          // test the load access (should be successful)
        nop                                             
	RVTEST_GOTO_MMODE		                                        // Switching back to M mode
        
	LI (a4, 0x123)
	RVTEST_SIGUPD(x13,a4)                                                   // Verification of virtualization disabled

#endif
 # -----------------------------------------------------------------------------

RVTEST_CODE_END
RVMODEL_HALT

RVTEST_DATA_BEGIN

#ifdef rvtest_strap_routine
.align 12
rvtest_slvl1_pg_tbl:
        RVTEST_PTE_IDENT_MAP
rvtest_slvl2_pg_tbl:
        RVTEST_PTE_IDENT_MAP        
#endif

RVTEST_DATA_END
RVMODEL_DATA_BEGIN
rvtest_sig_begin:
sig_begin_canary:
CANARY;

// test signatures initialization
signature_x13_1:
    .fill 64*(XLEN/64),8,0xcafebeef

// trap signatures initialization
#ifdef rvtest_mtrap_routine
mtrap_sigptr:
    .fill 64*(XLEN/64),8,0xdeadbeef
#endif

sig_end_canary:
CANARY;
rvtest_sig_end:
RVMODEL_DATA_END
