Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F187C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 04:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4PM4+yIsyf9xlO4iXNK/rVKH+mE0y30v452kUTFPBIs=; b=WN4uAmaQBIbjvyjDsj19io4z2G
	LZuPwUVP+cY0UG3Moq/mU5DzCaOnQgalZ6AkVLMfav0h4ynoyK1nvqMMTnLOcjM1WaI0EcANerPBz
	VSjqTYw5tevVbUS+8bITXtWh3lIhsN9agSHMTqCTVyyNpZA4XpeBYBNaBFuBixfAG7fuIh48s3aVx
	/x59umRhhB+X9PA5F87Hr7UU8yBLluKhdIrRzbVWTTyyzVXLChGzIWqa7nNQUu8/6vXFBeNEQUenk
	JIlm8ONxh9M5a2YyYXhcvQNeLIytGuDSEdU6wQE2n4GIToUkoWxRtMkciB17TDyi8z0Lu5BqwqOWf
	hDJWDBkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRnZP-007DTN-QT; Wed, 09 Mar 2022 04:05:03 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRnZM-007DSL-1g
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 04:05:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1646798699; x=1678334699;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rxMjPSleiLAt9WOXE4dV0sRDZSQUAuFLwRljbx4ZFiw=;
 b=Mn5ILtjt2IoltdW10GTVtwl8MkE1dCmVV01/tA7kTpVGqioJR8cp8UbH
 oapsicaw9k9tV/R5PendgHbIPGiLgODuEjXET270xauxJixXsNS3ypAhB
 0bknqLEHl7QMcmReZCiTa2FHLvxgy8mcF4zl5pMemfG8rbv4DXx/JOUpK
 2FBEUi4ImMTXMtlbREAdsJ5kgh2fh7fr3KburplvcASiNaQIsQjVhOR36
 oEO0TWQqOei6fgiKySu/KxMsabIqDg3nxE6mMPO7i+2HwSdFPhlAo5Ktm
 jOE9pymC966+MAlaoMeQkTWcn+RpB4qeFFI3ImUpKcy39OK+E8D2veHn7 A==;
X-IronPort-AV: E=Sophos;i="5.90,166,1643644800"; d="scan'208";a="194826268"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2022 12:04:54 +0800
IronPort-SDR: wX8WSGXkODL4jNrIIDIel53mpNr0WwVFuVuULjprHTzEemUptgpx//wauERUpVOIhO4FgIODt5
 bumIxHhJlk2EKR/yYyHIvZjCk8S7WvPP7i14TyhJy5fFKmiN7U7ONiRcM8QL/aUpYDeIuO9ZO9
 Br6rGMkODzHF7fhqZvVm/iS7ZAFZXQ6aphX1RA/eOMT9PDhdc+HA4QlxiS5R5JhUVQWFUb+Oes
 gRS19vD1fHR3lpT7SfpsXBIG+g+sDjhCFlTo6UG5dpTzmyZ1gtdEOFVgIFf+3Hac4Bows+nKey
 aN0ZTrW2r9qYMc0v3fG9OlRr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 19:37:10 -0800
IronPort-SDR: MH51QCNNuwV1E3McDV0PsNl9+/dpKOtl9ODa5t/Ui0WWCsbi494kvrzLmkbl4pQJ9BaXsDLLG+
 ODRAOOabQ2Dr3YjHyN6PQZVQ6R/PJnxoVi5ct53xjIhnvIFlPiW+coYZHNA3cKb2n0HX2hTvHC
 jFeqVxVUHidpFOZmmnB0wRs7bF1U2NiX47VmDbcCrA4G+ENq1oiQpG7JhVrSZ6UyPUl6SaO0fS
 36NeUPD61DDBIUzbjNkQKEQQ2lAb+lIBYmTRBFC8PKmiCnuH6jqZMPtZSNQrQZ06PZ1tW5COIT
 amo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 20:04:54 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KCz9f3mXXz1SVp2
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 20:04:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1646798691; x=1649390692; bh=rxMjPSleiLAt9WOXE4dV0sRDZSQUAuFLwRl
 jbx4ZFiw=; b=k076ehd8b4xFd1+DzYBbQxyi00WCinXpqj3IDQnvZ0qD+oyylT9
 EH6IwueIJdSaOQlow1wSdY+daymYlWqwNSf3VQ+2fhHOOTLqo5kEyT6HHemX4KF0
 AvPFdn60miY/F8X5o0XHfXkgtDVyqq1WBrMrgpzEia05fr2YHrhCghtG3A0Zn8rT
 fHgxM5IbP1gjm8tB9d2EaPqyvb5dX+/URqInnurvQCC6qZATUOCLTlFtLBzA2oHx
 L1dsLLFX0wiGXHBBVOmespL/tUPJCiYcI83DAXXPYYGhbDwmPpbaU2l5Opi69CKk
 SgnbgWeV53KbYglqiypfDL5/yrkxHkNiUkQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id LyKEnU4vDkqy for <linux-nvme@lists.infradead.org>;
 Tue,  8 Mar 2022 20:04:51 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KCz9X5bxWz1Rvlx;
 Tue,  8 Mar 2022 20:04:48 -0800 (PST)
