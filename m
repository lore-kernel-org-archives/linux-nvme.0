Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAAEC433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 20:35:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0365D613D8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 20:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0365D613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IKznTrDDLloc9cO7e037ApPnNfZRv3gmOnQL4jP+CkM=; b=IVILgpX3q53JMB5btvD6k43Ko
	c1mrA2kno3JBLGI6IGAc/tMZB6Nl1G/efxW+gikxd1oCVeFYNBNy3yPblJxn169+TTpfX7mTqTI4P
	uWNY5zAHsiBOZupFlXDHMQhNOZZCoSbvAIASeRO14tTkn2p8UTw0e6fVYCjXHu7FisZqIdld6D+Oz
	XVd51IHdRDTQiSFO1R32JN9Q9g5oXTWFmGuEalnD9I0BY69DU+Sk3Ws4gYU0++KVEXDATkYq+BG9W
	FUna9WrSp8mIgfkFuoJ2orCQkimcSBzJd1w0qjHGyEQ6d/ItbdZTq7gMV0bXQvRZNZrgAaMjeFFSp
	foW5c78SA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leOEs-002HR7-Fl; Wed, 05 May 2021 20:35:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leOEp-002HQi-Ei
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 20:35:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=//56uMPfGNhXHjqOkdZs8XTdaun9fDlogYvwR+pLaAU=; b=Jvo3qafL3x3NEdf0eX6/01staS
 Vu9GGx94O02WzfOePdY75jPJNqosgZV/xSFggId74+wttHDtoq+TEokrbFSPyET3QjVfbx1HJdj3y
 AojH0b+A+JiCzpZTMfoUN2IG3CWz8Crhga44iQow2nL+QFrmaI1bce1xJrY00Gg3TOGM7sBGPtkja
 63yEaKVPUuHdsXa/w+xQ08zt/ffHxbE+4XJSLcoFurJ0QUi6BSIJKZ+kwwo6lQluCmF8BxhB2OEjw
 GOCONheClmITj4tUdOSI2kNESnyYN33Q5EvfYiPVSSbJdC3C5Ow98P/u4XozSzNyG82YcxAhicuGs
 wbFr/9Og==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leOEm-005FWK-V5
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 20:35:18 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1841613E3;
 Wed,  5 May 2021 20:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620246915;
 bh=xliXkhA+zBa4zOTRbDJGCa5LIgNHtoMIiN8GDdPDM3U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=deJsH9id9vUqQDOATPoWFeL6Ag//pBR+lLJNtETNM/qwRMZU+OV8PcXf31iXp1Q6P
 3v2JrpgIF1PLWIxrUYg4UEnxJ0kQqhQw+Is/Yi5GdI0tl3ePN5wX9+QWY+GZmy4E+9
 4XeaWC/w7dloiJIaR0Zwasmcnp6r0NKysjY0SKEOCzFyFQz0XQDnFEdIPPSPJX/qsg
 VcCth1ba9xT0Zc7CfbrTtzgSBhnu/jlz0l6ND/FJ8DKOtdyzJqGJ0TKjWHYLWKqTGR
 taZFDeQ+HJmvjzKmWfbqZy//oVIQLbYKGaSL3h+FG5OJFTuXD4sQpsL9J4FBsvZSaO
 2VFE5hpK4Y9Uw==
Date: Wed, 5 May 2021 13:35:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Message-ID: <20210505203512.GA1186807@dhcp-10-100-145-180.wdc.com>
References: <0D017D65-3D7C-4165-B25B-21E6A6FFDED5@oracle.com>
 <20210318194653.GA2690@dhcp-10-100-145-180.wdc.com>
 <20210319065158.GA11263@lst.de>
 <20210319152208.GA3794@redsun51.ssa.fujisawa.hgst.com>
 <20210319153008.GA14280@lst.de>
 <49CFFA55-5A71-4C0D-8816-11EB88087AAA@oracle.com>
 <20210319173009.GA4198@redsun51.ssa.fujisawa.hgst.com>
 <023A7AD6-3606-4C3A-8D16-5E65A55551F0@oracle.com>
 <20210505201114.GA1186772@dhcp-10-100-145-180.wdc.com>
 <07E6C0A9-D180-4A4E-A10E-2423094E71B2@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <07E6C0A9-D180-4A4E-A10E-2423094E71B2@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_133517_039893_A55C3601 
