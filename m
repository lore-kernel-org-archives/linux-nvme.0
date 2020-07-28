Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6051DC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 08:18:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE6B2250E
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 08:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mknkvakd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE6B2250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AUFwmW1t0wC4oogMSmrgjQi2vbj1Nzi4QlGIfZ74w24=; b=Mknkvakd6ED74uRWgYt5klNHc
	f1awhZ4fmD9XNZ5wST8IABK7AuA5YD/q102/d09RnHggQ3UuVCIYw+i8SMoBpXe1ihIHMZPlzvE1F
	AZpemWD7eyrsPu/7umKJ0r00HTvkhtrdEHr1E76ZFShBlrXC2JJdaq0AcEdY6yHmt+x3IMYGOtcSX
	/oZ6tNTVnyJyqldCwZ268huz7huldfDWuE4OUzr7lnVwLfjuqZ4hiSvWVcBFq6H77Mnbnsf36ewcZ
	N2b3ue3eQwFobUu2ycrd6Lm365DwwHgKqBhOvYg3o0r6VIxzaFFJcNETnIaGnsrUbUKi3fcB8CEed
	tWkDePgiA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Kos-0004H3-8a; Tue, 28 Jul 2020 08:18:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Kop-0004GT-OP
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 08:18:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7742EB0BF;
 Tue, 28 Jul 2020 08:18:49 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme-multipath: do not fall back to
 __nvme_find_path() for non-optimized paths
