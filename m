Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8FEC54E5D
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 13:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6oXFvS9610RzB0va1HdQyUtjbXD54ats5fKJEVvh3i0=; b=MVabkO6njgBDWdNDOF+ylnwX2t
	9NV/eFZ2t8n/4N6H8YHsjjULRIhmJYp59dAD/lnrzwJLxl0ueim8AWh1afJBs2oXKYN5Sdl6m8FvE
	MvN+rsOZ1vKv/3+zda7nGDx1sl3Q45sdAA4yxNjaBAWknqo4/c4HgYh3Gs27IqSGDrVYDn8FJbFQM
	BjK00LZ5twIt8enJnj851rUJMGN3uOsSR1oZkjHPfL3WHItunFQngqu4Y5uYVon/QJj7IGKk0ItHx
	eF+rCjGHRkrRnSv8rghunGv14BQGeEtbLJ11h3moAzl9FFG0/LyukFvJuVA3TK1db7FKHwb/KSDjE
	+lTpruIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmDDv-00000008h88-3MaH;
	Mon, 18 Mar 2024 13:40:19 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmDDr-00000008h6G-1utk
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 13:40:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E41EC5C58D;
	Mon, 18 Mar 2024 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710769211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6oXFvS9610RzB0va1HdQyUtjbXD54ats5fKJEVvh3i0=;
	b=15mS08Z7ta9s5zzJPYvKpJAUmRU2NyOgNXh7iOMzq1G7P1A7C3d0iYyO6tNz4czFeLYnkU
	zWwTb0tisYHrumpOQTitzzAG2Lh4zPOcaIB+smv0Me9RAcK8rxTBCcfbBYlAKQX4f5aOs6
	vBbtIlqpO/GRbGuncnJOsd+cXV1BSTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710769211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6oXFvS9610RzB0va1HdQyUtjbXD54ats5fKJEVvh3i0=;
	b=ffvyZFPXBijH68uAeXemhM/35J4LsMgyZ9Ab8gNVwKGMr7LGbphM93qNH8wWS+zUg1uXJw
	1uyezBRsZwYpDrBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710769211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6oXFvS9610RzB0va1HdQyUtjbXD54ats5fKJEVvh3i0=;
	b=15mS08Z7ta9s5zzJPYvKpJAUmRU2NyOgNXh7iOMzq1G7P1A7C3d0iYyO6tNz4czFeLYnkU
	zWwTb0tisYHrumpOQTitzzAG2Lh4zPOcaIB+smv0Me9RAcK8rxTBCcfbBYlAKQX4f5aOs6
	vBbtIlqpO/GRbGuncnJOsd+cXV1BSTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710769211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6oXFvS9610RzB0va1HdQyUtjbXD54ats5fKJEVvh3i0=;
	b=ffvyZFPXBijH68uAeXemhM/35J4LsMgyZ9Ab8gNVwKGMr7LGbphM93qNH8wWS+zUg1uXJw
	1uyezBRsZwYpDrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D08011349D;
	Mon, 18 Mar 2024 13:40:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OyZ0MjtE+GVgKAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 18 Mar 2024 13:40:11 +0000
Message-ID: <bf1201db-a2fb-4ced-ac62-36315bbdf4a6@suse.de>
Date: Mon, 18 Mar 2024 14:40:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Hannes Reinecke <hare@suse.de>
Subject: Connection reset in nvme-cli?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.27 / 50.00];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.01)[46.85%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.98)[-0.976];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_064015_682788_E58675CD 
X-CRM114-Status: GOOD (  12.35  )
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

Hey Sagi,

the secure-concatenation stuff is nearing completion, but there is just
one snag: After DH-CHAP negotiation the connection has to be reset to
start over with a TLS-encrypted connection.

IE currently I have to do:

nvme connect ...
echo 1 > /sys/class/nvme/nvmeX/reset_controller

which is clearly unsatisfactory.

So now I have two options:
1) reset the controller after the call to ->create_ctrl()
    in drivers/nvme/host/fabrics.c
2) reset the controller from nvme-cli after the connection
    was established.
The really awkward thing is that resetting the connection works
when run from the error recovery; it's just the initial connect
for which I need to do something 'special'.

Personally, I'm not a big fan of option 2), as it means that we
have to do a 'blind' reset, ie we have to assume that upon reset
we'll pick up the correct key. If someone slips in a new key
after the initial connect and the reset call the connection will
fail as we won't be able to pick up the correct key.
Option 1) doesn't have this problem (as the 'options' structure
is carried over across resets, and the generated key is stored
in there). But then the intention seems to be to move error handling
/ retries from the initial connect over to userspace.

So, which way do you prefer?

Cheers,

Hannes

