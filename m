Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FE8C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 13:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yDI1CkXqiATchfksA3PoHOEkfJ4bg5IrcSInmqCmavE=; b=nxOVcHbh1wB7JucgazmAOXlsYz
	pJUpsNCFosySpsVEbIVpVHpkbj786fNEivQZJ0JoUSKfGdmDUcmja4Eed2wHD12+v+47GlUVBOXSv
	lkSHVbLENXTtQvel+WJqfrU8b1J9Khdgyjq1yl21o+pcj4ccRoyYvZwxRuA2sQB/19+hrx2mTpgL9
	7KUZHJnIpJOWe70T+1v2Wo3b1Vxr6BG60cHts+IVd9fHV7XxyPAnQKz+yAlH6RdzFtBbnsu5aUlTV
	JkxtmXHsGaP1nF0KlirmFPHSsXsiHzBpXrKvJc+aq1RoOyaCpdBP81bm5GG7/d16Dt5Eg+anokAfs
	TKhmI28A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXSp-00GZTw-Li; Wed, 28 Sep 2022 13:51:03 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXSk-00GZSy-2x
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 13:51:02 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E52B221DDF;
	Wed, 28 Sep 2022 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664373053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yDI1CkXqiATchfksA3PoHOEkfJ4bg5IrcSInmqCmavE=;
	b=KwwPtMNaSYRFc4+q5R5VndTDevhCJiBQ4Is+0F7IJO7sRW7B35u8XZPu5lqEIqEWsSh1/8
	QwGfnNtKLm83EtIcZ7HCUfGyEazJQRipdRTfHOJquy4mXc/PO4xPPmBOS3rKAGRFLsdxmf
	ztwmJOCsf0FgyE/siv4JO/wdXn57k84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664373053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yDI1CkXqiATchfksA3PoHOEkfJ4bg5IrcSInmqCmavE=;
	b=sUo2NcBKcXkV5mZqOShEcUPDEADOFKW3oBosi85kb8tYK6xQ6Lw0475YCGJxnr6XPvMKqy
	3a+lCAkEWBTGSVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB6A013677;
	Wed, 28 Sep 2022 13:50:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ohejMT1RNGN6ZAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 28 Sep 2022 13:50:53 +0000
Date: Wed, 28 Sep 2022 15:50:53 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "Knight, Frederick" <Frederick.Knight@netapp.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
Message-ID: <20220928135053.s6h6xr3llhp6riwr@carbon.lan>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_065058_295709_3D72E7FC 
X-CRM114-Status: GOOD (  26.42  )
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

On Wed, Sep 28, 2022 at 12:39:44PM +0000, Knight, Frederick wrote:
> Would this be a case for a new AEN - controller configuration changed?
> I'm also wondering exactly what changed in the controller?  It can't
> be the "Number of Queues" feature (that can't change - The controller
> shall not change the value allocated between resets.).  Is it the MQES
> field in the CAP property that changes (queue size)?
>
> We already have change reporting for: Namespace attribute, Predictable
> Latency, LBA status, EG aggregate, Zone descriptor, Discovery Log,
> Reservations. We've questioned whether we need a Controller Attribute
> Changed.
>
> Would this be a case for an exception?  Does the DNR bit apply only to
> commands sent on queues that already exist (i.e., NOT the connect
> command since that command is actually creating the queue)?  FWIW - I
> don't like exceptions.
>
> Can you elaborate on exactly what is changing?

The background story is, that we have a setup with two targets (*) and
the host is connected two both of them (HA setup). Both server run the
same software version. The host is told via Number of Queues (Feature
Identifier 07h) how many queues are supported (N queues).

Now, a software upgrade is started which takes first one server offline,
updates it and brings it online again. Then the same process with the
second server.

In the meantime the host tries to reconnect. Eventually, the reconnect
is successful but the Number of Queues (Feature Identifier 07h) has
changed to a smaller value, e.g N-2 queues.

My test case here is trying to replicated this scenario but just with
one target. Hence the problem how to notify the host that it should
reconnect. As you mentioned this is not to supposed to change as long a
connection is established.

My understanding is that the current nvme target implementation in Linux
doesn't really support this HA setup scenario hence my attempt to get it
flying with one target. The DNR bit comes into play because I was toying
with removing the subsystem from the port, changing the number of queues
and re-adding the subsystem to the port.

This resulted in any request posted from the host seeing the DNR
bit. The second attempt here was to delete the controller to force a
reconnect. I agree it's also not really the right thing to do.

As far I can tell, what's is missing from a testing point of view is the
ability to fail requests without the DNR bit set or the ability to tell
the host to reconnect. Obviously, an AEN would be nice for this but I
don't know if this is reason enough to extend the spec.

I can't really say if this is a real world scenario or just a result of
trying to cut corners. Anyway, I am glad to do the work if we can agree
on how this test case could be implemented.

Daniel

(*) not sure how to call it properly, is this one target or two targets?

