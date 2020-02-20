Return-Path: <SRS0=sGEd=4I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F57C11D20
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 21:12:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5E320679
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 21:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iR3p02OE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5E320679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Uti3ihKqupIyH8OTDN94Ge3cPrAOAT+dXdwB5YUdRVI=; b=iR3p02OEqhArrW+BofqR1iktQ
	xK/BnxLjszPuJ0AVU9KfPBQMDlJenDpPUu/s5JLNLzNiorg0oPD+FgFKdjF2NUO8TmHDbpB5mX0o4
	KyxWWCUZ039svmEhf+Txd/6j/4f8ZlWX8tUDBQtwZQIG/iPEoLOj307DnD6nBJYYYxBY46+S0J8Dj
	VBVFJ/EzKepa0XthIFH4Xw4Wlwl5B0a5BdBfNZnitZ4iw3fHhtNEx5pNWSC62HhPHEccKeS0bYGya
	AQm19ufCN8Br9ZKFBK5MFTFzcQXlgwHwQYhK33eHZCaM6e3Lx82tLnJa03XETLhp5+kMKUhVdNkx1
	TeRrd0s0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4t7o-00030r-Ib; Thu, 20 Feb 2020 21:12:48 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4t7l-00030P-Vm
 for linux-nvme@lists.infradead.org; Thu, 20 Feb 2020 21:12:47 +0000
Received: by mail-oi1-f194.google.com with SMTP id q84so29060695oic.4
 for <linux-nvme@lists.infradead.org>; Thu, 20 Feb 2020 13:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FNySM7+ZGK3F8XQLomvkf+fLeLguxdr89jI776J+teI=;
 b=PDaxsDy2Eiapj9a27/+NQc6pn7g6oKRyA/NtgHIY7A9HOoGeyp8LT1Y091MiTtpm+S
 t7jjxmky1eFAfT61DMip8FC7H6U8jAirBvRODGZQPzIsGWnGnpG8jUBzYjonij/qvVEO
 YRCqgYtew8F/mFQfegxcuI0o80RVBglBcSPfUY2EdtqYOL6XvNBQOKuABHifOVb1vprf
 me0a0EUVePNPq2oU0WYd5dHcDHQiwWg6X7OSZRzpTiK3xtx76YjhZLzbM+HOptzW4F4T
 dLDYfwbCkWIrRZAScmzFnJwc7lfuOFo6fZA+33kdLKpWxCPX71yxue6E2Z37HWUVa38X
 tESA==
X-Gm-Message-State: APjAAAVqWsD8BwgiApldprRSFQCyPQPHERLfHz4VbMx06rR0ro+bHY10
 26x8jCQQ9zh8l1PYvafNO3g=
X-Google-Smtp-Source: APXvYqw6Ba+6qn/njDshlmqjLyu/9nimEIfELWkjMON1pMiuDCyNPWKrWvjFtu/7ak2bgZ+MmpYU0A==
X-Received: by 2002:aca:50cd:: with SMTP id e196mr3528791oib.178.1582233164694; 
 Thu, 20 Feb 2020 13:12:44 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id u66sm163103oie.17.2020.02.20.13.12.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Feb 2020 13:12:44 -0800 (PST)
Subject: Re: [PATCH] nvme-multipath: Fix memory leak with ana_log_buf
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20200220202953.26139-1-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f77a1d7e-89b8-780b-2710-3baed48519c9@grimberg.me>
Date: Thu, 20 Feb 2020 13:12:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220202953.26139-1-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200220_131246_022168_9A53EBAF 
X-CRM114-Status: GOOD (  10.48  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Keith, can you CC stable when applying?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
