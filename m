Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7435EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 08:14:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B7C2395B
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 08:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B7C2395B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rd5OdB+A/1Z0sc8ngs7PeMoA66jun1pY6kOGreT/7gs=; b=blfZwEOEEtoLf7PhFgW++6n5J
	nsOCVag/PSJKBz4JKn8gFhNPx32Am15VVn1XDSAAcvtqEu+86kNi/OT9nVVy+goKuNvkovuyy71cG
	JFnTB4KCzLsjA+q/3m4YBum+BzHLcZk9KUqWWwhVZn+KFkblawozk+/Xw54j67OA9jFEp/0Gwgb18
	6vZZYpykEQiTRSfcoRmo3IA2IHbRVRxiL3m26mxr4MCq1sJ2NoQ5nlhwxEjHlC7xhnozUyLnugar5
	bw/QMjbeI3tTnSIgD+PWVYG93CsiMxmqO7i6ATT0LvehfuMrOUZOaj7HoAXf9Ch0MTu8EWusppG81
	OlgqONG1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2V6e-0001nq-SC; Thu, 21 Jan 2021 08:14:16 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2V6c-0001mk-F6
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 08:14:15 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D9920B247
 for <linux-nvme@lists.infradead.org>; Thu, 21 Jan 2021 08:14:11 +0000 (UTC)
Subject: Re: [PATCH v2 2/6] nvme-core: introduce complete failed request
To: linux-nvme@lists.infradead.org
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-3-lengchao@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <93e16361-6973-5245-b040-692ef2ec4d79@suse.de>
Date: Thu, 21 Jan 2021 09:14:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210107033149.15701-3-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_031414_618517_8A137DDC 
X-CRM114-Status: GOOD (  23.81  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS83LzIxIDQ6MzEgQU0sIENoYW8gTGVuZyB3cm90ZToKPiBXaGVuIGEgcmVxdWVzdCBpcyBx
dWV1ZWQgZmFpbGVkLCBpZiB0aGUgZmFpbCBzdGF0dXMgaXMgbm90Cj4gQkxLX1NUU19SRVNPVVJD
RSwgQkxLX1NUU19ERVZfUkVTT1VSQ0UsIEJMS19TVFNfWk9ORV9SRVNPVVJDRSwKPiB0aGUgcmVx
dWVzdCBpcyBuZWVkIHRvIGNvbXBsZXRlIHdpdGggbnZtZV9jb21wbGV0ZV9ycSBpbiBxdWV1ZV9y
cS4KPiBTbyBpbnRyb2R1Y2UgbnZtZV90cnlfY29tcGxldGVfZmFpbGVkX3JlcS4KPiBUaGUgcmVx
dWVzdCBpcyBuZWVkZWQgdG8gY29tcGxldGUgd2l0aCBOVk1FX1NDX0hPU1RfUEFUSF9FUlJPUiBp
bgo+IG52bWZfZmFpbF9ub25yZWFkeV9jb21tYW5kIGFuZCBxdWV1ZV9ycS4KPiBTbyBpbnRyb2R1
Y2UgbnZtZV9jb21wbGV0ZV9mYWlsZWRfcmVxLgo+IEZvciBkZXRhaWxzLCBzZWUgdGhlIHN1YnNl
cXVlbnQgcGF0Y2hlcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIExlbmcgPGxlbmdjaGFvQGh1
YXdlaS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggfCAyMSArKysrKysr
KysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaCBiL2RyaXZlcnMvbnZtZS9ob3N0
L252bWUuaAo+IGluZGV4IGJmY2VkZmE0YjA1Ny4uZmM0ZWVmZGZiYjM0IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUu
aAo+IEBAIC02NDksNiArNjQ5LDI3IEBAIHZvaWQgbnZtZV9wdXRfbnNfZnJvbV9kaXNrKHN0cnVj
dCBudm1lX25zX2hlYWQgKmhlYWQsIGludCBpZHgpOwo+ICAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBh
dHRyaWJ1dGVfZ3JvdXAgKm52bWVfbnNfaWRfYXR0cl9ncm91cHNbXTsKPiAgIGV4dGVybiBjb25z
dCBzdHJ1Y3QgYmxvY2tfZGV2aWNlX29wZXJhdGlvbnMgbnZtZV9uc19oZWFkX29wczsKPiAgIAo+
ICtzdGF0aWMgaW5saW5lIHZvaWQgbnZtZV9jb21wbGV0ZV9mYWlsZWRfcmVxKHN0cnVjdCByZXF1
ZXN0ICpyZXEpCj4gK3sKPiArCW52bWVfcmVxKHJlcSktPnN0YXR1cyA9IE5WTUVfU0NfSE9TVF9Q
QVRIX0VSUk9SOwo+ICsJYmxrX21xX3NldF9yZXF1ZXN0X2NvbXBsZXRlKHJlcSk7Cj4gKwludm1l
X2NvbXBsZXRlX3JxKHJlcSk7Cj4gK30KPiArCj4gK3N0YXRpYyBpbmxpbmUgYmxrX3N0YXR1c190
IG52bWVfdHJ5X2NvbXBsZXRlX2ZhaWxlZF9yZXEoc3RydWN0IHJlcXVlc3QgKnJlcSwKPiArCQkJ
CQkJCWJsa19zdGF0dXNfdCByZXQpCj4gK3sKPiArCXN3aXRjaCAocmV0KSB7Cj4gKwljYXNlIEJM
S19TVFNfUkVTT1VSQ0U6Cj4gKwljYXNlIEJMS19TVFNfREVWX1JFU09VUkNFOgo+ICsJY2FzZSBC
TEtfU1RTX1pPTkVfUkVTT1VSQ0U6Cj4gKwkJcmV0dXJuIHJldDsKPiArCWRlZmF1bHQ6Cj4gKwkJ
bnZtZV9jb21wbGV0ZV9mYWlsZWRfcmVxKHJlcSk7Cj4gKwkJcmV0dXJuIEJMS19TVFNfT0s7Cj4g
Kwl9Cj4gK30KPiArCj4gICAjaWZkZWYgQ09ORklHX05WTUVfTVVMVElQQVRICj4gICBzdGF0aWMg
aW5saW5lIGJvb2wgbnZtZV9jdHJsX3VzZV9hbmEoc3RydWN0IG52bWVfY3RybCAqY3RybCkKPiAg
IHsKPiAKVGhpcyBpcyBub3QgY29ycmVjdC4KSE9TVF9QQVRIX0VSUk9SIG9ubHkgc2hvdWxkIGJl
IHNldCBfaWZmXyBpdCBpcyBhIHBhdGhpbmcgaXNzdWUsIGFuZCB0aGUgCkhCQS90cmFuc3BvcnQg
aXMgZXF1aXBwZWQgdG8gZGV0ZXJtaW5lIHRoYXQuCkFueSBvdGhlciBlcnJvciBoYXZlIG90aGVy
IGNhdXNlcywgYW5kIHdlIG5lZWQgdG8gbG9vayBhdCB0aGUgaW5kaXZpZHVhbCAKZXJyb3IgY29k
ZXMgKGFuZCBzaXR1YXRpb25zKSB0byBkZXRlcm1pbmUgaWYgdGhpcyByZWFsbHkgaXMgYSBwYXRo
aW5nIGVycm9yLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAg
ICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0
aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBO
w7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
