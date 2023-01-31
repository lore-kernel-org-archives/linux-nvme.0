Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0520C636CD
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 06:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=utT+RE/MkgWVBG/iNzPiYM+H0kp8FILH2HeviGKceUM=; b=h6Ycw5m6WmgPzqukGAYH0cT1s8
	7quLTjoyRKKsbV+qKmVxBGn3L0DR231WKwO7m97UhbSwNDrFM9pq+3YO6AiiHeFmitLlftwQwqrx4
	RKruGyZFjm96ccrme1xSdcp5Tq5E6kS473Q/4Ct6L220pKEqlHYuTibFe3OR1JbHyNFphDnY+LGId
	85snmnZkq8BpxfcOY3hvWUZsR4mVOoPFRAaJHMgkp5kRu9Sb7RkQTvz9DPfckdbYS0PtIvWmX1TxD
	ySj+JT70ZwfAnczdv9Fjbvm0fMOQ6LfRSInloXU82PqiUPxdFVaIhW4atFTlGGDX9jbaKOh/mPjJd
	3iUEUY1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMjkE-006Ndv-Hv; Tue, 31 Jan 2023 06:03:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMgSP-0065uF-P7
	for linux-nvme@lists.infradead.org; Tue, 31 Jan 2023 02:33:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675132391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utT+RE/MkgWVBG/iNzPiYM+H0kp8FILH2HeviGKceUM=;
	b=jEUbd2pMf6qKnL/Q6xk9JrNT2CEhP0YhdJClextNS8AlEoxZUTq90LVF6P9Q3R0z7C/X5g
	NnI6oAjeDl6zUh7aXrwlM0RX26FQ+xP2xEstpVCElUXRghzAtFvbsdcf5WjEEbsB1NCYqx
	Mq0G95dM2n+9NfSPExZ1aRuZIu3seyg=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-nIE5OG-vMDKZo36toHQ6BA-1; Mon, 30 Jan 2023 21:31:29 -0500
X-MC-Unique: nIE5OG-vMDKZo36toHQ6BA-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1631f1eb91aso4918363fac.18
        for <linux-nvme@lists.infradead.org>; Mon, 30 Jan 2023 18:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utT+RE/MkgWVBG/iNzPiYM+H0kp8FILH2HeviGKceUM=;
        b=Mi0TlCT+Ze/teR51BCxlBCxj0S5atNr9nIBv08VVm9zn1v/uMlsp4J2Qd6sxj3sd5B
         7jrZw20Q6Pvg1swVc/4b+zwOfzc/o8YmnV6hoXxaoUKUVnp9LJYZdqUiVi93sHlYB4jb
         1QKPbcZrEFj6IcAYVSepKsBDTKcqQoW88n1/V2lBK6UM7LuPMU5zap3EkFseefcPoLa2
         2fU/KAesR9NE9b8MIT7BswpLXJlkTPWlgqkP6aOL8hha49ED3XsR3xB5k115hF4hWbzE
         gJ6uDY+Rj/TaWOLzX+QA1WoZ54sFA4cQQ+oq+ni0yMjvSs+8C6xFbJJOTKQn9sOiJ1EX
         EREw==
X-Gm-Message-State: AFqh2kq12FYwTl/Cz2Y4150qCQthxm3NWsSR4UH0KPWKHHsUAcFiiyeo
	7YvIWvXW4Mw2q3CrO+MkXo+WMOsbte8Ne/xrVQDLs3QK1hWFRJTtzfe9g2v0Y1elnYnMeYBvbh2
	dvm3+uS01kgOqGP9o7c0zN7xI2REZWzhEv5iON8v6Uz0=
X-Received: by 2002:aca:3f84:0:b0:36e:f5f8:cce1 with SMTP id m126-20020aca3f84000000b0036ef5f8cce1mr1057782oia.35.1675132289141;
        Mon, 30 Jan 2023 18:31:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXssco6mBUOhDTHWFT4/t2hB47krC6OsHE12Ww1f+hysvA2CpNEADdT3xvxh0DzmLnnFuHE/ftXAK22WOSTVfWk=
X-Received: by 2002:aca:3f84:0:b0:36e:f5f8:cce1 with SMTP id
 m126-20020aca3f84000000b0036ef5f8cce1mr1057763oia.35.1675132288910; Mon, 30
 Jan 2023 18:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20230130092157.1759539-1-hch@lst.de> <20230130092157.1759539-23-hch@lst.de>
In-Reply-To: <20230130092157.1759539-23-hch@lst.de>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 31 Jan 2023 10:31:18 +0800
Message-ID: <CACGkMEsPvy5jVWA7AHJkyRKa8-xr9oi4DUAzBcU0pQ_n4rqCFA@mail.gmail.com>
Subject: Re: [PATCH 22/23] vring: use bvec_set_page to initialize a bvec
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Xiubo Li <xiubli@redhat.com>, 
	Steve French <sfrench@samba.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, Mike Marshall <hubcap@omnibond.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-block@vger.kernel.org, 
	ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, devel@lists.orangefs.org, io-uring@vger.kernel.org, 
	linux-mm@kvack.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_183313_899057_18ECCC99 
X-CRM114-Status: GOOD (  20.04  )
X-Mailman-Approved-At: Mon, 30 Jan 2023 22:03:19 -0800
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

On Mon, Jan 30, 2023 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use the bvec_set_page helper to initialize a bvec.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

A typo in the subject, should be "vringh".

Other than this

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vhost/vringh.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 33eb941fcf1546..a1e27da544814a 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1126,9 +1126,8 @@ static int iotlb_translate(const struct vringh *vrh,
>                 size = map->size - addr + map->start;
>                 pa = map->addr + addr - map->start;
>                 pfn = pa >> PAGE_SHIFT;
> -               iov[ret].bv_page = pfn_to_page(pfn);
> -               iov[ret].bv_len = min(len - s, size);
> -               iov[ret].bv_offset = pa & (PAGE_SIZE - 1);
> +               bvec_set_page(&iov[ret], pfn_to_page(pfn), min(len - s, size),
> +                             pa & (PAGE_SIZE - 1));
>                 s += size;
>                 addr += size;
>                 ++ret;
> --
> 2.39.0
>


