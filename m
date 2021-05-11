Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACF7C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 17:13:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CEF661176
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 17:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEF661176
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NBBiFC/uO/dm61JCoStFwceNm8xRP7NT8kU1bwy9ikw=; b=NUl2HaY2M6f59h8CLCOovu4Nr
	MV2jeGBOpSx+DSX3fl636jeYzIyHloIWN/PpOJX6aQv1bPPW3NjuGwV6KfrcH50ZKniUgJbD5tW0t
	LrNXjDDNbjrGOt57eYWcptXYE6dhPOs7Nt06ch/bI7mPB3h8w4NKIm1dHKQWJf+qLScEsPME6K2fO
	hD/VQJR9Y+mc1avG9kdF7iBiek6r80TWClkfoFnXV11wm7LhzDlj2UpzG46Q9ItKXl3C7H8Fl1L0x
	iKinj/BEZBOfpYKubiVDix6QTSmoRT/fRR2emlfwuPUCgF7UsJvZwfmfnoazY/N5KhKa2jHUg+Pjx
	x7O+6UpNw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgVwU-000syb-Iq; Tue, 11 May 2021 17:13:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgVwR-000syL-T3
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 17:13:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=ByQTa+pg5MGboM7JgliBthjYGAJZJCDZ8+1RPZN1ZIQ=; b=HfKtkEhX/EinRwz+Rej4rPv+LX
 X6Lp1sEasIUa9zH1c3oj9gEHbbafkIlcrpfHmIOw7jDFP0w9dKqebQBjpXqeRCCSWjzo259p76NV1
 pOyvl/Wn1Lb1Nwc1cO5D/KNqEhT4WNzdGruvNcHZIQzBqFvoQL7HI93aY2E+grRj9tlSTK9Ib7HKH
 2hvdtAnRKVR3VZY8KefoxZX52ipCNUvCf8tHhw0rIM+1+ho6dyB8q5siKs5u9e66XVzsvmVPEXocj
 aIR0DsjBHNqb+qj4rOBDa2DHI+IKXWCziD4bK03w/eUzgn158RWw55yBHLo3g7KFEvykk6b0jJPx+
 B5w9/xmA==;
Received: from mail-pg1-f173.google.com ([209.85.215.173])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgVwP-009nlM-2C
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 17:13:06 +0000
Received: by mail-pg1-f173.google.com with SMTP id t193so3675431pgb.4
 for <linux-nvme@lists.infradead.org>; Tue, 11 May 2021 10:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ByQTa+pg5MGboM7JgliBthjYGAJZJCDZ8+1RPZN1ZIQ=;
 b=ZdZIlQkcY7sRT1G3DZIyHd5K2/HLoQOxDDwGbyLkMjr3L3GJ/5+R6xGCK3PWddRLYU
 nfNqiJwh2oouUlYwqaXkuNVHYVLrApidSbvUuUK/YYKqUKRRk+fQWYdLas9/3lMn7mP5
 ilCS+PD5X1QAXLFq0cv7BLypjl3Aq3AiME0y5oTPIYZbHSEFAYaVVPvWiOTlMrzuwQ9h
 //2VL5iKLYESAOX4VupaI1AUGc9rq4wFX4OKk6Mx0WxuGXcaZbqvcXlaZfZ8SXr0oYWx
 HvmkOBkBsHRv/iKa6gtv5qfH6y15wi8LvAwtTgSKBqsbfPlf5P6jZzs2fFwjLbyyrT13
 lEBA==
X-Gm-Message-State: AOAM533DCluOYnu9Cm+Ce37tOdPhMrZwQ/NFMC83vZQ21gFed4DsCR0H
 vLrDIqMtuiWipdVewxk4Jak=
X-Google-Smtp-Source: ABdhPJwGULbc7E+u3p/boTBTnqeHehUM4qEquFKTeGDdM1i/Utkp5yCARfNl1NfDkAsL5wskrSSf2g==
X-Received: by 2002:a63:7703:: with SMTP id s3mr32091150pgc.339.1620753184125; 
 Tue, 11 May 2021 10:13:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1522:1d2e:7c9d:185c?
 ([2601:647:4802:9070:1522:1d2e:7c9d:185c])
 by smtp.gmail.com with ESMTPSA id 144sm15345610pfc.101.2021.05.11.10.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 10:13:03 -0700 (PDT)
