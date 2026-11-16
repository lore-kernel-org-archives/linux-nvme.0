Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF9E606A7BA
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TYCkeTsu;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgaswur9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RW3Nmjz+GbO91KVwbZw20axMMPWohpmxD8TXxvGg3/8=; b=TYCkeTsumM3+q67rIf8gawZC9y
	pXf3fkMK5rNy2QgnsYw98hRfiWXvhHTnMuas/sabLWZBxE4o7+wjhWLfTr9msB97Ovvkbx++pyNj9
	P3l7BOQ9ScGO69kSnVKsM0StvUHE0SuSHN5GocXaUMXNr3vpEDCI3+h4mcFXomPPs+l2lDUvwrZnM
	/w/Y5z+HCGwttygK3SwN+HukJ+6zz7PFpUUpqgcnok3u/CpbDHqxoRbr0ndsp28Vs+jkbfLxpSLqm
	A3bMbqP81ibBYpqJcB4OGEPIH6dIrOKt5fI6FP/Dquh9yGp7z266vEcgwgTUOdlz5n0G456HjX9cx
	Ia56rjLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSusw-00000002BKf-1Kzg;
	Mon, 16 Nov 2026 11:28:30 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSusv-00000002BKI-1K12
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:28:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D402746344;
	Mon, 16 Nov 2026 11:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E091F000C4;
	Mon, 16 Nov 2026 11:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828508;
	bh=RW3Nmjz+GbO91KVwbZw20axMMPWohpmxD8TXxvGg3/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dgaswur9NKmVb2Cj2LBZvzzO++YPkgo2pM4LudFKJRS+BkMI5ErMhhAJqeDzhVlDv
	 eCPlnjvzIK+Il93Dk6xH3UrLaJjZsGk3GL/xs8+hSbIxs45r7o6sNqCn1GqDoq24qq
	 2QUS9uyBVKqILqww7albcp/nEZC5F+Gxqn2u6w+1S/QSyjVgBvEMBaBvy8oC1WrTZV
	 rcnaX+dbnp5rdl8gyPjgXF2DkHTYsV59wdAhIGeMurQ7N8u+SHTHNYNZNVuKeBPD4z
	 5O24la+RsvuF8Pvvu97OG2nsodEcHs5Rzt5fUjwVYjICfJDOyrd8HrYrpVXTeV62Oy
	 fIYgTSktA3yuQ==
Message-ID: <sashiko-outbox-216927@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 34/44] selftests/ovl: test data-only layers on
 pseudo filesystems
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Jann Horn" <jannh@google.com>, "Chris Mason" <mason@kernel.org>, "Josef
 Bacik" <josef@toxicpanda.com>, "Christoph Hellwig" <hch@lst.de>, linux-nvme@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com, linux-efi@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Amir
 Goldstein" <amir73il@gmail.com>, "Chuck Lever" <cel@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-34-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-34-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:28:27 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] selftests/ovl: missing prerequisite skips in setup_tmp() and
  tests
- [Low] selftests/ovl: duplicated setup_tmp() and datadir test cases
--

commit 9dfbd53c60eeeb8dceed3a46417fda9ee76bb58b
Author: Christian Brauner <brauner@kernel.org>

selftests/ovl: test data-only layers on pseudo filesystems

This commit adds an overlayfs selftest verifying that data-only layers on
pseudo filesystems (sysfs and procfs) are rejected while tmpfs data-only
layers and sysfs lower layers remain allowed.

> diff --git a/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir=
.c b/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c
> new file mode 100644
> index 0000000000000..3b59fd3e9f5c2
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c
> @@ -0,0 +1,131 @@
[ ... ]
> +static int setup_tmp(void)
> +{
> +	if (unshare(CLONE_NEWNS))
> +		return -errno;
> +	if (sys_mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL))
> +		return -errno;
> +	if (sys_mount("tmpfs", "/tmp", "tmpfs", 0, NULL))
> +		return -errno;
> +	if (mkdir("/tmp/lower", 0755) || mkdir("/tmp/data", 0755) ||
> +	    mkdir("/tmp/merged", 0755))
> +		return -errno;
> +	return 0;
> +}

[Severity: Low]
Should these tests invoke SKIP() with a reason string when root privileges
or kernel overlayfs support are unavailable?

Running this test without root privileges causes setup_tmp() to fail with
-EPERM on unshare(CLONE_NEWNS), and running on a kernel without
CONFIG_OVERLAY_FS causes mount_lowerdir() and fsmount_layers() to return
-ENODEV, failing all four tests in make run_tests instead of skipping them.

[ ... ]

> +TEST(datadir_sysfs)
> +{
> +	ASSERT_EQ(setup_tmp(), 0);
> +
> +	EXPECT_EQ(mount_lowerdir("/tmp/lower::/sys/kernel"), -EINVAL);
> +	EXPECT_EQ(fsmount_layers("/tmp/lower", "/sys/kernel", false), -EINVAL);
> +	EXPECT_EQ(fsmount_layers("/tmp/lower", "/sys/kernel", true), -EINVAL);
> +}
> +
> +TEST(datadir_procfs)
> +{
> +	ASSERT_EQ(setup_tmp(), 0);
> +
> +	EXPECT_EQ(mount_lowerdir("/tmp/lower::/proc"), -EINVAL);
> +	EXPECT_EQ(fsmount_layers("/tmp/lower", "/proc", false), -EINVAL);
> +	EXPECT_EQ(fsmount_layers("/tmp/lower", "/proc", true), -EINVAL);
> +}
> +
> +TEST(datadir_tmpfs)
> +{
> +	ASSERT_EQ(setup_tmp(), 0);
> +
> +	EXPECT_EQ(mount_lowerdir("/tmp/lower::/tmp/data"), 0);
> +	EXPECT_EQ(fsmount_layers("/tmp/lower", "/tmp/data", false), 0);
> +	EXPECT_EQ(fsmount_layers("/tmp/lower", "/tmp/data", true), 0);
> +}
> +
> +TEST(lowerdir_sysfs)
> +{
> +	ASSERT_EQ(setup_tmp(), 0);

[Severity: Low]
This isn't a bug, but could setup_tmp() move into a FIXTURE_SETUP() block,
and could the three datadir_* tests be parameterized with FIXTURE_VARIANT()
over the path and expected return code to avoid duplicating the setup and
mount sequence?  Also, since set_layers_via_fds.c already tests lowerdir+
and datadir+ layer configuration, should these cases live there instead of
in a new standalone binary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D34

