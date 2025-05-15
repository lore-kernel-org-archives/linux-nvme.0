Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F019C3ABC9
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mFVzz9p8nfztx5gF1nGVYeQVyOsEHOvOODmYxl6S9X0=; b=b/+JbPNESfJVAgrPauHmIzwnpF
	sVwA/99cIDtSuDTK5ohdNi7eDM0sIyD3xCrmTYgFtLoxULmaHmtruVXnCrZXdRVYRvLQ9uZw8Gdxl
	VXBBaB4/6MML8fIaa2DhM40p2J7GyfQQP+OFaYx2JneupYbflEcJ78cw/LXuOiD2e13xNwk+Nbsub
	7pqimwe/flPvx2tn++7/vCa3ATPQiq8M9mJh6x69IcQF+QBzOkeqEAaXUYfpftvRGhyAETQZD+tdu
	9pUGsg7tYLA1om3ku5OX7kyWkedPcZSxjGGgzR4ezbcbppP7RHjRAvl+brbXM0UzX3edQ5w1Yh+ql
	lzfKMLhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFbCl-00000001DJV-3i2f;
	Thu, 15 May 2025 16:13:07 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFb2H-00000001B2A-3Hys
	for linux-nvme@lists.infradead.org;
	Thu, 15 May 2025 16:02:18 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-30ac55f595fso1156643a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 15 May 2025 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747324937; x=1747929737; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mFVzz9p8nfztx5gF1nGVYeQVyOsEHOvOODmYxl6S9X0=;
        b=JdQXYEdLENVKASHWbg7lrMg3+onGpqc1f1CCrwsg8czHuSDGFS1xSxc5jzXeUN4mpp
         sPRqBjlZcglYx8G18S3tEJmaeMLP01YPy1Ub1YFHERJV5Z79KwCw2ElDzZKMspXQ2vgc
         9iWcUvFgFbDM4nl6TMIPhBIc9WQ6SFk7ngl2VQzYlDOvE0Q0OhqWl84I2RGN2CKTh5gc
         qlBJhGjwmTULOAiBq1JalHLk7HZQEnhj+1n+8FKnONK0FQ9cdLu0qYg+sBpUkJT+sl7Q
         LS+NgGOpLubI8BSKsoK1Ub5Di+/+x32CZm87CHSi4X1YH+kP7nDW5Pr4awrUxdnuhMxy
         V87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747324937; x=1747929737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFVzz9p8nfztx5gF1nGVYeQVyOsEHOvOODmYxl6S9X0=;
        b=XGk/9NZq38/G0nHT3+wKz8p8wrCK12C6YW3Kim1FcExo7/n2k31kNYRuTg37Tmfys0
         EuckmsHAclRNFMI1eYcp8F+/+G3ovT0OyjlmqOf6dwbyyIASUeDLIIPujAKGYRdGs22H
         hE8/+Wnn0+WbFRuMA073z1+OFyFkIJStmch9g7uA5KvnCLJRpQEyXdcAQcs5UaaM/jXt
         3msd/uicdKCgg31Fj8MmnuXNJ96AKQzD2t2JVRIDFxUG7MqU7W2NCBeBCjzP9nnbE4p6
         mDv9u0fmOdtcq7dYI+lEC0y8WKFI14a0bdEbqcx7s9Snc4YKIjZTh8Fy+i2LUTZjcW2u
         058g==
X-Forwarded-Encrypted: i=1; AJvYcCXMYFQ85S5FDhYgT5X0a1pQigDNpPxL+ln7sMa44Ih3RUxvKS6Rhep2QBeOuTuq7NSiyTd5n3iQOecC@lists.infradead.org
X-Gm-Message-State: AOJu0YzdJqaPH+xEbegpT2ds1XeGd0296BY5DDJ2C7eiLoFBJAlVf5wD
	43jcx+v2uuwA0oj0IXPpaRSY+pdxk3OM0G1YYCdB2KpPxfXCcJW5SOO8PzMvXmlT2djwgVSZXCg
	Xv8Vi3p+EyvTQDe4DP8eK6vA5JGU=
X-Gm-Gg: ASbGnctx4B4TD478IKXLEPGnGisI7KdEI6zka9Fl0GjcfoW+5I7TR2P4o467tpKvPve
	aQkMjIja+1RGmRegggjazObh1TLlJgW4bRpQ06YW6Hs1SAzCyREyeOsn2C/8m5yWmPHsBFOfEag
	wA4Z0eUFJRkDhAxRQuq1ckEO997M+VDKo=
X-Google-Smtp-Source: AGHT+IGDOIZGWOmD296FS3hkTixomDty6fSvG2HOiEQYrAsqxmtVUY12en+avv8fHmq7vb8xEgxioYdEU0tNiM7o0XI=
X-Received: by 2002:a17:90b:4c4a:b0:2fe:b9be:216 with SMTP id
 98e67ed59e1d1-30e2e642306mr10564212a91.31.1747324936572; Thu, 15 May 2025
 09:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <0250510102130.14710-1-amfernusus@gmail.com> <20250514151130.701885-1-amfernusus@gmail.com>
 <20250514151655.GA31705@lst.de>
In-Reply-To: <20250514151655.GA31705@lst.de>
From: Ilya Guterman <iliyagutermann@gmail.com>
Date: Fri, 16 May 2025 01:01:39 +0900
X-Gm-Features: AX0GCFuKsxJ3JOZQYgEyE26LSRAa6osFiGqWClik1JVAd51MntNf-f1eZAJLX9Q
Message-ID: <CAMraO693bYptEOA-bH-GH5drx8HJkqW-7a8652Gi1d=__pxavQ@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/nvme: Add quirks for device 025e:f1ac
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_090217_817099_D6DEE6CC 
X-CRM114-Status: UNSURE (   6.25  )
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

I appreciate it, Thank you.

