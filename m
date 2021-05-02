Return-Path: <SRS0=wOI1=J5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B257C433ED
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 11:27:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00EF6101A
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 11:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00EF6101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RBadz6B12DRphLocrnj7LdJPoJpj8ZsK98tjMGnS5AU=; b=nx8Cyj8/OAqbEosBl3mVGcDl/
	Ig1vrdzRHbAQTjBj8xWXS8xi2E2Q+R/wP436AIZoClh5/o6b7eQSIjf39R+pKBOctfCrSRpUzwivR
	xacgMCOwZTm09OjfBv31qk/T7V3qzqUmskgZ5oA5p5nJEgFztOZWK8UulYzvR+Er1ItGcr80MvWW5
	bgHqqJtz3IPSb+PTP+1v9Qqy64CpMRaY773aDk11Sexgq2RWWLHhGr9E12V+A3hpD8+3hESkNvql5
	2DYfBmD2sO3Dm+redcPIc8evr0fEbzkP7FM3+Vr1HR6V2urnB2T8AsxaGcd6sX1ZTfYzjUTLNUq9B
	ZNWLY0pcA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldAFm-00BfeF-D1; Sun, 02 May 2021 11:27:14 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldAFj-00Bfds-T0
 for linux-nvme@desiato.infradead.org; Sun, 02 May 2021 11:27:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=R0+7rbbmIoqs6ncMR46H7PAPFCUPpY2bVasZNvcUIbQ=; b=DEmlpCyEkk6U93KFmeICMVf8xL
 qsb3Y7ZaiHmFInkQQkQMA24ehkPEEVVfQX0o/GAfzq/ho7RG77IbIwMTXeSbvBF3BJEfraP4blf4D
 fjinePInyiUuO7XDdqrzuuV6tNwEwWCuUerop5EydisvfTiaBLwrty/V95bkkC15lpNwFtpxXRdlh
 FTOyemAkwezPBWK22MTNtNSSLgugs9jU4CeOoBfCpYJLNzHDuPgRrDyMQaOYD8i3EJjOYfeGwUnVL
 //OYmaurPTApNu1kRnm1Cey3rxgO711E/lK8jc0PAluRNg99jf/aOb6Bjphr49DfKoLzDQJINb4TD
 AHlaYHCg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldAFh-002UwZ-99
 for linux-nvme@lists.infradead.org; Sun, 02 May 2021 11:27:10 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F13F3AE38;
 Sun,  2 May 2021 11:27:07 +0000 (UTC)
Subject: Re: [RFC PATCH v4 16/27] qedn: Add qedn - Marvell's NVMeTCP HW
 offload vendor driver
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org
Cc: "David S . Miller davem @ davemloft . net --cc=Jakub Kicinski"
 <kuba@kernel.org>, aelior@marvell.com, mkalderon@marvell.com,
 okulkarni@marvell.com, pkushwaha@marvell.com, malin1024@gmail.com,
 Arie Gershberg <agershberg@marvell.com>
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-17-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4c17c44e-a08a-93cc-5ccf-51045cba0f0f@suse.de>
Date: Sun, 2 May 2021 13:27:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210429190926.5086-17-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210502_042709_484725_52EE46B9 
X-CRM114-Status: GOOD (  19.00  )
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
cmVzZW50IHRoZSBza2VsZXRvbiBvZiB0aGUgcWVkbiBkcml2ZXIuCj4gVGhlIG5ldyBkcml2ZXIg
d2lsbCBiZSBhZGRlZCB1bmRlciAiZHJpdmVycy9udm1lL2h3L3FlZG4iIGFuZCB3aWxsIGJlCj4g
ZW5hYmxlZCBieSB0aGUgS2NvbmZpZyAiTWFydmVsbCBOVk0gRXhwcmVzcyBvdmVyIEZhYnJpY3Mg
VENQIG9mZmxvYWQiLgo+IAo+IFRoZSBpbnRlcm5hbCBpbXBsZW1lbnRhdGlvbjoKPiAtIHFlZG4u
aDoKPiAgICBJbmNsdWRlcyBhbGwgY29tbW9uIHN0cnVjdHMgdG8gYmUgdXNlZCBieSB0aGUgcWVk
biB2ZW5kb3IgZHJpdmVyLgo+IAo+IC0gcWVkbl9tYWluLmMKPiAgICBJbmNsdWRlcyB0aGUgcWVk
bl9pbml0IGFuZCBxZWRuX2NsZWFudXAgaW1wbGVtZW50YXRpb24uCj4gICAgQXMgcGFydCBvZiB0
aGUgcWVkbiBpbml0LCB0aGUgZHJpdmVyIHdpbGwgcmVnaXN0ZXIgYXMgYSBwY2kgZGV2aWNlIGFu
ZAo+ICAgIHdpbGwgd29yayB3aXRoIHRoZSBNYXJ2ZWxsIGZhc3RsaW5RIE5JQ3MuCj4gICAgQXMg
cGFydCBvZiB0aGUgcHJvYmUsIHRoZSBkcml2ZXIgd2lsbCByZWdpc3RlciB0byB0aGUgbnZtZV90
Y3Bfb2ZmbG9hZAo+ICAgIChVTFApLgo+IAo+IEFja2VkLWJ5OiBJZ29yIFJ1c3NraWtoIDxpcnVz
c2tpa2hAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQXJpZSBHZXJzaGJlcmcgPGFnZXJz
aGJlcmdAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogUHJhYmhha2FyIEt1c2h3YWhhIDxw
a3VzaHdhaGFAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogT21rYXIgS3Vsa2FybmkgPG9r
dWxrYXJuaUBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgS2FsZGVyb24gPG1r
YWxkZXJvbkBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBBcmllbCBFbGlvciA8YWVsaW9y
QG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFNoYWkgTWFsaW4gPHNtYWxpbkBtYXJ2ZWxs
LmNvbT4KPiAtLS0KPiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgIHwgIDEwICsr
Cj4gICBkcml2ZXJzL252bWUvS2NvbmZpZyAgICAgICAgICAgICB8ICAgMSArCj4gICBkcml2ZXJz
L252bWUvTWFrZWZpbGUgICAgICAgICAgICB8ICAgMSArCj4gICBkcml2ZXJzL252bWUvaHcvS2Nv
bmZpZyAgICAgICAgICB8ICAgOCArKwo+ICAgZHJpdmVycy9udm1lL2h3L01ha2VmaWxlICAgICAg
ICAgfCAgIDMgKwo+ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vTWFrZWZpbGUgICAgfCAgIDUgKwo+
ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbi5oICAgICAgfCAgMTkgKysrCj4gICBkcml2ZXJz
L252bWUvaHcvcWVkbi9xZWRuX21haW4uYyB8IDIwMSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4gICA4IGZpbGVzIGNoYW5nZWQsIDI0OCBpbnNlcnRpb25zKCspCj4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9udm1lL2h3L0tjb25maWcKPiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL252bWUvaHcvTWFrZWZpbGUKPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L252bWUvaHcvcWVkbi9NYWtlZmlsZQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbnZt
ZS9ody9xZWRuL3FlZG4uaAo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbnZtZS9ody9x
ZWRuL3FlZG5fbWFpbi5jCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNl
LmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAg
ICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBH
bWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJl
cmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlz
dApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
