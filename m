Return-Path: <SRS0=CCYl=OH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB0DC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Sep 2021 00:04:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4486105A
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Sep 2021 00:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F4486105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Y2KTrBYiKF49AU0AGS53iszFt8G82lqb63OibUPvSnM=; b=OmJRerov+Gjdd9/i/sWn0lbMQF
	fIQfC7lG0jcCMfD/sMhGg8oNZmXUDM94BmkR9E/D3mSopEZnaTXgCqbqGnH9AVhdbdn/S6sPsm6aJ
	B3DkrwuDwLA5+vvWaYsLpm0oCuEDbYnseH1fQpGyiLaE3yYq/gEqZcoJeB8nCyQu5W3dBCz1dnrLa
	d+Vw5UzeZVxrDUGjbkkTxE5apwOxZSaKbwgYH5EAIajqPaiaMoq8UOpSnOzp1VlUBlgWUepvW2N40
	LN92j+FRp6wer10/5LfBrXzHWyCD83DXgwqZeiLnqCn+EGmMEN6w3pbY/OBn4Sr2aUm3SsHIumPpa
	jRtex6PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mR1M8-00Cn3W-1b; Fri, 17 Sep 2021 00:03:52 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mR10O-00CiZo-El
 for linux-nvme@lists.infradead.org; Thu, 16 Sep 2021 23:41:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=ldkK6FksW6AxBSIsN/n+YIWPajMSW0GYq8IzRYvtFoM=; b=OMj+IXhA0JlmDcMTNtuw+2naNo
 h+aSEBqNXGALEhnyVoJJQ02Zj7o7Zc9QOB+HlQGmZ1MdLz/kYLSgLKXn3vNz4ZouyEjt5er7gupt5
 z33xIhm/pO6gFpEIcnqKlAvm9oUXO347Qddi9w6t//UZb/L7JZH7xFHh33H6AhrWylBygyn17hAvR
 /H1rKFjBtB7mFHaD4INKJGVdTq9Lo+eQ+MB6SpwSuitUO/WBujObJ655/GoumkDOgj9twvXY2vM0F
 47f1/CRT1Dc+KenE0m9BVndGCJMkc2kcmbKYHLNSMJpiFZ895GlsBV2IabtQxZ81oTtdlhF9V5ps0
 h1jpMxjA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1mR10A-0008Hz-91; Thu, 16 Sep 2021 17:41:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1mR106-000Vrq-CV; Thu, 16 Sep 2021 17:41:06 -0600
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
Date: Thu, 16 Sep 2021 17:40:58 -0600
Message-Id: <20210916234100.122368-19-logang@deltatee.com>
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
Subject: [PATCH v3 18/20] mm: use custom page_free for P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210916_164124_604331_8DA2B889 
X-CRM114-Status: GOOD (  17.90  )
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

