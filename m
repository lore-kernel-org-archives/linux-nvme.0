Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FF6C64E7B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 15:16:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCBE2084C
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 15:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="waD8ovSG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzlUt+pJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCBE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0TJm6yOKS7EiFpuSK7mVLJRu54Qh/1h8DBbSkUzEv1M=; b=waD8ovSGDl2V6RwBB+AjrsFWH
	AxwL7UIRxYeCnfEHPx+EuXgmEVmikIkoi7QDqgnR9HVB1CqPb2xVDzOs+TGkSmsHF+vHSSzYizQbB
	+IrNxo3F2LrnWK4fvuFjs38NM2rDnawILQBJvPzsjHfZHd+nVhGWhuUhxuTbhfzFBtvoWfy42nOfQ
	mx0FRT4ZSobcnCt3Zd6r0J8nNxaK7lUfm49HYlhutd8dyFTcCye9/iircsZUatGPo69AwQm/SeIJA
	8dYAD2tDCzbeViM6EK/AA/2mnvFxcfMQK9bkAhkbyQixRb5L90p49Q6EzTWUATO/ivO8r8oLeVJy2
	fZbQloSfQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kk7OQ-00014C-DW; Tue, 01 Dec 2020 15:16:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk7ON-00012w-3I
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 15:16:37 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C5F562076C;
 Tue,  1 Dec 2020 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606835794;
 bh=kaWvN9i8+huMf6AvIgORWlRpPgxN5rIfIaVjaqvGCOg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CzlUt+pJA+53SO3UFHzReNIIGMqWwngpZV58v7zwdNbEPDLYhfZ7hSfaKCR/PE0Pr
 WZMdHo+6deBAaRDCbOKL8BxTOMUAY7Un0N86t/8fCgnojRxVUk0N+XS/nWrm9gWT/z
 U19oFOIyk90LIC7gNQkqXYcXKhd2gWICcgGc+BPw=
Date: Wed, 2 Dec 2020 00:16:28 +0900
From: Keith Busch <kbusch@kernel.org>
To: SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [RFC PATCH 2/2] nvme: add simple copy support
Message-ID: <20201201151628.GA27728@redsun51.ssa.fujisawa.hgst.com>
References: <20201201053949.143175-1-selvakuma.s1@samsung.com>
 <CGME20201201054106epcas5p486fa3f85f6ba5568f6df85c2660b2e3e@epcas5p4.samsung.com>
 <20201201053949.143175-3-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201201053949.143175-3-selvakuma.s1@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_101635_263855_517E9EC6 
X-CRM114-Status: GOOD (  16.06  )
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
Cc: axboe@kernel.dk, damien.lemoal@wdc.com, sagi@grimberg.me,
 joshi.k@samsung.com, selvajove@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, nj.shetty@samsung.com,
 linux-block@vger.kernel.org, javier.gonz@samsung.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 01, 2020 at 11:09:49AM +0530, SelvaKumar S wrote:
> +static void nvme_config_copy(struct gendisk *disk, struct nvme_ns *ns,
> +				       struct nvme_id_ns *id)
> +{
> +	struct nvme_ctrl *ctrl = ns->ctrl;
> +	struct request_queue *queue = disk->queue;
> +
> +	if (!(ctrl->oncs & NVME_CTRL_ONCS_COPY)) {
> +		queue->limits.max_copy_sectors = 0;
> +		blk_queue_flag_clear(QUEUE_FLAG_COPY, queue);
> +		return;
> +	}
> +
> +	/* setting copy limits */
> +	ns->mcl = le64_to_cpu(id->mcl);
> +	ns->mssrl = le32_to_cpu(id->mssrl);
> +	ns->msrc = id->msrc;

These are not used anywhere outside this function, so there's no need to
add members to the struct.

> +	if (blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, queue))
> +		return;

The queue limits are not necessarily the same each time we're called to
update the disk info, so this return shouldn't be here.

> +
> +	queue->limits.max_copy_sectors = ns->mcl * (1 << (ns->lba_shift - 9));
> +	queue->limits.max_copy_range_sectors = ns->mssrl *
> +		(1 << (ns->lba_shift - 9));
> +	queue->limits.max_copy_nr_ranges = ns->msrc + 1;
> +}

<>

> @@ -2045,6 +2133,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	set_capacity_and_notify(disk, capacity);
>  
>  	nvme_config_discard(disk, ns);
> +	nvme_config_copy(disk, ns, id);
>  	nvme_config_write_zeroes(disk, ns);
>  
>  	if (id->nsattr & NVME_NS_ATTR_RO)
> @@ -3014,6 +3103,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	ctrl->oaes = le32_to_cpu(id->oaes);
>  	ctrl->wctemp = le16_to_cpu(id->wctemp);
>  	ctrl->cctemp = le16_to_cpu(id->cctemp);
> +	ctrl->ocfs = le32_to_cpu(id->ocfs);

ocfs is not used anywhere.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
