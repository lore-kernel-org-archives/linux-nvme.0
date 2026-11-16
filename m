Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3002606A337
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=B3+h2Lv5;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdHQpj8j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1tC3N1qqBX7/u0OnGs3h9tXT815w695looNGw4xVvNg=; b=B3+h2Lv5mDiI4+nCmq80Ch4fdA
	zB2iHWXUlMg/ttgtPnkqvpMkKAKb7TnbK1n2QRpUvCLaR6MAV9tJ67tso1CHrhSETqEegiU3hCGzW
	05kz6ldpZXo2Wx/nzbWjVaB6QI6KoX3Fd8axQqkRp5Jc7rGXiXdQxCoVYsEooegxnMgVpYYABCX9P
	a8Lzt90Nm3UXmVtYBHRrlYfA35tQHz1ItH2VQbrl3p0D+PQMIeWzz0Hsh1IAchfovA7xXicN0VE9O
	pPl0Od/ecVn5Kl30t00yRfq80ZwvwQn0tSlPbWserFQLBnSeAXdkENbes7PkLP6Za5iO+sGQ2z79J
	Ab64z5Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuvO-00000002Bw3-1XQ4;
	Mon, 16 Nov 2026 11:31:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuvN-00000002Bvl-3AFX
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:31:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DB19B61D09
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 11:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302171F000C4;
	Mon, 16 Nov 2026 11:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828660;
	bh=1tC3N1qqBX7/u0OnGs3h9tXT815w695looNGw4xVvNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KdHQpj8jQM055I9TqpxYRHE0W+D1Ta5O5ntgrbWtgfFYXmuv8ggC7UFRpB6kvrp8q
	 MnzgKU48J1wciEkisugsFYjWBmStEIEztGbaS/eE4CNyTdT6PPt7JSFkzKfd+tSbsI
	 VN5o2jmqQE05/+1sqVTaa3m/7O327/auMjgwDYcxTfTn4hGRRONhM4cT86olGNTrmW
	 u3JTVDrIXNEZYcayaMMIb7K11ofGjIf+bFwkrx2anN5XJmjyMfsq51mi6ZG5aGQJNs
	 75beAv9KUANxHlEItGRJukLPVS0lh01EMQsaoVV0HziYc0IZ+u1DJYrLUHHqzpTubI
	 rBRBsuk6UI7UA==
Message-ID: <sashiko-outbox-216937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/17] fs: add kiocb_write_iter() and
 kiocb_end_write_iter()
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, bpf@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261116-work-fs-frozen_writes-v2-2-ecc4a2aac40e@kernel.org>
References: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org>
 <20261116-work-fs-frozen_writes-v2-2-ecc4a2aac40e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:30:59 +0000
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
- [Medium] fs: unconditional freeze protection on non-regular files in
  kiocb_write_iter()
--

commit c4bb9dc6398af3c2e2efc447c0b1b29d081b55ab
Author: Christian Brauner <brauner@kernel.org>

fs: add kiocb_write_iter() and kiocb_end_write_iter()

This commit adds kiocb_write_iter() and kiocb_end_write_iter() helpers to
manage superblock freeze protection across ->write_iter() calls.

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index eefc2c9d4af19..0b66a09fb686a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2840,6 +2840,54 @@ static inline void kiocb_end_write(struct kiocb *i=
ocb)
[ ... ]
> +static inline ssize_t kiocb_write_iter(struct kiocb *iocb,
> +				       struct iov_iter *iter)
> +{
> +	ssize_t ret;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!kiocb_start_write_trylock(iocb))
> +			return -EAGAIN;
> +	} else {
> +		kiocb_start_write(iocb);
> +	}
> +	iocb->ki_flags |=3D IOCB_WRITE;

[Severity: Medium]
Should kiocb_write_iter() check S_ISREG(file_inode(iocb->ki_filp)->i_mode)
before taking freeze protection and setting IOCB_WRITE, the way
file_start_write(), aio_write() and io_kiocb_start_write() do?

Callers such as loop and target_core_file accept S_ISBLK backing files.
Opening a block device node leaves file_inode(file)->i_sb pointing at the
filesystem hosting the device node rather than the block device.  Without
an S_ISREG() check, writes to a block device node whose hosting filesystem
is frozen will block in sb_start_write() (or fail with -EAGAIN for
IOCB_NOWAIT), and will deadlock if that filesystem is mounted on or
flushing through the virtual block device during freeze_super().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-fs-fr=
ozen_writes-v2-0-ecc4a2aac40e@kernel.org?part=3D2

