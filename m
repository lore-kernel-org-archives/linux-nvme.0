Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C089DC54E65
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 22:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZAfWsqJcvjBpbWRcpsuGbZEh52NQekcOPQL1wesj6C4=; b=cZcO9wT1Tk5LWcLNootPOH5Bbt
	l64MXXHA8DY99L2tFuOgfPPEMtYjbjn6Hmy2dcvHGdbZ8eGJuREgM+bB7LqIIFCIEWFumWO0TNxPg
	w/EtFDe4A3M0p/gWSxv7ODTF6fvT4j+RhQlAyOgKjYWGHxFLV/cPKWN/ZrpRaTOtVDzi+Zxpgpd6W
	RQVLcJVbapODcQRdUpzeXDjabPGGLze8WK52QR/e8h99pOSnIZ62LyA0nbYJBl/KzUUwudViEz+AD
	zKCRFuZoQXP1Sred6IAf7aZVtVKLhKiUwVyJNHBICphPp6zKxX2dghsuFIeQ1xe0rG179axPFiWCy
	/j1xCWsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIEDp-00000002H5A-3B0Q;
	Thu, 22 May 2025 22:17:05 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIEDm-00000002H4f-3sZs
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 22:17:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2F668A4F203;
	Thu, 22 May 2025 22:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FC6C4CEEB;
	Thu, 22 May 2025 22:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747952221;
	bh=xDr0TOzhX4k1VThDlvKns4EoMrVWG/oxR0ohwtsWE6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCaucfwbZQ24qsenkEgXnpx98hnTZ+DDnY3T2CZz/2GBWwiU3kxF0S/AfHOEv39Xg
	 /l+qWNmwhFKPu085SuB8hnJkK0BsdMnAdIg626U38wmnFd6FgxKrtlgcY6eFljfHOu
	 tLEo9fcg526MmOukEnBLnr0MaAvOzSOCmWtiS99mXucjwDkiwjrQNBqa15SpYd7smR
	 nKqBVvEoBMIVgoU8ufIZJFojVfvwob/c9hiqeDRyTwFjRcHKOJpuXQRWofTDFzKs/o
	 V12kfjZkaTW8wYpgnu3gkdrQU/1avfnfTkCxEI4B98x+bPbgALdAZG/8xDu0BaCSMG
	 pv6fgketYnIvQ==
Date: Thu, 22 May 2025 16:16:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Andrea Mencarelli <andrea3000@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: APST not working on Intel p1600x
Message-ID: <aC-iW4puI1V1g_-6@kbusch-mbp>
References: <0DCCBCB0-EBDE-402C-94BF-50A3CA6D58B7@gmail.com>
 <aC-gEw88-Wk0DT08@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC-gEw88-Wk0DT08@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_151703_027417_004BA824 
X-CRM114-Status: GOOD (  11.57  )
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

On Thu, May 22, 2025 at 04:07:15PM -0600, Keith Busch wrote:
> As to why the driver does this, spec section 8.1.17.2 "Autonomous Power
> State Transitions" has the answer:
> 
> 	The power state to transition to shall be a non-operational
> 	power state
> 
> I'm not sure why the spec decided on that behavior.

Well, it's that you need more info to capture when to autonomously
transition to a higher power state when you're already in a degraded
operational one. Does the device switch to a higher power after one
command, or should it handle it in its lower operational power state?
There's no spec guidance here, so the requirement makes sense, but I
think this could have been sorted out.

