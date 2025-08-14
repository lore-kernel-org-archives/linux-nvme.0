Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B38CA0EDC
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Aug 2025 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lRJSwxEnHv9W3+HiyrDzyVgDsTHeLbVWurUWf41xO4g=; b=GwMHqAdBotyiCfbol5r1iQIk3Z
	iMze8oBXP0SAnDCVBEiL33Apq2FwlJMD/pn1oUNMqdSGNqOrwO+aYztY/wZeCIoMaTcRzCqp5VjMT
	Et5FVvaB6GAxYObc9E1zO8dQSax7tdw9MSsqZYwLvhYAapEJshPoFW24kVy6p5AlLd2nGHDKLx/6c
	a3DwELQXE0GgbWowKfoxjRFKKpU9Gtn0PSvTZiwqd/Mo4VxPulVFGduJx1tnc+1/GW4iMncF/qns9
	RLBagRFtH5AMI8ekhWiDeSMRT3ECgitCP1+IDo2SGPn6oPK/FFIh0YhmmqIc/h/MMLoLMnrj3luVm
	O8E2KXkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umcGl-00000000HGi-45t3;
	Thu, 14 Aug 2025 18:01:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umbBd-0000000071R-1HDR
	for linux-nvme@lists.infradead.org;
	Thu, 14 Aug 2025 16:52:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C12495C6F3C;
	Thu, 14 Aug 2025 16:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A1CC4CEED;
	Thu, 14 Aug 2025 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755190339;
	bh=xDCJGRAkBOyLHPMWTglfKooDZPEiLk+khkQLFD0KVoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUS4ikf7AX6C88z+F2/XSv+1M5hXVOMeC77XiWieyZa2GUP+2JJyYoUpfS/WdwAsu
	 ODwd2O9RQzqvCWcRwAYScP7FOJ4OValdyb74tAUxKwmMZuHw3kAOuuK/32EFAlIB6W
	 qNW9YJ/ibCooE9homzMY+TCAM+G0BVHnPrpXHw+jcSJ9xVgSohIjtZZ0quEJMUShat
	 gX6/7xyHZgEggW9goPqtgemixofVOS7TxSvMic1AsL8yErqzhTzcIu5N5UqooXONtH
	 roS/Aif++L6UcDVzhcuO7rzAZWCyapIDdUPBjaUBawYOz7SE45r5e0bZRAAMk1oF1l
	 xHgOiDmsucQQg==
Date: Thu, 14 Aug 2025 09:52:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, hch@lst.de, tytso@mit.edu,
	bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH util-linux v2] fallocate: add FALLOC_FL_WRITE_ZEROES
 support
Message-ID: <20250814165218.GQ7942@frogsfrogsfrogs>
References: <20250813024015.2502234-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813024015.2502234-1-yi.zhang@huaweicloud.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_095221_444539_24DD96C7 
X-CRM114-Status: GOOD (  29.49  )
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

On Wed, Aug 13, 2025 at 10:40:15AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The Linux kernel (since version 6.17) supports FALLOC_FL_WRITE_ZEROES in
> fallocate(2). Add support for FALLOC_FL_WRITE_ZEROES to the fallocate
> utility by introducing a new option -w|--write-zeroes.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> v1->v2:
>  - Minor description modification to align with the kernel.
> 
>  sys-utils/fallocate.1.adoc | 11 +++++++++--
>  sys-utils/fallocate.c      | 20 ++++++++++++++++----
>  2 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/sys-utils/fallocate.1.adoc b/sys-utils/fallocate.1.adoc
> index 44ee0ef4c..0ec9ff9a9 100644
> --- a/sys-utils/fallocate.1.adoc
> +++ b/sys-utils/fallocate.1.adoc
> @@ -12,7 +12,7 @@ fallocate - preallocate or deallocate space to a file

<snip all the long lines>

> +*-w*, *--write-zeroes*::
> +Zeroes space in the byte range starting at _offset_ and continuing
> for _length_ bytes. Within the specified range, blocks are
> preallocated for the regions that span the holes in the file. After a
> successful call, subsequent reads from this range will return zeroes,
> subsequent writes to that range do not require further changes to the
> file mapping metadata.

"...will return zeroes and subsequent writes to that range..." ?

> ++
> +Zeroing is done within the filesystem by preferably submitting write

I think we should say less about what the filesystem actually does to
preserve some flexibility:

"Zeroing is done within the filesystem. The filesystem may use a
hardware accelerated zeroing command, or it may submit regular writes.
The behavior depends on the filesystem design and available hardware."

