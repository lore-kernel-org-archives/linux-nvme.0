Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A390C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 20:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/GqvRqe09WZKemmVtClMMW90NU4bWhmAczANIwpqoW0=; b=Wt5zOSZBcVoxCwtRnHPw7xOSgD
	SajPgZm1LaqADSk5utefBgTzyCad4nP1aEzdtcvdPtog+TYZp2ni3Dd1KbgYI2qrH6fqk2JARc7Ed
	RDum4G7Q/7rQH52hYOzTlTpOSfsc1kuUX4DyFBkCTJrPBh6Up27XxG/82Is6VjTwafqgExRtPvG1k
	Har1OZZVOdniD9/Rx+Fr9cOagl4ASzwC/En+ZBpg115kKZAgaKNZC3Q7JhG8OPLjLfa23TXK+Bjsr
	UPgBExkIUmU9qLVcFuB6+v4hKM37oha5ppEmjcIbtWe91nY92Ef327kjyDIkV3nWsai0Prcof+DPN
	wM+ndfWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onQDF-0072yJ-9e; Tue, 25 Oct 2022 20:07:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onQDC-0072xQ-IL
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 20:07:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 24F3561B32;
	Tue, 25 Oct 2022 20:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0601DC433D6;
	Tue, 25 Oct 2022 20:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666728465;
	bh=ld9B+PszrggddBUjPtGJtBm5QTF/Q+vm98994AZ9B1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HGACFCXSDTVFd1Q6kMPAoRaHIGdeu1Q+g7nkOT9mOn8Mtm01OWCzaEO0pw7LXEV8Y
	 UQfsRFqHbtmTMsnjn4M6TzQSLvESFSzYI+G48AAzAdO6Gpl7cwIYJGVtn1kM0tvVAP
	 zCMVpA2lRIPbk8S2ehC+TNvnGYPMnFHT5XslHSzQ8B79nQZ9todN50aPjsXMZPGU3K
	 V3POOxrwQAqeo/jdbZ2QL+64K0m/LpLqaEDKOGa3biuGzz2hrodZBemBnkjFzCqBpJ
	 8qfb8rK4AXML1ftEwTwWdWcYfrHQyvg/uT6i3Pf36Vi/Yw8xkchJxnfoTMxcaS9VSK
	 /JgTIO1We1CVg==
Date: Tue, 25 Oct 2022 14:07:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com
Subject: Re: [PATCH 0/2] Granular CAP_SYS_ADMIN
Message-ID: <Y1hCDkt1dOaM3KIW@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20221020071338epcas5p16d72f5d4d868b889e3a98688bc454a98@epcas5p1.samsung.com>
 <20221020070205.57366-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020070205.57366-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_130746_670879_DE394064 
X-CRM114-Status: GOOD (  11.82  )
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

On Thu, Oct 20, 2022 at 12:32:03PM +0530, Kanchan Joshi wrote:
> #1: Two NS, one with 666 another with 600
> $: ls -l /dev/ng*
> crw-rw-rw- 1 root root 242, 0 Oct 20 12:04 /dev/ng0n1
> crw------- 1 root root 242, 1 Oct 20 12:04 /dev/ng0n2
> 
> #2: this should fail
> $: nvme id-ns /dev/ng0n2
> /dev/ng0n2: Permission denied

This looks good to me. The only additional thought I had was to restrict
the identification's nsid parameter to ones readable to the user because
they could just open /dev/ng0n1 instead and override the nsid with the
'--nampespace-id=2' parameter.

But that doesn't look very straight now that I look at it again.

Reviewed-by: Keith Busch <kbusch@kernel.org>