Message-ID: <d13c40a5-3f87-fb2c-155e-dd64535067ac@opensource.wdc.com>
Date: Wed, 9 Mar 2022 13:04:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/6] nvme: zns: Add support for power_of_2 emulation to
 NVMe ZNS devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Adam Manzanares <a.manzanares@samsung.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, =?UTF-8?Q?Matias_Bj=c3=b8rling?=
 <matias.bjorling@wdc.com>, jiangbo.365@bytedance.com
Cc: Pankaj Raghav <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160@eucas1p1.samsung.com>
 <20220308165349.231320-5-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220308165349.231320-5-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_200500_169082_8FF98CFE 
X-CRM114-Status: GOOD (  39.69  )
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

On 3/9/22 01:53, Pankaj Raghav wrote:
> power_of_2(PO2) is not a requirement as per the NVMe ZNSspecification,
> however we still have in place a lot of assumptions
> for PO2 in the block layer, in FS such as F2FS, btrfs and userspace
> applications.
> 
> So in keeping with these requirements, provide an emulation layer to
> non-power_of_2 zone devices and which does not create a performance
> regression to existing zone storage devices which have PO2 zone sizes.
> Callbacks are provided where needed in the hot paths to reduce the
> impact of performance regression.

Contradiction: reducing the impact of performance regression is not the
same as "does not create a performance regression". So which one is it ?
Please add performance numbers to this commit message.

And also please actually explain what the patch is changing. This commit
message is about the why, but nothing on the how.

> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/host/core.c |  28 +++++++----
>  drivers/nvme/host/nvme.h | 100 ++++++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/pci.c  |   4 ++
>  drivers/nvme/host/zns.c  |  79 +++++++++++++++++++++++++++++--
>  include/linux/blk-mq.h   |   2 +
>  5 files changed, 200 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fd4720d37cc0..c7180d512b08 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -327,14 +327,6 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>  	return RETRY;
>  }
>  
> -static inline void nvme_end_req_zoned(struct request *req)
> -{
> -	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> -	    req_op(req) == REQ_OP_ZONE_APPEND)
> -		req->__sector = nvme_lba_to_sect(req->q->queuedata,
> -			le64_to_cpu(nvme_req(req)->result.u64));
> -}
> -
>  static inline void nvme_end_req(struct request *req)
>  {
>  	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> @@ -676,6 +668,12 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
>  }
>  EXPORT_SYMBOL_GPL(nvme_fail_nonready_command);
>  
> +blk_status_t nvme_fail_po2_zone_emu_violation(struct request *req)
> +{
> +	return nvme_zone_handle_po2_emu_violation(req);
> +}
> +EXPORT_SYMBOL_GPL(nvme_fail_po2_zone_emu_violation);
> +

This should go in zns.c, not in the core.

>  bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>  		bool queue_live)
>  {
> @@ -879,6 +877,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>  	req->special_vec.bv_offset = offset_in_page(range);
>  	req->special_vec.bv_len = alloc_size;
>  	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
> +	nvme_verify_sector_value(ns, req);
>  
>  	return BLK_STS_OK;
>  }
> @@ -909,6 +908,7 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
>  			break;
>  		}
>  	}
> +	nvme_verify_sector_value(ns, req);
>  
>  	return BLK_STS_OK;
>  }
> @@ -973,6 +973,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>  
>  	cmnd->rw.control = cpu_to_le16(control);
>  	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
> +	nvme_verify_sector_value(ns, req);
>  	return 0;
>  }
>  
> @@ -2105,8 +2106,14 @@ static int nvme_report_zones(struct gendisk *disk, sector_t sector,
>  	return nvme_ns_report_zones(disk->private_data, sector, nr_zones, cb,
>  			data);
>  }
> +
> +static void nvme_npo2_zone_setup(struct gendisk *disk)
> +{
> +	nvme_ns_po2_zone_emu_setup(disk->private_data);
> +}

