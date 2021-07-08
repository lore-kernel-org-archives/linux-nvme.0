Return-Path: <SRS0=KW0X=MA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10ECC07E99
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 10:14:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67D661418
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 10:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67D661418
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3gNFpUeracgRLIw4Zlw23+6ncm1cpnMsbhP2FQFV8Gw=; b=39BOfMcv462pLodGv+mCQWz9C6
	cfUgS1lmQqg6M8eQMdxFyr4bECEfaXoOIcRdOuLKDsTPNv38oxPfSwMfkP76U0NQODnkInRBSE3yE
	v8d7Uk3U+53u+NjYkQy5ixkrvy5j3RE+592/1fhVN3K2aN8MSO7/PUuWiQJwjsCE4fa3527WgUK3Z
	i+WNsl+npO+lxljQTbZOHobs60ClT+NxmJab2h0cW/jh/uZBJdPqJPtM/tA1H1lgvuj6ModtowKbk
	MYnFpWcwPEstkUeXoj7J5pkOnYv+aGk1baqIQpkGpDeCXd5yAhlOrvNp+paah7BNio9kH/LKAWql+
	rCPVa+rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1R2s-00GadI-Q8; Thu, 08 Jul 2021 10:14:14 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1R2q-00Gaca-T5
 for linux-nvme@lists.infradead.org; Thu, 08 Jul 2021 10:14:14 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E7B12235F;
 Thu,  8 Jul 2021 10:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625739251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9fG/9l95sDD5upgyztRxQDi3j6L5c0fkrT4qgdJKZU=;
 b=Uo1LL/bhDWwVf9ZzX35a1SvIKiZ6vvxHTyHpxaHdDdVcvtbh99hK1UsTsVSk5Dy5/oK0Qh
 Htk/1Vrlpj/d075LsCT7e7x/xovt8GwO8Lf8HSZ0BXY5GrhYY6jaQrN+Xs1O8jY2a9DUR+
 yQvc4EBHdwHqqwPOuMshDlP8o7aThdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625739251;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9fG/9l95sDD5upgyztRxQDi3j6L5c0fkrT4qgdJKZU=;
 b=kumXPEHTRHLuqo/viCd1DZo3N8g0e9KN8ULaqxBMX94BUkdRAXpneRR+qxoV4acQEdlI0x
 8V0tq38EJfq5L6BQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 75DB81338E;
 Thu,  8 Jul 2021 10:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id qSCpG/PP5mC0MwAAGKfGzw
 (envelope-from <hare@suse.de>); Thu, 08 Jul 2021 10:14:11 +0000
Subject: Re: [PATCH v2 5/5] nvme-fc: Freeze queues before destroying them
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20210708092755.15660-1-dwagner@suse.de>
 <20210708092755.15660-6-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8edf09e2-52c1-5b96-6d45-ec210ffc33e1@suse.de>
Date: Thu, 8 Jul 2021 12:14:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708092755.15660-6-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210708_031413_132949_75AF51C5 
X-CRM114-Status: GOOD (  22.07  )
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

T24gNy84LzIxIDExOjI3IEFNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOgo+IG52bWVfd2FpdF9mcmVl
emVfdGltZW91dCgpIGluIG52bWVfZmNfcmVjcmVhdGVfaW9fcXVldWVzKCkgbmVlZHMgdG8gYmUK
PiBwYWlyZWQgd2l0aCBhIG52bWVfc3RhcnRfZnJlZXplKCkuIFdpdGhvdXQgZnJlZXppbmcgZmly
c3Qgd2Ugd2lsbCBhbHdheXMKPiB0aW1lb3V0IGluIG52bWVfd2FpdF9mcmVlemVfdGltZW91dCgp
Lgo+IAo+IE5vdGUgdGhlcmUgaXMgYSBzaW1pbGlhciBmaXggZm9yIFJETUEgOWY5ODc3MmJhMzA3
ICgibnZtZS1yZG1hOiBmaXgKPiBjb250cm9sbGVyIHJlc2V0IGhhbmcgZHVyaW5nIHRyYWZmaWMi
KSB3aGljaCBoYXBwZW5zIHRvIGZvbGxvdyB0aGUgUENJCj4gc3RyYXRlZ3kgaG93IHRvIGhhbmRs
ZSByZXNldHRpbmcgdGhlIHF1ZXVlcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2FnbmVy
IDxkd2FnbmVyQHN1c2UuZGU+Cj4gLS0tCj4gICBkcml2ZXJzL252bWUvaG9zdC9mYy5jIHwgMSAr
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3QvZmMuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMKPiBpbmRleCA4ZTFm
YzM3OTY3MzUuLmEzOGIwMTQ4NTkzOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9m
Yy5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvZmMuYwo+IEBAIC0zMjQ5LDYgKzMyNDksNyBA
QCBudm1lX2ZjX2RlbGV0ZV9hc3NvY2lhdGlvbihzdHJ1Y3QgbnZtZV9mY19jdHJsICpjdHJsKQo+
ICAgCQludm1lX2ZjX3htdF9sc19yc3AoZGlzbHMpOwo+ICAgCj4gICAJaWYgKGN0cmwtPmN0cmwu
dGFnc2V0KSB7Cj4gKwkJbnZtZV9zdGFydF9mcmVlemUoJmN0cmwtPmN0cmwpOwo+ICAgCQludm1l
X2ZjX2RlbGV0ZV9od19pb19xdWV1ZXMoY3RybCk7Cj4gICAJCW52bWVfZmNfZnJlZV9pb19xdWV1
ZXMoY3RybCk7Cj4gICAJfQo+IApQbGVhc2UgYWRkIGEgY29tbWVudCBoZXJlIGFib3V0IHRoZSBw
YWlyaW5nLiBXZSd2ZSBtaXNzZWQgaXQgb25jZSwgc28gd2UgCnNob3VsZCBtYWtlIGl0IGNsZWFy
IHdoeSBpdCBoYXMgdG8gYmUgcGxhY2VkIGhlcmUuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBI
YW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0Cmhh
cmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4
ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJu
YmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJ
bWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
