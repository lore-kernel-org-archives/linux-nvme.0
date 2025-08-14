Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C2DCA0EE4
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Aug 2025 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8HSH52g0+K8/bGOxK4ap4aGmbmqlpyxKrd0hHLTldLc=; b=m3uG03cHttZNPAuIA9QFGeXLYQ
	kMMkgyttxZcSswVXTIzOB1Wc2KsTgbf8GB+17Q8BMTdfiylyX9D6+3c+nIYmqC2CEtVXhUxY7SSXO
	boGYLak3q7BixPZEtLosqDiSbf2NLPlN8JzFx0NRVSpxBf3aNutJgzSaoHElEB6uSkJhHhAOx5IaY
	NkZgImsg7UPswFHI3yz8Zcjafty9V3b/vO0A9BgprVTXz9G6Bl2bkfvXxj2Znf8E5AW53SoOklcrA
	XTsWnXX7xl9CXRtNdCIJXH5OqsLQ1z4yN8ELsLYl+PSrBnNRuJ1Px2vBPkVDDZOUtMLMgGrjRSdGA
	fnABynnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umcGm-00000000HH6-2aNa;
	Thu, 14 Aug 2025 18:01:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umbDk-000000007Lv-0N6S
	for linux-nvme@lists.infradead.org;
	Thu, 14 Aug 2025 16:54:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 837C85C71B0;
	Thu, 14 Aug 2025 16:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2593AC4CEED;
	Thu, 14 Aug 2025 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755190471;
	bh=l+BdPGU5s1lSz+Wn4Skj6yNZHRqBxCYdP1QbhjGj46w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uAijTxAuY3vGwM78+PrRc/fCQLGARlU2IACUe8szD/QvaX7trsuwHqBZM0fU/BkJ0
	 PrKRsyPReVqn1jx+XoArIoQSdVBZ6pgLV5XJ3gwVZsxMoPqw64Rd5/ba5m5Giswfef
	 +pWR5d1bRDswR628xphF8ZJg5OzExBiI+bx4OjoJXq70IScPa3+UDFRffBnH7BGs6t
	 Z0b1epTyG+7p8SS4oKLtdLRaB4oVYY2J/7eVwEiWHaGt2ultzwauOolHjFJbFepz6P
	 8AtC40MBVot4IzdXlUjfNKsre/FmlM+TNETCjpS5bIV9PHVY5//XDsMmFYJmeboDSM
	 trEYUGuKC9C6A==
Date: Thu, 14 Aug 2025 09:54:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH xfsprogs v2] xfs_io: add FALLOC_FL_WRITE_ZEROES support
Message-ID: <20250814165430.GR7942@frogsfrogsfrogs>
References: <20250813024250.2504126-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813024250.2504126-1-yi.zhang@huaweicloud.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_095432_210598_0689513F 
X-CRM114-Status: GOOD (  23.56  )
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

On Wed, Aug 13, 2025 at 10:42:50AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The Linux kernel (since version 6.17) supports FALLOC_FL_WRITE_ZEROES in
> fallocate(2). Add support for FALLOC_FL_WRITE_ZEROES support to the
> fallocate utility by introducing a new 'fwzero' command in the xfs_io
> tool.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> v1->v2:
>  - Minor description modification to align with the kernel.
> 
>  io/prealloc.c     | 36 ++++++++++++++++++++++++++++++++++++
>  man/man8/xfs_io.8 |  6 ++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/io/prealloc.c b/io/prealloc.c
> index 8e968c9f..9a64bf53 100644
> --- a/io/prealloc.c
> +++ b/io/prealloc.c
> @@ -30,6 +30,10 @@
>  #define FALLOC_FL_UNSHARE_RANGE 0x40
>  #endif
>  
> +#ifndef FALLOC_FL_WRITE_ZEROES
> +#define FALLOC_FL_WRITE_ZEROES 0x80
> +#endif
> +
>  static cmdinfo_t allocsp_cmd;
>  static cmdinfo_t freesp_cmd;
>  static cmdinfo_t resvsp_cmd;
> @@ -41,6 +45,7 @@ static cmdinfo_t fcollapse_cmd;
>  static cmdinfo_t finsert_cmd;
>  static cmdinfo_t fzero_cmd;
>  static cmdinfo_t funshare_cmd;
> +static cmdinfo_t fwzero_cmd;
>  
>  static int
>  offset_length(
> @@ -377,6 +382,27 @@ funshare_f(
>  	return 0;
>  }
>  
> +static int
> +fwzero_f(
> +	int		argc,
> +	char		**argv)
> +{
> +	xfs_flock64_t	segment;
> +	int		mode = FALLOC_FL_WRITE_ZEROES;

Shouldn't this take a -k to add FALLOC_FL_KEEP_SIZE like fzero?

(The code otherwise looks fine to me)

--D

> +
> +	if (!offset_length(argv[1], argv[2], &segment)) {
> +		exitcode = 1;
> +		return 0;
> +	}
> +
> +	if (fallocate(file->fd, mode, segment.l_start, segment.l_len)) {
> +		perror("fallocate");
> +		exitcode = 1;
> +		return 0;
> +	}
> +	return 0;
> +}
> +
>  void
>  prealloc_init(void)
>  {
> @@ -489,4 +515,14 @@ prealloc_init(void)
>  	funshare_cmd.oneline =
>  	_("unshares shared blocks within the range");
>  	add_command(&funshare_cmd);
> +
> +	fwzero_cmd.name = "fwzero";
> +	fwzero_cmd.cfunc = fwzero_f;
> +	fwzero_cmd.argmin = 2;
> +	fwzero_cmd.argmax = 2;
> +	fwzero_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
> +	fwzero_cmd.args = _("off len");
> +	fwzero_cmd.oneline =
> +	_("zeroes space and eliminates holes by allocating and submitting write zeroes");
> +	add_command(&fwzero_cmd);
>  }
> diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
> index b0dcfdb7..0a673322 100644
> --- a/man/man8/xfs_io.8
> +++ b/man/man8/xfs_io.8
> @@ -550,6 +550,12 @@ With the
>  .B -k
>  option, use the FALLOC_FL_KEEP_SIZE flag as well.
>  .TP
> +.BI fwzero " offset length"
> +Call fallocate with FALLOC_FL_WRITE_ZEROES flag as described in the
> +.BR fallocate (2)
> +manual page to allocate and zero blocks within the range by submitting write
> +zeroes.
> +.TP
>  .BI zero " offset length"
>  Call xfsctl with
>  .B XFS_IOC_ZERO_RANGE
> -- 
> 2.39.2
> 
> 