This helper seems useless.

>  #else
>  #define nvme_report_zones	NULL
> +#define nvme_npo2_zone_setup	NULL
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  
>  static const struct block_device_operations nvme_bdev_ops = {
> @@ -2116,6 +2123,7 @@ static const struct block_device_operations nvme_bdev_ops = {
>  	.release	= nvme_release,
>  	.getgeo		= nvme_getgeo,
>  	.report_zones	= nvme_report_zones,
> +	.npo2_zone_setup = nvme_npo2_zone_setup,
>  	.pr_ops		= &nvme_pr_ops,
>  };
>  
> @@ -3844,6 +3852,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>  	ns->disk = disk;
>  	ns->queue = disk->queue;
>  
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	ns->sect_to_lba = __nvme_sect_to_lba;
> +	ns->update_sector_append = nvme_update_sector_append_noop;
> +#endif
>  	if (ctrl->opts && ctrl->opts->data_digest)
>  		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
>  
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a162f6c6da6e..f584f760e8cc 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -457,6 +457,10 @@ struct nvme_ns {
>  	u8 pi_type;
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	u64 zsze;
> +	u64 zsze_po2;
> +	u32 zsze_diff;
> +	u64 (*sect_to_lba)(struct nvme_ns *ns, sector_t sector);
> +	sector_t (*update_sector_append)(struct nvme_ns *ns, sector_t sector);
>  #endif
>  	unsigned long features;
>  	unsigned long flags;
> @@ -562,12 +566,21 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
>  	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
>  }
>  
> +static inline u64 __nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
> +{
> +	return sector >> (ns->lba_shift - SECTOR_SHIFT);
> +}
> +
>  /*
>   * Convert a 512B sector number to a device logical block number.
>   */
>  static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
>  {
> -	return sector >> (ns->lba_shift - SECTOR_SHIFT);
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	return ns->sect_to_lba(ns, sector);

So for a power of 2 zone sized device, you are forcing an indirect call,
always. Not acceptable. What is the point of that po2_zone_emu boolean
you added to the queue ?

> +#else
> +	return __nvme_sect_to_lba(ns, sector);

This helper is useless.

> +#endif
>  }
>  
>  /*
> @@ -578,6 +591,83 @@ static inline sector_t nvme_lba_to_sect(struct nvme_ns *ns, u64 lba)
>  	return lba << (ns->lba_shift - SECTOR_SHIFT);
>  }
>  
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static inline u64 __nvme_sect_to_lba_po2(struct nvme_ns *ns, sector_t sector)
> +{
> +	sector_t zone_idx = sector >> ilog2(ns->zsze_po2);
> +
> +	sector = sector - (zone_idx * ns->zsze_diff);
> +
> +	return sector >> (ns->lba_shift - SECTOR_SHIFT);
> +}
> +
> +static inline sector_t
> +nvme_update_sector_append_po2_zone_emu(struct nvme_ns *ns, sector_t sector)
> +{
> +	/* The sector value passed by the drive after a append operation is the
> +	 * based on the actual zone layout in the device, hence, use the actual
> +	 * zone_size to calculate the zone number from the sector.
> +	 */
> +	u32 zone_no = sector / ns->zsze;
> +
> +	sector += ns->zsze_diff * zone_no;
> +	return sector;
> +}
> +
> +static inline sector_t nvme_update_sector_append_noop(struct nvme_ns *ns,
> +						      sector_t sector)
> +{
> +	return sector;
> +}
> +
> +static inline void nvme_end_req_zoned(struct request *req)
> +{
> +	if (req_op(req) == REQ_OP_ZONE_APPEND) {
> +		struct nvme_ns *ns = req->q->queuedata;
> +		sector_t sector;
> +
> +		sector = nvme_lba_to_sect(ns,
> +					  le64_to_cpu(nvme_req(req)->result.u64));
> +
> +		sector = ns->update_sector_append(ns, sector);

Why not assign that to req->__sector directly ?
And again here, you are forcing the indirect function call for *all* zns
devices, even those that have a power of 2 zone size.

> +
> +		req->__sector = sector;
> +	}
> +}
> +
> +static inline void nvme_verify_sector_value(struct nvme_ns *ns, struct request *req)
> +{
> +	if (unlikely(blk_queue_is_po2_zone_emu(ns->queue))) {
> +		sector_t sector = blk_rq_pos(req);
> +		sector_t zone_idx = sector >> ilog2(ns->zsze_po2);
> +		sector_t device_sector = sector - (zone_idx * ns->zsze_diff);
> +
> +		/* Check if the IO is in the emulated area */
> +		if (device_sector - (zone_idx * ns->zsze) > ns->zsze)
> +			req->rq_flags |= RQF_ZONE_EMU_VIOLATION;
> +	}
> +}
> +
> +static inline bool nvme_po2_zone_emu_violation(struct request *req)
> +{
> +	return req->rq_flags & RQF_ZONE_EMU_VIOLATION;
> +}

