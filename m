Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D56C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 06:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y4z1EV6H1Xo/q+97rV9e5dZ7sHwRvEWGQpRQoT1gSp0=; b=M7y0yXXjqtbiSWhwdMoUAQ7a3S
	GLDqwVjaqGMjzQD5k1s5rfL9FNXTyby55ZujUwM+Oa9hgQMTbgh4YjvPZw6L2gl8vutyq7A3R8/6a
	RtvwKsT1MWHhMYYLYscCVKnbq33nWGKW+sfm+IXga2tNXfyXkfmh9JRsKaZDjqEwzQTeErpu6UHFG
	60IN9qKS95MFtjgkniJB2lJx86JxuZpBawhRVO+8ftXykFqommc8nrpawo+FtcMHGfsraizaTylaS
	eiPd9swnE4sWSKC+RxCgOYpa3lYWJxBry6G7DXnduarjkYVpUj+of/ni6oYKzQck+KEzvYy5aw+dN
	pH5amL4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqr2Y-00BtU1-J5; Tue, 17 May 2022 06:50:42 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqr0p-00BsXo-Tn
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 06:48:57 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20220517064850epoutp0252463e0e4d4c1828f5534608bb053ef8~v0a1oC0LR1137311373epoutp02W
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 06:48:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20220517064850epoutp0252463e0e4d4c1828f5534608bb053ef8~v0a1oC0LR1137311373epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652770131;
 bh=Y4z1EV6H1Xo/q+97rV9e5dZ7sHwRvEWGQpRQoT1gSp0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VL1elb19XFarvYiiw7atPK1VGUfom8Cf+1XH+RozTJZoLw4g4NswLjEp7uiuE7mEy
 EiAhrfn21V+42P4sj7Xod6fAbmFrcUtmMVEevuFbQuA3GQ+95v9hJbOb5IhLeCwBaa
 zd5OULKxrWF41tm5RlxKSRNW/ujdsI3BNIEMJF+A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20220517064850epcas5p31410bdf3e3532bb281f3517b475ba7b1~v0a1LZtei1963619636epcas5p3C;
 Tue, 17 May 2022 06:48:50 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4L2RXr2zqjz4x9QK; Tue, 17 May
 2022 06:48:44 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 FD.63.09762.54543826; Tue, 17 May 2022 15:48:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20220517053713epcas5p4770bb3699f7a0c5884c14633659e8cd2~vzcTfgHgQ0704507045epcas5p4Z;
 Tue, 17 May 2022 05:37:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220517053713epsmtrp28cd75582b59df30905a2ab89f0f174cf~vzcTezBme0948409484epsmtrp2b;
 Tue, 17 May 2022 05:37:13 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-07-6283454507b2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 77.D1.11276.98433826; Tue, 17 May 2022 14:37:13 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220517053712epsmtip1c601761103fe86effdb0d8995238aff3~vzcSafWtU1464814648epsmtip1e;
 Tue, 17 May 2022 05:37:12 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
