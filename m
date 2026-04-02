Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEB7CC6B00
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2026 06:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jrD1iuF+GNNFEO5AvARb8A0vXs10PJBYxgbJT8WFa6o=; b=BRPFtR3dg3twU9mkoP5cN/NGyb
	CxhSlrD5kKFgaWwn0ZDGQz7HK9zTjeJrLKLM2tkqAU29bHohG6HugU/uh0U0PmROTW2nDVsnFA22t
	rUKMhYUsKZ4CJxP4+5ka+Q8HVCjCGGhOBRQZOU7Z3nXN5975BQeR3bsQNFJxXyzXZf0vdjKOaeUkQ
	uLt7WwE0JOvHTrQteqD5zFNRW27nGEz7CXcHS+Lr8y+34UNMYGqLv/0Anxj+k6hlwwp7hJFzdiaQv
	rvlvyYfVF2O6MtpGfje1LH1ivDz2HuA5he3q/mCuFye2ukUWzVsBEfvTLbyQ6Zw989+cfY47Gx5bT
	fqyKO7OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Blk-0000000GvLK-283l;
	Thu, 02 Apr 2026 06:43:08 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Blh-0000000GvJX-2Flb
	for linux-nvme@lists.infradead.org;
	Thu, 02 Apr 2026 06:43:07 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6031EE3248;
	Thu,  2 Apr 2026 08:42:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1775112182; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=jrD1iuF+GNNFEO5AvARb8A0vXs10PJBYxgbJT8WFa6o=;
	b=jbZqwdkqveAr6vV7TnNP3eoWxRa7pYTwbff6Ghx7yiUKG9T3rnphi9VYpjyTjc+jSvqZZ3
	1wcNBaYtOjCmhX38dMqDWAVwNYict2CyubLf48f4NqCiu324Fl3woDbpxGtpYCxJjmR7Nl
	xtFc1SgXJDTo7ZrPSlg2DFtJ56rodualuIVcMht4G6x8YnuX7F/HoA8dUDEdR32NSX/HK3
	OcjzFOkGoVOQ55ss6N58TCM+JP5+hx2Ny9vTKRjsYJrezSgdG4KMsMAiEldrJ/VwnBXAJo
	lzqiH7YP7VB/N18FofS7Qg33C987WOLJXOTTqR8dnB+RLGxVe23O3S6lOKOiZw==
Date: Thu, 2 Apr 2026 08:42:57 +0200
From: Daniel Wagner <wagi@monom.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: expose TLS mode
Message-ID: <ac373146-cf2d-47e0-a851-9c304bacd5f2@nitrogen.local>
References: <20260401-expose-tls-mode-v1-1-433a83d1d23f@kernel.org>
 <20260401140934.GD21703@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401140934.GD21703@lst.de>
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_234305_840110_F7FD4F93 
X-CRM114-Status: UNSURE (   7.25  )
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

On Wed, Apr 01, 2026 at 04:09:34PM +0200, Christoph Hellwig wrote:
> Looks fine to me with the example fixed.

BTW, do you think an empty string is better instead of "none" when TLS
is off? 