V2hlbiBQMlBETUEgcGFnZXMgYXJlIHBhc3NlZCB0byB1c2Vyc3BhY2UsIHRoZXkgd2lsbCBuZWVk
IHRvIGJlCnJlZmVyZW5jZSBjb3VudGVkIHByb3Blcmx5IGFuZCByZXR1cm5lZCB0byB0aGVpciBn
ZW5hbGxvYyBhZnRlciB0aGVpcgpyZWZlcmVuY2UgY291bnQgcmV0dXJucyB0byAxLiBUaGlzIGlz
IGFjY29tcGxpc2hlZCB3aXRoIHRoZSBleGlzdGluZwpERVZfUEFHRU1BUF9PUFMgYW5kIHRoZSAu
cGFnZV9mcmVlKCkgb3BlcmF0aW9uLgoKQ2hhbmdlIENPTkZJR19QMlBETUEgdG8gc2VsZWN0IENP
TkZJR19ERVZfUEFHRU1BUF9PUFMgYW5kIGFkZApNRU1PUllfREVWSUNFX1BDSV9QMlBETUEgdG8g
cGFnZV9pc19kZXZtYXBfbWFuYWdlZCgpLApkZXZtYXBfbWFuYWdlZF9lbmFibGVfW3B1dHxnZXRd
KCkgYW5kIGZyZWVfZGV2bWFwX21hbmFnZWRfcGFnZSgpLgoKU2lnbmVkLW9mZi1ieTogTG9nYW4g
R3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPgotLS0KIGRyaXZlcnMvcGNpL0tjb25maWcg
IHwgIDEgKwogZHJpdmVycy9wY2kvcDJwZG1hLmMgfCAxMyArKysrKysrKysrKysrCiBpbmNsdWRl
L2xpbnV4L21tLmggICB8ICAxICsKIG1tL21lbXJlbWFwLmMgICAgICAgIHwgMTIgKysrKysrKysr
LS0tCiA0IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvS2NvbmZpZyBiL2RyaXZlcnMvcGNpL0tjb25maWcKaW5k
ZXggOTBiNGJkZGIzMzAwLi5iMzFkMzUyNTlkM2EgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL0tj
b25maWcKKysrIGIvZHJpdmVycy9wY2kvS2NvbmZpZwpAQCAtMTY1LDYgKzE2NSw3IEBAIGNvbmZp
ZyBQQ0lfUDJQRE1BCiAJYm9vbCAiUENJIHBlZXItdG8tcGVlciB0cmFuc2ZlciBzdXBwb3J0Igog
CWRlcGVuZHMgb24gWk9ORV9ERVZJQ0UgJiYgNjRCSVQKIAlzZWxlY3QgR0VORVJJQ19BTExPQ0FU
T1IKKwlzZWxlY3QgREVWX1BBR0VNQVBfT1BTCiAJaGVscAogCSAgRW5hYmxl0ZUgZHJpdmVycyB0
byBkbyBQQ0kgcGVlci10by1wZWVyIHRyYW5zYWN0aW9ucyB0byBhbmQgZnJvbQogCSAgQkFScyB0
aGF0IGFyZSBleHBvc2VkIGluIG90aGVyIGRldmljZXMgdGhhdCBhcmUgdGhlIHBhcnQgb2YKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3AycGRtYS5jIGIvZHJpdmVycy9wY2kvcDJwZG1hLmMKaW5k
ZXggNDQ3ODYzMzM0NmJkLi4yNDIyYWY1YTUyOWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL3Ay
cGRtYS5jCisrKyBiL2RyaXZlcnMvcGNpL3AycGRtYS5jCkBAIC0xMDAsNiArMTAwLDE4IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIHAycG1lbV9ncm91cCA9IHsKIAkubmFt
ZSA9ICJwMnBtZW0iLAogfTsKIAorc3RhdGljIHZvaWQgcDJwZG1hX3BhZ2VfZnJlZShzdHJ1Y3Qg
cGFnZSAqcGFnZSkKK3sKKwlzdHJ1Y3QgcGNpX3AycGRtYV9wYWdlbWFwICpwZ21hcCA9IHRvX3Ay
cF9wZ21hcChwYWdlLT5wZ21hcCk7CisKKwlnZW5fcG9vbF9mcmVlKHBnbWFwLT5wcm92aWRlci0+
cDJwZG1hLT5wb29sLAorCQkgICAgICAodWludHB0cl90KXBhZ2VfdG9fdmlydChwYWdlKSwgUEFH
RV9TSVpFKTsKK30KKworc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcGFnZW1hcF9vcHMgcDJwZG1h
X3BnbWFwX29wcyA9IHsKKwkucGFnZV9mcmVlID0gcDJwZG1hX3BhZ2VfZnJlZSwKK307CisKIHN0
YXRpYyB2b2lkIHBjaV9wMnBkbWFfcmVsZWFzZSh2b2lkICpkYXRhKQogewogCXN0cnVjdCBwY2lf
ZGV2ICpwZGV2ID0gZGF0YTsKQEAgLTE5Nyw2ICsyMDksNyBAQCBpbnQgcGNpX3AycGRtYV9hZGRf
cmVzb3VyY2Uoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGludCBiYXIsIHNpemVfdCBzaXplLAogCXBn
bWFwLT5yYW5nZS5lbmQgPSBwZ21hcC0+cmFuZ2Uuc3RhcnQgKyBzaXplIC0gMTsKIAlwZ21hcC0+
bnJfcmFuZ2UgPSAxOwogCXBnbWFwLT50eXBlID0gTUVNT1JZX0RFVklDRV9QQ0lfUDJQRE1BOwor
CXBnbWFwLT5vcHMgPSAmcDJwZG1hX3BnbWFwX29wczsKIAogCXAycF9wZ21hcC0+cHJvdmlkZXIg
PSBwZGV2OwogCXAycF9wZ21hcC0+YnVzX29mZnNldCA9IHBjaV9idXNfYWRkcmVzcyhwZGV2LCBi
YXIpIC0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUvbGludXgvbW0u
aAppbmRleCA2YWZkYzA5ZDA3MTIuLjlhNmVhMDBlNTI5MiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9s
aW51eC9tbS5oCisrKyBiL2luY2x1ZGUvbGludXgvbW0uaApAQCAtMTE2Myw2ICsxMTYzLDcgQEAg
c3RhdGljIGlubGluZSBib29sIHBhZ2VfaXNfZGV2bWFwX21hbmFnZWQoc3RydWN0IHBhZ2UgKnBh
Z2UpCiAJc3dpdGNoIChwYWdlLT5wZ21hcC0+dHlwZSkgewogCWNhc2UgTUVNT1JZX0RFVklDRV9Q
UklWQVRFOgogCWNhc2UgTUVNT1JZX0RFVklDRV9GU19EQVg6CisJY2FzZSBNRU1PUllfREVWSUNF
X1BDSV9QMlBETUE6CiAJCXJldHVybiB0cnVlOwogCWRlZmF1bHQ6CiAJCWJyZWFrOwpkaWZmIC0t
Z2l0IGEvbW0vbWVtcmVtYXAuYyBiL21tL21lbXJlbWFwLmMKaW5kZXggY2VlYmRiOGE3MmJiLi5m
YmRjOTk5MWFmMGUgMTAwNjQ0Ci0tLSBhL21tL21lbXJlbWFwLmMKKysrIGIvbW0vbWVtcmVtYXAu
YwpAQCAtNDQsMTQgKzQ0LDE2IEBAIEVYUE9SVF9TWU1CT0woZGV2bWFwX21hbmFnZWRfa2V5KTsK
IHN0YXRpYyB2b2lkIGRldm1hcF9tYW5hZ2VkX2VuYWJsZV9wdXQoc3RydWN0IGRldl9wYWdlbWFw
ICpwZ21hcCkKIHsKIAlpZiAocGdtYXAtPnR5cGUgPT0gTUVNT1JZX0RFVklDRV9QUklWQVRFIHx8
Ci0JICAgIHBnbWFwLT50eXBlID09IE1FTU9SWV9ERVZJQ0VfRlNfREFYKQorCSAgICBwZ21hcC0+
dHlwZSA9PSBNRU1PUllfREVWSUNFX0ZTX0RBWCB8fAorCSAgICBwZ21hcC0+dHlwZSA9PSBNRU1P
UllfREVWSUNFX1BDSV9QMlBETUEpCiAJCXN0YXRpY19icmFuY2hfZGVjKCZkZXZtYXBfbWFuYWdl
ZF9rZXkpOwogfQogCiBzdGF0aWMgdm9pZCBkZXZtYXBfbWFuYWdlZF9lbmFibGVfZ2V0KHN0cnVj
dCBkZXZfcGFnZW1hcCAqcGdtYXApCiB7CiAJaWYgKHBnbWFwLT50eXBlID09IE1FTU9SWV9ERVZJ
Q0VfUFJJVkFURSB8fAotCSAgICBwZ21hcC0+dHlwZSA9PSBNRU1PUllfREVWSUNFX0ZTX0RBWCkK
KwkgICAgcGdtYXAtPnR5cGUgPT0gTUVNT1JZX0RFVklDRV9GU19EQVggfHwKKwkgICAgcGdtYXAt
PnR5cGUgPT0gTUVNT1JZX0RFVklDRV9QQ0lfUDJQRE1BKQogCQlzdGF0aWNfYnJhbmNoX2luYygm
ZGV2bWFwX21hbmFnZWRfa2V5KTsKIH0KICNlbHNlCkBAIC0zNTUsNiArMzU3LDEwIEBAIHZvaWQg
Km1lbXJlbWFwX3BhZ2VzKHN0cnVjdCBkZXZfcGFnZW1hcCAqcGdtYXAsIGludCBuaWQpCiAJY2Fz
ZSBNRU1PUllfREVWSUNFX0dFTkVSSUM6CiAJCWJyZWFrOwogCWNhc2UgTUVNT1JZX0RFVklDRV9Q
Q0lfUDJQRE1BOgorCQlpZiAoIXBnbWFwLT5vcHMtPnBhZ2VfZnJlZSkgeworCQkJV0FSTigxLCAi
TWlzc2luZyBwYWdlX2ZyZWUgbWV0aG9kXG4iKTsKKwkJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwp
OworCQl9CiAJCXBhcmFtcy5wZ3Byb3QgPSBwZ3Byb3Rfbm9uY2FjaGVkKHBhcmFtcy5wZ3Byb3Qp
OwogCQlicmVhazsKIAlkZWZhdWx0OgpAQCAtNTA0LDcgKzUxMCw3IEBAIEVYUE9SVF9TWU1CT0xf
R1BMKGdldF9kZXZfcGFnZW1hcCk7CiB2b2lkIGZyZWVfZGV2bWFwX21hbmFnZWRfcGFnZShzdHJ1
Y3QgcGFnZSAqcGFnZSkKIHsKIAkvKiBub3RpZnkgcGFnZSBpZGxlIGZvciBkYXggKi8KLQlpZiAo
IWlzX2RldmljZV9wcml2YXRlX3BhZ2UocGFnZSkpIHsKKwlpZiAoIWlzX2RldmljZV9wcml2YXRl
X3BhZ2UocGFnZSkgJiYgIWlzX3BjaV9wMnBkbWFfcGFnZShwYWdlKSkgewogCQl3YWtlX3VwX3Zh
cigmcGFnZS0+X3JlZmNvdW50KTsKIAkJcmV0dXJuOwogCX0KLS0gCjIuMzAuMgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
