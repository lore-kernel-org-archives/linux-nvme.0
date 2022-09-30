Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A24C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 14:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KE/La02ogRQIY/HzxSEopjUhIfT01GVed+k6zu427FM=; b=3+6qZ42G77GLkEaVHt9nbwqa6s
	c5WOyzw24qa2pGuiKiNw/2BJPHEz1Oka/DA8mVp8tQNylV0wwv1ZkzMfKO3effhXqKQX6pPPd+l5Z
	0KCCxtKXYWmXrVowkXaQQy7rjyL8TQMvXbeJctbbYESaly4OhPXR4FfBpBKKx/Vs769Z0Le5yShnl
	g4wMa4+3/77xJykBj3UsAR3d3kLDvhKut/XIb+rCJX2qmLgqwaJznE6z4CazSZxmi7lSdyViE5z1K
	jgryYSnk7wI/NtxF2U1pD92L21k9uACXLZ5WB5GLoWSXiTqsdxNB/zsZadUOHjqcFJaCd8NkQ30dv
	kraZIDlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeGxW-009k9c-MQ; Fri, 30 Sep 2022 14:25:46 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeGdV-009YEb-Pq
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 14:05:08 +0000
Received: by mail-io1-xd2f.google.com with SMTP id 138so3312384iou.9
        for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=KE/La02ogRQIY/HzxSEopjUhIfT01GVed+k6zu427FM=;
        b=eTSscY00rOLUJHWuFQyJIl59dQGpUSoWvHHwSfNnFKA4Lw44WSKU49+jZTWN47Jnf5
         55R/FwWHdwkFedGF7J3APM2KsySrM9JgactJUB3aSET9yPsj9KVjVwyT4ZLrz+OD+KKV
         AhfLWzDGtUjoMr5OXEttfZYzZDT4hj0bjxzcqlI1syLfAFm+CjXjGbkI72jZhUIib47a
         TiVeQlPuyIFn+ebZpyH/8DYCExfqdWWWzDillNjOUNcotehAMdGUndCvUHfH4w0GpLJq
         ughRo26e9JqrBgCkOHoGxXOjnjLv3PQ8AiiKFqEgltASsaQc8z5EH/ExdZCSOWlOJt00
         kMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KE/La02ogRQIY/HzxSEopjUhIfT01GVed+k6zu427FM=;
        b=q3B/tfR3E6PLV5bLUhQxBgzMnoBqtM7AcY0z6l7yX2mgk8N3+uEKAjEPsIzdu/i/y5
         KTfI3dKdj2KsSUinIZuECNZIfSmppcAfFZWv23xCMUzBJh2CXPZ/c+sUldVSmgpE+BDl
         26Q5sljHxseUdtCG9BLrYWuwkgH921CQppU2oZp5Bx5Vl116QDVAt0HvFKRiJVUPkpNe
         sDXRl374wLtQ+LoCv+fZKYwqroz+rxhSE37GNZh6w2/1hmmrYssAW3thE7dxbU0f2bjO
         FztIU85q7yd3/F1aC+QvESdIs+vGmAvCInmdC3lLIlj8L9sJ44PP5/6EW9gmzbnwgTtC
         SiAQ==
X-Gm-Message-State: ACrzQf0Jq1erZJKMTcToOnM8XdsZaI1tuivtZtRAEi8PaeWoKUgZnSLT
	ElJ5AFgIXO9JHMh0SrOw7UGoRQ==
X-Google-Smtp-Source: AMsMyM4JtLxVJcRSJ6Gida3IQoin845TBOh5Ewp8EzEnzwL947qn7d3mtbmSE+hpAqBx4RR26Cvc1w==
X-Received: by 2002:a05:6638:1449:b0:35a:70ce:8a3f with SMTP id l9-20020a056638144900b0035a70ce8a3fmr4631148jad.42.1664546700214;
        Fri, 30 Sep 2022 07:05:00 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y4-20020a027304000000b00349d2d52f6asm963095jab.37.2022.09.30.07.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:04:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, Anuj Gupta <anuj20.g@samsung.com>, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org
In-Reply-To: <20220930062749.152261-1-anuj20.g@samsung.com>
References: <CGME20220930063754epcas5p2aff33c952032713a39604388eacda910@epcas5p2.samsung.com>
 <20220930062749.152261-1-anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v12 00/12] Fixed-buffer for uring-cmd/passthru
Message-Id: <166454669913.10664.15099234392865928285.b4-ty@kernel.dk>
Date: Fri, 30 Sep 2022 08:04:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_070505_912918_E270B8FA 
X-CRM114-Status: UNSURE (   9.09  )
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

On Fri, 30 Sep 2022 11:57:37 +0530, Anuj Gupta wrote:
> uring-cmd lacks the ability to leverage the pre-registered buffers.
> This series adds that support in uring-cmd, and plumbs nvme passthrough
> to work with it.
> Patches 3 - 5 carve out a block helper and scsi, nvme then use it to
> avoid duplication of code.
> Patch 6 and 7 contains a bunch of general nvme cleanups, which got added
> along the iterations.
> 
> [...]

Applied, thanks!

[01/12] io_uring: add io_uring_cmd_import_fixed
        commit: a9216fac3ed8819cbbda5d39dd5fcaa43dfd35d8
[02/12] io_uring: introduce fixed buffer support for io_uring_cmd
        commit: 9cda70f622cdcf049521a9c2886e5fd8a90a0591
[03/12] block: add blk_rq_map_user_io
        commit: 557654025df5706785d395558244890dc4b2c875
[04/12] scsi: Use blk_rq_map_user_io helper
        commit: 6732932c836a4313f471b92b4d90761f31d3fa81
[05/12] nvme: Use blk_rq_map_user_io helper
        commit: 7f05635764390d5f811971af9f4c89b794032c80
[06/12] nvme: refactor nvme_add_user_metadata
        commit: 38c0ddab7b93daa90c046d0b9064a34fb0e586e5
[07/12] nvme: refactor nvme_alloc_request
        commit: 470e900c8036ff1aafeb5f06f3cb7a375a081399
[08/12] block: rename bio_map_put to blk_mq_map_bio_put
        commit: 32f1c71b15fc9cb8e964c3d0c15ca99a70cfe8a7
[09/12] block: factor out blk_rq_map_bio_alloc helper
        commit: ab89e8e7ca526ca04baaad2aa28172d336425d67
[10/12] block: extend functionality to map bvec iterator
        commit: 37987547932c89f15f9b76950040131ddb591a8b
[11/12] nvme: pass ubuffer as an integer
        commit: 4d174486820e625fa85bac5d4235d4b4cb659866
[12/12] nvme: wire up fixed buffer support for nvme passthrough
        commit: 23fd22e55b767be9c31fda57205afb2023cd6aad

Best regards,
-- 
Jens Axboe



