Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D61C5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 09:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XcFMZ+BWgHEUVydJExrm0h0WA34AeksN3ptVPV0nieQ=; b=auC5rloJG9URHXaiANKjVROGyH
	J+EMamSA4UK9XGcX7zFtq6jB1yLz+suyBAvSMCXh62mwZKR3tROcd6V6SkVeBOFJgcnJdOqwdgSzx
	m+xIUz/eRQPxciI78tr3DsI+aDznjFHH/qIWluWPJ/zapXgP9aXaOsjprLDWDcpx5zuEHQMmmUrmt
	ZkTJtlLGJ2Y7lIm/PxAWguk6iICTnSrB4FOeBCujZL4IvzsYd29XOzRoFIXl6Vht1We1vLdjHgMAP
	v8TudGaxr1oJSBLxmhwbdp/MmM3YW6kUGiFaqY/foliVz4/lbOsBEsrB5l7Q/xy8OpE1rvPzrE+84
	BUlmhYMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfzVM-0000000HEVE-03X7;
	Fri, 01 Mar 2024 09:48:36 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfzVE-0000000HESf-0R4E
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 09:48:31 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DA4A20088;
	Fri,  1 Mar 2024 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709286504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XcFMZ+BWgHEUVydJExrm0h0WA34AeksN3ptVPV0nieQ=;
	b=DUi/RqvlY429nH937HuLA4M2yjb72vaey6B4gJ2y4UH4+Nd6NRcUAjj61mb1qwV1OTN3bn
	JGrLm8gks9wWxbRrdvVNCrdnV4W7t2IlhbxLw3NNPr3Zz2mDylevAP0C7ck3k34YUuciAq
	4l7nwVsbvFt0wTvWZmlGHDvoapknAU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709286504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XcFMZ+BWgHEUVydJExrm0h0WA34AeksN3ptVPV0nieQ=;
	b=26DJCdQl8zLe5iZp6yvlppnRtpERerTsMSH71nqUwh39Vemi1XT66Rj5v4Zh3l/Y8QnrRI
	1PXkFjKNnGD1GbDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709286504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XcFMZ+BWgHEUVydJExrm0h0WA34AeksN3ptVPV0nieQ=;
	b=DUi/RqvlY429nH937HuLA4M2yjb72vaey6B4gJ2y4UH4+Nd6NRcUAjj61mb1qwV1OTN3bn
	JGrLm8gks9wWxbRrdvVNCrdnV4W7t2IlhbxLw3NNPr3Zz2mDylevAP0C7ck3k34YUuciAq
	4l7nwVsbvFt0wTvWZmlGHDvoapknAU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709286504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XcFMZ+BWgHEUVydJExrm0h0WA34AeksN3ptVPV0nieQ=;
	b=26DJCdQl8zLe5iZp6yvlppnRtpERerTsMSH71nqUwh39Vemi1XT66Rj5v4Zh3l/Y8QnrRI
	1PXkFjKNnGD1GbDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B93513581;
	Fri,  1 Mar 2024 09:48:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kJDPGGik4WXlGQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 01 Mar 2024 09:48:24 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests 0/2] make nvme/048 checks more robust
Date: Fri,  1 Mar 2024 10:48:15 +0100
Message-ID: <20240301094817.29491-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="DUi/Rqvl";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=26DJCdQl
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.88 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.990];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.61)[92.51%]
X-Rspamd-Queue-Id: 7DA4A20088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_014828_322577_3780A058 
X-CRM114-Status: UNSURE (   7.20  )
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

The nvme/048 tests fails with the fc transport because the check logic is racing
with the reset code in the target. By making the checks a bit more robust in
blktests, this test passes for all transports.

Daniel Wagner (2):
  nvme/048: remove unused argument for set_qid_max
  nvme/048: make queue count check retry-able

 tests/nvme/048 | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

-- 
2.43.2


