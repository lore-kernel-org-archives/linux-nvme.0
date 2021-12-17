Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEB0C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Dec 2021 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LPB0Yo3U9msWs0+52Es7nIx+TDjBQR18C+Mj41pFhSc=; b=tuiO24G7XkYwUprUykdg78V8fe
	jr5Uy2HLvkMuOs2D3tJkcy1ngcrNiO9PrYpElOdHTz2d0y0MYqP1u+AIp9oxFXjjMiwaheEL0vK5H
	RIXlLx0ajTg7zH1nhHHJRa1NXWEnVHi49ZZhuMWV1n/bDuQi7eKzh7RB5nQRItSJjGTSnnQehyQap
	Y068+4s4yNJeaUrWir7ovacw2rA0XREzxmhHVUD9w7YP1LALBkOKSAslW3EZC0M5StLN47kSEjDm7
	5JcAza+h1u7FVHcvrG/9CYaq/cZCygiWggzsI2X4pzYORfcCBrLYq/6ldiig9IjwJYJ8rwDikH25h
	rDQFSsNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1myI5v-00Btni-8K; Fri, 17 Dec 2021 18:36:39 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1myHaN-00BeCr-6v
 for linux-nvme@lists.infradead.org; Fri, 17 Dec 2021 18:04:04 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CFE3218A9;
 Fri, 17 Dec 2021 18:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639764239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LPB0Yo3U9msWs0+52Es7nIx+TDjBQR18C+Mj41pFhSc=;
 b=A+BVs/Ar5/jWQdQT3NFszO5GuXvx0wKwdmDOI+6UogtoWY4qQ2w7HhlS4I+FMYsSD2PcVM
 x5T8jVY85DDRGKNguU/Ch/qjIYYOxFc+0puZxm7F4MWH7sqbEyoBmzUnNChesDqlrMsLHJ
 i/BdmVKwvfKA/wzn9hddX4HzNRj8cIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639764239;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LPB0Yo3U9msWs0+52Es7nIx+TDjBQR18C+Mj41pFhSc=;
 b=mS8X/T+NbqigNSE3ux4nXbwIbi05svnLReB/2z0iGc4SalC1wv1fC+89vvUnAnDZq4fSrh
 QiBXQJP6pOkufVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26329139C1;
 Fri, 17 Dec 2021 18:03:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XHDlCA/RvGHiewAAMHmgww
 (envelope-from <dwagner@suse.de>); Fri, 17 Dec 2021 18:03:59 +0000
Date: Fri, 17 Dec 2021 19:03:58 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCHv2] nvme: add 'iopolicy' module parameter
Message-ID: <20211217180358.6j65izoebwk3raea@carbon.lan>
References: <20211217150222.142014-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217150222.142014-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211217_100403_469485_2C7EB7CD 
X-CRM114-Status: UNSURE (   8.31  )
X-CRM114-Notice: Please train this message.
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

On Fri, Dec 17, 2021 at 04:02:22PM +0100, Hannes Reinecke wrote:
> +static int iopolicy = NVME_IOPOLICY_NUMA;
> +module_param(iopolicy, int, 0444);
> +MODULE_PARM_DESC(iopolicy,
> +	"Default multipath I/O policy; 0 - NUMA (default), 1 - Round-robin");
> +
> +void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
> +{
> +	subsys->iopolicy = iopolicy;

Wouldn't make sense to check if iopolicy has a valid value too?

