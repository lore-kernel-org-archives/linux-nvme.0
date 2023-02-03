Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF33C05027
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=piXirJB1ocWVRzhs3blzzKk9+m92CHpoGy9Z2k+SCeM=; b=Uak6xBy1HhfIdud3hUmE5DjMLG
	nV7hPLSoQHMkdkSzPXIZtkTN+FuUz1YRB5gST8ZMUA5/XOYYM9ceET3ghU9DOeeWvCSbX3YrLT9yu
	tHG+ezqhxO0LhM2VUUTHq54aFsGqRvu1xR1mT0d1cF91VZZiVKi7HwSCTsvH9Eg1bKrDPtQFqGht8
	G9xe66lTgSM1Idlrq2UDDP+DP19hh8pzNhM5uB6yH5ADqwylNZXamGiha4no2a7JZA4J9c89bZ9AW
	5nfHxTatFSIM9oqOyjEj9duof5bNZGEgJEc80zahWzrjBhSaDcbHnrrFIRe1A86aVbB894G9iqle7
	rTCB3dSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNzeP-0033R6-KO; Fri, 03 Feb 2023 17:15:01 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNze2-0033Lt-04; Fri, 03 Feb 2023 17:14:39 +0000
Received: by mail-ej1-x635.google.com with SMTP id ud5so17213800ejc.4;
        Fri, 03 Feb 2023 09:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=piXirJB1ocWVRzhs3blzzKk9+m92CHpoGy9Z2k+SCeM=;
        b=Fb0zwCwCJOeiTQEIlhQwff7G7k9ElObO1R+33i0wPXCrqwIBrpEt840BslhPeWvhej
         RNm1AhkBApvOqVaG8WlS647E04HIjv8QXHbrx4efowZpI0TaabZ8LMgSoh/aq8KjxxRH
         ymR8pWmWjw/LsMUWJ9rofMDzzzyZxS3bG6pr5yuXBaSNOMLnBMDA9JK7UsqZLm4fTbdz
         3JONOsnKCVpep3uis1ESPNXO4PXE5PboF2NqB2yAqmji5Wmfqm6IMWogBRXHCGUo+evy
         5FIXmxmK0Q+tgY6yH5xQu0jB1ogx5Xoz2NijnyXZiUzSOhVkO+fo8Fi/9WHvdy2fnh/f
         yg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piXirJB1ocWVRzhs3blzzKk9+m92CHpoGy9Z2k+SCeM=;
        b=l2NCpzi3eZNo0fb77UEp5bYtTUaWs6NQpBN94KlPOhq+JOF5pm4dGZ6Z4sOS+UtA85
         d53S5dDh6hDtQlYsIYmpWJjnc5H6x8bZ4APpep3Dp+4Y9koVU/+6sM2hGLZFTmdiswzw
         Gbt4c3dUl6kcIunSKr4BOx++Whkd+i9W8A2qa1Azaxcv+mADJ/n1Dv4x2x9VxqcQYvid
         1TsVmXHUMOSOXnyU2uI6NBDOii39Aq3aELM9ZPRAg1MftuUhrgzM6ff2V/ZpT6FZu52s
         XpZZvSTsmLc9lE8QyBGoOrvYf/zwqBo9/xX7lBYjURP7XBSbft/eTM8cflMMCcoc98Ae
         M4HA==
X-Gm-Message-State: AO0yUKU3fXIr5QP8iEDi66ZLkyzdKRIFjfRmz1gY2k572Sa6yVeptbZ2
	Eas9kzJmkT+7mzCKlipiIcwCiM2Bj5GBF6kJfrK9UVrT1VrlNA==
X-Google-Smtp-Source: AK7set/+j+io9+OTuTc3zxO0OENdkhbzE8/JIAWcegXUIkecBeeVYLPG3d1104QBp1VROkgVOtVScA3k2o3zdZ2WZFo=
X-Received: by 2002:a17:907:9917:b0:878:5f93:e797 with SMTP id
 ka23-20020a170907991700b008785f93e797mr2680768ejc.4.1675444473257; Fri, 03
 Feb 2023 09:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20230203150634.3199647-1-hch@lst.de> <20230203150634.3199647-13-hch@lst.de>
In-Reply-To: <20230203150634.3199647-13-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 3 Feb 2023 18:14:21 +0100
Message-ID: <CAOi1vP-HNmphq-_KakcGnmGYDY3rWbqmu0vWWS9vmYMLxgj1DQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20230203_091438_091596_0B22F361 
X-CRM114-Status: GOOD (  17.07  )
X-Mailman-Approved-At: Fri, 03 Feb 2023 09:15:00 -0800
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

On Fri, Feb 3, 2023 at 4:07 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use the bvec_set_page helper to initialize a bvec.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ceph/file.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 764598e1efd91f..90b2aa7963bf29 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -103,14 +103,10 @@ static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
>                 size += bytes;
>
>                 for ( ; bytes; idx++, bvec_idx++) {
> -                       struct bio_vec bv = {
> -                               .bv_page = pages[idx],
> -                               .bv_len = min_t(int, bytes, PAGE_SIZE - start),
> -                               .bv_offset = start,
> -                       };
> -
> -                       bvecs[bvec_idx] = bv;
> -                       bytes -= bv.bv_len;
> +                       int len = min_t(int, bytes, PAGE_SIZE - start);
> +
> +                       bvec_set_page(&bvecs[bvec_idx], pages[idx], len, start);
> +                       bytes -= len;
>                         start = 0;
>                 }
>         }
> --
> 2.39.0
>

Reviewed-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya

