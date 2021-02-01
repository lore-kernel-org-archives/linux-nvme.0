Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE13C43381
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 10:45:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB04764DD8
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 10:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB04764DD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Q3ydnRO5RDnBgawCb0gknppRt1NL1JuT4TVO2jNZB6w=; b=DfzJo5VDHBb1mzUuW/2AyPU7+
	YRYJxcoitbNaGXzgECdIra66SgIjg7p8qu8ROT++uv6gXJT690lUiMfKyGQ31YVdo6OG/cuEBSYqV
	CpHv/LTtctSgskiUZOPbzxc6o4i70f9d+Tbc1rgY2bA6GAQskoxmIr6yZz1Bd32cNzoBgfI4M/53S
	xdnQzJwJ/3HK1SPRYY6GXIkmeX+yt7aI/blWl0LB1cvtbHeC2DpvtSMFIOEglVdbPcn1EyQ9ddYA8
	p6cnvypdXNQcmXl9yghO+fOL5gwt5sU2tp2dfVRrFHpK7ya2GORDXEc4EEMPYRolj6LXmhxIzAYNl
	9rE7A5xkw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6Wi6-0004Py-Dg; Mon, 01 Feb 2021 10:45:34 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6Wi2-0004PK-KC
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 10:45:31 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C0F62ADDD;
 Mon,  1 Feb 2021 10:45:27 +0000 (UTC)
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Chao Leng <lengchao@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
 <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
 <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
 <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
 <65392653-6b03-9195-f686-5fe4b3290bd2@suse.de>
 <81b22bbf-4dd3-6161-e63a-9699690a4e4f@huawei.com>
 <715dd943-0587-be08-2840-e0948cf0bc62@suse.de>
 <eb131d8f-f009-42e7-105d-58b84060f0dd@huawei.com>
 <ac019690-7f02-d28c-ed58-bfc8c1d48879@suse.de>
 <6ceff3cb-c9e9-7e74-92f0-dd745987c943@huawei.com>
 <114751ac-1f7d-ce5e-12c5-7d6303bdb999@suse.de>
 <aebc6c2d-4711-95ba-daf2-1cd17fc6f0e7@huawei.com>
 <47a1b796-9d91-5947-4bac-dd8f397041a3@suse.de>
 <bd37abd5-759d-efe2-fdcd-8b004a41c75a@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2752ed93-6bd5-1a13-0e05-b91e2dcc24e1@suse.de>
