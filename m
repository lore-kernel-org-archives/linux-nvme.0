Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61699C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 12:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=29gyw0zTpPKhvETDNLiVqLaond7YgjQA6HAkDuYiOGQ=; b=vmN060qGj281Ztajto8dyVS9eH
	b7UEOuQQkNS4Y3BVWGd1wKW8xOTuuRlbXKrdRU5KkAzji3oaDA3WInz6CpndVsQU/UUXSy9TRpvX3
	sCwa+kimaVbTuOCEdmUWe+cim6EYrWfc6rIU9yge9BYVl7CRtpbpDMx95fvbmFOU0Fb7tvy+of92G
	vLPjNxO2SNCm8msmkXeyT+z4+1fn9M00HZvnFnPfn7oO3qUvnaJhQtqhsFoLEWohYXVm4lpWv6cnH
	aouzKTt8LZXlhpRFBsiznPWejdxwEiHe4kp/TvDoAgc3G9GuVY8AkJYW127berWGUsQKrXN0kc6+s
	Wq6mjpsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBOj-0000000Ec0y-0Mcx;
	Mon, 29 Jun 2026 12:47:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBOg-0000000EbzN-2jKf
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 12:47:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E14CD68C7B; Mon, 29 Jun 2026 14:47:31 +0200 (CEST)
Date: Mon, 29 Jun 2026 14:47:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, elver@google.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 09/17] nvme: add Clang context annotations for
 nvme_subsystems_lock
Message-ID: <20260629124730.GC23417@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-10-nilay@linux.ibm.com> <20260626064528.GI10731@lst.de> <7c841336-72a4-4072-ab26-5f6356f228c9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c841336-72a4-4072-ab26-5f6356f228c9@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_054734_835723_B79D2E0A 
X-CRM114-Status: GOOD (  10.94  )
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

On Fri, Jun 26, 2026 at 08:18:55PM +0530, Nilay Shroff wrote:
> Maybe INIT_LIST_HEAD_UNSAFE() helper as I suggested in the earlier
> message ?

If we have that, yes.

> BTW, I think these helpers should be added in include/linux/list.h so
> it will be helpful in general for other kernel code as well.

Absolutelty!


