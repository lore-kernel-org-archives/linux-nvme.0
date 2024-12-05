Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A693BE77170
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 18:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1VWUjmRyxip+1QNQhl0piHt7X2RmLewkp5xz5WbnzMY=; b=4HoHjiifjE5PIceYtv7kkFPIPQ
	CjXebWpnKUD0rHQ/O0Sesu8vDDDTMeuwl5eRdF2T0ryZOdF19qtWs7Oz96JzBHjF+DJIvPfDY0l16
	EPab6tvOZgU0e23Ve4xZ3v3h3B3rvO7kriAVSj0j8vC7bGkYkuc+ZC2sBfexmJXUHykVPOxl4w14Q
	ET9HkGiHp7h0EfE2HRhwIABYAQuJDfdxTPz6CnbPnLNAXuH6lEH9Mld9BFEfL9duMxXSesFEwknXM
	3m5MX/cInW1Ed23KDKnIU7Ci3aX8cvrsJldwmSQezf/B+z9OKXMP9mWwlao14xIGjOaCAPF0jxvgm
	eBPVB+JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJGHu-0000000H4Kp-2y4g;
	Thu, 05 Dec 2024 18:09:18 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJGDf-0000000H3ao-0irp
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 18:04:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 76DFFA43E9E;
	Thu,  5 Dec 2024 18:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BABDC4CED1;
	Thu,  5 Dec 2024 18:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733421894;
	bh=hZtXBo2jdC7H9GEX5zEd/6dIqnpMpPqcvFJELa7vEWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m07EyLZjU+dhfWLP/mB5cAFfr5igeKowggMRD3cYlKDgXfxZkhZ5UddV/46QQlF6z
	 3E4O4Yv25mh6PBav+Mh9A+tIqOGX6rB51txBav+RdsY3sXHL7VPamNp3fev0mPSIr/
	 EiSfDKKiu6JAyc+1LIEfqY/srROvlqGGEpS0TnuAIDfASOtP/L47igrhICFsgzikjx
	 t7/ilUJdJwCI1gR3UJ9f0DRBQ9+ZyQViV90RV1AiR5PR4j5c5lryss5/V9N6oiDi/T
	 TkfiY4HaT8ymdtViw6Q8FIW7IVA1N98wQCFfh6IRys0BOdsiLDPuJz+dNvsbX71KkX
	 +t4SMo43J9pUA==
Date: Thu, 5 Dec 2024 10:04:51 -0800
From: Keith Busch <kbusch@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	asml.silence@gmail.com, anuj1072538@gmail.com, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v11 06/10] io_uring: introduce attributes for read/write
 and PI support
Message-ID: <Z1HrQ8lz7vYlRUtX@kbusch-mbp.dhcp.thefacebook.com>
References: <20241128112240.8867-1-anuj20.g@samsung.com>
 <CGME20241128113109epcas5p46022c85174da65853c85a8848b32f164@epcas5p4.samsung.com>
 <20241128112240.8867-7-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128112240.8867-7-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_100455_274354_AD5870A4 
X-CRM114-Status: GOOD (  19.43  )
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

On Thu, Nov 28, 2024 at 04:52:36PM +0530, Anuj Gupta wrote:
> Add the ability to pass additional attributes along with read/write.
> Application can prepare attibute specific information and pass its
> address using the SQE field:
> 	__u64	attr_ptr;
> 
> Along with setting a mask indicating attributes being passed:
> 	__u64	attr_type_mask;
> 
> Overall 64 attributes are allowed and currently one attribute
> 'IORING_RW_ATTR_FLAG_PI' is supported.
> 
> With PI attribute, userspace can pass following information:
> - flags: integrity check flags IO_INTEGRITY_CHK_{GUARD/APPTAG/REFTAG}
> - len: length of PI/metadata buffer
> - addr: address of metadata buffer
> - seed: seed value for reftag remapping
> - app_tag: application defined 16b value
> 
> Process this information to prepare uio_meta_descriptor and pass it down
> using kiocb->private.
> 
> PI attribute is supported only for direct IO.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  include/uapi/linux/io_uring.h | 16 +++++++
>  io_uring/io_uring.c           |  2 +
>  io_uring/rw.c                 | 83 ++++++++++++++++++++++++++++++++++-
>  io_uring/rw.h                 | 14 +++++-
>  4 files changed, 112 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index aac9a4f8fa9a..38f0d6b10eaf 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -98,6 +98,10 @@ struct io_uring_sqe {
>  			__u64	addr3;
>  			__u64	__pad2[1];
>  		};
> +		struct {
> +			__u64	attr_ptr; /* pointer to attribute information */
> +			__u64	attr_type_mask; /* bit mask of attributes */
> +		};

I can't say I'm a fan of how this turned out. I'm merging up the write
hint stuff, and these new fields occupy where that 16-bit value was
initially going. Okay, so I guess I need to just add a new attribute
flag? That might work if I am only appending exactly one extra attribute
per SQE, but what if I need both PI and Write Hint? Do the attributes
need to appear in a strict order?

