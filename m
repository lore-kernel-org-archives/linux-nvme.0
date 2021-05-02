Return-Path: <SRS0=wOI1=J5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DC1C433B4
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 11:55:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26D761106
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 11:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26D761106
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=THA3YR/QDoIj2dC0sV37SRG745HIFvHX1e/ZGV/7ZOc=; b=mQSPSzjxJIv3e6zO934t4KJjo
	jImzAL0VemeodTepQtVEHPSkyozPd4uBWQmuVne7zoA8pVCMlAc296G2FqmkU3nyiMh6P7mZFGVXa
	o9DAwolURJXY8JN+c5R4iLCloBJPiiGtqlc0ZB/dyrevSSeOcoiUB1leHm/BTh9wEgNKeqwkgV6kz
	3lh55TlmzLaSW3wQA9Qvw8h5QWa2Y3REzo96WWyvVC9KkgWPjEthZlidkl/d8U2SL9U/fWM7wrE1O
	at90OnNw8i6TeBZIzF1RdS/Uq2fIN1mbyKr7ayg/KA7Q0ggzzbCUhgwllios5Nkad2ytbTFH8dx1X
	ZEZgQTTFw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldAgm-00BiIR-Qq; Sun, 02 May 2021 11:55:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldAgh-00BiI1-Ui
 for linux-nvme@desiato.infradead.org; Sun, 02 May 2021 11:55:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=fIKD3pNtRroSNNt9zR8qdnKnYxf1YWy31w8jTGw/meQ=; b=dk+qL295BcMPtqHWfe/gsBVw5R
 IoYgWAWp7L+d/NYgtC2TizGC6nZh562eZ9f9Mdg6ZTQT8PPA4KqyVDFRBOkZ1U0BDS4zG+OSuEFgu
 ewZ8MzFNRpAQfzVBObEwvY+kyhx97hynBRTsJXR3Er4px+qpPfQePiUdeXnv08rE/CdE61FoUX9mU
 IkS59FLPPjgA9PrHZdlODb5hZX0PyaSoJcM6QcCKfjN5ot8Cv6rVPUDudzsMlyuwrHQebet4P2nxv
 yIGFsS894+QiXlzB5mvI5YByQ4ga+zu4zNboGWMGKMGXfwRngoLggUa7o9GmXA4OAwHPxlLjeLNFb
 8bl37HWg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldAge-002Vyx-FG
 for linux-nvme@lists.infradead.org; Sun, 02 May 2021 11:55:01 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 14CFBB199;
 Sun,  2 May 2021 11:54:59 +0000 (UTC)
Subject: Re: [RFC PATCH v4 25/27] qedn: Add IO level fastpath functionality
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org
Cc: "David S . Miller davem @ davemloft . net --cc=Jakub Kicinski"
 <kuba@kernel.org>, aelior@marvell.com, mkalderon@marvell.com,
 okulkarni@marvell.com, pkushwaha@marvell.com, malin1024@gmail.com
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-26-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <92c994a9-004e-55b0-b345-6c555953bab0@suse.de>
Date: Sun, 2 May 2021 13:54:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210429190926.5086-26-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210502_045500_678856_239CCF5E 
X-CRM114-Status: GOOD (  15.95  )
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

