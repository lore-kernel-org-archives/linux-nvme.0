Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52B8C71133
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Aug 2023 06:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/GfIFSneNxiJ5ZkfLnsi8LpYv18OpdIVmYfGUM82eco=; b=oTTa2GXQ19tmIEWqW7G47GZfmR
	1k2sMH9THRDEN63wL1zZeVCfCqquf+kvbcGZBdNqFjJuSgLZAp/5E/oJYB0FD9TMB83+9nv98K/2a
	ViBUeHqD0ZMMBLBzDAGyOLCxDYl9cAIPqI51shZnnApVEocq4EQgUnmSTF14gFt2Jao/DJx0Sy0XW
	UPwi6nCzrY98aF4FNVvLuZRi0rkgA1mmPjuYQjuuR+VXBUUX0yA5amK7dmu/voDt1m2EJTUoOSFZY
	HsNkbPJjqwc5EDNyWVGJO8grx40b2pr45uuItDiDiA171aeqz+hXPKDOAOLdDOrJrXZ3fbVpxaXQK
	2OSZCfig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZQUX-004TtA-02;
	Fri, 25 Aug 2023 06:40:21 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZQUU-004TsI-0j
	for linux-nvme@lists.infradead.org;
	Fri, 25 Aug 2023 06:40:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F824224C0;
	Fri, 25 Aug 2023 06:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692945616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/GfIFSneNxiJ5ZkfLnsi8LpYv18OpdIVmYfGUM82eco=;
	b=WvfmvupBVT2s+uKw5qMgI3+wuAMWaOPaDxsI1BZ0yUlMaV9yhq3Y2fok7eP0B2vNr0fVar
	qNG8jX9OPKnJpH6lbNP1Gg9vw+nCMhvDrLgteOVS5sK9WIK5BDW1+clZcfNVFmJKfRLSjp
	GvS/h9PKBL2UNtf6spEOdjA+w0Pu+E0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692945616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/GfIFSneNxiJ5ZkfLnsi8LpYv18OpdIVmYfGUM82eco=;
	b=IW9xCyKEddt+yTFH8YyB4vgvYlWaZEzv97y7b2em4MRo/S52tLyW59h3NUjpiaTkPf4+o3
	qUZN14+wIeXhwDBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20FC1138F9;
	Fri, 25 Aug 2023 06:40:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id AeABCNBM6GQEMAAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 25 Aug 2023 06:40:16 +0000
Date: Fri, 25 Aug 2023 08:40:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Bart Van Assche <bvanassche@acm.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Message-ID: <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_234018_412669_D1246977 
X-CRM114-Status: GOOD (  14.77  )
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

On Fri, Aug 25, 2023 at 12:53:26AM +0000, Shinichiro Kawasaki wrote:
> This works, but a bit ugly. Another idea is to make one of the optional
> arguments mandatory, a positional argument. I think the option --device_type
> worth making mandatory and explicit, like,
> 
>     _nvmet_target_setup device
>     _nvmet_target_setup file

Possible but as I said in the other mail, we have a lot more of default
arguments to functions which I would like to drop too.

> This will make it easier for me to review which test case uses which type.
> (This might be against Sagi's comment, though.)
> 
> Daniel, what do you think?

I don't think it is good strategy to change blktests just to make
ShellCheck happy, when we know it is broken. It rather have SC2119
ignored until ShellCheck is fixed.

