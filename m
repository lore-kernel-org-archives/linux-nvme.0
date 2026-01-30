Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B38AE6BF3C
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GV7Voi0nrInsLXEq5RkNoDVzXZs64tJ1PAjrF2nT2jo=; b=UdO1iDTH3N7Cuplw+o81b1Lzm1
	7aI9hKEQU0rlG/7vcqC/BNQwOvK49jonu+X6hjmMLnaMyGbChqfQbkJJIVw+7978TWRBPrSb+GiSU
	bnYx21lEg41yq5v/1z/dAHSJizQMQJig5//YJ+bZcxWdr/a3nmWWDmVvarR/vufkvk2u5sYphUVR6
	gFjpmzm6oMNIgGjrQpAEXFaeR1fVX79WVA+OKT7ubxpxcws2sRxq56yY++nYOUrkHeI2UwQ7XxDEw
	2+9O7tJAPXc43sKH1XA0vUGsO0ed3j4m2RjCz2XpqqpqO5WN6mJKmXkDaF9DTsSCNaByvp9QiLmZz
	vKJYg6BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx2h-000000022SC-2Ei8;
	Fri, 30 Jan 2026 22:32:43 +0000
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx2e-000000022RC-0q2r
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:32:41 +0000
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-1233bc1117fso2471446c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812359; x=1770417159; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GV7Voi0nrInsLXEq5RkNoDVzXZs64tJ1PAjrF2nT2jo=;
        b=d27QTHQH9AOEJgxqMFQSkohz2FluI8vaGolfPvVQphH3WHtwdYXS4Hx80b5aQBXL3u
         u/WQIi+xgly62GNKfHxkKPLVAFvSIRseMlXy0SmdTOZyRvsjFOhREoJYnokX3Z0592q2
         u+zBcfNN/kaI8mWjJtpdxkjmXc8I8IoQtzoRtH1q8+tfShitl0dVpCFjxvErXpYX5wMc
         /9sdNZ4oyENG/ynZSMVIO33oyXWutYRniscLM4PBujw+x95qa7Tb48DiDRY5KnetrOo3
         JBvWCvCkQ6rdFOWkGsBNuZqukJPmGktnV+S4Zngb46wa2gffi3yep2Y2mRRrg9SfGt8R
         u4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812359; x=1770417159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV7Voi0nrInsLXEq5RkNoDVzXZs64tJ1PAjrF2nT2jo=;
        b=XHKSZfNlReSf9GMg31rn9T9VVDiSChb7M4epGqWowrcfaQDDxGABrb45zzsAF/wV7K
         5MZOMXRKlORggo/LrKWuqda/WEzUymredf7c0TRTk1WzhQCI01sT8LHMWI6o8VVnIEOY
         HKi/JYJ8ajjDzbKZCHUElMtxcFXFKa8aeH/DtSGVlGFxCju41RMyJdi0TFLuetx2tfH9
         gYl7l0F1V/aERtOpklTW1/IzXiuk+EUlTbAJWr+oQ6xsZ/fwoRDDcFZVSlxAi+ePQ852
         MqQb4vO+amUu2UKp+8GDlI3Emiujc5X3cuzHNyGqGvLo3pzKIkTz+Q9tr3aCJw949zRe
         9bLw==
X-Forwarded-Encrypted: i=1; AJvYcCXom+ZT1ML6efRLtpUJM6ynN1HBD46CB8t9j1VxM/IPQaeRq85r/7TwjmRPLsuLimQfIIuivxoKVRcs@lists.infradead.org
X-Gm-Message-State: AOJu0YxbGSmwElR//H8Xc0iBKdlU1es76fhsNnSEEnKeTfxejrGgkilE
	EWImd1AnIQwuplZNnf3Jv3WUwTJafvDAP7iEv5JXAObVosPuVopwsRoV2XzZN6mNrQE=
X-Gm-Gg: AZuq6aJ7o1zR7Gaqw2pRcRicFJ3v+FrLshAZXlgUic87E5nDY9KJNzXSwACWb6Yampq
	0JY7FtCGCskkjlTZ3x0ZhKggODnuO53xCT26M1n1u/aQdRfUbEUane5YYMMaX7hla8HDlIvVKTy
	c9usxC8SZP/yRCzCcionx5Pg1ASFOMtHPLD+eyBH5mAKABCKFk0jNYyuLyuwrdEKUQMdOFrbqsi
	gFA5HSr8/q27+Z/n1Th9ueLitR+1Gia8Xh7y9p3EYuHQJP4SxK/1/aJpfwDPseYQgX4wBWutcJJ
	MrBHDZ3Riq65IANgZZ6F2aUD4DyMkdhmvW6ESpSjvHcONLF6Q3s0pe1VExS71clMVroZxZXi2iO
	mFg4erx6gE9zvScE5+XzWEuECOXIW3/YYUwT8M2P6aAWq/2b7ktnLkUlNUjeQXtd/XV9wHlH4lN
	A+xfnDHIOvWjRCuJNaA21Ql9NAcoNSAP0=
X-Received: by 2002:a05:7022:4185:b0:119:e569:f872 with SMTP id a92af1059eb24-125c19ce46amr1704042c88.15.1769812359007;
        Fri, 30 Jan 2026 14:32:39 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-124a9cdcbcfsm14084353c88.0.2026.01.30.14.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:32:38 -0800 (PST)
Date: Fri, 30 Jan 2026 14:32:37 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 09/14] nvme: Implement cross-controller reset
 completion
Message-ID: <20260130223237.GG1710902-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-10-mkhalfella@purestorage.com>
 <9ac9b7c8-139f-48f9-bfd2-bfd03506abf0@grimberg.me>
 <20251231235136.GQ3864520-mkhalfella@purestorage.com>
 <14098277-cbcf-4397-bf72-f9cf1613789b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14098277-cbcf-4397-bf72-f9cf1613789b@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143240_237922_95FBB1FD 
X-CRM114-Status: GOOD (  12.93  )
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

On Sun 2026-01-04 23:15:53 +0200, Sagi Grimberg wrote:
> 
> 
> On 01/01/2026 1:51, Mohamed Khalfella wrote:
> > On Sat 2025-12-27 12:24:17 +0200, Sagi Grimberg wrote:
> >>> +	log = kmalloc(sizeof(*log), GFP_KERNEL);
> >>> +	if (!log)
> >>> +		return;
> >>> +
> >>> +	ret = nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
> >>> +			   0x00, log, sizeof(*log), 0);
> >>> +	if (ret)
> >>> +		goto out;
> >>> +
> >>> +	spin_lock_irqsave(&ctrl->lock, flags);
> >>> +	for (i = 0; i < le16_to_cpu(log->ne); i++) {
> >>> +		entry = &log->entries[i];
> >>> +		if (entry->ccrs == 0)	/* skip in progress entries */
> >>> +			continue;
> >> What does ccrs stand for?
> > Cross-Controller Reset Status
> >
> > 0x00 -> In Progress
> > 0x01 -> Success
> > 0x02 -> Failed
> > 0x03 - 0xff -> Reserved
> 
> Let's add it as a proper enumeration please.
> 

Done

