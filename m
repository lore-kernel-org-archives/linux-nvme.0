Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE34C87FD5
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 19:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bld3KP6fvw6ruCPXHgers7uw2RQzyYLnIuPJzfIOIC0=; b=U2LrKHTbaZ1RgG88Rkx+tYqEnF
	MjEbLF69QP909Qx/0fTs1xKrxaioWodFbLTwOCBZtRkksmxXoPGY2Ezk6YPYCGN2c6DLvdyOz/8UA
	mGD3moMHCWjIUV8AHFJpNSMZAmmNgqfG2bUbdIo0/sb2JuCwbzRP3GtghZAfoV+EpZNdkJbY4ArpR
	0s6AYZegsNQnm3zQ8cZc6k0MjpuU7e80YvGc7QBqleu84RtJBQVNOUuecy+E+C2xlBpV6sV81JxqW
	A/ZNF2RBMNz7jq3F9o5K6hOZorpFkiLVXV9nr4eJs4Z08WrqGxT6Sv1fCCXclhnqDWmpIsF7hlk/y
	fNW7A6lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjl1W-00000003OO0-2yGF;
	Thu, 29 Aug 2024 19:41:38 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjl1U-00000003OMe-1UVl
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 19:41:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC16E21AA5;
	Thu, 29 Aug 2024 19:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724960495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bld3KP6fvw6ruCPXHgers7uw2RQzyYLnIuPJzfIOIC0=;
	b=lOOG1x94eRb7AqarEAtZ7aBNphIQqHFRaFdXKHu1Y6JyKLumHl4T0AO6ecMJdS6+8FAgw8
	RTx4zsf6CkAwU43WOi7vA/sa3xdpR8/FTNaXjkzwinZp9tPlruK6lP6rTieoxA8+NZRydC
	1vAB4zopn/4TFFo212251mdhDbFBVGM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Z8GbKr88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724960494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bld3KP6fvw6ruCPXHgers7uw2RQzyYLnIuPJzfIOIC0=;
	b=Z8GbKr88xIqcUOahcyR7326hmwk100Ahrm7HXhyoob5w4Qn+NI6Pch1DgBPCoiSNqfIfm9
	7CJXUMdTZsCsDb5gVyAnjTFbhdBjqRJOEogFj/BfuCTc0clajcB+sB+hC5sJoFyXXMdq/6
	xMTsqchDqVKkDKa6q30EwqOCeTktd0k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B23B413408;
	Thu, 29 Aug 2024 19:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G+PCKe7O0GZDLgAAD6G6ig
	(envelope-from <mwilck@suse.com>); Thu, 29 Aug 2024 19:41:34 +0000
Message-ID: <b752edf1ceb9146fdbaec740f50f8eb8aff9d205.camel@suse.com>
Subject: Re: [PATCH 3/3] nvme: freeze both the ns and multipath queues whe
 updating queue limits
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Date: Thu, 29 Aug 2024 21:41:34 +0200
In-Reply-To: <20240829063142.2048109-4-hch@lst.de>
References: <20240829063142.2048109-1-hch@lst.de>
	 <20240829063142.2048109-4-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Rspamd-Queue-Id: DC16E21AA5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:dkim,lst.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_124136_653820_16C5F598 
