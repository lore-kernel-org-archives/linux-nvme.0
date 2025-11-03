Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455A7CCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BzQBgAjvsn8W9vltqeF5rzyjlgLG7ymyAu1h3wIfBrw=; b=1sTZHzdzwBfrr3PzRkbqlFrawz
	u+xBg/Hi6eCArPVwO9GMY13RYgsFQ9lhYDv/PS0b8OT55vQlDTKvw0b1U+mlgFVucpmbH05hC7onk
	EWtU1M95B/Fgvx//pqp4xTJI8Yp+RwFywKZIHoEebORlkAuTJn2qiSkiuuRuedKsPMYIq/exQTWha
	IHaU766JhbJjfCLS11ohaSMiory8EBYZTsnRwuS3iPYhSK5cEANVS1bDNh5oLg/8ZgCcB6c5KEErM
	4gAyx6EMcfdmLIXNoigMrgOp17+3KkjX/O2OnpFzbzwrb1H5088kS3aYUVgW0K02a6ry7QXVaFi+6
	7SoIkcZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFvxV-0000000A3bA-2VNv;
	Mon, 03 Nov 2025 14:55:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFvxT-0000000A3aW-025c
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 14:55:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4B57641781;
	Mon,  3 Nov 2025 14:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09E3C4CEE7;
	Mon,  3 Nov 2025 14:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181698;
	bh=rPRDR9jEi3yy/wWePCxpffjIm3GoAYWWdcsgHU9tjfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IUed1fdX0g/3UzHH5kUVYTExzxMZ0nT8fhmBqA71b22XA1sgAXbPUCWw3GshDzuIf
	 D5F8RHj4VdX3xbfNITRdzB6EK8JJ8MeP26WMCrGGK8nrMZ0RMkdkEmsbcfAfFi4dj/
	 tC/UiOyKubCQN6M1kuArbAPpaWdAFnf+Z/sdQGz5ztE6H4jOJ+nFCWOwKwtjkeJCjc
	 HiGZEru/yIrzbbC9OQOqGdp6z8HgxGOJH88IQFLGgI06vm+ho/XKnmIcpmwUp1eSpu
	 +6zvaq21CkBsqEyWfKuA6KCfwv/d2IzsYbBzqgzdo2yT6A4Xkor7A6TBPk9EFxtD2t
	 FFDjhTZ1FdBCw==
Date: Mon, 3 Nov 2025 07:54:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, hare@suse.de,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-auth: use IS_REACHABLE for nvme_auth_extract_key()
 declaration
Message-ID: <aQjCQKiN5mzw2oY3@kbusch-mbp>
References: <20251102031742.69984-1-ckulkarnilinux@gmail.com>
 <20251103114621.GB15280@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103114621.GB15280@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_065459_086056_3CEC707C 
X-CRM114-Status: GOOD (  10.80  )
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

On Mon, Nov 03, 2025 at 12:46:21PM +0100, Christoph Hellwig wrote:
> So with Keith' latest fixes the auth code should always be built
> in if either the host or target code is built in.  Did this not
> work, or is this for an older branch?

It should be fine if either or both are built in. The problem is if both
are modules. For that config, this should have used:

#ifdef CONFIG_NVME_AUTH_STATE

Or IS_REACHABLE also works.

