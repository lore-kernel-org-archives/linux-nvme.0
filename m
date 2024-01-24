Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73798C48260
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8nHJpxze9i3uCOhGTrGvmXB+FRPyyXp/F8Bkilw7L18=; b=jLvbL0g6v1Gk/goxNnx0lIkgWX
	0Ag72Hl5q32t/zkL52H/98Aw/fW0sL+2Vy+W2Ihdtw2WxIyZMzCFH5SuGEKKklTQ8Xvk3nuy6eRl3
	LZwCLcaBE5CjfXuB0oJMAzzW//QJZP2gsqOEgifACLF4gYX3MbXKjjRgq5nW5m00WEyxmrvbXeIHT
	R234MBdoBQo6nrof5EPZQvXZRQ55D/lqZS1S/3/E4ag3u2zvNFqYavpOmWk6eehPvLRJ86mkS6MNi
	y+Skv4asR0PoFVKHwftOe2I8GLOzpbu2WjDPMLee0zzF7zDp+KONAJZmrjU3h4W2TZneQm067m9I8
	uB/QDJew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rShTb-004bWb-0O;
	Wed, 24 Jan 2024 17:55:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rShTZ-004bVF-1R
	for linux-nvme@bombadil.infradead.org;
	Wed, 24 Jan 2024 17:55:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8nHJpxze9i3uCOhGTrGvmXB+FRPyyXp/F8Bkilw7L18=; b=g4Gbu+QOZjcYDq1GX/CDd67xHQ
	1MS2y9fFaTAAJ6vO8sFRAVyk/JnxX4hhNK3I6E7t0IGS/3oGdUQQc2wVXu7jLTM4KIf7Akg27WWex
	+izhhj1Ds/mX2I0vTtpSsOIaG4EU1c/T4eGoZGcZaJSaP1cPW6I/bESRrkHVZ17kK1sstMEANhNzm
	JgFmlZgjGUTRWuNS4HllcmC5yUs5YnmBV0Om9LJjAN2fS2+9dknKqY7yhnIN0B8JnY3J1RRmw4f2B
	OBae5YKcDNoYlXZs7ihRQgOiTff75Oww/7n+OnE/AGJZFp+JwmhmUCoUwdieCrHNXh8DIuXVWOadO
	VcW8VyQA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rShTW-00000007Lpb-2ECT;
	Wed, 24 Jan 2024 17:55:46 +0000
Date: Wed, 24 Jan 2024 17:55:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Sourav Panda <souravpanda@google.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <ZbFPIidl6dK5cR0W@casper.infradead.org>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
 <b04b65df-b25f-4457-8952-018dd4479651@google.com>
 <Za2lS-jG1s-HCqbx@casper.infradead.org>
 <aa94b8fe-fc08-2838-50b5-d1c98058b1e0@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa94b8fe-fc08-2838-50b5-d1c98058b1e0@linux.com>
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

On Wed, Jan 24, 2024 at 09:51:02AM -0800, Christoph Lameter (Ampere) wrote:
> Can we come up with a design that uses a huge page (or some arbitrary page
> size) and the breaks out portions of the large page? That way potentially
> TLB use can be reduced (multiple sections of a large page use the same TLB)
> and defragmentation occurs because allocs and frees focus on a selection of
> large memory sections.

Could I trouble you to reply in this thread:
https://lore.kernel.org/linux-mm/Za6RXtSE_TSdrRm_@casper.infradead.org/
where I actually outline what I think we should do next.

