Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286C8EB64D8
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jun 2023 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vWIDDbn9JWbjBlzAwpy4GLqrJVgb2pbwwADT0+IZSY4=; b=NyLa2Rw3AVAJaxjV9T48OBF7tN
	58BzOvcSVeLPi9SSzTgii/ZAwyAT23g7DTInj/3B8NrqZ/M0X1+W5UM8sLtdmv+VepVAifKrhOBLx
	c613QLGio3i7xlCpui6CtQdB1MbhGR+5yRNXOn1PGrCvD13pu2TcF2lkFvQLBTRy9bmcZkjp2i/fF
	xvorMBQqgV+IgHTY5pakE51GAa4v+heD8/CS/uJ/hdHcNRzpZUwGTymL6Wm6vTmJSFdlHIp+JcAdy
	t2mOntAIxm5/fkyfdKtiuf7ms6tqNgJ9wfx5IfUSrhdc6QfW0UJOmFOQgr07udVgFvXbyhdBFRYNx
	5IBt0xUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qA5VO-00HQVd-1s;
	Fri, 16 Jun 2023 09:12:30 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qA5VM-00HQVD-0H
	for linux-nvme@lists.infradead.org;
	Fri, 16 Jun 2023 09:12:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65AD71FDEB;
	Fri, 16 Jun 2023 09:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686906744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=vWIDDbn9JWbjBlzAwpy4GLqrJVgb2pbwwADT0+IZSY4=;
	b=RvG0Dp4hDkAxbKK+KLXxUNxfqEfObEsqa81qsnbW4zCQ+Vdu1+6ezA0xK3e+794kf2Mj2J
	mTLr78jDogyw4yotbnVeOjDB8Ym3Ky5t10jRlHpb1p++QcHlci8eHJvjckQc2g+5vLCzbs
	Ict6YcOopZNEb+g1vzpaZpasNAAqfP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686906744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=vWIDDbn9JWbjBlzAwpy4GLqrJVgb2pbwwADT0+IZSY4=;
	b=Xj94gfjAsfPEicxkxjvTZWAByoiyt4G3j9ny6VpdVxuihgAsehUg36zIU6+VtQEInsLI1z
	7PAF+GNaMnRl20CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56DA0138E8;
	Fri, 16 Jun 2023 09:12:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id eEPsFHgnjGQ8RAAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 16 Jun 2023 09:12:24 +0000
Date: Fri, 16 Jun 2023 11:12:23 +0200
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <jsmart2021@gmail.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
	Hannes Reinecke <hare@suse.de>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: nvme-fc vs nvme-tcp: Initial connect behavior
Message-ID: <j4w7724skjsapgtp6wtll5fgsb4adhpfdtrif52lhc7iql4inf@3mu2gbjrrtcs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_021228_298735_851CE6AA 
X-CRM114-Status: GOOD (  12.13  )
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

Hi,

blktests' nvme/041 fails for the fc transport because it behaves differently for
the initial connect. While tcp/rdma do the initial call directly in the context
of write to the /dev/nvme-fabrics file, fc does defer it to a workqueue (for
retries).

The nvme/041 test case first tries to setup an authenticated connect with an
invalid key, thus it is expected to fail. For tcp/rdma the invalid key is
reported back to userspace and all allocated resources are freed.

Though for fc, it will defer the connect and even retries with the invalid key.

The test is then trying to cleanup the invalid configuration by issuing a 'nvme
disconnect' but this fails too.

Aftrer this the test is trying to setup a connection with the correct key, but
this fails for fc because there is already a connetion attempt (the real reason
why the test will fail)

   run blktests nvme/041 at 2023-06-15 14:19:06
   nvmet: adding nsid 1 to subsystem blktests-subsystem-1
   nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
   (NULL device *): {0:0} Association created
   [10505] nvmet: ctrl 1 start keep-alive timer for 5 secs
   [10505] nvmet: check nqn.2014-08.org.nvmexpress:uuid:40931c1f-4bf3-4c23-b1af-deb3f65a73e0
   [10505] nvmet: nvmet_setup_dhgroup: ctrl 1 selecting dhgroup 0
   [10505] nvmet: nvmet_setup_auth: using hash none key d4 8b f7 36 75 34 db 1a a2 c5 75 9a 6b 05 de 3a 9e e8 68 61 c5 d6 cb 0b 1a f2 c4 f8 3b 24 a2 a5
   nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:40931c1f-4bf3-4c23-b1af-deb3f65a73e0 with DH-HMAC-CHAP.
   nvme nvme2: qid 0: no key
   nvme nvme2: qid 0: authentication setup failed
   nvme nvme2: NVME-FC{0}: reset: Reconnect attempt failed (401)
   nvme nvme2: NVME-FC{0}: Reconnect attempt in 2 seconds
   nvme nvme2: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1"
   [10505] nvmet: ctrl 1 stop keep-alive
   (NULL device *): {0:0} Association deleted
   (NULL device *): {0:0} Association freed
   (NULL device *): Disconnect LS failed: No Association
   nvme nvme2: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
   nvme nvme2: NVME-FC{0}: transport unloading: deleting ctrl
   nvme_fc: nvme_fc_exit_module: waiting for ctlr deletes
   nvme nvme2: Removing ctrl: NQN "blktests-subsystem-1"
   nvme_fc: nvme_fc_exit_module: ctrl deletes complete


I tickered a bit around to make the initial connect synchronous to see if I
could get the test case working. But got hit by a KASAN report in
nvmf_dev_show() but haven't figured out what's going on yet.

My question is what are we going to do about it? 4c984154efa1 ("nvme-fc: change
controllers first connect to use reconnect path") eleborates why it was changed
to do use workqueues and I suppose these reason still exists.

Thanks,
Daniel

