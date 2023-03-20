Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DA0C6FD1D
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 17:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OPZystiWgWZBF/KoGFa99oumfGSejAkBGozWqKbZbDM=; b=zvDPcx/tVlvwaY+4LfsIG/coXg
	Y39fMn0YXcgmwpCa+igIm6nNai20nbjpQ/CWEbbDp+jM9J1zWc4UyF5cbGFiRmuWTT2bQPJP48wzA
	dGMYJO25vhkB/m+skDK3qnwfi5y3bw1TIx2ciOFd3UEoeu+RghOLmtaN/gCT2mBJf9SUCUygBxCSW
	sQ7Cfc9HmDhhWwPdaSX1HGQiwTwqk28IvF8LgiNIqDMCMONiLBkaVc2/bbIylC3QJgfcQRNjghMvz
	Qz4cYhRQAiJiXLBPoyWDb7mgEJxUMUlV2di6pIFfBozICc7dc02CMfiNP3X+rQB0NLLmz/PegIplH
	mQbz1BLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peJSh-00A0D7-2y;
	Mon, 20 Mar 2023 17:38:23 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peJSf-00A0Bq-0U
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 17:38:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 492FB1F385;
	Mon, 20 Mar 2023 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679333897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPZystiWgWZBF/KoGFa99oumfGSejAkBGozWqKbZbDM=;
	b=sc3rsuYx52NObJgLUchXpyMBSxYupS5SvOt20chP42s/Mdamk02SntiIpM4Q/1DFI9kDef
	gUh0x19FiNT5/NSuHUj56HiF/HNZb1Pnm3IPa3mjbGYwp1kA60Oh6/SQsLzhdLO4h5Z+M3
	YXSU9Zlrr08b1daiRv3xU2x+PFhGXOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679333897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPZystiWgWZBF/KoGFa99oumfGSejAkBGozWqKbZbDM=;
	b=CRjtVhESTGEwOO3HKdb89fzD7BINzpsshvHlzq1+4PR2ENd3kR+hSmTnUZTu3Uqdt56Y1b
	+hucbB9dDZJ/l8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3714A13A00;
	Mon, 20 Mar 2023 17:38:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Eh5kDQmaGGSpEQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 20 Mar 2023 17:38:17 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 0/2] Test different queue counts
Date: Mon, 20 Mar 2023 18:38:04 +0100
Message-Id: <20230320173806.12784-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230320152204.g27a6jqbb65xmb6r@carbon.lan>
References: <20230320152204.g27a6jqbb65xmb6r@carbon.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_103821_329857_4E6A3035 
X-CRM114-Status: GOOD (  10.31  )
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

Here is a rough version which tests the different types.

There are a couple problems with this version:

  - works only for fabrics transports and not loop. I haven't figured out how
    to express this in the requires()
  - let's the kernel crash in various ways


Daniel Wagner (2):
  nvme/rc: Parse optional arguments in _nvme_connect_subsys()
  nvme/047: Test different queue counts

 tests/nvme/047     | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/047.out |  2 ++
 tests/nvme/rc      | 46 ++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

-- 
2.40.0


