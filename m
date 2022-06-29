Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033A1C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uGbPvuZAX9L6u2c2TOBfL6P4ejxxPA7CbvTmYClAGV8=; b=oJfn5oMtKHJ/7L6XCKKTGOanhY
	Nh7l/xj8k4JXQzjE0XZfie+1kLrFN+F8qtPqQNQyZxTBxPBe+4PShb+rs5kIKIWXKc0U2SW92+B06
	fgAr5CdnDf/RjLLpA0TaMZJ1I/WzBs8uMBM0gln3sh4uASKX3gtLQiZRgBldxBGn6LndteI/ju07D
	S1ETKT9VBM4Cb6DTxREIGXULmfSP11XbUASLeEup3C2GaAMDWLd0Yqb2aL+F5QYRYytYBRcTMoFZi
	Yw+D3bZl84QNZUsRAyH40hYidGjUhsP9fRzCUT2DsmPHbiJ+ogpgEFAeUue86PGQ48GMjUyPkCHDi
	0/UEXKEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6blW-00DEoS-Cb; Wed, 29 Jun 2022 17:46:14 +0000
Received: from mga05.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6blS-00DEn2-Ru
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 17:46:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656524770; x=1688060770;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U9HK4ylooK7Tf08M3sTXhqwwWVQ3meqXzDez1Ryq2rc=;
  b=UV1REQm6pK6Jznt+obQRdpCoA+OHxpCZB7iUT6XRy+jfBhqw3EhYg4mn
   MlhZ7EnVIOzqX/UbulGfsSTefV2rzZlr2XXIEhlo8st4sozmLPUFOI7yH
   xpBbHG54KwKb2d9noaw9xzng2YnaTtHSFfgj9lETI0zuGdu6/Smky/lNU
   clu0CFl8ZFrlkN+Gp0UIsExCk/5kNkvqY20LTI1JpNMWpgY4pADUkP91G
   r15fifgVPp3WC+Y7Dux9U13Ndvg+RPiekT61e+tHfsQRg35s5s+238mu3
   DuLwBnhjdmEr0o6B4EIb7uBWhTEuCJa4WNUE5QZrGpg3/a3ho+dFmzziR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="368414789"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="368414789"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 10:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="595331945"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2022 10:46:06 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o6blN-000BNo-F0;
	Wed, 29 Jun 2022 17:46:05 +0000
Date: Thu, 30 Jun 2022 01:45:55 +0800
From: kernel test robot <lkp@intel.com>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [linux-nvme:nvme-5.19 5/5] drivers/nvme/target/core.c:1379:11:
 error: no member named 'clear_ids' in 'struct nvmet_subsys'
