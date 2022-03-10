Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5B4C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 18:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RDPqdqNCuDwqDa5kR/2nGkwsHmkez+kf3hdzw585ySc=; b=XtZSITnP35+QoAwbDB9nw0FQTn
	N3FKn7EHq9aKhCLMy635e7+olRJw+lfQWXQyGwv/uUsDsKykmcUbGUFIlGbT5V+Juy/GgYfm/vLqr
	iVEDm6ma7lyX9k7ttOdiggHyCZMfCDiZJiXDyz3e9ORInHpB6370sRKHWKZkPJszALdE+4IlV4YXh
	ecl4Kfk4/RLBdzBdra56zg5jqhyg319AtpM/6G1deWaVa0w136FSAsoibGwPyEvdUPWs6tcL/4+9U
	vWuXqIrpQZnnDnQ7/bfcoxIG+zGU13EnmWWhsk+gZYJn+LHz+CXE3+rTlEBxyozLrOYQbKiV7e4Et
	VNYk1etA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSNeh-00DjAa-2T; Thu, 10 Mar 2022 18:36:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSNef-00Dj9H-42
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 18:36:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 43CBE61E74;
 Thu, 10 Mar 2022 18:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE8FC340E8;
 Thu, 10 Mar 2022 18:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646937408;
 bh=RdgCysgl6dR7J0j7duKi30HlTSNbetlrjcptAA8yIP4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ORaAk5KDQ7MKF/ON/55HLWHpH4hL8dCDmsb+0tiseGNVUI7173pEQRS2YRjDFuP2d
 g8voDYpZnRnm6Hlf9R7Ql/GPkOSM56Jfkhq/MXjURxh9/Ikr4UNUstBWB8objSCEGv
 YDdg4YOl/OwUFVwmSjIM8h4lxYXLDbnXd/05buJtiyPxJ6fnhqL6afwtEAxWnfbDWK
 XfqNfUFABIZ8dfrnkccAs1AfHA5Ooo/nwVEcdv5fPuelqf3m2qThPB7ZTDk5tBiCF3
 lXwmN1oxcs+ruTpO0WT/iQgjJWF/goswaST0dk4R3X/7Rh5BwzJrB3X+NkMXBQRZZg
 v0pnRLNb5v6+A==
Date: Thu, 10 Mar 2022 18:36:47 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <YipFP8B8MxMxTVBR@gmail.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
 <your-ad-here.call-01646770901-ext-3299@work.hours>
 <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
 <YigzoKRJ1EHFRZY9@sol.localdomain>
 <20220309193126.GA3950874@dhcp-10-100-145-180.wdc.com>
 <YikEs7RNgPXTQolv@gmail.com>
 <20220310153959.GB329710@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220310153959.GB329710@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_103653_267940_56C34D17 
X-CRM114-Status: GOOD (  22.51  )
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

On Thu, Mar 10, 2022 at 07:39:59AM -0800, Keith Busch wrote:
> On Wed, Mar 09, 2022 at 07:49:07PM +0000, Eric Biggers wrote:
> > The issue is that every other "shash" algorithm besides crct10dif, including
> > crc32 and crc32c, follow the convention of treating the digest as bytes.  Doing
> > otherwise is unusual for the crypto API.  So I have a slight preference for
> > treating it as bytes.  Perhaps see what Herbert Xu (maintainer of the crypto
> > API, Cc'ed) recommends?
> 
> I'm okay either way, they're both simple enough. Here is an update atop
> this series to match the other shash conventions if this is preferred
> over my previous fix:
> 
> ---
> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index 914d8cddd43a..f9eb45571bc7 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -282,7 +282,7 @@ EXPORT_SYMBOL(t10_pi_type3_ip);
>  
>  static __be64 ext_pi_crc64(void *data, unsigned int len)
>  {
> -	return cpu_to_be64(crc64_rocksoft(data, len));
> +	return cpu_to_be64(le64_to_cpu(crc64_rocksoft(data, len)));
>  }
>  
>  static blk_status_t ext_pi_crc64_generate(struct blk_integrity_iter *iter,
> diff --git a/crypto/testmgr.h b/crypto/testmgr.h
> index f1a22794c404..f9e5f601c657 100644
> --- a/crypto/testmgr.h
> +++ b/crypto/testmgr.h
> @@ -3686,11 +3686,11 @@ static const struct hash_testvec crc64_rocksoft_tv_template[] = {
>  	{
>  		.plaintext	= zeroes,
>  		.psize		= 4096,
> -		.digest		= (u8 *)(u64[]){ 0x6482d367eb22b64eull },
> +		.digest		= "\x4e\xb6\x22\xeb\x67\xd3\x82\x64",
>  	}, {
>  		.plaintext	= ones,
>  		.psize		= 4096,
> -		.digest		= (u8 *)(u64[]){ 0xc0ddba7302eca3acull },
> +		.digest		= "\xac\xa3\xec\x02\x73\xba\xdd\xc0",
>  	}
>  };
>  
> diff --git a/include/linux/crc64.h b/include/linux/crc64.h
> index e044c60d1e61..5319f9a9fc19 100644
> --- a/include/linux/crc64.h
> +++ b/include/linux/crc64.h
> @@ -12,7 +12,7 @@
>  u64 __pure crc64_be(u64 crc, const void *p, size_t len);
>  u64 __pure crc64_rocksoft_generic(u64 crc, const void *p, size_t len);
>  
> -u64 crc64_rocksoft(const unsigned char *buffer, size_t len);
> -u64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len);
> +__le64 crc64_rocksoft(const unsigned char *buffer, size_t len);
> +__le64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len);
>  
>  #endif /* _LINUX_CRC64_H */
> diff --git a/lib/crc64-rocksoft.c b/lib/crc64-rocksoft.c
> index fc9ae0da5df7..215acb79a15d 100644
> --- a/lib/crc64-rocksoft.c
> +++ b/lib/crc64-rocksoft.c
> @@ -54,16 +54,16 @@ static struct notifier_block crc64_rocksoft_nb = {
>  	.notifier_call = crc64_rocksoft_notify,
>  };
>  
> -u64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len)
> +__le64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len)
>  {
>  	struct {
>  		struct shash_desc shash;
> -		u64 crc;
> +		__le64 crc;
>  	} desc;
>  	int err;
>  
>  	if (static_branch_unlikely(&crc64_rocksoft_fallback))
> -		return crc64_rocksoft_generic(crc, buffer, len);
> +		return cpu_to_le64(crc64_rocksoft_generic(crc, buffer, len));
>  
>  	rcu_read_lock();
>  	desc.shash.tfm = rcu_dereference(crc64_rocksoft_tfm);
> @@ -77,7 +77,7 @@ u64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len)
>  }
>  EXPORT_SYMBOL_GPL(crc64_rocksoft_update);
>  
> -u64 crc64_rocksoft(const unsigned char *buffer, size_t len)
> +__le64 crc64_rocksoft(const unsigned char *buffer, size_t len)
>  {
>  	return crc64_rocksoft_update(0, buffer, len);
>  }
> --

I think the lib functions should still use native endianness, like what crc32
does.

- Eric