To: Christoph Hellwig <hch@lst.de>
References: <20200727160803.55683-1-hare@suse.de>
 <20200727160803.55683-3-hare@suse.de>
 <bb5ad6b6-c0b2-213e-e16a-a6bfcba394e1@grimberg.me>
 <25b94bcf-1730-da16-6a1f-b68ffa4b8970@suse.de>
 <20200728080223.GA22321@lst.de>
 <93ab83e5-2293-2b78-32dc-af08463f4a24@suse.de>
 <20200728081632.GA22985@lst.de>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 mQINBE6KyREBEACwRN6XKClPtxPiABx5GW+Yr1snfhjzExxkTYaINHsWHlsLg13kiemsS6o7
 qrc+XP8FmhcnCOts9e2jxZxtmpB652lxRB9jZE40mcSLvYLM7S6aH0WXKn8bOqpqOGJiY2bc
 6qz6rJuqkOx3YNuUgiAxjuoYauEl8dg4bzex3KGkGRuxzRlC8APjHlwmsr+ETxOLBfUoRNuE
 b4nUtaseMPkNDwM4L9+n9cxpGbdwX0XwKFhlQMbG3rWA3YqQYWj1erKIPpgpfM64hwsdk9zZ
 QO1krgfULH4poPQFpl2+yVeEMXtsSou915jn/51rBelXeLq+cjuK5+B/JZUXPnNDoxOG3j3V
 VSZxkxLJ8RO1YamqZZbVP6jhDQ/bLcAI3EfjVbxhw9KWrh8MxTcmyJPn3QMMEp3wpVX9nSOQ
 tzG72Up/Py67VQe0x8fqmu7R4MmddSbyqgHrab/Nu+ak6g2RRn3QHXAQ7PQUq55BDtj85hd9
 W2iBiROhkZ/R+Q14cJkWhzaThN1sZ1zsfBNW0Im8OVn/J8bQUaS0a/NhpXJWv6J1ttkX3S0c
 QUratRfX4D1viAwNgoS0Joq7xIQD+CfJTax7pPn9rT////hSqJYUoMXkEz5IcO+hptCH1HF3
 qz77aA5njEBQrDRlslUBkCZ5P+QvZgJDy0C3xRGdg6ZVXEXJOQARAQABtCpIYW5uZXMgUmVp
 bmVja2UgKFN1U0UgTGFicykgPGhhcmVAc3VzZS5kZT6JAkEEEwECACsCGwMFCRLMAwAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheABQJOisquAhkBAAoJEGz4yi9OyKjPOHoQAJLeLvr6JNHx
 GPcHXaJLHQiinz2QP0/wtsT8+hE26dLzxb7hgxLafj9XlAXOG3FhGd+ySlQ5wSbbjdxNjgsq
 FIjqQ88/Lk1NfnqG5aUTPmhEF+PzkPogEV7Pm5Q17ap22VK623MPaltEba+ly6/pGOODbKBH
 ak3gqa7Gro5YCQzNU0QVtMpWyeGF7xQK76DY/atvAtuVPBJHER+RPIF7iv5J3/GFIfdrM+wS
 BubFVDOibgM7UBnpa7aohZ9RgPkzJpzECsbmbttxYaiv8+EOwark4VjvOne8dRaj50qeyJH6
 HLpBXZDJH5ZcYJPMgunghSqghgfuUsd5fHmjFr3hDb5EoqAfgiRMSDom7wLZ9TGtT6viDldv
 hfWaIOD5UhpNYxfNgH6Y102gtMmN4o2P6g3UbZK1diH13s9DA5vI2mO2krGz2c5BOBmcctE5
 iS+JWiCizOqia5Op+B/tUNye/YIXSC4oMR++Fgt30OEafB8twxydMAE3HmY+foawCpGq06yM
 vAguLzvm7f6wAPesDAO9vxRNC5y7JeN4Kytl561ciTICmBR80Pdgs/Obj2DwM6dvHquQbQrU
 Op4XtD3eGUW4qgD99DrMXqCcSXX/uay9kOG+fQBfK39jkPKZEuEV2QdpE4Pry36SUGfohSNq
 xXW+bMc6P+irTT39VWFUJMcSuQINBE6KyREBEACvEJggkGC42huFAqJcOcLqnjK83t4TVwEn
 JRisbY/VdeZIHTGtcGLqsALDzk+bEAcZapguzfp7cySzvuR6Hyq7hKEjEHAZmI/3IDc9nbdh
 EgdCiFatah0XZ/p4vp7KAelYqbv8YF/ORLylAdLh9rzLR6yHFqVaR4WL4pl4kEWwFhNSHLxe
 55G56/dxBuoj4RrFoX3ynerXfbp4dH2KArPc0NfoamqebuGNfEQmDbtnCGE5zKcR0zvmXsRp
 qU7+caufueZyLwjTU+y5p34U4PlOO2Q7/bdaPEdXfpgvSpWk1o3H36LvkPV/PGGDCLzaNn04
 BdiiiPEHwoIjCXOAcR+4+eqM4TSwVpTn6SNgbHLjAhCwCDyggK+3qEGJph+WNtNU7uFfscSP
 k4jqlxc8P+hn9IqaMWaeX9nBEaiKffR7OKjMdtFFnBRSXiW/kOKuuRdeDjL5gWJjY+IpdafP
 KhjvUFtfSwGdrDUh3SvB5knSixE3qbxbhbNxmqDVzyzMwunFANujyyVizS31DnWC6tKzANkC
 k15CyeFC6sFFu+WpRxvC6fzQTLI5CRGAB6FAxz8Hu5rpNNZHsbYs9Vfr/BJuSUfRI/12eOCL
 IvxRPpmMOlcI4WDW3EDkzqNAXn5Onx/b0rFGFpM4GmSPriEJdBb4M4pSD6fN6Y/Jrng/Bdwk
 SQARAQABiQIlBBgBAgAPBQJOiskRAhsMBQkSzAMAAAoJEGz4yi9OyKjPgEwQAIP/gy/Xqc1q
 OpzfFScswk3CEoZWSqHxn/fZasa4IzkwhTUmukuIvRew+BzwvrTxhHcz9qQ8hX7iDPTZBcUt
 ovWPxz+3XfbGqE+q0JunlIsP4N+K/I10nyoGdoFpMFMfDnAiMUiUatHRf9Wsif/nT6oRiPNJ
 T0EbbeSyIYe+ZOMFfZBVGPqBCbe8YMI+JiZeez8L9JtegxQ6O3EMQ//1eoPJ5mv5lWXLFQfx
 f4rAcKseM8DE6xs1+1AIsSIG6H+EE3tVm+GdCkBaVAZo2VMVapx9k8RMSlW7vlGEQsHtI0FT
 c1XNOCGjaP4ITYUiOpfkh+N0nUZVRTxWnJqVPGZ2Nt7xCk7eoJWTSMWmodFlsKSgfblXVfdM
 9qoNScM3u0b9iYYuw/ijZ7VtYXFuQdh0XMM/V6zFrLnnhNmg0pnK6hO1LUgZlrxHwLZk5X8F
 uD/0MCbPmsYUMHPuJd5dSLUFTlejVXIbKTSAMd0tDSP5Ms8Ds84z5eHreiy1ijatqRFWFJRp
 ZtWlhGRERnDH17PUXDglsOA08HCls0PHx8itYsjYCAyETlxlLApXWdVl9YVwbQpQ+i693t/Y
 PGu8jotn0++P19d3JwXW8t6TVvBIQ1dRZHx1IxGLMn+CkDJMOmHAUMWTAXX2rf5tUjas8/v2
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <52414c8f-bc38-be41-8093-e55a6831a43a@suse.de>
Date: Tue, 28 Jul 2020 10:18:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200728081632.GA22985@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_041840_012928_3D74999C 
X-CRM114-Status: GOOD (  24.37  )
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
 Keith Busch <keith.busch@wdc.com>, Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNy8yOC8yMCAxMDoxNiBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gVHVlLCBK
