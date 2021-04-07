Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C961CC433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 15:36:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677D66112F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 15:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677D66112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dHZx37W3/pndWU+iww2StS6SQ45ukestGK7kW5GTaDc=; b=h5kikYGwP8xKl2SVd4FruUzUZ
	rrCwno+xrOaqZ/ZpK22R8C0VkuwVSMCfAHuKOnTHlSpNKcF+6LtL5CUapMXQ1W1xUkPWwbBnwjsMk
	WZ5/LZNHdfJDNoa7i7KKJ+eQwm3kRsbCSY9GtodHExlf8/OowHArMhlgEWAQwoepAL+vOBCR5GNZl
	Bi4WFCQZ7mpeJYAY7tH8wyx35iA1R9FUjp4P3q+kdzeVtZpWL9QqHgvIObeiGHvt3zYOOyFXcaW9s
	STBnNU7WHIjuhLo//Ca54//7qRucXypAtGQjC+gxOzz0PVGgT90UDHVEKRRP67zrcR1aBl5+vaxAM
	XS/ud2R0g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUADk-005IBI-O7; Wed, 07 Apr 2021 15:35:56 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUADV-005I9t-TI
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 15:35:44 +0000
Received: by mail-pl1-x62b.google.com with SMTP id t20so9508433plr.13
 for <linux-nvme@lists.infradead.org>; Wed, 07 Apr 2021 08:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2J2xxEruBDHQu+LZ4/NOfLyyYCvsG0bj+yFCL2PsoU4=;
 b=AZhCQP2GdiC56rysxPuAG/7lyzI653yEpkOLRR4mhhwOvT+3aBZd2epLMIkwD6elkv
 62fc96muh+hbnnT5DONohjTJw4AGc8/7hfZMbXo9CVfbAEDpDzz1vhJnuoGlbbtPDRMM
 WoIBvIx2Qh/3cNaHuBA0mLkf47hF0n4nYFbwGYel8/65Zus5IgIrxOs7f/MgaQcEpA1y
 pIsfM4CZNUkHgOLRdj93TWWAL4imn/prPNzDaDJBNsHKIfmASjYhB5DnP1FD6SbEX/rc
 cFcfugQ0s3Ld6hWgBjN1K8LMQMyhnAeWy8gjfu8xHskBV8T9UKIn2IwG6WOBeOTq8zWu
 Svhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2J2xxEruBDHQu+LZ4/NOfLyyYCvsG0bj+yFCL2PsoU4=;
 b=mxR9N11aIPMaQXAnkzixWAZeOJ1qP+s8l60MGe9zjx56DayH4vwn6+nswdYZD1pncD
 Dp8qcZNHvHnVpZgygPyWFw2e1iwppM3S9KLlyEzOqdv2y4+BPQF3jK0xGyHU6jy0qhuN
 VwBht2A+ztyfxtMAGrhAxyLI62pjmm5ShuyvVeryFCkmFrcq7NO8w7/onnqtIRU67Hjb
 ULGtwo1a4AmNGjWAhe+63pUsvh2+awUiwOR+BFefg7g+tN+3zbOFR5KCHIoH6KUiMHuk
 HyDB2vmRVcQLHvGOUgpISAaobh5q4t8bVGbfJbDWsV3YTAvqZ81NQPdop7ozFPiJOgBz
 AqLw==
X-Gm-Message-State: AOAM532L/o02InSobo+hUW3oTzkN3J70qxDw3wIcf3hIs9y0IHxxq7V1
 HugMp1mwEYs55POu8jBI8Jo=
X-Google-Smtp-Source: ABdhPJzIe5AKLDiqY1uG7zPvsi6doCRdQZIprurxRfbGYDyK3tVuy46d3YNykOzgcAMjSZrDS38dIA==
X-Received: by 2002:a17:902:b943:b029:e8:c0d4:eecf with SMTP id
 h3-20020a170902b943b02900e8c0d4eecfmr3420610pls.53.1617809740369; 
 Wed, 07 Apr 2021 08:35:40 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id b1sm6569081pgf.84.2021.04.07.08.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Apr 2021 08:35:39 -0700 (PDT)
