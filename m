Return-Path: <SRS0=GfOp=4X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD10C10DCE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2020 09:03:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3982073D
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2020 09:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YRIoewpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3982073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RPgOwNL+Vqf+ST2f5CJjbIuS8AW1/VaqThYSk5r96vA=; b=YRIoewpBJPVVVm
	JqdF6I2fHo4p+33sUH/X2iD/yWwYpJMUtFT34G51GljHWrw8AzXyb1G4q+Pnt6dEGpxOCUshXVW5Q
	4DkBsmGQt+7A/m8DxVA9kGe0iZ26F94zA1XoLCeGn5qGf4BaU2DnHAZOJ5NTFC/OA80kHTdVZISG5
	3+hCuXT9fhjjBok9tOriiBKW50o6kL4R4hsKFOWUmwf0b/ALLJPvTMDGLLR019589gqR0wxZsKxir
	g2wieZBfV7N5gZwaGm9aZsQmQaQNzDXBSJLOQNPgsVIJQ8gu3bclkP21NcyGwwGBWReofKSzEbNDF
	RLWPU7G+pc8NbM21T48w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jA8su-0001Rk-S3; Fri, 06 Mar 2020 09:03:08 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jA8sn-0001Qu-Gr
 for linux-nvme@lists.infradead.org; Fri, 06 Mar 2020 09:03:07 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EFF38B2D4;
 Fri,  6 Mar 2020 09:02:59 +0000 (UTC)
Subject: Re: [PATCH 15/29] nvmet-fc: track hostport handle for associations
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200205183753.25959-1-jsmart2021@gmail.com>
 <20200205183753.25959-16-jsmart2021@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <07d75fac-eb07-e992-e4b3-c17bedf53253@suse.de>
