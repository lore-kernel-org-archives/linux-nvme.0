Return-Path: <SRS0=ia7R=ZO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44A9C432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 07:42:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A447520708
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 07:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GYXyCyjv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HFVDq4b8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A447520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5foL5zIjL6/viGlGoReyjwV9RbV1TmziPBNpHpMYxaU=; b=GYXyCyjvT6F5y+
	PUUy/r7rjGgeyQCiJNSLpvbKhLsV0x2IGxC9M6J+Kq/glx0wEoE0dOp55c5StmOafVCY2kA88rqUk
	BDr+8XJArYkxtBRNSorIJdx+d3HkPOiFYH4qmfx9IzYgX1MzE0aC5mpeoaoSjheiLtwVlG7p6aOiw
	mYftT0DLPnkjG/fxTaCwCdtjckOG+cHqHU9KH7KF9d0LToMnczilieedRrcEdraa10TriRuOn3Ut2
	jXWM+SzZY8t3GWL14MXtG/I2oyGSxJYhPIDq93zK32rF8KxnrRUpqDCuu4nK9XDaJ6J6WD6kejDRv
	6htygn9Qxyg855SE3njQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iY3ag-00046M-Fw; Fri, 22 Nov 2019 07:42:54 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iY3a5-0003cz-Ao
 for linux-nvme@lists.infradead.org; Fri, 22 Nov 2019 07:42:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574408538; x=1605944538;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hA176hSIwOQe5LvU8gVRDvEgHSteDEOwP2pp7QzzH50=;
 b=HFVDq4b8HiqB6scobjtaKoezH/f9gzdz4H2mOHx1ZmKS3qkjLajlnCAk
 fOktir4JfmdF3Ba4OsdJkUZob1gYCGydFGZ7rwfY4KE6Nj5qcL9TYz81n
 c8rVULZKhKOfzCUzp8d7virCIzqMI8flTBqLN9Sqq6ni9rpgFNyt/MVBo
 vMZEFm2jyW+6UDpF4Dm74RHTaVYWxRGGik17saiks9P2QuRjG+XzODaBv
 RhYnmfA2Z9om2jqF2PNLS4akrgYldQGflrM5jc8SvprF33tcI4IFk0Hhi
 JC+zAg6QSJqKnfqoIDVRM24UyyfEeHMcvuIOmOz/r5u+3tQYDO9b/lftC g==;
IronPort-SDR: LpxOhqGIpdI2XQLW2MYMUbopqVs66LbYw/Mq5O1q6tzpvYGJuTTsWuygEQrpj/icgV5aCHghg3
 RAWDzsdVZidzUoKDidBbqXTjE7ob0OdKCpIkdeV16J4kj/1t/MAFhSWBDpCjcKyWM1BPhF+viJ
 w89Y0ENYtWPy6Qdf4Ib+DVL/CfVjoOyjMv3TP+qTI1MagoI+NZF65y0i4V4zKNETlguM40Xjlg
 gH5ZsdsxKstaoNhuC2R8rJee/pVyCwItCGhEEF7izGzBUJxnzZ9TvFQ7GaygYjTnw1iXvbWIV0
 f/4=
X-IronPort-AV: E=Sophos;i="5.69,229,1571673600"; d="scan'208";a="128163469"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2019 15:42:16 +0800
IronPort-SDR: YcxfAb+kSRuDhduXnGQgZ5+EuAn/G4CcsdcLGWLOhuipzLKcRl2pdsQZ3TDGku4qzPSARKudnE
 Rl+n/w0Ce4rVZxulJaYhJjCyVe4Iyg3CrY6BVObeyCqlYx7z1qSP37T30qctFcCGMkD1JoW5Xb
 GFLFZ0x1eWwLvzGGa5UR4uoVdOfEZkHvyoOcC7OMZYhm75rwhNWv6m9JGDZoGMxbYjCz5iBFMz
 Gti8LZT67dibnib4A+k+TASqrn13nn3A/u2qQN7thZuf2jXTp6ER1W8ZterSwL4p3DITbyVDlW
 p+ni3MCN6uNhXaBNFUAmjjCH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2019 23:37:01 -0800
IronPort-SDR: 6ikl+ZzAOVEX1W+a16u49xglmntdH7t/kxtFqCkR/bMBzYlID9HvOKztPKo+RRqu1dbYoeZu0d
 BWGhD+Ew98BLMhlB45UrwdxZ2lBoUJmTHwjokmSTvdf2vW2knKrLtvT60L/oVSH4rUpUmVqiz6
 Hm1chNEwU8I1Ikm9kUz6lzFESRZqlIxsJkuID1CCA33DFW5s1EQuYw+aEexIz8allBN82IJrig
 P+Iw3uKIVgY+7Z0nWodBRmG/8jYOJiKW4WuDYjI+FBScnCw80it6VPEE36ujnYc8CTCnftZEHS
 qHU=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 21 Nov 2019 23:42:15 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvmetcli: allow setting of the cntlid[min|max]
Date: Thu, 21 Nov 2019 23:42:12 -0800
Message-Id: <20191122074213.12232-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191122074213.12232-1-chaitanya.kulkarni@wdc.com>
References: <20191122074213.12232-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191121_234217_757788_2EFA0710 
X-CRM114-Status: UNSURE (   8.00  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch allows users to set the subsystem's cntlid min and
cntlid max.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 nvmetcli | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/nvmetcli b/nvmetcli
index 3d8c16e..4fdac53 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -155,6 +155,8 @@ class UISubsystemNode(UINode):
     ui_desc_attr = {
         'allow_any_host': ('string', 'Allow access by any host if set to 1'),
         'serial': ('string', 'Export serial number to hosts'),
+        'cntlid_min': ('number', 'Set min ctrl id'),
+        'cntlid_max': ('number', 'Set max ctrl id'),
         'version': ('string', 'Export version number to hosts'),
     }
 
@@ -172,6 +174,21 @@ class UISubsystemNode(UINode):
         info.append("allow_any=" +
                     self.cfnode.get_attr("attr", "allow_any_host"))
         info.append("serial=" + self.cfnode.get_attr("attr", "serial"))
+
+        try:
+            cntlid_min = str(self.cfnode.get_attr("attr", "cntlid_min"))
+        except Exception as e:
+            cntlid_min = "n/a"
+        if cntlid_min != "n/a":
+            info.append("cntlid_min=" + cntlid_min)
+
+        try:
+            cntlid_max = str(self.cfnode.get_attr("attr", "cntlid_max"))
+        except Exception as e:
+            cntlid_max = "n/a"
+        if cntlid_max != "n/a":
+            info.append("cntlid_max=" + cntlid_max)
+
         return (", ".join(info), True)
 
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
