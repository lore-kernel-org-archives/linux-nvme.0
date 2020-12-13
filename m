Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D919C4361B
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CF122D71
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CF122D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zlTN+TwZYkrqR5PLs3ZbsniUqrnx0H4H815cDBth/kc=; b=Z7WB42v4HJkaZx0AMyIaK2JIP
	LT8onNXIBF0RD1EpEY4vFiEywdO4BE3ciWil/+pLE6SgDJvbdDeMnXcfcovOqUYZKp5oVgbI0D+/v
	J9/rcDZ6uQ8yVwTpwTJojP7cy7g7iyDSsOFFgHN+WMpXZ6AMzsdPc337yWx1pqh0MYomP0q/qOHAy
	noey8vJnoVUQJ9OvEpC6MNXV3l1s63e+InLzyRUYQhqnElVhkgZv7u4GxtyyBcrdHqrr8ONYsF8hE
	UMzfOZjiSTwqTZM0UvCiO3Wvn0X9Z66g0nYOCeMGEnSIz8S3Xl6EOz4wW6PT9C9cgRLh/qDZjFHb0
	IhMOIuj6w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koKIE-0005sp-CC; Sun, 13 Dec 2020 05:51:38 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koKHk-0005mU-Ca
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 05:51:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607838668; x=1639374668;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fsUzpqMK2kJ7sFLk1LyyNvbRs9Aq1ZwOj7Q3hAK3fLU=;
 b=AioOS0ewMXIBL9bGk2zwMFebPGDgBACr8QxO/+K+WESIN8+PriHglIUf
 bWMtbhWBnsi1eF8ezUo04HQw1mSCLPLPHr7tUmBjui3kRb7RiY6ru9pbS
 fWzCkFgvoLSHARkSLCVr90UJK8+ceTRdq+XmWNI51LuvYcqIgdNjaqs3U
 iCbmlsaRXOOFvj1iaWJmRWRmILxpt97G9FJhUOr/JGhO7uy1aRbHL2+Bq
 rtwh0Lu7MnS1SSBZL9CFvomPSeX9QQ3AWiQwHGBjcn+fEBOGlIAvzRMB8
 H5lrDnAGXwu3mSe2Jumqn/UwLr0gYyt/t276mWNKH7+w5WULd5xe3DTUK A==;
IronPort-SDR: anV+8Eml2Qbwchj9PVc22b/tcEioljNpQSXL/dYVz0qipWfd8xItl7WsacLEdavppSr+1M+Ssp
 Z9jWP9/KAo5RE0PG8iKsRU8DDhR/nTAkBavKOtYfFLdTLKcquQB1rKnpS3DyRL+/Dn+jZzFGVU
 v2h4EC+Z8R/Y38PFL3zSq8p549FHPduTLF7YJv6aCuB72K1UoFjL3H8LUQ4/ttB02zzVvbhSYF
 dZubz8JIRtOgtklY+PjbPCpgzp39KpPfZxxALLr2H9zNPln2A35/42PUMcST3XqHrVoGOK1UBX
 Vms=
X-IronPort-AV: E=Sophos;i="5.78,415,1599494400"; d="scan'208";a="155013133"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2020 13:51:07 +0800
IronPort-SDR: QtKv95HguFvfDOQ+xUyY42DItw4pPx4waazs8gHgWIuPg3eRLq9HHl7foXmEqzIUWX3Nx+7n7b
 GeZmlwCLIkFVoPmp5u8VXp3RSNuOQii3tUmu6dzez1nKIbxKLvXvAj/qP7VrE24gg82XBScMfC
 ZfkleMbhhnJzZR//Z1t+zc4du3BPqdDidIEX+MjFrzrl5S2Nqg2PZGd6cu2ohO5QtmTK0QyqFu
 DWgQz2haE8qkHu7mUPIHgMmpFuFWStvf2uAr0hH8ZZKm6M4gSD8f4I8E6uYxvlJKWRPFkk9J50
 VaHoVLjHX9UZRK4x+LSRspSN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2020 21:34:56 -0800
