Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BDD606A32D
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YD1qaPze;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nXTlg0XX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QsiTmvnYi1/bC68aKEXBe6BBwV5VctGfUYNCz+WL7/I=; b=YD1qaPzei4FV2GdpfljvOfRRlt
	cukx6Eb0VEZdTp/Rn8HBaC2mPx3I8WKT+dZITY+sio08Z7xb7w/5XrC3FyS16+jNucQk70FfRU5jK
	XHoXPoP1xu+bXUDx4sUxmJ0MKoTqTsz3FhhXVKNGnv3r4anXjJavQC1iQ769S35xFpTLj/BZfPQ7l
	QC9bLMGt0dEwdWgRpvpagzvsjHUvJvjDni/TJ2YACdW5+y6pz/TI/sJq2nLYHhh5TYnBwwDY0wIOJ
	0FT0E+z4KayRUZOECAE8x4b9hTx/421/urVIBhSd+GIEt7wZV1vYWXAzPgul4f9p6cx04Hs1PYaCN
	8o9QGojw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBsg-0000000Fsv2-31x7;
	Sat, 14 Nov 2026 11:25:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBse-0000000Fsug-2zn9
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 11:25:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C30E560230
	for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 11:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1453E1F000C4;
	Sat, 14 Nov 2026 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794655511;
	bh=QsiTmvnYi1/bC68aKEXBe6BBwV5VctGfUYNCz+WL7/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nXTlg0XXpFR1qLAj2e9TfeRX3ojYfW9/jjS5N9GtQOGat1zYW3n2QceCk7ahKutlw
	 sEuN/hiTMQAhCFTeIyOCQws+H0C2F3p6vhVq6iUXP7AjKgyT+mTdkHbJwzIJAxoKqF
	 cgkRMXyF6KU4+gBQlWnIKuuv5tSxc6t1KEAKuhtDIknDp3hHqtTRNco42Xbx7WbhWm
	 Px9ClZL9ROLtuMMCpeuSbGLlJaNqtaDnDtSYkS7DdcFUr11qDjHNxgzVkrqJFxJ32X
	 IabH4+B6mjMIO3YSoy0Hic0xwlLuJsyAetRr2WhpoKMFt3AKxOre4A71ja2TFhHuNJ
	 XJKVeSg48xf0g==
Message-ID: <sashiko-outbox-214401@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] target: fileio: don't free the aio command under
 the filesystem
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, bpf@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261114-work-fs-frozen_writes-v1-4-f5ae61c898b1@kernel.org>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
 <20261114-work-fs-frozen_writes-v1-4-f5ae61c898b1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 11:25:10 +0000
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
- [Medium] target: fileio: premature target_complete_cmd() in
  cmd_rw_aio_complete()
--

commit 6e1a6f1140a7e9133b9c8d928debaca48c4124cf
Author: Christian Brauner <brauner@kernel.org>

target: fileio: don't free the aio command under the filesystem

This commit adds a reference count to struct target_core_file_cmd so that
the command and its embedded kiocb are not freed before ->read_iter() or
->write_iter() return.

> diff --git a/drivers/target/target_core_file.c b/drivers/target/target_co=
re_file.c
> index ab9824a4852f1..4dace29b6d662 100644
> --- a/drivers/target/target_core_file.c
> +++ b/drivers/target/target_core_file.c
[ ... ]
> @@ -244,10 +245,17 @@ static void fd_destroy_device(struct se_device *dev)
>  struct target_core_file_cmd {
>  	unsigned long	len;
>  	struct se_cmd	*cmd;
> +	refcount_t	ref;
>  	struct kiocb	iocb;
>  	struct bio_vec	bvecs[];
>  };
> =20
> +static void cmd_rw_aio_put(struct target_core_file_cmd *cmd)
> +{
> +	if (refcount_dec_and_test(&cmd->ref))
> +		kfree(cmd);
> +}
> +
>  static void cmd_rw_aio_complete(struct kiocb *iocb, long ret)
>  {
>  	struct target_core_file_cmd *cmd;
> @@ -259,7 +267,7 @@ static void cmd_rw_aio_complete(struct kiocb *iocb, l=
ong ret)
>  	else
>  		target_complete_cmd(cmd->cmd, SAM_STAT_GOOD);
> =20
> -	kfree(cmd);
> +	cmd_rw_aio_put(cmd);
>  }

[Severity: Medium]
Should target_complete_cmd() also wait until the final reference drops in
cmd_rw_aio_put(), as loop, zloop, and target_core_iblock do?

fd_execute_rw_aio() sets aio_cmd->iocb.ki_filp to fd_dev->fd_file without
get_file(), relying on the in-flight se_cmd to hold se_lun->lun_ref and
keep the backend device alive.  Calling target_complete_cmd() before
->read_iter() or ->write_iter() returns drops lun_ref early, which allows
concurrent LUN unlinking and device removal to close fd_dev->fd_file while
the filesystem is still using iocb->ki_filp:

CPU0                              CPU1
fd_execute_rw_aio()
  ext4_dio_read_iter()
    ...
      submit_bio()
                                  cmd_rw_aio_complete()
                                    target_complete_cmd()
                                      ...
                                        percpu_ref_put(&lun->lun_ref)
                                  core_tpg_remove_lun()
                                  target_free_device()
                                    fd_destroy_device()
                                      filp_close(fd_dev->fd_file, NULL)
    file_accessed(iocb->ki_filp)  <-- use-after-free

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-fs-fr=
ozen_writes-v1-0-f5ae61c898b1@kernel.org?part=3D4

