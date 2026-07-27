Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C799FC531D0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b8F07ymoocI+qWAMeBAQcpSypFK4H0a20Rdmn02FcP8=; b=Mg9Ikg5c91MuwSLl8yUhYfDBFv
	5dXCBZr5TVa0Znl1k57OQ74Bj+yx13Q7Yi6rQRdzCasYlLP5vG8D604bvBZ6WdS9Q6HdouWNDMhRR
	0N1p9LCw43AswNRKCVr82EZipQO81GcIpxZIJUexjkcdqQMBizFQdW7MmW62R76ijJUN5NTBbqj59
	5m4m7z5QjqE3enPmV6DiFAf6pHSSbTtDJDUZp2iPXblEexxjM7omJjL1uVfpo974vdZlLA1QmeYIY
	PoLw0rbKgJ0ArKEEpvnRgenzyDx2YbONpFyheuUTgTxo6EBUj3jS2gqu4xTM0DkpGqtJPjDzNB/xs
	04/8nWqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woMEC-00000002yMu-21pl;
	Mon, 27 Jul 2026 14:22:48 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woME9-00000002yLB-27Xd
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 14:22:47 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260727142237epoutp0190d3c0d0c840aee0028272cf2c091612~GK4YkdDQG0345403454epoutp01L
	for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2026 14:22:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260727142237epoutp0190d3c0d0c840aee0028272cf2c091612~GK4YkdDQG0345403454epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785162157;
	bh=b8F07ymoocI+qWAMeBAQcpSypFK4H0a20Rdmn02FcP8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=o2isC41PGVBb1O4Csf8A0Sm3i9+GC2P7vP4CvpxvgxREBSV11B3LTxXj0Hb8XjtJm
	 8fc6tPPT9BfimPVU4hrAycMMuTTaMSkxDdnbXxhMprt16kuq/DArd4NCSL+dIGRb3T
	 i0qcJ2mQMH+VV1liyFKubFd3P/FdzeYSfklDXy/o=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260727142236epcas5p47fb8932b075d5dcf61960de049dc90c7~GK4YI8_tt2938729387epcas5p4l;
	Mon, 27 Jul 2026 14:22:36 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.94]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4h815S0794z2SSKX; Mon, 27 Jul
	2026 14:22:36 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260727142235epcas5p408bbcf060c0cf642a83989f7be981226~GK4W2bTHA2940129401epcas5p4Y;
	Mon, 27 Jul 2026 14:22:35 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260727142234epsmtip1f67808e39267d27064a4d9d3dd25dfaa~GK4VfbfOX2334323343epsmtip1C;
	Mon, 27 Jul 2026 14:22:33 +0000 (GMT)
Message-ID: <96dadac7-a072-48ba-b282-356d29ed789a@samsung.com>
Date: Mon, 27 Jul 2026 19:52:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: fix racy access to FDP placement ID array
From: Kanchan Joshi <joshi.k@samsung.com>
To: Hari Mishal <harimishal1@gmail.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
In-Reply-To: <7c3e3243-0c9a-436b-b5c2-e6092e181435@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260727142235epcas5p408bbcf060c0cf642a83989f7be981226
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260725135125epcas5p26801513d440f066295ef2d44035ce3db
References: <20260725135111.14041-1-harimishal1@gmail.com>
	<CGME20260725135125epcas5p26801513d440f066295ef2d44035ce3db@epcas5p2.samsung.com>
	<20260725135111.14041-2-harimishal1@gmail.com>
	<7c3e3243-0c9a-436b-b5c2-e6092e181435@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_072245_868467_EE84185C 
X-CRM114-Status: GOOD (  24.85  )
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

Hari,

Can you please try this patch and see if this solves what you saw?

  drivers/nvme/host/core.c | 38 +++++++++++++++++---------------------
  drivers/nvme/host/nvme.h |  1 +
  2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..09cb22f6509c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2320,14 +2320,6 @@ static int nvme_query_fdp_info(struct nvme_ns 
*ns, struct nvme_ns_info *info)
         size_t size;
         int i, ret;

