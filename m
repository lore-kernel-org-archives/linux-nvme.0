Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDCFC369D8
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tJdKg0AM7bnavIX4fjpcO9tgoXWYFgs3Zwbw1mNNCAM=; b=1rQIwPtPz3CMKN0NiCgV9q8+K1
	K4O5EjDXbNafcRZBceI7QW6naBZlZ7x3xLIW4grJa9MgjksNZpKHRyUd1TlKwGP+SGLxG7QEjwmOp
	0B9FQlOFrLa5vvpQ+wqR4cEHUaGn7PAk52GPIX/g740k0QQiFLIMVSSRbOy/cBig7wMpHYmTdYfLY
	SqaEg1nmWQPBhzoLMdSv1EGQrBgQt9Z4BQyIsrwlOVXmcYMnsx54oUbFuV0EXDCknR5S/akEkhH7h
	JEHGwmA6pNB6PmkpZkbxGKRP7FXjV4LN/meREdJr5ifDL38NtCwTEmeR52Fzz5gVobythxy50Uhfk
	eAHV54TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7wxo-0000000EFrv-1kwk;
	Thu, 24 Apr 2025 13:50:04 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7wAT-0000000E7O5-0Jxt
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 12:59:06 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A859A1F445;
	Thu, 24 Apr 2025 12:59:03 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BEB2139D0;
	Thu, 24 Apr 2025 12:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 65bLH5c1Cmg+VgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 24 Apr 2025 12:59:03 +0000
Date: Thu, 24 Apr 2025 14:58:58 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/14] nvmet-fcloop: don't wait for lport cleanup
Message-ID: <11c9e291-b7dd-453c-82d8-09d068b6b69c@flourine.local>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
 <20250423-nvmet-fcloop-v5-10-3d7f968728a5@kernel.org>
 <05ac9a81-66a9-4bbc-92e0-6ff47a6dc7ad@suse.de>
 <c1f207f3-6657-4803-90df-a059353ba6da@flourine.local>
 <8a3093b6-d5b2-496d-828a-0667abbf1670@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a3093b6-d5b2-496d-828a-0667abbf1670@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A859A1F445
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_055905_253662_4B04311A 
X-CRM114-Status: UNSURE (   9.90  )
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

On Thu, Apr 24, 2025 at 02:10:20PM +0200, Hannes Reinecke wrote:
> My point was more: you call kmem_cache_destroy() unconditionally upon
> exit. But the boilerplate says that you have to free all allocations
> from the kmem_cache before that call.
> Yet the exit function doesn't do that.
> Question is: what are the guarantees that the cache is empty upon exit?

The first loop will only terminate when all request have been freed,
thus it is safe to destroy the cache afterwards.

