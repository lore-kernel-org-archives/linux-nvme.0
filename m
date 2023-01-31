Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDE6C636CD
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 06:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SMy4AhdFGD9NV+ZMw++exFusPY18E/iROcgJAJj2buw=; b=n+lPSK7y5rYpMapdw8c3h4xbX5
	UL4soMZfyqE6R9iNRZq5glF9Vhl1Kaps8S2cMh7WwLe/G5A1d487xmSc+K8Po40UzZ7ItjThJkulC
	8S9ZGctJSKYTYewJtAQ2l3+YsCPfsCpF4LauEVkFd4O6CH7A8rBsZmp3CZBL8/kLoJnwLQ2yuUcON
	U1Y62yxVTgkl4XCRReG+EO4AzMi1/gScA25OltnTsoCokTU9FMPIyU2s6+L40Tm+XGnhT+JDFK0Uw
	UIsXHq8Tqmj1RSxFxuvha9RxuKeI7KO5G1FUbTESBj3FTDiS4xJr/QyGKD6+eNqHYKaCzmfp2a44I
	zDvscFBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMjkb-006Nqb-7K; Tue, 31 Jan 2023 06:04:13 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMiYv-006GmK-80; Tue, 31 Jan 2023 04:48:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D2A26B81914;
	Tue, 31 Jan 2023 04:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0504C433D2;
	Tue, 31 Jan 2023 04:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675140481;
	bh=CWgleLhFsY7fdAWz2/GYSNCWb5dkQP977u3wpy/hMGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dARP7ELm0JDZUtfdf/aZ8jH1JD0CLl7hoXoH78TsDhjc1mmn8JFRG1IigOhyzOTIR
	 8LpgawDRtBw86IFXj6i1YkeRts+SWuJNykJYmlH/aIgncIrOZjAf+V+/CmtP/KRDAr
	 VQCKDZAbOX7gqYp11J79NeVN8tSKvri14UKFB/PyE8wFl5jc+kE8t46/tFsmTWzcUR
	 7y905w/ePF+771Ea1UzytT2Miv5ypO2Q07DAhG9UQz+0Eikry/PkH6GHvO2153a1Tl
	 gFsQ/iFj+f+SWMdPgkH2tVoOS0Nrv5jbsqd1Sdse8+GqnLYQ5xf/0l8xGGH0jIGlb6
	 ELagiuszQyNWQ==
Date: Mon, 30 Jan 2023 20:47:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
 <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, David Howells
 <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Xiubo Li
 <xiubli@redhat.com>, Steve French <sfrench@samba.org>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Mike
 Marshall <hubcap@omnibond.com>, Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Chuck Lever
 <chuck.lever@oracle.com>, linux-block@vger.kernel.org,
 ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
 io-uring@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/23] block: factor out a bvec_set_page helper
Message-ID: <20230130204758.38f4c6b9@kernel.org>
In-Reply-To: <20230130092157.1759539-2-hch@lst.de>
References: <20230130092157.1759539-1-hch@lst.de>
	<20230130092157.1759539-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_204805_462769_9C41EBAB 
X-CRM114-Status: GOOD (  18.20  )
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

On Mon, 30 Jan 2023 10:21:35 +0100 Christoph Hellwig wrote:
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index 35c25dff651a5e..9e3dac51eb26b6 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -35,6 +35,21 @@ struct bio_vec {
>  	unsigned int	bv_offset;
>  };
>  
> +/**
> + * bvec_set_page - initialize a bvec based off a struct page
> + * @bv:		bvec to initialize
> + * @page:	page the bvec should point to
> + * @len:	length of the bvec
> + * @offset:	offset into the page
> + */
> +static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
> +		unsigned int len, unsigned int offset)
> +{
> +	bv->bv_page = page;
> +	bv->bv_len = len;
> +	bv->bv_offset = offset;
> +}

kinda random thought but since we're touching this area - could we
perhaps move the definition of struct bio_vec and trivial helpers 
like this into a new header? bvec.h pulls in mm.h which is a right
behemoth :S

