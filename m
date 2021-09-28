Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D679C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 18:33:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE26C6103E
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 18:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE26C6103E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DkPLwApKc6HDXr+XhETV5XP8WIehXZwUYNT8Mo326TM=; b=VXrW97kG72LYVM
	b9hyiVh4169lcowFmOEfbHKa227nW8Mad46aBIjqX8hBKp4MXBO/hDiZVcqjoHP9k8RYDI8qt4xPJ
	6ZJcbmFdmApnItVv/jx2mORDdc6AoYBq7KXyjdBuHAR6CuIV2uGlLoxOGfSd3vNlQMBDCLJNMxGQf
	D9vDS90aGaxzjeBT93Yajd6Tj39wN4kTFcLM/SaLF8XiGzT8BGRLMp0xHseubPH783r5ZgA+xKChP
	pMHTX4eV+9d9oODBBfvivXwG12mSxxiJobrAJAvasbm+yDgvSt4kewxwJWDC6vlN6D1nzAQrQ/fEk
	05fVqechsBpITxI6XMdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVHuY-008Soi-KG; Tue, 28 Sep 2021 18:33:02 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVHtu-008SUB-G1
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 18:32:27 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id dk4so4852301qvb.2
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=bg5/FXYy6+0jcxwwe7U26Md8Qo1QDW6vkKmJYeX4i1Y=;
 b=Hl/E00tVRRsG4VyZTxHCUyfFppftH6aDIraQlh7Zo4b85gvTNF+AYqXgzSNwc5/npf
 l06458g+lvnyddemEzX90uBn/bHB8RYcKfeo1e7FpLjMI+74Dzz/0g/94z+f7GzW+0Zd
 CfpRY5E+W8e1NS+sbJ1/ugjuNMbciPIgxXLMQk1vyLzXxq0uHenjiyziZ6R3dyiq9JVL
 p4sfE2H5q8AjNru6j9eT1fchBVmabhTgc0UQSbcACR3kakx5Tj48HjTa5txeDIwD47Yn
 QqR/fi/0MROMXY9kXIbtoFfIdbEtX3H3w3iXU5cvYHfX3miyrcJhnWwRC/Xh64nSBvuk
 yGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bg5/FXYy6+0jcxwwe7U26Md8Qo1QDW6vkKmJYeX4i1Y=;
 b=MkgHoLDnvCauZPmvipcaTvRNCqhFuC2COmwozW2kP8kmOrySRdIinCIG5TasniXPcg
 peQcdvwfttzS6HFbMQtSfna3xMtBEHmdoSHqSeIZhLc3A6Gpo/LACogmjux+bjyuW3Zr
 bFUg1lYfovmCJsb+pMoXqbpW+fpond8cnIqW6TCwDinRRQ69pj6Pl0cOTy5i5XdisF+O
 yWlxUwKY1X2gf5DXvm1ztz7lisF9bI29LdVaMZ2TIMQl49/FU3rcPLR9r/BxtQI2Sfvj
 f4y21Zq6zzyEJaGg2UjmDxBa6LcEUtwigcFDL2UAeQG6SqrksEa8kunm9J0nIPXisMKB
 rDmQ==
X-Gm-Message-State: AOAM533FaXx15skAAonFrzUKu1Fi9D/wn6frsAwzza5RZj52fWs4Wox1
 7AEh2uUxyEuystf30JQ8bwriGA==
X-Google-Smtp-Source: ABdhPJzfCJn9TE545S5oPvfgJD/DrRXSPKUbE0avVhY8SKIQnFw2dHzYLn+zJmKsF3kZryoXkBtS0Q==
X-Received: by 2002:ad4:4652:: with SMTP id y18mr7157907qvv.2.1632853940961;
 Tue, 28 Sep 2021 11:32:20 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id w185sm16014000qkd.30.2021.09.28.11.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 11:32:20 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVHtr-007FEl-RE; Tue, 28 Sep 2021 15:32:19 -0300
Date: Tue, 28 Sep 2021 15:32:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 01/20] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
Message-ID: <20210928183219.GJ3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-2-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_113222_787737_7AA14211 
X-CRM114-Status: GOOD (  32.82  )
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

