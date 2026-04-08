Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F73A10F9955
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DMPsq9nh/DivBwkJVwzHmyp5XqOl0wUh/nTo1UESYHQ=; b=0cN1hjDMCVJamwFxB0Ozs94ASD
	Qoa4dxPg9zFctqOHGQRRhrEdRLhElOO1ZxZkVUAmHRIIfTVuq9jYbyTSxebNdkpnrbvVDJ9tQTViE
	K4azwAMVfScjscQjvAjraPswSVTPEcjYc4g50bcUuQTLT1mEmtshi/c8EVwhDnZKb1jJX39MQVDXZ
	lsFcgN5w3Ik6Fy70o+N4d4QtlXWkr30PogmFNz+CVuybpxNQHl8LbItu/2xcnPyyyoM0ZYit1w4sL
	7s1ORVBXMRnv6o8ztn1JhMwM58tiaI8SAGYgeuZQFN1rRNj3o1x4p1l+tCtiEssxze9PCvfuxb7wz
	EMkpCBfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAUbW-000000092QL-0qTj;
	Wed, 08 Apr 2026 15:14:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAUbT-000000092Pt-3APA
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 15:14:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7840B43F3F;
	Wed,  8 Apr 2026 15:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6EBC19421;
	Wed,  8 Apr 2026 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775661243;
	bh=DMPsq9nh/DivBwkJVwzHmyp5XqOl0wUh/nTo1UESYHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFTvfn5ItvrtczJknzQiIdgxwN92ZBY/aKwM8BmLBu0GEEURd0+CnaaMQY8Q7QNCH
	 R23ViqwalZhbQ/nueX53sonyYTpmgTIcbKfdPupq21Qm7taxkShNEdW4jsL0XR1g1/
	 pJHhPZMeg5cwVOHUjfz+r/UDxVAdKM/NMrGQqqAf7237XPlZItso5aDnUDQgQ5CZ9N
	 OGonknmbcdT8lR1Aa2uS/a4gDQqlAxOemci0ceBqVM21Uc8/NN6AtNC1Za4hcpcpyY
	 ZaROMEmXXXrtSchbfUL67Y0UchifbXiytSYdwWj0EdE85onKyvIjRO2ZQedv/K/1yd
	 pXhzqB7Qg2DEQ==
Date: Wed, 8 Apr 2026 09:14:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, smalin@nvidia.com,
	linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v3] nvmet: introduce new mdts configuration entry
Message-ID: <adZwuRg1ymnaYGNa@kbusch-mbp>
References: <20260407052358.GA6089@lst.de>
 <20260408090226.319321-1-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408090226.319321-1-aaptel@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_081403_812361_50A7AC65 
X-CRM114-Status: UNSURE (   7.79  )
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

On Wed, Apr 08, 2026 at 09:02:26AM +0000, Aurelien Aptel wrote:
> Using this port configuration, one will be able to set the Maximum Data
> Transfer Size (MDTS) for any controller that will be associated to the
> configured port. The default value remains 0 (no limit).

Thanks, applied to nvme-7.1.

