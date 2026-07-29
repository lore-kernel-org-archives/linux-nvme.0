Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFDEC53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+tYT9emIa2uLeZKybxUfqsicxoAA1xQpLD7SiJfK3g=; b=NGTymcRpmSWdc4HaBCW32p2/t5
	GIwLaRuJj1Sif9jtHBqZneVC3r4AAPDOrnUaxVJlXZHPPVzqcEUhOAOYzz1JI7IMKwY7LdOZ9oX0x
	UZMs0D6J5wnkxKslsAGTVAUMM7oFxQDjWHdJqDpy7j5OwwuVo+XRRrzXjT6khKC80K5z2wlT3zLak
	1XP0focxyqYgbc+8TVkbmVpqDOixgbR7MHR1LGSlv61xO+KBmvPO3VgaHNJ1NZpR4FnnNU4A0M2cO
	XXeTf54B3cvEiOOL6dknaRaSoxMU5DXy76I3yHX5u4LSD9gANCfDdwE7fiECWCX2a7leZNBer2SJk
	YZavihFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2X8-00000007jr3-0ExV;
	Wed, 29 Jul 2026 11:33:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2X5-00000007jpH-0KEF
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 11:33:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CFDAB68AFE; Wed, 29 Jul 2026 13:33:03 +0200 (CEST)
Date: Wed, 29 Jul 2026 13:33:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme-pci: return error when parsing a quirk string
 fails
Message-ID: <20260729113303.GC31402@lst.de>
References: <20260729105958.1403095-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729105958.1403095-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_043307_264082_34BA1F82 
X-CRM114-Status: GOOD (  13.19  )
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

On Wed, Jul 29, 2026 at 06:59:58PM +0800, Guixin Liu wrote:
> quirks_param_set() reuses 'err', which param_set_copystring() left as 0,
> as the return value of the whole function. When nvme_parse_quirk_entry()
> fails to parse a field, the code jumps to out_free_qlist and returns that
> stale 0, so a malformed quirks= parameter is silently accepted as valid.
> 
> Set err to -EINVAL before jumping out on a parse failure.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


