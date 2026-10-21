Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D76606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P5SPc2xI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UXbOGUpZm15en8KHgC3tGiUJ4oIJt1ZsmGR453cgBIY=; b=P5SPc2xI81vCfs64xa0OuTorpP
	fA5HAsjMVoJaQWqzZTEOk4sWB1LPK31rYdZLjPLPUpbA7tFOFFZMwfy1m9SEnZkMiv8lM5ZBQa3P1
	nqOVg0ny7qVlRDSUGwlBbBhkbHvhHxk+5tfhoMASKr1mXo8zZ6EBX1peue7hzz7uzYgYLAbkR+uAu
	W8uvgjMlFPV/UB+MGb1eFlj0e0nidRkFSHbexYAT62mNKlM4wNEUwlsNGkwjfTarmkG8YAhdKpMF0
	nvcF1Y/EvadNbtoNmrt0DPmHUsVZj63AnksrACCRd2z4wpHovUj7zixDsXKrRX6+0lXuRENmsLQX/
	hcd++9Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRXx-0000000BJy5-4095;
	Wed, 21 Oct 2026 08:19:41 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRXw-0000000BJxJ-1u4Y
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 08:19:41 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F14F1F457;
	Wed, 21 Oct 2026 08:19:38 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67C73134FD;
	Wed, 21 Oct 2026 08:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BnZkEZp12GovSgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 21 Oct 2026 08:19:38 +0000
Date: Wed, 21 Oct 2026 10:19:37 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Saravanan D <saravanand@crusoe.ai>, linux-nvme@lists.infradead.org, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, 
	nilay@linux.ibm.com, sgogte@purestorage.com, hare@kernel.org, 
	linux-kernel@vger.kernel.org, iyamahata@crusoe.ai, kiyer@crusoe.ai, ganbalagane@crusoe.ai, 
	sjpark@crusoe.ai
Subject: Re: [PATCH v5 2/2] nvme-tcp: allow setting per-queue io_cpu through
 sysfs
Message-ID: <79b5a23a-5ecf-4e96-85c8-031b5eca2867@flourine.local>
References: <20261018010059.83120-1-saravanand@crusoe.ai>
 <20261018010059.83120-3-saravanand@crusoe.ai>
 <0ee4d281-61b4-458e-92c6-7fff3e50c0ec@flourine.local>
 <72fce5bb-b256-42aa-8844-f970c4480ad3@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72fce5bb-b256-42aa-8844-f970c4480ad3@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9F14F1F457
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_011940_644172_CEE165E5 
X-CRM114-Status: GOOD (  17.41  )
X-Spam-Score: -4.2 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 09:21:09AM +0200, Hannes Reinecke wrote:
> > I think it make sense to allow that the user can change queue CPU
> > pinning during runtime even with isolcpu enabled. And then the question
> > is should this be connected to cgroups?
> 
> Not sure if cgroups is the right concept here; cgroups are user/
> application centric whereas nvme-tcp is pretty much queue/cpu centric.
> IE after all the cgroup calculations are done.
> Don't think cgroups are a good fit here.

There was a lot of discussion during Linux Plumbers on how to configure
a system for the isolcpus case at runtime. From what I understand, the
preferred interface for this is cgroups. Hence, pinning the CPU for this
work is likely a target for it, though I don't think there is a need to
figure it out right now. I just wanted to highlight this point.

However, to make this truly user-friendly, I think nvme-cli should be
extended so it is aware of this and can configure it directly. I've
merged Nilay's --nr-io-queues patches, so this is the natural next
feature nvme-cli should support; see commit:

e170d6985797 ("news: document the use of --nr-io-queues during nvme connect")

I would also really like to have a blktest for this as well.

