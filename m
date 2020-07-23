Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9329C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 08:06:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97CD82086A
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 08:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vNp0czJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CD82086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BrKtRLn/4NSiktbbuT4eT32hlFqEKt5wmMGzX/OeuXI=; b=vNp0czJmciTbzPdtvCZgFMbfl
	V8MhSGfeYvKArQnW1hkKzYGZmUkXKfBT72fAFNtTTVB1rLYAfQmLimty6Uvlm5n2/LgvqbpKpciJ8
	IA20B+ptg1qwUHxLABH7Zq0pRw1R92zHLKAsIq+vueRSv0qw0Ew2z+k0eZwGqaxrNMK7JL2CcV12J
	s/VEc0UOhag0saeuvJz+mDN46AymV+rSQIolvfyQnJ7gsTuzbCI8CQ7JBdxp+WSMNS0FZLbSHyqI0
	a6CAV51TjtqJCL1ZpOM93DiUGk2NCrYPqhf3+ccm+9mZTnhSim7E9zTHRzN7syOYmtvPiniN+RhDe
	B4Nkn4vUQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyWFg-0000Bx-31; Thu, 23 Jul 2020 08:06:52 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyWFc-0000BA-0X
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 08:06:49 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 06326559F49BED4A2E9E;
 Thu, 23 Jul 2020 16:06:36 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 23 Jul 2020 16:06:34 +0800
Subject: Re: [PATCH] nvme-core: reduce io pause time when fail over
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
References: <20200722093633.31347-1-lengchao@huawei.com>
 <20200722160054.GA1363519@dhcp-10-100-145-180.wdl.wdc.com>
 <973d6470-05e8-8be4-2c8b-3162f37a971e@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <fffa2b82-f933-6531-7f98-2f6269fd0d11@huawei.com>
