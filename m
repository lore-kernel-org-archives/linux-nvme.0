Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9EEFD45F9
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 02:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hJmYuxjS0nD2lV0lsEQm+chlolOaID++/wSzcaTxkiM=; b=tewE6eHCBTx1iPH51fverTxg6N
	D+omWFkAB6KfhKHdKN2aBwSTIYlSV04S3UmFOFvy/Ge1dTc3gXf+STpfjJ7GB3bqbc65r7RsAfb69
	kQM+0yRTUN9AFGY2gQc3gidQQzC1LoC5+mnBPrt53RR3B6hcc72Ej/btJXjBJ8XU+SKKApUtOCDiJ
	5swLuPecjzKTHvfi4rUoHpBCELS2YTON3KPjjmYdibOmTqHUIapjOpWAFIylCAklzjA9xJffeebmv
	8eZy9CryjWzCQAnYKsFZnFUF9o6IF2lfE16nhS7nT9ASKN0+EBeiInYruMCfjjuPl4bW1UryzdFpG
	43Qsnx/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvQvf-00000005ELg-311M;
	Thu, 26 Feb 2026 02:16:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvQvd-00000005ELK-140b
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 02:16:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772072194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJmYuxjS0nD2lV0lsEQm+chlolOaID++/wSzcaTxkiM=;
	b=gI+pPS8SRqeg08WWx13yJ73L3LDIxGMj9rNnGfNgeHyh0Gx0iMvE7x1GJLRdkF6LiWU6/Y
	fs+EOo0uN+V0eHafSa58QHHlMySXp1thsXD/nruIIHArDWFuO9dhGjhvwvavw43sHkV8e6
	b0KDp4xSqFT987vTx0jw4B/otJl8oU4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-kv6YtGLNMKaescy-QcRm1g-1; Wed,
 25 Feb 2026 21:16:30 -0500
X-MC-Unique: kv6YtGLNMKaescy-QcRm1g-1
X-Mimecast-MFC-AGG-ID: kv6YtGLNMKaescy-QcRm1g_1772072188
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDDCC180057E;
	Thu, 26 Feb 2026 02:16:27 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA4D13003D88;
	Thu, 26 Feb 2026 02:16:26 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 61Q2GPtm1678244
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 21:16:25 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 61Q2GO3e1678243;
	Wed, 25 Feb 2026 21:16:24 -0500
Date: Wed, 25 Feb 2026 21:16:24 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] libmultipath: Add basic gendisk support
Message-ID: <aZ-s-JNWBOA1xqVG@redhat.com>
References: <20260225153225.1031169-1-john.g.garry@oracle.com>
 <20260225153225.1031169-3-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20260225153225.1031169-3-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 2XWEWJ6qFVHm1oOX2vBEpAulVAj0JhPA_Hnej-fWyIQ_1772072188
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_181637_359926_EF5393E7 
X-CRM114-Status: GOOD (  14.36  )
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

On Wed, Feb 25, 2026 at 03:32:14PM +0000, John Garry wrote:
> Add support to allocate and free a multipath gendisk.
> 
> NVMe has almost like-for-like equivalents here:
> - mpath_alloc_head_disk() -> nvme_mpath_alloc_disk()
> - multipath_partition_scan_work() -> nvme_partition_scan_work()
> - mpath_remove_disk() -> nvme_remove_head()
> - mpath_device_set_live() -> nvme_mpath_set_live()
> 
> struct mpath_head_template is introduced as a method for drivers to
> provide custom multipath functionality.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
> +
> +void mpath_device_set_live(struct mpath_disk *mpath_disk,
> +			struct mpath_device *mpath_device)
> +{
> +	struct mpath_head *mpath_head = mpath_disk->mpath_head;

You're dereferencing mpath_disk here, before the check if it's NULL.

-Ben

> +	int ret;
> +
> +	if (!mpath_disk)
> +		return;
> +
> +	if (!test_and_set_bit(MPATH_HEAD_DISK_LIVE, &mpath_head->flags)) {
> +		dev_set_drvdata(disk_to_dev(mpath_disk->disk), mpath_disk);
> +		ret = device_add_disk(mpath_disk->parent, mpath_disk->disk,
> +				mpath_head->mpdt->device_groups);
> +		if (ret) {
> +			clear_bit(MPATH_HEAD_DISK_LIVE, &mpath_head->flags);
> +			return;
> +		}
> +		queue_work(mpath_wq, &mpath_disk->partition_scan_work);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(mpath_device_set_live);
> +
>  struct mpath_head *mpath_alloc_head(void)
>  {
>  	struct mpath_head *mpath_head;
> -- 
> 2.43.5


