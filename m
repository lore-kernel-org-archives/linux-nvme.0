Return-Path: <SRS0=wEPw=XB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8699C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:40:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF3120854
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S3FoIXKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF3120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QhJhyChmR6SvST61aXfyiO9VzyBfVYSdyNCZXYnjX78=; b=S3FoIXKh41rZiuvHbniK/TeBA
	ZOb5mVj87GfXwplvg2ZrDt70y9oo8rJ6Zky9HJivRHlriYVB2Iixl52659UyKBnIgOE79LnAx//rA
	JZvfuz/myWoj6QD3CaGKDNVKRuZg0UlCLbEHkAi+CxdUyYOhDgN33WIZ+5xa9E6j3e/F9njWLyIG0
	mYvW35rar3cb3FGtrLgGAU/Et/DI6s1NpKo/Iu1K5x7edAbOEqagSskPLBO82BEX3/Ss2XNdc6X+r
	iSsiEe3EZgyWmw2g1yLxhj9l4dxJjUcIXlV2wCzPWUnaPhS8zSl3yokIOli3foNrjqdRaoj3prgNo
	xsR0WTxYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6NqI-0007i2-0F; Fri, 06 Sep 2019 23:40:38 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6NqF-0007hb-8K
 for linux-nvme@lists.infradead.org; Fri, 06 Sep 2019 23:40:36 +0000
Received: by mail-oi1-f194.google.com with SMTP id a127so6439274oii.2
 for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2019 16:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ckiUV8HeIYQ/rsOxCbMNm/VjxU8EUESI63njQcctYnQ=;
 b=jDBe6Ou662G5HBThP5ZGrZC7dZ/f9JXQ6ARmoefI6NMe6P21KjMqM7uia6I0Il6Fyk
 NpeoAeChWn3GsBMaaTJ7cS6pqEfnpt0YGMZ+ILuFgsq69wEyV5JPtV6ga1XDywRAYfrH
 1kNwX8N09Lhf2MwPJ9TIxeatW2QOULbwLn8GLTrCceo2xXiPxwkHhdttgo6Ph7ssNkA5
 egJHn1wHrCCVjfoverzhpXNqo0+FZWo04VnBc21PAxcjT3SwaC/Yq0l0RHjp/TOLP06v
 +BT1uJWaCgL1XYPlHw21aZ5odilUCkD0Zt6WZf9MBv8ObcigV45Yt/eevTXkv/X+Lpyy
 mLCg==
X-Gm-Message-State: APjAAAXHFYQ9aOTCAPLIttVGO4xmFsel+PP0SHHpMPRYeSIzvDQlX4J1
 9Fl23sVTQVRZnruAQSnE8Qw=
X-Google-Smtp-Source: APXvYqwIj4G+yxyw390JPsYAPQ+j0LZYO7Jfo5X/fJwmq/xVN01yp+lhcqixc0ggg122plDaAo1mZw==
X-Received: by 2002:a05:6808:195:: with SMTP id
 w21mr4987809oic.109.1567813234565; 
 Fri, 06 Sep 2019 16:40:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id p15sm2769865otq.37.2019.09.06.16.40.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Sep 2019 16:40:33 -0700 (PDT)
Subject: Re: [PATCH v8 11/13] block: don't check blk_rq_is_passthrough() in
 blk_do_io_stat()
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-12-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6684bf33-5151-9f09-8cfd-7586cc9be99c@grimberg.me>
Date: Fri, 6 Sep 2019 16:40:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-12-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190906_164035_293640_8BE7A607 
X-CRM114-Status: GOOD (  10.08  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
