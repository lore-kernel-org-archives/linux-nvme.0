Return-Path: <SRS0=ymBk=4T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10683C3F2D2
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 07:33:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC83A2468E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 07:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dv9DGXwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC83A2468E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f70HUN4mRdIwXBwJ9vCqa+56v2Xt/wjY4IwxGvgGXWc=; b=Dv9DGXwA0O7dgq
	PdjnZ2gDH7XYRHG8wmG9kfHShfMjKPYgAgYercAvQcCVINKQHcPDKm0+inTGPVE68ts/EQabSVHs/
	pANsDnoyl4R5rhdq00rJrx50SFBiP7bI697/vw4uZkzOm711CvmylMpFl9HCekMM/7GSIQXvpHOfo
	u6XDsLF9VuH6e+EhSF0gVboxPqi/iDYYlSR2Z7uVgnEWaB6hQPeBUbftWOig/1rjjBOfqfv2KP1sI
	UJadHHnir6sgTLfDhA9SdtPc5eHA74JOmgASd+thAvRz2I7rnDGEt1xwlqYZK8B5VG3HI+wSTB7T8
	rb+DhRVjp8we/4NtUphg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8fZi-0006MF-Ju; Mon, 02 Mar 2020 07:33:14 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8fZf-0006LH-3X
 for linux-nvme@lists.infradead.org; Mon, 02 Mar 2020 07:33:13 +0000
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 0227WgY0012818;
 Sun, 1 Mar 2020 23:32:42 -0800
Date: Mon, 2 Mar 2020 13:02:41 +0530
From: Krishnamraju Eraparaju <krishna2@chelsio.com>
To: Max Gurtovoy <maxg@mellanox.com>, sagi@grimberg.me
Subject: Re: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs
 to match hosts pgs len
Message-ID: <20200302073240.GA14097@chelsio.com>
References: <20200226141318.28519-1-krishna2@chelsio.com>
 <b7a7abdc-574a-4ce9-ccf0-a51532f1ac58@grimberg.me>
 <20200227154220.GA3153@chelsio.com>
 <aeff528c-13ed-2d6a-d843-697035e75d6c@grimberg.me>
 <7a8670c0-64bc-7d7b-1c7a-feb807ed926a@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7a8670c0-64bc-7d7b-1c7a-feb807ed926a@mellanox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200301_233311_164166_C1A7AA90 
X-CRM114-Status: GOOD (  18.60  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
 bharat@chelsio.com, nirranjan@chelsio.com, linux-nvme@lists.infradead.org,
 jgg@ziepe.ca, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi & Max Gurtovoy,

Thanks for your pointers regarding mdts.

Looks like fixing this issue through mdts is more natural than fixing
through RDMA private data.

Issue is not occuring after appling the below patch(inspired by Max's
patch "nvmet-rdma: Implement set_mdts controller op").

So any consensus about merging the fix upstream, to fix this specific
issue?

diff --git a/drivers/nvme/target/admin-cmd.c
b/drivers/nvme/target/admin-cmd.c
index 56c21b50..0d468ab 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -346,8 +346,12 @@ static void nvmet_execute_identify_ctrl(struct
nvmet_req *req)
        /* we support multiple ports, multiples hosts and ANA: */
        id->cmic = (1 << 0) | (1 << 1) | (1 << 3);

-       /* no limit on data transfer sizes for now */
-       id->mdts = 0;
+       /* Limit MDTS according to transport capability */
+       if (ctrl->ops->set_mdts)
+               id->mdts = ctrl->ops->set_mdts(ctrl);
+       else
+               id->mdts = 0;
+
        id->cntlid = cpu_to_le16(ctrl->cntlid);
        id->ver = cpu_to_le32(ctrl->subsys->ver);

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e..851f8ed 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -279,6 +279,7 @@ struct nvmet_fabrics_ops {
                        struct nvmet_port *port, char *traddr);
        u16 (*install_queue)(struct nvmet_sq *nvme_sq);
        void (*discovery_chg)(struct nvmet_port *port);
+       u8 (*set_mdts)(struct nvmet_ctrl *ctrl);
 };

 #define NVMET_MAX_INLINE_BIOVEC        8
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 37d262a..62363be 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1602,6 +1602,17 @@ static void nvmet_rdma_disc_port_addr(struct
nvmet_req *req,
        }
 }

+static u8 nvmet_rdma_set_mdts(struct nvmet_ctrl *ctrl)
+{
+       struct nvmet_port *port = ctrl->port;
+       struct rdma_cm_id *cm_id = port->priv;
+       u32 max_pages;
+
+       max_pages = cm_id->device->attrs.max_fast_reg_page_list_len;
+       /* Assume mpsmin == device_page_size == 4KB */
+       return ilog2(max_pages);
+}
+
 static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
        .owner                  = THIS_MODULE,
        .type                   = NVMF_TRTYPE_RDMA,
@@ -1612,6 +1623,7 @@ static void nvmet_rdma_disc_port_addr(struct
nvmet_req *req,
        .queue_response         = nvmet_rdma_queue_response,
        .delete_ctrl            = nvmet_rdma_delete_ctrl,
        .disc_traddr            = nvmet_rdma_disc_port_addr,
+       .set_mdts               = nvmet_rdma_set_mdts,
 };

 static void nvmet_rdma_remove_one(struct ib_device *ib_device, void
*client_data)


Thanks,
Krishna.

On Sunday, March 03/01/20, 2020 at 16:05:53 +0200, Max Gurtovoy wrote:
> 
> On 2/28/2020 1:14 AM, Sagi Grimberg wrote:
> >
> >>>The patch doesn't say if this is an actual bug you are seeing or
> >>>theoretical.
> >>
> >>I've noticed this issue while running the below fio command:
> >>fio --rw=randwrite --name=random --norandommap --ioengine=libaio
> >>--size=16m --group_reporting --exitall --fsync_on_close=1 --invalidate=1
> >>--direct=1 --filename=/dev/nvme2n1 --iodepth=32 --numjobs=16
> >>--unit_base=1 --bs=4m --kb_base=1000
> >>
> >>Note: here NVMe Host is on SIW & Target is on iw_cxgb4 and the
> >>max_pages_per_mr supported by SIW and iw_cxgb4 are 255 and 128
> >>respectively.
> >
> >This needs to be documented in the change log.
> >
> >>>>The proposed patch enables host to advertise the max_fr_pages(via
> >>>>nvme_rdma_cm_req) such that target can allocate that many number of
> >>>>RW ctxs(if host's max_fr_pages is higher than target's).
> >>>
> >>>As mentioned by Jason, this s a non-compatible change, if you want to
> >>>introduce this you need to go through the standard and update the
> >>>cm private_data layout (would mean that the fmt needs to increment as
> >>>well to be backward compatible).
> >>
> >>Sure, will initiate a discussion at NVMe TWG about CM
> >>private_data format.
> >>Will update the response soon.
> >>>
> >>>
> >>>As a stop-gap, nvmet needs to limit the controller mdts to how much
> >>>it can allocate based on the HCA capabilities
> >>>(max_fast_reg_page_list_len).
> >
> >Sounds good, please look at capping mdts in the mean time.
> 
> guys, see my patches from adding MD support.
> 
> I'm setting mdts per ctrl there.
> 
> we can merge it meantime for this issue.
> 
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
