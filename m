Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DA0C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Apr 2022 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eQY981qQJsial6Teqout4wQZLQ5cka3Wr/hRVUCufOA=; b=PHipIUzW4IpSeg6IevDNGRuRnx
	AlDJbnEJ4+KLTEKNJzlYAlv5Z1k6axeMK685O0od0J2fdkNetZeBpqeQeiaPKpWsfwsBAnGcpjqFL
	Yu4+fWcuGqiEeb3qtxh6fRuZQ7/ByEwka/qptdJF0tIrzmPIOCIuhQ5Z9UYwqhnpNOXvFO5itxIvk
	tqlX/JyF5BmZwPJEVJQXJst0xx6LhL3NWIxQmOxr2Y3H59L5aHorL9t1+Qh/NbrhsnW5nMB+/hRza
	GKktjLJDNuFUTQDiDBXHGneaaU5fJ6Ck+1wkizpD3arUJ0qedddRDo9mZtJ1uFq9G1qy/4HR1kr5U
	MBIx+9lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1naHzY-005ulr-Qe; Fri, 01 Apr 2022 14:11:08 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naHzD-005uaO-KO
 for linux-nvme@lists.infradead.org; Fri, 01 Apr 2022 14:10:49 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20220401141039epoutp04e8fc099a14ff4b2cf8b983df82b45d60~hyxdVFX8m1120211202epoutp04d
 for <linux-nvme@lists.infradead.org>; Fri,  1 Apr 2022 14:10:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20220401141039epoutp04e8fc099a14ff4b2cf8b983df82b45d60~hyxdVFX8m1120211202epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1648822239;
 bh=eQY981qQJsial6Teqout4wQZLQ5cka3Wr/hRVUCufOA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YZo4FFJw8YovEUcQezx780SzfVvPgckOUbU4wVvloc6ralaLSGK5uLb/VTmyhYrZf
 P9EBUWElZAJ6AKF9Fc38cc1QHlerFeUWWBk0GVPuA0XZ/neA9H4Kh7iFGbPggA2IKo
 i2jR4dmtVr43nc1t2rNop1R4AtoVhRauuYND7mZQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20220401141039epcas5p4c033b2a6d97051f930a18af88388896d~hyxcts6rt1430814308epcas5p4U;
 Fri,  1 Apr 2022 14:10:39 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4KVMWv63GJz4x9Pv; Fri,  1 Apr
 2022 14:10:35 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 7F.82.06423.BD707426; Fri,  1 Apr 2022 23:10:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20220401110833epcas5p18e828a307a646cef5b7aa429be4396e0~hwSdFLjZ81893718937epcas5p1e;
 Fri,  1 Apr 2022 11:08:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220401110832epsmtrp2bb5847e90b6723d87d3c5e9eb342f9ec~hwSdDiLxq2799827998epsmtrp2n;
 Fri,  1 Apr 2022 11:08:32 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-e1-624707db139c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 46.49.03370.03DD6426; Fri,  1 Apr 2022 20:08:32 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220401110831epsmtip12236795323fb5dc084d00fb83e8e014e~hwSbXq0uw0869908699epsmtip10;
 Fri,  1 Apr 2022 11:08:31 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org,
 pankydev8@gmail.com, javier@javigon.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: [RFC 2/5] fs: add file_operations->async_cmd()
