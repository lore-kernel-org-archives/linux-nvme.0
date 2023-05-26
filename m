Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD07C7EE23
	for <linux-nvme@archiver.kernel.org>; Fri, 26 May 2023 14:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NU42swyAqnqwn+EcaliV+Ixy4+iiHaXRRMA80sXi3U0=; b=vsuS+rtUyXwaSpHfbInd6AESKG
	OOliS6TlwglJ7tKyJeB2NsOjIBW0rw4pQT2Av5eEC34zXTgPNrjLYWvcAhbAO8CtuUcpwukzWiHhY
	S7bCOHzr9jdVWsUuzBeMy4uppVTuMTFNwWdzOBJtMskFDXYfKuuv3bHS6ulWAXbjb14gQ3f8XIJ9K
	wuM4JxIwc5cKlcSHlikxTJYXfdldbwVjn99G1NEkfaJeimJq43XzNJQxrlMUyZJB1cq4IItnUODnb
	HbaZ9bqqGyztbXJ6wAou5XnsAX4KOdQQ4tnf5DxzNC9yyFUTaBwOBcKdcQKrGALue/n6d5tSdWSwI
	IUb9U1Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2YUC-002nnj-2I;
	Fri, 26 May 2023 14:32:08 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2YU9-002nle-0b
	for linux-nvme@lists.infradead.org;
	Fri, 26 May 2023 14:32:06 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id D759021B04;
	Fri, 26 May 2023 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1685111519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NU42swyAqnqwn+EcaliV+Ixy4+iiHaXRRMA80sXi3U0=;
	b=ZFfAeedUMO01ukB3JafZVmehCqemtJd/ul9L28Heh+r4O4vDgdtRaBxjHnDH6GfZIPfAQs
	39MYj2EOlraCoVQCXwORUnk1XrwCsqw040kEyTZ1cFVUkRXkJORo/qMDTPGl0I5ox6CDjF
	9P/gVclrp1rGtVo4Uyurj8/H+2ZDqU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1685111519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NU42swyAqnqwn+EcaliV+Ixy4+iiHaXRRMA80sXi3U0=;
	b=3rr5Yi72g29HTR7C8raD5kBJh3GZtAhkIKfZ0SSjvMngTKatlBZg3MbmFyXCco6kwpdnxp
	YZaT2ZtnoE9BBoAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B9B9D2C142;
	Fri, 26 May 2023 14:31:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id A6DA851C3F3E; Fri, 26 May 2023 16:31:58 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/3] net/tls: fixes for NVMe-over-TLS
Date: Fri, 26 May 2023 16:31:49 +0200
Message-Id: <20230526143152.53954-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_073205_374754_99430965 
X-CRM114-Status: UNSURE (   9.37  )
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

Hi all,

here are some small fixes to get NVMe-over-TLS up and running.
The first two are just minor modifications to have MSG_EOR handled
for TLS, but the third implements the ->read_sock() callback for tls_sw
and I guess could do with some reviews.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  net/tls: handle MSG_EOR for tls_sw TX flow
  net/tls: handle MSG_EOR for tls_device TX flow
  net/tls: implement ->read_sock()

 net/tls/tls.h        |  2 ++
 net/tls/tls_device.c |  8 ++++-
 net/tls/tls_main.c   |  2 ++
 net/tls/tls_sw.c     | 82 ++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 90 insertions(+), 4 deletions(-)

-- 
2.35.3


