Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3968C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 14:11:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4563161107
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 14:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4563161107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Bi4vB4OUhOJPBUxDHv6RxX+4BkQgZxXCI1Q/fR08MUA=; b=RON2pa5SxH2zal9uCf9e5SGzu
	wg8ofng5CDOieudseslM15NmT7OxH9HFSiELq2FBvE+P2DJSAMF9vyp7M1KZCNhYeycJ80kJPxwHm
	uJZq2b2uKW4VgWP54bnDgZ65p2Pkh3UCjYgkWTusopYsxEIilN5ZO5R85nY5S/bjjRXi6hZao9Mcb
	v488hqT8l0VTbE14mwI8UVT5logtsGLXhy9UPU+kxmMUtzvCb4fWRSuUI2mxVmGgsA6EZkvMRsmUe
	sHcimxyJCMb19TDcG7zqLIylKR6h9YYdtZyESxkWRRUM2b1jwbO+sjUjjEHIRSFbdXajyHUuzMKyG
	yLW8TcG2Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lU8uB-0055xz-At; Wed, 07 Apr 2021 14:11:39 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU8u5-0055xK-AM
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 14:11:35 +0000
Received: by mail-pl1-x62e.google.com with SMTP id v8so9392344plz.10
 for <linux-nvme@lists.infradead.org>; Wed, 07 Apr 2021 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=w/bqYtHD89YNEdiefJ6vHz2LesdegfJQj9NTf6zfspU=;
 b=e3wZm55q/4XHt4ZDNm90gffBKruM44vHKTCoHwLB3oTAqtf43ubquK1QMIU3jPw2op
 wwmpRi7rJl+IA/Fd/wZHhICx0A2FLq9toc/fA2lfCkAapbYAVrMO/1uaDOS+c4kFX9kg
 l0kJ9HaKSLQTh6xfmZrZvk5StLUDpwwIsOzu2wVUYhGsXN+BXHw37ZyBaC2n+wUZqgOB
 jk8Ra2/OX5StaqEUcANL3dMU0zv524VSJQ/9XGXtUFWuGsAzIMJT3roildHANWODX4Pr
 pWo4taO2UfPCym9Xa8Qr/PDDBehkjyjAk3c08I/xQQKcZkFcU3iId3nTlst5nTxZGPbE
 JSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=w/bqYtHD89YNEdiefJ6vHz2LesdegfJQj9NTf6zfspU=;
 b=gAXPDnBaYuXmTPU1Mtw8SWMWVCDuKpy6uGgXZtJ3GSSI6C1hMBUQeLizB5jTsaoUJe
 iVxPvFYpeM2iEd4Fs10jX5kqPvmDdv+EOk+eqrlo6NlhzvrjFdfKA7/4ibmCiQ4KpP+H
 ID+w2ePuQBdib/gMJN7f6lGNJwWsbBbqGCfbL8S0BUSxVx8tZNKG3Par/dZ7JQFQq6+I
 H9Zr+4xtq9XsSNx3Fq2C6MYt2YMwXwacUpLZvjFJG4oh+Ont8P/ZiI5HEnVpRHlixVDg
 AHljmSRzSre03O3H75Jm1RLr9Dfabmj0cMjRNdWVWCb6fqtW/qpave6p7NSOg2ENSGC2
 ZCNw==
X-Gm-Message-State: AOAM5327bEDIAXT7XGCJrevzHR6eBxtLT7V8EIT9gJMT42eqr+8ZU7eO
 oJLexf+80hwbbrgRlA7PzFc=
X-Google-Smtp-Source: ABdhPJxr5316hzlWglEJHPAXYpZXpO06P7Wg4O8vWje3PYiA5+cGUKZfaf4AXabTU1x+CdfUeG2WQQ==
X-Received: by 2002:a17:90a:5284:: with SMTP id
 w4mr3408037pjh.29.1617804690939; 
 Wed, 07 Apr 2021 07:11:30 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id p2sm21760153pgm.24.2021.04.07.07.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Apr 2021 07:11:30 -0700 (PDT)
Date: Wed, 7 Apr 2021 23:11:28 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210407141128.GB2805@localhost>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <20210406064841.103393-2-minwoo.im.dev@gmail.com>
 <20210407131527.GA15142@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407131527.GA15142@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_151133_483089_39983AB2 
X-CRM114-Status: GOOD (  35.39  )
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

