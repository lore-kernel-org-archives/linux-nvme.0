Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A1ACAC5A0
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Sep 2025 12:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DrfUnZZt/eEE+c2HKV6AcescbyTYRdkE9YUmVIx7oP4=; b=BeaidVvUL53ZJXM2mN47UHBmQh
	rtod6OJ9BXhBOI712lbOppnU/G/krJn+0omU0nZg7nQX9tfmKigDznVfH8L7WBIVUkH3uix94QtEE
	PCuG1S2ljTlbItakfPfqfAVbB6EOozqKbv8vF4+t7ungjiBevyAaBg2lMiUNG9dQf5GJ4Qr27aV5h
	Q5Gj+8IpW57V3zADweADSHMsNRVydcCC2Wt68ZggZ3YqNwxY5NPa2oWzGPlJr0gd/DChk3myqx4tk
	BIMavZJmG0kGmHpaN4tjwy4ZZWrfp7Kqym4RM++iViVOmar5Ue5nbkNlUwXiZUNEffEXWGdD+b4bj
	jjDu1f/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzwgJ-00000005KMQ-3iiF;
	Sat, 20 Sep 2025 12:27:11 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzwgC-00000005KLT-30KC
	for linux-nvme@lists.infradead.org;
	Sat, 20 Sep 2025 12:27:06 +0000
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-890e5bb3100so66651639f.0
        for <linux-nvme@lists.infradead.org>; Sat, 20 Sep 2025 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758371223; x=1758976023; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrfUnZZt/eEE+c2HKV6AcescbyTYRdkE9YUmVIx7oP4=;
        b=Ngjh0inNtrYetedO0Kr8MGVA2XAVmx3xOquAVTjOuRFsK0ij8DQWItvTood151jurF
         k5hWX6oUlKClQ03B1Tb9VIfDpXrOpKhllj8iBBGEKGYzBUPrryo2GCfpDV6EAlN/T0f/
         qce7r/QGMTwywcmPikV/Y3awJ6RP8sYHCP+fxrePDb1Qga1ngRhwzXnvsmPrvw9HY2IL
         HWEq2ztMH2b11vqDFvh/4D7tF2kX4EG7kQSVGuHtflSBrG5fh3VoB4r1akJAukUQh5hw
         3YWmO6snjVSEAzsxh7rAT5fY8Q7qeEWmTUbUvp8zlNzJ/EF+eOMFQKzEKcZcRfxG70A2
         2TuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758371223; x=1758976023;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrfUnZZt/eEE+c2HKV6AcescbyTYRdkE9YUmVIx7oP4=;
        b=HQHllO/n3R/UzRhny84LicAS6NbrhQFU3hmHX+q1iAp174ehLyWXnupbzB9H2MjgBl
         G8pIq8kgO/bWMRcGsprzEao5wIOA8LbwA1WXYu9i9i+ZqwikccCYb+OG8TxdGPtYU2+x
         R8SlssYm6jMjQ7sffDrkt2+hrTtncwGX1gJBH0ohJAS4YBF0++2Vf6l1o9TBuPticT8Y
         74U8n0ntw7YxNY/e56fTCDq7QBNgIX4XE7JdBerKxbCmvQA1q06Ca9PLwXlak6nuYIm0
         gbqOQMwVGVAOvkwsdl1wpJPtA2Y/KWGjEHJHq3a14csutWOcRklRBQzxU132IujD9aqb
         G6ww==
X-Gm-Message-State: AOJu0YwjtjKTJg/7KYMvbmGVO1yUHw6cxhP81nwz5lEMY1u2xKqq3ohk
	5OMISCpJrEIdLF08lGdYaiRZOaWlYWQ+Rp2xmQSipT/wlWeCMF+wL73XWHgxyFCSviIm86YejXp
	g6GQ+
X-Gm-Gg: ASbGncuEWq53LEkClGKdvolXZ9SvScNf5k6wwjudoaaHBYlJuI8kjmZnR/7yxJUJRj5
	ZfCCnyHttm4n2NKD1fnaKOlKFTD698nPIdNcL+0eOX8yzIvcq9WzW3b0xJCVxE/l5ZxT5vUhxln
	RtRfH7AoXnMK95bMch9x8VRgz7/bRoxOoNnWn8l+qF9rx5kbtQGxk0Oi0sl0N7bjKXeyHRAi9RR
	qte1scR08SFgAtIsP8gRI+1olhS64Ac1svY2PMhDAYMLiyPhzsOmgUd4B3HOkv0CyCRbwuoTRE9
	DcflucMjkB4VCXkM9Z50nvwOl7aBH+tK8vxluWtJ2CvPldYZt1P8q08tlUCbwya+CjZiQzB98ZB
	8EwvtI6qra8RCFwY=
X-Google-Smtp-Source: AGHT+IH6PbeinWquegKHF83mRTyDVkSGqVhQ4ja3n6ihc8w60BH/rghaqqrTzmm+v4fm0MbhAmg2gA==
X-Received: by 2002:a05:6602:4887:b0:887:45ad:fcc6 with SMTP id ca18e2360f4ac-8ade617b11dmr1074725739f.15.1758371222963;
        Sat, 20 Sep 2025 05:27:02 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a480438b98sm265068339f.21.2025.09.20.05.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 05:27:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20250919193858.1542767-1-kbusch@meta.com>
References: <20250919193858.1542767-1-kbusch@meta.com>
Subject: Re: [PATCH] io_uring: fix nvme's 32b cqes on mixed cq
Message-Id: <175837122208.915180.3165699897517903214.b4-ty@kernel.dk>
Date: Sat, 20 Sep 2025 06:27:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_052704_993716_0B9484FC 
X-CRM114-Status: UNSURE (   8.45  )
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


On Fri, 19 Sep 2025 12:38:58 -0700, Keith Busch wrote:
> The nvme uring_cmd only uses 32b CQEs. If the ring uses a mixed CQ, then
> we need to make sure we flag the completion as a 32b CQE.
> 
> On the other hand, if nvme uring_cmd was using a dedicated 32b CQE, the
> posting was missing the extra memcpy because it only applied to bit CQEs
> on a mixed CQ.
> 
> [...]

Applied, thanks!

[1/1] io_uring: fix nvme's 32b cqes on mixed cq
      commit: 79525b51acc1c8e331ab47eb131a99f5370a76c2

Best regards,
-- 
Jens Axboe




