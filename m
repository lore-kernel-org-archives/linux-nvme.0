Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12992C83F1B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jul 2025 13:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/juseajL28aExOR0ncFEkgamJFYX4aY2BgbPyJWuRxo=; b=w9rklL5su4KJLBqPNCH2AAqn+S
	iN7Dgo+UjYXDdDBH6TKXRNJbuR4jSdb5GPdH1ZzUEpS3mygUSZ1eHdG66iODpDRClR0jBm4Pcuv3j
	sGKzEF8ls7FIw3B4TcqJ8zw4FGRH0uhn8RUswFWZ/Ptp2POFFf4vER5ymFTZilALU6ivIf29rA6C5
	62OxCD7iwB1/RJzgBMg9U/1dTmShfrOXUSOQkNBW6qkpjZQU9oynHzad7mEcIv3+02sUR6F4vE5zl
	ycT6RlnXGJDY/DTWx75xTdi9LuSta31jbEdcqfi6NkTjF7I1TzFY2DiseQHCehk/jN7nDjoSZDOC/
	v2eyhr8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaEBj-0000000ExdF-1ZWz;
	Fri, 11 Jul 2025 13:53:19 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaE5G-0000000EwXq-381h
	for linux-nvme@lists.infradead.org;
	Fri, 11 Jul 2025 13:46:39 +0000
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-879502274cfso70982139f.0
        for <linux-nvme@lists.infradead.org>; Fri, 11 Jul 2025 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752241597; x=1752846397; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/juseajL28aExOR0ncFEkgamJFYX4aY2BgbPyJWuRxo=;
        b=3Gxt+KGKRZlUrliPMbffZTDJp9sgTAd6/Jwfhk77TYkkvcCUo3/11HimXbqVUgOVu6
         vIVKyl29Vrgj+hjvxNTXInr7i6Wni5y+g5S2h3FVDthfvVwZ+F4v3u7wtgJDwtRgZgyz
         GwW6ae8nVHODHVayCO0I5teJh9ORyiZfzP2bknaeyUhPGpEC6seLg5kruBlv3VGF0lcI
         yno4dsZVNLeaF2mG1UVXIvREWMdztoc7UI9Bn5t81s7Q99X89KlzgSUlcZqEkjegnFgn
         rPno8QGU80VN4wPR0w9df1XGltcOfO8kYGubTyy8GakSotmwPM9Y7xhdF1sUXQBv95+B
         yGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241597; x=1752846397;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/juseajL28aExOR0ncFEkgamJFYX4aY2BgbPyJWuRxo=;
        b=HSO0rfAvdwobeX4XqQCQQ7d6ysFfdOecj28DwNxXqUalYPhIX6w+WwO5S8lU/kH6XK
         V5M9bhD6lu6BFASjSDMBej9OCbv/SgjO/Y0qIWQDgdQcsdLQrb39Iug4/XJO6idd/ePY
         8F/afC4X/As9o4jLdkdQ688rue+gYiMam+uXdigFSZ1efmqiZCTOkQzh/dr03pEFpR8x
         xdoYw+yzib3HuUOSGpL5eNDV41xukWzbSzJlFwoE3thOa5YWHfXhilb9jD+UUgpT1+Sf
         2WKWe+MilBnBG7eHOy5UpaTt+UNZorf50E/Uca0UFKs/JEhgVCnsHtFA26U7g7f+X+QP
         dUew==
X-Forwarded-Encrypted: i=1; AJvYcCXAIEO05ImoB0H8Rtii7nxuip7qcFMDqjQOGm6cT0nD53J0NKt+bqJHAQUBkFJD9btn5o2NQkDHfVEb@lists.infradead.org
X-Gm-Message-State: AOJu0YwWsJ35dZQEjg4JQiCby8HGXEtDeSnFR07N9UxFzesdER07gRi3
	CWEWJ6F9pVZ3PGrhkMrUB/6Z2Lx2go5UQISogJNqXW7oZ7bHlsgLnMYc1uNovBT3hKUvqMDFraR
	D8GIc
X-Gm-Gg: ASbGncvIn/bOfZwC1QzOAGaJ2ZxHIz4Uz+3Njm8dRws8HYBx/WEs1aWnauM9rna1mgl
	VCdKIgvo/1DMm3chnD6co8B6slt2L0kkpFIgZNnfscDG5pKXfoXx8O56eymMYEbDB274CeG3Pp7
	oeRp5ZLhm1yXTvSx2toVenwTw43eZOyTXormnamzlHeoI5eGqOVvh1OTjQraHD7F2vD8M5AgYeg
	S+y5K3fGWyzD4kZ16K5b1qqy0pwEJxFIKiwEuLRgj6z7cgi3+A04fWKfdLYrCGhGKaptJKLcBTz
	0w6x5yRZVrRVEfNJlHKldWju2CihCf7KpXwr6SmoCqoPLi5oFTfs/G1pp5Q416jai3ImjiTnXRG
	Hyaa1/ypn/pCsIw==
X-Google-Smtp-Source: AGHT+IHC39aaGhMdGdrpBQXoGqq43BIWcV2gT087/3qAkm55jq0BVsD9zJu4zapauSL4z+v7y+zNpw==
X-Received: by 2002:a05:6602:3fcc:b0:875:dcde:77a9 with SMTP id ca18e2360f4ac-87977fbe295mr457592739f.14.1752241597239;
        Fri, 11 Jul 2025 06:46:37 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8796b79fe4bsm97569039f.0.2025.07.11.06.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 06:46:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org, Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20250711112250.633269-1-hch@lst.de>
References: <20250711112250.633269-1-hch@lst.de>
Subject: Re: [PATCH] nvme-pci: don't allocate dma_vec for IOVA mappings
Message-Id: <175224159635.1454175.11115661661587383197.b4-ty@kernel.dk>
Date: Fri, 11 Jul 2025 07:46:36 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250711_064638_786369_5F16E0F0 
X-CRM114-Status: UNSURE (   8.09  )
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


On Fri, 11 Jul 2025 13:22:50 +0200, Christoph Hellwig wrote:
> Not only do IOVA mappings no need the separate dma_vec tracking, it
> also won't free it and thus leak the allocations.
> 
> 

Applied, thanks!

[1/1] nvme-pci: don't allocate dma_vec for IOVA mappings
      commit: 1bb94ff5ab4be2485884e0a46483f12629f3bb92

Best regards,
-- 
Jens Axboe




