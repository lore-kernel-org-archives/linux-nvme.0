Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEBCEA794A
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 23:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UFXDmM2WsnEcrtt2/f8D7d2IPqt9PDasWFuSkn4PWxo=; b=W5ePSAXgOO6X/wDugUjVxc6eOG
	3EmW4e2KEmxKbgkCDfwCtWANdqiopiKWBv0s+HhxFCNBKB9+DxaLZnm28aaxIuqJrzEeE1Sw5dMc6
	GlLe644aBpAnOaoWFHCmZvAF7QotbvZzD1qJw4utp7PEgWnsYIeJWD2i5vMz8aZtaJrLvL6H6C1PU
	YGB8UwX+k9B6TKrh8wEGChe9lxrazEY8ZIqsL8bS0ySDDwdunTVSukoy3UflQdHOOr1Ajrexr4iOu
	KUnyL7UjCzbQRGE0xpCO6kOJQzgWfdHV4paG6wxKyCgJ89v16pzYMxWCWc0fNb1tx1SuqTmnhToz+
	1Tmoie1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnmF5-00000009BOR-1BSD;
	Wed, 04 Feb 2026 23:25:03 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnmF1-00000009BNg-2Zb3
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 23:25:01 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-124a1b4dd40so791058c88.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Feb 2026 15:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770247498; x=1770852298; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UFXDmM2WsnEcrtt2/f8D7d2IPqt9PDasWFuSkn4PWxo=;
        b=cBsCIRKpLFMaebFxLcUil4IYUleqr/1irwt1dbB0MsZSkeNM3YsjKjSNeFokZVcQLa
         whOj/fmsLBf2x5SnVaOabIAhuoDaPhPrO9kSE1VUUbIguEE7/zPuOdjEoijYcWdyk131
         cWgIjDXMJ7oDgCUn4wmrrza78kcJkmR48Ep2H2+zEUnaL+UYhS7+l8AuqXQjpXM6D4XJ
         ZbG1x8DHKPFt5rud8Hgq1XJUffd0Z5dcxV7HJc09tj6NDV0ycqkvGkbXaAQs37BLUD+i
         U6MIHmj/IYiDXiCacdJAerKv6GCcJYzBzi16OI/xYLvNpnbc4ZqBxnRMCb5GfKwUgBCG
         WcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770247498; x=1770852298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFXDmM2WsnEcrtt2/f8D7d2IPqt9PDasWFuSkn4PWxo=;
        b=KjqFiGOlR9LkVZu/+3x9pOBlJXYnvF8Jfvefr2YSGfOFMPuTJhdX0kG5J65SrReFU0
         AmC+kmri1hzjFY/TwVfN5Xe50lkGrggarghM8nu9UEHNGiATL9bFD2Z0uuwi7sNvP8tc
         V2cgF0dr8TdAFHzFxc+/Ey+M1wUFjm0zhbH6vtrX+POnnxyCqKJpZP96GwlZw3FeW4bM
         CinhF225b7Xwyw3VPOuP/eRLWf2QG5awqCyUgbqtep4MEbBYbhja/+Ubo1hB8TSVo/yZ
         5iuI5+tLunf0KJibQW0qoymak8NkuzQAZstHqbb/ctmsJNsnyDlJXgVZLsbLjUG4kC2K
         amMg==
X-Forwarded-Encrypted: i=1; AJvYcCUxP4e+T3NtRSbDIjp2TYfbxeXgJ/kFFHgWXtYy3wFosI9jeKG5T5mZHUm7RJGS1zei/loIa8NFrtkx@lists.infradead.org
X-Gm-Message-State: AOJu0YzGRDTbs6ZFJjjC+qnbyS0C6QtfRjgTnCVu8q5DHMxwJJhhINkY
	Y88f+h6eaO9Ey9u7Nhej0c6PGxgiRyflaU/m2z0Fkk9lde8xA6SnkkESRUAV8RLrpSSuyjh+r8b
	BEiLc
X-Gm-Gg: AZuq6aLzeJO5JabDUZl2CS4OkdZ8Py3v461GFdNptgbnjUm6YTVGaU3+5wT3derc+dx
	EvBa77ijKzrKXciFDhq5hQzHQ4EgWC2tNWU0jVHGrzgzd4RZLcwT0SmRBlPF4G2UvRtGQsteriJ
	y/H+RdCoUaz3VqlILJ+XLmsipuF2gsdTOGSYNFHXTCSl7eht0SpAuWsxI/TMTOMqkNR2L/6ozI2
	x3J2XzubmYPBD3sHvlHE0N6M2wIN+4Mkv4dM1UVpa926pV77wE8dLwspYTS44ds8xMtqKSetMku
	HPMt3Be2EHe89QCYs8ecmpbIp2HI3RU7Lms+QBAf5LA8OG4xPDptqUWCpCeObKY11LpQ9dyZHC4
	MUZWkvf/JSjwvne4Zu+SSWj19VIYRqkxzZsP7WmiiFz5wT408TAhgAN++UPwgzS4eqsu17ajx93
	cA9ChwarpzFDiEqeMD6RZ5C3BKu+WskMw=
