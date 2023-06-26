Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297E2EB64D7
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jun 2023 11:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=G7sIG9mMWqnBSjmRGaB+tfEB5pMmkNJkQTNkwiFZC9I=; b=jigiSOpoykgHFW
	7ltUF9T2snGO8O1jCLksA9rZ+CdGyNX9epJZcspJ8uWt5I+Er2G9Ej7fYxCxHokhCmKpzegHxchBP
	tJHr0O0VCzzQx/tda3m/EWIM+cR3jxEk0hV5WYlAnGSu9zipXEc5mShne/Q61QlGqUjupPLvcaA9U
	qVhMbkyyYTSCsIQhnhCtW5Cqg5rBzk2Vwj+X6yAi9Xigkg0rYOfotj70bqOxwQDHoI/SpjB3Dyjr2
	62B4/vohp5TP+YRFsKoFWQnrTUp+V3/gH4FZ1bJc+1QpSnTtbLfUOmIhyRumRG2Iyabm3mAUs7Uha
	oPzBH2XhVVvo/T5vBn4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDjx4-00A0nm-2G;
	Mon, 26 Jun 2023 11:00:10 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDjx1-00A0mH-31
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jun 2023 11:00:09 +0000
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f96d680399so3955951e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 26 Jun 2023 04:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687777202; x=1690369202;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G7sIG9mMWqnBSjmRGaB+tfEB5pMmkNJkQTNkwiFZC9I=;
        b=kOuezhJK6qeL7RdVK0EOMNMSwUCf02bEbVt9y7n+j9VvQxFcy4KlmXddXqoSEo9xXw
         Twj3oux1PDEvBM9/2TCSWUNNfx+Jh3sOhVwLSOMelasvm7JK/49oqOzkPnxvgR6rShTs
         fhqd/Xktl6up0HT/IZGAldUumnle4bP0IQQuCNi8ALDLsig7t5ycgbte5L4+CtorhH7T
         p5bEZMCRp91/Z9tD64QgcB61hKm42eeH0XdgZqedFbQpPzpzhZlkhSVtrnm8tHQzHOml
         eHqGP7Pt/3v8HP739ro4zjbQcottNhuEZWYU5Mi47yOjxN/p8n0bxh1Ks//kGturNmfr
         Ib2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687777202; x=1690369202;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7sIG9mMWqnBSjmRGaB+tfEB5pMmkNJkQTNkwiFZC9I=;
        b=e6kVGHssolapp80K1f/HnHpOxZCCPeRJYVYtxsb8/i/ACLsnKup9o7G3gFAt4fsIjv
         h2L/zRaWNx4KBaJhiBnMvgdK84MgKjFrZuYxXhovn80dh8JdBQQ22mhkZlYdL8U6iBaf
         v/gZboAIZBIf88U4/LS+UhNaxpLOxuSFW8TnAJapViViFZ0nx6GpGdBE8MnmeFmUcZWB
         wAexpRUhZHoflllOGnV4ypgTxeIjqJYnx01Uhi6AzKjyApCXZWSIJ1oWAzQ+xUwmZOiW
         ZW3eCH3okGVLdw2zC3FH4BVM4veQeySI4VSVHqwWfMdUbflQAX8zkgJBggPbJFeaW+5b
         wLHw==
X-Gm-Message-State: AC+VfDyLpTnbUhDOlOS+GD+ylFq0R4HxNdxva1/YhHTKwiNpiKFQ+JhL
	89Ya6g6+LZbQdLLQ+vcNhoQzGQ==
X-Google-Smtp-Source: ACHHUZ4zYjhSY+qg0esWzswppt9V4YWWBAzQx43K/Cea8Dvc33slbb6+aW2ukojrhy6ftK1bsVxRaA==
X-Received: by 2002:a19:8c18:0:b0:4f4:fdb4:c76d with SMTP id o24-20020a198c18000000b004f4fdb4c76dmr18353746lfd.47.1687777202458;
        Mon, 26 Jun 2023 04:00:02 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t12-20020a7bc3cc000000b003f604793989sm10065546wmj.18.2023.06.26.04.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 04:00:01 -0700 (PDT)
