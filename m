Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1FAC432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 17:14:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3364860F42
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 17:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3364860F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qRuR/96zKWqO0KdjjkKmxpcAxBJp1pXT9HO9PUQjviY=; b=ZLmklp21Widkpot4ovKu8WbnWJ
	49+QYcsteyiJ0/UlxrJlxlnDb24umUht+Nnn9XnuCP1hOvLijhixh4yLwqs1Ej7CoVZGngnqhL/95
	fCPTHH4CDOAIB0Rf3wUL7LRhTqX7Xwh7kDnUG9vjSUlbQsmbAJ7joBgfWdDlEz2e9QCmCfnSGK87d
	C2i3pymIgDsJVfoAAdEbSXsBRSI4/UMEZV1anCl+mbgjLyjCjx5EfRFZMDGeM/qBzsjeV3qtVSIos
	67vnvcxCS4em5Zq/MVasw5PRiPsFqbgc/LsK6WPjxulA9ByPVdTjg6nDpErNBWGVFHWORcZv2m7PZ
	JZbB8Lwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKkrQ-000A3L-T8; Mon, 30 Aug 2021 17:14:16 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKkrL-000A2X-6a
 for linux-nvme@lists.infradead.org; Mon, 30 Aug 2021 17:14:15 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8446A220E5;
 Mon, 30 Aug 2021 17:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630343647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHehU4xksFs9Gy3dRgH/qv027selH0oP9fNeJb3sQhY=;
 b=X+ElkcdXgEdT2FDRlqsJtsN4AkaN5LS5dtyc8KtmHPqESK+Lf+TrEGGLOWC7KERLFzYSG5
 V2FMbaUaEmws46JjiPCtifF0WNGEZ59oKTEN9gwD02y2tI9QkILBeuMHv+Q0DstyUOcxP1
 G4i34uSM++hurFY7LAjKKycA/dTtCzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630343647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHehU4xksFs9Gy3dRgH/qv027selH0oP9fNeJb3sQhY=;
 b=72bmKQESOjtRUVDv7C1TveyTVR7sd8xGZJaCLvftd+tdN90gG1Uj54CkJOL7Z0jfiHpPVf
 WQ7RFkEjP/hzeMCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C16901399E;
 Mon, 30 Aug 2021 17:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id de5ALdwRLWFRLgAAGKfGzw
 (envelope-from <hare@suse.de>); Mon, 30 Aug 2021 17:14:04 +0000
Subject: Re: [PATCH v1] nvme: avoid race in shutdown namespace removal
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20210830093618.97657-1-dwagner@suse.de>
 <20210830100443.b2zkdp4l3vi2gz42@carbon.lan>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <742108c3-7c76-0bc3-fc13-06acf975c25c@suse.de>
Date: Mon, 30 Aug 2021 19:14:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210830100443.b2zkdp4l3vi2gz42@carbon.lan>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210830_101411_437922_DBAD0E15 
X-CRM114-Status: GOOD (  17.28  )
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

T24gOC8zMC8yMSAxMjowNCBQTSwgRGFuaWVsIFdhZ25lciB3cm90ZToKPiBPbiBNb24sIEF1ZyAz
MCwgMjAyMSBhdCAxMTozNjoxOEFNICswMjAwLCBEYW5pZWwgV2FnbmVyIHdyb3RlOgo+PiBUaG91
Z2ggb25lIHRoaW5nIEkgYW0gbm90IHJlYWxseSBzdXJlIGhvdyBpdCBpbnRlcmFjdHMgd2l0aAo+
PiBudm1lX2luaXRfbnNfaGVhZCgpIGFzIHdlIGNvdWxkIGJlIGluIHJ1bm5pbmcgbnZtZV9pbml0
X25zX2hlYWQoKQo+PiBhZnRlciB3ZSBoYXZlIHNldCBsYXN0X3BhdGggPSB0cnVlLiBJIGhhdmVu
J3QgcmVhbGx5IGZpZ3VyZWQKPj4gb3V0IHlldCB3aGF0IHRoaXMgd291bGQgbWVhbi4gSXMgdGhp
cyBhIHJlYWwgcHJvYmxlbT8KPiAKPiBJIHN1c3BlY3QgaXQgd2lsbCByZWdyZXNzIHRoZSB2ZXJ5
IHRoaW5nIDUzOTZmZGFjNTZkOCAoIm52bWU6IGZpeAo+IHJlZmNvdW50aW5nIGltYmFsYW5jZSB3
aGVuIGFsbCBwYXRocyBhcmUgZG93biIpIHRyaWVkIHRvIGZpeC4KPiAKTW9zdCBsaWtlbHkuIERv
IGRyb3AgbWUgYSBtYWlsIG9uIGhvdyB0byBjcmVhdGUgYSByZXByb2R1Y2VyIGZvciB0aGF0OyAK
aXQncyBub3QgZXhhY3RseSB0cml2aWFsIGFzIHlvdSBuZWVkIHRvIHBhdGNoIHFlbXUgZm9yIHRo
YXQKKGFuZCwgb2YgY291cnNlLCB0aG9zZSBwYXRjaGVzIHdpbGwgbm90IGdvIHVwc3RyZWFtIGFz
IHRoZXkgYWdhaW4gaGl0IGEgCnNlY3Rpb24gd2hpY2ggdGhlIG1haW50YWluZXIgZGVlbWVkIHRv
IGJlIHJld29ya2VkIGFueSB0aW1lIG5vdy4gU28gb2YgCmNvdXJzZSBoZSBjYW4ndCBwb3NzaWJs
eSBhcHBseSB0aGVtLikKKEkgc2VlbSB0byBoYXZlIGEgcGFydGljdWxhciBzcGVsbCBvZiBiYWQg
bHVjaywgc2VlaW5nIHRoYXQgaXQncyB0aGUgCl90aGlyZF8gdGltZSB0aGlzIGhhcHBlbmVkIHRv
IG1lIDotKCApCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAg
ICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7D
vHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
