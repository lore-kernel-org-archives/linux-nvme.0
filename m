Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CCD606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kV2B4JbK;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G82NOfhr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=; b=kV2B4JbKFkS7jrfE//UixDUDAg
	WdNYzQS8oXn8xah7GZXZvq+b/3hJ7WER7KjVB1jxAm0FV/jZ5Zkdw/iFZLcXi0Qt3cXLH1cnq/fdX
	gUM+t7EoeJ6XUmgj0zI5cRqg0E0jxR1H5qvDLHJLElVA57IKtKDK31EiS2WXqo79zdwbY8f2oucKV
	wpeNtodJV3aDY0bER4dUDpcvxuNb/k0EsngFdGieT7SbctSMHYoRettf3yj8c5tDH2wdyBWI7Lohc
	YbDdsr3hAOnLHerEYiwRcjbHf2EqAZPDt/QbzCxM+ctGcjDqG2Mg5VyFO4z7ET7IKgcoe4lOwZSUI
	7FfwuRZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSw05-00000002PRW-2gON;
	Mon, 16 Nov 2026 12:39:57 +0000
Received: from mail-wr1-x448.google.com ([2a00:1450:4864:20::448])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvOM-00000002HYo-2psO
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 12:01:00 +0000
Received: by mail-wr1-x448.google.com with SMTP id ffacd0b85a97d-4923b9fdd43so2415776f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 04:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794830455; x=1795435255; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=;
        b=G82NOfhrCh3lqQ/k/vS9mD+kMrqU5FXWC4lcWs2hh7FoOyZej1mORe7rqveQ2lGupO
         lnl6NvQ36+dMhdJrLr0SSCWB0S4v//F6ezjr0+l/ftkaMZ8+o7nGd5KPhsYM8RQp5F1/
         M9ONw3QJuEMNqipTxP9r/LL4f/RaZ5VgZ12F1btEtJDiLCMdFsBqUeQjbVNnSkYqB7jd
         P5rTxl0jZnMRzXgxmbRKiFXjNsYIFZ4LO5SKuJ/P2QczsvWOVrTlXtobp256ujwc2xe+
         FzLuRK3qyAVbPuwXxVLBinzb9HFeAAfPumQo7ZMgeHyIgRamyjy3/sjHUALAIaGnboto
         KH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830455; x=1795435255;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=;
        b=jW15DoViCJFgdX5Qrb69xhgb2oHD3LCtDA3ZlzqjyMaKPmJX/MHvphNbDwXBb9Otdn
         5UePHVTJZ57xiBFFjOw1+pKlNt4uhVyT8/7wX/UdCiN5XgRcVar3fn0uLj/SAr/Y4LBJ
         bC6ZTHmLuX6e8hlvXqFcCJYWOjN2LeQ9mvY8OECAdzQBCqcKMp2YhzSU2uAPZ8+0RTaO
         qjL3pw2JfWD5qg0OwVGgfTlh0Pnes7LR0tRAKjD0VIEzz+5nwXb2+Ubtqd8e4nPodlf1
         bH+yTNWc5P9aH5JLEO7anna+i5qxEpMDJ1ffcLQUWs2R0o3MNbeisHYH9iR/e20OiXsC
         mOdA==
X-Forwarded-Encrypted: i=1; AL+hErHuInM7IDe1FaMNHR42j0gl5dDQzbzqMmWgMj1Bi3/7W4dHxII4dQkwSK5z3mIgtAWRo9iyfd0OOeJv@lists.infradead.org
X-Gm-Message-State: APuU4Z/9G1kHVr++mffWpCDIB02Ef3Uj5GHTouIPT7egiiGaucAKPYHI
	e5D8bf1s+kuckm86esFdu3J+q3+Ov5uS8pUSbDHZXowv6DdE7Q3ektHfuvDMKElnyQLuKyd0Avz
	LlRRguc/lYlSBeXYpkw==
X-Received: from wrso13.prod.google.com ([2002:a5d:474d:0:b0:493:3d97:6e88])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e007:0:20b0:48e:3697:708d with SMTP id ffacd0b85a97d-49c70ed8e41mr16698595f8f.12.1794830455230;
 Mon, 16 Nov 2026 04:00:55 -0800 (PST)
Date: Mon, 16 Nov 2026 12:00:53 +0000
In-Reply-To: <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116120053.371591-1-aliceryhl@google.com>
Subject: Re: [PATCH RFC v3 12/44] rust_binderfs: use fc_init_pseudo()
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_040058_966572_11FB9FD1 
X-CRM114-Status: UNSURE (   7.95  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -9.5 (---------)
X-Mailman-Approved-At: Mon, 16 Nov 2026 04:39:20 -0800
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
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 12:04:45PM +0100, Christian Brauner wrote:
> Initialize binderfs as a pseudo filesystem instead of raising SB_I_NOEXEC
> by hand. This adds SB_I_PSEUDO. binderfs_fill_super() keeps clearing
> SB_I_NODEV for the binder device nodes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

