Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B49C36010
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Apr 2025 23:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=by/wrTT9SK2n2yZUbUYZYwaO3zeg4wymoJSHglmGG3s=; b=slG4nBnEgfWgbnC+HyLsy5UA97
	Gqkc36pbFhGJcLXdrGnRDGLBdRwXiyrPdv6d4nKgNx20vgyteaxwUoWI8MKvYR8YUL6fQsyFvXsQ/
	M5w+llmdaD782mIKQWlQagBB5aByCr1JkMNHnmvy+tGZ/je28gH2M1BgoYJkYSps/Inbqw2llG/n+
	sQSDog6amkag+NJfjMtq5Y8GOHzB7ELUka3nQK4hyIfSAIMYqj/vtOiwywGecWWtROxZqta8p0k+7
	zjIXD+cfreC4OduT8kwkZppB+yReqJu/luGGJjETA2yINyVdCbGtLEwwd9F8tups66rgQ6EXqFIQW
	9GX/F9Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1CXO-0000000EaJL-1Rh8;
	Sat, 05 Apr 2025 23:02:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1CXL-0000000EaIs-0nla
	for linux-nvme@lists.infradead.org;
	Sat, 05 Apr 2025 23:02:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F0DC244EC4;
	Sat,  5 Apr 2025 23:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B75C4CEE4;
	Sat,  5 Apr 2025 23:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743894169;
	bh=+Yqb/Or7jQoKw3+2YPLSBAtUemjwqw7X304A0PCIoI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OT0Kx6bBbsF+KS9DMyMTXUsDSBIz7zduwmVT3fSxxC52rwoOEW9YN4jtw3wCP+1VD
	 5R1Kqo69xkRDIBz0udHv31l6kduwI78gOfql7ghdC8Ca440wzzi+5jdWxRsFhXbYmT
	 Aa+T1rsL6pqPhFQkxLm0Etw8kgpYQNLSrODIb5oC39vESweIZmiKskfEhVlFtqvccv
	 qK6cJLF3+4hQFH2q4vzSIGsdr3bklOeSRi5rYUSfN34F6UTQN8qvbQxb8rVlCPc0z4
	 YEgmMfkaa50Psw1jezxE1EmQVN861FTjODpzw6pFOwoRKv0cRucD2m0N7VwPuUxTfU
	 hfKJAza999JJg==
Date: Sat, 5 Apr 2025 17:02:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: re-read ANA log page after ns scan completes
Message-ID: <Z_G2l6wc_vVW6-YR@kbusch-mbp>
References: <20250403071930.52154-1-hare@kernel.org>
 <20250403071930.52154-3-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403071930.52154-3-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250405_160251_248097_2D050D45 
X-CRM114-Status: UNSURE (   9.54  )
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

On Thu, Apr 03, 2025 at 09:19:30AM +0200, Hannes Reinecke wrote:
> When scanning for new namespaces we might have missed an ANA AEN,
> so we should always re-read the ANA log page after scanning to ensure
> we don't miss updates there.

Maybe just update the commit message to refer to the spec: 

  A controller shall not send this event if an Attached Namespace Attribute Changed asynchronous
  event ... is sent for the same event

Change looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

