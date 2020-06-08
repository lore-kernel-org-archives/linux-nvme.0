Return-Path: <SRS0=Onny=7V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0382CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 04:42:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCE8207C3
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 04:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nMDXGym8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCE8207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=nMDXGym8C33mYw9dQ0eypZid8
	TJr8vg+LzZ4bkPXYl/xhOchKV077T2zAdZ8QzXukBRlkaU40+fNG7ReUVWiSofcGXurIDCzzlZmAd
	9YQJvwoXvPm5RxXInBZq2exfrZdd1KzwfPUYXjwmIIM294TZOLdASN+lMde6CmdNRwMjyIvFcH3Rf
	eOSg4mOmGskJhVBamjQfs564C134+g65rDEegzof4WmsNCVKWWx0rHorFOcn0UKFPcCkOy3FLXVw7
	FJ4yTscU0vMSukJD/5ROG9Ue08ZLvC+MuiiICRkDaAKolg+kK1CAW3uW2Fy9k/qLq0Z3FTkoeZQCD
	1QcsvfQXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ji9bz-0003u4-QG; Mon, 08 Jun 2020 04:42:15 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ji9by-0003tW-6n
 for linux-nvme@lists.infradead.org; Mon, 08 Jun 2020 04:42:15 +0000
Received: by mail-pg1-f196.google.com with SMTP id s10so8227650pgm.0
 for <linux-nvme@lists.infradead.org>; Sun, 07 Jun 2020 21:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=ogpHN/ofDFxAhzd5rG6B7OVHFLiDpS3K7uVYruKfiyO7Xi/xMHtjutpsq0aTsoJ/T9
 /QI/LG5jZ7XNqO2u17iWewa1v9MwAnBmFpFXwhrPOJa6tigre6tpzfp4uIcH/6CKaEAb
 +sABifDAFDggvPIk5V1s50yqEvbre+NxcGH7jNlW0OchO+g6vTN0gqh7dwtq2HY7aB1Q
 IIaFzgqdNmgQT02Q3V04FAW0f2aYdc9Cr8DK7hEVJfPgSoN98sHc2nlhFaUxM5Mf6Ayz
 MZiqBUs68/nYJq9L/ikK1VwTrIh4HsbAK6LHXDyYqmKuqc4HOz4NzrwInapbOxV8RofD
 unEw==
X-Gm-Message-State: AOAM532CInTpGUiY5uJvQQaQxzpvFYzcO1FU9lasNIvtlemc06GB/aww
 Zdib35ZGkvGTyaV2iUJTG5hEbsAVov0=
X-Google-Smtp-Source: ABdhPJzK02RNz2PGm3x5D7KGjyZ+oukieutTm+MRazsKQULHulXca4whO7raBRwcl3Ae9h894E0Vug==
X-Received: by 2002:aa7:8a47:: with SMTP id n7mr19163268pfa.219.1591591333127; 
 Sun, 07 Jun 2020 21:42:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5183:321c:38f8:ee16?
 ([2601:647:4802:9070:5183:321c:38f8:ee16])
 by smtp.gmail.com with ESMTPSA id 73sm4737103pge.15.2020.06.07.21.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2020 21:42:11 -0700 (PDT)
Subject: Re: [PATCH] nvme: do not call del_gendisk() on a disk that was never
 added
To: Niklas Cassel <niklas.cassel@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Israel Rukshin
 <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
References: <20200607114520.130756-1-niklas.cassel@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <18b34afc-1c9c-e650-3836-cadf0b4a9fca@grimberg.me>
Date: Sun, 7 Jun 2020 21:42:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200607114520.130756-1-niklas.cassel@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200607_214214_246382_93BE9AED 
X-CRM114-Status: UNSURE (   9.88  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
