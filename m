Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC8ED43350
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 11:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YEtOgEdykDYQ99dxARcs2YKL2jnmh1MpdjVdx30kGsw=; b=EZYHnOxaO0RqwH1e8zB3wxdG/G
	Y0L9EoIjzc++lIp+iFkD45DlfxgGYJxoIsKOE6URb3MtPMEqEj2+1iv+YEjtczAFRy2HNpVDWkLO0
	uzGwwTm+M5s78aH6Mv9JNyEEuYPUihnNtstmLf5qqKj4FBlFtv4leqjz0GRF13RT3Y9CZE+5QYbYH
	KTOlMJKNy6CdaUbo7prFyqgIpMM5dQb+IXWjEnGVmWos+6LqzqwUXWOkgg7w+NdPWvmW83l/WunHX
	5Zh3VG/GrD0JWOMv7lwC2P4pTuEjc276YM3/Uad/L+/HWp4vdLuXwvS2Q+Lo8GCDJE4jEEdL4ICYR
	4G7MLimA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t90xu-00000006nAw-0E9M;
	Thu, 07 Nov 2024 11:46:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t90wb-00000006mpU-1IrF
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 11:44:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8C64D68B05; Thu,  7 Nov 2024 12:44:52 +0100 (CET)
Date: Thu, 7 Nov 2024 12:44:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Anuj gupta <anuj1072538@gmail.com>,
	axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
	asml.silence@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v8 06/10] io_uring/rw: add support to send metadata
 along with read/write
Message-ID: <20241107114452.GA31441@lst.de>
References: <20241106121842.5004-1-anuj20.g@samsung.com> <CGME20241106122710epcas5p2b314c865f8333c890dd6f22cf2edbe2f@epcas5p2.samsung.com> <20241106121842.5004-7-anuj20.g@samsung.com> <20241107055542.GA2483@lst.de> <CACzX3As284BTyaJXbDUYeKB96Hy+JhgDXs+7qqP6Rq6sGNtEsw@mail.gmail.com> <20241107073852.GA5195@lst.de> <20241107104000.GB9730@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107104000.GB9730@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_034457_757518_C12B18DE 
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

> +/*
> + * If sqe->ext_cap is set to this for IORING_OP_READ/WRITE, then the SQE
> + * contains protection information, and ring needs to be setup with SQE128
> + */
> +#define EXT_CAP_PI	(1U << 0)
> +
> +/* Second half of SQE128 for IORING_OP_READ/WRITE */
> +struct io_uring_sqe_ext {
> +	/*
> +	 * Reserved space for extended capabilities that are added down the
> +	 * line. Kept in beginning to maintain contiguity with the free space
> +	 * in first SQE
> +	 */
> +	__u64	rsvd0[4];

Thanks for documenting the design decision.  But I still don't understand
it.  Due to the layout it will be a bit hard to have fields spreading
form the "normal" SQE into the extended area anyway.  Note that this
is not a rejection of the approach, but I don't understand the argument
for it.

> +	/* only valid when EXT_CAP_PI is set */
> +	__u16	flags;
> +	__u16	pi_app_tag;
> +	__u32	pi_len;
> +	__u64	pi_addr;
> +	__u64	pi_seed;
> +	__u64	rsvd1;

.. but either way it would probably make sense to keep the reserved
areas together instead of spread out.

Otherwise this looks good to me.

