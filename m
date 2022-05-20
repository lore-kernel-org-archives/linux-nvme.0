Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78459C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 09:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HKqeQElR/L5ooc/R+UyNvgJynNJc4zFVxqdPo1VCJbY=; b=0L3+5XT8n/95RW19uO/ZUX8OJv
	BC4uDHHMiOxmRB3XZnBUPL+PlRNzsiaoaEYrd2+B9pI9AQH/VxqbpIXbyFRo3kHceO4YndlviRrZT
	xFEhhJlj6l8V//YT7NgeBqr50STeVr+ko+qVrlK+HlBHork7aZDB81v5KsRVSEKD8y9v/RGbhANtQ
	8i44hr1Jn84y3TlSoJmMS71T+i/m/t0egBIqka0tM/LQPh92cWIx69y1zv/a0sOwV8yuv8qnJJ1NT
	S5LZ5W2qyX3J/PBgoctgihR+V1W5bWiy95AFmkxJJTS95vZSt9IKhxcjCaVdNimEQtXzglZmxe6nW
	fn20fbrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nryjD-00BWT4-Hi; Fri, 20 May 2022 09:15:23 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nryjA-00BWQQ-SU
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 09:15:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7969B68AFE; Fri, 20 May 2022 11:15:14 +0200 (CEST)
Date: Fri, 20 May 2022 11:15:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
Subject: Re: [PATCH v2 0/2] uring-passthrough for admin commands
Message-ID: <20220520091514.GA28084@lst.de>
References: <CGME20220520050118epcas5p1f6a930419285ecdac65afaa22255c03f@epcas5p1.samsung.com>
 <20220520045600.3773-1-joshi.k@samsung.com> <20220520060143.GA16433@lst.de>
 <20220520082134.GA28050@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520082134.GA28050@test-zns>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_021521_105016_78A4BC88 
X-CRM114-Status: GOOD (  12.36  )
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

On Fri, May 20, 2022 at 01:51:34PM +0530, Kanchan Joshi wrote:
> Sure. By free, you mean this I suppose: 
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -699,6 +699,9 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
>        case NVME_URING_CMD_ADMIN:
>                ret = nvme_uring_cmd_io(ctrl, NULL, ioucmd, issue_flags, false);
>                break;
> +       case NVME_URING_CMD_ADMIN_VEC:
> +               ret = nvme_uring_cmd_io(ctrl, NULL, ioucmd, issue_flags, true);
> +               break;
>
> anything else? I will fold this in, and submit v3 before Jens takes a
> look.

We need a definition for NVME_URING_CMD_ADMIN_VEC, but yes, that's it.

