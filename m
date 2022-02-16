Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D61C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 14:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qsBZ9wiGg+5UzEKntO0jaAovS5MItRMLSwsd6ZhYdp0=; b=DwfrOBJTRtoiUoSh6wqkD3PyiM
	9w+wl8IePilMdyADakY5Blm1uSd3+x/17pdGRXtSWOV2Qm5oYZGrAmXhU+t+Ep73Ssp000bAEKiuB
	gyRHNUGeeJyx0XMqqFkW9O20iUpjDoxnu6bon7ExpTIb0CzNZu748it1WWxQrcBb3/tWs9FvQJrw6
	Dhtw18iyPuKLcobRzzerVAqjnXt6HAFrTdsJq5O/NyB6zmqI1KzDi2BbZ115ye1Gp3AO5krDnEuY/
	LSDbjGRdmkdkCr5/8c58Xiv2Yo4Jg6FZvjgXIB76qlUec1xdxFwe+TlVz7QMeibSmZpLpeFvCkMYp
	ipeefJtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKLkU-007PZt-0Z; Wed, 16 Feb 2022 14:57:42 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKLkR-007PYi-Ls
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 14:57:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C4D841F383;
 Wed, 16 Feb 2022 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1645023457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qsBZ9wiGg+5UzEKntO0jaAovS5MItRMLSwsd6ZhYdp0=;
 b=Re+BS5Zlumh/h88kLJFF/z4dVFda3q6DcderYiWW7H3rJzeOW7RycJlkV0bTjlKY4dis28
 7VZMVgDt8qI2BzGGRjOTkk8b7o/2WbjsyH/IOTcr5zY+0PY9obBO7OC7mU0VH4es6U0/V9
 IFD/cYxXgfZcv6ldPg/Pt3WdunjZ87E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1645023457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qsBZ9wiGg+5UzEKntO0jaAovS5MItRMLSwsd6ZhYdp0=;
 b=+JDdy77s+j7GXQkU3yWCZczGiUo4lfx5p8eb4WfcTRX2+oyCoT6k74v8rXV5V+6n9FJVJI
 f2hYNmsREPVinRBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6C0613B24;
 Wed, 16 Feb 2022 14:57:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WHBoLOEQDWJbIgAAMHmgww
 (envelope-from <dwagner@suse.de>); Wed, 16 Feb 2022 14:57:37 +0000
Date: Wed, 16 Feb 2022 15:57:37 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, joshi.k@samsung.com,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: also mark passthrough-only namespaces ready in
 nvme_update_ns_info
Message-ID: <20220216145737.dijq4xgmmn3ky2yg@carbon.lan>
References: <20220216141220.4162670-1-hch@lst.de>
 <20220216141220.4162670-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216141220.4162670-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_065739_899736_4AE7D1A5 
X-CRM114-Status: GOOD (  10.98  )
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

On Wed, Feb 16, 2022 at 03:12:20PM +0100, Christoph Hellwig wrote:
>  out_unfreeze:
> -	blk_mq_unfreeze_queue(ns->disk->queue);
> -out:
>  	/*
>  	 * If probing fails due an unsupported feature, hide the block device,
>  	 * but still allow other access.
>  	 */
>  	if (ret == -ENODEV) {
>  		ns->disk->flags |= GENHD_FL_HIDDEN;
> +		set_bit(NVME_NS_READY, &ns->flags);
>  		ret = 0;
>  	}
> +	blk_mq_unfreeze_queue(ns->disk->queue);

Do you want to unfreeze the queue also for non ENODEV errors? It seems
ENOMEM is possible.

