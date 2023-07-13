Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91F4EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 10:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DCNOq+j0xtZP84aUwE8KPQYvyz9rFaVzhnvfV5TLeaA=; b=3FmjTcYSpPfUlHqFkt59aN8Zky
	SUkhozAfGxjRSjf+akjEDJcHitglapbOQwj6PM92YufK6lyDQTLFv3r6xECUu0jwcYetgLrwdahCA
	pctdGHE7d5u9vFZKwAQAmSibAwwzitDaDPda2XWr9tGZpV/Mn54U1q36HgCNc1mOHLQL1ay5//vCd
	e3JYjZV/+1vkpYmxup0bzECBnvkSQ1KhfQ8kw3kQl8TMYQ4C98ZYLunxPDsxkoCiGMdZf2TGVClzO
	gxkai8jylLiGBZ9LoXMDV4qEN7533PySysphgvbPqeplgzwGH6T+dRH0DTCrLDBgQCpPQWAK9f0t/
	CfZDiXVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJtay-002paF-3D;
	Thu, 13 Jul 2023 10:30:49 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJtaw-002pXT-1L
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 10:30:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 068F5221A1;
	Thu, 13 Jul 2023 10:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689244245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DCNOq+j0xtZP84aUwE8KPQYvyz9rFaVzhnvfV5TLeaA=;
	b=HgYB5rCn+YeML2m46NPdO8yxP1U9ZIDQ4RkRlVb0+d/ZmT/Aus7qq6gjzZZziO5vbIn+Uc
	vQziGY14c3b9ymKmumlN4xDc5ogCnnF0Dyini+JqbLIK0XFCsJeJTHLHJJnunYaWgM5DyH
	yA8XtiRHUBcVCcIL7EpTO6qYN3QCgWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689244245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DCNOq+j0xtZP84aUwE8KPQYvyz9rFaVzhnvfV5TLeaA=;
	b=Zz8NDhbPPYSsg9eQS4S1kg/xGLTRIz1YaYuri8h1eWslxe5FMVJgNppF1XWh7kX+vpFSrl
	YyHs+IGLezxUyODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC473133D6;
	Thu, 13 Jul 2023 10:30:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jv2dOVTSr2T0bAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 13 Jul 2023 10:30:44 +0000
Date: Thu, 13 Jul 2023 12:30:44 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <jsmart2021@gmail.com>, Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <mf3lgyy6qivmeb5ut7jk3qllyzz7hdrmqstz5phxseygj3oc34@sdf3ilsivmbb>
References: <39f9977e-b34c-f2dd-d356-8c78414a60d1@nvidia.com>
 <jdsoqllqmrqu5j5bt3fudkksmjskgs4ooodynm6yh3b4oc5scn@t3hydrmbb22f>
 <972a06e0-6841-043e-fc00-db7596f664c4@nvidia.com>
 <cskolyrp3s47gnn4nwtqpfxtafzhpirn3hv7ovhnnzpbb3ll2z@oum3v3n7go6l>
 <6dced1ba-c468-c88e-f861-9c202e803894@nvidia.com>
 <eadl5bkyysdcymgy7ra4hm6cqn6ngcxbyvz2qzg3fdffsssnpo@d3rzegyurzn5>
 <6fa5ec73-e6c6-cf8e-b11f-1a57f0fc34b4@nvidia.com>
 <95210a8a-c70e-c312-2c47-4f5ee9329586@suse.de>
 <bd7c91c4-9528-aaeb-9789-03191dc7761b@nvidia.com>
 <875b1903-bca8-8c6e-79d7-506313bbd56d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875b1903-bca8-8c6e-79d7-506313bbd56d@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_033046_599016_F6DC9F64 
X-CRM114-Status: GOOD (  11.59  )
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

On Thu, Jul 13, 2023 at 12:14:14PM +0200, Hannes Reinecke wrote:
> > Exposing the subsystem is from the target configuration side.
> > Additionally, the --context (which is in the initiator/host side),
> > according to Daniel, is there to distinguish between different
> > invocations. I proposed that blktests subsystem will not be part of
> > discoverable fabric or protected somehow by access list. Therefore, no
> > additional invocation will happen.

I am confused. This is exactly what the whole --context thing is.

> Hmm. Maybe we can tweak blktest to use it's own HostNQN, and always pass
> that for any nvme-cli call.

This is what the current code already does.

