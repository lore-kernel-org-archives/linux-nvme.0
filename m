Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9D8C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QLwDJBwJUyurwdA1KQeq9Y4vMNeTVG8BJ1Hj5GtG0FY=; b=NA7QsE4+XyhCOqvJV42GeDytKP
	CSLVudxyXzEck/a/FW1Ekzmz/n+/IuwBUSvuaCKBTxhzh2FJX/m3HvhcicZ51k78cz6mrgahjOGtn
	bxtp26XJ6jQPQYMZSOit3v5g1guv0fv0jV/WU41V3Dsp42uR4FDBruGjW0xLdIy5qv9mLe0rybH1s
	MiKduu0KyfOSlqKpilD5tjkf+TuwJD0vbHpGElaZySMrElRPeamDB9jXsMi4YT+9O0OQ/YSpUWVge
	V/AZVNsdysDCgDHtNvT8vRZEIt6Q06bwYzZbnDeFbW/kHOzZ/VaKs/vouLvk8nxKMt3GSVH4Ky2GE
	Eg2845YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFas-00000005GQE-27cW;
	Thu, 07 Mar 2024 15:23:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFao-00000005GOy-13m0
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 15:23:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6132961BD2;
	Thu,  7 Mar 2024 15:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41477C433F1;
	Thu,  7 Mar 2024 15:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709825011;
	bh=QLwDJBwJUyurwdA1KQeq9Y4vMNeTVG8BJ1Hj5GtG0FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lN6U5wysUBIsea39sveda6cKOE8vaYQeS428B3+79IalRiz1prKW5EJAc14cDSk08
	 23zae8ymWNhLYfRHmFoqAJsCtCXPETajKuMpzn60oZSNFtG4hSMIay6jzpMHp6s5GK
	 mQUu2B5pGqfAIuXTRxYONY7klnRKZ7txdFQ38M/MIwHcmc0NE6dYbs1Gf2lERPZ1FZ
	 wxyq1kEdDDBMxLf/599BYrBnNOwT1gu0XvZX+Dy7dO+TSXpWZ6Lzm23kkbxm54pKIV
	 jBiDzGZRMy7mBtcnhQfrRf1O76E2rzDiDaFwhqCimQrA2jTIdyiPFX5gLKeBDnx0+5
	 p39v1nd8w44fA==
Date: Thu, 7 Mar 2024 08:23:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Len Brown <lenb@kernel.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
	maxg@mellanox.com, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 1/1] nvme: Use pr_dbg, not pr_info, when setting shutdown
 timeout
Message-ID: <Zenb8eDX9Hq6YbQQ@kbusch-mbp>
References: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
 <dc6c4d98-e56a-448d-b372-38ce0cd927e9@nvidia.com>
 <CAJvTdK=Fbo0in7diYv_4Zk_-zrOPP4skDgpTMOYw-UM8=3R29Q@mail.gmail.com>
 <ZenacXkUAh4I1gkK@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZenacXkUAh4I1gkK@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_072334_356063_C88FAE61 
X-CRM114-Status: UNSURE (   7.88  )
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

On Thu, Mar 07, 2024 at 08:17:05AM -0700, Keith Busch wrote:
> But personally, I don't find this print very useful anymore, so I don't
> care if it gets removed.

Or maybe we can make the print less scary: how about changing "shutdown
timeout" to "D3 entry latency"?