Date: Mon, 1 Feb 2021 11:45:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <bd37abd5-759d-efe2-fdcd-8b004a41c75a@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_054530_916136_39944CF7 
X-CRM114-Status: GOOD (  24.12  )
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
Cc: Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8xLzIxIDEwOjQwIEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4gCj4gCj4gT24gMjAyMS8yLzEg
MTY6NTcsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gT24gMi8xLzIxIDk6NDcgQU0sIENoYW8g
TGVuZyB3cm90ZToKPj4+Cj4+Pgo+Pj4gT24gMjAyMS8yLzEgMTU6MjksIEhhbm5lcyBSZWluZWNr
ZSB3cm90ZTpbIC4uIF0KPj4+PiBVcmdoLiBQbGVhc2UsIG5vLiBUaGF0IGlzIHdlbGwgaW1wb3Nz
aWJsZSB0byBkZWJ1Zy4KPj4+PiBDYW4geW91IHBsZWFzZSBvcGVuLWNvZGUgaXQgdG8gZGVtb25z
dHJhdGUgd2hlcmUgdGhlIGRpZmZlcmVuY2UgdG8gCj4+Pj4gdGhlIGN1cnJlbnQgKGFuZCBteSBm
aXhlZCkgdmVyc2lvbnMgaXM/Cj4+Pj4gSSdtIHN0aWxsIG5vdCBjbGVhciB3aGVyZSB0aGUgcHJv
YmxlbSBpcyBvbmNlIHdlIGFwcGxpZWQgYm90aCBwYXRjaGVzLgo+Pj4gRm9yIGV4YW1wbGUgYXNz
dW1lIHRoZSBsaXN0IGhhcyB0aHJlZSBwYXRoLCBhbmQgYWxsIHBhdGggaXMgbm90IAo+Pj4gTlZN
RV9BTkFfT1BUSU1JWkVEOgo+Pj4gaGVhZC0+bmV4dCA9IG5zMTsKPj4+IG5zMS0+bmV4dCA9IG5z
MjsKPj4+IG5zMi0+bmV4dCA9IGhlYWQ7Cj4+PiBvbGQtPm5leHQgPSBuczI7Cj4+Pgo+PiBBbmQg
dGhpcyBpcyB3aGVyZSBJIGhhdmUgaXNzdWVzIHdpdGguCj4+IFdoZXJlIGRvZXMgJ29sZCcgY29t
ZSBmcm9tPwo+PiBDbGVhcmx5IGl0IHdhcyBwYXJ0IG9mIHRoZSBsaXN0IGF0IG9uZSBwb2ludDsg
c28gd2hhdCBoYXBwZW5lZCB0byBpdD8KPiBJIGV4cGxhaW5lZCB0aGlzIGVhcmxpZXIuCj4gSW4g
bnZtZV9uc19yZW1vdmUsIHRoZXJlIGlzIGEgaG9sZSBiZXR3ZWVuIGxpc3RfZGVsX3JjdSBhbmQK
PiBudm1lX21wYXRoX2NsZWFyX2N1cnJlbnRfcGF0aC4gSWYgaGVhZC0+Y3VycmVudF9wYXRoIGlz
IHRoZSAib2xkIiwgYW5kCj4gdGhlICJvbGQiIGlzIHJlbW92aW5nLiBUaGUgIm9sZCIgaXMgYWxy
ZWFkeSByZW1vdmVkIGZyb20gdGhlIGxpc3QgYnkKPiBsaXN0X2RlbF9yY3UsIGJ1dCBoZWFkLT5j
dXJyZW50X3BhdGggaXMgbm90IGNsZWFyIHRvIE5VTEwgYnkKPiBudm1lX21wYXRoX2NsZWFyX2N1
cnJlbnRfcGF0aC4KPiBGaW5kIHBhdGggaXMgcmFjZSB3aXRoIG52bWVfbnNfcmVtb3ZlLCB1c2Ug
dGhlICJvbGQiIHBhc3MgdG8KPiBudm1lX3JvdW5kX3JvYmluX3BhdGggdG8gZmluZCBwYXRoLgoK
QWguIFNvIHRoaXMgc2hvdWxkIGJlIGJldHRlcjoKCkBAIC0yMDIsMTAgKzIwMiwxMiBAQCBzdGF0
aWMgc3RydWN0IG52bWVfbnMgKl9fbnZtZV9maW5kX3BhdGgoc3RydWN0IApudm1lX25zX2hlYWQg
KmhlYWQsIGludCBub2RlKQogIHN0YXRpYyBzdHJ1Y3QgbnZtZV9ucyAqbnZtZV9uZXh0X25zKHN0
cnVjdCBudm1lX25zX2hlYWQgKmhlYWQsCiAgICAgICAgICAgICAgICAgc3RydWN0IG52bWVfbnMg
Km5zKQogIHsKLSAgICAgICBucyA9IGxpc3RfbmV4dF9vcl9udWxsX3JjdSgmaGVhZC0+bGlzdCwg
Jm5zLT5zaWJsaW5ncywgc3RydWN0IApudm1lX25zLAotICAgICAgICAgICAgICAgICAgICAgICBz
aWJsaW5ncyk7Ci0gICAgICAgaWYgKG5zKQotICAgICAgICAgICAgICAgcmV0dXJuIG5zOworICAg
ICAgIGlmIChucyAmJiAhdGVzdF9iaXQoTlZNRV9OU19SRU1PVklORywgJm5zLT5mbGFncykpIHsK
KyAgICAgICAgICAgICAgIG5zID0gbGlzdF9uZXh0X29yX251bGxfcmN1KCZoZWFkLT5saXN0LCAm
bnMtPnNpYmxpbmdzLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IG52bWVfbnMsIHNpYmxpbmdzKTsKKyAgICAgICAgICAgICAgIGlmIChucykKKyAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIG5zOworICAgICAgIH0KICAgICAgICAgcmV0dXJuIGxp
c3RfZmlyc3Rfb3JfbnVsbF9yY3UoJmhlYWQtPmxpc3QsIHN0cnVjdCBudm1lX25zLCAKc2libGlu
Z3MpOwogIH0KClRoZSAnTlZNRV9OU19SRU1PVklORycgYml0IGlzIHNldCBiZWZvcmUgbGlzdF9k
ZWxfcmN1KCkgaXMgY2FsbGVkLCBzbyBpdCAKc2hvdWxkIGd1YXJkIGFnYWluc3QgdGhlIGlzc3Vl
IHlvdSBtZW50aW9uZWQuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2Ug
ICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUg
U29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkg
KEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
