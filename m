Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060CFC636CA
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 13:58:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984A66115A
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 13:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984A66115A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nHoSPAsoLxEzHcYOA5iY0jjzRVquMwdDFXHtAsPN76k=; b=ItVkhlVEgFnkKUzQ/+LhqPr6NK
	PKqHdw7U3QAfsNHx1dqbmME912Uf7f7+y5SWNq/oCtsszb81gidCf3aS6kqah8dIBwi9iFywotLqQ
	sGHRO5P3bszhiEftTKjIHpjZg0y12IGzoKhQ62rB5Xm2Zj92gV3IoOr1LVQXQGCAi7TVaccHmbxEE
	TP8pBILW6RtmrjojXKrFrzORlpl6C/mfoQkwb6fgBMh/eG3Klp+e06GvAaAtTV9lLTTlxTH6oR39B
	2x+NHMFubvrlcH4YAuyDgIu/+C4Nfb6cWLihWLeFTfdGMHILlFdMUDdfHJVp7MnEn8jwbDUP+bzI5
	PaLKn3xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4kp2-006gpi-3h; Sat, 17 Jul 2021 13:57:40 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4koy-006gpP-8A
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 13:57:37 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 89C451FF13;
 Sat, 17 Jul 2021 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626530252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZAkIiHuPNFlhlE4mZwFNIvahXEAwXghF4bVnXz4XOk=;
 b=TG55fNTfaWsOtV0Du4Ksq67Y+o1x4Cli8KBeqLbPS1c+SFRN4Kdc8EGsou14rvLd5dXv2/
 x9qBzAnbgQomSinZx1c8tDPJJyQdYKNGcHDM7J6tvRcnSDXgjeNLozJYxyetz4fG4SKTIQ
 3cL9BAKqh6TykATGpccXgPJDfWr2Dak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626530252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZAkIiHuPNFlhlE4mZwFNIvahXEAwXghF4bVnXz4XOk=;
 b=pDjPlGS3dPUnuskvls5KIzkTBxivFm+5qxMjPhWVuNvuMT51HZUd37GBOEFjt2L+LgP5l9
 U6RqudYeVeqbtFCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 631E513A57;
 Sat, 17 Jul 2021 13:57:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 4mKBFszh8mAnXAAAGKfGzw
 (envelope-from <hare@suse.de>); Sat, 17 Jul 2021 13:57:32 +0000
Subject: Re: [PATCH 03/11] crypto/ffdhe: Finite Field DH Ephemeral Parameters
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-4-hare@suse.de>
 <3f9473c3-12c6-71c0-0744-34ea2a8a8c99@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <73e065db-7200-1409-2bd1-5a06df4404a0@suse.de>
Date: Sat, 17 Jul 2021 15:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3f9473c3-12c6-71c0-0744-34ea2a8a8c99@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210717_065736_490710_E24E0766 
X-CRM114-Status: GOOD (  22.02  )
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

