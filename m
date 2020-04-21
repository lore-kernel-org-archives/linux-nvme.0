Return-Path: <SRS0=BHyj=6F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75431C54FCC
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 15:23:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC502068F
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 15:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IG/YrwFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC502068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PB0F2kNITXFEpBLrxmcoOoiFOFOG6/nxJvpjGlcl/zY=; b=IG/YrwFtZPR2CD
	8vub5Qa6UL8flI0GZEei8Mt60LvQiToyqJpdJMBQ76X2iCKJ21k2hFz018Mlqd6kqp5AfVC27DaNM
	mtKPyM4JqI4KfX51xIPBj8OFDl/sDJS1LGVdfpOUymMfJFyR5P52JkNKwZjBkes1xtE3DmFMlGp8R
	7PXo0srslSTwBflloxD1eCTreD/S2TcxRsRYjzToYfKqUNcVcQP7018Y6L6fsbvLZaEeIFr16ycOq
	BjybTFy5Vn1MG2yyDcELCEYsCaZAjUcBrXwVLVGkNsplNsmwI3ybMZQG+wPeVviTUytwn3Ny43sh4
	71vSwiBTIVE378ve1q1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQujx-0001Kc-2y; Tue, 21 Apr 2020 15:23:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQuju-0001Jz-Dg
 for linux-nvme@lists.infradead.org; Tue, 21 Apr 2020 15:23:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BEEA168C4E; Tue, 21 Apr 2020 17:23:07 +0200 (CEST)
