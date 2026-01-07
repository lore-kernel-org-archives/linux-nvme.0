Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EF5CD5828
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 10:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P8Sa1VeCZ7F5QfUbO54f1heGzVglFS5iEkVdn3aunjs=; b=dH8yiRsNlMagh+1/OKM0OlGlqx
	8wxnL0KQ7FwdMBhcRiukcC5MV9TD97WNe2wALF4jXwwFJ9oYxfknd/i+u33em15ifV2EGA6YPnFwq
	UmlJlDlQGU9w48kFa+sRiwXcXH/4UWJcCg5VoxGEEAEFBpgdWyCWxtYKikLQeRTswXTJK2ysi7cUg
	BDSm2zhXr6qmVO8V7ScQF2c3ZfO1TVv28oXmwvPBQBFkDWU8BBFSLxdMgLBw2vumvi9Xo8l1nHZb1
	gZebO/NXn8M4r0dqr2ftrCK42wvswBI71/vPa647WjtLApICAiFNuPQ1pEEt31rd7tEActpm3bxvF
	VAee8WTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdQRj-0000000EeJw-05W1;
	Wed, 07 Jan 2026 10:07:19 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdQRe-0000000EeJX-1Vuv;
	Wed, 07 Jan 2026 10:07:14 +0000
Date: Wed, 7 Jan 2026 02:07:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] nvmet: do not copy beyond sybsysnqn string length
Message-ID: <aV4wUhevpSgOrL5J@infradead.org>
References: <20251221073714.398747-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221073714.398747-1-shinichiro.kawasaki@wdc.com>
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

On Sun, Dec 21, 2025 at 04:37:14PM +0900, Shin'ichiro Kawasaki wrote:
> Commit edd17206e363 ("nvmet: remove redundant subsysnqn field from
> ctrl") replaced ctrl->subsysnqn with ctrl->subsys->subsysnqn. This
> change works as expected because both point to strings with the same
> data. However, their memory allocation lengths differ. ctrl->subsysnqn
> has the fixed size defined as NVMF_NQN_FILED_LEN, while

s/has/had/

The change itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


