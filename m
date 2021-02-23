Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF93C433E6
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 20:48:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CAE64E2E
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 20:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CAE64E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zEtHqQuHHlPKkmNgRqV+HaOSfvGAPW+z7cZUczw2uwA=; b=cum0TQqHouGOjm+mUspVXzpmE
	Ho3fkHkMEym7pzuoWejHR3YFlGEamEgjovrqfpBVwy9GPKvgLEbS+T18fp3zXITVoP+lZy2yuHm1h
	EelTKwlliTrHyX3f0wNlRXVrSnftAHS3eVuVivAqSSfnF+SLlnnC5EIR++FkQqHSAI6lKXRMhdB5s
	MhfDDRzyrsOREcJbr1NC/9K8WPR8AXF7pvm2bq5wXLcCwiX10YliB08u4eGeji0NmB5IS3ZWhM/uW
	F0nFEaV5IuS0V26h3Z3Nh03kDPnohw7H8Z2HaO5sPcgkMdl2n0FZjpJH9OG0JODvrgLkpwpxUiC92
	vQG1HAr1w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEeb4-0004Yu-Kb; Tue, 23 Feb 2021 20:47:54 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEeb2-0004YD-E4
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 20:47:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614113272; x=1645649272;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tLZ0GwXfhN5cwwbyM64lBHjE3oRMtZ/bOeRZymifU1c=;
 b=dbeBNFG4cA4kKYwz4iHJqX/J7gF9xWvLcEBWhwAjzLpmEPUI25nBYi3D
 oNmkoVcTwXmNovU96eAR6IQY4B0PyUeNk8P425JDwsVgc4boBJX3kL6tn
 JCVOxhadMU+3blC5VQYXJyywlw4YyksXElUWhqDLTXRAMt6MKI9feIPkt
 skrxydZfXQp9DwLdr3wHtVd0UzslVImh9y4WnvCoQ4N1oKYCUdGxybf2q
 kARAKN+W7jZlzO+iZOdkEW8bTvOynv8luGxwtK65XJzGdP31vqPAzmOVa
 0jPPw8tYisu2zte2U2ZtEMt1/f/XdT1+G0+24PBT1eDhUm1MUeQBXZgQ6 w==;
IronPort-SDR: NVWLEZ8us2Od+b+jJwC6xWJzJeSa+5tm9W95knMwKA5bhPrZKVaO4/P1Ejrp+iv30vD37DsK4D
 cxmHwMGqlA+OY3WKA7mYOK+VB/BaOul+eQsXYLpKnnYxprAgmPkXq76R0UDAO1OxiZf47V/2Tb
 l4HdSh7PKLp/yKNko8zD4HkforRVHq6FgojVOTv5utkPkMo6EVkp+dMtLlFm4W+OG00xuYKzQr
 VDry3rvqQCkWYTCisUm6WCEc13YTpCo7pQ8sdlHSKh2plXo01sBwawfImt5lP+2kXvPyZyvP8W
 vcU=
X-IronPort-AV: E=Sophos;i="5.81,200,1610380800"; d="scan'208";a="160615751"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2021 04:47:50 +0800
IronPort-SDR: hm+CbS5ER0qTPIRmrVMk72r41tZxrlBrFqZyFc77dq7OijaAaYe8Bkh/Wdx+eO/qZhuNCYUdqc
 mW0q9GcBxTR/O7Mnyr4giyYpGwJIjQ0cGkbLyWv+lUfGwZkiJTttroZpOBc7GQu7cnC149peay
 gWR3BKJatYqB8twDsV5DH7aVvbwbm55kqz9ZCv0qDcPJoforQ0E5vKO+mltowGntBADGox6YgO
 6MQGJId7go2w/1UqqnbDrNJJa6euOX3AgEo2mBDVQbyf7DSgQ+mSeOSeDfuep97eBztdtlN13A
 nI+HcOUh7zn5rHB7NYzv6sjM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2021 12:29:18 -0800
IronPort-SDR: TOhMx6PIz1XM3h8xdaji2d+DX07BhlJD1WPZgxRIdPxeXEH3wW8iGqmXaLnhylzrzWpH86bZw4
 CcxJiInFhnKmsFjjdXIaZzXz4ZyMPEgOeK0nKLnbNfePd5XbaXUmQiL0L5G/CNMYvVM5Rq4tZv
 h9q5cV4qdTuJMP1XG6S4N7APy6narJq4gku6T3Ze4dBKrVCO+DKa4TMrclMJVqZlK/dU/hK7Ux
 Q/4QS8IVKe99oYE0vALJfhcejn9Ii8mhTO+1o4vo9CmOpuf++n74vK42/p8vMk80l31gfdxD0K
 ORw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Feb 2021 12:47:52 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/2] nvme-pci; remove the barriers nvme_irq()
Date: Tue, 23 Feb 2021 12:47:40 -0800
Message-Id: <20210223204741.38301-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210223204741.38301-1-chaitanya.kulkarni@wdc.com>
References: <20210223204741.38301-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_154752_646719_1EE7A568 
X-CRM114-Status: GOOD (  12.28  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 axboe@fb.com, kbusch@kernel.org, hch@lst.de,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The barriers were added to the nvme_irq() in the
commit 3a7afd8ee42a ("nvme-pci: remove the CQ lock for interrupt driven queues")
to prevent compiler from doing memory optimization for the variabes that
were protected previously by spinlock in nvme_irq() at completion queue
processing and with queue head check condition..

The variable nvmeq->last_cq_head from those checks was removed in the
commit f6c4d97b0d82 ("nvme/pci: Remove last_cq_head") that was not
allwing poll queues from mistakenly triggering the spurious interrupt
detection.

Remove the barriers which were protecting the updates to the variables.

Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/nvme/host/pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0045c5edf629..3729775f6a8a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1062,14 +1062,8 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	struct nvme_queue *nvmeq = data;
 	irqreturn_t ret = IRQ_NONE;
 
-	/*
-	 * The rmb/wmb pair ensures we see all updates from a previous run of
-	 * the irq handler, even if that was on another CPU.
-	 */
-	rmb();
 	if (nvme_process_cq(nvmeq))
 		ret = IRQ_HANDLED;
-	wmb();
 
 	return ret;
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
