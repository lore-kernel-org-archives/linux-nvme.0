Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D9FC19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 08:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MfvNRguiS2iq5y0sNZKB60jqe2ezNBZsG1kuxHfIPlI=; b=STp5j7qknxzNbD1fWY4tdBct/0
	MWLxQY+Y++YSZh3zRS/FTn63eI0Vrx3TkYaigp9TDtg2GlQSjh+6M7bqpv9ZLNgVg7D3KaWlSjS/2
	bp/6GExfORRX21Wnff/xMQvWtZinYvZO+fWg76kh1IR7Kj6FAggWFWPL7QwfyX/4sgVW6daCARMTQ
	2KFdO2/lqkYMEulCN8hAnj7uWNAXd9lzrrB75d+GfzgCT49YwbOzKiFMnziaaCeGROiXMayZ1dTwJ
	wmvduRWyTxcQYs61XcrlRDul7KB9Td3Gdi0ds8eqXp/qSwGphMd9OnLLUp/YkqIdfTAIlc2c+3fqO
	a1J0Ky1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnviD-0000000AB5a-1AF9;
	Fri, 28 Feb 2025 08:27:13 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnva2-0000000A9Lw-1Lw5
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 08:18:47 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA1382116F;
	Fri, 28 Feb 2025 08:18:44 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C750C13888;
	Fri, 28 Feb 2025 08:18:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +qZYMGRxwWeTNgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 28 Feb 2025 08:18:44 +0000
Date: Fri, 28 Feb 2025 09:18:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] nvmet-fcloop: track ref counts for nports
Message-ID: <dd2178ca-2875-4afb-b7d0-3a00af9f76bf@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-4-c0bd83d43e6a@kernel.org>
 <d4b09a75-30f8-4db7-a02b-25ae405f7340@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b09a75-30f8-4db7-a02b-25ae405f7340@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: DA1382116F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_001846_507255_BAA28DD7 
X-CRM114-Status: GOOD (  14.57  )
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

On Fri, Feb 28, 2025 at 08:19:19AM +0100, Hannes Reinecke wrote:
> >   static int
> >   __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
> >   {
> > -	if (!tport)
> > -		return -EALREADY;
> > +	int ret;
> That's iffy.
> Q1: How can you end up with a NULL tport?

The existing code doesn't get the life time right. I don't think it's
necessary anymore. This gets removed in the next two patches.

> Q2: Why do we have _two_ arguments? Can't we use 'nport->tport'?

This is addressed when the rport and tport get their own ref counting
(next two patches).

> Q3: What do you do when tport is valid and tport != nport->tport?

That is not going to happen after the full series.

I've tried to keep the changes logically separated. This patch here is
only updating the nport ref counters. It took a long time to get these
changes into a readable state. I really would like to avoid doing to
many things in one patch.

