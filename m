Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0959BC28CBC
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 16:27:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD567208E4
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 16:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IrAY44aG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD567208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l8loOhf8ykWxfGIDJHw+GgcqAFtOI/443O3KknhUMZE=; b=IrAY44aGKpxTyUwt5VIctOSsO
	xk4/PYdjaXSJV5P3oPHRqAfwtkme9w4BKe8cimMcN5p0T9g67FZfEXtnJ/9+XIa7BGfMYhlYUjSpT
	WG+mgEFFNAfBY+H2AATX20xSY4ITZRUEICZt/4iJdjmLwNS9I1fOqlUO1z2qTfHZVFndDQkG1CBug
	3vxYtqxtegmc1LMcBWpAc0IawLwn8u2bE4ufgoeaR2Fw0xO6tIL9j+iNhCLxZv7BOP3k7Hz8kQF8A
	hR0wVvft5yYeGITDe+kV1AX/HXqG/+te65u3qRRosqF00rgoNMaQQknl93Xc6EVPhyN0SzsEHJCt4
	j5pIZ17Rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWMtP-0005T5-TF; Wed, 06 May 2020 16:27:31 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWMtN-0005Rf-6M
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 16:27:30 +0000
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 19A78572F94006B0E1BE;
 Wed,  6 May 2020 17:27:22 +0100 (IST)
Received: from [127.0.0.1] (10.47.1.169) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 6 May 2020
 17:27:21 +0100
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
To: Christoph Hellwig <hch@lst.de>
References: <20200228184519.GA2281@avx2>
 <20200229055351.GA542920@dhcp-10-100-145-180.wdl.wdc.com>
 <defb25c5-5ae5-5ff9-66db-efb129bd7743@huawei.com>
 <20200506124701.GA54933@C02WT3WMHTD6> <20200506132429.GA21451@avx2>
 <2ecb88b5-b585-52ed-bb84-5b486868743a@huawei.com>
 <20200506143519.GA570@lst.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <4155a814-798c-0c7e-5433-daf719c0345c@huawei.com>
Date: Wed, 6 May 2020 17:26:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200506143519.GA570@lst.de>
Content-Language: en-US
X-Originating-IP: [10.47.1.169]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200506_092729_384097_4E60E730 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: sagi@grimberg.me, Will Deacon <will@kernel.org>,
 linux-nvme@lists.infradead.org, axboe@fb.com, Keith Busch <kbusch@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Alexey Dobriyan <adobriyan@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

