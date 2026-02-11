Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF83EB5946
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 00:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cujy7Px8Xtv882zc02e0/J26UmbB2bTAirwtCIJhOg8=; b=EmZusppSuTkVIL3lzfbP+oTr5U
	dLqdI3JIcUA1yDnkU2NofA+iNqc3Y/CZIzCXtlMx7FK8jyDN1qHwfbmSBEFSO4sm/u8fiYnS0D1gs
	PHx6w9H4iZ84YhveiAPmxmjwV1mO/BcFMhmiKkQ6rKouIlvZdBveNedsyagBPdI98CuKkp90J5UP5
	azaiG3W08noFVpKtym1CMZWVrZHTiup1ppRRwton5IQo7ooHQLGk1CxXZDQVE6ejK9Xig7cizJz2V
	E249h/1S3eDiBnLPPOPQlBk5qRvmQp4QWSgP23CM/MjF1h0gQgzZKThnN41DQ4tV82FIaTK6Y8tSz
	qlMCtH/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpxqe-000000002pJ-06ud;
	Wed, 11 Feb 2026 00:12:52 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpxqb-000000002ox-2qwa
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 00:12:51 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so51471195e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 16:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770768767; x=1771373567; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cujy7Px8Xtv882zc02e0/J26UmbB2bTAirwtCIJhOg8=;
        b=eI7fi1JMW9e/UTtzq0cNOxen5dNFaiRMG+OULP21FmvhBngUKSjMKcNUMu+4N6775x
         cGRAxzwPNXdpLOea5hpOIYv6VKo4DkKFWHJomHWwMINx3ypuGkgRO5psLmSPmy1mpM2M
         MMPaI3+QWWg2ilMpKnVHF0wtTV+AzSqar5of0xHzifxo0g5wu0AZMmIoZtdr+Biclz6V
         ia7cV9MqMZPbnjPlcHLVyKic/sClBgokxDlFvXWEFBY9ckeflpGo2e25TRgI2u2cAnae
         5Yl+PvJIDX7zzvEDy9veEXV7hXaMK1uRO695l6TElOHzHDAOoxtKOSSGzPq55jMz6dSK
         tNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770768767; x=1771373567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cujy7Px8Xtv882zc02e0/J26UmbB2bTAirwtCIJhOg8=;
        b=lXJXXL/7FztUXK2mUy0om/3IZkF+k0r6+BtOCFavZDUmgpFuErgWVmFOTUI8lGaNC2
         mZmTJuoU34JAjY105osvylW2KVOzgrXmpT/8Ju1Ah8lE8tr0lGcIJPIARhbnEzlVeb3x
         +LHZG1QchkrBKhrJ3rDQ/rqsIzcwneXEJOF/ww0yA8FJXFakUxmy8Evbv3kDNjGnnp44
         WQm7OTqMtKN3lN/KmsSwdQS0FpqsmmoqjUE6xpN16SdO/yxGsfqsj3D7WAA3AGz5WCMr
         ZfGzAcjy04XxvHnijN0pTicugMfhYUmd+7CBhILPbcD3HQFkLhfzoxo/2FbGyQyq1mFV
         /JUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJFxBX/9RT5LrsZg98a6Uy5CIZtOdW7Eca7qQ33X2w0cMvOAJhIoo8a7ahOac/ZkG9TtwDmxMW3BBK@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/sOCMX864c5IhJKoVIskvgS8G8d9RswHqCyi2Vv5JBaYRYwoL
	zW2kYM2nzE3lHUeq0uX6uMN73JtccrESJw4cKQj/JCYeskhqfK4RxNr5zpe8Do/tnuA=
X-Gm-Gg: AZuq6aLg+BcBM1GLUzQtrcC0ObDuGnpM9tQXRhQc+FBdEvXRzRouTGVs8Sy8dlRNAqr
	CwSEhDVDXyRJqFn01HJ8AQq6XCCG7Vclldkwi+luAGVob7OZDAiC++TyjhK8Kg54ecqy9qkVAqt
	FipChOCsGdPKboSab4Ea5KUJqh56H/7AWHMKcleRh46mrA5/WD9RI7NChd5leaPnvIZDVCOHof+
	Fbp/1W3DlcJYDLGNVcghniq7xbs27NYxc+LMk/2Pbui99230TzOOGYjrsM3HFS9NSYTIAfMfIiu
	p1MYoL8qeRxf9QVWjd3lZqdq1kiPAEjWg2MKh91Dqq2/TxQVhZgGQTbXa3GVdWC8yzaIailONzr
	0ApD6hktlVyotCO2+o2ezJl45GrPeC8fUZp9+hkiIvGNwbwK3HKczOm8Pf+prTf8FGJUSXTA2ZF
	N7BglWfWVixrO3zP8GAwklcyhGIXcoYJivsTpDtgt239g=
