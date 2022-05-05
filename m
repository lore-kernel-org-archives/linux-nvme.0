Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F702C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 13:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1bYeNJ7zE87RngaCi1gArLTnk5fOkpEu74Ft3vCoaso=; b=axcm8Igl2zLZpGpFjSC4Kcf7c6
	zS02PHop1VPIGOglC72IsAoCdKmuBjJlWyuXygbGTf11+s2HaISwBjczNWJhwEswp9XiNfMualFs9
	+aTU8vGDJes8lbRcGdco8autNvuf5ZnJpEO+EcZ4m4LbB75qCqb6Xrr7vcwkjssc1kEhBuIbR+PPV
	7wDbVcqX16DlVRWzIuH1CxbRL8dQlwD2Ram0y1ZIz/mAgJ5Qonn7U/wo04QIPX/vAb6bLCF7krD98
	lrQx25bbOuMLSM0SR11Grmzomo0jO47KlJP03btHd5GNTFlWHDKCINP2uIa+qtrraq6qRA5vzZb2R
	oCvAQFag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmbXj-00G284-FH; Thu, 05 May 2022 13:29:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmbXg-00G24K-BC
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 13:29:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 87FDD68BFE; Thu,  5 May 2022 15:29:03 +0200 (CEST)
Date: Thu, 5 May 2022 15:29:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com,
 ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 1/5] fs,io_uring: add infrastructure for uring-cmd
Message-ID: <20220505132902.GA11853@lst.de>
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061144epcas5p3821a9516dad2b5eff5a25c56dbe164df@epcas5p3.samsung.com>
 <20220505060616.803816-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505060616.803816-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_062916_563102_D2A92166 
X-CRM114-Status: GOOD (  11.97  )
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

On Thu, May 05, 2022 at 11:36:12AM +0530, Kanchan Joshi wrote:
> +	void (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);

This adds an overly long line now.

>  } __randomize_layout;
> +struct io_uring_cmd {
> +	struct file	*file;
> +	const u8	*cmd;
> +	/* callback to defer completions to task context */
> +	void (*task_work_cb)(struct io_uring_cmd *cmd);
> +	u32		cmd_op;
> +	u8		pdu[32]; /* available inline for free use */

And with both unused and flags gone, pdu is unaligned again and will
crash the kernel on 64-bit architectures that do not support unaligned
loads and stores, so we'll need a "u32 __pad" here now.

