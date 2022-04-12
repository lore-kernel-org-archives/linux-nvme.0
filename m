Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFECDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 22:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UTSp/G8zwV18QcS++FuQzWULt0VtGmmOqsMfzG5ErkA=; b=4uUdcbcMpkIqEM+trIBFAA/Q0b
	BPwhh9xZsCzdcMH7h+46g1Imu25hL5sGt6VP/aHzj6c4cEuY/A8Zh2Yi45pu+jZ6uB9uEQr8XBYur
	8S13/YK/mwfmy8MkjOemvlP5HK5QdinYYTPbu5LdZlruRsh6q8HQZCPlO/q7fM0oAgorTdFIq7Ylu
	b17ueYezeAcEnljuFjr/HD9ayDmf1lpaLMMXjvYng8Ow14EwoVozQP9AcaXjs1e8jfRzmHJagtgie
	VrPHAQvSAlrKmxOI00TcUGIR/UUTlvNzHb3P4ZgisieNCxoPKWKbLAIlKBX+qc/u5a2KUvx53yBqS
	SF6qeMzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neP3P-00FyXh-4Z; Tue, 12 Apr 2022 22:32:07 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neP3K-00FyXM-W4
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 22:32:04 +0000
Received: by mail-pf1-x42a.google.com with SMTP id a21so289643pfv.10
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=UTSp/G8zwV18QcS++FuQzWULt0VtGmmOqsMfzG5ErkA=;
 b=2u8RZR5Z/ycl0/rlZlTpBfbAQMR7bXJ9y/kQiA4x/saJN2+hoVZnRddqJRcYY7lb2v
 Bjodb+LUw3QTYFHpteR0dVcP6+jjnQlsCS2yVTUPgAvAxhQH75k3PFMoYpY6TcXVJXKy
 JudGJnkgu6CrhOQLuBs8YxpJVIjKnGliYLhm3kWUrWEIfz+27mq+rL0MLrS8sbQXWZrI
 TM3hM45jKo3JLLTbPZWOzw4mttlmyYdOIXO71hIow4aJYgK5BDO+uhK9qlDEA1o4UzPc
 MC44eMEGnQEArcYYjgJJcZcNJr56zFC6KsUykNSU1QOvOTGRE6FBdf8bZjZO/OGZ7EQ4
 tqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=UTSp/G8zwV18QcS++FuQzWULt0VtGmmOqsMfzG5ErkA=;
 b=fl6nwuk3vqnelFOz/PYxPdMuclNfnwVhvflSf2SPBhFidha7kKw3gE5y5NWMdclyym
 /xOwI6yilFWUHzuf6QmxfdS9hfQTnqRPIu3kjw+TtyPxyxeAtVMzmvwFMUt+uFzfb612
 YuvrDDun3Nz6BtbrPHl4KPbJzgTz7SWmUHubeFJ9FfuybYxqSNEP6L+r+plaAB7lV9LO
 Vp/PARQgAJSCqOFfFPggoBh7LwvucyVSWL4rJgrKbyey/Ys8+5Kgn+DDYZg4GJY/03wL
 kqC8i7l1oCd2AufjEoyLZ94u7e+dCtRU8+fXYKJbCDjbfJRtKC7BWs1fHpZP1npOrqkl
 hAQA==
X-Gm-Message-State: AOAM531uYY31q1phfysS1PQERQ+z5wigsLmmTU+BcdqKBuA50YtaTCJn
 lzY/7MDhPjaHe+mQOWKygo3ZJQ==
X-Google-Smtp-Source: ABdhPJxfJJwMFnMw12ISX69ykkGJykL+olL9K1M/959vnjtHTUaLHqNf2JTnUA5fym5wfUqCsaxWhQ==
X-Received: by 2002:a65:6a07:0:b0:39d:8c35:426b with SMTP id
 m7-20020a656a07000000b0039d8c35426bmr5415538pgu.171.1649802720473; 
 Tue, 12 Apr 2022 15:32:00 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157]) by smtp.gmail.com with ESMTPSA id
 x6-20020a17090aa38600b001ca2f87d271sm535902pjp.15.2022.04.12.15.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Apr 2022 15:31:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: alobakin@pm.me, linux-crypto@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: bvanassche@acm.org, linux-kernel@vger.kernel.org, kch@nvidia.com,
 kbusch@kernel.org, Christoph Hellwig <hch@lst.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org,
 martin.petersen@oracle.com, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20220412215220.75677-1-alobakin@pm.me>
References: <20220412215220.75677-1-alobakin@pm.me>
Subject: Re: [PATCH RESEND] asm-generic: fix __get_unaligned_be48() on 32 bit
 platforms
Message-Id: <164980271890.301666.4533609890818235558.b4-ty@kernel.dk>
Date: Tue, 12 Apr 2022 16:31:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_153203_290009_F81A4FEB 
X-CRM114-Status: GOOD (  10.13  )
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

On Tue, 12 Apr 2022 21:59:16 +0000, Alexander Lobakin wrote:
> While testing the new macros for working with 48 bit containers,
> I faced a weird problem:
> 
> 32 + 16: 0x2ef6e8da 0x79e60000
> 48: 0xffffe8da + 0x79e60000
> 
> All the bits starting from the 32nd were getting 1d in 9/10 cases.
> The debug showed:
> 
> [...]

Applied, thanks!

[1/1] asm-generic: fix __get_unaligned_be48() on 32 bit platforms
      commit: b97687527be85a55e12804c98745c5619eadcc32

Best regards,
-- 
Jens Axboe



