Return-Path: <SRS0=oPks=75=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08186C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 15:55:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A3F207C4
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 15:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V8skXeZl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="iCqIeop8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A3F207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+t3FbMsL9FX187XIC6VolZAHeic9DsLZEmskkti/cDg=; b=V8skXeZlgtMuG/kkR7jOEc/Cc
	7zsM1JR0Diz6qQ9ra7C2ONuarj4tWPsoMqmqxObcORgouKFvwRoG6a0Fh1Z8zgg26IjMyQ67/LmmR
	GBYSIN5+tim83F89OMZJVN3p99YzGjZNeMP5gOx7xhbPE/GFxFKx/wwP+U36yxhCCss1062w6PEMz
	65+YH2hCGj77c+lGeaxwKwamLVBmgTvbAMLnFBRgIusjFKyfyRYYTHEJ/rrit70/WoVgcMIHTcmg0
	Sq6kWmIySysm0O1w2Eh9i6ADkjjIGwi4gDR2IJG7b3WpYOY2GG5iXM+pW60gh2fj53vDL8nHgE4YA
	aLfLyAXiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlDvv-0001HC-TH; Tue, 16 Jun 2020 15:55:31 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlDvt-0001GY-CJ
 for linux-nvme@lists.infradead.org; Tue, 16 Jun 2020 15:55:30 +0000
Received: by mail-ed1-x543.google.com with SMTP id y6so9379595edi.3
 for <linux-nvme@lists.infradead.org>; Tue, 16 Jun 2020 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=xEs6l5YYTY7vWmlgrA4jKAEGGbn+MWtaOcxgiTkeLQk=;
 b=iCqIeop8uWupJGMennpOIzPf38n3kpEQx4Mey9ypwVY8qEGCONkA3fUDrjiuAljUI6
 ufdFa5vVM2k8tiOyiKnxyMgiKRBJdFlsuCq9E//zPkFh1D9gNYpfidValanJwfKV/moe
 OZT+7vfQTcMfveiiBpbiN2DqiI7JTWa2wPTz4AFF5W2Qvx10SLXVoeBRKcfZYaWIwFbt
 Jd6s6FmvnVpteDtP8DDHXLsApxezLl5gJCSzoGIM/CsirGAbX/UxTCshksQnjaCNHRYl
 k7gD4V0BJiYg5fK9z1O8xd6yF7p7ANQoEuhWTbTZKe8TUFp7fPiWXo8byLJta4Cjyvpi
 5Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=xEs6l5YYTY7vWmlgrA4jKAEGGbn+MWtaOcxgiTkeLQk=;
 b=c/BiqSe7iFPlePwotT+eHp+aJi6P+vrtCWft4u03rQ2t+IFGu7rNUReujsvQaDCSDW
 AK0n9xglfG+T38nyAoxygKOraOVmIdqDLwoKR5ltjkNoar8NNpsGR5JsmAvYkloIpe/i
 12o5nv75PjD66pcDbsqXAYdvUMAY5q844Lqq9WYvcg07PuaEoxkE83vFn6iU6lhVUcfe
 sP6mjtvlW1Zz/w4zd1pn98pfMMN1+jx++Uwru5EVq2OJ8K1nn7VnEVhcGwzp794VZ0ct
 uJ5Zqe3hoFNf6MGJNCJj9PogwkWxd1AqJaNQm1M4NjINspscUvzKQ6tVuvlc8PQaoXqg
 SgfQ==
X-Gm-Message-State: AOAM533zo+C4Pcq9AiGl9ncGUdBMqoLYiESLJNAkNSjKQ5lNZMtPwcp0
 FIdm/i6SsuiVYeVwx4Lv0HD1bg==
X-Google-Smtp-Source: ABdhPJwCU0HhktxdeeAYE7dZV8sNul0cD22hMf98on+8qLbGFxigdQeQ0A6QzgR5omVM8s0X5pYJFg==
X-Received: by 2002:a05:6402:cbc:: with SMTP id
 cn28mr3266688edb.220.1592322927768; 
 Tue, 16 Jun 2020 08:55:27 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id b26sm11283494eju.6.2020.06.16.08.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 08:55:27 -0700 (PDT)
Date: Tue, 16 Jun 2020 17:55:26 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200616155526.wxjoufhhxkwet5ya@MacBook-Pro.localdomain>
References: <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_085529_467522_1C42564E 
X-CRM114-Status: UNSURE (   8.51  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Ajay Joshi <Ajay.Joshi@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <Keith.Busch@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTYuMDYuMjAyMCAwODo0OCwgS2VpdGggQnVzY2ggd3JvdGU6Cj5PbiBUdWUsIEp1biAxNiwg
MjAyMCBhdCAwNTowMjoxN1BNICswMjAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBUaGlz
IGRlcGVuZHMgdmVyeSBtdWNoIG9uIGhvdyB0aGUgRlMgLyBhcHBsaWNhdGlvbiBpcyBtYW5hZ2lu
Zwo+PiBzdHJpcHBpbmcuIEF0IHRoZSBtb21lbnQgb3VyIG1haW4gdXNlIGNhc2UgaXMgZW5hYmxp
bmcgdXNlci1zcGFjZQo+PiBhcHBsaWNhdGlvbnMgc3VibWl0dGluZyBJL09zIHRvIHJhdyBaTlMg
ZGV2aWNlcyB0aHJvdWdoIHRoZSBrZXJuZWwuCj4+Cj4+IENhbiB3ZSBlbmFibGUgdGhpcyB1c2Ug
Y2FzZSB0byBzdGFydCB3aXRoPwo+Cj5JIHRoaW5rIHRoaXMgYWxyZWFkeSBwcm92aWRlcyB0aGF0
LiBZb3UgY2FuIHNldCB0aGUgbnNpZCB2YWx1ZSB0bwo+d2hhdGV2ZXIgeW91IHdhbnQgaW4gdGhl
IHBhc3N0aHJvdWdoIGludGVyZmFjZSwgc28gYSBuYW1lc3BhY2UgYmxvY2sKPmRldmljZSBpcyBu
b3QgcmVxdWlyZWQgdG8gaXNzdWUgSS9PIHRvIGEgWk5TIG5hbWVzcGFjZSBmcm9tIHVzZXIgc3Bh
Y2UuCgpNbW1tbS4gUHJvYmxlbSBub3cgaXMgdGhhdCB0aGUgY2hlY2sgb24gdGhlIG52bWUgZHJp
dmVyIHByZXZlbnRzIHRoZSBaTlMKbmFtZXNwYWNlIGZyb20gYmVpbmcgaW5pdGlhbGl6ZWQuIEFt
IEkgbWlzc2luZyBzb21ldGhpbmc/CgpUaGFua3MsCkphdmllcgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
