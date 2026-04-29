Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABECFF887E
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FOLuNiA/kfZwdLV9E2p8TNPc5d6B3zFK/DDHPjJ4Ciw=; b=ii9+uxVEsGmqLU5TUt5U63/Ahi
	XlVDOSArU9rw1qFkpqLEFyeR+IG+HinjH9hE6hLuyh0soXSPKo7GMsWxXqZ5wm2oEnPtW3vJaRdre
	esvWDGuW5B+mrWt9008HaED+i2ncnnzf8aibWoOFZeQXkOOH3QuucbltTg7rM5c5Pl5Hq3mLztriA
	EMKlhAWrqE2N6iRvArS/nwhw7iOROXcmNhqn3y0tpxWAuBZOxO1IjPAkQMF2RkKe7PNkRKjIk/+d9
	V7VULsmG9myzRQ+m3A1F4iz4hSqYb7dQO+vfcLftS50e/E27tA5XaGzMhH15JTJERCY9dSC7dN7+9
	XNIRjsjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6rc-00000003rS1-2SOx;
	Wed, 29 Apr 2026 15:30:12 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6ra-00000003rRT-0Umy
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 15:30:11 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-43d77f60944so9089235f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476608; x=1778081408; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOLuNiA/kfZwdLV9E2p8TNPc5d6B3zFK/DDHPjJ4Ciw=;
        b=MlFvAkcZu4TYvsBl+uwzN4rAHoIc+r6MJmjlpWaoKkxqE1fXycIB6ok/d34fOZmp7V
         i+TXZVlLvv2K02gYvPxe6hzquCG3ozXg8/XiDK3TuI0lF4jLfd5t5oSIkUmjLIAahpjI
         vO/4kvH+V8MCWmEAj1csUeX5PYV0JBmoQxeyF2x0ZbAVDWbEnOI6YHignK0JRCi5t06x
         Po1mAqrTdTlSMAIwRLlhUgtxZj0rnvXo2waMcnzqhjAuyGBT7I1KvhDW3v5FtdpJ7GK4
         pQPtqdbwGrGFPsdv4cjq1c2QkJKvFBVPYabHR37gxMq06wB5n9GIXiH5YPs0qLJj5Sjv
         rXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476608; x=1778081408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOLuNiA/kfZwdLV9E2p8TNPc5d6B3zFK/DDHPjJ4Ciw=;
        b=bK0feQwxyIohAt6TA/CBErObURd4QRJ3ZU7qV7tddXrY4INz9/1vBK0zn3tCB2NHOT
         QbA9a7+tCqy0lIVyYhqk9j1R4tLavAvnl/Toh3dFffM1U3xabs91LwFdXdMvUcCxTgug
         ki9YbflenzOBI8OMRfg5c8ei4O2tFUvCswh4zNdXJ0abeEtVY8T9x8Kf4IIAtat1F35x
         fQoh86ImxkzazRp7FAmuLtmv5Q32TqJIT0EyG2RydAMq57NxmZPzZ9rZiGuNpy9iofwJ
         wBH/6HwZc+sSuGxfBSzYjAQFBGO1mlccIaIs0ZIql/uSM5O0MXqsU5rE0LpuHyo7KgfY
         CfWA==
X-Forwarded-Encrypted: i=1; AFNElJ/7i2saDkjXFX/XAHL7L6oqpNRv05CPxEQY13wgGOakOGZnLx00ySrm8LxPOeOWy+PKcFO0VFCjiS+K@lists.infradead.org
X-Gm-Message-State: AOJu0YyZxWGBfh8euw+X3i6iA7GaO6IRhBKgyq7GQT2UElG/+qkzzamp
	82XaW4oDIbZXhkQyGZIPQwX39KxaTadoqGQ/qsaofczY80H/Ktb5NlvY
X-Gm-Gg: AeBDiev21rBGci91P71XMw9xr6Dizp4HYKDeuQPG2vUt9Ys2O/OHN6NCfvQ8c7acpAU
	tXteGd+Icin4iLe+XezxAl8k9e2JZD6qW/DosFk6Z+7kfk0zwjpv5x0bRYd2z9cr3Kqiz/EIJ9u
	CKQp8XkdfZgSefOyD8vHIdRNdDITDLnnXnscwEm+UaBzyCB0qFg0fi+lNB6A43uMkPLgKOThg34
	W2VGOMCdBQZfX2PemESle/sW2Zhyu7FKxdeiRUBVRkVL84BiB9g6JRsC/opl64+mmhY/C0tEMNg
	p7Pd0YNeHd6QJFb3hGmX7ZNIOf/UfvVXVzqCU4+YwEiAACiCnl9E/YBXuRt7BbNNhdTLOyKS08Q
	0CuhiE+hcgXq4v70azfYkcIgG3Ufz5Q2XXXn42BpGf+hZIhsizR11L0ue0hxYqRDPoO/LWs06Dz
	8HD7jfD4YnoXXeFi9Gpjm1j4rfqhmsjIZTObP2+vrqN9ZtG6BJDDBj2lcRmh2KOMwmGIFB50L7T
	8r4Zga92cGD9NZBZO9XIXwdmMyZujPAiqY/eBUwsQ==
X-Received: by 2002:a05:6000:4313:b0:43d:d037:d59c with SMTP id ffacd0b85a97d-4478eb81cf7mr7566713f8f.16.1777476607642;
        Wed, 29 Apr 2026 08:30:07 -0700 (PDT)
Received: from [10.228.209.141] ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d481fdsm6740381f8f.8.2026.04.29.08.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 08:30:07 -0700 (PDT)
Message-ID: <46bf2c04-72ab-48a2-a8e1-9f4423eb17a6@gmail.com>
Date: Wed, 29 Apr 2026 16:29:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi
 <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_083010_199024_F1CFFEAA 
X-CRM114-Status: UNSURE (   9.58  )
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

On 4/29/26 16:25, Pavel Begunkov wrote:
> Enable BIO_DMABUF_MAP backed requests. It creates a prp list for the
> dmabuf when it's mapped, which is then used to initialise requests.

I left nvme request / map setup as it was in Keith's work for the most
part (apart from rebases, adapting it, etc.). It appears I have some
use for prp lists, and I know Kanchan, Nitesh and Anuj already have some
patches adding sgl support and some other optimisations. Hopefully, I
addressed most all feedback from v2.

-- 
Pavel Begunkov


