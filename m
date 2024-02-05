Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE99C4828D
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 08:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JM0SxOC/oW6G1Gge+jLLSc2sfD7fZKpYANJjmQXdqHA=; b=BDZIsdvGfQLex1BFdsRync6mmW
	cHviDo39BeAgZXWxV9qfHZEqQvh3s1t55EjfyNhvGrCtzU6FHPGPybPK0+twF/X3REDjzqo6OAWVH
	1zfcNn0KkAnFKIDBYy7ZSvCdAON2Wh3ELjEtt4a++Zm4HeEfEQ+t0QZUMyw3IoEhdimgl1c71l4in
	PPykp5riFFt6Xan2VnpcI2RDtECcNnjiv7v0+s5qRLHLTM0bAWoYSqdrMvKsJN6oLwXC+3KIavKwG
	6cpsf+J2pKa/7SBgFxVdlk86xI53RshKPYGiSN+UzE0cO4d9HuHk3rihLZLLt6fcupMeGepf3U5cb
	QV6ZarsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWuca-00000002Tdp-1z5I;
	Mon, 05 Feb 2024 08:46:32 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWucX-00000002Td4-1fFr
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 08:46:32 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA51E222A1;
	Mon,  5 Feb 2024 08:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707122788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JM0SxOC/oW6G1Gge+jLLSc2sfD7fZKpYANJjmQXdqHA=;
	b=z9BolKseWZIrkN+BNGve9jPI4TxX6KiJMtJrpilHbVKLsVBjcx2dKOc6bNXAK+60FHlYpn
	zUvATWeK29Ja4df58nhm5myOa/NFLKBFgy5dT8vF5ySBMF+gim0yw21qewMxWdUaiLGXHs
	t34tO+m1E1eqbiPSayZBMa1cyFihh8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707122788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JM0SxOC/oW6G1Gge+jLLSc2sfD7fZKpYANJjmQXdqHA=;
	b=2TWZMepGLQRW4qP3fWpKhYfu4U+LEVg3z1JcE/7/P1wNqzs5TuK3xY9XrapaqhM6AtiTRF
	/DxPw90L78iPoqCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707122787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JM0SxOC/oW6G1Gge+jLLSc2sfD7fZKpYANJjmQXdqHA=;
	b=aXrJAVwApA1QUIssXvh8g/3VefVLNHSEgiDCbneELy8qLLGxcPu6DNAwPaljNRv7FyQaKL
	mzTilWrfjXHhe2YDeuk6IQL2tTkVJJlgf40eGTYGZwFdurgXMYSqxBJ3v6cwyueWn5fk6N
	hx2x46UhVzgXY3D95GPlxKeyvxr9VsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707122787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JM0SxOC/oW6G1Gge+jLLSc2sfD7fZKpYANJjmQXdqHA=;
	b=C8w5LdXZGmoZreC7kY6MjbTHS17OhRsyAnoru7dS2MO7oI0tm6GthfkHMppwIuoLwmOiNr
	zIHCUHiVCq3I7VDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7680132DD;
	Mon,  5 Feb 2024 08:46:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wttRM2OgwGX9EgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 05 Feb 2024 08:46:27 +0000
Date: Mon, 5 Feb 2024 09:46:27 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Re: race between nvme device creation and discovery?
Message-ID: <vjwzvc5wt5uhlowgwpw23yb4orgpz7uyahu2kqwofcl2upshfi@jb5onzztznj2>
References: <i4bmvgd3u7shgizqgtdtssdz5v3wc76l6bcce6fcbvoft32gzk@rztzeut4azvj>
 <e0e89568-d3af-4d4e-9652-59d04f2c1977@suse.de>
 <5pquzxdvemeeahharuoyh72njlx4unrshwxbtkpg63tk3aw2lt@ugv4guf7hkpz>
 <c8b6b6dc-91bb-45b2-a911-e23cbea28a8e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8b6b6dc-91bb-45b2-a911-e23cbea28a8e@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.69 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 REPLY(-4.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.89)[85.87%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_004629_609955_E5092159 
X-CRM114-Status: GOOD (  14.95  )
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

On Mon, Feb 05, 2024 at 04:57:24PM +0900, Hannes Reinecke wrote:
> I thought something along these lines:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 85ab0fcf9e88..3ed706f595fe 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2845,6 +2845,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl,
> struct nvme_id_ctrl *id)
>                         goto out_put_subsystem;
>                 }
>         } else {
> +               dev_set_uevent_suppress(&subsys->dev, 1);
>                 ret = device_add(&subsys->dev);
>                 if (ret) {
>                         dev_err(ctrl->device,
> @@ -2869,6 +2870,10 @@ static int nvme_init_subsystem(struct nvme_ctrl
> *ctrl, struct nvme_id_ctrl *id)
>         ctrl->subsys = subsys;
>         list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
>         mutex_unlock(&nvme_subsystems_lock);
> +       if (!found) {
> +               dev_set_uevent_suppress(&subsys->dev, 0);
> +               kobject_uevent(&subsys->dev.kobj, KOBJ_ADD);
> +       }
>         return 0;

Unfortunatly, this fixes a different race. Not the one I reported here:

nvme/030 (ensure the discovery generation counter is updated appropriately) [failed]
    runtime  0.602s  ...  0.542s
    --- tests/nvme/030.out      2023-08-30 10:39:08.428409596 +0200
    +++ /home/wagi/work/blktests/results/nodev/nvme/030.out.bad 2024-02-05 09:44:28.768208105 +0100
    @@ -1,2 +1,3 @@
     Running nvme/030
    +failed to lookup subsystem for controller nvme0
     Test complete