KyBhcm02NCBndXlzIChQbGVhc2Ugbm90ZSBXQVJOIGJlbG93LCBnZW5lcmF0ZWQgd2hlbiB0ZXN0
aW5nIE5WTWUpCgpPbiAwNi8wNS8yMDIwIDE1OjM1LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZTo+
IE9uIFdlZCwgTWF5IDA2LCAyMDIwIGF0IAowMjo0NDo1MFBNICswMTAwLCBKb2huIEdhcnJ5IHdy
b3RlOgo+PiBJJ2QgcmF0aGVyIGhlYXIgdGhlIG1haW50YWluZXLigJlzIG9waW5pb24gYmVmb3Jl
IGJvdGhlcmluZyB0ZXN0aW5nIHRoaXMuLi4KPiAKPiBBcyB0aGUgb3RoZXIgbWFpbnRhaW5lciAt
IHBsZWFzZSBnaXZlIGl0IGEgc3Bpbi4gCgpvaywgc28gSSBoYXZlIHRlc3RlZCB3aXRoIHRoZSBt
b2RpZmljYXRpb24gZnJvbSBLZWl0aCAodG8gYXZvaWQgdGhlIApSRUFEX09OQ0UoKSksIGFuZCBp
dCdzIG9rIGZvciB1c2VfdGhyZWFkZWRfaW50ZXJydXB0cz0xLgoKSG93ZXZlciwgZm9yIHVzZV90
aHJlYWRlZF9pbnRlcnJ1cHRzPTAsIEkgc2VlIGEgbmV3IGlzc3VlOgoKWyAgMTIyLjUyNDI5MF0g
V0FSTklORzogQ1BVOiA4NiBQSUQ6IDExNTcgYXQgCmRyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1h
cm0uYzozMDQKX19hcm1fbHBhZV9tYXArMHgxZDAvMHgyYmMKW1IoNjApXSBbMC4wJSBkWyAgMTIy
LjUzMzY0MF0gTW9kdWxlcyBsaW5rZWQgaW46ClsgIDEyMi41MzgwNjJdIENQVTogODYgUElEOiAx
MTU3IENvbW06IGZpbyBUYWludGVkOiBHICAgICAgICBXIAo1LjcuMC1yYzQKLWdhM2M0YTVhLWRp
cnR5ICMxNDAKWyAgMTIyLjU0Njg5Ml0gSGFyZHdhcmUgbmFtZTogSHVhd2VpIFRhaVNoYW4gMjI4
MCBWMi9CQzgyQU1EQywgQklPUyAKMjI4MC1WMiBDUyBWCjMuQjIyMC4wMiAwMy8yNy8yMDIwCm9u
ZV0gWzQ4MjJNQi8wS0JbICAxMjIuNTU1NzIyXSBwc3RhdGU6IDYwNDAwMDA5IChuWkN2IGRhaWYg
K1BBTiAtVUFPKQpbICAxMjIuNTYxODcwXSBwYyA6IF9fYXJtX2xwYWVfbWFwKzB4MWQwLzB4MmJj
ClsgIDEyMi41NjYwMzZdIGxyIDogX19hcm1fbHBhZV9tYXArMHhmMC8weDJiYwovMEtCIC9zXSBb
MTIzNUsvWyAgMTIyLjU3MDExNF0gc3AgOiBmZmZmODAwMDI0YjViNGIwClsgIDEyMi41NzQ3OTRd
IHgyOTogZmZmZjgwMDAyNGI1YjRiMCB4Mjg6IGZmZmZiNjJhOWU1MDNkNGMKMC8wIGlvcHNdIFtl
dGEgMVsgIDEyMi41ODAwODNdIHgyNzogMDAwMDAwMDAwMDAwMTAwMCB4MjY6IDAwMDAwMDAwMDAw
MDAwMDEKWyAgMTIyLjU4Njc1MF0geDI1OiBmZmZmMjAyN2M2ZTEwOTgwIHgyNDogMDAwMDAwMDAw
MDAwMGY0NAoxNTgwNTA0NDFkOjA2aDo1WyAgMTIyLjU5MjAzOF0geDIzOiAwMDAwMDAyN2QxMGY5
MDAwIHgyMjogMDAwMDAwMDBlZjEzMDAwMApbICAxMjIuNTk4NzA2XSB4MjE6IDAwMDAwMDAwMDAw
MDEwMDAgeDIwOiAwMDAwMDAwMDAwMDAwOTgwClsgIDEyMi42MDM5OTRdIHgxOTogZmZmZjAwMjdk
YmEzZTIwMCB4MTg6IDAwMDAwMDAwMDAwMDAwMDAKWyAgMTIyLjYwOTk3MF0geDE3OiAwMDAwMDAw
MDAwMDAwMDAwIHgxNjogMDAwMDAwMDAwMDAwMDAwMApbICAxMjIuNjE1MjU3XSB4MTU6IDAwMDAw
MDAwMDAwMDAwMDAgeDE0OiAwMDAwMDAwMDAwMDAwMDAwClsgIDEyMi42MjA1NDRdIHgxMzogMDAw
MDAwMDAwMDAwMDAwMCB4MTI6IDAwMDAwMDAwMDAwMDAwMDAKWyAgMTIyLjYyNTgzMV0geDExOiAw
MDAwMDAwMDAwMDAwMDAyIHgxMDogMDAwMDAwMDAwMDAwMTAwMApbICAxMjIuNjMxMTE5XSB4OSA6
IDAwMDAwMDAwMDAwMDEwMDAgeDggOiAwMDAwMDAwMDAwMDAwMDAwClsgIDEyMi42MzY0MDZdIHg3
IDogMDAwMDAwMDAwMDAwMDAwOSB4NiA6IGZmZmYyMDI3YzZlMTAwMDAKWyAgMTIyLjY0MTY5M10g
eDUgOiAwMDAwMDAwMDAwMDAwMDAzIHg0IDogMDAwMDAwMDAwMDAwMGY0NApbICAxMjIuNjQ2OTgw
XSB4MyA6IDAwMDAwMDAwMDAwZWYxMzAgeDIgOiAwMDAwMDAwMDAwMDAwMDAyClsgIDEyMi42NTIy
NjZdIHgxIDogMDAwMDAwMDAwMDAwMDAwMSB4MCA6IDAwMDAwMDAwMDAwMDAwMDMKWyAgMTIyLjY1
NzU1NF0gQ2FsbCB0cmFjZToKWyAgMTIyLjY1OTk4OV0gIF9fYXJtX2xwYWVfbWFwKzB4MWQwLzB4
MmJjClsgIDEyMi42NjM4MDddICBfX2FybV9scGFlX21hcCsweGYwLzB4MmJjClsgIDEyMi42Njc1
MzddICBfX2FybV9scGFlX21hcCsweGYwLzB4MmJjClsgIDEyMi42NzEyNzBdICBfX2FybV9scGFl
X21hcCsweGYwLzB4MmJjClsgIDEyMi42NzUwMDNdICBhcm1fbHBhZV9tYXArMHhkYy8weDE2NApb
ICAxMjIuNjc4NTYzXSAgYXJtX3NtbXVfbWFwKzB4MTgvMHgyOApbICAxMjIuNjgyMDM1XSAgX19p
b21tdV9tYXArMHhkYy8weDE3YwpbICAxMjIuNjg1NTA4XSAgaW9tbXVfbWFwX2F0b21pYysweDEw
LzB4MTgKWyAgMTIyLjY4OTMyNV0gIF9faW9tbXVfZG1hX21hcCsweGNjLzB4ZTQKWyAgMTIyLjY5
MzA1OF0gIGlvbW11X2RtYV9tYXBfcGFnZSsweDgwLzB4YzQKWyAgMTIyLjY5NzA1MF0gIG52bWVf
cXVldWVfcnErMHg3ZGMvMHg3ZmMKWyAgMTIyLjcwMDc4MV0gIF9fYmxrX21xX3RyeV9pc3N1ZV9k
aXJlY3RseSsweDEwOC8weDFjMApbICAxMjIuNzA1NzIyXSAgYmxrX21xX3JlcXVlc3RfaXNzdWVf
ZGlyZWN0bHkrMHg0MC8weDY0ClsgIDEyMi43MTA2NjNdICBibGtfbXFfdHJ5X2lzc3VlX2xpc3Rf
ZGlyZWN0bHkrMHg1Yy8weGYwClsgIDEyMi43MTU2OTJdICBibGtfbXFfc2NoZWRfaW5zZXJ0X3Jl
cXVlc3RzKzB4MTcwLzB4MWQwClsgIDEyMi43MjA3MjFdICBibGtfbXFfZmx1c2hfcGx1Z19saXN0
KzB4MTBjLzB4MTU4ClsgIDEyMi43MjUyMzFdICBibGtfZmx1c2hfcGx1Z19saXN0KzB4YzQvMHhk
NApbICAxMjIuNzI5MzA4XSAgYmxrX2ZpbmlzaF9wbHVnKzB4MzAvMHg0MApbICAxMjIuNzMzMDQw
XSAgYmxrZGV2X2RpcmVjdF9JTysweDNkNC8weDQ0NApbICAxMjIuNzM3MDM0XSAgZ2VuZXJpY19m
aWxlX3JlYWRfaXRlcisweDkwLzB4YWY4ClsgIDEyMi43NDE0NThdICBibGtkZXZfcmVhZF9pdGVy
KzB4M2MvMHg1NApbICAxMjIuNzQ1Mjc2XSAgYWlvX3JlYWQrMHhkYy8weDEzOApbICAxMjIuNzQ4
NDkwXSAgaW9fc3VibWl0X29uZSsweDRhYy8weGJmMApbICAxMjIuNzUyMjIxXSAgX19hcm02NF9z
eXNfaW9fc3VibWl0KzB4MTZjLzB4MWY4ClsgIDEyMi43NTY2NDVdICBlbDBfc3ZjX2NvbW1vbi5j
b25zdHByb3AuMysweGI4LzB4MTcwClsgIDEyMi43NjE0MTVdICBkb19lbDBfc3ZjKzB4NzAvMHg4
OApbICAxMjIuNzY0NzE2XSAgZWwwX3N5bmNfaGFuZGxlcisweGYwLzB4MTJjClsgIDEyMi43Njg2
MjBdICBlbDBfc3luYysweDE0MC8weDE4MApbICAxMjIuNzcxOTE4XSAtLS1bIGVuZCB0cmFjZSAy
ZTVjN2VlODQ5ZDBlYTMwIF0tLS0KWyAgMTIyLjc3NjYwNF0gLS0tLS0tLS0tLS0tWyBjdXQgaGVy
ZSBdLS0tLS0tLS0tLS0tCgphbmQgbWFueSBtb3JlIHNwZXdlZCBvdXQuIEFuZCB0aGlzIGlzIGFm
dGVyIHRoZSBSQ1Ugc3RhbGwgcmVwb3J0IGZyb20gYSAKQ1BVIGxvY2tpbmcgdXAgaGFuZGxpbmcg
dGhlIE5WTWUgaGFyZCBpbnRlcnJ1cHQgKHdoaWNoIGhhcyBiZWVuIHNlZW4gb24gCnByZXZpb3Vz
IGtlcm5lbHMpLgoKPiBUaGUgZXhwbGFuYXRpb24gZnJvbQo+IEFsZXhleSBpbiB0aGUgcmVwbHkg
dG8geW91ciBtYWlsIG1ha2VzIGNvbXBsZXRlIHNlbnNlIHRvIG1lLgo+IC4KCkkgbWVhbnQgdGhh
dCB0aGUgb3JpZ2luYWwgcGF0Y2ggY29tbWl0IGxvZyBoYWQgZGlzYXNzZW1ibHksIGV0YyB0byBw
cm92ZSAKdGhlIHdvcnRoLCBidXQgbm93IG5vdCBtdWNoIHRvIHNob3cgdGhhdCB0aGUgcGF0Y2gr
Zml4IGlzIHN0aWxsIGJldHRlci4KClRoYW5rcywKSm9obgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
