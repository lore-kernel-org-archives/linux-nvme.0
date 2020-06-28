Return-Path: <SRS0=+Irc=AJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8699C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jun 2020 05:29:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7365920760
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jun 2020 05:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="whKE2AFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7365920760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wTAhy3D48D6FXCAftLd0lAXJUPoqw7aM8MjKMsXliMo=; b=whKE2AFchOuH3NuvUmtCwzG0h
	MOAKdlGA1K+qhwpqXDvFXmOacRGQW3+O1XBFxC8itLw539LQOYazW9oH6rd0OwXYb9TBDo/g+qqoB
	F8szes/L4yZ+NRWHPOzF6C/XZCyRrF8eqI2Q8y8izADRAXOEprOLhL/sEDJcZSxf7gEX4ynDA7+4c
	umiFHNVvDi9z38rkyUxNE1oSvIJprjgzD8o9Rh0ipGk8R9FGfWcT9reTsVZMhdpogqq3ySydDQyoq
	dVz/QuHAWuMz7sQQne2sbrcR+bge+LgUSNDRr38Dn87a2pKRT00r5ImT8Uoq0AiYjQTnP4UX2SOvy
	qiJ8oxgHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpPs4-0003Jd-OF; Sun, 28 Jun 2020 05:28:52 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpPrr-0003JQ-9V
 for linux-nvme@lists.infradead.org; Sun, 28 Jun 2020 05:28:40 +0000
Received: by mail-wr1-f65.google.com with SMTP id b6so13186239wrs.11
 for <linux-nvme@lists.infradead.org>; Sat, 27 Jun 2020 22:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LVwqGt5n0vzuAiiJuNDZJ1sylWRVy9JrfRr72gHiSCo=;
 b=YIzRDqCcWsIacwsKIQUF1jOOB7xdHAelyNhelT0UI6NPjNOtYyzEjHQVHonRQkA7pi
 SCFkPy3NUwvoIuIdNZNc9kJ99vI0mSZL5ZsylnRaprPNBx4At3IZgaWDmUjoLA8fOxPo
 6JMzvGglMTuhtZ0IMSjsXhE65CYbAJ7gu0h42ljoogYutcnwUqOcVPK8taMp3R/V19mf
 M+brV79ysAVzCa5nJvKV1zSAyQkzlm5gYdVo6ssY4JpuqzTuhRpU4AtfkM04IMHbZ2Mj
 sto9bJyXCPq2WZ4QfPP7afRpl1+vSBFmjdTPiJlcydrzxXtZy1Evsd98w14KCUe2MLCd
 7iPQ==
X-Gm-Message-State: AOAM533zSAebXxe8oqoCvUKYWx3DFeGxiLAUxXrcVhY37RuN2ek3LDf/
 66ktVNaxM8WOud102Pz3my4QlbQI
X-Google-Smtp-Source: ABdhPJxV+lW9REtq67xvixSedEuiOg/MsBDKCLq8FHaZd7LfrmrcsOEsOvybih7ULAeonhwDNzY9qg==
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr11342964wrv.155.1593322114475; 
 Sat, 27 Jun 2020 22:28:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3175:2622:5902:20dd?
 ([2601:647:4802:9070:3175:2622:5902:20dd])
 by smtp.gmail.com with ESMTPSA id u20sm22957427wmc.44.2020.06.27.22.28.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jun 2020 22:28:33 -0700 (PDT)
Subject: Re: [PATCH] nvme: fix identify error status silent ignore
To: Christoph Hellwig <hch@lst.de>
References: <20200625000257.29981-1-sagi@grimberg.me>
 <20200626082437.GA23888@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bfb855e7-3f87-b16a-c23c-449bf847586b@grimberg.me>
Date: Sat, 27 Jun 2020 22:28:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626082437.GA23888@lst.de>
Content-Language: en-US
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Patch 59c7c3caaaf8 intended to only silently ignore
>> non retry-able errors (DNR bit set) such that we can still
>> identify misbehaving controllers, and in the other hand
>> propagate retry-able errors (DNR bit cleared) so we don't
>> wrongly abandon a namespace just because it happens to be
>> temporarily inaccessible.
>>
>> The goal remains the same as the original commit where this
>> was introduced but unfortunately had the logic backwards.
> 
> This probably also needs to be added to the comment to explain WTF is
> going on here..

Sent v3

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
