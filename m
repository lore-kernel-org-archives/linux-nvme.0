Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E4D606A334
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cA1c0GIt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xzflw6pe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9hHPdtSok7Dh0R1O/iCJW3dg8G4o4xj2i/9mjyDsQxc=; b=cA1c0GItUBlDMyQSbSEIvsM88T
	gcx5Hnxf0vq+YYPiy9tcJLIZxwu/Xijmqh4/mdR4K7odVFjJnm1ZeUOrcdnZXNpB9E5gbXEyVr841
	o2v4VwIlq69CauGFgqyzMl1oT+O4sLJ/NUlUKpeeE7NAP0QdzZ+fH5yHgYAIkvVaBoXJFBRIb6LBe
	fkl9gpFny4bv4qIbtHQJ/vQImphM+mZGCwDAOTLm13GJU6UuA/mEvF3j4DXgbpR6L/MZtW9XpksGS
	WKBSJCU5wvLoPDrnzewdoWx+TA/X0fFN+GFrDFHamNDGOXbiRzm3CUR45eXcowWPLQ4CRJxA2vwBG
	QCC+ZpFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObnz-00000005bXq-0ysg;
	Wed, 04 Nov 2026 14:17:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObny-00000005bXi-0USi
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 14:17:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D4F71403A9;
	Wed,  4 Nov 2026 14:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E0A1F000C1;
	Wed,  4 Nov 2026 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801853;
	bh=9hHPdtSok7Dh0R1O/iCJW3dg8G4o4xj2i/9mjyDsQxc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Xzflw6peDmU6ztBuIUBBEXUQcW+/Lguscdn5LqgkDnfTK5beMcRVFwr8yBzwbuNjS
	 JU7ZsgjBWXSuJMX84HhYzPxsY1hmj2oB5eVqZKIztr1uLIszvjaXAc+j1ex8/wnSJb
	 SmmUr/KnOMSND8+l8LNfsI/tUmKMQOTn2np5bkt2mbn4iFpfctya0RMvkGlmD2xxF7
	 9g8v1dJcAMg2hvIzQSTDCdVfihpekf68stiTbyh+/fOWV9+4KyvDndzlXhvGihJUe8
	 +rqUftloRa5QAXbh28rCHpF9lZj8VObxu/rnMYCoQK4nS4lQQcolIPzPmQt04HBHkE
	 4WdPWhZBd/hkg==
Message-ID: <sashiko-outbox-197419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] nvme: add per-queue sysfs directories
To: "Saravanan D" <saravanand@crusoe.ai>, linux-nvme@lists.infradead.org
In-Reply-To: <656dac7329c8452efe786b0c76a3b8c0bbf53159.1793800758.git.saravanand@crusoe.ai>
References: <cover.1793800758.git.saravanand@crusoe.ai>
 <656dac7329c8452efe786b0c76a3b8c0bbf53159.1793800758.git.saravanand@crusoe.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:17:33 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] nvme: missing kobject_del() on error path in nvme_add_queue_info=
()
--

commit 6e5f76664582ac2e5b614fa65fb1066286cd6645
Author: Saravanan D <saravanand@crusoe.ai>

nvme: add per-queue sysfs directories

This commit adds helpers to create a per-controller queues sysfs directory
and manage per-queue subdirectories (/sys/class/nvme/nvmeX/queues/<qid>/)
populated with transport-provided attribute groups.

Link: https://lore.kernel.org/linux-nvme/13c160d0-0657-47ce-9a16-58d348267a=
b0@grimberg.me/

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 10018c6356b62..8a982453cb69d 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c

[ ... ]

> +struct nvme_queue_info *
> +nvme_add_queue_info(struct nvme_ctrl *ctrl, unsigned int qid, void *data)
> +{
> +	struct nvme_queue_info *qinfo;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!ctrl->queues_kobj))
> +		return ERR_PTR(-EINVAL);
> +
> +	qinfo =3D kzalloc_obj(*qinfo);
> +	if (!qinfo)
> +		return ERR_PTR(-ENOMEM);
> +	qinfo->data =3D data;
> +
> +	ret =3D kobject_init_and_add(&qinfo->kobj, &nvme_queue_info_ktype,
> +				   ctrl->queues_kobj, "%u", qid);
> +	if (ret)
> +		goto out_put;
> +
> +	ret =3D sysfs_create_groups(&qinfo->kobj, ctrl->ops->queue_attr_groups);
> +	if (ret)
> +		goto out_put;
> +	return qinfo;
> +
> +out_put:
> +	kobject_put(&qinfo->kobj);
> +	return ERR_PTR(ret);
> +}

[Severity: Medium]
If sysfs_create_groups() fails in nvme_add_queue_info() after
kobject_init_and_add() has already published qinfo->kobj in sysfs, should
the error path call kobject_del(&qinfo->kobj) before kobject_put(&qinfo->ko=
bj),
just like nvme_remove_queue_info() does?

Without kobject_del(), unlinking the directory from sysfs is deferred to
kobject_cleanup(). If CONFIG_DEBUG_KOBJECT_RELEASE is enabled or if another
thread grabbed a reference to qinfo->kobj after it was added to sysfs, the
<qid> directory and its parent reference on ctrl->queues_kobj remain live
after nvme_add_queue_info() returns an error, which can cause a subsequent
retry or reconnect for the same qid to fail with -EEXIST or expose a
dangling qinfo->data pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793800758.gi=
t.saravanand@crusoe.ai?part=3D1