dWwgMjgsIDIwMjAgYXQgMTA6MTQ6MTRBTSArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+
PiBPbiA3LzI4LzIwIDEwOjAyIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4+IE9uIFR1
ZSwgSnVsIDI4LCAyMDIwIGF0IDA4OjI1OjE4QU0gKzAyMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90
ZToKPj4+Pj4gTWF5YmUgaW5zdGVhZCBvZiB0aGUgZWFybHkgcmV0dXJuIHB1dCB0aGUgZm9sbG93
aW5nIGNvbmRpdGlvbiBvbiBlbHNlPwo+Pj4+Cj4+Pj4gVGhhdCBkZXBlbmRzIG9uIHdoZXRoZXIg
d2Ugd2FudCB0byBoYXZlIGEgZmFsbGJhY2sgdG8gX19udm1lX2ZpbmRfcGF0aCgpIG9yIAo+Pj4+
IG5vdC4gV2l0aCB5b3VyIHN1Z2dlc3Rpb24gd2Ugd291bGQgbG9zZSB0aGF0OyBJJ2QgcmF0aGVy
IGtlZXAgaXQuCj4+Pgo+Pj4gV2h5IHdvdWxkIHdlIHdhbnQgdG8gZmFsbCBiYWNrPyAgbnZtZV9y
b3VuZF9yb2Jpbl9wYXRoIG9ubHkKPj4+IHJldHVybnMgTlVMTCBpbiBjYXNlIHRoZXJlIGlzIGEg
c2luZ2xlIGRpc2FibGVkIHBhdGgsIGluIHdoaWNoCj4+PiBjYXNlIF9fbnZtZV9maW5kX3BhdGgg
d29uJ3QgZmluZCBhbnl0aGluZyBlaXRoZXIuICBJJ2QgZ28gZm9yIHNvbWV0aGluZwo+Pj4gbGlr
ZSB0aGlzOgo+Pj4KPj4+IC0tLQo+Pj4gRnJvbSA0ZjU3ODM2NGEzZDE1ODk4YzdkNzE1MzE1YTMz
NzFiMmY3MWRiNDE2IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQo+Pj4gRnJvbTogSGFubmVzIFJl
aW5lY2tlIDxoYXJlQHN1c2UuZGU+Cj4+PiBEYXRlOiBNb24sIDI3IEp1bCAyMDIwIDE4OjA4OjAz
ICswMjAwCj4+PiBTdWJqZWN0OiBudm1lLW11bHRpcGF0aDogZG8gbm90IGZhbGwgYmFjayB0byBf
X252bWVfZmluZF9wYXRoKCkgZm9yCj4+PiAgbm9uLW9wdGltaXplZCBwYXRocwo+Pj4KPj4+IFdo
ZW4gbnZtZV9yb3VuZF9yb2Jpbl9wYXRoKCkgZmluZHMgYSB2YWxpZCBuYW1lc3BhY2Ugd2Ugc2hv
dWxkIGJlIHVzaW5nIGl0Owo+Pj4gZmFsbGluZyBiYWNrIHRvIF9fbnZtZV9maW5kX3BhdGgoKSBm
b3Igbm9uLW9wdGltaXplZCBwYXRocyB3aWxsIGNhdXNlIHRoZQo+Pj4gcmVzdWx0IGZyb20gbnZt
ZV9yb3VuZF9yb2Jpbl9wYXRoKCkgdG8gYmUgaWdub3JlZCBmb3Igbm9uLW9wdGltaXplZCBwYXRo
cy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gV2lsY2sgPG13aWxja0BzdXNlLmNvbT4K
Pj4+IFNpZ25lZC1vZmYtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgo+Pj4gUmV2
aWV3ZWQtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4+PiBTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPj4+IC0tLQo+Pj4gIGRyaXZlcnMv
bnZtZS9ob3N0L211bHRpcGF0aC5jIHwgMTEgKysrKysrKy0tLS0KPj4+ICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYyBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0
aC5jCj4+PiBpbmRleCA5M2M3MGUxNTkxZGU4Zi4uM2RlZDU0ZDJjOWM2YWQgMTAwNjQ0Cj4+PiAt
LS0gYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+Pj4gKysrIGIvZHJpdmVycy9udm1l
L2hvc3QvbXVsdGlwYXRoLmMKPj4+IEBAIC0yODEsMTAgKzI4MSwxMyBAQCBpbmxpbmUgc3RydWN0
IG52bWVfbnMgKm52bWVfZmluZF9wYXRoKHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQpCj4+PiAg
CXN0cnVjdCBudm1lX25zICpuczsKPj4+ICAKPj4+ICAJbnMgPSBzcmN1X2RlcmVmZXJlbmNlKGhl
YWQtPmN1cnJlbnRfcGF0aFtub2RlXSwgJmhlYWQtPnNyY3UpOwo+Pj4gLQlpZiAoUkVBRF9PTkNF
KGhlYWQtPnN1YnN5cy0+aW9wb2xpY3kpID09IE5WTUVfSU9QT0xJQ1lfUlIgJiYgbnMpCj4+PiAt
CQlucyA9IG52bWVfcm91bmRfcm9iaW5fcGF0aChoZWFkLCBub2RlLCBucyk7Cj4+PiAtCWlmICh1
bmxpa2VseSghbnMgfHwgIW52bWVfcGF0aF9pc19vcHRpbWl6ZWQobnMpKSkKPj4+IC0JCW5zID0g
X19udm1lX2ZpbmRfcGF0aChoZWFkLCBub2RlKTsKPj4+ICsJaWYgKHVubGlrZWx5KCFucykpCj4+
PiArCQlyZXR1cm4gX19udm1lX2ZpbmRfcGF0aChoZWFkLCBub2RlKTsKPj4+ICsKPj4+ICsJaWYg
KFJFQURfT05DRShoZWFkLT5zdWJzeXMtPmlvcG9saWN5KSA9PSBOVk1FX0lPUE9MSUNZX1JSKQo+
Pj4gKwkJcmV0dXJuIG52bWVfcm91bmRfcm9iaW5fcGF0aChoZWFkLCBub2RlLCBucyk7Cj4+PiAr
CWlmICh1bmxpa2VseSghbnZtZV9wYXRoX2lzX29wdGltaXplZChucykpKQo+Pj4gKwkJcmV0dXJu
IF9fbnZtZV9maW5kX3BhdGgoaGVhZCwgbm9kZSk7Cj4+PiAgCXJldHVybiBuczsKPj4+ICB9Cj4+
PiAgCj4+Pgo+Pgo+PiBZZXMsIHRoYXQgd291bGQgd29yaywgdG9vLgo+Pgo+PiBTaG91bGQgSSBy
ZXNlbmQ/Cj4gCj4gTm8gbmVlZCwgSSBjYW4gYXBwbHkgaXQgd2l0aCB0aGUgbW9kaWZpY2F0aW9u
LiAgIEJ1dCBpZiB5b3UgaGF2ZSBhCj4gUlIgdGVzdCBzZXR1cCBpdCB3b3VsZCBiZSBncmVhdCB0
byBydW4gaXQgdGhyb3VnaCB0aGF0IGFnYWluLCBqdXN0IGluCj4gY2FzZS4KPiAKSSdtIGF0IGl0
LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtl
cm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICAr
NDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1h
eGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdG
OiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