Date: Tue, 21 Apr 2020 17:23:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 10/17] nvmet: add metadata characteristics for a namespace
Message-ID: <20200421152307.GC10837@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-12-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200327171545.98970-12-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200421_082310_608264_ACC8C937 
X-CRM114-Status: GOOD (  15.34  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org,
 hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBNYXIgMjcsIDIwMjAgYXQgMDg6MTU6MzhQTSArMDMwMCwgTWF4IEd1cnRvdm95IHdy
b3RlOgo+IEZyb206IElzcmFlbCBSdWtzaGluIDxpc3JhZWxyQG1lbGxhbm94LmNvbT4KPiAKPiBG
aWxsIHRob3NlIG5hbWVzcGFjZSBmaWVsZHMgZnJvbSB0aGUgYmxvY2sgZGV2aWNlIGZvcm1hdCBm
b3IgYWRkaW5nCj4gbWV0YWRhdGEgKFQxMC1QSSkgb3ZlciBmYWJyaWMgc3VwcG9ydCB3aXRoIGJs
b2NrIGRldmljZXMuCj4gCj4gU2lnbmVkLW9mZi1ieTogSXNyYWVsIFJ1a3NoaW4gPGlzcmFlbHJA
bWVsbGFub3guY29tPgo+IFNpZ25lZC1vZmYtYnk6IE1heCBHdXJ0b3ZveSA8bWF4Z0BtZWxsYW5v
eC5jb20+Cj4gUmV2aWV3ZWQtYnk6IE1hcnRpbiBLLiBQZXRlcnNlbiA8bWFydGluLnBldGVyc2Vu
QG9yYWNsZS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbnZtZS90YXJnZXQvaW8tY21kLWJkZXYuYyB8
IDIyICsrKysrKysrKysrKysrKysrKysrKysKPiAgZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5o
ICAgICAgIHwgIDMgKysrCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQo+IAo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMgYi9kcml2ZXJz
L252bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMKPiBpbmRleCBlYTBlNTk2Li5iZGY2MTFmIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvaW8tY21kLWJkZXYuYwo+ICsrKyBiL2RyaXZl
cnMvbnZtZS90YXJnZXQvaW8tY21kLWJkZXYuYwo+IEBAIC01MCw2ICs1MCw5IEBAIHZvaWQgbnZt
ZXRfYmRldl9zZXRfbGltaXRzKHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIHN0cnVjdCBudm1l
X2lkX25zICppZCkKPiAgaW50IG52bWV0X2JkZXZfbnNfZW5hYmxlKHN0cnVjdCBudm1ldF9ucyAq
bnMpCj4gIHsKPiAgCWludCByZXQ7Cj4gKyNpZmRlZiBDT05GSUdfQkxLX0RFVl9JTlRFR1JJVFkK
PiArCXN0cnVjdCBibGtfaW50ZWdyaXR5ICpiaTsKPiArI2VuZGlmCj4gIAo+ICAJbnMtPmJkZXYg
PSBibGtkZXZfZ2V0X2J5X3BhdGgobnMtPmRldmljZV9wYXRoLAo+ICAJCQlGTU9ERV9SRUFEIHwg
Rk1PREVfV1JJVEUsIE5VTEwpOwo+IEBAIC02NCw2ICs2NywyNSBAQCBpbnQgbnZtZXRfYmRldl9u
c19lbmFibGUoc3RydWN0IG52bWV0X25zICpucykKPiAgCX0KPiAgCW5zLT5zaXplID0gaV9zaXpl
X3JlYWQobnMtPmJkZXYtPmJkX2lub2RlKTsKPiAgCW5zLT5ibGtzaXplX3NoaWZ0ID0gYmxrc2l6
ZV9iaXRzKGJkZXZfbG9naWNhbF9ibG9ja19zaXplKG5zLT5iZGV2KSk7Cj4gKwo+ICsJbnMtPm1k
X3R5cGUgPSAwOwo+ICsJbnMtPm1zID0gMDsKPiArI2lmZGVmIENPTkZJR19CTEtfREVWX0lOVEVH
UklUWQo+ICsJYmkgPSBiZGV2X2dldF9pbnRlZ3JpdHkobnMtPmJkZXYpOwo+ICsJaWYgKGJpKSB7
Cj4gKwkJbnMtPm1zID0gYmktPnR1cGxlX3NpemU7Cj4gKwkJaWYgKGJpLT5wcm9maWxlID09ICZ0
MTBfcGlfdHlwZTFfY3JjKQo+ICsJCQlucy0+bWRfdHlwZSA9IE5WTUVfTlNfRFBTX1BJX1RZUEUx
Owo+ICsJCWVsc2UgaWYgKGJpLT5wcm9maWxlID09ICZ0MTBfcGlfdHlwZTNfY3JjKQo+ICsJCQlu
cy0+bWRfdHlwZSA9IE5WTUVfTlNfRFBTX1BJX1RZUEUzOwo+ICsJCWVsc2UKPiArCQkJLyogVW5z
dXBwb3J0ZWQgbWV0YWRhdGEgdHlwZSAqLwo+ICsJCQlucy0+bXMgPSAwOwo+ICsJfQo+ICsKPiAr
CXByX2RlYnVnKCJtcyAlZCBtZF90eXBlICVkXG4iLCBucy0+bXMsIG5zLT5tZF90eXBlKTsKPiAr
I2VuZGlmCgpHaXZlbiB0aGF0IGJkZXZfZ2V0X2ludGVncml0eSBpcyBzdHViYmVkIG91dCBhbmQg
cmV0dXJucyBOVUxMCmZvciB0aGUgIUNPTkZJR19CTEtfREVWX0lOVEVHUklUWSBjYXNlLCBjYW4g
d2UganVzdCBza2lwIHRoZSBpZmRlZiBhbmQKbGV0IHRoZSBjb21waWxlciBvcHRpbWl6ZSB0aGUg
ZGVhZCBjb2RlIGF3YXk/ICBJIGFsc28gZG9uJ3QgdGhpbmsgd2UKbmVlZCB0aGUgcHJfZGVidWcu
Cgo+ICsJaW50CQkJbWRfdHlwZTsKPiArCWludAkJCW1zOwoKQ2FuIHdlIHVzZSBtb3JlIGRlc2Ny
aXB0aXZlIG5hbWVzPyAgbWRfdHlwZSBzZWVtcyB0byBiZSB3aGF0IHdlIGNhbGwKcGlfdHlwZSBl
bHNld2hlcmUsIGFu0ZUgbXMgY291bGQgYmUgc3BlbGxlZCBvdXQgYXMgbWV0YWRhdGFfc2l6ZS4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
