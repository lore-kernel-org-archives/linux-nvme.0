Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29AFC433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 08:48:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B8C613B4
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 08:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B8C613B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wrSdyGW+g5p1nH2h77eSPNYsI9v+f0gYLa9p2m7bb6U=; b=TUGlvgDpwWcSBBngNYKyM3C9/
	aQ5oRtJTRpGVe1xrWFYFgaeKH6x7ZjEs6Y3W3wnIxlvybHTc08wtwMVbUr2op7JMcU6duob8HjxMo
	OMpR6Z15ybO5S3mqqlCz/ega83joq6C6FBsn8zOKiJ5zobZvXA+wqlG9y7ds+ZNvi+Kh21XEzyplT
	sUcf25Jmujve+NmEp2vxrs1008JZLmZoYU06Af7v6jAXB6VJm7beqqChTpEH69jYpBXSTbmX+AoRl
	YXUZum7H/gYgAvYMNlfTFQG457KjUuZDU4/uWVFN0nS+6UFoy+KCWo3cZvByFnh5dCFHL/mfP4NTn
	hmZLTWeDg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leDBj-000f7A-0v; Wed, 05 May 2021 08:47:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leDBg-000f6q-3x
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 08:47:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=xpopayPlz0HEqTf2GlUDFPqLTv1T8sCJTmVSysmNvwA=; b=3TzENdHDweVCvBzUD9KxPtuBh3
 kZH5Ulf+Ed0ZEmi7HavYqmnmh2DsnjSQdH9PkYVY9rAMTV5N8xFhWDRJQ8Bzzefga2A6iNV75ZcvJ
 IgBmpdDKuhpzjHCb4cdJ+0RWERVNbbQ85edY4/gDZSoIfdxCRfdoDtWKjhaMfRym3FE9/A0yqpexg
 iXZ6nDgDl4v9Rv3+q1mhrnD6pfLYa1C+ydKxuOt5oIFOf/sb34ZqKoxZKWCHV5pkUs5BLyaKBYQC/
 TDohCJFD3PF5jvAWtH4qqqCe4IvKc+T59ey68tTzffyl+8+jzv8v4jtH3i5epKR71Nqa6xxm6t8Ge
 hQl+3lrg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leDBd-004aJe-Dj
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 08:47:18 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2CEABAEAA;
 Wed,  5 May 2021 08:47:15 +0000 (UTC)
Subject: Re: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection. The
 driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
To: Sagi Grimberg <sagi@grimberg.me>, Martin Belanger
 <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 Martin Belanger <martin.belanger@dell.com>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
 <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <b47456a5-69ae-1f33-30f0-aa25906668f2@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <27a0071d-7c7b-ee5b-41a2-d5eb8de12928@suse.de>
Date: Wed, 5 May 2021 10:47:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <b47456a5-69ae-1f33-30f0-aa25906668f2@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_014717_629220_E1380B9D 
X-CRM114-Status: GOOD (  20.54  )
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

T24gNS80LzIxIDk6NTYgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+IEZyb206IE1hcnRp
biBCZWxhbmdlciA8bWFydGluLmJlbGFuZ2VyQGRlbGwuY29tPgo+IAo+IENoYW5nZSBsb2cgaXMg
bWlzc2luZy4uLgo+IAo+Pgo+PiAtLS0KPj4gwqAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jwqDC
oMKgIHzCoCA1ICsrKysrCj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYyB8IDE0ICsr
KysrKysrKysrKysKPj4gwqAgZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5oIHzCoCA2ICsrKysr
LQo+PiDCoCBkcml2ZXJzL252bWUvaG9zdC90Y3AuY8KgwqDCoMKgIHwgNDEgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLQo+PiDCoCA0IGZpbGVzIGNoYW5nZWQsIDYyIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gaW5kZXggMjg4YWM0N2Zm
NWI0Li45MWFlMTFhMWFlMjYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
Ywo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gQEAgLTM5NjEsNiArMzk2MSwx
MSBAQCBzdGF0aWMgaW50IG52bWVfY2xhc3NfdWV2ZW50KHN0cnVjdCBkZXZpY2UKPj4gKmRldiwg
c3RydWN0IGtvYmpfdWV2ZW50X2VudiAqZW52KQo+PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
ID0gYWRkX3VldmVudF92YXIoZW52LCAiTlZNRV9IT1NUX1RSQUREUj0lcyIsCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3B0cy0+aG9zdF90cmFkZHIgPzogIm5vbmUiKTsK
Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyZXQpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiByZXQ7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IGFkZF91ZXZlbnRfdmFyKGVu
diwgIk5WTUVfSE9TVF9UUklGQUNFPSVzIiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBvcHRzLT5ob3N0X3RyaWZhY2UgPzogIm5vbmUiKTsKPiAKPiBHaXZlbiB0aGF0IHRoaXMg
d2FzIHRoZSBvcmlnaW5hbCBpbnRlbnQgZm9yIGhvc3RfdHJhZGRyLCB3aHkgbm90IGhhdmUKPiBo
b3N0X3RyYWRkciByZXNvbHZlIHRoZSBpZmFjZSBmcm9tIHRoZSBhZGRyZXNzIGFuZCBzZXQgc29j
a29wdAo+IFNPX0JJTkRUT0RFVklDRSBvbiBpdD8KPiAKVGhhdCB3YXMgbXkgcXVlc3Rpb24sIHRv
by4KCkkgd291bGQgdmFzdGx5IHByZWZlciB0byBub3QgaGF2ZSBhbm90aGVyIG9wdGlvbiB0byBk
ZWFsIHdpdGgKKGFzIGl0IHJhaXNlcyB0aGUgcXVlc3Rpb24gd2hldGhlciB0byBhZGQgaXQgZWcg
ZHVyaW5nCidudm1lIGNvbm5lY3QtYWxsJykKQW5kIG9uZSBjb3VsZCBhcmd1ZSB0aGF0IHRoaXMg
d2FzIHRoZSBpbnRlbnRpb24gb2YgX2hhdmluZ18gdGhlCmhvc3RfdHJhZGRyIGFyZ3VtZW50IGlu
IHRoZSBmaXJzdCBwbGFjZSAuLi4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWlu
ZWNrZQkJICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAg
ICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2Vy
bWFueSBHbWJILCA5MDQwOSBOw7xybmJlcmcKR0Y6IEYuIEltZW5kw7ZyZmZlciwgSFJCIDM2ODA5
IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
