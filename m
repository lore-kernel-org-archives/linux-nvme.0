Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D47C678D4
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 12:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0DDmhBvB4agrkgyT6e20E3M4Tkcsj8paJbo7k09llpU=; b=jH9zIBp/xY3FgWb3OUiApFppOH
	QqnMCYJShRnVJXcDUY6khMNA90UEh+DxUZEoH7/JeRrsLVije3MmMO8RGj1KynqxKYtZS1aRQ0n7O
	Pry3JSQ43nJDJ+hDoP2o6k0ZWKgCZX5BsVRTewjPbNzQbEgHmGqAEa0dW1mR/h8dMzo0h4TyI/1ca
	wYpFmVmjklAm3Bi8UKr+H3d3uCfrzHh8L5Hafb8F/fObLT96/z52K6amdYcJCUBEWt+ZPqMoBjdIk
	7jXBmmdCY6qkckYinHwtHS+hnvfEYTIdV0TZz30Dt/VglzWd1yNdLJJ+r4gWLbKaFeKbZ55TdLSxr
	lpW2Ni3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZWR6-0006QC-4V; Tue, 07 Mar 2023 12:28:56 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZWR3-0006PL-38
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 12:28:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9DC11F37C;
	Tue,  7 Mar 2023 12:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1678192129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0DDmhBvB4agrkgyT6e20E3M4Tkcsj8paJbo7k09llpU=;
	b=kEiQ1cdigWXZw8Ns2PfxTJcv+04gGC7aWhC6l4XlUJPoTQnBBznv2yNlAcFJmBI0APVq9/
	Md5JNIJ4vGHBDjsYyDKZdQaX3fuYX11xNIF12dqo8+lK6r/j2HJXGzTUL9veUnQG0c1QKQ
	nqsjY9wjFUksn4ibr9oNO3T6KDOElAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1678192129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0DDmhBvB4agrkgyT6e20E3M4Tkcsj8paJbo7k09llpU=;
	b=+J6JnzdBk6qWv1g+nDYb01QKhdE8WjY1WylQkMd8O+sNt1Mx38TNkkj2ECUgsS9NtEOg3/
	c7WgHRpV4Q/i50DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A87991341F;
	Tue,  7 Mar 2023 12:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id vCYbKQEuB2SIMAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 07 Mar 2023 12:28:49 +0000
Date: Tue, 7 Mar 2023 13:28:49 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [RFC v1 0/3] Unifying fabrics drivers
Message-ID: <20230307122849.3oc66ojdsgvvj77h@carbon.lan>
References: <20230301082737.10021-1-dwagner@suse.de>
 <a73ea22a-9871-d152-080e-49c0904dbe94@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a73ea22a-9871-d152-080e-49c0904dbe94@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_042853_319494_DC34A184 
X-CRM114-Status: GOOD (  17.98  )
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

On Tue, Mar 07, 2023 at 11:26:12AM +0200, Sagi Grimberg wrote:
> I think we should make all transports to unify setup/teardown sequences
> (i.e. including pcie and fc). Otherwise we are not gaining much.

Not sure about pcie but I haven't really looked at it. The state machine is
really handling all the fabrics specific queue handling.

Ideally, fc would use the same state machine. Though the current code base is
differs quiet significantly but I can try to convert it too.

> It will help if we make the ops higher level like
> 
> ops.setup_transport(ctrl)
> ops.alloc_admin_queue(ctrl)
> ops.start_admin_queue(ctrl)
> ops.stop_admin_queue(ctrl)
> ops.free_admin_queue(ctrl)
> ops.alloc_io_queues(ctrl)
> ops.start_io_queues(ctrl)
> ops.stop_io_queues(ctrl)
> ops.free_io_queues(ctrl)

This is more ore less what v2 is.

> The init/deinit can be folded to alloc/free I think.

Yes, that would a good thing. In my first attempt I tried to keep things more a
less identically with the existing code, just using the callbacks for the
transport specific bits.

> This is indeed a much larger effort, but I don't know what
> this unification of rdma/tcp buys us really...

My motiviation is that we are keep fixing the same bugs in rdma and tcp
transport since a while. The state machine code is almost identically so why not
trying to reduce the code duplication?

(*) There are a few small things which are not the same.

