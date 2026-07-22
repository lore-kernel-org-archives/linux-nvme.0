Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E432DC44536
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 12:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Bal61HDfAVLX+JP9T4xx4sa2Rq
	lw2C7lXrubMeQQ6nVtynbywftmxxAyUxws4+LD/tsVnF1W1gspgwdIpxCqv27L0EJXz1IVlKqsYCh
	/Uazem1/XiiSlG8YobBn+ysH9M9P5yn8UoOYJDVlEZGo7w/CNKA5S6D6xpuRZZE9F9a/OTBqJaH7M
	XXup8K2aCzznya7L+ao+oxFZo2pedp7m8lXPZuG3gb+xa7tP+e7Cy+KiDTwHnCLd6zWI5rvYX5q88
	MtzZsgReb84y/J5rxRdMAPEsEsb5SNOva96ZT+MKCHn82RLUMMuQNwv69fcT3cODe0hIuqdX2o1Jj
	GbCfGRmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmVsH-0000000BjJe-2Pip;
	Wed, 22 Jul 2026 12:16:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmVsF-0000000BjIb-3VQQ
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 12:16:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B37C68D1F; Wed, 22 Jul 2026 14:16:29 +0200 (CEST)
Date: Wed, 22 Jul 2026 14:16:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 08/20] nvme: add context annotations for
 nvme_ns_head::current_path
Message-ID: <20260722121628.GE12774@lst.de>
References: <20260713115444.465704-1-nilay@linux.ibm.com> <20260713115444.465704-9-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713115444.465704-9-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_051632_026759_C917D0E1 
X-CRM114-Status: UNSURE (   9.51  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

