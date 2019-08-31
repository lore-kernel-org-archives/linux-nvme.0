Return-Path: <SRS0=EcNd=W3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67805C3A59B
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Aug 2019 00:10:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDE723407
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Aug 2019 00:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OhQb/Zal";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jNJlaHa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDE723407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qO4+44Qo9lDUQ+OK3t/hTkCQG+A8szg3Blqg64kB7s0=; b=OhQb/ZalGe0VV5
	Faw4fxmUOsmz5wFBMw2GwfCiSWOnlrQN4/NdsEWvqAZheJVepSY3UOVsyfuDWeytyzNHYw43PuR3g
	zmab/U43xW9n/jcrkEnDTztoYUu8RMUKzEBILDPNyOzSn/Brx0TbCq3LgIyw1YnNxL+6jWg1no1UP
	Alt7jPaXASQ0rguK0HZ9FJgsPpDwU8VYWoP3bt23x/H9BaiZ+4juC+DWTSHsFD/t4E1eP0Otzp4KS
	0J2zBd7LtuEysMTPZi53CeiWoFpelRipGPIBI7ivsHLtGTdLL9HEtTbk91LeiInO7B9dCiqLpFa4Y
	ZbbOfjnlyGCLvjUOtaFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3qyE-0005rP-7y; Sat, 31 Aug 2019 00:10:22 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3qy9-0005r3-Il
 for linux-nvme@lists.infradead.org; Sat, 31 Aug 2019 00:10:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567210217; x=1598746217;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zj5i/W8d8iNF49xddR4/+DEh1tw6smMifwUnIaur9F8=;
 b=jNJlaHa5Tn3nwNQcjDeYK2lsqzUrFkZqancsoCSjs8K0OoCz4ODlJSJ+
 bhjvp2ro2yhkN8o/xxImBkvRMfo0xuWKA+Anepz/UmgjBg4xyR/ttV7Sn
 dWM93uXBWlta42INbm5IdKYe9K5acKdlOvM1Ta3A4G/IgQAcZ+8e+rJPy
 EeNQS0psGO+mbA9EOCPUsRATfTHfdAzFdNDryzGlbs/2C49zzHnlEQZLB
 b7hh8G5io0hvIjEYT4Zmw8Tr044GKJzYs0k0CKoSc8Fdv5+mCHrRVJ8LT
 pVMJ7FflRQbbJJz73tsJKeGiApXkwbcurEbRbPPxOZkqgnhpmLabCrW9O g==;
IronPort-SDR: 43KyhuITiN0QeU86OK6yVcnAYmI0t5g0oq9WcGsMq/GC7LtiIps29G6Shj0kSVCcLMnJ9IZlZx
 C1j8Tnt9DWq1ooEUi++qLE53QferjhAHuTfjcc8zY5yicqAAk0kBupKaa1SQ+2rfxPI4bt1L0J
 CxPopDuACPgSRTQL8MzMn5TCtvHpekVKLCDDhWGS6Azyzfmns2iOYyGlawky8yd39DVHAgqycQ
 w5BkH1NuHAEtGsi+x7Jb+ycLNX1fNjJbUWLAT8KfHyUKlCQd+nBJJjMnxe/kh14ENg2MY+e2lu
 0Vs=
X-IronPort-AV: E=Sophos;i="5.64,449,1559491200"; d="scan'208";a="223755687"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2019 08:10:16 +0800
IronPort-SDR: VCqjcWhE5+VX8kdIkyCYEiqmmEIOedyOYT+siI0FECUfl9K7C1EXjD6vUnyf3rp8CnY+OHoClf
 H4NQ0JUjwzA8LMqlXS0OFZucN0tIYzwPeBc719BS8asHaMclsI92AGhglEz4wYUAUYN+LNI2l+
 c15myZXPV68ZzHsEo/NabeaOZe8Kr84bQoJxCVpYtUPTMCV4zPwKVAarDgjLmdXa9XRNidZzXc
 GvET7ytn7rjLmtGehvh3cIKxx8gt7t96pd8g892RJIzWJsVWlZHzkWacML1/1/4NCRkYmCqOa6
 BONC3WGXE/T/VZd4iP4EVF2t
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2019 17:07:21 -0700
IronPort-SDR: FtyiBzjWLih3fvhXmy0PQtgdpzzVaKra83knRrwaez4lhvDjSKRTK769L7X8O1rzOm12lKduJm
 y6zFCP3YZY1Ghl+QUSfji7zZvc1WaCqx8KLLEnmxK+iZZNCEaQsHqktlA/vzFdnpbpaFDtqGgJ
 bWs1x0VQgWXafsUiizzU30RIY9BftvGqhOLZM5Pll7ljkiXhwdwOMnE9jrkan48hG+6Z6Z77Pm
 s25LkecUUve8NgCs7G36nPnmgoTeLiIQUL3w1K8EU7Q3G4EgU5F89zgyW2HgJYTpax8Jdkg7aM
 s94=
WDCIronportException: Internal
Received: from qemu.hgst.com ([10.202.66.53])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Aug 2019 17:10:15 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-core: get rid of the unused variable
Date: Fri, 30 Aug 2019 17:10:13 -0700
Message-Id: <20190831001013.8581-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_171017_736045_3C8306F7 
X-CRM114-Status: UNSURE (   9.22  )
X-CRM114-Notice: Please train this message.
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhpcyBwYXRjaCBmaXhlcyB0aGUgZm9sbG93aW5nIGNvbXBpbGF0aW9uIHdhcm5pbmc6LQoKZHJp
dmVycy9udm1lLy9ob3N0L2NvcmUuYzogSW4gZnVuY3Rpb24g4oCYbnZtZV9jb21wbGV0ZV9yceKA
mToKZHJpdmVycy9udm1lLy9ob3N0L2NvcmUuYzoyNjQ6MTg6IHdhcm5pbmc6IHVudXNlZCB2YXJp
YWJsZSDigJhuc+KAmQpbLVd1bnVzZWQtdmFyaWFibGVdCiAgc3RydWN0IG52bWVfbnMgKm5zID0g
cmVxLT5xLT5xdWV1ZWRhdGE7CgpTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNo
YWl0YW55YS5rdWxrYXJuaUB3ZGMuY29tPgotLS0KIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8
IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXggMGIxZmY4
ZDU0ZTQ4Li5kZGY5OTM0NWUzZDggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
YworKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKQEAgLTI2MSw3ICsyNjEsNiBAQCBzdGF0
aWMgdm9pZCBudm1lX3JldHJ5X3JlcShzdHJ1Y3QgcmVxdWVzdCAqcmVxKQogdm9pZCBudm1lX2Nv
bXBsZXRlX3JxKHN0cnVjdCByZXF1ZXN0ICpyZXEpCiB7CiAJYmxrX3N0YXR1c190IHN0YXR1cyA9
IG52bWVfZXJyb3Jfc3RhdHVzKHJlcSk7Ci0Jc3RydWN0IG52bWVfbnMgKm5zID0gcmVxLT5xLT5x
dWV1ZWRhdGE7CiAKIAl0cmFjZV9udm1lX2NvbXBsZXRlX3JxKHJlcSk7CiAKLS0gCjIuMTcuMAoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
