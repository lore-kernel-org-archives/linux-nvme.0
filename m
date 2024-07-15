Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621F7C3DA4B
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jul 2024 20:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lJ4uGv7BMO/wwzWpJD0pkE1S/OCikEqtzCmNElpwP+4=; b=mWIaFNU1kbjZCT2t+vKtojwkNW
	vc0i61rPRg09jKyjm2fOk8wJNGr690Xn4/mjs2l6xAQpRaJD98N9wvittX9ulSVYHXoGu7cBQ8Rsc
	d5bwc18mCrTb1oTofBnTJNf/qH5UKtfe8c8pZhFJcSFvsagE+79YXdmU/5i3Ugpn0s1na23pi4DD2
	YBtzDO8Sc62g+OknFrRKSLDN9Wz/DjKNNuAPu9hyuZoTGiDXpjLpXWmXzJN43+e5vCQYfXB/vYL84
	mvoV+S0nQm4rjQjx1uuHjMuXRo1jEnJFaEG6GJRudlhXxiKrAe+JO+ovPu49jj2GAyBHBJH4HJfQu
	MOfIQHiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTSf8-00000008Mi5-3LLr;
	Mon, 15 Jul 2024 20:51:10 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTSf4-00000008Mg5-2mVd
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jul 2024 20:51:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 08C9BCE1233;
	Mon, 15 Jul 2024 20:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83F2C32782;
	Mon, 15 Jul 2024 20:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721076664;
	bh=lJ4uGv7BMO/wwzWpJD0pkE1S/OCikEqtzCmNElpwP+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpY2w4ixyhP6bUKULtmGFLxbW69+3IP3psyLIB1AnwF1HykMbSWF66xX/T6Lk6Asx
	 5AOHSNtUo+7WUtZSBLYnTvAc08wAutFpXJCnh7/bqaidwbRo8a6W6oZvUeXAm+kR/2
	 QPLd2AZbAKHmhX4t28wbARuNLpR/ToGVVX8fC9hK0qgg6NzhbAPhm9j1MzAaVhOnDB
	 3Z/U6K5NmiuCYYWA6CGUvnUdx6gU9pE9FmImUOPr3ql85jGkT4Wy0oUmtAiPUHTVcu
	 id6aaw6ve59CQmrd5cMDOFUKZhLvaD8rtgo1OQQbKSknvDk8BJlUccKhsRyWLr9u7u
	 TsqylEZ6IjStA==
Date: Mon, 15 Jul 2024 14:51:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
	Linux-nvme <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: remove redundant bdev local variable
Message-ID: <ZpWLtfCsEIebfAvp@kbusch-mbp.dhcp.thefacebook.com>
References: <1720698053-4076216-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720698053-4076216-1-git-send-email-israelr@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_135106_895317_C85A886A 
X-CRM114-Status: UNSURE (   7.07  )
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

On Thu, Jul 11, 2024 at 02:40:53PM +0300, Israel Rukshin wrote:
> Use disk directly instead of getting it from bdev->bd_disk.

Thanks, applied to nvme-6.11.

