Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F048ECCA481
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 13:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mCXUyp9b0GmA8u2OLbGkD8z7KAc76pVIasvJ7EG3zc8=; b=QEQFQI3GeG3wuOQGcpfqIxLEVk
	FV3m6TnBJXIS2kADLM3LqK1kWq0oZHCYfNdhWVAs2YCHxWinEnWyhAp+TlbjoR3mizfVReQuYiud6
	Jy5oq0qT1OY7cC/+hJLJbqgH5xrf1h+9HuN5blJhk+cb+SuVbG5Zy8xTONCnshIa/TQ/HathuH8bI
	bBwK+NA6Dh/um74gUn4xyG+mP9Oh18rFfoBbd7vYGfSky7hRYOPFin29MC9+hl4bODGJHJXZ2tiO+
	kypbIaqmy2B6r2HVhUyDL/CF0de2amR9j/YSRaglgEXOM93q0rYegdAIQSkP1rywuwqSjlYZpwEBi
	eCyZOdog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o40sq-00Akgm-SP; Wed, 22 Jun 2022 13:59:04 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o40sf-00AkcI-Im
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 13:58:58 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220622135843euoutp01409abcce930c77b0b967f15caf7dfccf~69gcx2Ab62215322153euoutp01-
	for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 13:58:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220622135843euoutp01409abcce930c77b0b967f15caf7dfccf~69gcx2Ab62215322153euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655906323;
	bh=mCXUyp9b0GmA8u2OLbGkD8z7KAc76pVIasvJ7EG3zc8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=sle2pzthsYBe2soTuy78X3HqPanvG7YLMB+kbkX+JDkzAdwz8EA6AlUG0GuJDGeCb
	 3Bl9ZtuITxIea4k/W3BhUXe5aXc3cGuma2cSBJqHK0nY3w01FMzLuD9BQNx3eVXAmM
	 Fou7hMNTZKzVc/xVgnvSkG4HMplZeAyrRVnhWXq4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220622135843eucas1p289be824bfdff00310edfe5bd4d90261c~69gcor3i91880318803eucas1p23;
	Wed, 22 Jun 2022 13:58:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 4A.17.10067.31023B26; Wed, 22
	Jun 2022 14:58:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220622135843eucas1p232aacf6f5cbe956cd450936ece4f74b7~69gcXJjh91878518785eucas1p2-;
	Wed, 22 Jun 2022 13:58:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220622135843eusmtrp14e8672b65a5b89bf5a6b4b29882f0a95~69gcWXfaz2589025890eusmtrp1C;
	Wed, 22 Jun 2022 13:58:43 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-88-62b320138cce
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 2F.7C.09095.31023B26; Wed, 22
	Jun 2022 14:58:43 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220622135843eusmtip271746533189a8759d5fb30796aca23ea~69gcPH1I03062830628eusmtip2H;
	Wed, 22 Jun 2022 13:58:43 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 22 Jun 2022 14:58:42 +0100
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <joshi.k@samsung.com>,
	<gost.dev@samsung.com>, <k.jensen@samsung.com>
