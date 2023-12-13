Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1699C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 13:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=THUNaIPCj3UXkLkp4y+hnDHsey8kw6K+6ACn36v7rlc=; b=WOIV5Z3KM8PVvNX+VJYbgUbVQ/
	kbj7BdbcQXOztoE7tI9f+E2VMbtC0/tqlONUl0Ndi8FcvUTf3az3vtW24hMCt5UUT7BLLmXKrY+2o
	fnpqF3YDhvhI0ID37zSy/ZWqddqN2BNu7/6iBGyXmTqnE7pLBr9qYoV2LWv03bU1PMYduHozSX75W
	UDkreAe6upMYVhYCyngq25aKfQ6faQ6yYK2fBt2Ap7W2Uf6DZSSk6NCJN0PCMz7kevGKfBezbzwse
	GJkLdxsGOo69Wd3ClSG4UFPf/QTcs02zniZUWAL/fdiSkVMd+90i2ojk+pN/zSzXHK+VmGxucLYg3
	H1gk6rkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDOsv-00Ej1x-0V;
	Wed, 13 Dec 2023 13:02:45 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDOss-00Ej0P-1c
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 13:02:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E4D6FCE1E04;
	Wed, 13 Dec 2023 13:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CCFC433C8;
	Wed, 13 Dec 2023 13:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702472559;
	bh=oucTferbO8z09uzRC+QN/9ilQDasa9VaUoOZvOLBlL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qMGDvekulMiLgPyCQAmQWR/eYvFAOux9M1LrBgXpjuHKi5GdnupdLCcjMmHeANAZw
	 NDWN1eQkHCW2Sw+pfLuqq2pfj/JcgsDdVtA22OmSnHNJxYpw+yR1FExTe1nE8Z/wZs
	 akM7+FPs9zpIm5sPjIcHPvfZPn+4KlneeGqG3rOB6Je1SWsz2emIBCRZySFkAzIPeA
	 xA8qRf8Vl62kxL6qdWQBsLnN2r/BrbU0YpgQxCdD/1rH6ftoAJoKvEHvCU6oG3Umxf
	 wyUryDjEKQZG4E1FVlzWMllV3UPLfXuBS3NdhfbgQtbEkbPuCgd+tR20WHysGMMqwt
	 MUW7KhdPyiXlw==
Date: Wed, 13 Dec 2023 14:02:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ming.lei@redhat.com,
	jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 04/16] fs: Increase fmode_t size
Message-ID: <20231213-gurte-beeren-e71ff21c3c03@brauner>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-5-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212110844.19698-5-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_050242_797495_37B1F7BE 
X-CRM114-Status: GOOD (  15.64  )
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

On Tue, Dec 12, 2023 at 11:08:32AM +0000, John Garry wrote:
> Currently all bits are being used in fmode_t.
> 
> To allow for further expansion, increase from unsigned int to unsigned
> long.
> 
> Since the dma-buf driver prints the file->f_mode member, change the print
> as necessary to deal with the larger size.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/dma-buf/dma-buf.c | 2 +-
>  include/linux/types.h     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 21916bba77d5..a5227ae3d637 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1628,7 +1628,7 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
>  
>  
>  		spin_lock(&buf_obj->name_lock);
> -		seq_printf(s, "%08zu\t%08x\t%08x\t%08ld\t%s\t%08lu\t%s\n",
> +		seq_printf(s, "%08zu\t%08x\t%08lx\t%08ld\t%s\t%08lu\t%s\n",
>  				buf_obj->size,
>  				buf_obj->file->f_flags, buf_obj->file->f_mode,
>  				file_count(buf_obj->file),
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 253168bb3fe1..49c754fde1d6 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -153,7 +153,7 @@ typedef u32 dma_addr_t;
>  
>  typedef unsigned int __bitwise gfp_t;
>  typedef unsigned int __bitwise slab_flags_t;
> -typedef unsigned int __bitwise fmode_t;
> +typedef unsigned long __bitwise fmode_t;

As Jan said, that's likely a bad idea. There's a bunch of places that
assume fmode_t is 32bit. So not really a change we want to make if we
can avoid it.

