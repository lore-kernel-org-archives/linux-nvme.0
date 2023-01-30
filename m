Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F56DC636CD
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 06:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9FE8Tg/ETfLF2znBVGSneSNpDHtD4K+4dzhis/koiic=; b=phfQXx9Q9cEzPB6V9f8af2i2C1
	hJ8mHrWY/ochnkmgkywg/4oS8P6BpIJamrcYrlMG1x7pEHsJ2uMBRcKy2/ZwvyfO8nJsMI/7LsTX0
	TthWjqrZwqiTAFl0p+aS9Y+CZNV6CrQ0KwOfc15umDF4IKl2pV4EqRaM45IobSd1cwLIx+DhkMTrM
	K3SM4r5sn7twZOsrLahs6ES52eiXvinTJvuyjzCKIgqBah7HtSoNqtv+Q6KkNM21bclEb4oAJgXCZ
	jrOQXGvvQ4mk3iavB/tkLCaWzFILbhOk+9zS4Zu5K2R/4pWJUJKiBRXQI3OKfHuHIELEpOtuR5zsO
	Melmmwpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMjjy-006NW0-NQ; Tue, 31 Jan 2023 06:03:34 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMZ07-0053FH-Pe; Mon, 30 Jan 2023 18:35:33 +0000
Received: by mail-ej1-x62c.google.com with SMTP id bk15so34445062ejb.9;
        Mon, 30 Jan 2023 10:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9FE8Tg/ETfLF2znBVGSneSNpDHtD4K+4dzhis/koiic=;
        b=TdmKB3xUWwABi5gYQNKjBDn+QIkfyNCfLMKldrUBcWh0xLgeMjLs3Qub+GOKGwMozm
         FUbJ1XZpC2jhGxFhyyhzN118RA97F6oSOXm3m1/Wk+FMjfUWolHE100s5kNNs+L38530
         uOMnspdpGVscA37fmr5QPdeoxhIyThNBJdmwhiF6nQnureuktWkd6Kjmwi65jygf0nHZ
         rIy2rkDK2Db/9GyNHpy3U5BFUA5hqu2EF0t9o15V7jSS6IE6idX4bXNtQazLjHQ6mKVg
         66TdcLQr33MVchRcfI9E3P1LjAwRTNx+NjLiDce4tI2AmTdZIRtd42lzwZYv312KXNeQ
         C0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FE8Tg/ETfLF2znBVGSneSNpDHtD4K+4dzhis/koiic=;
        b=4Gashgbdw2tIV3eL3oiX33OVn9Psa9H0L0k5PYF9FSVmlqczHzGQmWrU1ubJ3i27Wa
         V+azLPXTfcnQLnnVX2jl8QX1eKue6HrxrIdgo40Jmu8IMl1FoeakrA0hVuLBLfpZsVdI
         GpamQgRi/fN2A7oAMABGSb1bgRfI/E5ch2ek8ePKpkTV1YEpKyaXOK+5XLr75u4CEgx1
         9ADD8Nht0luf49Ax9N0AdbM1BL7x2bN2kujy3KHCiMb7GJXAXP/kxRJ1zzwsejQC6gLu
         yE1Nx6dZ9iVkPCtUcSeeZU7AgOzSL7fr1YKw/I7R+Y4wolnYlqxkD/OXjyKztIV1FyXh
         KO0g==
X-Gm-Message-State: AFqh2kofI5cP2KMPxn6yv4AWuxJImqYNI5W68s1x3GD/xQpZ64vHL/Eq
	+v4rK56Q08zuFc2evhwz88BemkAV4cStygECpUQ=
X-Google-Smtp-Source: AMrXdXvnrppwjWc2GYoaSQvqFwNiTQID4l0gmI8rLvQT5AS+GqW5c9yL3gsxiJUvTOWQUcAgkpnAGLzZ827Cy2iv9XQ=
X-Received: by 2002:a17:906:3658:b0:872:68a:a17e with SMTP id
 r24-20020a170906365800b00872068aa17emr7442256ejb.159.1675103729082; Mon, 30
 Jan 2023 10:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20230130092157.1759539-2-hch@lst.de> <20230130092157.1759539-1-hch@lst.de>
 <3347557.1675074816@warthog.procyon.org.uk> <20230130103619.GA11874@lst.de>
In-Reply-To: <20230130103619.GA11874@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 30 Jan 2023 19:35:17 +0100
Message-ID: <CAOi1vP_aU58YpiOkYgQy4a=VVnm64WeWH5pwYf+bc_C=COYY3g@mail.gmail.com>
Subject: Re: [PATCH 01/23] block: factor out a bvec_set_page helper
To: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Marc Dionne <marc.dionne@auristor.com>, 
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
X-CRM114-CacheID: sfid-20230130_103531_857878_45CA2C90 
X-CRM114-Status: GOOD (  13.72  )
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

On Mon, Jan 30, 2023 at 11:36 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jan 30, 2023 at 10:33:36AM +0000, David Howells wrote:
> > Christoph Hellwig <hch@lst.de> wrote:
> >
> > > +static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
> > > +           unsigned int len, unsigned int offset)
> >
> > Could you swap len and offset around?  It reads better offset first.  You move
> > offset into the page and then do something with len bytes.
>
> This matches bio_add_page and the order inside bio_vec itself.  willy
> wanted to switch it around for bio_add_folio but Jens didn't like it,
> so I'll stick to the current convention in this area as well.

This also matches sg_set_page() so sticking to the current convention
is definitely a good idea!

Thanks,

                Ilya