Subject: [PATCH v3 1/2] nvme-multipath: refactor nvme_mpath_add_disk
Date: Wed, 22 Jun 2022 15:55:55 +0200
Message-ID: <20220622135556.2185991-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220622135556.2185991-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djP87rCCpuTDHpfKVmsXH2UyWLSoWuM
	FvOXPWV3YPbYtKqTzWPzknqP3Tcb2AKYo7hsUlJzMstSi/TtErgyeiZdYi94I1bRsuswewPj
	MeEuRk4OCQETiRcfPrF3MXJxCAmsYJTont3AAuF8YZQ4fOoZG4TzmVHiZMNUVpiWFTvboBLL
	GSUezbjBDFfVcWY7E4SzmVFi95dGJpAWNgEdifNv7gBVcXCICKhK7GuxBQkzC+RKNM57wwxi
	Cwu4SJx79J0dxGYBKln55irYNl4BW4kTnc+ZIDbLS7Rdn84IYnMK2Ek82LWLCaJGUOLkzCcs
	EDPlJZq3zmaGsCUkDr54wQzRqyixZc53qA9qJfY2H2CHsA9wSFy+IA1ymgTQDf1HHCDCwhKv
	jm+BKpGROD25hwXCzpbYOWUX1MgCiVknp7JBtFpL9J3JgQg7SrQtuMYCEeaTuPFWEOIYPolJ
	26YzQ4R5JTrahCYwqsxCcv4sJOfPQnL+AkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmb
	GIHJ4vS/4192MC5/9VHvECMTB+MhRgkOZiURXhvuDUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
	eZMzNyQKCaQnlqRmp6YWpBbBZJk4OKUamOxTeHYVXL6bvrFz18TvzHxTNB1ivt+eod42V/q+
	9QNZ+RczQk4Z1gk0nbu57t1ymzcBhhs8f6hNSvITfldXXhT2mv2l2L2T/6cozn0f3mj2fet3
	vyVFP59/fc1lnjR9TqdU9G2+h7zXTqjuNJpYs2muw+HZTmH+Z7atDukMMvw5ce8BedM17Xt1
	H7n8Fg22vxZodS/sEF/TzjfM7pNXZz//+v3Zki/LjhqdYArrKQz6aC0f3hax693ezR7/Xn94
	45P+lvGzzORvzErsZq99nm3wlqiOMfmSUduSauVp8WG6DctRmQvzJ8/kZjg5r9RCf7qMc+5/
	q1s76qQVV2h88Dmm7sOn4R/SpXNXV3vGbx8lluKMREMt5qLiRAAxyeB5hQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7rCCpuTDM6sErBYufook8WkQ9cY
	LeYve8ruwOyxaVUnm8fmJfUeu282sAUwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
	m8daGZkq6dvZpKTmZJalFunbJehl9Ey6xF7wRqyiZddh9gbGY8JdjJwcEgImEit2trF1MXJx
	CAksZZT43rmKHSIhI/HpykcoW1jiz7UuqKKPjBJvGttYQBJCApsZJU5fLQax2QR0JM6/ucPc
	xcjBISKgKrGvxRYkzCyQK9E47w0ziC0s4CJx7tF3sJksQCUr31xlBbF5BWwlTnQ+Z4LYJS/R
	dn06I4jNKWAn8WDXLiaIVbYSjfs3sUPUC0qcnPmEBWK+vETz1tnMELaExMEXL5gh5ihKbJnz
	nRXCrpXofHWabQKjyCwk7bOQtM9C0r6AkXkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYDxt
	O/Zz8w7Gea8+6h1iZOJgPMQowcGsJMJrw70hSYg3JbGyKrUoP76oNCe1+BCjKdCfE5mlRJPz
	gRGdVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAdHiB3H5rTtU1
	SVvYzf8drwnhXd0smhglxd7FvUA58dXN6Fb2H+sufJluY7Nv2yk9LsH3O207l0XI3Fu1z4dp
	5pHr85h2P76oIpu7aeYSR77+8t8v2Fh/ukwXLjYzZjnwrU/+1Rr1SIvplbnGMlPTA8xXbTkf
	yF0ktsnDML/xNFtlM4t0ccir9+6Prr3wXdxSKPHg2ZObOYrX7ou93n/RODh2cu1JthAlxUtv
	Q/Yab7nL56NSeMRsbqDMoqkLNixfs/Efi/W05OcxDs6ZsuE2K03UlcOq4/7+Fd5vlsplsu/H
	G3ehBdf+fO073LGuNfmVgpc9+2lDq2g9AZlX256ErKgGmrs29ID/te8v5+oqsRRnJBpqMRcV
	JwIASXuvDjADAAA=
X-CMS-MailID: 20220622135843eucas1p232aacf6f5cbe956cd450936ece4f74b7
X-Msg-Generator: CA
X-RootMTR: 20220622135843eucas1p232aacf6f5cbe956cd450936ece4f74b7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220622135843eucas1p232aacf6f5cbe956cd450936ece4f74b7
References: <20220622135556.2185991-1-j.granados@samsung.com>
	<CGME20220622135843eucas1p232aacf6f5cbe956cd450936ece4f74b7@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_065854_307272_7161DF3A 
X-CRM114-Status: GOOD (  15.45  )
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

Pass anagrpid as second argument. This is prep patch that allows reusing
this function for supporting unknown command sets.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c      | 2 +-
 drivers/nvme/host/multipath.c | 6 +++---
 drivers/nvme/host/nvme.h      | 5 ++---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 57480075550c..0fd6127da8d1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4024,7 +4024,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
-	nvme_mpath_add_disk(ns, id);
+	nvme_mpath_add_disk(ns, id->anagrpid);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
 	kfree(id);
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d3e2440d8abb..94dba4eab4fb 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -800,16 +800,16 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 	return -ENXIO; /* just break out of the loop */
 }
 
-void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
+void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 {
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
 		struct nvme_ana_group_desc desc = {
-			.grpid = id->anagrpid,
+			.grpid = anagrpid,
 			.state = 0,
 		};
 
 		mutex_lock(&ns->ctrl->ana_lock);
-		ns->ana_grpid = le32_to_cpu(id->anagrpid);
+		ns->ana_grpid = le32_to_cpu(anagrpid);
 		nvme_parse_ana_log(ns->ctrl, &desc, nvme_lookup_ana_group_desc);
 		mutex_unlock(&ns->ctrl->ana_lock);
 		if (desc.state) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e4612dd0b420..5dac319f9b7c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -836,7 +836,7 @@ void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
-void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
+void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
 void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
@@ -878,8 +878,7 @@ static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
 {
 	return 0;
 }
-static inline void nvme_mpath_add_disk(struct nvme_ns *ns,
-		struct nvme_id_ns *id)
+static inline void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 {
 }
 static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
-- 
2.30.2


