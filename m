Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D657C87FD2
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 19:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j/anwXmAadLw9J9TyomelfR/dCWaX455jbW68n6h+xc=; b=HKTYg/h6X+hf/wxVkWLBJeXqVN
	i3SuHwZOYp7YaE0ElgAzDu+WSsPI9Elfx327o6L++s6HYqyTX5QnsgnrZeHysmD/RNlIqZLQqIhV6
	J1kKvYhObkjWF9ECBDby6lEcXyLlGPky9iSiQlqXWeqpVKcYV6fiXPhFoDX0uXtI1m2Cdf1xjtJDH
	WqonQmFl2n2dmUPQ4lx38qUemV67h3F46s3BAyY0l8CbKd4ZrphkIZnpuSvIZ/SiTjzkL/pCQwNHi
	G2amiFaOI0pJvIHCcjxfJynM3/dAf0YZFaNRRZz+sDqoPHjfpXmmldjoeSR3jCyuyqUkNJO1oe/Sg
	s1YltP6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjl1G-00000003OKy-2yAc;
	Thu, 29 Aug 2024 19:41:22 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjl1D-00000003OKP-2peq
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 19:41:21 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C67D21AA5;
	Thu, 29 Aug 2024 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724960476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/anwXmAadLw9J9TyomelfR/dCWaX455jbW68n6h+xc=;
	b=OowGOcN0ie25+QHkRiwKVhd/kR6jxc3KCc8F/l/rjCseIBvxsDBmm/BC2FUo3FQD1JExk5
	wzJYT+iteDA5QeStI6iy/FWRERJbda7Cp8wQO2VKrkbLk3mbd89+AY7UOgcIqdtdJe1sWA
	WCGvQO7jsENa5+O/O6A8G76NrFFC6bQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724960476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/anwXmAadLw9J9TyomelfR/dCWaX455jbW68n6h+xc=;
	b=OowGOcN0ie25+QHkRiwKVhd/kR6jxc3KCc8F/l/rjCseIBvxsDBmm/BC2FUo3FQD1JExk5
	wzJYT+iteDA5QeStI6iy/FWRERJbda7Cp8wQO2VKrkbLk3mbd89+AY7UOgcIqdtdJe1sWA
	WCGvQO7jsENa5+O/O6A8G76NrFFC6bQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E84DE13408;
	Thu, 29 Aug 2024 19:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wpGfNtvO0GYuLgAAD6G6ig
	(envelope-from <mwilck@suse.com>); Thu, 29 Aug 2024 19:41:15 +0000
Message-ID: <d67dc8bc8ef6c12229f3a7b68edea94c87b5e297.camel@suse.com>
Subject: Re: [PATCH 2/3] nvme: move hidden device and multipath handling out
 of nvme_update_ns_info
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Date: Thu, 29 Aug 2024 21:41:15 +0200
In-Reply-To: <20240829063142.2048109-3-hch@lst.de>
References: <20240829063142.2048109-1-hch@lst.de>
	 <20240829063142.2048109-3-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_124119_888951_82CE242D 
