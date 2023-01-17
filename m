Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498FCC3DA78
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 17:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D5DIPHY/njq2wIS08dD2d3rKYvkfcqoz4OTAbEpZhhU=; b=a2c1NhSLkC0RDBhmdbx1+JIuWU
	Xnsoxj8qY2RH/+XVXqle1kldrEXvaRWublN6otsuIMgV4NH0S8JMMsP6nMUYhOmuZL03tJ2KfDvYW
	JHpUuOmqMPn4nDX5NtyKEXXbg8K1fu4XiVz3GuMJREIopjMUQeHpUKC4qclPnL/o0wZ19F5MZH/1s
	3zsZVcLOJzDW0nlT8R8EW/MFU4kRVnWpr08rToxl6WKh5gP3b+vxcLNKsbcDmBRi3sXGLJGKEe8cs
	yJ9wHO8Wv2QoaPviEPBjgOwk9casPUUhUXR6R4aRLHSVYmGCfbOyBpZsISgY61Kw4p5LIOFSrCZkJ
	qGgE9l3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHpfx-00FFHV-Ib; Tue, 17 Jan 2023 17:23:09 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHpfu-00FFGc-Pk
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 17:23:08 +0000
Received: by mail-io1-xd34.google.com with SMTP id y69so688007iof.3
        for <linux-nvme@lists.infradead.org>; Tue, 17 Jan 2023 09:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5DIPHY/njq2wIS08dD2d3rKYvkfcqoz4OTAbEpZhhU=;
        b=AEdTGsUVnxiZSN2T+ib6yVx8rOwEB75qn738SFJoSgzISngltLKD3QzUbBR1zyifU/
         3SVCS45Ef7Cjr+cQas7BL+rKwMtbYwYDg63AcwWYXJOV7dslrWe4ZeAcUFOdgTXVNTc+
         UCjioy2h9dItUaDItwKsmD8Po49JAeZPzhbxQY3jvQlcF+oZUAajjRAZCbQzw2245WJO
         Ty2QKJHn5fSTjoBL95sArlMRecK+rkTXq/4AG4bcPGbArlvv6uM43aP2xC+on33I/4Se
         gdo/duoUP/6iyoNaQVcrAbjLUWqrg3+C43/tDQ5AKbeJHulNQycE+KYJnshDYIZc08HW
         YxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5DIPHY/njq2wIS08dD2d3rKYvkfcqoz4OTAbEpZhhU=;
        b=tNIWOKOaOVXny5L39XWDgQ6HqFVL7cJvFLkzj/CkeQ1v3AOPTtD8JlN34faFFKO0b/
         LAuH/CGHfxtl7D59jZ+pMgQSJWLyi+ofupe+srQWfsnE2fhzClfQd8pAU6LPKuZYPnkN
         G3keRa6eOfoZHR7YVPBzUE36Ye1U93WpM33cAQTrqdhnXyEHGJc6vzuA1i6aoJcbPlEf
         hKgoZ9c+GUyMxH5jbyZjuQTZuEW+wUsdLyLnp1Ha+Zobj/6UPHbEHNN3ywKPwwz5ivnW
         JaloPKn0EwPy3Pc5H2edP7okCZcZbn0bbpNFCsP4R5Qg7haGPw1q7u7ICOrvOUXHB6gM
         OAkw==
X-Gm-Message-State: AFqh2koqhfzfkmgqdTtWYnPOOK4BnTrfh61lJRSMW2yEYVXJ8lR7E+qP
	QxrgOue4vUqo5N1LdAQfUUceyh9YsRQWbXMQ
X-Google-Smtp-Source: AMrXdXsbkGmLNzDhmyWLDFtrqMnmqJZzH0nw5a4ERljZLMuqERTXm4Ww7xSXu2luIPAHBlCBueZBMw==
X-Received: by 2002:a05:6602:341a:b0:704:d91f:9932 with SMTP id n26-20020a056602341a00b00704d91f9932mr281103ioz.0.1673976184716;
        Tue, 17 Jan 2023 09:23:04 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h31-20020a056638339f00b0039e8a5930a2sm7549588jav.8.2023.01.17.09.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:23:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com, 
 Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 gost.dev@samsung.com
In-Reply-To: <20230117120638.72254-1-anuj20.g@samsung.com>
References: <CGME20230117120741epcas5p2c7d2a20edd0f09bdff585fbe95bdadd9@epcas5p2.samsung.com>
 <20230117120638.72254-1-anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v1 0/2] enable pcpu bio-cache for IRQ
 uring-passthru I/O
Message-Id: <167397618395.17297.16132962940608644546.b4-ty@kernel.dk>
Date: Tue, 17 Jan 2023 10:23:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_092306_857744_E8F424D3 
X-CRM114-Status: UNSURE (   6.85  )
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


On Tue, 17 Jan 2023 17:36:36 +0530, Anuj Gupta wrote:
> This series extends bio pcpu caching for normal / IRQ-driven
> uring-passthru I/Os. Earlier, only polled uring-passthru I/Os could
> leverage bio-cache. After the series from Pavel[1], bio-cache can be
> leveraged by normal / IRQ driven I/Os as well. t/io_uring with an Optane
> SSD setup shows +7.21% for batches of 32 requests.
> 
> [1] https://lore.kernel.org/io-uring/cover.1666347703.git.asml.silence@gmail.com/
> 
> [...]

Applied, thanks!

[1/2] nvme: set REQ_ALLOC_CACHE for uring-passthru request
      commit: 988136a307157de9e6e9d27ee9f7ea24ee374f32
[2/2] block: extend bio-cache for non-polled requests
      commit: 934f178446b11f621ab52e83211ebf399896db47

Best regards,
-- 
Jens Axboe




