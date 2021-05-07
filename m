Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB77DC43460
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 17:03:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECF261460
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 17:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECF261460
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wxKgAlRz5EOVciEZwokk/wsu7k9M2RcRf+M4hlQA5vY=; b=XsHqakhJaFYASmsxaj/hIyVLG
	OD0JT+X2VLRmBwdKAxAB/If6vTTjHsVGDGYMZrLC7Nu+rcSE4Eo0et4QX+LfYe/8osi3mlVd5qIa8
	x+86HHIGG9ezcfoj/1W2Bm3OVf6qqVBnTtJZHqCxNvDJGNDQvaSxIqWocn1fZVFYCJf8E6AW+9lFz
	x2YldbFkfp++wvSJMv6ETTcPMEobIIeGoDXsdxSy+z3NUrbwmPm8Qwa+eL+4vAyDsQ+2fZfGLhxJ2
	7+9WRKvRM78ZTntyjt2HquXSHdap12nd8PCeOOXjfXDpkaAxRaAlpihTY1RzGHuO7s5WG6hDqOoJQ
	2EbYFMsVA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lf3sS-007dVV-Pu; Fri, 07 May 2021 17:03:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf3sP-007dUh-6V
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 17:02:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=6M9i00vhJ/PWgkeef2ldeEsjK5ae3daasd11S5o7Fd8=; b=dwa94QMu32b15GbWKBoq+bJedh
 ULlcCdRFXqhlBJvnrRwK9xFWwmektfaM/ZdJUxzofiRNxO9ka7NKSvIXjx729LzIuHqYeoivagMgm
 6WhemDqKKyHwm01/2LORGeyEkv6yB7FF+/bqWMRY13VqxsX2BihGIx0dUnoKXZU+0iAcFqPlITmLO
 V8n78VIr8ObkRTrR6uVN1dlEIkv2ObbARp96PoCUZrdo31puUstAnOS1EqkP0+D8krkSh5PXOSGma
 l3fyxPbaMFEb8MCzHR0c4+LWF3fZW3SH2WXRGg84y9dK6NGLiH9O+BYmNi8gWelibphZ9McCwGd1g
 6qoEm+Ww==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf3sM-0071WZ-Li
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 17:02:56 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 552BDB1C1;
 Fri,  7 May 2021 17:02:53 +0000 (UTC)
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <daniel.wagner@suse.de>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
 <20210506074341.GC14615@lst.de>
 <96fbc678-a7e8-aaf3-5f15-8c866e683afe@suse.de>
 <d50ca6e6-5340-6f38-bc56-6f10b49d7801@grimberg.me>
 <20210506120855.GA1546@lst.de> <7cd891d9-6aa0-fd98-cbc5-1df2eabbe31d@suse.de>
 <20210507064656.GA24437@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4fd33328-9060-6e95-dd26-ab013e44c07a@suse.de>
Date: Fri, 7 May 2021 19:02:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210507064656.GA24437@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210507_100254_872327_ECB13F76 
X-CRM114-Status: GOOD (  15.76  )
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

T24gNS83LzIxIDg6NDYgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIFRodSwgTWF5
IDA2LCAyMDIxIGF0IDA1OjU0OjI5UE0gKzAyMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4g
UENJIGFuZCBmYWJyaWNzIGhhdmUgZGlmZmVyZW50IGRlZmF1bHRzOyBmb3IgUENJIHRoZSBkZXZp
Y2UgZ29lcyBhd2F5IGlmCj4+IHRoZSBsYXN0IHBhdGggKGllIHRoZSBjb250cm9sbGVyKSBnb2Vz
IGF3YXksIGZvciBmYWJyaWNzIGl0IGRvZXNuJ3QgaWYgdGhlCj4+IGRldmljZSBpcyBtb3VudGVk
Lgo+IAo+IEVyciwgbm8uICBGb3IgZmFicmljcyB3ZSByZWNvbm5lY3QgYSB3aGlsZSwgYnV0IG90
aGVyd2lzZSB0aGUgYmVoYXZpb3IKPiBpcyB0aGUgc2FtZSByaWdodCBub3cuCj4gCk5vLCB0aGF0
IGlzIG5vdCB0aGUgY2FzZS4KCldoZW4gYSBQQ0kgbnZtZSBkZXZpY2Ugd2l0aCBDTUlDPTAgaXMg
cmVtb3ZlZCAodmlhIHBjaSBob3RwbHVnLCBzYXkpLCAKdGhlIG52bWUgZGV2aWNlIGlzIGNvbXBs
ZXRlbHkgcmVtb3ZlZCwgaXJyZXNwZWN0aXZlIG9uIHdoZXRoZXIgaXQncyAKbW91bnRlZCBvciBu
b3QuCldoZW4gdGhlIF9zYW1lXyBQQ0kgZGV2aWNlIHdpdGggQ01JQz0xIGlzIHJlbW92ZWQsIHRo
ZSBudm1lIGRldmljZSAoaWUgCnRoZSBuc25oZWFkKSB3aWxsIF9zdGF5XyB3aGVuIG1vdW50ZWQg
KGFzIHRoZSByZWZjb3VudCBpcyBub3QgemVybykuCgpUaGlzIGNhbiBiZSBlYXNpbHkgZGVtb25z
dHJhdGVkIG9uIHFlbXU7IGp1c3Qgc2V0IHRoZSAnc3Vic3lzJyBwYXJhbWV0ZXIgCmZvciB0aGUg
bnZtZSBkZXZpY2UuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAg
ICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29s
dXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFH
IE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
