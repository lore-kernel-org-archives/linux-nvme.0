Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A2BD58E49
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 02:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TKRBAHBhGf33PeUUogtnMtfD26THedM4RUsbkwW8suQ=; b=zTu6Siiygj28AxnsHOP+maqc9E
	8XvukDL17VNRPfTAQ1KtlZI9d05qHPHSEYmOrhpyk50Efdd+MdqP3p20eVvC2CLVYchjz+uQZOnMR
	OM6aNs7SGhI5bQwDiEpXd5xwOT6uevEuZHN3VQmbxn5H99Ua7ws9GQvYveI2N+d4qr2aVgY9XEtwy
	aJJHE6mYQGunlW7JFWV9bNP/fckogg06mDEB5a2g+IxHTK8KNy7PU7fVM5mIspw/u4PgFlqwe7xR1
	yicOXW5UN2X3l3KhXcZPlRhOoRvXNfzD5Egkzs6WVYGXklPIle/G0olBS0iEMyS567KW1PojTne/3
	h6Qhq4MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwsqA-0000000C6my-0v63;
	Mon, 02 Mar 2026 02:16:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwsq7-0000000C6ma-31F6
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 02:16:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772417812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKRBAHBhGf33PeUUogtnMtfD26THedM4RUsbkwW8suQ=;
	b=HK9qi+JEk5gAjoe9dBZqjlz2STJMTT2Hgq63EB3Jgzu2UHghm1XWreKzqK8p2sQ0ZhO1f+
	xP1pepXCwn4cOTRGmTJ6lfNTKQVTkkkJNfCyL54uo2S4ZGlxw6JuSvC/vVjM6BcKG868wO
	fSAqjA50V9dxIoN3ODhBY0oJ2PHaL7Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-LCW3ziGGOgyxShhomJFY4Q-1; Sun,
 01 Mar 2026 21:16:43 -0500
X-MC-Unique: LCW3ziGGOgyxShhomJFY4Q-1
X-Mimecast-MFC-AGG-ID: LCW3ziGGOgyxShhomJFY4Q_1772417801
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B87E1800451;
	Mon,  2 Mar 2026 02:16:40 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C33030001BF;
	Mon,  2 Mar 2026 02:16:38 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 6222Gavh1829082
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 1 Mar 2026 21:16:37 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 6222Gaxo1829081;
	Sun, 1 Mar 2026 21:16:36 -0500
Date: Sun, 1 Mar 2026 21:16:36 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/24] scsi-multipath: introduce basic SCSI device support
Message-ID: <aaTzBNPE7lDEyxd1@redhat.com>
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-3-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20260225153627.1032500-3-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: j4LA-YyV5OnItFYPQuAFutAESkEMSC7KU9nSCVXEWTU_1772417801
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_181655_840185_D928A732 
X-CRM114-Status: GOOD (  23.18  )
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

On Wed, Feb 25, 2026 at 03:36:05PM +0000, John Garry wrote:
> For a scsi_device to support multipath, introduce structure
> scsi_mpath_device to hold multipath-specific details.
> 
> Like NS structure for NVME, scsi_mpath_device holds the mpath_device
> structure to device management and path selection.
> 
> Two module params are introduced to enable multipath:
> - scsi_multipath
> - scsi_multipath_always
> 
> SCSI multipath will only be available until the following conditions:
> - scsi_multipath enabled and ALUA supported and unique ID available in
>   VPD page 83.
> - scsi_multipath_always enabled and unique ID available in VPD page 83
> 
> The scsi_device structure contains a pointer to scsi_mpath_device, which
> means whether multipath is enabled or disabled for the scsi_device.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
>
> diff --git a/include/scsi/scsi_multipath.h b/include/scsi/scsi_multipath.h
> new file mode 100644
> index 0000000000000..ca00ea10cd5db
> --- /dev/null
> +++ b/include/scsi/scsi_multipath.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _SCSI_SCSI_MULTIPATH_H
> +#define _SCSI_SCSI_MULTIPATH_H
> +
> +#include <linux/list.h>
> +#include <linux/types.h>
> +#include <linux/rcupdate.h>
> +#include <linux/workqueue.h>
> +#include <linux/mutex.h>
> +#include <linux/blk-mq.h>
> +#include <linux/multipath.h>
> +#include <scsi/scsi.h>
> +#include <scsi/scsi_cmnd.h>
> +#include <scsi/scsi_dbg.h>
> +#include <scsi/scsi_device.h>
> +#include <scsi/scsi_devinfo.h>
> +#include <scsi/scsi_driver.h>
> +
> +#ifdef CONFIG_SCSI_MULTIPATH
> +#define SCSI_MPATH_DEVICE_ID_LEN 40

Is there a reason that this is set to 40? scsi_vpd_lun_id() can return
ids larger than 40 (struct alua_port_group uses 256 bytes to hold the
response), and I don't know of any guarantee that the id will be unique
within the first 40 characters, although it certainly seems like only
pathological devices wouldn't.

-Ben

> +
> +struct scsi_mpath_device {
> +	struct mpath_device	mpath_device;
> +	struct scsi_device 	*sdev;
> +
> +	char			device_id_str[SCSI_MPATH_DEVICE_ID_LEN];
> +};
> +#define to_scsi_mpath_device(d) \
> +	container_of(d, struct scsi_mpath_device, mpath_device)
> +
> +int scsi_mpath_dev_alloc(struct scsi_device *sdev);
> +void scsi_mpath_dev_release(struct scsi_device *sdev);
> +int scsi_multipath_init(void);
> +void scsi_multipath_exit(void);
> +#else /* CONFIG_SCSI_MULTIPATH */
> +
> +struct scsi_mpath_device {
> +};
> +
> +static inline int scsi_mpath_dev_alloc(struct scsi_device *sdev)
> +{
> +	return 0;
> +}
> +static inline void scsi_mpath_dev_release(struct scsi_device *sdev)
> +{
> +}
> +static inline int scsi_multipath_init(void)
> +{
> +	return 0;
> +}
> +static inline void scsi_multipath_exit(void)
> +{
> +}
> +#endif /* CONFIG_SCSI_MULTIPATH */
> +#endif /* _SCSI_SCSI_MULTIPATH_H */
> -- 
> 2.43.5


