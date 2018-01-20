From: lkp@intel.com (kbuild test robot)
Date: Sun, 21 Jan 2018 01:57:14 +0800
Subject: [PATCH 4/6] mpt3sas: Introduce Base function for cloning.
In-Reply-To: <1516365462-14708-5-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1516365462-14708-5-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <201801210158.dDNewOts%fengguang.wu@intel.com>

Hi Suganath,

I love your patch! Perhaps something to improve:

[auto build test WARNING on scsi/for-next]
[also build test WARNING on v4.15-rc8 next-20180119]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Suganath-Prabu-S/mpt3sas-Add-PCI-device-ID-for-Andromeda/20180121-002454
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: i386-randconfig-i1-201802 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_get_chain_phys':
   drivers/scsi/mpt3sas/mpt3sas_base.c:188:21: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     base_chain_phys  = (void *)ioc->chip_phys + MPI_FRAME_START_OFFSET +
                        ^
   drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_clone_sg_entries':
   drivers/scsi/mpt3sas/mpt3sas_base.c:315:10: error: implicit declaration of function 'mpt3sas_scsih_scsi_lookup_get'; did you mean 'mpt3sas_scsih_issue_locked_tm'? [-Werror=implicit-function-declaration]
      scmd = mpt3sas_scsih_scsi_lookup_get(ioc, smid);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
             mpt3sas_scsih_issue_locked_tm
   drivers/scsi/mpt3sas/mpt3sas_base.c:315:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      scmd = mpt3sas_scsih_scsi_lookup_get(ioc, smid);
           ^
