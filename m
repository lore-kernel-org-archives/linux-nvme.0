Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DA9E98DF5
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 07:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p8SG8CS3KXLX93bP4UJhM5bBlb2k87pveVugxaKNX+M=; b=4O7ds0e3Q7bjlaxBOrtsya/p0r
	0/sJWMYLSBq5vNUrgFNMA/92Cf5i4TNKvkLdpRZLnSh71FEhpxlRw+TAeNspcTVVOUMtR5LPZ3uCs
	2nzWFQEvGRSmdawGVxoZdnZQ/BYlctSo63rq9p1RxF51mBLXx14nv8H+aJkEKZasMQB9Kw4ImeDMa
	3r3a6V8mGEDh3mdbMOqyaMZnnP1UytFJJWJGREHucpWtw4YgvgNUjG1ypp2lUszk4QIGLNtakc1BE
	drRZ+QTCURHqivW7MRgIXggQ3FDOkcXxKitF6DsFJcqHA9juKYbDabP3L0BwcZ0Tgv8xX0uPpbqZm
	bofllSyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuQZE-0000000HOOz-1Gor;
	Mon, 23 Feb 2026 07:41:20 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuQZA-0000000HONH-2Ggu
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 07:41:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771832476; x=1803368476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A3IH64x50WE7AgzI9g1WtgmkQgW+rfS4j/nA35LWYpk=;
  b=Sx/WBqUs6E+uiOXmswK8lGM4MhFqGedAh+IBoNQyl5x/Syr9P7s3D39J
   aMnisY8TLXwMtBZH3eN0ZTSe/p077+PPACX67AekC8rW1EXlsublCETKf
   CFzikTBBvXthAqu1P1J/TIvuucv1ZEbyf6m8Yl9yDq+Dn3UaxQDsE/Ybn
   dLYNsKFdt46lRXyFOQ7kHwxO56xi2Y0F4TyG6UkJgUHwyNPrAMIB2zDYs
   uvnUZ1YBKRUxWfPDEwwLE/seFCNvHrtR0cBQMQhoiH8rcnKgZLpOcWdko
   z4jVKWLpc0WVeZVULaUntKPdlvJ2jRZfv9OeRyViOEnFE/QpWmRdS60/B
   w==;
X-CSE-ConnectionGUID: Ea+itOy3QIWyfm4RYERV2A==
X-CSE-MsgGUID: zMEVgEpDTNu1SUoHODha9A==
X-IronPort-AV: E=Sophos;i="6.21,306,1763395200"; 
   d="scan'208";a="141214635"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 15:41:16 +0800
IronPort-SDR: 699c049c_GpK3UmDVvBf0bYNWPUfzYKwRV8iH9QvSChExH9RiQUY+LRa
 MQHVl0wrqs4y3wfbcTIuYIp/nrE/1Q25Z9w73lg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 23:41:16 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 23:41:16 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/3] src: add nvme-passthru-admin-uring to .gitignore
Date: Mon, 23 Feb 2026 16:41:10 +0900
Message-ID: <20260223074110.144758-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
References: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260222_234116_580259_51D8676B 
X-CRM114-Status: UNSURE (   9.24  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Commit a94b77010d56 ("nvme/067: test io_uring pass through for NVMe
admin queue") introduced a new program nvme-passthru-admin-uring under
/src directory, but omitted it from .gitignore. Add it to .gitignore.

Fixes: a94b77010d56 ("nvme/067: test io_uring pass through for NVMe admin queue")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 src/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/.gitignore b/src/.gitignore
index e6c6c38..988d785 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -13,3 +13,4 @@
 /miniublk
 /nvme-passthrough-meta
 /ioctl-lbmd-query
+/nvme-passthru-admin-uring
-- 
2.53.0


