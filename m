Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDCAC02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 11:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pQeV0O+jL1G/DFyqYGy9184NT6E7z1zePUvfpKkhxQI=; b=G3FHZoC3wFznwwBKjOcplXg/G7
	no7ZzNMbH+17r6WPKVPP5O3vKP1dBPJet6OMh5n3NlNfL6iJkdYMxOQ4IekU7crs3kFDOkViWxnpd
	hZQuEx8owSHC/tWYudplpbcu95F/mbpm1VjuWoCW1l6j+7Du2x+pCK98ywDlc9OC1lTyB2iQ9UKxZ
	3oXcnLvvUVJZkXkqUNzkcEblHupluiroi/23RA/Wd1NFDrOjFtJNoKmSP0lHThJGevXZ6Vcm7iu+a
	pduZvLgPLDbVkjRisPkMDNQUlgmnJl8zRbg1k8MtmPX8K4+tb+G7Y2tKUQzzeY9L6iIH8Uq96YjFZ
	T1RDcJUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYkyL-00000000C7k-03aJ;
	Fri, 17 Jan 2025 11:57:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYkyI-00000000C6A-1WqZ
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 11:57:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737115025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQeV0O+jL1G/DFyqYGy9184NT6E7z1zePUvfpKkhxQI=;
	b=ZKdY4jtvWMN3MUhSBM45GYN3q0HIiLvq42cv2sVsOaruWoUdAIA2SsmE3y3wgDPl+XR+eI
	BQZuWC0l2wqn7jTJ3Ir01uGeV+zDxq70YPLGA3HWbV4wWtTyN40QJM+pUQpqGV+Yojnlgs
	OLFn6g3xMCGD8VWzt4NoS32pFvQpsr4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-X-QMKzuZMpylKLq_glYHgA-1; Fri,
 17 Jan 2025 06:57:02 -0500
X-MC-Unique: X-QMKzuZMpylKLq_glYHgA-1
X-Mimecast-MFC-AGG-ID: X-QMKzuZMpylKLq_glYHgA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7363919560BB;
	Fri, 17 Jan 2025 11:57:00 +0000 (UTC)
Received: from fedora (unknown [10.72.116.68])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CA3F1955F10;
	Fri, 17 Jan 2025 11:56:53 +0000 (UTC)
Date: Fri, 17 Jan 2025 19:56:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	nbd@other.debian.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/2] loop: force GFP_NOIO for underlying file systems
 allocations
Message-ID: <Z4pFgIqB50gz-ODi@fedora>
References: <20250117074442.256705-1-hch@lst.de>
 <20250117074442.256705-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117074442.256705-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_035706_475567_02CECFFB 
X-CRM114-Status: GOOD (  22.89  )
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

On Fri, Jan 17, 2025 at 08:44:07AM +0100, Christoph Hellwig wrote:
> File systems can and often do allocate memory in the read-write path.
> If these allocations are done with __GFP_IO or __GFP_FS set they can
> recurse into the file system or swap device on top of the loop device
> and cause deadlocks.  Prevent this by forcing a noio scope over the
> calls into the file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/loop.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 1ec7417c7f00..71eccc5cfffb 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1905,6 +1905,15 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>  	int ret = 0;
>  	struct mem_cgroup *old_memcg = NULL;
>  	const bool use_aio = cmd->use_aio;
> +	unsigned int memflags;
> +
> +	/*
> +	 * We're calling into file system which could do be doing memory
> +	 * allocations.  Ensure the memory reclaim does not cause I/O,
> +	 * because that could end up in the user of this loop devices again and
> +	 * deadlock.
> +	 */
> +	memflags = memalloc_noio_save();

If we call memalloc_noio_save() here, setting PF_MEMALLOC_NOIO can be removed
from loop_process_work().


Thanks,
Ming


