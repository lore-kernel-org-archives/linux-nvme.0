Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC15EB271F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 23:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2sIbZBDn7RC8xtlEUpZRZ0I3UvC7oJ11E6UNkED3Ag0=; b=l4WYK3r7GHqxfH9vdygqaucwFQ
	lwai55BF5OflS1il69KGeqqdoJJGopS2NJ03GZwv2AB79a/HFLv67s6JbuTfswKhH7QuvjJ3V2gOi
	IHxYok+q1Bz2+myplNsEJyb9+ADx1i2ZL1vkRNRgmDYV3S5JKyi+i8b/EajqKFP0fqJOYbiaqB5Vv
	Yh2WdIqv4GdjNMEMjjZDQNo25qJCKiVd/PEUUIoA7bfdVHoDVkEzFNnFaTqtLQNi17mMjue1fcZnJ
	zEEzapn8ievn8aPKoCyeMixPWmy8QbJ2wrg+vjRwFET+O7YxO6GX1GZa9VhiMwBwXWKDRHUyuNczD
	lHfQh91A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpx7H-0000000013w-01ah;
	Tue, 10 Feb 2026 23:25:59 +0000
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpx7E-0000000013Z-2G08
	for linux-nvme@lists.infradead.org;
	Tue, 10 Feb 2026 23:25:58 +0000
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-2b740872a01so2974590eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 15:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770765955; x=1771370755; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2sIbZBDn7RC8xtlEUpZRZ0I3UvC7oJ11E6UNkED3Ag0=;
        b=GQCv6PIX+YutfDAg/UHXkuBJ5GIQvYMxEY/DQ4iVSw60vfiPDimoaFey3sssV10e7F
         4Z7v21XxFq0I8YYpVhYkD2NIyTBj/Pud+u5QO6uDJ5CW+RfJZPkJ+LtEZAlxyFOnUUUj
         sSF6ha+9jRQndUYvn9By/TmdP63yeLv9wWhTDUahIHQfbrCNo5yO9kxYw181AVW+R9oS
         OU9kjfUWmDpz6gers//wqbazRchulHORY4plErrB81+Q7SkH+y+yDTRPk8UToh8auN7J
         jr58wjmsr1fyYl8NTitKon6TLSdBwB1GwwjaePqkn+ThUx7gZhNFU/mTHHx0Btq+o4oM
         LWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770765955; x=1771370755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sIbZBDn7RC8xtlEUpZRZ0I3UvC7oJ11E6UNkED3Ag0=;
        b=gJeR9z2y0y26cyRt+KKymT/awpm8zdW9rO1ENo/EwronN6Q1t/uoNzZ5Pbc7G1l+lD
         cxe8FZdhz9RXaFvJrh66EZfPR8rTxrAreOiQvRqBEnhlaDv4CD5zbLmCq+e3Q/e37NYi
         QBm+zX+VuZwvEc6Ty7LoX1Rn8zdtyCtZ48SzOze5kRVDZXjgxmKwHDHaSRmkhJaQlJy4
         +V7liijZTfWPVRqskSPR9U93LbpAOGFmJTLdmKxlvMc5+Q80Tt6bCNlYwWLFnMiVTXRd
         T2D8Dz31uQp/9n1zbLoNuy6qlRor4lKuuPZlOc2PgeajTNPkf4zc37Ku856dBsy4z8nG
         nu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuz9R3pwbC2vW2eWblFYlij64dXZ9wExC2MWJ0f4A71dOVMJ/ypjynRrnjX6shob5mBx+WlZejxELf@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3sZHMf/1DcBxhgKh4TRxMqaEdJ1ECHj1lct1nluT7A6WoePT8
	iexD+6qWUYr5GXk4lqj3G6pkiPS5pt0gfCVmJY1o0PWB+gqyzSS/33T0499U83y0Umo=
