Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75B2C001E0
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AF0HqJKtq785OAd4GOPrkFjQegeTnPgjinGxD+qGhgU=; b=LH5xXSBkhyEKxax3LDnstVRwId
	o8CisTFqe+jLrqm3ZT7IZRGAidYwKqX9PlspUiKHZkFO1q4aWczZnVG7Bxk1GHqX6jbP5bOp80+lD
	XEtcVmT5ZTlBLs4EMQ1EigCpDwTbiqHH6rAJ8uVsVUD4oeXpjcBD78/mP5XPFjNTTCdSBw7c7s53+
	xPD5KoTvqbPTuGCu5P+ntQsbe8gO38VOb7YBbaAZDKeAqr8gHcknbpQVtHmBYD0IDlvesBbcyGHMr
	0QKvX6tLs63+RK4TXMhmtQ6v0L86J1quzxiuJnszo+FUyFGnT2QRTvW4psH3LEorPWE9PpaEzbxld
	4euIoxUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTmOA-005RFs-1O;
	Wed, 09 Aug 2023 16:50:26 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTmO7-005RE3-27
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 16:50:25 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78A861F390;
	Wed,  9 Aug 2023 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691599816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AF0HqJKtq785OAd4GOPrkFjQegeTnPgjinGxD+qGhgU=;
	b=Mt7opTm3TNW2tVA/MCh75LxQ1X2CTjtKBHJYyK58Xgxtcrjzckx+k0vSB50UUnjdTP7sxz
	1s8j4+kfJ/Dl3yH69VyqyPOtURjfryebE4HTRZ5XDzxd51DnqN3W0VhW+2qn/grgjZLgUG
	gV1KMdmYz4CqqGXbXgLHYwgXceN/YZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691599816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AF0HqJKtq785OAd4GOPrkFjQegeTnPgjinGxD+qGhgU=;
	b=dTCzO7IiZtqTaoztLGK5HCLF7NjFMfxwwY6Dc9R5SO8UxO1oRjCsrzL0dOS377ipjiDFyU
	F/SYu5obqKie4rCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A8CF133B5;
	Wed,  9 Aug 2023 16:50:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id BJ4AGsjD02Q4bgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 09 Aug 2023 16:50:16 +0000
Date: Wed, 9 Aug 2023 18:50:17 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
Message-ID: <xrqutkdhz7v6axohfxipv4or7k4jhoa57semwcxde7gletk76z@5kcashfdezhk>
References: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
 <CAHj4cs9J7w_QSWMrj0ncufKwT9viS-o7pxmS2Y4FeaWEyPD34Q@mail.gmail.com>
 <vxeo2ucxhvdcm2z673keqerkpxay6dgfluuvxawukkbunddzm2@jdkdk7y3a5nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vxeo2ucxhvdcm2z673keqerkpxay6dgfluuvxawukkbunddzm2@jdkdk7y3a5nu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_095023_840917_972913AB 
X-CRM114-Status: GOOD (  22.00  )
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

On Tue, Aug 08, 2023 at 10:46:46AM +0200, Daniel Wagner wrote:
> On Fri, Aug 04, 2023 at 06:33:04PM +0800, Yi Zhang wrote:
> > On Tue, Aug 1, 2023 at 7:28 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> > > After some investigating, I found it was due to the /dev/nvme0n1 node
> > > couldn't be created in time which lead to the following fio failing.
> > > + nvme connect -t tcp -a 127.0.0.1 -s 4420 -n blktests-subsystem-1
> > > --hostnqn=nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > > --hostid=0f01fb42-9f7f-4856-b0b3-51e60b8de349 --nr-write-queues=1
> > > + ls -l /dev/nvme0 /dev/nvme-fabrics
> > > crw-------. 1 root root 234,   0 Aug  1 05:50 /dev/nvme0
> > > crw-------. 1 root root  10, 122 Aug  1 05:50 /dev/nvme-fabrics
> > > + '[' '!' -b /dev/nvme0n1 ']'
> > > + echo '/dev/nvme0n1 node still not created'
> > > dmesg:
> > > [ 1840.413396] loop0: detected capacity change from 0 to 10485760
> > > [ 1840.934379] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > > [ 1841.018766] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > > [ 1846.782615] nvmet: creating nvm controller 1 for subsystem
> > > blktests-subsystem-1 for NQN
> > > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> > > [ 1846.808392] nvme nvme0: creating 33 I/O queues.
> > > [ 1846.874298] nvme nvme0: mapped 1/32/0 default/read/poll queues.
> > > [ 1846.945334] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> > > 127.0.0.1:4420
> 
> Not really sure how the blk device registration code works, but this
> looks like there something executed not in the same context as the
> nvme-cli command and thus we might return to userspace before the device
> is fully created. And there is also udev events which are handled by
> systemd. If this is the case, we might want to add some generic helper
> which waits for the device to pop up before we continue with the test.

