Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB5DC27C52
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 08:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pcFej4tHI5c8EAeZLPCsO5ul9/zMUYyPor7FSg3i5OQ=; b=GcIZPyfA0UdYRdtJ6y/+97E1V3
	EXpSqaxVio4Nu5Lc+9FK2qs10aGwqfoD7cASKNYMRBHxHAVs6y1DQ9jlYi9xYvLAOqhGkqAD6Shyi
	mO4ADLf002jATVS0FBdnV1wZXXBTOfkpBpIcIlewhIy8ZeInldpA47oLtjyrNm58LbHaq2YFwo0bY
	KZ4BF7WABB0yP2iPB4DFDDDkOIl+ImblMnq4RtUgks2vD3FWBaRyY1dtl7C+h36bNwEiyo2jnB6DW
	l/1oZaKOjddFYQRncVPk9ZGIoybT1T25c7ImufsB/IAC//2KC5bgrEwuR9r0hI6yYLFci5Ytooh9J
	Uops46yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEm2T-00000005DOc-3iW6;
	Wed, 05 Jun 2024 08:30:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEm2Q-00000005DLD-3fl3
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 08:30:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BFC20227A87; Wed,  5 Jun 2024 10:30:16 +0200 (CEST)
Date: Wed, 5 Jun 2024 10:30:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH v7 2/9] fs: Initial atomic write support
Message-ID: <20240605083015.GA20984@lst.de>
References: <20240602140912.970947-1-john.g.garry@oracle.com> <20240602140912.970947-3-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602140912.970947-3-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_013031_083089_3EC29F6C 
X-CRM114-Status: GOOD (  17.35  )
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

Highlevel question:  in a lot of the discussions we've used the
term "untorn writes" instead, which feels better than atomic to
me as atomic is a highly overloaded term.  Should we switch the
naming to that?

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 0283cf366c2a..6cb67882bcfd 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -45,6 +45,7 @@
>  #include <linux/slab.h>
>  #include <linux/maple_tree.h>
>  #include <linux/rw_hint.h>
> +#include <linux/uio.h>

fs.h is included almost everywhere, so if we can avoid pulling in
even more dependencies that would be great.

It seems like it is pulled in just for this helper:

> +static inline
> +bool generic_atomic_write_valid(loff_t pos, struct iov_iter *iter)
> +{
> +	size_t len = iov_iter_count(iter);
> +
> +	if (!iter_is_ubuf(iter))
> +		return false;
> +
> +	if (!is_power_of_2(len))
> +		return false;
> +
> +	if (!IS_ALIGNED(pos, len))
> +		return false;
> +
> +	return true;
> +}

should that just go to uio.h instead, or move out of line?

Also the return type formatting is wrong, the two normal styles are
either:

static inline bool generic_atomic_write_valid(loff_t pos,
		struct iov_iter *iter)

or:

static inline bool
generic_atomic_write_valid(loff_t pos, struct iov_iter *iter)

(and while I'm at nitpicking, passing the pos before the iter
feels weird)

Last but not least: if READ/WRITE is passed to kiocb_set_rw_flags,
it should probably set IOCB_WRITE as well?  That might be a worthwile
prep patch on it's own.

