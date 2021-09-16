Return-Path: <SRS0=Ydhk=OG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B82C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 23:41:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7264E610C7
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 23:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7264E610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=gVBnW5b0rbZ2nJx5yvhkReN3UDCpdlJmD948lSJ9kqg=; b=VBbQLaebNTOM1IGdTr1ie6AkPk
	ygq8XoS8iSCzC3obpzrcuRYjPHdSPfHLr46QvzZ1FC4+4ygzIiBVfbDwWo+zcmJswnab+wLiqkZ1/
	YjwvVjShGxl/YtJcJ0f4Ex6M/ibOyTCTtjnhS10gUQe618bsJaKQWFpPMop3zOz6APlun7XnyPek4
	RrHKxZqQCV1LunDL0cNtM1oTeihN2Kj+uJdjErJyRH7wUCm4XQKY0t+etm7Kqd8DSr27QsOD1wp2J
	UjpGZFQyuheqDZy0kGARDUOagLJAABVTt2ibODPEDSoBiErHUuxyhTl0VAO5yYPAXbzMpsqUnBjhS
	9b6h08qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mR10d-00Cim4-0h; Thu, 16 Sep 2021 23:41:39 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mR10B-00CiPf-JV
 for linux-nvme@lists.infradead.org; Thu, 16 Sep 2021 23:41:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=8bOXOFnckmEc8LCJ9PH0f4LyphVDIcC24zx3B6oadvQ=; b=RFVdJzEG1LYX/cCVSoDTFqrqzO
 eWbPdYWb6JTWgxd1VH8508Ykwd0ArTzEQflE+Zf39KsZT9V44tJlNZw1MlNDh1hGjxjce55nxShDO
 X/F436UI2JS6/1dTCeIfETkJCAsaFHpRzZm6+NPQz/uAWz5V8vOZbLFY5Qiz6QpbF+jkldK5QYtF1
 gQOyJeepovW7eyPIRZWyBJDz7xMCCcf/+Do9AeM4IG5nlQyYeXPmFJ+XU8umkONBVEMIJdLUc1ZAz
 1GKlO8AgAHAE0o1zX1N4kppCztLqedObZwWaCeAcEEUSw7bDG8VKfc1vq1+4pA1jClAbKym8zA+Dv
 EySiIlGg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1mR107-0008I0-JT; Thu, 16 Sep 2021 17:41:08 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1mR103-000Vqp-JU; Thu, 16 Sep 2021 17:41:03 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
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
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 16 Sep 2021 17:40:41 -0600
Message-Id: <20210916234100.122368-2-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916234100.122368-1-logang@deltatee.com>
References: <20210916234100.122368-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v3 01/20] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210916_164111_724744_573CC8D5 
X-CRM114-Status: GOOD (  22.93  )
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

