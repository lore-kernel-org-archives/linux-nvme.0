Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7CFC54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 18:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2e4q4vLnV4kvKyozPY83n3uJMaYkgSTzaraxFCK6VlE=; b=0APPdShAw50679PuageiQJ40eN
	WPmYpqQAVIP5aEuqX7MrGdTXf/nG1gTx6Umxv5bbT6ohQ0H66hVudipsbd1qHXkC7rZA3iYscrkgF
	3VqpKKN5UdCLUdL3a5xc1OFgia0kCrFySplwcrqUNogIKbVaYGiLNxRTsMN3lYs2h2Ka8QI2DElRn
	P5wVHLOznBBstLRASyPRXHwoqsQkmeBt/V/fKYzeKN1CnOft+yLzb3CXS9eVf/9hFlKgXbINyHk9H
	mMtIoCdkrLvYy2nLP1t1GW0qOs8Ts9Hs4mpxWYIZXaRV3hTzvmnB/aMKin3rOWo2Ll4UvSVkr5K2Q
	DBxvpdpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMYdT-004sGv-4H; Mon, 30 Jan 2023 18:12:07 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMYU3-004oA9-7U; Mon, 30 Jan 2023 18:02:24 +0000
Received: by mail-ej1-x629.google.com with SMTP id dr8so12611409ejc.12;
        Mon, 30 Jan 2023 10:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2e4q4vLnV4kvKyozPY83n3uJMaYkgSTzaraxFCK6VlE=;
        b=QjPHN5B6CALVYF8eJzNIPsG0g1pzceiE2hsCvWmpJNAGD1vrWbJvCZeCcjQ6eADy7X
         +rHhPzs8YzfZY27hQrxxOVws+NeMmpQzs2dZvJyF9ePDcY6pL5qFpcxv6Z3gjK7XJP8V
         cByRrvJBuUR2bPrhmi5d/WnmANG7Y6jQK9ldIaDSqBxh3ID4IGOHEOX0TaogXKy8B68f
         YdGt9CF227lvD+bRgHbXuA/ANtLnfNmLv2C8td08GoyJe+3J4zL8gQFKZUR4Wjx07grD
         jmy6zNmOrRAYNi0zk7CarTBn76RGSVuzRP3TFEnE334v1V1ZIQxbXypKDzhXSbc1rITc
         v3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2e4q4vLnV4kvKyozPY83n3uJMaYkgSTzaraxFCK6VlE=;
        b=F4tHM3q+/GgCz5L5UG8PYLmehm8xxKFq57h9Mxg5O0cu8M4NV1qsmEbcVXvdy20wWB
         7ZRHXWg9hW1wHkrlAJRyvlXJLdV8Xp1b3KNfDVitjlIyZCIwQA8huQGQwgmo5LEX1UkH
         G7sEua/bqDBOu0kKdMQwx1pdZvCAyx9866QAWsTDN1cEPjiH/7wU5JxnnWs3cwVzKBUe
         JzdhhB4mxpOgQ3ZbaGQTbOrmNszyy1NFIoxoObbbZj/CPQhuLMns0pWhDAG5k1uxLZnA
         Pt2EpQLnVNX29asMBCfOKRqVaJh0IHi1p3W9YML5/ngB0VZVxr4ggYSFUD+5VJGhYNqr
         /y0w==
X-Gm-Message-State: AFqh2kqvHTq7Pi7mGJm/LZhq7SYvzKpu1fies+hEeToa0bfiYXYV/4ua
	exvxjmOdJArSHYtF98AD5biFrUwim8OyyKhJzzM=
X-Google-Smtp-Source: AMrXdXt2v8RXnqr0n63brJW64DYfr9lJj0iX+IQ07lAj+juWDoh3rFhuQaZ3DIDSg0TjGFzZmicnL1ZkcXc8EtRtQFI=
X-Received: by 2002:a17:906:7754:b0:86f:2cc2:7028 with SMTP id
 o20-20020a170906775400b0086f2cc27028mr7689625ejn.133.1675101740519; Mon, 30
 Jan 2023 10:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20230130092157.1759539-1-hch@lst.de> <20230130092157.1759539-13-hch@lst.de>
In-Reply-To: <20230130092157.1759539-13-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 30 Jan 2023 19:02:08 +0100
Message-ID: <CAOi1vP_b77Pq=hYmFMi1zGGRMee2uNjbAbHz_gCCoByOdbRqLw@mail.gmail.com>
Subject: Re: [PATCH 12/23] ceph: use bvec_set_page to initialize a bvec
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Xiubo Li <xiubli@redhat.com>, Steve French <sfrench@samba.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-block@vger.kernel.org, 
	ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, devel@lists.orangefs.org, io-uring@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_100223_313238_B7E68FF3 
X-CRM114-Status: GOOD (  18.68  )
X-Mailman-Approved-At: Mon, 30 Jan 2023 10:11:00 -0800
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

On Mon, Jan 30, 2023 at 10:22 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use the bvec_set_page helper to initialize a bvec.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ceph/file.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 764598e1efd91f..6419dce7c57987 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -103,11 +103,11 @@ static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
>                 size += bytes;
>
>                 for ( ; bytes; idx++, bvec_idx++) {
> -                       struct bio_vec bv = {
> -                               .bv_page = pages[idx],
> -                               .bv_len = min_t(int, bytes, PAGE_SIZE - start),
> -                               .bv_offset = start,
> -                       };
> +                       struct bio_vec bv;
> +
> +                       bvec_set_page(&bv, pages[idx],

Hi Christoph,

There is trailing whitespace on this line which git complains about
and it made me take a second look.  I think bvec_set_page() allows to
make this more compact:

        for ( ; bytes; idx++, bvec_idx++) {
                int len = min_t(int, bytes, PAGE_SIZE - start);

                bvec_set_page(&bvecs[bvec_idx], pages[idx], len, start);
                bytes -= len;
                start = 0;
        }

Thanks,

                Ilya

