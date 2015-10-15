From: lkp@intel.com (kbuild test robot)
Date: Thu, 15 Oct 2015 10:46:16 +0800
Subject: [PATCH v9 5/5] nvme: LightNVM support
In-Reply-To: <1444833738-8961-6-git-send-email-m@bjorling.me>
Message-ID: <201510151007.f6nvy7gi%fengguang.wu@intel.com>

Hi Matias,

[auto build test WARNING on block/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Matias-Bj-rling/Support-for-Open-Channel-SSDs/20151014-224617
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/nvme/host/lightnvm.c:282:23: sparse: incorrect type in assignment (different base types)
   drivers/nvme/host/lightnvm.c:282:23:    expected restricted __le32 [assigned] [usertype] nsid
   drivers/nvme/host/lightnvm.c:282:23:    got unsigned int [unsigned] ns_id
>> drivers/nvme/host/lightnvm.c:291:19: sparse: cast to restricted __le64
   drivers/nvme/host/lightnvm.c:292:19: sparse: cast to restricted __le64
>> drivers/nvme/host/lightnvm.c:331:28: sparse: incorrect type in assignment (different base types)
   drivers/nvme/host/lightnvm.c:331:28:    expected restricted __le64 [assigned] [usertype] slba
   drivers/nvme/host/lightnvm.c:331:28:    got unsigned long long [unsigned] [usertype] cmd_slba
>> drivers/nvme/host/lightnvm.c:332:27: sparse: incorrect type in assignment (different base types)
   drivers/nvme/host/lightnvm.c:332:27:    expected restricted __le32 [assigned] [usertype] nlb
   drivers/nvme/host/lightnvm.c:332:27:    got unsigned long long [unsigned] [usertype] cmd_nlb

vim +282 drivers/nvme/host/lightnvm.c

   276		struct nvme_nvm_command c = {};
   277		int sz = sizeof(struct nvm_get_features);
   278		int ret;
   279		u64 *resp;
   280	
   281		c.common.opcode = nvme_nvm_admin_get_features;
 > 282		c.common.nsid = ns->ns_id;
   283		resp = kmalloc(sz, GFP_KERNEL);
   284		if (!resp)
   285			return -ENOMEM;
   286	
   287		ret = nvme_submit_sync_cmd(q, (struct nvme_command *)&c, resp, sz);
   288		if (ret)
   289			goto done;
   290	
 > 291		gf->rsp = le64_to_cpu(resp[0]);
   292		gf->ext = le64_to_cpu(resp[1]);
   293	
   294	done:
   295		kfree(resp);
   296		return ret;
   297	}
   298	
   299	static int nvme_nvm_set_resp(struct request_queue *q, u64 resp)
   300	{
   301		struct nvme_ns *ns = q->queuedata;
   302		struct nvme_nvm_command c = {};
   303	
   304		c.resp.opcode = nvme_nvm_admin_set_resp;
   305		c.resp.nsid = cpu_to_le32(ns->ns_id);
   306		c.resp.resp = cpu_to_le64(resp);
   307		return nvme_submit_sync_cmd(q, (struct nvme_command *)&c, NULL, 0);
   308	}
   309	
   310	static int nvme_nvm_get_l2p_tbl(struct request_queue *q, u64 slba, u64 nlb,
   311					nvm_l2p_update_fn *update_l2p, void *priv)
   312	{
   313		struct nvme_ns *ns = q->queuedata;
   314		struct nvme_dev *dev = ns->dev;
   315		struct nvme_nvm_command c = {};
   316		u32 len = queue_max_hw_sectors(q) << 9;
   317		u64 nlb_pr_rq = len / sizeof(u64);
   318		u64 cmd_slba = slba;
   319		void *entries;
   320		int ret = 0;
   321	
   322		c.l2p.opcode = nvme_nvm_admin_get_l2p_tbl;
   323		c.l2p.nsid = cpu_to_le32(ns->ns_id);
   324		entries = kmalloc(len, GFP_KERNEL);
   325		if (!entries)
   326			return -ENOMEM;
   327	
   328		while (nlb) {
   329			u64 cmd_nlb = min_t(u64, nlb_pr_rq, nlb);
   330	
 > 331			c.l2p.slba = cmd_slba;
 > 332			c.l2p.nlb = cmd_nlb;
   333	
   334			ret = nvme_submit_sync_cmd(q, (struct nvme_command *)&c,
   335									entries, len);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