>> drivers/scsi/mpt3sas/mpt3sas_base.c:378:20: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
       sgel->Address = (dma_addr_t)dst_addr_phys;
                       ^
   drivers/scsi/mpt3sas/mpt3sas_base.c:389:7: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
          (dma_addr_t)buff_ptr_phys;
          ^
   drivers/scsi/mpt3sas/mpt3sas_base.c:395:10: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
             (dma_addr_t)buff_ptr_phys;
             ^
   At top level:
   drivers/scsi/mpt3sas/mpt3sas_base.c:278:13: warning: '_clone_sg_entries' defined but not used [-Wunused-function]
    static void _clone_sg_entries(struct MPT3SAS_ADAPTER *ioc,
                ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +378 drivers/scsi/mpt3sas/mpt3sas_base.c

   265	
   266	/**
   267	 * _clone_sg_entries -	MPI EP's scsiio and config requests
   268	 *			are handled here. Base function for
   269	 *			double buffering, before submitting
   270	 *			the requests.
   271	 *
   272	 * @ioc: per adapter object.
   273	 * @mpi_request: mf request pointer.
   274	 * @smid: system request message index.
   275	 *
   276	 * @Returns: Nothing.
   277	 */
   278	static void _clone_sg_entries(struct MPT3SAS_ADAPTER *ioc,
   279			void *mpi_request, u16 smid)
   280	{
   281		Mpi2SGESimple32_t *sgel, *sgel_next;
   282		u32  sgl_flags, sge_chain_count = 0;
   283		bool is_write = 0;
   284		u16 i = 0;
   285		void  *buffer_iomem, *buffer_iomem_phys;
   286		void *buff_ptr, *buff_ptr_phys;
   287		void *dst_chain_addr[MCPU_MAX_CHAINS_PER_IO];
   288		void *src_chain_addr[MCPU_MAX_CHAINS_PER_IO], *dst_addr_phys;
   289		MPI2RequestHeader_t *request_hdr;
   290		struct scsi_cmnd *scmd;
   291		struct scatterlist *sg_scmd = NULL;
   292		int is_scsiio_req = 0;
   293	
   294		request_hdr = (MPI2RequestHeader_t *) mpi_request;
   295	
   296		if (request_hdr->Function == MPI2_FUNCTION_SCSI_IO_REQUEST) {
   297			Mpi25SCSIIORequest_t *scsiio_request =
   298				(Mpi25SCSIIORequest_t *)mpi_request;
   299			sgel = (Mpi2SGESimple32_t *) &scsiio_request->SGL;
   300			is_scsiio_req = 1;
   301		} else if (request_hdr->Function == MPI2_FUNCTION_CONFIG) {
   302			Mpi2ConfigRequest_t  *config_req =
   303				(Mpi2ConfigRequest_t *)mpi_request;
   304			sgel = (Mpi2SGESimple32_t *) &config_req->PageBufferSGE;
   305		} else
   306			return;
   307	
   308		/* From smid we can get scsi_cmd, once we have sg_scmd,
   309		 * we just need to get sg_virt and sg_next to get virual
   310		 * address associated with sgel->Address.
   311		 */
   312	
   313		if (is_scsiio_req) {
   314			/* Get scsi_cmd using smid */
 > 315			scmd = mpt3sas_scsih_scsi_lookup_get(ioc, smid);
   316			if (scmd == NULL) {
   317				pr_err(MPT3SAS_FMT "scmd is NULL\n", ioc->name);
   318				return;
   319			}
   320	
   321			/* Get sg_scmd from scmd provided */
   322			sg_scmd = scsi_sglist(scmd);
   323		}
   324	
   325		/*
   326		 * 0 - 255	System register
   327		 * 256 - 4352	MPI Frame. (This is based on maxCredit 32)
   328		 * 4352 - 4864	Reply_free pool (512 byte is reserved
   329		 *		considering maxCredit 32. Reply need extra
   330		 *		room, for mCPU case kept four times of
   331		 *		maxCredit).
   332		 * 4864 - 17152	SGE chain element. (32cmd * 3 chain of
   333		 *		128 byte size = 12288)
   334		 * 17152 - x	Host buffer mapped with smid.
   335		 *		(Each smid can have 64K Max IO.)
   336		 * BAR0+Last 1K MSIX Addr and Data
   337		 * Total size in use 2113664 bytes of 4MB BAR0
   338		 */
   339	
   340		buffer_iomem = _base_get_buffer_bar0(ioc, smid);
   341		buffer_iomem_phys = _base_get_buffer_phys_bar0(ioc, smid);
   342	
   343		buff_ptr = buffer_iomem;
   344		buff_ptr_phys = buffer_iomem_phys;
   345	
   346		if (sgel->FlagsLength &
   347				(MPI2_SGE_FLAGS_HOST_TO_IOC << MPI2_SGE_FLAGS_SHIFT))
   348			is_write = 1;
   349	
   350		for (i = 0; i < MPT_MIN_PHYS_SEGMENTS + ioc->facts.MaxChainDepth; i++) {
   351	
   352			sgl_flags = (sgel->FlagsLength >> MPI2_SGE_FLAGS_SHIFT);
   353	
   354			switch (sgl_flags & MPI2_SGE_FLAGS_ELEMENT_MASK) {
   355			case MPI2_SGE_FLAGS_CHAIN_ELEMENT:
   356				/*
   357				 * Helper function which on passing
   358				 * chain_buffer_dma returns chain_buffer. Get
   359				 * the virtual address for sgel->Address
   360				 */
   361				sgel_next =
   362					_base_get_chain_buffer_dma_to_chain_buffer(ioc,
   363							sgel->Address);
   364				if (sgel_next == NULL)
   365					return;
   366				/*
   367				 * This is coping 128 byte chain
   368				 * frame (not a host buffer)
   369				 */
   370				dst_chain_addr[sge_chain_count] =
   371					_base_get_chain(ioc,
   372						smid, sge_chain_count);
   373				src_chain_addr[sge_chain_count] =
   374							(void *) sgel_next;
   375				dst_addr_phys =
   376					_base_get_chain_phys(ioc,
   377							smid, sge_chain_count);
 > 378				sgel->Address = (dma_addr_t)dst_addr_phys;
   379				sgel = sgel_next;
   380				sge_chain_count++;
   381				break;
   382			case MPI2_SGE_FLAGS_SIMPLE_ELEMENT:
   383				if (is_write) {
   384					if (is_scsiio_req) {
   385						_base_clone_to_sys_mem(buff_ptr,
   386						    sg_virt(sg_scmd),
   387						    (sgel->FlagsLength & 0x00ffffff));
   388						sgel->Address =
   389							(dma_addr_t)buff_ptr_phys;
   390					} else {
   391						_base_clone_to_sys_mem(buff_ptr,
   392						    ioc->config_vaddr,
   393						    (sgel->FlagsLength & 0x00ffffff));
   394						sgel->Address =
   395						    (dma_addr_t)buff_ptr_phys;
   396					}
   397				}
   398				buff_ptr += (sgel->FlagsLength & 0x00ffffff);
   399				buff_ptr_phys += (sgel->FlagsLength & 0x00ffffff);
   400				if ((sgel->FlagsLength &
   401				    (MPI2_SGE_FLAGS_END_OF_BUFFER
   402						<< MPI2_SGE_FLAGS_SHIFT)))
   403					goto eob_clone_chain;
   404				else {
   405					/*
   406					 * Every single element in MPT will have
   407					 * associated sg_next. Better to sanity that
   408					 * sg_next is not NULL, but it will be a bug
   409					 * if it is null.
   410					 */
   411					if (is_scsiio_req) {
   412						sg_scmd = sg_next(sg_scmd);
   413						if (sg_scmd)
   414							sgel++;
   415						else
   416							goto eob_clone_chain;
   417					}
   418				}
   419				break;
   420			}
   421		}
   422	
   423	eob_clone_chain:
   424		for (i = 0; i < sge_chain_count; i++) {
   425			if (is_scsiio_req)
   426				_base_clone_to_sys_mem(dst_chain_addr[i],
   427					src_chain_addr[i], ioc->request_sz);
   428		}
   429	}
   430	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29458 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180121/fc96af54/attachment-0001.gz>
