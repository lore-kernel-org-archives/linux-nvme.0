Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE40C54E90
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 14:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v+2R6Hzm8MOzYh7bO5AdpgnC5E9dMvdP5JypAmE9eSg=; b=2avLizs0HxClzMuWkHf9hthTcY
	Sfk247T0qMM/01CNrVAxgQBO3sEsq7Yhej6lwuWtQ4xu/xnIaWtTSMZg8MQQsOWIJQOSFpzD7Ve5t
	BzNJTbpxO+WJw7R3WUSGPnpXohZvom5qSqEJeZRqfrjp+iDfqCFi0+tbDITj9xGEqBBvEbTGMv56d
	+lLaSLH/K5yKEpsumVI2VBWxy5kuJfqeA7++akps3/LxPRxekEIbdMR+2knHJvGYd/teCE/I4lSVm
	ZfVSrN9K+mRCCd/jpD5JpT8BudbEkzcw/oRg2jvvgi5jhVLmjqYPr+aTytVxOuTbaH8DAyA0H6Uv/
	cgx2eZJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI6jG-00000001E9e-14jQ;
	Thu, 22 May 2025 14:17:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI6Zg-00000001CdC-0VBw
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 14:07:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 338765C4B90;
	Thu, 22 May 2025 14:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E084C4CEE4;
	Thu, 22 May 2025 14:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747922827;
	bh=0P6S5mM76WtwYl5idB17bKNw74rBuLMDgD/qcH1/GVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t4jM5Mcoruwb0RQ3t4tiGede8lBriTubmyqoGwRhBMLKQPI4fc/yuyUK3uZu+8QYK
	 OF+Ny41dH/CjE7V80MrNfS7o11ufE9gjuhDD2sLkqmPrIlwtsRGd2vfReo+v8/bKuh
	 QFWywpSNXfLYtNRewJP1zyjkOwG+MA59zaUM1ifbAUBUvw31yw46fWBNb/61sLobcs
	 rvXejF2qKKn3bgBPlSPW/N1ox2rMOobDUWI2GY1k6/qgB1pPr/TqYJoJrUe9CeGXvA
	 W5H48e9N3/TtAAZFSOD9f/6iB2oF/sWXOLGgocVZYR92cQTmpCOPnNWkiqyRb+RZ5j
	 lgJAtiFHhb50A==
Date: Thu, 22 May 2025 07:07:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Sagi Grimberg
 <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 00/10] net: faster and simpler CRC32C computation
Message-ID: <20250522070705.19fa9ca6@kernel.org>
In-Reply-To: <20250519175012.36581-1-ebiggers@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_070708_202827_5DE74BC1 
X-CRM114-Status: GOOD (  10.83  )
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

On Mon, 19 May 2025 10:50:02 -0700 Eric Biggers wrote:
> Update networking code that computes the CRC32C of packets to just call
> crc32c() without unnecessary abstraction layers.  The result is faster
> and simpler code.
> 
> Patches 1-7 add skb_crc32c() and remove the overly-abstracted and
> inefficient __skb_checksum().
> 
> Patches 8-10 replace skb_copy_and_hash_datagram_iter() with
> skb_copy_and_crc32c_datagram_iter(), eliminating the unnecessary use of
> the crypto layer.  This unblocks the conversion of nvme-tcp to call
> crc32c() directly instead of using the crypto layer, which patch 9 does.
> 
> Please consider this series for net-next for 6.16.

Applied to net-next with Leon's ack he sent to v1.
Thanks!

