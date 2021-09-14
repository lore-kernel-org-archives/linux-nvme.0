Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46765C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:20:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0222F60F44
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0222F60F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AXNuEcCRdLh0muWf664ccoP8q8AzGa2JpSwAiuBFnS0=; b=rNl2OEbsQ5qNqLQngcy8t+Vt5d
	v+5TVIN4yhdvnlXEgVGhqm/6oHKN1qXkkeRGbRw8rrx48AMcuR9yUwNCOhwp7wjX9jl1Mr4FmsTzW
	53l2cfvtUCQfQO+RtLWr1q4ciddBHnSf6lUddXbVVpOeQHdaMMRca7NAzS+59bXnaR38TGfECQU8a
	Lm2YMTLcWbGuULkYYyhUDF35Xc1Lbhj4f9MNJasWEeOBcodA7ILH22a+nviDSnSAyG5JZTJjSfMIG
	3Aon2ojITOM2F64DLyG2FQqvanb1vsPVg3nekfmM0HXuVe08XOoXyYHzjngscyYHrbrig4ww9rf3E
	FRkspXOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ2jT-004ROn-CN; Tue, 14 Sep 2021 07:19:55 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2jQ-004RNA-18
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 07:19:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 449462003A;
 Tue, 14 Sep 2021 07:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631603989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qa6FB0uYQ2RYdrHZTs6vTxf+pqm8aDnKtUrZl6NWqYA=;
 b=rtxMine2n/wlRj205bVSePa/irX65O6ydD/Qrz5clC1jOBY3u98CAXCI/dBImd5sqD6pnj
 oM3lyZ99/sBr8Vrh8joXg7kNToYGACEt6c5yxbxeA027GnnBXLKxHj/yTJkxZRCHrDrnDq
 1+HF17pH+zMKST9SXNxlrq0GxTJgfIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631603989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qa6FB0uYQ2RYdrHZTs6vTxf+pqm8aDnKtUrZl6NWqYA=;
 b=kaKLN+oGmQWiFnK0soeTOuWWuNA/16eyNkswJsQLXshLpGRk5QkxZ0R0muFhzLRbfH2eg/
 JTqzn+aVsyU/qQCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2503B13E55;
 Tue, 14 Sep 2021 07:19:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NsIJBxVNQGEqfQAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 14 Sep 2021 07:19:49 +0000
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-8-hare@suse.de>
 <99cbf790-c276-b3d0-6140-1f5bfa8665eb@grimberg.me>
 <8bff9a88-a5d4-d7bb-8ce9-81d30438bfbb@suse.de>
 <6eeae78a-a4eb-bb18-6cad-273e1a21050a@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7ea0e477-be74-80e4-a89b-9e14f5395011@suse.de>
Date: Tue, 14 Sep 2021 09:19:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <6eeae78a-a4eb-bb18-6cad-273e1a21050a@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_001952_286426_0F3EC7F2 
X-CRM114-Status: GOOD (  13.74  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOS8xNC8yMSA5OjA2IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pj4+IEBAIC0zNjEsMTEg
KzM2NiwxMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbnZtZV9lbmRfcmVxKHN0cnVjdCByZXF1ZXN0
Cj4+Pj4gKnJlcSkKPj4+PiDCoMKgIMKgIHZvaWQgbnZtZV9jb21wbGV0ZV9ycShzdHJ1Y3QgcmVx
dWVzdCAqcmVxKQo+Pj4+IMKgwqAgewo+Pj4+ICvCoMKgwqAgc3RydWN0IG52bWVfY3RybCAqY3Ry
bCA9IG52bWVfcmVxKHJlcSktPmN0cmw7Cj4+Pj4gKwo+Pj4+IMKgwqDCoMKgwqDCoCB0cmFjZV9u
dm1lX2NvbXBsZXRlX3JxKHJlcSk7Cj4+Pj4gwqDCoMKgwqDCoMKgIG52bWVfY2xlYW51cF9jbWQo
cmVxKTsKPj4+PiDCoMKgIC3CoMKgwqAgaWYgKG52bWVfcmVxKHJlcSktPmN0cmwtPmthcykKPj4+
PiAtwqDCoMKgwqDCoMKgwqAgbnZtZV9yZXEocmVxKS0+Y3RybC0+Y29tcF9zZWVuID0gdHJ1ZTsK
Pj4+PiArwqDCoMKgIGlmIChjdHJsLT5rYXMpCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGN0cmwtPmNv
bXBfc2VlbiA9IHRydWU7Cj4+Pj4gwqDCoCDCoMKgwqDCoMKgIHN3aXRjaCAobnZtZV9kZWNpZGVf
ZGlzcG9zaXRpb24ocmVxKSkgewo+Pj4+IMKgwqDCoMKgwqDCoCBjYXNlIENPTVBMRVRFOgo+Pj4+
IEBAIC0zNzcsNiArMzg0LDE1IEBAIHZvaWQgbnZtZV9jb21wbGV0ZV9ycShzdHJ1Y3QgcmVxdWVz
dCAqcmVxKQo+Pj4+IMKgwqDCoMKgwqDCoCBjYXNlIEZBSUxPVkVSOgo+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG52bWVfZmFpbG92ZXJfcmVxKHJlcSk7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuOwo+Pj4+ICvCoMKgwqAgY2FzZSBBVVRIRU5USUNBVEU6Cj4+Pj4gKyNpZmRlZiBD
T05GSUdfTlZNRV9BVVRICj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChudm1lX2NoYW5nZV9jdHJs
X3N0YXRlKGN0cmwsIE5WTUVfQ1RSTF9SRVNFVFRJTkcpKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHF1ZXVlX3dvcmsobnZtZV93cSwgJmN0cmwtPmRoY2hhcF9hdXRoX3dvcmspOwo+Pj4K
Pj4+IFdoeSBpcyB0aGUgc3RhdGUgY2hhbmdlIGhlcmUgYW5kIG5vdCBpbiBudm1lX2RoY2hhcF9h
dXRoX3dvcms/Cj4+Pgo+PiBCZWNhdXNlIHN3aXRjaGluZyB0byAncmVzZXR0aW5nJyBpcyBhbiBl
YXN5IHdheSB0byBzeW5jaHJvbml6ZSB3aXRoIHRoZQo+PiBhZG1pbiBxdWV1ZS4KPiAKPiBNYXli
ZSBmb2xkIHRoaXMgaW50byBudm1lX2F1dGhlbnRpY2F0ZV9jdHJsPyBpbiBjYXNlIHNvbWVvbmUg
YWRkcy9tb3Zlcwo+IHRoaXMgaW4gdGhlIGZ1dHVyZSBhbmQgZm9yZ2V0cyB0aGUgY3RybCBzdGF0
ZSBzZXJpYWxpemF0aW9uPwoKWWVhaDsgbm90IGEgYmFkIGlkZWEuIFdpbGwgYmUgbG9va2luZyBp
bnRvIGl0LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAg
ICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAg
ICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdt
YkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVy
ZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
