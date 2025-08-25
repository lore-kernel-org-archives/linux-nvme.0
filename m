Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C06CA0FEE
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HBc+koNxzNYkLXGaE2HMu3UyvOdaSSN/vPguHG2JiMI=; b=hZ5N6YI1g2VghiokD9pNxc8Qz9
	7vmRhFfU2NIFx56NBEViCoTg3mG1XCrP4umK6lvFUQIIIlYHsrcDA3jlHZGPN+5jvAdAXyadLDI1v
	gy58ql+3mRdBwmWQNj6CyDL4U/Y5+mMVRdeT9AvFzwr2Q6a7IyeH3QLGDMLQtBeIAH723sYtUAHTo
	kwVfbmkldaEy/eayZ7wQ3+7oBuOcQx/h+95YUw2EEsazvgyyzvq81lVg/zwDwXczRB0kDVLrw5Yhb
	p5Jb0gFie4MGMfXACKGUkPyFWPnKA62bVq4gvCPH5GmbIc8lKWflZeN1H+9MzTeY+mNqcGvOu+yD4
	k6qmqXnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqYiq-00000008QZQ-1LRu;
	Mon, 25 Aug 2025 15:03:00 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqXY1-000000088km-41ae
	for linux-nvme@lists.infradead.org;
	Mon, 25 Aug 2025 13:47:47 +0000
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3e9812c8315so33374205ab.1
        for <linux-nvme@lists.infradead.org>; Mon, 25 Aug 2025 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756129665; x=1756734465; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBc+koNxzNYkLXGaE2HMu3UyvOdaSSN/vPguHG2JiMI=;
        b=YRLd9poKadwNMTTeQGoS6VT2YMvlV7UuJn3fTs/1Fpc+711ILl9Ua07zT+gToVRzOY
         HVQXcio0kMg8VjkmRTFV3M2fSX4G5JVyjnJHL7R8pb7ZlM1FhO1wLc0PFkuehdor6Ugq
         xTuttpVMyGE993usqNW+Lf79K+nAqF433DLoD3z/k4MYUy0EhS8aWfSU2LZ3vVNV3KGt
         xOJytisbW0yNJCKPI6B8BAjXB6GaPNSbb2cCJz0dW29vvMRRjRD1zG/dDButdKQPHnLq
         w5Hxl08VwPs/RYHNI4dBukUfN6ZeQ0nsQ+VZI9lU9S9TK/YooX8uQfso7wID0k5BiXvz
         XxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756129665; x=1756734465;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBc+koNxzNYkLXGaE2HMu3UyvOdaSSN/vPguHG2JiMI=;
        b=AcW6iPf39WUITGEH9yn/mX+6RN2OHE5HtTIo/qfnM2zcUi9dgVhKxzGacyb80DkGxn
         BncH44z/9ioQuw1A/I5j+Bb2sPrG8LCp60vYj3Bn5mv8x8W4MlLcjZgtb1aKxGSEOvyY
         y2tsgeZeTVRxVFncoQz88hgjC3Dkn0ntZ5eCCqPzaFnQBsErbZSRp/MsxQEn0HX7r6DL
         akjYSpQ0u7tYuB1UdV+rUsdz97UdE1USsqqz2r3lNKBOyKvKipQKuExMwtARLjtqR+jA
         4i9TZM4FL0KZMf3tFAODIZDHUJfqXbPvWirmM8x+xdNza8/KjQDoDQ+UWXJdXJuZ9tYb
         ypQw==
X-Forwarded-Encrypted: i=1; AJvYcCVoJKLmFtz4ilaAKUAKjCdrK5iyNiMWf5xKtfobF2rS3cmHVR+GsKnOu3jEXmlv7ib8nugy5o2KuYeD@lists.infradead.org
X-Gm-Message-State: AOJu0YyEKiHXN4A1bMyEN/jlNrrTpqGDoHRLlhMuBgk1O7JCOKRnbN3O
	Pe5zMeNlrqXyUCduHKbMuqDS+YlcGbsYjBeCCF8VgWbMX63CHrZRCA3GoKR9JhQPKNc=
X-Gm-Gg: ASbGncvxe1j2fJlOcTEwaS0iNBZRxFIj06qUXMyJv3Z3pPpDpEQZzoqVbhTM7gsuNyY
	0tjsfJLKccm16A2SpM2HmsfUlvMRMkpIVa1D3OE4PUtKpCWF7fbqMwAjQ8Q9sx9uJBbs0r5j4xo
	2YjC6BbhEn+axWM+UXXzl8Z5nxMkerqaZaPncqDTmZSOzwiOvCqx9MaiEX8y3AShyPHhTWZmqta
	/CPyrW/cZ8yQTbCrUQaba7H+FDTs3NyyEZ4SYIQNxVwuMfU8vnPh+xApHcN5AVKRpKUQ1/KnFXi
	EeG3LSyikFm6b5RN8FnMsRzDRyhih4pTkYbwAXiPKrFndBpUUmt12MOuHTjn4gTP3pDJl82uONh
	ENmiZbsGA9fyiYbPioaWN5aA6
X-Google-Smtp-Source: AGHT+IElh9Q/ZAIPGzrZLoacK3I57vtsTZr0FfqOvIqZ2YsoI3hlDMJrBjCesK4YwM4uPnK+wWiMTA==
X-Received: by 2002:a05:6e02:3309:b0:3eb:1211:8738 with SMTP id e9e14a558f8ab-3eb121187c5mr80555825ab.21.1756129664761;
        Mon, 25 Aug 2025 06:47:44 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3eb18693d2esm38348625ab.42.2025.08.25.06.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:47:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
Subject: Re: [PATCHv7 0/9] blk dma iter for integrity metadata
Message-Id: <175612966335.55174.17855813946100333153.b4-ty@kernel.dk>
Date: Mon, 25 Aug 2025 07:47:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_064746_238085_8E16265C 
X-CRM114-Status: UNSURE (   8.25  )
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


On Wed, 13 Aug 2025 08:31:44 -0700, Keith Busch wrote:
> Previous version:
> 
>   https://lore.kernel.org/linux-block/20250812135210.4172178-1-kbusch@meta.com/
> 
> Changes since v6 addressing review feeback from Christoph:
> 
>   - Moved the integrity sg conversion to its own patch
> 
> [...]

Applied, thanks!

[1/9] blk-mq-dma: create blk_map_iter type
      (no commit info)
[2/9] blk-mq-dma: provide the bio_vec array being iterated
      (no commit info)
[3/9] blk-mq-dma: require unmap caller provide p2p map type
      (no commit info)
[4/9] blk-mq: remove REQ_P2PDMA flag
      (no commit info)
[5/9] blk-mq-dma: move common dma start code to a helper
      (no commit info)
[6/9] blk-mq-dma: add scatter-less integrity data DMA mapping
      (no commit info)
[7/9] blk-integrity: use iterator for mapping sg
      (no commit info)
[8/9] nvme-pci: create common sgl unmapping helper
      (no commit info)
[9/9] nvme-pci: convert metadata mapping to dma iter
      (no commit info)

Best regards,
-- 
Jens Axboe