After looking a bit at nvme/010 I see why does tests are not failing
in the same way as nvme/047. After connecting _find_nvme_dev is used
to wait for the device to appear:

+ nvme connect -t tcp -n blktests-subsystem-1 -a 127.0.0.1 -s 4420 --hostnqn=nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 --hostid=0f01fb42-9f7f-4856-b0b3-51e60b8de349
++ _find_nvme_dev blktests-subsystem-1
++ local subsys=blktests-subsystem-1
++ local subsysnqn
++ local dev
++ for dev in /sys/class/nvme/nvme*
++ '[' -e /sys/class/nvme/nvme0 ']'
+++ basename /sys/class/nvme/nvme0
++ dev=nvme0
+++ cat /sys/class/nvme/nvme0/subsysnqn
++ subsysnqn=nqn.2019-08.org.qemu:nvme-0
++ [[ nqn.2019-08.org.qemu:nvme-0 == \b\l\k\t\e\s\t\s\-\s\u\b\s\y\s\t\e\m\-\1 ]]
++ for dev in /sys/class/nvme/nvme*
++ '[' -e /sys/class/nvme/nvme1 ']'
+++ basename /sys/class/nvme/nvme1
++ dev=nvme1
+++ cat /sys/class/nvme/nvme1/subsysnqn
++ subsysnqn=blktests-subsystem-1
++ [[ blktests-subsystem-1 == \b\l\k\t\e\s\t\s\-\s\u\b\s\y\s\t\e\m\-\1 ]]
++ echo nvme1
++ (( i = 0 ))
++ (( i < 10 ))
++ [[ -e /sys/block/nvme1/uuid ]]
++ sleep .1
++ (( i++ ))
++ (( i < 10 ))
++ [[ -e /sys/block/nvme1/uuid ]]
++ sleep .1
++ (( i++ ))
++ (( i < 10 ))
++ [[ -e /sys/block/nvme1/uuid ]]
++ sleep .1
++ (( i++ ))
++ (( i < 10 ))
++ [[ -e /sys/block/nvme1/uuid ]]
++ sleep .1
++ (( i++ ))
++ (( i < 10 ))
++ [[ -e /sys/block/nvme1/uuid ]]
++ sleep .1
++ (( i++ ))
++ (( i < 10 ))
++ [[ -e /sys/block/nvme1/uuid ]]
++ sleep .1
++ (( i++ ))
++ (( i < 10 ))
++ [[ -e /sys/block/nvme1/uuid ]]
++ sleep .1
++ (( i++ ))
++ (( i < 10 ))
++ [[ -e /sys/block/nvme1/uuid ]]
++ sleep .1
++ (( i++ ))
++ (( i < 10 ))
++ [[ -e /sys/block/nvme1/uuid ]]
++ sleep .1
++ (( i++ ))
++ (( i < 10 ))
++ [[ -e /sys/block/nvme1/uuid ]]
++ sleep .1
++ (( i++ ))
++ (( i < 10 ))
+ nvmedev=nvme1
+ cat /sys/block/nvme1n1/uuid
91fdba0d-f87b-4c25-b80f-db7be1418b9e
+ cat /sys/block/nvme1n1/wwid
uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e

We should propably do the same for all tests.

