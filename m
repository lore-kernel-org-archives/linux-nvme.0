Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69619C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:35:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D180A64F11
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D180A64F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=omgL6V7OaJPBtRhMnosz50xzJ3yaBSj/rwQ11CMxqDw=; b=IvM+1y3Nprdkjl2BOrVUgZat5
	YYIYVnFMpc1p04lOzGHWLeaTmQwADjigT2ZHLfa6Cc9X9P7/CkXgOKldUlNyPve+LefNLM5gXHwks
	IjbqwCIpZ2Un2UGSsqIYQkL4JuaZTYW2hyy4Pw5dmuFsZzobQ5qRJi4tddEQdWnLBUTfz0r82dOht
	KjBv0Ru6mjT3uxGzULJSKdOJo2Bv9FnyBCvLSXOq8fomkAedbH1JyaLACq8su+sZ/FAWx2woLXQ/7
	yarkBqxTUIAX3rVoD4TUJVYGm7FVzKBjneScen0I+DoHU/qo/eYFmYzFqvm9BGjFGs5wZd0WcnucF
	+ob3DVm9w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHnCa-008dAq-GA; Thu, 04 Mar 2021 12:35:36 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHn9E-008cUD-Bz
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:32:11 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 895E2AD57;
 Thu,  4 Mar 2021 12:32:07 +0000 (UTC)
Subject: Re: [PATCH v8 06/16] lpfc: vmid: Forward declarations for APIs
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
 <1614835646-16217-7-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e2afce77-b414-bfb1-5ca6-37142c0dad21@suse.de>
Date: Thu, 4 Mar 2021 13:32:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614835646-16217-7-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
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

T24gMy80LzIxIDY6MjcgQU0sIE11bmVlbmRyYSB3cm90ZToKPiBGcm9tOiBHYXVyYXYgU3JpdmFz
dGF2YSA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20uY29tPgo+IAo+IFRoaXMgcGF0Y2ggY29u
dGFpbnMgdGhlIGZvcndhcmQgZGVjbGFyYXRpb25zIG9mIGNvbW1vbmx5IHVzZWQgQVBJcyB3aGlj
aAo+IGFyZSB1c2VkIG91dHNpZGUgdGhlIHNjb3BlIG9mIHRoZSBmaWxlLgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IEdhdXJhdiBTcml2YXN0YXZhIDxnYXVyYXYuc3JpdmFzdGF2YUBicm9hZGNvbS5jb20+
Cj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgU21hcnQgPGpzbWFydDIwMjFAZ21haWwuY29tPgo+IAo+
IC0tLQo+IHY4Ogo+IG1vZGlmeSBmdW5jdGlvbiBkZWNsYXJhdGlvbgo+IAo+IHY3Ogo+IE5vIGNo
YW5nZQo+IAo+IHY2Ogo+IE5vIGNoYW5nZQo+IAo+IHY1Ogo+IE5vIGNoYW5nZQo+IAo+IHY0Ogo+
IE5vIGNoYW5nZQo+IAo+IHYzOgo+IE5vIGNoYW5nZQo+IAo+IHYyOgo+IFBvcnRlZCB0aGUgcGF0
Y2ggb24gdG9wIG9mIDUuMTAvc2NzaS1xdWV1ZQo+IC0tLQo+ICAgZHJpdmVycy9zY3NpL2xwZmMv
bHBmY19jcnRuLmggfCAxMSArKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19jcnRuLmgg
Yi9kcml2ZXJzL3Njc2kvbHBmYy9scGZjX2NydG4uaAo+IGluZGV4IGEwYWFkNDg5NmE0NS4uNmE3
MzgxOWQ5YjZiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfY3J0bi5oCj4g
KysrIGIvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19jcnRuLmgKPiBAQCAtNjA4LDMgKzYwOCwxNCBA
QCBleHRlcm4gdW5zaWduZWQgbG9uZyBscGZjX25vX2hiYV9yZXNldFtdOwo+ICAgZXh0ZXJuIHVu
aW9uIGxwZmNfd3FlMTI4IGxwZmNfaXJlYWRfY21kX3RlbXBsYXRlOwo+ICAgZXh0ZXJuIHVuaW9u
IGxwZmNfd3FlMTI4IGxwZmNfaXdyaXRlX2NtZF90ZW1wbGF0ZTsKPiAgIGV4dGVybiB1bmlvbiBs
cGZjX3dxZTEyOCBscGZjX2ljbW5kX2NtZF90ZW1wbGF0ZTsKPiArCj4gKy8qIHZtaWQgaW50ZXJm
YWNlICovCj4gK2ludCBscGZjX3ZtaWRfdXZlbShzdHJ1Y3QgbHBmY192cG9ydCAqdnBvcnQsIHN0
cnVjdCBscGZjX3ZtaWQgKnZtaWQsIGJvb2wgaW5zKTsKPiArdWludDMyX3QgbHBmY192bWlkX2dl
dF9jc19jdGwoc3RydWN0IGxwZmNfdnBvcnQgKnZwb3J0KTsKPiAraW50IGxwZmNfdm1pZF9jbWQo
c3RydWN0IGxwZmNfdnBvcnQgKnZwb3J0LAo+ICsJCSAgaW50IGNtZGNvZGUsIHN0cnVjdCBscGZj
X3ZtaWQgKnZtaWQpOwo+ICtpbnQgbHBmY192bWlkX2hhc2hfZm4oY29uc3QgY2hhciAqdm1pZCwg
aW50IGxlbik7Cj4gK3N0cnVjdCBscGZjX3ZtaWQgKmxwZmNfZ2V0X3ZtaWRfZnJvbV9oYXN0YWJs
ZShzdHJ1Y3QgbHBmY192cG9ydCAqdnBvcnQsCj4gKwkJCQkJICAgICAgdWludDMyX3QgaGFzaCwg
dWludDhfdCAqYnVmKTsKPiArdm9pZCBscGZjX3ZtaWRfdnBvcnRfY2xlYW51cChzdHJ1Y3QgbHBm
Y192cG9ydCAqdnBvcnQpOwo+ICtpbnQgbHBmY19pc3N1ZV9lbHNfcWZwYShzdHJ1Y3QgbHBmY192
cG9ydCAqdnBvcnQpOwo+IApTYW1lIGhlcmU7IHBsZWFzZSBtZXJnZSB3aXRoIHByZXZpb3VzIHBh
dGNoLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAg
ICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBH
bWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJl
cmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlz
dApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
