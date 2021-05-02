Return-Path: <SRS0=wOI1=J5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DE2C433B4
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 11:39:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E736D61244
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 11:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E736D61244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h42fxib/fWlnL3rvrNMlxFRq4LzXxxPa7MKAhjOijYY=; b=Jo99TQMUfSOtJmk+la3SmsFlD
	iDMyEAy0ouGxAFxhmSj83IzKV01xirSpSBYrbXoYh7dk1BFO+rxPTc9UKfPxaAN2XRlU2mqE1umIP
	ldTVpjOkzqNpJvKbloSCt0jcMSW0eleQ2zgXmHMUVVmDQ9/U38vJF7rkjVxTRkP8/8+8wQYOZoxo0
	X+lnWEhNnWfivYm8sEwzyhQvcKwhJ7DauIk0MiT+r9Qi9DVUuidbDuulilZSxP9UTeA/TsGqQuOkM
	hepndwl656MR1Mhw2OuQ+eDTCPXx59kdxineV6t+OXMb3R5pJWTpYiICT0ZPCKkKpnk7AsMEzIhYg
	ShUukqkYQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldAR9-00Bgw5-GP; Sun, 02 May 2021 11:38:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldAR6-00Bgvg-Nf
 for linux-nvme@desiato.infradead.org; Sun, 02 May 2021 11:38:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=dIac1AccxGZ/wxD4hesXFWeHBHaHz26fK8ItfNLyzsA=; b=nMFnRYP0GteJwom8HTEgJ1ut44
 XRHL9ZqKGWmVRUDXq94LKwoKtXDf5v/TIOoT7PNHBivuXHsglHl1FP+ub4F2RCWjFn7u2T46fGoQ5
 RQPotuNvBQwAYlkFc0jd22iQZ3zcktpVKvX/ELHj5j7wiOTimsBJdkzCnWU16TjKdHwF2JT/lmC/5
 Crpn1riMCK/44KHZp/Ng243XFoVFleTmUdVSGMN+JaFE0D45UOxUTOwkYtvUCSRvxGY09rzDWitSs
 vCjgNb14/TiFKFAJTSw+k2oBR8giyCfX27UiCOyHEAy2Dci2ACx4OBYDmElbmX5NgNShvv9xvz7C8
 07L7aUVA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldAR4-002VS4-5O
 for linux-nvme@lists.infradead.org; Sun, 02 May 2021 11:38:55 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CF588AD22;
 Sun,  2 May 2021 11:38:52 +0000 (UTC)
Subject: Re: [RFC PATCH v4 21/27] qedn: Add support of configuring HW filter
 block
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org
Cc: "David S . Miller davem @ davemloft . net --cc=Jakub Kicinski"
 <kuba@kernel.org>, aelior@marvell.com, mkalderon@marvell.com,
 okulkarni@marvell.com, pkushwaha@marvell.com, malin1024@gmail.com
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-22-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <cbefe381-7d00-8535-a4d7-1ac36c7aaffc@suse.de>
Date: Sun, 2 May 2021 13:38:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210429190926.5086-22-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210502_043854_365735_4585C25B 
X-CRM114-Status: GOOD (  13.02  )
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

T24gNC8yOS8yMSA5OjA5IFBNLCBTaGFpIE1hbGluIHdyb3RlOgo+IEZyb206IFByYWJoYWthciBL
dXNod2FoYSA8cGt1c2h3YWhhQG1hcnZlbGwuY29tPgo+IAo+IEhXIGZpbHRlciBjYW4gYmUgY29u
ZmlndXJlZCB0byBmaWx0ZXIgVENQIHBhY2tldHMgYmFzZWQgb24gZWl0aGVyCj4gc291cmNlIG9y
IHRhcmdldCBUQ1AgcG9ydC4gUUVETiBsZXZlcmFnZSB0aGlzIGZlYXR1cmUgdG8gcm91dGUKPiBO
Vk1lVENQIHRyYWZmaWMuCj4gCj4gVGhpcyBwYXRjaCBjb25maWd1cmVzIEhXIGZpbHRlciBibG9j
ayBiYXNlZCBvbiBzb3VyY2UgcG9ydCBmb3IgYWxsCj4gcmVjZWl2aW5nIHBhY2tldHMgdG8gZGVs
aXZlciBjb3JyZWN0IFFFRE4gUEYuCj4gCj4gQWNrZWQtYnk6IElnb3IgUnVzc2tpa2ggPGlydXNz
a2lraEBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBQcmFiaGFrYXIgS3VzaHdhaGEgPHBr
dXNod2FoYUBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBPbWthciBLdWxrYXJuaSA8b2t1
bGthcm5pQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhbCBLYWxkZXJvbiA8bWth
bGRlcm9uQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFyaWVsIEVsaW9yIDxhZWxpb3JA
bWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU2hhaSBNYWxpbiA8c21hbGluQG1hcnZlbGwu
Y29tPgo+IC0tLQo+ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbi5oICAgICAgfCAgMTUgKysr
KysKPiAgIGRyaXZlcnMvbnZtZS9ody9xZWRuL3FlZG5fbWFpbi5jIHwgMTA4ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTIyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBz
dXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAg
ICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9u
cyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xy
bmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
