Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00B0C369C2
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Apr 2025 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UObmXiJMwtZWa9R/9QuJ1tr6dudIkXIrnHdmZ3LzV7A=; b=UuMPCGy4WOO9ekIomihuV0gdtt
	Mxfo/g/YQP2gf9RRdq8SvRyG+NfHOR6FSZSUkLXv5XZmyquHcIv1ERiQnlBcde5c7KFY7xylTN7i3
	MsG0XWoIioEWKr112IKertKBwlaZbdvKA/uWT414PovGShooE+85++VrmZcqVehYBP8fs6ttNJWOw
	E/WekU/nblmjWUboIJcWeE/Gz/ZI68MJeRMo01LVs/JBWFrghmzaH6tE3zdHp6OfxSoc5k91cymUJ
	5dt48USVMf0rLJGDhYB6hB0518Nbv5PpsVHnmvijd1Z7tu71i4KZu21qvoMWLGPUAuawC/sXgHcLx
	oiRHcAkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6SDc-00000002SJ2-3hJ1;
	Sun, 20 Apr 2025 10:48:12 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6SDY-00000002SHr-1bb2
	for linux-nvme@lists.infradead.org;
	Sun, 20 Apr 2025 10:48:09 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 03E7D298566;
	Sun, 20 Apr 2025 12:47:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id BRkj1ldQ_UCU; Sun, 20 Apr 2025 12:47:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 94DBA298567;
	Sun, 20 Apr 2025 12:47:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 56sgopLhutVU; Sun, 20 Apr 2025 12:47:56 +0200 (CEST)
Received: from anvil.corp.sigma-star.at (84-115-238-41.cable.dynamic.surfer.at [84.115.238.41])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 21BE0298562;
	Sun, 20 Apr 2025 12:47:56 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	a.hindborg@kernel.org,
	leitao@debian.org,
	kch@nvidia.com,
	sagi@grimberg.me,
	hch@lst.de,
	upstream+nvme@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] configfs: Add CONFIGFS_ATTR_PERM helper
Date: Sun, 20 Apr 2025 12:47:25 +0200
Message-ID: <20250420104726.2963750-1-richard@nod.at>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250420_034808_559959_2CBC9801 
X-CRM114-Status: UNSURE (   8.68  )
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

This new helper allows creating rw files with custom
permissions.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/linux/configfs.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index c771e9d0d0b9..698520b1bfdb 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -120,15 +120,19 @@ struct configfs_attribute {
 	ssize_t (*store)(struct config_item *, const char *, size_t);
 };
=20
-#define CONFIGFS_ATTR(_pfx, _name)			\
+#define CONFIGFS_ATTR_PERM(_pfx, _name, _perm)		\
 static struct configfs_attribute _pfx##attr_##_name =3D {	\
 	.ca_name	=3D __stringify(_name),		\
-	.ca_mode	=3D S_IRUGO | S_IWUSR,		\
+	.ca_mode	=3D _perm,			\
 	.ca_owner	=3D THIS_MODULE,			\
 	.show		=3D _pfx##_name##_show,		\
 	.store		=3D _pfx##_name##_store,		\
 }
=20
+#define CONFIGFS_ATTR(_pfx, _name) CONFIGFS_ATTR_PERM(	\
+		_pfx, _name, S_IRUGO | S_IWUSR		\
+)
+
 #define CONFIGFS_ATTR_RO(_pfx, _name)			\
 static struct configfs_attribute _pfx##attr_##_name =3D {	\
 	.ca_name	=3D __stringify(_name),		\
--=20
2.48.1


