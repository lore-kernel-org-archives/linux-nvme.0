Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20948C44503
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 06:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6lC1UMnG4ghZqCTVpfrQ6PkiQAfN0oYhtylV80D33D8=; b=gkjs6XXNH1cD10sYuo3VGuysQX
	owP2kkeCmBx672QZuUWUY3dT/z7nQdVQGPnE34rUou2cjyzr4ISfWqz2Y6jOjjHubbyHf1AUFSdwk
	iGMv53ipuCtVUQcYhAWljQP8PEfLFgPqHIw+W1Bn5ORW8ivN11MmHvherZ2Jnxojv35iJjRAibmgp
	/w5eX4H1MuCmjcVFNRVPGSsc9dJcaLbDKIk0QCpasoh9hzWeuDlcu+iAfvP5vHeEDOy+OdFeMcM3f
	lRn0U2OpMS+lii5+hDY4UUpbswreUvGzZUlXt7eDly+dGbNZHy2BT6Qh2Hybv8gEl6KO+mBvd4VCS
	1FhlWb3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiHC-00000001AUM-1fWN;
	Thu, 09 Jul 2026 06:30:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiHA-00000001ATJ-067I
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 06:30:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F4E068BFE; Thu,  9 Jul 2026 08:30:21 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:30:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v3 14/18] list: Permit context-unguarded access with
 list_empty_careful()
Message-ID: <20260709063020.GC18056@lst.de>
References: <20260706141452.3008233-1-nilay@linux.ibm.com> <20260706141452.3008233-15-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706141452.3008233-15-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_233024_213191_7F80FC07 
X-CRM114-Status: GOOD (  12.38  )
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

On Mon, Jul 06, 2026 at 07:44:16PM +0530, Nilay Shroff wrote:
> From: Marco Elver <elver@google.com>
> 
> With Context Analysis (viz. Clang's Thread Safety Analysis), list_heads
> that are __guarded_by(..) require holding the appropriate context lock
> when accessing and manipulating them via the list API. Because Clang's
> warning diagnostics do not perform inter-procedural analysis, this is
> enforced by Clang with -Wthread-safety-pointer in the caller at the call
> boundary; a warning is produced when passing a pointer to a guarded
> variable without holding the appropriate context locks:

Same thing here, maybe try to get this to Linus late in the current
window as it's trivial and makes dependency management much easier.

If that doesn't work, move it to the front of the series.


