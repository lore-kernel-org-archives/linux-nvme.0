Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B5CC3F2CD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 09:59:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C23208CD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 09:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V6WLfWST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C23208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/9J0VDFW6PCKLCy18rNZK+Qe4Oio6dmKFJmh12EpI7Y=; b=V6WLfWSTCj7I59
	7BnDQD5xgeisrBIls+YNtH3Bjy+WNzzZzKfhQyEFjbBJZhWSOdfyTRkJAyTBxjEbnHf42TnxGze9q
	XUijtzG6z0kLRmXSL4/dUKRQsgxTvxsmX0nzu+9vXg+4OySaAJcX5PEiYctc23zP3DBRhJeZVBQOC
	7JaEcTEj3picP2UtJ9TqVOs8uk9bLDX/d/Jvne3p0PBpjb14QbfI/o61wI2Sk6ubJCC0DeglKJdUs
	D7jgbauxgoiHG7uyO8qtrONr5W9dEQYqbL30NzRZK5a/HEhegdMpjnCaLlzir5wPz8KZLs/ipzF/x
	imKlUPHGHmT4oGzr5VLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9nHT-0002Pt-4H; Thu, 05 Mar 2020 09:59:03 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9nHP-0002OA-ND
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 09:59:01 +0000
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 0259wq31023375;
 Thu, 5 Mar 2020 01:58:53 -0800
Date: Thu, 5 Mar 2020 15:28:52 +0530
From: Krishnamraju Eraparaju <krishna2@chelsio.com>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 3/3] nvmet-rdma: allocate RW ctxs according to mdts
Message-ID: <20200305095847.GA12902@chelsio.com>
References: <20200304153935.101063-1-maxg@mellanox.com>
 <20200304153935.101063-3-maxg@mellanox.com>
 <20200304191848.GA30485@chelsio.com>
 <5bef57b6-aade-f074-c1e1-71a1cd93acce@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5bef57b6-aade-f074-c1e1-71a1cd93acce@mellanox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_015859_767736_2A46C6CF 
X-CRM114-Status: GOOD (  28.88  )
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
Cc: sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, bharat@chelsio.com,
 nirranjan@chelsio.com, linux-nvme@lists.infradead.org, jgg@mellanox.com,
 kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thursday, March 03/05/20, 2020 at 00:19:01 +0200, Max Gurtovoy wrote:
> 
> On 3/4/2020 9:18 PM, Krishnamraju Eraparaju wrote:
> >Hi Max Gurtovoy,
> >
> >I just tested this patch series, the issue is not occuring with these
> >patches.
> >
> >Have couple of questons:
> >- Say both host & target has max_fr_pages size of 128 pages, then
> >the number of MRs allocated at target will be twice the size of
> >send_queue_size, as NVMET_RDMA_MAX_MDTS is set to 256 pages.
> >
> >so, in this case, as host can never request an IO of size greater
> >than 128 pages, half of the MRs allocated at target will always
> >left unused.
> >
> >If this is true, will this be a concern in future when
> >NVMET_RDMA_MAX_MDTS limit is increased, but max_fr_pages
> >size of few devices remained at 128 pages?
> 
> for this I suggested a configfs entry so a user would be able to
> configure the target mdts as a QoS and/or to save resources.
> 
> Currently this suggestion is not accepted but let's re-think about
> it in the future (I think adding some configfs entries for saving
> resources such as q_depth, mdts, num_queues, etc might be helpful
> for some users).
> 
> On the other hand, I didn't limit the mdts even for devices with
> small amount of max_fr_pages in the target side so it will be able
> to work with host the can send "big" IOs (with multiple MRs in the
> target side).
> 
> I think this is the right approach - better support capable devices
> and sometimes allocate more than required from host.
> 
> The target acts as a subsystem controller and expose it's mdts,
> exactly as the pci ctrl expose it. Sometimes it's bigger than the
> max_io_size we actually need and it's fine :)
> 
> >
> >
> >- Also, will just passing the optimal mdts(derived based on
> >max_fr_pages) to host during ctrl identification fixes this issue
> >properly(instead of increasing the max_rdma_ctxs with factor)? I think
> >the target doesn't require multiple MRs in this case as host's blk
> >max_segments got tuned with target's mdts.
> >
> >Please correct me if I'm wrong.
> 
> Linux host max_io_size is also set to 1MB (if the device is capable
> for it) so you actually won't be needing multiple MRs per IO.
> 
> I don't know what's optimal_mdts since some users would like to send
> 1MB IOs and not split it to 4 requests of 256KB in the host side.
> 
> And since we use RW api we always need the factor because it might
> be limited by the API one day (today the limit is 256 pages in RW
> api).
> 
> From your question, I understand that your device can support upto
> 512K IOs but I think it will be good idea not to limit hosts that
> use other devices with target that uses your devices.

Thanks for the clarification!

Tested-by: Krishnamraju Eraparaju <krishna2@chelsio.com>

> 
> >
> >Thanks,
> >Krishna.
> >On Wednesday, March 03/04/20, 2020 at 17:39:35 +0200, Max Gurtovoy wrote:
> >>Current nvmet-rdma code allocates MR pool budget based on queue size,
> >>assuming both host and target use the same "max_pages_per_mr" count.
> >>After limiting the mdts value for RDMA controllers, we know the factor
> >>of maximum MR's per IO operation. Thus, make sure MR pool will be
> >>sufficient for the required IO depth and IO size.
> >>
> >>That is, say host's SQ size is 100, then the MR pool budget allocated
> >>currently at target will also be 100 MRs. But 100 IO WRITE Requests
> >>with 256 sg_count(IO size above 1MB) require 200 MRs when target's
> >>"max_pages_per_mr" is 128.
> >>
> >>Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> >>Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> >>---
> >>  drivers/nvme/target/rdma.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> >>index 5ba76d2..a6c9d11 100644
> >>--- a/drivers/nvme/target/rdma.c
> >>+++ b/drivers/nvme/target/rdma.c
> >>@@ -976,7 +976,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
> >>  {
> >>  	struct ib_qp_init_attr qp_attr;
> >>  	struct nvmet_rdma_device *ndev = queue->dev;
> >>-	int comp_vector, nr_cqe, ret, i;
> >>+	int comp_vector, nr_cqe, ret, i, factor;
> >>  	/*
> >>  	 * Spread the io queues across completion vectors,
> >>@@ -1009,7 +1009,9 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
> >>  	qp_attr.qp_type = IB_QPT_RC;
> >>  	/* +1 for drain */
> >>  	qp_attr.cap.max_send_wr = queue->send_queue_size + 1;
> >>-	qp_attr.cap.max_rdma_ctxs = queue->send_queue_size;
> >>+	factor = rdma_rw_mr_factor(ndev->device, queue->cm_id->port_num,
> >>+				   1 << NVMET_RDMA_MAX_MDTS);
> >>+	qp_attr.cap.max_rdma_ctxs = queue->send_queue_size * factor;
> >>  	qp_attr.cap.max_send_sge = max(ndev->device->attrs.max_sge_rd,
> >>  					ndev->device->attrs.max_send_sge);
> >>-- 
> >>1.8.3.1
> >>
> >_______________________________________________
> >linux-nvme mailing list
> >linux-nvme@lists.infradead.org
> >https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&amp;data=02%7C01%7Cmaxg%40mellanox.com%7C9d945a2bb54543630a1e08d7c070ee88%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C637189463598411223&amp;sdata=xBgbsudv9jqJ0mSOYW37zLFvRbxSQ2cyzyFmWCVMSVQ%3D&amp;reserved=0

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