Date: Thu, 23 Jul 2020 16:06:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <973d6470-05e8-8be4-2c8b-3162f37a971e@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_040648_387749_8509829F 
X-CRM114-Status: GOOD (  18.48  )
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
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDIwMjAvNy8yMyAwOjEzLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+PiBUbyByZWR1Y2Ug
aW8gcGF1c2UgdGltZSwgbnZtZV9zdG9wX3F1ZXVlcyB1c2UKPj4+IGJsa19tcV9xdWllc2NlX3F1
ZXVlX25vd2FpdCB0byBxdWllc2NlIHRoZSBxdWV1ZSwgbnZtZV9zdG9wX3F1ZXVlcyB3YWl0Cj4+
PiBhbGwgb25nb2luZyBkaXNwYXRjaGVzIGNvbXBsZXRlZCBhZnRlciBhbGwgcXVldWVzIGhhcyBi
ZWVuIHF1aWVzY2VkLgo+Pgo+PiBUaGUgY29tbWVudCBhYm92ZSBibGtfbXFfcXVpZXNjZV9xdWV1
ZV9ub3dhaXQoKSB3YW50cyB0byByZW1vdmUgdGhpcwo+PiBmdW5jdGlvbi4gSSdtIG5vdCBzdXJl
IHdlIHNob3VsZCBiZSBpbnRyb2R1Y2luZyBtb3JlIHVzZXJzIGlmIHRoYXQncyB0aGUKPj4gY2Fz
ZS4KPj4KPj4gVXNpbmcgc3luY2hyb25pemVfcmN1KCkgYXQgdGhlIGVuZCBtYXkgYmUgbG9va2lu
ZyB0byBtdWNoIGludG8gYmxrLW1xJ3MKPj4gaW50ZXJuYWwgcXVpZXNjZSBpbXBsZW1lbnRhdGlv
bi4gSXQgaGFwcGVucyB0byBiZSB0aGUgcmlnaHQgdGhpbmcgdG8gZG8KPj4gZm9yIG5vbi1ibG9j
a2luZyBoY3R4LCBzbyB0aGlzIHBhdGNoIGFzc3VtZXMgdGhhdCB3aWxsIGJlIHRydWUgZm9yIGFu
eQo+PiBudm1lIHJlcXVlc3RfcXVldWUuCj4KPiBudm1lLXRjcCBiZWNhbWUgYSBibG9jayBoY3R4
IHNpbmNlIHdlIG9wdGltaXplIHRvIGRvIG5ldHdvcmsgc2VuZHMgZnJvbQo+IGluc2lkZSBxdWV1
ZV9ycS4gU28gdGhpcyBzaG91bGQgZWl0aGVyIHNwbGl0IGludG8gdHdvIGZ1bmN0aW9ucyBvcgo+
IG52bWUtY29yZSBuZWVkcyB0byBsb29rIGludG8gQkxLX01RX0ZfQkxPQ0tJTkcgYW5kIGRvIHRo
ZSByaWdodCB0aGluZy4KCkFub3RoZXIgc29sdXRpb27vvJppbnRyb2R1Y2UgYmxrX21xX3F1aWVz
Y2VfcXVldWVfYXN5bmMsCmJsa19tcV9xdWllc2NlX3F1ZXVlX2FzeW5jIGRvIG5vdCB3YWl0IGFs
bCBvbmdvaW5nIGRpc3BhdGNoZXMgY29tcGxldGVkLAppZiB0aGUgaGN0eCBpcyBub3QgYmxvY2sg
aGN0eC4gVGhlIGNhbGxlciBzdWNoIGFzIG52bWVfc3RvcF9xdWV1ZXMKd2FpdCBhbGwgb25nb2lu
ZyBkaXNwYXRjaGVzIGNvbXBsZXRlZCBhZnRlciBhbGwgcXVldWVzIGhhcyBiZWVuIHF1aWVzY2Vk
LgoKLS0tCiDCoGJsb2NrL2Jsay1tcS5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyOCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiDCoGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8wqAgNSAr
KysrLQogwqBpbmNsdWRlL2xpbnV4L2Jsay1tcS5owqDCoCB8wqAgMSArCiDCoDMgZmlsZXMgY2hh
bmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Jsb2Nr
L2Jsay1tcS5jIGIvYmxvY2svYmxrLW1xLmMKaW5kZXggNGUwZDE3M2JlYWEzLi4wMDUzZmY0MmJi
NDcgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2Jsay1tcS5jCisrKyBiL2Jsb2NrL2Jsay1tcS5jCkBAIC0y
MzUsNiArMjM1LDM0IEBAIHZvaWQgYmxrX21xX3F1aWVzY2VfcXVldWUoc3RydWN0IHJlcXVlc3Rf
cXVldWUgKnEpCiDCoH0KIMKgRVhQT1JUX1NZTUJPTF9HUEwoYmxrX21xX3F1aWVzY2VfcXVldWUp
OwoKKy8qCisgKiBibGtfbXFfcXVpZXNjZV9xdWV1ZV9hc3luYygpIC0gZG8gbm90IHdhaXQgZm9y
IG5vbiBibG9jayBoY3R4CisgKiBAcTogcmVxdWVzdCBxdWV1ZS4KKyAqCisgKiBOb3RlOiB0aGlz
IGZ1bmN0aW9uIGRvIG5vdCB3YWl0IGFsbCBvbmdvaW5nIGRpc3BhdGNoZXMgY29tcGxldGVkCisg
KiBpZiB0aGUgaGN0eCBpcyBub3QgYmxvY2sgaGN0eC4gU2hvdWxkIGJlIHVzZWQgdG8gcmVkdWNl
IHdhaXQgdGltZQorICogd2hlbiBxdWllc2NlIGJhdGNoIHF1ZXVlcyBhdCB0aGUgc2FtZSB0aW1l
LiBUaGUgY2FsbGVyIHNob3VsZAorICogc3luY2hyb25vdXMgd2FpdCB1bnRpbCBhbGwgb25nb2lu
ZyBkaXNwYXRjaGVzIGhhdmUgZmluaXNoZWQKKyAqIGFmdGVyIGFsbCBxdWV1ZXMgaGFzIGJlZW4g
ZG9uZSB0aGlzLgorICovCitib29sIGJsa19tcV9xdWllc2NlX3F1ZXVlX2FzeW5jKHN0cnVjdCBy
ZXF1ZXN0X3F1ZXVlICpxKQoreworwqDCoMKgIHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4Owor
wqDCoMKgIHVuc2lnbmVkIGludCBpOworwqDCoMKgIGJvb2wgcmN1ID0gZmFsc2U7CisKK8KgwqDC
oCBibGtfbXFfcXVpZXNjZV9xdWV1ZV9ub3dhaXQocSk7CisKK8KgwqDCoCBxdWV1ZV9mb3JfZWFj
aF9od19jdHgocSwgaGN0eCwgaSkgeworwqDCoMKgIMKgwqDCoCBpZiAoaGN0eC0+ZmxhZ3MgJiBC
TEtfTVFfRl9CTE9DS0lORykKK8KgwqDCoCDCoMKgwqAgwqDCoMKgIHN5bmNocm9uaXplX3NyY3Uo
aGN0eC0+c3JjdSk7CivCoMKgwqAgwqDCoMKgIGVsc2UKK8KgwqDCoCDCoMKgwqAgwqDCoMKgIHJj
dSA9IHRydWU7CivCoMKgwqAgfQorwqDCoMKgIHJldHVybiByY3U7Cit9CitFWFBPUlRfU1lNQk9M
X0dQTChibGtfbXFfcXVpZXNjZV9xdWV1ZV9hc3luYyk7CisKIMKgLyoKIMKgICogYmxrX21xX3Vu
cXVpZXNjZV9xdWV1ZSgpIC0gY291bnRlcnBhcnQgb2YgYmxrX21xX3F1aWVzY2VfcXVldWUoKQog
wqAgKiBAcTogcmVxdWVzdCBxdWV1ZS4KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2Nv
cmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwppbmRleCBhZGQwNDAxNjhlNjcuLmExOTE1
ZjAyNzZlYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCisrKyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYwpAQCAtNDMyMCwxMSArNDMyMCwxNCBAQCBFWFBPUlRfU1lNQk9M
X0dQTChudm1lX3N0YXJ0X2ZyZWV6ZSk7CiDCoHZvaWQgbnZtZV9zdG9wX3F1ZXVlcyhzdHJ1Y3Qg
bnZtZV9jdHJsICpjdHJsKQogwqB7CiDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV9ucyAqbnM7CivCoMKg
wqAgYm9vbCByY3UgPSBmYWxzZTsKCiDCoMKgwqDCoCBkb3duX3JlYWQoJmN0cmwtPm5hbWVzcGFj
ZXNfcndzZW0pOwogwqDCoMKgwqAgbGlzdF9mb3JfZWFjaF9lbnRyeShucywgJmN0cmwtPm5hbWVz
cGFjZXMsIGxpc3QpCi3CoMKgwqAgwqDCoMKgIGJsa19tcV9xdWllc2NlX3F1ZXVlKG5zLT5xdWV1
ZSk7CivCoMKgwqAgwqDCoMKgIHJjdSA9IHJjdSB8fCBibGtfbXFfcXVpZXNjZV9xdWV1ZV9hc3lu
Yyhucy0+cXVldWUpOwogwqDCoMKgwqAgdXBfcmVhZCgmY3RybC0+bmFtZXNwYWNlc19yd3NlbSk7
CivCoMKgwqAgaWYgKHJjdSkKK8KgwqDCoCDCoMKgwqAgc3luY2hyb25pemVfcmN1KCk7CiDCoH0K
IMKgRVhQT1JUX1NZTUJPTF9HUEwobnZtZV9zdG9wX3F1ZXVlcyk7CgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9ibGstbXEuaCBiL2luY2x1ZGUvbGludXgvYmxrLW1xLmgKaW5kZXggZDZmY2Fl
MTdkYTVhLi42YWQ4M2JmZDE3YjIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvYmxrLW1xLmgK
KysrIGIvaW5jbHVkZS9saW51eC9ibGstbXEuaApAQCAtNTE1LDYgKzUxNSw3IEBAIHZvaWQgYmxr
X21xX3N0YXJ0X2h3X3F1ZXVlcyhzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSk7CiDCoHZvaWQgYmxr
X21xX3N0YXJ0X3N0b3BwZWRfaHdfcXVldWUoc3RydWN0IGJsa19tcV9od19jdHggKmhjdHgsIGJv
b2wgYXN5bmMpOwogwqB2b2lkIGJsa19tcV9zdGFydF9zdG9wcGVkX2h3X3F1ZXVlcyhzdHJ1Y3Qg
cmVxdWVzdF9xdWV1ZSAqcSwgYm9vbCBhc3luYyk7CiDCoHZvaWQgYmxrX21xX3F1aWVzY2VfcXVl
dWUoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEpOworYm9vbCBibGtfbXFfcXVpZXNjZV9xdWV1ZV9h
c3luYyhzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSk7CiDCoHZvaWQgYmxrX21xX3VucXVpZXNjZV9x
dWV1ZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSk7CiDCoHZvaWQgYmxrX21xX2RlbGF5X3J1bl9o
d19xdWV1ZShzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCwgdW5zaWduZWQgbG9uZyBtc2Vjcyk7
CiDCoHZvaWQgYmxrX21xX3J1bl9od19xdWV1ZShzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCwg
Ym9vbCBhc3luYyk7Ci0tIAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==