On 21-04-07 15:15:27, Christoph Hellwig wrote:
> On Tue, Apr 06, 2021 at 03:48:41PM +0900, Minwoo Im wrote:
> > +static bool generic_ns = true;
> > +module_param(generic_ns, bool, 0644);
> > +MODULE_PARM_DESC(generic_ns, "support generic namespace character device");
> 
> I do not think the module option is a good idea.

Okay. Will make generic device by default.

> > +#ifdef CONFIG_NVME_MULTIPATH
> > +static int nvme_generic_ns_open(struct inode *inode, struct file *file)
> > +{
> 
> The ifdef here means that the cases of either a subsystem that can't
> have multiple controllers or the multipath=N option can't be handled
> properly.  We really need two different code paths:  one with the
> cdev in the namespace, and one with the cdev in the ns_head.  Just
> like the gendisk.

Agreed.  Kanchan has reported that if multiple controller in CMIC is not
supported, the head disk instance is not allocated and this code will
just return -ENODEV.  As you pointed out here, will make it work in the
next version.

> > +	return nvme_ns_head_open(generic_ns->head->disk->part0, file->f_mode);
> 
> Calling this based on the bdev is a little silly when we can just
> use the trivial underlying functionality.

Then can we have like this ?  The following diff is just considering the
ns_head only, but just conceptually, not hanging out with bdev, it's
just get the reference.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a06634e7bad1..c92328eedc00 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2377,15 +2377,18 @@ static const struct block_device_operations nvme_bdev_ops = {
 };
 
 #ifdef CONFIG_NVME_MULTIPATH
-static int nvme_ns_head_open(struct block_device *bdev, fmode_t mode)
+static int nvme_ns_head_get(struct nvme_ns_head *head)
 {
-	struct nvme_ns_head *head = bdev->bd_disk->private_data;
-
 	if (!kref_get_unless_zero(&head->ref))
 		return -ENXIO;
 	return 0;
 }
 
+static int nvme_ns_head_open(struct block_device *bdev, fmode_t mode)
+{
+	return nvme_ns_head_get(bdev->bd_disk->private_data);
+}
+
 static void nvme_ns_head_release(struct gendisk *disk, fmode_t mode)
 {
 	nvme_put_ns_head(disk->private_data);
@@ -3877,7 +3880,7 @@ static int nvme_generic_ns_open(struct inode *inode, struct file *file)
 		return -ENODEV;
 
 	file->private_data = generic_ns;
-	return nvme_ns_head_open(generic_ns->head->disk->part0, file->f_mode);
+	return nvme_ns_head_get(generic_ns->head);
 }
 
 static int nvme_generic_ns_release(struct inode *inode, struct file *file)


> > +	device_initialize(&generic_ns->device);
> > +	generic_ns->device.devt = MKDEV(MAJOR(nvme_generic_ns_devt), minor);
> > +	generic_ns->device.class = nvme_generic_ns_class;
> > +	generic_ns->device.parent = ctrl->device;
> 
> We can't reference the controller for something hanging off the ns_head.

Got your point.  Let me fix this up.

> > +	/*
> > +	 * If the namespace update fails in a graceful manner, hide the block
> > +	 * device, but still allow for the generic namespae device to be
> > +	 * craeted.
> > +	 */
> > +	if (nvme_update_ns_info(ns, id)) {
> > +		if (generic_ns)
> > +			ns->disk->flags |= GENHD_FL_HIDDEN;
> > +		else
> > +			goto out_put_disk;
> > +	}
> 
> We must still fail when the error is one that does not just indicate
> a not supported feature.

Okay.  Let me first list up the real error cases.

> > +struct nvme_generic_ns {
> > +	struct device		device;
> > +	struct cdev		cdev;
> > +	struct nvme_ns_head	*head;
> > +
> > +	/* targted namespace instance.  only valid in non-multipath */
> > +	struct nvme_ns		*ns;
> > +};
> 
> I don't really see point of this extra structure.

As you pointed out above, we just can't rely on the nvme_ns_head where
disk might not be allocated.  Earlier, I was trying to put this to
nvme_ns_head, but now possibililties are two.  Where do you think for
this generic device fields to be located properly ?

> FYI, I've looked into addressing some of these points and will send
> out an updated patch that sits on top of an ioctl and multipath
> refatoring series I planned a while ago that I resurrected for this.

Sure.  Once series are applied, we can make it on top of that series.
Thanks for sharing!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
