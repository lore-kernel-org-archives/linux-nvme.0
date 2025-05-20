Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459ABC3ABDD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1yWPYT76RqsHgoegjtWzCTxh32Pi/LRH5O23kd1dWVI=; b=IO56pr5PmhbD0xKUIbCjnqBeOR
	dU7rzrBCNbYmAuhE3jLoZTG6QiwdszWXzMtNETYckReYzf5WFyEdPK10V9YBCFRY3jJI5XOGVdyD6
	k9hNXUSDXdw2RTic7bAcCiTH4o54Eabsfv0JbMo3OyJTFcHSPIzLR6rOzGpXWHmX33UU2qHSa9Gru
	2G99NGYjuKDyveucbvqyzVJ9Ftktx2bWO9T+G8jP9L1PYml52Fb37onWIW+/eHq9uZxsFmxKjpBs2
	QjAp7ZQrlJMX3OXNnIo2Xy9W2QitRI1grGfEs7tT+k8wHOYB/4JKMjpFXhzdpoDIQPXbDoXjTPgZl
	DpQcoShg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHOto-0000000DLfA-3Fqt;
	Tue, 20 May 2025 15:29:00 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHOmW-0000000DJby-3nai
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 15:21:30 +0000
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-85df99da233so606776039f.3
        for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 08:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747754487; x=1748359287; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1yWPYT76RqsHgoegjtWzCTxh32Pi/LRH5O23kd1dWVI=;
        b=2NPoG8Bc0ck+dlSPq3nKlYpgqueM1O49Bg6xDV141jc2+YwWsYiMcLlOcpSEaSZsJI
         MpWP6Xfnwlj/vEb6cmDdxXuT0EM70Ky/60uUduvu8NlQEWX4H61jH8rzILOXeGKXoldU
         XW7EnJE9LW1Sa3KjO+BrH2WnVL0c78ed4RmjKssFr3R6s70Dqzp2Ms/nmCTctsGpwNWM
         S3Be3g2QTUY+YUPJiP6cl88ro+7LRAcjah2C3GVuolEJviqsnhihihvqBOO5qd7gfzJ3
         wXuQEk/IgNnnCe4CYktGW432gw4WhDJ/cldsKIPoTYwLujzdBbfxKbELmLHEBHeUmAN8
         u0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754487; x=1748359287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yWPYT76RqsHgoegjtWzCTxh32Pi/LRH5O23kd1dWVI=;
        b=eKa2S+zlJXCrntuhKItqCPCDuh4XRqBfxAs/jRdz8jrAmcZfZc6G+WflOWsY+/oCie
         rNmeAdrGr+CPQfhDRgi5kQ58uoOM1aJrpKB2JBdeewMleb2YqlPqtXjA8163oPojJUep
         RGSTh82NP4NSd2JFZ+2uGAAEGBiB6FLW+jpcTinfyiGTG/hiWYHLa6hI83nXJTQEwZOf
         QJYPuPYQxcQD80lotFa027InNmxm4vck238SaAxvVCGSIeGcVJu0kkwcrmTgmGfrtf8/
         NxkrqGMqLiTLoMsYDxNOSdVNRNJxStbE7Tjk7UBFOTdNRptoLBNhMY2UR9hS8WLD3fzJ
         a9Mg==
X-Gm-Message-State: AOJu0Yz2est3/jOQIfOtx+NVC4O1gIvdVtgkwrv2DzS5ndVMY3Ly9lWf
	xYlKBzs3knt+PqDp69o0VfHxP+Z51oFrYLZbfeB5574gDasmvCo0zowfSsoG7Oha+zM=
X-Gm-Gg: ASbGnct/avKRl7VlXrmvv7jnQGS4tHEHL8cfG37EBZ3jL9o5NXOW+kUNDu7BlCCUpo3
	CcgKwZ6UzBDWs56mS9MiyayTVDhBsloIMsodHtTJ+iXHoBEKCuEFyAqZ2XSHaagUWQIE4apj93h
	QsfJOztTTO7xnykwwFi+0qpELcjAoKnD/jr7jcU6ZQd62jZ2m2sVRM7ANBGSt7st+X2hN7GzkHE
	7sguh1B3l5tZlXyXO2Hio+KE5bIaO4MX/p1Rj4Dos9Bj2y5Twx7ePt6vZIVJbtcd6yFx8No5yq4
	S6f6EEtrOZkuaRd02PwGzgTieHDDqo5f0vp98ZQKvzV9U1Y=
X-Google-Smtp-Source: AGHT+IGTY1PdI1W3tLCAHQJh9fLxDoWN5UlnCZipo+EbvIMyJ2LVobmLNoQcAMuDAWFiNs5yyrZMHQ==
X-Received: by 2002:a5d:8547:0:b0:86a:2523:6037 with SMTP id ca18e2360f4ac-86a252360e9mr1473854939f.0.1747754487496;
        Tue, 20 May 2025 08:21:27 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc48c8a2sm2277561173.87.2025.05.20.08.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 08:21:26 -0700 (PDT)
Message-ID: <eac36a76-fc41-480c-b2f1-542a9bdf8d1d@kernel.dk>
Date: Tue, 20 May 2025 09:21:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: fix implicit bool to flags conversion
To: Pavel Begunkov <asml.silence@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
References: <d8ed3f9ae153dfc3e8a2a63ed5abbc5e1f0589fb.1747753887.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d8ed3f9ae153dfc3e8a2a63ed5abbc5e1f0589fb.1747753887.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_082128_949024_98CC676E 
X-CRM114-Status: UNSURE (   9.90  )
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

On 5/20/25 9:14 AM, Pavel Begunkov wrote:
> nvme_map_user_request() takes flags as the last argument, but
> nvme_uring_cmd_io() shoves a bool "vec" into it. It behaves as
> expected because bool is converted to 0/1 and NVME_IOCTL_VEC is
> defined as 1, but it's better to pass flags explicitly.

LGTM:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