X-CRM114-Status: GOOD (  24.01  )
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
> Turn nvme_update_ns_info into a pure multiplexer and move the real
> work
> into nvme_update_ns_info_generic and nvme_update_ns_block, which
> allows
> to set the flags more coherently while the queue is still frozen.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> =C2=A0drivers/nvme/host/core.c | 55 ++++++++++++++++++-------------------=
-
> --
> =C2=A01 file changed, 25 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 51cb3b001b3757..81d2a09dd00f30 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2147,12 +2147,18 @@ static int nvme_update_ns_info_generic(struct
> nvme_ns *ns,
> =C2=A0	lim =3D queue_limits_start_update(ns->disk->queue);
> =C2=A0	nvme_set_ctrl_limits(ns->ctrl, &lim);
> =C2=A0	ret =3D queue_limits_commit_update(ns->disk->queue, &lim);
> -	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
> -	blk_mq_unfreeze_queue(ns->disk->queue);
> +	if (ret)
> +		goto out_unfreeze;
> =C2=A0
> =C2=A0	/* Hide the block-interface for these devices */
> -	if (!ret)
> -		ret =3D -ENODEV;
> +	ns->disk->flags |=3D GENHD_FL_HIDDEN;
> +	set_bit(NVME_NS_READY, &ns->flags);
> +	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
> +
> +out_unfreeze:
> +	blk_mq_unfreeze_queue(ns->disk->queue);
> +	if (nvme_ns_head_multipath(ns->head) && !ret)
> +		ret =3D nvme_update_ns_info_mpath(ns, info, true);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -2163,6 +2169,7 @@ static int nvme_update_ns_info_block(struct
> nvme_ns *ns,
> =C2=A0	struct nvme_id_ns_nvm *nvm =3D NULL;
> =C2=A0	struct nvme_zone_info zi =3D {};
> =C2=A0	struct nvme_id_ns *id;
> +	bool unsupported =3D false;
> =C2=A0	sector_t capacity;
> =C2=A0	unsigned lbaf;
> =C2=A0	int ret;
> @@ -2188,6 +2195,11 @@ static int nvme_update_ns_info_block(struct
> nvme_ns *ns,
> =C2=A0	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 ns->head->ids.csi =3D=3D NVME_CSI_ZNS) {
> =C2=A0		ret =3D nvme_query_zone_info(ns, lbaf, &zi);
> +		if (ret =3D=3D -ENODEV) {
> +			unsupported =3D true;
> +			ns->disk->flags |=3D GENHD_FL_HIDDEN;
> +			goto done;


This looks wrong to me. We call blk_mq_unfreeze_queue() after the
"done" label, although the queue has not been frozen yet.


> +		}
> =C2=A0		if (ret < 0)
> =C2=A0			goto out;
> =C2=A0	}
> @@ -2238,6 +2250,8 @@ static int nvme_update_ns_info_block(struct
> nvme_ns *ns,
> =C2=A0	 */
> =C2=A0	if ((id->dlfeat & 0x7) =3D=3D 0x1 && (id->dlfeat & (1 << 3)))
> =C2=A0		ns->head->features |=3D NVME_NS_DEAC;
> +
> +done:
> =C2=A0	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
> =C2=A0	set_bit(NVME_NS_READY, &ns->flags);
> =C2=A0	blk_mq_unfreeze_queue(ns->disk->queue);
> @@ -2252,50 +2266,31 @@ static int nvme_update_ns_info_block(struct
> nvme_ns *ns,
> =C2=A0out:
> =C2=A0	kfree(nvm);
> =C2=A0	kfree(id);
> +
> +	if (nvme_ns_head_multipath(ns->head) && !ret)
> +		ret =3D nvme_update_ns_info_mpath(ns, info,
> unsupported);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static int nvme_update_ns_info(struct nvme_ns *ns, struct
> nvme_ns_info *info)
> =C2=A0{
> -	bool unsupported =3D false;
> -	int ret;
> -
> =C2=A0	switch (info->ids.csi) {
> =C2=A0	case NVME_CSI_ZNS:
> =C2=A0		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> =C2=A0			dev_info(ns->ctrl->device,
> =C2=A0	"block device for nsid %u not supported without
> CONFIG_BLK_DEV_ZONED\n",
> =C2=A0				info->nsid);
> -			ret =3D nvme_update_ns_info_generic(ns, info);
> -			break;
> +			return nvme_update_ns_info_generic(ns,
> info);
> =C2=A0		}
> -		ret =3D nvme_update_ns_info_block(ns, info);
> -		break;
> +		return nvme_update_ns_info_block(ns, info);
> =C2=A0	case NVME_CSI_NVM:
> -		ret =3D nvme_update_ns_info_block(ns, info);
> -		break;
> +		return nvme_update_ns_info_block(ns, info);
> =C2=A0	default:
> =C2=A0		dev_info(ns->ctrl->device,
> =C2=A0			"block device for nsid %u not supported (csi
> %u)\n",
> =C2=A0			info->nsid, info->ids.csi);
> -		ret =3D nvme_update_ns_info_generic(ns, info);
> -		break;
> +		return nvme_update_ns_info_generic(ns, info);
> =C2=A0	}
> -
> -	/*
> -	 * If probing fails due an unsupported feature, hide the
> block device,
> -	 * but still allow other access.
> -	 */
> -	if (ret =3D=3D -ENODEV) {
> -		ns->disk->flags |=3D GENHD_FL_HIDDEN;
> -		set_bit(NVME_NS_READY, &ns->flags);
> -		unsupported =3D true;
> -		ret =3D 0;
> -	}


Are we certain that the two cases above (nvme_update_ns_info_generic()
and failure of nvme_query_zone_info()) are the only cases in which ret
=3D=3D -ENODEV would have been true here?

Regards
Martin


> -
> -	if (nvme_ns_head_multipath(ns->head) && !ret)
> -		ret =3D nvme_update_ns_info_mpath(ns, info,
> unsupported);
> -	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],


