Return-Path: <SRS0=pUqL=YS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620F9CA9EA0
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 21:13:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332BA21D7B
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 21:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hYvBe6FI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332BA21D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0fdt7/qkPibUkjVVCsXnsOFTqtAgLVcsULCRBbEe4zs=; b=hYvBe6FIkVYIfl
	Cx4PfQ90xnaVrC7U1D+K8TpNqIBYXI0JSRWqL5Drg9WHbBO1/N3Hb/8nYasQmxinPkBztMMxZvyBa
	ZxnEyXylEbDDC+JRNosAy9wBwwTYj2YXaXSS6/HPmlhjVgKCiyybxACMUYbLycKyY1Irw46G2tmQV
	Mk/AoQkvysJ7bCCIhxh2K/CkLQ9gfBJ0paEIHXOKZQlGKIiBntP6lhnhige5c01k2MIrYV4f6QP6y
	xCH36yhfFWaw62gsvx86zb6ar9h9dmh9GTxZn7bPddAHhrZn815J0azbwkA42vGfkH6oXgs4jLoeo
	KbkaIpjEyMos8Wg87ScQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iO6sy-0000uX-I0; Fri, 25 Oct 2019 21:12:40 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iO6sw-0000u4-A3
 for linux-nvme@lists.infradead.org; Fri, 25 Oct 2019 21:12:39 +0000
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155])
 by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <logang@deltatee.com>)
 id 1iO6so-00082S-Ir; Fri, 25 Oct 2019 15:12:31 -0600
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20191025202535.12036-1-logang@deltatee.com>
 <20191025202535.12036-4-logang@deltatee.com>
 <28b40ab8-c695-784e-3f52-03a18b891d25@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <11006dd2-718f-b569-4ef3-c01232354d5f@deltatee.com>
Date: Fri, 25 Oct 2019 15:12:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <28b40ab8-c695-784e-3f52-03a18b891d25@grimberg.me>
Content-Language: en-US
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: hch@lst.de, maxg@mellanox.com, kbusch@kernel.org,
 sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 3/3] nvme: Introduce nvme_execute_passthru_rq_nowait()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191025_141238_678143_CAF5E8B7 