-       /*
-        * The FDP configuration is static for the lifetime of the 
namespace,
-        * so return immediately if we've already registered this 
namespace's
-        * streams.
-        */
-       if (head->nr_plids)
-               return 0;
-
         ret = nvme_get_features(ctrl, NVME_FEAT_FDP, info->endgid, NULL, 0,
                                 &fdp);
         if (ret) {
@@ -2374,6 +2366,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, 
struct nvme_ns_info *info)

         for (i = 0; i < head->nr_plids; i++)
                 head->plids[i] = le16_to_cpu(ruhs->ruhsd[i].pid);
+       head->write_stream_granularity = min(info->runs, U32_MAX);
  free:
         kfree(ruhs);
         return ret;
@@ -2421,12 +2414,6 @@ static int nvme_update_ns_info_block(struct 
nvme_ns *ns,
                         goto out;
         }

-       if (ns->ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
-               ret = nvme_query_fdp_info(ns, info);
-               if (ret < 0)
-                       goto out;
-       }
-
         if (nvme_invalid_lba_sz(le64_to_cpu(id->nsze),
                         id->lbaf[lbaf].ds - SECTOR_SHIFT, &capacity)) {
                 dev_warn_once(ns->ctrl->device,
@@ -2469,10 +2456,7 @@ static int nvme_update_ns_info_block(struct 
nvme_ns *ns,
                 capacity = 0;

         lim.max_write_streams = ns->head->nr_plids;
-       if (lim.max_write_streams)
-               lim.write_stream_granularity = min(info->runs, U32_MAX);
-       else
-               lim.write_stream_granularity = 0;
+       lim.write_stream_granularity = ns->head->write_stream_granularity;

         /*
          * Only set the DEAC bit if the device guarantees that reads from
@@ -3964,9 +3948,10 @@ static void nvme_add_ns_cdev(struct nvme_ns *ns)
         set_bit(NVME_NS_CDEV_LIVE, &ns->flags);
  }

-static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
+static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ns *ns,
                 struct nvme_ns_info *info)
  {
+       struct nvme_ctrl *ctrl = ns->ctrl;
         struct nvme_ns_head *head;
         size_t size = sizeof(*head);
         int ret = -ENOMEM;
@@ -4002,15 +3987,26 @@ static struct nvme_ns_head 
*nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
         } else
                 head->effects = ctrl->effects;

+       if (ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
+               ns->head = head;
+               ret = nvme_query_fdp_info(ns, info);
+               if (ret < 0)
+                       goto out_clear_ns_head;
+       }
+
         ret = nvme_mpath_alloc_disk(ctrl, head);
         if (ret)
-               goto out_cleanup_srcu;
+               goto out_cleanup_fdp;

         list_add_tail(&head->entry, &ctrl->subsys->nsheads);

         kref_get(&ctrl->subsys->ref);

         return head;
+out_cleanup_fdp:
+       kfree(head->plids);
+out_clear_ns_head:
+       ns->head = NULL;
  out_cleanup_srcu:
         cleanup_srcu_struct(&head->srcu);
  out_ida_remove:
@@ -4103,7 +4099,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, 
struct nvme_ns_info *info)
                                 info->nsid);
                         goto out_unlock;
                 }
-               head = nvme_alloc_ns_head(ctrl, info);
+               head = nvme_alloc_ns_head(ns, info);
                 if (IS_ERR(head)) {
                         ret = PTR_ERR(head);
                         goto out_unlock;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824651cc898d..3ae73b36866d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -560,6 +560,7 @@ struct nvme_ns_head {

         u16                     nr_plids;
         u16                     *plids;
+       u32                     write_stream_granularity;
  #ifdef CONFIG_NVME_MULTIPATH
         struct bio_list         requeue_list;
         spinlock_t              requeue_lock;
--
2.25.1


