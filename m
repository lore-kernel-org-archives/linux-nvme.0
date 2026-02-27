Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDD71039880
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 19:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i9XwpDxs/qoFLn1Jvyqbmikgtgk6yGhzXhIV9M3DNKQ=; b=yhLMOK1anEr8xdukTx4rZa1QxK
	qxzJyPMdxPP9X4kCarUbKH8p4tZT7Rx4ibvziCG2Xk3lNcK7ALlpCi/Qhv/qY+uhFS1YjGRRJZF3z
	iSwWwGIbB1wdheWg3XTFaIuwT/gatKOl8D/NGSFM83POOfGMjJjrdigc9Ca7yeYxxJENK5tA1WOx3
	V3RICPudz0R5vjdE+2gptI2NWIBmqRh1KiLewJR9OvgphHyZapFWzO1J/bGeKm006oaYcavGAxXpO
	IOpi3kBdyoisdZ0jOiBAd1dMJ6ESvbM5/PKGRlN+p6+05DTwQ05QKx0Dr6EJp4s31CS4AHvKPTwEi
	GUE9S1Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw3t0-000000094df-0RQM;
	Fri, 27 Feb 2026 19:52:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw3sx-000000094dJ-346M
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 19:52:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772221946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9XwpDxs/qoFLn1Jvyqbmikgtgk6yGhzXhIV9M3DNKQ=;
	b=FZTL5SLwuAS8AQkoLal3SrUPSI4GnALJ62fQfxhtaC1zmpHg0L+xma5kNiVgc+489RpjVb
	2aFkIfE4CvaLCXQDvfoMSBXkvSoCxxA+zI/tf0Xd9/xXQCmRsSCSspUMUJR7DAIb42FpLQ
	rZSz9QRHnd9gaGEYeKXAGjZPWPfrxtQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-AAfjTlalMvC76zMyXgTzMA-1; Fri,
 27 Feb 2026 14:52:21 -0500
X-MC-Unique: AAfjTlalMvC76zMyXgTzMA-1
X-Mimecast-MFC-AGG-ID: AAfjTlalMvC76zMyXgTzMA_1772221939
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C8E61956063;
	Fri, 27 Feb 2026 19:52:19 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47D8B1800286;
	Fri, 27 Feb 2026 19:52:18 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 61RJqH8H1743483
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 14:52:17 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 61RJqG1o1743482;
	Fri, 27 Feb 2026 14:52:16 -0500
Date: Fri, 27 Feb 2026 14:52:16 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] libmultipath: Add support for block device IOCTL
Message-ID: <aaH18HKCMdjuUhUh@redhat.com>
References: <20260225153225.1031169-1-john.g.garry@oracle.com>
 <20260225153225.1031169-12-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20260225153225.1031169-12-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 2yKVYOWpRtMKb-QPMcORPQg9eZP07YH871rPROW-J6o_1772221939
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_115227_869023_03F3C63D 
X-CRM114-Status: GOOD (  18.25  )
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

On Wed, Feb 25, 2026 at 03:32:23PM +0000, John Garry wrote:
> Add mpath_bdev_ioctl() as a multipath block device IOCTL handler. This
> handler calls into driver mpath_head_template.ioctl handler.
> 
> It is expected that the .ioctl handler will unlock the SRCU read lock,
> as this is what NVMe requires - see nvme_ns_head_ctrl_ioctl(). As such,
> export a handler to unlock, mpath_head_read_unlock().
> 
> The .compat_ioctl handler is given the standard handler.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  include/linux/multipath.h |  4 ++++
>  lib/multipath.c           | 42 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/include/linux/multipath.h b/include/linux/multipath.h
> index 3846ea8cfd319..40dda6a914c5f 100644
> --- a/include/linux/multipath.h
> +++ b/include/linux/multipath.h
> @@ -72,6 +72,9 @@ struct mpath_head_template {
>  	bool (*is_disabled)(struct mpath_device *);
>  	bool (*is_optimized)(struct mpath_device *);
>  	enum mpath_access_state (*get_access_state)(struct mpath_device *);
> +	int (*bdev_ioctl)(struct block_device *bdev, struct mpath_device *,
> +			blk_mode_t mode, unsigned int cmd, unsigned long arg,
> +			int srcu_idx);

I don't know that this API is going to work out. SCSI persistent
reservations need access to all the mpath_devices, not just one, and
they are commonly handled via SG_IO ioctls. Unless you want to disallow
SCSI persistent reservations via SG_IO, you need to be able to detect
them, and handle them using the persistent reservation code with the
mpath_head.

-Ben 


