Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE9AC48295
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Feb 2024 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Yv89qsijhL8lE7JeRJ9pRE/QquGa9JQWLz2IsajqlBs=; b=VxFCOyLW1QdL0HcbFUKSs/cbDT
	7aN3tXvPMmScafjAr+Xfv4HsYMb1hRy8R5Z3x7nUVm4BQWjn2DUB0tZAYT4qLVwmYMekNFvLYgDXz
	JSK7Sw+5CbZjrt2tqszdnE7lDEq5+yA2pfDK5HjM2s9idnTwT+d1k0QorZrMN6DKacTG5y33CScIN
	TJQaBg2QNzOlH5Cuuiq10l6fAkQe+za/2AkUv9f3ejsPgC3p1R2qPD3bxxF7+SRTg0vV9zufIygUa
	UzOLVlAfVms6wqai1nhbgftnwfe6axGGP42ydfZZY528vnpewp2pzaA7WG4JdS47rO8Rx2QRJcR7m
	z2vNA4zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVwPW-0000000CIrd-490R;
	Fri, 02 Feb 2024 16:29:02 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVwPV-0000000CIrE-2Yk1
	for linux-nvme@bombadil.infradead.org;
	Fri, 02 Feb 2024 16:29:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Yv89qsijhL8lE7JeRJ9pRE/QquGa9JQWLz2IsajqlBs=; b=LupnOBpPM7vOxUoL0szt/IoMn2
	F66A8AOYNKkWiA5U7g6aqHrhkZQpS5bHjROLG3EPb6L3eMYFzEveKlh3osmMmSpsWTYzDrJWsscSU
	WRoqUj0aaThljAVKz6Zodjnx4h6FV0bN7zCia1RxICB3IglElc/83cb5NtDG4SSksdqu+1N/ryFIa
	9NC5aoxlMipUHLI2BH7grBhfY88f/CH0js/1SDCgucWZo0gcD2A1jQXLtsD2yZgARPWzuR+wkqsY7
	D4qsG1S9OYcqW4slm3kn5GW/RJ8z1any9KcewnC7RTupQkpkhHRwA/Tikl6BoYJ6TjXuZJGI+2QtT
	hWeDhWzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVwPS-00000001Wnv-2KCT;
	Fri, 02 Feb 2024 16:28:58 +0000
Date: Fri, 2 Feb 2024 16:28:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Message-ID: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Message-ID: <20240202162858.Ls92Xc_5ujibp6MKKLacpn7ZJoRy5v-IqVIwYhM8BmI@z>

LFrom willy@infradead.org Fri Feb  2 16:28:25 2024
Date: Fri, 2 Feb 2024 16:28:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [resend, PATCH v1 1/1] logic_pio: Use RESOURCE_SIZE_MAX
 definition
References: <20231016132611.1201402-1-andriy.shevchenko@linux.intel.com>
 <Zb0LzpBkE71wWyqO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb0LzpBkE71wWyqO@smile.fi.intel.com>
X-Mutt-References: <Zb0LzpBkE71wWyqO@smile.fi.intel.com>
X-Mutt-Fcc: ~/sent
Status: RO
Content-Length: 237
Lines: 7

On Fri, Feb 02, 2024 at 05:35:42PM +0200, Andy Shevchenko wrote:
> On Mon, Oct 16, 2023 at 04:26:11PM +0300, Andy Shevchenko wrote:
> > Use a predefined limit instead of hardcoding it.
> 
> Can we apply this one?

Why are you asking me?

