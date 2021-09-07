Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B56C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 01:30:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B859D61057
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 01:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B859D61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=goX2EsBte3TqYbosJXSWozPKtl+KnZHFZsgNMFeUe4o=; b=D4vBhanercwVaY
	ztBAyng4ul6h2a63dHJmVFLe1AdTKP+cmeG0cPFtkjTgLcEy/8HJo1hDb5lyuxCaw/yABg6xgPEeI
	uVTatzAreyS0YZdM+JNxxHAOCMhI4tDo5mIa07bvfMNhKf8+zozOR2xiQsg/orcuschMd+R+yrGaS
	DLQ32ftIC2b2vikjTYJTqtVW2lOrnDqOituP2h5OTj9OS6Ic4hvsKVHXqrXD2g0Q4dPWDu+FaB4yd
	tBZPom8eYnXj4g+ex0KuxoEw5WtoIuGPP7lNI1t+/PlM3cOrKcUWOKld4vHQgx/TyPTZkCbP0BfAE
	v+zRWON+lM9fNgeo/wqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNPw6-002Cxm-Rv; Tue, 07 Sep 2021 01:30:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNPvd-002Cx4-Ia
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 01:29:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630978173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TKgDvqKCjC/sEBRel6+SL/8u4J2HhIt06zHYphh9H0o=;
 b=X70lgC/0/cpzFAuP7TSbx34A0SIAYhPSCifCICENEDI+AD3ZRJtYWC7llRutiSJcvn5l9x
 Cyz9/uIUpi0wsB+AZqlOiWI5XMqxGCYmQBefclwC3XuYs/XqnIoTodhzhdNemvRcT5/Bh8
 AGZtzv+msqfDeYKx/xdXKdH5f0Wpp18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-E4mwGRf4NEamNRpPjMFLvQ-1; Mon, 06 Sep 2021 21:29:32 -0400
X-MC-Unique: E4mwGRf4NEamNRpPjMFLvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0326A80124F;
 Tue,  7 Sep 2021 01:29:29 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B103271B3;
 Tue,  7 Sep 2021 01:29:06 +0000 (UTC)
Date: Tue, 7 Sep 2021 09:29:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com, hch@infradead.org, hare@suse.de,
 bvanassche@acm.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
 dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/8] scsi/sd: add error handling support for add_disk()
Message-ID: <YTbAYyo0+rqUZ+L0@T590>
References: <20210830212538.148729-1-mcgrof@kernel.org>
 <20210830212538.148729-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210830212538.148729-2-mcgrof@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210906_182937_714689_598DDD26 
X-CRM114-Status: GOOD (  19.74  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 30, 2021 at 02:25:31PM -0700, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/scsi/sd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 610ebba0d66e..8c1273fff23e 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3487,7 +3487,11 @@ static int sd_probe(struct device *dev)
>  		pm_runtime_set_autosuspend_delay(dev,
>  			sdp->host->hostt->rpm_autosuspend_delay);
>  	}
> -	device_add_disk(dev, gd, NULL);
> +
> +	error = device_add_disk(dev, gd, NULL);
> +	if (error)
> +		goto out_free_index;
> +

The error handling is actually wrong, see 

	https://lore.kernel.org/linux-scsi/c93f3010-13c9-e07f-1458-b6b47a27057b@acm.org/T/#t

Maybe you can base on that patch.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