X-Gm-Gg: AZuq6aJGyq9p7H0fQnmY29P1K6+qyNuFG8sUvEoxLTvJjGPMl8peAD9ZGjpHlT4WViQ
	jG5THAdFR0rYvOimuF9e8qIgTVs++rPTvnJVvIfXsmANThJvCsaaAw+zI8PJKzpGaxljh/OPVvr
	5JRAbjw5Kfc0Bi8wfG8s+WgUUpmt+oImdbfgpjvxLFPDGw/tsTeQ8lXrBYfJ9//RabmRaWV4IQ8
	Z/DkAVBfZZjRvpUVzbylfyPEwmybbOEh2M1bbyv1VLwKb6Fk/KoD3VGTSwzhfBzOi8h1vWAysM2
	Z6ChRdfRuvXXhANfzkJ2EaVJfR+Lyp03wXU0Kwvh7zTwiCGXUbI5iaeoceLCrLn7zowXu9GfCnh
	EQL4xH9kTskm4kT552BGEwDVdT6Ypycw9443Egr6JO6sxNH2c+F2cMphgETaHI6PqGn+FiNIK9O
	xBaYDb2cQswNd2teBcHqDjXRf5IbAF7tW7X13K5UkGtHk=
X-Received: by 2002:a05:693c:6082:b0:2ba:6b03:909b with SMTP id 5a478bee46e88-2ba6b0396abmr3523532eec.19.1770765955031;
        Tue, 10 Feb 2026 15:25:55 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2ba9dbe127dsm27213eec.11.2026.02.10.15.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 15:25:54 -0800 (PST)
Date: Tue, 10 Feb 2026 15:25:53 -0800
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
Message-ID: <20260210232553.GR3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-9-mkhalfella@purestorage.com>
 <05875e07-b908-425a-ba6f-5e060e03241e@gmail.com>
 <20260210222732.GQ3729-mkhalfella@purestorage.com>
 <5f3c9cf0-7fee-432a-b6c5-44fb2acb0b1d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3c9cf0-7fee-432a-b6c5-44fb2acb0b1d@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_152556_880980_52B34F6F 
X-CRM114-Status: GOOD (  32.31  )
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

On Tue 2026-02-10 14:49:15 -0800, James Smart wrote:
> On 2/10/2026 2:27 PM, Mohamed Khalfella wrote:
> > On Tue 2026-02-10 14:09:27 -0800, James Smart wrote:
> >> On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
> >> ...
> >>> +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> >>> +{
> >>> +	unsigned long deadline, now, timeout;
> >>> +	struct nvme_ctrl *sctrl;
> >>> +	u32 min_cntlid = 0;
> >>> +	int ret;
> >>> +
> >>> +	timeout = nvme_fence_timeout_ms(ictrl);
> >>> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> >>> +
> >>> +	now = jiffies;
> >>> +	deadline = now + msecs_to_jiffies(timeout);
> >>> +	while (time_before(now, deadline)) {
> >>
> >> Q: don't we have something to identify the controller's subsystem
> >> supports CCR before we starting selecting controllers and sending CCR ?
> >>
> >> I would think on older devices that don't support it we should be
> >> skipping this loop.   The loop could delay the Time-Based delay without
> >> any CCR.
> > 
> > I do not think we have something that identifies CCR support at
> > subsystem level. The spec defines CCRL at the controller level. The loop
> > should not that bad. nvme_find_ctrl_ccr() should return NULL if CCR is
> > not supported and nvme_fence_ctrl() will return immediately.
> > 
> >>
> >> -- james
> >>
> 
> I would think CCRL on the failed controller would be enough to assume 
> the subsystem supports it.

ictrl->ccr_limit is a good indication that subsystem supports CCR. I do
not think it is enough though. I say that for two reasons:

- May be this controller does not support CCR but others do on the same
  subsystem. There is nothing prevents subsystem from putting a cap of
  CCR at subsytem level.
- May be this controller supports CCR command but not now because all
  CCR slots are used now. This can happen in the case of cascading
  failure.

> 
> I'm not worried about the coding on the host is so bad. It's more the 
> multiple paths that must have cmds sent to them and getting error 
> responses for unknown cmds (should be responded to ok, but you never 
> know) as well as creating conditions for other errors where there will 
> be no return for it - e.g. other paths losing connectivity while the ccr 
> outstanding, etc. yes, they all have to work, but why bother adding 
> these flows to an old controller that would never do CCR ?

If nvme_find_ctrl_ccr() returns a source controller to use then we know
the controller supports CCR and does have an available slot to process
this CCR request. I do not see how this code will send CCR request to an
old controller that does not know about CCR command.

I am not fully opposed against using ictrl->ccr_limit to return early. I
do not see the need for it. If you feel strongly about it I can update
nvme_fence_ctrl() to do so.


