Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D40BC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:10:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E344B2087E
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E344B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Rza/g1xxxllQlmfkiAwcC+0hScZ4+mG8ZoQPH00XRww=; b=GmrpLjaonuF/4FCjXXWsO85xX
	XfoEcCsmFZZb2BYovuvlgb397zxlRwdIwxZoKuUr5ollVvrzB578j0Nj9o6ddWt5ZrysUexGxTRrd
	YI4MeS3V+3qJsl1xa+mTgzAYK5ogqYnI5+Yv6Qva9iTP+a26mL3jJUOQ97TXitT+L3S2dTF2ynMLu
	pkUafMevcvvZjZnKt1Bn7XAGKtWgJucUNJDVlWgp4Ew52AcRl4N1qOA3ZLrDMo4YPK6xqkYLQ4AzO
	PIcv8lfF/d6+UoX4U5AMmSPvVj1xb8EO4u/UGX4noURylxdLNY7bWLBAOEodkoE61SXQjLq5lk0Ls
	T1bX8nMtg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwI8V-00032O-Uz; Mon, 04 Jan 2021 05:10:31 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwI8R-00030l-Fv
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 05:10:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1609737027; x=1641273027;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1y14BfiDYeW2GPW7aJ8piMTbIb+XExWNPhFvc+apnpU=;
 b=o1Vfn02cmNgwilMyiMQbMN6btUXbH5K6EPJQASJu3ObZ76sb9qQ0UhzE
 CZuIx/2eLRfCc6kkRyWzGfFilH3Xo35tlu4gSpKw8LfcCDBWFu72smEFP
 V1dwMOGfckxjXBDetpDLFr7J4g5LYOTt3TjUc1CRnTgJID0aah5OxccUl
 60nMuxVy6UtO3EOy1olE1uUIq76/OlWPdkVoZ9Y/U7GbLuqYzZqTQoJP6
 VVewn5b5OGTifjdZk/VH2xpPEM7pC41UnTqaAbnPhhnq8BibS5MYQMlzo
 yXKpzVMW6uS4aOyhZnFdZYgGNB8St8Ojcx5bFzAKmf31J5QA3/oq7YPLC Q==;
IronPort-SDR: szWv+cV2j0wmGHR4nTvQ3wR8rUOJma3bHdtu/NI/tqtt65Tvv5sS44n9/mJg7HfVqfvUNKANw2
 WtYQC6I0N8su70BYLOywJ/eTxNZITHjfwXMrQnc/OVSSDi71xO/p3NXy2iE+UhWtMNYF0naEIJ
 C5oQ2e3ehUnqK2YpfR8j98qcIoiVI2knR5I6B8auoAuuZIEliigqzzq01WCpLJtGMVD9q+lBfF
 i6/r+IgDEmHL/A61XTmHa5tqc19F+J2UWu68hnB2xwGVlrhV9H5BQ3Vn5ntnoYMA8zSGPXQ5p/
 3DE=
X-IronPort-AV: E=Sophos;i="5.78,473,1599494400"; d="scan'208";a="156435517"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 13:10:26 +0800
IronPort-SDR: VRXdzc6QxD3sUupcUPsITmS+fCXwykbKas+TGzSqRbZtmQovvsPyIb1xj5UPxeJavxwvsD5swG
 7WQR/5hFdfXKuRF06NZ1I3Szz2HTRVC9nlENued6v6qJ/pqlbJOVjmSrSlF8uwzHuYnAb2UQAQ
 C2TCyfF1sai4v6ITXUCJFzp2jDU7yF347SMLl/iYEzWuVhSXxo2BiQaqAEl5QzQqGyLp7VIk2b
 LYubMbwFW7ruKSDgTMsNcyelnVURMyWwkYcLDMg8TE+Gc3or0MOZmM+1gH0Tz7vOTAj3OAOxMX
 RUjM2pQtLQGdDamdo/CCtJLy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2021 20:55:21 -0800
