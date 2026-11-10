Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599A606A32A
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SpHrM7G/;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhEODFnv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=; b=SpHrM7G/hdOuGwfGQm5Wvslg82
	75s5v3DmCNGOVX0zPF/oPCq9GtSz4YppPVwOiLq3Lvi8cZlCMxyTVREchh7yO146iE685gKGuK1Om
	9nv477xY4PBu8cX9DxKhcvFiYlp4/BIqwrOEDPnHH1O6qD3cEfRN4evStBK0MnXGy4/hqqqtoEGKO
	i952IGENwqJFi840ItNtI2CWszJlGgM5e84oxRDSiDagpGVMYbHfipOfJyg6W9wus3A6WeomQN27v
	J7SGsBc96+frjd1W8eLKwtNo9JPqn4VmU7WQC47Pl98KxWC7TiuNTQCp+/GM6SSoOxAgBhPBzt+wV
	JV3tlCvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhS-00000007kSh-3JTq;
	Wed, 11 Nov 2026 21:17:46 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQisC-00000003Qet-0kQO
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 10:14:41 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-c4395d31228so245008966b.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2026 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794305678; x=1794910478; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
        b=UhEODFnvqfuMWaQAoKsoumMhoTg7kEBIR+LI0kE+lIF6Z+1uduZMatBx22ePbK2f34
         WKJgINNJmHDP/W+w1I/ZrirxNubkHbt8MkcpZQ7/vIHDDF6LrYV+3D0ne0IAMsXT7piu
         qzNdB1vTRjEFU8GsoJDmESx59MWq4o5gvav+uHxGAe2DAo6bsRDJFsn7sLmiW7OOPr2a
         ZR1VgKxta52ounyXNW0T874DfahXKcFXQ3EdZSWaHmH9i3GSOqKYYu13Ub3VC25ZyHxs
         KZjeEuubQdILELpDyWlxhMru2mUsSfdKnHrKYCVu8dADkj4whys7mgUnrBV0KD93k/Xb
         jFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794305678; x=1794910478;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
        b=DDw6aoHLW0TNCt8skY+NlzgL04qYnbiDOtHdV8ekUV6yuCRIm281s70vv9FS3ROooM
         0Bxo6Q+8X9TawMwGzfrsQj03G6I5Bwcb3o8jmzsAs1CQDl5eY92NNoFgd2vBXJzG0nas
         IfuxaG3uH9wSR0rTr4dhKhANz2ctUlzEKiQJfCd7jU/MJTyxxeHOeDBofVE+qlxOVpoS
         I6eGGoeHtWO/WtUUdGgshqGLszf1hvcLHx6XzZNKF7gEFSwup0OoKFxLhvr/in2hqwuS
         8Kt578j1ukczazRKIzMgv5r/llNi7kLyOlB8WYlwgsKrNxIEbkIszbn6Ju+9m4ElQ8Zq
         2Q9w==
X-Forwarded-Encrypted: i=1; AL+hErH3cpNMlZyk6nl1JKxMiHlxT5V4dzDsKAnDkLhaPfiai8hVjnmTyhpvjwod5M9zgVD/7xhHt21hybCu@lists.infradead.org
X-Gm-Message-State: APuU4Z+sVxVN8/M7ArbIgRwM2Ce26QCZ0SbNB1tpai3eyinBI+OCpcO+
	viWgn+TpdVuGhxM0W+Pj/2KbUCz0XqYOsR1ziyUCdSmZb81J+knF03aB
X-Gm-Gg: AYBFou2rJW54LCl5rDE02vFQ7bNemqpqWH9oXDVHc+XVAA5pOlxu8lbX9jHVmgWpW7l
	IuZxYNb2F12S9U3g8hZOv0RPxOLt+aNobe2CV8Iz0qinE7tz3G4aiit32v45t9mMcTWf4zYFLuP
	dTY/+fnsOQMRW2wqy1FJ7fHgQWhKSSxGs0jZGbDeMxPrWK4hmnNlkz9riz4lMBk2u1udjDRXyhB
	uL9qXMTdOfBkrNcskbWvMEjACsK0RNEHizlmbNZZ68FLWcju4lZAB1yHMn/n3tRcB7Wcaprlrcm
	hgy0cZKXG2gWGBdsKCnRQaBB6UxhdK5VcfJj/o5YnPHJbedAXAOvybNpxDlvGUHnghraVLsQHrN
	3fgwAVd+Own6RfQsB3L5nRUEkC0/cLWqXIPM6WxRJkErqdYkoAJ+VHIy9a2G+S14v5UAWrjO96+
	LoccRNQvBc62zq3MJIOJJSOhB51OTXrSNrw6Mhw92NZ+H/0BSTWaUKC4/iCJKz96+KtCA95Q7YI
	YiCoqwYTjJrncA9Ly6tTJd5Svrf2qHtaiHldEiJeR74vdygE/OhvyTQ9NiDUIGNnshKMyQuZGNP
	OylQgxi6+OQTbTVoswI9Q3u5gNakMHZPIbUaXopO4ZI8fm+9gB8si+XgyoY8Ye1r1JDhfJE6+Mm
	GvasiS9gC60/Q
X-Received: by 2002:a17:907:944d:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c504963ce05mr189793966b.44.1794305677695;
        Tue, 10 Nov 2026 02:14:37 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a593eacsm90433466b.36.2026.11.10.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:14:36 -0800 (PST)
Date: Tue, 10 Nov 2026 11:14:35 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Message-ID: <avLui6Mpf8GbKbtc@amir-ThinkPad-T480>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_021440_235177_5DD49A24 
X-CRM114-Status: GOOD (  19.38  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:03 -0800
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 10:14:54AM +0100, Christian Brauner wrote:
> The fuse server can register any regular file as a backing file. procfs
> and binfmt_misc files are already refused by the stacking depth check as
> both set s_stack_depth to FILESYSTEM_MAX_STACK_DEPTH. sysfs and the
> other pseudo filesystems aren't. Reads and writes of the fuse file would
> then be done on the pseudo file with the fuse server's credentials.
> Refuse files on pseudo filesystems just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/fuse/backing.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index 8c21a8a74efb..4e4fb810ddaa 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -147,6 +147,9 @@ static int fuse_backing_open_file(struct fuse_conn *fc, struct fuse_backing *fb,
>  		if (inode->i_sb->s_stack_depth >= fc->max_stack_depth)
>  			return -ELOOP;
>  
> +		if (file_is_pseudo(file))
> +			return -EINVAL;
> +
>  		fb->type = FUSE_BACKING_PATH;
>  		fb->path = file->f_path;
>  		path_get(&fb->path);
> 
> -- 
> 2.53.0
> 

Reviewed-by: Amir Goldstein <amir73il@gmail.com>


