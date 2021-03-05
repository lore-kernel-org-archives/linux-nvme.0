Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0F9C433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 16:13:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C2865004
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 16:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C2865004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YcukMwa9FKDtFtSSpxEaKzAvdqTXPq3MEUkaLxpD1Vc=; b=DJqH8+3n5Saj8gaFrdu5NiSTa
	XR2mOvUQ88dS5cdQwnbHnR6hqby++NwzKCr8HN2WIEuIHpH6/sHZKFXYCFnnq/MXSOifr+y+ItH5S
	9TzFyi54NT3iRr0PXIbMlNq7ULNlNTy2EJ/yy3Dl2S+ZzDYeuLq+oCo9R+/29AlCk8ykr0xCF+xRA
	mxnOodVDj9HG4pLASRzFm3gPE5BfKJUFDIYpQp/7foAqB/9RvdwbD/7R81zGvP3pRtJTHDr7t4uur
	qesHNQQD2FGc8phFjS+FZIdofb/oX9nFpMtiIavZR3kYkJeuWDrlIdVtGHrZSHcG3JHQoEtyG/Lm0
	c4ArqRaSw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lID5G-00FaAR-Vv; Fri, 05 Mar 2021 16:13:47 +0000
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lID58-00Fa80-5O
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 16:13:41 +0000
Received: by mail-il1-x132.google.com with SMTP id p10so2460254ils.9
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 08:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6DWum0PkSFOC7EqnCDn0YxayPunMKftKntuZCF5jSJc=;
 b=sHStvXrtBm6j4SWxFCJpnJ+pVtAmQg1uacMFUfPAQteAAbaiBcpbANbT7TRRRxDPHy
 JUdTBvSZFhigNZCUH89PlBHI1cLYC5fsV2R5d2z/T8Z0Z9yiVCYarIAE3AqHM8+bGIqB
 4z8CflWwuAFmyiRq16M4SO08/3yXfUv7I5YMvu80lhQ47ePg4psxwr2tcqbRsqjAyF1p
 jo4eMNnKc7rU6ZzBrrFe9E9NHCWvHx/GTrEKyqUR1uXFg8TynqdHQ6rvNLif8KSoK4gQ
 onVZN21d5Zlgr2uvxJLAdc7iLOG25r/0wYG6/oUfKEDZ4qs1fqnbFz7ZvbgEIniXGNj7
 OZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6DWum0PkSFOC7EqnCDn0YxayPunMKftKntuZCF5jSJc=;
 b=PX364CXvlZiZiGWq6/IM34/WRE1BZO8WEdsj0zvh/xvIOPmMfkpgGjqTgtiQMvbf6p
 DOP8LhTJwbpcBu9pcu/FPlapmFwkGfkKAxIRvs0qdNoaySn1RVPpBqALFOJMQesLePhc
 bi0VQ5wFSI9SC7CZ4rS4hn1k2zqx2f/UPEOLXuqnl6Lvhf566nvdZJNQTNlKA/+S9PpU
 vPgaiIrO5AlU+YpOQz4QgdGYS1m4d6kAZqqK18RfH5AKM6Ug8EQukdB8rVRIOadPWQ4t
 lFgtuHpNySvLhcKaFx4j0BQTvSzkvsG8CYguyjq6DLTcqaYD65ETWFrCjXVwa7FmGdsp
 BKxQ==
X-Gm-Message-State: AOAM533j1DH4+uIrVrWZsTVKjquwbfTeEcWib/gzktymKuV3LSlXc2eY
 PMSUjZ93cgKNqQ5T4x5Vaen9DSmkbgfRAQ==
X-Google-Smtp-Source: ABdhPJztVmGl6jVH9oIl+8Ya5KaL8hRp1949lAmDKpwctA2ro7Y8mZ5278NfNDNTc9d08kfFDygcaQ==
X-Received: by 2002:a05:6e02:1384:: with SMTP id
 d4mr9470392ilo.307.1614960816442; 
 Fri, 05 Mar 2021 08:13:36 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id o19sm1519955ioh.47.2021.03.05.08.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 08:13:36 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.12
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YEJYFTnbec9jteOc@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <353e221d-3d17-63ae-3956-507ea7d46846@kernel.dk>
Date: Fri, 5 Mar 2021 09:13:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YEJYFTnbec9jteOc@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_161340_011466_139B4A9E 
X-CRM114-Status: UNSURE (   9.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/5/21 9:11 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-05

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
