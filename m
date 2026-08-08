Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFE5C55174
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Aug 2026 07:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TtyMmNLD5kYHkR25F4J0okBlAhxZuviH4rvHbsosVac=; b=Btu7HXy06RhurmavqiiqHL/Fis
	rheZowYSnjsqIOf7Pe1eFbuBBgVB1Gjn5kzyGkr4OKklrQYVA153OKmmjIT7u6I7yKboxr50fZrGe
	Zj84vKkJMdrKJL1XcEFXQizDpGqicKmur2RfOPxEG7EtzLJwK3yn0ct4NiOT/1kwp3nrLbwmLjTEH
	h9qMgw1F/B+moybkFg1aUhxPQhWoser9b7yL/5/izHdiOkJZtIg6VY2RWD96TjzWVB+Kd3rA0pCGo
	UyQKFEWfZhHziA7qFffs5BQ+s1RVn4YWBLfI1wWCXFHHLcIztpXbo6BIV4ItGl87kajDvbCo7WpO7
	kNXyhzMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsbhz-000000098Vm-3PEY;
	Sat, 08 Aug 2026 07:43:07 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsbhw-000000098VR-46U2
	for linux-nvme@lists.infradead.org;
	Sat, 08 Aug 2026 07:43:06 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-38759bcd877so267005a91.2
        for <linux-nvme@lists.infradead.org>; Sat, 08 Aug 2026 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1786174983; x=1786779783; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TtyMmNLD5kYHkR25F4J0okBlAhxZuviH4rvHbsosVac=;
        b=ETLEuUg1ghFezi2WuLeIQPNmoctmtiT0TMpqua9hQiD7+O/gAQc750Y9IZ2j4Kuli0
         8BlqtUHAlqu+FjS/TR2RhyR02CORJqv+cwhEDTip8Hj9v3JTsgCzqitcgJsLdekuknCX
         y87Ch3T0kBGNuLbiXPxNgalv82ToqZ+0RzbqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786174983; x=1786779783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TtyMmNLD5kYHkR25F4J0okBlAhxZuviH4rvHbsosVac=;
        b=cS1tGUU6EVwCPteA0QPrNMvVTq1b+a+MD+JiEhD9Is/CSmgv9s/7zfP4sjAgt6IRHD
         6dkhKfrfl5Jqo0qrmL+Ih9nlnu6o0+5r6t/bZKVXtakE7e7iLmv8kobe6lZXM1/zpKOF
         DgilM9VNYg8Py+MQQw1cABajB0Tg8s6PxrFRbYGdtaFex1aznxStKbEqWgb0fbGaJyfe
         vDIDTSIVcwLi8Z55nkgTQZwgi2GqboYTWrJvLFx4w1oggHApIJ5ZGDMw1BysaVgTpRdi
         OvLpo0VGxnU0VYZXihkuFlHughTWYtdBNNrx6btJUryeIscUaFTyYmu4yy7TZc5ol5jG
         knZw==
X-Forwarded-Encrypted: i=1; AHgh+RoxXbcewY0HjdXDEFNXgPb3oS/SXC4/dn78aXHmulGlE80NNWt66qzwkidhrTowm/Xq80UfmQOSgSOH@lists.infradead.org
X-Gm-Message-State: AOJu0YxxbrLVhMZHZOlWrq1wzsWAAwUjIrnDRxvDNuyd2o1ZcFm3bMag
	Bp8NdGVG9sRDDQpaFUSn5xQ1l/K84fdFuXVV26vx/M6YYE55Puk46S0kJ1rW7KAg2cU=
X-Gm-Gg: AR+sD125rW3ff0ixoU7ZS9tLiR6RmlshMGYcuKrYG0mAdtg7qGnZv7LKtB8ICvn9bsJ
	gvSLR0dD1XiiI1kydxHtsP52J18tbqCJTGKBXD2iqksBqYEE8Nsq/TOLReZACKXfGZK9obOeqyz
	Wq+okHmKlbaWUjoju8r+TbBqLGhjop/IcnCT1wLv2wBYLpoblwojP4rXvrDfn6zirFcEuPfnd8T
	wp7pG5I+Y2t7Yls0G0che9/ffRTmNA2QYOpwOuTBx0MM0sAASoI6ZGaRV9GmWgSOQGvCZZQTRkX
	nYCax+ZtmbsQU7Sywgx5zFSmlV50rnwtB5VB+f+fIVFboad9Tgy+KDXlP0PAzic8xRyzgNRBCJq
	PLSY6/sNqCMIhlpHD/QcWJ7QQxElRibR3pp1R7/HcdpNmaWc6X8t3RxxbyolKlU6hVJKqTWvpob
	KrPHWRx+b9VIttvdP2Vmd+s04qfjqxX2/aY8+tQUm6UQilfM5pHUiSO7KjakbBL9fquFcEyN17K
	E/3KfcZVRRgfg5PkWs=
X-Received: by 2002:a17:90b:4f4c:b0:380:540:d499 with SMTP id 98e67ed59e1d1-3903c5381e3mr26493795a91.6.1786174983338;
        Sat, 08 Aug 2026 00:43:03 -0700 (PDT)
Received: from localhost.localdomain ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39086164982sm7523449a91.16.2026.08.08.00.42.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 00:43:02 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	nj.shetty@samsung.com,
	joshi.k@samsung.com,
	anuj20.g@samsung.com,
	tushar.gohad@intel.com,
	william.power@intel.com,
	phil.cayton@intel.com,
	jgg@nvidia.com
Subject: Re: [PATCH v5 01/16] dma-buf: introduce initial file I/O infrastructure
Date: Sat,  8 Aug 2026 16:42:27 +0900
Message-ID: <20260808074245.85757-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <ff5dccf71e8c03d62797352c4bb5fbb7c6c759c8.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com> <ff5dccf71e8c03d62797352c4bb5fbb7c6c759c8.1785596451.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260808_004305_033262_1379E84B 
X-CRM114-Status: UNSURE (   7.14  )
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

On 8/1/26 16:46, Pavel Begunkov wrote:
> +	if (dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
> +				  true, 0) < 0) {
> +		dma_resv_unlock(dmabuf->resv);
> +		goto retry;
> +	}

Shouldn't this be <= 0? With a zero timeout dma_resv_wait_timeout()
returns 0 for a still pending fence; only -ERESTARTSYS is negative.

Thanks,
Sidong

