Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2738BC8303C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tz+3g8Gk738iBxfQpYL75vI8bUAIduK+IwHHVtiU6pk=; b=xmyUQ5AbbdcIQAhAfgNl3TvLoj
	KbYheQwrSPdQR+Ekl/hgqbXgPHr7/NWPfW35LdRzHRxteO30wjHLp78KjL84OmLOQ51NSMLaNW4bf
	S0zDa5rpCKhAiFm6sOk8eGvzyYnJ/+SCxttgkRUMq8Ka7hD7Z0WKMf+kEUVqiFXtVIfhPj8COK6Ci
	USqevsLf8L02n7gJNAbSnV8QKDi9FvFCqWG0I7bMwoAPlB2LMc/mZgGitw/XMpDcH5hzgj6RN5VRb
	uLr2oKpGmocydVHl1ZHju4HvVDkh2fyLvVy9LvXgluJ9PO9/r1cVk4e+QxMErF9GWLxXItua7ffch
	WeT32Gdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ7vH-00000005Lyn-1M6y;
	Tue, 08 Jul 2025 12:59:47 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ7r1-00000005LLi-0pKG
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 12:55:24 +0000
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-86d029e2bdeso184297139f.1
        for <linux-nvme@lists.infradead.org>; Tue, 08 Jul 2025 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751979322; x=1752584122; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz+3g8Gk738iBxfQpYL75vI8bUAIduK+IwHHVtiU6pk=;
        b=xLxMhowbWgx3EgSjjaAOtI/eK0z0Nfl1HVL0/l4CWsgxzPvIls3dkxVaRJvpP3Ll6P
         FBVVHhg2nbUpF+EGjR2FyUBO5G23GZHb8b4JxfRARI66XrRWgexbQhPlDrSrMqYKTMtb
         mzKPyPYpGkl0kCRxXb1Om/sFuapO737ulS4xu/neCFY5nz6KjUftI6GNqNfgtAyjD0qy
         viC37mpCk+ol68uRoetY2HY3HfmTDh2NYT46xDIr1eKfduBN8WujeGWlV3tLIgMiy95g
         o6qw9uX/dPQZ1M/SDUU1mLVtMG3/S+rv5rCuuSPLZeMxRgmn7rbqGG6zQvMxAeT9Xvj8
         JBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751979322; x=1752584122;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tz+3g8Gk738iBxfQpYL75vI8bUAIduK+IwHHVtiU6pk=;
        b=SdrTW//jfGhGDH+IMUMjidtkagg+XsJpEcWtVXLeHp/0NnUHBGXtpLuPf3o1EL2q7C
         H92WBXl7Hyw/uFeiVzt03qs0ivsOtBGKjM3i1Cd5Dh6M51KuEcUTRlFNYWazcK1FXnIG
         ScqcFRIMR92FZdO8kAV2hQanxy6ve37CauZhH3gedGpbOGbo8B/czq590Ijsb2YzTWj5
         RuOJiirc1FAfvATEcTfoc9g7yRMhCE646//2jvjQ1Ug5qceYzjQOoqbTdgacSK90hOwZ
         augRBEoGlRKgQD97uNBgndoVHvLbcqrsSufdxCfJiDvla2vmrrCA/uHtbdSYl6Snx/K0
         +amQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHgTjYBpdoTYnlF90+0TQpCfnf/ie/sR7f4vP+NKZ9DznGiC3vpLzn2hK9sdtyr9xptLtGNBvYbN46@lists.infradead.org
X-Gm-Message-State: AOJu0YwyLNZFNl0Re2QwntaLlva3q10EDqEpU45WOoKobKdAYTuN+Jrv
	8pFJ2nb9mboMlcM3wrpGctpUQ99kvc0hUigqDWIaPsr0oEgoJI0WeupAZoDFSRiAz+Y=
X-Gm-Gg: ASbGnctdE+sZJnfwwS8yp/U0iDQgH/wJwjdkEuYVSKy+h9QqDv0FwmWPkcb6gO9hCli
	JiAY7VaTua7QJdUnt3vkmqMYx+U0Yy8cQfyBy5lv9Dqd6hJaVrhfrB83z/sA0gAHRK7+7iYYDqK
	eBSG7uzMhkRVrqrCOMOK4kiu8OirpFK2Po5uldG94V297Xcr/FNIxug+6BM6rjSdTqmbD/78wO/
	0cK0aPx6EP/YPlO7a/tSQKSfnl9QwVyDygbZBruDEHT50jmp7Uo1N6hR7GWmAUgt5Ci6KxKuklg
	zGiie04vwIq5mkoHkDZh+TILGSbpvPR5Vo6VjTM6/e7RLeb96Nqpgg==
X-Google-Smtp-Source: AGHT+IHHn2y2EQ9dCWVmGRtV4imCt3ZhSYyqOZi1I3uvvpjvD3LZWZEaCWognCUlw5l1BMS8tkglJg==
X-Received: by 2002:a05:6e02:1a47:b0:3dd:bb60:4600 with SMTP id e9e14a558f8ab-3e154fcddfemr24652925ab.5.1751979321972;
        Tue, 08 Jul 2025 05:55:21 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e0fe221071sm32286865ab.44.2025.07.08.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 05:55:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, sagi@grimberg.me, Christoph Hellwig <hch@lst.de>
Cc: ben.copeland@linaro.org, leon@kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
In-Reply-To: <20250707125223.3022531-1-hch@lst.de>
References: <20250707125223.3022531-1-hch@lst.de>
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-Id: <175197932094.1079793.8874503109418666370.b4-ty@kernel.dk>
Date: Tue, 08 Jul 2025 06:55:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_055523_477641_0914AEAC 
X-CRM114-Status: GOOD (  13.58  )
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


On Mon, 07 Jul 2025 14:52:23 +0200, Christoph Hellwig wrote:
> The current version of the blk_rq_dma_map support in nvme-pci tries to
> reconstruct the DMA mappings from the on the wire descriptors if they
> are needed for unmapping.  While this is not the case for the direct
> mapping fast path and the IOVA path, it is needed for the non-IOVA slow
> path, e.g. when using the interconnect is not dma coherent, when using
> swiotlb bounce buffering, or a IOMMU mapping that can't coalesce.
> 
> [...]

Applied, thanks!

[1/1] nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping
      commit: b8b7570a7ec872f2a27b775c4f8710ca8a357adf

Best regards,
-- 
Jens Axboe




