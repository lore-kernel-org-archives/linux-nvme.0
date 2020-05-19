Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7D9C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:06:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE21207FB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="turi4UFC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AMCsjDDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE21207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=m7dz4itg7eu2o0OjlgqRoQ32Z5+WZKYsmVAdYlxnrBs=; b=turi4UFCVwhw2B
	gLPUmilQAhQIAdUuVaQadxjcIcn40i3u/a1cLOVzgf27TBxHeuIQSsCCI+WikTMFKG0VGh/LqrftS
	AcCjINcZNq4skJVGPLqYVDRH/sD8w4lwSpAzLvb45AL36vwVOf4WNbZUA8Zp11ELhIs+ECqJLAC6X
	1J9h1zXS1mGvLvP1jvnNK2R77B7OGJtP2oInlm7NP4T8PbfbMtvQ880lGTGlcvUHrKNwj2jpQPHVY
	+BER3ZAhblhsO6C2DvbwiiYdNJNAhMGd/yxJd1lOSVroLX6C6zk2tdJQ9xvx5T0TDEhK2C+TGzg/U
	ehslYcXoBNxfFohwFqXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jaxGn-0006BF-Gl; Tue, 19 May 2020 08:06:37 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jaxGj-0006AD-4c
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 08:06:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589875614; x=1621411614;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=33owWryTjryQX8Fj+dG8wxmWwQ7wJPItr5IGnDzQmo4=;
 b=AMCsjDDlOThUjd8mV4IDwHRxDOJkJFC7iOBaGhPBsA12l5scyA0PT9Ff
 zlkiDC4VFhLVQOu11St9fkz+gLpGfHLmdkO9PwrUvMEV7cX/S6qwDuJs4
 9WNg7sJjq7XDrswzO93NXTgyYyf7P8rLpNTFESfixd8ghJtEWX6tnF4Xj
 BeLIZbrT/coPHkm2h7BDizjSTElM+ANzJOM87ax9wOMlWRo/Di3VbDm8Q
 q1ijcNSpb2nWeznM+l1nsVXZQgw9UFXkK/8X3eMIw+yjFPJi+jRl3Orvr
 U9krBr3ZrMgv/06zTyN4dEPhZ5nLfNTokIC7yR9xK8d4ipdI+2vYnenWO A==;
IronPort-SDR: OGnOJMSZP2gvBJSgRaYl232vB0XsuG4wySRJl4jtiGRN62GTbfYCYVIsH/GBmalf/2zBLqRg+B
 zCkZNr7FbwsfM2TI9rhnNZTmvNeLWlOPusqaQChcKPaVcH6EoVzd9HIyCoGoJScwG3K6+xOjFI
 HXBOQkhOO0QCHDYlRJJgctmVuFXpYYq+EDLCvMGoYv0k8TpNrUaRQJD5UKMd99Uo7YCeC6EiQG
 iYGKkfMkIjfaYprQBaCmVWTgIA6NEGA43/RMGiLY6H8XXxT1izQRgbs0V8imOASAGumF/gh6ek
 WAg=
X-IronPort-AV: E=Sophos;i="5.73,409,1583164800"; d="scan'208";a="240756796"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 May 2020 16:06:52 +0800
IronPort-SDR: 8wEjCuj6xs4JUFcmeaio9EUgAfBsdiSeNlpJ2wFP4PgGbZUIT+/xjLHRQ4iL9MUoRl1Qr/2ikZ
 0L/dNNCtMsOGpgTv6ei5qDVuPvaFVgeXc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2020 00:56:36 -0700
IronPort-SDR: JP1ZZU5OU2dmowNngefwUl+5oR6lEE95r4s8/u0zlAJ7t2ddeEUrbcOb2jNz/pDRyCtL1qAIXZ
 rMLLc+l5+25g==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2020 01:06:32 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH V4 0/3] nvmet: add target ns revalidate support
Date: Tue, 19 May 2020 01:06:26 -0700
Message-Id: <20200519080630.3500-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_010633_297907_321B0CB3 
X-CRM114-Status: GOOD (  11.09  )
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

