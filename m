Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FDED6A221
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 20:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xi3Mt0dvcbkLwzEPSrMA1jQ9eEltJbcTG5gzTPDb/fs=; b=x+22G23f4KtnaPCLqBqcRtoXlS
	d0u2Ol6OIxdFTFv+hibsqJNQCm8Pxgg1+rr31KnPCmlxPZHZIZZ5D0x1CaqVrRvod7E7S0E9yML84
	Y/c/J6DW0aWh5hTwQy0xtQ/tn98GQvlCfyIo5KFXQQiPpDTzHvEvbOtu7Bhh3vrvcYpxl8b/EpIsT
	PiB1hgs7tqgEF4pBKESUckjbcUNXqAG18uWk9iErzYitGgtzBxU52YhmZB4S/2sKMR1RpEZ7nYOvo
	fFp0IQiDPSxdseOollyOfV8aGN86suPYNI5emRe9co/6WwrKo6g8M3NQmqzqKnmprrzsq58IAsf9X
	m1/ljn9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBgBR-00000000iGu-0HHq;
	Thu, 14 Nov 2024 20:11:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBgBQ-00000000iGJ-0K4M
	for linux-nvme@bombadil.infradead.org;
	Thu, 14 Nov 2024 20:11:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xi3Mt0dvcbkLwzEPSrMA1jQ9eEltJbcTG5gzTPDb/fs=; b=dn5iM4Ry33yzytzWnD5nnJzoha
	ST83YVSzgVOIMJF1Xlw96kr//vN4/4sY0U1DP4+wnLq49BS538ms8uRcwJ5ENwEdPGAgWODtRZOQZ
	uxXbAmYxzwDmYpuQ0Hy2s97b5cbQgUthdgyNIfl9stW8tadrXUTiXMUHsE213RHTCMXAWeEqpYGLC
	rwhsHn536yqvQRnbTvWv1tLIG/MM3WcQoifigwDuXpWIjOE/EupjQbp1nwCbwMSoMNcDU0Ihc1Q80
	45vBl2V63mFDnXuk8zTCWCSlV8ot7rYi1pHUvMUJTH9El3zmY2vQjqHTMjWejcvMW7z5E9GH2g9jG
	Z1ekGrNA==;
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBgBK-00000000ABb-2pHp
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 20:11:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 87311A41B0E;
	Thu, 14 Nov 2024 20:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C035C4CECD;
	Thu, 14 Nov 2024 20:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731615066;
	bh=ASl8LSAvyQVJiieFrry6JPr3SCOWxU/QgkzXXpnO05k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anx91EaEjJy6ntu/ddhlMwoMHjGZHqXIcwlIbSxu2kcIowwLvk0UMlYby2HoawQBE
	 sbHvq+nARD/fY8HjJLg0VQCU5jOhJpqefyvJJFZ+f+qLvTpgcBp+tjagV8VPGSTX60
	 4kskjjjHURDBovPsnp/VTNUO8ITbMWwx2W2KL+5N2QKDS7IRQ9oAIkEmJm+59XuIOA
	 l1VzSp7HwTt1oIQOTTmYjK82gHnErDFI3wDf+EKeei1n2xKrAKGHUEWdD7uchJoI3V
	 PC5BtRgOOKwMQ0g+7H4HCnJlTN/H4VNZ+dTMPpc4aPLFr+AOKTMj7fybJKs94y7uhH
	 7wMQc3PHz3+RQ==
Date: Thu, 14 Nov 2024 13:11:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 4/6] block: add a rq_list type
Message-ID: <20241114201103.GA2036469@thelio-3990X>
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113152050.157179-5-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_201111_484956_85BA9A3B 
X-CRM114-Status: GOOD (  18.93  )
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

Hi Christoph,

On Wed, Nov 13, 2024 at 04:20:44PM +0100, Christoph Hellwig wrote:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 65f37ae70712..ce8b65503ff0 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1006,6 +1006,11 @@ extern void blk_put_queue(struct request_queue *);
>  void blk_mark_disk_dead(struct gendisk *disk);
>  
>  #ifdef CONFIG_BLOCK
> +struct rq_list {
> +	struct request *head;
> +	struct request *tail;
> +};
> +
>  /*
>   * blk_plug permits building a queue of related requests by holding the I/O
>   * fragments for a short period. This allows merging of sequential requests
> @@ -1018,10 +1023,10 @@ void blk_mark_disk_dead(struct gendisk *disk);
>   * blk_flush_plug() is called.
>   */
>  struct blk_plug {
> -	struct request *mq_list; /* blk-mq requests */
> +	struct rq_list mq_list; /* blk-mq requests */
>  
>  	/* if ios_left is > 1, we can batch tag/rq allocations */
> -	struct request *cached_rq;
> +	struct rq_list cached_rqs;
>  	u64 cur_ktime;
>  	unsigned short nr_ios;
>  
> @@ -1683,7 +1688,7 @@ int bdev_thaw(struct block_device *bdev);
>  void bdev_fput(struct file *bdev_file);
>  
>  struct io_comp_batch {
> -	struct request *req_list;
> +	struct rq_list req_list;

This change as commit a3396b99990d ("block: add a rq_list type") in
next-20241114 causes errors when CONFIG_BLOCK is disabled because the
definition of 'struct rq_list' is under CONFIG_BLOCK. Should it be moved
out?

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 00212e96261a..a1fd0ddce5cf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1006,12 +1006,12 @@ extern void blk_put_queue(struct request_queue *);
 
 void blk_mark_disk_dead(struct gendisk *disk);
 
-#ifdef CONFIG_BLOCK
 struct rq_list {
 	struct request *head;
 	struct request *tail;
 };
 
+#ifdef CONFIG_BLOCK
 /*
  * blk_plug permits building a queue of related requests by holding the I/O
  * fragments for a short period. This allows merging of sequential requests

>  	bool need_ts;
>  	void (*complete)(struct io_comp_batch *);
>  };

