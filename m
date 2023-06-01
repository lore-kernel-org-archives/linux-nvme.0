Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29462C7EE2A
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jun 2023 09:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qGTmJ6xmU2TNLLSSL4l4aL6bEdbixFH8VogAiXev27I=; b=gUoLgL9aae+AUWcEqaYbQpW2PN
	gYCvrI5z0fvH1mifuiFbtRXncNnA+ZvbTY14xJUAv057VmaCmMDNO2NgNNlY9nEiynwtgYyQJFuCK
	WXKsoj7ivcl3u3FiztpMcskxozaS4c3c7mc8xGF9FDIoGNUTKoMzWT00NFkd9CAzZ6WuHdwCvd8OM
	NvLTdQpZK6XE20m5wtA4JU4KJtI2tJz0cbjm1tMZdgV3alIP0HP87JVmIoyX3LQVyvjJ+1TBieMZo
	8+M5mdfvsxzGEDPbpu7zBbCGGmx/2pAMa/SgM6lsTISPC3w+TzVSas79tQLw2Y0AeeQ47Z6KvjT7n
	mfAH0EQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4eyx-002nFe-1T;
	Thu, 01 Jun 2023 09:52:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4eyr-002nD8-2E
	for linux-nvme@lists.infradead.org;
	Thu, 01 Jun 2023 09:52:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D8CF960F76;
	Thu,  1 Jun 2023 09:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301C8C433EF;
	Thu,  1 Jun 2023 09:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685613146;
	bh=+C6KoTnzYoqe2NGMblFrRlx+vs7d7T9fhqlO/pPMxd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1DAIlN8riwWFivON4JTRO9vAukPRUemXUBiab1A2/KrRKpBjGcyVU5PxkzRgnUjK
	 0QffO/tpTWBgTzgAvw4pS+y7dYHxbMjUQplLlCsfySwbb52i3p2GnYpfHLOhu1gS7h
	 fG2G4igdRuBzVq5NxAbJkmE4AUeB/rbaRKsRVzOSMntJSLulAEIwpQj9RjyUXRwX3s
	 Kk5DFVNfq9FSQZa8Pi2balNYZVq6P2+tmkCoyEZnfBG5qCchDRZ+E1pex4MWlAIeLr
	 bik+WrBZ1JnUzbWQ/aBion9cej695aexz7tXM7JtibW/GLFQbC/zpih9BwxY9OWyBg
	 dq/CSd9UJvEdw==
Date: Thu, 1 Jun 2023 05:52:24 -0400
From: Sasha Levin <sashal@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Andrey God <andreygod83@protonmail.com>,
	Christoph Hellwig <hch@lst.de>, kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.3 01/67] nvme-pci: add NVME_QUIRK_BOGUS_NID for
 HS-SSD-FUTURE 2048G
Message-ID: <ZHhqWIU/YrJwzyYl@sashalap>
References: <20230525183144.1717540-1-sashal@kernel.org>
 <20230525190201.GA1266801@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230525190201.GA1266801@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_025229_770303_569A4F3D 
X-CRM114-Status: GOOD (  15.73  )
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

On Thu, May 25, 2023 at 07:02:01PM +0000, Eric Biggers wrote:
>Hi Sasha,
>
>This feedback is on the whole 67-patch series.  I'm replying to patch 1 because
>this series lacks a cover letter.  Please include a cover letter next time.
>
>This series doesn't apply because the following error happens on patch 35:
>
>    Applying: tipc: add tipc_bearer_min_mtu to calculate min mtu
>    error: patch failed: net/tipc/bearer.h:146
>    error: net/tipc/bearer.h: patch does not apply
>    error: patch failed: net/tipc/udp_media.c:738
>    error: net/tipc/udp_media.c: patch does not apply
>    Patch failed at 0035 tipc: add tipc_bearer_min_mtu to calculate min mtu
>
>For the base commit I tried the latest linux-6.3.y, both with and without the
>latest queue-6.3 applied.

Yup, it was based on the prior release, and the conflict you see here is
because the patch in question was brought in to the stable tree via a
different route.

>As with any kernel patch series, please make it clear what the base commit is.
>Otherwise the series is unreviewable and untestable.

Ack, I can add annotation of the base. In general - if an AUTOSEL patch
fails to apply/build when brought to a newer release, it'll simply get
dropped.

-- 
Thanks,
Sasha

