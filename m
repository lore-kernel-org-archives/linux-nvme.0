Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43042C36010
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1nvNH0lrAA/wbLVYemhiHUT+8EPnybSgCsSmZqUqAKI=; b=XWMsCBsFtvlOk7HMYsBAv7WxuZ
	4bscC2WLc3TtqLxJcH0aG4pA+PtszeuWlO5laTDYW8tLH8KIowE1b0mOLnyub/fKRI5Mfk06zhhuc
	+F/HHxy2Z+ssOrSHfcrHs+uIOH7pMT62YWPgQRi1TfYLqbJEmVRN/RacND5HCHtwy6oMPJIaFXrtR
	CROsr9EdcXUJltRgM+OcyRmN0lRJgcp5b+5l6Cc6O6IAejVXV2paXlYwAwxAStHCLFZdtda9NXGRI
	XtaMkawCyTi9vPT608B4jVjHdbivVLvNzMQyFbxA27LDcNMzff6VVPNfl6JshK1Ue/19AgL6F3yjX
	V16RWKDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzdUy-00000003iGZ-0agA;
	Tue, 01 Apr 2025 15:25:56 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzdUv-00000003iFn-3Gn0
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 15:25:55 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 113F12116C;
	Tue,  1 Apr 2025 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743521152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1nvNH0lrAA/wbLVYemhiHUT+8EPnybSgCsSmZqUqAKI=;
	b=MgqnyZlb7ThPnLjzlS8AFBv9IRHAPmKh/UK3B4d85Orj4skn2j9t0CzrwR6AWDEvN4COxH
	u7AHVrkX5Gc3VxEB6vM0C2XfyWOBq0xWr9WVg+65rv7HGzmFStVHJlwZFcGNnrWC1ujixq
	M1ArD0WgOoZYiqtAO40rLJxuSQhP/HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743521152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1nvNH0lrAA/wbLVYemhiHUT+8EPnybSgCsSmZqUqAKI=;
	b=agc9bPHC3rQltaf3IfcmIevOLvtKKb4wHcZKlfD/NgnVUM2WndO770koSrZB9pzQqMLldp
	SfeqYowiZCLC6UAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743521152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1nvNH0lrAA/wbLVYemhiHUT+8EPnybSgCsSmZqUqAKI=;
	b=MgqnyZlb7ThPnLjzlS8AFBv9IRHAPmKh/UK3B4d85Orj4skn2j9t0CzrwR6AWDEvN4COxH
	u7AHVrkX5Gc3VxEB6vM0C2XfyWOBq0xWr9WVg+65rv7HGzmFStVHJlwZFcGNnrWC1ujixq
	M1ArD0WgOoZYiqtAO40rLJxuSQhP/HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743521152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=1nvNH0lrAA/wbLVYemhiHUT+8EPnybSgCsSmZqUqAKI=;
	b=agc9bPHC3rQltaf3IfcmIevOLvtKKb4wHcZKlfD/NgnVUM2WndO770koSrZB9pzQqMLldp
	SfeqYowiZCLC6UAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF09913691;
	Tue,  1 Apr 2025 15:25:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pskwOX8F7GdneQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 01 Apr 2025 15:25:51 +0000
Date: Tue, 1 Apr 2025 17:25:51 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: bluca@debian.org, Caleb Sander Mateos <csander@purestorage.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: nvme-cli connect regression
Message-ID: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_082553_976876_D68AA6AB 
X-CRM114-Status: UNSURE (   9.15  )
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

Hi,

Luca reported that "occasional failures in the systemd integration test
that uses nvme-cli:" [1]

[   10.378713] TEST-84-STORAGETM.sh[316]: + nvme connect-all -t tcp -a 127.0.0.1 -s 16858 --hostid=95fe8041-3f53-415b-bc40-1bbd8932e7e8
[   10.397892] nvme_tcp: queue 0: failed to receive icresp, error -4
[   10.397326] TEST-84-STORAGETM.sh[340]: failed to add controller, error failed to write to nvme-fabrics device

I was not able to identify any changes in nvme-cli v2.12 which could
explain this problem. The kernel in question is a stable kernel (6.13.7)
which got following commit back ported:

578539e09690 ("nvme-tcp: fix connect failure on receiving partial ICResp
PDU").

The change itself looks okay but I think introduces a behavior change
for the initial connect attempt.

The error code is EINTR, should the kernel retry here, or is userland in
charge to retry? Assuming we should retry... Thoughts?

Thanks,
Daniel

[1] https://github.com/linux-nvme/nvme-cli/issues/2760

