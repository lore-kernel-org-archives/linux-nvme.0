Return-Path: <SRS0=GEgN=O7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9A6C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Oct 2021 13:08:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC8E60F21
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Oct 2021 13:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AC8E60F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dhu9yKS/TiJP5NZGAUq+L2xJtrzWDHo0erOO4jK+qUU=; b=nc5nr9awrYTm5gHCpe6PQZdZ02
	CTSfRmGXFzyjs5o71rkqiR3lVW7cLIhlZjcW8GUecLUvvN/jTJuSc1hkZsAlMwUUVy6utwucsrUjT
	7eLb0UMGDWuuXtehRS8XXaQsCnW2DhbNR0HQb9NjPH+tVKeUxJqhm/BMW2qbqRwV3gNPGt+Ztwp7k
	3WEzc2MjCNVFISX6qxIzWMr7axh+ouaIAzCMyvfKFhP1HJODZztI4dJk8o/0BDmMy903cHc9jwpfO
	BxV7HeOQzkoHjUa5seXD9+/d76bwp3AdvqdPEFKhYZCNFWS4EeOVxAl8uDDW3Dhy6Kk4UJpSWVcdV
	Qz91lV0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mZv2W-009SF3-2U; Mon, 11 Oct 2021 13:08:24 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11] helo=mx1.molgen.mpg.de)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mZv2P-009SEM-Mh
 for linux-nvme@lists.infradead.org; Mon, 11 Oct 2021 13:08:22 +0000
