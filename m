Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C157C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 04:48:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82472376E
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 04:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82472376E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XwRoFmG8R/AiCGFPLQvKvWbbqgGp1je26y2A2TynheQ=; b=FCuI0Kfs25rlW3xo3dixM1r7K
	39zEDWsG/CIlRonEI3izMP6vZxxllyGS03zf+GpCGIgRHoGohv8hUUX6vbHhfHq2AdivZJAUAwHGu
	X2oJdU5s2WAmMoVlf28EAlqo/ux/LyBEHFuMitF/vdhVRq9ugLYJNwxo8rKMenJogetDNf+YNCsJP
	1SS020g8h6B5E5XK02Vh6gAKa+a9tBOfyBaL2lRPxzwN8Xr6QgCTHbyxvD12KVau9xvq86QsrF8BQ
	K5Zm7vVRzbV4rP3v12wvZ10UXTPJT8QCXg3NaxI6JpaZq/ypEUkhFkRZpUU+SBPr+7V0jbl05J6gZ
	AEPO0FA4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzuY3-0001vX-VR; Thu, 14 Jan 2021 04:47:52 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzuY0-0001vB-BR
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 04:47:49 +0000
Received: by mail-oi1-x230.google.com with SMTP id f132so4661130oib.12
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 20:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TpaFTtQGBITkh7gnwnwRnxfc1yeL6k+ojODqTkBdYPA=;
 b=MK0ZqXZnn3bKw9+cxy1sR1SHP/E3yW9PuaOkIH/fIqpBgsM8GKRPI5uZdKuZqhGFhk
 pWB+ACP+63FDfrBvDeftcZ+ltL2iSzlOWQBW6ivxqBQ70kwRvYuEnyTIloXxc+IZ44oP
 TrzEcg9XFzCeD++U3lhpSv3RozGpGs8DLvbcMB0k+MG10TFeYB3XMaLnr91rspyu9xLU
 LZzD9lYZE4PM37HKsX9pxdHV5zClV7zYhglBK+5Q5B3lhppzBYEhkF5o6xNOi1CSR2oj
 wdb6qvJXfnaZT4r9dDRBt/QR4L9RWvhSe7EZNdDduNdwp1VMW31UZ7IynLnfsEiqQL4C
 3asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TpaFTtQGBITkh7gnwnwRnxfc1yeL6k+ojODqTkBdYPA=;
 b=jd6Ve+OEAgdjnGTnV0klXegFQi4QMj/YZMYoN572ueONRRRHNSVygraO/bM35u++9e
 cNT8BU7wHFfmOOAidJtiFxydssivaDMnYScVzX8+kS9s0egLqiQkuxEPQL28aFU0zwdK
 l/BzJDItJ2Vs7SO5oQ6994HH2kr+HH8cAG14XEgOGfiUjUBKbEV+5x+4QPLPjmssoF+h
 RuKjn7Gx7VQ1NciFZ4CvgR/yvr3Fm6U+hWTZMY9VippI/sPVD98uzJNoYzUDg5pct/5S
 akfZH0jElqwY894kGuWz/EgtGljsi8Wsdr6JbHHGL/f9MHnOIw5m2l0uDe4h4+Xz7cL1
 /0tg==
X-Gm-Message-State: AOAM533ZLRnN0o6H/DGl1t2y00Kt1O2Snt7gqargXKKGp7kg8lMdMxS5
 Orf86ALKu1cmirp5YGhamPIHpYJ68Uc=
X-Google-Smtp-Source: ABdhPJzHylTd5odVg7AypxBwPKvcXHwkdIOlKdkEMQKSV44dkjFxzolrbu8aTTH9quUDrCuiPkp9yQ==
X-Received: by 2002:aca:cfc2:: with SMTP id f185mr1602038oig.136.1610599664585; 
 Wed, 13 Jan 2021 20:47:44 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.50])
 by smtp.googlemail.com with ESMTPSA id z38sm888614ooi.34.2021.01.13.20.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 20:47:43 -0800 (PST)
Subject: Re: [PATCH v1 net-next 00/15] nvme-tcp receive offloads
To: Sagi Grimberg <sagi@grimberg.me>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <69f9a7c3-e2ab-454a-2713-2e9c9dea4e47@grimberg.me>
From: David Ahern <dsahern@gmail.com>
Message-ID: <967ae867-42c9-731d-9cb1-2c81fcc1ef77@gmail.com>
Date: Wed, 13 Jan 2021 21:47:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <69f9a7c3-e2ab-454a-2713-2e9c9dea4e47@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_234748_434654_A7DDEC77 
X-CRM114-Status: GOOD (  12.97  )
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
Cc: yorayz@nvidia.com, boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 benishay@nvidia.com, netdev@vger.kernel.org, ogerlitz@nvidia.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8xMy8yMSA2OjI3IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+PiBDaGFuZ2VzIHNpbmNl
IFJGQyB2MToKPj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPj4g
KiBTcGxpdCBtbHg1IGRyaXZlciBwYXRjaGVzIHRvIHNldmVyYWwgY29tbWl0cwo+PiAqIEZpeCBu
dm1lLXRjcCBoYW5kbGluZyBvZiByZWNvdmVyeSBmbG93cy4gSW4gcGFydGljdWxhciwgbW92ZSBx
dWV1ZQo+PiBvZmZsYW9kCj4+IMKgwqAgaW5pdC90ZWFyZG93biB0byB0aGUgc3RhcnQvc3RvcCBm
dW5jdGlvbnMuCj4gCj4gSSdtIGFzc3VtaW5nIHRoYXQgeW91IHRlc3RlZCBjb250cm9sbGVyIHJl
c2V0cyBhbmQgbmV0d29yayBoaWNjdXBzCj4gZHVyaW5nIHRyYWZmaWMgcmlnaHQ/CgpJIGhhZCBx
dWVzdGlvbnMgb24gdGhpcyBwYXJ0IGFzIHdlbGwgLS0gZS5nLiwgd2hhdCBoYXBwZW5zIG9uIGEg
VENQCnJldHJ5PyBwYWNrZXRzIGFycml2ZSwgc2dsIGZpbGxlZCBmb3IgdGhlIGNvbW1hbmQgaWQs
IGJ1dCBwYWNrZXQgaXMKZHJvcHBlZCBpbiB0aGUgc3RhY2sgKGUuZy4sIGVucXVldWUgYmFja2xv
ZyBpcyBmaWxsZWQsIHNvIHBhY2tldCBnZXRzCmRyb3BwZWQpCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