X-Received: by 2002:a05:7022:6ba1:b0:11b:b064:f606 with SMTP id a92af1059eb24-126f47bb0afmr1925009c88.26.1770247497991;
        Wed, 04 Feb 2026 15:24:57 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-126f4e04297sm3040651c88.3.2026.02.04.15.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 15:24:57 -0800 (PST)
Date: Wed, 4 Feb 2026 15:24:56 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] nvme: Implement cross-controller reset recovery
Message-ID: <20260204232456.GM3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-9-mkhalfella@purestorage.com>
 <528a39a9-f087-461f-9f5b-c4b5821396b6@suse.de>
 <20260203200048.GE3729-mkhalfella@purestorage.com>
 <481562cd-0444-49db-8755-29436bec02de@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <481562cd-0444-49db-8755-29436bec02de@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_152459_800989_98600D8F 
X-CRM114-Status: GOOD (  33.90  )
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

On Wed 2026-02-04 02:10:48 +0100, Hannes Reinecke wrote:
> On 2/3/26 21:00, Mohamed Khalfella wrote:
> > On Tue 2026-02-03 06:19:51 +0100, Hannes Reinecke wrote:
> >> On 1/30/26 23:34, Mohamed Khalfella wrote:
> [ .. ]
> >>> +	timeout = nvme_fence_timeout_ms(ictrl);
> >>> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> >>> +
> >>> +	now = jiffies;
> >>> +	deadline = now + msecs_to_jiffies(timeout);
> >>> +	while (time_before(now, deadline)) {
> >>> +		sctrl = nvme_find_ctrl_ccr(ictrl, min_cntlid);
> >>> +		if (!sctrl) {
> >>> +			/* CCR failed, switch to time-based recovery */
> >>> +			return deadline - now;
> >>> +		}
> >>> +
> >>> +		ret = nvme_issue_wait_ccr(sctrl, ictrl);
> >>> +		if (!ret) {
> >>> +			dev_info(ictrl->device, "CCR succeeded using %s\n",
> >>> +				 dev_name(sctrl->device));
> >>> +			nvme_put_ctrl_ccr(sctrl);
> >>> +			return 0;
> >>> +		}
> >>> +
> >>> +		/* CCR failed, try another path */
> >>> +		min_cntlid = sctrl->cntlid + 1;
> >>> +		nvme_put_ctrl_ccr(sctrl);
> >>> +		now = jiffies;
> >>> +	}
> >>
> >> That will spin until 'deadline' is reached if 'nvme_issue_wait_ccr()'
> >> returns an error. _And_ if the CCR itself runs into a timeout we would
> >> never have tried another path (which could have succeeded).
> > 
> > True. We can do one thing at a time in CCR time budget. Either wait for
> > CCR to succeed or give up early and try another path. It is a trade off.
> > 
> Yes. But I guess my point here is that we should differentiate between
> 'CCR failed to be sent' and 'CCR completed with error'.
> The logic above treats both the same.
> 
> >>
> >> I'd rather rework this loop to open-code 'issue_and_wait()' in the loop,
> >> and only switch to the next controller if the submission of CCR failed.
> >> Once that is done we can 'just' wait for completion, as a failure there
> >> will be after KATO timeout anyway and any subsequent CCR would be pointless.
> > 
> > If I understood this correctly then we will stick with the first sctrl
> > that accepts the CCR command. We wait for CCR to complete and give up on
> > fencing ictrl if CCR operation fails or times out. Did I get this correctly?
> > 
> Yes.
> If a CCR could be send but the controller failed to process it something
> very odd is ongoing, and it's extremely questionable whether a CCR to
> another controller would be succeeding. That's why I would switch to the
> next available controller if we could not _send_ the CCR, but would
> rather wait for KATO if CCR processing returned an error.
> 
> But the main point is that CCR is a way to _shorten_ the interval
> (until KATO timeout) until we can start retrying commands.
> If the controller ran into an error during CCR processing chances
> are that quite some time has elapsed already, and we might as well
> wait for KATO instead of retrying with yet another CCR.

Got it. I updated the code to do that.

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

