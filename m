Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601B606A32A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qwVzZCSa;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIG7IYQ9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HxE2DUF0mI/lkkVAS05CXuO6QUX16xLeeN6qA9h8AYk=; b=qwVzZCSaZj/r2bL4WuuUNU3/gz
	fcWTZuTrh9qSdfK+gFX2aQa4CcMYXOSnW2FOp/Z53Uzp5dzvKYKHE5ZtYjME4gGuuPPvqGJ/+ZGzF
	vb8UzR8BVgQdxcp9GMoyG8PK63DSr3lFjk9yAYw/rBm7h08gcyGkx9uo3JLAj88efrNtaayw+Jtzq
	omPm6qKQ0q5Gv8/3ScxmKkHi64enJoQmFZYFVbLzSk0ZA6UHPhtEOb9KjuWTWl6RFrZMbK3Ebf8qg
	NzhwsozcmBoWVUBMJE1NN0k/Zx19EbqQvOIaRNMFaz/SPdVlsiofMOzipblvIdgNFjcFD7vfROmqQ
	1xfe+5Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU0FE-0000000BgwN-32mw;
	Thu, 19 Nov 2026 11:24:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU0FC-0000000Bgvx-2wWm
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 11:23:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2EC42459D9;
	Thu, 19 Nov 2026 11:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2261F000C5;
	Thu, 19 Nov 2026 11:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795087438;
	bh=HxE2DUF0mI/lkkVAS05CXuO6QUX16xLeeN6qA9h8AYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mIG7IYQ93oe0OKdTQXakgxKfcCvNNngGVV8jCXKxPAG384nyYEurSgFqyuIBKI5R5
	 1Cg9U6mp5ftU4J05oHEAlfophYmhczpr296HUb00UR7yLdo7WvTjZG+Tz21h8Y0mE6
	 EHTiPIqQhR1hK9wtgVfW7aoWwaA8lc5WMETe2UiCaw9OlH+rVUICxVJFtJBzcfr5NB
	 km+XfVyTFDFilWUc+Zjj64mj15HkBcnHvk5B+9KXSnDKb7aWKpXhhoQj0Q/lLKQ0PL
	 2IAt363seIbZW67LTGtfNdIiUeivFmX5hJpgQfIjKpdjkoyEVAsP5jtN5qi8JxPpaG
	 jB/rhAOCpLZXQ==
Message-ID: <sashiko-outbox-223024@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] nvme-multipath: apply delayed_removal_secs
 changes to a pending removal
To: "Qiliang Yuan" <qiliang.yuan@linux.dev>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261119-bug-nvme-mpath-set-live-srcu-v5-1-e1483e2e447f@linux.dev>
References: <20261119-bug-nvme-mpath-set-live-srcu-v5-0-e1483e2e447f@linux.dev>
 <20261119-bug-nvme-mpath-set-live-srcu-v5-1-e1483e2e447f@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 11:23:57 +0000
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
- [Medium] nvme-multipath: clearing delayed_removal_secs fails to kick
  requeue_work
- [Low] nvme-multipath: 32-bit overflow in sec * HZ in
  delayed_removal_secs_store()
--

commit 6d5b135aa1c8a348dae91223319bfb27c4526bcb
Author: Qiliang Yuan <qiliang.yuan@linux.dev>

nvme-multipath: apply delayed_removal_secs changes to a pending removal

This commit updates delayed_removal_secs_store() to cancel and requeue
any pending head->remove_work with the new delay, and moves the
remove_work cancellation in nvme_init_ns_head() under subsys->lock.

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index ae8059366b57d..51c59cc3ea246 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1242,6 +1242,12 @@ static ssize_t delayed_removal_secs_store(struct d=
evice *dev,
>  	mutex_lock(&head->subsys->lock);
>  	head->delayed_removal_secs =3D sec;
>  	assign_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags, sec);
> +	/*
> +	 * Apply the new delay to a removal that is still pending. The module
> +	 * reference taken for it carries over to the requeued work.
> +	 */
> +	if (cancel_delayed_work(&head->remove_work))
> +		queue_delayed_work(nvme_wq, &head->remove_work, sec * HZ);

[Severity: Low]
Can sec * HZ overflow 32-bit unsigned int arithmetic before being widened
to unsigned long?  sec is parsed with kstrtouint() without an upper bound
(and nvme_mpath_remove_disk() does the same head->delayed_removal_secs * HZ
multiplication), so a value above UINT_MAX / HZ wraps the delay and can
remove the head right away even though NVME_NSHEAD_QUEUE_IF_NO_PATH is set.
Using secs_to_jiffies() or clamping sec would avoid the wrap.

>  	mutex_unlock(&head->subsys->lock);
>  	/*
>  	 * Ensure that update to NVME_NSHEAD_QUEUE_IF_NO_PATH is seen

[Severity: Medium]
When sec is set to 0 while head->remove_work is not pending, does this
leave bios that were already queued on head->requeue_list stuck?

If paths are still present on head->list in NVME_ANA_INACCESSIBLE or
NVME_ANA_PERSISTENT_LOSS states, remove_work is not queued, yet
nvme_available_path() returns nvme_mpath_queue_if_no_path(head) and
nvme_ns_head_submit_bio() parks incoming bios on head->requeue_list while
NVME_NSHEAD_QUEUE_IF_NO_PATH is set.  Clearing delayed_removal_secs to 0
clears NVME_NSHEAD_QUEUE_IF_NO_PATH, but without scheduling
head->requeue_work after synchronize_srcu(&head->srcu) (as
fail_on_ctrl_loss_store() does), nothing drains and fails the bios already
on head->requeue_list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-bug-nvme-m=
path-set-live-srcu-v5-0-e1483e2e447f@linux.dev?part=3D1

