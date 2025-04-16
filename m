Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B402DC369C5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 19:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e5jX5vAkCjmrrtYmKuR4FVu2jjvQlpbRk2vPXmMuN0U=; b=xVo+G5wAxC6mVR3FHZznJIs1ZC
	UaUWijSKAqmbT1nTRqI63mDu0x+dalCr2fr/+rk1Gr7NKL8Xoihxc4vcMONeD5ownI2yx7gqC35KA
	Po9hJk+DltvGGcZYvlai1PSER/uShkl2BGYVqWgF+auyRdFRyDKdnozeydceaWQrCvJHYnA7F7lng
	MgDIhcWaTHL6g5uRklWz2Gq6GPi5OdQh63J/HH0QhRpkNExlqLbIGd8Y/0BB26jZKMYYXG69yQKzi
	3UdZCjkBJCX129AWgeAn5nGsOChbCAYW9owR32nxgi8jjd+MBRhPXDYaEA7hJpC+ddIUTKvHYJ8pm
	iY51cBRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u58Wd-0000000AhvH-3YFH;
	Wed, 16 Apr 2025 19:34:23 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u58Wa-0000000Ahup-4BkB
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 19:34:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C0BBEA4A52B;
	Wed, 16 Apr 2025 19:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E34AC4CEE2;
	Wed, 16 Apr 2025 19:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744832059;
	bh=geLExcJtOAjXjEY3nYZsjfpMc2TX5ES0OBy8m9gKC/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+A0oHTSymTtL9IlRxP2X49sZVIM+qKZykeUc2U1jckOh7Fab2nVwAlbNWbp/XYXH
	 72yCmdRJgMazizkaUaoxG0Wn7KFWs6aHcG6OfFWYy+IW8oFbj4GScY3vpMq0460m83
	 znneUQQNp70DChBAFipuLJMTCbl0QPbJuB9t45gg34S2XEtV2Xy7YIWXsmuR4MnGoB
	 ONm30k/EW8IhlQTZhxZ/RMNIYfZyo3oG6WmJH2ox1m2hZrI+VEcIhKMAYk9WTZNjB/
	 RizhkamT1QOnRjMZK46AjXuFi1Hwlokh2lbPLIBWcjDTJ5LJe25/TXY4xyWLb6lIOf
	 LWfCobji2UGcQ==
Date: Wed, 16 Apr 2025 22:34:16 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: chenlinxuan@uniontech.com
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-integrity@vger.kernel.org,
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
	Winston Wen <wentao@uniontech.com>,
	Changbin Du <changbin.du@intel.com>
Subject: Re: [PATCH RFC v2 4/5] tpm: add __always_inline for
 tpm_is_hwrng_enabled
Message-ID: <aAAGOIN-IsnTK2gm@kernel.org>
References: <20250416-noautoinline-v2-0-e69a2717530f@uniontech.com>
 <20250416-noautoinline-v2-4-e69a2717530f@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-noautoinline-v2-4-e69a2717530f@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_123421_164450_D722B49F 
X-CRM114-Status: GOOD (  30.40  )
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

On Wed, Apr 16, 2025 at 05:44:50PM +0800, Chen Linxuan via B4 Relay wrote:
> From: Winston Wen <wentao@uniontech.com>
> 
> Presume that kernel is compiled for x86_64 with gcc version 13.3.0:
> 
>   make defconfig
>   ./scripts/kconfig/merge_config.sh .config <(
>     echo CONFIG_TCG_TPM=y
>     echo CONFIG_HW_RANDOM=m
>   )
>   make KCFLAGS="-fno-inline-small-functions -fno-inline-functions-called-once"
> 
> This results a link error:
> 
>   ld: vmlinux.o: in function `tpm_add_hwrng':
>   tpm-chip.c:(.text+0x6c5924): undefined reference to `hwrng_register'
>   ld: vmlinux.o: in function `tpm_chip_unregister':
>   (.text+0x6c5bc9): undefined reference to `hwrng_unregister'
>   ld: vmlinux.o: in function `tpm_chip_register':
>   (.text+0x6c5c9b): undefined reference to `hwrng_unregister'
> 
> With `CONFIG_TCG_TPM=y` and `CONFIG_HW_RANDOM=m`,
> the functions `tpm_add_hwrng`, `tpm_chip_unregister`, and
> `tpm_chip_register` are compiled into `vmlinux.o`
> and reference the symbols `hwrng_register` and `hwrng_unregister`.
> These symbols, however, are compiled into `rng-core.ko`, which results
> in the linking error.
> 
> I am not sure but I think this weird linking error only arises when
> auto inlining is disabled because of some dead code elimination.
> 
> `CONFIG_TCG_TPM=y` and `CONFIG_HW_RANDOM=m` set `CONFIG_HW_RANDOM_TPM=n`.
> This causes the function `tpm_is_hwrng_enabled` to always return
> `false`, as shown below:
> 
>   static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
>   {
>       if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
>           return false;
>       if (tpm_is_firmware_upgrade(chip))
>           return false;
>       if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
>           return false;
>       return true;
>   }
> 
> When `tpm_is_hwrng_enabled` is inlined, dead code elimination
> optimizations are applied and the reference to the `hwrng_*` functions
> will been removed.
> For instance, in the `tpm_chip_unregister` function:
> 
>   void tpm_chip_unregister(struct tpm_chip *chip)
>   {
>   #ifdef CONFIG_TCG_TPM2_HMAC
>       int rc;
> 
>       rc = tpm_try_get_ops(chip);
>       if (!rc) {
>           tpm2_end_auth_session(chip);
>           tpm_put_ops(chip);
>       }
>   #endif
> 
>       tpm_del_legacy_sysfs(chip);
>       if (tpm_is_hwrng_enabled(chip))
>           hwrng_unregister(&chip->hwrng);
>       tpm_bios_log_teardown(chip);
>       if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))
>           tpm_devs_remove(chip);
>       tpm_del_char_device(chip);
>   }
> 
> When `tpm_is_hwrng_enabled` is inlined and always returns `false`,
> the call to `hwrng_unregister` is effectively part of a `if (false)`
> block, which I guess that will be then optimized out.
> 
> However, when the `-fno-inline-small-functions` and
> `-fno-inline-functions-called-once` flags are used,
> tpm_is_hwrng_enabled is not inline.
> 
> And this optimization some how cannot occur,
> leading to the undefined reference errors during linking.
> 
> Adding the `__always_inline` attribute ensures that
> `tpm_is_hwrng_enabled` is inlined regardless of the compiler flags.
> This allows the dead code elimination to proceed as expected,
> resolving the linking issue.
> 
> Co-developed-by: Chen Linxuan <chenlinxuan@uniontech.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> Signed-off-by: Winston Wen <wentao@uniontech.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index e25daf2396d37bcaeae8a96267764df0861ad1be..48cc74d84247e258a39f2118e03aa10d0cbb066a 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -534,7 +534,7 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>  	return tpm_get_random(chip, data, max);
>  }
>  
> -static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
> +static __always_inline bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
>  {
>  	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
>  		return false;
> 
> -- 
> 2.48.1
> 
> 
> 

Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>


BR, Jarkko

