Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98CCC7EE29
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 19:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oh7oDkRL0ScrWww/hECL3TWop3jRe/S49H8FWQYNvmo=; b=1WdukaC/dhnJHXUnsoifmF8E30
	98G1JYzedCqvkcfp9sKZR+EG7YfcmlxNNKC+KM+HqHxvjLwoFfCFrFMllnf/J91Pnsi706mZ06JVz
	CzB+N4+CdE2DOjPJOVkq2uRhFE4fTI7c2RfqekJEfWAaJ0zWUOa3h+w+24P4WNmXcmf9KO+hBouli
	LBsAqmc7lxEre3BlMDHCjS1pLujLfbMdQGG6swxkL2fs1gm37UcjwQXvfpaycfx9HZFVPr/ZQgus9
	m7wfbVKq/lpsrw+Seujh9bAtdUwl5TEtC6BZwfyk4+5j8JAFzt45oCzaaLXrZbnW19mlTboWRwH9u
	/Z0JSpLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2GDu-00HVWh-1i;
	Thu, 25 May 2023 19:02:06 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2GDs-00HVVz-0t
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 19:02:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5306964A68;
	Thu, 25 May 2023 19:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA11C433D2;
	Thu, 25 May 2023 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685041322;
	bh=/nHmfbW2TjMXmkkNUUIeO7lCCKl2hqVyaBxBf/SbfM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBXVu7GEqd4G5papzgh/zjF/sYRdPT8tJ/+IRFxulE8jwhEGBKUt9ElsUJuESFIjF
	 2aK0REOpS5Sjot0kwYX1AvwJp9dOW/RfJJgUiLYu14NnRZslOQ+my8zSo78gP20xMH
	 CGCxbaDVmRaB1YraLbg8xt3+ta0t6UyTBYO/GhjW0q1+yV9zqANrRm/q995RUqlWcs
	 cH02Ep28k1Bfb9sWSHa8pD91hLlI1lZWvsklV6MUVa7zFUeSTA0lHUy7ztP6T8DxZa
	 0gaFi+GKrE1jIytyq7Y3qetJai9I9zG9j866rFhwLCllsyzzIjRVwsKS7/pOAcxkMt
	 eVRnJLq883ZrA==
Date: Thu, 25 May 2023 19:02:01 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Andrey God <andreygod83@protonmail.com>,
	Christoph Hellwig <hch@lst.de>, kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.3 01/67] nvme-pci: add NVME_QUIRK_BOGUS_NID for
 HS-SSD-FUTURE 2048G
Message-ID: <20230525190201.GA1266801@google.com>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_120204_375871_B43DCEF9 
X-CRM114-Status: GOOD (  10.99  )
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

Hi Sasha,

This feedback is on the whole 67-patch series.  I'm replying to patch 1 because
this series lacks a cover letter.  Please include a cover letter next time.

This series doesn't apply because the following error happens on patch 35:

    Applying: tipc: add tipc_bearer_min_mtu to calculate min mtu
    error: patch failed: net/tipc/bearer.h:146
    error: net/tipc/bearer.h: patch does not apply
    error: patch failed: net/tipc/udp_media.c:738
    error: net/tipc/udp_media.c: patch does not apply
    Patch failed at 0035 tipc: add tipc_bearer_min_mtu to calculate min mtu

For the base commit I tried the latest linux-6.3.y, both with and without the
latest queue-6.3 applied.

As with any kernel patch series, please make it clear what the base commit is.
Otherwise the series is unreviewable and untestable.

- Eric

