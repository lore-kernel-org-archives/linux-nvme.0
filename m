Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516C5E67A6C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 05:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rk8SfGWznxs8PCnNuzIOKZoorLz2mCPwrChTHvdhTxs=; b=kxkZdX5gC+iFLGUmCKqirp29GA
	QsOjTbehID1DqtqYTpbp+Vk/t77X66DlyaNN3rheqUOgLjeLzv6FqKU+4IacYRaWsTucyUwMTrY3I
	bYQoFgcEnhaPMXuus5iUipsJm0rIZpYQJJsQvxq8jeCcx9xSSMsrhx+UVGcjuMGKsUhiyxnt8QR56
	rbjbz6Ofjsw9Fav3BQRZOOtFPwQtojHVafEmQeu1rUVVh/7Iw2q7ONdDwT7pVNIufF5/0sBIKcg7y
	visrjNiNtMA6JPYd1C94IfdKm4LBDu4aCfn+4AYuXAOoWe8IAK8o7CGIBoI5HVFR80cSE17ZI5Aih
	qFfkR8iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxIMc-0000000EY9Q-0HjZ;
	Tue, 03 Mar 2026 05:32:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxIMZ-0000000EY80-2JCW
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 05:32:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772515924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rk8SfGWznxs8PCnNuzIOKZoorLz2mCPwrChTHvdhTxs=;
	b=RbCZuarlyQ3gtp7fzfHNT0OEaXnjnAkRei2iSC2WkhnJBkj0IgNlMdSwuc/mFiA4Gex3mV
	jTigZGE1wvbYFkHEUjre6JpLVfgnk83dR97X/WpQtMVCiKkxOIicS8Pu6rFddY3Sx+pqR2
	CSpxf/9/I1zhdEvJTUgdZY1CD9XgjQM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-3y5x-f46Mfu3DVitalfYUw-1; Tue,
 03 Mar 2026 00:31:59 -0500
X-MC-Unique: 3y5x-f46Mfu3DVitalfYUw-1
X-Mimecast-MFC-AGG-ID: 3y5x-f46Mfu3DVitalfYUw_1772515917
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81A4119560B2;
	Tue,  3 Mar 2026 05:31:55 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A608130001B9;
	Tue,  3 Mar 2026 05:31:53 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 6235VqTB1875154
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 3 Mar 2026 00:31:52 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 6235Vp3B1875151;
	Tue, 3 Mar 2026 00:31:51 -0500
Date: Tue, 3 Mar 2026 00:31:51 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/24] scsi-multipath: provide callbacks for path state
Message-ID: <aaZyR5FZJRbbwdI-@redhat.com>
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-13-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20260225153627.1032500-13-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Ab5sLFEUudnLvPYC6eZM7b0cDA1MEoMsaf3Bk-Tlw_c_1772515917
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_213207_668615_6F5C31F8 
X-CRM114-Status: GOOD (  18.65  )
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

On Wed, Feb 25, 2026 at 03:36:15PM +0000, John Garry wrote:
> Until ALUA is supported, just always say that the path is optimized. In
> addition, just add basic scsi_device state tests for checking on path
> state.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/scsi/scsi_multipath.c | 45 +++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
> index 36f13605b44e7..6aeac20a350ff 100644
> --- a/drivers/scsi/scsi_multipath.c
> +++ b/drivers/scsi/scsi_multipath.c
> @@ -340,8 +340,53 @@ static int scsi_mpath_ioctl(struct block_device *bdev,
>  	return err;
>  }
>  
> +static bool scsi_mpath_is_disabled(struct mpath_device *mpath_device)
> +{
> +	struct scsi_mpath_device *scsi_mpath_dev =
> +				to_scsi_mpath_device(mpath_device);
> +	struct scsi_device *sdev = scsi_mpath_dev->sdev;
> +	enum scsi_device_state sdev_state = sdev->sdev_state;
> +
> +	if (sdev_state == SDEV_RUNNING || sdev_state == SDEV_CANCEL)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool scsi_mpath_is_optimized(struct mpath_device *mpath_device)
> +{
> +	if (scsi_mpath_is_disabled(mpath_device))
> +		return false;
> +	return true;
> +}
> +
> +/* Until we have ALUA support, we're always optimised */
> +static enum mpath_access_state scsi_mpath_get_access_state(
> +				struct mpath_device *mpath_device)
> +{
> +	if (scsi_mpath_is_disabled(mpath_device))
> +		return MPATH_STATE_INVALID;
> +	return MPATH_STATE_OPTIMIZED;
> +}
> +
> +static bool scsi_mpath_available_path(struct mpath_device *mpath_device, bool *available)
> +{
> +	struct scsi_mpath_device *scsi_mpath_dev =
> +				to_scsi_mpath_device(mpath_device);
> +	struct scsi_device *sdev = scsi_mpath_dev->sdev;
> +
> +	if (scsi_device_blocked(sdev))
> +		return false;
> +
> +	return scsi_device_online(sdev);
> +}

Here's another vote for redoing the mpath_available_path() interface.
scsi_mpath_available_path() is already ignoring the available pointer,
and treating the return value like it determines whether the path is
available.

-Ben


