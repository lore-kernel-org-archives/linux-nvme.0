Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884E0C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jun 2022 19:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mCXUyp9b0GmA8u2OLbGkD8z7KAc76pVIasvJ7EG3zc8=; b=LL+xgiKTccyLhMBleIl3szRXBD
	9O00bydj9W2M5PU1XGJhtFrQj76pn8wd/YXhq6KBqv7gF6FWYVEsT5pzHO7oBu5KyzrMGY8Iro8MA
	s1vPcNwiEQoHJu7rBHpJ0r0HkjcFojuvNM4aQSIJt4rSeo1I+KTfjvaC91cckhMq97uu8qvSbo135
	QA57w17EIOoMH/IqrShsuZoX6lHsOEJkPd6GT8N48UwKMMdIHho4PQdYMHTpq7twqojoDn3GMZQvY
	ui9onA4K9C928ziIZkb4Q40ZZjlKjyDi5ZHAqdURV6XOVvErMn89G1d6PjuLS3+baAysSQ6iKtDAG
	FlxOyzKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6GeA-007n0q-Fp; Tue, 28 Jun 2022 19:13:14 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6Ge0-007mtZ-S2
	for linux-nvme@lists.infradead.org; Tue, 28 Jun 2022 19:13:08 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220628191257euoutp0107b4240a010b804027911ef9fec1d42b~83qg-Fu6q1875918759euoutp01h
	for <linux-nvme@lists.infradead.org>; Tue, 28 Jun 2022 19:12:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220628191257euoutp0107b4240a010b804027911ef9fec1d42b~83qg-Fu6q1875918759euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1656443577;
	bh=mCXUyp9b0GmA8u2OLbGkD8z7KAc76pVIasvJ7EG3zc8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=MYpmTmBvf6aHLQWtom2D4TNxdxpOge0Nw4LxCHw5gsnqOUrQGj0JA9WnAOZtsIzZ+
	 XLi3hMxxZLMNEyvfQP4gSoWaEOBKYQik5abyAwxtxH4ySo4IqYsNYwk8CiMNewM4vm
	 hzC8G5KarvvHEJHDN9ItzT10CUJRS4pb3/jfSDlw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220628191256eucas1p10c8c329d5d3ab9e7fd4aaabbf627420c~83qg0okW_1297212972eucas1p1U;
	Tue, 28 Jun 2022 19:12:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 4C.68.09664.8B25BB26; Tue, 28
	Jun 2022 20:12:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220628191256eucas1p2c667b40cac36183c45e45fdb6cfe5b03~83qf88UGy0862108621eucas1p2c;
	Tue, 28 Jun 2022 19:12:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220628191256eusmtrp1ae97eca03a580480c537a44c8d33b782~83qf8WpEV2062620626eusmtrp1e;
	Tue, 28 Jun 2022 19:12:56 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-85-62bb52b8eadb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 5D.6F.09038.7B25BB26; Tue, 28
	Jun 2022 20:12:55 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220628191255eusmtip2d89570c2a8dc2be20adef90d9814509e~83qf09yd21650616506eusmtip2T;
	Tue, 28 Jun 2022 19:12:55 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 28 Jun 2022 20:12:55 +0100
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>
CC: <joshi.k@samsung.com>, <k.jensen@samsung.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>
Subject: [PATCH v4 1/2] nvme-multipath: refactor nvme_mpath_add_disk
Date: Tue, 28 Jun 2022 21:10:15 +0200
Message-ID: <20220628191016.291935-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220628191016.291935-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7djP87o7gnYnGUxbaWmxcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAliiuGxSUnMyy1KL9O0SuDJ6Jl1i
	L3gjVtGy6zB7A+Mx4S5GTg4JAROJKVfWsHQxcnEICaxglHi69jyU84VRYurGk1DOZ0aJJev2
	ssC0/D7whBUisZxRYuPDKYxwVdO2b4XKbGaU2L1nHjNIC5uAjsT5N3fAbBEBS4neD7fAbGaB
	XInN23awgtjCAi4S39c/ZgSxWQRUJXYv3s0OYvMK2Ejc2rSIHWK1vETb9elgNZwCthL3tzxm
	g6gRlDg58wkLxEx5ieats6HmS0gcfPGCGaJXUWLLnO+sEHatxN7mA+wgh0oInOGQ6F2zFOo3
	F4lFbb+glglLvDq+BcqWkTg9uQeqJlti55RdUEMLJGadnAp0BAeQbS3RdyYHIuwosfLUK0aI
	MJ/EjbeCEOfwSUzaNp0ZIswr0dEmNIFRZRaSB2YheWAWkgcWMDKvYhRPLS3OTU8tNsxLLdcr
	TswtLs1L10vOz93ECEwjp/8d/7SDce6rj3qHGJk4GA8xSnAwK4nwLjyzM0mINyWxsiq1KD++
	qDQntfgQozQHi5I4b3LmhkQhgfTEktTs1NSC1CKYLBMHp1QDE8e8C59bZAV8Le3m1LsyXJ6w
	TLN72ZojbyZnnFmem8Mn4M1QdZHvSVT892k9TCYh/3UYlA6f+xVX8NM3KKrGW9brrL3Pg5Uu
	GyUUj5g8/mibcyTpQZfV5xOvZL54MW5OyV8fvf/IpUebN63P31f88ViUR8bpz9+n339Yvfbj
	9jebVHvFr7OKRqSdK+S4zX/DaZJhj86BEys7nr210pFieH/ZlHVK0W5Z011pX4MvGl7tyey4
	/qyRoWAT16/YfNOOkrvWzWukbaOXTFK6rpoZv1L7+cMtW4RuufVsP7mATepjD1vPs6Kko1+Z
	5TWCzs080JLzKerGTDanNHHhl0lxhec885/ZZxe9XhDEMjG1QImlOCPRUIu5qDgRAOJlOfGS
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7rbg3YnGfQ+t7FYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRejZF+aUlqQoZ+cUltkrRhhZG
	eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehk9ky6xF7wRq2jZdZi9gfGYcBcjJ4eE
	gInE7wNPWLsYuTiEBJYySlyeu5wZIiEj8enKR3YIW1jiz7UuNoiij4wSUzqvMoEkhAQ2M0pc
	exoKYrMJ6Eicf3MHrFlEwFKi98MtMJtZIFdi87YdrCC2sICLxPf1jxlBbBYBVYndi3eDLeAV
	sJG4tWkR1DJ5ibbr08FqOAVsJe5vecwGsctGYtnmG0wQ9YISJ2c+YYGYLy/RvHU21C4JiYMv
	XkA9oCixZc53Vgi7VqLz1Wm2CYwis5C0z0LSPgtJ+wJG5lWMIqmlxbnpucVGesWJucWleel6
	yfm5mxiBUbbt2M8tOxhXvvqod4iRiYPxEKMEB7OSCO/CMzuThHhTEiurUovy44tKc1KLDzGa
	Av05kVlKNDkfGOd5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1M
	tfs2TlzanlfrfibV1mySEf/uksgNP+1nlXYbH5gU/uVKzF/NusATpedXP/iRsGFi0zX20hkS
	9UzVZ7s5Hy7O28b+7vA/UYsctXUsmYrHJuUparrsWcA95UBozpEdtpluzYn19glpWou5zDxb
	p0S6Xv7w/1O1zMqdcyJ5bL/M6/K9emeej9TGJ9LZr8S+9348uPuIqMfdeTeMI/J2XuP0PZte
	vLvXm12Ua7rZevemlF0J255fTf1j/Pjw33Xd+1xqJynyzuYT8G19Yae1POqM99HdxxImXnc8
	UyLzcVJq6fugRTs+7nm3nf/aLOf3ExOLf2Y9f7H0TKHnMq+Jkq+u39qoqbEsT8fF3W+r+/7/
	HEosxRmJhlrMRcWJAHZOLe07AwAA
X-CMS-MailID: 20220628191256eucas1p2c667b40cac36183c45e45fdb6cfe5b03
X-Msg-Generator: CA
X-RootMTR: 20220628191256eucas1p2c667b40cac36183c45e45fdb6cfe5b03
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220628191256eucas1p2c667b40cac36183c45e45fdb6cfe5b03
References: <20220628191016.291935-1-j.granados@samsung.com>
	<CGME20220628191256eucas1p2c667b40cac36183c45e45fdb6cfe5b03@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_121305_380616_8F786115 
X-CRM114-Status: GOOD (  15.28  )
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


