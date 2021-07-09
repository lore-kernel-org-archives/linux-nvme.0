Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6916C07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:59:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745B9613D0
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745B9613D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EhoCBaDgl7Ud0Djrnn7NoUg3Y+5z2/pwwb0e+af2oFE=; b=jePi6Mcf7YrqRcDU1WxAZZgRkq
	pz9BdPD+8QhWH2QjqNJQdXQP45KSSl39R+P9cSfcfMjb497UVsDj/g2ZHiC5ybB2MRX64kiBk1erS
	Tai+HafIEWGGT13L1FrztX4gtQVIIZpzOzqCroo7paJfpGebkSrjAU7Ge+s+ipnu1cvwRB26J8I8S
	w8+odZqbzM/IzOCXMXr+9B2AO+wTf0gg4gVVEPYaNx3koHiygV0IBiXOxMujl076TIBJFh3/fB4Kb
	vYJwTJm8UlRXlNoAqTxmfHYkvftcKO2e2NuIZWfw06fopJ/xMoG0w8gI/jqq/yexSiBTQzpWUl7BQ
	DYvih96A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1mLs-001EpK-3p; Fri, 09 Jul 2021 08:59:16 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1mLo-001EoY-Rl
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 08:59:14 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8617B2027C;
 Fri,  9 Jul 2021 08:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625821151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i3tKMuQTB+eBLmMrgLGhhB7bMse0LzzoqYLpZi5T9Jw=;
 b=M9t83NfmSdV2Yu/fyNTjTORxPmusquBFw82iSXcibYj4XYaUeXnDOyw7l3TU/MQitLiTOI
 3/LDvotSSbYReKZvw4n2SFuWrQiTWuCjrz//Orr9iASrm2iDonJwfwbIXYPXWuh4adzqLg
 OQSIIVNid4wC39UpHtrZIVRdy+4CtrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625821151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i3tKMuQTB+eBLmMrgLGhhB7bMse0LzzoqYLpZi5T9Jw=;
 b=dE8qrRZuALt8lZIqtWjvO6oEwyHN7YjWilR9OpTsdNCvxc2YKKRN2/lNY5FXRKzHwzw/or
 SFo5tJJ+kL1PuOAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 623171348A;
 Fri,  9 Jul 2021 08:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id +LnNFt8P6GBOGgAAGKfGzw
 (envelope-from <hare@suse.de>); Fri, 09 Jul 2021 08:59:11 +0000
Subject: Re: [PATCH 0/2] nvme-fabrics: short-circuit connect retries
From: Hannes Reinecke <hare@suse.de>
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
 <5866f912-45de-e4a6-f98e-2562fb913746@suse.de>
Message-ID: <ac11d458-b538-9099-9097-8760d5145d60@suse.de>
Date: Fri, 9 Jul 2021 10:59:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5866f912-45de-e4a6-f98e-2562fb913746@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_015913_089400_8031EBBB 
X-CRM114-Status: GOOD (  23.79  )
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

