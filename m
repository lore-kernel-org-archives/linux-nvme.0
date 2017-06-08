From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Jun 2017 23:11:29 +0800
Subject: [PATCH v6 10/10] nvme: use ctrl->device consistently for logging
In-Reply-To: <20170607095118.32557-1-jthumshirn@suse.de>
Message-ID: <201706082301.2ouDU4nL%fengguang.wu@intel.com>

Hi Johannes,

[auto build test ERROR on block/for-next]
[also build test ERROR on v4.12-rc4 next-20170608]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Johannes-Thumshirn/Implement-NVMe-Namespace-Descriptor-Identification/20170608-203614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-randconfig-x018-201723 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/nvme/host/fc.c: In function 'nvme_fc_connect_admin_queue':
>> drivers/nvme/host/fc.c:932:15: error: 'struct nvme_fc_ctrl' has no member named 'device'; did you mean 'dev'?
      dev_err(ctrl->device,
                  ^~
   drivers/nvme/host/fc.c:947:15: error: 'struct nvme_fc_ctrl' has no member named 'device'; did you mean 'dev'?
      dev_err(ctrl->device,
                  ^~
   drivers/nvme/host/fc.c: In function 'nvme_fc_connect_queue':
   drivers/nvme/host/fc.c:1031:15: error: 'struct nvme_fc_ctrl' has no member named 'device'; did you mean 'dev'?
      dev_err(ctrl->device,
                  ^~
   drivers/nvme/host/fc.c:1044:15: error: 'struct nvme_fc_ctrl' has no member named 'device'; did you mean 'dev'?
      dev_err(ctrl->device,
                  ^~
   drivers/nvme/host/fc.c: In function '__nvme_fc_init_request':
   drivers/nvme/host/fc.c:1412:15: error: 'struct nvme_fc_ctrl' has no member named 'device'; did you mean 'dev'?
      dev_err(ctrl->device,
                  ^~
   drivers/nvme/host/fc.c:1422:15: error: 'struct nvme_fc_ctrl' has no member named 'device'; did you mean 'dev'?
      dev_err(ctrl->device,
                  ^~

vim +932 drivers/nvme/host/fc.c

   926		else if (assoc_acc->connectid.desc_len !=
   927				fcnvme_lsdesc_len(sizeof(struct fcnvme_lsdesc_conn_id)))
   928			fcret = VERR_CONN_ID_LEN;
   929	
   930		if (fcret) {
   931			ret = -EBADF;
 > 932			dev_err(ctrl->device,
   933				"q %d connect failed: %s\n",
   934				queue->qnum, validation_errors[fcret]);
   935		} else {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26011 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170608/faf750ec/attachment-0001.gz>
