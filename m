Return-Path: <SRS0=9Kud=5W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53A0C2BA17
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 17:03:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C71249B8
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 17:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b59E70XJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C71249B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=b59E70XJYubBT9CxloVupN3sn
	hSs2J1zUWLctmrEs9CTP3ThiByWn5nTcBcdH5xH4n8EvUGjZgVkNlOVo3nG7p5QBDBhMZeTl4xbZG
	5KzO8McV13illKScKOxLspsDFlEwzWYuGt/XR2LdVXLRn1UDr2KMih730Zt8PT4zWRNSDZ8+rtH81
	+MGfeH45jV24FPsRfPJWdOFeG24zgXrRHzX3p9FY6lgRXarJPK5XLBGTWae06Oblz2MsuAfyK8AgY
	WqJeekg5nToXx/0Qi2d5xdIzMgggaGj8vzBexjxAZ9O3gBdJbLTn2J1Q3lDPz8iiEQdhkl4a5mjva
	mOgiolAug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jLV9Y-0005lQ-3w; Mon, 06 Apr 2020 17:03:16 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLV9V-0005l7-TE
 for linux-nvme@lists.infradead.org; Mon, 06 Apr 2020 17:03:15 +0000
Received: by mail-pg1-f195.google.com with SMTP id k5so243862pga.2
 for <linux-nvme@lists.infradead.org>; Mon, 06 Apr 2020 10:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=BQCIHVknfVuXhwKkJ/1Ewv8opNQ1bVGq9y39jhpUW+1ntBRsPzeyDAs0VpPayRSStr
 sxaWGE1lVIosqpDo8aC9+0J2NVWBM6j2vpia0ReFnvAQuCIll3MVCT26tWWgkhJa8EuX
 aXnfAVYypcfAnSHTOzaTDbR8uefAbPY1JQK9L/UTS99e5iRuraR6UZjLVFTKI5A+6Gm6
 kNv+Ue4Ripp4nw30m8Xid84b8tWq/C83+4dF8oaWPJGaZVbWVD9tPlIZVTcTh4vkn9Aq
 nH4IYcxSrCtQWKgY6dksv5F+f8RFOq1mGlt83BcGGioLSqCwU+kPERrcosIIiN6Gf+Ev
 qklA==
X-Gm-Message-State: AGi0Pubx+wEz9Yn/YS2cil2cQTb3fXgTSHGqEyew2IV2kNJ/afLTAcXa
 E28SpR8ViV769ZOH1plyctWcNR21
X-Google-Smtp-Source: APiQypKeGU6SKanwaBi58OhwBRJwurk5yOLJE5qt6PgmGjHY/r/9xHdpZOyoA9GlBf/tGoZtxQ+3DQ==
X-Received: by 2002:a62:1d1:: with SMTP id 200mr471195pfb.8.1586192589946;
 Mon, 06 Apr 2020 10:03:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e891:e4b7:ccee:cfaa?
 ([2601:647:4802:9070:e891:e4b7:ccee:cfaa])
 by smtp.gmail.com with ESMTPSA id i187sm11974029pfg.33.2020.04.06.10.03.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 10:03:08 -0700 (PDT)
Subject: Re: [PATCH 1/5] nvme: refine the Qemu Identify CNS quirk
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200406121352.1151026-1-hch@lst.de>
 <20200406121352.1151026-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8dfb1b7b-986f-4e33-73f9-0adcfd0246a0@grimberg.me>
Date: Mon, 6 Apr 2020 10:03:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200406121352.1151026-2-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200406_100313_938388_C51D4FD1 
X-CRM114-Status: UNSURE (   9.06  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
