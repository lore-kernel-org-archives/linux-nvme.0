Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE056C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Mar 2022 11:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=tan5dKTreBUbAGGgES0KQjuzvPrsaAfL+5h47iaHc50=; b=2SAW4ym9JzdOh+CvUz67DGRXcy
	TxEeov6Tf7azSClCxAVYCRwIhNQz8LHmnlvpGQe+l7JRk8uLsna/2VE9YbWiBBVPLls3mwnhVLAuE
	6+sqMkiJRwemOe9Hb28KlqHJatInmZnv2aYx2nc4p9H0t4cL6bYhSmcJQZf1YAGfpyCYhj/EFz9jx
	0RVJr/2dEYopQbnU/ggsQVFQZNhoTlVntiGY+zHcavly9EObrng/mJ+4uEEEcgjrrDxwycEFUwfgN
	dnuOJlVfYekQcc6cV5YLgkpRIMBTS/j+6asUAUeIVO4p72mWWEkQTlQ2YBh/CgZqvVJAgapZvt8SK
	fhtfro6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXi37-001uZX-W7; Fri, 25 Mar 2022 11:24:10 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXi33-001uYE-81
 for linux-nvme@lists.infradead.org; Fri, 25 Mar 2022 11:24:08 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220325112359epoutp0364ee82110c43a625b85f8a0cbcb1f9aa~fm_8HX2Ex2761827618epoutp03c
 for <linux-nvme@lists.infradead.org>; Fri, 25 Mar 2022 11:23:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220325112359epoutp0364ee82110c43a625b85f8a0cbcb1f9aa~fm_8HX2Ex2761827618epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1648207439;
 bh=tan5dKTreBUbAGGgES0KQjuzvPrsaAfL+5h47iaHc50=;
 h=From:To:Cc:Subject:Date:References:From;
 b=tkDsAu0aFOSDr541q762PpvlfLYhhjUgJ7AcxhCcnxD1vCDa3fphNjQqhfa2joMzV
 0O5+r/nnfTR70ACb3tkMOZ7mdC3dv9p6OPQmw/pQr9pOI075ZAUBJiCKXcC4aS1RcG
 gI7OzZTcKCTTEbUdwMgZd7gG4M3i/Ae25CW6d2VE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20220325112359epcas5p14ea0d44ac2626dae92d1532f41efa3a8~fm_7wDTkn0384303843epcas5p1b;
 Fri, 25 Mar 2022 11:23:59 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4KQ08r1dSmz4x9Px; Fri, 25 Mar
 2022 11:23:56 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A1.FC.06423.D36AD326; Fri, 25 Mar 2022 20:23:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20220325111952epcas5p4800055294fe473b923713d4b9c006026~fm7WNNynK0880008800epcas5p4I;
 Fri, 25 Mar 2022 11:19:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220325111952epsmtrp2ae5f2fc8a3069457747eb754d514d48d~fm7WMgjbP1544315443epsmtrp27;
 Fri, 25 Mar 2022 11:19:52 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-e9-623da63d414c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 CB.F3.29871.855AD326; Fri, 25 Mar 2022 20:19:52 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220325111951epsmtip1ea66f81119ed1671fcd651c2d87c51c2~fm7VNrKb12421524215epsmtip1m;
 Fri, 25 Mar 2022 11:19:51 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, k.jensen@samsung.com,
 javier@javigon.com, j.granados@samsung.com
Subject: [PATCH] nvme: enable generic interface (/dev/ngX) for unknown
 command sets
