Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CC0C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:07:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A51207D8
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fyFf/NUX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DxbfHQUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A51207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nUkEKv4scVdPIBOiSdTmYE3P3MgrqPHm9Z1poh5kyrs=; b=fyFf/NUX5ogI4T
	tk2FxKBcXWZ7KCENoojprm4YQlaH9V4VMjALJsu6bCWeItKiV2PzZWWYOXy7mwVWZOqWFG/59ors9
	pi4CG2Et74Q+pItRaiDOUVuj56QCEMAbB6kyY5QmxFEX8MyCj5XoZ7/5R5e6LerpJg6IyVgrzxN2Y
	9tfq1cdcqRN0JNJOxaKsXZvUHlfMZXRfNSRWqwB7sJI5Tw3auNFu9k20MGoeRGokjLeWYsBfpXTua
	hXiajAZoJXUCeDnZMgZCLtL/kQoJG1aSuViQA/H09q4ocdliYNO8cO1UVnpfGWUpco23isDOVPssz
	Oa+uNaCoGLH2F7KQkPow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jaxHO-0006lz-JB; Tue, 19 May 2020 08:07:14 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jaxGw-0006AD-5a
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 08:06:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589875607; x=1621411607;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vLZAlWmifka0she1U5PiBZv8T9foWnohViq3+Ac82Sg=;
 b=DxbfHQUxsRfbMhNMDcFB4/qU6hEYgX0RDTRQuqziTEOzksD1Ga5fVFwZ
 HBYBxR9yJOY9jaiwD1jPsY3GwcgDhQsmmLbNovAQbbUM0gblc8EwSSBxP
 /SEWVa6/+RXud4h9dpAoPmDROmuAs/Kf/8lOMrZHYtIWjfrU0317eEYjg
 GN1DRxR5/yjLkx6nQI4DGmpiuMIOj+xYhOWVHjDTAeqlm2n0PsquuCMw+
 HSYMjWHRKydCreNk1NSjyBi1bGYR0sjk5DFhREoJGLQ9Prib4PhWygcZG
 iYlFjWowT8WYK98LnIMckFT66GqaVwV+FIiPSUkGz9J5jUaBgydurtdYJ A==;
IronPort-SDR: 5BCPLu0XgCgrmFGSiarcO0caahqzEEoR2Mj0ZmJz13mP6LhhgIh15An7FX32ufGZusHkT6JKK6
 K6imWFjjTBzlC/RnigX03yWc1KK4JlPEw7OteY9sDwkrEkSiZ3qgqru7diwicbL9Qql3mL709S
 7UH8muJEEr0gSEw6fzZYXO2yXqLTD8kfzxQHVxXlqFdmvaGXBbXcJcEBwRVOY+puKa9mpinQL7
 /aEu9965qlDrhVV5t1pA57zsQWWcew7auvemU10lG9wq4yaY0tme7tsugQ84PicK16sQW7IMpb
 FmA=
X-IronPort-AV: E=Sophos;i="5.73,409,1583164800"; d="scan'208";a="240756812"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 May 2020 16:06:46 +0800
IronPort-SDR: 4fK7VnEcyw5HYtlozK1SQs1ZZUXO/b8Rs90e34wToIqeAj14fAu4mUYyZXVHr7Tl445kTwE2kD
 IvZcfW0Z/JEb0JSkEQOvFMoiKoeFHS7Mk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2020 00:56:50 -0700
IronPort-SDR: lWI5TPFHsCZ1fRGpNeH/+XyJ+8K0VhSq84x/tplKOZaTR2tq+SLESZA4tysTaF4SvY5pU+/aya
 j/p/1aw2Iohw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2020 01:06:45 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH V4 4/4] nvmet: add async event tracing support
