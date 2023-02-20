Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAEDC636D6
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Feb 2023 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RLFvTROSL59TCn2fGhNvjwMQhLQ+CYTi3S1im+iq8+k=; b=WvQoRDkGXRKKXxd5EppnQCvCcu
	ngFbm6IdDwfESKTFYIopkCgJmOtwuo11C90ZrDEMIazuIldTCLAZg2oAETS5QkGUDOFC6r3wjyp28
	kuAzD3ldpix29P/2O+i05tlDRINXbtOIqYrFfPxlg8rBOBHZHaUwza4PDzZoxgsfvFf0iCDHc0bEB
	qzp9ZP3mGZ8u8uX8Y+7/W97iwA5cAHV+wcFAARZwC1b9K2xVoAaFH9Nn1EQxAhH0vqu8k82HOR7QZ
	KjLfyf/GMmEHbBEAPqzyTi9bGITI6LMq3vZ7u/Te+BDKgRYHKXLJiyN7AP0Le3vjUBAgJi3NXTdGR
	ugRi1Xvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUAQp-00599y-5O; Mon, 20 Feb 2023 17:58:31 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUAQl-005996-O3
	for linux-nvme@lists.infradead.org; Mon, 20 Feb 2023 17:58:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 885B522D14
	for <linux-nvme@lists.infradead.org>; Mon, 20 Feb 2023 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1676915905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=RLFvTROSL59TCn2fGhNvjwMQhLQ+CYTi3S1im+iq8+k=;
	b=tqSPSNJoyJJ5HYk6eGEk8xZ1JLUuiiXwoinMRD1dj4qMpjbzSiFa170dz5vShqI04dXsQS
	/f4A+SwvYIDWhdQv9v9BhebXEPqCP+Ay2E7wPOv/yJBCYC43dYI9rn9BL+VEGA4zFIfpZw
	imA+dzjkglSpyplChMt9Ky2R11SZmNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1676915905;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=RLFvTROSL59TCn2fGhNvjwMQhLQ+CYTi3S1im+iq8+k=;
	b=X3iQGmpqbvhJVTAWMia1gNQma0h8H/b2hSlVlVmEYBXMj3GIHfxWpiAiax3H6/5RI/nW9R
	l8X7rsY2CQRXlcBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A783134BA
	for <linux-nvme@lists.infradead.org>; Mon, 20 Feb 2023 17:58:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id qcbYHcG082PIIQAAMHmgww
	(envelope-from <dwagner@suse.de>)
	for <linux-nvme@lists.infradead.org>; Mon, 20 Feb 2023 17:58:25 +0000
Date: Mon, 20 Feb 2023 18:58:24 +0100
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: null-ptr-deref in nvmet_execute_disc_get_log_page
Message-ID: <20230220175824.neotgark4g3fo56o@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230220_095827_947468_1951F0A5 
X-CRM114-Status: UNSURE (   9.01  )
X-CRM114-Notice: Please train this message.
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

FYI, while trying to get the block test running with the fc transport, I was greeted
with a NULL pointer:


 run blktests nvme/012 at 2023-02-20 18:47:35
 nvme nvme0: NVME-FC{0}: connectivity re-established. Attempting reconnect
 loop1: detected capacity change from 0 to 2097152
 nvmet: adding nsid 1 to subsystem blktests-subsystem-1
 nvme nvme0: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
 (NULL device *): {1:0} Association created
 nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:2cd2c43b-a90a-45c1-a8cd-86b33ab273b5.
 nvme nvme0: NVME-FC{0}: controller connect complete
 nvme nvme3: NVME-FC{1}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
 (NULL device *): {1:1} Association created
 nvmet: creating nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:2cd2c43b-a90a-45c1-a8cd-86b33ab273b5.
 nvme nvme3: NVME-FC{1}: controller connect complete
 nvme nvme3: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1"
 XFS (nvme3n1): Mounting V5 Filesystem 956f6501-fcdc-4059-8d9d-1f759e9e0be0
 XFS (nvme3n1): Ending clean mount
 xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
 XFS (nvme3n1): Unmounting Filesystem 956f6501-fcdc-4059-8d9d-1f759e9e0be0
 nvme nvme3: Removing ctrl: NQN "blktests-subsystem-1"
 (NULL device *): {1:1} Association deleted
 (NULL device *): {1:1} Association freed
 (NULL device *): Disconnect LS failed: No Association
 ==================================================================
 BUG: KASAN: null-ptr-deref in nvmet_execute_disc_get_log_page+0x19b/0x5a0 [nvmet]
 Read of size 8 at addr 0000000000000520 by task kworker/2:0/2553

 CPU: 2 PID: 2553 Comm: kworker/2:0 Kdump: loaded Not tainted 6.2.0+ #4 7ac3eece8c11633fa2815efb5a20b1c5b55011f5
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Workqueue: nvmet-wq fcloop_fcp_recv_work [nvme_fcloop]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5a/0x80
  print_report+0x103/0x220
  ? __virt_addr_valid+0x2a/0x170
  ? trace_lock_acquired+0x55/0x130
  ? trace_lock_acquired+0x55/0x130
  ? nvmet_execute_disc_get_log_page+0x19b/0x5a0 [nvmet b6cfd0efddc3f6e687219ea59b5a92b951bb0ddd]


I try to figure out what's happening here but maybe someone has already an idea
what it could be.

