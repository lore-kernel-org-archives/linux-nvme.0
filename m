Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECE7C61DA3
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Feb 2023 17:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kZFBTTpVl/a2D7Yh/ErEJmW83TcnjuBw59MF6K/8k8k=; b=q07Rt2bxpJrwrGfMIPf3Kc1XeH
	bpsFS/qHMyH73fEsz3qqQKfUV9iVK7+rc3cQK+gFhzkZECu6mde+ZuOcL8rMMWVh6uklI7UOKqqS3
	aIT8e54Yhr7xCEAq1TwP7eNrVDRHS2ytkDwJv690btV8jNRUidKEvYPKZNHyys+pgSQKuw6lVotvU
	zWxp5NcyIre6D6qzjgfuxARSIgx96nz7BszjEoSWpCywKIYRnT/5rWQV9TQjXCFxkrFyI6AJD8psQ
	hCbyXAZcWqmf4JUetWE4ZUBcyWcJzA5ialaYlE+vde9uo0Gp92a9wdqz0GcZjlCI2LKgE8ftfj5Km
	RUFynapg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUWnA-009ENe-Qf; Tue, 21 Feb 2023 17:51:04 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUWn9-009EMn-9x; Tue, 21 Feb 2023 17:51:03 +0000
Date: Tue, 21 Feb 2023 09:51:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Nils Hanke <nh@edgeless.systems>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"nils.hanke@outlook.com" <nils.hanke@outlook.com>
Subject: Re: nvme_scan_ns does not remove stale namespaces anymore since
 kernel 6.0
Message-ID: <Y/UEh+lh5RT+1uAP@infradead.org>
References: <CE04FCB1-DE80-404A-823E-5B164EDC2A50@edgeless.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE04FCB1-DE80-404A-823E-5B164EDC2A50@edgeless.systems>
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

Hi Nils,

can you try this patch?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8b64211411626b..fec247d379cc24 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4418,6 +4418,7 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_info info = { .nsid = nsid };
 	struct nvme_ns *ns;
+	int ret;
 
 	if (nvme_identify_ns_descs(ctrl, &info))
 		return;
@@ -4434,12 +4435,15 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	 * set up a namespace.  If not fall back to the legacy version.
 	 */
 	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
-	    (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS)) {
-		if (nvme_ns_info_from_id_cs_indep(ctrl, &info))
-			return;
-	} else {
-		if (nvme_ns_info_from_identify(ctrl, &info))
-			return;
+	    (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS))
+		ret = nvme_ns_info_from_id_cs_indep(ctrl, &info);
+	else
+		ret = nvme_ns_info_from_identify(ctrl, &info);
+
+	if (ret) {
+		if (ret > 0 && (ret & NVME_SC_DNR))
+			nvme_ns_remove_by_nsid(ctrl, nsid);
+		return;
 	}
 
 	/*

