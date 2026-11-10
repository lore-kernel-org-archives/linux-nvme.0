Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC06606D59D
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Qi9Q65NE;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKmf+e1g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bww7nw5bSwEPBt04rDt0/bI4su6VmPuV17HzMgP1WVA=; b=Qi9Q65NETJP7vhXO2jOrzdAa4H
	bcrdeYJHsoOiSstz1ag5rsYSEkIt8pXDDX6LisKA+kmlBgpA9GfLc8GkK5OSYD36OhoPrO7tL5SnA
	55wHShZDM8L4MtGY8PYtsKVN+AK3sN1ZbEb+wAU1hfOQq17h/29PgI75OU+du5rpj3wO2CxjMRX5Z
	3oaFGMAplHHvNWQDORQjjw43LEtkk1EnX9B6qbrcTbuiLkRlgNS7W6eVSfqiiyCTrourSYFqBeKi8
	zlDkanw+tiXS/+ZhyzprXYoxyuq7ntJACEBmR9cztHQcF5dB2HA/WSWk0tt1qB/lUfU0CWT8gjPrR
	HQ6VYOlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQiEW-00000003Hmc-0rcH;
	Tue, 10 Nov 2026 09:33:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQiEV-00000003HmB-0iqk
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:33:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8FB194487E;
	Tue, 10 Nov 2026 09:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C081F0089F;
	Tue, 10 Nov 2026 09:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303218;
	bh=bww7nw5bSwEPBt04rDt0/bI4su6VmPuV17HzMgP1WVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IKmf+e1gFKkj418fSwF/WvpYdm5kRAazs7jwnCLr8UBX0mWUP8DQEFBBBEZlbkXZ1
	 XI4prTk7TROigxS8fxK3H7nyiNmObFLtBmkCA0ke0HXW7pt9dEt/aaSRLKtzC4egpf
	 OEHRA7RgND8FIgqLmipqQVPz2GNvvRJE2PgE7T/NOFf640AwOp8vZiaRQth92bBap0
	 HKEfy9pnSL5/wTdbiAfkWabIrGIRQRAr+uE+2HXR6t6FbfBJFofcbxlw42H4vOVzXk
	 w77kmjm4jAJg1fdzTMQ0RDczx8gBsj6Uaq5LnRuUkl/WYcX9JduP6Rs8JOjO15ilQh
	 USFa7wOu4MpQw==
Message-ID: <sashiko-outbox-206765@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 37/41] target: fileio: refuse files on pseudo
 filesystems as backing files
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Jann Horn" <jannh@google.com>, "Chris Mason" <mason@kernel.org>, "Josef
 Bacik" <josef@toxicpanda.com>, "Christoph Hellwig" <hch@lst.de>, linux-nvme@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com, linux-efi@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Amir
 Goldstein" <amir73il@gmail.com>, "Chuck Lever" <cel@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-37-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-37-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:33:35 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] target: fileio: missing file_is_pseudo() check in
  fd_init_prot()
--

commit 4e15db58376b542897dd4203d7acdfd99df1aec4
Author: Christian Brauner <brauner@kernel.org>

target: fileio: refuse files on pseudo filesystems as backing files

This commit rejects files on pseudo filesystems in fd_configure_device() so
that SCSI initiators cannot read or write kernel interfaces such as procfs
or sysfs with kernel credentials.

> diff --git a/drivers/target/target_core_file.c b/drivers/target/target_co=
re_file.c
> index a5391e57e9aa5..7a3cf63dc979b 100644
> --- a/drivers/target/target_core_file.c
> +++ b/drivers/target/target_core_file.c
> @@ -152,6 +152,13 @@ static int fd_configure_device(struct se_device *dev)
>  		goto fail;
>  	}
> =20
> +	if (file_is_pseudo(file)) {
> +		pr_err("FILEIO: %s is on a pseudo filesystem\n",
> +		       fd_dev->fd_dev_name);
> +		ret =3D -EINVAL;
> +		goto fail;
> +	}

[Severity: Medium]
Should fd_init_prot() also check file_is_pseudo() (and ->read_iter /
->write_iter) when opening fd_dev->fd_prot_file?

When DIF protection is enabled via pi_prot_type_store(), fd_init_prot()
opens "%s.protection" by pathname without these checks.  If that path is a
symlink or bind mount to a procfs or sysfs file, fd_execute_rw_buffered() ->
fd_do_rw() will still read and write it with kernel worker credentials.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D37