TWFrZSB1c2Ugb2YgdGhlIHRoaXJkIGZyZWUgTFNCIGluIHNjYXR0ZXJsaXN0J3MgcGFnZV9saW5r
IG9uIDY0Yml0IHN5c3RlbXMuCgpUaGUgZXh0cmEgYml0IHdpbGwgYmUgdXNlZCBieSBkbWFfW3Vu
XW1hcF9zZ19wMnBkbWEoKSB0byBkZXRlcm1pbmUgd2hlbiBhCmdpdmVuIFNHTCBzZWdtZW50cyBk
bWFfYWRkcmVzcyBwb2ludHMgdG8gYSBQQ0kgYnVzIGFkZHJlc3MuCmRtYV91bm1hcF9zZ19wMnBk
bWEoKSB3aWxsIG5lZWQgdG8gcGVyZm9ybSBkaWZmZXJlbnQgY2xlYW51cCB3aGVuIGEKc2VnbWVu
dCBpcyBtYXJrZWQgYXMgUDJQRE1BLgoKVXNpbmcgdGhpcyBiaXQgcmVxdWlyZXMgYWRkaW5nIGFu
IGFkZGl0aW9uYWwgZGVwZW5kZW5jeSBvbiBDT05GSUdfNjRCSVQgdG8KQ09ORklHX1BDSV9QMlBE
TUEuIFRoaXMgc2hvdWxkIGJlIGFjY2VwdGFibGUgYXMgdGhlIG1ham9yaXR5IG9mIFAyUERNQQp1
c2UgY2FzZXMgYXJlIHJlc3RyaWN0ZWQgdG8gbmV3ZXIgcm9vdCBjb21wbGV4ZXMgYW5kIHJvdWdo
bHkgcmVxdWlyZSB0aGUKZXh0cmEgYWRkcmVzcyBzcGFjZSBmb3IgbWVtb3J5IEJBUnMgdXNlZCBp
biB0aGUgdHJhbnNhY3Rpb25zLgoKU2lnbmVkLW9mZi1ieTogTG9nYW4gR3VudGhvcnBlIDxsb2dh
bmdAZGVsdGF0ZWUuY29tPgpSZXZpZXdlZC1ieTogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlk
aWEuY29tPgotLS0KIGRyaXZlcnMvcGNpL0tjb25maWcgICAgICAgICB8ICAyICstCiBpbmNsdWRl
L2xpbnV4L3NjYXR0ZXJsaXN0LmggfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvS2NvbmZpZyBiL2RyaXZlcnMvcGNpL0tjb25maWcK
aW5kZXggMGM0NzNkNzVlNjI1Li45MGI0YmRkYjMzMDAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNp
L0tjb25maWcKKysrIGIvZHJpdmVycy9wY2kvS2NvbmZpZwpAQCAtMTYzLDcgKzE2Myw3IEBAIGNv
bmZpZyBQQ0lfUEFTSUQKIAogY29uZmlnIFBDSV9QMlBETUEKIAlib29sICJQQ0kgcGVlci10by1w
ZWVyIHRyYW5zZmVyIHN1cHBvcnQiCi0JZGVwZW5kcyBvbiBaT05FX0RFVklDRQorCWRlcGVuZHMg
b24gWk9ORV9ERVZJQ0UgJiYgNjRCSVQKIAlzZWxlY3QgR0VORVJJQ19BTExPQ0FUT1IKIAloZWxw
CiAJICBFbmFibGXRlSBkcml2ZXJzIHRvIGRvIFBDSSBwZWVyLXRvLXBlZXIgdHJhbnNhY3Rpb25z
IHRvIGFuZCBmcm9tCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmggYi9p
bmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgKaW5kZXggMjY2NzU0YTU1MzI3Li5lNjJiMWNmNjM4
NmYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2NhdHRlcmxpc3QuaAorKysgYi9pbmNsdWRl
L2xpbnV4L3NjYXR0ZXJsaXN0LmgKQEAgLTY0LDYgKzY0LDIxIEBAIHN0cnVjdCBzZ19hcHBlbmRf
dGFibGUgewogI2RlZmluZSBTR19DSEFJTgkweDAxVUwKICNkZWZpbmUgU0dfRU5ECQkweDAyVUwK
IAorLyoKKyAqIGJpdCAyIGlzIHRoZSB0aGlyZCBmcmVlIGJpdCBpbiB0aGUgcGFnZV9saW5rIG9u
IDY0Yml0IHN5c3RlbXMgd2hpY2gKKyAqIGlzIHVzZWQgYnkgZG1hX3VubWFwX3NnKCkgdG8gZGV0
ZXJtaW5lIGlmIHRoZSBkbWFfYWRkcmVzcyBpcyBhIFBDSQorICogYnVzIGFkZHJlc3Mgd2hlbiBk
b2luZyBQMlBETUEuCisgKiBOb3RlOiBDT05GSUdfUENJX1AyUERNQSBkZXBlbmRzIG9uIENPTkZJ
R182NEJJVCBiZWNhdXNlIG9mIHRoaXMuCisgKi8KKworI2lmZGVmIENPTkZJR19QQ0lfUDJQRE1B
CisjZGVmaW5lIFNHX0RNQV9QQ0lfUDJQRE1BCTB4MDRVTAorI2Vsc2UKKyNkZWZpbmUgU0dfRE1B
X1BDSV9QMlBETUEJMHgwMFVMCisjZW5kaWYKKworI2RlZmluZSBTR19QQUdFX0xJTktfTUFTSyAo
U0dfQ0hBSU4gfCBTR19FTkQgfCBTR19ETUFfUENJX1AyUERNQSkKKwogLyoKICAqIFdlIG92ZXJs
b2FkIHRoZSBMU0Igb2YgdGhlIHBhZ2UgcG9pbnRlciB0byBpbmRpY2F0ZSB3aGV0aGVyIGl0J3MK
ICAqIGEgdmFsaWQgc2cgZW50cnksIG9yIHdoZXRoZXIgaXQgcG9pbnRzIHRvIHRoZSBzdGFydCBv
ZiBhIG5ldyBzY2F0dGVybGlzdC4KQEAgLTcyLDcgKzg3LDkgQEAgc3RydWN0IHNnX2FwcGVuZF90
YWJsZSB7CiAjZGVmaW5lIHNnX2lzX2NoYWluKHNnKQkJKChzZyktPnBhZ2VfbGluayAmIFNHX0NI
QUlOKQogI2RlZmluZSBzZ19pc19sYXN0KHNnKQkJKChzZyktPnBhZ2VfbGluayAmIFNHX0VORCkK
ICNkZWZpbmUgc2dfY2hhaW5fcHRyKHNnKQlcCi0JKChzdHJ1Y3Qgc2NhdHRlcmxpc3QgKikgKChz
ZyktPnBhZ2VfbGluayAmIH4oU0dfQ0hBSU4gfCBTR19FTkQpKSkKKwkoKHN0cnVjdCBzY2F0dGVy
bGlzdCAqKSgoc2cpLT5wYWdlX2xpbmsgJiB+U0dfUEFHRV9MSU5LX01BU0spKQorCisjZGVmaW5l
IHNnX2lzX2RtYV9wY2lfcDJwZG1hKHNnKSAoKHNnKS0+cGFnZV9saW5rICYgU0dfRE1BX1BDSV9Q
MlBETUEpCiAKIC8qKgogICogc2dfYXNzaWduX3BhZ2UgLSBBc3NpZ24gYSBnaXZlbiBwYWdlIHRv
IGFuIFNHIGVudHJ5CkBAIC04NiwxMyArMTAzLDEzIEBAIHN0cnVjdCBzZ19hcHBlbmRfdGFibGUg
ewogICoqLwogc3RhdGljIGlubGluZSB2b2lkIHNnX2Fzc2lnbl9wYWdlKHN0cnVjdCBzY2F0dGVy
bGlzdCAqc2csIHN0cnVjdCBwYWdlICpwYWdlKQogewotCXVuc2lnbmVkIGxvbmcgcGFnZV9saW5r
ID0gc2ctPnBhZ2VfbGluayAmIChTR19DSEFJTiB8IFNHX0VORCk7CisJdW5zaWduZWQgbG9uZyBw
YWdlX2xpbmsgPSBzZy0+cGFnZV9saW5rICYgU0dfUEFHRV9MSU5LX01BU0s7CiAKIAkvKgogCSAq
IEluIG9yZGVyIGZvciB0aGUgbG93IGJpdCBzdGVhbGluZyBhcHByb2FjaCB0byB3b3JrLCBwYWdl
cwogCSAqIG11c3QgYmUgYWxpZ25lZCBhdCBhIDMyLWJpdCBib3VuZGFyeSBhcyBhIG1pbmltdW0u
CiAJICovCi0JQlVHX09OKCh1bnNpZ25lZCBsb25nKSBwYWdlICYgKFNHX0NIQUlOIHwgU0dfRU5E
KSk7CisJQlVHX09OKCh1bnNpZ25lZCBsb25nKXBhZ2UgJiBTR19QQUdFX0xJTktfTUFTSyk7CiAj
aWZkZWYgQ09ORklHX0RFQlVHX1NHCiAJQlVHX09OKHNnX2lzX2NoYWluKHNnKSk7CiAjZW5kaWYK
QEAgLTEyNiw3ICsxNDMsNyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBwYWdlICpzZ19wYWdlKHN0
cnVjdCBzY2F0dGVybGlzdCAqc2cpCiAjaWZkZWYgQ09ORklHX0RFQlVHX1NHCiAJQlVHX09OKHNn
X2lzX2NoYWluKHNnKSk7CiAjZW5kaWYKLQlyZXR1cm4gKHN0cnVjdCBwYWdlICopKChzZyktPnBh
Z2VfbGluayAmIH4oU0dfQ0hBSU4gfCBTR19FTkQpKTsKKwlyZXR1cm4gKHN0cnVjdCBwYWdlICop
KChzZyktPnBhZ2VfbGluayAmIH5TR19QQUdFX0xJTktfTUFTSyk7CiB9CiAKIC8qKgpAQCAtMjI4
LDYgKzI0NSwzMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc2dfdW5tYXJrX2VuZChzdHJ1Y3Qgc2Nh
dHRlcmxpc3QgKnNnKQogCXNnLT5wYWdlX2xpbmsgJj0gflNHX0VORDsKIH0KIAorLyoqCisgKiBz
Z19kbWFfbWFya19wY2lfcDJwZG1hIC0gTWFyayB0aGUgc2NhdHRlcmxpc3QgZW50cnkgZm9yIFBD
SSBwMnBkbWEKKyAqIEBzZzoJCSBTRyBlbnRyeVNjYXR0ZXJsaXN0CisgKgorICogRGVzY3JpcHRp
b246CisgKiAgIE1hcmtzIHRoZSBwYXNzZWQgaW4gc2cgZW50cnkgdG8gaW5kaWNhdGUgdGhhdCB0
aGUgZG1hX2FkZHJlc3MgaXMKKyAqICAgYSBQQ0kgYnVzIGFkZHJlc3MuCisgKiovCitzdGF0aWMg
aW5saW5lIHZvaWQgc2dfZG1hX21hcmtfcGNpX3AycGRtYShzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNn
KQoreworCXNnLT5wYWdlX2xpbmsgfD0gU0dfRE1BX1BDSV9QMlBETUE7Cit9CisKKy8qKgorICog
c2dfdW5tYXJrX3BjaV9wMnBkbWEgLSBVbm1hcmsgdGhlIHNjYXR0ZXJsaXN0IGVudHJ5IGZvciBQ
Q0kgcDJwZG1hCisgKiBAc2c6CQkgU0cgZW50cnlTY2F0dGVybGlzdAorICoKKyAqIERlc2NyaXB0
aW9uOgorICogICBDbGVhcnMgdGhlIFBDSSBQMlBETUEgbWFyaworICoqLworc3RhdGljIGlubGlu
ZSB2b2lkIHNnX2RtYV91bm1hcmtfcGNpX3AycGRtYShzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnKQor
eworCXNnLT5wYWdlX2xpbmsgJj0gflNHX0RNQV9QQ0lfUDJQRE1BOworfQorCiAvKioKICAqIHNn
X3BoeXMgLSBSZXR1cm4gcGh5c2ljYWwgYWRkcmVzcyBvZiBhbiBzZyBlbnRyeQogICogQHNnOgkg
ICAgIFNHIGVudHJ5Ci0tIAoyLjMwLjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
