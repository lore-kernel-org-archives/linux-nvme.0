Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6287E606B25E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ccb+3YgG;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tcwd7Q8/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zSjXnOetE5oKa5v8S9LBrUhcmgizc8ch93AeD/W6gEI=; b=ccb+3YgGwDAbv8
	dgKKULmRZUhX60EOptLp0S5xstQ5bu1LDEI0JrW26kRW4mgu4SGJsaXeRJ2XQs0XidcQ4MpsRvHdB
	FWRdaubOls1X1YAK2A0WrcvZ6LvkxTip6l9aCVPRaCc7jk81XQx8HiBSJ8ahZy0zaZdo66EoQG/g/
	b15Rx6tcb6LqxolA/75CYbPaHPyKwDpK6F4zwgKY3hBWEeDIKZG7Wp8VohOGFCBjMyM+2U+gjRyOt
	UM7Qe4sVDGwXG96IfP0gWTaHHJL0ESl8bNrYdfTpTnkAXfLUMcEJgzzSUwHHS2XQzI/qWJYgcaaHe
	a4cMkycBFH4JIH5arVVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhu-00000007lQ5-1VHI;
	Wed, 11 Nov 2026 21:18:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnGI-00000004HyD-0qU3
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 14:55:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9F0FC639E8;
	Tue, 10 Nov 2026 14:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E4C1F008A3;
	Tue, 10 Nov 2026 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322549;
	bh=zSjXnOetE5oKa5v8S9LBrUhcmgizc8ch93AeD/W6gEI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Tcwd7Q8/BgCZr0AJA+q53XtkaEXHNBQAptcCIoE3INOkDT8T++JPLwFgnijhu6LIp
	 QoJCfJqeBNhK26M7LL9xd4MzXxKVISVDOEW1cYrYEyBiFKRmR2hdLsioEex6m+2Rc5
	 2AgfVzjCsuMDtAVvAKOrFX1qXAfAYeUYjVl2rownrESZ29DXkmWTHYRM7alPMZLQ6M
	 DZH727vPlYTYzZb+oco6o/Bkhlk4m5LBSezhlvCb0bhHHiXIMbUlIMDObU3PIfYN46
	 k7napT6YlagBuXnh78UDBF3WtFBwiJfcd2zG9H8WTZ7Zkc62YNaLopDBhwYuzfc472
	 iPuH2WgxnRVeQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B2761F40069;
	Tue, 10 Nov 2026 09:55:47 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 10 Nov 2026 09:55:47 -0500
X-ME-Sender: <xms:czDzahOxHA_IGoa_FJdwV0BFPQw-nSdKO6kKGUN5puCfrxj2G2sK_w>
    <xme:czDzauxKYck9zKSqhpZaTHxPL9lIOi42MPCnrNTR7eaQqnpkmbe8dEx0PuhUogQkg
    tb2W38kOzksOJlDJ4uTGR7-rkbiwtctKuF5oVtOm556TqS1yjjUw9U>
X-ME-Proxy-Cause: dmFkZTE8jIcOTzT9axQiHwEjJScKTRkNH3ZVhgYbwXrBMnGwr/PZk5kUfGxy+RC0ezRM03
    2Axgl1A3kstcvJQqQJ+tEirxS634eXBQm2b+wwk+7byJnMoEdYYw7Lfb7185Bnwoliq1Mt
    XZ8lliUhOZ8AACZwbl4T2Tc7NYRy4GvnOujvSweRGBGAD4OQXGjTipshhA5n2cB6RQlk4p
    zmTRFZMOMjoY8cueG7e24ndoN2R/gq/lSNUbCVZu/PUOrAg9f6aovYYa9SSKBBYGtgXYMN
    0qbpFOi4S4kwXDcxuFcZlmK43Jt2p3+0W9uSzX8U3QJynW/odwma6a1hhpAbc8zEaSnbtk
    CFI/IAk8YwHJ0hyg7qaH8oiiVC3V/1ZiobIhoPO231VrqQk5oaP4jl+jS7yMnBbNxynDhF
    /tTsfxMaF/A9xwJBu4sKm+3lzwzMEEbqt79mE4Lq/VAgowI2/Z3gVdFMTE48DIB1KcUvAe
    gGFx1Bx/tQmWXfeE09uUSkiQ2KYN+OrlgTMnrepjVRxO73rY2t7sodPh2AhJIAG1ZYT5ga
    3nwb3G0mQrnmFOm4Qa4C2JwbajMdJBWMeam4uZKQraajbqcBHzCXvMtQm1fQbm3S2rexTo
    KA6wW/vDabSoXlut9Nm5uKTSjp20eGQ9lpLOxOz31c8eLm8Mlp10sjOYDNZA
X-ME-Proxy: <xmx:czDzaoanLMdLTFqhzMhrxv5H09chgFe3GMMhc1XBCkfiMJQ_ckta8Q>
    <xmx:czDzauzWTK7EYc76X_4JSXvP7e9Yqejr2yggz6O-tuvCpsEWBQGUaQ>
    <xmx:czDzasWQEDY8T3p3eaJhPzKDKFxYGPCQnFb1-n-prg7tBs3f0gJpWA>
    <xmx:czDzaqbpJaYjvNkk5zy3xoww5EsXMA5_awnvU25FYCgSdhgQQ41Hfg>
    <xmx:czDzavOKwCwywHfR1JNgdmNe33GAeUXrw31wmu_3YBRbMsucyl2ChD_t>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7D2B9780070; Tue, 10 Nov 2026 09:55:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKCAcWHxcB8B
Date: Tue, 10 Nov 2026 09:55:27 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: "Jann Horn" <jannh@google.com>, "Chris Mason" <mason@kernel.org>,
 "Josef Bacik" <josef@toxicpanda.com>, "Christoph Hellwig" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 target-devel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
 xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
 linux-s390@vger.kernel.org, "Linuxppc Dev" <linuxppc-dev@lists.ozlabs.org>,
 linux-usb@vger.kernel.org, "Amir Goldstein" <amir73il@gmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Message-Id: <47b8b8cb-aadb-4f84-aa5c-c5a74d73fac1@app.fastmail.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-21-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-21-4c998976c6c7@kernel.org>
Subject: Re: [PATCH RFC 21/41] nfsd: use fc_init_pseudo()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:02 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Tue, Nov 10, 2026, at 4:14 AM, Christian Brauner wrote:
> Initialize the nfsd filesystem as a pseudo filesystem. This raises
> SB_I_PSEUDO and also SB_I_NOEXEC and SB_I_NODEV. It never holds
> executables or device nodes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/nfsd/nfsctl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index f32311f2d7cf..ce2666deddbd 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -9,6 +9,7 @@
>  #include <linux/namei.h>
>  #include <linux/ctype.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> 
>  #include <linux/sunrpc/cache.h>
>  #include <linux/sunrpc/svcsock.h>
> @@ -1375,6 +1376,7 @@ static int nfsd_init_fs_context(struct fs_context *fc)
>  {
>  	put_user_ns(fc->user_ns);
>  	fc->user_ns = get_user_ns(fc->net_ns->user_ns);
> +	fc_init_pseudo(fc);
>  	fc->ops = &nfsd_fs_context_ops;
>  	return 0;
>  }
>
> -- 
> 2.53.0

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