IronPort-SDR: ujqV4VBBz1EWImNreZgSTJiWSprCOP+Edif9CfLHtcOSpf/lkC0VY4gpgsR+BklaywtFXinufH
 C7XaopUMiRHb95T44V1JKjEbJ5amRFj9oA/XfpYZ41sq/+eObPMAa9xBBF22Hi9u46/PC8DWBk
 V9wiVP58es5CW/cl4BXwd6reVk9a13JDotxoAzcqPjZZrT7J+GWNDSdTinCcoWIlNEG63nT6QF
 ry8H8TZnpEXM0a5uUA0Wxk6T/5NIWaKT4cBtMca7vOVGEE0U785sxdWY0FWRW92UTH9b5Bd6Lh
 u3o=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2020 21:51:07 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V6 5/6] nvmet: add bio get helper for different backends
Date: Sat, 12 Dec 2020 21:50:16 -0800
Message-Id: <20201213055017.7141-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
References: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_005111_596133_8B349044 
X-CRM114-Status: GOOD (  17.84  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

V2l0aCB0aGUgYWRkaXRpb24gb2YgdGhlIHpucyBiYWNrZW5kIG5vdyB3ZSBoYXZlIHRocmVlIGRp
ZmZlcmVudApiYWNrZW5kcyB3aXRoIGlubGluZSBiaW8gb3B0aW1pemF0aW9uLiBUaGF0IGxlYWRz
IHRvIGhhdmluZwpkdXBsaWNhdGUgY29kZSBpbiBmb3IgYWxsb2NhdGluZyBvciBpbml0aWFsaXpp
bmcgdGhlIGJpbyBpbiBhbGwKdGhyZWUgYmFja2VuZHM6IGdlbmVyaWMgYmRldiwgcGFzc3N0aHJ1
LCBhbmQgZ2VuZXJpYyB6bnMuCgpBZGQgYSBoZWxwZXIgZnVuY3Rpb24gdG8gcmVkdWNlIHRoZSBk
dXBsaWNhdGUgY29kZSBzdWNoIHRoYXQgaGVscGVyCmZ1bmN0aW9uIGFjY2VwdHMgdGhlIGJpX2Vu
ZF9pbyBjYWxsYmFjayB3aGljaCBnZXRzIGluaXRpYWxpemUgZm9yIHRoZQpub24taW5saW5lIGJp
b19hbGxvYygpIGNhc2UuIFRoaXMgaXMgZHVlIHRvIHRoZSBzcGVjaWFsIGNhc2UgbmVlZGVkIGZv
cgp0aGUgcGFzc3RocnUgYmFja2VuZCBub24taW5saW5lIGJpbyBhbGxvY2F0aW9uIGJpb19hbGxv
YygpIHdoZXJlIHdlIHNldAp0aGUgYmlvLT5iaV9lbmRfaW8gPSBiaW9fcHV0LCBoYXZpbmcgdGhp
cyBwYXJhbWV0ZXIgYXZvaWRzIHRoZSBleHRyYQpicmFuY2ggaW4gdGhlIHBhc3N0aHJ1IGZhc3Qg
cGF0aC4gRm9yIHJlc3Qgb2YgdGhlIGJhY2tlbmRzLCB3ZSBzZXQgdGhlCnNhbWUgYmlfZW5kX2lv
IGNhbGxiYWNrIGZvciBpbmxpbmUgYW5kIG5vbi1pbmxpbmUgY2FzZXMsIHRoYXQgaXMgZm9yCmdl
bmVyaWMgYmRldiB3ZSBzZXQgdG8gbnZtZXRfYmlvX2RvbmUoKSBhbmQgZm9yIGdlbmVyaWMgem5z
IHdlIHNldCB0bwpOVUxMLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oAoKU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEua3Vsa2FybmlA
d2RjLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMgfCAgNyArLS0t
LS0tCiBkcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmggICAgICAgfCAxNiArKysrKysrKysrKysr
KysrCiBkcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMgICAgfCAgOCArLS0tLS0tLQogZHJp
dmVycy9udm1lL3RhcmdldC96bnMuYyAgICAgICAgIHwgIDggKy0tLS0tLS0KIDQgZmlsZXMgY2hh
bmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL3RhcmdldC9pby1jbWQtYmRldi5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9pby1j
bWQtYmRldi5jCmluZGV4IDYxNzhlZjY0Mzk2Mi4uNzI3NDZlMjljYjBkIDEwMDY0NAotLS0gYS9k
cml2ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMKKysrIGIvZHJpdmVycy9udm1lL3Rhcmdl
dC9pby1jbWQtYmRldi5jCkBAIC0yNjYsMTIgKzI2Niw3IEBAIHN0YXRpYyB2b2lkIG52bWV0X2Jk
ZXZfZXhlY3V0ZV9ydyhzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpCiAKIAlzZWN0b3IgPSBudm1ldF9s
YmFfdG9fc2VjdChyZXEtPm5zLCByZXEtPmNtZC0+cncuc2xiYSk7CiAKLQlpZiAocmVxLT50cmFu
c2Zlcl9sZW4gPD0gTlZNRVRfTUFYX0lOTElORV9EQVRBX0xFTikgewotCQliaW8gPSAmcmVxLT5i
LmlubGluZV9iaW87Ci0JCWJpb19pbml0KGJpbywgcmVxLT5pbmxpbmVfYnZlYywgQVJSQVlfU0la
RShyZXEtPmlubGluZV9idmVjKSk7Ci0JfSBlbHNlIHsKLQkJYmlvID0gYmlvX2FsbG9jKEdGUF9L
RVJORUwsIG1pbihzZ19jbnQsIEJJT19NQVhfUEFHRVMpKTsKLQl9CisJYmlvID0gbnZtZXRfcmVx
X2Jpb19nZXQocmVxLCBOVUxMKTsKIAliaW9fc2V0X2RldihiaW8sIHJlcS0+bnMtPmJkZXYpOwog
CWJpby0+YmlfaXRlci5iaV9zZWN0b3IgPSBzZWN0b3I7CiAJYmlvLT5iaV9wcml2YXRlID0gcmVx
OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5oIGIvZHJpdmVycy9udm1l
L3RhcmdldC9udm1ldC5oCmluZGV4IDczNjE2NjU1ODVhMi4uM2ZjODRmNzljY2UxIDEwMDY0NAot
LS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgKKysrIGIvZHJpdmVycy9udm1lL3Rhcmdl
dC9udm1ldC5oCkBAIC02NTIsNCArNjUyLDIwIEBAIG52bWV0X2JkZXZfZXhlY3V0ZV96b25lX2Fw
cGVuZChzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpCiB9CiAjZW5kaWYgLyogQ09ORklHX0JMS19ERVZf
Wk9ORUQgKi8KIAorc3RhdGljIGlubGluZSBzdHJ1Y3QgYmlvICpudm1ldF9yZXFfYmlvX2dldChz
dHJ1Y3QgbnZtZXRfcmVxICpyZXEsCisJCQkJCSAgICBiaW9fZW5kX2lvX3QgKmJpX2VuZF9pbykK
K3sKKwlzdHJ1Y3QgYmlvICpiaW87CisKKwlpZiAocmVxLT50cmFuc2Zlcl9sZW4gPD0gTlZNRVRf
TUFYX0lOTElORV9EQVRBX0xFTikgeworCQliaW8gPSAmcmVxLT5iLmlubGluZV9iaW87CisJCWJp
b19pbml0KGJpbywgcmVxLT5pbmxpbmVfYnZlYywgQVJSQVlfU0laRShyZXEtPmlubGluZV9idmVj
KSk7CisJCXJldHVybiBiaW87CisJfQorCisJYmlvID0gYmlvX2FsbG9jKEdGUF9LRVJORUwsIHJl
cS0+c2dfY250KTsKKwliaW8tPmJpX2VuZF9pbyA9IGJpX2VuZF9pbzsKKwlyZXR1cm4gYmlvOwor
fQorCiAjZW5kaWYgLyogX05WTUVUX0ggKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJn
ZXQvcGFzc3RocnUuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvcGFzc3RocnUuYwppbmRleCBiOTc3
NmZjOGYwOGYuLjU0Zjc2NWI1NjZlZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9w
YXNzdGhydS5jCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvcGFzc3RocnUuYwpAQCAtMTk0LDEz
ICsxOTQsNyBAQCBzdGF0aWMgaW50IG52bWV0X3Bhc3N0aHJ1X21hcF9zZyhzdHJ1Y3QgbnZtZXRf
cmVxICpyZXEsIHN0cnVjdCByZXF1ZXN0ICpycSkKIAlpZiAocmVxLT5zZ19jbnQgPiBCSU9fTUFY
X1BBR0VTKQogCQlyZXR1cm4gLUVJTlZBTDsKIAotCWlmIChyZXEtPnRyYW5zZmVyX2xlbiA8PSBO
Vk1FVF9NQVhfSU5MSU5FX0RBVEFfTEVOKSB7Ci0JCWJpbyA9ICZyZXEtPnAuaW5saW5lX2JpbzsK
LQkJYmlvX2luaXQoYmlvLCByZXEtPmlubGluZV9idmVjLCBBUlJBWV9TSVpFKHJlcS0+aW5saW5l
X2J2ZWMpKTsKLQl9IGVsc2UgewotCQliaW8gPSBiaW9fYWxsb2MoR0ZQX0tFUk5FTCwgbWluKHJl
cS0+c2dfY250LCBCSU9fTUFYX1BBR0VTKSk7Ci0JCWJpby0+YmlfZW5kX2lvID0gYmlvX3B1dDsK
LQl9CisJYmlvID0gbnZtZXRfcmVxX2Jpb19nZXQocmVxLCBiaW9fcHV0KTsKIAliaW8tPmJpX29w
ZiA9IHJlcV9vcChycSk7CiAKIAlmb3JfZWFjaF9zZyhyZXEtPnNnLCBzZywgcmVxLT5zZ19jbnQs
IGkpIHsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvem5zLmMgYi9kcml2ZXJzL252
bWUvdGFyZ2V0L3pucy5jCmluZGV4IDNmOWE1YWM2YTZjNS4uMDU4ZGE0YTIwMTJiIDEwMDY0NAot
LS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L3pucy5jCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQv
em5zLmMKQEAgLTMwOSwxMyArMzA5LDcgQEAgdm9pZCBudm1ldF9iZGV2X2V4ZWN1dGVfem9uZV9h
cHBlbmQoc3RydWN0IG52bWV0X3JlcSAqcmVxKQogCQlyZXR1cm47CiAJfQogCi0JaWYgKHJlcS0+
dHJhbnNmZXJfbGVuIDw9IE5WTUVUX01BWF9JTkxJTkVfREFUQV9MRU4pIHsKLQkJYmlvID0gJnJl
cS0+Yi5pbmxpbmVfYmlvOwotCQliaW9faW5pdChiaW8sIHJlcS0+aW5saW5lX2J2ZWMsIEFSUkFZ
X1NJWkUocmVxLT5pbmxpbmVfYnZlYykpOwotCX0gZWxzZSB7Ci0JCWJpbyA9IGJpb19hbGxvYyhH
RlBfS0VSTkVMLCByZXEtPnNnX2NudCk7Ci0JfQotCisJYmlvID0gbnZtZXRfcmVxX2Jpb19nZXQo
cmVxLCBOVUxMKTsKIAliaW9fc2V0X2RldihiaW8sIHJlcS0+bnMtPmJkZXYpOwogCWJpby0+Ymlf
aXRlci5iaV9zZWN0b3IgPSBzZWN0OwogCWJpby0+Ymlfb3BmID0gUkVRX09QX1pPTkVfQVBQRU5E
IHwgUkVRX1NZTkMgfCBSRVFfSURMRTsKLS0gCjIuMjIuMQoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
