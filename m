Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B695AEF99FD
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 03:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4z7I9/cOjKpEZZ3/JySSx+yHMUVTI86sF9dh2MgV87Q=; b=Dyn1Gk3sXPZ6QlCslIdfFtv9ye
	zkaSxmNuyYoocewDR66Y/tw2uL9o/00m20o88dFBTZVT4FMFAuvHGXgoHh0ARqRr+7lKQrwFYFB7G
	ggpsAnVpdChb7s1ExPmKB2Ry5LibONlCYqQ2ijiwTIWRAP98ODcsQ5ALf5OL2VPXFLkPNwjiTyyK2
	xTkHnNR72eGPIgqexHb6NxgR3RBsv2vWubMVf+x2RriqosFg6WoTbmavfwdFslw1+lu2/M68whGdj
	u5esXlKlbdoogayMru81blOtQlnEwEDS8pLbLlwD7lNZGZ79Y+oPyjrnPX4bFwEoNUWdHRFC2qyTx
	0HXJVWVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr6mG-00000004DfG-45p3;
	Sat, 14 Feb 2026 03:57:04 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr6m9-00000004Dev-2EPU
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 03:56:59 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-127423bea4bso823513c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 19:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771041416; x=1771646216; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4z7I9/cOjKpEZZ3/JySSx+yHMUVTI86sF9dh2MgV87Q=;
        b=aVBH8B3EYNGb7ydaBVl435/vNb+DbcvDlOOLYd5dYPYmyfTdE32vnnrOFVE39W9SQr
         TowhQC8sUFbNHJ+XML05u4MgGBOnD5X62Avr28UG6C1Ed1KHDHQU5xvLYyXhiqC/19SM
         ezADaUEc0M+p4rosvFuFBoVjFBpQnO8HzE//A6jizQ8mD8O7r4nrnwK+TtoPSIH6KIN0
         uxKE8h6PpTkhyPL8UgWkVU1yEXd6OiDNX3mVCgchrXtz657uv8QdNuWmLfZIPfnHZVbr
         4WY8uAPVqcuxJqNRFcsEoK9rsDkrxLnNWfXnT4YYExenji+Eu2JmxJmztuUMlDENkGXr
         2f8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771041416; x=1771646216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4z7I9/cOjKpEZZ3/JySSx+yHMUVTI86sF9dh2MgV87Q=;
        b=TOh/paeLvwdqT40ascNFrPk6Ctgi4TQD2cHKFyhBzmP6r7YUnn4N896tXgBqzzqCOK
         x5WmIzUIjPgkUv0xryVHVFwCh/3P2hDpC5nxju3IHslV8NvY60HNVI/aD/pim1NPp62c
         W23Q6cx0Vh34M3YF5qKKfdnByv/MbveZx00j294CKVAba50NshaWYELUrG73WjbVBmAw
         M+8EI7U9kuDB/3MimdC8Z6jKgA4vPj0rJ7arDUILRUDg15Xo+gbPCNKlxk+YvszsfRCJ
         24N2bkA3jbGpZwTCIXtgCts4BmxJlAY4Vrh5TbL04EnfJvB4o9nROqB1K/xE8bqo1GUa
         u5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoWXcphCwF+hcBRPLjcr9bvkKAPklcegK0/bCGSp5UajgMxZS3LlxpvAg1VwYSnO9zQS0hTUMPSutk@lists.infradead.org
X-Gm-Message-State: AOJu0YyAzDZyGGsGIEQGWYlYhGPNF1yS5xqlazzP/CAGQ0k5vxRt0KYL
	aFrz+6xoWesmjrh0LRj4me7ti8s8gXis4eo5LNpne01jsIjg8MlXvsxue18oynPxJNU=
