Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6DD606A331
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2RZHCuaM;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FEfYCCIC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=; b=2RZHCuaMyKuAsssNJqh3VajV8j
	q9Z6ex4Uus5i2HwFt0VaIlASzau5rR2+Ndng9HrD14mKTv4mpsJFYPMMy0r5PCcDRs92s6VjwVacv
	x4Nl7o4E4Ky2xC/aFG1ICrWw/pCFcBackOvmgOZviHlULdv/wqyZg/jmIFHfjO/vRygiWIdEvELjo
	WHSfLA7jMrd2YnHDF/q3tU/5CQZInOrzC6e9VsM/+bkgIFr8MhzuoXgrG+UawgzN8w65lMFIcK5Gn
	XRkgM3QcyiXirhMNNxg354Z6mw6fn9Vlr8QwBg6bF7Z74GPoiC8IvsJnKCdKQVxUEYDOTUJWbD3OA
	qo4vDg5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSCji-0000000Fzzd-2um4;
	Sat, 14 Nov 2026 12:20:02 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSCjf-0000000Fzyf-2KrC
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 12:20:00 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-c40e30c26a4so402486766b.0
        for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 04:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794658797; x=1795263597; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=;
        b=FEfYCCICow7f9FJ+S9tQtbiE0jkd4o5irGBZhyXbf0g82qDu1PUYXv3rkGQYb67Ygs
         PT8so4AbHikogMTrHHiu9lxU8m9IRr0ND229/A+ThuH+S+v6vCcALi2Oh8dJ0biA4tJG
         kczWW8Sl7KMlfP44Bvc9b1JrUUNk8TUX9idPZX+iIGFVcKhEz0J/EYnQE5d/IzVlx78t
         DLLex/wS5Wqi0MjtoGuZaQ0IKMyJHFpHhVjfOux/r7TN3w8TG2QOc2LJvr/JPPAsRkQQ
         ebhldPJH1IUMzPPxoQoWaoXOm7lz/rrvjYyiXlagcg+8Lc2IUQf8OoL3zgFQI+Vv8VNw
         IYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794658797; x=1795263597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=;
        b=sOI6Ef9Z5Q947HeqZd2/pgPeFjBWsjjyTIg6FGMgJNfxOiEhCQj9lUheCibikCW5Ey
         4CtN0QzHpUM/kSmwRfRVa44aJYSEAG9owwM6sLz5yNXWLwDzGLU5NH07A5P/arOrC15F
         EqkaIOIt1V0XcTlNqVOv0k3D4gjK1UcWPWoSx0R2+5wg/RZB2jgHT7HRKkrrq0bWgld3
         SJiGpg6zr3cAyTykeBpjXDqRgClAH1rUbGHrzzyLv1tTUYrasePgcd27dBH2kN4i/5VS
         nL8+istzoIN8j0XPAqgSg0g4prb9dBN5HpjIrHSskOCFQ2LTs44q7rliBGJwSLwz5aCm
         jeVg==
X-Forwarded-Encrypted: i=1; AL+hErGrgId3t2neYWgjjAUIvZI1iP5V+hKmc+Yw50hx+00tsJ6rSnIlzXPEP2XScdPA86uwCDohjwrmSCwj@lists.infradead.org
X-Gm-Message-State: APuU4Z+bzEf7AgBVMaynCLlDhHYmc1myKQByJCc9bZ3c6q4GUjnXg73G
	BRtcw8Q1cWcJuOE3prbJXGNrP05S9yI5OOy387qiVi3VFU9ARl/suroHYmYOJLGo
X-Gm-Gg: AYBFou2fM9ChS33QS3La9Br7S4E1uamsdto+GAnKI9wxLK4vpHc3kfcJlBxvRf/ZOKJ
	NLsFi5ZlNbvL+n/5iLk4xgMole0e6t5bZ3njp+E8ql9FPfi0XFUB9Bx7JKw8FgJyATjgyXzDV9j
	lu0U/ERTMxmbzlaN7QCmCIa6F/lJQXp9JHXK0ht7AtQgIt13VA6tGZu8gt3QYjcteKIp5a7ryDc
	xmxca6RkpUNxUbVAgzq7r3WSJNsd00XbntJZ80s7BqdkpxedhATEeW7fNcuHYQRWaDgCpHsYHMJ
	DfeejiW2KV7+HAsanM7Sr0jJ0f3sTIq6j/k02y1yim+/WFIeKuLYqDwXaISr0OKSJ9TXB5YTeMC
	lmO/nnkmkSsg2tv1dlIAj4Hvaj3OC8NBCCzhnryOpEQFZVz1h6ZzYwhr/k+jvpgchmr3Da6zTgw
	retSqJpEXzZQN8AB3+t2Kg4aOhpD/35m4n3gM2SJZs0a4qKiOmsJ7ikoiFv1JldjPJqLWEvDXJ2
	/V51mrsPyA1yzF5ofV8vDEF8wdUngf8ZtUYNrTTZaB/vUDOl6Yebk4PwPzmDTOiYhEg89vOXtHt
	ka6Rwt6kIVNsLaq2DNagMpI0YinSWwcC1GvZESBEkL7Wk/OwNWxcLAsw3XbhqwPehFJLEuE+IAL
	CdKfL9TFHyhZz
X-Received: by 2002:a17:906:1001:10b0:c41:4512:560d with SMTP id a640c23a62f3a-c5096387b02mr309942166b.16.1794658797424;
        Sat, 14 Nov 2026 04:19:57 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b5ac2asm211518966b.55.2026.11.14.04.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:19:56 -0800 (PST)
Date: Sat, 14 Nov 2026 13:19:56 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	bpf@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 10/12] ovl: take freeze protection when storing the uuid
Message-ID: <avhR7DbNbVDCyPDO@amir-ThinkPad-T480>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
 <20261114-work-fs-frozen_writes-v1-10-f5ae61c898b1@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114-work-fs-frozen_writes-v1-10-f5ae61c898b1@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_041959_613940_9199986A 
X-CRM114-Status: GOOD (  19.14  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 11:47:17AM +0100, Christian Brauner wrote:
> ovl_init_uuid_xattr() stores the persistent uuid in an xattr on the
> upper root. That happens after ovl_make_workdir() dropped its write
> access to the upper mount and before ovl_get_indexdir() takes it
> again. So a freeze of the upper filesystem that lands in between lets
> the mount modify a frozen filesystem.
> 
> Take write access to the upper mount around the xattr update.
> 
> Fixes: d9544c1b0d9e ("ovl: store persistent uuid/fsid with uuid=on")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  fs/overlayfs/util.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 521717209b2e4..67aa7b71e9c83 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -829,8 +829,12 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
>  
>  	/* Try to store persistent uuid */
>  	set = true;
> -	res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, uuid.b,
> -			   UUID_SIZE);
> +	res = mnt_want_write(ovl_upper_mnt(ofs));
> +	if (!res) {
> +		res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID,
> +				   uuid.b, UUID_SIZE);
> +		mnt_drop_write(ovl_upper_mnt(ofs));
> +	}
>  	if (res)
>  		goto fail;
>  
> 
> -- 
> 2.53.0
> 


