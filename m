Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942E606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 01:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dBDUhhjw;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=DX7QSxpE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Oyr8CX2pbnGJ3Q3gjNqYHBW2ZoYGQd/yYe9ksgRu8M=; b=dBDUhhjwnSakx/FrZwytTwF50F
	ZOkbEI3ER8GT7j8Y5GcAyn6rxCiWiTdd3gyTz8rTNQLlQxriJvUrKl7t7Bs/AZB4YgOX4VNt//1Cl
	KmltigzDfElmeLTtiBiBz29S8niytOky+SOm572J3Op1+XaXKfCamAbuAJqDdPY1clMy2JubVjr6L
	9tJvdTS9RHkM2Pry6xWiFBuOxhbfXftJKHV09ktVtt/fSvnhtpvZwf+D0RMQIfJPq01eTv0Bc9ZOT
	clm1TvIxVpBDGFq729HzDMtGgKSGOKzXJkV6JpagEocmFJgqqVFJbtvX353vUi9Uf5KEB0XnJpfmc
	masursmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJLB3-0000000AtnR-2hzI;
	Wed, 21 Oct 2026 01:31:37 +0000
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJLB0-0000000Atmg-1hsu
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 01:31:35 +0000
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-35f036b17easo483595eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2026 18:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792546294; x=1793151094; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Oyr8CX2pbnGJ3Q3gjNqYHBW2ZoYGQd/yYe9ksgRu8M=;
        b=DX7QSxpEPSjEsmOQrA1pRqORPoNSOYTSXKOPQp+jFrVSbTVsYydoOI/X+oFpeU40Wr
         D1Q6YWUEdEjZM/723X2VUqK+wJm0jiqz15Zyaq7ykJe7h/WIA2bCvS+17gxJieyoS224
         Wck4u+gu9u36Cu5Lbn/i8vZKI2w1WYXLGyIP8QkkGwCUerof7HzElvwDIYcMGQf9BM7c
         GT57/RUJpavhK8YDoEUje1LHN9YwSPmY3xRmxzGSWCYyXgMN5z/7x7uhG9WMeU4vAD2O
         l1Om4L592Hjt99X5YrSNalZb2gtnqlvSx7Pj17lwciZmVLxwINLU35PuWo60vmuxrTaK
         oWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792546294; x=1793151094;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Oyr8CX2pbnGJ3Q3gjNqYHBW2ZoYGQd/yYe9ksgRu8M=;
        b=tYB2nqZQ+d21WNQJFZaX9784iGh0ygGIKTuPuhGE0y0J0KrGFiOsduaMnec3QpdYD4
         WfcZqEgrp3FYAV8NE3m+Y/rbATNGFDtdVgOvaNQf2C5YTM1RefUMj8IJuWv4jlX3EqyP
         adIn3Zo2ldkK5yLJfh9oensiC1ZbNvIlB5aGM/WFZGgEhw3E6OMDk0lD9wlE3rFnSWMq
         MbfTuQ9xspapZfQNvA0hoAQDbBa/FzNY/89SxsgKwCuWKM4c4ta9Cso+7VpbL5HepN+r
         T971yaCyDHDLSp+ErUNEY5UwdaBl1SU1cZlff9MgCj3x+vXA2/QuabBKOf+3sPpuLFnf
         Qmfg==
X-Forwarded-Encrypted: i=1; AKwUvBxraoHVju9HCRHRZxfr2jQ8q0XpBrDncBeypGMvHKsFU3YWpmJMGVU0rGtmQzWj6lxH6bN3VRMmg41F@lists.infradead.org
X-Gm-Message-State: AFq9FYKlsp1bBRrZapHEtLwTplwC8bW/fsy6QbQVEXgsXYOTN+OBfyDf
	K2UEUtDeU69KZMbe4Unej2BIgJwKtQc/LJwzdH1Z4dJ9XjIA+j0AYs1pxQrvLZCTtdc=
X-Gm-Gg: AYBFou3vLAy3TJP7IjAWHFsawlN17nXwL3Tp6vVEYsdW/zBeRxHSwM2nYYLcjJOmqrC
	OsaM6VosW4k99jsgsRANr4e1ugauwjrApt6PHAKzFbrvJHq0jnjDHg0F9JsCLz5oxWDSgPsNLhj
	0GnxNhKT1jI/1yw3scjZfGgEdkFUkRsuM+amFbPJyXPDx/gbnQXVHeKjtcgRWPmSvgiHxtCHu1S
	0tMwK8n42TrJZoChNgRrrB/XbSuQrtx3kO/SgDk0HPYufSUnfia0y4qs4CutWMJgaibJG6M37C/
	Xj9oh/QmJ3PH1JvvOrZI90riDyNQfr0NXLfJUr+Cn9TKBc37T9h1NArzLtKUWurhxvULEJG1TPQ
	YifL+Gh6x8bdOhsF0DP37Ny79tEV+9Bzi19yVJSxAGbfi7DKcP4fXIFLsqNbfZc0iD8/PV7sWch
	3dFE1daCNwEKH6AmwfinyxxMNXQ0f+reAAz7RaWPqfe0m26Kutkk8RNEoQPGceJl0mI6USyzL5b
	yrk1/YCVVDECT+HGfHOoASP20rHPLJVZdbZmJ+QPPh8ph8a1k5s2pifUWqa5BiCBr6ZRc9s2bp0
X-Received: by 2002:a05:693c:8807:20b0:351:207d:bff4 with SMTP id 5a478bee46e88-3674b525236mr1312379eec.4.1792546293260;
        Tue, 20 Oct 2026 18:31:33 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3673b1d0ab7sm2567638eec.0.2026.10.20.18.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 18:31:32 -0700 (PDT)
Date: Tue, 20 Oct 2026 18:31:31 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 14/18] nvme-fc: Use CCR to recover controller that
 hits an error
Message-ID: <20261021013131.GU2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-15-mkhalfella@purestorage.com>
 <32d5f56f-285e-43d8-b5a7-490492270e51@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d5f56f-285e-43d8-b5a7-490492270e51@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_183134_446224_58D223A0 
X-CRM114-Status: GOOD (  16.94  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 2026-10-20 13:56:38 +0200, Daniel Wagner wrote:
> On Sun, Sep 20, 2026 at 11:28:12AM -0700, Mohamed Khalfella wrote:
> > +static void nvme_fc_fencing_work(struct work_struct *work)
> > +{
> > +	struct nvme_fc_ctrl *fc_ctrl =
> > +			container_of(work, struct nvme_fc_ctrl, fencing_work);
> > +	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
> > +	unsigned long rem;
> > +
> > +	/*
> > +	 * Tear the association down now so the LLDD can finish unregistering
> > +	 * the remoteport/localport while the fencing this controller.
> > +	 */
> 
> 
> Maybe:
> 
>           /*
>            * Tear down the association before fencing starts. Fencing can take
>            * a long time and the LLDD can't finish unregistering the
>            * remoteport/localport until all associations on it are gone.
>            * Inflight requests are held and only completed once fencing has
>            * finished.
>            */
> ?

Yes, this is better. I updated the comment just like suggested above.

