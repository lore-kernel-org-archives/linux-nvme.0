Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEABC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 12:22:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1376103A
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 12:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B1376103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=vsknqDAkpMuaSswDCbbKSZR6z1f7T/ZvBFgbisXbxa4=; b=wf1e3Vsu233L1Pae4HNbORYhab
	/+55QNwD6Pt3BP0meDza/eEqA1bsvAeFkvo7kkT0lQuEnDdgJlWqHfT2fchflUDfSDzDQtVXUvCKH
	fth3iDn9aa+s533ZE98jHr63zy27YGvLYSugA+6F5ID25/4/VQbwrK9yhr6QEMREUwia7ApNMXEVF
	xVQKSw5Fa0MGYt9JIh/LE6eQHM1hF4JzNBC7Ji79Fs2M25eXASPCYPzo5jrS/1Pn52Lo/VwmShTbw
	Vsa3ZygfKtCFgOcyMh6FEGg3R51ozpiWY3xAEun1oT8/2P/ZqP9Fn4Aek/Ad2bgWqs0fxDeVIt16J
	x7Vqfl0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGKa0-005Ug9-VG; Wed, 18 Aug 2021 12:22:01 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGKZv-005UcZ-By
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 12:21:59 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E144D1FFA2;
 Wed, 18 Aug 2021 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629289311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZwEvRtIuyZEjCL/vXUBtkJZmR2erkZdAfEZBkHpZlxw=;
 b=Z0dWAVnQqeFhuAJpni2TL/i9Gff5CwWehE4oQF+fyNALjOxVVtNkezGMGg90YUhr2neSJ7
 tUX3hW64JUIdL5ZiauTs2IFZkO/FOHu2TpRXUs66xEjMnR0/WGOfyiOWDuOI33wR2eliCw
 RZMQYx3tcqFcM579BCVEq7dpmXg/7TY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629289311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZwEvRtIuyZEjCL/vXUBtkJZmR2erkZdAfEZBkHpZlxw=;
 b=Z+721H+As6XuSxoWxCwuLiO8DCMp1tNx9P/ZuyeViJknaTyeE43wAHb/SfcT89P28lY0A3
 YaabV2T0bAv93iAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D03E614454;
 Wed, 18 Aug 2021 12:21:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id w+aZMl/7HGGKJAAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 18 Aug 2021 12:21:51 +0000
Subject: Re: [PATCH v5 3/3] nvme-fc: fix controller reset hang during traffic
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 James Smart <jsmart2021@gmail.com>
References: <20210818120530.130501-1-dwagner@suse.de>
 <20210818120530.130501-4-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ba6ebacb-6554-7683-7a7f-577241356bfa@suse.de>
Date: Wed, 18 Aug 2021 14:21:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210818120530.130501-4-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210818_052155_635353_FBF861A9 
X-CRM114-Status: GOOD (  26.38  )
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

