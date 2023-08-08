Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00228C001B0
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 08:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1VmL4cnlNgAd9wIWh+n1F88tzINAPC+fI3K+o+7FiWI=; b=X72/o1SCVYN6oKv+N+j4Hx4t8i
	lewPsRJdGM6rGHVvy68gosVyJ05Fx/SU1issdDKxct/SRJpRMVJAmMnu0fSoFaqVfcKq5miipCHGT
	0Pwpi76cisI7x/uO1fgEhyphjY/SYqFHaN+/EiDGEUOnjDYplspHMArFSZ5rwAPIS1TOYXMpMR/Qh
	iXi1Ic7phDs2J6FfnFQLZcTKQr5u2ER91fzsU9CJv1cIlnlzI7E0oR9p5htmmq0Nw6SyybqdhLx8/
	ptMgLO/Q3kGfROAbrIY35LLiq8c3X3UGOBURuSbgm1n75B6ZyOfv2b0/46QvWMT5pXMV35a7arD4Y
	QArseBkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIMi-0024dW-11;
	Tue, 08 Aug 2023 08:46:56 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIMe-0024cb-0G
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 08:46:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B5AD20310;
	Tue,  8 Aug 2023 08:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691484407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VmL4cnlNgAd9wIWh+n1F88tzINAPC+fI3K+o+7FiWI=;
	b=kPmvuDyyKufNdk1d2aK3My5PVf/0qF0yLNCx+l0mgsLS5AkXAVPr6DcUFDdBqKiy2VQB6L
	+CLlHOc0a28PZOaEGGb/4OEFRoO113NDS0BVDDAoY9dqUAMMr5qVx2mNXrWNbRaBYFTXkI
	hq7BENiPoKY+rGn/vqLBMXSCBfSQyhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691484407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VmL4cnlNgAd9wIWh+n1F88tzINAPC+fI3K+o+7FiWI=;
	b=ClDAnv4Er+7VUiVfj723l/hk/ylWWLCSHpwdDaXrQvWmmtVQlAefPBIZRcQp+dabW9EyR4
	4AmUTlQLFoy260Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 718E4139D1;
	Tue,  8 Aug 2023 08:46:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id qDuyG/cA0mQ8BQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 08:46:47 +0000
Date: Tue, 8 Aug 2023 10:46:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
Message-ID: <vxeo2ucxhvdcm2z673keqerkpxay6dgfluuvxawukkbunddzm2@jdkdk7y3a5nu>
References: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
 <CAHj4cs9J7w_QSWMrj0ncufKwT9viS-o7pxmS2Y4FeaWEyPD34Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHj4cs9J7w_QSWMrj0ncufKwT9viS-o7pxmS2Y4FeaWEyPD34Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_014652_276606_E0D1DEFB 
X-CRM114-Status: GOOD (  15.54  )
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

On Fri, Aug 04, 2023 at 06:33:04PM +0800, Yi Zhang wrote:
> On Tue, Aug 1, 2023 at 7:28 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> > After some investigating, I found it was due to the /dev/nvme0n1 node
> > couldn't be created in time which lead to the following fio failing.
> > + nvme connect -t tcp -a 127.0.0.1 -s 4420 -n blktests-subsystem-1
> > --hostnqn=nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > --hostid=0f01fb42-9f7f-4856-b0b3-51e60b8de349 --nr-write-queues=1
> > + ls -l /dev/nvme0 /dev/nvme-fabrics
> > crw-------. 1 root root 234,   0 Aug  1 05:50 /dev/nvme0
> > crw-------. 1 root root  10, 122 Aug  1 05:50 /dev/nvme-fabrics
> > + '[' '!' -b /dev/nvme0n1 ']'
> > + echo '/dev/nvme0n1 node still not created'
> > dmesg:
> > [ 1840.413396] loop0: detected capacity change from 0 to 10485760
> > [ 1840.934379] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [ 1841.018766] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > [ 1846.782615] nvmet: creating nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> > [ 1846.808392] nvme nvme0: creating 33 I/O queues.
> > [ 1846.874298] nvme nvme0: mapped 1/32/0 default/read/poll queues.
> > [ 1846.945334] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> > 127.0.0.1:4420

Not really sure how the blk device registration code works, but this
looks like there something executed not in the same context as the
nvme-cli command and thus we might return to userspace before the device
is fully created. And there is also udev events which are handled by
systemd. If this is the case, we might want to add some generic helper
which waits for the device to pop up before we continue with the test.

