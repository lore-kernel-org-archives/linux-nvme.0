Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E83AC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 10:06:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A61D6101A
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 10:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A61D6101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TDUb6ioSWRsj/Eq3WPR693WktSqD/He5GhoSmUxjcQI=; b=RTKEdo0ctDrcwGjFxbicCvkS/i
	64D2wrLLQsxxdsF44uEBGzO1uCyroTKpE4dRLK2s5mWcFzXQMaPDgZA+Qp4+DPzl2n5+u4I128x34
	MDO2cDPmmGoSGh9JAxqv2yRgMYRF69PI4Z/Q20bX/iAQY+jv8wy5ySPhBaFUluCRicMR0X9IqOdEr
	pw7vWjEwZ11qVEwFn2uNodC6oFnHbpCIbmGWhtkEM65dymqMw6IYsGKJdE0f/ZXllMAFy5Gwd8YXf
	M3k3umphEl7NhDtZJFxeKG3FrqxFxQlLttgR/w6CXcE0POi1OTzDtDxg3kt+tkUBXN3QyR2ZDGXkY
	Dnv0s4wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOGwz-008qfk-Ho; Thu, 09 Sep 2021 10:06:33 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOGwv-008qfA-Qb
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 10:06:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 659A722311;
 Thu,  9 Sep 2021 10:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631181985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6xcNsSwzzwbyGGDvll2fWt5jcnOiGP0/VGXDC81ybU=;
 b=egSsXmMxS0Lng80t5hWrpuqYO8ke0cUimwRjIz7N8b+Pwb8oRhzmPAPCFQPSCkr0n2bJVF
 4ftS5d0ekn7OI+6pa9LXHaDKIUcBuwXVWg4kmXj2lhLUgzRDuS+NY13XMmTa3VAoRXqDMU
 240jQYlBSwF//H42Krfv3HVFq05axq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631181985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6xcNsSwzzwbyGGDvll2fWt5jcnOiGP0/VGXDC81ybU=;
 b=YNco0YwIrCMQC1axCJulfv2hohzGTnteG3SsFxQSMWxlxRdsq+1ApIe4V8iHn34TeN/mZM
 hfevW3Z1X82BBtDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49B1813342;
 Thu,  9 Sep 2021 10:06:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kxG9EaHcOWHwLAAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 09 Sep 2021 10:06:25 +0000
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20210902092002.67614-1-dwagner@suse.de>
 <YTXKwOvCtJOHnhpu@infradead.org>
 <d63a15af-63a7-3fa0-1559-4518dee3a99a@suse.de>
Subject: Re: [PATCH v2] nvme: avoid race in shutdown namespace removal
Message-ID: <f211ac99-cddb-8515-e34f-a82a62e26d79@suse.de>
Date: Thu, 9 Sep 2021 12:06:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d63a15af-63a7-3fa0-1559-4518dee3a99a@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_030630_059673_366A3739 
X-CRM114-Status: GOOD (  17.29  )
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

