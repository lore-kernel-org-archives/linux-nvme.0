Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C087C3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 22:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CVgOF5htGgXTxeqgootQCNOyXhH1t1T2eIGBUtemh/I=; b=IDNsOjtWYbc6YjJt4UwYJXw6Do
	QsAcTJ3qMEmJ4fWwhTnZZw+MKHpu8bJJIa3rhJVc8wD/A+Gw1D+V4UnbOrGjF3KnWWGuMA4A7z7gZ
	BrKkPwr0qZRjdAv2RHs3vfh7FuICpDewJ7auM7sbOhf4xv+22K5+PQD/3UUdRIoSHek4Cp9h5EStN
	bbz85D9/fg2/06nf98ajO98x8rEaeV/lmwVVkd4kGydZFIb4tnR0SQ9/Yh9CPd9C8mtfBQ8kcJmPO
	O0YGjwNeNNOgZ1Zs1DVcrmMRyXQvhHy/XUkCMkIJZFspFkkO/1AONouoaTuJ2wN0h6slUrld6UiDr
	IbIiSEWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCQgh-0000000DWPl-1amt;
	Tue, 06 May 2025 22:22:55 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCLHG-0000000ChGM-14Kq
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 16:36:19 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 32D1A1F393;
	Tue,  6 May 2025 16:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746549375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVgOF5htGgXTxeqgootQCNOyXhH1t1T2eIGBUtemh/I=;
	b=2CCsXtvZxAqDQMljkijEpYnKLjkj/hjiZjJwy52pIHG0NbxFSee8ePByzN1mA7f1Ci+W2S
	sJTKC+lCk3A0+3NjsQ+YBw/ESclXN3Vp3oogG/OP/ZbAO8jo+md5P+N6LriugGzbCkgjYH
	lmvq9U/IFG/qUKeueiqEu8zwCwbRbZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746549375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVgOF5htGgXTxeqgootQCNOyXhH1t1T2eIGBUtemh/I=;
	b=qC982Qq8299An0TUOWoGF03gIjt7Jkhv8DJgLEemPumVieFVTx9o+25AqzS228Fq3K/zzB
	thN7SeRLiTFk05DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2CCsXtvZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qC982Qq8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746549375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVgOF5htGgXTxeqgootQCNOyXhH1t1T2eIGBUtemh/I=;
	b=2CCsXtvZxAqDQMljkijEpYnKLjkj/hjiZjJwy52pIHG0NbxFSee8ePByzN1mA7f1Ci+W2S
	sJTKC+lCk3A0+3NjsQ+YBw/ESclXN3Vp3oogG/OP/ZbAO8jo+md5P+N6LriugGzbCkgjYH
	lmvq9U/IFG/qUKeueiqEu8zwCwbRbZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746549375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVgOF5htGgXTxeqgootQCNOyXhH1t1T2eIGBUtemh/I=;
	b=qC982Qq8299An0TUOWoGF03gIjt7Jkhv8DJgLEemPumVieFVTx9o+25AqzS228Fq3K/zzB
	thN7SeRLiTFk05DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1861513687;
	Tue,  6 May 2025 16:36:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qHqUA386GmjydAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 May 2025 16:36:15 +0000
Date: Tue, 6 May 2025 18:36:14 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/14] nvmet-fcloop: track resources via reference
 counting
Message-ID: <144a314b-75b8-4d0c-ae19-40680cb681d1@flourine.local>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
X-Rspamd-Queue-Id: 32D1A1F393
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_093618_444263_BC7696DB 
X-CRM114-Status: GOOD (  19.99  )
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

On Wed, Apr 23, 2025 at 03:21:43PM +0200, Daniel Wagner wrote:
> Note blktests nvme/030 test is likely to fail if the
> 70-nvmf-autoconnect.rules is active. In this case two discovery are
> running in parallel and nvme-cli/libnvme gets out of sync. I don't see a
> problem in blktests, but maybe I am just blind:
> 
> nvme/030 (tr=fc) (ensure the discovery generation counter is updated appropriately) [failed]
>     runtime  1.843s  ...  1.719s
>     --- tests/nvme/030.out      2023-08-30 08:39:08.428409596 +0000
>     +++ /tmp/blktests/nodev_tr_fc/nvme/030.out.bad      2025-04-10 10:56:05.146372112 +0000
>     @@ -1,2 +1,6 @@
>      Running nvme/030
>     +Failed to open ctrl nvme1, errno 11
>     +Failed to open ctrl nvme1, errno 11
>     +failed to get discovery log: Bad file descriptor

It turns out that nvme/030 uncovered a bunch of bugs. First the kernel
returned EAGAIN consistently for a while and could easily reproduce it.
But after updating something it went away. I think the EAGAIN was issued
because in my test setup the udev rule is active and triggers a discover
(creates a discover ctrl) which runs in parallel with the test, also
running a discover. I think EAGAIN was alwasys there but it is hard to
hit.

I've added a workaround to handle EINTR to libnvme but after reading up
on signals, I came to the conclusion, nvme-cli needs to handle EAGAIN
and EINTR. The EINTR case might be entered with Ctrl-C and in this case
we want to terminate the loop. Installing a signal handler in a library
is a no go from my understanding:

  https://github.com/linux-nvme/nvme-cli/pull/2797

After getting this out of the way, I figured out that nvmet-fc is not
able to handle more than on in flight async, and there is a nested
locking issue in nvme-fc.

The tests get more and more reliable, though I thought I saw a KASAN
report but now it's not reproducing. Yeah, everyone loves heisenbugs.

