Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B631C11F66
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 12:32:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F5861D8B
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 12:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F5861D8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7j39bN0pJafVGLkgKvijZJf8QUzMwLTedqFztdOnHFc=; b=yFERaCph0cRcZGgYjylrSh5pjk
	p2E4ulG9KJzsf+4zwMTlkvpJCYwh8Kj5DJ8xSUq5bC0SMKTlTCneSyd/oXu5HcnWrEIQUjMTn6gjZ
	XfdKyZ9GvqRuFnao8KLdV5CWtOBLq1t2vc8cnTDNsh7K1GweCctMxgBToUHiluYlIo4Jby2YXbrvY
	9KoX5lnV/Ma0epyQr84MF8OtzMFByQAzEQPvYxJpfK8SaLc8tYIN6P6g0lnBGY9zjy97VC1VWzY9a
	Ow2aOIknSXJFaJ/nTib2GgHp3hFh0ymKCsl+IfGjE76SyIxSGqBLpo+t8oGTNqgyvsAQ15DVbzfzC
	aKvkIiRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyCuA-00ApNh-DB; Tue, 29 Jun 2021 12:31:54 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyCu8-00ApMQ-DU
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 12:31:53 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 25491226C5;
 Tue, 29 Jun 2021 12:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624969911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y4g4C2c4FJ507ilwRKpysNSC5KlV8Tgsj2EAb0yKOhY=;
 b=oyt0qFRI87bPzuOA/rdHaDjLT6IdTfszUqoazGxslhEhl0ZkAG92u+WxegPG1AUaOGcPlK
 tc3F4EInxgcGhb8PyGRx4aHY0GRRFawJZGAX3p/+oLXUex7Y0PPZOxhAQySi0CJrHxDqZU
 A9mf2nEZk7yXt4JcSjk8nQwnm+U3QXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624969911;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y4g4C2c4FJ507ilwRKpysNSC5KlV8Tgsj2EAb0yKOhY=;
 b=By0u6ThelRgPo7IE/L//b8hqRxCJHhfIxPxbmFDyCaTm+r/oAjvHKocO0KNzm0SjvyB3eu
 wJkEoncTSEoFJrBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 4FBE211906;
 Tue, 29 Jun 2021 12:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624969911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y4g4C2c4FJ507ilwRKpysNSC5KlV8Tgsj2EAb0yKOhY=;
 b=oyt0qFRI87bPzuOA/rdHaDjLT6IdTfszUqoazGxslhEhl0ZkAG92u+WxegPG1AUaOGcPlK
 tc3F4EInxgcGhb8PyGRx4aHY0GRRFawJZGAX3p/+oLXUex7Y0PPZOxhAQySi0CJrHxDqZU
 A9mf2nEZk7yXt4JcSjk8nQwnm+U3QXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624969911;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y4g4C2c4FJ507ilwRKpysNSC5KlV8Tgsj2EAb0yKOhY=;
 b=By0u6ThelRgPo7IE/L//b8hqRxCJHhfIxPxbmFDyCaTm+r/oAjvHKocO0KNzm0SjvyB3eu
 wJkEoncTSEoFJrBA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id flwlCbYS22AbSgAALh3uQQ
 (envelope-from <hare@suse.de>); Tue, 29 Jun 2021 12:31:50 +0000
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <aef60901-b1d0-0499-211c-b87dc0745e2d@suse.de>
Date: Tue, 29 Jun 2021 14:31:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210625101649.49296-3-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_053152_651561_87D611FB 
X-CRM114-Status: GOOD (  22.69  )
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

T24gNi8yNS8yMSAxMjoxNiBQTSwgRGFuaWVsIFdhZ25lciB3cm90ZToKPiBEbyBub3Qgd2FpdCBp
bmRpZmluaXRseSBmb3IgYWxsIHF1ZXVlcyB0byBmcmVlemUuIEluc3RlYWQgdXNlIGEKPiB0aW1l
b3V0IGFuZCBhYm9ydCB0aGUgb3BlcmF0aW9uIGlmIHdlIGdldCBzdHVjay4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+Cj4gLS0tCj4gICBkcml2ZXJz
L252bWUvaG9zdC9mYy5jIHwgOSArKysrKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hv
c3QvZmMuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMKPiBpbmRleCBhOTY0NWNkODllY2EuLmQ4
ZGI4NWFhNTQxNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9mYy5jCj4gKysrIGIv
ZHJpdmVycy9udm1lL2hvc3QvZmMuYwo+IEBAIC0yOTU1LDcgKzI5NTUsMTQgQEAgbnZtZV9mY19y
ZWNyZWF0ZV9pb19xdWV1ZXMoc3RydWN0IG52bWVfZmNfY3RybCAqY3RybCkKPiAgIAkJZGV2X2lu
Zm8oY3RybC0+Y3RybC5kZXZpY2UsCj4gICAJCQkicmVjb25uZWN0OiByZXZpc2luZyBpbyBxdWV1
ZSBjb3VudCBmcm9tICVkIHRvICVkXG4iLAo+ICAgCQkJcHJpb3JfaW9xX2NudCwgbnJfaW9fcXVl
dWVzKTsKPiAtCQludm1lX3dhaXRfZnJlZXplKCZjdHJsLT5jdHJsKTsKPiArCQlpZiAoIW52bWVf
d2FpdF9mcmVlemVfdGltZW91dCgmY3RybC0+Y3RybCwgTlZNRV9JT19USU1FT1VUKSkgewo+ICsJ
CQkvKgo+ICsJCQkgKiBJZiB3ZSB0aW1lZCBvdXQgd2FpdGluZyBmb3IgZnJlZXplIHdlIGFyZSBs
aWtlbHkgdG8KPiArCQkJICogYmUgc3R1Y2suICBGYWlsIHRoZSBjb250cm9sbGVyIGluaXRpYWxp
emF0aW9uIGp1c3QKPiArCQkJICogdG8gYmUgc2FmZS4KPiArCQkJICovCj4gKwkJCXJldHVybiAt
RU5PREVWOwo+ICsJCX0KPiAgIAkJYmxrX21xX3VwZGF0ZV9ucl9od19xdWV1ZXMoJmN0cmwtPnRh
Z19zZXQsIG5yX2lvX3F1ZXVlcyk7Cj4gICAJCW52bWVfdW5mcmVlemUoJmN0cmwtPmN0cmwpOwo+
ICAgCX0KPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hl
ZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5l
bCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhm
ZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNj
aMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
