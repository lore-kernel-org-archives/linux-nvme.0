Return-Path: <SRS0=li1X=BB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41B9C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 23:23:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D0E22B47
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 23:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UHPvYDUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D0E22B47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tUTqfSKY8yMZjRvP3Icc5/aFWpmg2+kSO/o0gdt+qlM=; b=UHPvYDUWRWi5khuTfkPDeijYQ
	nB81o1t5Hjfbz/OerF37xNe+XJxEWS5TQv9nech5QmyaUFqSkgQ7QT/gpQxV6spGpH7rzUV0feklm
	bxzeXShvchdfRUMwkqrCLdNX9ufOjyCR9paVWgC+nTGtRY+BI4XGxNeWkBlzH59FEm/ut/oYptEkO
	D7gPY4tCVpz1GLO1P+Dzz3xnD6HyAX3tXLFAosAQuWrgQGIadwyQA+lsE7QuPbBaxLlkpM+x2IsAj
	ZtaHpMM4I5VeEMrggse8jU0yH32MS7wh2HMJi3eETfMwZmzlkzEWPmc0fI8D05oTOBxkwtAvkr8Ja
	SezOngPig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyO5N-0004Lu-CC; Wed, 22 Jul 2020 23:23:41 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyO5K-0004LM-P2
 for linux-nvme@lists.infradead.org; Wed, 22 Jul 2020 23:23:39 +0000
Received: by mail-pl1-f194.google.com with SMTP id 72so1725969ple.0
 for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2020 16:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wIiRBu3eT3uuwmvJ5fd10KZFNkysX09cqyuWSnOH/Es=;
 b=RR+JF+1hCJRT/vnrKwQQuBUPxMPMC+93Z/sNKnqVpWpUsCGw3i0Dz2Y/0lvXl/edPC
 xIS9NARx1oT8piew4zbyiFvnWyNnQcDHqS8P1j/2aC/DDlyZkA026g3hZzS0G8AEFgsz
 0j7e4IgPeKm/785T6o+qYd6Ca8/X5EHVybhWAj0qrd0kEleD5YhVy3th7Wdbou9DQyNu
 3jzbEvuzuYyATHZZfdw+Nt+82nu8ceeqBuMfjFArOyhaFQa3Fzm7j1TxhH0ro3J8R4r2
 9k9gTX0IwEfHCe32TfMqkMRlvLYQbopTB9XOKVUtr0BbBIdGIbZlTM5IdxeJ6fNiVvvp
 6uAg==
X-Gm-Message-State: AOAM531zKIlpoAKO+AJJ4+EQSdXULNWbjGJMUNE/2CSxRDVHNH5NRRtO
 lp11Z85p82nAJt+kcP4y5qL01HBq
X-Google-Smtp-Source: ABdhPJwH1PLnsFwNqBEAN/mnFblHXIW+kU43AWZV2o7qWylcMU/t/WdHXblqkaYWNuoAVfKtsm8fOg==
X-Received: by 2002:a17:90b:3802:: with SMTP id
 mq2mr1625467pjb.84.1595460216032; 
 Wed, 22 Jul 2020 16:23:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45ba:2951:1398:d100?
 ([2601:647:4802:9070:45ba:2951:1398:d100])
 by smtp.gmail.com with ESMTPSA id g18sm699704pfk.40.2020.07.22.16.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 16:23:35 -0700 (PDT)
Subject: Re: [PATCH] nvme: Namepace identification descriptor list is optional
To: Ingo Brunberg <ingo_brunberg@web.de>, linux-nvme@lists.infradead.org
References: <m3a707rd8y.fsf@web.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c92f9d41-de84-ab54-c003-8649d20deb50@grimberg.me>
Date: Wed, 22 Jul 2020 16:23:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <m3a707rd8y.fsf@web.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200722_192338_885267_85C29759 
X-CRM114-Status: GOOD (  10.72  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> With commit ea43d97, appearing now in kernel 5.7.8, you made my cheap
> SSD disfunctional again. For reference, see bug 205679. Maybe you
> remember the discussion.
> 
> I do not know if this was intentional or not. Maybe you should introduce
> a quirk for that particular controller.

Either we quirk this controller, or we are back to test specific errors...

What is the pci id of the device to test a quirk?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