X-CRM114-Status: GOOD (  16.68  )
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

T24gV2VkLCBNYXkgMDUsIDIwMjEgYXQgMDg6MjM6NDNQTSArMDAwMCwgQWxhbiBBZGFtc29uIHdy
b3RlOgo+IAo+IAo+ID4gT24gTWF5IDUsIDIwMjEsIGF0IDE6MTEgUE0sIEtlaXRoIEJ1c2NoIDxr
YnVzY2hAa2VybmVsLm9yZz4gd3JvdGU6Cj4gPiAKPiA+IE9uIFdlZCwgTWF5IDA1LCAyMDIxIGF0
IDA2OjQwOjU0UE0gKzAwMDAsIEFsYW4gQWRhbXNvbiB3cm90ZToKPiA+PiBOZWVkIHRvIHJldmlz
aXQgdGhpcyBpc3N1ZSBhZ2Fpbi4gIEluIHRoZSBvcmlnaW5hbCBjYXNlIHdlIG5lZWRlZCB0bwo+
ID4+IGdldCBhY2Nlc3MgdG8gdGhlIGNzdHMgcmVnaXN0ZXIuIFdlIHdlcmUgYWJsZSB0byBtb3Zl
IHRvIHVzaW5nIHRoZQo+ID4+IOKAmXN0YXRl4oCZIHN5c2ZzIGF0dHJpYnV0ZS4KPiA+PiAKPiA+
PiBXZSBhcmUgbm93IGdldHRpbmcgYSBzaW1pbGFyIHJlcXVlc3QgZnJvbSBvdXIgbWFudWZhY3R1
cmluZyB0ZWFtLiBUaGV5Cj4gPj4gYXJlIHVzaW5nIG52bWUtY2xpIHNob3ctcmVncyB0byBhc3Np
c3QgZGVidWcuIFRoZSDigJlzdGF0ZeKAmSBhdHRyaWJ1dGUgaXMKPiA+PiBub3Qgc3VmZmljaWVu
dCBhbmQgdGhleSB3YW50IHRvIHVzZSB0aGUgcHJvZHVjdGlvbiB2ZXJzaW9uIG9mIHRoZQo+ID4+
IGtlcm5lbCAod2hpY2ggZW5hYmxlcyBDT05GSUdfSU9fU1RSSUNUX0RFVk1FTSkgcmF0aGVyIHRo
YW4gYSBzcGVjaWFsCj4gPj4ga2VybmVsLiBJZGVhbGx5LCB3ZSB3b3VsZCB3YW50IG52bWUtY2xp
IHNob3ctcmVncyB0byB3b3JrIHdoZXRoZXIgb3IKPiA+PiBub3QgQ09ORklHX0lPX1NUUklDVF9E
RVZNRU0gaXMgY29uZmlndXJlZC4gT3RoZXIgdGhhbiBleHBvcnRpbmcgdGhlCj4gPj4gcmVnaXN0
ZXJzIHRocnUgc3lzZnMgYXR0cmlidXRlcywgaXMgdGhlcmUgYW55IG90aGVyIG1lY2hhbmlzbSB0
byBnZXQKPiA+PiBzaG93LXJlZ3MgdGhlIGRhdGEgaXQgbmVlZHM/Cj4gPiAKPiA+IEFwcGVuZCBr
ZXJuZWwgcGFyYW1ldGVyICJpb21lbT1yZWxheGVk4oCdLgo+IAo+IFRoYXQgcmVxdWlyZXMgdGhl
IE9TIGRpc2sgdG8gYmUgbW9kaWZpZWQuICBXZSB3b3VsZCByYXRoZXIgbm90IGRvIHRoYXQuCgpP
aCwgdGhhdCBzZWVtcyBsaWtlIGEgcmVhbGx5IGdvb2QgaWRlYSB0byBtZSBmb3IgYSBtYW51ZmFj
dHVyaW5nCmVudmlyb21lbnQuIFRoZXJlIHJlYWxseSBpcyBubyBvdGhlciBvcHRpb24gb3RoZXIg
dGhhbiBtb2RpZnkgdGhlCmtlcm5lbCwgd2hpY2ggc291bmRzIG11Y2ggbW9yZSBpbnZhc2l2ZS4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
