Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003F7C38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 07:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9sLMfHEXmVdQyCdL+DZAQnO8Jl0+zL9z9r4oZmrQdt0=; b=4z702I7W0p1MvqjCjduQziSuDj
	iwVNiQ7AUQEo6uq2EUWxIpyCDTOnTS8NFTtkwNtWVE2q+eTDXGaWVT3do3KG5ME0mNZp/VKjO/oif
	kOqc2HwgmDQjzOMRibfKTq4OcPY+P9h/UOvn8/IrlV/yVJXRvKuZGq+PS2b6RL/nSesgdwbOUC9Rk
	JRl+X42HR1curCErKLq1hsFMahWRns6a+7sMIr3cw0qAz+eOVGUyIBVzDbB0jz6O/oDQ+rtzCxYDC
	wIP5qkdNxHbr4e0BaTG29i1l+s7LhzVdpsQlk4Viz5Kjc4C08O/j5w6CtrjKcozZec2ZpB5tqG36R
	x6hYOyGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onaju-008Nsb-1T; Wed, 26 Oct 2022 07:22:14 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onajo-008NsI-1V
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 07:22:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 90CA521FBE;
	Wed, 26 Oct 2022 07:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666768926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9sLMfHEXmVdQyCdL+DZAQnO8Jl0+zL9z9r4oZmrQdt0=;
	b=mE0bAZD35izrUt4c78dNWk8bgLBkDRY2jYg0XoflqGCgr5DzGOPzWXzE0zqoUw2xrOPMwD
	1XvU1AY96HkV3Lc2EIqa4a5XP6VSFVam18RZrxkCWB5azfiidS9KRQ0VrXBvjqeMpTDZAK
	db1EThcOcR2Ca2nyRQWsNAa+MhCXGrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666768926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9sLMfHEXmVdQyCdL+DZAQnO8Jl0+zL9z9r4oZmrQdt0=;
	b=L9dsT8LDvO0z5ZQ47K4QZEdJHTkvgCwvnM3a36kpxltCDgzef1TRNCvU/B0FVZHSfwOeZB
	+WP5mZQO2o+vK/Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7720013A6E;
	Wed, 26 Oct 2022 07:22:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WxUIHR7gWGPwGwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 26 Oct 2022 07:22:06 +0000
Date: Wed, 26 Oct 2022 09:22:05 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v4] nvmet: force reconnect when number of queue changes
Message-ID: <20221026072205.4ezo2fvhbreth7xm@carbon.lan>
References: <20221025155008.30028-1-dwagner@suse.de>
 <3e102dd5-da6a-cdae-5bf7-6c3f635a9308@nvidia.com>
 <5b15d323-bf99-6eab-12e8-251700faf8a0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b15d323-bf99-6eab-12e8-251700faf8a0@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_002208_265439_389D8EA4 
X-CRM114-Status: GOOD (  21.79  )
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

On Wed, Oct 26, 2022 at 07:53:56AM +0200, Hannes Reinecke wrote:
> > Without looking into the spec, isn't some sort of AEN should be used for
> > this ? please correct me if I'm wrong but deleting all the controllers
> > and relaying on reconnect maybe overkill ? if it doesn't exists in
> > the NVMe spec then perhaps we should think/work on it to update the
> > spec ? Is it worth it ?

As it turns out there is no AEN which really matches this. We scenario
had a short discussion on this topic with Fred during ALPSS and he was
not against adding something if there is a good use case for it.

The issue is that no one really came up with a good general use case
except for testing corner cases.

> Problem is that changing the number of queues on the fly is really awkward,
> _and_ you have the problem that the number of queues is negotiated during
> the 'connect' call. So changing the number of queues from the controller
> side really requires us to reconnect to rectify the situation.
> 
> And no, I don't think it's overkill. It actually makes the situation easier
> as you start off from scratch with the correct number of queues.

There is also the argument, that this approach doesn't rely on the host
to cooperate correctly. For example, if we had an AEN to tell the host
'hey, drop all connections and reconnect', the target still doesn't know
when and if this has been done by the host.


