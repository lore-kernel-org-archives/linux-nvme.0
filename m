Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCC0C41604
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 08:29:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7802078E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 08:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lNqyEdhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7802078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z9x6kkWy4exQk0NH+/vIISocYBtAl2O2mk3ekiYcUfg=; b=lNqyEdhZz0pRL7i6iK74yYo9Z
	I4MeumbubBoJRttQ5NLUeyMta6mEqhM7wvvxv4DS+cs2p07cPaoZmshIfGbhKuG3AATREcRH4O38L
	Zd3iFrAsR0xHGrMvDFv0Zxva6oSbc9AAF0/vggi4bg3ufHAjYEeMP2mA88vOFYtMk/QJjDwDS9P0l
	dWgfnQYORLV5Vx+HslW1NG3aEcJMu6G9+RpGn2RE66TtZ0Huyyejs7MMgFgcICrfVZ6CSEayRTIkN
	ur7qoL15hIfEuL/0HvyhUMWxCO3SODhZadA+EwTyi9dXN1Ues4VasXPIxScH/3gdIG9nniZJ1BwW7
	0hRTuZMcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPiM5-00005i-UJ; Tue, 06 Oct 2020 08:29:54 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPiM3-0008WL-EU
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 08:29:52 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 319E3ACC8;
 Tue,  6 Oct 2020 08:29:50 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme: add 'queue_if_no_path' semantics
To: Christoph Hellwig <hch@lst.de>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-3-hare@suse.de> <20201005125201.GB1125@lst.de>
 <8d7d4803-5808-0839-ee4f-e36a12756497@suse.de>
 <20201006075153.GA10041@lst.de>
 <b720433b-5849-2e7f-d359-53247976bad5@suse.de>
 <20201006082727.GC10243@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a848297e-3243-6366-86ee-0800d51198e1@suse.de>
Date: Tue, 6 Oct 2020 10:29:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201006082727.GC10243@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_042951_610090_9B0C95EB 
X-CRM114-Status: GOOD (  20.91  )
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

T24gMTAvNi8yMCAxMDoyNyBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gVHVlLCBP
Y3QgMDYsIDIwMjAgYXQgMTA6MDc6NDlBTSArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+
PiBPbiAxMC82LzIwIDk6NTEgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+Pj4gT24gVHVl
LCBPY3QgMDYsIDIwMjAgYXQgMDc6NDg6NDBBTSArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3Rl
Ogo+Pj4+IFdlbGwsIGJlY2F1c2UgaXQncyBlc3RhYmxpc2hlZCBiZWhhdmlvdXIgb2YgdGhlIGN1
cnJlbnQgY29kZS4KPj4+PiBDaGFuZ2luZyBpdCBub3cgaGFzIHRoZSBwb3RlbnRpYWwgdG8gYnJl
YWsgZXhpc3Rpbmcgc2NlbmFyaW9zLgo+Pj4+Cj4+Pj4gRm9yIFBDSSAoaWUgbm9uLWZhYnJpY3Mp
IHRoZSBjdXJyZW50IGJlaGF2aW91ciBpcyBhcmd1YWJseSBhIGNvcm5lciBjYXNlCj4+Pj4gKGFz
IG9uZSBuZWVkcyB0byBoYXZlIGEgUENJLU5WTWUgd2l0aCBDTUlDIGJpdCBzZXQpLCBidXQgb25j
ZSB5b3UgaGF2ZSBpdAo+Pj4+IFBDSSBob3RwbHVnIGlzIGRvbmUgZm9yLiBTbyB0aGVyZSB3ZSBy
ZWFsbHkgd2FudCB0byBjaGFuZ2UgdGhlIGJlaGF2aW91ciB0bwo+Pj4+IGdldCB0aGUgc2FtZSB1
c2VyIGV4cGVyaWVuY2UgZm9yIGFsbCBOVk1lIGRyaXZlcy4KPj4+Cj4+PiBEdWFsIHBvcnQgUENJ
IE5WTWUgZGV2aWNlcyBhcmUgcHJldHR5IGNvbW1vbiBpbiB0aGUgZW50ZXJwcmlzZSBzcGFjZS4K
Pj4+IEkgcmVhbGx5IGRvbid0IHNlZSBhbnkgZ29vZCByZWFzb24gdG8gZGlmZmVyIGhlcmUuCj4+
Pgo+PiA/Cj4+IERpZmZlciBmcm9tIHdoYXQ/Cj4+Cj4+IE5vcm1hbCAobm9uLWR1YWwgcG9ydGVk
KSBQQ0ktTlZNZT8KPj4gTlZNZS1vRj8KPiAKPiBBbGwgbXVsdGlwYXRoIGRldmljZXMgc2hvdWxk
IGJlaGF2ZSB0aGUgc2FtZS4gIE5vIHNwZWNpYWwgY2FzaW5nIGZvcgo+IFBDSWUsIHBsZWFzZS4K
PiAKRXZlbiBpZiB0aGUgZGVmYXVsdCBiZWhhdmlvdXIgYnJlYWtzIFBDSSBob3RwbHVnPwoKQ2hl
ZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBT
dG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTEx
IDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRz
dHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxp
eCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
