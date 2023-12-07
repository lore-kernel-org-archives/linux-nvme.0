Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A987C4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 05:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=pKKdA0pKK+DStB7nNq/u7uQgrp7qgpRk20DuhU/uuFw=; b=0O3u8cg4tlT51n
	OO5N+hnt6kArZJSRP4Y9wJp9Hb1HjuwKkxYNTqr8/RyT7cQmIOUKdbgfxEGA4Cgt6P9qne6y/QmoE
	T20YL+lSZUO5WNXYgeApj90b5mI0mgQeJu9CkosUJyO3i0A45nuhY4+hUWXW/6/6MEWEpg53GyUEU
	0khcqbuQC6ZloAHFL9VmlLE55HrtFQhWvCie79gOWDcVa3I2azY8wj/SfgJHTeeOHTAz5EXWUOKAU
	cosmcJXVW6D0RI7Bj5hl25+8Q3LxRIh6w3uu/UGA8OgJHy7jeO/F7riY4szpD4//ApyydrMfnDUmH
	gq0bfVrBqEx8WSg+L/1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rB73v-00BuiB-22;
	Thu, 07 Dec 2023 05:36:39 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rB73r-00Buh4-2y
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 05:36:37 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c032962c5so6768745e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 06 Dec 2023 21:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701927393; x=1702532193; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKKdA0pKK+DStB7nNq/u7uQgrp7qgpRk20DuhU/uuFw=;
        b=DMiFv8jxdUZLrHFkqBUH3/q/G8ejs40d/PZKKatvygW9byVtJQJ6c8llvXMMKXvsi6
         cJsJte4RBOUag9eD69kQ+qUrXbjFpsw/50bXsZ2Bkbt34VQKzYOKyELLva9DS9rmjNSs
         wsU/ubzbU3TyKqegYT7/eZquiOLNr9eVeJQsfImO8kKAGYyXrG9SmSr16ivig3AXcxEq
         WnHUpKYg+CQowwm5ktjb7We8hUX3rXmXG3GchkR0Aif+rrZFqFiuDdi/8a2DLzkMNCks
         4EyhFxvHSUdwHMQ75580pOPXTiMdE3ygNHHiYlslHVB/54pd6jYO6QZGHebMG+M3vd/5
         HMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701927393; x=1702532193;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKKdA0pKK+DStB7nNq/u7uQgrp7qgpRk20DuhU/uuFw=;
        b=nlInS/MS6DE8ed8QWQEjhRVQQcLgDCIaqVFaPG14mgETH0m1oGfAxlwUAaFldMYgCN
         ImGfozrqipmX9FPfyQJ3OhNuct6flwHJ5pa30Xo0/tZ1Dk0wWAKNNDNEAJlF4hqwYcfV
         7Im83DwRZk3SIrbcOhar/+kLzAzCuxskmokaxo/zEGPS2AJaEybnVn5ZRYU2X+AD0S2e
         uO2vRF+60H/qKHlvPI3p7fNZnFpVHwm5U3DsidEyCtQGHXEMLaKvDNC0Q85kHLyHY3EL
         0sLQJk7l/hHzbAQJWS8oV9o8dNFTzrvEPUK9/Z6RqU8vAa/4S9hJFjo3lJh9UY5Ss6bm
         50EQ==
X-Gm-Message-State: AOJu0YyVmcgnO2Tf8Oe8TggPjdoDZtHFH6fdaSPaCTU03IRJn+Mw3CLJ
	kw8YtTnT2u8TkIDiHUUoxoNtZA==
X-Google-Smtp-Source: AGHT+IFi4HIRN2UiPOlet45ZbrWakGrgFmno6Br4elP7b/KXXWCQQutIbrMJ218FpN9charPtkQYMQ==
X-Received: by 2002:a05:600c:458d:b0:40a:45ff:fd69 with SMTP id r13-20020a05600c458d00b0040a45fffd69mr856572wmo.19.1701927393055;
        Wed, 06 Dec 2023 21:36:33 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c458800b0040b3867a297sm617806wmo.36.2023.12.06.21.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 21:36:32 -0800 (PST)
