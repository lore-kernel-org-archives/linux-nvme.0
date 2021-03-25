Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28B0C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 06:50:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E5561A12
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 06:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E5561A12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zYuijmaLe7QTzAqHlsqaWSi1ONw/xP685GR+OyBxEKU=; b=OQgCj/agXrNLV0TUSOw2WZs5t
	8s2sOaqKMY8FPQKEqM2kU/gpDYAvzSKhnw6MbMoeuOADrBWz6VSqThi6gS8ep58bXsndDJoQqeemO
	Ez1hzbH1IatrSBxUiSKnnzsHx4tdYmb15gGDvkxXm63+vnEMj8ENn4JCC5kaRPm1hplqZdTza5hAE
	C0v1hf3xTbtflyEg6z3ZeTClFuMkDVn0FYgWkumv+Lir8DsJ3wSEJFfa/GpjYwwCw/7iryPiKmiyN
	dhTpSFIR8H0l4wm4RBA2Gvx8nXb2Q4qDXzf/VhBC592qUthCClRnCitBHClttw0pWmXtDFqihzxrc
	SgaqOpVhw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPJpE-000gvM-VW; Thu, 25 Mar 2021 06:50:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPJp9-000guq-SR
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 06:50:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5F7BC68B05; Thu, 25 Mar 2021 07:50:28 +0100 (CET)
Date: Thu, 25 Mar 2021 07:50:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv3] nvme: implement non-mdts command limits
Message-ID: <20210325065028.GA25678@lst.de>
References: <20210324231805.1232062-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210324231805.1232062-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_065032_167372_D42E9BAD 
X-CRM114-Status: GOOD (  36.45  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 24, 2021 at 04:18:05PM -0700, Keith Busch wrote:
> Commands that access LBA contents without a data transfer between the
> host historically have not had a spec defined upper limit. The driver
> set the queue constraints for such commands to the max data transfer
> size just to be safe, but this artificial constraint frequently limits
> devices below their capabilities.
> 
> The NVMe Workgroup ratified TP4040 defines how a controller may
> advertise their non-MDTS limits. Use these if provided and default to
> the current constraints if not. Since the Dataset Management command
> limits are defined in logical blocks, but without a namespace to tell us
> the logical block size, the code defaults to the safe 512b size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v2->v3:
> 
>   Remove the nvm_config_write_zeroes helper (hch)
> 
>   For clarity, don't use inverted oncs logic (hch)
> 
>   Replace nvme revision check with nvme_ctrl_limited_cns (hch)
> 
>   Rebased patch for nvme-5.13: the previous version was based on a local
>   conflict-resolved 5.12+5.13 branch, so that version wouldn't have
>   successfully applied to either upstream branch.
> 
>  drivers/nvme/host/core.c | 107 ++++++++++++++++++++++++++-------------
>  drivers/nvme/host/nvme.h |   3 ++
>  include/linux/nvme.h     |  10 ++++
>  3 files changed, 86 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 40215a0246e4e..15ee470c1b8c6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1936,7 +1936,7 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>  	struct request_queue *queue = disk->queue;
>  	u32 size = queue_logical_block_size(queue);
>  
> -	if (!(ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
> +	if (ctrl->max_discard_sectors == 0) {
>  		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, queue);
>  		return;
>  	}
> @@ -1954,39 +1954,13 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>  	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
>  		return;
>  
> -	blk_queue_max_discard_sectors(queue, UINT_MAX);
> -	blk_queue_max_discard_segments(queue, NVME_DSM_MAX_RANGES);
> +	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
> +	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
>  
>  	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
>  		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
>  }
>  
> -static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
> -{
> -	u64 max_blocks;
> -
> -	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
> -	    (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
> -		return;
> -	/*
> -	 * Even though NVMe spec explicitly states that MDTS is not
> -	 * applicable to the write-zeroes:- "The restriction does not apply to
> -	 * commands that do not transfer data between the host and the
> -	 * controller (e.g., Write Uncorrectable ro Write Zeroes command).".
> -	 * In order to be more cautious use controller's max_hw_sectors value
> -	 * to configure the maximum sectors for the write-zeroes which is
> -	 * configured based on the controller's MDTS field in the
> -	 * nvme_init_ctrl_finish() if available.
> -	 */
> -	if (ns->ctrl->max_hw_sectors == UINT_MAX)
> -		max_blocks = (u64)USHRT_MAX + 1;
> -	else
> -		max_blocks = ns->ctrl->max_hw_sectors + 1;
> -
> -	blk_queue_max_write_zeroes_sectors(disk->queue,
> -					   nvme_lba_to_sect(ns, max_blocks));
> -}
> -
>  static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
>  {
>  	return !uuid_is_null(&ids->uuid) ||
> @@ -2156,7 +2130,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	set_capacity_and_notify(disk, capacity);
>  
>  	nvme_config_discard(disk, ns);
> -	nvme_config_write_zeroes(disk, ns);
> +	blk_queue_max_write_zeroes_sectors(disk->queue,
> +					   ns->ctrl->max_zeroes_sectors);
>  
>  	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
>  		test_bit(NVME_NS_FORCE_RO, &ns->flags));
> @@ -3060,14 +3035,73 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
>  	return 0;
>  }
>  
> +static inline u32 nvme_mps_size_to_sectors(struct nvme_ctrl *ctrl, u8 size)
> +{
> +	int page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
> +
> +	return 1 << (size + page_shift - 9);

A little nitpick we can fix when applying if needed:  MPS already
is the memory page size, so the size here seems redundant.

> +	/*
> +	 * Even though NVMe spec explicitly states that MDTS is not applicable
> +	 * to the write-zeroes, we are cautious and limit the size to the
> +	 * controllers max_hw_sectors value, which is based on the MDTS field
> +	 * and possibly other limiting factors.
> +	 */
> +	if (!(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES) &&
> +	    (ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES))

I would place the oncs check befoe the quirks check as it flows a lot
more logical.

But all the actual logic looks fine to me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