X-Received: by 2002:a05:600c:1da8:b0:47e:f481:24b7 with SMTP id 5b1f17b1804b1-4835dfcf995mr677145e9.17.1770768767169;
        Tue, 10 Feb 2026 16:12:47 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5b1f17b1804b1-4834d8334a8sm88916655e9.12.2026.02.10.16.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 16:12:46 -0800 (PST)
Date: Tue, 10 Feb 2026 16:12:43 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: James Smart <jsmart833426@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] nvme: Implement cross-controller reset recovery
Message-ID: <20260211001243.GS3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-9-mkhalfella@purestorage.com>
 <05875e07-b908-425a-ba6f-5e060e03241e@gmail.com>
 <20260210222732.GQ3729-mkhalfella@purestorage.com>
 <5f3c9cf0-7fee-432a-b6c5-44fb2acb0b1d@gmail.com>
 <20260210232553.GR3729-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210232553.GR3729-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_161249_776742_D86B7B57 
X-CRM114-Status: GOOD (  40.06  )
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

On Tue 2026-02-10 15:25:55 -0800, Mohamed Khalfella wrote:
> On Tue 2026-02-10 14:49:15 -0800, James Smart wrote:
> > On 2/10/2026 2:27 PM, Mohamed Khalfella wrote:
> > > On Tue 2026-02-10 14:09:27 -0800, James Smart wrote:
> > >> On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
> > >> ...
> > >>> +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> > >>> +{
> > >>> +	unsigned long deadline, now, timeout;
> > >>> +	struct nvme_ctrl *sctrl;
> > >>> +	u32 min_cntlid = 0;
> > >>> +	int ret;
> > >>> +
> > >>> +	timeout = nvme_fence_timeout_ms(ictrl);
> > >>> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> > >>> +
> > >>> +	now = jiffies;
> > >>> +	deadline = now + msecs_to_jiffies(timeout);
> > >>> +	while (time_before(now, deadline)) {
> > >>
> > >> Q: don't we have something to identify the controller's subsystem
> > >> supports CCR before we starting selecting controllers and sending CCR ?
> > >>
> > >> I would think on older devices that don't support it we should be
> > >> skipping this loop.   The loop could delay the Time-Based delay without
> > >> any CCR.
> > > 
> > > I do not think we have something that identifies CCR support at
> > > subsystem level. The spec defines CCRL at the controller level. The loop
> > > should not that bad. nvme_find_ctrl_ccr() should return NULL if CCR is
> > > not supported and nvme_fence_ctrl() will return immediately.
> > > 
> > >>
> > >> -- james
> > >>
> > 
> > I would think CCRL on the failed controller would be enough to assume 
> > the subsystem supports it.
> 
> ictrl->ccr_limit is a good indication that subsystem supports CCR. I do
> not think it is enough though. I say that for two reasons:
> 
> - May be this controller does not support CCR but others do on the same
>   subsystem. There is nothing prevents subsystem from putting a cap of
>   CCR at subsytem level.
> - May be this controller supports CCR command but not now because all
>   CCR slots are used now. This can happen in the case of cascading
>   failure.
> 
> > 
> > I'm not worried about the coding on the host is so bad. It's more the 
> > multiple paths that must have cmds sent to them and getting error 
> > responses for unknown cmds (should be responded to ok, but you never 
> > know) as well as creating conditions for other errors where there will 
> > be no return for it - e.g. other paths losing connectivity while the ccr 
> > outstanding, etc. yes, they all have to work, but why bother adding 
> > these flows to an old controller that would never do CCR ?
> 
> If nvme_find_ctrl_ccr() returns a source controller to use then we know
> the controller supports CCR and does have an available slot to process
> this CCR request. I do not see how this code will send CCR request to an
> old controller that does not know about CCR command.
> 
> I am not fully opposed against using ictrl->ccr_limit to return early. I
> do not see the need for it. If you feel strongly about it I can update
> nvme_fence_ctrl() to do so.
> 

I forgot to mention that ctrl->ccr_limit is initialized from id->ccrl in 
nvme_init_identify(). If this value is greater than zero then we know
the controller does support CCR. nvme_find_ctrl_ccr() checks for that
and the returned source controller must support CCR and has a slot
available for it.