Date: Mon, 26 Jun 2023 13:59:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Message-ID: <7ba59f01-57fe-4ad2-917a-0a199528b1f6@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620133711.22840-5-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_040008_002322_7E7AB539 
X-CRM114-Status: GOOD (  10.86  )
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

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvme-fc-Do-not-wait-in-vain-when-unloading-module/20230620-213849
base:   linus/master
patch link:    https://lore.kernel.org/r/20230620133711.22840-5-dwagner%40suse.de
patch subject: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
config: openrisc-randconfig-m041-20230622 (https://download.01.org/0day-ci/archive/20230624/202306240125.U2jdrjAY-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230624/202306240125.U2jdrjAY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202306240125.U2jdrjAY-lkp@intel.com/

smatch warnings:
drivers/nvme/host/fc.c:3590 nvme_fc_init_ctrl() warn: passing zero to 'ERR_PTR'

vim +/ERR_PTR +3590 drivers/nvme/host/fc.c

61bff8ef008845 James Smart       2017-04-23  3533  	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_fc_ctrl_ops, 0);
61bff8ef008845 James Smart       2017-04-23  3534  	if (ret)
98e3528012cd57 Ross Lagerwall    2023-01-20  3535  		goto out_free_queues;
e399441de9115c James Smart       2016-12-02  3536  
61bff8ef008845 James Smart       2017-04-23  3537  	/* at this point, teardown path changes to ref counting on nvme ctrl */
e399441de9115c James Smart       2016-12-02  3538  
98e3528012cd57 Ross Lagerwall    2023-01-20  3539  	ret = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
98e3528012cd57 Ross Lagerwall    2023-01-20  3540  			&nvme_fc_admin_mq_ops,
98e3528012cd57 Ross Lagerwall    2023-01-20  3541  			struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
98e3528012cd57 Ross Lagerwall    2023-01-20  3542  				    ctrl->lport->ops->fcprqst_priv_sz));
98e3528012cd57 Ross Lagerwall    2023-01-20  3543  	if (ret)
98e3528012cd57 Ross Lagerwall    2023-01-20  3544  		goto fail_ctrl;
98e3528012cd57 Ross Lagerwall    2023-01-20  3545  
e399441de9115c James Smart       2016-12-02  3546  	spin_lock_irqsave(&rport->lock, flags);
e399441de9115c James Smart       2016-12-02  3547  	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
e399441de9115c James Smart       2016-12-02  3548  	spin_unlock_irqrestore(&rport->lock, flags);
e399441de9115c James Smart       2016-12-02  3549  
ac881fd1288ca6 Daniel Wagner     2023-06-20  3550  	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
4c984154efa131 James Smart       2018-06-13  3551  		dev_err(ctrl->ctrl.device,
4c984154efa131 James Smart       2018-06-13  3552  			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
4c984154efa131 James Smart       2018-06-13  3553  		goto fail_ctrl;

No error code on this path.  Originally it didn't matter because it was
hardcoded to return ERR_PTR(-EIO);

17c4dc6eb7e1b2 James Smart       2017-10-09  3554  	}
17c4dc6eb7e1b2 James Smart       2017-10-09  3555  
ac881fd1288ca6 Daniel Wagner     2023-06-20  3556  	ret = nvme_fc_create_association(ctrl);
ac881fd1288ca6 Daniel Wagner     2023-06-20  3557  	if (ret)
4c984154efa131 James Smart       2018-06-13  3558  		goto fail_ctrl;
4c984154efa131 James Smart       2018-06-13  3559  
4c984154efa131 James Smart       2018-06-13  3560  	dev_info(ctrl->ctrl.device,
4c984154efa131 James Smart       2018-06-13  3561  		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
e5ea42faa773c6 Hannes Reinecke   2021-09-22  3562  		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl));
4c984154efa131 James Smart       2018-06-13  3563  
4c984154efa131 James Smart       2018-06-13  3564  	return &ctrl->ctrl;
4c984154efa131 James Smart       2018-06-13  3565  
4c984154efa131 James Smart       2018-06-13  3566  fail_ctrl:
19fce0470f0503 James Smart       2020-12-01  3567  	cancel_work_sync(&ctrl->ioerr_work);
cf25809bec2c7d James Smart       2018-03-13  3568  	cancel_work_sync(&ctrl->ctrl.reset_work);
cf25809bec2c7d James Smart       2018-03-13  3569  	cancel_delayed_work_sync(&ctrl->connect_work);
cf25809bec2c7d James Smart       2018-03-13  3570  
de41447aac034c Ewan D. Milne     2017-04-24  3571  	ctrl->ctrl.opts = NULL;
17c4dc6eb7e1b2 James Smart       2017-10-09  3572  
61bff8ef008845 James Smart       2017-04-23  3573  	/* initiate nvme ctrl ref counting teardown */
e399441de9115c James Smart       2016-12-02  3574  	nvme_uninit_ctrl(&ctrl->ctrl);
61bff8ef008845 James Smart       2017-04-23  3575  
0b5a7669a457dd James Smart       2017-06-15  3576  	/* Remove core ctrl ref. */
0b5a7669a457dd James Smart       2017-06-15  3577  	nvme_put_ctrl(&ctrl->ctrl);
0b5a7669a457dd James Smart       2017-06-15  3578  
61bff8ef008845 James Smart       2017-04-23  3579  	/* as we're past the point where we transition to the ref
61bff8ef008845 James Smart       2017-04-23  3580  	 * counting teardown path, if we return a bad pointer here,
61bff8ef008845 James Smart       2017-04-23  3581  	 * the calling routine, thinking it's prior to the
61bff8ef008845 James Smart       2017-04-23  3582  	 * transition, will do an rport put. Since the teardown
61bff8ef008845 James Smart       2017-04-23  3583  	 * path also does a rport put, we do an extra get here to
61bff8ef008845 James Smart       2017-04-23  3584  	 * so proper order/teardown happens.
61bff8ef008845 James Smart       2017-04-23  3585  	 */
61bff8ef008845 James Smart       2017-04-23  3586  	nvme_fc_rport_get(rport);
61bff8ef008845 James Smart       2017-04-23  3587  
ac881fd1288ca6 Daniel Wagner     2023-06-20  3588  	if (ret > 0)
ac881fd1288ca6 Daniel Wagner     2023-06-20  3589  		ret = -EIO;
ac881fd1288ca6 Daniel Wagner     2023-06-20 @3590  	return ERR_PTR(ret);
e399441de9115c James Smart       2016-12-02  3591  
61bff8ef008845 James Smart       2017-04-23  3592  out_free_queues:
61bff8ef008845 James Smart       2017-04-23  3593  	kfree(ctrl->queues);
e399441de9115c James Smart       2016-12-02  3594  out_free_ida:
61bff8ef008845 James Smart       2017-04-23  3595  	put_device(ctrl->dev);
3dd83f4013f0e8 Sagi Grimberg     2022-02-14  3596  	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
e399441de9115c James Smart       2016-12-02  3597  out_free_ctrl:
e399441de9115c James Smart       2016-12-02  3598  	kfree(ctrl);
e399441de9115c James Smart       2016-12-02  3599  out_fail:
e399441de9115c James Smart       2016-12-02  3600  	/* exit via here doesn't follow ctlr ref points */
e399441de9115c James Smart       2016-12-02  3601  	return ERR_PTR(ret);
e399441de9115c James Smart       2016-12-02  3602  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


