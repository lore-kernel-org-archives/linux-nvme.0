Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D449C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 05:48:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4866A610A2
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 05:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4866A610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oEyRFP81V+KSp9QnZ6vA7IHmkmcLovogmLNJaDy2A0c=; b=geTYwkzCvHf03aYx4skzSJ44LD
	cTIEH6P/LhoNGBgaiMLjRl2ST8RCROOzC7pVlHq7u5rd8DBlaoTnmvVwyCSfuuQlMlzbfCzl/Lmcl
	TdmZ5C5gSjL/y/Fo+AhqIVSKT0KMidTSsJfTuebUIaFhCLacDGAYeI58ujr40x/UPWt9xSy0XS2Zd
	QOGGZYNDxlYpsM77UPX8in1CuJf6M25TyPNiXNEbFJswa4MCZ+NC1HBtN2Xh7GVjboaWUrYdiJ01g
	duYE4dB+Aadum1de+n4Cd1yIpXkyuBXASErHpIUl2Jdixwe/8Ns2+8PEx+hXQOpGIZEzzU7fuAD+a
	13IdoXKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUjVA-001dNx-Qv; Mon, 27 Sep 2021 05:48:32 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUjV6-001dMP-HV
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 05:48:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 094051FF4E;
 Mon, 27 Sep 2021 05:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632721704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8sEji05pcYac50uS2f9y7kF2zF7HbkHKk3CSQyhuxZQ=;
 b=PhRKPpt+m45+7rn67w6BUWcohnZw2gj/oeIESbP451WVXTtkuCf5/Kd0K6QzDcbW6QnUjY
 XYmf3LS04HJ+92J4N5p78TMRPNe/EI0UoyGBDTLdLpYsUob/Ms00GWs8r/TddK9jOwhq/B
 8OPRZnCLYZnrgZLEmIq62xg2jITBA1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632721704;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8sEji05pcYac50uS2f9y7kF2zF7HbkHKk3CSQyhuxZQ=;
 b=hiWsxEDmCqQvtCGJcPZ4En5yglp3ya3kw4EBp4xLvVir6ZLeHSmK/RbWWWsKAZt5NnI4no
 kyoHxviCWUS8maDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9C8813A1E;
 Mon, 27 Sep 2021 05:48:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1r04MCdbUWFQCAAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 27 Sep 2021 05:48:23 +0000
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-8-hare@suse.de>
 <745c58b2-e508-25c0-f094-8d24af0631ed@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0a7e7f2a-3f62-96c3-3b04-549afb8343ff@suse.de>
Date: Mon, 27 Sep 2021 07:48:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <745c58b2-e508-25c0-f094-8d24af0631ed@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_224828_828358_641AB194 
X-CRM114-Status: GOOD (  15.69  )
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

T24gOS8yNy8yMSAxMjo1MyBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gKy8qIEFzc3Vt
ZXMgdGhhdCB0aGUgY29udHJvbGxlciBpcyBpbiBzdGF0ZSBSRVNFVFRJTkcgKi8KPj4gK3N0YXRp
YyB2b2lkIG52bWVfZGhjaGFwX2F1dGhfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4+
ICt7Cj4+ICvCoMKgwqAgc3RydWN0IG52bWVfY3RybCAqY3RybCA9Cj4+ICvCoMKgwqDCoMKgwqDC
oCBjb250YWluZXJfb2Yod29yaywgc3RydWN0IG52bWVfY3RybCwgZGhjaGFwX2F1dGhfd29yayk7
Cj4+ICvCoMKgwqAgaW50IHJldCwgcTsKPj4gKwo+IAo+IEhlcmUgSSB3b3VsZCBwcmludCBhIHNp
bmdsZToKPiAgwqDCoMKgwqBkZXZfaW5mbyhjdHJsLT5kZXZpY2UsICJyZS1hdXRoZW50aWNhdGlu
ZyBjb250cm9sbGVyIik7Cj4gCj4gVGhpcyBpcyBpbnN0ZWFkIG9mIGFsbCB0aGUgcXVldWUgcmUt
YXV0aGVudGljYXRpb24gcHJpbnRzIHRoYXQKPiBzaG91bGQgYmUgZGV2X2RiZy4KPiAKPiBMZXQn
cyBhdm9pZCBkb2luZyB0aGUgcGVyLXF1ZXVlIHByaW50Li4uCgpIbW0uIEFjdHVhbGx5IHRoZSBz
cGVjIGFsbG93cyB0byB1c2UgZGlmZmVyZW50IGtleXMgcGVyIHF1ZXVlLCBldmVuIAp0aG91Z2gg
b3VyIGltcGxlbWVudGF0aW9uIGRvZXNuJ3QuIEFuZCBmbWRzIGhhcyBzdHJ1Z2dsZWQgdG8gY29t
ZSB1cCAKd2l0aCBhIHNhbmUgdXNlY2FzZSBmb3IgdGhhdC4KQnV0IHllcywgb2theSwgd2lsbCBi
ZSB1cGRhdGluZyBpdC4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAg
ICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBT
b2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAo
QUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
