Return-Path: <SRS0=WUqE=4B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F4C352A3
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 19:51:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771E12086A
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 19:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WTKNSWha";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCiUv1cE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771E12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SRpc8ZQlwOZgv9/YAI1SIaXJgC2FylSxOA7+kQHQGBE=; b=WTKNSWha4mrDUK
	+KDMT5/X5c8M+LVoskqLiC7V5i4zTGiIr5iFX8X6q5gbL3iDCD4D5PJzV+3B6vgDfLSxAFSsx4vA1
	hKnoVa7cSqivmskFzs/6H2EChUrC/ekHLqsK/EF24wJxeKDpMMrMlPkbwDipNO1F4LP1NZAEwM9Bs
	Z5XSN42WzLEqi0UpYPvRIWEYqlRBB98qU/GYkJDyxvoFG7dz8PsLxECmxfd22jXkq5MalRO31R385
	lzVrWlw4AABuSgq4B00EGPcgH4PBenEC5BDFYrCX6hCHY6wiyAaWOGoBtM8yk1+DzmCYxa250JPHH
	K8ZSWYJsbDiKfG34WXlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2KW5-00063Q-NJ; Thu, 13 Feb 2020 19:51:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2KW3-00062s-5z
 for linux-nvme@lists.infradead.org; Thu, 13 Feb 2020 19:51:16 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A1489206DB;
 Thu, 13 Feb 2020 19:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581623474;
 bh=Xqbq2haBuZFkDYjZmsV4yATrit/Qz2AEyZkfCyM1khw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iCiUv1cEhk9VwBol7PtJap7ex5wIeg5ldTR+g0vDrDf4ZXUVibPHJxmw8z0OsPtP4
 3sDi51kklI4zP5HGQ5GjBfBHOb/TbuhsXDlniCFor44vp8ZUureEQ/Ir07YM2O7TyV
 sSG00Eyn9qbz3BCSD2kSR7827Jm6gkeT/WqVN19E=
Date: Fri, 14 Feb 2020 04:51:06 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] nvme: fix uninitialized-variable warning
Message-ID: <20200213195106.GA8256@redsun51.ssa.fujisawa.hgst.com>
References: <20200107214215.935781-1-arnd@arndb.de>
 <20200130150451.GA25427@infradead.org>
 <CAK8P3a0EgfQkrSr77jE12Wm_NKemEZ1rFZLMcVhkAuu1cwOOWQ@mail.gmail.com>
 <20200130154815.GA2463@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200130154815.GA2463@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200213_115115_244774_7F76D146 
X-CRM114-Status: GOOD (  16.34  )
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
Cc: Oleksandr Natalenko <oleksandr@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>, Arnd Bergmann <arnd@arndb.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Marta Rybczynska <mrybczyn@kalray.eu>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 30, 2020 at 07:48:15AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 30, 2020 at 04:36:48PM +0100, Arnd Bergmann wrote:
> > > This one is just gross.  I think we'll need to find some other fix
> > > that doesn't obsfucate the code as much.
> > 
> > Initializing the nvme_result in nvme_features() would do it, as would
> > setting it in the error path in __nvme_submit_sync_cmd() -- either
> > way the compiler cannot be confused about whether it is initialized
> > later on.
> 
> Given that this is outside the hot path we can just zero the whole
> structure before submitting the I/O.

I think this should be okay:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7f05deada7f4..4aeed750dab2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1165,8 +1165,8 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl,
 static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 		unsigned int dword11, void *buffer, size_t buflen, u32 *result)
 {
+	union nvme_result res = { 0 };
 	struct nvme_command c;
-	union nvme_result res;
 	int ret;
 
 	memset(&c, 0, sizeof(c));
--

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
