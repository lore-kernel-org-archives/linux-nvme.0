Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE88CC6B38
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 10:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yidpPs+IlsFe6CH8kkeaYDg9/bA2fKGHlODzWaB+2wg=; b=miyvGBiZItEvRLyDI9aoZJM6Fb
	O12BkHIm3h1ZlEjF46zVIXUcctDrgJGgV9TGXr1LWnyM4CI34BuX3soCQwDyIOrXycofd6bs/KF8e
	iw5q+oP2B+0TBGLeKcC0k0Zic2qgpjgMBGRZ85y5e8rMsqx+3LMJRUCd8TVZzuxk2kaNZWPi4l1X2
	mKyvnMlOoppbLrnWqYB2AAzESBehMBsT1BwhqEdwgZzPd/KAgQdRbNPhWP0QoqgK+LJE6arp6yKzb
	7up0eatToa04D6IB2YAZIuldFKxDXbdR4IqYBZg8YP0XWNmGgRJg6ksSV5OIt/uLQNEAdkpCiXOaT
	7S5Bm8nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHfNe-00000002grz-1sMH;
	Fri, 16 Oct 2026 10:41:42 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHfNb-00000002grV-3aPO
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 10:41:41 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6b1d8944cb0so7420910a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2026 03:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792147298; cv=none;
        d=google.com; s=arc-20260327;
        b=Msk5S3+ouzxvPCYJnT4ZbVTYF2Bht/xldkop/vz0YV/XmNko/5o2wk5Z3Qwwemanxv
         +GjD0FQy3IrDBz4x/Ga8RW2pzDZ3dCv52YzVKulA8cH/iD3oo8NQnudS1QxoKZF3He7T
         +L0TvYlG1cFX+6fTOH+2zmbqPdKiy7NS5/2QEI22E4oJLptexTUFmjWIhqa+QnSaf1Ra
         0OhzuuO6ojFcpO3gMhIoRGcZkVC0QDND9OfmL291fRykGbXPblFYw5OcH5feN6VhX5Jb
         JYM3dKmIAUxKitogfy7UKGuQVTK0cFaR2/ke/iLZFDe0JgCnz8hcGJf87eVW5cvrSF08
         FixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yidpPs+IlsFe6CH8kkeaYDg9/bA2fKGHlODzWaB+2wg=;
        fh=W1BsJCQCdstglwXYDYWbxcwkHA3Eb+Y1ivOdZdHwdFo=;
        b=QZBwm6fYSb312iJGXThBXhHwjtDh1puJ2kyouA7z4M3NmmLkGFUqorPoLDemFdB6j+
         ZSjqhZM0BMwZHThFsBgdSQSSkc+HY75KrSJDYZVtMSvZEgFGbPMyD9Et4PPWoTvuTuao
         gaSfReSniKeYq1CqSBvpBYyHY0RXSfKtf9H2+QQ/Bv5M/ONR+Znf1MryJjLPTrRVKQF2
         2C0xwF9V5IRvbwFK3c0RmwswlvCG6WfEDQVqogs2gs8bz46sLaPfEBQrzFYdrk9EmVgk
         tSsRc6dIjjyA+4wC8J3c2yaCX82yu2nQUMRR4JaYIGVfjVzVttLXWwWawi9Cc4J3X6eq
         MCAg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792147298; x=1792752098; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yidpPs+IlsFe6CH8kkeaYDg9/bA2fKGHlODzWaB+2wg=;
        b=VNdG2vQrhH019QyZSZaIbUTFC0Nlej6pmEuoWr3tHFLKobvwseW4A0YKvqa+Eisf/A
         AfK4kDQ0BP4xwVWMk2N8OsCatDSHNlBAbrqVhMf6x66iZCAv85cBgKgnh0Bm54wWmPZ7
         ejm5TVdiXg62eQRiKaeaV7l6a4hw3cXT6jKiUedCIRqbo7x582SSdFU1FleJiDaF/6Md
         R/9AzA+caVM6OdagRolb1c/w0+u4ScnRPS3ue2ltxTcrgpAGZXljC4yqD54ntZv6kilw
         /84MRSkq06YWGf6veLttpygTGYilCGx51DKnkM1oIlOm8AAFfaHbW5N/BjZ6xNDh7C2b
         Tgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792147298; x=1792752098;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yidpPs+IlsFe6CH8kkeaYDg9/bA2fKGHlODzWaB+2wg=;
        b=N2Bh3M+CKh85SpTUWpdXRQWswrBLsAczCAozqUNLobNxXtIZzSBUecXSFnLbK3ynfu
         F6Qs/8iHc17ypfNzjwM02zgXgb0PSC32YlV6t0vAuZq16rbSKsnfxdkbZAWtjjLa0X+c
         98zRZrq+E3NoZmt334kzbIyaoS1W8JpcboYBJ5sjsMUOT8tPyWl8Xk24K/gPd0MQ4u9s
         C4ZIS+/rnPi0JMkMF4C52NJg0uY10j8nxH/JEBIPFRiSJNBqVIHI1axWKT1LbFD7zrsD
         Q2Gw2W7BSxNulcGPZUDHxuWqYaRzjgBViqxQFogxwek0rRsQUBunAwYo9w5d0/Jy/UU+
         ZThA==