Date: Fri, 25 Mar 2022 16:44:44 +0530
Message-Id: <20220325111444.5675-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmuq7dMtskgxNSFitXH2WyWLr/IaNF
 5+kLTBYnG/ewWkw6dI3RYv6yp+wObB7NC+6weGxa1cnmsXlJvcfumw1sHn1bVjEGsEZl22Sk
 JqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaCkUJaYUwoU
 CkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM44/+A2
 Y8ErgYr/t3pYGhjf8HYxcnJICJhITN+8jLWLkYtDSGA3o8Tf7mlMEM4nRolve+eyQzjfGCXW
 XvzICNMy6+xUFojEXkaJrdP3QzmfGSXuPgLJcHCwCWhKXJhcCtIgIqAo8XbCfRYQm1kgTeLB
 1cusILawQKjEkol/mUBsFgFViZaZz9hBbF4Bc4kdm2azQCyTl5h56TtUXFDi5MwnUHPkJZq3
 zmYG2SshcIxdYkXjYyaIBheJH8duMUPYwhKvjm9hh7ClJD6/28sGYSdLtG6/zA5yp4RAicSS
 BeoQYXuJi3tA7uEAmq8psX6XPkRYVmLqqXVMEGv5JHp/P4HaxCuxYx6MrShxb9JTVghbXOLh
 jCVQtofE1ZYtYLaQQKzEg8WvGCcwys9C8s0sJN/MQti8gJF5FaNkakFxbnpqsWmBYV5qOTxe
 k/NzNzGCk6GW5w7Guw8+6B1iZOJgPMQowcGsJMJ7/7J1khBvSmJlVWpRfnxRaU5q8SFGU2AQ
 T2SWEk3OB6bjvJJ4QxNLAxMzMzMTS2MzQyVx3tPpGxKFBNITS1KzU1MLUotg+pg4OKUamCbz
 sO3w5fvIpC9/u5h3cmDwY0auK36hCjbBb6+9NbUM5Z+bclBpGtv7mW3HAr+zCf55Y5Vd/uGn
 3bPnRbfeyd3YObGjarZtZ6PDtaIbFbVWBnUfMoW32WX+frfmWOCBRZOfO21yuySY0iEW0y5T
 /9vq7MYQ1XUzTgqs37+sqsXmrnANh2PigZj5R37pNDHcnn27NJFBVzVvSvrmqzn37v7UPuG2
 fuPblSu7z+25qyk9a/vkaSekYr8r/jVVspK4f26ugleykmTzmwt3Dq57a/g9+XhZ12u7uXMt
 WCP/fNcW658eqfCQ2WMx433jpOP5yRJPzrAGHNOwTNWPOz/hzcSi6qP2Jxz2v/XdPSnoPZMS
 S3FGoqEWc1FxIgAtlFPVDwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsWy7bCSnG7EUtskg/+31SxWrj7KZLF0/0NG
 i87TF5gsTjbuYbWYdOgao8X8ZU/ZHdg8mhfcYfHYtKqTzWPzknqP3Tcb2Dz6tqxiDGCN4rJJ
 Sc3JLEst0rdL4Mo4/+A2Y8ErgYr/t3pYGhjf8HYxcnJICJhIzDo7laWLkYtDSGA3o8TRG8uY
 IBLiEs3XfrBD2MISK/89Z4co+sgosfvfK7YuRg4ONgFNiQuTS0FMEQFlie5WRZByZoEsiaOr
 b4BVCAsES/z+7QsSZhFQlWiZ+QxsIq+AucSOTbNZIKbLS8y89B0qLihxcuYTFogx8hLNW2cz
 T2Dkm4UkNQtJagEj0ypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOCw1NLcwbh91Qe9
 Q4xMHIyHGCU4mJVEeO9ftk4S4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6Yklqdmpq
 QWoRTJaJg1OqgWnRj6bTUlOLcjgnib0775HQtmJnzfFeGfdI1wALycn+V6MZpiX1rvW6ccTd
 Wm7qLF62PKa9LkqPvZ6u+xTVv+XgaqllqWtzNl3y+5P+lqVr9RWTM5/ffHw3wTz3dNOT0zrK
 MY80H/y0WbCipdyqIuFylfr3R1yOxVX9K6Y1KSjMssq0Oh++/7Br1D8zZq4SHumzUXvm/wp4
 N7FRoMfxiepXuXjm2x/d3124t32Bx93lz03SDj5ge/U+5qV+E09V/NK68DX8IRvm63Dw3M13
 uVE6KygxoW+r2D5FmzPbTu8603g6duHZGZZ3Fs1lSMk91qorsTaQPXVD5g5Xo0vNac/e79vg
 lR5pdbC763cxz0slluKMREMt5qLiRABEKBaMugIAAA==
X-CMS-MailID: 20220325111952epcas5p4800055294fe473b923713d4b9c006026
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220325111952epcas5p4800055294fe473b923713d4b9c006026
References: <CGME20220325111952epcas5p4800055294fe473b923713d4b9c006026@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220325_042405_761454_021381A7 
X-CRM114-Status: GOOD (  17.93  )
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

block and char interface do not show up for any command set other than
NVM and ZNS.
Allow namespace setup to take place, and char interface to come up for
unknown command sets. Hide the block-interface for such command sets.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
This is prepared against linux-block/for-next.
On top of commit e529e21f317 ("Merge branch 'for-5.18/io_uring' into for-next")


 drivers/nvme/host/core.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 677fa4bf76d3..3e5d9a3f4167 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1875,7 +1875,7 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
 static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	unsigned lbaf = nvme_lbaf_index(id->flbas);
-	int ret;
+	int ret = 0;
 
 	blk_mq_freeze_queue(ns->disk->queue);
 	ns->lba_shift = id->lbaf[lbaf].ds;
@@ -1885,11 +1885,13 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	nvme_set_chunk_sectors(ns, id);
 	nvme_update_disk_info(ns->disk, ns, id);
 
-	if (ns->head->ids.csi == NVME_CSI_ZNS) {
+	if (ns->head->ids.csi == NVME_CSI_ZNS)
 		ret = nvme_update_zone_info(ns, lbaf);
-		if (ret)
-			goto out_unfreeze;
-	}
+	else if (ns->head->ids.csi != NVME_CSI_NVM)
+		/* suppress block-interface for unknown command-sets */
+		ret = -ENODEV;
+	if (ret)
+		goto out_unfreeze;
 
 	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
@@ -4098,6 +4100,14 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	default:
 		dev_warn(ctrl->device, "unknown csi %u for nsid %u\n",
 			ids.csi, nsid);
+		if (!nvme_multi_css(ctrl)) {
+			dev_warn(ctrl->device,
+				"command set not reported for nsid: %d\n",
+				nsid);
+			break;
+		}
+		/* required to enable char-interface for unknown command sets*/
+		nvme_alloc_ns(ctrl, nsid, &ids);
 		break;
 	}
 }
-- 
2.25.1