Date: Tue, 19 May 2020 01:06:30 -0700
Message-Id: <20200519080630.3500-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200519080630.3500-1-chaitanya.kulkarni@wdc.com>
References: <20200519080630.3500-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_010646_349170_3FB6969B 
X-CRM114-Status: GOOD (  10.75  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhpcyBhZGRzIGEgbmV3IHRyYWNlcG9pbnQgZm9yIHRoZSB0YXJnZXQgdG8gdHJhY2UgYXN5bmMg
ZXZlbnQuIFRoaXMgaXMKaGVscGZ1bCBpbiBkZWJ1Z2dpbmcgYW5kIGNvbXBhcmluZyBob3N0IGFu
ZCB0YXJnZXQgc2lkZSBhc3luYyBldmVudHMKZXNwZWNpYWxseSB3aGVuIGhvc3QgaXMgY29ubmVj
dGVkIHRvIGRpZmZlcmVudCB0YXJnZXRzIG9uIGRpZmZlcmVudAptYWNoaW5lcyBhbmQgbm93IHRo
YXQgd2UgcmVseSBvbiB1c2Vyc3BhY2UgY29tcG9uZW50cyB0byBnZW5lcmF0ZSBBRU4uwqAKClNp
Z25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlhLmt1bGthcm5pQHdkYy5j
b20+ClJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KUmV2aWV3ZWQt
Ynk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Ci0tLQogZHJpdmVycy9udm1lL3Rh
cmdldC9jb3JlLmMgIHwgIDEgKwogZHJpdmVycy9udm1lL3RhcmdldC90cmFjZS5oIHwgMjggKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMgYi9kcml2ZXJzL252
bWUvdGFyZ2V0L2NvcmUuYwppbmRleCBmYTFmNzliM2ZkZTMuLmZiNzhiMTY1YzEyMyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMKKysrIGIvZHJpdmVycy9udm1lL3Rhcmdl
dC9jb3JlLmMKQEAgLTE1MSw2ICsxNTEsNyBAQCBzdGF0aWMgdm9pZCBudm1ldF9hc3luY19ldmVu
dHNfcHJvY2VzcyhzdHJ1Y3QgbnZtZXRfY3RybCAqY3RybCwgdTE2IHN0YXR1cykKIAkJa2ZyZWUo
YWVuKTsKIAogCQltdXRleF91bmxvY2soJmN0cmwtPmxvY2spOworCQl0cmFjZV9udm1ldF9hc3lu
Y19ldmVudChjdHJsLCByZXEtPmNxZS0+cmVzdWx0LnUzMik7CiAJCW52bWV0X3JlcV9jb21wbGV0
ZShyZXEsIHN0YXR1cyk7CiAJfQogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC90
cmFjZS5oIGIvZHJpdmVycy9udm1lL3RhcmdldC90cmFjZS5oCmluZGV4IGU2NDVjYWE4ODJkZC4u
MDQ1ODA0NmQ2NTAxIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L3RyYWNlLmgKKysr
IGIvZHJpdmVycy9udm1lL3RhcmdldC90cmFjZS5oCkBAIC0xMzAsNiArMTMwLDM0IEBAIFRSQUNF
X0VWRU5UKG52bWV0X3JlcV9jb21wbGV0ZSwKIAogKTsKIAorI2RlZmluZSBhZXJfbmFtZShhZXIp
IHsgYWVyLCAjYWVyIH0KKworVFJBQ0VfRVZFTlQobnZtZXRfYXN5bmNfZXZlbnQsCisJVFBfUFJP
VE8oc3RydWN0IG52bWV0X2N0cmwgKmN0cmwsIF9fbGUzMiByZXN1bHQpLAorCVRQX0FSR1MoY3Ry
bCwgcmVzdWx0KSwKKwlUUF9TVFJVQ1RfX2VudHJ5KAorCQlfX2ZpZWxkKGludCwgY3RybF9pZCkK
KwkJX19maWVsZCh1MzIsIHJlc3VsdCkKKwkpLAorCVRQX2Zhc3RfYXNzaWduKAorCQlfX2VudHJ5
LT5jdHJsX2lkID0gY3RybC0+Y250bGlkOworCQlfX2VudHJ5LT5yZXN1bHQgPSAobGUzMl90b19j
cHUocmVzdWx0KSAmIDB4ZmYwMCkgPj4gODsKKwkpLAorCVRQX3ByaW50aygibnZtZXQlZDogTlZN
RV9BRU49JSMwOHggWyVzXSIsCisJCV9fZW50cnktPmN0cmxfaWQsIF9fZW50cnktPnJlc3VsdCwK
KwkJX19wcmludF9zeW1ib2xpYyhfX2VudHJ5LT5yZXN1bHQsCisJCWFlcl9uYW1lKE5WTUVfQUVS
X05PVElDRV9OU19DSEFOR0VEKSwKKwkJYWVyX25hbWUoTlZNRV9BRVJfTk9USUNFX0FOQSksCisJ
CWFlcl9uYW1lKE5WTUVfQUVSX05PVElDRV9GV19BQ1RfU1RBUlRJTkcpLAorCQlhZXJfbmFtZShO
Vk1FX0FFUl9OT1RJQ0VfRElTQ19DSEFOR0VEKSwKKwkJYWVyX25hbWUoTlZNRV9BRVJfRVJST1Ip
LAorCQlhZXJfbmFtZShOVk1FX0FFUl9TTUFSVCksCisJCWFlcl9uYW1lKE5WTUVfQUVSX0NTUyks
CisJCWFlcl9uYW1lKE5WTUVfQUVSX1ZTKSkKKwkpCispOworI3VuZGVmIGFlcl9uYW1lCisKICNl
bmRpZiAvKiBfVFJBQ0VfTlZNRVRfSCAqLwogCiAjdW5kZWYgVFJBQ0VfSU5DTFVERV9QQVRICi0t
IAoyLjIyLjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