Date: Thu, 7 Dec 2023 08:36:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v3 3/4] nvme: move ns id info to struct nvme_ns_head
Message-ID: <9877974d-3943-42e6-b89b-cd2704cdf20d@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206081244.32733-4-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_213635_964255_DE2FBDA3 
X-CRM114-Status: GOOD (  11.02  )
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

Hi Daniel,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvme-lookup-ctrl-from-request-instead-from-namespace/20231206-161455
base:   v6.7-rc4
patch link:    https://lore.kernel.org/r/20231206081244.32733-4-dwagner%40suse.de
patch subject: [PATCH v3 3/4] nvme: move ns id info to struct nvme_ns_head
config: i386-randconfig-141-20231207 (https://download.01.org/0day-ci/archive/20231207/202312071105.jkXzp8v9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231207/202312071105.jkXzp8v9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312071105.jkXzp8v9-lkp@intel.com/

smatch warnings:
drivers/nvme/target/passthru.c:354 nvmet_passthru_execute_cmd() warn: variable dereferenced before check 'ns' (see line 342)

vim +/ns +354 drivers/nvme/target/passthru.c

c1fef73f793b7f Logan Gunthorpe    2020-07-24  292  static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
c1fef73f793b7f Logan Gunthorpe    2020-07-24  293  {
ab7a2737ac5acd Christoph Hellwig  2021-08-27  294  	struct nvme_ctrl *ctrl = nvmet_req_subsys(req)->passthru_ctrl;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  295  	struct request_queue *q = ctrl->admin_q;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  296  	struct nvme_ns *ns = NULL;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  297  	struct request *rq = NULL;
47e9730c26a4a5 Chaitanya Kulkarni 2020-11-09  298  	unsigned int timeout;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  299  	u32 effects;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  300  	u16 status;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  301  	int ret;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  302  
c1fef73f793b7f Logan Gunthorpe    2020-07-24  303  	if (likely(req->sq->qid != 0)) {
c1fef73f793b7f Logan Gunthorpe    2020-07-24  304  		u32 nsid = le32_to_cpu(req->cmd->common.nsid);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  305  
c1fef73f793b7f Logan Gunthorpe    2020-07-24  306  		ns = nvme_find_get_ns(ctrl, nsid);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  307  		if (unlikely(!ns)) {
c1fef73f793b7f Logan Gunthorpe    2020-07-24  308  			pr_err("failed to get passthru ns nsid:%u\n", nsid);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  309  			status = NVME_SC_INVALID_NS | NVME_SC_DNR;
4db69a3d7cfe31 Chaitanya Kulkarni 2020-08-06  310  			goto out;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  311  		}
c1fef73f793b7f Logan Gunthorpe    2020-07-24  312  
c1fef73f793b7f Logan Gunthorpe    2020-07-24  313  		q = ns->queue;
20c2c3bb83f26c Chaitanya Kulkarni 2021-02-09  314  		timeout = nvmet_req_subsys(req)->io_timeout;
a2f6a2b8ce43db Chaitanya Kulkarni 2020-11-09  315  	} else {
20c2c3bb83f26c Chaitanya Kulkarni 2021-02-09  316  		timeout = nvmet_req_subsys(req)->admin_timeout;

ns is NULL here

c1fef73f793b7f Logan Gunthorpe    2020-07-24  317  	}
c1fef73f793b7f Logan Gunthorpe    2020-07-24  318  
e559398f47e090 Christoph Hellwig  2022-03-15  319  	rq = blk_mq_alloc_request(q, nvme_req_op(req->cmd), 0);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  320  	if (IS_ERR(rq)) {
c1fef73f793b7f Logan Gunthorpe    2020-07-24  321  		status = NVME_SC_INTERNAL;
4db69a3d7cfe31 Chaitanya Kulkarni 2020-08-06  322  		goto out_put_ns;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  323  	}
e559398f47e090 Christoph Hellwig  2022-03-15  324  	nvme_init_request(rq, req->cmd);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  325  
a2f6a2b8ce43db Chaitanya Kulkarni 2020-11-09  326  	if (timeout)
a2f6a2b8ce43db Chaitanya Kulkarni 2020-11-09  327  		rq->timeout = timeout;
a2f6a2b8ce43db Chaitanya Kulkarni 2020-11-09  328  
c1fef73f793b7f Logan Gunthorpe    2020-07-24  329  	if (req->sg_cnt) {
c1fef73f793b7f Logan Gunthorpe    2020-07-24  330  		ret = nvmet_passthru_map_sg(req, rq);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  331  		if (unlikely(ret)) {
c1fef73f793b7f Logan Gunthorpe    2020-07-24  332  			status = NVME_SC_INTERNAL;
a2138fd49467d0 Chaitanya Kulkarni 2020-08-06  333  			goto out_put_req;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  334  		}
c1fef73f793b7f Logan Gunthorpe    2020-07-24  335  	}
c1fef73f793b7f Logan Gunthorpe    2020-07-24  336  
c1fef73f793b7f Logan Gunthorpe    2020-07-24  337  	/*
2a459f6933e1c4 Christoph Hellwig  2022-12-21  338  	 * If a command needs post-execution fixups, or there are any
2a459f6933e1c4 Christoph Hellwig  2022-12-21  339  	 * non-trivial effects, make sure to execute the command synchronously
2a459f6933e1c4 Christoph Hellwig  2022-12-21  340  	 * in a workqueue so that nvme_passthru_end gets called.
c1fef73f793b7f Logan Gunthorpe    2020-07-24  341  	 */
a754bb00c0d393 Daniel Wagner      2023-12-06 @342  	effects = nvme_command_effects(ctrl, ns->head, req->cmd->common.opcode);
                                                                                             ^^^^^^^^
Unchecked dereference

2a459f6933e1c4 Christoph Hellwig  2022-12-21  343  	if (req->p.use_workqueue ||
2a459f6933e1c4 Christoph Hellwig  2022-12-21  344  	    (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))) {
c1fef73f793b7f Logan Gunthorpe    2020-07-24  345  		INIT_WORK(&req->p.work, nvmet_passthru_execute_cmd_work);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  346  		req->p.rq = rq;
8832cf922151e9 Sagi Grimberg      2022-03-21  347  		queue_work(nvmet_wq, &req->p.work);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  348  	} else {
e2e530867245d0 Christoph Hellwig  2022-05-24  349  		rq->end_io = nvmet_passthru_req_done;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  350  		rq->end_io_data = req;
e2e530867245d0 Christoph Hellwig  2022-05-24  351  		blk_execute_rq_nowait(rq, false);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  352  	}
c1fef73f793b7f Logan Gunthorpe    2020-07-24  353  
c1fef73f793b7f Logan Gunthorpe    2020-07-24 @354  	if (ns)

The rest of the code checks

c1fef73f793b7f Logan Gunthorpe    2020-07-24  355  		nvme_put_ns(ns);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  356  
c1fef73f793b7f Logan Gunthorpe    2020-07-24  357  	return;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  358  
a2138fd49467d0 Chaitanya Kulkarni 2020-08-06  359  out_put_req:
7ee51cf60a90c2 Chaitanya Kulkarni 2020-08-06  360  	blk_mq_free_request(rq);
4db69a3d7cfe31 Chaitanya Kulkarni 2020-08-06  361  out_put_ns:
c1fef73f793b7f Logan Gunthorpe    2020-07-24  362  	if (ns)
c1fef73f793b7f Logan Gunthorpe    2020-07-24  363  		nvme_put_ns(ns);
4db69a3d7cfe31 Chaitanya Kulkarni 2020-08-06  364  out:
c1fef73f793b7f Logan Gunthorpe    2020-07-24  365  	nvmet_req_complete(req, status);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  366  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