T24gVGh1LCBTZXAgMTYsIDIwMjEgYXQgMDU6NDA6NDFQTSAtMDYwMCwgTG9nYW4gR3VudGhvcnBl
IHdyb3RlOgo+IE1ha2UgdXNlIG9mIHRoZSB0aGlyZCBmcmVlIExTQiBpbiBzY2F0dGVybGlzdCdz
IHBhZ2VfbGluayBvbiA2NGJpdCBzeXN0ZW1zLgo+IAo+IFRoZSBleHRyYSBiaXQgd2lsbCBiZSB1
c2VkIGJ5IGRtYV9bdW5dbWFwX3NnX3AycGRtYSgpIHRvIGRldGVybWluZSB3aGVuIGEKPiBnaXZl
biBTR0wgc2VnbWVudHMgZG1hX2FkZHJlc3MgcG9pbnRzIHRvIGEgUENJIGJ1cyBhZGRyZXNzLgo+
IGRtYV91bm1hcF9zZ19wMnBkbWEoKSB3aWxsIG5lZWQgdG8gcGVyZm9ybSBkaWZmZXJlbnQgY2xl
YW51cCB3aGVuIGEKPiBzZWdtZW50IGlzIG1hcmtlZCBhcyBQMlBETUEuCj4gCj4gVXNpbmcgdGhp
cyBiaXQgcmVxdWlyZXMgYWRkaW5nIGFuIGFkZGl0aW9uYWwgZGVwZW5kZW5jeSBvbiBDT05GSUdf
NjRCSVQgdG8KPiBDT05GSUdfUENJX1AyUERNQS4gVGhpcyBzaG91bGQgYmUgYWNjZXB0YWJsZSBh
cyB0aGUgbWFqb3JpdHkgb2YgUDJQRE1BCj4gdXNlIGNhc2VzIGFyZSByZXN0cmljdGVkIHRvIG5l
d2VyIHJvb3QgY29tcGxleGVzIGFuZCByb3VnaGx5IHJlcXVpcmUgdGhlCj4gZXh0cmEgYWRkcmVz
cyBzcGFjZSBmb3IgbWVtb3J5IEJBUnMgdXNlZCBpbiB0aGUgdHJhbnNhY3Rpb25zLgo+IAo+IFNp
Z25lZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRlbHRhdGVlLmNvbT4KPiBSZXZp
ZXdlZC1ieTogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlkaWEuY29tPgo+ICBkcml2ZXJzL3Bj
aS9LY29uZmlnICAgICAgICAgfCAgMiArLQo+ICBpbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0Lmgg
fCA1MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCj4gIDIgZmlsZXMgY2hh
bmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvS2NvbmZpZyBiL2RyaXZlcnMvcGNpL0tjb25maWcKPiBpbmRleCAwYzQ3M2Q3
NWU2MjUuLjkwYjRiZGRiMzMwMCAxMDA2NDQKPiArKysgYi9kcml2ZXJzL3BjaS9LY29uZmlnCj4g
QEAgLTE2Myw3ICsxNjMsNyBAQCBjb25maWcgUENJX1BBU0lECj4gIAo+ICBjb25maWcgUENJX1Ay
UERNQQo+ICAJYm9vbCAiUENJIHBlZXItdG8tcGVlciB0cmFuc2ZlciBzdXBwb3J0Igo+IC0JZGVw
ZW5kcyBvbiBaT05FX0RFVklDRQo+ICsJZGVwZW5kcyBvbiBaT05FX0RFVklDRSAmJiA2NEJJVAoK
UGVyaGFwcyBhIGNvbW1lbnQgdG8gZXhwbGFpbiB3aGF0IHRoZSA2NGJpdCBpcyBkb2luZz8KCj4g
IAlzZWxlY3QgR0VORVJJQ19BTExPQ0FUT1IKPiAgCWhlbHAKPiAgCSAgRW5hYmxl0ZUgZHJpdmVy
cyB0byBkbyBQQ0kgcGVlci10by1wZWVyIHRyYW5zYWN0aW9ucyB0byBhbmQgZnJvbQo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmggYi9pbmNsdWRlL2xpbnV4L3NjYXR0
ZXJsaXN0LmgKPiBpbmRleCAyNjY3NTRhNTUzMjcuLmU2MmIxY2Y2Mzg2ZiAxMDA2NDQKPiArKysg
Yi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgKPiBAQCAtNjQsNiArNjQsMjEgQEAgc3RydWN0
IHNnX2FwcGVuZF90YWJsZSB7Cj4gICNkZWZpbmUgU0dfQ0hBSU4JMHgwMVVMCj4gICNkZWZpbmUg
U0dfRU5ECQkweDAyVUwKPiAgCj4gKy8qCj4gKyAqIGJpdCAyIGlzIHRoZSB0aGlyZCBmcmVlIGJp
dCBpbiB0aGUgcGFnZV9saW5rIG9uIDY0Yml0IHN5c3RlbXMgd2hpY2gKPiArICogaXMgdXNlZCBi
eSBkbWFfdW5tYXBfc2coKSB0byBkZXRlcm1pbmUgaWYgdGhlIGRtYV9hZGRyZXNzIGlzIGEgUENJ
Cj4gKyAqIGJ1cyBhZGRyZXNzIHdoZW4gZG9pbmcgUDJQRE1BLgo+ICsgKiBOb3RlOiBDT05GSUdf
UENJX1AyUERNQSBkZXBlbmRzIG9uIENPTkZJR182NEJJVCBiZWNhdXNlIG9mIHRoaXMuCj4gKyAq
Lwo+ICsKPiArI2lmZGVmIENPTkZJR19QQ0lfUDJQRE1BCj4gKyNkZWZpbmUgU0dfRE1BX1BDSV9Q
MlBETUEJMHgwNFVMCgpBZGQgYSAKCXN0YXRpY19hc3NlcnQoX19hbGlnbm9mX18odm9pZCAqKSA9
PSA4KTsKCj8KCj4gKyNlbHNlCj4gKyNkZWZpbmUgU0dfRE1BX1BDSV9QMlBETUEJMHgwMFVMCj4g
KyNlbmRpZgo+ICsKPiArI2RlZmluZSBTR19QQUdFX0xJTktfTUFTSyAoU0dfQ0hBSU4gfCBTR19F
TkQgfCBTR19ETUFfUENJX1AyUERNQSkKPiArCj4gIC8qCj4gICAqIFdlIG92ZXJsb2FkIHRoZSBM
U0Igb2YgdGhlIHBhZ2UgcG9pbnRlciB0byBpbmRpY2F0ZSB3aGV0aGVyIGl0J3MKPiAgICogYSB2
YWxpZCBzZyBlbnRyeSwgb3Igd2hldGhlciBpdCBwb2ludHMgdG8gdGhlIHN0YXJ0IG9mIGEgbmV3
IHNjYXR0ZXJsaXN0Lgo+IEBAIC03Miw3ICs4Nyw5IEBAIHN0cnVjdCBzZ19hcHBlbmRfdGFibGUg
ewo+ICAjZGVmaW5lIHNnX2lzX2NoYWluKHNnKQkJKChzZyktPnBhZ2VfbGluayAmIFNHX0NIQUlO
KQo+ICAjZGVmaW5lIHNnX2lzX2xhc3Qoc2cpCQkoKHNnKS0+cGFnZV9saW5rICYgU0dfRU5EKQo+
ICAjZGVmaW5lIHNnX2NoYWluX3B0cihzZykJXAo+IC0JKChzdHJ1Y3Qgc2NhdHRlcmxpc3QgKikg
KChzZyktPnBhZ2VfbGluayAmIH4oU0dfQ0hBSU4gfCBTR19FTkQpKSkKPiArCSgoc3RydWN0IHNj
YXR0ZXJsaXN0ICopKChzZyktPnBhZ2VfbGluayAmIH5TR19QQUdFX0xJTktfTUFTSykpCj4gKwo+
ICsjZGVmaW5lIHNnX2lzX2RtYV9wY2lfcDJwZG1hKHNnKSAoKHNnKS0+cGFnZV9saW5rICYgU0df
RE1BX1BDSV9QMlBETUEpCgpJJ3ZlIGJlZW4gZW5jb3VyYWdpbmcgcGVvcGxlIHRvIHVzZSBzdGF0
aWMgaW5saW5lcyBtb3JlLi4KCnN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IF9fc2dfZmxhZ3Mo
c3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKewoJcmV0dXJuIHNnLT5wYWdlX2xpbmsgJiBTR19QQUdF
X0xJTktfTUFTSzsKfQpzdGF0aWMgaW5saW5lIGJvb2wgc2dfaXNfY2hhaW4oc3RydWN0IHNjYXR0
ZXJsaXN0ICpzZykKewoJcmV0dXJuIF9fc2dfZmxhZ3Moc2cpICYgU0dfQ0hBSU47Cn0Kc3RhdGlj
IGlubGluZSBib29sIHNnX2lzX2xhc3Qoc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykKewoJcmV0dXJu
IF9fc2dfZmxhZ3Moc2cpICYgU0dfRU5EOwp9CnN0YXRpYyBpbmxpbmUgYm9vbCBzZ19pc19kbWFf
cGNpX3AycGRtYShzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQp7CglyZXR1cm4gX19zZ19mbGFncyhz
ZykgJiBTR19ETUFfUENJX1AyUERNQTsKfQoKPiAgLyoqCj4gICAqIHNnX2Fzc2lnbl9wYWdlIC0g
QXNzaWduIGEgZ2l2ZW4gcGFnZSB0byBhbiBTRyBlbnRyeQo+IEBAIC04NiwxMyArMTAzLDEzIEBA
IHN0cnVjdCBzZ19hcHBlbmRfdGFibGUgewo+ICAgKiovCj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBz
Z19hc3NpZ25fcGFnZShzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLCBzdHJ1Y3QgcGFnZSAqcGFnZSkK
PiAgewo+IC0JdW5zaWduZWQgbG9uZyBwYWdlX2xpbmsgPSBzZy0+cGFnZV9saW5rICYgKFNHX0NI
QUlOIHwgU0dfRU5EKTsKPiArCXVuc2lnbmVkIGxvbmcgcGFnZV9saW5rID0gc2ctPnBhZ2VfbGlu
ayAmIFNHX1BBR0VfTElOS19NQVNLOwoKSSB0aGluayB0aGlzIHNob3VsZCBqdXN0IGJlICcmIFNH
X0VORCcsIHNnX2Fzc2lnbl9wYWdlKCkgZG9lc24ndCBsb29rCmxpa2UgaXQgc2hvdWxkIGV2ZXIg
YmUgdXNlZCBvbiBhIHNnX2NoYWluIGVudHJ5LCBzbyB0aGlzIGlzIGp1c3QKdHJ5aW5nIHRvIHBy
ZXNlcnZlIHRoZSBlbmQgc3RhbXAuCgpBbnl3YXksIHRoaXMgbG9va3MgT0sKClJldmlld2VkLWJ5
OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPgoKSmFzb24KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
