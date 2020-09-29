Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B83BC4727F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:33:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6712020759
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AblVgFWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6712020759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=AblVgFWi1wWS7znrfFNuylZSQ
	xQOYw+D9K58I0MEGgaq+N6I1YMqUR4YG5LpkfiejVDyRBrDFwteYF5+5ZbiUhQsXpCMGHKhupivmN
	K1riDgTDCdrTD/LREdltTDTKzIo5xmcH9py8f/LTE4p4D8jEwOvqj1YN8lqYSuy0VFUpKKuVhcT9T
	UVUcPKuO3eWDJEEtUX1cF+0Q9fifHgWV5G91NAZ0Z+lpzUbPSP1BZF4qSaRO4LNdtz2aK9T5SOkvK
	C9GTt0fJGQJ6AKh3RhvHIUxRt++8gsP4x8QYP01CP/xVdaWv9gesmWdO4pSBuFgJzuNrzF1fNeDPD
	pRsdWZFyw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNB4o-0003dl-4n; Tue, 29 Sep 2020 08:33:34 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNB3t-0003Ct-0L
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:32:38 +0000
Received: by mail-pf1-f194.google.com with SMTP id n14so3802047pff.6
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=AvcjWD/zVdbwE5AUCRnhtYzvl0WV2IQhsibbekg1AQNY8BPMulnuWSpga7FE4fdb92
 YOrBveR47yNYW4avdsylHvtHhDUIkUQZ/HQbAW/yU/5MulsbATllRFNxPhUwhjMH5Bzp
 E8T4gTRZCnhOHbjja632PP4sTiVWt7CnVAui98tYwaDzRttoX1FMMcrF5Jeu/c/TlH4t
 Tpp78pFPRueCUPt/dvHJ3fmyPW2BdHyOGhOMdP0N9mKX0sGkrWWvG+f7A5chIDnpOi3x
 LZEaxBD3E8hytRxXYEGjMHo3XrQ12qAvTRBpJcrzB9zyYOYDhVLCdA1FAf6wgKTvLbIZ
 uKoQ==
X-Gm-Message-State: AOAM533ZU0IL4TqloSGkhjL0aC8dA9sMcb+5GCI4ptA6pCuJB6x7+ayV
 F0fEDO19Tt72n3Ck86nPr8c=
X-Google-Smtp-Source: ABdhPJwKlUItLHQRXVU1EPsafOa6ZqRjfnjJQvUJriUNh5hruovd03Pea02CKXzbTGmjaXmAaUJDKQ==
X-Received: by 2002:a17:902:74cc:b029:d2:ab25:543f with SMTP id
 f12-20020a17090274ccb02900d2ab25543fmr1620448plt.32.1601368355830; 
 Tue, 29 Sep 2020 01:32:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id 63sm4440493pfw.42.2020.09.29.01.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:32:35 -0700 (PDT)
Subject: Re: [PATCH 03/20] nvme: remove the disk argument to
 nvme_update_zone_info
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <93e7e089-ddef-d9e0-49c5-9b1060ce3166@grimberg.me>
Date: Tue, 29 Sep 2020 01:32:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928123502.435373-4-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_043237_096571_399676D6 
X-CRM114-Status: GOOD (  10.93  )
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
