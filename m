Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B42E909C1
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jzHPwh7gCcw3aD1stz1FwTBp8o4EpMP2ycLOZFh68ak=; b=GrINXRoXVSSviDNC3BmYf1wUA/
	mzsqbhTG24LHpxuk/VGgJhlkH8uhlQPnJYbF202KHBxikm2pusB0TQ4Rv3uUzezrWtiJYoUpOsC+k
	vmpyIeQMQqXR06mGoo46/GJ81fw9AdyG/9pOkZW33CwqQOjiRPk4btWufvQ+6Oobgu+H/wVjwCA1/
	hWE8h79OmZ3D1j/jz29t+glp44P/1e/jPPsT9dmUi7vljdnWFuNHClRG5NTujNuLixmj5SicBOXm+
	qwjcvwlWd0Tl7r+yx+e6iiaGFFYc6eT44UzEy2wELvYumcWHaJDcpzr3qrxgJSMznFcaIBp616C4j
	Za6+neZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsN6w-00000008Vqk-1xzg;
	Tue, 17 Feb 2026 15:35:38 +0000
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsN6s-00000008VqO-18Mu
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 15:35:36 +0000
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-2ba9d13f10eso7571379eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Feb 2026 07:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771342533; x=1771947333; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzHPwh7gCcw3aD1stz1FwTBp8o4EpMP2ycLOZFh68ak=;
        b=H7pKFofRb9AQ7UQ2bVwf/B1vV5yU6WuWAYC6nJpzziDj9io8/v2SGBcIXH2eqbOL3l
         l5PNV6xKjeSyRQc8ixK6PuJ+Y6Wk7P+TU4r9dBvzCuAqbsufNunio4CBLJ/XrrU/egzI
         0/jOFjT8tgvZPLiLOxUlOTwGO2q3ARXhOFqLdcH7EfUOHG1ngkXNDLgaIlxPmUdUaJjT
         t9NtWq/nCzq12fsw+f5RqJJQ62GSHpjliWZr7NQZ8iAw8uWFjgiVeuvbiNfSW/qGj+lW
         RSNbMIrWLbxBP5VOuLXnhDlDbie1qGOXbI5/3RWyfsWbXlUrK84BDYiQCci4J93bWNKs
         IBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771342533; x=1771947333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzHPwh7gCcw3aD1stz1FwTBp8o4EpMP2ycLOZFh68ak=;
        b=oj0ffCle6on9giGFfENpdu/PWWUYj1ktIkCLCmDLN+S2p/r6yw9PB39AWT1mHLTsVN
         qv8B/GwpHWfK8xbtmtwQ4KqT2sXX8frdmFGeTL0g5wMjURupN3VkUEDSoyIeNmccfw6N
         f7B28v5ib3SF/pkKdQuuoOlK4zVzJUbS0yeOsUo9mokv/nyLgs4G88p583+iDFHHisVH
         2N9ajUGVRArX05I9QiLtiKPr5NmjOZEQNHOyzW6arCJRzSWh7Uv13CL8ndVxIbr38eQO
         ywuh9I76xBx1HydN7j7jiWbGfu97gsX1R/XARmNv9TLR4vOsIVTCQfYBQ7ENAAu9ClsN
         J1/g==
X-Forwarded-Encrypted: i=1; AJvYcCXFmE3cA9053zctTkztQizrWSwj4YMtgqUXxylriFFUFpGRsZ0iY0uqm7M5nw8JnJJtoZO7Igg9nFO1@lists.infradead.org
X-Gm-Message-State: AOJu0Yy8/Y2/QhVTUKQ5ZySitwLo8qEjKqXZlwI39ZYPA5obb32hOmxr
	B3mHKyFwuO5IDlTY8409GOgEWU8/hUKbu7oUfmKequvuWzlwn5nTsrsD1wzgXoEIm6g=
