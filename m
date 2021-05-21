Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797D7C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:49:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F1E6109F
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F1E6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sh3QinEOarJls8xqhxUOw1r1pSvFP5ug8b1nxgs983g=; b=yx3dEtXGfE+yHm
	LTFxCVGZSIt5NRAugmGLWeY0AnelSJSBYAtnC6glh0CD9becUtB7WVZgStRKwESh8bLPGKQgbMvgV
	JBvFEzutDq3YS3K/ThVmaJ+F+1dNRqaHy4UKYOch86+4mS00AuK7iL3Shc6J1V+Q1AbYEdncSne+f
	18/t9nkq1kgaJ3x1I8+Vk39gPgxtuREI4q7CEVPWR/pS/HiJpio+Vt/9+bfQt/xJVEqSV3c+rqs2W
	CO8pRgKLNFOLG5Gq7XUmKMPkJmh/h1XWD0gVrOO+4WgUV8HJF2p89ipdpx0B0UuUWUodNJ7JFhQCw
	u2Ov+2NvxI6SCrzyYJQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llGZl-001jse-4u; Mon, 24 May 2021 19:49:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk9C1-000Zce-0j
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 17:44:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=lcP+zO2F1IGQjzr8jBvO9rG6CcCMMr/Whp/T20TGCRM=; b=uRIe6SngE61oLufOBCGMPt0rFX
 txEBrbNRNkCU//WZhpUkSrahgJKTnLB+EfFjRoOIxuiZQmmcMRDux+lb/InjhSPpfl5hg43dY75Gv
 gpwPCph1ajbUuv0o/QsSvDdve98YA9cKxnCM/oIJ1YWBtVxCbGLMywztxfWLIffdaFPMIjttbqDW6
 7uBTTMpfEEYWRo9/Gn46VaKq/qgWZY2qguRdPr05hptZ74mRiYr7BsQO2HoWtF1auxLp3ulPmhshi
 8bnnvAvQhwxUzs0a6QZYPaRO0dX4ZaTOyv0MJ0uMJhQKB1uI/bRW6fe6DbESvcTZXk4qAZSVe40tf
 +RLAM8YQ==;
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk9By-00HK6f-Dz
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 17:44:11 +0000
Received: by mail-pg1-f181.google.com with SMTP id m124so14772241pgm.13
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 10:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lcP+zO2F1IGQjzr8jBvO9rG6CcCMMr/Whp/T20TGCRM=;
 b=Hq/oGzz3HdOse6pwC7F3MTRrARIivdrsAO4OMfSp3Xpet3CE5siY+r1c1J0+Z0Rc2R
 I/HoZB1nEau+de92I1YMbQzvP63330EFb8BbXH673CsKNfVVhW7Raba7FznjG+l9UW7N
 YmYwvpznItOV3eviiEGpC1PcwjXe69NAZ0/tSmE0UU1MtGowQetF2pew3Ftg4SQHi7Th
 LalXCUOT1TrsPU9c7AfPK/XIHUKr+MVsbek/OIoCO4Ijn3IxKQ/fFAcMA3YuRc1UIb/q
 YslokqMoX0hZtx1oHY/UurwDXK6vVF2Ro2DJ9/mJTiDlLQi6jEy02+sVQtcH2v2bMX6N
 FYJg==
X-Gm-Message-State: AOAM533066DcQ3g7xFkIcnMBa34Qn8kIeFCM35bdPdHJcdKN+30oWX4p
 VAlg1ESJAu/GPWIf7DFmEbU=
X-Google-Smtp-Source: ABdhPJx2cr14kVfs56RCS6Lg1N9a0F2CxWXa6sTYNwZ2wWHW3RuCIJw00Zxq6x/ufjwVbJsYm0Ya2A==
X-Received: by 2002:a05:6a00:15d4:b029:2de:a538:c857 with SMTP id
 o20-20020a056a0015d4b02902dea538c857mr11480779pfu.51.1621619049288; 
 Fri, 21 May 2021 10:44:09 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id o3sm4974976pgh.22.2021.05.21.10.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 May 2021 10:44:08 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id 766BF423A3; Fri, 21 May 2021 17:44:07 +0000 (UTC)
Date: Fri, 21 May 2021 17:44:07 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Jim Paris <jim@jtan.com>, Joshua Morris <josh.h.morris@us.ibm.com>,
 Philip Kelleher <pjk1939@linux.ibm.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 Matias Bjorling <mb@lightnvm.io>, Coly Li <colyli@suse.de>,
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
 Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 linux-xtensa@linux-xtensa.org, linux-m68k@vger.kernel.org,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-s390@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-bcache@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 drbd-dev@tron.linbit.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [dm-devel] [PATCH 05/26] block: add blk_alloc_disk and
 blk_cleanup_disk APIs
Message-ID: <20210521174407.GA25291@42.do-not-panic.com>
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-6-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210521055116.1053587-6-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_104410_491056_E1EE3AEF 
X-CRM114-Status: GOOD (  23.32  )
X-Mailman-Approved-At: Mon, 24 May 2021 11:59:45 -0700
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

On Fri, May 21, 2021 at 07:50:55AM +0200, Christoph Hellwig wrote:
> Add two new APIs to allocate and free a gendisk including the
> request_queue for use with BIO based drivers.  This is to avoid
> boilerplate code in drivers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c         | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/genhd.h | 22 ++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index e4974af3d729..6d4ce962866d 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1302,6 +1302,25 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
>  }
>  EXPORT_SYMBOL(__alloc_disk_node);
>  
> +struct gendisk *__blk_alloc_disk(int node)
> +{
> +	struct request_queue *q;
> +	struct gendisk *disk;
> +
> +	q = blk_alloc_queue(node);
> +	if (!q)
> +		return NULL;
> +
> +	disk = __alloc_disk_node(0, node);
> +	if (!disk) {
> +		blk_cleanup_queue(q);
> +		return NULL;
> +	}
> +	disk->queue = q;
> +	return disk;
> +}
> +EXPORT_SYMBOL(__blk_alloc_disk);

Its not obvious to me why using this new API requires you then to
set minors explicitly to 1, and yet here underneath we see the minors
argument passed is 0.

Nor is it clear from the documentation.

  Luis

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
