Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F14C4338F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 07:25:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C283604DB
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 07:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C283604DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:From:References:Cc:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yzxRyLBucbSOv/9bC/mCYOlRrsXAHFgU4P6u+oylEeQ=; b=qrDYaeCbVrsPkpp7trkNKP3iE8
	/dTpI+8Qwrwj1kb3s9VSz1YgFyvT0flUAHE4iPaKhXikvPDjJz9ZJeRHdZqAXEgGdVlKDNjcZA6oo
	g4Jm3F2omkzR87+m8HSkA+EQHX0n24xIPmbFhnWlqm3wMQRkRCfY6YNizOIWAnxH9kSVsVIuzXr5v
	FLHXXxhpu10qfqyhlvcBbBLxZS+Pi1cc8FclPxOxC2j6jLYeCRAIWv8eVxNFtip1X/CVSNmp6gDWn
	QPewNiMKZF8IUNzWKpIz3O0PhkfUu9KtzxztP7+x10V4JniJAeMSygP+BXeLkj6sU0fvo0XZSMuKr
	c8K2Aprw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBBFt-0051Np-6z; Wed, 04 Aug 2021 07:23:57 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBBFp-0051NB-TD
 for linux-nvme@lists.infradead.org; Wed, 04 Aug 2021 07:23:55 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF9D6221AB;
 Wed,  4 Aug 2021 07:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628061829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oOGybBe6w0jPITI2UQ0wM1DQGqv5itcWuZ3umMNAP8w=;
 b=WJGE1vWvY3By2QDkuZFXHD/+c77Cw4L3VVFsFaRmxX5dPJRGFIXwen7n4RTUZJbQWD6xT0
 wG/fdnWysxqpPfIsQPLBmBmC6/9bdklpmxjyTau2svhzaMu4ZebVxVyyKBHyAjfNQ55FJu
 VRLFbbso74fbnMWU2DA6fsYOoJvt9Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628061829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oOGybBe6w0jPITI2UQ0wM1DQGqv5itcWuZ3umMNAP8w=;
 b=qKS+WgJoF9+2uSgJdPWlhycd3K8g23/KoE0nNPleM2TqwdCRGFUUmo2vg8PswODXgX6ab/
 atnuYhdv4yjPY4BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF79A139FC;
 Wed,  4 Aug 2021 07:23:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OfIeNoVACmGPdAAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 04 Aug 2021 07:23:49 +0000
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Wen Xiong <wenxiong@us.ibm.com>,
 James Smart <jsmart2021@gmail.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
Message-ID: <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
Date: Wed, 4 Aug 2021 09:23:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802112658.75875-7-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210804_002354_144454_C0EF81DE 
X-CRM114-Status: GOOD (  27.74  )
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

