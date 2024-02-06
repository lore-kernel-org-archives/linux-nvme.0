Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B2AC4828D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 12:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P8ouMeJTH8G9myfbnlB1jHE6cdK3/7iKxDuf/3qLWrY=; b=Qir/Y4vKHWoBz9/kYiPm9BZlN0
	B+IlXvSJwr8NkaOb0dbYJ+8/12oMk3x/vuKbArore4UsJ0xaVU4O/scwNAoY9JBbAE546JKQuSgHY
	gPmYBqqVcPGbgXyoNr77TlSBlAFxwTkdNa69fdrutM0JdUgPFofhVfIuHGuZOJu5BZcPw006rDF41
	3Y/nh2J8DHNbjAnBYsh+k1hit3kDlVHuP7NffVKROQaDnEXGgCHb2YJM/Jhyl66VRAIutwVBzH2WF
	mJGrkCyiu3cmAIRxJ4HWLpj7iLiFwPr29QNe1xwxb/d1ZERvxBBamIq/NCfD8NmE2y5uYOgp/W8Rd
	xF4I33Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXKpe-00000007c1W-2wnv;
	Tue, 06 Feb 2024 12:45:46 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXKpZ-00000007bzm-1FxO
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 12:45:44 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C8592219C;
	Tue,  6 Feb 2024 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707223537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8ouMeJTH8G9myfbnlB1jHE6cdK3/7iKxDuf/3qLWrY=;
	b=eQ8QFqlYayT5Lr7X8TDqnCwphoAJUoLWlGkzB92wAA/3tQvO/PoyURpGRFrMEMOMIouVtk
	SgKyq5GjpyAuVDLMS6G51HBJBTYsbhGP0OkYtnFCNiaRynURaRxkH2GPmrS8Pa4KX2jUiQ
	1FG15eAx701eznl8RA8Tp+lmjo2nwJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707223537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8ouMeJTH8G9myfbnlB1jHE6cdK3/7iKxDuf/3qLWrY=;
	b=MkvtM3msQVwIfEJUsE0dqmG9/I9aidaYVaaRJuC9uleOYNCVfB76kKuN4Wi/Xl0tzgceoR
	PCfQjjaIoSeUSOAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707223537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8ouMeJTH8G9myfbnlB1jHE6cdK3/7iKxDuf/3qLWrY=;
	b=eQ8QFqlYayT5Lr7X8TDqnCwphoAJUoLWlGkzB92wAA/3tQvO/PoyURpGRFrMEMOMIouVtk
	SgKyq5GjpyAuVDLMS6G51HBJBTYsbhGP0OkYtnFCNiaRynURaRxkH2GPmrS8Pa4KX2jUiQ
	1FG15eAx701eznl8RA8Tp+lmjo2nwJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707223537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8ouMeJTH8G9myfbnlB1jHE6cdK3/7iKxDuf/3qLWrY=;
	b=MkvtM3msQVwIfEJUsE0dqmG9/I9aidaYVaaRJuC9uleOYNCVfB76kKuN4Wi/Xl0tzgceoR
	PCfQjjaIoSeUSOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09AC7139D8;
	Tue,  6 Feb 2024 12:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xXkGAfEpwmX9LwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 Feb 2024 12:45:37 +0000
Date: Tue, 6 Feb 2024 13:45:36 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: race between nvme device creation and discovery?
Message-ID: <zsa32voqes4jrgqdn3s646dyzvud7eymen74vw4ehfhqpz3cqp@vm45kuu5ibhb>
References: <i4bmvgd3u7shgizqgtdtssdz5v3wc76l6bcce6fcbvoft32gzk@rztzeut4azvj>
 <e0e89568-d3af-4d4e-9652-59d04f2c1977@suse.de>
 <5pquzxdvemeeahharuoyh72njlx4unrshwxbtkpg63tk3aw2lt@ugv4guf7hkpz>
 <CAFL455kN3Y-ia5twzNRyuT1a+hDWwqS93C2XJDa1+_8nEom0gQ@mail.gmail.com>
 <CAFL455mLZ5j9Jkvo+AqKaAmyjDeTpZgKN2X53uytDD1uQTutHg@mail.gmail.com>
 <p2qty2zv6h5aq7mvbqbg3hbvwe5opuquq2sahcing6s7ezq5fp@dxbadmzjur5g>
 <m4mtj3s5v6wlgvcnir7skajafvekloufkzsodpjpqnzgpv3gfd@mievitjqki5p>
 <r63s55fo5e5vbkbzfvw32hspxkghwozivgmptsv74cjpa3ulik@6jcsrsvkaaho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r63s55fo5e5vbkbzfvw32hspxkghwozivgmptsv74cjpa3ulik@6jcsrsvkaaho>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.20 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[11.77%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_044541_512007_096A14E8 
X-CRM114-Status: GOOD (  20.23  )
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

On Mon, Feb 05, 2024 at 06:13:13PM +0100, Daniel Wagner wrote:
> > > We have a 'state' attribute in sysfs already, though the
> > > NVME_CTRL_STARTED_ONCE is modelled as flag. Not sure how this fits
> > > together yet, so let me play with this.
> > 
> > If I got this right, we could just filter out all controllers which are
> > in the NEW state, because all transports trigger the connect code right
> > after the NEW state. At this point the sysfs should be completely
> > populated.
> 
> I've patched libnvme to print the state of the controller right
> before the lookup for the subsystem happens and it says:
> 
>     +state connecting
>     +failed to lookup subsystem for controller nvme1
> 
> more digging needed...

So after a lot more debugging and testing I think the real solution is
just not to issue the error message in libnvme. It this case we just do
add the device to the tree. And looking the code we have already
other error returns in this function which issue nothing:


nvme_scan_ctrl()
{
	[...]

	subsysnqn = nvme_get_attr(path, "subsysnqn");
	if (!subsysnqn) {
		errno = ENXIO;
		return NULL;
	}
	subsysname = nvme_ctrl_lookup_subsystem_name(r, name);
	if (!subsysname) {
		nvme_msg(r, LOG_ERR,
			 "failed to lookup subsystem for controller %s\n",
			 name);
		errno = ENXIO;
		return NULL;
	}
	s = nvme_lookup_subsystem(h, subsysname, subsysnqn);

	if (!s) {
		errno = ENOMEM;
		return NULL;
	}

	[...]
}

Changing it from LOG_ERR to LOG_DEBUG makes the tests happy. No problems
observed.

