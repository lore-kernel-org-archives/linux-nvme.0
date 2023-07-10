Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9253EB64DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dcqwH1JHB/zMyfnzLAkQxVrnbSRsy6dRa4E0txqsIQs=; b=1Hq5cr6fJAetykxjzkh4D7bWz2
	YUFpjwirQCe3SOo513xRHkQURJxm1Q4OkiG5TFbd+NKzEZ2Fibc/I1hUUqm8x6w4qjnfjs7futY6w
	AZ0iRxBWRhPv7mu9Te0BpZN34gdBciV7Cci3N+M/YBNpBDRWkLCbPzxNtOqwLlSpELM8hhSHUiuIf
	p4zWMgpKB+vo1uBSiaxWgv34wfJzCbX8bip9P/+8jyJqr9DYUCJ5QITMV+hPbtMCg8Mio3V+DvYI0
	uaUywSNWvZYhwN0485pqcdp3DcCy9zcxQs9hrekPzLAE1/5J/tQvsaCupsX8SMPzKnfdxI4B7eMki
	cmwDc24w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIoM3-00BL8E-35;
	Mon, 10 Jul 2023 10:42:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIoM1-00BL5F-0w
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 10:42:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688985771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dcqwH1JHB/zMyfnzLAkQxVrnbSRsy6dRa4E0txqsIQs=;
	b=Yao5EYyw67DwO4wlyqPOLgjfDoo4z/DN/Q3ZIZXsEsJRsopKba5XFM1j6y8fVnJx8YkPAJ
	jzVfltJhG6KEXYyHRSmZYrMLaEw/d9owpo0l8qdI9l4g0nPdr6ocXkmBCdJ6soE+6y7cr5
	a0wjIBcaDhrObzY19t93h1VJJsw/Jxg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-NwoKJUS-OB6gnRBBDCzZ2Q-1; Mon, 10 Jul 2023 06:42:46 -0400
X-MC-Unique: NwoKJUS-OB6gnRBBDCzZ2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DEFC2999B20;
	Mon, 10 Jul 2023 10:42:45 +0000 (UTC)
Received: from ovpn-8-33.pek2.redhat.com (ovpn-8-33.pek2.redhat.com [10.72.8.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6960FC09A09;
	Mon, 10 Jul 2023 10:42:41 +0000 (UTC)
Date: Mon, 10 Jul 2023 18:42:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, ming.lei@redhat.com
Subject: Re: [PATCH 1/4] block: don't unconditionally set max_discard_sectors
 in blk_queue_max_discard_sectors
Message-ID: <ZKvgnI5qZ/Z70ycL@ovpn-8-33.pek2.redhat.com>
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707094616.108430-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_034253_403444_F57E8CFA 
X-CRM114-Status: GOOD (  22.56  )
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

On Fri, Jul 07, 2023 at 11:46:13AM +0200, Christoph Hellwig wrote:
> max_discard_sectors is split into a hardware and a tunable value, but
> blk_queue_max_discard_sectors sets both unconditionally, thus dropping
> any user stored value on a rescan.  Fix blk_queue_max_discard_sectors to
> only set max_discard_sectors if it either wasn't set, or the new hardware
> limit is smaller than the previous user limit.
> 
> Fixes: 0034af036554 ("block: make /sys/block/<dev>/queue/discard_max_bytes writeable")

It is hard to say a fix, given discard_max_bytes can still be changed
by kernel. I'd suggest to document this behavior in Documentation/ABI/stable/sysfs-block.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-settings.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 0046b447268f91..978d2e1fd67a51 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -179,7 +179,9 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>  		unsigned int max_discard_sectors)
>  {
>  	q->limits.max_hw_discard_sectors = max_discard_sectors;
> -	q->limits.max_discard_sectors = max_discard_sectors;
> +	if (!q->limits.max_discard_sectors ||
> +	     q->limits.max_discard_sectors > max_discard_sectors)
> +		q->limits.max_discard_sectors = max_discard_sectors;
>  }

Userspace may write 0 to discard_max_bytes, and this patch still can
override user setting.

Thanks,
Ming


