Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7A6C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 07:09:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2B320708
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 07:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="v24nnd7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2B320708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mdmmOClkI+pwA6uqgxgH5/ZK0eFnjFjyXmAZMKVY3os=; b=v24nnd7W9RWt8Isu/V4/40x7G
	rBX4R2fYytdcroZWBj95DCCODnKWIIvieE/76mG6tC1oLZhdAPFaM2mTJbTs4IBBdQmGY2J3DcMGp
	98pITL8JSw9pSdsPuF8JRLhV/DOIL8oY9N9cWcmstkCeUjedpAmClM0Ug4JGUU2j2PYDmSOVd4jzJ
	JvjmTgnuPxcq9epfULZ8PNZ5MzZfJqeUwnHicz2xU3NpIWHRpUDltcA6+MwxHaBrkWe0ijlSwwA5i
	qrQ7riZkqe1dhPbke3xF0EBxq3UcKp4b0DWykdEfsRxicAZsCcuPvi26Yroi4CFRU5vtpJxv4y1d0
	lnRPGIiCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6TqO-0008Kp-5E; Fri, 14 Aug 2020 07:09:40 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6TqL-0008K4-Ag
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 07:09:38 +0000
Received: by mail-wm1-f47.google.com with SMTP id 3so7075501wmi.1
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 00:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WPhbIcepvhNDKDxgQ6sWBfY1UBbldEp4hQDGvARenjs=;
 b=m11HmzbDuC8DKOFCIre11fbbuKNU6VCingRENRMglAn1ldj1IdFZxHPEM5Z6uYX3av
 qDMasf4eAbIsw+5V5S+1TprxfLTy4NtmlY1CanZj00all1dlQvzlRux74ribgdBKYy01
 Veo1qyq+sdUu3dCp62VNsfc75LFapdK2nIcS3dvlh8CefUeYC49SI8pDpg4QJ6F+r9CG
 ubd6pYSBd+wjJlAum+T7D1Us/ei93naYVtuUMB86apqMMnPAE8fg/gQTPFyc6DNajxjD
 dPe9HzgJwhwyrTL1O6m8X9q/kM/hNkh6UoCqMUK+B0UvmVwSUD1N3/DTYB1LH9GRFyqD
 f16Q==
X-Gm-Message-State: AOAM532QoW4jLC0RxU3FellMPICfgJM8fO3XwgDwrXCOkRVwnL1FNZHW
 8L7VIRyH0EYhyZA4e16DDU0=
X-Google-Smtp-Source: ABdhPJyMQJeprmAiUvLLjhx6xMaONSgu16QM75jElgeVhNWEsyjWAPPmrxBPW+dyo6fXU4WayRSQ5A==
X-Received: by 2002:a1c:984d:: with SMTP id a74mr1322941wme.140.1597388974497; 
 Fri, 14 Aug 2020 00:09:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id r3sm13115834wro.1.2020.08.14.00.09.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 00:09:34 -0700 (PDT)
Subject: Re: [PATCH v2 2/8] nvme: have nvme_wait_freeze_timeout return if it
 timed out
To: Christoph Hellwig <hch@lst.de>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-3-sagi@grimberg.me> <20200814064507.GB1719@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b2ae0025-57ea-c99d-5ac3-787562bff080@grimberg.me>
Date: Fri, 14 Aug 2020 00:09:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814064507.GB1719@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_030937_419859_009FE622 
X-CRM114-Status: GOOD (  13.14  )
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
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> users can detect if the wait has completed or not
> 
> Please capitalize the first word in a sentence and end it with a
> punctuation.

ack.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
