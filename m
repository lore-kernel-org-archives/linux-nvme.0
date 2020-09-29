Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8968C4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:41:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4897E206A2
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QKKn6ylT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4897E206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=QKKn6ylTgjQ4WG7Gb4El4NA+6
	Xlco4HoEtTL64abOmZx+PoND6k5sw9bQtYEiKLk2Qc5jRYB0mMmE+Ibwp5cTAhdEyVFk2AGhMpSpM
	u9VHGcWkajP3FDvKwkV8uectWzSEaA3kDgWJiCeytJnP3yckuINVjw0xh0jTscRgnvALN9Ls7w4c+
	QcZL/DozpqiWW9J8cRTtQjiaWZeM3AEa+QyKLpCS6Unn7zGr6i62hg0xGIGOc7E8rfiSIddGSwHqk
	8036tna9iYzt4mCHRrJRXYim65AEpktLcncX6fTBLD6YRx+/vsLXscWVa+Yd9MX/NScIomPkCh763
	OERCSGc6Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNBC1-0007ZQ-8p; Tue, 29 Sep 2020 08:41:01 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNBBY-0007Ne-OZ
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:40:34 +0000
Received: by mail-pf1-f194.google.com with SMTP id l126so3827915pfd.5
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=M4TkKTTRl8GJ/s4U8cW2POZY1w1Vv0TgBY6NQo4ENdcuXi6qntAHK3qc8Yn7P3a6kL
 ZWFw+MRAtWZyTAmtzYb/t9L3HO86TpAfnESYDJC+Hv/U5BQn3jWKR1WHY20lWi1W8uMz
 IVXHjdoFSTQbQP0ewc1PbP87gV6v8J7WtRkEiXPlPqQkz9zK+mInOMyo8yn20hNkSA4r
 nA4Cgym3AlW2RC7utBbmEgedoeYBvXDVde6lCvetEE3XO7/9g8OJD3Upzvr6ReEYwBWs
 LslO9RUN/5Ht1iD6XJ9PnRwnEE5zoATQfr5gudb6sRAOdHRPp+vrvtRBemM1VcIEDSge
 eShQ==
X-Gm-Message-State: AOAM532pSQFEJU7nFGYOLZDDabGSqXi/CiNthUU39NOXHp9/VCpTYsoh
 2oBrfYDiBdT+RuuPQIid/yc=
X-Google-Smtp-Source: ABdhPJyZm4rM0du63YlYdIwYR4myJgc6rXpAW6ffEnKVaMk8U23cfMuDWAXEXgxTGUWQ5cyugn706A==
X-Received: by 2002:a63:cf17:: with SMTP id j23mr2364339pgg.116.1601368831919; 
 Tue, 29 Sep 2020 01:40:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id j12sm1821871pjs.21.2020.09.29.01.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:40:31 -0700 (PDT)
Subject: Re: [PATCH 09/20] nvme: factor out a nvme_configure_metadata helper
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-10-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <34598d43-6f5c-b620-39ea-e7bd4da3f072@grimberg.me>
Date: Tue, 29 Sep 2020 01:40:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928123502.435373-10-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_044032_858002_2CF51F57 
X-CRM114-Status: GOOD (  10.63  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
