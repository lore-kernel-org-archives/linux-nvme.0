Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095D6C5DF81
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Zmvlpe/tj2rUQF6nnYe1MZk/u9
	uxEsmpVoyE71OPmn3bXrFFa4SfyEqKAXgD0TzU4hM552mTerwvgzMTL7HQU/QymUbOLIi6p1ozdiG
	JNNtfhoJbFbnlFxrE30xvGP+VNQ89lk+N/xBEEhoqKt4mI8El13koSTzNDGba03Wx18OgmgDCPTud
	UMqhsd1kOuw9F3q5nkPJi4pab2QlOGw7a05QOeb9+76j/yPdtwBaS5uQ6TDdWcQtvN3W6QPx970Im
	vWt9nl6TxtQLsUyBGBl2SpP7Ww7hNVQp79s/w47FOwJalJNsTaU3AcLGbhkbQNEb11Xq9KSngKdQX
	nO+7jE0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy4DU-0000000FCi7-301V;
	Sun, 23 Aug 2026 09:10:12 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy4DS-0000000FChG-1eY9
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 09:10:11 +0000
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a1a546a6bbso4363001a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 02:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787476209; x=1788081009;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=AU7IhWXFo9FEwpHjor1zCBxbCVueX19nK+KkVQtIDfQFFtVjoWCo0Z1anjBaT8fqAV
         dZ7Rj50U7TapQMdyKNh0DP4EdRJ/bu+5WQHr0Gs/GAFPJJ3I5T5JyE70+b7BqK4S9OgG
         36Brrv/8pVMV1dAv+ajoJUXptA1YgBb3cVh4FRlaSzkzXhaZkCoqVe56Tc8n7X5WnQRW
         lWxV7YJ+d+Lzxn97tGhak1wfImOESApQYYzAVTK7JSX3NqzJCJfluBvpqiBbnBwZIwP1
         5uoduKzXZCX5wEk9x89wwhDCvZb7R3LB1jCqfRGE+R2iZ3t67MW8uV7BfcKsrDddxU9/
         U6hg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9WBCH6YMD+xtpkOueM+iosBz29ZifWxzdL3uwTHBO7T+D2AljYGDI2yehXgq4Yl4l5YBWLjTxnwVy@lists.infradead.org
X-Gm-Message-State: AFuF++mMDSvF2RjIrJbFyblWVhkqEb0tER/2fAQPdjaEVG13JelmB/6c
	v6C9mRsJEVn1KhekhgmPvivBgxwUun90B6Hcg4rhzab0lHopmge44PAeyCT+Rg==
X-Gm-Gg: AR+sD12KVMMDlUQi3nk8vDkV3JzJuhJUhqNZQCWOGxd4P8H0TnR2uztoSqeMqIuSUUK
	JGjxzghUuBbvvc1UsGZGqS92dnlmm8pwXQ1Q0dsOphF7g0P7KO40x5NgdeSp86Xcd3hy8a0OjuW
	4cCwJZ5BwVMoouDZ49VMqpQ5sbAXMzQWrgl8YhwYA9cAce3pfgYoF9j6AsgIP24hqLNV8qbru+m
	RgquYlZROn91O/1kwwZVX4oaEuytLiL2CXeFTUsyBtwhSxGLfb8Sk3We/5kFqQNFBppDaCGb8fM
	BcdMLx02fvZc9pBOWSCaBeevGJPN8rmyhsFbs7aJwUw6GKZTc62LLW3KbKHyn9fGECgbS+IYnoA
	tQiCPPylkGOrGgB9CDhscfBkosvY8j+MsU/gbByqNxIkoEYrgLubOjho51L47hGOIpX6EOmm+he
	OlBdUcWyTsVTHX/v32FtxN6U//mM15cJ7+dbGdq8nPfPMm9xTNpvTDHa8EdCU91vQRoJvp7OOVw
	r7JJ+DzI0fKgIVCuFsMSPtdwzmRkg==
X-Received: by 2002:a05:6402:2b90:b0:6a3:8586:9b73 with SMTP id 4fb4d7f45d1cf-6a42f111a58mr20139323a12.6.1787476208544;
        Sun, 23 Aug 2026 02:10:08 -0700 (PDT)
Received: from [10.50.4.207] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e0190d3sm2553994a12.9.2026.08.23.02.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 02:10:07 -0700 (PDT)
Message-ID: <74219d85-3b0c-4021-964b-3b1d4586509d@grimberg.me>
Date: Sun, 23 Aug 2026 12:10:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/5] block: fix invalid zone append status
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com, coshi036@gmail.com,
 Igor.Achkinazi@dell.com, dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-3-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260519172326.3462354-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_021010_436142_0D87B8F5 
X-CRM114-Status: UNSURE (   4.18  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

