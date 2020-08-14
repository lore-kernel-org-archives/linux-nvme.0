Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB3AC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:33:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F6320774
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eF1cRVFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F6320774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6mAEkp2te/tQexSjeoL9CHaFuCaaa8JR2NM1b6ZRiOY=; b=eF1cRVFlD5JTccPZqPg44ixJD
	7utmM3guM0/3sMQfNtRCwDPyA72CyCfF+nqi7291EH/mppJ/PrU3Q9A2XTaE5C2DqYPoUoSyAaRCf
	ww8hQTg0kwGof6duTD1RdgfkHVLrBV3MMlXU5vVe8ZtvGNRdiJNQ5KEM4i/P1Lpkw5vwiLhlN/cDg
	t4yWMq9FwKFJ0F35o8mmo6+DnrSRXTPvr+GhAHX+O+VI7EkOKcMJ2cGXCTctw4rrtsZJeUsBKDNUf
	pAYX4pr9jffVTkQgCycvY/EPb+sJlbN/lJsSZhLr8pPAHZyCGzY+b7PEQFyX4nqdHuYGIqrNT0y42
	JCTeDysEQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6THh-0004a6-7N; Fri, 14 Aug 2020 06:33:49 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6THf-0004Zf-04
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:33:47 +0000
Received: by mail-wr1-f46.google.com with SMTP id a5so7350596wrm.6
 for <linux-nvme@lists.infradead.org>; Thu, 13 Aug 2020 23:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x+uotZkaduJn5dUXSf8448JFJxAV+H/DsP7iCH4nl0w=;
 b=nawCgdB4bIVklNG1YPbmaZSS07KbKQO7eb5QeCVAe9FDD1D8pzyp05KtqbZGDHhkgM
 INVkeQh/n6hmF5meIneFGkJLhyzCzjB9k5KPyJ3Ne3k3BeYP7hM7Uy7DXK/QbSwtKV6c
 02H6tkfl2rIMfdciZb+plmrs3N3piyxN7ufoNasN4/LP5AsTXsFTgGyvm9kSDPtF/Lt7
 yGZ/oXpZ4kmbpjUPf/2k0puMNN2qQU0F2JDmxVrOxrfBXhEptlzk1NT6gjyXQxZBPoFO
 JQcB2AYOhRhJMWDLJq1/Rew7NsKxtstMzoP6s5xZlKlOyOaehTk9aMtHg/rcfTFw99eK
 LoSg==
X-Gm-Message-State: AOAM533JjJBz0Sw9ZQrLgw195imlDta92N+iqw/M2JhE3DQwRhTENY3K
 vnfh1mDdHkBjfXNQeF7YzvgwMTkQM9rfRw==
X-Google-Smtp-Source: ABdhPJxHMyABVd9IewOHrmMgQGLT8wkA1pBl/ws/dcrGE2QkcuTgUKhiT/s7u3lF71jl/ucdAGH5Kg==
X-Received: by 2002:adf:c108:: with SMTP id r8mr1330811wre.350.1597386825602; 
 Thu, 13 Aug 2020 23:33:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id g14sm12833123wme.16.2020.08.13.23.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 23:33:45 -0700 (PDT)
Subject: Re: [PATVH V5] nvme-core: use xarray for ctrl ns tracking
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
 kbusch@kernel.org
References: <20200814021612.5161-1-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4654370f-40b9-1b35-1e22-864e762c3001@grimberg.me>
Date: Thu, 13 Aug 2020 23:33:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814021612.5161-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_023347_081776_7CB13131 
X-CRM114-Status: GOOD (  13.02  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> This patch replaces the ctrl->namespaces tracking from linked list to
> xarray for better ns-mgmt on the host side. For host side
> nvme_find_get_ns() falls into the fast path for NVMeOF passthru target.
> This allows us to have better performance for NVMeOF passthru backend
> since XArray has shows better performance numbers over having
> a combination of read-write semapore read + linked list in the
> nvme_find_get_ns() to find namespace in I/O patch from nsid specified
> in the nvme_rw_cmd.

This patch scares me to be honest...

We have such non-trivial synchronization paths for ns scanning, ns
removal, quiescing, freezing, path handling... I'm not even sure
how many tests we'll need to verify that nothing breaks here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