IronPort-SDR: hT0rgF/BJr/2speCIYspfSILnUrLaG4YOkZDETUf4tcuwLfwAlfOFUoj92Y/X6iGMhZ2RJBUmp
 OouUyLMkibVzu/0gbz2k1fyi+EGK6nV78tklosOmgjq89NY08qT6vGHy0lPifh/w4SHxkx8RBZ
 b1i8tsYxI8vlo4j0hbz2juVijLBku0NSumEUJSQmwj3VPRt0HkJRKkvleD/tyQZiyDTVNhL7WX
 arIlogtJLfEcVeucn9KS/GynQmZ8SGyUEzV521lbrMFAsLmR8D+6/er4R57Gs/EEigmFQfWiDm
 Tic=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2021 21:10:27 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V8 5/9] nvmet: add bio get helper for different backends
Date: Sun,  3 Jan 2021 21:09:34 -0800
Message-Id: <20210104050938.25745-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
References: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_001027_817482_B4C48E20 
X-CRM114-Status: GOOD (  17.27  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

V2l0aCB0aGUgYWRkaXRpb24gb2YgdGhlIHpucyBiYWNrZW5kIG5vdyB3ZSBoYXZlIHRocmVlIGRp
ZmZlcmVudApiYWNrZW5kcyB3aXRoIGlubGluZSBiaW8gb3B0aW1pemF0aW9uLiBUaGF0IGxlYWRz
IHRvIGhhdmluZyBkdXBsaWNhdGUKY29kZSBmb3IgYWxsb2NhdGluZyBvciBpbml0aWFsaXppbmcg
dGhlIGJpbyBpbiBhbGwgdGhyZWUgYmFja2VuZHM6CmdlbmVyaWMgYmRldiwgcGFzc3N0aHJ1LCBh
bmQgZ2VuZXJpYyB6bnMuCgpBZGQgYSBoZWxwZXIgZnVuY3Rpb24gdG8gcmVkdWNlIHRoZSBkdXBs
aWNhdGUgY29kZSBzdWNoIHRoYXQgaGVscGVyCmZ1bmN0aW9uIGFjY2VwdHMgdGhlIGJpX2VuZF9p
byBjYWxsYmFjayB3aGljaCBnZXRzIGluaXRpYWxpemUgZm9yIHRoZQpub24taW5saW5lIGJpb19h
bGxvYygpIGNhc2UuIFRoaXMgaXMgZHVlIHRvIHRoZSBzcGVjaWFsIGNhc2UgbmVlZGVkIGZvcgp0
aGUgcGFzc3RocnUgYmFja2VuZCBub24taW5saW5lIGJpbyBhbGxvY2F0aW9uIGJpb19hbGxvYygp
IHdoZXJlIHdlIHNldAp0aGUgYmlvLT5iaV9lbmRfaW8gPSBiaW9fcHV0LCBoYXZpbmcgdGhpcyBw
YXJhbWV0ZXIgYXZvaWRzIHRoZSBleHRyYQpicmFuY2ggaW4gdGhlIHBhc3N0aHJ1IGZhc3QgcGF0
aC4gRm9yIHJlc3Qgb2YgdGhlIGJhY2tlbmRzLCB3ZSBzZXQgdGhlCnNhbWUgYmlfZW5kX2lvIGNh
bGxiYWNrIGZvciBpbmxpbmUgYW5kIG5vbi1pbmxpbmUgY2FzZXMsIHRoYXQgaXMgZm9yCmdlbmVy
aWMgYmRldiB3ZSBzZXQgdG8gbnZtZXRfYmlvX2RvbmUoKSBhbmQgZm9yIGdlbmVyaWMgem5zIHdl
IHNldCB0bwpOVUxMLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoAoK
U2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEua3Vsa2FybmlAd2Rj
LmNvbT4KLS0tCiBkcml2ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMgfCAgNyArLS0tLS0t
CiBkcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmggICAgICAgfCAxNiArKysrKysrKysrKysrKysr
CiBkcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMgICAgfCAgOCArLS0tLS0tLQogZHJpdmVy
cy9udm1lL3RhcmdldC96bnMuYyAgICAgICAgIHwgIDggKy0tLS0tLS0KIDQgZmlsZXMgY2hhbmdl
ZCwgMTkgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9udm1lL3RhcmdldC9pby1jbWQtYmRldi5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQt
YmRldi5jCmluZGV4IDYxNzhlZjY0Mzk2Mi4uNzI3NDZlMjljYjBkIDEwMDY0NAotLS0gYS9kcml2
ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMKKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9p
by1jbWQtYmRldi5jCkBAIC0yNjYsMTIgKzI2Niw3IEBAIHN0YXRpYyB2b2lkIG52bWV0X2JkZXZf
ZXhlY3V0ZV9ydyhzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpCiAKIAlzZWN0b3IgPSBudm1ldF9sYmFf
dG9fc2VjdChyZXEtPm5zLCByZXEtPmNtZC0+cncuc2xiYSk7CiAKLQlpZiAocmVxLT50cmFuc2Zl
cl9sZW4gPD0gTlZNRVRfTUFYX0lOTElORV9EQVRBX0xFTikgewotCQliaW8gPSAmcmVxLT5iLmlu
bGluZV9iaW87Ci0JCWJpb19pbml0KGJpbywgcmVxLT5pbmxpbmVfYnZlYywgQVJSQVlfU0laRShy
ZXEtPmlubGluZV9idmVjKSk7Ci0JfSBlbHNlIHsKLQkJYmlvID0gYmlvX2FsbG9jKEdGUF9LRVJO
RUwsIG1pbihzZ19jbnQsIEJJT19NQVhfUEFHRVMpKTsKLQl9CisJYmlvID0gbnZtZXRfcmVxX2Jp
b19nZXQocmVxLCBOVUxMKTsKIAliaW9fc2V0X2RldihiaW8sIHJlcS0+bnMtPmJkZXYpOwogCWJp
by0+YmlfaXRlci5iaV9zZWN0b3IgPSBzZWN0b3I7CiAJYmlvLT5iaV9wcml2YXRlID0gcmVxOwpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5oIGIvZHJpdmVycy9udm1lL3Rh
cmdldC9udm1ldC5oCmluZGV4IDczNjE2NjU1ODVhMi4uM2ZjODRmNzljY2UxIDEwMDY0NAotLS0g
YS9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgKKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9u
dm1ldC5oCkBAIC02NTIsNCArNjUyLDIwIEBAIG52bWV0X2JkZXZfZXhlY3V0ZV96b25lX2FwcGVu
ZChzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpCiB9CiAjZW5kaWYgLyogQ09ORklHX0JMS19ERVZfWk9O
RUQgKi8KIAorc3RhdGljIGlubGluZSBzdHJ1Y3QgYmlvICpudm1ldF9yZXFfYmlvX2dldChzdHJ1
Y3QgbnZtZXRfcmVxICpyZXEsCisJCQkJCSAgICBiaW9fZW5kX2lvX3QgKmJpX2VuZF9pbykKK3sK
KwlzdHJ1Y3QgYmlvICpiaW87CisKKwlpZiAocmVxLT50cmFuc2Zlcl9sZW4gPD0gTlZNRVRfTUFY
X0lOTElORV9EQVRBX0xFTikgeworCQliaW8gPSAmcmVxLT5iLmlubGluZV9iaW87CisJCWJpb19p
bml0KGJpbywgcmVxLT5pbmxpbmVfYnZlYywgQVJSQVlfU0laRShyZXEtPmlubGluZV9idmVjKSk7
CisJCXJldHVybiBiaW87CisJfQorCisJYmlvID0gYmlvX2FsbG9jKEdGUF9LRVJORUwsIHJlcS0+
c2dfY250KTsKKwliaW8tPmJpX2VuZF9pbyA9IGJpX2VuZF9pbzsKKwlyZXR1cm4gYmlvOworfQor
CiAjZW5kaWYgLyogX05WTUVUX0ggKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQv
cGFzc3RocnUuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvcGFzc3RocnUuYwppbmRleCBiOTc3NmZj
OGYwOGYuLjU0Zjc2NWI1NjZlZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9wYXNz
dGhydS5jCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvcGFzc3RocnUuYwpAQCAtMTk0LDEzICsx
OTQsNyBAQCBzdGF0aWMgaW50IG52bWV0X3Bhc3N0aHJ1X21hcF9zZyhzdHJ1Y3QgbnZtZXRfcmVx
ICpyZXEsIHN0cnVjdCByZXF1ZXN0ICpycSkKIAlpZiAocmVxLT5zZ19jbnQgPiBCSU9fTUFYX1BB
R0VTKQogCQlyZXR1cm4gLUVJTlZBTDsKIAotCWlmIChyZXEtPnRyYW5zZmVyX2xlbiA8PSBOVk1F
VF9NQVhfSU5MSU5FX0RBVEFfTEVOKSB7Ci0JCWJpbyA9ICZyZXEtPnAuaW5saW5lX2JpbzsKLQkJ
YmlvX2luaXQoYmlvLCByZXEtPmlubGluZV9idmVjLCBBUlJBWV9TSVpFKHJlcS0+aW5saW5lX2J2
ZWMpKTsKLQl9IGVsc2UgewotCQliaW8gPSBiaW9fYWxsb2MoR0ZQX0tFUk5FTCwgbWluKHJlcS0+
c2dfY250LCBCSU9fTUFYX1BBR0VTKSk7Ci0JCWJpby0+YmlfZW5kX2lvID0gYmlvX3B1dDsKLQl9
CisJYmlvID0gbnZtZXRfcmVxX2Jpb19nZXQocmVxLCBiaW9fcHV0KTsKIAliaW8tPmJpX29wZiA9
IHJlcV9vcChycSk7CiAKIAlmb3JfZWFjaF9zZyhyZXEtPnNnLCBzZywgcmVxLT5zZ19jbnQsIGkp
IHsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvem5zLmMgYi9kcml2ZXJzL252bWUv
dGFyZ2V0L3pucy5jCmluZGV4IDJhNzFmNTZlNTY4ZC4uYzMyZTkzYTNjN2UxIDEwMDY0NAotLS0g
YS9kcml2ZXJzL252bWUvdGFyZ2V0L3pucy5jCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvem5z
LmMKQEAgLTI5NiwxMyArMjk2LDcgQEAgdm9pZCBudm1ldF9iZGV2X2V4ZWN1dGVfem9uZV9hcHBl
bmQoc3RydWN0IG52bWV0X3JlcSAqcmVxKQogCQlyZXR1cm47CiAJfQogCi0JaWYgKHJlcS0+dHJh
bnNmZXJfbGVuIDw9IE5WTUVUX01BWF9JTkxJTkVfREFUQV9MRU4pIHsKLQkJYmlvID0gJnJlcS0+
Yi5pbmxpbmVfYmlvOwotCQliaW9faW5pdChiaW8sIHJlcS0+aW5saW5lX2J2ZWMsIEFSUkFZX1NJ
WkUocmVxLT5pbmxpbmVfYnZlYykpOwotCX0gZWxzZSB7Ci0JCWJpbyA9IGJpb19hbGxvYyhHRlBf
S0VSTkVMLCByZXEtPnNnX2NudCk7Ci0JfQotCisJYmlvID0gbnZtZXRfcmVxX2Jpb19nZXQocmVx
LCBOVUxMKTsKIAliaW9fc2V0X2RldihiaW8sIHJlcS0+bnMtPmJkZXYpOwogCWJpby0+YmlfaXRl
ci5iaV9zZWN0b3IgPSBzZWN0OwogCWJpby0+Ymlfb3BmID0gUkVRX09QX1pPTkVfQVBQRU5EIHwg
UkVRX1NZTkMgfCBSRVFfSURMRTsKLS0gCjIuMjIuMQoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
