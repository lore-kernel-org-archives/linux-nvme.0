Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229F4C001DE
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Yf/nnz/m2V4Mhx6Ft8bsqzcoUpk2Omj1LOftduSjAE=; b=Hdd8JvTkCYMjwY9zbJhs96w9Qn
	wiWbFO1YGxQvrrNN3HLudET2EHM7WjsXNpQUSbFhCWXHfW80rSpp9hubHNmXVt90Z8UeUsqN1OIeP
	S5csbtsJvzUUnU5DcA8Fv6ddzCJkfwNBRwX/zVFtnxxja9PMpOSsfm7qjRC6lI5S9iwis3UxSGnRC
	Y6eAu0268IGtANoM/2nYP0VRxOahg+tRhp8jm+GapcCWyEMOtj7SpyTVNDOKky2i0wp0tHqbRKq/0
	LzPqZZ2nLBs57EEwid/Q3N9SS3+80dlurzMzp2chAkkObhMJ35aANyyBs+Z5ZcwV98vs71lXA0Hbo
	DoCo31VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUWtp-00BMbZ-2K;
	Fri, 11 Aug 2023 18:30:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUWtn-00BMb3-0m
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 18:30:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6F4036467F;
	Fri, 11 Aug 2023 18:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F5EC433C9;
	Fri, 11 Aug 2023 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691778609;
	bh=8Yf/nnz/m2V4Mhx6Ft8bsqzcoUpk2Omj1LOftduSjAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4P7rWHWjC8cKjOTd1zy5iDnFlBzQUUIf5hEtNvr4VsATUiqM3+t0pSLLDTfagRSW
	 vKrCxvG7CF6SYYoJKVPwNssB2ROVjZlwrQm2VRy6AQ52LyLsTpXSiJZrBkGb443KDL
	 Dzr76t7o1BWlX7Q0BNQtgbKK6ib08CUSPZb1/aDdrB1D1F7bIwioYM4qeq/2gKAk4k
	 cN0+7S2JCbpDPwP5oIXo+A9Jw+1/3/9oO6//Z0YAMLVHkyf2bxaF9KqfbVNtCEMzgN
	 dwrW+/Au8gWUzfars226o4iyA5ayqLuTpoFyQhUtbyEFQNvKxgEcVBGvOXWVuExrGg
	 GyvzWnO7otekw==
Date: Fri, 11 Aug 2023 12:30:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Sariel <davidsa@openu.ac.il>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Key Value Command Set Specification
Message-ID: <ZNZ+LqB/c4azu0L0@kbusch-mbp.dhcp.thefacebook.com>
References: <CAKhp91GOYQURee7gvecynpskPi1=JbJFe5C8zMi812n6NnhQZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKhp91GOYQURee7gvecynpskPi1=JbJFe5C8zMi812n6NnhQZA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_113011_346784_6A137F3E 
X-CRM114-Status: UNSURE (   9.38  )
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

On Thu, Aug 10, 2023 at 03:35:38PM +0300, David Sariel wrote:
> Hi,
> Is there any active development underway for the implementation of the
> Key Value Command Set Specification within the kernel driver and/or
> QEMU?

From the kernel driver side, you should be able to utilize KV commands
through io-uring's OP_URING_CMD, or the NVME_IOCTL_IO64_CMD ioctl. Those
are essenatially passthrough interfaces. There are no other plans to
provide additional kernel interfaces to KV beyond that, as far as I
know.

