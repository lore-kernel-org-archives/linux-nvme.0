Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDECC433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 13:16:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E6C61242
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 13:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E6C61242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N7+BM5uLZ26UuCLznx5aYXtAcL0ynA5G5hQycAlc3MU=; b=OmHKvFwLS28CKyQcvNkqXELMa
	BUCMGAMeTouOq+2UWq9UaAO07HvLUwALnJoOUH38gJCB/NzFMMP5EfiYxd0sxab1tG3Swx+pLVtfL
	bnW2miXft9EVqIQGLSg/LLwhE/mPZ0Bn91IuukrBA/cl4/2rV4x7ChpZ5pBI0ZQogNxDcmOKzIm79
	m/u8DqsrdZy6YLA4Wm25sY533qDqL3SkCozcfclKPOwTXQXsWas97+K0oKWylZKycndtwTRZEPukt
	TkNyobF/JVhKooItgpbdcWlsgSXso2R6cOe8QodTBzQT2xzpUZ0O/RTV96r3gzmj7I+2IKZ7pzSLh
	aC8x+TE8w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lU823-0051UO-KD; Wed, 07 Apr 2021 13:15:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU81r-0051TA-ED
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 13:15:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5B56068B05; Wed,  7 Apr 2021 15:15:28 +0200 (CEST)
Date: Wed, 7 Apr 2021 15:15:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210407131527.GA15142@lst.de>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <20210406064841.103393-2-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210406064841.103393-2-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_141535_142381_49EA3C7D 
X-CRM114-Status: GOOD (  22.22  )
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

On Tue, Apr 06, 2021 at 03:48:41PM +0900, Minwoo Im wrote:
> +static bool generic_ns = true;
> +module_param(generic_ns, bool, 0644);
> +MODULE_PARM_DESC(generic_ns, "support generic namespace character device");

I do not think the module option is a good idea.

> +#ifdef CONFIG_NVME_MULTIPATH
> +static int nvme_generic_ns_open(struct inode *inode, struct file *file)
> +{

The ifdef here means that the cases of either a subsystem that can't
have multiple controllers or the multipath=N option can't be handled
properly.  We really need two different code paths:  one with the
cdev in the namespace, and one with the cdev in the ns_head.  Just
like the gendisk.

> +	return nvme_ns_head_open(generic_ns->head->disk->part0, file->f_mode);

Calling this based on the bdev is a little silly when we can just
use the trivial underlying functionality.

> +	device_initialize(&generic_ns->device);
> +	generic_ns->device.devt = MKDEV(MAJOR(nvme_generic_ns_devt), minor);
> +	generic_ns->device.class = nvme_generic_ns_class;
> +	generic_ns->device.parent = ctrl->device;

We can't reference the controller for something hanging off the ns_head.

> +	/*
> +	 * If the namespace update fails in a graceful manner, hide the block
> +	 * device, but still allow for the generic namespae device to be
> +	 * craeted.
> +	 */
> +	if (nvme_update_ns_info(ns, id)) {
> +		if (generic_ns)
> +			ns->disk->flags |= GENHD_FL_HIDDEN;
> +		else
> +			goto out_put_disk;
> +	}

We must still fail when the error is one that does not just indicate
a not supported feature.

> +struct nvme_generic_ns {
> +	struct device		device;
> +	struct cdev		cdev;
> +	struct nvme_ns_head	*head;
> +
> +	/* targted namespace instance.  only valid in non-multipath */
> +	struct nvme_ns		*ns;
> +};

I don't really see point of this extra structure.



FYI, I've looked into addressing some of these points and will send
out an updated patch that sits on top of an ioctl and multipath
refatoring series I planned a while ago that I resurrected for this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
