Return-Path: <SRS0=BHyj=6F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD26C2BA19
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 06:48:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7207C2071E
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 06:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XuskwT7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7207C2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=XuskwT7/6VYFMVYfb6x0qzeOA
	d4yjUV0v+Vzcdhf4cjs5QxtD4S8YS6OQQkmM1XuPN0lUYNJ2A3el/TvLPuVpAHm5HPxpGU6DW/69y
	YFO9hrN33TTBtitb5h/ePEXXimFV4A9u85Tgg3pKtt5UzRtnJRxJ3gVZPkaPXhn4/ZxvRZKN1UgCO
	oh+4bjAR+7QoAN5qk6XL9/gR/KPQS5E7ioSsIdVHyCAP3YO+lPQD5w75F1kboCinmfIqnvsPhDgSS
	5W3ldEz7mS+JfDhgkRFwflO/GL6hXWPFgN2TphmnbSuSuUfgCN/jZJ8eKavQ8cnyrgf1WGW1AALY+
	7gpGfRb/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQmi0-00024u-Jr; Tue, 21 Apr 2020 06:48:40 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQmhy-00024F-LQ
 for linux-nvme@lists.infradead.org; Tue, 21 Apr 2020 06:48:39 +0000
Received: by mail-wm1-f44.google.com with SMTP id y24so2325752wma.4
 for <linux-nvme@lists.infradead.org>; Mon, 20 Apr 2020 23:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=dRdN+721KSLMurNOzCfeYJHM+vi5wkGKR9qiq8UGV/XO5MsL9vU5X4NsDqakHq70B/
 cJYjXbjlEN2Qu1uNEb+rzZVniVYObWp2epb0o8v4jfe7nZ3VQKKrglggdURxHaXwk42C
 YmL5QxmR/8pDDDsh8eYQPqMYiKp+zB+AOag8gCxhId/8IE+5HuVtrnmrtX0xN0K6AaBU
 7KAoPYTazTPanwf9/VDSOxX2eu6gkQBD9dsRvrwQJ+jC739Mg5J5Tj5AN2h5BtGTPvgK
 nkmV2ZrBinXmZAAgZB3tro7Pj3ACJ2JIGBXmSP3ACpodvb6XldxJYyT2120BOW/WHmgP
 HIXg==
X-Gm-Message-State: AGi0PuZrUKSlaiws1W7b0mndewpAdtBQO9vkd3P4VGs3rGVI0URO+kaI
 0NX7PipCbwfLxKh4sbvoqIikZhol
X-Google-Smtp-Source: APiQypKsgr7fjMjZ8sDRXnwjXEEggw3b2Y289+BZrqBKARlrbAutDjCSNHuIXSYlZGGr1lhbDkcS7A==
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr3227447wmj.60.1587451716277; 
 Mon, 20 Apr 2020 23:48:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d4f0:54a7:68bc:1947?
 ([2601:647:4802:9070:d4f0:54a7:68bc:1947])
 by smtp.gmail.com with ESMTPSA id i6sm2649234wrc.82.2020.04.20.23.48.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 23:48:35 -0700 (PDT)
Subject: Re: [PATCH v12 8/9] nvmet-passthru: Add enable/disable helpers
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20200420164700.21620-1-logang@deltatee.com>
 <20200420164700.21620-9-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9f885add-aa53-6d63-e97a-ed033e39e7fd@grimberg.me>
Date: Mon, 20 Apr 2020 23:48:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200420164700.21620-9-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200420_234838_700407_3CF18DDA 
X-CRM114-Status: UNSURE (   8.68  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
