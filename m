Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2C7FC72BE
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Mar 2026 12:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zy7Blgxy40soCOuXl92qgOwyt/XcIUx/5IMLBAJKnqc=; b=a+Pado30q6WYiktuPmM5JRqFPq
	v0cUNeQ1mOQGTtawmp67M8FE3AdycO5GQq+duUFjP5CrlyTiWcRO6XK3+GT34A9nVlJQzWtw3mMdy
	k8mxWbXL/358ApIgHC/syKrpit4n4DF5DdEAAtZyRQwcfdna6NRZ8+RiU42Rp/UTK9Z+2EnJyV99I
	PU/n2rYOIGCQrXPCDCGmzpEdNKxgPV64uE0C8Mqf/Qh3/OVcABWxtiZPZCEhGD5kBxqhWscjXNDQy
	ZGdsAZ7dRKYPS9NPttt400cP/9zfPtGQjQeznGy1g+AY/gTafLfhC0O7HBKr0yLscDgOXxHVDFgTt
	XWrfKdIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4HdW-0000000FIUq-2hlN;
	Sun, 22 Mar 2026 12:10:30 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4HdS-0000000FIUK-3G6N;
	Sun, 22 Mar 2026 12:10:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774181427; x=1805717427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FiSORyFIdIZ2F5fDS7mDHv41diJnTp+IxLV9U2/jyKE=;
  b=mGElnB9r8lpRkD9FB5yOqLLWhw/f49eFpA/laRTGu/f3uEc2vF2jvoTT
   eWcxugGjFRi2Qh/PgmDzCpR8gGpaGuC9hMiYjxmmdYIJfWRC4J1nuhFUm
   gN9o7K1A9tOjyrB6OV6w3y8kFoZSZwVVOFv+0ZverMAPJVU8FUi0RrUaR
   9fWzTNnZFPUhbcxz3t+9stGC4fC0v3r13NOqREadTLlKiZQ5qZjtMs2Up
   8ML46fClN1EATgZ+sICfUyFDNBgx4q2Sf8+OstnI3z1N7OYwQVGFdhw2k
   jZK40Yydmy8wByTfpsZGcbQ234UfxPqd/LT4gCNyimb7mEmQWMh8oRLhy
   w==;
X-CSE-ConnectionGUID: nExu72dfRp+AUIv7vKDYsw==
X-CSE-MsgGUID: 5/3MMxSWS6iKcgYORndZdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75085848"
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; 
   d="scan'208";a="75085848"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 05:10:24 -0700
X-CSE-ConnectionGUID: Haa6IgncQm6bgkG0/AV0AQ==
X-CSE-MsgGUID: OBrAZaQHQzWGFzgXUem91w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; 
   d="scan'208";a="222970651"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 22 Mar 2026 05:10:20 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4HdI-0000000026P-1Bti;
	Sun, 22 Mar 2026 12:10:16 +0000
Date: Sun, 22 Mar 2026 20:09:29 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, "sven@kernel.org" <sven@kernel.org>,
	"j@jannau.net" <j@jannau.net>, "neal@gompa.dev" <neal@gompa.dev>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"justin.tee@broadcom.com" <justin.tee@broadcom.com>,
	"nareshgottumukkala83@gmail.com" <nareshgottumukkala83@gmail.com>,
	"paul.ely@broadcom.com" <paul.ely@broadcom.com>,
	"kch@nvidia.com" <kch@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
Subject: Re: [PATCH] nvme: Move nvme_setup_cmd before hot_pathing
Message-ID: <202603222033.ACImXpPE-lkp@intel.com>
References: <20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260322_051026_906941_0E0B9164 
X-CRM114-Status: GOOD (  11.01  )
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