T24gOC8yLzIxIDE6MjYgUE0sIERhbmllbCBXYWduZXIgd3JvdGU6Cj4gRnJvbTogSmFtZXMgU21h
cnQgPGpzbWFydDIwMjFAZ21haWwuY29tPgo+IAo+IGNvbW1pdCBmZTM1ZWM1OGYwZDMgKCJibG9j
azogdXBkYXRlIGhjdHggbWFwIHdoZW4gdXNlIG11bHRpcGxlIG1hcHMiKQo+IGV4cG9zZWQgYW4g
aXNzdWUgd2hlcmUgd2UgbWF5IGhhbmcgdHJ5aW5nIHRvIHdhaXQgZm9yIHF1ZXVlIGZyZWV6ZQo+
IGR1cmluZyBJL08uIFdlIGNhbGwgYmxrX21xX3VwZGF0ZV9ucl9od19xdWV1ZXMgd2hpY2ggbWF5
IGF0dGVtcHQgdG8gZnJlZXplCj4gdGhlIHF1ZXVlLiBIb3dldmVyIHdlIG5ldmVyIHN0YXJ0ZWQg
cXVldWUgZnJlZXplIHdoZW4gc3RhcnRpbmcgdGhlCj4gcmVzZXQsIHdoaWNoIG1lYW5zIHRoYXQg
d2UgaGF2ZSBpbmZsaWdodCBwZW5kaW5nIHJlcXVlc3RzIHRoYXQgZW50ZXJlZCB0aGUKPiBxdWV1
ZSB0aGF0IHdlIHdpbGwgbm90IGNvbXBsZXRlIG9uY2UgdGhlIHF1ZXVlIGlzIHF1aWVzY2VkLgo+
IAo+IFNvIHN0YXJ0IGEgZnJlZXplIGJlZm9yZSB3ZSBxdWllc2NlIHRoZSBxdWV1ZSwgYW5kIHVu
ZnJlZXplIHRoZSBxdWV1ZQo+IGFmdGVyIHdlIHN1Y2Nlc3NmdWxseSBjb25uZWN0ZWQgdGhlIEkv
TyBxdWV1ZXMgKHRoZSB1bmZyZWV6ZSBpcyBhbHJlYWR5Cj4gcHJlc2VudCBpbiB0aGUgY29kZSku
IGJsa19tcV91cGRhdGVfbnJfaHdfcXVldWVzIHdpbGwgYmUgY2FsbGVkIG9ubHkKPiBhZnRlciB3
ZSBhcmUgc3VyZSB0aGF0IHRoZSBxdWV1ZSB3YXMgYWxyZWFkeSBmcm96ZW4uCj4gCj4gVGhpcyBm
b2xsb3dzIHRvIGhvdyB0aGUgcGNpIGRyaXZlciBoYW5kbGVzIHJlc2V0cy4KPiAKPiBUaGlzIHBh
dGNoIGFkZGVkIGxvZ2ljIGludHJvZHVjZWQgaW4gY29tbWl0IDlmOTg3NzJiYTMwNyAibnZtZS1y
ZG1hOiBmaXgKPiBjb250cm9sbGVyIHJlc2V0IGhhbmcgZHVyaW5nIHRyYWZmaWMiLgo+IAo+IFNp
Z25lZC1vZmYtYnk6IEphbWVzIFNtYXJ0IDxqc21hcnQyMDIxQGdtYWlsLmNvbT4KPiBDQzogU2Fn
aSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4KPiBbZHdhZ25lcjogY2FsbCBudm1lX3VuZnJl
ZXplKCkgdW5jb25kaXRpb25hbGx5IGluCj4gICAgICAgICAgIG52bWVfZmNfcmVjcmVhdGVfaW9f
cXVldWVzKCkgdG8gbWF0Y2ggdGhlIG52bWVfc3RhcnRfZnJlZXplKCldCj4gVGVzdGVkLWJ5OiBE
YW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+Cj4gUmV2aWV3ZWQtYnk6IERhbmllbCBXYWdu
ZXIgPGR3YWduZXJAc3VzZS5kZT4KPiAtLS0KPiAgZHJpdmVycy9udm1lL2hvc3QvZmMuYyB8IDMg
KystCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvZmMuYyBiL2RyaXZlcnMvbnZtZS9ob3N0
L2ZjLmMKPiBpbmRleCAxMzNiODdkYjRmMWQuLmIyOTJhZjBmZDY1NSAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL252bWUvaG9zdC9mYy5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvZmMuYwo+IEBA
IC0yNDg2LDYgKzI0ODYsNyBAQCBfX252bWVfZmNfYWJvcnRfb3V0c3RhbmRpbmdfaW9zKHN0cnVj
dCBudm1lX2ZjX2N0cmwgKmN0cmwsIGJvb2wgc3RhcnRfcXVldWVzKQo+ICAJICogKGJ1dCB3aXRo
IGVycm9yIHN0YXR1cykuCj4gIAkgKi8KPiAgCWlmIChjdHJsLT5jdHJsLnF1ZXVlX2NvdW50ID4g
MSkgewo+ICsJCW52bWVfc3RhcnRfZnJlZXplKCZjdHJsLT5jdHJsKTsKPiAgCQludm1lX3N0b3Bf
cXVldWVzKCZjdHJsLT5jdHJsKTsKPiAgCQludm1lX3N5bmNfaW9fcXVldWVzKCZjdHJsLT5jdHJs
KTsKPiAgCQlibGtfbXFfdGFnc2V0X2J1c3lfaXRlcigmY3RybC0+dGFnX3NldCwKPiBAQCAtMjk2
Niw4ICsyOTY3LDggQEAgbnZtZV9mY19yZWNyZWF0ZV9pb19xdWV1ZXMoc3RydWN0IG52bWVfZmNf
Y3RybCAqY3RybCkKPiAgCQkJcmV0dXJuIC1FTk9ERVY7Cj4gIAkJfQo+ICAJCWJsa19tcV91cGRh
dGVfbnJfaHdfcXVldWVzKCZjdHJsLT50YWdfc2V0LCBucl9pb19xdWV1ZXMpOwo+IC0JCW52bWVf
dW5mcmVlemUoJmN0cmwtPmN0cmwpOwo+ICAJfQo+ICsJbnZtZV91bmZyZWV6ZSgmY3RybC0+Y3Ry
bCk7Cj4gIAo+ICAJcmV0ID0gbnZtZV9mY19jcmVhdGVfaHdfaW9fcXVldWVzKGN0cmwsIGN0cmwt
PmN0cmwuc3FzaXplICsgMSk7Cj4gIAlpZiAocmV0KQo+IApUaGVyZSBzdGlsbCBpcyBub3cgYW4g
aW1iYWxhbmNlLCBhcyB3ZSdyZSBhbHdheXMgY2FsbGluZwonbnZtZV91bmZyZWV6ZSgpJyAoaXJy
ZXNwZWN0aXZlIG9uIHRoZSBudW1iZXIgb2YgcXVldWVzKSwgYnV0IHdpbGwgb25seQpjYWxsICdu
dm1lX3N0YXJ0X2ZyZWV6ZSgpJyBpZiB3ZSBoYXZlIG1vcmUgdGhhbiBvbmUgcXVldWUuCgpUaGlz
IG1pZ2h0IGxlYWQgdG8gYW4gaW1iYWxhbmNlIG9uIHRoZSBtcV9mcmVlemVfZGVwdGggY291bnRl
ci4KV291bGRuJ3QgaXQgYmUgYmV0dGVyIHRvIG1vdmUgdGhlIGNhbGwgdG8gJ252bWVfc3RhcnRf
ZnJlZXplKCknIG91dCBvZgp0aGUgaWYoKSBjb25kaXRpb24gdG8gYXZvaWQgdGhlIGltYmFsYW5j
ZT8KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICAgICBL
ZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgICAg
KzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCBN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBH
RjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
