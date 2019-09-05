Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192F1C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 18:02:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110792070C
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 18:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YtkCTDI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110792070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8SNmHBGrI9RoRiJLDSqUZk/nfTx3LAAc88xF3mtUs2o=; b=YtkCTDI9FYX6GD
	ay+1gZ4jn15fy2fobCY85Vgv2ppqE3D96dCWq/8HADVR5/zRb0V1D1n0JmQRAi4ZBM3WM0vybcRBN
	k20C8A5rVAIT55FJptBml52yaHRC70jM2nVdlzJQKe5EOHJuF8fPOcsEjssxayRaElMPzbGwyS662
	ncOwMBGvcy9ZVdYvUcjYFRgKx5/aT2Tn/562NexBn6fD5WU0vcisVTTwKsWS5v5FN6DzYtc5xrv+4
	9vd492kZOBEw9IRLbEHeCtu9sTmeTl1KjoQImhLBFPtZ7KkgpY30qRu1hgwXg7cwS7QR13s7VxWRS
	Auupwcs9YXtIn6Nsz0Jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5w5r-0002Qf-48; Thu, 05 Sep 2019 18:02:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5w5o-0002QH-6F
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 18:02:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1770068B05; Thu,  5 Sep 2019 20:02:44 +0200 (CEST)
Date: Thu, 5 Sep 2019 20:02:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v3 1/3] block: centralize PI remapping logic to the
 block layer
Message-ID: <20190905180243.GB24146@lst.de>
References: <1567701836-29725-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1567701836-29725-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_110248_530809_9BD699E4 
X-CRM114-Status: GOOD (  19.15  )
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
Cc: axboe@kernel.dk, keith.busch@intel.com, sagi@grimberg.me,
 martin.petersen@oracle.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 shlomin@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 05, 2019 at 07:43:54PM +0300, Max Gurtovoy wrote:
> Currently dif_prepare/dif_complete functions are called during the
> NVMe and SCSi layers command preparetion/completion, but their actual
> place should be the block layer since T10-PI is a general data integrity
> feature that is used by block storage protocols.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
> 
> changes from v2:
>  - remove local variable for protection_type
>  - remove remapping between NVMe T10 definition to blk definition
>  - added patches 2/3 and 3/3
>  - remove pi_type from ns structure
> 
> changes from v1:
>  - seperate from nvme_cleanup command patches
>  - introduce blk_integrity_interval_shift to avoid div in fast path
> 
> ---
>  block/blk-core.c         |  5 +++++
>  block/blk-mq.c           |  4 ++++
>  block/blk-settings.c     |  1 +
>  block/t10-pi.c           | 16 ++++++----------
>  drivers/nvme/host/core.c | 27 ++++++++++-----------------
>  drivers/nvme/host/nvme.h |  1 -
>  drivers/scsi/sd.c        | 28 ++++++++++------------------
>  drivers/scsi/sd.h        |  1 -
>  drivers/scsi/sd_dif.c    |  2 +-
>  include/linux/blkdev.h   | 12 ++++++++++++
>  include/linux/genhd.h    |  1 +
>  include/linux/t10-pi.h   | 10 ++++------
>  12 files changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d0cc6e1..eda33f9 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -34,6 +34,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/blk-cgroup.h>
> +#include <linux/t10-pi.h>
>  #include <linux/debugfs.h>
>  #include <linux/bpf.h>
>  
> @@ -1405,6 +1406,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
>  	if (!req->bio)
>  		return false;
>  
> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
> +	    error == BLK_STS_OK)
> +		t10_pi_complete(req, nr_bytes);
> +
>  	if (unlikely(error && !blk_rq_is_passthrough(req) &&
>  		     !(req->rq_flags & RQF_QUIET)))
>  		print_req_error(req, error, __func__);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0835f4d..30ec078 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -30,6 +30,7 @@
>  #include <trace/events/block.h>
>  
>  #include <linux/blk-mq.h>
> +#include <linux/t10-pi.h>
>  #include "blk.h"
>  #include "blk-mq.h"
>  #include "blk-mq-debugfs.h"
> @@ -693,6 +694,9 @@ void blk_mq_start_request(struct request *rq)
>  		 */
>  		rq->nr_phys_segments++;
>  	}
> +
> +	if (blk_integrity_rq(rq) && req_op(rq) == REQ_OP_WRITE)
> +		t10_pi_prepare(rq);
>  }
>  EXPORT_SYMBOL(blk_mq_start_request);
>  
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 2c18312..8183ffc 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -330,6 +330,7 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
>  void blk_queue_logical_block_size(struct request_queue *q, unsigned short size)
>  {
>  	q->limits.logical_block_size = size;
> +	q->limits.logical_block_shift = ilog2(size);
>  
>  	if (q->limits.physical_block_size < size)
>  		q->limits.physical_block_size = size;
> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index 0c00946..7d9a151 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -171,7 +171,6 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
>  /**
>   * t10_pi_prepare - prepare PI prior submitting request to device
>   * @rq:              request with PI that should be prepared
> - * @protection_type: PI type (Type 1/Type 2/Type 3)
>   *
>   * For Type 1/Type 2, the virtual start sector is the one that was
>   * originally submitted by the block layer for the ref_tag usage. Due to
> @@ -181,13 +180,13 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
>   *
>   * Type 3 does not have a reference tag so no remapping is required.
>   */
> -void t10_pi_prepare(struct request *rq, u8 protection_type)
> +void t10_pi_prepare(struct request *rq)
>  {
>  	const int tuple_sz = rq->q->integrity.tuple_size;
>  	u32 ref_tag = t10_pi_ref_tag(rq);
>  	struct bio *bio;
>  
> -	if (protection_type == T10_PI_TYPE3_PROTECTION)
> +	if (rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
>  		return;
>  
>  	__rq_for_each_bio(bio, rq) {
> @@ -222,13 +221,11 @@ void t10_pi_prepare(struct request *rq, u8 protection_type)
>  		bip->bip_flags |= BIP_MAPPED_INTEGRITY;
>  	}
>  }
> -EXPORT_SYMBOL(t10_pi_prepare);
>  
>  /**
>   * t10_pi_complete - prepare PI prior returning request to the block layer
>   * @rq:              request with PI that should be prepared
> - * @protection_type: PI type (Type 1/Type 2/Type 3)
> - * @intervals:       total elements to prepare
> + * @nr_bytes:        total bytes to prepare
>   *
>   * For Type 1/Type 2, the virtual start sector is the one that was
>   * originally submitted by the block layer for the ref_tag usage. Due to
> @@ -239,14 +236,14 @@ void t10_pi_prepare(struct request *rq, u8 protection_type)
>   *
>   * Type 3 does not have a reference tag so no remapping is required.
>   */
> -void t10_pi_complete(struct request *rq, u8 protection_type,
> -		     unsigned int intervals)
> +void t10_pi_complete(struct request *rq, unsigned int nr_bytes)
>  {
> +	unsigned int intervals = nr_bytes >> blk_integrity_interval_shift(rq->q);

This adds a > 80 line.  Just dropping the redundant int will fix that.

>  	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
>  	/* the PI implementation requires metadata equal t10 pi tuple size */
>  	if (ns->ms == sizeof(struct t10_pi_tuple))
> -		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
> +		disk->protection_type = id->dps & NVME_NS_DPS_PI_MASK;
>  	else
> -		ns->pi_type = 0;
> +		disk->protection_type = 0;
>  
>  	if (ns->noiob)
>  		nvme_set_chunk_size(ns);
>  	nvme_update_disk_info(disk, ns, id);
>  #ifdef CONFIG_NVME_MULTIPATH
>  	if (ns->head->disk) {
> +		ns->head->disk->protection_type = disk->protection_type;
>  		nvme_update_disk_info(ns->head->disk, ns, id);

I'd just move the protection_type assignment into nvme_update_disk_info
instead.

>  #ifdef CONFIG_BLK_DEV_INTEGRITY
> -extern void t10_pi_prepare(struct request *rq, u8 protection_type);
> -extern void t10_pi_complete(struct request *rq, u8 protection_type,
> -			    unsigned int intervals);
> +extern void t10_pi_prepare(struct request *rq);
> +extern void t10_pi_complete(struct request *rq, unsigned int intervals);

This might be a chance to drop the redundant externs.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
