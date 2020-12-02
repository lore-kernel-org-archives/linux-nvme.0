Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A95C64E7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 09:07:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F77522202
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 09:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F77522202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7Qv3C3Q4P9sbdQNgWz7QsFi74JtjmfZY0S+UOndng/A=; b=NpkAidf6OQKnfEphaG57tHtQM
	hQKThmvvtXdbc2DYT5roCjBLa2pthmSg7x8wM1nIP+gXYnTkp0bsaUGbMuazsqtgWgIN7dEs7/kwp
	cluitTyZ1oJBhAl1YtkRqGfe6zTiF/PWjSSUdOv8j0xZLzXPmqj5Igha8e19dmycPJkV4XI7K4dj5
	C4/fplopkghBwiDF02NFJ1BKmg9ftQaGz1Qh/TThMqF7OrYx8g182aSzbiuFmVy0pJxpUufrRSH7f
	vAQMxhc5C6miykkOi8g/JG/p+YhjzAuRYpMKnLLIAX9RFckLoCQAznk/9x0TRn80ca75PUzEQ+/a3
	jbdtA0/Lg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkO6c-0008Bi-Ej; Wed, 02 Dec 2020 09:07:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkO6Z-0008BA-J1
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 09:07:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id ACCB967373; Wed,  2 Dec 2020 10:07:15 +0100 (CET)
Date: Wed, 2 Dec 2020 10:07:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V4 2/9] nvmet: add ZNS support for bdev-ns
Message-ID: <20201202090715.GA2952@lst.de>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201202062227.9826-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_040719_857732_2684CD26 
X-CRM114-Status: GOOD (  26.70  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me, johannes.thumshirn@wdc.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 01, 2020 at 10:22:20PM -0800, Chaitanya Kulkarni wrote:
> Add zns-bdev-config, id-ctrl, id-ns, zns-cmd-effects, zone-mgmt-send,
> zone-mgmt-recv and zone-append handlers

If you think you need to speel out command please do so as in the spec
instead of uisng strange abbreviations.

That being said the commit log should document the why and the overall
architecture considerations, not low-level details like this.

> +#ifdef CONFIG_BLK_DEV_ZONED
> +	struct nvme_id_ns_zns	id_zns;
> +	unsigned int		zasl;
> +#endif

This wastes a lot of space for all normal non-zns uses.  Please have some
sort of private data field that zns can use.  Why do we even need to store
the whole data structure instead of the few native format fields we need?

>  static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
> @@ -251,6 +255,10 @@ struct nvmet_subsys {
>  	unsigned int		admin_timeout;
>  	unsigned int		io_timeout;
>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	struct nvme_id_ctrl_zns	id_ctrl_zns;
> +#endif

Same here.

> +#define NVMET_MPSMIN_SHIFT	12

Needs some documentation on the why.

> +static inline struct block_device *nvmet_bdev(struct nvmet_req *req)
> +{
> +	return req->ns->bdev;
> +}

I don't really see the point of this helper.

> +/*
> + *  ZNS related command implementation and helpers.
> + */
> +
> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
> +{
> +	u16 nvme_cis_zns = NVME_CSI_ZNS;
> +
> +	if (!bdev_is_zoned(nvmet_bdev(req)))
> +		return NVME_SC_SUCCESS;
> +
> +	return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, NVME_NIDT_CSI_LEN,
> +					&nvme_cis_zns, off);
> +}

This looks weird.  We can want to support the command set identifier in
general, so this should go into common code, and just look up the command
set identifier in the nvmet_ns structure.

> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
> +{
> +	log->iocs[nvme_cmd_zone_append]		= cpu_to_le32(1 << 0);
> +	log->iocs[nvme_cmd_zone_mgmt_send]	= cpu_to_le32(1 << 0);
> +	log->iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
> +}

Just add this to the caller under an if.  For the if a helper that checks
IS_ENABLED() and the csi would be useful.

> +
> +static inline bool nvmet_bdev_validate_zns_zones(struct nvmet_ns *ns)
> +{
> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {
> +		pr_err("block devices with conventional zones are not supported.");
> +		return false;
> +	}
> +
> +	return !(get_capacity(ns->bdev->bd_disk) &
> +			(bdev_zone_sectors(ns->bdev) - 1));
> +}

I think this should be open coded in the caller.

> +static inline u8 nvmet_zasl(unsigned int zone_append_sects)
> +{
> +	/*
> +	 * Zone Append Size Limit is the value experessed in the units
> +	 * of minimum memory page size (i.e. 12) and is reported power of 2.
> +	 */
> +	return ilog2((zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT);
> +}
> +
> +static inline void nvmet_zns_update_zasl(struct nvmet_ns *ns)
> +{
> +	struct request_queue *q = ns->bdev->bd_disk->queue;
> +	struct nvmet_ns *ins;
> +	unsigned long idx;
> +	u8 min_zasl;
> +
> +	/*
> +	 * Calculate new ctrl->zasl value when enabling the new ns. This value
> +	 * has to be the minimum of the max_zone_append values from available
> +	 * namespaces.
> +	 */
> +	min_zasl = ns->zasl = nvmet_zasl(queue_max_zone_append_sectors(q));
> +
> +	xa_for_each(&(ns->subsys->namespaces), idx, ins) {
> +		struct request_queue *iq = ins->bdev->bd_disk->queue;
> +		unsigned int imax_za_sects = queue_max_zone_append_sectors(iq);
> +		u8 izasl = nvmet_zasl(imax_za_sects);
> +
> +		if (!bdev_is_zoned(ins->bdev))
> +			continue;
> +
> +		min_zasl = min_zasl > izasl ? izasl : min_zasl;
> +	}
> +
> +	ns->subsys->id_ctrl_zns.zasl = min_zasl;
> +}

This will change the limit when a new namespaces is added.  I think we need
to just pick the value of the first namespaces and refuse adding a new
one if the limit is lower to not completely break hosts.

> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)

This whole function looks weird.  I'd expect that we mostly (if not
entirely) reuse nvmet_bdev_execute_rw, just using bio_add_hw_page
instead of bio_add_page and setting up the proper op field.

> +#else  /* CONFIG_BLK_DEV_ZONED */

We really do try to avoid these kinds of ifdefs in .c files.  Either
put the stubs inline into the header, of use IS_ENABLED() magic in
the callers.  In this case I think the new helper I mentioned above
which checks IS_ENABLED + the csi seems like the right way.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