T24gNC8yOS8yMSA5OjA5IFBNLCBTaGFpIE1hbGluIHdyb3RlOgo+IFRoaXMgcGF0Y2ggd2lsbCBw
cmVzZW50IHRoZSBJTyBsZXZlbCBmdW5jdGlvbmFsaXR5IG9mIHFlZG4KPiBudm1lLXRjcC1vZmZs
b2FkIGhvc3QgbW9kZS4gVGhlIHFlZG5fdGFza19jdHggc3RydWN0dXJlIGlzIGNvbnRhaW5pbmcK
PiB2YXJpb3VzIHBhcmFtcyBhbmQgc3RhdGUgb2YgdGhlIGN1cnJlbnQgSU8sIGFuZCBpcyBtYXBw
ZWQgMXgxIHRvIHRoZQo+IGZ3X3Rhc2tfY3R4IHdoaWNoIGlzIGEgSFcgYW5kIEZXIElPIGNvbnRl
eHQuCj4gQSBxZWRuX3Rhc2sgaXMgbWFwcGVkIGRpcmVjdGx5IHRvIGl0cyBwYXJlbnQgY29ubmVj
dGlvbi4KPiBGb3IgZXZlcnkgbmV3IElPIGEgcWVkbl90YXNrIHN0cnVjdHVyZSB3aWxsIGJlIGFz
c2lnbmVkIGFuZCB0aGV5IHdpbGwgYmUKPiBsaW5rZWQgZm9yIHRoZSBlbnRpcmUgSU8ncyBsaWZl
IHNwYW4uCj4gCj4gVGhlIHBhdGNoIHdpbGwgaW5jbHVkZSAyIGZsb3dzOgo+ICAgIDEuIFNlbmQg
bmV3IGNvbW1hbmQgdG8gdGhlIEZXOgo+IAkgVGhlIGZsb3cgaXM6IG52bWVfdGNwX29mbGRfcXVl
dWVfcnEoKSB3aGljaCBpbnZva2VzIHFlZG5fc2VuZF9yZXEoKQo+IAkgd2hpY2ggaW52b2tlcyBx
ZWRuX3F1ZXVlX3JlcXVlc3QoKSB3aGljaCB3aWxsOgo+ICAgICAgIC0gQXNzaWduIGZ3X3Rhc2tf
Y3R4Lgo+IAkgLSBQcmVwYXJlIHRoZSBSZWFkL1dyaXRlIFNHIGJ1ZmZlci4KPiAJIC0gIEluaXRp
YWxpemUgdGhlIEhXIGFuZCBGVyBjb250ZXh0Lgo+IAkgLSBQYXNzIHRoZSBJTyB0byB0aGUgRlcu
Cj4gCj4gICAgMi4gUHJvY2VzcyB0aGUgSU8gY29tcGxldGlvbjoKPiAgICAgICBUaGUgZmxvdyBp
czogcWVkbl9pcnFfaGFuZGxlcigpIHdoaWNoIGludm9rZXMgcWVkbl9md19jcV9mcF9oYW5kbGVy
KCkKPiAJIHdoaWNoIGludm9rZXMgcWVkbl9pb193b3JrX2NxKCkgd2hpY2ggd2lsbDoKPiAJIC0g
cHJvY2VzcyB0aGUgRlcgY29tcGxldGlvbi4KPiAJIC0gUmV0dXJuIHRoZSBmd190YXNrX2N0eCB0
byB0aGUgdGFzayBwb29sLgo+IAkgLSBjb21wbGV0ZSB0aGUgbnZtZSByZXEuCj4gCj4gQWNrZWQt
Ynk6IElnb3IgUnVzc2tpa2ggPGlydXNza2lraEBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBQcmFiaGFrYXIgS3VzaHdhaGEgPHBrdXNod2FoYUBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2Zm
LWJ5OiBPbWthciBLdWxrYXJuaSA8b2t1bGthcm5pQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYt
Ynk6IE1pY2hhbCBLYWxkZXJvbiA8bWthbGRlcm9uQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYt
Ynk6IEFyaWVsIEVsaW9yIDxhZWxpb3JAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU2hh
aSBNYWxpbiA8c21hbGluQG1hcnZlbGwuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9udm1lL2h3L3Fl
ZG4vcWVkbi5oICAgICAgfCAgIDQgKwo+ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbl9jb25u
LmMgfCAgIDEgKwo+ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbl90YXNrLmMgfCAyNjkgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyNzIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNr
ZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tl
ICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJl
IFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5
IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
