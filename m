Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35CAC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 08:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p1s5jMDrUBxZBZWTGeFE0HAki3ixSROArH88l+ErhWQ=; b=AMNNngVf7+ybDKXLe1H2vRyV0g
	VEOxLPs+Ozj/oywF5kyDTvu7POy/I5phgxDXiUUwrlRyHfJM1w1Um0KCmsDxxyfVTAE8Fv0Zs/wJc
	LmG1thLXIu4FwPR+lkMR2kKXzFDcOivMfRW28V7jCeb+UcB8vIxDrxWUqjvHzTqISMThxr5rslCpG
	32enVRbbZEiIB8XBSi0xD6HNkUBNn51TaQ4J2+ldbtZi24nSYB1muROhIeklfo4pLkK0R+cvyvO79
	jVFItmrx02WVpB5cZonCiHK0QWa/xWmj59a2HZLR4m187T3wXLWxfa/8evU7BipoHnCS8X5afDAcj
	rnanaq/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp3U2-004dcd-0z;
	Wed, 19 Apr 2023 08:48:10 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp3Ty-004dZh-2Z
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 08:48:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E6E752193C;
	Wed, 19 Apr 2023 08:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681894081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=p1s5jMDrUBxZBZWTGeFE0HAki3ixSROArH88l+ErhWQ=;
	b=lZzuFhPiUoGy/vSbK76tTDOCZMiJnkr7I0qcrjCNKrXyhkiibQ1QLTw98PNuD00YABQuqs
	ZFPYTdmmzDHttjckDGbqHWDgbmyuuSSGGAmnuG5oIPTezou1zWb5/x8ojZCOysTxvQMjLZ
	fsiYzRbXhUF/EEruw2UeMukvxk1fj4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681894081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=p1s5jMDrUBxZBZWTGeFE0HAki3ixSROArH88l+ErhWQ=;
	b=utW/gvW2BNoWXYLubrP/Yy7rWTOR5SkGkMjk3RtjlAsI2frWzssb8EjbRaLmCpmFG0VaDv
	QphJLNKY8zuO3rAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D89FA1390E;
	Wed, 19 Apr 2023 08:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id tjrTNMGqP2SydQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 08:48:01 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 0/2] nvme_trtype=fc fixes
Date: Wed, 19 Apr 2023 10:47:55 +0200
Message-Id: <20230419084757.24846-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_014806_980919_A641D0F7 
X-CRM114-Status: UNSURE (   9.10  )
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

With the attempt to get the fc transport running for blktest I found a couple of
issues in the current cleanup code path for fc. With these fixes and the kernel
patches and configuration from

  https://lore.kernel.org/linux-nvme/20230418130159.11075-1-dwagner@suse.de/

it starts to work nicely, incl finding some bugs in fc I think.

Daniel Wagner (2):
  nvme-rc: Cleanup fc ports in reverse order
  nvme-rc: Cleanup fc resource before module unloading

 tests/nvme/rc | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.40.0