Received: from [192.168.0.7] (ip5f5aef5a.dynamic.kabel-deutschland.de
 [95.90.239.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id A062561E5FE33;
 Mon, 11 Oct 2021 15:08:15 +0200 (CEST)
Subject: Re: SK hynix BC511: warning: nvme nvme0: missing or invalid SUBNQN
 field.
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
References: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
 <20210817161638.GC223727@dhcp-10-100-145-180.wdc.com>
 <f3f78d3c-d3f7-67f5-4263-f306b4f623d1@molgen.mpg.de>
 <20210817170222.GA224912@dhcp-10-100-145-180.wdc.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <f02a8989-d255-26ee-2fca-c9db2d1e158c@molgen.mpg.de>
Date: Mon, 11 Oct 2021 15:08:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210817170222.GA224912@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211011_060817_919978_2261399A 
X-CRM114-Status: GOOD (  19.47  )
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

RGVhciBLZWl0aCwKCgpBbSAxNy4wOC4yMSB1bSAxOTowMiBzY2hyaWViIEtlaXRoIEJ1c2NoOgo+
IE9uIFR1ZSwgQXVnIDE3LCAyMDIxIGF0IDA2OjUzOjE1UE0gKzAyMDAsIFBhdWwgTWVuemVsIHdy
b3RlOgo+PiBbY2M6ICtEZWxsLkNsaWVudC5LZXJuZWxAZGVsbC5jb20gYXMgaXTigJlzIGEgRGVs
bCBkZXZpY2VdCj4+IEFtIDE3LjA4LjIxIHVtIDE4OjE2IHNjaHJpZWIgS2VpdGggQnVzY2g6Cj4+
PiBPbiBUdWUsIEF1ZyAxNywgMjAyMSBhdCAwNToxMDo0MFBNICswMjAwLCBQYXVsIE1lbnplbCB3
cm90ZToKPj4+PiBPbiBhIERlbGwgT3B0aVBsZXggNzc4MCBBSU8vMDRHNDdXIChCSU9TIDEuNi4z
IDAzLzA4LzIwMjEpIExpbnV4IDUuMTAuNDcKPj4+PiBzaG93cyB0aGUgd2FybmluZyBiZWxvdzoK
Pj4+Pgo+Pj4+ICAgICAgICQgZG1lc2cgfCBncmVwIG52bWUKPj4+PiAgICAgICBbICAgIDMuMDE1
MzkyXSBudm1lIDAwMDA6MDI6MDAuMDogcGxhdGZvcm0gcXVpcms6IHNldHRpbmcgc2ltcGxlIHN1
c3BlbmQKPj4+PiAgICAgICBbICAgIDMuMDIxODYxXSBudm1lIG52bWUwOiBwY2kgZnVuY3Rpb24g
MDAwMDowMjowMC4wCj4+Pj4gICAgICAgWyAgICAzLjAyNjU5M10gYWhjaSAwMDAwOjAwOjE3LjA6
IHZlcnNpb24gMy4wCj4+Pj4gICAgICAgWyAgICAzLjAyNjkyMl0gYWhjaSAwMDAwOjAwOjE3LjA6
IEFIQ0kgMDAwMS4wMzAxIDMyIHNsb3RzIDEgcG9ydHMgNiBHYnBzIDB4MSBpbXBsIFNBVEEgbW9k
ZQo+Pj4+ICAgICAgIFsgICAgMy4wMzUwMjBdIGFoY2kgMDAwMDowMDoxNy4wOiBmbGFnczogNjRi
aXQgbmNxIHNudGYgcG0gY2xvIG9ubHkgcGlvIHNsdW0gcGFydCBlbXMgZGVzbyBzYWRtIHNkcyBh
cHN0Cj4+Pj4gICAgICAgWyAgICAzLjAzNTIxOV0gbnZtZSBudm1lMDogbWlzc2luZyBvciBpbnZh
bGlkIFNVQk5RTiBmaWVsZC4KPj4+PiAgICAgICBbICAgIDMuMDQ0NTE4XSBzY3NpIGhvc3QwOiBh
aGNpCj4+Pj4gICAgICAgWyAgICAzLjA1MTYzMl0gbnZtZSBudm1lMDogMTIvMC8wIGRlZmF1bHQv
cmVhZC9wb2xsIHF1ZXVlcwo+Pj4+ICAgICAgIFsgICAgMy4wNTI1OTBdIGF0YTE6IFNBVEEgbWF4
IFVETUEvMTMzIGFiYXIgbTIwNDhAMHhkMTMzOTAwMCBwb3J0IDB4ZDEzMzkxMDAgaXJxIDEyNQo+
Pj4+ICAgICAgIFsgICAgMy4wNTg1MzhdICBudm1lMG4xOiBwMSBwMiBwMwo+Pj4+Cj4+Pj4gU2hv
dWxkIGl0IGJlIGFkZGVkIHRvIHRoZSBxdWlyayBsaXN0IGluIGBkcml2ZXJzL252bWUvaG9zdC9w
Y2kuY2Agb3IgaXMgaXQgYQo+Pj4+IHJlYWwgaXNzdWVzLCB0aGUgbWFudWZhY3R1cmVyIHNob3Vs
ZCBmaXg/IElmIHNvLCBkbyB5b3UgaGF2ZSBTSyBIeW5peAo+Pj4+IGNvbnRhY3RzPwo+Pj4KPj4+
IEl0IHdvdWxkIGJlIGdyZWF0IGlmIGRldmljZSBtYWtlcnMgd291bGQgYmUgc3BlYyBjb21wbGlh
bnQsIGJ1dCB0aGUKPj4+IGRyaXZlciB3aWxsIGNvbnRpbnVlIHRvIHdvcmsgd2l0aCB0aGUgZGV2
aWNlIHRoZSBzYW1lIHdoZXRoZXIgeW91IGFkZAo+Pj4gdGhlIHF1aXJrIG9yIG5vdC4KPj4KPj4g
Q291bGQgeW91IHBsZWFzZSBwb2ludCBtZSB0byB0aGUgTlZNZSBzcGVjaWZpY2F0aW9uIHNlY3Rp
b24sIHNvIEkgY2FuIHJlZmVyCj4+IHRvIGl0LCB3aGVuIGNvbnRhY3RpbmcgdGhlIG1hbnVmYWN0
dXJlcj8KPiAKPiBJbiB0aGUgc2VjdGlvbiBmb3IgIklkZW50aWZ5IENvbnRyb2xsZXIgRGF0YSBT
dHJ1Y3R1cmUiIChzZWN0aW9uCj4gNS4xNy4yLjEsIGZpZ3VyZSAyNTcgaW4gc3BlYyB2ZXJzaW9u
IDIuMCksIHRoZSBOUU4gZGVmaW5pdGlvbiBzYXlzOgo+IAo+ICAgICJTdXBwb3J0IGZvciB0aGlz
IGZpZWxkIGlzIG1hbmRhdG9yeSBpZiB0aGUgY29udHJvbGxlciBzdXBwb3J0cyByZXZpc2lvbgo+
ICAgIDEuMi4xIG9yIGxhdGVyIgo+IAo+IFRoZSBkcml2ZXIgZG9lcyBjb25maXJtIHRoZSBjb250
cm9sbGVyJ3MgcmVwb3J0ZWQgcmV2aXNpb24gbWVldHMgdGhpcwo+IHJlcXVpcmVtZW50IGJlZm9y
ZSBlbWl0dGluZyB0aGUgd2FybmluZy4KClRoZSBEZWxsIHN1cHBvcnQgY2FtZSBiYWNrIHRvIG1l
LCBhbmQgc2FpZCwgdGhhdCBIeW5peCByZWZ1c2VzIHRvIApwdWJsaXNoIGEgZml4ZWQgZmlybXdh
cmUgdW5sZXNzIEkgc2hvdyB0aGVtIGEgdXNlIGNhc2UsIHdoZXJlIEkgbmVlZCAKdGhhdCBmaWVs
ZC4KCkNhbiBzb21lYm9keSB0aGluayBvZiBhIHVzZSBjYXNlLCBhbmQgd2h5IHRoaXMgZmllbGQg
d2FzIG1hZGUgbWFuZGF0b3J5IAppbiB0aGUgc3BlY2lmaWNhdGlvbj8KCgpLaW5kIHJlZ2FyZHMs
CgpQYXVsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