Date: Fri, 6 Mar 2020 10:02:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200205183753.25959-16-jsmart2021@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200306_010301_848206_AC37A7DA 
X-CRM114-Status: GOOD (  21.75  )
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
Cc: martin.petersen@oracle.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi81LzIwIDc6MzcgUE0sIEphbWVzIFNtYXJ0IHdyb3RlOgo+IEluIHByZXBhcmF0aW9uIGZv
ciBzZW5kaW5nIExTIHJlcXVlc3RzIGZvciBhbiBhc3NvY2lhdGlvbiB0aGF0Cj4gdGVybWluYXRl
cywgc2F2ZSBhbmQgdHJhY2sgdGhlIGhvc3RoYW5kbGUgdGhhdCBpcyBwYXJ0IG9mIHRoZQo+IExT
J3MgdGhhdCBhcmUgcmVjZWl2ZWQgdG8gY3JlYXRlIGFzc29jaWF0aW9ucy4KPiAKPiBTdXBwb3J0
IGNvbnNpc3RzIG9mOgo+IC0gQ3JlYXRlIGEgaG9zdHBvcnQgc3RydWN0dXJlIHRoYXQgd2lsbCBi
ZSAxOjEgbWFwcGVkIHRvIGEKPiAgIGhvc3QgcG9ydCBoYW5kbGUuIFRoZSBob3N0cG9ydCBzdHJ1
Y3R1cmUgaXMgc3BlY2lmaWMgdG8KPiAgIGEgdGFyZ2V0cG9ydC4KPiAtIFdoZW5ldmVyIGFuIGFz
c29jaWF0aW9uIGlzIGNyZWF0ZWQsIGNyZWF0ZSBhIGhvc3QgcG9ydCBmb3IKPiAgIHRoZSBob3N0
aGFuZGxlIHRoZSBDcmVhdGUgQXNzb2NpYXRpb24gTFMgd2FzIHJlY2VpdmVkIGZyb20uCj4gICBU
aGVyZSB3aWxsIGJlIG9ubHkgMSBob3N0cG9ydCBzdHJ1Y3R1cmUgY3JlYXRlZCwgd2l0aCBhbGwK
PiAgIGFzc29jaWF0aW9ucyB0aGF0IGhhdmUgdGhlIHNhbWUgaG9zdGhhbmRsZSBzaGFyaW5nIHRo
ZQo+ICAgaG9zdHBvcnQgc3RydWN0dXJlLgo+IC0gV2hlbiB0aGUgYXNzb2NpYXRpb24gaXMgdGVy
bWluYXRlZCwgdGhlIGhvc3Rwb3J0IHJlZmVyZW5jZQo+ICAgd2lsbCBiZSByZW1vdmVkLiBBZnRl
ciB0aGUgbGFzdCBhc3NvY2lhdGlvbiBmb3IgdGhlIGhvc3QKPiAgIHBvcnQgaXMgcmVtb3ZlZCwg
dGhlIGhvc3Rwb3J0IHdpbGwgYmUgZGVsZXRlZC4KPiAtIEFkZCBzdXBwb3J0IGZvciB0aGUgbmV3
IG52bWV0X2ZjX2ludmFsaWRhdGVfaG9zdCgpIGludGVyZmFjZS4KPiAgIEluIHRoZSBwYXN0LCB0
aGUgTExERCBkaWRuJ3Qgbm90aWZ5IGxvc3Mgb2YgY29ubmVjdGl2aXR5IHRvCj4gICBob3N0IHBv
cnRzIC0gdGhlIExMRCB3b3VsZCBzaW1wbHkgcmVqZWN0IG5ldyByZXF1ZXN0cyBhbmQgd2FpdAo+
ICAgZm9yIHRoZSBrYXRvIHRpbWVvdXQgdG8ga2lsbCB0aGUgYXNzb2NpYXRpb24uIE5vdywgd2hl
biBob3N0Cj4gICBwb3J0IGNvbm5lY3Rpdml0eSBpcyBsb3N0LCB0aGUgTExERCBjYW4gbm90aWZ5
IHRoZSB0cmFuc3BvcnQuCj4gICBUaGUgdHJhbnNwb3J0IHdpbGwgaW5pdGlhdGUgdGhlIHRlcm1p
bmF0aW9uIG9mIGFsbCBhc3NvY2lhdGlvbnMKPiAgIGZvciB0aGF0IGhvc3QgcG9ydC4gV2hlbiB0
aGUgbGFzdCBhc3NvY2lhdGlvbiBoYXMgYmVlbiB0ZXJtaW5hdGVkCj4gICBhbmQgdGhlIGhvc3Ro
YW5kbGUgd2lsbCBubyBsb25nZXIgYmUgcmVmZXJlbmNlZCwgdGhlIG5ldwo+ICAgaG9zdF9yZWxl
YXNlIGNhbGxiYWNrIHdpbGwgYmUgbWFkZSB0byB0aGUgbGxkZC4KPiAtIEZvciBjb21wYXRpYmls
aXR5IHdpdGggcHJpb3IgYmVoYXZpb3Igd2hpY2ggZGlkbid0IHJlcG9ydCB0aGUKPiAgIGhvc3Ro
YW5kbGU6ICB0aGUgTExERCBtdXN0IHNldCBob3N0aGFuZGxlIHRvIE5VTEwuIEluIHRoZXNlCj4g
ICBjYXNlcywgbm90IExTIHJlcXVlc3Qgd2lsbCBiZSBtYWRlLCBhbmQgbm8gaG9zdF9yZWxlYXNl
IGNhbGxiYWNrcwo+ICAgd2lsbCBiZSBtYWRlIGVpdGhlci4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBK
YW1lcyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbnZtZS90
YXJnZXQvZmMuYyB8IDE3NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTcwIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25z
KC0pCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVy
cywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICAgICBLZXJuZWwgU3Rv
cmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3
NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCBNYXhmZWxkc3Ry
LiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHRjogRmVsaXgg
SW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
