Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FE1C54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=URESPY8B3rO6+zudqQ9a2I8Kc4P4ekxUO74igKr3Ygk=; b=dICROmqcGuBuL8xa+BrgAnBp7g
	fvTGs2udm0hxb+oybdHL1B/tSMr+Z/nzKZZXKOmM6cgjIzpPmb/DuzWJR4Tmg23IcJpZNAaqBT7Vd
	CwW7V319zw0WsqeK3Ls/3Znm1/ROubA8aK6ZnOWGynQ5Tw9HJKxP4yksXVb7ClnJJIVapfwjDFeIR
	L3KDrHO4Tmc/YGLx3o4I2qsIoYwGe0utYDbEUl2swgWFrWzlxplvcMbfo/5v6/T/gqcQGDUTE3bow
	ooWqiwkXJAReYhuk1ekNO8fSeXSB1diiZ8O2gG1w2mqa3WUI+Y7MiLl3E7qUI0PcR0noWG2k7wCYA
	kgwi7R0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMVxS-0040B0-Va; Mon, 30 Jan 2023 15:20:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMVv7-003zir-SQ
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 15:18:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675091888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URESPY8B3rO6+zudqQ9a2I8Kc4P4ekxUO74igKr3Ygk=;
	b=LYj3dWN8F+7XqFa16uGwGmwWWGfX+GbOS/LpjPtQ51Nx3nd2LHEydaiX91f44faRkaSC3Y
	R1uYLyk+HJyS749bPI3PX+GLKHIIQK2zZKAWQigAJf3Krd7mm3FC533PhAHz4V/m1FF6vY
	GblLzMbtXXNZLMfRXFmhxX77Mxpkeew=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-125-t2AFO8AROI6q5Antz8dKLw-1; Mon, 30 Jan 2023 10:18:07 -0500
X-MC-Unique: t2AFO8AROI6q5Antz8dKLw-1
Received: by mail-wm1-f72.google.com with SMTP id l8-20020a05600c1d0800b003dc25f6bb5dso7744808wms.0
        for <linux-nvme@lists.infradead.org>; Mon, 30 Jan 2023 07:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URESPY8B3rO6+zudqQ9a2I8Kc4P4ekxUO74igKr3Ygk=;
        b=M2zAKpZMojwPTnHNvfJgy/qUV8J3a0Ke1v7P5/9ogTPNRILEX59EcGRwAqq5z+7nHT
         j8Bi9RH3qvFq+hzzp5WK02VJrpZ5EnnYOgm+OwyktfoQdHg47nFcjVq9D1sOA2jkSxDq
         OPczCXCx4JZmGE55Hgf2XavJusSKtGA0dmn6kY0xRLAYQjOFup73PTmcYDPUygkrLjID
         44I4TXpuhdkpegpk0h8ffmUE1BK4tS9OVK5qDKhzHt/m5cb0GmyrUKKbKPENwuXb+CLJ
         EXVh9DxBQzkaylStKlZ1uexbZ9wWXAvKs3kkxhr2vQX3QrSPV76ed4Obv394uCFt2Lk4
         043Q==
X-Gm-Message-State: AO0yUKWFohp30rLJDIqeCGAO/ruQmG1gs0+3AObdXtpFr23d0XVFkPQ/
	t0KxZghVe77YB4LGtC+XrWQKbTSvOuqF/1JFRvvnfs72uNBS0EQxP5DbBPT16PZwz+B3yHowAKk
	cbVjKKYtKkRMEZvemYEK921ET090=
X-Received: by 2002:a05:6000:1105:b0:2bf:b77c:df72 with SMTP id z5-20020a056000110500b002bfb77cdf72mr16512226wrw.25.1675091885693;
        Mon, 30 Jan 2023 07:18:05 -0800 (PST)
X-Google-Smtp-Source: AK7set9hHGYe0bnBQdwa2LZ/rAVCRbopEtGk+crtv3OHnMIQTfwimU+PtBLrc1/FzlqOKTq9Gtug2w==
X-Received: by 2002:a05:6000:1105:b0:2bf:b77c:df72 with SMTP id z5-20020a056000110500b002bfb77cdf72mr16512171wrw.25.1675091885371;
        Mon, 30 Jan 2023 07:18:05 -0800 (PST)
Received: from redhat.com ([2.52.144.173])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d48c6000000b002bfc0558ecdsm11985935wrs.113.2023.01.30.07.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:18:04 -0800 (PST)
Date: Mon, 30 Jan 2023 10:17:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>,
	Jason Wang <jasowang@redhat.com>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Steve French <sfrench@samba.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-block@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	devel@lists.orangefs.org, io-uring@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 09/23] virtio_blk: use bvec_set_virt to initialize
 special_vec
Message-ID: <20230130101747-mutt-send-email-mst@kernel.org>
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-10-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20230130092157.1759539-10-hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_071810_013379_770B05A5 
X-CRM114-Status: GOOD (  19.21  )
X-Mailman-Approved-At: Mon, 30 Jan 2023 07:19:29 -0800
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

On Mon, Jan 30, 2023 at 10:21:43AM +0100, Christoph Hellwig wrote:
> Use the bvec_set_virt helper to initialize the special_vec.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/block/virtio_blk.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6a77fa91742880..dc6e9b989910b0 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -170,9 +170,7 @@ static int virtblk_setup_discard_write_zeroes_erase(struct request *req, bool un
>  
>  	WARN_ON_ONCE(n != segments);
>  
> -	req->special_vec.bv_page = virt_to_page(range);
> -	req->special_vec.bv_offset = offset_in_page(range);
> -	req->special_vec.bv_len = sizeof(*range) * segments;
> +	bvec_set_virt(&req->special_vec, range, sizeof(*range) * segments);
>  	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
>  
>  	return 0;
> -- 
> 2.39.0


