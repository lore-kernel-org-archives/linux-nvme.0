Return-Path: <SRS0=77Bv=24=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FE0C33C8C
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 18:07:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2CC20848
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 18:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mSHi+dM/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdxxdJon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2CC20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zOq9AihF2XX8ojPhj3c0Q46uHouMMl0OSLUYQPvnAdI=; b=mSHi+dM/CtKh0g
	Q1QrXr9UwC1dhYTmbeMoLM/dv1BdGpdu96ci01p1pO74imOYpRXMD3tHb9gSvPumxscgF5Hhi6Jr2
	xyQFegXhjVXvKh9eXyyIcnHrmnFVq0Tv9mmILTdYMQtQjBtDqJog94US686M2pCJXm05E1bWFpX+O
	MQLMYczbqstwBPxfDs0Tdo2vX4A517TJolStrOyaPlUKKNANc330Eh9Y2KhrHWUEI9IqnkcOIqG2V
	pqv5nubM/zebUCMTwO7vYXj7rrJtGFSLKjzybleSr3iBSrlXErW/eEQN33zSJZOAzNNJ+WLFWKODt
	vWVZ31Wyz9Ohrx3BXkUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iotGE-0005wR-7x; Tue, 07 Jan 2020 18:07:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iotGB-0005w8-8W
 for linux-nvme@lists.infradead.org; Tue, 07 Jan 2020 18:07:20 +0000
Received: from chuupie.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 08CC620848;
 Tue,  7 Jan 2020 18:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578420438;
 bh=x3IScgWsEfEbj7wzMWcmTUDUE9CsS3jOXDX0z0exgIk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PdxxdJon1KjQOXhQmRBHd50hyZL8YO2pZTfw6OJ0i5z6oqu/b97bB0OOZWlTcaAAt
 xr4g4P/Cup98fhPUBY2Puhw96K6lljA2LVtk9BN3CQcYyA/vmXByBz02hXwNz6g8np
 9aKxHFfdhYvE2VlbNxw4OSR/pkIE+ynJAPKBorEg=
Date: Tue, 7 Jan 2020 11:07:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 01/15] nvme: Introduce namespace features flag
Message-ID: <20200107180716.GA603371@chuupie.wdl.wdc.com>
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-3-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200106133736.123038-3-maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200107_100719_316338_C6828048 
X-CRM114-Status: GOOD (  14.21  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me, martin.petersen@oracle.com,
 shlomin@mellanox.com, israelr@mellanox.com, vladimirk@mellanox.com,
 linux-nvme@lists.infradead.org, idanb@mellanox.com, oren@mellanox.com,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 06, 2020 at 03:37:22PM +0200, Max Gurtovoy wrote:
> From: Israel Rukshin <israelr@mellanox.com>
> 
> Centralize all the integrity checks to one place and make the code more
> readable. Also add has_pi field to the nvme_req structure as well, so the
> transport drivers could use it.

I think the two changes should be in different patches, splitting the
namespace "features" flags from nvme_request "has_pi". I'm not even
sure there's a need for the per-IO settings and checks for "has_pi",
though. I don't find any transport driver changes in this series using
this flag outside this patch.
 
> @@ -1834,12 +1831,29 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
> +	if (ns->ms) {
> +		if (id->flbas & NVME_NS_FLBAS_META_EXT)
> +			ns->features |= NVME_NS_EXT_LBAS;
> +
> +		/*
> +		 * For PCI, Extended logical block will be generated by the
> +		 * controller.
> +		 */
> +		if (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED) {
> +			if (!(ns->features & NVME_NS_EXT_LBAS))

A little simpler:

		if (id->flbas & NVME_NS_FLBAS_META_EXT)
			ns->features |= NVME_NS_EXT_LBAS;
		else if (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)
			ns->features |= NVME_NS_DIX_SUPPORTED;

> +				ns->features |= NVME_NS_DIX_SUPPORTED;
> +		}
> +	}

It's not really a "DIX" flag since we can observe separate metadata
formats for non-DIX related use. Can we use a more generic name for this
feature flag? maybe "NVME_NS_MS_SEPARATE".

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