X-CRM114-Status: GOOD (  28.53  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2024-08-29 at 09:31 +0300, Christoph Hellwig wrote:
> We really should not have any I/O outstanding while updating the
> queue
> limits, as that could introduce inconsistencies between the multipath
> and underlying nodes.=C2=A0 So always freeze the multipath node first and
> then
> the underlying one, matching the order in nvme_passthru_start.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> =C2=A0drivers/nvme/host/core.c | 41 ++++++++++++++++++++++++++++---------=
-
> --
> =C2=A01 file changed, 29 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 81d2a09dd00f30..0f01a0bf976fd3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2095,6 +2095,24 @@ static void nvme_set_chunk_sectors(struct
> nvme_ns *ns, struct nvme_id_ns *id,
> =C2=A0	lim->chunk_sectors =3D iob;
> =C2=A0}
> =C2=A0
> +/*
> + * Freeze all I/O for a namespace, including clearing out anything
> on the
> + * multipath node.
> + */
> +static void nvme_ns_freeze(struct nvme_ns *ns)
> +{
> +	if (nvme_ns_head_multipath(ns->head))
> +		blk_mq_freeze_queue(ns->head->disk->queue);
> +	blk_mq_freeze_queue(ns->disk->queue);
> +}
> +
> +static void nvme_ns_unfreeze(struct nvme_ns *ns)
> +{
> +	blk_mq_unfreeze_queue(ns->disk->queue);
> +	if (nvme_ns_head_multipath(ns->head))
> +		blk_mq_unfreeze_queue(ns->head->disk->queue);
> +}
> +
> =C2=A0/*
> =C2=A0 * The queue_limits structure mixes values that are the hardware
> limitations for
> =C2=A0 * bio splitting with what is the device configuration.
> @@ -2116,7 +2134,8 @@ static int nvme_update_ns_info_mpath(struct
> nvme_ns *ns,
> =C2=A0	struct queue_limits lim;
> =C2=A0	int ret;
> =C2=A0
> -	blk_mq_freeze_queue(disk->queue);
> +	WARN_ON_ONCE(disk->queue->mq_freeze_depth < 1);
> +
> =C2=A0	lim =3D queue_limits_start_update(disk->queue);
> =C2=A0	lim.logical_block_size =3D ns_lim->logical_block_size;
> =C2=A0	lim.physical_block_size =3D ns_lim->physical_block_size;
> @@ -2132,7 +2151,6 @@ static int nvme_update_ns_info_mpath(struct
> nvme_ns *ns,
> =C2=A0	set_capacity_and_notify(disk, get_capacity(ns->disk));
> =C2=A0	set_disk_ro(disk, nvme_ns_is_readonly(ns, info));
> =C2=A0	nvme_mpath_revalidate_paths(ns);
> -	blk_mq_unfreeze_queue(disk->queue);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -2143,7 +2161,7 @@ static int nvme_update_ns_info_generic(struct
> nvme_ns *ns,
> =C2=A0	struct queue_limits lim;
> =C2=A0	int ret;
> =C2=A0
> -	blk_mq_freeze_queue(ns->disk->queue);
> +	nvme_ns_freeze(ns);
> =C2=A0	lim =3D queue_limits_start_update(ns->disk->queue);
> =C2=A0	nvme_set_ctrl_limits(ns->ctrl, &lim);
> =C2=A0	ret =3D queue_limits_commit_update(ns->disk->queue, &lim);
> @@ -2154,11 +2172,11 @@ static int nvme_update_ns_info_generic(struct
> nvme_ns *ns,
> =C2=A0	ns->disk->flags |=3D GENHD_FL_HIDDEN;
> =C2=A0	set_bit(NVME_NS_READY, &ns->flags);
> =C2=A0	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
> +	if (nvme_ns_head_multipath(ns->head))
> +		ret =3D nvme_update_ns_info_mpath(ns, info, true);
> =C2=A0
> =C2=A0out_unfreeze:
> -	blk_mq_unfreeze_queue(ns->disk->queue);
> -	if (nvme_ns_head_multipath(ns->head) && !ret)
> -		ret =3D nvme_update_ns_info_mpath(ns, info, true);
> +	nvme_ns_unfreeze(ns);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -2204,7 +2222,7 @@ static int nvme_update_ns_info_block(struct
> nvme_ns *ns,
> =C2=A0			goto out;
> =C2=A0	}
> =C2=A0
> -	blk_mq_freeze_queue(ns->disk->queue);
> +	nvme_ns_freeze(ns);
> =C2=A0	ns->head->lba_shift =3D id->lbaf[lbaf].ds;
> =C2=A0	ns->head->nuse =3D le64_to_cpu(id->nuse);
> =C2=A0	capacity =3D nvme_lba_to_sect(ns->head, le64_to_cpu(id-
> >nsze));
> @@ -2236,7 +2254,7 @@ static int nvme_update_ns_info_block(struct
> nvme_ns *ns,
> =C2=A0
> =C2=A0	ret =3D queue_limits_commit_update(ns->disk->queue, &lim);
> =C2=A0	if (ret) {
> -		blk_mq_unfreeze_queue(ns->disk->queue);
> +		nvme_ns_unfreeze(ns);
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0__
> @@ -2254,7 +2272,9 @@ static int nvme_update_ns_info_block(struct
> nvme_ns *ns,
> =C2=A0done:
> =C2=A0	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
> =C2=A0	set_bit(NVME_NS_READY, &ns->flags);
> -	blk_mq_unfreeze_queue(ns->disk->queue);
> +	if (nvme_ns_head_multipath(ns->head))
> +		ret =3D nvme_update_ns_info_mpath(ns, info,
> unsupported);
> +	nvme_ns_unfreeze(ns);
> =C2=A0
> =C2=A0	if (blk_queue_is_zoned(ns->queue)) {
> =C2=A0		ret =3D blk_revalidate_disk_zones(ns->disk);
> @@ -2266,9 +2286,6 @@ static int nvme_update_ns_info_block(struct
> nvme_ns *ns,
> =C2=A0out:
> =C2=A0	kfree(nvm);
> =C2=A0	kfree(id);
> -
> -	if (nvme_ns_head_multipath(ns->head) && !ret)
> -		ret =3D nvme_update_ns_info_mpath(ns, info,
> unsupported);
> =C2=A0	return ret;
> =C2=A0}
>=20

Moving the call to nvme_update_ns_info_mpath() up before the "out"
label has the effect that the prior error conditions that jump to "out"
(for example, failure in queue_limits_commit_update()) will not run the
multipath code any more, while they previously did. I am not saying
this is wrong, but I wanted to make sure we make this change
conciously.=C2=A0I think it should be mentioned in the commit message.

While I was staring at this code yesterday, I made no progress because
my brain went in circles about this change. Looking at it now, it seems
to me that when we jump to "out", nothing has been commited to the
namespace queue, and thus we don't need to apply changes to the
multipath queue either, and the change is thus ok.

Regards
Martin