Subject: [PATCH 3/3] nvme: admin command uring-passthrough on controller node
Date: Tue, 17 May 2022 11:01:47 +0530
Message-Id: <20220517053147.7925-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517053147.7925-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTS9fVtTnJ4PdPc4vVd/vZLG4e2Mlk
 sXL1USaL828PM1lMOnSN0WL+sqfsDmweO2fdZfe4fLbUY9OqTjaPzUvqPXbfbGDz6NuyijGA
 LSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
 ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
 dsakV6uZC7bxVxzes5WlgXERbxcjJ4eEgInExQnTWbsYuTiEBHYzSqx6+Z0RJCEk8IlRYstv
 bYjEN0aJRZ3XGWE6PtzvY4NI7GWUuHthK5TzmVHi7MmPQLM4ONgENCUuTC4FMUUEjCRuv40B
 6WUW8Je4sn4fO4gtDGQfXfuKGcRmEVCV+PWzA8zmFTCXWNexkhlil7zEzEvf2UHGcApYSMzb
 4wNRIihxcuYTFoiR8hLNW2czg1wgIfCIXeLn+x0sIPUSAi4SnxdxQ4wRlnh1fAs7hC0l8fnd
 XjYIO1midftldojyEoklC9QhwvYSF/f8ZQIJMwP9sX6XPkRYVmLqqXVMEFv5JHp/P2GCiPNK
 7JgHYytK3Jv0lBXCFpd4OGMJlO0hsWbRVGg4dTNK9PTtZ57AqDALyTezkHwzC2H1AkbmVYyS
 qQXFuempxaYFxnmp5fAITs7P3cQITpRa3jsYHz34oHeIkYmD8RCjBAezkgivQUVDkhBvSmJl
 VWpRfnxRaU5q8SFGU2BoT2SWEk3OB6bqvJJ4QxNLAxMzMzMTS2MzQyVxXoH/jUlCAumJJanZ
 qakFqUUwfUwcnFINTMwyU/6wbXpXKn17yZof4msNX65+0h8YH1wwUzTjbJvUK40Eoetq7cvY
 dx49FP3N/pNNlPGWh0ckPvHorrTJ9Jwl6XPkv/TXK1kzbF9NfCojnlrOeefWZQ6xN00LxWc8
 Z7z0+Jj01kleBZ3bnThYTPq0OC+Ym6Vd3dD6WMZX48fqYv+njtz7C9Quy89idUwKj/WUkNEq
 TOP5pfjWb1Hu/UUxW7k4I4Mv/F93kG3Khl0Ppi0v3B71vWBSrU/lvZnBlw/w7WqyUDt34Jhp
 yz6r3Jjpc1NL7QNdUmtTVpakH2KLZb0v1/zCrte+TTtcou7szXt6Z4V/lb7pn7iLpWDrr71n
 JD3WZzq90j/3zm1TsRJLcUaioRZzUXEiACbRYMYdBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSnG6nSXOSwYaFShar7/azWdw8sJPJ
 YuXqo0wW598eZrKYdOgao8X8ZU/ZHdg8ds66y+5x+Wypx6ZVnWwem5fUe+y+2cDm0bdlFWMA
 WxSXTUpqTmZZapG+XQJXxqRXq5kLtvFXHN6zlaWBcRFvFyMnh4SAicSH+31sXYxcHEICuxkl
 Zp/8xQ6REJdovvYDyhaWWPnvOTtE0Uegou1bGbsYOTjYBDQlLkwuBakRETCTWLBgHguIzSwQ
 KNHdcx/MFhbwlZh5sYMVxGYRUJX49bODGcTmFTCXWNexkhlivrzEzEvf2UFGcgpYSMzb4wMS
 FgIq+fftJCNEuaDEyZlPoMbLSzRvnc08gVFgFpLULCSpBYxMqxglUwuKc9Nziw0LDPNSy/WK
 E3OLS/PS9ZLzczcxggNaS3MH4/ZVH/QOMTJxMB5ilOBgVhLhNahoSBLiTUmsrEotyo8vKs1J
 LT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBaVsa39vM81q7c+pFjui+DNp25abl
 9s6fwjf3J7nKL7u7uLK/4f/6C04Ty8+0Wt9JtimaN3VBFMPT528U99R1VC9mrjkyo1nj3s9L
 szdm3XWe+zdKsvm729LjOim+x7Zuf1YUeqS6MXLrYcMol5XyzKvtr63fqN69u0+N19FHTeVw
 WkC15wmeaftv/UwQ1pyjuXvPmQUhpscTF8wR9tizfZ5MNWcUz+QPExbw+L+4cLdB9XzJ/vea
 RXv6Yybr7kj4kLdUNk6kST+q655V2r0CyQOi/50kPsafPn1CKPcQz7t1wb0OXut/akzt/7Zg
 ebA3M/OiwAw+nas2Uxdt8QqLELmzvf6mpGvQGs8NUY4h5kosxRmJhlrMRcWJAO19KJbXAgAA
X-CMS-MailID: 20220517053713epcas5p4770bb3699f7a0c5884c14633659e8cd2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517053713epcas5p4770bb3699f7a0c5884c14633659e8cd2
References: <20220517053147.7925-1-joshi.k@samsung.com>
 <CGME20220517053713epcas5p4770bb3699f7a0c5884c14633659e8cd2@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_234856_392105_09CC26A2 
X-CRM114-Status: GOOD (  15.06  )
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

Enable uring-passthrough for admin commands when issued on controller
(/dev/nvmeX) node.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c  | 1 +
 drivers/nvme/host/ioctl.c | 7 +++++++
 drivers/nvme/host/nvme.h  | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 510e3860358b..23479cf866cc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3145,6 +3145,7 @@ static const struct file_operations nvme_dev_fops = {
 	.release	= nvme_dev_release,
 	.unlocked_ioctl	= nvme_dev_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
+	.uring_cmd	= nvme_dev_uring_cmd,
 };
 
 static ssize_t nvme_sysfs_reset(struct device *dev,
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 0f46dc7381a0..833b285b1b04 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -736,6 +736,13 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
+int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
+{
+	struct nvme_ctrl *ctrl = ioucmd->file->private_data;
+
+	return nvme_ctrl_uring_cmd(ctrl, ioucmd, issue_flags);
+}
+
 static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 086ccbdd7003..26d35c557588 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -787,6 +787,7 @@ int nvme_ns_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 		unsigned int issue_flags);
 int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
+int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct pr_ops nvme_pr_ops;
-- 
2.25.1