X-Gm-Gg: AZuq6aLneAW6aENLyrJKGR860vepjHCwQ8x6e4coAHohSt7/dKMr5ebfmdhp4ltNUoK
	hje4bgoSX4T1p34NkswC4UWmlEOPvABKwq/U7MWwHtk7ZxcT80yY7Za7IrV0D8lQnJf5eXmUOP9
	Z1XIzs9yiLjWBrPnUs9i1NM5z0xRYaFjedgr46dxZhKscZWnYKygJq4Cj9D7WwV43iwNiTflgDG
	i67t00STyZq/4XZCzwq9e2wKTn80yXMcwCrPZK9m2Yn3yNg2bzQ0OzcX6qhVAnTQCXthOeDsZ81
	aD/tzB0do6zisox1xMRouKRaV+a9yvO8J4v+3CWeMDGqJv1k62bnRRVKXXbDCpNnK7y7yTDo2rB
	QT+DzHPZwdA11CEAib5AKUmZYgBclJNvxEmlZMm3d4f7Sp4Y1qxGR6Q48zlslEhnaitPoMDTGqV
	ubLmBzPyvi1Vk/UXhY6goHMAvqgwM=
X-Received: by 2002:a05:7300:6d22:b0:2b7:f7f:6ad with SMTP id 5a478bee46e88-2babc535b2amr5645107eec.26.1771342533072;
        Tue, 17 Feb 2026 07:35:33 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::68dd])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2bacb543d4dsm14668289eec.7.2026.02.17.07.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 07:35:32 -0800 (PST)
Date: Tue, 17 Feb 2026 07:35:30 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/21] nvme: Update CCR completion wait timeout to
 consider CQT
Message-ID: <20260217153530.GI2392949-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-19-mkhalfella@purestorage.com>
 <9d6cf4f9-37d8-4704-bcc1-0b849ad28955@suse.de>
 <20260216184515.GH2392949-mkhalfella@purestorage.com>
 <3bad149e-a0fa-4377-9701-7b35ef6b5b88@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bad149e-a0fa-4377-9701-7b35ef6b5b88@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_073535_201851_EF58E462 
X-CRM114-Status: GOOD (  31.32  )
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

On Tue 2026-02-17 08:09:33 +0100, Hannes Reinecke wrote:
> On 2/16/26 19:45, Mohamed Khalfella wrote:
> > On Mon 2026-02-16 13:54:18 +0100, Hannes Reinecke wrote:
> >> On 2/14/26 05:25, Mohamed Khalfella wrote:
> >>> TP8028 Rapid Path Failure Recovery does not define how much time the
> >>> host should wait for CCR operation to complete. It is reasonable to
> >>> assume that CCR operation can take up to ctrl->cqt. Update wait time for
> >>> CCR operation to be max(ctrl->cqt, ctrl->kato).
> >>>
> >>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> >>> ---
> >>>    drivers/nvme/host/core.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >>> index 0680d05900c1..ff479c0263ab 100644
> >>> --- a/drivers/nvme/host/core.c
> >>> +++ b/drivers/nvme/host/core.c
> >>> @@ -631,7 +631,7 @@ static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
> >>>    	if (result & 0x01) /* Immediate Reset Successful */
> >>>    		goto out;
> >>>    
> >>> -	tmo = secs_to_jiffies(ictrl->kato);
> >>> +	tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
> >>>    	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> >>>    		ret = -ETIMEDOUT;
> >>>    		goto out;
> >>
> >> That is not my understanding. I was under the impression that CQT is the
> >> _additional_ time a controller requires to clear out outstanding
> >> commands once it detected a loss of communication (ie _after_ KATO).
> >> Which would mean we have to wait for up to
> >> (ctrl->kato * 1000) + ctrl->cqt.
> > 
> > At this point the source controller knows about communication loss. We
> > do not need kato wait. In theory we should just wait for CQT.
> > max(cqt, kato) is a conservative guess I made.
> > 
> Not quite. The source controller (on the host!) knows about the
> communication loss. But the target might not, as the keep-alive
> command might have arrived at the target _just_ before KATO
> triggered on the host. So the target is still good, and will
> be waiting for _another_ KATO interval before declaring
> a loss of communication.
> And only then will the CQT period start at the target.
> 
> Randy, please correct me if I'm wrong ...
> 

wait_for_completion_timeout(&ccr.complete, tmo)) waits for CCR operation
to complete. The wait starts after CCR command completed successfully.
IOW, it starts after the host received a CQE from source controller on
the target telling us all is good. If the source controller on the target
already know about loss of communication then there is no need to wait
for KATO. We just need to wait for CCR operation to finish because we
know it has been started successfully.

The specs does not tell us how much time to wait for CCR operation to
complete. max(cqt, kato) is an estimate I think reasonable to make.

