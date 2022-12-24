Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB59C4332F
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Dec 2022 15:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HJvpfRX2tbFtq+ubTBg2ndy7utW61VdVDpl6vlz73bY=; b=Cmg1q6I2ts9tZYJi9aA+Li1ul/
	TGYXa/Xjc+CDg5YkVsd3xoSAhFl1aXMkfaoo+CETzdU2QjQ+vuxHDeTIff4MJwNtfS/U4Omh7mY7g
	Uhfii9OG1WVPvV3+GM0wIaUlE7JvGxqIvOK0AH/W0qQ1xs8MMPiCdwBtAUVt+1aBGFHe+Lxrh64M7
	YMJz00RJbsBVeA5oZQ+ORHbYdVZnKFdJ0hmgUJx9ivfLTdo8UpgEcNADgfC5xqQSQ5Noq0vA5qB6H
	oVO36fqbz/3+XYjGl2lANKRu42Bz9R0t1hJXkxG/p3F45+EXBexze1tRdvjmjFMyi1ulOSryIjozw
	lE49hX6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p96K9-0011zS-SO; Sat, 24 Dec 2022 15:20:34 +0000
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p91d7-00Gp0z-5h
	for linux-nvme@lists.infradead.org; Sat, 24 Dec 2022 10:19:50 +0000
Received: by mail-qv1-xf35.google.com with SMTP id q10so4584698qvt.10
        for <linux-nvme@lists.infradead.org>; Sat, 24 Dec 2022 02:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJvpfRX2tbFtq+ubTBg2ndy7utW61VdVDpl6vlz73bY=;
        b=PWGgmKyPL3Uk6FAntsHlLJMP/dbDLVk9k4YlNWSNMsPXD+AjwlbME3lRPHmUUt/uvo
         FYHY6BZ41AB1372hFGt7Tf0PB1aijjhUWvFV6+1u5cu6gDmWLxFLI8wOqwgvbeyLveJS
         hndZQhl3BIj0beM29p7ALfgnv8prJMrx+FWkjODS9cPaU//nfJOMIM3u3hRdMNcCwuXg
         WFfYx2UlP0HBWaMHCjdMgn/Vc25sG17gK/p5CPFU5Pk6UgZwLN4ysocPosyhOOR7ibU+
         socQDMyglbeUH6CbrF1dH1oSxjSfLdwDTYJVYAaR2AYZuppBEm0BBm4vrM5An8zEq6hd
         rxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJvpfRX2tbFtq+ubTBg2ndy7utW61VdVDpl6vlz73bY=;
        b=JFn+yrMx3CX5ic/Eep2qmj84yD340vKoyc+jW0oGO0Srbq2fECW1t98Vif2f/p3ZFG
         mrz49q+rEodAcS6bmfjF3k3HCYCf86P2TI9ey3XOj00bAJWI/XtubCnIv53MoALLcqQk
         YqbwkKZriFC3Bq2sCnHVGfEYbXnFuK/oZ94Jp6Wv8aF+BbGA0UadGDqsLLWJvGf4Fnbm
         kMhUakgpeNx+OQUpIOuO4qSDFvApS19PUCaOPfHOh2zUMJbqV8rxAyMtHenAjXpJnQOU
         IFJdsgSa0p4UJYSpXkyeyxIhxA4+LvLw0GAFjbxUCCEE6dNH7q1h8cd9Qsx+i41/P7ZG
         v1xQ==
X-Gm-Message-State: AFqh2kp3HDvw6Axh5Fx0TA0QO5X7MJk+RwT2kJ27ddVXdX9fp3NLYRUk
	I41WR+GQUK3uTkkuD6aB9LKtSw==
X-Google-Smtp-Source: AMrXdXuCRtN0lCn4Wy8/udbHBgrRkQKIQCfv9E6k+b6rheJIsOH43Iccppqy0TG6XpeUFQgvm+baSA==
X-Received: by 2002:a05:6214:3512:b0:4c7:a29:6495 with SMTP id nk18-20020a056214351200b004c70a296495mr15977018qvb.3.1671877185757;
        Sat, 24 Dec 2022 02:19:45 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id cx15-20020a05620a51cf00b006f8665f483fsm3793869qkb.85.2022.12.24.02.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 02:19:44 -0800 (PST)