Date: Fri,  1 Apr 2022 16:33:07 +0530
Message-Id: <20220401110310.611869-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401110310.611869-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmhu5tdvckgwlNhhZNE/4yW8xZtY3R
 YvXdfjaLlauPMlm8az3HYtF5+gKTxfm3h5ks5i97ym5xY8JTRotDk5uZLNbcfMriwO2xc9Zd
 do/mBXdYPC6fLfXYtKqTzWPzknqP3Tcb2Dze77vK5tG3ZRWjx+dNcgGcUdk2GamJKalFCql5
 yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDHKimUJeaUAoUCEouLlfTt
 bIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM343H2IsmMReMbf5
 F0sD4xPWLkZODgkBE4kdL26xdDFycQgJ7GaUOLJiDjtIQkjgE6PEmg9REInPjBIzZ9+A61jQ
 /p8dIrGLUeLap9uMEB1AVXMnCHUxcnCwCWhKXJhcChIWEZCX+HJ7LdgGZoFrjBKPXx1iA0kI
 C5hLPD6wCmwoi4CqxKu3k8Dm8ApYShzo2MgOsUxeYual72A2p4CVxKF/G9kgagQlTs58wgJi
 MwPVNG+dzQyyQEJgIYfEmtvvmSCaXSRO3n8BNUhY4tXxLVC2lMTnd3vZIOxkidbtl9lBjpYQ
 KJFYskAdImwvcXHPXyaQMDPQL+t36UOEZSWmnlrHBLGWT6L39xOoTbwSO+bB2IoS9yY9hYaV
 uMTDGUugbA+J5u7NrJBw62WUaJ/5jmkCo8IsJO/MQvLOLITVCxiZVzFKphYU56anFpsWGOal
 lsPjODk/dxMjOPlqee5gvPvgg94hRiYOxkOMEhzMSiK8V2Ndk4R4UxIrq1KL8uOLSnNSiw8x
 mgLDeyKzlGhyPjD955XEG5pYGpiYmZmZWBqbGSqJ855O35AoJJCeWJKanZpakFoE08fEwSnV
 wCT7sTJ5jtScTYZGl/5derxnldbsU1djVwSfuikz4+cK4fzetdkRYVpRpWl8C5WFt54tZ01j
 nPx4o9hCvdVJkz7JF067HXXoYVTFnSo2H5bnhUnJzx+XfrRIDDT9O3P2Q+PpQvc0u+115q48
 WMQgfyXpK/fhRM8u5b2CF4882m6S41JsLK/qmfsjyOPx4p2CT3fYMMfcqNm3faLBIo8Fk24c
 N4gpyZEJvvG+R01kS+SC2EtFnL/Xi0S3qZ1pMFvKUXr9m9FW2WNsa/w/nbgxd5L+YrbQh+e3
 N19dbqxkO//uMtuy2Y466zyLni9r2Rb8p8E8NWDiWSFF28+xvK2LwoomBfKucj55aUmt8Gdp
 zUolluKMREMt5qLiRADAe+tZRwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSnK7BXbckgxN3jCyaJvxltpizahuj
 xeq7/WwWK1cfZbJ413qOxaLz9AUmi/NvDzNZzF/2lN3ixoSnjBaHJjczWay5+ZTFgdtj56y7
 7B7NC+6weFw+W+qxaVUnm8fmJfUeu282sHm833eVzaNvyypGj8+b5AI4o7hsUlJzMstSi/Tt
 ErgyfjcfYiyYxF4xt/kXSwPjE9YuRk4OCQETiQXt/9m7GLk4hAR2MEpc/7yMDSIhLtF87Qc7
 hC0ssfLfc6iij4wShxc+ACri4GAT0JS4MLkUpEZEQFFi48cmRpAaZoEHjBL3p/8GGyQsYC7x
 +MAqsG0sAqoSr95OYgSxeQUsJQ50bIRaIC8x89J3MJtTwEri0L+NYL1CQDX7p85jgagXlDg5
 8wmYzQxU37x1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQI
 jhEtrR2Me1Z90DvEyMTBeIhRgoNZSYT3aqxrkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n
 44UE0hNLUrNTUwtSi2CyTBycUg1Mk22fVGzd0GIh9GZtdKSxi9e+0/e1H881c6+NcYmbVbBH
 PvHQt2kVb0Un3Mt0NHnpXLzr64vfR4srg89nbXgpssLdvHXm3qZb9UWaDxeufXciqFtDemWI
 3O7NPJv6atfU/azZ8Hr30t+/i6RWfQl+0Vcuc+mTySKWO/auOof6eHVtX0Yky1ZU/HWpNupx
 fGvXP//fYVOb7vQfYpcmT3x1knfR/Sy7P3ql31dk3T+X0Bl0J/nz/ge72i5cam8/I7A7QYCr
 lnHn61M7+Iuc1U6enbo4+1OGe07Y9kaGFSqTb7BFZcyetnrfgk1ufNtjnxzPmnyzxotTv/DC
 VsXix7U/VxW8s/krul39errihEl/jiqxFGckGmoxFxUnAgBoV/QEAAMAAA==
X-CMS-MailID: 20220401110833epcas5p18e828a307a646cef5b7aa429be4396e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220401110833epcas5p18e828a307a646cef5b7aa429be4396e0
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110833epcas5p18e828a307a646cef5b7aa429be4396e0@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220401_071048_069909_8C4A969D 
X-CRM114-Status: GOOD (  13.75  )
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

From: Jens Axboe <axboe@kernel.dk>

This is a file private handler, similar to ioctls but hopefully a lot
more sane and useful.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..a32f83b70435 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1977,6 +1977,7 @@ struct dir_context {
 #define REMAP_FILE_ADVISORY		(REMAP_FILE_CAN_SHORTEN)
 
 struct iov_iter;
+struct io_uring_cmd;
 
 struct file_operations {
 	struct module *owner;
@@ -2019,6 +2020,7 @@ struct file_operations {
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
+	int (*async_cmd)(struct io_uring_cmd *ioucmd);
 } __randomize_layout;
 
 struct inode_operations {
-- 
2.25.1


