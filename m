Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FC4C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 21:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lkjlx4kJhJHiokI9fY55rFIhNj+PAzj/G9jyFBkfO/o=; b=selOy3Sf5LZxfQCig3YD5LNq81
	SAywDITjC1hMjAQmvf1YK5DRdwWNaOl8WPqLT68r0PJWsJqXVYBRAcy93IL4rjwkgaYMAj3SRS5/u
	cCNyPyWzFCX5q+eC6ZjPagbc7cfUqipDBxvSuuZufLkEMiHQ85UJqun+IZ8RM+RQNuBz4ZpEkEQKC
	q4Xd3ihh/HSAbJv8DvzQm54P3vwbWcBmSUfgznnEd8m1ASHq+uwHGZar8dupi25xwrLPYgLTyT9Lq
	UHbF5LXo725gZB3nX2NXAmNnMEdzPL2eJnjCyqAidqVfNhYwRB/9WzM0XD7lYsLISJiq63X5U4G5e
	xtu2TgBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyKRJ-002uXP-6S; Mon, 06 Jun 2022 21:39:09 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyKRD-002uW7-Pb
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 21:39:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 74FBF61578;
	Mon,  6 Jun 2022 21:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5872CC385A9;
	Mon,  6 Jun 2022 21:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654551540;
	bh=MGAeQv1niyMBoP7Ed8JAPjV785AVpCsDhiplhZjVKaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhyzwzpSuQ+PBZferXQQXjc+lPchH0JZXhRgVz6cysN+naRga9UMZdnnlVROwIz2Y
	 SZSgFyWt5jKI6fJ/3TsXgMc8kGJrOJI4ws7N8HgK+292A9mulPMmKI1ub7v1fmgVR7
	 sNHjdlbI7AlsmXr4/pyMyqNpGqFRTF86jA9kfeMHcGMCR3IxjdmmRea47Pz2USJWyn
	 W642g4J0CjOq0TXiRrs8ldigk6YH0gXqgPX/TRhmggrbzAGpzPImHtXKBP6TAPwp5u
	 HDh0qzaV00HHGPpdIahgHAZKP+Q+BP6yCmUVE1UVY3g0gMuSp/BK7YxundDIGJ6w17
	 46IuP25zzOG3w==
Date: Mon, 6 Jun 2022 15:38:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <Yp5z8b4ec5tFt9qk@kbusch-mbp.dhcp.thefacebook.com>
References: <Yk+KO8hEYpnKdGu3@garbanzo>
 <20220408052907.GA31990@lst.de>
 <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de>
 <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de>
 <20220411055455.GA14480@lst.de>
 <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
 <20220420073641.GA6859@lst.de>
 <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_143903_929966_475E832B 
X-CRM114-Status: GOOD (  24.01  )
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

On Mon, Jun 06, 2022 at 08:35:39PM +0000, Alan Adamson wrote:
> 
> 
> > On Apr 20, 2022, at 12:36 AM, Christoph Hellwig <hch@lst.de> wrote:
> > 
> > On Mon, Apr 18, 2022 at 11:30:33PM +0000, Alan Adamson wrote:
> >> I ran into an issue with blktests and my qemu setup when passthru is enabled.  The passthru tests
> >> do not complete.  This was because the UUID for the passthru device is coming from the a device
> >> from the same system since the fabric was setup as a loop and nvme_global_check_duplicate_ids() fails.
> >> 
> >> This is probably not a valid real life configuration, but since blktests try to test fabrics on a single
> >> system, we have this issue.
> >> 
> >> I’ve hacked together a fix to manipulate Namespace Identifier’s to get the test to work.  Is there a
> >> why for blktests to hardcode the IDs for the passthru devices?
> > 
> > Hmm.  I suspect the best thing would be to optionally just clear the
> > IDS entirely.  Optionally as in maybe a fabrics connect argument,
> > with it defaulting to true only for loop as that is per definition
> > local.
> 
> Here are the changes to support a clear-ids nvme connect argument.  Want to float these changes prior
> to sending a formal patch out.

Shouldn't the nvme-passthrough target just change the cntlid so it looks like
two controllers in the same subsystem? That would just need to stop overriding
the subsysnqn, which is what currently happens.

