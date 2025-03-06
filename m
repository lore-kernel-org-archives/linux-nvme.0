Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83C2C282D1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=85jq1Q6VP5GwImlSpp7X1r/ay/vqE02iBEhuFPnO6PI=; b=TDGWwYVe4MrHDIdPxgZX2evDSk
	zqoDtr3RC0iO4T9tOUmY+DNCWyzMc6Km3Yr1F3C3PSTEYMeM7xnLSe4BAgLk9GNoPf2QYI4u47Wye
	CS5daK6Je+SaaSpUjz3PNcMKkrr/xolBSHAJydXaLNBJE91oixyeNqAqSKB2b98QBnuNVUHs4PBpm
	H2yh89r0Ijzm9Y18fjYHtY8JGURzI83IgPMAEPuSQbEZ6BAqQfYoiKjrir3XBFmh1zyj0/zQruCG7
	lL9+ouiJugO9npTx9EJf99NaOejl+kr8LoMtYxjbcu7C4OIrPwBnHHZLBtomgUFAlgV58g0P+biQb
	Gv7sL6Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqClJ-0000000BGkg-1Q7c;
	Thu, 06 Mar 2025 15:03:49 +0000
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqCjo-0000000BGXv-3FlT
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 15:02:18 +0000
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3d04932a36cso7174225ab.1
        for <linux-nvme@lists.infradead.org>; Thu, 06 Mar 2025 07:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741273336; x=1741878136; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85jq1Q6VP5GwImlSpp7X1r/ay/vqE02iBEhuFPnO6PI=;
        b=a/RqSm2VNeFaB8T8s+ET/0tSUpCtb7EGeQxrv7+1l3xFSYFd7PbRAFEKkIXdPpfEiR
         F8rpUbpxA9mWq1jCth69a5F/DS0IYlG8J+jWD09+fD1uvu4k++SGRND346D1wg1XAeH+
         3Yd72AoznZp2S6hzVRcX1mo6NpMeg4r9w6Fz4NscFzPBNHr5jLCYgfFssaqdkkjkFKel
         a2jTj+0XBIZM/8oXKC47/Bl5okv0FG8ZsL39slwwhC/wnUV59tAs8Zds+A9up+u2+l5s
         yGOi1BWL4bInjTOYcRx06CpJnZx+dLK+sv9vbQTf3ZTFlukwCdBPY/ZbkTaNiU9AdSMI
         7KgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741273336; x=1741878136;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85jq1Q6VP5GwImlSpp7X1r/ay/vqE02iBEhuFPnO6PI=;
        b=H2BaePfYkayvRSaoEbfpGTW85WVbD3PvKZmARjYDKO/9Thed4I5A0Xz4/v47IKXjbs
         NsTfUefmtRhRebgxCNaaJ/n3bSveGk/3sI03p3YvIp797tNqUnH25qc6b/+pMqzskR9k
         /qJza9gtyr8RJpK1lvc3RFE4bNyLzgNLYIAEeNPqS5lFKohYKsJUNYjQCgv+QPeqNdov
         pLXFr524DCCm9dn1KR7yAz5nBPDjaMDEdLwfwl+CjrGRYAiyIVtWsXQdQzdO1/OfylIl
         0QBDoPNJZcCRNrabXQNmGf/hb3O/qOWG8tbZuYoX++jXDs6lEHxHxSD3EVVW+t0BDpKU
         WUkA==
X-Forwarded-Encrypted: i=1; AJvYcCVuPg5iakcnG4PozdCOPinz7LIJVDIm7gXlm1jDmX6KERdvfRYabZ3ZZZC2v7KwTyldjAXEq0/HOQjp@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7jOjxaSuq9Z2lg40gMovY7iOEReTGKrzaIgAoRCtGd8Orx/4Y
	9mybuLYcuJan5dGUuRIln3zsd36SF6tYQCmHmPcHR5oFMRWkbEBMjYx1v3bofJWwB6/kQBBLwCk
	X
X-Gm-Gg: ASbGncv199D8WRPxK9FRJtxiyfFQLa6wpc0j/9u+yaWSCGmVSGQs8ttjoFEsRL5KVfY
	mqwSvaXWDZd4yKQuNVNMq3KzO3lo7Ovah+HFa0qobgJuhtK5G35K/ToGhFjL/KlQc5IB6GsdaUg
	Y9TpV7sKAMWrYkhK8vxb0W7TxD9EA8mS4kCPvrXp2QJgbiiRr/5K347/qktVGmLJbG2gM918kMJ
	ea5VOTfpLEo+cN03iupXqGpW3MqySryaGQjHVhI/y7zBJ/Q5iAO6crhaYQnUTgc0XXKj9Qmr8Qc
	bGaxhrDOryqsQsK2WRIQoAmrRGxfqd4HlzyF
X-Google-Smtp-Source: AGHT+IFLAobN1y/JaLFeXk9mcMrXNaETTC2QGpW5wyvCdzhLBlyXi27OPaIuZlvogV6xlSSS4u8ADg==
X-Received: by 2002:a05:6e02:1985:b0:3cf:bb6e:3065 with SMTP id e9e14a558f8ab-3d42b75767bmr95773635ab.0.1741273335734;
        Thu, 06 Mar 2025 07:02:15 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f20a06a6a7sm375874173.134.2025.03.06.07.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:02:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, martin.petersen@oracle.com, 
 Anuj Gupta <anuj20.g@samsung.com>
Cc: anuj1072538@gmail.com, nikh1092@linux.ibm.com, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 linux-scsi@vger.kernel.org, dm-devel@lists.linux.dev
In-Reply-To: <20250305063033.1813-1-anuj20.g@samsung.com>
References: <CGME20250305063900epcas5p38bb20587ccf4310cfb0f3307180eb536@epcas5p3.samsung.com>
 <20250305063033.1813-1-anuj20.g@samsung.com>
Subject: Re: [PATCH v3 0/2] Fix integrity sysfs reporting inconsistencies
Message-Id: <174127333427.62743.13850185317855218553.b4-ty@kernel.dk>
Date: Thu, 06 Mar 2025 08:02:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_070217_095524_C9ED7D04 
X-CRM114-Status: UNSURE (   6.51  )
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


On Wed, 05 Mar 2025 12:00:31 +0530, Anuj Gupta wrote:
> Patch 1: Ensures DM devices correctly propagate
> device_is_integrity_capable
> Patch 2: initialize nogenerate and noverify correctly
> 
> Changes since v2:
> Ensure that integrity capability gets propogated correctly for all cases
> in DM (hch)
> 
> [...]

Applied, thanks!

[1/2] block: ensure correct integrity capability propagation in stacked devices
      commit: 677e332e4885a17def5efa4788b6e725a737b63c
[2/2] block: Correctly initialize BLK_INTEGRITY_NOGENERATE and BLK_INTEGRITY_NOVERIFY
      commit: 85f72925000e924291a0ebf63d2234994a4f22bd

Best regards,
-- 
Jens Axboe