This helper makes the code unreadable in my opinion.

> +#else
> +static inline void nvme_end_req_zoned(struct request *req)
> +{
> +}
> +
> +static inline void nvme_verify_sector_value(struct nvme_ns *ns, struct request *req)
> +{
> +}
> +
> +static inline bool nvme_po2_zone_emu_violation(struct request *req)
> +{
> +	return false;
> +}
> +
> +#endif
> +
>  /*
>   * Convert byte length to nvme's 0-based num dwords
>   */
> @@ -752,6 +842,7 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
>  long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>  		unsigned long arg);
>  int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
> +blk_status_t nvme_fail_po2_zone_emu_violation(struct request *req);
>  
>  extern const struct attribute_group *nvme_ns_id_attr_groups[];
>  extern const struct pr_ops nvme_pr_ops;
> @@ -873,11 +964,13 @@ static inline void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
>  int nvme_revalidate_zones(struct nvme_ns *ns);
>  int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  		unsigned int nr_zones, report_zones_cb cb, void *data);
> +void nvme_ns_po2_zone_emu_setup(struct nvme_ns *ns);
>  #ifdef CONFIG_BLK_DEV_ZONED
>  int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf);
>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
>  				       struct nvme_command *cmnd,
>  				       enum nvme_zone_mgmt_action action);
> +blk_status_t nvme_zone_handle_po2_emu_violation(struct request *req);
>  #else
>  static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
>  		struct request *req, struct nvme_command *cmnd,
> @@ -892,6 +985,11 @@ static inline int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  		 "Please enable CONFIG_BLK_DEV_ZONED to support ZNS devices\n");
>  	return -EPROTONOSUPPORT;
>  }
> +
> +static inline blk_status_t nvme_zone_handle_po2_emu_violation(struct request *req)
> +{
> +	return BLK_STS_OK;
> +}
>  #endif
>  
>  static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6a99ed680915..fc022df3f98e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -960,6 +960,10 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		return nvme_fail_nonready_command(&dev->ctrl, req);
>  
>  	ret = nvme_prep_rq(dev, req);
> +
> +	if (unlikely(nvme_po2_zone_emu_violation(req)))
> +		return nvme_fail_po2_zone_emu_violation(req);
> +
>  	if (unlikely(ret))
>  		return ret;
>  	spin_lock(&nvmeq->sq_lock);
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index ad02c61c0b52..25516a5ae7e2 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -3,7 +3,9 @@
>   * Copyright (C) 2020 Western Digital Corporation or its affiliates.
>   */
>  
> +#include <linux/log2.h>
>  #include <linux/blkdev.h>
> +#include <linux/math.h>
>  #include <linux/vmalloc.h>
>  #include "nvme.h"
>  
> @@ -46,6 +48,18 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
>  	return 0;
>  }
>  
> +static sector_t nvme_zone_size(struct nvme_ns *ns)
> +{
> +	sector_t zone_size;
> +
> +	if (blk_queue_is_po2_zone_emu(ns->queue))
> +		zone_size = ns->zsze_po2;
> +	else
> +		zone_size = ns->zsze;
> +
> +	return zone_size;
> +}
> +
>  int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  {
>  	struct nvme_effects_log *log = ns->head->effects;
> @@ -122,7 +136,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>  				   sizeof(struct nvme_zone_descriptor);
>  
>  	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) / ns->zsze);
> +			 get_capacity(ns->disk) / nvme_zone_size(ns));
>  
>  	bufsize = sizeof(struct nvme_zone_report) +
>  		nr_zones * sizeof(struct nvme_zone_descriptor);
> @@ -147,6 +161,8 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>  				 void *data)
>  {
>  	struct blk_zone zone = { };
> +	u64 zone_gap = 0;
> +	u32 zone_idx;
>  
>  	if ((entry->zt & 0xf) != NVME_ZONE_TYPE_SEQWRITE_REQ) {
>  		dev_err(ns->ctrl->device, "invalid zone type %#x\n",
> @@ -159,10 +175,19 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>  	zone.len = ns->zsze;
>  	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
>  	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
> +
> +	if (blk_queue_is_po2_zone_emu(ns->queue)) {
> +		zone_idx = zone.start / zone.len;
> +		zone_gap = zone_idx * ns->zsze_diff;
> +		zone.start += zone_gap;
> +		zone.len = ns->zsze_po2;
> +	}
> +
>  	if (zone.cond == BLK_ZONE_COND_FULL)
>  		zone.wp = zone.start + zone.len;
>  	else
> -		zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
> +		zone.wp =
> +			nvme_lba_to_sect(ns, le64_to_cpu(entry->wp)) + zone_gap;
>  
>  	return cb(&zone, idx, data);
>  }
> @@ -173,6 +198,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  	struct nvme_zone_report *report;
>  	struct nvme_command c = { };
>  	int ret, zone_idx = 0;
> +	u64 zone_size = nvme_zone_size(ns);
>  	unsigned int nz, i;
>  	size_t buflen;
>  
> @@ -190,7 +216,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>  	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
>  
> -	sector &= ~(ns->zsze - 1);
> +	sector = rounddown(sector, zone_size);
>  	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
>  		memset(report, 0, buflen);
>  
> @@ -214,7 +240,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  			zone_idx++;
>  		}
>  
> -		sector += ns->zsze * nz;
> +		sector += zone_size * nz;
>  	}
>  
>  	if (zone_idx > 0)
> @@ -226,6 +252,32 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  	return ret;
>  }
>  
> +void nvme_ns_po2_zone_emu_setup(struct nvme_ns *ns)
> +{
> +	u32 nr_zones;
> +	sector_t capacity;
> +
> +	if (is_power_of_2(ns->zsze))
> +		return;
> +
> +	if (!get_capacity(ns->disk))
> +		return;
> +
> +	blk_mq_freeze_queue(ns->disk->queue);
> +
> +	blk_queue_po2_zone_emu(ns->queue, 1);
> +	ns->zsze_po2 = 1 << get_count_order_long(ns->zsze);
> +	ns->zsze_diff = ns->zsze_po2 - ns->zsze;
> +
> +	nr_zones = get_capacity(ns->disk) / ns->zsze;
> +	capacity = nr_zones * ns->zsze_po2;
> +	set_capacity_and_notify(ns->disk, capacity);
> +	ns->sect_to_lba = __nvme_sect_to_lba_po2;
> +	ns->update_sector_append = nvme_update_sector_append_po2_zone_emu;
> +
> +	blk_mq_unfreeze_queue(ns->disk->queue);
> +}
> +
>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
>  		struct nvme_command *c, enum nvme_zone_mgmt_action action)
>  {
> @@ -239,5 +291,24 @@ blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
>  	if (req_op(req) == REQ_OP_ZONE_RESET_ALL)
>  		c->zms.select_all = 1;
>  
> +	nvme_verify_sector_value(ns, req);
> +	return BLK_STS_OK;
> +}
> +
> +blk_status_t nvme_zone_handle_po2_emu_violation(struct request *req)
> +{
> +	/*  The spec mentions that read from ZCAP until ZSZE shall behave
> +	 *  like a deallocated block. Deallocated block reads are
> +	 *  deterministic, hence we fill zero.
> +	 * The spec does not clearly define the result for other opreation.
> +	 */

Comment style and indentation is weird.

> +	if (req_op(req) == REQ_OP_READ) {
> +		zero_fill_bio(req->bio);
> +		nvme_req(req)->status = NVME_SC_SUCCESS;
> +	} else {
> +		nvme_req(req)->status = NVME_SC_WRITE_FAULT;
> +	}

What about requests that straddle the zone capacity ? They need to be
partially zeroed too, otherwise data from the next zone may be exposed.

> +	blk_mq_set_request_complete(req);
> +	nvme_complete_rq(req);
>  	return BLK_STS_OK;
>  }
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 3a41d50b85d3..9ec59183efcd 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -57,6 +57,8 @@ typedef __u32 __bitwise req_flags_t;
>  #define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
>  /* queue has elevator attached */
>  #define RQF_ELV			((__force req_flags_t)(1 << 22))
> +/* request to do IO in the emulated area with po2 zone emulation */
> +#define RQF_ZONE_EMU_VIOLATION	((__force req_flags_t)(1 << 23))
>  
>  /* flags that prevent us from merging requests: */
>  #define RQF_NOMERGE_FLAGS \


-- 
Damien Le Moal
Western Digital Research

