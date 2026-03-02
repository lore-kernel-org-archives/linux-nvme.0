Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC354D58E4B
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 04:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NKGcz8tlyCPU7NrDjoUUnPCQmL3iAFi9IJXAqCR6JYs=; b=ralIsIwuCH1BFlJ3VhTUDiaEBT
	azHUexU5J9O6t39TP9in3UnseKHlNfodOsXb3H4wqhWBDI+YbKo7jy+pkYEFOlbub8FL135mx/Zds
	/8QiPA8n6CFXJSJTMktlR/RwbWNVGseuz5x7msZR7y536573Q5udqsrRjV+Zma42FI1psNvESuAhJ
	Y4ENxw7dVPKtoWa+ow1gxaRGXc4bnnTEyLIaMlSuu1/odGUP8W6ZW9MsNgrMj5JCkYeI9/wewUPem
	uVpAByyAsGR/lVE7bWyICVRNyP//K7Wq4+1FdXl2xeArU66ZFas+QWU1M/IsT+Cys7ajo07q0o78/
	UzEjjdMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwuaM-0000000CEwr-3Hxx;
	Mon, 02 Mar 2026 04:08:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwuaK-0000000CEwS-1Hsf
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 04:08:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772424522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NKGcz8tlyCPU7NrDjoUUnPCQmL3iAFi9IJXAqCR6JYs=;
	b=h00pofgGzTHRH+ANV3ZWxhb26WT4El6r6omEx1qJUz3o6Mw7+z2lewNTgvotNy9f8m2Z5O
	HRTIZ1LJcl5Dir84hdBaNdRbx/n11xHpwPsd8wvHD3e5nxRq+WHJEkRm8AZJNv9w+KEx2S
	UxizI+Ca6F/jSm78X17KL+jo93EoXF0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-Q2mNSiM0N7OQD_xm4M8l5A-1; Sun,
 01 Mar 2026 23:08:39 -0500
X-MC-Unique: Q2mNSiM0N7OQD_xm4M8l5A-1
X-Mimecast-MFC-AGG-ID: Q2mNSiM0N7OQD_xm4M8l5A_1772424517
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0330E1956089;
	Mon,  2 Mar 2026 04:08:37 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E984F19560A3;
	Mon,  2 Mar 2026 04:08:35 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 62248YjS1832189
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 1 Mar 2026 23:08:34 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 62248Ype1832188;
	Sun, 1 Mar 2026 23:08:34 -0500
Date: Sun, 1 Mar 2026 23:08:34 -0500
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
Message-ID: <aaUNQgJu8sEx-lsv@redhat.com>
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-11-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20260225153627.1032500-11-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: oyRs1BCv1_YP9ZEcCgUlMDPQOgpkC1E0Odzw0-W9Hx8_1772424517
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_200844_471656_0B53231B 
X-CRM114-Status: GOOD (  17.68  )
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
>  	#ifdef CONFIG_SCSI_MULTIPATH
> +	void (*mpath_start_cmd)(struct scsi_cmnd *);
> +	void (*mpath_end_cmd)(struct scsi_cmnd *);
>  	struct mpath_disk *(*to_mpath_disk)(struct request *);
>  	#endif
>  };
> diff --git a/include/scsi/scsi_multipath.h b/include/scsi/scsi_multipath.h
> index 07db217edb085..6cb3107260952 100644
> --- a/include/scsi/scsi_multipath.h
> +++ b/include/scsi/scsi_multipath.h
> @@ -56,6 +56,23 @@ void scsi_mpath_add_sysfs_link(struct scsi_device *sdev);
>  void scsi_mpath_remove_sysfs_link(struct scsi_device *sdev);
>  int scsi_mpath_get_head(struct scsi_mpath_head *);
>  void scsi_mpath_put_head(struct scsi_mpath_head *);
> +
> +static inline void scsi_mpath_start_request(struct request *req)
> +{
> +	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
> +
> +	if (is_mpath_request(req))
> +		scsi_cmd_to_driver(cmd)->mpath_start_cmd(cmd);
> +}
> +
> +static inline void scsi_mpath_end_request(struct request *req)
> +{
> +	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
> +
> +	if (is_mpath_request(req))
> +		scsi_cmd_to_driver(cmd)->mpath_start_cmd(cmd);

Copy-paste error. It should be:

		scsi_cmd_to_driver(cmd)->mpath_end_cmd(cmd);

-Ben


