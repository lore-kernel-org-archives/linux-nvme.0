Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7495AC001DE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 01:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z6WQGimvpw8I3eWQzkelPA3+R/lSG2mPQ4BbdsuaY/0=; b=SnCtK32k9ReWHP7LIC0BBhTAt8
	mIZELfTlqIStAQ3XcYTM3e9lg5hSMET+hMsY+qh/pihdulxVwEwrHif1szwOnbiL6XWyBbJ6PbpQ9
	L7MnXVUhCPs/wyRhaIhTL4dDFXitahXh1rTyWmUbyCtlk0jqUxU+mDrMhlPeJgpeIqbTUdHbKfZ14
	kHICl0mhY1EnrNFWmDog8FGHKHz08+kW6cZevrFjMfW/pMWh01lORbMVZE4iEA4O2fdOW/IIeVZeS
	2cRafsCDNfAgusab0j9SkBwhUHzKq/85W7lY7ukZPqStou6x9TtWbGRzKOepb2s+9xnmKWw4sIR0f
	cpBY/iDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTXoC-003nKa-1e;
	Wed, 09 Aug 2023 01:16:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTXoA-003nJe-0x
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 01:16:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691543777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6WQGimvpw8I3eWQzkelPA3+R/lSG2mPQ4BbdsuaY/0=;
	b=Mjs6TkB44/9x+7ktxJWRLIfhUBDsTURKb4drnGJqaGsVKlH4nduo+5lccQFzQn5tIFILw2
	AyF1b5+OnVPRuPbbr6NfgEqUGAhdC7wCKDZl3xzQyf/T1NCTc88YIKG8ODgG0Kl/m++FQm
	llMrkdlK/R4Va7dm06oO3rnenWgVeR0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-otz98xfCMmO9ly3oHNFUnA-1; Tue, 08 Aug 2023 21:16:14 -0400
X-MC-Unique: otz98xfCMmO9ly3oHNFUnA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DA178007CE;
	Wed,  9 Aug 2023 01:16:09 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DA2C492C13;
	Wed,  9 Aug 2023 01:16:02 +0000 (UTC)
Date: Wed, 9 Aug 2023 09:15:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Anuj Gupta <anuj20.g@samsung.com>, ming.lei@redhat.com
Subject: Re: [PATCH for-next v3 4/4] nvme: wire up async polling for io
 passthrough commands
Message-ID: <ZNLozRZNPJ6CVYLO@ovpn-8-17.pek2.redhat.com>
References: <20220823161443.49436-1-joshi.k@samsung.com>
 <CGME20220823162517epcas5p2f1b808e60bae4bc1161b2d3a3a388534@epcas5p2.samsung.com>
 <20220823161443.49436-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823161443.49436-5-joshi.k@samsung.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_181618_410326_F9BE29EC 
X-CRM114-Status: GOOD (  17.80  )
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

Hi Kanchan,

On Tue, Aug 23, 2022 at 09:44:43PM +0530, Kanchan Joshi wrote:
> Store a cookie during submission, and use that to implement
> completion-polling inside the ->uring_cmd_iopoll handler.
> This handler makes use of existing bio poll facility.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---

...

>  
> +int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd)
> +{
> +	struct bio *bio;
> +	int ret = 0;
> +	struct nvme_ns *ns;
> +	struct request_queue *q;
> +
> +	rcu_read_lock();
> +	bio = READ_ONCE(ioucmd->cookie);
> +	ns = container_of(file_inode(ioucmd->file)->i_cdev,
> +			struct nvme_ns, cdev);
> +	q = ns->queue;
> +	if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
> +		ret = bio_poll(bio, NULL, 0);
> +	rcu_read_unlock();
> +	return ret;
> +}

It looks not good to call bio_poll() with holding rcu read lock,
since set_page_dirty_lock() may sleep from end_io code path.

blk_rq_unmap_user
	bio_release_pages
		__bio_release_pages
			set_page_dirty_lock
				lock_page

Probably you need to move dirtying pages into wq context, such as
bio_check_pages_dirty(), then I guess pt io poll perf may drop.

Maybe we need to investigate how to remove the rcu read lock here.


>  #ifdef CONFIG_NVME_MULTIPATH
>  static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
>  		void __user *argp, struct nvme_ns_head *head, int srcu_idx)
> @@ -685,6 +721,29 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
>  	srcu_read_unlock(&head->srcu, srcu_idx);
>  	return ret;
>  }
> +
> +int nvme_ns_head_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd)
> +{
> +	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
> +	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
> +	int srcu_idx = srcu_read_lock(&head->srcu);
> +	struct nvme_ns *ns = nvme_find_path(head);
> +	struct bio *bio;
> +	int ret = 0;
> +	struct request_queue *q;
> +
> +	if (ns) {
> +		rcu_read_lock();
> +		bio = READ_ONCE(ioucmd->cookie);
> +		q = ns->queue;
> +		if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio
> +				&& bio->bi_bdev)
> +			ret = bio_poll(bio, NULL, 0);
> +		rcu_read_unlock();

Same with above.


thanks,
Ming


