Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63978C07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:55:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22756613CA
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22756613CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BW/GP7h6b9kAtw5GpKljZx1TDbtKTXnHq06Zbz2eflg=; b=X5PBgdSXeIEiDAwsx2YojFjlt5
	pe9RC8mtfgjFkNGLpGvIoPhCdkxQmpydBO+obO0dXlgTa4+9vVkxWpqaxKkx+eEk7kauMahJHrV+t
	6QAtH/fy7USUMHCJiQ/NhHD6f4ev5oltLIFaX514lHYl+3Bn4q3YvCTNENcNL1/smLkJHTjhj814S
	wnm0FEvxi5VVoeBjzw/2ElnZd+DQlZ/8PaR6lShcxPUN//r/aPVv94gWlaoiUMxRbKH7F/kbouqJK
	/4yyj89la9yyIWbU3t0ZcPraeKRNH2HO5fkj91w7g/5UtgEPUBaL9MYFHoSGcCluJL9jNF/i4/r2I
	igmLC/fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1mI3-001E2M-GZ; Fri, 09 Jul 2021 08:55:19 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1mI1-001E1S-5q
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 08:55:18 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08EED21F33;
 Fri,  9 Jul 2021 08:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625820914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x/S8NPxWxBt4Dz/Xo7YejQv4s2LNftuOuvvRd+BsTPA=;
 b=oA6g3OQtWqyui3eSl54wJ1SKKJSF5qaxcK5ZMEw7rr44/Fh31I1H0num9Ox0JXFS9hcbem
 IU3BfjpIYdLPl9/bV/+/XR7O4P5q7fjHo7FTbdsH/sOitXRUdal4mkwkUGZ7Cv8l0s0w//
 kOrCucZRf2r/Idqdvc0CJB3AHI6O9K0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625820914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x/S8NPxWxBt4Dz/Xo7YejQv4s2LNftuOuvvRd+BsTPA=;
 b=HVDp0dyg3/63hkaSR+ml2x7m11ohFeYqWh5Cjf9qEe7YwexCxXEXqrMHrIr35U+6zaycjn
 HOh9h/5Lq2oPhACA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DF2F4133D1;
 Fri,  9 Jul 2021 08:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 8+K+NfEO6GD0GAAAGKfGzw
 (envelope-from <hare@suse.de>); Fri, 09 Jul 2021 08:55:13 +0000
Subject: Re: [PATCH 0/2] nvme-fabrics: short-circuit connect retries
To: Chao Leng <lengchao@huawei.com>, James Smart <jsmart2021@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210623143250.82445-1-hare@suse.de>
 <8d7c79d9-0928-8c71-74fd-7185d67e7895@grimberg.me>
 <204a6656-ef83-b688-4979-26fe17f57974@suse.de>
 <cdf40226-12ed-5f87-8549-10b4defceae5@huawei.com>
 <91ff9961-6537-05d1-c552-18a02d13bf0c@suse.de>
 <984b2d1a-f319-1a09-7347-6c4edd1dbab6@huawei.com>
 <d20b23fc-dd08-cb51-eb29-aa033810b0a4@suse.de>
 <caa3759f-9a72-5e3b-9097-700132e4ab63@gmail.com>
 <28ec79af-beb0-8ef9-ab6a-d608a632ee2c@huawei.com>
 <0af5901a-4dab-70de-abda-00ed7f8cf45f@suse.de>
 <c5ddf523-af8c-eae0-03fc-6c64d0df9e7c@huawei.com>
 <f4d95ae8-7c7b-275b-0436-863c5add25cb@gmail.com>
 <4ae04d12-cb34-45bb-5a01-54802d2a94b9@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5866f912-45de-e4a6-f98e-2562fb913746@suse.de>
Date: Fri, 9 Jul 2021 10:55:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4ae04d12-cb34-45bb-5a01-54802d2a94b9@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_015517_418840_67C70CE3 
X-CRM114-Status: GOOD (  21.84  )
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

