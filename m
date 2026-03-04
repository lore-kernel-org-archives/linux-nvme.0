Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD991EDEC12
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 06:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hifhB8EKHJQ7PQPYx3jR5aKs6hdV4ehfn0Z4JLP6Nxg=; b=RNTzDVSVL7xTiLDl52hXR2SCdI
	GZwWYwd1sFUQD2RQ70IZJ1LAHKneQJlfbBFqqdXczO+bb4wwlSOpvxRSw6XzdDgQE5OHf7CkrP74j
	TLKJTHFqYZstXkKJ7UpldbQh/JFTaNQ5gmIeL5ONqup0doVVJlE7HbYm9Q+MxNlWHHhgLl6v03+LZ
	DbX7KxAELp2aaX8Pz+/yWKr3b27blYfnMLFic+KKxHmlOeQzGEZzUUWQZh9Wdc2zbU30W/6D2Yk3I
	zeOEXiwmJCf3ejb+NmD+WSvPHY6FPdJ2L2E1ZeYqM2krvPzEUnPqKBSffbCDXXwPXF+fjcRLtCySk
	JE7taB7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxfUd-0000000GVpf-2z2T;
	Wed, 04 Mar 2026 06:13:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxfUb-0000000GVpJ-1Y8h
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 06:13:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772604835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hifhB8EKHJQ7PQPYx3jR5aKs6hdV4ehfn0Z4JLP6Nxg=;
	b=Cvbt+Dx0kilBLRgcx9ICb62heJLesGePI1dxiHZ8b8d3zASyVkCVAHYohULk+KDAssOsv2
	7bHSVUAxuZgxfFheyNZ3Mlp19idNR9muyl6LUxb2IL5wUUbysgQQcn0kC8+9GwNNLmtdqc
	8W6vul8J60LxwQrp2QA35Z4k2RS+mt0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-QBsmGE1QP9ycB549mn9zFQ-1; Wed,
 04 Mar 2026 01:13:54 -0500
X-MC-Unique: QBsmGE1QP9ycB549mn9zFQ-1
X-Mimecast-MFC-AGG-ID: QBsmGE1QP9ycB549mn9zFQ_1772604832
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D94C7195609F;
	Wed,  4 Mar 2026 06:13:50 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0873D18002A6;
	Wed,  4 Mar 2026 06:13:49 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 6246Dm4e1917917
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 4 Mar 2026 01:13:48 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 6246Dmhf1917916;
	Wed, 4 Mar 2026 01:13:48 -0500
Date: Wed, 4 Mar 2026 01:13:48 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/24] scsi-multipath: add
 scsi_mpath_{start,end}_request()
Message-ID: <aafNnO6o2yoeLjPs@redhat.com>
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-11-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20260225153627.1032500-11-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: V9Ov8mX3TCxrV09lAy8q0PETxc_bSMggg0H8oUDg_8I_1772604832
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_221357_507420_9E269F21 
X-CRM114-Status: GOOD (  19.50  )
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

On Wed, Feb 25, 2026 at 03:36:13PM +0000, John Garry wrote:
> Add scsi_mpath_{start,end}_request() to handle updating private multipath
> request data, like nvme_mpath_{start,end}_request().
> 
> Since we may need to update mpath_disk data, add a callbacks in
> scsi_driver to actually do this work for the scsi driver.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/scsi/scsi_lib.c       |  4 ++++
>  include/scsi/scsi_driver.h    |  2 ++
>  include/scsi/scsi_multipath.h | 24 ++++++++++++++++++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 7ed0defc8161e..61179caa7b2c8 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -654,6 +654,8 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
>  	 */
>  	destroy_rcu_head(&cmd->rcu);
>  
> +	scsi_mpath_end_request(req);
> +
>  	/*
>  	 * In the MQ case the command gets freed by __blk_mq_end_request,
>  	 * so we have to do all cleanup that depends on it earlier.

This looks wrong. We start accounting in scsi_queue_rq(), and we need to
end it whenever we complete or requeue the request, otherwise the
accounting will get off. But not all requests go through
scsi_end_request(). scsi_mpath_failover_req(), for instance, calls
blk_mq_end_request() directly, and other functions, like
scsi_queue_insert() call blk_mq_requeue_request(). I'm pretty sure that
this should go in scsi_complete(), as well in the error path of
scsi_queue_rq().

-Ben


