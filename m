Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42C0C001DF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=48Be09y3TO6g+02n2khk+doLwgXVesA8SU4KvUwsYqc=; b=3z6VyoxC5+C2x65u2INr+ZWu9W
	BRrKzFTWN0jMBW2pcXV+y90uj0zJz9aGe5kZ0XJgUS5kVSNBqM1RS4gWxP52i4cHkBu+6vOIjB5GV
	a2TyvyeOP9ihpO+0vXqM446cVBp8ztiboR9DikacKK+ju07xRrYznxfhymIe3qKkrp1zqPIRyor26
	p8HEBFSPQumNGPyRfd2xFNABGkwuyXepA89x5LQgTPzSDRaWNrG63gdNm2l1IwsJN3OjElvM6kTah
	ZL6ZKKFrDka9Udc8zpi0QPSwq+uah+2VDlqJ1dZnKYMrrfT/W7l64yHmbXim54bQhu4BsOHqfnrwj
	2hz0MJ0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTMnK-002eCn-19;
	Tue, 08 Aug 2023 13:30:42 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTMnF-002eBL-2n
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 13:30:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75FAC1F854;
	Tue,  8 Aug 2023 13:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691501434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=48Be09y3TO6g+02n2khk+doLwgXVesA8SU4KvUwsYqc=;
	b=Zr643i/NDRstC6QoEAjRnrZ4iwyKwD96dfBFRaSZG9T4Lhs7sjT6Z8ZXfEVjySdrwVu6IQ
	orlJbKS5Dyl0mpxfSBhXWLYTQFz7dHX+9/nWejUlEMHx/MwmdbHDmoqszp6x+1pd7OoqoW
	Rd+B0d2mj9rHvGe15JGeYf+7H4CW4+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691501434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=48Be09y3TO6g+02n2khk+doLwgXVesA8SU4KvUwsYqc=;
	b=IcGA/oTGOF5SZBGYfjHcaxMsRsE9pAiDvYRUm2TE9iOcP9GZgfjk8e1GvMsODlunfYV8s+
	7mU4x0qbqZ1YKiAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BAAC139D1;
	Tue,  8 Aug 2023 13:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MRYbFnpD0mSnGAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 13:30:34 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH libnvme v4 0/2] Do not pass disable_sqflow if not supported 
Date: Tue,  8 Aug 2023 15:30:26 +0200
Message-ID: <20230808133028.14643-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_063038_052653_EDDD9F56 
X-CRM114-Status: UNSURE (   9.36  )
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

Follow up on the discussion in [1]

[1] https://lore.kernel.org/linux-nvme/676b7c2b-7bcf-6138-0229-389ed9efaa92@grimberg.me/

changes:
v4:
 - updated commit message
 - updated author
v3:
  - do not even try to use disable_sqflow if when it not supported
v2:
  - use cached options table
v1
  - initial verison


Daniel Wagner (2):
  fabrics: Read the supported options lazy
  fabrics: Do not pass disable_sqflow if not supported

 src/nvme/fabrics.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

-- 
2.41.0