Date: Sat, 24 Dec 2022 02:19:34 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: Christoph Hellwig <hch@infradead.org>
cc: Hugh Dickins <hughd@google.com>, Jens Axboe <axboe@kernel.dk>, 
    Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
    Chaitanya Kulkarni <kch@nvidia.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Thorsten Leemhuis <regressions@leemhuis.info>, linux-block@vger.kernel.org, 
    linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 6.2 nvme-pci: something wrong
In-Reply-To: <Y6amzxU7choHAXWi@infradead.org>
Message-ID: <c67eba0-fc5a-4ad0-971-cf80bc1c6e5a@google.com>
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com> <Y6amzxU7choHAXWi@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221224_021949_241878_5DBA2A1A 
X-CRM114-Status: GOOD (  33.18  )
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

On Fri, 23 Dec 2022, Christoph Hellwig wrote:
> On Fri, Dec 23, 2022 at 09:24:56PM -0800, Hugh Dickins wrote:
> > Hi Christoph,
> > 
> > There's something wrong with the nvme-pci heading for 6.2-rc1:
> > no problem booting here on this Lenovo ThinkPad X1 Carbon 5th,
> > but under load...
> > 
> > nvme nvme0: I/O 0 (I/O Cmd) QID 2 timeout, aborting
> > nvme nvme0: I/O 1 (I/O Cmd) QID 2 timeout, aborting
> > nvme nvme0: I/O 2 (I/O Cmd) QID 2 timeout, aborting
> > nvme nvme0: I/O 3 (I/O Cmd) QID 2 timeout, aborting
> > nvme nvme0: Abort status: 0x0
> > nvme nvme0: Abort status: 0x0
> > nvme nvme0: Abort status: 0x0
> > nvme nvme0: Abort status: 0x0
> > nvme nvme0: I/O 0 QID 2 timeout, reset controller
> > 
> > ...and more, until I just have to poweroff and reboot.
> > 
> > Bisection points to your
> > 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
> > And that does revert cleanly, giving a kernel which shows no problem.
> > 
> > I've spent a while comparing old nvme_pci_alloc_tag_set() and new
> > nvme_alloc_io_tag_set(), I do not know my way around there at all
> > and may be talking nonsense, but it did look as if there might now
> > be a difference in the queue_depth, sqsize, q_depth conversions.
> > 
> > I'm running load successfully with the patch below, but I strongly
> > suspect that the right patch will be somewhere else: over to you!
> 
> Thanks for the report!  The patch is definitively wrong, ->sqsize
> hold one of the awful so called 'zeroes based values' in NVMe,
> where 0 means 1, and thus have a built-in one off.  We should
> probably convert it to a sane value at read time, but that's a
> separate discussion.
> 
> I suspect your controller is one of those where we quirk the size,
> and the commit you bisected fails to reflects that in the common
> sqsizse value.  The patch below should be the minimum fix, and in
> the long term, the duplicate bookkeeping for it in the PCI driver
> should go away:

Thanks for the rapid response.  No, I've just tried your patch below,
and it does not help.  And I don't see any message about "queue size"
in dmesg, so don't think mine is quirked.

cat /sys/devices/pci0000:00/0000:00:1c.4/0000:05:00.0/nvme/nvme0/sqsize
tells me 511 (and that looked like the only relevant file under /sys).

Regarding the awful 0's based queue depth: yes, it just looked to me
as if the way that got handled in pci.c before differed from the way
it gets handled in pci.c and core.c now, one too many "+ 1"s or "- 1"s
somewhere.

> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f0f8027644bbf8..a73c0ee7bd1892 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2536,7 +2536,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  
>  	dev->q_depth = min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
>  				io_queue_depth);
> -	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
>  	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
>  	dev->dbs = dev->bar + 4096;
>  
> @@ -2577,7 +2576,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  		dev_warn(dev->ctrl.device, "IO queue depth clamped to %d\n",
>  			 dev->q_depth);
>  	}
> -
> +	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
>  
>  	nvme_map_cmb(dev);
>  

