Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B92606A323
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Nov 2026 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BYrDm7YW;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JE2KFYZD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6iGFbBnREh7O4SlIcpMU+4Ogf6JM1aV3kALmEchfMf0=; b=BYrDm7YWjny1+mhobDfOqZp16N
	YNl7NItoY6jHMUh5UylWykSFDRw4QbZbm4X/B7TRGhWZyfO3KKhFMt7x+AP3I1S2+is5A6cwazVEy
	LBsZnSCI6veaqGtGoFJrkyY6s38B4qongPFCdEKUVqXr+FxNE9a43LlnO24arKNKMLSHXuG9YdhAx
	uC0KyvsgL+65ulUpuRMkw/RGEt/gSUNgldI7JLH1lqAWHYMztGb3RKrTesBosRJJyLw3f9NDOKck8
	04IEwemJEI/6tv/8pS737PAiHUTXfRuLDMpVeomG9I8aOmaWHPigCtR53TpoAdtmfI5NzEwmNag7e
	Ivm6FSXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSQ6M-0000000H0hE-3CZ2;
	Sun, 15 Nov 2026 02:36:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSQ6K-0000000H0h7-3PPP
	for linux-nvme@lists.infradead.org;
	Sun, 15 Nov 2026 02:36:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BDA18601EE;
	Sun, 15 Nov 2026 02:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBCE1F000C4;
	Sun, 15 Nov 2026 02:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794710175;
	bh=6iGFbBnREh7O4SlIcpMU+4Ogf6JM1aV3kALmEchfMf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JE2KFYZDGHnDsrJjxGwFl/ix79askPAdX+B8jHDNlz5EVhImaZa08ioSlbvZPK2EF
	 AMIxrg86gy4YP8b684AoMBFq8lyIyYi98MZuSQoXbO7gx8+mlsQktdHop7brTeBFGI
	 WWe5SOeF4vW7rsURB4BREUIKGtAhQUUKGBd/FcjA8ux6arlrrj4PwcJi4UYbAUzsQn
	 yUrzGMypClFMj/8/KtREN91KiKSrgl1sPnoxDCjbWFs4shlYQEGDjjchXAGPdclPVn
	 Vux01aaqcTTL8esIKhw9gj2rmzUWisev3RErQ+PTImuxrxkibtC26rA7lOofmCFtXt
	 yK2WzRlzvAvtA==
Message-ID: <sashiko-outbox-215189@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] nvme-multipath: apply delayed_removal_secs
 changes to a pending removal
To: "Qiliang Yuan" <qiliang.yuan@linux.dev>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261114-bug-nvme-mpath-set-live-srcu-v3-1-d84651de6334@linux.dev>
References: <20261114-bug-nvme-mpath-set-live-srcu-v3-0-d84651de6334@linux.dev>
 <20261114-bug-nvme-mpath-set-live-srcu-v3-1-d84651de6334@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 02:36:14 +0000
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
- [Medium] nvme-multipath: race in delayed_removal_secs_store() re-arms
  remove_work
--

commit 92bcf5100d1d5ed726ca5da1431d5f936dbea0e9
Author: Qiliang Yuan <qiliang.yuan@linux.dev>

nvme-multipath: apply delayed_removal_secs changes to a pending removal

This commit cancels and requeues any pending head->remove_work when
delayed_removal_secs is written via sysfs so the updated delay takes
effect immediately.

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index ae8059366b57d..35278b9c4de60 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1242,6 +1242,9 @@ static ssize_t delayed_removal_secs_store(struct de=
vice *dev,
>  	mutex_lock(&head->subsys->lock);
>  	head->delayed_removal_secs =3D sec;
>  	assign_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags, sec);
> +	/* Apply the new delay to a removal that is already pending */
> +	if (cancel_delayed_work(&head->remove_work))
> +		queue_delayed_work(nvme_wq, &head->remove_work, sec * HZ);

[Severity: Medium]
Can this race with nvme_init_ns_head() and re-arm head->remove_work after
a path has reconnected?

drivers/nvme/host/core.c:nvme_init_ns_head() {
	...
	list_add_tail_rcu(&ns->siblings, &head->list);
	ns->head =3D head;
	mutex_unlock(&ctrl->subsys->lock);

#ifdef CONFIG_NVME_MULTIPATH
	if (cancel_delayed_work(&head->remove_work))
		module_put(THIS_MODULE);
#endif
}

nvme_init_ns_head() adds the new namespace to head->list under
subsys->lock, but cancels head->remove_work after dropping the lock.  If
delayed_removal_secs_store() runs in between, it clears the pending bit on
head->remove_work before nvme_init_ns_head() checks it, and then requeues
the work:

CPU0                              CPU1
nvme_alloc_ns()
  nvme_init_ns_head()
    mutex_lock(&subsys->lock)
    list_add_tail_rcu(..., &head->list)
    mutex_unlock(&subsys->lock)
                                  delayed_removal_secs_store()
                                    mutex_lock(&subsys->lock)
                                    cancel_delayed_work(&head->remove_work)
                                      (returns true)
    cancel_delayed_work(&head->remove_work)
      (returns false)
                                    queue_delayed_work(..., &head->remove_w=
ork, ...)
                                    mutex_unlock(&subsys->lock)
  ...
  out_unlink_ns:
    nvme_put_ns_head(ns->head)    <-- frees head with remove_work queued

This leaves head->remove_work pending while a path is on head->list.  If
nvme_alloc_ns() then fails and takes its out_unlink_ns error path, it
drops both references and frees head while head->remove_work is still
queued on nvme_wq, causing a use-after-free when the work runs.

Checking list_empty(&head->list) under head->subsys->lock before
cancelling and requeuing head->remove_work (or moving the cancel in
nvme_init_ns_head() inside subsys->lock) would avoid this race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-bug-nvme-m=
path-set-live-srcu-v3-0-d84651de6334@linux.dev?part=3D1

