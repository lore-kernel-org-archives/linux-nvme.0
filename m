Return-Path: <SRS0=viL0=52=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F0DC2BA2B
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 07:49:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345AA206F7
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 07:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Th6eNMtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345AA206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=Th6eNMtbJYiKVUL6Ri1ofC8Ei
	LzeSmeA4iOShit4vSexByFnlxtQbi0q5197Vqm0i2fXlv0MpC1125jwevtMdb9uWzdnyCQBm7dD43
	z7E5Cmy5Ww0eT5G/ajSS8bpTvhEu1cfaSqn5oZjAc2wkjI7ThP6/qN6fe/eoYh8TAv80OmC8QT7xZ
	7gdE8S8ZxC2MtwiAJ+3TkGNVk5TMly6iGvZGO9NDqWSoOg/FVQnlGLi7RTvRdxzhstStPP/g2GX6F
	5WRcwIib6eMEE5o33JkYK0os/Vuw7WBko7MjiI65Y7GwgtWjIuCmFRhhIhU78S6SknVPnzO33Of/x
	Otbr0zDJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMoPk-0006ST-8C; Fri, 10 Apr 2020 07:49:24 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMoPh-0006Rx-UF
 for linux-nvme@lists.infradead.org; Fri, 10 Apr 2020 07:49:23 +0000
Received: by mail-wr1-f66.google.com with SMTP id j2so1359650wrs.9
 for <linux-nvme@lists.infradead.org>; Fri, 10 Apr 2020 00:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=Skebeb/z+Q/KSMv8F9QsNEuysBEEpk80jSiVtUzd+J9KAEvWdxs9mOikMER6kiSQsT
 y1ub7zxoCGnCGt57Mbmv6xfvSlH3Ig3DFCIpdh07ARX+3WMgw/nslwtJkJnLGELRtuE4
 CF3VXtRygF4kv2/F6SZqQG8jMvWP2UfoWl9QRsgHA7/x2VnpQbhWfwwtom8rTJLlviKo
 Vu7n2cnLxBsG2BN+AfGWFYOrvU956DSkh40DPM7Ga9PZ3PH5+OuoRqku4pyaF+zokMOz
 x/2Yx/VMznBPPkKolqHV1upt24bNpzBllJRuD6sKy3dqJLG8mzL0jSG8eg4fGD372+nI
 z+mw==
X-Gm-Message-State: AGi0PuaOij/2DIZ+m7u+bIpAqjoXl9NEsz1x2BzFQTZE/5PSwe1Uq5Ji
 HoKfH1YepptIkU6Ux8MhSI0=
X-Google-Smtp-Source: APiQypLanPWZc775AFH2S7Yq00hdQFhIipgn8T4UCDdP0BoEEqpDjwFGvEk7wl1wVbtPgCsNPrhnVA==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr3344450wrk.135.1586504960555; 
 Fri, 10 Apr 2020 00:49:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9052:1641:fbba:d9ee?
 ([2601:647:4802:9070:9052:1641:fbba:d9ee])
 by smtp.gmail.com with ESMTPSA id z16sm1972438wrl.0.2020.04.10.00.49.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 00:49:19 -0700 (PDT)
Subject: Re: [PATCH 08/10] nvme: consolidate chunk_sectors settings
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200409160908.1889471-1-kbusch@kernel.org>
 <20200409160908.1889471-9-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9f493a48-41a7-09e1-ec31-98ebac2196e1@grimberg.me>
Date: Fri, 10 Apr 2020 00:49:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409160908.1889471-9-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200410_004921_972901_5F33F7DB 
X-CRM114-Status: UNSURE (   7.85  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
