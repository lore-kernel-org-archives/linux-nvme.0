Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A560EEB570
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Dec 2025 22:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cuRm8CIPxlGH0xisps8rZUq5ovMIXRx8PmUQ+JJfoqs=; b=0Wq2zmMir7ZPSJzV3jE+a4Fpwz
	w5L9gkFzuSN9bABali1otDj3KzlH90u4M+NDL51CcgGpxTgLRbYXbu9adpjLJw5zM0vwLB0xGDSsk
	cGsgtFawST10YXy07qyc4RgpeKHByfKg3bahwDw11t1JCzcGx3o2dgmYp+KddMkNRqKZfbPjPq7j5
	QjyiCCElPrCNAx2KNx/rGSlyyPN2ZWkVjkOOl4S0wDcGkUpVWQg2sMDZ9fS6ALqNG0mqQUivQwyIe
	Ay98wgcxJaFaFCeslcNgEyvoVUQkF4OwTBxpQqnE49c7Q9oAYB7VY3Q24qgx7yaOSmG8ojDn+D9vm
	9d3qLmYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb4wN-00000006P5V-1aBv;
	Wed, 31 Dec 2025 22:45:15 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb4wI-00000006P52-0qCe
	for linux-nvme@lists.infradead.org;
	Wed, 31 Dec 2025 22:45:11 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c227206e6dcso10403791a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 31 Dec 2025 14:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767221109; x=1767825909; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cuRm8CIPxlGH0xisps8rZUq5ovMIXRx8PmUQ+JJfoqs=;
        b=KViZwg/tF9sOk+fMDbKFiwVTWvywUARcT4njDbNXNdEHF+upXA4uAhWkB2Szv/nQDU
         lVDUCAVgAzWfVXBYXt1ylck6QuBQr0CMGiS8tdjJmDz4Wfg5KpkrIrc8uNSiAB3L7XJo
         rxbBXK2DNSpe2eTcT3VsBGzfPpUKNz9L/lXwwauEh5St5ANVhOxJE0cuOyPV0ceSOPOC
         Lib8ExIgu8TRifNnvi6tfjADh2XkhPvAL6Q0J1W54Lvgyp05Yowuz/eMBGNvaBc000DT
         746aZsbO6AP1hlsWZ4oMCT57bW/72QcfVXXwANTOdWxQeM2qqfLRCnseOtrfs+0Ma5GK
         CPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767221109; x=1767825909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuRm8CIPxlGH0xisps8rZUq5ovMIXRx8PmUQ+JJfoqs=;
        b=eSLgfMNVC7mhAdaEF0iDu15asG/5MmmruTynGF5kC+vbocI/gHVEmd5DVwo58tDIEZ
         BmC7PkSCXu8ZHJTdlwDEKtETxLkx4c02iMuP85wFkyzBe/RlC+5x8zbB10z5N1kc5yNH
         xhCLAkhDETkL78xZMUVCb2kqd1HnSoPoDE9ydegxsOM7pRJmM5xUvBK9kRUmYyLWvxwk
         sf33GakeeW1UUr0vCTjn5E4ez1IqWnkK2yOln8xAZ2sjGQ3zXHXku2XEDiiovzxfgh5R
         hq9VdzEfq4VHK+8Qe4yjVdMlww6JiKIm0Qhj/A3jviUZFvyE3CFygyVzNcEmN3nB3Z/U
         OZtg==
X-Forwarded-Encrypted: i=1; AJvYcCWtCleM4/ZMVR7HgSja01KNmIzGbkM/Ca28iqVHJLAJfNHFcsL15NXvEpp4fP7asZBEbxkugdjgqEtk@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5rHvca2cWAC5SlY6ZalgqamQZ37lZp/DPMYcDGt/7VulSgYI2
	N1Vqi2vGeFRasVteiZAr32/Jaxc74Nl7A4QdG1rRz2AopRoLRuMJiSW1gKOehFDS48w=
X-Gm-Gg: AY/fxX4L19d3u1ZEQ3hmQM5d70d0PwxDxlluyl9+pHz1yXCnYXcvWVVGEYIfcootF7c
	K9VImeNFgKnwUzotXc3cUCTnD0uN2EfH70V39ZbMKZNpgA0H9dq+fstr5Lt5PEUp9EailyJeatd
	BmPrbIQ6TvS9jp74n1ROjcupI+Q/tjbE/iIfG1Uuiak6jGXBoxaNrDVu5c5MKuDP5fcxhjWraVu
	/hGd56KV0tbt32f32m9S2Top+FFCAtLDK0Y6wj8X+uMR/OmzYUdvgp+zlweNC96MYuR/BuYvt10
	9xpTXRdAOugwSKrMqZea1/zddt+C5fjrdQBDzy3akkgyxW9Gkrf8vY5qETff/lSSWvHixWcqLWY
	1D+CpvxabbuR5icNz4N23FIhgJoN6D04XojPaIAIfW1oL7GbKrBkbcyW00SdMWT+PY/HfgWcqgP
	Ct8Ha5zYrYhhs9kJmbJdfybAIUiN+gVw8=
