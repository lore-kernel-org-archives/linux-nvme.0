Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBC7FD88ED
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Mar 2026 04:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oFCE0765f92uX2IgFFqUbjXSAd+HWvC6aFzPdbzLksw=; b=2b/K8g+Z2oycFlht4eJhfNkpVw
	80o6Qz1VYcimBgqdaZVBgC8Hs7FGiniWx1w19BL/QzNZSJXhqIlnZcH4HAOQt1LXoKmyuZyGarH8h
	C2f6OQOIO9tMGcFdJiGGU4v4cl72HR10dLByYKekNuQlMK2IaN7ndvcDNAmeDcpU2Ug9UnOA8KhMX
	pTXOotbbE286Q+LPMJOwT/cVI+lKNYp9xDo5RTqW4vQszcvCggVcYnxOGyEkJSa3vIfQrLTkE+ipg
	ord/K55aJdREFD5KoTfnN7vw4kPrhkepg1IjhndqIhSgN0ygjr1BDuxYfdzybB8U9l2Gp9zA1jVnI
	PyJedo6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1Gis-00000001UHM-1pF9;
	Sat, 14 Mar 2026 04:35:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1Gio-00000001UGx-44sR
	for linux-nvme@lists.infradead.org;
	Sat, 14 Mar 2026 04:35:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773462928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFCE0765f92uX2IgFFqUbjXSAd+HWvC6aFzPdbzLksw=;
	b=Gy6v97GReW3LnOMHujPoLTK02b4yCYU+b1fiWxHQM8q1PN5MYKEUh9TUYVU4TihBVA11Ye
	RGzEzosr3FZTIcyUrik5g8jsCWwlyIsedY09VxGBzf6kbYVrXHy5IDGBZVwDKZx2skzo6W
	logImziwMxu1XRaYWQKvhsVt6Rilusc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-kJ0wgQkvP5KS8aaMfu1ItQ-1; Sat,
 14 Mar 2026 00:35:25 -0400
X-MC-Unique: kJ0wgQkvP5KS8aaMfu1ItQ-1
X-Mimecast-MFC-AGG-ID: kJ0wgQkvP5KS8aaMfu1ItQ_1773462923
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77E881953987;
	Sat, 14 Mar 2026 04:35:22 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F019119560B7;
	Sat, 14 Mar 2026 04:35:19 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 62E4ZI4W688154
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 14 Mar 2026 00:35:18 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 62E4ZGme688153;
	Sat, 14 Mar 2026 00:35:16 -0400
Date: Sat, 14 Mar 2026 00:35:16 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com,
        james.bottomley@hansenpartnership.com, hare@suse.com,
        jmeneghi@redhat.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
        axboe@fb.com, linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, nilay@linux.ibm.com
Subject: Re: [PATCH 4/8] scsi: Create a core ALUA driver
Message-ID: <abTlhI0nO94Ax6gQ@redhat.com>
References: <20260310114925.1222263-1-john.g.garry@oracle.com>
 <20260310114925.1222263-5-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20260310114925.1222263-5-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: SK4xF07zwvT4QTsGJPQJ6qWOhTr8BHF2ZuAvXQDzSWc_1773462923
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_213531_420743_61563713 
X-CRM114-Status: GOOD (  25.77  )
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

On Tue, Mar 10, 2026 at 11:49:21AM +0000, John Garry wrote:
> Add a dedicated ALUA driver which can be used for native SCSI multipath
> and also DH-based ALUA support.
> 
> Only core functions to submit a RTPG, STPG, tur, and also helper functions
> are added.
> 
> The code from scsi_dh_alua.c to maintain the port groups is not added,
> because it is quite intertwined with the DH code. However the port group
> management code would be quite useful.
> 
> Hannes Reinecke originally authored this code.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> diff --git a/drivers/scsi/scsi_alua.c b/drivers/scsi/scsi_alua.c
> new file mode 100644
> index 0000000000000..2e4102192dcb9
> --- /dev/null
> +++ b/drivers/scsi/scsi_alua.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Generic SCSI-3 ALUA SCSI driver
> + *
> + * Copyright (C) 2007-2010 Hannes Reinecke, SUSE Linux Products GmbH.
> + * All rights reserved.
> + */
> +
> +#include <scsi/scsi.h>
> +#include <scsi/scsi_proto.h>
> +#include <scsi/scsi_dbg.h>
> +#include <scsi/scsi_eh.h>
> +#include <scsi/scsi_alua.h>
> +
> +#define DRV_NAME "alua"
> +
> +#define ALUA_FAILOVER_RETRIES		5
> +
> +/*
> + * alua_check_tpgs - Evaluate TPGS setting
> + * @sdev: device to be checked
> + *
> + * Examine the TPGS setting of the sdev to find out if ALUA
> + * is supported.
> + */
> +int alua_check_tpgs(struct scsi_device *sdev)
> +{
> +	int tpgs = TPGS_MODE_NONE;
> +
> +	/*
> +	 * ALUA support for non-disk devices is fraught with
> +	 * difficulties, so disable it for now.
> +	 */
> +	if (sdev->type != TYPE_DISK) {
> +		sdev_printk(KERN_INFO, sdev,
> +			    "%s: disable for non-disk devices\n",
> +			    DRV_NAME);
> +		return tpgs;
> +	}
> +
> +	tpgs = scsi_device_tpgs(sdev);
> +	switch (tpgs) {
> +	case TPGS_MODE_EXPLICIT|TPGS_MODE_IMPLICIT:
> +		sdev_printk(KERN_INFO, sdev,
> +			    "%s: supports implicit and explicit TPGS\n",
> +			    DRV_NAME);
> +		break;
> +	case TPGS_MODE_EXPLICIT:
> +		sdev_printk(KERN_INFO, sdev, "%s: supports explicit TPGS\n",
> +			    DRV_NAME);
> +		break;
> +	case TPGS_MODE_IMPLICIT:
> +		sdev_printk(KERN_INFO, sdev, "%s: supports implicit TPGS\n",
> +			    DRV_NAME);
> +		break;
> +	case TPGS_MODE_NONE:
> +		sdev_printk(KERN_INFO, sdev, "%s: not supported\n",
> +			    DRV_NAME);
> +		break;
> +	default:
> +		sdev_printk(KERN_INFO, sdev,
> +			    "%s: unsupported TPGS setting %d\n",
> +			    DRV_NAME, tpgs);
> +		tpgs = TPGS_MODE_NONE;
> +		break;
> +	}
> +
> +	return tpgs;
> +}
> +EXPORT_SYMBOL_GPL(alua_check_tpgs);
> +
> +/*
> + * alua_tur - Send a TEST UNIT READY
> + * @sdev: device to which the TEST UNIT READY command should be send
> + *
> + * Send a TEST UNIT READY to @sdev to figure out the device state
> + * Returns SCSI_DH_RETRY if the sense code is NOT READY/ALUA TRANSITIONING,
> + * 0 if no error occurred, and SCSI_DH_IO otherwise.

Nitpick: The comment here still references SCSI_DH_ values

-Ben

> + */
> +int alua_tur(struct scsi_device *sdev)


