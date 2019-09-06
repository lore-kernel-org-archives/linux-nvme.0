Return-Path: <SRS0=wEPw=XB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DDAC43331
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:39:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970E520854
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="APLySgsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970E520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vH1CUhqqBfdtVIY019uabQ1b/tFaMY2Uue9FyOFCz90=; b=APLySgsq9F9H8Fw1/gQzB9xi2
	keYOimmUX4GFoOaD/KItxal070CxmeUAUdozXMjmQuGJNH4nitGK8PpB6YYUaj6eni2td5X1NHLqD
	Z56XoQo0vKFj8AUExShGW9c99pbBLYoCR4OITUhljYxNgPHsP7slxDItPkm8ttYGJh4ODgMu6m40s
	9pl4wjmJYowEuIz5wZQKs2rXfhORBSvrBxjZ1VB8CkCdT7F6hdSGxWf228hIoR+bPFBizMRYsZFQ7
	+QTXlZfLv+o1+lovl7o4sqQjEBvGWdAPMTjpcDAyOdptiUp2T7KHXRLcQaT5SIldcq4AEPnHKDWG7
	X2qxX2Stg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6Nop-0005vU-Ht; Fri, 06 Sep 2019 23:39:07 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6Non-0005ul-IY
 for linux-nvme@lists.infradead.org; Fri, 06 Sep 2019 23:39:06 +0000
Received: by mail-ot1-f66.google.com with SMTP id h17so3517002otn.5
 for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2019 16:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zdAQxtehqqIstpzaxZGNLX/2x6fViaxGv6dGKoG4FqE=;
 b=oOhwRQqwbg8Iv4tvjS33CuInAgTeWxmtbrTxpR/AIWnJtvNt2T0SZSsCrtXO7264pC
 q6G+qggccql5/+UARqJCQTIF0h7lx01DyUxv8ChuIgq+glNh5+LQ1CSZ/BN5kftweAXx
 bFmsQr4dVsa4+0U53jOMJyGiGyBGVRjmlLYgXggIcw3meMPeUWNY1tU4jVaEa51daCin
 ZHFnfoBPRVM/mfsj/qw+/1HcHJ9EkGjovLVgciXptq+YaKPUSb4uAiSsWgDEJBV0i7Xe
 W0Cy2gjuFRn+Ww75SqbazX0exFg6awjqfJUXVjOenCHY/GQFtpIYf3FWrJE9pqnNYN/D
 kfxA==
X-Gm-Message-State: APjAAAWyTQKan+ZMOpamjpd+FXWzeTVPEBUWtMMQOHroz4pmqjQTtNT8
 twrpG5/03E6Zm7o7sUmPW5k=
X-Google-Smtp-Source: APXvYqxmJXOqP4WdQZNRWAH817fLo9Efmn3OiH4QFJ6y1IufYKxK2MbjMXyiFWjvqTumoNuTexQ3ag==
X-Received: by 2002:a9d:5c13:: with SMTP id o19mr9494233otk.80.1567813141623; 
 Fri, 06 Sep 2019 16:39:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id h4sm2260986oie.18.2019.09.06.16.38.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Sep 2019 16:39:00 -0700 (PDT)
Subject: Re: [PATCH v8 08/13] nvmet-core: don't check the data len for pt-ctrl
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-9-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <46920cc3-b703-134f-7a1e-f212a0ae05e7@grimberg.me>
Date: Fri, 6 Sep 2019 16:38:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-9-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190906_163905_614397_CE4A1C47 
X-CRM114-Status: UNSURE (   9.75  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Makes sense to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
