Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABA7C433E9
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8988D64EB9
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8988D64EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CIY9ph5M/HEBlBvbkSQplMn26/4oTPWAnEpAo3xXSUI=; b=IBs7Dz+ErUfFbsABN6F8Oqhob
	MKFr7AnM+3h5QagCuNvl2cDMx3pLxmgBRlTzYHQ4IKm1sL7J6X+eycZg3lp3HiPvEIdSPC86Zpzo4
	+yMd54FHCObw0CL1p3IK966yYKt/Juk1NFUZVbixrLXgaiF69mM2ZQyI9GLGzTo9dMqyWyW0WZ22j
	KPnYbwU0DnOE97jhuyZ/URf8wt2NA7G3TuoGjZxqgH5qGcWYYcgKrqf0zHqi3vpBkvlb1Kw0B+LI5
	w6Tc5h9i8d1R0ZQk3o7HQlPjur2W/jY9IPyJDAuw8uFEFm84us2jEcn/+HaBCtts+pGD4A5d7CB7I
	Nn9dJAYWg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9KKa-0002tJ-CY; Tue, 09 Feb 2021 04:08:52 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9KKW-0002rR-0Z
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 04:08:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612843728; x=1644379728;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OHHyLTRE4hsRU94Eksd7zCOQ/1YLVrWr6NGuO4WflNk=;
 b=KyUiJ6EVhgNWEyR4vjXmRqhDoSIS6gXAZFL9Ax6qyvtNOfBZY6IfLYz3
 zfGXJD4vHPE7NbS61q/7HR264y3VujW/IF9am/fbPMiJw3OW6YD/4sx7J
 VQq+R6ACH11rcnxsVlOFL6lCr72VdZPLTCwspL/0nKW++mQfgXz0tygYz
 RrmGfsLf2ALlp+gFwLrmyl7Ckisxjhzcn0JmVcwjM9j2/hC8sQ2/KiBoh
 7HAPXMxlh4MfaAlCBJwgxWthgjaL/yShkr89i+aSjkqKG57qplcKvoY16
 Pa9vJJp1pxBnA1YSAJUJACNnqYM3I3k1UDcKqlPprWfqICQbProoEtJVC A==;
IronPort-SDR: JbftaoQsC6CGAGGVikwtwJ1z03UoyvFtiNX/JwGYFpg6srswZKNCFx5wwP8SMtbBmCU7RGebd0
 PX2iDy+4pFw7W/SG7swb+G2fX+ZLqPcGaw2EtSdS0EaC/LpU9LL3ZL8YxiM4qrOgu39ZT4lD1E
 xUdtGBTIMSXLTScn8NjYSHM58WrVblKB2iMzxYNTB7PhHCV54fYpoJrgkKqCyKAI8CkgUIzTAd
 k/PNkQqwNtlLMfHwYggGGZeo8JpYJEwRFh7gLRmF3jd+q37WDgQST0X4IGhtkwZUMI3tKwoOCX
 aXw=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; d="scan'208";a="269970513"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 12:08:46 +0800
IronPort-SDR: sW+xOLUjSH3r7olnxAWT8J6Il8I3VeMoOA0SZD8VhND3bxk0Gcj4eDKUktMtzvh7WZxsNipbR6
 rbi1ZVXTWwt0DygrlmrWEDllJPGqCW/DibWmvYTUd/ECPd2RuyTj7L6MHX3BrQJPbf4NQT+ThO
 e03PBzPZvElyZI69kiOkWMEFXozcDLraTVdZNPG842D1CjAH7uJ/jjJOGBeqQ3+R5cG68l9zzn
 xQfacas4SRhpajKJFbt03rzLqJADzrPvp20PQNQlhy+cuY96H9DUC+EkA5O7Yw3CUCaoBoIEoZ
 0hjIReEic4Meuxu4E6EGGEHv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 19:50:40 -0800
IronPort-SDR: sO+0InWur/kSN6aWv8Yx+lTdsV2hcRM6vEUQSrRRq6VIGh+dpSodVMjcIH1HFzyHBc708DXNPZ
 kBSIjAChSE1IaJ3CZB8cL3Y/MM8uQW9tK6HZESXynbZGMxNKZgda+dD5pqOz2pktpxBvtjz/4l
 L5ihlgt0csZLqPQWew2V6UHQDHtTqEd4qamP2f7qxjO41JpWDN0G2oN/Nc9o2+NALrxY5g6TdX
 oJq7z6sUZY3T5a5tu24Xv4OqQObXgO49cE/phA6WoJX/QpgMD/0+Dp89DoEpGrUHthrCtXKjrW
 PA0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2021 20:08:47 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 01/11] nvmet: zeroout id-ns buffer for invalid nsid
Date: Mon,  8 Feb 2021 20:08:33 -0800
Message-Id: <20210209040843.45572-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
References: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_230848_238840_803E3299 
X-CRM114-Status: GOOD (  14.13  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

According to spec :-
"5.15.2.7 Identify Namespace data structure for an Allocated Namespace
ID (CNS 11h) The Identify Namespace data structure (refer to Figure 245)
is returned to the host for the namespace specified in the Namespace
Identifier (NSID) field if it is an allocated NSID. If the specified
namespace is an unallocated NSID then the controller returns a zero
filled data structure."

Call nvmet_zero_sgl() when call to nvmet_find_namespace() fails and add
an explicit comment to specify the reason for zeroing the buffer which
is not common for the NVMe commands.

Fixes: bffcd507780e ("nvmet: set right status on error in id-ns handler")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 613a4d8feac1..fa9a83541d51 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -482,10 +482,16 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto out;
 	}
 
-	/* return an all zeroed buffer if we can't find an active namespace */
 	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
 	if (!req->ns) {
 		status = NVME_SC_INVALID_NS;
+		/*
+		 * According to spec : If the specified namespace is
+		 * an unallocated NSID then the controller returns a zero filled
+		 * data structure. Also don't override the error status as invalid
+		 * namespace takes priority over the failed zeroout buffer case.
+		 */
+		nvmet_zero_sgl(req, 0, sizeof(*id));
 		goto done;
 	}
 
@@ -539,10 +545,11 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	if (req->ns->readonly)
 		id->nsattr |= (1 << 0);
-done:
+
 	if (!status)
 		status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
+done:
 	kfree(id);
 out:
 	nvmet_req_complete(req, status);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