X-Gm-Gg: AZuq6aL1ULanrxPDu/y6+juG0aIJotXVUJagL/VdOvmaec+e4K2q9AfAI8mPRxfL1og
	j0GrqD5Qhuf72G4Vr3ee9fztJZrsrkDbHt4lab8H3COfSack+vvbKcRnTQtWBfS5JvpIWbslQRL
	gyOginLeD00u/q3Tmk/TD4L+QOlrFZviybpSbHESyWj1wjav+7JIoCBmbClnLzzYzfOo0qp0ce1
	I4gqs0XQJc+z6K87K0JKQyZmtLI9bUj9fS29xrFpm0j4rf0XC9x6k7DfH98amJTtiMyZWPyBzfb
	A8fE+Ws5JxEqnXWAh5daU32/gvOnUM3J7Uy0OKyKVgdRzY0uf8KIj77W06BJOuBXLhbr1YEf+Wg
	wqCN5pcvzuhKdAzzKSBqmehJxsU3r+WE+wpTjA1mDOC7fefl9G0u6tT/nIVpF/Ty9cN1r+m0SJv
	TjMDw6oC8n8AhRdhIzEcONb+S3TGAg1yURsasQqy66fiE=
X-Received: by 2002:a05:7022:f102:b0:124:acc6:6dd1 with SMTP id a92af1059eb24-1273ae8185bmr1982067c88.46.1771041415787;
        Fri, 13 Feb 2026 19:56:55 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-12742b62455sm1018488c88.1.2026.02.13.19.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 19:56:55 -0800 (PST)
Date: Fri, 13 Feb 2026 19:56:54 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Randy Jennings <randyj@purestorage.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Aaron Dailey <adailey@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] nvmet: Rapid Path Failure Recovery set
 controller identify fields
Message-ID: <20260214035654.GC3435530-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-2-mkhalfella@purestorage.com>
 <59a8d510-d06d-4d35-b911-c758c184df52@suse.de>
 <20260203181457.GA3729-mkhalfella@purestorage.com>
 <b695a3f5-bfb9-4215-9672-47abf7e35cdf@suse.de>
 <35ae10c9-808a-4882-86dc-311b23c821e5@grimberg.me>
 <CAPpK+O3Uus03zmuqif++5fMVDdXXLiUxOwxdbixRyfkhMTJ5NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpK+O3Uus03zmuqif++5fMVDdXXLiUxOwxdbixRyfkhMTJ5NA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_195657_748353_B57CA68D 
X-CRM114-Status: GOOD (  26.59  )
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

On Fri 2026-02-13 16:42:55 -0800, Randy Jennings wrote:
> On Sat, Feb 7, 2026 at 5:41 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > > Precisely my point. If CQT defaults to zero no delay will be inserted,
> > > but we _still_ have CCR handling. Just proving that both really are
> > > independent on each other. Hence I would prefer to have two patchsets.
> >
> > Agreed. I think it would be cleaner to review each separately. the CCR
> > can be based
> > on top of the CQT patchset, for simplicity.
> >
> Hannes, I have some concerns about structuring the CQT patches
> separate from the CCR patches.
> 
> We are trying to fix the Ghost Write data corruption, and this has
> been a long process (involving 3 modifications to the spec and a
> number of proposed patch sets).  We’ve already been told (explicitly
> and implicitly) that CCR is the more interesting solution (a
> euphemism) for solving this data corruption.  I have some concern
> that, if  separated, the CCR patches will get accepted without the CQT
> patches.
> 
> CCR does not work in all cases, so I do not see them as independent as
> you are saying here. Also, CQT is a natural time cap on the retries
> needed for CCR to handle CCR retries when it cannot succeed down some
> paths.  When used as a time cap, CQT fits well with the CCR changes.
> 
> I am concerned that it will be more complicated to review the CQT
> changes, with at least more patches to review.

True. It results in more patches to review. However, I think it is
easier to see the delay added by CQT after the it has pulled pulled into
separate set of patches.

> 
> Structuring the patches with CQT first and CCR second would take care
> of many of these concerns.
> 
> Sincerely,
> Randy Jennings

