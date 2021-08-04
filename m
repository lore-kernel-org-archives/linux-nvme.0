Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313E5C4338F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 17:05:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2BFE60F22
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 17:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2BFE60F22
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Wm5uh6wwhb8pc8YkUildT5V3UOLUftYfhlDG/aKabss=; b=S3DWPA1a0ij1OgIuUvDaFYjfTZ
	VweCB8MnLmDjPcpmhIv11J+CgdRhwlLYNGBKCVwtrdFBW3dYk0xsd+nVJA0DEJHwGg1IMi3WY2C07
	147nP4uoT0pW/bNl3zT0zNQeYctK250HzcpHFGa2FovAynyN58OfyEA5XZWEzc9EeHwJUhyc8kwCC
	NFuamN3yVFoZXcIY+F8jMRNkIeiu16aRlYROol6NBj/TLmDGsefoGHk/BIeAlcZl94s1cN42YTZCq
	rG5MRGq/GhjIvE6/53jGMCvEbu5FgcbavwaCooiAlhM3W48e5HIRyWV3ny5Mm3gZt3TInu7PrWCXE
	sMTtgXtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBKKa-006r9x-8v; Wed, 04 Aug 2021 17:05:24 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBKKX-006r8t-9U; Wed, 04 Aug 2021 17:05:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 87CC22226C;
 Wed,  4 Aug 2021 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628096717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZP5mbUaD4tLAM/AkhQwADJlhMUwxJoQ/fOe4VFqGiM=;
 b=T28M0ZzaVol9YE3Im9Ef1mW1D7DzmcvFlTfm+U3I6h9FX8vh3AkbVlkZFRYSdqJtek/+0x
 dI3DWubXqGVFB7wCjGMMp3YpUY0PLxtnKXLrO4UFOKWVXWoEisnr9ymd2Q+ibiGfXn7xYW
 yN1YDv9rZpfydqtAGq/FdJrpbfRlczY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628096717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZP5mbUaD4tLAM/AkhQwADJlhMUwxJoQ/fOe4VFqGiM=;
 b=t/keDuDOz4izQ9+Pevp8W+FaYqjWV9O9Grio2dEGxQV6iGJHmdZQ208YpuRM80KcNSr8MP
 me7eM4q47pic8fDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E66913D1F;
 Wed,  4 Aug 2021 17:05:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +P54DsjICmHSHgAAMHmgww
 (envelope-from <colyli@suse.de>); Wed, 04 Aug 2021 17:05:12 +0000
Subject: Re: [PATCH 09/15] bcache: use bvec_virt
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Geoff Levand <geoff@infradead.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Song Liu <song@kernel.org>, Mike Snitzer <snitzer@redhat.com>,
 Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Phillip Lougher <phillip@squashfs.org.uk>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-um@lists.infradead.org,
 ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <20210804095634.460779-1-hch@lst.de>
 <20210804095634.460779-10-hch@lst.de>
From: Coly Li <colyli@suse.de>
Message-ID: <13eb9def-5db4-d776-2b5a-0096a0a2a681@suse.de>
Date: Thu, 5 Aug 2021 01:05:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804095634.460779-10-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210804_100521_536739_90D7DE2C 
X-CRM114-Status: GOOD (  17.56  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/4/21 5:56 PM, Christoph Hellwig wrote:
> Use bvec_virt instead of open coding it.  Note that the existing code is
> fine despite ignoring bv_offset as the bio is known to contain exactly
> one page from the page allocator per bio_vec.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  drivers/md/bcache/btree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index 183a58c89377..0595559de174 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -378,7 +378,7 @@ static void do_btree_node_write(struct btree *b)
>  		struct bvec_iter_all iter_all;
>  
>  		bio_for_each_segment_all(bv, b->bio, iter_all) {
> -			memcpy(page_address(bv->bv_page), addr, PAGE_SIZE);
> +			memcpy(bvec_virt(bv), addr, PAGE_SIZE);
>  			addr += PAGE_SIZE;
>  		}
>  


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