Subject: Re: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection. The
 driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
 <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <b47456a5-69ae-1f33-30f0-aa25906668f2@grimberg.me>
 <27a0071d-7c7b-ee5b-41a2-d5eb8de12928@suse.de>
 <SJ0PR19MB45446577ACEA270069ADB738F2599@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <dbb70739-e636-7f4c-7332-1fbc07332444@suse.de>
 <07fa3404-ed37-052a-c2d7-0e21c119f5c5@suse.de>
 <SJ0PR19MB4544F01520BE86D205B41B23F2589@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <b511b6a0-392f-9845-8097-1f2173085ce0@grimberg.me>
 <SJ0PR19MB4544420019D202816F4392DFF2549@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <7b0d0915-961a-0af2-7ea3-77f59cd98ef1@grimberg.me>
 <SJ0PR19MB45449EA9215D3EB116E1325CF2549@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <60aa6be0-ca88-bab8-c893-4c2b1d3f8baf@grimberg.me>
 <SJ0PR19MB45449B142BE6DC506FBABA72F2539@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9c7d43e1-e13e-43a9-8212-ff48467d3a49@grimberg.me>
Date: Tue, 11 May 2021 10:13:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB45449B142BE6DC506FBABA72F2539@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_101305_127781_BF5FA8BB 
X-CRM114-Status: GOOD (  24.53  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gSSd2ZSBiZWVuIHRoaW5raW5nIGFib3V0IHdoYXQgeW91IHNhaWQgcmVnYXJkaW5nIHRoZSBu
ZWVkIHRvIHJlcGVhdCB0aGUgLXcgb3B0aW9uIHdoZW4gdHdvIGludGVyZmFjZXMgc2hhcmUgdGhl
IHNhbWUgSVAgYWRkcmVzcy4gSSB0aGluayB3ZSdyZSBsb29raW5nIGF0IHRoZSBwcm9ibGVtIGZy
b20gYSBkaWZmZXJlbnQgcG9pbnQgb2Ygdmlldy4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24g
dXNlcyBhbiBJUCBhZGRyZXNzIHRvIGlkZW50aWZ5IGFuIGludGVyZmFjZS4gSSwgb24gdGhlIG90
aGVyIGhhbmQsIGJlbGlldmUgdGhhdCB0aGUgYmVzdCB3YXkgdG8gaWRlbnRpZnkgYW4gaW50ZXJm
YWNlIGlzIGJ5IGl0cyAiaW50ZXJmYWNlIG5hbWUgb3IgaW5kZXgiLiBJbiBwcmV2aW91cyBlbWFp
bHMsIEkgcHJvdmlkZWQgZXhhbXBsZXMgb2YgdGhlIHByb2JsZW1zIHRoYXQgbWF5IG9jY3VyIHdo
ZW4gdXNpbmcgYW4gSVAgYWRkcmVzcyB0byBpZGVudGlmeSBhbiBpbnRlcmZhY2UuIEZvciBleGFt
cGxlLCBvbmUgY2FuIGFzc2lnbiB0aGUgc2FtZSBJUCBhZGRyZXNzIHRvIGRpZmZlcmVudCBpbnRl
cmZhY2VzIG1ha2luZyBpdCBpbXBvc3NpYmxlIHRvIGRpc3Rpbmd1aXNoIGludGVyZmFjZXMgYnkg
dGhlaXIgSVAgYWRkcmVzcyBhbG9uZS4gQW5vdGhlciBleGFtcGxlIGlzIHRoYXQgdGhlIGxvdyBs
ZXZlbCBBUElzIChlLmcuIHNldHNvY2tvcHQoU09fQklORFRPREVWSUNFKSBkb27igJl0IGV2ZW4g
cmVxdWlyZSB0aGUgc291cmNlIElQIGFkZHJlc3MuIFRoZXkgb25seSBuZWVkIHRoZSBpbnRlcmZh
Y2UgbmFtZS9pbmRleC4gU28sIHdoeSBnbyB0aHJvdWdoIHRoZSB0cm91YmxlIG9mIHBlcmZvcm1p
bmcgYSByZXZlcnNlIGFkZHJlc3MgbG9va3VwIHRvIHJldHJpZXZlIHRoZSBpbnRlcmZhY2UgbmFt
ZS9pbmRleCB3aGVuIHRoZSBhZGRyZXNzIGlzIG5vdCB1c2VkIGF0IGFsbD8KPiAKPiBCeSB0aGUg
d2F5LCBpZiBudm1lLWNsaS9saW51eC1udm1lIGFsbG93ZWQgc3BlY2lmeWluZyBpbnRlcmZhY2Vz
IGJ5IG5hbWUvaW5kZXgsIHRoZW4gd2Ugd291bGQgbm90IHJlYWxseSBuZWVkIHRvIHJlcGVhdCB0
aGUgLXcgb3B0aW9uIHVubGVzcyB3ZSBhbHNvIHdhbnRlZCB0byBzZXQgdGhlIHNvdXJjZSBhZGRy
ZXNzIGF0IHRoZSBzYW1lIHRpbWUuIFNldHRpbmcgdGhlIHNvdXJjZSBhZGRyZXNzIGlzIGEgY29t
cGxldGVseSBkaWZmZXJlbnQgdGhpbmcgZnJvbSBzZXR0aW5nIHRoZSBpbnRlcmZhY2UuIE9uZSBz
aG91bGQgYmUgYWxsb3dlZCB0byBzZXQgb25lIGluZGVwZW5kZW50bHkgZnJvbSB0aGUgb3RoZXIs
IG9yIGJvdGgsIG9yIG5vbmUuCj4gCj4gSWYgeW91IGxvb2sgYXQgaG93IHBpbmcgaXMgaW1wbGVt
ZW50ZWQsIHRoZXkgZG8gbm90IGluZmVyIHRoZSBpbnRlcmZhY2UgZnJvbSB0aGUgSVAgYWRkcmVz
cy4gSWYgb25lIHdhbnRzIHRvIGZvcmNlIHBpbmcgdG8gZ28gb3ZlciBhbiBpbnRlcmZhY2UsIHRo
ZW4gb25lIG11c3QgcHJvdmlkZSB0aGUgaW50ZXJmYWNlIGJ5IG5hbWUvaW5kZXggdXNpbmcgdGhl
IC1JIG9wdGlvbi4gSWYgb25lIHdhbnRzIHRvIGNoYW5nZSB0aGUgc291cmNlIElQIGFkZHJlc3Mg
KHdpdGhvdXQgZm9yY2luZyBhIHNwZWNpZmljIGludGVyZmFjZSksIHRoZW4gb25lIHByb3ZpZGVz
IHRoZSBJUCBhZGRyZXNzIHRvIHRoZSAtSSBvcHRpb24uIEl0J3Mgc2ltcGxlIGFuZCBpbnR1aXRp
dmUuIEFuZCBwaW5nIGFsc28gc3VwcG9ydHMgYXBwZW5kaW5nIHRoZSBpbnRlcmZhY2UgdG8gdGhl
IERlc3RpbmF0aW9uIElQIHVzaW5nIHRoZSAnJScgZGVsaW1pdGVyIGZvciBJUHY2LW9ubHkgYXMg
cGVyIFJGQzQwMDcuCj4gCj4gSSB0aGluayB0aGF0IG52bWUtY2xpL2xpbnV4LW52bWUgc2hvdWxk
IGZvbGxvdyB0aGUgcGluZyBhcHByb2FjaC4gSW50ZXJmYWNlcyBzaG91bGQgbmV2ZXIgYmUgaW5m
ZXJyZWQgZnJvbSBzb3VyY2UgSVAgYWRkcmVzc2VzLCBidXQgaW5zdGVhZCBiZSBjbGVhcmx5IGlk
ZW50aWZpZWQgYnkgdGhlaXIgbmFtZSBvciBpbmRleC4gQW5kIHNldHRpbmcgdGhlIHNvdXJjZSBh
ZGRyZXNzIHNob3VsZCBiZSBpbmRlcGVuZGVudCBmcm9tIHNldHRpbmcgdGhlIGludGVyZmFjZS4K
CkknbSBzdGFydGluZyB0byB0aGluayB0aGF0IHdlIGFyZSBnb2luZyBpbiBjaXJjbGVzLCBJJ20g
Z2V0dGluZyB0bwp0aGUgcG9pbnQgdGhhdCBoYXZpbmcgaG9zdF9pZmFjZSBpcyB0aGUgcmlnaHQg
d2F5IHRvIGdvLgoKV2UgY2FuIGhhdmUgbnZtZS1jbGkgY29udmVydCA8YWRkcj4laWZhY2Ugbm90
YXRpb24gdG8KIi4uLGhvc3RfdHJhZGRyPTxhZGRyPixob3N0X2lmYWNlPTxpZmFjZT4sLi4iIHdo
ZW4gY3JlYXRpbmcgdGhlCmNvbnRyb2xsZXIgc3RyaW5nLi4uCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
