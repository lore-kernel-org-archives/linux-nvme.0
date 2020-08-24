Return-Path: <SRS0=kA5W=CC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840EDC433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 08:26:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B7820738
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 08:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PkV69Lnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B7820738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=PkV69LnmX+7/u3nXK2+miVHvR
	7zl7OMA5ouQqwBr0OFCmB/5EZ6P4+uSFLfrVdYbNWX9aKHX5HRB4cfrDNIzjO37gYVAQU83aCVwQK
	/Cc8soW6k+sREeCFh7XgRYEfSbMadK4Ghd1EtEV5o7OAbiQgw3SQR44ppCvNxmxMnO4rhSdsFvJQp
	A/2hmk/UC7S+TGEMPb+JR5u8kU8ZJswzLVOwxE/Xns3Fu0edrHoM2uD1/ChlnAciE2HO6OGWz1ECT
	rDkByOWU8xoe27w0PnbmPNbr1u+Qyr1YZmF3zWi++EsyARygWHUU4fl2OALU0yybH5J1FGWMIj4NM
	GhQRLEH/Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kA7nw-00089H-A3; Mon, 24 Aug 2020 08:26:12 +0000
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kA7ns-00087g-3c
 for linux-nvme@lists.infradead.org; Mon, 24 Aug 2020 08:26:09 +0000
Received: by mail-pl1-f174.google.com with SMTP id y6so3874186plt.3
 for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2020 01:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=i4LkX/x+RQvz9myJFrJKIP4rs8C8ShPCGLsW8r1/V7oJ7xOm70CiPxGD6youMrzLoS
 dRVD5zvP4d5S9Us8MSwLkPIyoDi9/4W3eU8YOUZAYHZqee8UyDpescA33Yb1BOCjmYhK
 OSsUISbLdWOFajwXJ5YdOlCHAecFcuhHnLotE1jlSnon+Af4hj2PD2c8phxDmXfQXWg9
 fBa4zHwZn2KO0xECtqWkE8cSqex4NgZqEa8fHKtVNwO20xef2HQLkwaO6pkrNp++P7wV
 4aTINAMNF9iJF+tpSgF73NOuLYNVhO+0UjNJJ8v9GEjR3lMksOTqSD00+CItEZeun05b
 0NMw==
X-Gm-Message-State: AOAM531k+wvkwW1aex/EGyvQQSKuvDVHUZfz/4zg3eHVljMB6+imMUQ6
 Q5u83v0w+Emcv75bPEkzOsU=
X-Google-Smtp-Source: ABdhPJwX8zNdc7jFiZkEPKaTs4v/SLmNt0Dx7a+U6l+UKbsqW6vA00T1N6wB/78LH4C1jRnOhLPIPg==
X-Received: by 2002:a17:902:6ac9:: with SMTP id
 i9mr3156325plt.128.1598257566796; 
 Mon, 24 Aug 2020 01:26:06 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cda6:bf68:c972:645d?
 ([2601:647:4802:9070:cda6:bf68:c972:645d])
 by smtp.gmail.com with ESMTPSA id k5sm9452366pjq.5.2020.08.24.01.26.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2020 01:26:06 -0700 (PDT)
Subject: Re: [PATCH 2/3] block: fix locking for struct block_device size
 updates
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20200823091043.2600261-1-hch@lst.de>
 <20200823091043.2600261-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4021e83a-b107-df28-2266-38648c769c9d@grimberg.me>
Date: Mon, 24 Aug 2020 01:26:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200823091043.2600261-3-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200824_042608_329194_C8E31C44 
X-CRM114-Status: GOOD (  11.18  )
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
Cc: linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
 Justin Sanders <justin@coraid.com>, Josef Bacik <josef@toxicpanda.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Xianting Tian <xianting_tian@126.com>, nbd@other.debian.org,
 Stefan Haberland <sth@linux.ibm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