> zeores commands, the alternative way is submitting actual zeroed data,
> the specified range will be converted into written extents. The write
> zeroes command is typically faster than write actual data if the
> device supports unmap write zeroes, the specified range will not be
> physically zeroed out on the device.
> ++
> +Options *--keep-size* can not be specified for the write-zeroes
> operation.
> +
>  include::man-common/help-version.adoc[]
>  
>  == AUTHORS
> diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
> index 13bf52915..8d37fdad7 100644
> --- a/sys-utils/fallocate.c
> +++ b/sys-utils/fallocate.c
> @@ -40,7 +40,7 @@
>  #if defined(HAVE_LINUX_FALLOC_H) && \
>      (!defined(FALLOC_FL_KEEP_SIZE) || !defined(FALLOC_FL_PUNCH_HOLE) || \
>       !defined(FALLOC_FL_COLLAPSE_RANGE) || !defined(FALLOC_FL_ZERO_RANGE) || \
> -     !defined(FALLOC_FL_INSERT_RANGE))
> +     !defined(FALLOC_FL_INSERT_RANGE) || !defined(FALLOC_FL_WRITE_ZEROES))
>  # include <linux/falloc.h>	/* non-libc fallback for FALLOC_FL_* flags */
>  #endif
>  
> @@ -65,6 +65,10 @@
>  # define FALLOC_FL_INSERT_RANGE		0x20
>  #endif
>  
> +#ifndef FALLOC_FL_WRITE_ZEROES
> +# define FALLOC_FL_WRITE_ZEROES		0x80
> +#endif
> +
>  #include "nls.h"
>  #include "strutils.h"
>  #include "c.h"
> @@ -94,6 +98,7 @@ static void __attribute__((__noreturn__)) usage(void)
>  	fputs(_(" -o, --offset <num>   offset for range operations, in bytes\n"), out);
>  	fputs(_(" -p, --punch-hole     replace a range with a hole (implies -n)\n"), out);
>  	fputs(_(" -z, --zero-range     zero and ensure allocation of a range\n"), out);
> +	fputs(_(" -w, --write-zeroes   write zeroes and ensure allocation of a range\n"), out);
>  #ifdef HAVE_POSIX_FALLOCATE
>  	fputs(_(" -x, --posix          use posix_fallocate(3) instead of fallocate(2)\n"), out);
>  #endif
> @@ -304,6 +309,7 @@ int main(int argc, char **argv)
>  	    { "dig-holes",      no_argument,       NULL, 'd' },
>  	    { "insert-range",   no_argument,       NULL, 'i' },
>  	    { "zero-range",     no_argument,       NULL, 'z' },
> +	    { "write-zeroes",   no_argument,       NULL, 'w' },
>  	    { "offset",         required_argument, NULL, 'o' },
>  	    { "length",         required_argument, NULL, 'l' },
>  	    { "posix",          no_argument,       NULL, 'x' },
> @@ -312,8 +318,8 @@ int main(int argc, char **argv)
>  	};
>  
>  	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
> -		{ 'c', 'd', 'i', 'p', 'x', 'z'},
> -		{ 'c', 'i', 'n', 'x' },
> +		{ 'c', 'd', 'i', 'p', 'w', 'x', 'z'},
> +		{ 'c', 'i', 'n', 'w', 'x' },
>  		{ 0 }
>  	};
>  	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
> @@ -323,7 +329,7 @@ int main(int argc, char **argv)
>  	textdomain(PACKAGE);
>  	close_stdout_atexit();
>  
> -	while ((c = getopt_long(argc, argv, "hvVncpdizxl:o:", longopts, NULL))
> +	while ((c = getopt_long(argc, argv, "hvVncpdizwxl:o:", longopts, NULL))
>  			!= -1) {
>  
>  		err_exclusive_options(c, longopts, excl, excl_st);
> @@ -353,6 +359,9 @@ int main(int argc, char **argv)
>  		case 'z':
>  			mode |= FALLOC_FL_ZERO_RANGE;
>  			break;
> +		case 'w':
> +			mode |= FALLOC_FL_WRITE_ZEROES;
> +			break;
>  		case 'x':
>  #ifdef HAVE_POSIX_FALLOCATE
>  			posix = 1;
> @@ -429,6 +438,9 @@ int main(int argc, char **argv)
>  			else if (mode & FALLOC_FL_ZERO_RANGE)
>  				fprintf(stdout, _("%s: %s (%ju bytes) zeroed.\n"),
>  								filename, str, length);
> +			else if (mode & FALLOC_FL_WRITE_ZEROES)
> +				fprintf(stdout, _("%s: %s (%ju bytes) write zeroed.\n"),

"write zeroed" is a little strange, but I don't have a better
suggestion. :)

--D

> +								filename, str, length);
>  			else
>  				fprintf(stdout, _("%s: %s (%ju bytes) allocated.\n"),
>  								filename, str, length);
> -- 
> 2.39.2
> 
> 