X-CRM114-Status: GOOD (  14.33  )
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
Cc: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDE5LTEwLTI1IDI6NDEgcC5tLiwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4gKyNpZmRl
ZiBDT05GSUdfTlZNRV9UQVJHRVRfUEFTU1RIUlUKPj4gK3N0YXRpYyB2b2lkIG52bWVfZXhlY3V0
ZV9wYXNzdGhydV9ycV93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqdykKPj4gK3sKPj4gK8KgwqDC
oCBzdHJ1Y3QgbnZtZV9yZXF1ZXN0ICpyZXEgPSBjb250YWluZXJfb2Yodywgc3RydWN0IG52bWVf
cmVxdWVzdCwKPj4gd29yayk7Cj4+ICvCoMKgwqAgc3RydWN0IHJlcXVlc3QgKnJxID0gYmxrX21x
X3JxX2Zyb21fcGR1KHJlcSk7Cj4+ICvCoMKgwqAgcnFfZW5kX2lvX2ZuICpkb25lID0gcnEtPmVu
ZF9pbzsKPj4gK8KgwqDCoCB2b2lkICplbmRfaW9fZGF0YSA9IHJxLT5lbmRfaW9fZGF0YTsKPiAK
PiBXaHkgaXMgZW5kX2lvX2RhdGEgc3RvcmVkIHRvIGEgbG9jYWwgdmFyaWFibGUgaGVyZT8gd2hl
cmUgaXMgaXQgc2V0PwoKYmxrX2V4ZWN1dGVfcnEoKSAod2hpY2ggaXMgY2FsbGVkIGJ5IG52bWVf
ZXhlY3V0ZV9ycSgpKSB3aWxsIG92ZXJ3cml0ZQpycS0+ZW5kaW8gYW5kIHJxLT5lbmRfaW9fZGF0
YS4gV2Ugc3RvcmUgdGhlbSBoZXJlIHNvIHdlIGNhbiBjYWxsIHRoZQpjYWxsYmFjayBhcHByb3By
aWF0ZWx5IGFmdGVyIHRoZSByZXF1ZXN0IGNvbXBsZXRlcy4gSXQgd291bGQgYmUgc2V0IGJ5CnRo
ZSBjYWxsZXIgaW4gdGhlIHNhbWUgd2F5IHRoZXkgc2V0IGl0IGlmIHRoZXkgd2VyZSBjYWxsaW5n
CmJsa19leGVjdXRlX3JxX25vd2FpdCgpLgoKPj4gKwo+PiArwqDCoMKgIG52bWVfZXhlY3V0ZV9w
YXNzdGhydV9ycShycSk7Cj4+ICsKPj4gK8KgwqDCoCBpZiAoZG9uZSkgewo+PiArwqDCoMKgwqDC
oMKgwqAgcnEtPmVuZF9pb19kYXRhID0gZW5kX2lvX2RhdGE7Cj4+ICvCoMKgwqDCoMKgwqDCoCBk
b25lKHJxLCAwKTsKPj4gK8KgwqDCoCB9Cj4+ICt9Cj4+ICsKPj4gK3ZvaWQgbnZtZV9leGVjdXRl
X3Bhc3N0aHJ1X3JxX25vd2FpdChzdHJ1Y3QgcmVxdWVzdCAqcnEsIHJxX2VuZF9pb19mbgo+PiAq
ZG9uZSkKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZV9jb21tYW5kICpjbWQgPSBudm1lX3Jl
cShycSktPmNtZDsKPj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsID0gbnZtZV9yZXEo
cnEpLT5jdHJsOwo+PiArwqDCoMKgIHN0cnVjdCBudm1lX25zICpucyA9IHJxLT5xLT5xdWV1ZWRh
dGE7Cj4+ICvCoMKgwqAgc3RydWN0IGdlbmRpc2sgKmRpc2sgPSBucyA/IG5zLT5kaXNrIDogTlVM
TDsKPj4gK8KgwqDCoCB1MzIgZWZmZWN0czsKPj4gKwo+PiArwqDCoMKgIC8qCj4+ICvCoMKgwqDC
oCAqIFRoaXMgZnVuY3Rpb24gbWF5IGJlIGNhbGxlZCBpbiBpbnRlcnJ1cHQgY29udGV4dCwgc28g
d2UgY2Fubm90Cj4+IHNsZWVwCj4+ICvCoMKgwqDCoCAqIGJ1dCBudm1lX3Bhc3N0aHJ1X1tzdGFy
dHxlbmRdKCkgbWF5IHNsZWVwIHNvIHdlIG5lZWQgdG8gZXhlY3V0ZQo+PiArwqDCoMKgwqAgKiB0
aGUgY29tbWFuZCBpbiBhIHdvcmsgcXVldWUuCj4+ICvCoMKgwqDCoCAqLwo+PiArwqDCoMKgIGVm
ZmVjdHMgPSBudm1lX2NvbW1hbmRfZWZmZWN0cyhjdHJsLCBucywgY21kLT5jb21tb24ub3Bjb2Rl
KTsKPj4gK8KgwqDCoCBpZiAoZWZmZWN0cykgewo+PiArwqDCoMKgwqDCoMKgwqAgcnEtPmVuZF9p
byA9IGRvbmU7Cj4+ICvCoMKgwqDCoMKgwqDCoCBJTklUX1dPUksoJm52bWVfcmVxKHJxKS0+d29y
aywgbnZtZV9leGVjdXRlX3Bhc3N0aHJ1X3JxX3dvcmspOwo+PiArwqDCoMKgwqDCoMKgwqAgcXVl
dWVfd29yayhudm1lX3dxLCAmbnZtZV9yZXEocnEpLT53b3JrKTsKPiAKPiBUaGlzIHdvcmsgd2ls
bCBuZWVkIHRvIGJlIGZsdXNoZWQgd2hlbiBpbiBudm1lX3N0b3BfY3RybC4gVGhhdCBpcwo+IGFz
c3VtaW5nIHRoYXQgaXQgd2lsbCBmYWlsLWZhc3QgYW5kIG5vdCBoYW5nICh3aGljaCBpdCBzaG91
bGQgZ2l2ZW4KPiB0aGF0IGl0cyBhIHBhc3N0aHJ1IGNvbW1hbmQgdGhhdCBpcyBhbGxvY2F0ZWQg
dmlhIG52bWVfYWxsb2NfcmVxdWVzdCkuCgpIbW0sIHRoYXQncyBnb2luZyB0byBiZSBhIGJpdCB0
cmlja3kuIFNlZWluZyB0aGUgd29ya19zdHJ1Y3QgYmVsb25ncwpwb3RlbnRpYWxseSB0byBhIG51
bWJlciBvZiBkaWZmZXJlbnQgcmVxdWVzdHMsIHdlIGNhbid0IGp1c3QgZmx1c2ggdGhlCmluZGl2
aWR1YWwgd29yayBpdGVtcy4gSSB0aGluayB3ZSdkIGhhdmUgdG8gY3JlYXRlIGEgd29yay1xdWV1
ZSBwZXIgY3RybAphbmQgZmx1c2ggdGhhdC4gQW55IG9iamVjdGlvbnMgdG8gdGhhdD8KCkxvZ2Fu
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
