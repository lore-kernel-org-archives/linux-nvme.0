Return-Path: <SRS0=S+bv=NP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FFDC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 06:11:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12F8610E7
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 06:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C12F8610E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QsVM4LWHA+eZZuUISxrzrG4N8Qb1NSuBhTtwerxqlDE=; b=wg33Df2GZ8I0TN
	HJy7scsBk4inL+24AYuGK/5sj4/RJgl+Gpc5GBN06HuCbL40nhzDrOcOOhSpgLBa2tW/zqxj2w/Xy
	xcH7GrR9H8uHVMtvKLcsX0+q41RobQp0Gzypnp6dhW3Xe8GVzt0sP+cjYhTHsmbbw8zD4m0Z5bXkm
	ad6l5Q++ja+2nrTSIdIKeL+uds4sknHhjg6YPA4SwX1UQ97DWewsUjmI93yZsHmAN1lehZdu03gjH
	5UZVUnpas2qzHWliIrtDqIe4UGQSyZUEDV1Oyk0+8SK0Ds2fFqR9UIKQTjkFNSOrhWLkqBh5KcOMw
	ngYgJon2YeyJct6pHmfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIPe8-001ni5-B7; Tue, 24 Aug 2021 06:10:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIPe7-001nhF-0l
 for linux-nvme@bombadil.infradead.org; Tue, 24 Aug 2021 06:10:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=f7fH1rEvs0xJyERlr1GeZJ7G2DDZAEuI5WBFO6aM0DE=; b=IawXlIwSwAzz4WaAqpSzlEYxuz
 YiMQyUZgyoz6kZjcZVo1wk9wnfy8loh2so2h4F0X6QTyc0UumyE1gSMOAESY0Wgk9RKtw9E2EUrOJ
 IpzX0i8DVqmIyy4L3J+wUOM6gSArc/8+o1oQro7eRQSN0Mea6zOI+O+3Y5oUgqy6Iwnuk8hVd4OiB
 WcUde1NJHpd7HYCa5qUS537YP7wYEVRMGEQhPKT29n5iWmWtEy8vhDoA7iHO5dsxhIPSkBBVbRHc4
 vNKG1wE5yZW+Pua4UHYAjlWohpQHBS4ePYZdMerkcT+36IeBcq4CnFhzMNGhxfue7Y0Y8jf9L6fHL
 7+6xITiQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mIPcv-00AdX1-Qy; Tue, 24 Aug 2021 06:09:50 +0000
Date: Tue, 24 Aug 2021 07:09:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com, hch@infradead.org, hare@suse.de,
 bvanassche@acm.org, ming.lei@redhat.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
 dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] nvme: add error handling support for add_disk()
Message-ID: <YSSNIaYpUhrkvC+J@infradead.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
 <20210823202930.137278-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210823202930.137278-6-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Mon, Aug 23, 2021 at 01:29:25PM -0700, Luis Chamberlain wrote:
> +	rc = device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
> +	if (rc)
> +		goto out_cleanup_ns_from_list;
> +

Nit: no real need for the rc variable here as we never use the actual
value.

>  	if (!nvme_ns_head_multipath(ns->head))
>  		nvme_add_ns_cdev(ns);
>  
> @@ -3785,6 +3789,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>  
>  	return;
>  
> + out_cleanup_ns_from_list:
> +	down_write(&ctrl->namespaces_rwsem);
> +	list_del_init(&ns->list);
> +	up_write(&ctrl->namespaces_rwsem);

This also needs to do a nvme_put_ctrl.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
