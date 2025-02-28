Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0D8C19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 14:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wejv4BYNHQOXgDDBtI+W8fsgrcH5ND5AwtMfHnIPJBw=; b=ADFw2JVh9ucmauuS31Sx/733CF
	k9a7dPLVAd7EHu6nGgdtQBMUOJdvNXAkXSLwYP9B6ni6DEV43f49kSmi7aa9eIqR9MHaz/syfHw8E
	63WKk6EChjQRWyQy7IsDC1ZARiu5Rk0aSednqS3JiCyZa+TnDJFXfuxNev7z+0dP75sjauB7Kivze
	y9rIIk4abKwMmIsxEuuRptndEzbK7fLIo5Ab71nKhm+CobeoTdDdS56cAGOCbim+JRV/c5sqVBX2E
	tTgJksexatpfIizh7sxTb3ps103xVWTDcp3nLMQlu1YxfqsxPiIe3YkGoUTah7iczso7ruiYtYXFg
	z2wowM/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1to11f-0000000BBHZ-2n4T;
	Fri, 28 Feb 2025 14:07:39 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1to10J-0000000BAtK-2Xty
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 14:06:17 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2feae794508so2625532a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 28 Feb 2025 06:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740751575; x=1741356375; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wejv4BYNHQOXgDDBtI+W8fsgrcH5ND5AwtMfHnIPJBw=;
        b=wfoZ6j170rdBRzoHx0iQvlHbD664kE+iS83+XwD9/5rlJU71NjfTrqz6HSN2nZvCDK
         uvw/1Byy5tBmslJJY1Cwy2b3y6RlT8+cWOhTTpkYC3pYJRVXSwxYYW/eWdZRYJQ7ligW
         cHwN3ghd+duJTBqdoV9BXGe8NP8E52aZXsalg1+2cvw5viIt1KD9jPltIK1cvcyhkwJR
         x/OVghgCYcXASuy4lpuB+74YuhwzuYyWrA3xNECCYdWIjESlROuTyBKXdrT/inflDg0B
         B8diUK/n9kdIHP75d/nKs+gkSkRpHX1Mh1yLPLlgq3JmsXw5xyOsFjRtpALqn5QWqCub
         iE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751575; x=1741356375;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wejv4BYNHQOXgDDBtI+W8fsgrcH5ND5AwtMfHnIPJBw=;
        b=KuSKB27xgxp66wPg8/Uh/+jVBEGGR74RkgJLM6Lf4BmcP3fiZOww4yhxNqdiy5Icxp
         pFTbiw4zZ/pwgWwgNegEiwDHsyNmnVi7kf6etBIdGZo08tjPmpoOKb6/PNr3j0CfDNAs
         MwS7bpUgpLaFPldKXkfH9REk2bjRxTXqw706Q1n+WGhntFIww2OXLveyYniV9nBlBBsm
         nnld2bBZ+hhL23EbkiNq+B6BoX5t6OJP04y3xpd6YLwY9EbbAcxyVdb2kAAETaWm7vmr
         AnTfZn5XlC790SSUkHr+dC1+9s+E8bp9Byu8Dz2nh6zFjR1QW6NiKxNjU/bkd26I4oJD
         IKEQ==
X-Gm-Message-State: AOJu0YzTYyT3fYdTJoBEnQ3/ZmG4NNG45oZGf+AIo+JdBZlWGCS9QgYG
	rkCcDsZz5Ih7zcpAPoy8obqOxPqernPL4PdIqu8cFsc9/eiDnd0//ILaDjHRS+I=
X-Gm-Gg: ASbGncvVSLFB7qT4KDrHkOQskYxdWIq8d/04D+875BWyboOeIayg75Oslhyl/emaBAi
	PmX3MklT00+UL8PxcKShPsRHvzEA5K2bu6PvTsDLUBhoYWQPLApwo4S81b25godf7856uMoV2Ih
	pQr9GJcVsgrqZZ03KHKGb6evjfegZHlw2UIWhD9/Unsy1+ZqfkZBgAP85F9+fxUz9U4NjXOtNeP
	ei+oyk2krxGAb8Wn75zlckkAd0R+uk2rtNxLdyhR2K2laTHnb2gi7wYzsQMSMh6MQeUz6aOyY7f
	9c4QQxAOPFDMx6h5
X-Google-Smtp-Source: AGHT+IH8m6B9bONZtggc5TOaP8SNcq84OAlI7zJ06gGNTlOvv8IU6LI+DzSn+79wPg5Fd/r58sopOA==
X-Received: by 2002:a17:90b:4990:b0:2f9:cf97:56ac with SMTP id 98e67ed59e1d1-2febaa8b67fmr7061106a91.0.1740751574773;
        Fri, 28 Feb 2025 06:06:14 -0800 (PST)
Received: from [127.0.0.1] ([63.78.1.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5de5sm33062875ad.134.2025.02.28.06.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:06:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, asml.silence@gmail.com, 
 linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
 Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, csander@purestorage.com, 
 Keith Busch <kbusch@kernel.org>
In-Reply-To: <20250227223916.143006-1-kbusch@meta.com>
References: <20250227223916.143006-1-kbusch@meta.com>
Subject: Re: [PATCHv8 0/6] ublk zero copy support
Message-Id: <174075157357.2559329.8032266585029864578.b4-ty@kernel.dk>
Date: Fri, 28 Feb 2025 07:06:13 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_060615_918485_91D29C73 
X-CRM114-Status: UNSURE (   7.21  )
X-CRM114-Notice: Please train this message.
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


On Thu, 27 Feb 2025 14:39:10 -0800, Keith Busch wrote:
> This one completed liburing 'make runtests' successfully.
> 
> Changes from v7:
> 
>   Prep patch, mostly from Jens, that removes the "do_import" parameter
>   from the generic rw prep.
> 
> [...]

Applied, thanks!

[1/6] io_uring/rw: move buffer_select outside generic prep
      commit: 2a61e63891add7817e35a2323347ed8d354acf84
[2/6] io_uring/rw: move fixed buffer import to issue path
      commit: ff92d824d0b55e35ed2ee77021cbd2ed3e7ae7a2
[3/6] nvme: map uring_cmd data even if address is 0
      commit: 99fde895ff56ac2241e7b7b4566731d72f2fdaa7
[4/6] io_uring: add support for kernel registered bvecs
      commit: 27cb27b6d5ea401143ca3648983342bb820c4be9
[5/6] ublk: zc register/unregister bvec
      commit: 1f6540e2aabb7372e68223a3669019589c3e30ad
[6/6] io_uring: cache nodes and mapped buffers
      commit: ed9f3112a8a8f6e6919d3b9da2651fa302df7be3

Best regards,
-- 
Jens Axboe




