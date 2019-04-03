From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Wed, 3 Apr 2019 17:03:25 -0600
Subject: nvme cli format question
Message-ID: <754e9409-0255-220f-c4c2-18fe55dd4df3@intel.com>


What is the expected behavior when calling 'format' on a NVMe character
device? I see two problems with the code below.

1) If no namespace Id is specified and the device is not a block device,
then nvme_identify_ns() is never called and the 'ns' variable used in
the 'if (cfg.bs)' case is  uninitialized.

2) If the namespace_id is specified or determined from the block device,
then the 'cfg.bs' check is redundant (and done twice).

         if (cfg.namespace_id != NVME_NSID_ALL) {
                 err = nvme_identify_ns(fd, cfg.namespace_id, 0, &ns);
                 if (err) {
                         if (err < 0)
                                 perror("identify-namespace");
                         else
                                 fprintf(stderr,
                                         "NVME Admin command 
error:%s(%x)\n",
                                         nvme_status_to_string(err), err);
                         return err;
                 }
                 prev_lbaf = ns.flbas & 0xf;

                 if (cfg.bs) {
                         for (i = 0; i < 16; ++i) {
                                 if ((1ULL << ns.lbaf[i].ds) == cfg.bs &&
                                     ns.lbaf[i].ms == 0) {
                                         cfg.lbaf = i;
                                         break;
                                 }
                         }
                         if (cfg.lbaf == 0xff) {
                                 fprintf(stderr,
                                         "LBAF corresponding to block 
size %"PRIu64"(LBAF %u) not found\n",
                                         (uint64_t)cfg.bs, lbads);
                                 fprintf(stderr,
                                         "Please correct block size, or 
specify LBAF directly\n");
                                 return EINVAL;
                         }
                 }
         }
         if (cfg.bs) {
                 __u64 bs = cfg.bs;
                 bs = bs >> 1;
                 while (bs) {
                         ++lbads;
                         bs = bs >> 1;
                 }
                 for (i=0; i<16; ++i) {
                         if (ns.lbaf[i].ds == lbads && ns.lbaf[i].ms == 0) {
                                 cfg.lbaf = i;
                                 break;
                         }
                 }
                         if (cfg.lbaf == 0xff) {
                                 fprintf(stderr,
                                         "LBAF corresponding to block 
size %"PRIu64" (LBAF %u) not found\n",
                                         (uint64_t)cfg.bs, lbads);
                                 fprintf(stderr,
                                         "Please correct block size, or 
specify LBAF directly\n");
                                 return EINVAL;
                         }
         }
