From: lkp@intel.com (kbuild test robot)
Date: Sat, 17 Oct 2015 01:15:36 +0800
Subject: [PATCH v11 5/5] nvme: LightNVM support
In-Reply-To: <1445001655-16370-6-git-send-email-m@bjorling.me>
Message-ID: <201510170104.xJh18mvo%fengguang.wu@intel.com>

Hi Matias,

[auto build test ERROR on block/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Matias-Bj-rling/Support-for-Open-Channel-SSDs/20151016-212550
config: x86_64-rhel (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> drivers/nvme/host/lightnvm.c:547:6: error: conflicting types for 'nvme_nvm_unregister'
    void nvme_nvm_unregister(char *disk_name) {};
         ^
   In file included from drivers/nvme/host/lightnvm.c:23:0:
   drivers/nvme/host/nvme.h:141:6: note: previous declaration of 'nvme_nvm_unregister' was here
    void nvme_nvm_unregister(struct request_queue *q, char *disk_name);
         ^

vim +/nvme_nvm_unregister +547 drivers/nvme/host/lightnvm.c

   541	}
   542	#else
   543	int nvme_nvm_register(struct request_queue *q, char *disk_name)
   544	{
   545		return 0;
   546	}
 > 547	void nvme_nvm_unregister(char *disk_name) {};
   548	int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *id)
   549	{
   550		return 0;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 35276 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20151017/ecdc9ab0/attachment-0001.obj>
