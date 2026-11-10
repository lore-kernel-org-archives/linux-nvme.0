Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C473606A76F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pr4zsfB9;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqqdb4TH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OEZgn8Zbp+z86XHAFSsNyw8vuf8Amxex3+czeV9AP14=; b=pr4zsfB9GWY+BEz/YnGRGOXUFi
	u4oonJoHMcCWeKACRqUVPL9TWo8sixUoI+YvHLloa2jIRKpBr4rM59gdUr8P/BfZacO7Y7IWNQgDV
	t6ZpUreOMmXX9mSCM7fS5w6QNACNVctykUgHg3iCBZwLB2mxvkmor+PPgp4a3cqD6D9qgolt0vQu0
	vGBbO3eaSGdh/I/VDa7K76iVPD9cZL+N5dryEg4m0lhheYycqde4yOVLKTjZesVA3RhIclt0MRgyE
	ZSYFCSTFr3Q/So1MqASvRpDlhctglLlWoXnB5AWDVU5m/uKZco9yjZI49sr3v4edL2molaRHNcT3l
	jLBEEOsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlxt-000000044Lm-0lty;
	Tue, 10 Nov 2026 13:32:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlxr-000000044L0-3sni
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 13:32:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 01D7660D4B;
	Tue, 10 Nov 2026 13:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBBD1F0089F;
	Tue, 10 Nov 2026 13:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317562;
	bh=OEZgn8Zbp+z86XHAFSsNyw8vuf8Amxex3+czeV9AP14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eqqdb4THW2SZHiuTHwJxuqw/wCLG6Atu1No42CXygkoJDncNVhzWa9aMP3q0f/zJd
	 b+AL1sktmP8VayVb/3461gX7S7w5ujTiCxrnX8qCRsJPvhmmZ5o4JI1gfgJNQq+ttR
	 29ZVgITU1WoJC9wzxCMGhTvRWAnbK+9V2MJ0wt92X+n8LBg9YNSdN1QbkMQ0GP7bdU
	 DmCEc2S+nH7W9NKTWatCliCoG3QF6rigU9ZcUVnuhvKEO3ZmM2ixab/bw8TiAVmrhY
	 S7Vbd16+XMGhmjDqIJYGldQmorUKxbdOgGAdcstK56KW3NWiL7ydva2trNOB1PrSFU
	 fsm/9OIPFCPCg==
Message-ID: <sashiko-outbox-207126@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-multipath: don't wait for a grace period in
 nvme_mpath_set_live()
To: "Qiliang Yuan" <qiliang.yuan@linux.dev>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261110-bug-nvme-mpath-set-live-srcu-v1-1-1f58b405b0f8@linux.dev>
References: <20261110-bug-nvme-mpath-set-live-srcu-v1-1-1f58b405b0f8@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:32:42 +0000
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
- [Medium] nvme-multipath: unlocked requeue_srcu_cookie update in
  nvme_mpath_set_live()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] nvme-multipath: stranded I/O in delayed_removal_secs_store()
  [1]
--

commit c9b236e98759e76a4ecd5a5f54a6bd1f8d9ab7be
Author: Qiliang Yuan <qiliang.yuan@linux.dev>

nvme-multipath: don't wait for a grace period in nvme_mpath_set_live()

This commit replaces the synchronous synchronize_srcu() call in
nvme_mpath_set_live() with start_poll_synchronize_srcu() and defers
waiting for the SRCU grace period to nvme_requeue_work().

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index ae8059366b57d..4bc94f165c17d 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c

[ ... ]

> @@ -851,7 +857,13 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>  	}
>  	mutex_unlock(&head->lock);
> =20
> -	synchronize_srcu(&head->srcu);
> +	/*
> +	 * Have nvme_requeue_work() wait for the grace period instead of
> +	 * blocking here, so that namespaces going live together, e.g. on
> +	 * an ANA change, do not wait for one grace period each.
> +	 */
> +	WRITE_ONCE(head->requeue_srcu_cookie,
> +		   start_poll_synchronize_srcu(&head->srcu));
>  	nvme_mpath_revalidate_zones(head);
>  	kblockd_schedule_work(&head->requeue_work);
>  }

[Severity: Medium]
Can concurrent nvme_mpath_set_live() calls on the same head overwrite a
newer head->requeue_srcu_cookie with an older, already-completed cookie?

CPU0                              CPU1
nvme_mpath_set_live(ns1)
  mutex_unlock(&head->lock)
  c1 =3D start_poll_synchronize_srcu()
  // grace period c1 completes;
  // ns1 fails over again, and a
  // reader enters srcu_read_lock()
  // seeing no usable path
                                  nvme_mpath_set_live(ns2)
                                    mutex_unlock(&head->lock)
                                    c2 =3D start_poll_synchronize_srcu()
                                    WRITE_ONCE(requeue_srcu_cookie, c2)
  WRITE_ONCE(requeue_srcu_cookie, c1)
                                    kblockd_schedule_work(&requeue_work)
                                  nvme_requeue_work()
                                    poll_state_synchronize_srcu(..., c1)
                                      // returns true, skips sync
                                    bio_list_get(&head->requeue_list)
                                      <-- misses in-flight reader's bio

When that happens, nvme_requeue_work() drains head->requeue_list before
the in-flight nvme_ns_head_submit_bio() reader finishes queueing its bio,
leaving the bio stranded on head->requeue_list until a later path event.
Updating head->requeue_srcu_cookie before mutex_unlock(&head->lock) would
serialize the cookie generation and store.

[Severity: High]
This problem wasn't introduced by this patch, but in the same file,
delayed_removal_secs_store() [1] can leave parked bios stranded on
head->requeue_list when delayed_removal_secs is set to 0:

drivers/nvme/host/multipath.c:delayed_removal_secs_store() {
	...
	mutex_lock(&head->subsys->lock);
	head->delayed_removal_secs =3D sec;
	assign_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags, sec);
	mutex_unlock(&head->subsys->lock);
	/*
	 * Ensure that update to NVME_NSHEAD_QUEUE_IF_NO_PATH is seen
	 * by its reader.
	 */
	synchronize_srcu(&head->srcu);

	return count;
}

When writing 0 clears NVME_NSHEAD_QUEUE_IF_NO_PATH while no paths are
usable, any bios already queued on head->requeue_list need to be drained
and failed, but delayed_removal_secs_store() returns without calling
kblockd_schedule_work(&head->requeue_work), leaving tasks waiting on
those bios hung until a separate path event schedules requeue_work.

[1] https://sashiko.dev/#/bug/linux-7d2cc5ea-2752-4473-b874-a955225beb1b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-bug-nvme-m=
path-set-live-srcu-v1-1-1f58b405b0f8@linux.dev?part=3D1

