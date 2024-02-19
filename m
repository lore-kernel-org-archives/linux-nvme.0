Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54150C48BC3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 22:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A9Ts2f1R3ZP5ehz4Ryw7qzx5Hb49U9Z/fGb1ezuOXHs=; b=BEsZXtEAOaxiECPFbsPqUM0erH
	udzB/0waom40cSGjkiIMED5Aw/maeqTMaXPoYuDYQWSfxfKlcaL9uhHMg7vjaJtNAby3JZDOSRlCC
	FuHpuWewZXKV00N68aKIXmnsd5+145yTpUmzh2QC6eDK9rcZX6x5sdF1r21ZMcQeVVf5d4/OiHqbI
	H4QA0NuORq0erGTxorIP6B1Yw1AaMeWuzd8OtvN9htYAvztkzg00/2++i/yomujAfjwjQeAjLp9MN
	wZ+QsN3eS0wj/uq+Oxu+nCu0wrveDb4WB3vOtXQtlPHNgu8aDKWeRsJl3JNnCjZvzC46EyHfD9VAO
	udDpKvFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcCN3-0000000CSxr-49Pm;
	Mon, 19 Feb 2024 22:44:21 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcCN1-0000000CSxH-12MT
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 22:44:20 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d73066880eso46781585ad.3
        for <linux-nvme@lists.infradead.org>; Mon, 19 Feb 2024 14:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708382657; x=1708987457; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9Ts2f1R3ZP5ehz4Ryw7qzx5Hb49U9Z/fGb1ezuOXHs=;
        b=R1kD92pdB9C0DuQYwGVK+xbo+8IZmm4X7DkvxBNBnw+wgdIEVlkAQe/bUgMW0bf9bM
         CRDsAYuD87DPgV8HPGBr+HZCLe/LmhriYGdJQIs3OkImNLnlDu/fniNXEnG/MmE9KIty
         tLKyenzfj7RxUwkQBasJc1BpjwProwwQb5Hb2xg74vEv2cYtlCaLUeOJNVaKtobdUt69
         syM74m3D8QEGwFjz0B/Y4XRsXUQNFStzTkUbwsE+TEnxRzp4+4ziTKNZucCVYiTLDG1s
         S4My3vHI8fnF5MouKqh95BwtQupJ3O18TJnyz0GO4yUoUeZ3EUPQWSZ2hLTItZm+Uq0i
         6W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708382657; x=1708987457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9Ts2f1R3ZP5ehz4Ryw7qzx5Hb49U9Z/fGb1ezuOXHs=;
        b=Te6KAhw5d+6jLToACQOpdYdu2alEzr3CtJkTlzFXWQiI+4RCY6FxUhl+RdusxvoGEB
         LP1JpBS0QePuSGpun9oQrMHgPbfFEwHQa/Vr5hArsU3bGLmXyzK1ljGi+LJhXE0Etu1K
         xMYWG7QS9q7ygxEkT3S3KQYuYW2e3U+isBKOrllbNo34Zgi7O/Hq9Vpyeqeatv85EPfM
         KOPNq+RaSMi1jnc9vxPcxw3BYs499bNLzq6x2gCOUCghqB1b24JiSKuOLz3H7MkmpE9d
         aJ1z+o/ik5sOo7evJEjB2PpFrLA1yVqJsAyUo7EuYQqHUY3oYNkXlfl8mxDW4tSCe55k
         Ejxg==
X-Forwarded-Encrypted: i=1; AJvYcCVNLSXS7aMkR21OagEqwVDuMcY2Q+5EAVws6QPED63JlJqIesU1NAgVhJWz1J6t/2S30zWQiWbDwk/hn1keudDy+5+x1yYvZk/T+G3uwxM=
X-Gm-Message-State: AOJu0YwuI5nUs1Ei10WxU8Anbx3+2qn9kh87SvSZmwFO72mDbwfhL4bs
	75ym4NyVq6fdI99QS5XbPNOMB9BVwgyVFd2cvQ3Xrjvi25HNUPewfdbHXcRg0m8=
X-Google-Smtp-Source: AGHT+IHtkpRXt4t+i6SxwRLeZE82T0JiGotni2ywqDT8XTyF+HxlsLNBTl8TRCMTJinSK3yziLiesQ==
X-Received: by 2002:a17:903:1211:b0:1d9:a609:dd7e with SMTP id l17-20020a170903121100b001d9a609dd7emr16096638plh.55.1708382657159;
        Mon, 19 Feb 2024 14:44:17 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id lw15-20020a1709032acf00b001dbb6fef41asm4880249plb.272.2024.02.19.14.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 14:44:16 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rcCMw-008oFa-1W;
	Tue, 20 Feb 2024 09:44:14 +1100
Date: Tue, 20 Feb 2024 09:44:14 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH v4 03/11] fs: Initial atomic write support
Message-ID: <ZdPZvqLgwWSP1ppv@dread.disaster.area>
References: <20240219130109.341523-1-john.g.garry@oracle.com>
 <20240219130109.341523-4-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219130109.341523-4-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_144419_305891_E30A2A80 
X-CRM114-Status: GOOD (  14.56  )
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

On Mon, Feb 19, 2024 at 01:01:01PM +0000, John Garry wrote:
> @@ -3523,4 +3535,26 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
>  extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
>  			   int advice);
>  
> +static inline bool atomic_write_valid(loff_t pos, struct iov_iter *iter,
> +			   unsigned int unit_min, unsigned int unit_max)
> +{
> +	size_t len = iov_iter_count(iter);
> +
> +	if (!iter_is_ubuf(iter))
> +		return false;
> +
> +	if (len == unit_min || len == unit_max) {
> +		/* ok if exactly min or max */
> +	} else if (len < unit_min || len > unit_max) {
> +		return false;
> +	} else if (!is_power_of_2(len)) {
> +		return false;
> +	}

This doesn't need if else if else if and it doesn't need to check
for exact unit min/max matches. The exact matches require the
length to be a power of 2, so the checks are simply:

	if (len < unit_min || len > unit_max)
		return false;
	if (!is_power_of_2(len))
		return false;

> +	if (pos & (len - 1))
> +		return false;

This has typing issues - 64 bit value, 32 bit mask. probably should
use:

	if (!IS_ALIGNED(pos, len))
		return false;

-Dave.

-- 
Dave Chinner
david@fromorbit.com

