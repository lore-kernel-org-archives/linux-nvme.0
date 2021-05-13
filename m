Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278EFC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 01:24:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6983E613E9
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 01:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6983E613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VR3Gl4w5QzRF2ZwqaxMlruxBNAEueBdGhn+6rPiFlS8=; b=PgkoYIIry/XMUxWohn9CfVTJI
	+IYxGm4OQgRATEsv+1LTCpY3hL/RhpYowz2Hpp312MdaofuPGOftFby1/ZQ5A+uurE/R+bSYOcfEl
	Bk9W9tJTyGqRyEBDw3qJpMZ8Gum/9VQ0dC9aUoc2ckgSjL6dDLIVPHCmnsjnWVNEQaDR78ftOppdv
	v/UoV50MxzNpSZw9ZkgwTSooaN4xJuoHgjBb1rr631g38QZK0sW6DbCp4jCqAMeAW6qzuXVkmjGWE
	+E2Vwa9CkVQJHpKil5Q8oTXaZavyZgt8jPpkjZRU5+yeCJYnfN1E0+758Demn1ApPHU7QjVxNAScR
	lNT54ELDQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lh05B-004NMf-On; Thu, 13 May 2021 01:24:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lh059-004NLj-72
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 01:24:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=9ApXt0lTU+wHkW/Hw5FHEMTlgYZ3cL3RrSCxBAdJAAg=; b=4Dt019zVxNFhJeShcg7Qp7ow9E
 725qPwkBmFYAJQSWaoZdVPcu5y7xWS3m0votWh2lnbpRxUb6DFwR+bdftE346WR2eZ/mT4zEMAQQJ
 HMF5h7acnu2s/UqB2D2O8dXgyRyRhjZ8j+RWtX70zAgqd6Z2RTrzJbITQJ7accQqYRFSAdmnp4YTs
 4J0N1FE4J2TESsUnvUSLt9RWE+OjmQOKKz95CV54WrzaAhVYmhDsW1lNfhMo4s63kQlD9rnV8p+0U
 gHwOc4wZdUQkWceVwzfdhCxzRxjDc1hqMiahcDRC+J52j4RPBHl7MM80KL2y5nO4HwCOVIdy0zjjE
 hCy/kZRA==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lh056-00AxI0-I2
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 01:24:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620869042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ApXt0lTU+wHkW/Hw5FHEMTlgYZ3cL3RrSCxBAdJAAg=;
 b=ffDEAgNFyR2dlY4nld0nbbACPPtrtErBoRNEpQ4CbspcuCoS53pi4C2BmcCafA0wbEjuCJ
 ntgDXFhoAVEryn4VwIj8XOxzp6Fq33+V1XGSelS97XfWwaVvApYRP1I5uovdUOwiHKXjHn
 SHu7bsfqqjca/DWWK2/5YzohlZM1J2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-DHD9XigsNrWqitZoa_jjAA-1; Wed, 12 May 2021 21:24:00 -0400
X-MC-Unique: DHD9XigsNrWqitZoa_jjAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E60906123C;
 Thu, 13 May 2021 01:23:58 +0000 (UTC)
Received: from T590 (ovpn-12-78.pek2.redhat.com [10.72.12.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B95F56D8C2;
 Thu, 13 May 2021 01:23:47 +0000 (UTC)
Date: Thu, 13 May 2021 09:23:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 12/15] block: switch polling to be bio based
Message-ID: <YJx/nlec4yy0DHq3@T590>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-13-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210512131545.495160-13-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_182404_710321_37A989FF 
X-CRM114-Status: GOOD (  29.08  )
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

On Wed, May 12, 2021 at 03:15:42PM +0200, Christoph Hellwig wrote:
> Replace the blk_poll interface that requires the caller to keep a queue
> and cookie from the submissions with polling based on the bio.
> 
> Polling for the bio itself leads to a few advantages:
> 
>  - the cookie construction can made entirely private in blk-mq.c
>  - the caller does not need to remember the request_queue and cookie
>    separately and thus sidesteps their lifetime issues
>  - keeping the device and the cookie inside the bio allows to trivially
>    support polling BIOs remapping by stacking drivers
>  - a lot of code to propagate the cookie back up the submission path can
>    be removed entirely.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

...

> +
> +/*
> + * Helper to implement file_operations.iopoll.  Requires the bio to be stored
> + * in iocb->private, and cleared before freeing the bio.
> + */
> +int iocb_bio_iopoll(struct kiocb *kiocb, unsigned int flags)
> +{
> +	struct bio *bio;
> +	int ret = 0;
> +
> +	/*
> +	 * Note: the bio cache only uses SLAB_TYPESAFE_BY_RCU, so bio can
> +	 * point to a freshly allocated bio at this point.  If that happens
> +	 * we have a few cases to consider:
> +	 *
> +	 *  1) the bio is beeing initialized and bi_bdev is NULL.  We can just
> +	 *     simply nothing in this case
> +	 *  2) the bio points to a not poll enabled device.  bio_poll will catch
> +	 *     this and return 0
> +	 *  3) the bio points to a poll capable device, including but not
> +	 *     limited to the one that the original bio pointed to.  In this
> +	 *     case we will call into the actual poll method and poll for I/O,
> +	 *     even if we don't need to, but it won't cause harm either.
> +	 *
> +	 * For cases 2) and 3) above the RCU grace period ensures that the
> +	 * bi_bdev is still allocated, and because partitions hold a reference
> +	 * to the whole device bdev and thus disk it is still valid.
> +	 */
> +	rcu_read_lock();
> +	bio = READ_ONCE(kiocb->private);
> +	if (bio && bio->bi_bdev)
> +		ret = bio_poll(bio, flags);

The bio can be re-allocated from another IO path & bdev after checking on
bio->bi_bdev in the above code, then this bio is freed, its ->bi_bdev is freed,
same with its associated disk/hw queues/request queue.

Both bdev and request queue are freed via rcu, but disk/hw queues are freed
immediately, so there is still UAF risk in bio_poll().

Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
