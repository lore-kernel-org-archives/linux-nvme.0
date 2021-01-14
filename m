Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86670C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 02:08:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F031D235FA
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 02:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F031D235FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=ZIGP2W9jSNty85iDqUjicmZMT
	Taquiqld4ExWPHlpnzspnig3GqlQWvuIiTylGsIsKHIJG0Uhxx3u+AgcMAHZ9vrrb+lysJLnhjibC
	qaT5YvL/CA0Ht1n9/Xu6aC2lo1APDDoEg3ZBMadthEyrFY3xQ1CgNLFPbO3tT873hZXQGt/Lc7uq5
	UPS5LEuUk5aZ9aQ0GtK3yIc21WPU6x63d3Dhr7WoW4rIdx0PJ6Vztys9L4M31osi0DzIt5RiVwHIW
	N+8nDSSpy8AtRDZUCPrBp0qWRRuQ+SukjybibWNYBu3okUVEgyz2nX7HCb8mTCu0Dl+RsfFySUJbi
	oRZJPvNkQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzs2u-0002B9-3Y; Thu, 14 Jan 2021 02:07:32 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzs2f-000235-FY
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 02:07:18 +0000
Received: by mail-wr1-f53.google.com with SMTP id a12so4140447wrv.8
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 18:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=WB9JSn/Odv0vSfCbr2pnRGgbfmfnutzYr4wiz6f2ph7ZhvshK/X3zbnZiMQ+oOgDxD
 gLnkmsdkwz77hv3Jsh6esyZ//hfqS0F7/gMUAvuvNgCDQIifxnkNxLSCh1GXbTEWTA9H
 ae7smmFwHOoN2ixedM1eq4glTykFpLmj6BMR73VyUOF11DDePU4gy8suc/dSRJDPqDLR
 4VcLt8tHRDU/8uAmdPuO/N9XI9ax67ArNzPhVjgSC6uh6NsC3YioOgeaR6F8v+/gl/7R
 tKc5oYfCjm9/RTDYtauTW8V8pq0nyt/StBcqfZontjNUq0jOL6Ctd8Ed6zcQTO1YyRuf
 ep0Q==
X-Gm-Message-State: AOAM531if0yHyDLYeVkBdupiPifMA+KAVEt6aKnsqMUr0USSpP0uivzo
 A25+cLIT8pyfKv4pKSXtCNI=
X-Google-Smtp-Source: ABdhPJwzeqnKD0Y48oJKmxbPQRrdYKMmbmdx9wLYVXLzmnhYtpNZ7ulC9QpwRc5POww5sZTAD315fg==
X-Received: by 2002:adf:814f:: with SMTP id 73mr1333223wrm.368.1610590036618; 
 Wed, 13 Jan 2021 18:07:16 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id h29sm7133997wrc.68.2021.01.13.18.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 18:07:16 -0800 (PST)
Subject: Re: [PATCH V4 3/4] nvmet: remove extra variable in id-desclist
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
 <20210114013354.33946-4-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0ce05e4c-c89e-41d5-2f09-e531660614cd@grimberg.me>
Date: Wed, 13 Jan 2021 18:07:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114013354.33946-4-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_210717_634992_CE6B8A58 
X-CRM114-Status: UNSURE (   9.28  )
X-CRM114-Notice: Please train this message.
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
Cc: hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
