Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331FBECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Sep 2022 12:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KQc6WpAPcK2M89PZhLOKB1G8CRSWOlxdrWLHEXpaHlg=; b=S5Hv7qJmdjmwcngltBftvifxFu
	aY82Vo5pqqIm+zelnBoP8j2gOLo+WAaPJ7Ggnxnny6caUADoJ0qUHB9JnoeJQtLJwuWcpqxP4s9do
	XSQDij9ZdbL1q5qCpP4YpSFiUy/PbC8rIY+syZpDOEOsDpkRrXjrVppezeYhI4SKHIy8ah7XE894w
	xrr7xR5+w067frU4O528Lw9rokVLHTEZ2ZI40fLfxqxmpsORdwX1MWFaF7HbKPBPjMJnIX/remMxR
	JDSW9HwGBGM5oCok4mcszI0xx0ylPw/Ko+I8sTMfvOKNHbUXXYTBZ+X5smndLapopki12mJbW+S7w
	5GJkyipg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXiU6-009iWh-FQ; Mon, 12 Sep 2022 12:24:18 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXiU1-009iTO-An
	for linux-nvme@lists.infradead.org; Mon, 12 Sep 2022 12:24:15 +0000
Received: by mail-wm1-f52.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso10882499wmc.0
        for <linux-nvme@lists.infradead.org>; Mon, 12 Sep 2022 05:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KQc6WpAPcK2M89PZhLOKB1G8CRSWOlxdrWLHEXpaHlg=;
        b=PTQtfq4Jyj0tvb7bXnLePG1Xx0GeHuxCyI+CzgMnKbWL9JUZ3u+Sw24koIo032HC4h
         IMk2Y0vIDSdg1PIar8UnKkxT6f9Bhy5ZVcqXoiML78hSGFVhm4agjAoAAKb/HEr0BClq
         4g0b5oODk1wCPrZGtXkXB30PdHZ3mk8YeP36Y+oB35WR93looX8oTSoo4kJME3cBWRes
         pcDiTqQ/wm6XK0cttn5Yv3rfvCWsT3u72tYxLDwHQw23P0htAOCHlI+SMtmjhvmosMl4
         NICGvHt2tUJB1qmVB+tR5dMPcTWgY3G5t6lJEzQpQ9pgNV9WbE7L98ZY7R1jW0CwQHfu
         6beA==
X-Gm-Message-State: ACgBeo2QsyzTAjGGvA58Q8IY24an7zEeiJdnVWsp/4LL8UfGO0/zx/wm
	RG0JPl4+LWD1oO6NhXNMzXQ=
X-Google-Smtp-Source: AA6agR7XyxHqThGBHypz+s/hSLiMTgBad6yyFdjvxEBP+UVLDjrwjoDyQLDdM/1cQXVWi2SXWCZ2Iw==
X-Received: by 2002:a1c:a1c4:0:b0:3b4:75f0:e924 with SMTP id k187-20020a1ca1c4000000b003b475f0e924mr5835807wme.99.1662985448899;
        Mon, 12 Sep 2022 05:24:08 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j22-20020a5d4536000000b0022a293ab1e9sm7444031wra.11.2022.09.12.05.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 05:24:08 -0700 (PDT)
Message-ID: <7809a693-0996-3717-931f-4a7141781ee8@grimberg.me>
Date: Mon, 12 Sep 2022 15:24:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme: restrict management ioctls to admin
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20220908213517.3085323-1-kbusch@fb.com>
 <20220909151127.GA12466@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220909151127.GA12466@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_052413_394560_89AE8E9D 
X-CRM114-Status: GOOD (  14.01  )
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


>> The passthrough commands already have this restriction, but the other
>> operations do not. Require the same capabilities for all users as all of
>> these operations can be disruptive.
> 
> Where "these operations" are: NVME_IOCTL_RESET, NVME_IOCTL_SUBSYS_RESET,
> NVME_IOCTL_RESCAN.  Yes, I think those are very disruptive and the
> definition of what CAP_SYS_ADMIN was designed for, but that should
> be spelled out in the commit log.
> 
> That being said I think we should just do the capable() check in the
> individul ioctl opcode to document things better, even if that does't
> currently make any difference.

Agree.

>  Any we really need a FIXES tag going
> back to the addition of the first of these ioctls.

100% agree on the fixes tag

