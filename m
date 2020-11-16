Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF30C4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:51:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F4B2419A
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3kiKejmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F4B2419A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=C8imJ+xs7X01wzPfLqlaQf7H9kKYVf+GNP4cHVlG5Mg=; b=3kiKejmqd8nk3Zns9ngFIlWnz
	/7ATnhKZ042KJF6rD+D93o2wgtEsrfRZUh3NgJU+/OFDJgu7Y+GKu1Rg5XertugDGk87ZGfZ0dbPv
	xkd+LD0B3yBj3Eq/CIlalcQfQ5jpt/vvhmYPC++ICEMPrMbmyUVM7XKFlNxQfPkn8ho0W4ceTCP/t
	TJaDXKIOJKYd32d8+1RIw1VFBmO3d5no67D17RW4s9NNpoVaQlRzBnQ7joASKiu0Wdb2b3Yg3CHC8
	1L9urAlk28R9KHb3CO3omFB5pN6JHSv6ZJgrXNJopwsrEB2lsJ8Oq/gSWSloTKJScRV56fmMoS3Nw
	Tp2cf7vuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keZHs-0005ea-EU; Mon, 16 Nov 2020 07:50:56 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keZHp-0005dm-Pl
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 07:50:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 883EEAF96;
 Mon, 16 Nov 2020 07:50:52 +0000 (UTC)
Subject: Re: [PATCH v4 07/19] lpfc: vmid: Forward declarations for APIs
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604895845-2587-8-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a88e24ae-159e-4cbc-9142-63c21cd85413@suse.de>
Date: Mon, 16 Nov 2020 08:50:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604895845-2587-8-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_025053_973073_1D2A5F97 
X-CRM114-Status: GOOD (  23.26  )
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
Cc: pbonzini@redhat.com, jsmart2021@gmail.com, mkumar@redhat.com,
 emilne@redhat.com, Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvOS8yMCA1OjIzIEFNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gRnJvbTogR2F1cmF2IFNyaXZh
c3RhdmEgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNvbT4KPiAKPiBUaGlzIHBhdGNoIGNv
bnRhaW5zIHRoZSBmb3J3YXJkIGRlY2xhcmF0aW9ucyBvZiBjb21tb25seSB1c2VkIEFQSXMgd2hp
Y2gKPiBhcmUgdXNlZCBvdXRzaWRlIHRoZSBzY29wZSBvZiB0aGUgZmlsZS4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBHYXVyYXYgU3JpdmFzdGF2YSAgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+Cj4g
Cj4gLS0tCj4gdjQ6Cj4gTm8gY2hhbmdlCj4gCj4gdjM6Cj4gTm8gY2hhbmdlCj4gCj4gdjI6Cj4g
UG9ydGVkIHRoZSBwYXRjaCBvbiB0b3Agb2YgNS4xMC9zY3NpLXF1ZXVlCj4gLS0tCj4gICBkcml2
ZXJzL3Njc2kvbHBmYy9scGZjX2NydG4uaCB8IDExICsrKysrKysrKysrCj4gICAxIGZpbGUgY2hh
bmdlZCwgMTEgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvbHBm
Yy9scGZjX2NydG4uaCBiL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfY3J0bi5oCj4gaW5kZXggNzgy
ZjZmNzZmMThhLi43NGNhNTg2MGNhOGUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9zY3NpL2xwZmMv
bHBmY19jcnRuLmgKPiArKysgYi9kcml2ZXJzL3Njc2kvbHBmYy9scGZjX2NydG4uaAo+IEBAIC02
MDAsMyArNjAwLDE0IEBAIGV4dGVybiBpbnQgbHBmY19lbmFibGVfbnZtZXRfY250Owo+ICAgZXh0
ZXJuIHVuc2lnbmVkIGxvbmcgbG9uZyBscGZjX2VuYWJsZV9udm1ldFtdOwo+ICAgZXh0ZXJuIGlu
dCBscGZjX25vX2hiYV9yZXNldF9jbnQ7Cj4gICBleHRlcm4gdW5zaWduZWQgbG9uZyBscGZjX25v
X2hiYV9yZXNldFtdOwo+ICsKPiArLyogdm1pZCBpbnRlcmZhY2UgKi8KPiAraW50IGxwZmNfdm1p
ZF91dmVtKHN0cnVjdCBscGZjX3Zwb3J0ICp2cG9ydCwgc3RydWN0IGxwZmNfdm1pZCAqdm1pZCwg
Ym9vbCBpbnMpOwo+ICt1MzIgbHBmY192bWlkX2dldF9jc19jdGwoc3RydWN0IGxwZmNfdnBvcnQg
KnZwb3J0KTsKPiAraW50IGxwZmNfdm1pZF9jbWQoc3RydWN0IGxwZmNfdnBvcnQgKnZwb3J0LAo+
ICsJCSAgaW50IGNtZGNvZGUsIHN0cnVjdCBscGZjX3ZtaWQgKnZtaWQpOwo+ICtpbnQgbHBmY192
bWlkX2hhc2hfZm4oY2hhciAqdm1pZCwgaW50IGxlbik7Cj4gK3N0cnVjdCBscGZjX3ZtaWQgKmxw
ZmNfZ2V0X3ZtaWRfZnJvbV9oYXN0YWJsZShzdHJ1Y3QgbHBmY192cG9ydCAqdnBvcnQsCj4gKwkJ
CQkJICAgICAgdTMyIGhhc2gsIHU4ICpidWYpOwo+ICt2b2lkIGxwZmNfdm1pZF92cG9ydF9jbGVh
bnVwKHN0cnVjdCBscGZjX3Zwb3J0ICp2cG9ydCk7Cj4gK2ludCBscGZjX2lzc3VlX2Vsc19xZnBh
KHN0cnVjdCBscGZjX3Zwb3J0ICp2cG9ydCk7Cj4gCnVpbnQzMl90IC4uLgoKQ2hlZXJzLAoKSGFu
bmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdl
IEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkg
OTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1
LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8
aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