T24gNy85LzIxIDEwOjM0IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4gCj4gCj4gT24gMjAyMS83Lzkg
MTI6NTcsIEphbWVzIFNtYXJ0IHdyb3RlOgo+PiBPbiA3LzcvMjAyMSAxMToyOSBQTSwgQ2hhbyBM
ZW5nIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiAyMDIxLzYvMjkgMTk6MDAsIEhhbm5lcyBSZWluZWNr
ZSB3cm90ZToKWyAuLiBdCj4+Pj4KPj4+PiBQbGVhc2UgZ2l2ZSBkZXRhaWxzIGZvciB0aGUgaXNz
dWVzIHlvdSBhcmUgY29uY2VybmVkIHdpdGguCj4+PiBGb3IgZXhhbXBsZSwgaWYgaG9zdCBzZW5k
IGEgZmFicmljIGNtZCwgYnV0IHRoZSBmYWJyaWMgY21kIGlzIHBvaXNvbmVkCj4+PiBkdWUgdG8g
SEJBIGlubmVyIGVycm9yLCBhYm5vcm1hbCBvciBhdHRhY2tlZCBuZXR3b3JrLCBhbmQgdGhlbiB0
aGUgCj4+PiB0YXJnZXQKPj4+IHNldCB0aGUgRE5SIHRvIHJlcGx5IHJlc3BvbnNlLiBJZiBkbyBu
b3QgcmVjb25uZWN0IGZvciBETlIgcmVzcG9uc2Ugb2YKPj4+IG9sZCBjb25uZWN0aW9uLCB0aHVz
IHRoZSBjb25uZWN0aW5nIGNhbiBub3QgYW90byByZWNvdmVyeS4gVGhlIGZhYnJpYwo+Pj4gY21k
IHBvaXNvbmluZyBtYXkgYmUgdHJhbnNpZW50LCBtYXkgc3VjY2VzcyBpZiB0cnkgZm9yIHJlY29u
bmVjdGluZy4KPj4+IHNvIHRyeSB0byByZWNvbm5lY3RpbmcgaXMgYSBiZXR0ZXIgY2hvaWNlLgo+
Pj4gSWYgZG8gbm90IHJlY29ubmVjdCBmb3IgRE5SIHJlc3BvbnNlLCB0YXJnZXQgc2hvdWxkIHNl
dCBETlIgc3RhdGUganVzdAo+Pj4gZm9yIHRhcmdldCBpbm5lciBlcnJvci4KPj4+Pgo+Pgo+PiBJ
dCByZWFsbHkgZG9lc24ndCBtYXR0ZXIgd2hhdCB5b3UgZGVzY3JpYmUgaXMgaGFwcGVuaW5nIG9u
IHRoZSBiYWNrIAo+PiBlbmQgb2YgdGhlIGNvbnRyb2xsZXJzL3N1YnN5c3RlbS7CoCBUaGUgcmV2
IDEuNCBzcGVjIHNheXMgImlmIHRoZSBzYW1lIAo+PiBjb21tYW5kIGlzIHJlLXN1Ym1pdHRlZCB0
byBhbnkgY29udHJvbGxlciBpbiB0aGUgTlZNIHN1YnN5c3RlbSwgdGhlbiAKPj4gdGhhdCByZS1z
dWJtaXR0ZWQgY29tbWFuZCBpcyBleHBlY3RlZCB0byBmYWlsLiIgLSBTbywgaWYgdGhlcmUncyBh
IAo+PiBjaGFuY2UgdGhhdCBhIHJlY29ubmVjdCB3b3VsZCBzdWNjZWVkLCB3aGljaCB3b3VsZCBi
ZSBvbiBhIGRpZmZlcmVudCAKPj4gY29udHJvbGxlciAtIHRoZW4gc3Vic3lzdGVtIGlzIG5vdCBm
b2xsb3dpbmcgdGhhdCBzdGF0ZW1lbnQuIFNvIHlvdSAKPj4gc2hvdWxkbid0IGJlIHNldHRpbmcg
RE5SLsKgwqAgSWYgeW91IGRpc2FncmVlIHdpdGggdGhpcyBiZWhhdmlvciwgaXQgCj4+IHdpbGwg
bmVlZCB0byBiZSB0YWtlbiB1cCB3aXRoIHRoZSBOVk0gRXhwcmVzcyBncm91cC4KPiBJIGFncmVl
IHRoZSBudm1lIHNwZWMuIEkgbWVhbiB0aGF0IGxpbnV4IGtlcm5lbCBudm1lIHRhcmdldCBkb2Vz
IG5vdCAKPiBiZWhhdmUgZXhhY3RseSBsaWtlIHRoaXMuCj4gU28gbmVlZCB0byBtb2RpZnkgYm90
aCBob3N0IGFuZCB0YXJnZXQuIEluIGFkZGl0aW9uLCB0aGUgY29tcGF0aWJpbGl0eSAKPiBiZXR3
ZWVuIGRpZmZlcmVudCB2ZXJzaW9ucyBzaG91bGQgYmUgY29uc2lkZXJlZC4KCkFoLiBZb3UgYXJl
IHRhbGtpbmcgYWJvdXQgdGhlIF90YXJnZXRfLiBJIHdvdWxkIGJlIHRoZSBmaXJzdCB0byBhZG1p
dCAKdGhhdCB0aGlzIGNvdWxkIGJlIGNsZWFyZWQgdXAgcXVpdGUgYSBiaXQ7IHRoZXJlIGFyZSBs
b3RzIG9mIAppbmNvbnNpc3RlbmNpZXMgdGhlcmUuCgpBbmQgc3VyZSwgSSBjYW4gZG8gYSBwYXRj
aCBmb3IgdGhhdCwgdG9vLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tl
ICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJl
IFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5
IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
