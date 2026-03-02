Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A042D58E4D
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 02:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ubPJujatj4+N2BOY/aHQ9FwR3IIuPKfIVVUU3eyTFAA=; b=KAf5zIAKPJpH4yVSDF7jkM3VBf
	0W/KKMYb1HHOOO6qkUpv3ueiJibXRROWsLNdAiUojlvLjwSCHfqMCoJ/FCKFVjkP2IHW+6+T3kwuM
	PY/15/UXpMKRjgs3QgvfFn52RYr9JDuI+D26UVaheDO7NNVKlWsUWEip5pd9YsugKYoeqPQkQOjFh
	gkchgF8f4gTjxwmcAlwud1Dgkd4nzcQZxW4iNRMWzMzpadaAsFzDmrTFd37htJLm8WeOyaFo28NUN
	wyfE9DgS+HaYjnwBcbBIGMmdyewiUOYo4PmkVN28nQRlU0oTTDe3QIIsiTcAmwleCvb8tVwhSdUre
	VA1ysQ+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwsvJ-0000000C7Bt-25qa;
	Mon, 02 Mar 2026 02:22:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwsvG-0000000C7Ai-3sm3
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 02:22:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772418133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ubPJujatj4+N2BOY/aHQ9FwR3IIuPKfIVVUU3eyTFAA=;
	b=SLtGqzpBHo08iHkWdqthMUZlAHyoblkj7SByCnXcpyNNuUoptarGeeQzi4XURoO9W/n+Dz
	GkW8FgFfAfMttS61cMGU1KvVdWZu8iPvbHWJG0pXNlGIGIovDgDvsMxrvynCWXyWnsapPf
	u7YyeWtN1g5R7hunOGAL7EpTzSEoT0o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-grVdMD9COr6kZybo6HGCZw-1; Sun,
 01 Mar 2026 21:22:10 -0500
X-MC-Unique: grVdMD9COr6kZybo6HGCZw-1
X-Mimecast-MFC-AGG-ID: grVdMD9COr6kZybo6HGCZw_1772418128
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07C2F18003F5;
	Mon,  2 Mar 2026 02:22:07 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C3CA1800666;
	Mon,  2 Mar 2026 02:22:06 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 6222M5DR1829264
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 1 Mar 2026 21:22:05 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 6222M5SK1829263;
	Sun, 1 Mar 2026 21:22:05 -0500
Date: Sun, 1 Mar 2026 21:22:05 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/24] scsi-multipath: introduce basic SCSI device support
Message-ID: <aaT0Taxs6WgX6m-j@redhat.com>
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-3-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20260225153627.1032500-3-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: vKwSMXju37PzJKZCxvXGs2TaRoKLt92GKn7CrtT20-s_1772418128
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_182215_039507_406FD70C 
X-CRM114-Status: GOOD (  21.09  )
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
> ---
>  drivers/scsi/Kconfig          |  10 +++
>  drivers/scsi/Makefile         |   1 +
>  drivers/scsi/scsi.c           |   8 +-
>  drivers/scsi/scsi_multipath.c | 158 ++++++++++++++++++++++++++++++++++
>  drivers/scsi/scsi_scan.c      |   4 +
>  drivers/scsi/scsi_sysfs.c     |   2 +
>  include/scsi/scsi_device.h    |   2 +
>  include/scsi/scsi_multipath.h |  55 ++++++++++++
>  8 files changed, 239 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/scsi/scsi_multipath.c
>  create mode 100644 include/scsi/scsi_multipath.h
> 
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 19d0884479a24..cfab7ad1e3c2c 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -76,6 +76,16 @@ config SCSI_LIB_KUNIT_TEST
>  
>  	  If unsure say N.
>  
> +config SCSI_MULTIPATH
> +	bool "SCSI multipath support"

At least until this supports ALUA, it should probably be marked
EXPERIMENTAL, just so people trying it out aren't surprised if it
doesn't multipath their device in the way they expect.

-Ben


