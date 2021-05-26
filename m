Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC75CC47088
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 09:09:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95AC6600D1
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 09:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AC6600D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=X2lrflcA05AUW1A9nnQpJv6Q45/aPttiOrjjYmn8Cdo=; b=gr5g/0cbrlz1eLradXK2aruXVH
	OVvha/IM0XBE+fnGBISnYeFPRNyxiFCy1GptIPsXWUGl8yGidro2jI+7wUf4+ZIyX8+QPKk6V6WP8
	0C62/0db+VZTPKIOcTzFAGAOor9AGEQMCEFTevSGJGKmhA3VJVaUOWyXVw93SNEdWgG2XF7xHtBs8
	DLhaUTfuKLOMQDupWv5TJjnh9/UBQrGdV8OAB+lAN+Q0G6+hoKi9uda9i8wPIshS53kXxcGgOYtYT
	3tMLP2Hhx8veN8buvdeyPM5zdiJbLkntTVxb60pkCUMjwc97hCXCFpvC7CuswBWdemPAVkv7Ojdgq
	xffBNuAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llpXB-00CkMN-8X; Wed, 26 May 2021 09:09:01 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llpJu-00Ceho-Io
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 08:55:20 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by smtp-out1.suse.de (Postfix) with ESMTP id E1E98218CA;
 Wed, 26 May 2021 08:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622019316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=85L/mGtC5i0Hkgt7DM/dW7GFlNrDpEUtXNnI/bAvv3Y=;
 b=lIjexbK36xQNKyjBpSnn/F4Y8VOQpSyr7/eUEs/s7JsaZ/Un2MagPfEwISPCAQi2gKlFmN
 pQ60C3yIfAnYKkY0/KG5bO6gQlYmT6hokJQDqusLg8zXDm8PkL87kzd8GOfMnRJCMHzB8S
 isgFFz9g50/kKoHFSDmB6PLbIW+b3Rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622019316;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=85L/mGtC5i0Hkgt7DM/dW7GFlNrDpEUtXNnI/bAvv3Y=;
 b=akE8dUEoGun4kgutxdCfAbsjGZ6mtStez5XnlkIRG9Gvee0yHlfnDd6qu2tSD78m+pf/6c
 rMHmXXMVJ04tn4Bw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
 by imap.suse.de (Postfix) with ESMTPSA id C013611A98;
 Wed, 26 May 2021 08:55:16 +0000 (UTC)
Subject: Re: [PATCH v2 2/4] nvme-pci: limit maximum queue depth to 4095
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <20210519174340.1144806-3-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <4278e853-08b1-0005-77ba-4aa660a93786@suse.de>
Date: Wed, 26 May 2021 10:55:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210519174340.1144806-3-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_015518_825269_B0AB27E4 
X-CRM114-Status: GOOD (  20.02  )
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

T24gNS8xOS8yMSA3OjQzIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IFdlIGFyZSBnb2luZyB0
byB1c2UgdGhlIHVwcGVyIDQtYml0cyBvZiB0aGUgY29tbWFuZF9pZCBmb3IgYSBnZW5lcmF0aW9u
Cj4gY291bnRlciwgc28gZW5mb3JjZSB0aGUgbmV3IHF1ZXVlIGRlcHRoIHVwcGVyIGxpbWl0LiBB
cyB3ZSBlbmZvcmNlCj4gYm90aCBtaW4gYW5kIG1heCBxdWV1ZSBkZXB0aCwgdXNlIHBhcmFtX3Nl
dF91aW50X21pbm1heCBpc3RlYWQgb2YKPiBvcGVuIGNvZGluZyBpdC4KPiAKPiBTaWduZWQtb2Zm
LWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPgo+IC0tLQo+ICBkcml2ZXJzL252
bWUvaG9zdC9wY2kuYyB8IDE1ICsrKysrKy0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252
bWUvaG9zdC9wY2kuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCj4gaW5kZXggYTI5YjE3MDcw
MWZjLi5hYzI2ZDI0MmI2MzAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMK
PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYwo+IEBAIC02MCw2ICs2MCw4IEBAIE1PRFVM
RV9QQVJNX0RFU0Moc2dsX3RocmVzaG9sZCwKPiAgCQkiVXNlIFNHTHMgd2hlbiBhdmVyYWdlIHJl
cXVlc3Qgc2VnbWVudCBzaXplIGlzIGxhcmdlciBvciBlcXVhbCB0byAiCj4gIAkJInRoaXMgc2l6
ZS4gVXNlIDAgdG8gZGlzYWJsZSBTR0xzLiIpOwo+ICAKPiArI2RlZmluZSBOVk1FX1BDSV9NSU5f
UVVFVUVfU0laRSAyCj4gKyNkZWZpbmUgTlZNRV9QQ0lfTUFYX1FVRVVFX1NJWkUgNDA5NQo+ICBz
dGF0aWMgaW50IGlvX3F1ZXVlX2RlcHRoX3NldChjb25zdCBjaGFyICp2YWwsIGNvbnN0IHN0cnVj
dCBrZXJuZWxfcGFyYW0gKmtwKTsKPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW1f
b3BzIGlvX3F1ZXVlX2RlcHRoX29wcyA9IHsKPiAgCS5zZXQgPSBpb19xdWV1ZV9kZXB0aF9zZXQs
Cj4gQEAgLTY4LDcgKzcwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW1fb3Bz
IGlvX3F1ZXVlX2RlcHRoX29wcyA9IHsKPiAgCj4gIHN0YXRpYyB1bnNpZ25lZCBpbnQgaW9fcXVl
dWVfZGVwdGggPSAxMDI0Owo+ICBtb2R1bGVfcGFyYW1fY2IoaW9fcXVldWVfZGVwdGgsICZpb19x
dWV1ZV9kZXB0aF9vcHMsICZpb19xdWV1ZV9kZXB0aCwgMDY0NCk7Cj4gLU1PRFVMRV9QQVJNX0RF
U0MoaW9fcXVldWVfZGVwdGgsICJzZXQgaW8gcXVldWUgZGVwdGgsIHNob3VsZCA+PSAyIik7Cj4g
K01PRFVMRV9QQVJNX0RFU0MoaW9fcXVldWVfZGVwdGgsICJzZXQgaW8gcXVldWUgZGVwdGgsIHNo
b3VsZCA+PSAyIGFuZCA8IDQwOTYiKTsKPiAgCldoeSBkbyB3ZSBsaW1pdCBpdCB0byA0MDk1IChp
ZSBvbmUgbGVzcyB0aGFuIDQwOTYpLCBidXQgaGF2ZSB0aGUgZGVmYXVsdAphdCAxMDI0PwpTaG91
bGRuJ3QgdGhlIGRlZmF1bHQgYmUgb25lIGxlc3MsIHRvbz8KCkNoZWVycywKCkhhbm5lcwotLSAK
RHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFy
ZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2Fy
ZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCA5MDQwOSBOw7xybmJlcmcKR0Y6IEYuIEltZW5kw7Zy
ZmZlciwgSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==
