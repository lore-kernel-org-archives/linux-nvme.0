Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEB9D5AE60
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 05:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JlpxCIWRxDZogpxTfmEhRpDXBE7KwpPXqh1EJRW4Hp0=; b=XtKYiETygpnZWUqwzEG68oQq8c
	P46MnS/rpwno6Tj+yYYfEBFBJANaPZFzwu7iEAJLPWZU8UeYOUZKS3Aq29AtZcgB7J/h0BG499loU
	RW/98Nmse8VpxhidziFy4euaLgKwWahBv3WoKsLswGIp91oKJRURsiMcVYPrNjNuqN1F56VFmVDcT
	w216NJEeXKK09jCy93AEwzA0wySjFp937IHWby9Olzf9ES4hbPseFFSukfld/CzuJ6t7l/ePXF74M
	9+6H/dFp4cqYzsH6S/3a9VM0XsExehm9+Yzf9wDx2Ku0dLwXNyesln7S80yBDZHl8T+tc6IgTwUUo
	cQZZzmCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8vUn-00000005lax-2kXb;
	Thu, 07 Nov 2024 05:55:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8vUk-00000005laI-123c
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 05:55:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 677C5227A87; Thu,  7 Nov 2024 06:55:42 +0100 (CET)
Date: Thu, 7 Nov 2024 06:55:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v8 06/10] io_uring/rw: add support to send metadata
 along with read/write
Message-ID: <20241107055542.GA2483@lst.de>
References: <20241106121842.5004-1-anuj20.g@samsung.com> <CGME20241106122710epcas5p2b314c865f8333c890dd6f22cf2edbe2f@epcas5p2.samsung.com> <20241106121842.5004-7-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106121842.5004-7-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_215550_450769_BDE4C00E 
X-CRM114-Status: GOOD (  17.15  )
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

> +enum io_uring_sqe_ext_cap_bits {
> +	EXT_CAP_PI_BIT,
> +	/*
> +	 * not a real extended capability; just to make sure that we don't
> +	 * overflow
> +	 */
> +	EXT_CAP_LAST_BIT,
> +};
> +
> +/* extended capability flags */
> +#define EXT_CAP_PI	(1U << EXT_CAP_PI_BIT)

This is getting into nitpicking, but is the a good reason to have that
enum, which is never used as a type and the values or only defined to
actually define the bit positions below?  That's a bit confusing to
me.

Also please document the ABI for EXT_CAP_PI, right now this is again
entirely undocumented.

> +/* Second half of SQE128 for IORING_OP_READ/WRITE */
> +struct io_uring_sqe_ext {
> +	__u64	rsvd0[4];
> +	/* if sqe->ext_cap is EXT_CAP_PI, last 32 bytes are for PI */
> +	union {
> +		__u64	rsvd1[4];
> +		struct {
> +			__u16	flags;
> +			__u16	app_tag;
> +			__u32	len;
> +			__u64	addr;
> +			__u64	seed;
> +			__u64	rsvd;
> +		} rw_pi;
> +	};

And this is not what I though we discussed before.  By having a
union here you imply some kind of "type" again that is switched
on a value, and not flags indication the presence of potential
multiple optional and combinable features.  This is what I would
have expected here based on the previous discussion:

struct io_uring_sqe_ext {
	/*
	 * Reservered for please tell me what and why it is in the beginning
	 * and not the end:
	 */
	__u64	rsvd0[4];

	/*
	 * Only valid when EXT_CAP_PI is set:
	 */
	__u16	pi_flags; /* or make this generic flags, dunno? */
	__u16	app_tag;
	__u32	pi_len;
	__u64	pi_addr;
	__u64	pi_seed;

	__u64	rsvd1;
};


