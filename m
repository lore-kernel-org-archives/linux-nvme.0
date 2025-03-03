Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFD6C282CD
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Mar 2025 20:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NWA9gAHgAwnsmHFvcWkdQwCGusSCq4dXZmyW+Pamm/I=; b=X9OarBmIFgLlTwp/zWxcrrrUR3
	9x82vFcLp1EZdU4tUHzhky3OWAqNtrjpyTQ68wyMhJAjaQ9+11SkdgEJwCpKVVLgzLYxkl6V9CqCP
	ntVcNMVEoNWE6NgbKO7BLQeNI4BZmbOzsCTK676bKrO5FsfkUD+ESJ0/AIfR3tgtzKErclqDU6EnW
	QTMUEmhPsGm0lDlfIBm0BZoSk3XuqMV9OIkLIATfA39y5ZHyHhZjmg1DyYOndZGkFQrExmPlvx7a/
	BE1hRqMmzRfiKvVsLiwij0Zvc+dlAWy7f4MtOeGsb7BFOwTk7mn9pDRgu4jbwRxcG4JwQ2bEE2KO1
	TAUUyy9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpC0h-000000028lr-2Xxh;
	Mon, 03 Mar 2025 20:03:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpC0e-000000028k6-3Zm4
	for linux-nvme@lists.infradead.org;
	Mon, 03 Mar 2025 20:03:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2F51F5C0A5A;
	Mon,  3 Mar 2025 20:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57098C4CED6;
	Mon,  3 Mar 2025 20:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741032207;
	bh=NWA9gAHgAwnsmHFvcWkdQwCGusSCq4dXZmyW+Pamm/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7eAzevTb5xUNeNNvBV+ZQ3no02V8rnxF7wLZrDrLn37pWa5mtQXris2D7g8gdixB
	 GbPgNxv5sikYhyA2qWJwdPi5ZQAsFbhgkq12Rw4ZgK9qHwzMcHX7TDYcc63JjPVnPW
	 DYg1BBF67iWFewrIz05xbuqm0xH/U7/URMu367IeqpSEffsAtmg/+i5tcMEAk6QtyV
	 LYFaT2ICdtDufCTK33ej18Sot3fbvSZyGo7Dc6WeSuwez+lSXojPg75pk6hZdRFyD6
	 EMEIaywh0v1bcS1vFgl2JHry7lu0jXyqcFzA68PK76SHuP2jL6r57qrvfD54KxEouN
	 8VdknqgzXAEnQ==
Date: Mon, 3 Mar 2025 13:03:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 0/6] nvme ioctl cleanups
Message-ID: <Z8YLDYyqIS0wysng@kbusch-mbp.dhcp.thefacebook.com>
References: <20250224182128.2042061-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224182128.2042061-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_120328_946400_7CC9C512 
X-CRM114-Status: UNSURE (   7.44  )
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

On Mon, Feb 24, 2025 at 10:21:22AM -0800, Keith Busch wrote:
> Various non-functional changes in the nvme ioctl code organaization.

Just fyi, I'm going to redo this series after the first nvme bits for
6.15 are merged upstream. Rebasing to a tree after that will make it
possible to avoid some minor merge conflicts.