T24gOC8xOC8yMSAyOjA1IFBNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOgo+IEZyb206IEphbWVzIFNt
YXJ0IDxqc21hcnQyMDIxQGdtYWlsLmNvbT4KPiAKPiBjb21taXQgZmUzNWVjNThmMGQzICgiYmxv
Y2s6IHVwZGF0ZSBoY3R4IG1hcCB3aGVuIHVzZSBtdWx0aXBsZSBtYXBzIikKPiBleHBvc2VkIGFu
IGlzc3VlIHdoZXJlIHdlIG1heSBoYW5nIHRyeWluZyB0byB3YWl0IGZvciBxdWV1ZSBmcmVlemUK
PiBkdXJpbmcgSS9PLiBXZSBjYWxsIGJsa19tcV91cGRhdGVfbnJfaHdfcXVldWVzIHdoaWNoIG1h
eSBhdHRlbXB0IHRvIGZyZWV6ZQo+IHRoZSBxdWV1ZS4gSG93ZXZlciB3ZSBuZXZlciBzdGFydGVk
IHF1ZXVlIGZyZWV6ZSB3aGVuIHN0YXJ0aW5nIHRoZQo+IHJlc2V0LCB3aGljaCBtZWFucyB0aGF0
IHdlIGhhdmUgaW5mbGlnaHQgcGVuZGluZyByZXF1ZXN0cyB0aGF0IGVudGVyZWQgdGhlCj4gcXVl
dWUgdGhhdCB3ZSB3aWxsIG5vdCBjb21wbGV0ZSBvbmNlIHRoZSBxdWV1ZSBpcyBxdWllc2NlZC4K
PiAKPiBTbyBzdGFydCBhIGZyZWV6ZSBiZWZvcmUgd2UgcXVpZXNjZSB0aGUgcXVldWUsIGFuZCB1
bmZyZWV6ZSB0aGUgcXVldWUKPiBhZnRlciB3ZSBzdWNjZXNzZnVsbHkgY29ubmVjdGVkIHRoZSBJ
L08gcXVldWVzICh0aGUgdW5mcmVlemUgaXMgYWxyZWFkeQo+IHByZXNlbnQgaW4gdGhlIGNvZGUp
LiBibGtfbXFfdXBkYXRlX25yX2h3X3F1ZXVlcyB3aWxsIGJlIGNhbGxlZCBvbmx5Cj4gYWZ0ZXIg
d2UgYXJlIHN1cmUgdGhhdCB0aGUgcXVldWUgd2FzIGFscmVhZHkgZnJvemVuLgo+IAo+IFRoaXMg
Zm9sbG93cyB0byBob3cgdGhlIHBjaSBkcml2ZXIgaGFuZGxlcyByZXNldHMuCj4gCj4gVGhpcyBw
YXRjaCBhZGRlZCBsb2dpYyBpbnRyb2R1Y2VkIGluIGNvbW1pdCA5Zjk4NzcyYmEzMDcgIm52bWUt
cmRtYTogZml4Cj4gY29udHJvbGxlciByZXNldCBoYW5nIGR1cmluZyB0cmFmZmljIi4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBKYW1lcyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+Cj4gQ0M6IFNh
Z2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4gVGVzdGVkLWJ5OiBEYW5pZWwgV2FnbmVy
IDxkd2FnbmVyQHN1c2UuZGU+Cj4gUmV2aWV3ZWQtYnk6IERhbmllbCBXYWduZXIgPGR3YWduZXJA
c3VzZS5kZT4KPiAtLS0KPiAgZHJpdmVycy9udm1lL2hvc3QvZmMuYyB8IDYgKysrKystCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lL2hvc3QvZmMuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMKPiBp
bmRleCAzZmY3ODNhMmU5ZjcuLjk5ZGFkYWIyNzI0YyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252
bWUvaG9zdC9mYy5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvZmMuYwo+IEBAIC0yOTc0LDkg
KzI5NzQsMTAgQEAgbnZtZV9mY19yZWNyZWF0ZV9pb19xdWV1ZXMoc3RydWN0IG52bWVfZmNfY3Ry
bCAqY3RybCkKPiAgCQkJcmV0dXJuIC1FTk9ERVY7Cj4gIAkJfQo+ICAJCWJsa19tcV91cGRhdGVf
bnJfaHdfcXVldWVzKCZjdHJsLT50YWdfc2V0LCBucl9pb19xdWV1ZXMpOwo+IC0JCW52bWVfdW5m
cmVlemUoJmN0cmwtPmN0cmwpOwo+ICAJfQo+ICAKPiArCW52bWVfdW5mcmVlemUoJmN0cmwtPmN0
cmwpOwo+ICsKPiAgCXJldHVybiAwOwo+ICAKPiAgb3V0X2RlbGV0ZV9od19xdWV1ZXM6Cj4gQEAg
LTMyMTUsNiArMzIxNiw5IEBAIG52bWVfZmNfZGVsZXRlX2Fzc29jaWF0aW9uKHN0cnVjdCBudm1l
X2ZjX2N0cmwgKmN0cmwpCj4gIAljdHJsLT5pb2NudCA9IDA7Cj4gIAlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZjdHJsLT5sb2NrLCBmbGFncyk7Cj4gIAo+ICsJaWYgKGN0cmwtPmN0cmwucXVldWVf
Y291bnQgPiAxKQo+ICsJCW52bWVfc3RhcnRfZnJlZXplKCZjdHJsLT5jdHJsKTsKPiArCj4gIAlf
X252bWVfZmNfYWJvcnRfb3V0c3RhbmRpbmdfaW9zKGN0cmwsIGZhbHNlKTsKPiAgCj4gIAkvKiBr
aWxsIHRoZSBhZW5zIGFzIHRoZXkgYXJlIGEgc2VwYXJhdGUgcGF0aCAqLwo+IApSZXZpZXdlZC1i
eTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRy
LiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0Cmhh
cmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29m
dHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5i
ZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