Message-ID: <202206300158.HnaC96OB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_104610_961162_1DD8F7A3 
X-CRM114-Status: GOOD (  12.27  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree:   git://git.infradead.org/nvme.git nvme-5.19
head:   74138c25fae3f1989bef321bfffa324b1cb19dbc
commit: 74138c25fae3f1989bef321bfffa324b1cb19dbc [5/5] nvmet: add a clear_ids attribute for passthru targets
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220630/202206300158.HnaC96OB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a774ba7f60d1fef403b5507b1b1a7475d3684d71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme nvme-5.19
        git checkout 74138c25fae3f1989bef321bfffa324b1cb19dbc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/nvme/target/core.c:1379:11: error: no member named 'clear_ids' in 'struct nvmet_subsys'
                   subsys->clear_ids = 1;
                   ~~~~~~  ^
   1 error generated.


vim +1379 drivers/nvme/target/core.c

  1337	
  1338	u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
  1339			struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp)
  1340	{
  1341		struct nvmet_subsys *subsys;
  1342		struct nvmet_ctrl *ctrl;
  1343		int ret;
  1344		u16 status;
  1345	
  1346		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
  1347		subsys = nvmet_find_get_subsys(req->port, subsysnqn);
  1348		if (!subsys) {
  1349			pr_warn("connect request for invalid subsystem %s!\n",
  1350				subsysnqn);
  1351			req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
  1352			req->error_loc = offsetof(struct nvme_common_command, dptr);
  1353			goto out;
  1354		}
  1355	
  1356		down_read(&nvmet_config_sem);
  1357		if (!nvmet_host_allowed(subsys, hostnqn)) {
  1358			pr_info("connect by host %s for subsystem %s not allowed\n",
  1359				hostnqn, subsysnqn);
  1360			req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
  1361			up_read(&nvmet_config_sem);
  1362			status = NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR;
  1363			req->error_loc = offsetof(struct nvme_common_command, dptr);
  1364			goto out_put_subsystem;
  1365		}
  1366		up_read(&nvmet_config_sem);
  1367	
  1368		status = NVME_SC_INTERNAL;
  1369		ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
  1370		if (!ctrl)
  1371			goto out_put_subsystem;
  1372		mutex_init(&ctrl->lock);
  1373	
  1374		ctrl->port = req->port;
  1375		ctrl->ops = req->ops;
  1376	
  1377		/* By default, set loop targets to clear IDS by default */
  1378		if (ctrl->port->disc_addr.trtype == NVMF_TRTYPE_LOOP)
> 1379			subsys->clear_ids = 1;
  1380	
  1381		INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
  1382		INIT_LIST_HEAD(&ctrl->async_events);
  1383		INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
  1384		INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
  1385		INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
  1386	
  1387		memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
  1388		memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
  1389	
  1390		kref_init(&ctrl->ref);
  1391		ctrl->subsys = subsys;
  1392		nvmet_init_cap(ctrl);
  1393		WRITE_ONCE(ctrl->aen_enabled, NVMET_AEN_CFG_OPTIONAL);
  1394	
  1395		ctrl->changed_ns_list = kmalloc_array(NVME_MAX_CHANGED_NAMESPACES,
  1396				sizeof(__le32), GFP_KERNEL);
  1397		if (!ctrl->changed_ns_list)
  1398			goto out_free_ctrl;
  1399	
  1400		ctrl->sqs = kcalloc(subsys->max_qid + 1,
  1401				sizeof(struct nvmet_sq *),
  1402				GFP_KERNEL);
  1403		if (!ctrl->sqs)
  1404			goto out_free_changed_ns_list;
  1405	
  1406		if (subsys->cntlid_min > subsys->cntlid_max)
  1407			goto out_free_sqs;
  1408	
  1409		ret = ida_alloc_range(&cntlid_ida,
  1410				     subsys->cntlid_min, subsys->cntlid_max,
  1411				     GFP_KERNEL);
  1412		if (ret < 0) {
  1413			status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
  1414			goto out_free_sqs;
  1415		}
  1416		ctrl->cntlid = ret;
  1417	
  1418		/*
  1419		 * Discovery controllers may use some arbitrary high value
  1420		 * in order to cleanup stale discovery sessions
  1421		 */
  1422		if (nvmet_is_disc_subsys(ctrl->subsys) && !kato)
  1423			kato = NVMET_DISC_KATO_MS;
  1424	
  1425		/* keep-alive timeout in seconds */
  1426		ctrl->kato = DIV_ROUND_UP(kato, 1000);
  1427	
  1428		ctrl->err_counter = 0;
  1429		spin_lock_init(&ctrl->error_lock);
  1430	
  1431		nvmet_start_keep_alive_timer(ctrl);
  1432	
  1433		mutex_lock(&subsys->lock);
  1434		list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
  1435		nvmet_setup_p2p_ns_map(ctrl, req);
  1436		mutex_unlock(&subsys->lock);
  1437	
  1438		*ctrlp = ctrl;
  1439		return 0;
  1440	
  1441	out_free_sqs:
  1442		kfree(ctrl->sqs);
  1443	out_free_changed_ns_list:
  1444		kfree(ctrl->changed_ns_list);
  1445	out_free_ctrl:
  1446		kfree(ctrl);
  1447	out_put_subsystem:
  1448		nvmet_subsys_put(subsys);
  1449	out:
  1450		return status;
  1451	}
  1452	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

