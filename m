Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABD7C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 17:53:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F7464DD9
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 17:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F7464DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Rg3JaDXZ3JhILse0TCaanUg3uQ/qrXhRBHJxv73tmnk=; b=zsAf4x21O0hnF9bLcPmNfOp5c
	E2SwrbhxEgA+j1SyayBpiHqBa+ugFnd2eBq0WuVzC7poXYmuAHlXbI9QuINxbQJzz7fwgAlC7fUDm
	W2/txoi5Pr5cfGSYY0zCTR3S0eMgU7qTwbGFOv7tnJILXRE00UULG1OKZHWc6RMIaaibDcvZ2V9xI
	oXmXlNPZVI0F2L8/ag3DKTIvlFxN6ZBtpPAFIJVHAsyFN7qL7G4jPWmf/f4WszLgz1XSxsUO4kn8n
	Z1foCSjdANSfyOhxCzQxVhKoWPU+ByLdpVVuWYIOEcdfm4GVNg7Oxjq4ULk7kjAV6pmVCENg8vBlx
	uLeq8Eaug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6dNw-0000y2-B5; Mon, 01 Feb 2021 17:53:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6dNu-0000xj-Hh
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 17:53:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 038E464DD9;
 Mon,  1 Feb 2021 17:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612201989;
 bh=5Kmn85S3980j5PND9fwvcfhBPuHPl6sQaS80xXcJLr4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PBPYC8i/eDI4uygkY2cNyfXaT4LO9pQxujYIs1E5pSD/EOWgePbdzaNdDqnX0qSyT
 76j+gjMj/zMXjU5iQDtVJPZuxeo82HzURjeVBYXs+F/uEZaA1D9HVe2VRe3Y3Ap6SJ
 /wK1JCsObdT8xPTewN/IYcrBjdyknFNaMSJQKtRq2z3LuJ3TtjwGD4uyZQ5EqMDcPh
 P1KKBws440x4IzMVp2RW4fdwixJuJ9+jz5+b6byG35oSmpYF0iSkER1uyq6NOxCCSo
 TAvc4Xwjb9n23cZZ5DsaNRBxVmxaWwQX6rGK9JdsgknfmbYtIDlg9xyfDRy6N2gaFF
 kdrwtOf89tmTA==
Date: Mon, 1 Feb 2021 09:53:06 -0800
From: Keith Busch <kbusch@kernel.org>
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Subject: Re: Buffer I/O Errors from Zoned NVME devices
Message-ID: <20210201175306.GA2127465@dhcp-10-100-145-180.wdc.com>
References: <BYAPR04MB56561E48A54530BC7F6DCF30EAB69@BYAPR04MB5656.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB56561E48A54530BC7F6DCF30EAB69@BYAPR04MB5656.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_125310_678389_2845CFB9 
X-CRM114-Status: GOOD (  13.81  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 01, 2021 at 02:36:12PM +0000, Jeffrey Lien wrote:
> Christoph, Keith
> We're seeing a lot of these Buffer I/O errors with our zoned nvme devices.  One of the FW developers looked into it and had the following explanation:
> All these Reads are from the kernel during enumeration and for LBAs that are in last zone's hole hence expected to return boundary error which is getting logged by kernel.
> 
> [65281.936988] Buffer I/O error on dev nvme1n2, logical block 3800039296, async page read
> [65281.937165] blk_update_request: I/O error, dev nvme1n2, sector 3800039297 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [65281.937166] Buffer I/O error on dev nvme1n2, logical block 3800039297, async page read
> [65281.937335] blk_update_request: I/O error, dev nvme1n2, sector 3800039298 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [65281.937336] Buffer I/O error on dev nvme1n2, logical block 3800039298, async page read
> [65281.937498] blk_update_request: I/O error, dev nvme1n2, sector 3800039299 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> 
> Are you aware of this issue and if so, do you have any recommendations on how to avoid or resolve?  

Is this from the partition scanning? We don't partition zoned devices,
so I think we can skip it. Does the following resolve the issue?

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a3cdc6b1036..fafd02ab3a46 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3925,6 +3925,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		}
 	}
 
+	if (blk_queue_is_zoned(ns->queue))
+		disk->flags |= GENHD_FL_NO_PART_SCAN;
+
 	down_write(&ctrl->namespaces_rwsem);
 	list_add_tail(&ns->list, &ctrl->namespaces);
 	up_write(&ctrl->namespaces_rwsem);
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
