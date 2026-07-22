Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B366C44536
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 12:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2iVuoV+fUrf8UdhSr5mk5wJx14xeOoFK+KBBxDM6e4A=; b=4Rfu0OQefHaY984rJL1Xuj7ZLJ
	Caikkiwc70JI1tFb6KlCHfn2j/DiaY3b5tMfbtSRPTXR7Ddk9cbyNI0xQ07EP12C6rpJw2J35l8u0
	c0WmZDBWb6LqQIm5LUoy2Xh/knivyFUjVDM0YZ/zcw8P+A+IsZuZO5lSMPMmNc8Qg2K/7p6BvY+LT
	65fXcM/RMvA3uiy+LgL6PiyQtuSdp1FeDRW1oL7J+jvpqhZElbcHhkYiSDZr6XK5EXWNu/ItVAro6
	16LQn1blJZIO58dzoD6zWhKuBZ5cMJceKIVNojBSs3cRyzH3xaPZwpKm6uDDRXiV/8crouV7pUx7Y
	Gi5fhPMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmVtX-0000000Bjhj-0FLD;
	Wed, 22 Jul 2026 12:17:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmVtU-0000000Bjga-08S7
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 12:17:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 730D268D1F; Wed, 22 Jul 2026 14:17:45 +0200 (CEST)
Date: Wed, 22 Jul 2026 14:17:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v4 11/20] nvme: add context annotations for
 nvme_subsystem::lock
Message-ID: <20260722121744.GG12774@lst.de>
References: <20260713115444.465704-1-nilay@linux.ibm.com> <20260713115444.465704-12-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713115444.465704-12-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_051748_216136_A1663D82 
X-CRM114-Status: UNSURE (   9.45  )
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

Still no fan of any of these broken ways of dealing with the lock
initializations, but we'll need to get the series going somehow,
so:

Signed-off-by: Christoph Hellwig <hch@lst.de>

