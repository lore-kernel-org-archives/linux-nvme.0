Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BE3E68956
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 06:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QLDIAaSD9844H1amX6uRVboWINL3zB7PYQjgIeituFI=; b=lzYLfNP8wlXX7IFiIVW3UtRriF
	EsqW554vtNd0PwkSDTnXwake75fJG50gIfOv4UYPwgYxeb7lACCn19iLUiiKYi2dT5K26kUxp6+a6
	OLqsQP3GMsDA9UEQCv+5pS30uL6vCLiLHTNnrKJmxNkDm2rPn/01ksY3kXNhqIHFAkQSklbIpaO/X
	l/0IWFezoB2xDE49Frvq9pWh62QdhFN7WKBCY9I5xuRinUuzfJo6yzGFE6NHNKoJyFHAytSXzSrwv
	D5QpRX6aY4wUazsNGnDU8wZ3X4CyhJfUk9Tlg+r244/jtArdpgXPPouYLPMTTY0bJjYXAKc/AppAG
	X1wrDP0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6P5v-00000002jEa-26us;
	Thu, 31 Oct 2024 06:55:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6P5s-00000002jDi-1hOV
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 06:55:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CB0C7227AAD; Thu, 31 Oct 2024 07:55:35 +0100 (CET)
Date: Thu, 31 Oct 2024 07:55:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, anuj1072538@gmail.com,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH v6 04/10] fs, iov_iter: define meta io descriptor
Message-ID: <20241031065535.GA26299@lst.de>
References: <20241030180112.4635-1-joshi.k@samsung.com> <CGME20241030181008epcas5p333603fdbf3afb60947d3fc51138d11bf@epcas5p3.samsung.com> <20241030180112.4635-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030180112.4635-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_235544_610661_07BFD12E 
X-CRM114-Status: UNSURE (   9.31  )
X-CRM114-Notice: Please train this message.
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

On Wed, Oct 30, 2024 at 11:31:06PM +0530, Kanchan Joshi wrote:
> +typedef __u16 uio_meta_flags_t;

I would have just skipped the typedef, but I don't have strong feelings
here.

Reviewed-by: Christoph Hellwig <hch@lst.de>

