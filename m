Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5131C07E98
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 08:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xhtMDEPVeCkzMMr9t+QFUn/frIx4jqPqIJXFe1KAaNs=; b=ZKgDPdKeBunhP7/2C79unODKzb
	+690mgwRcNu2XZEt7kJ1lyfugOtFWWoOp8enl1U8eCyIZFwXdikm17vGcSKWuczdukA8mkb9VJRq/
	3ojUCeTkye1iCo0Tcwg6yIJlgwl08Kaqy+IyjQdGUQdXrTyz6Gr0gf4XW9NnF+UbggtICYJWxrQaK
	nvozIfirJHzp2FXfXLkQSEsFWZxDY79UtJuJm9G03QvyAP5R1K1e/P+9tXe56yFrwUkAXIRU29mY6
	NEuaVYia7B9XOEd+QgqP3ZI2H9/yEBh44lC/iKloY3oRYLT0BKRtM3xUJzDRq6ZR8Wrau34XzLhPu
	pC7dNAOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7tJh-004W7e-17;
	Tue, 28 Nov 2023 08:19:37 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7tJe-004W6s-1x
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 08:19:36 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52CEC2195A;
	Tue, 28 Nov 2023 08:19:32 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F0DE133B5;
	Tue, 28 Nov 2023 08:19:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id hMfuDZSiZWWbPQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 28 Nov 2023 08:19:32 +0000
Date: Tue, 28 Nov 2023 09:21:45 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <n57gxockmm4iqt53olerr52rgxg3mvgdp4wfshyci2r7dohxfg@22mqtj3ya3g3>
References: <20231127103208.25748-1-dwagner@suse.de>
 <20231127141857.GA25833@lst.de>
 <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
 <20231127155649.GA1403@lst.de>
 <ZWTEFvYbI1bFTXyZ@kbusch-mbp.dhcp.thefacebook.com>
 <20231127163333.GA2273@lst.de>
 <ZWTH85bmw0cdePXf@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWTH85bmw0cdePXf@kbusch-mbp.dhcp.thefacebook.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 52CEC2195A
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_001934_803762_BCA4D087 
X-CRM114-Status: GOOD (  19.85  )
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

On Mon, Nov 27, 2023 at 09:46:43AM -0700, Keith Busch wrote:
> On Mon, Nov 27, 2023 at 05:33:33PM +0100, Christoph Hellwig wrote:
> > On Mon, Nov 27, 2023 at 09:30:14AM -0700, Keith Busch wrote:
> > > > > Should this even be an nvme specific attribute? I thought we should have
> > > > > blk-integrity.c report its 'tuple_size' attribute instead. That should
> > > > > work as long as we're not dealing with extended metadata at least, but
> > > > > that's kind of a special format that doesn't have block layer support.
> > > > 
> > > > Reporting the tuple size is a good idea.  But is that enough for
> > > > the existing nvme-cli use case?

'nvme list' is just listening the block size and the meta size in the
'Format' field. So nothing really crazy going on:

  Usage                      Format
  -------------------------- ----------------
  343.33  GB / 512.11  GB    512   B +  0 B

nvme-cli commands like 'nmve ns-id' etc will always issue a command so
that is not a concern. It's just the libnvme nvme_scan_topology() call
which should stop issuing any commands.

I'll add the missing tuple_size to the integrity sysfs dir in this case.

> > > nvme-cli currently queries with admin passthrough identify command, so
> > > adding a new attribute won't break that. I assume Daniel would have it
> > > fallback to that same command for backward compatibilty if a desired
> > > sysfs attribute doesn't exist.

Yes, a fallback will exist. There is no need to break existing users.

In summary, the only missing entries are

 - csi
 - tuple_size
 - nuse