Date: Thu, 8 Apr 2021 00:35:36 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210407153536.GA8667@localhost>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <20210406064841.103393-2-minwoo.im.dev@gmail.com>
 <20210407131527.GA15142@lst.de> <20210407141128.GB2805@localhost>
 <20210407142152.GA20466@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407142152.GA20466@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_163542_608138_33CA0072 
X-CRM114-Status: GOOD (  28.56  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 21-04-07 16:21:52, Christoph Hellwig wrote:
> On Wed, Apr 07, 2021 at 11:11:28PM +0900, Minwoo Im wrote:
> > Then can we have like this ?  The following diff is just considering the
> > ns_head only, but just conceptually, not hanging out with bdev, it's
> > just get the reference.
> 
> FYI, this is what I did today.  Not really tested yet and at least
> one known issue.  Busy with calls for now, but I hope to have something
> ready tonight:
> 
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-generic

Here's an additional patch based on the branch above:

1. During the `nvme list` command, controller ioctl for the ns_head has
   been not coming out from the mutex_lock_killable(&nvme_subsystems_lock)
   because it just gets the controller reference and return it without
   unlocking it.  So the first change point of this patch is to unlock the
   mutex right before the return.  But, Is this a real issue? because
   this changes are not from this series though.....

2. Can we have the check whether the ns_head has disk allocated or not
   by getting `disk` pointer out of the #ifdef CONFIG_NVME_MULTIPATH?
   If it's not allocated due to some reasons (e.g., !multipath, or CMIC
   does not support multiple controllers, or some failures during the
   allocations), disk will never be allocated.  So, I tried to pull the
   `disk` pointer out of the #ifdef from the nvme_ns_head, but maybe
   this is not what you have intended....  It would be great if you can
   give some feedback on this.

I had a quick tests based on the branch with the following patch:
  - !CONFIG_NVME_MULTIPATH
  - CONFIG_NVME_MULTIPATH && !multipath
  - Basic I/O for /dev/ng* chardev through `nvme io-passthru` command.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2b04fc451f09..f05eff5b7c30 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2016,6 +2016,7 @@ struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys)
 		if (ctrl->state != NVME_CTRL_LIVE)
 			continue;
 		nvme_get_ctrl(ctrl);
+		mutex_unlock(&nvme_subsystems_lock);
 		return ctrl;
 	}
 
@@ -3687,8 +3688,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	nvme_get_ctrl(ctrl);
 
 	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
-	// XXX: only for the !multipath case
-	nvme_add_ns_cdev(ns);
+	if (!nvme_ns_head_multipath(ns->head))
+		nvme_add_ns_cdev(ns);
 
 	nvme_mpath_add_disk(ns, id);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
@@ -3733,8 +3734,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
 
 	if (ns->disk->flags & GENHD_FL_UP) {
-		// XXX: only for !multipath
-		cdev_device_del(&ns->cdev, &ns->cdev_device);
+		if (!nvme_ns_head_multipath(ns->head))
+			cdev_device_del(&ns->cdev, &ns->cdev_device);
 		del_gendisk(ns->disk);
 		blk_cleanup_queue(ns->queue);
 		if (blk_get_integrity(ns->disk))
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index dc1846d3e4f2..91ff75b41ed6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -417,8 +417,9 @@ struct nvme_ns_head {
 	struct cdev		cdev;
 	struct device		cdev_device;
 
-#ifdef CONFIG_NVME_MULTIPATH
 	struct gendisk		*disk;
+
+#ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
@@ -429,6 +430,11 @@ struct nvme_ns_head {
 #endif
 };
 
+static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
+{
+	return !!head->disk;
+}
+
 enum nvme_ns_features {
 	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
 	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
