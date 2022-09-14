Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A91ECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Sep 2022 11:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n8oHeLRGdXVZvmSIdgnKW+nqgcZRm6dFYE+8HfnyAdg=; b=bXMXUGsCpGWNobiJrbzINYNy+m
	LZWE4Al48SEVNiKBVVvAG7HWl4psAuYxeWVAlsHR8OQt/bJxTuUdgzEPXk8GnZ+Iy876kA1hJdIFG
	R2l2ac+yTanKnyRICEaOmDT3/uIBX6lVQ1zRpFnZaD4MUACmkEy0UM02mbjVHfvDUHLb+LT3SbOhf
	vxscgHxWVK2O8+SClExvY3s0iGh8cg2b4Nlrmf06EC+44A6hDGTLnkqaXrn1TU9e3REPjrcaV6VnH
	5R185bbn80HQlZVs9O+xkQbe/zIC0ksbuMUbeDeBPrIr00XrfVT/dcaxgfF5Y9hA4VGmMqoZ/IKn0
	wHfjRUMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYQEq-00Fcyc-9X; Wed, 14 Sep 2022 11:07:28 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYQEj-00Fcvj-QG
	for linux-nvme@lists.infradead.org; Wed, 14 Sep 2022 11:07:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 30A7133881;
	Wed, 14 Sep 2022 11:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663153638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n8oHeLRGdXVZvmSIdgnKW+nqgcZRm6dFYE+8HfnyAdg=;
	b=TGAz/L8k3E7/aJSiZ1aoWst/MgxyFE+HKP5KnUZ3Yy4KI1du2bIohrgTIJQeUyiGescuob
	fg3nwRluOckxrrJ5LtnLZxUfysuod19msSY/eivpxwjd+gZmeUoFp8NFH8Nfy0lm3iKrYq
	rCwz6ME65RGXnugcxQsE5U5JI1fwJy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663153638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n8oHeLRGdXVZvmSIdgnKW+nqgcZRm6dFYE+8HfnyAdg=;
	b=3OWYMC7NV4wKQujaC4MKMxQ8hMfEi6e1d8cq+n38nZDEY9wr29umJeWCrgTacJPSmWXx7u
	E9MkrC5oZ0mY7XBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2259B13494;
	Wed, 14 Sep 2022 11:07:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id HPNCCOa1IWPUWAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 14 Sep 2022 11:07:18 +0000
Date: Wed, 14 Sep 2022 13:07:17 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v3] nvme/046: test queue count changes on
 reconnect
Message-ID: <20220914110717.pvzm2666mklkg73a@carbon.lan>
References: <20220913065758.134668-1-dwagner@suse.de>
 <20220913105743.gw2gczryymhy6x5o@shindev>
 <20220913114210.gceoxlpffhaekpk7@carbon.lan>
 <20220913171049.kgim57lu5rqb7j3g@carbon.lan>
 <20220914090003.jbc5xmtfxjjssuz3@carbon.lan>
 <3b58b91d-e217-86a2-b2e4-3b0656bbe0e9@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b58b91d-e217-86a2-b2e4-3b0656bbe0e9@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220914_040722_019116_1B112C32 
X-CRM114-Status: GOOD (  26.17  )
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

On Wed, Sep 14, 2022 at 01:37:38PM +0300, Sagi Grimberg wrote:
> 
> > > > > FYI, each blktests test case can define DMESG_FILTER not to fail with specific
> > > > > keywords in dmesg. Test cases meta/011 and block/028 are reference use
> > > > > cases.
> > > > 
> > > > Ah okay, let me look into it.
> > > 
> > > So I made the state read function a bit more robust (test if state file
> > > exists) and the it turns out this made rdma happy(??) but tcp is still
> > > breaking.
> > 
> > s/tcp/fc/
> > 
> > On closer inspection I see following sequence for fc:
> > 
> > [399664.863585] nvmet: connect request for invalid subsystem blktests-subsystem-1!
> > [399664.863704] nvme nvme0: Connect Invalid Data Parameter, subsysnqn "blktests-subsystem-1"
> > [399664.863758] nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (16770)
> > [399664.863784] nvme nvme0: NVME-FC{0}: reconnect failure
> > [399664.863837] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> > 
> > When the host tries to reconnect to a non existing controller (the test
> > called _remove_nvmet_subsystem_from_port()) the target returns 0x4182
> > (NVME_SC_DNR|NVME_SC_READ_ONLY(?)).
> 
> That is not something that the target is supposed to be doing, I have no
> idea why this is sent. Perhaps this is something specific to the fc
> implementation?

Okay, I'll look into this.

>  So arguably fc behaves correct by
> > stopping the reconnects. tcp and rdma just ignore the DNR.
> 
> DNR means do not retry the command, it says nothing about do not attempt
> a future reconnect...

That makes sense.

> > If we agree that the fc behavior is the right one, then the nvmet code
> > needs to be changed so that when the qid_max attribute changes it forces
> > a reconnect. The trick with calling _remove_nvmet_subsystem_from_port()
> > to force a reconnect is not working. And tcp/rdma needs to honor the
> > DNR.
> 
> tcp/rdma honor DNR afaik.

I did interpret DNR wrongly. As you pointed out it's just about the
command not about the reconnect attempt.

So do we agree the fc host should not stop reconnecting? James?