SGkgQ2hyaXN0b3BoL1NhZ2ksCgpBcyBwZXIgcHJldmlvdXMgZGlzY3Vzc2lvbiBvbiB0aGUgbnMt
cmV2YWxpZGF0aW9uIHRocmVhZCwgdGhpcyBwYXRjaApzZXJpZXMgYWRkcyBhIG5ldyBwZXIgbmFt
ZXNwYWNlIGNvbmZpZ2ZzIGF0dHJpYnV0ZSBzbyB0aGF0IEFFTiBjaGVjawpjYW4gYmUgdHJpZ2dl
cmVkIGZyb20gdGhlIHVzZXJzcGFjZSB3aXRoIGFwcHJvcHJpYXRlIG5vdGlmaWNhdGlvbgp0b29s
KHMpLgoKQXMgYWx3YXlzIHRlc3QgbG9nIGF0IHRoZSBlbmQgZm9yIHJlZmVyZW5jZS4KClJlZ2Fy
ZHMsCkNoYWl0YW55YQoKQ2hhbmdlcyBmcm9tIFYzOi0KMS4gVXNlIGlmL2Vsc2UgdGhhbiA/OiBp
biBudm1ldF9uc19yZXZhbGlkYXRlKCkuCjIuIE1vdmUgQUVOIGdlbmVyYXRpb24gaW4gbnZtZXRf
bnNfcmV2YWxpZGF0ZSgpIGludG8gYSBzZXBhcmF0ZSBwYXRjaAogICBhbmQgYWRkIGRvY3VtZW50
YXRpb24uCjMuIFJlbmFtZSBjb25maWdmcyBhdHRyaWJ1dGUgZnJvbSAicmVzaXplX2NoZWNrIiB0
byAicmV2YWxpZGF0ZV9zaXplIi4KNC4gT25seSBhY2NlcHQgInRydWUiIHZhbHVlIGZvciAicmV2
YWxpZGF0ZV9zaXplIiBmcm9tICMzIG90aGVyd2lzZQogICByZXR1cm4gLUVJTlZBTC4KCkNoYW5n
ZXMgZnJvbSBWMjotCjEuIE1vdmUgb2xkIHNpemUgY2hlY2sgYW5kIEFFTiBnZW5lcmF0aW9uIGlu
IG52bWV0X25zX3JldmFsaWRhdGUoKSwgZml4CiAgIHRoZSBjb3JyZXNwb25kaWcgcHJvdG90eXBl
cy4KMi4gUmV0dXJuIC1FSU5WQUwgd2hlbiBucyBpcyBub3QgZW5hYmxlZCBmb3IgcmVzaXplX2No
ZWNrIGF0dHIuCjMuIE1vdmUgcmVzdWx0IGNhbGN1bGF0aW9uIGludG8gdHJhY2luZyBjb2RlLgoK
Q2hhbmdlcyBmcm9tIFYxOi0KMS4gTW92ZSBBRU4gZ2VuZXJhdGlvbiBpbnRvIGNvbW1vbiBoZWxw
ZXIgbnZtZXRfbnNfcmV2YWxpZGF0ZSgpLgoyLiBDaGFuZ2UgdGhlIGNhbGxpbmcgY29udmVudGlv
biBvZiB0aGUgbnZtZXRfZmlsZV9uc19yZXZhbGlkYXRlKCkKwqAgwqBzdWNoIHRoYXQgbm93IGl0
IHdpbGwgcmV0dXJuIGFuIGVycm9yIGFuZCB0YWtlIHRoZSBwYXJhbWV0ZXIgdG8gCiAgIHNpemVf
Y2hhbmdlIGJvb2xlYW4gcG9pbnRlciB0byBpbmRpY2F0ZSBhIGNoYW5nZSBpbiB0aGUgc2l6ZSBv
ZgogICBuYW1lc3BhY2UuCjMuIE1vdmUgdGhlIHJlc3VsdCBleHRyYWN0aW9uIGludG8gdGhlIHRy
YWNpbmcgY29kZS4KCkNoYWl0YW55YSBLdWxrYXJuaSAoNCk6CiAgbnZtZXQ6IGFkZCBoZWxwZXIg
dG8gcmV2YWxpZGF0ZSBiZGV2IGFuZCBmaWxlIG5zCiAgbnZtZXQ6IGdlbmVyYXRlIEFFTiBmb3Ig
bnMgcmV2YWxpZGF0ZSBzaXplIGNoYW5nZQogIG52bWV0OiByZXZhbGlkYXRlLW5zICYgZ2VuZXJh
dGUgQUVOIGZyb20gY29uZmlnZnMKICBudm1ldDogYWRkIGFzeW5jIGV2ZW50IHRyYWNpbmcgc3Vw
cG9ydAoKIGRyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMgfCAgNSArLS0tLQogZHJpdmVy
cy9udm1lL3RhcmdldC9jb25maWdmcy5jICB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
CiBkcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYyAgICAgIHwgMTQgKysrKysrKysrKysrKysKIGRy
aXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaCAgICAgfCAgMSArCiBkcml2ZXJzL252bWUvdGFyZ2V0
L3RyYWNlLmggICAgIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogNSBmaWxlcyBj
aGFuZ2VkLCA3MCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKLS0gCjIuMjIuMQoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