Hi 전민식,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe/for-next]
[also build test WARNING on linus/master v7.0-rc4 next-20260320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/nvme-Move-nvme_setup_cmd-before-hot_pathing/20260322-080947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6%40epcms2p4
patch subject: [PATCH] nvme: Move nvme_setup_cmd before hot_pathing
config: x86_64-rhel-9.4-kunit (https://download.01.org/0day-ci/archive/20260322/202603222033.ACImXpPE-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260322/202603222033.ACImXpPE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603222033.ACImXpPE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/host/rdma.c: In function 'nvme_rdma_queue_rq':
>> drivers/nvme/host/rdma.c:2067:1: warning: label 'unmap_qe' defined but not used [-Wunused-label]
    2067 | unmap_qe:
         | ^~~~~~~~


vim +/unmap_qe +2067 drivers/nvme/host/rdma.c

71102307196028 Christoph Hellwig 2016-07-06  1991  
fc17b6534eb839 Christoph Hellwig 2017-06-03  1992  static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
71102307196028 Christoph Hellwig 2016-07-06  1993  		const struct blk_mq_queue_data *bd)
71102307196028 Christoph Hellwig 2016-07-06  1994  {
71102307196028 Christoph Hellwig 2016-07-06  1995  	struct nvme_ns *ns = hctx->queue->queuedata;
71102307196028 Christoph Hellwig 2016-07-06  1996  	struct nvme_rdma_queue *queue = hctx->driver_data;
71102307196028 Christoph Hellwig 2016-07-06  1997  	struct request *rq = bd->rq;
71102307196028 Christoph Hellwig 2016-07-06  1998  	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
71102307196028 Christoph Hellwig 2016-07-06  1999  	struct nvme_rdma_qe *sqe = &req->sqe;
f4b9e6c90c5725 Keith Busch       2021-03-17  2000  	struct nvme_command *c = nvme_req(rq)->cmd;
71102307196028 Christoph Hellwig 2016-07-06  2001  	struct ib_device *dev;
3bc32bb1186cca Christoph Hellwig 2018-06-11  2002  	bool queue_ready = test_bit(NVME_RDMA_Q_LIVE, &queue->flags);
fc17b6534eb839 Christoph Hellwig 2017-06-03  2003  	blk_status_t ret;
fc17b6534eb839 Christoph Hellwig 2017-06-03  2004  	int err;
71102307196028 Christoph Hellwig 2016-07-06  2005  
71102307196028 Christoph Hellwig 2016-07-06  2006  	WARN_ON_ONCE(rq->tag < 0);
71102307196028 Christoph Hellwig 2016-07-06  2007  
ae1c609d185960 전민식            2026-03-20  2008  	ret = nvme_setup_cmd(ns, rq);
ae1c609d185960 전민식            2026-03-20  2009  	if (ret)
ae1c609d185960 전민식            2026-03-20  2010  		return ret;
ae1c609d185960 전민식            2026-03-20  2011  
a97157440e1e69 Andy Chiu         2021-04-26  2012  	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
a97157440e1e69 Andy Chiu         2021-04-26  2013  		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
553cd9ef82edd8 Christoph Hellwig 2016-11-02  2014  
71102307196028 Christoph Hellwig 2016-07-06  2015  	dev = queue->device->dev;
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2016  
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2017  	req->sqe.dma = ib_dma_map_single(dev, req->sqe.data,
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2018  					 sizeof(struct nvme_command),
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2019  					 DMA_TO_DEVICE);
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2020  	err = ib_dma_mapping_error(dev, req->sqe.dma);
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2021  	if (unlikely(err))
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2022  		return BLK_STS_RESOURCE;
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2023  
71102307196028 Christoph Hellwig 2016-07-06  2024  	ib_dma_sync_single_for_cpu(dev, sqe->dma,
71102307196028 Christoph Hellwig 2016-07-06  2025  			sizeof(struct nvme_command), DMA_TO_DEVICE);
71102307196028 Christoph Hellwig 2016-07-06  2026  
6887fc6495f2df Sagi Grimberg     2022-10-03  2027  	nvme_start_request(rq);
71102307196028 Christoph Hellwig 2016-07-06  2028  
5ec5d3bddc6b91 Max Gurtovoy      2020-05-19  2029  	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
5ec5d3bddc6b91 Max Gurtovoy      2020-05-19  2030  	    queue->pi_support &&
5ec5d3bddc6b91 Max Gurtovoy      2020-05-19  2031  	    (c->common.opcode == nvme_cmd_write ||
5ec5d3bddc6b91 Max Gurtovoy      2020-05-19  2032  	     c->common.opcode == nvme_cmd_read) &&
0372dd4e361717 Daniel Wagner     2023-12-18  2033  	    nvme_ns_has_pi(ns->head))
5ec5d3bddc6b91 Max Gurtovoy      2020-05-19  2034  		req->use_sig_mr = true;
5ec5d3bddc6b91 Max Gurtovoy      2020-05-19  2035  	else
5ec5d3bddc6b91 Max Gurtovoy      2020-05-19  2036  		req->use_sig_mr = false;
5ec5d3bddc6b91 Max Gurtovoy      2020-05-19  2037  
fc17b6534eb839 Christoph Hellwig 2017-06-03  2038  	err = nvme_rdma_map_data(queue, rq, c);
a7b7c7a105a528 Max Gurtovoy      2017-08-14  2039  	if (unlikely(err < 0)) {
71102307196028 Christoph Hellwig 2016-07-06  2040  		dev_err(queue->ctrl->ctrl.device,
fc17b6534eb839 Christoph Hellwig 2017-06-03  2041  			     "Failed to map data (%d)\n", err);
71102307196028 Christoph Hellwig 2016-07-06  2042  		goto err;
71102307196028 Christoph Hellwig 2016-07-06  2043  	}
71102307196028 Christoph Hellwig 2016-07-06  2044  
b4b591c87f2b0f Sagi Grimberg     2017-11-23  2045  	sqe->cqe.done = nvme_rdma_send_done;
b4b591c87f2b0f Sagi Grimberg     2017-11-23  2046  
71102307196028 Christoph Hellwig 2016-07-06  2047  	ib_dma_sync_single_for_device(dev, sqe->dma,
71102307196028 Christoph Hellwig 2016-07-06  2048  			sizeof(struct nvme_command), DMA_TO_DEVICE);
71102307196028 Christoph Hellwig 2016-07-06  2049  
fc17b6534eb839 Christoph Hellwig 2017-06-03  2050  	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
f41725bbe16b07 Israel Rukshin    2017-11-26  2051  			req->mr ? &req->reg_wr.wr : NULL);
16686f3a6c3cd6 Max Gurtovoy      2019-10-13  2052  	if (unlikely(err))
16686f3a6c3cd6 Max Gurtovoy      2019-10-13  2053  		goto err_unmap;
71102307196028 Christoph Hellwig 2016-07-06  2054  
fc17b6534eb839 Christoph Hellwig 2017-06-03  2055  	return BLK_STS_OK;
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2056  
16686f3a6c3cd6 Max Gurtovoy      2019-10-13  2057  err_unmap:
16686f3a6c3cd6 Max Gurtovoy      2019-10-13  2058  	nvme_rdma_unmap_data(queue, rq);
71102307196028 Christoph Hellwig 2016-07-06  2059  err:
62eca39722fd99 Chao Leng         2021-02-01  2060  	if (err == -EIO)
62eca39722fd99 Chao Leng         2021-02-01  2061  		ret = nvme_host_path_error(rq);
62eca39722fd99 Chao Leng         2021-02-01  2062  	else if (err == -ENOMEM || err == -EAGAIN)
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2063  		ret = BLK_STS_RESOURCE;
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2064  	else
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2065  		ret = BLK_STS_IOERR;
16686f3a6c3cd6 Max Gurtovoy      2019-10-13  2066  	nvme_cleanup_cmd(rq);
62f99b62e5e3b8 Max Gurtovoy      2019-06-06 @2067  unmap_qe:
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2068  	ib_dma_unmap_single(dev, req->sqe.dma, sizeof(struct nvme_command),
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2069  			    DMA_TO_DEVICE);
62f99b62e5e3b8 Max Gurtovoy      2019-06-06  2070  	return ret;
71102307196028 Christoph Hellwig 2016-07-06  2071  }
71102307196028 Christoph Hellwig 2016-07-06  2072  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