X-Google-Smtp-Source: AGHT+IEZLT/+WbCKBQMwpBdR5Aquq/aznnOPx+B3An3bx9Mxw29q3Zlmri8iNhG7vbXZ+1tAkhEJjg==
X-Received: by 2002:a05:7022:428b:b0:11d:f440:b743 with SMTP id a92af1059eb24-121722a7648mr34297831c88.7.1767221108847;
        Wed, 31 Dec 2025 14:45:08 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-121725548b5sm143825183c88.17.2025.12.31.14.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 14:45:08 -0800 (PST)
Date: Wed, 31 Dec 2025 14:45:07 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/14] nvme: Add RECOVERING nvme controller state
Message-ID: <20251231224507.GN3864520-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-8-mkhalfella@purestorage.com>
 <e9bb2664-9d96-45f0-a39d-6deaad0829e9@grimberg.me>
 <20251225171709.GA8129-mkhalfella@purestorage.com>
 <fc33dcfe-244c-412a-ab06-a554a66ada1b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc33dcfe-244c-412a-ab06-a554a66ada1b@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_144510_491289_C266D1DB 
X-CRM114-Status: GOOD (  28.88  )
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

On Sat 2025-12-27 11:52:31 +0200, Sagi Grimberg wrote:
> 
> 
> On 25/12/2025 19:17, Mohamed Khalfella wrote:
> > On Thu 2025-12-25 15:29:52 +0200, Sagi Grimberg wrote:
> >>
> >> On 26/11/2025 4:11, Mohamed Khalfella wrote:
> >>> Add NVME_CTRL_RECOVERING as a new controller state to be used when
> >>> impacted controller is being recovered. A LIVE controller enters
> >>> RECOVERING state when an IO error is encountered. While recovering
> >>> inflight IOs will not be canceled if they timeout. These IOs will be
> >>> canceled after recovery finishes. Also, while recovering a controller
> >>> can not be reset or deleted. This is intentional because reset or delete
> >>> will result in canceling inflight IOs. When recovery finishes, the
> >>> impacted controller transitions from RECOVERING state to RESETTING state.
> >>> Reset codepath takes care of queues teardown and inflight requests
> >>> cancellation.
> >> Is RECOVERING really capturing the nature of this state? Maybe RESETTLING?
> >> or QUIESCING?
> > Naming is hard. QUIESCING sounds better, I will renaming it to
> > QUIESCING.
> >
> >>> Note, there is no transition from RECOVERING to RESETTING added to
> >>> nvme_change_ctrl_state(). The reason is that user should not be allowed
> >>> to reset or delete a controller that is being recovered.
> >>>
> >>> Add NVME_CTRL_RECOVERED controller flag. This flag is set on a controller
> >>> about to schedule delayed work for time based recovery.
> >>>
> >>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> >>> ---
> >>>    drivers/nvme/host/core.c  | 10 ++++++++++
> >>>    drivers/nvme/host/nvme.h  |  2 ++
> >>>    drivers/nvme/host/sysfs.c |  1 +
> >>>    3 files changed, 13 insertions(+)
> >>>
> >>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >>> index aa007a7b9606..f5b84bc327d3 100644
> >>> --- a/drivers/nvme/host/core.c
> >>> +++ b/drivers/nvme/host/core.c
> >>> @@ -574,6 +574,15 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> >>>    			break;
> >>>    		}
> >>>    		break;
> >>> +	case NVME_CTRL_RECOVERING:
> >>> +		switch (old_state) {
> >>> +		case NVME_CTRL_LIVE:
> >>> +			changed = true;
> >>> +			fallthrough;
> >>> +		default:
> >>> +			break;
> >>> +		}
> >>> +		break;
> >> That is a strange transition...
> > Why is it strange?
> >
> > We transition to RECOVERING state only if controller is LIVE. This is
> > when we expect to have inflight user IOs to be quiesced by CCR. We do
> > not care about inflight requests in other states.
> 
> Sorry, got confused myself - I read it as the other way around...
> I am missing RECOVERING -> RESETTING transition in this patch.

This is in patch 8 ("nvme: Implement cross-controller reset recovery").
It was not added to nvme_change_ctrl_state() because we do not want the
controller to be reset while in RECOVERING state.

