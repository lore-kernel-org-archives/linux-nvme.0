Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8D1D1BDD4
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Dec 2025 20:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f160TSNKN5H1H5hP6aXm/BM/HawUWWpVvaI+0egcaxE=; b=M+am4fIxN+N+dFfifQPsJ6tLOR
	lGylpLv6AsXE0PPWq3wirN6NL5ccFlWegTy9dAdCZnAwvYyg6Fk9R6MC4v4t5WcS0q03yl/bIPrVx
	VHvm7xdoYC3V49iA75BoE6dXw/zyjzsuqLiq1E3ZrRFNYB/0B4oNgWb3x/bs5Vs1Bj3Kcs0SFFfzz
	w/6KMoyKpaKtTXJqS8bMJOxBpoUWQfg3Q4hTvSK1b8h0Sd942ob6OOmS8qrQlH90G2RFEgrO11l0B
	IPYWVxLcOmMUeCgthaqmTqIHDlH2WYkBa9WVHb6FOJiWRpdIr6E3X00jifPjKt7KxydBl4fc/ZCLP
	34Yu+Oug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQtOt-0000000725Q-02Uf;
	Wed, 03 Dec 2025 20:24:35 +0000
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQtOq-00000007250-2tX3
	for linux-nvme@lists.infradead.org;
	Wed, 03 Dec 2025 20:24:34 +0000
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-3ec41466a30so200262fac.0
        for <linux-nvme@lists.infradead.org>; Wed, 03 Dec 2025 12:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764793472; x=1765398272; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f160TSNKN5H1H5hP6aXm/BM/HawUWWpVvaI+0egcaxE=;
        b=2yEB9KNr5bhPBiGBQUpA/4Wz98pviNP8oKXjd4DAW0/qq01uDaej3bqV+NX4jAit/s
         Zi37YNn2BRv8mA4XezPHZP+aBk6NugV4AQVcyPjLSJfUFt9owHlP2uvOwG3coRiM/AFz
         qx0b7VrNn7NHfMo71ubFaqDeYvjq0De8b9G7o5mjNadRtog3UC/n1q42kr9h5pgVR/6a
         yrzQb/BBSd5XQfNcJJ1Zy5BbTTvlPrii+RkcAmAv5Q01k2+SjX1R+JCVs1knSPreUvOi
         PabH+pTaGECwngTYklPuRgkGQgQTwEv11s+OBPGwAc/M/LN5mCV40fsM6JcUs0RDYQoV
         udbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764793472; x=1765398272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f160TSNKN5H1H5hP6aXm/BM/HawUWWpVvaI+0egcaxE=;
        b=mtklrlJa64syTUQAZdyNg+lSun1RkJhno1flizVQ+8OzJ4LaOSMU6oo3A01KSHNPae
         05isA7PIp+q67PEybOCmmCeH/yu1jrPidvF7m3PkW1cpsSjJvOQ9dX5++RGOURqzvy5q
         pLzgDKBxz+K5vBH043nK79E5EVQ53ECwUmLcrpyOJ6j7QszN5yHao3BhpUm5uPUEcvuM
         PVuh6QArkm8AoT6L9WpeOIQNTbLSx0A0Ba1NCnGnp7ssfZm0y6a2kpO136+FdeikDk4c
         oO3G/FbmcBeX6YCu7rNd5belCZ6ZPtSmh5E6fjG0FCLt0x8DlvC/xjTa8mX+QxCRYdj9
         W3sA==
X-Forwarded-Encrypted: i=1; AJvYcCUcZNnhzSRGsIsTAcC4AKr436qTKBEu3IWTgEBBP3LdhKf8u90jjWeEhKnuMcfvTwti7QGmLb5Y7Xqi@lists.infradead.org
X-Gm-Message-State: AOJu0YxqZAz8Euzma1QGbAVqFVk6YcO3KEHhOdmdzhEX+/pcT/jAk+lC
	uiFnqvwM7ojpRbZ+/CmdkQxfAPvtg+Ko4oLJqsNDIdFERogc9W1bAtcbQpMOBgpxqXw=
X-Gm-Gg: ASbGncs+lDXa1+9rqrPVIoe2LiquxjEhKUdPD+z7go6YGs/CdX+aNu697zGUuBtnvIf
	8bU1WYT8Na3c1UJuH5aKbMNbxVe9Fisz3HSVId2eoy8tWfKxB5yMJW5IyuQt3sI2j4gNtQEep/J
	gbWvvFhAZa7hpo1FtjxYVGLZOlgkeUowJkdDHZXiWNzUbQkwFT/Kdm+i9dMOq3cHPF2GrxO3HMw
	uHarR+ACsLHFS9f2S8C1BFaJquBF2UXTOAVbCsX5e/VOCct41fRHPdJJPn4nxOEQ6QbfxF0bOtE
	Id+FA6OOqchVGiuUUUVkmNL7MMxFderqaCHSDsQdm+CuohLzR57k7NWSkja9oD1fhfAo7Z28Nog
	diF6zxomLf/+P9cM33HZtGpTMGbFQFhhqSaLS9gMpaAvFHno5Gv5Cw+BXezEz216H4VoYn1NlAz
	mKCGArSLk=
X-Google-Smtp-Source: AGHT+IEN8NS05UzcmpDN5e2kbkXu8HURZpNgW5SUJjm8k7LnPtXcqOJtgkJ2ttQ7wzN1mVjMu+9LZw==
X-Received: by 2002:a05:6870:9721:b0:314:d62b:3f84 with SMTP id 586e51a60fabf-3f503147215mr625825fac.17.1764793471684;
        Wed, 03 Dec 2025 12:24:31 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dca01676sm10840472fac.5.2025.12.03.12.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 12:24:31 -0800 (PST)
Message-ID: <5e500645-6eca-41bc-a863-6c6cdce79347@kernel.dk>
Date: Wed, 3 Dec 2025 13:24:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.19
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <aTCNwTd9E186RsXE@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aTCNwTd9E186RsXE@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251203_122432_731299_020C4181 
X-CRM114-Status: UNSURE (   8.39  )
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

On 12/3/25 12:21 PM, Keith Busch wrote:
> This is a bit later than usual as we dropped part of the original set to
> provide additional time to resolve some late comments.

Thanks Keith - I'll pull this once Linus has pulled the other bits that
are pending, it'll go into my block-6.19 branch at that point for
later submission in this merge window.

-- 
Jens Axboe


