Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A024EE57F8
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 13:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XgGsrf7dA6CpjvI9fBVgqtnxnzZ8jdii2mjMffhIatM=; b=mSByVybam+QMRyVRlKb7NB6xxo
	DTASG8rAxh8rGOxBBm7E6+hURlEX20TgLhs1VndKP03se60l3/NuR65ZvCKGUsErsfN4lVd3lUH4X
	wIzMmK8k5vfBeK1c2eQ8Mg2DxFJb6eAFzf150dJqnJ9AR9smCgoeUdQN+iL3ppsz+Sm6+myhOGgfy
	f+4IONDnUMHxEPACjbrTEqBDWmwc3YLlymUA+C7z+x9qH5prIHLzaBNJ6sEnltva7EweJoJ0M/7mQ
	uvA2yiKpEWIXkUCFJdT96ohFieC3fI2KTI3A6OsTKlbrwTfSrCw33CmnLVQjZBVTo+Js/jqIIK22w
	zuIcuP6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojUI-0000000D8PF-0wYZ;
	Thu, 12 Sep 2024 13:03:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojSJ-0000000D83Z-3GUh
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 13:03:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 944E4227AB6; Thu, 12 Sep 2024 15:01:46 +0200 (CEST)
Date: Thu, 12 Sep 2024 15:01:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v5 3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
Message-ID: <20240912130146.GA28535@lst.de>
References: <20240910150200.6589-1-joshi.k@samsung.com> <CGME20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af@epcas5p4.samsung.com> <20240910150200.6589-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910150200.6589-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_060151_983924_9BB6DF2F 
X-CRM114-Status: GOOD (  18.24  )
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

On Tue, Sep 10, 2024 at 08:31:58PM +0530, Kanchan Joshi wrote:
> This is similar to existing F_{SET/GET}_RW_HINT but more
> generic/extensible.
> 
> F_SET/GET_RW_HINT_EX take a pointer to a struct rw_hint_ex as argument:
> 
> struct rw_hint_ex {
>         __u8    type;
>         __u8    pad[7];
>         __u64   val;
> };
> 
> With F_SET_RW_HINT_EX, the user passes the hint type and its value.
> Hint type can be either lifetime hint (TYPE_RW_LIFETIME_HINT) or
> placement hint (TYPE_RW_PLACEMENT_HINT). The interface allows to add
> more hint add more hint types in future.

What is the point of multiplexing these into a single call vs having
one fcntl for each?  It's not like the code points are a super
limited resource.

And the _EX name isn't exactly descriptive either and screams of horrible
Windows APIs :)

> +	WRITE_ONCE(inode->i_write_hint, hint);
> +	if (file->f_mapping->host != inode)
> +		WRITE_ONCE(file->f_mapping->host->i_write_hint, hint);

This doesn't work.  You need a file system method for this so that
the file system can intercept it, instead of storing it in completely
arbitrary inodes without any kind of checking for support or intercetion
point.

> --- a/include/linux/rw_hint.h
> +++ b/include/linux/rw_hint.h
> @@ -21,4 +21,17 @@ enum rw_lifetime_hint {
>  static_assert(sizeof(enum rw_lifetime_hint) == 1);
>  #endif
>  
> +#define WRITE_HINT_TYPE_BIT	BIT(7)
> +#define WRITE_HINT_VAL_MASK	(WRITE_HINT_TYPE_BIT - 1)
> +#define WRITE_HINT_TYPE(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
> +				TYPE_RW_PLACEMENT_HINT : TYPE_RW_LIFETIME_HINT)
> +#define WRITE_HINT_VAL(h)	((h) & WRITE_HINT_VAL_MASK)
> +
> +#define WRITE_PLACEMENT_HINT(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
> +				 WRITE_HINT_VAL(h) : 0)
> +#define WRITE_LIFETIME_HINT(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
> +				 0 : WRITE_HINT_VAL(h))
> +
> +#define PLACEMENT_HINT_TYPE	WRITE_HINT_TYPE_BIT
> +#define MAX_PLACEMENT_HINT_VAL	(WRITE_HINT_VAL_MASK - 1)

That's a whole lot of undocumented macros.  Please turn these into proper
inline functions and write documentation for them.


