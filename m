From: lkp@intel.com (kbuild test robot)
Date: Fri, 2 Jun 2017 08:14:59 +0800
Subject: [PATCH v2 3/8] nvmet: implement namespace identify descriptor list
In-Reply-To: <20170601111750.20880-4-jthumshirn@suse.de>
Message-ID: <201706020730.grqRkmRE%fengguang.wu@intel.com>

Hi Johannes,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.12-rc3 next-20170601]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Johannes-Thumshirn/nvme-introduce-NVMe-Namespace-Identification-Descriptor-structures/20170601-224249
config: x86_64-randconfig-s2-06020617 (attached as .config)
compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the linux-review/Johannes-Thumshirn/nvme-introduce-NVMe-Namespace-Identification-Descriptor-structures/20170601-224249 HEAD eed0e29a990ae9332379fbaf71b249bb482b3c6b builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/nvme//target/admin-cmd.c: In function 'nvmet_execute_identify_desclist':
>> drivers/nvme//target/admin-cmd.c:383: error: 'struct nvmet_ns' has no member named 'uuid'
>> drivers/nvme//target/admin-cmd.c:383: error: 'struct nvmet_ns' has no member named 'uuid'
   drivers/nvme//target/admin-cmd.c:392: error: 'struct nvmet_ns' has no member named 'uuid'
   drivers/nvme//target/admin-cmd.c:393: error: 'struct nvmet_ns' has no member named 'uuid'
   drivers/nvme//target/admin-cmd.c:396: error: 'struct nvmet_ns' has no member named 'uuid'

vim +383 drivers/nvme//target/admin-cmd.c

   377		ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
   378		if (!ns) {
   379			status = NVME_SC_INVALID_NS | NVME_SC_DNR;
   380			goto out;
   381		}
   382	
 > 383		if (memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
   384			memset(&hdr, 0, sizeof(hdr));
   385			hdr.nidt = NVME_NIDT_UUID;
   386			hdr.nidl = NVME_NIDT_UUID_LEN;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33087 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170602/b6c21977/attachment-0001.gz>