T24gNy8xNy8yMSA4OjE0IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+PiBBZGQgaGVscGVyIGZ1
bmN0aW9ucyB0byBnZW5lcmF0ZW4gRmluaXRlIEZpZWxkIERIIEVwaGVtZXJhbCBQYXJhbWV0ZXJz
IGFzCj4+IHNwZWNpZmllZCBpbiBSRkMgNzkxOS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSGFubmVz
IFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+Cj4+IC0tLQo+PiDCoCBjcnlwdG8vS2NvbmZpZ8KgwqDC
oMKgwqDCoMKgwqAgfMKgwqAgOCArCj4+IMKgIGNyeXB0by9NYWtlZmlsZcKgwqDCoMKgwqDCoMKg
IHzCoMKgIDEgKwo+PiDCoCBjcnlwdG8vZmZkaGVfaGVscGVyLmPCoCB8IDg3NyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiDCoCBpbmNsdWRlL2NyeXB0by9mZmRo
ZS5oIHzCoCAyNCArKwo+PiDCoCA0IGZpbGVzIGNoYW5nZWQsIDkxMCBpbnNlcnRpb25zKCspCj4+
IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBjcnlwdG8vZmZkaGVfaGVscGVyLmMKPj4gwqAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGluY2x1ZGUvY3J5cHRvL2ZmZGhlLmgKPj4KPj4gZGlmZiAtLWdpdCBhL2Ny
eXB0by9LY29uZmlnIGIvY3J5cHRvL0tjb25maWcKPj4gaW5kZXggY2EzYjAyZGNiYmZhLi4xYmVh
NTA2YmE1NmYgMTAwNjQ0Cj4+IC0tLSBhL2NyeXB0by9LY29uZmlnCj4+ICsrKyBiL2NyeXB0by9L
Y29uZmlnCj4+IEBAIC0yMzEsNiArMjMxLDE0IEBAIGNvbmZpZyBDUllQVE9fREgKPj4gwqDCoMKg
wqDCoCBoZWxwCj4+IMKgwqDCoMKgwqDCoMKgIEdlbmVyaWMgaW1wbGVtZW50YXRpb24gb2YgdGhl
IERpZmZpZS1IZWxsbWFuIGFsZ29yaXRobS4KPj4gK2NvbmZpZyBDUllQVE9fRkZESEUKPj4gK8Kg
wqDCoCB0cmlzdGF0ZSAiRmluaXRlIEZpZWxkIERIIChSRkMgNzkxOSkgZXBoZW1lcmFsIHBhcmFt
ZXRlcnMiCj4gCj4gSSdkIHN0aWNrIHdpdGggIkRpZmZpZS1IZWxsbWFuIiBpbiB0aGUgdHJpc3Rh
dGUuCj4gCgpPay4KCj4+ICvCoMKgwqAgc2VsZWN0IENSWVBUT19ESAo+PiArwqDCoMKgIHNlbGVj
dCBDUllQVE9fS1BQCj4+ICvCoMKgwqAgc2VsZWN0IENSWVBUT19STkdfREVGQVVMVAo+PiArwqDC
oMKgIGhlbHAKPj4gK8KgwqDCoMKgwqAgR2VuZXJpYyBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgRmlu
aXRlIEZpZWxkIERIIGFsZ29yaXRobQo+IAo+IERpZmZpZS1IZWxsbWFuIGFsZ29yaXRobQo+IEFu
ZCBub3Qgc3VyZSBJJ2QgY2FsbCBpdCBhbGdvcml0aG0gaW1wbGVtZW50YXRpb24sIGJ1dCByYXRo
ZXIgYQo+IGhlbHBlciBidXQgbWF5YmUgc29tZXRoaW5nIGxpa2U6Cj4gRmluaXRlIEZpZWxkIERp
ZmZpZS1IZWxsbWFuIGVwaGVtZXJhbCBwYXJhbWV0ZXJzIGhlbHBlciBpbXBsZW1lbnRhdGlvbgo+
IAoKV2Fzbid0IHN1cmUgaG93IHRvIGNhbGwgaXQgbXlzZWxmOyBhcyBzdGF0ZWQgSSdtIG5vdCBh
IHNlY3VyaXR5IGV4cGVydC4KCj4+ICsKPj4gwqAgY29uZmlnIENSWVBUT19FQ0MKPj4gwqDCoMKg
wqDCoCB0cmlzdGF0ZQo+PiBkaWZmIC0tZ2l0IGEvY3J5cHRvL01ha2VmaWxlIGIvY3J5cHRvL01h
a2VmaWxlCj4+IGluZGV4IDEwNTI2ZDQ1NTliOC4uZDNiYzc5ZmJhMjNmIDEwMDY0NAo+PiAtLS0g
YS9jcnlwdG8vTWFrZWZpbGUKPj4gKysrIGIvY3J5cHRvL01ha2VmaWxlCj4+IEBAIC0xNzcsNiAr
MTc3LDcgQEAgb2JqLSQoQ09ORklHX0NSWVBUT19PRkIpICs9IG9mYi5vCj4+IMKgIG9iai0kKENP
TkZJR19DUllQVE9fRUNDKSArPSBlY2Mubwo+PiDCoCBvYmotJChDT05GSUdfQ1JZUFRPX0VTU0lW
KSArPSBlc3Npdi5vCj4+IMKgIG9iai0kKENPTkZJR19DUllQVE9fQ1VSVkUyNTUxOSkgKz0gY3Vy
dmUyNTUxOS1nZW5lcmljLm8KPj4gK29iai0kKENPTkZJR19DUllQVE9fRkZESEUpICs9IGZmZGhl
X2hlbHBlci5vCj4+IMKgIGVjZGhfZ2VuZXJpYy15ICs9IGVjZGgubwo+PiDCoCBlY2RoX2dlbmVy
aWMteSArPSBlY2RoX2hlbHBlci5vCj4+IGRpZmYgLS1naXQgYS9jcnlwdG8vZmZkaGVfaGVscGVy
LmMgYi9jcnlwdG8vZmZkaGVfaGVscGVyLmMKPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5kYzAyM2UzMGM0ZTUKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi9j
cnlwdG8vZmZkaGVfaGVscGVyLmMKPj4gQEAgLTAsMCArMSw4NzcgQEAKPj4gKy8qIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICovCj4+ICsvKgo+PiArICogRmluaXRl
IEZpZWxkIERIIEVwaGVtZXJhbCBQYXJhbWV0ZXJzIChSRkMgNzkxOSkKPj4gKyAqCj4+ICsgKiBD
b3B5cmlnaHQgKGMpIDIwMjEsIEhhbm5lcyBSZWluZWNrZSwgU1VTRSBTb2Z0d2FyZSBQcm9kdWN0
cwo+PiArICoKPj4gKyAqLwo+PiArCj4+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4+ICsj
aW5jbHVkZSA8Y3J5cHRvL2ludGVybmFsL2twcC5oPgo+PiArI2luY2x1ZGUgPGNyeXB0by9rcHAu
aD4KPj4gKyNpbmNsdWRlIDxjcnlwdG8vZGguaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9tcGkuaD4K
Pj4gKwo+PiArLyoKPj4gKyAqIGZmZGhlMjA0OCBnZW5lcmF0b3IgKGcpLCBtb2R1bHVzIChwKSBh
bmQgZ3JvdXAgc2l6ZSAocSkKPiAKPiBNYXliZSB3b3J0aCB0byByZWZlciBleGFjdGx5IHRoZSBz
b3VyY2Ugb2YgdGhlc2UgcGFyYW1ldGVycwo+IGluIHRoZSBjb21tZW50IGJvZHkgKHJmYyBzZWN0
aW9uL2FwcGVuZGl4KS4KPiAKClN1cmUuIFRoZXNlIGFjdHVhbGx5IGFyZSBjb3BpZXMgZnJvbSBS
RkMgNzkxOSwgc28gd2lsbCBiZSBhZGRpbmcgYSAKcmVmZXJlbmNlIHRvIGl0LgoKQ2hlZXJzLAoK
SGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9y
YWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAr
NDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3Ry
LiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRz
ZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
