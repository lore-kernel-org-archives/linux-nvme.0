Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB95C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 07:16:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0607B6101A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 07:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0607B6101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jmPHXgHuoySoB+00lDX2VaCWcvYEN+0R5x8DdYG51jE=; b=cpL9ljdCsTCLsJPO0mpFLPrupb
	9IYl3SC3p0HnyT+eNhyEGn2w6A2ITc5W0X6wLKzqZkJsL20NvsEAUiz5+6q0mHqoWdnbu1k5Kgk4F
	2uz+WWscwY68ZJ70CoK9CL9u4U2524GPGMd/5CQcVl+23+wGIGkNnq1D4KiW8HzIcbp26Pi8jtjRX
	4yBpg+MzbhQAWuEcLx+AXnBnU8It9zBbPfiGaszNMfvKuyS0MvwSQQRkoxAJQIxVkEHegGoIbA/Gq
	vrVyl1eON3LOJUAJo1el8SBcD2sfgjPBpUkLsJ10fH+h7P4Gu7cf2r5ixzSfTaY0HbiHaLl87ik1+
	mqBgq5MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV7Lz-005ySl-Ju; Tue, 28 Sep 2021 07:16:39 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV7Lw-005yS4-HX
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 07:16:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B83E822207;
 Tue, 28 Sep 2021 07:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632813394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPoc9HcKmX/HuJJ6DcP/Xn52CYGxWL8xcWnjG/kvr9U=;
 b=clw1hE466g10+JFJk1GI4mjnAgaR+tDTBycaR/UN9Bq1SBgrdDSJMWRQqRBzBKLkuebANN
 xGzUSjA/u9bWsLBKIKXiBhvkuNr5Wg3uFDEMDQrHzZk55QeUkfx0xjFrkCggGWP5cS5Zxj
 hJgVDnS9h2VZWehJ9az92Q2jPn48MMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632813394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPoc9HcKmX/HuJJ6DcP/Xn52CYGxWL8xcWnjG/kvr9U=;
 b=uQ5SOG+MU/hXhQNBdw4qrcnYsSQb9w4hFkItJ5qbRf7f4oyHqxS5VC/QjQk+K6JbCrKDWG
 M1ZJs1M7iyvffdCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5D5013ACF;
 Tue, 28 Sep 2021 07:16:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xgr8J1LBUmGJYAAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 28 Sep 2021 07:16:34 +0000
Subject: Re: [PATCH 04/12] lib/base64: RFC4648-compliant base64 encoding
To: Eric Biggers <ebiggers@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210928060356.27338-1-hare@suse.de>
 <20210928060356.27338-5-hare@suse.de> <YVK1D+GZgdFPRsaS@sol.localdomain>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2eee5e3c-265d-d84f-6214-ad3bcd19d169@suse.de>
Date: Tue, 28 Sep 2021 09:16:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YVK1D+GZgdFPRsaS@sol.localdomain>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_001636_758845_EFB01F2E 
X-CRM114-Status: GOOD (  14.15  )
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

T24gOS8yOC8yMSA4OjI0IEFNLCBFcmljIEJpZ2dlcnMgd3JvdGU6Cj4gT24gVHVlLCBTZXAgMjgs
IDIwMjEgYXQgMDg6MDM6NDhBTSArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+PiArICog
UmV0dXJuOiB0aGUgbGVuZ3RoIG9mIHRoZSByZXN1bHRpbmcgYmFzZTY0dXJsLWVuY29kZWQgc3Ry
aW5nIGluIGJ5dGVzLgo+IAo+IGJhc2U2NCwgbm90IGJhc2U2NHVybC4KPiAKPj4gKyAqIERlY29k
ZXMgYSBzdHJpbmcgdXNpbmcgYmFzZTY0dXJsIGVuY29kaW5nLCBpLmUuIHRoZSAiQmFzZSA2NCBF
bmNvZGluZyIKPj4gKyAqIHNwZWNpZmllZCBieSBSRkMgNDY0OCwgaW5jbHVkaW5nIHRoZSAgJz0n
LXBhZGRpbmcuCj4gCj4gYmFzZTY0LCBub3QgYmFzZTY0dXJsLgo+IApTaGVlc2gsIHlvdSBhcmUg
cmlnaHQuCgpCdXQgbm93IHlvdSBrbm93IEkndmUgY29waWVkIGl0IGFzIHJlcXVlc3RlZCA6LSkK
CkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICAgICBLZXJu
ZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgICAgKzQ5
IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCBNYXhm
ZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHRjog
RmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==
