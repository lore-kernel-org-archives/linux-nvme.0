Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB4BD59D8F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 19:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=StTVbGf1mPsXgZZ3d28QJjsQQzKmymRGuXpSNQalBC0=; b=VRVH/1ELclC9VJ4BisIpP6Y4+/
	UpOz/g3rMsHynFa+2eYlNTXNWye4vsV6Vi0phQNq+tNEyfXY7YVLB0+Ww83+2z+NleKN+HdfJAFh9
	+42qi6+dugec9QdRUJCyde+1XqxE629RHNETZPBYxoGRkHgb2lwfXnrkUAoM2GgqOgyYFKedMCZa/
	eyWceT+9p+mncCati7123tYxtTR3eLr+1bhgq0qEij9krjtbNB0vx3xWfm5jx8UCa9jcRIedsVH8A
	qE7yl08uC5EqxbcRkWRHHC7rRcW1ztaOR14h3ujxOlwrw3OUn0+BEtFlzfnCQTgsiWdBUM5zVDGhj
	l/IF2KKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU8y2-00000000zrn-1Enf;
	Fri, 12 Dec 2025 19:38:18 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU8xh-00000000zq0-0Jjn
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 19:38:17 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so1636708a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 11:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765568276; x=1766173076; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StTVbGf1mPsXgZZ3d28QJjsQQzKmymRGuXpSNQalBC0=;
        b=gRgvg+3cBOCsCwTW1wRU3cUKIYO9FOYl0eaCOWxdG8EpZIScX/8JC1J8SOWpquAbq+
         sQvcZ8LjgMjAvgTYGxO0gyiK9lcoXgMrFjNWnHKW/8XOeHIZ6M59C8KqfhdWNCjo+Qtx
         2tCKCBxIaxS9pUpVKZM9/PWDvsUZDwrCwXSAp47Qhdn80KDiCFCz2eiNNwaVHpNbBxZ/
         tPUQZmaStKhXnbbmquhlSDYox9m7ihOVFz87XLxv7t9QW8CP0BEugB4QIffqm2KH9QUP
         Fdy5/qXPfQcJxQnCoRPHnDmgZgsUBOS7XHI9rzAcKIpSwKONReFvYzCADwOp6+LxKyc/
         b2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765568276; x=1766173076;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=StTVbGf1mPsXgZZ3d28QJjsQQzKmymRGuXpSNQalBC0=;
        b=Gj54TPDCubLHrnWffOhCe2ClZpI24yUG4K0I7z/fDxeewkI1b2acismgIUDJZllbQ4
         Fk0NRaZmp1R0gSkMHN2f0eGZEwXu/+2dZQIoeQEVKPYct3/4scMioUxxi7V09Z8vji2i
         CzizP+a0YFcnB6AQYr8iAnJk/O7mqjtPWHZsOoi0W9paJnvRyIdSlRe773OXr7F0zZXy
         wRIR7hdbndqxruIHKefiqyQ8LwM6OnRNWp33xk/JnY7XL0mCHLxkmuB/ui1i+2TPcQm7
         3qPGgEQd7u1HEKfNFe3rCkwgjjfuRSxA/dX6SYVs6lKkyvTCnt8v66utc2CyApinTpvd
         bHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUClYYcj25qQ3qLDzsesGOKEpzPdA9W4xqx+pmdrkkMsAUZylf/8xJOlm8Lm2+O33uNM+m+jLFt71yt@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/ZtokVO0i67lg8hLY5OAWB3J02oJHfZBgHCWoLuNwkydT83ei
	fT+72tJBNPzfqb2GsoR1dJxGU+JuMcsJTrKFXBp1f/N2aivTt+EllaGp0HwqaIV1+kg=
X-Gm-Gg: AY/fxX4l3jWDVgA7lBabo0ybJ7rIffIcM3HUS9i8oMeBs1Mr1eqPd4aq54XLGLDeFZG
	OyUDXbBH383nAoyPkkmoYjNQ2i/BhIJMUO2VJfS5HlX5VwgBn7S3jn/sqst7U7z/sgXtxo7aYxy
	DTMYi8CpPIj+rUVu1S9Dy0nflRux2VJC3hf052oEbdzQ8R6g2MEoOQXCko+MW5Jeg9b//7rVzFQ
	sVsOyYnhlQZF3w/BRU7UzU7B3bBy1cn/2rtqw0zq7Sw8zC0/UAXhJyVo9wS7hJZEEZ8AASEhYRF
	0THapDxFDhYruqHHRCB+8+gHzkWhFu3PXYKGFZ3TbvySbdzxHwJvlsWDhXeGViBRDs5tDeZ/E9f
	6pYFfHSCppSbQIIov1zrncOLQ4/O2fsE67Xcak/AQ4wKgJo6a0kZupnWR2F1KTtt4F3xkVWdtDR
	XYEzQM49+VF997vR9WWDB1o5NJlsR0SA1XBVAiXBhACk5JYK3DfLY9iKWp
X-Google-Smtp-Source: AGHT+IGRg2Nd8ny+lEY1UTB7dhC5oApF/NmRzRo0kswvAor/xhBJns1Qxh+lICHO2/Y0nRHD/a4u7Q==
X-Received: by 2002:a05:7022:e1c:b0:11e:354:32cb with SMTP id a92af1059eb24-11f34c39abemr3023356c88.49.1765568275584;
        Fri, 12 Dec 2025 11:37:55 -0800 (PST)
Received: from [127.0.0.1] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2b4867sm20294552c88.6.2025.12.12.11.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 11:37:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
 Pavel Begunkov <asml.silence@gmail.com>
Cc: Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
Subject: Re: (subset) [RFC v2 00/11] Add dmabuf read/write via io_uring
Message-Id: <176556827123.851918.9976241171726294701.b4-ty@kernel.dk>
Date: Fri, 12 Dec 2025 12:37:51 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_113757_361210_1235EA90 
X-CRM114-Status: GOOD (  12.01  )
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


On Sun, 23 Nov 2025 22:51:20 +0000, Pavel Begunkov wrote:
> Picking up the work on supporting dmabuf in the read/write path. There
> are two main changes. First, it doesn't pass a dma addresss directly by
> rather wraps it into an opaque structure, which is extended and
> understood by the target driver.
> 
> The second big change is support for dynamic attachments, which added a
> good part of complexity (see Patch 5). I kept the main machinery in nvme
> at first, but move_notify can ask to kill the dma mapping asynchronously,
> and any new IO would need to wait during submission, thus it was moved
> to blk-mq. That also introduced an extra callback layer b/w driver and
> blk-mq.
> 
> [...]

Applied, thanks!

[03/11] block: move around bio flagging helpers
        commit: d9f514d3e6ee48c34d70d637479b4c9384832d4f

Best regards,
-- 
Jens Axboe




