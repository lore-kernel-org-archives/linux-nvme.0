Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E8FC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 09:50:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 302BC206B5
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 09:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pyq+ZU9v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="1dqfVxQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302BC206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=u8UzWLy8c+6L1niTZEITMATk9TkPMQa1DPxeG0MH/VE=; b=Pyq+ZU9v0hHNAsBHyz3gT6lVx
	UolWC0mT5plxxeLorjoJdefoaSieiENClWcRujkj0LWWvWtXkS4p9zSB550orI/azLzeWTjfhOntt
	edpMmBdTwst35488rJSIoy8t2f53CfWOrrYb9d9Gd3FL1B/HbJg5/UFAtn0gbuset6feSw8mmpJUH
	XLTpBhQuIe9SxAqydL1CRk1M46UuxWS0i2NA5QF38quYf853b1LtndN4sgMYThj8jrjEzTW4sp+aK
	zW439FMctzaueLhjwweu+inFY1YSSJ9KvT1FzijJgdzu44b9//+DfXM+jLP6hqOWxclSr2g6d5CgG
	8cWehs78Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7yGQ-0007zh-9i; Tue, 18 Aug 2020 09:50:42 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7yGN-0007y4-AQ
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 09:50:40 +0000
Received: by mail-wm1-x343.google.com with SMTP id f18so14995531wmc.0
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 02:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=i5vDKEZg30AIs6a0nWYqfPKaiEsU3ewP/cuwaplcd5Y=;
 b=1dqfVxQFClI+zfejIh1qTvSsngHFLaKqPtzKLGLjelw3bC2aQD6QKBit3dijblXqri
 4qIVwFR71xk25st/eAJvzncev4uETStFXHoVK9U48yYtee49fWBR/bl4kYMNejbhNhQ4
 epGdb7Ih3XcfLxQKGu5WwJK6MitmuZtqC+aF/TbPUuLbq9//Flfs148+xhXZ0ONP6UdI
 4e2WW1d28D7iKP6tqaCTR+bku4ZUdrbOt9+wFwU02wM4f7QcWnU3mPSBsCB2qKR1kcaB
 La+Em2GybOQoR5kWGO4FflyNc/VDvPuM98HdRfBPIOBwY+JA4XqOzOIsUmI0/G9wMLzs
 kMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i5vDKEZg30AIs6a0nWYqfPKaiEsU3ewP/cuwaplcd5Y=;
 b=VW2myb6BXC++ituNhURa6CWGBlE7KTN7CDlFCPhjR0dfO2+/JKuScOh8Vfbjk7XO4m
 yK33tohfJubLJTA4lthQAt5iRIgYfl29RrMYt0aJ8Jnaksa0r8fCFwOF00TNs3Iz8iCG
 ob93adbIcZfLllImTmjFLor143qlaQFJ45Qt1s6wzC20crVLsJvvds7o42PnTeUtq9Ru
 JjSotPdXwqBuDD7DtQBa6jrf9BKX2iYjNVN6XiXTCTtmmtNMooiV1kewpyGTkjEA3vEC
 h98YzKkihhfgFWdOKdgUa3W/C0LmVMCiTRHlzNyYRbKIhprU0PEyrZ2+H5oPOlEI5Lph
 v6tw==
X-Gm-Message-State: AOAM53221BK+9QQ2kHA1NLAb2oJX/FG6sSDUjHISyrC5aEEB1b6WKox4
 N85QVCaravXYSd8m7HyEx9oqdQ==
X-Google-Smtp-Source: ABdhPJwXe/4xueqeRf0J9LQvvAsnSGSbxMv4RuMbhh6K4fVUIj613NFz/q+cokvNq9g37PMJmlJj9A==
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr19576673wmf.49.1597744235584; 
 Tue, 18 Aug 2020 02:50:35 -0700 (PDT)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id p3sm31479709wma.44.2020.08.18.02.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 02:50:34 -0700 (PDT)
From: Javier Gonzalez <javier@javigon.com>
X-Google-Original-From: Javier Gonzalez <javier.gonz@samsung.com>
Date: Tue, 18 Aug 2020 11:50:33 +0200
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818071249.GB2544@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_055039_506740_C4824628 
X-CRM114-Status: GOOD (  16.58  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, johannes.thumshirn@wdc.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 18.08.2020 09:12, Christoph Hellwig wrote:
>On Tue, Aug 18, 2020 at 10:59:36AM +0530, Kanchan Joshi wrote:
>> If drive does not support zone-append natively, enable emulation using
>> regular write.
>> Make emulated zone-append cmd write-lock the zone, preventing
>> concurrent append/write on the same zone.
>
>I really don't think we should add this.  ZNS and the Linux support
>were all designed with Zone Append in mind, and then your company did
>the nastiest possible move violating the normal NVMe procedures to make
>it optional.  But that doesn't change the fact the Linux should keep
>requiring it, especially with the amount of code added here and how it
>hooks in the fast path.

I understand that the NVMe process was agitated and that the current ZNS
implementation in Linux relies in append support from the device
perspective. However, the current TP does allow for not implementing
append, and a number of customers are requiring the use of normal
writes, which we want to support.

During the initial patch review we discussed this and we agreed that the
block layer is designed for append on zone devices, and that for the
foreseeable future this was not going to change. We therefore took the
feedback and followed a similar approach as in the SCSI driver for
implementing append emulation.

We are happy to do more characterization on the impact of these hooks in
the non-zoned hast path and eventually changing the approach if this
proves to be a problem. Our thought is to isolate any potential
performance degradation to the zoned path using the emulation (we do not
see any ATM).

Do you have any early suggestion on how you this patch should look like
to be upstreamable?

Javier

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