X-Forwarded-Encrypted: i=1; AKwUvBwKzXKyY1kxdisYrvHMU7Y7kBLWNnHk33OI9rNW0y/Fs9gTfTXpVr5C61JHj7QFSdXg00jscMpp9mWj@lists.infradead.org
X-Gm-Message-State: AFq9FYIQLnn77lqH54VV2ImWwJT5jE+Ftxv1EoAms0N7oQJ0HBKYRcHu
	pPBWRs39Zw0Aywp8tpKNJnaJw+pfuUbFafzlhN8xjuj/ox7Ee5ERWoQeNnxv4lRE1bVjCwCY1P2
	77Gfjq+Y9yt/bgbXdp6TWR18JMrpeow==
X-Gm-Gg: AYBFou11y88YJBv1p+dIb1MjkY7reU+wwSQtqB3iW8eO/kixeLLUekEJm6aF/31Cs+L
	eqjZ4Bqj99d4tlGQ03FeXzWDlrrsevb9b/WpR+9A1ZcCmsy2uisSsCm08HEKNQvYt5gz8R3vWst
	iToIM6WiQpH6EedmPbf6SH7exsELTti2bqp4FawBKHk9hlHfTJrt6vAfOH+k9GMH78mOahGdAMq
	4vL2jwrtVeaKJ0mPx0wVIyDGRnAp+/m4SJIx90xkY8LQ5ar5odbe/FzcXoCRpyrIdbNErkqBAAY
	NguSfwN1cRr3atMgbcaEeuiHvbVqlTtNQn2BUIGUYgqiwgZ8cdnN6ps7LujdIa2DonnIk9jaxz6
	XCfPTp9mvLugDISaQmn76ToFg4KhrmynPMyBs+ouy
X-Received: by 2002:a05:6402:2101:b0:6b1:c355:c7c0 with SMTP id
 4fb4d7f45d1cf-6b1f9998b4amr8172527a12.26.1792147297855; Fri, 16 Oct 2026
 03:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261016103453.1129150-1-anuj1072538@gmail.com>
In-Reply-To: <20261016103453.1129150-1-anuj1072538@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 16 Oct 2026 16:11:00 +0530
X-Gm-Features: AclHuK_TBuGnsWkZyqNlpbVsORRdkyu1KED6frckw8PX5cM8wShBEPc2Ia-Ogs0
Message-ID: <CACzX3AsAKsYsZr7DoDTBYi6H2gYMzkktNkMi88O5GD457XxmHw@mail.gmail.com>
Subject: Re: [PATCH] nvme/io_uring: enable dma-buf backed passthrough I/O
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk
Cc: asml.silence@gmail.com, joshi.k@samsung.com, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	io-uring@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_034139_900852_EC1ADD9E 
X-CRM114-Status: UNSURE (   5.70  )
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

I tested the dma-buf backed NVMe passthrough path with a liburing test,
available here:
https://github.com/anuj7781/liburing/tree/rw-dmabuf-pt

