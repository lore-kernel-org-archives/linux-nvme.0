Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBE9C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u5UmlN+ZkcLL4s0pRKYH5oIqYunIGhMWhM1THEN2Q8s=; b=WHzCZrYIMtVHZaGOdfPlUI1Xxv
	+IZu9mwCWBheAZXpBF3fHJ75hmG0+X+m1mKP+2XyQN7S2oddTTTIrPiv7pC4DEeYA0DsUyOKYou9f
	H/LkwJZ3snz2pz7SfuCvt9x9vgu61dv/rYdZcIroifyxymQNbJxvAdzlA6Tdxr8Grcm6wMRjYPk6+
	F6BI8GTGx4rng+0WjlmCOIhlcsEHIiS+hvbe+4p114oqwnhj2gp8pAyma9OQEYr0RzB+/xTNEBl8S
	U/tRqoWLs3aNd3EQw8E28ElNGfXoJh+wf5HTMGYOYl4jmgj0m67TtaaK4R0mymwc+W4st90/nVLpk
	G0ftoocg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKJsH-0071DG-U5; Wed, 16 Feb 2022 12:57:37 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKJsF-0071Cc-Fo
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 12:57:36 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 56BE021763;
 Wed, 16 Feb 2022 12:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1645016252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u5UmlN+ZkcLL4s0pRKYH5oIqYunIGhMWhM1THEN2Q8s=;
 b=ccqPg2s1k2aHUkgi5z7BVOyJ/NqCSId/Sp20YnhjnMom1k21w9vvE8/MXP2veKfnc8M+s6
 sjDtf6eJdok5zJLgnrjIQgjhKpRkK6VgsSCAjmgancvR+z4DB2w+eypc6nJWPsaDm9+cG4
 TXqR61FLLH6ogLU3KG1Z3BCOWs7FJFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1645016252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u5UmlN+ZkcLL4s0pRKYH5oIqYunIGhMWhM1THEN2Q8s=;
 b=Fr97q5b6agsX+jx2Nb0t8Zog3lBwK01cJU1iubLSNvNQqewRi6P7HmBdPl8AFvN0thuroY
 +KpxJsi6OppWtVCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44BD813B0A;
 Wed, 16 Feb 2022 12:57:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PCe9ELz0DGJtXgAAMHmgww
 (envelope-from <dwagner@suse.de>); Wed, 16 Feb 2022 12:57:32 +0000
Date: Wed, 16 Feb 2022 13:57:31 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH] nvme-multipath: fix multipath path scan
Message-ID: <20220216125731.6juezl4kshv7ovbp@carbon.lan>
References: <CGME20220216061807epcas5p1a349815c50db8f3539c30e2dd569232f@epcas5p1.samsung.com>
 <20220216061305.45360-1-joshi.k@samsung.com>
 <20220216081148.GA10851@lst.de>
 <CA+1E3r+3ra2sr3hHx4b2QEq-tsQ6sfLp+hVvPz0a+Q_8G84QKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3r+3ra2sr3hHx4b2QEq-tsQ6sfLp+hVvPz0a+Q_8G84QKg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_045735_715969_6944F33B 
X-CRM114-Status: GOOD (  12.82  )
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

On Wed, Feb 16, 2022 at 06:18:06PM +0530, Kanchan Joshi wrote:
> On Wed, Feb 16, 2022 at 1:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Feb 16, 2022 at 11:43:05AM +0530, Kanchan Joshi wrote:
> > > commit e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
> > > introduced NVME_NS_READY flag. nvme_path_is_disabled() declares path/ns
> > > to be disabled if this flag is not found to be set.
> > > This causes side-effect on namespace for which block-interface is not
> > > fully up.
> >
> > Hmm. This means for non-bdev namespaces we error out somewhere in
> > nvme_update_ns_info.  Where do we fail here, nvme_configure_metadata?
> 
> In nvme_update_zone_info, but nvme_configure_metadata is also possible.
> Moved setting the flag before both these.

But the NS is not ready at this point. nvme_update_disk_info() needs run
before the NS can be marked as ready. Commit message e7d65803e2bb
("nvme-multipath: revalidate paths during rescan") explains why.