T24gOS82LzIxIDEwOjQwIEFNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4gT24gOS82LzIxIDEw
OjAxIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4gT24gVGh1LCBTZXAgMDIsIDIwMjEg
YXQgMTE6MjA6MDJBTSArMDIwMCwgRGFuaWVsIFdhZ25lciB3cm90ZToKPj4+IFdoZW4gd2UgcmVt
b3ZlIHRoZSBzaWJsaW5ncyBlbnRyeSwgd2UgdXBkYXRlIG5zLT5oZWFkLT5saXN0LCBoZW5jZSB3
ZQo+Pj4gY2FuJ3Qgc2VwYXJhdGUgdGhlIHJlbW92YWwgYW5kIHRlc3QgZm9yIGJlaW5nIGVtcHR5
LiBUaGV5IGhhdmUgdG8gYmUKPj4+IGluIHRoZSBzYW1lIGNyaXRpY2FsIHNlY3Rpb24gdG8gYXZv
aWQgYSByYWNlLgo+Pj4KPj4+IFRvIGF2b2lkIGJyZWFraW5nIHRoZSByZWZjb3VudGluZyBpbWJh
bGFuY2UgYWdhaW4sIGFkZCBhIGxpc3QgZW1wdHkKPj4+IGNoZWNrIHRvIG52bWVfZmluZF9uc19o
ZWFkLgo+Pgo+PiBIYW5uZXMsIGNhbiB5b3UgbG9vayBvdmVyIHRoaXMgYW5kIHJ1biB5b3VyIHRl
c3RzIG9uIGl0Pwo+Pgo+IEknbSBhdCBpdC4KPiAKRmluYWxseS4gcWVtdSBiZWluZyBpdCdzIHVz
dWFsIGJpdGNoeSBzZWxmLgoKQnV0IG1hbmFnZWQgdG8gdGVzdCB0aGUgcGF0Y2gsIGFuZCBhbGwg
bG9va3MgZ29vZC4KCkZvciByZWZlcmVuY2UsIHRoZSB0ZXN0Y2FzZSBpczoKCi0gQ3JlYXRlIHFl
bXUgaW5zdGFuY2Ugd2l0aCB0d28gTlZNZSBuYW1lc3BhY2VzOgogIC1kZXZpY2UgcGNpZS1yb290
LXBvcnQsaWQ9cnA4MCxidXM9cGNpZS4wLGNoYXNzaXM9MixhZGRyPTguMCxcCiAgIG11bHRpZnVu
Y3Rpb249b24scHJlZjY0LXJlc2VydmU9MzJNIFwKICAtZGV2aWNlIHBjaWUtcm9vdC1wb3J0LGlk
PXJwOTAsYnVzPXBjaWUuMCxjaGFzc2lzPTMsYWRkcj05LjAsXAogICBtdWx0aWZ1bmN0aW9uPW9u
LHByZWY2NC1yZXNlcnZlPTMyTSBcCiAgLWRldmljZSBudm1lLXN1YnN5cyxpZD1udm1lLXN1YnN5
czEsbnFuPXNsZXNudm1lc3Vic3lzLTEgXAogIC1kZXZpY2UgbnZtZS1zdWJzeXMsaWQ9bnZtZS1z
dWJzeXMyLG5xbj1zbGVzbnZtZXN1YnN5cy0yIFwKICAtZGV2aWNlIG52bWUsYnVzPXJwODAsaWQ9
bnZtZS1ycDgwLHNlcmlhbD1TTEVTTlZNRTIsXAogICBzdWJzeXM9bnZtZS1zdWJzeXMxIFwKICAt
ZGV2aWNlIG52bWUtbnMsaWQ9bnZtZS1ucy0yLGJ1cz1udm1lLXJwODAsZHJpdmU9bnZtZS0yIFwK
ICAtZGV2aWNlIG52bWUsYnVzPXJwOTAsaWQ9bnZtZS1ycDkwLHNlcmlhbD1TTEVTTlZNRTMsXAog
ICBzdWJzeXM9bnZtZS1zdWJzeXMyIFwKICAtZGV2aWNlIG52bWUtbnMsaWQ9bnZtZS1ucy0zLGJ1
cz1udm1lLXJwOTAsZHJpdmU9bnZtZS0zCgotIEluc3RhbGwgdGhlIHN5c3RlbSwgYW5kIGNyZWF0
ZSBhbiBNRCBSQUlEIDEgb24gdGhvc2UgbmFtZXNwYWNlcy4KLSBFbnRlciBxZW11IG1vbml0b3Is
IGFuZCBkZXRhY2ggb25lIGNvbnRyb2xsZXI6CiAgZGV2aWNlX2RlbCBudm1lLXJwOTAKLSBDaGVj
ayBpbiB0aGUgT1MgdGhhdCB0aGUgZGV2aWNlIGhhcyBiZWVuIHJlbW92ZWQsIGFuZCBNRCBoYXMK
ICByZWdpc3RlcmVkIHRoZSBkZXZpY2UgZmFpbHVyZToKCiMgZG1lc2cKWyAxODAxLjA3NjIzNl0g
cGNpZXBvcnQgMDAwMDowMDowOS4wOiBwY2llaHA6IFNsb3QoMC0yKTogQXR0ZW50aW9uCmJ1dHRv
biBwcmVzc2VkClsgMTgwMS4wNzYyNTFdIHBjaWVwb3J0IDAwMDA6MDA6MDkuMDogcGNpZWhwOiBT
bG90KDAtMik6IFBvd2VyaW5nIG9mZgpkdWUgdG8gYnV0dG9uIHByZXNzClsgMTgwNi4yNTAwMTdd
IGJsb2NrIG52bWUybjE6IG5vIGF2YWlsYWJsZSBwYXRoIC0gZmFpbGluZyBJL08KWyAxODA2LjI1
MDAzMF0gbWQ6IHN1cGVyX3dyaXR0ZW4gZ2V0cyBlcnJvcj0tNQpbIDE4MDYuMjUwMDM2XSBtZC9y
YWlkMTptZDE6IERpc2sgZmFpbHVyZSBvbiBudm1lMm4xLCBkaXNhYmxpbmcgZGV2aWNlLgogICAg
ICAgICAgICAgICBtZC9yYWlkMTptZDE6IE9wZXJhdGlvbiBjb250aW51aW5nIG9uIDEgZGV2aWNl
cy4KCi0gRW50ZXIgcWVtdSBtb25pdG9yLCBhbmQgcmUtYXR0YWNoIHRoZSBjb250cm9sbGVyOgog
IGRldmljZV9hZGQgYnVzPXJwOTAsaWQ9bnZtZS1ycDkwLHNlcmlhbD1TTEVTTlZNRTMsc3Vic3lz
PW52bWUtc3Vic3lzMgoKLSBDaGVjayBpbiB0aGUgT1MgdGhhdCB0aGUgZGV2aWNlIGhhcyBiZWVu
IHJlYXR0YWNoZWQ6CiMgZG1lc2cKWyAxODQ1LjYzNDYxM10gcGNpZXBvcnQgMDAwMDowMDowOS4w
OiBwY2llaHA6IFNsb3QoMC0yKTogQXR0ZW50aW9uCmJ1dHRvbiBwcmVzc2VkClsgMTg0NS42MzQ2
MjZdIHBjaWVwb3J0IDAwMDA6MDA6MDkuMDogcGNpZWhwOiBTbG90KDAtMikgUG93ZXJpbmcgb24g
ZHVlCnRvIGJ1dHRvbiBwcmVzcwpbIDE4NDUuNjM0ODIxXSBwY2llcG9ydCAwMDAwOjAwOjA5LjA6
IHBjaWVocDogU2xvdCgwLTIpOiBDYXJkIHByZXNlbnQKWyAxODQ1LjYzNDgyNl0gcGNpZXBvcnQg
MDAwMDowMDowOS4wOiBwY2llaHA6IFNsb3QoMC0yKTogTGluayBVcApbIDE4NDUuNzcwOTY5XSBw
Y2kgMDAwMDowMzowMC4wOiBbMWIzNjowMDEwXSB0eXBlIDAwIGNsYXNzIDB4MDEwODAyClsgMTg0
NS43NzEzMDddIHBjaSAwMDAwOjAzOjAwLjA6IHJlZyAweDEwOiBbbWVtIDB4MDAwMDAwMDAtMHgw
MDAwM2ZmZiA2NGJpdF0KWyAxODQ1Ljc3MzUwM10gcGNpIDAwMDA6MDM6MDAuMDogQkFSIDA6IGFz
c2lnbmVkIFttZW0KMHhjMTIwMDAwMC0weGMxMjAzZmZmIDY0Yml0XQpbIDE4NDUuNzczNjQ2XSBw
Y2llcG9ydCAwMDAwOjAwOjA5LjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwM10KWyAxODQ1Ljc3MzY3
MV0gcGNpZXBvcnQgMDAwMDowMDowOS4wOiAgIGJyaWRnZSB3aW5kb3cgW2lvICAweDcwMDAtMHg3
ZmZmXQpbIDE4NDUuNzc2OTI2XSBwY2llcG9ydCAwMDAwOjAwOjA5LjA6ICAgYnJpZGdlIHdpbmRv
dyBbbWVtCjB4YzEyMDAwMDAtMHhjMTNmZmZmZl0KWyAxODQ1Ljc3ODgxNl0gcGNpZXBvcnQgMDAw
MDowMDowOS4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbQoweDgwNDAwMDAwMC0weDgwNWZmZmZmZiA2
NGJpdCBwcmVmXQpbIDE4NDUuNzgzOTcwXSBudm1lIG52bWUyOiBwY2kgZnVuY3Rpb24gMDAwMDow
MzowMC4wClsgMTg0NS43ODQyMjddIG52bWUgMDAwMDowMzowMC4wOiBlbmFibGluZyBkZXZpY2Ug
KDAwMDAgLT4gMDAwMikKWyAxODQ1Ljc5ODkxOF0gbnZtZSBudm1lMjogMS8wLzAgZGVmYXVsdC9y
ZWFkL3BvbGwgcXVldWVzCgotIFJlYXR0YWNoIHRoZSBuYW1lc3BhY2UgdG8gdGhlIE1EIFJBSUQ6
CiMgbWRhZG0gLS1tYW5hZ2UgL2Rldi9tZDEgLS1yZS1hZGQgL2Rldi9udm1lMm4xCgotIENoZWNr
IHRoYXQgZXZlcnl0aGluZyB3b3JrZWQ6CiMgIyBjYXQgL3Byb2MvbWRzdGF0ClBlcnNvbmFsaXRp
ZXMgOiBbcmFpZDFdCm1kMSA6IGFjdGl2ZSByYWlkMSBudm1lMm4xWzFdIG52bWUxbjFbMF0KICAg
ICAgNDE4OTE4NCBibG9ja3Mgc3VwZXIgMS4yIFsyLzJdIFtVVV0KICAgICAgYml0bWFwOiAwLzEg
cGFnZXMgWzBLQl0sIDY1NTM2S0IgY2h1bmsKCnVudXNlZCBkZXZpY2VzOiA8bm9uZT4KClNvIHlv
dSBjYW4gYWRkOgoKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgpU
ZXN0ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVz
Ci0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hp
dGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApT
VVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5
IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZm
ZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
