Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9A5C678D4
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3UAINWft++6VP4kXhCOKs0gr7LLCXtmbAnFL03GxT0A=; b=hrivSBOULrOJDcwiX9CATxs9Hg
	uubOoVd9heUxAITUse+S4LtH6q75Ux0pmDPd52m81dYSYIfF8DeKV0zbBwZxK1rhzvDHe+WKrxF88
	1W7TtjEN/MuDPvoWNSoZoAE862yrbRLPeO122U7bsOWaR1UBzDZZmfDZgY6SIIctXHCZcvVS62H92
	Ul5DrqRzoQ3OdrqAgv3vetsBH2PI1m08PyBWoG/5vasyakZo2tQWFEJDguXQU0659m5ArtXvoPhL4
	n9jFfTPlz6+hkgtQCocCj9NUksWOxpdZZNHJaxt4491GSGs97SfIjPMZGo/Ae/7rNuDxW/Gf6gH89
	L4TKBYAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZWdf-0008XG-Mq; Tue, 07 Mar 2023 12:41:55 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZWdW-0008Rv-5x
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 12:41:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7444F1FE17;
	Tue,  7 Mar 2023 12:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1678192904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UAINWft++6VP4kXhCOKs0gr7LLCXtmbAnFL03GxT0A=;
	b=G4QD9wHxiXFduzK100V28QjHqB3GnllQTBcAkVHKcpDkHBcYbeZprjXY7SGtQvMB8O75fx
	YHluZBW9MAfyzlIoOe3G7vBqjZfMmyjj75kXAgEpLGDmPkvlpFLeaUSaFMP+kexVV30ZjQ
	Qy+San9yiFl2IMWUg3cOSEvz2GJqNiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1678192904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UAINWft++6VP4kXhCOKs0gr7LLCXtmbAnFL03GxT0A=;
	b=VyAc9LHXgV/Rm/i2RBS3EpsK5B+kezJNkvO6zG5DeDQlIEyaqSmmAZnsPP9Ika3DpM22R+
	SQH31OzFI7wVXeBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 674541341F;
	Tue,  7 Mar 2023 12:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id tpQrGQgxB2SZOAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 07 Mar 2023 12:41:44 +0000
Date: Tue, 7 Mar 2023 13:41:43 +0100
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <jsmart2021@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [RFC v1 0/3] Unifying fabrics drivers
Message-ID: <20230307124143.s5ojphvt2wvdj2j7@carbon.lan>
References: <20230301082737.10021-1-dwagner@suse.de>
 <e70f3b0c-5049-0bbe-fb13-41efc0425e0f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e70f3b0c-5049-0bbe-fb13-41efc0425e0f@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_044146_396856_F7DD51C0 
X-CRM114-Status: GOOD (  24.76  )
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

On Fri, Mar 03, 2023 at 03:13:53PM -0800, James Smart wrote:
> Initial reaction:
> The resulting nvmf_configure_admin_queue() routine does look nice. However,
>> I'm not sure the callback chain is all that easier to follow.

v1 is a bit too simple as I only tried to get nvmf_configure_admin_queue()
sorted out.

> I guess I'm most disappointed that more of the logic isn't actually being
> commonized.

v2 is moving the whole state machine which makes more sense.

> Examples:
> alloc_queue():
>   At least pass queue_size as an arg. I assume we should to match up
>   with the fabric connect routine.

I'll look into that.

> init_queue():
>   I'd like to see setting of ctrl.max_segments/hw_sectors in the common
>   code. Unfortunately, likely needs to be a fops call. At least it
>   makes sure its done at the same point in controller creation.

Okay, I suspect it needs a few iterations until we sorted all these details out.

> start_queue():
>   can't common code do the nvmf_connect_admin_queue() call ?
>      If its too tied to the LIVE bit - then perhaps the queue LIVE
>      bits should actually be getting set by the common code after
>      the successful start_queue - or has routines transport can call
>      from start/stop to set/clear it.
>   If LIVE bit can be dealt with - this whole block in rdma/tcp moves to
>   common code.

Good point, the LIVE bit is currently transport specific which it dosen't need
to be.

What would be the best strategy with this kind of change for review? Should I
add stuff ontop v2 or should I try to add the common code first and then migrate
the transports over? The current approach with moving and updating in the same
time is obviously a bit hard to review (and has a good chance to introduce
regressions).

> Also I'd really like to get rid of the "new" argument everywhere. It should
> just be a state flag set on the common ctrl.

Okay.

> I guess not bad, but not helping much (yet).

I posted a very early version to discuss the approach and get all parties to
agree on so it has a chance to get accepted.

