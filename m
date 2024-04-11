Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F4BCD128A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MBQm6swefZeoP58URWQBqzIo8nlXLjtnPBclsTmq3io=; b=QZLc2PgaUkUQeBeUxWJUOSbONE
	u+boj0PvorETDLfjcwQJYyBYzAL50fhkHBPVR3Q4bzl3m1hn039n3pxYdbmzjpvhHtW0SrNBqjsiZ
	ZzOkMQh3CWmPf0yyyMf3yl75SdT8h6mbikpZ0S5U3vj5reUvf6JVbCdFzWk7qxk8x523NuqjPpwDG
	l7aveyHKILSqPAfub9yGqLayByn+pw5wnKyzUaCyJ2lkx2b2g+Py/fTlEXqqtU8i8M+fZOQ52QjG2
	Fz1yRGyg6X0anvMfI6PYHerqGk6vWIWG9r5VdJYWefb/6ciJ3g0cUiOPTwCVpef7Jcwxpm16MUgrm
	BqWyswow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rus24-0000000Bb0M-10Wq;
	Thu, 11 Apr 2024 10:51:52 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rus1x-0000000Baxl-2TI9
	for linux-nvme@lists.infradead.org;
	Thu, 11 Apr 2024 10:51:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5092F5BF9A;
	Thu, 11 Apr 2024 10:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712832701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=MBQm6swefZeoP58URWQBqzIo8nlXLjtnPBclsTmq3io=;
	b=QMO9wrYJCHm8gkypCzcxxG0F/bVpj5FkhZ5C2YVM5GPNM3T5EPCt1499xz0X8P53CsFjY5
	F9Jb1wtfeLOPqN9m8bdQAtb/uIr/C9FQmtiFj5VNyzEeuCb03V0GARA60dmX4o34mAYEGr
	h3qmmiwtAOY5q4p3TtTahW2YJvPxLI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712832701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=MBQm6swefZeoP58URWQBqzIo8nlXLjtnPBclsTmq3io=;
	b=I8C++2ESITKd/bSI5Rk4b6EXaoSUQ+DgMsnDgIXoTFsHaoGX9ut6wd9uok7ugG36ivwWsP
	68Cbe6r6bu2VpiAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712832701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=MBQm6swefZeoP58URWQBqzIo8nlXLjtnPBclsTmq3io=;
	b=QMO9wrYJCHm8gkypCzcxxG0F/bVpj5FkhZ5C2YVM5GPNM3T5EPCt1499xz0X8P53CsFjY5
	F9Jb1wtfeLOPqN9m8bdQAtb/uIr/C9FQmtiFj5VNyzEeuCb03V0GARA60dmX4o34mAYEGr
	h3qmmiwtAOY5q4p3TtTahW2YJvPxLI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712832701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=MBQm6swefZeoP58URWQBqzIo8nlXLjtnPBclsTmq3io=;
	b=I8C++2ESITKd/bSI5Rk4b6EXaoSUQ+DgMsnDgIXoTFsHaoGX9ut6wd9uok7ugG36ivwWsP
	68Cbe6r6bu2VpiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EA5E13685;
	Thu, 11 Apr 2024 10:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6lqdDb3AF2bpeQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 11 Apr 2024 10:51:41 +0000
Date: Thu, 11 Apr 2024 12:51:40 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: Is idenditfy ctrl cmd supposed to return a 'result' for RDMA? 
Message-ID: <pdazbshqj2kqkhtmdp4m4qtaqexu7bfio2ccampteskuugqmkf@srgzsimaj3bn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.26 / 50.00];
	BAYES_HAM(-2.96)[99.83%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_035146_035864_7C4DC995 
X-CRM114-Status: UNSURE (   9.39  )
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

A bug was reported against nvme-cli that a setup works fine with
nvme-tcp but not with nvme-rdma[1]. The only difference I could spot
from user space PoV, is that RDMA returns 'funky' result values

# nvme id-ctrl /dev/nvme2 -vvv
opcode       : 06
flags        : 00
rsvd1        : 0000
nsid         : 00000000
cdw2         : 00000000
cdw3         : 00000000
data_len     : 00001000
metadata_len : 00000000
addr         : 3762f000
metadata     : 0
cdw10        : 00000001
cdw11        : 00000000
cdw12        : 00000000
cdw13        : 00000000
cdw14        : 00000000
cdw15        : 00000000
timeout_ms   : 00000000
result       : 3f3b0000
err          : 0
latency      : 7076 us

while for the same command, TCP returns 0.

I've tried to figure out where the source these values are

[ 4040.869872] nvmet: nvmet_execute_identify_ctrl:358
[ 4040.874002] nvme_submit_user_cmd:196 ffff88813f3b0000
[ 4040.875759] nvme_user_cmd:326 status 0 result ffff88813f3b0000

but got a bit lost in the RDMA code. So I am not sure, is this supposed to
happen?

[1] https://github.com/linux-nvme/libnvme/issues/807