T24gNy85LzIxIDEwOjU1IEFNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4gT24gNy85LzIxIDEw
OjM0IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDIwMjEvNy85IDEyOjU3LCBKYW1l
cyBTbWFydCB3cm90ZToKPj4+IE9uIDcvNy8yMDIxIDExOjI5IFBNLCBDaGFvIExlbmcgd3JvdGU6
Cj4+Pj4KPj4+Pgo+Pj4+IE9uIDIwMjEvNi8yOSAxOTowMCwgSGFubmVzIFJlaW5lY2tlIHdyb3Rl
Ogo+IFsgLi4gXQo+Pj4+Pgo+Pj4+PiBQbGVhc2UgZ2l2ZSBkZXRhaWxzIGZvciB0aGUgaXNzdWVz
IHlvdSBhcmUgY29uY2VybmVkIHdpdGguCj4+Pj4gRm9yIGV4YW1wbGUsIGlmIGhvc3Qgc2VuZCBh
IGZhYnJpYyBjbWQsIGJ1dCB0aGUgZmFicmljIGNtZCBpcyBwb2lzb25lZAo+Pj4+IGR1ZSB0byBI
QkEgaW5uZXIgZXJyb3IsIGFibm9ybWFsIG9yIGF0dGFja2VkIG5ldHdvcmssIGFuZCB0aGVuIHRo
ZSAKPj4+PiB0YXJnZXQKPj4+PiBzZXQgdGhlIEROUiB0byByZXBseSByZXNwb25zZS4gSWYgZG8g
bm90IHJlY29ubmVjdCBmb3IgRE5SIHJlc3BvbnNlIG9mCj4+Pj4gb2xkIGNvbm5lY3Rpb24sIHRo
dXMgdGhlIGNvbm5lY3RpbmcgY2FuIG5vdCBhb3RvIHJlY292ZXJ5LiBUaGUgZmFicmljCj4+Pj4g
Y21kIHBvaXNvbmluZyBtYXkgYmUgdHJhbnNpZW50LCBtYXkgc3VjY2VzcyBpZiB0cnkgZm9yIHJl
Y29ubmVjdGluZy4KPj4+PiBzbyB0cnkgdG8gcmVjb25uZWN0aW5nIGlzIGEgYmV0dGVyIGNob2lj
ZS4KPj4+PiBJZiBkbyBub3QgcmVjb25uZWN0IGZvciBETlIgcmVzcG9uc2UsIHRhcmdldCBzaG91
bGQgc2V0IEROUiBzdGF0ZSBqdXN0Cj4+Pj4gZm9yIHRhcmdldCBpbm5lciBlcnJvci4KPj4+Pj4K
Pj4+Cj4+PiBJdCByZWFsbHkgZG9lc24ndCBtYXR0ZXIgd2hhdCB5b3UgZGVzY3JpYmUgaXMgaGFw
cGVuaW5nIG9uIHRoZSBiYWNrIAo+Pj4gZW5kIG9mIHRoZSBjb250cm9sbGVycy9zdWJzeXN0ZW0u
wqAgVGhlIHJldiAxLjQgc3BlYyBzYXlzICJpZiB0aGUgc2FtZSAKPj4+IGNvbW1hbmQgaXMgcmUt
c3VibWl0dGVkIHRvIGFueSBjb250cm9sbGVyIGluIHRoZSBOVk0gc3Vic3lzdGVtLCB0aGVuIAo+
Pj4gdGhhdCByZS1zdWJtaXR0ZWQgY29tbWFuZCBpcyBleHBlY3RlZCB0byBmYWlsLiIgLSBTbywg
aWYgdGhlcmUncyBhIAo+Pj4gY2hhbmNlIHRoYXQgYSByZWNvbm5lY3Qgd291bGQgc3VjY2VlZCwg
d2hpY2ggd291bGQgYmUgb24gYSBkaWZmZXJlbnQgCj4+PiBjb250cm9sbGVyIC0gdGhlbiBzdWJz
eXN0ZW0gaXMgbm90IGZvbGxvd2luZyB0aGF0IHN0YXRlbWVudC4gU28geW91IAo+Pj4gc2hvdWxk
bid0IGJlIHNldHRpbmcgRE5SLsKgwqAgSWYgeW91IGRpc2FncmVlIHdpdGggdGhpcyBiZWhhdmlv
ciwgaXQgCj4+PiB3aWxsIG5lZWQgdG8gYmUgdGFrZW4gdXAgd2l0aCB0aGUgTlZNIEV4cHJlc3Mg
Z3JvdXAuCj4+IEkgYWdyZWUgdGhlIG52bWUgc3BlYy4gSSBtZWFuIHRoYXQgbGludXgga2VybmVs
IG52bWUgdGFyZ2V0IGRvZXMgbm90IAo+PiBiZWhhdmUgZXhhY3RseSBsaWtlIHRoaXMuCj4+IFNv
IG5lZWQgdG8gbW9kaWZ5IGJvdGggaG9zdCBhbmQgdGFyZ2V0LiBJbiBhZGRpdGlvbiwgdGhlIGNv
bXBhdGliaWxpdHkgCj4+IGJldHdlZW4gZGlmZmVyZW50IHZlcnNpb25zIHNob3VsZCBiZSBjb25z
aWRlcmVkLgo+IAo+IEFoLiBZb3UgYXJlIHRhbGtpbmcgYWJvdXQgdGhlIF90YXJnZXRfLiBJIHdv
dWxkIGJlIHRoZSBmaXJzdCB0byBhZG1pdCAKPiB0aGF0IHRoaXMgY291bGQgYmUgY2xlYXJlZCB1
cCBxdWl0ZSBhIGJpdDsgdGhlcmUgYXJlIGxvdHMgb2YgCj4gaW5jb25zaXN0ZW5jaWVzIHRoZXJl
Lgo+IAo+IEFuZCBzdXJlLCBJIGNhbiBkbyBhIHBhdGNoIGZvciB0aGF0LCB0b28uCj4gCkJ1dCBp
bmNpZGVudGFsbHksIEknZCByYXRoZXIgc29sdmUgdGhpcyBpbiBhIGRpZmZlcmVudCBwYXRjaHNl
dCwgYXMgCnRoZXJlIGFyZSBsb3RzIG9mIHBsYWNlcyBpbiB0aGUgdGFyZ2V0IGNvZGUgd2hlcmUg
d2UgcmV0dXJuIApOVk1FX1NDX0lOVEVSTkFMIHVwb24gYWxsb2NhdGlvbiBmYWlsdXJlLCB3aGlj
aCBieSByaWdodHMgc2hvdWxkIGJlIApyZXRyeWFibGUuIEJ1dCB0aGVuIEknZCByYXRoZXIgaW1w
bGVtZW50IEFDUkUgZm9yIHRoZSB0YXJnZXQgZmlyc3QsIGFzIAp0aGVuIHdlIGNvdWxkIGNsYXNz
aWZ5IHRoZSByZXRyeSBmcmVxdWVuY3k7IGZvciBhbGxvY2F0aW9uIGZhaWx1cmVzIHdlIApzaG91
bGQgZ2l2ZSB0aGUgdGFyZ2V0IG1vcmUgdGltZSBiZXR3ZWVuIHJldHJpZXMgYXMgZm9yIGVnIGxv
Y2tpbmcgaXNzdWVzLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAg
ICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChB
RyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
