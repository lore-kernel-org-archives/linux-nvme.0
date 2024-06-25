Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D57DC2BBCA
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jun 2024 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8PtmWZFEhdO5oFL3PM6WujyngC0aarxAvSZebgwjOKo=; b=3ND1TwYg3Zyd2o1JxmpxYAxUNn
	dxXAMpa0WEduTRcjN22oUtJ6NSHn9OHlJvp86dZDDfm8p+gzrTz0tUyx3kq96dLUtrnuHeCetJQuA
	A0vu8AXa7TV4V3tNYYovxVXsQ7Cf2jU7sI+DDu5nCHYytNPqswnDV/J7tiVPFiI5ydPyRKbzm8K/E
	NMG11743R+uPCMojoQTTGhD8Z1wGbJk4BkiK7aNwv6ANvhQmHB+VmawCp95y2b1+8k+p8PYlzC27F
	qYKRXZENmK2p2APuzUeqUuR0T/ICUDbCsWpzStSx3j38jEO2KqxpM3NQQ6uweob1j/64+FWlk89DZ
	+wAwB2sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM9At-00000003j6q-18mG;
	Tue, 25 Jun 2024 16:37:43 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM9Aq-00000003j5m-1kQy
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jun 2024 16:37:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 181C1CE1A2C;
	Tue, 25 Jun 2024 16:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D51C32781;
	Tue, 25 Jun 2024 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719333456;
	bh=8PtmWZFEhdO5oFL3PM6WujyngC0aarxAvSZebgwjOKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQfthsjd1lxzW7BWvWz2HsTLM/9w6xXKcOgxhp/N5RlgkiZQOpJe98ArJbS5PNqpN
	 2KmAHkSsRTFt1wyR+hivHTLUUN8fh/mcgWliLI18fdLrq4v6MmEtjK6aEk/kkvlVzo
	 HRKDmO6mizwDOi7Qw/1EOlWirOE/uHQoJIoakMBq8YfTog3rEDWL3F8oizB9bVCUoM
	 2eBf0qN/iRN/xeUrwH+/wsQ27OAt4p7xacJC+hUe/zqHEDyP9CgeqPGsi997zXmEHv
	 omQvuuWqkeFqQYZS/YHeA/Dn/wAqJGgqZVHeY1qsEVb8z+Fo4nBON3TBxIZfWb/O3y
	 LN4XDII3yTMeg==
Date: Tue, 25 Jun 2024 10:37:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, emilne@redhat.com,
	jrani@purestorage.com, randyj@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH v8 0/2] nvme: queue-depth multipath iopolicy
Message-ID: <ZnryTZqwlz61s0D4@kbusch-mbp.dhcp.thefacebook.com>
References: <20240625122605.857462-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625122605.857462-1-jmeneghi@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240625_093740_652363_CBD629B0 
X-CRM114-Status: UNSURE (   8.31  )
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

On Tue, Jun 25, 2024 at 08:26:03AM -0400, John Meneghini wrote:
> Please add this to nvme-6.11.

This looks good to me! I'll give another day for potential
comments/reviews, but I think this okay for 6.11.

