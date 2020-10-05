Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2121DC4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 09:30:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE16120774
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 09:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tnzs3PkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE16120774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b9O7Q45udm8vgMkvciyrrsIAA/zJtK9plzzFn5ZR2AI=; b=tnzs3PkDaolzcpQNOJFlM+si+
	mdTx/1DbHqeP++879cmO1xPAhIp1EHDICY8GEEjTZvWyfW6v4+m9eKO9Sz3RP9frC8sbxLZtICJAP
	KrRezjaVLW6pBiIDL7tGaMTJTA++qR3Xm91Pjc/Yir55mxcuq5TqiTsyb9iU8aI90u3cznMFDCLxC
	tytqCkbdXT8LaCtAu2/ayH5FyoSP7OLcvU2GddAgbd8k9n5n7/4NEyKzfvKsViErVFpw92neoxpEp
	Qz96g2EBIe1tFc9cGaU05XQ1nUyXnA2u6st+OUEBWbvLqa9hs6CgEZTUGE8ytwOLZcbeksVamaH9k
	yS9bztucQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPMpb-0001xP-TW; Mon, 05 Oct 2020 09:30:55 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPMpZ-0001wM-Ad
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 09:30:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 147F1AD1A;
 Mon,  5 Oct 2020 09:30:51 +0000 (UTC)
Subject: Re: [RFC PATCH] nvme: add 'queue_if_no_path' semantics
To: Christoph Hellwig <hch@lst.de>
References: <20201002160634.11821-1-hare@suse.de>
 <20201005092405.GA18193@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d6710652-0733-15fe-518f-9ec4ab10a57d@suse.de>
Date: Mon, 5 Oct 2020 11:30:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005092405.GA18193@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_053053_478751_54B77975 
X-CRM114-Status: GOOD (  24.99  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAvNS8yMCAxMToyNCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gRnJpLCBP
Y3QgMDIsIDIwMjAgYXQgMDY6MDY6MzRQTSArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+
PiBDdXJyZW50bHkgbmFtZXNwYWNlcyBiZWhhdmUgZGlmZmVyZW50bHkgZGVwZW5kaW5nIG9uIHRo
ZSAnQ01JQycKPj4gc2V0dGluZy4gSWYgQ01JQyBpcyB6ZXJvLCB0aGUgZGV2aWNlIGlzIHJlbW92
ZWQgb25jZSB0aGUgbGFzdCBwYXRoCj4+IGdvZXMgYXdheS4gSWYgQ01JQyBoYXMgdGhlIG11bHRp
cGF0aCBiaXQgc2V0LCB0aGUgZGV2aWNlIGlzIHJldGFpbmVkCj4+IGV2ZW4gaWYgdGhlIGxhc3Qg
cGF0aCBpcyByZW1vdmVkLgo+PiBUaGlzIGlzIG9rYXkgZm9yIGZhYnJpY3MsIHdoZXJlIG9uZSBj
YW4gZG8gYW4gZXhwbGljaXQgZGlzY29ubmVjdAo+PiB0byByZW1vdmUgdGhlIGRldmljZSwgYnV0
IGZvciBudm1lLXBjaSB0aGlzIGluZHVjZXMgYSByZWdyZXNzaW9uCj4+IHdpdGggUENJIGhvdHBs
dWcuCj4+IFdoZW4gdGhlIE5WTWUgZGV2aWNlIGlzIG9wZW5lZCAoZWcgYnkgTUQpLCB0aGUgTlZN
ZSBkZXZpY2UgaXMgbm90Cj4+IHJlbW92ZWQgYWZ0ZXIgYSBQQ0kgaG90LXJlbW92ZS4gSGVuY2Ug
TUQgd2lsbCBub3QgYmUgbm90aWZpZWQgYWJvdXQKPj4gdGhlIGV2ZW50LCBhbmQgd2lsbCBjb250
aW51ZSB0byBjb25zaWRlciB0aGlzIGRldmljZSBhcyBvcGVyYXRpb25hbC4KPj4gQ29uc2VxdWVu
dGx5LCB1cG9uIFBDSSBob3QtYWRkIHRoZSBkZXZpY2Ugc2hvd3MgdXAgYXMgYSBuZXcgTlZNZQo+
PiBkZXZpY2UsIGFuZCBNRCB3aWxsIGZhaWwgdG8gcmVhdHRhY2ggdGhlIGRldmljZS4KPj4gU28g
dGhpcyBwYXRjaCBhZGRzIE5WTUVfTlNIRUFEX1FVRVVFX0lGX05PX1BBVEggZmxhZyB0byB0aGUg
bnNoZWFkCj4+IHRvIHJlc3RvcmUgdGhlIG9yaWdpbmFsIGJlaGF2aW91ciBmb3Igbm9uLWZhYnJp
Y3MgTlZNZSBkZXZpY2VzLgo+Pgo+PiBTdWdnZXN0ZWQtYnk6IEtlaXRoIEJ1c2NoIDxrZWl0aC5i
dXNjaEB3ZGMuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3Vz
ZS5kZT4KPiAKPiBUaGlzIHNlZW1zIHRvIGluY2x1ZGUgdGhlIHBhdGNoIGZyb20gS2VpdGggdG8g
dGVhciBkb3duIHRoZSBkaXNrCj4gZWFybGllci4gSSB0aGluayB0aGF0IG5lZWRzIHRvIHN0YXkg
YSBzZXBhcmF0ZSBwcmVwIHBhdGNoLCBvdGhlcndpc2UKPiBpdCB3aWxsIGJlIHZlcnkgaGFyZCB0
byByZXZpZXcgYW5kIHJlYXNvbiBhYm91dC4KPiAKV2Fzbid0IHN1cmUgaG93IHRvIGFwcHJvYWNo
IHRoaXMgYmVzdCwgYnV0IHllcywgc3VyZSwgSSBjYW4gc3BsaXQgaXQgb2ZmIAppbnRvIHNlcGFy
YXRlIHBhdGNoZXMsIHdpdGggdGhhdCBvbmUgZnJvbSBLZWl0aCBiZWluZyB0aGUgZmlyc3Qgb25l
LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAg
IEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJI
LCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcp
LCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
