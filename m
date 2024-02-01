Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E4FC47258
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 00:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gz+nsKjWk8Nf+ei6d5uAUW8VaFlVj2RhKbdd6i4rq2s=; b=Xtm/9PGDQyQ80f9Cv8H7XO1jcU
	c1Hex0Y3MCA8mbBE8CXHqw9WuvAB8JVZdHYGAOMWQGFeXJHhU3EDskgNsZ0pd3kFTHGQSLml6AOKM
	T/lBzgsaLJyWLOGPRBT3wIY8H1FN0FoPVhF7WF7WZ9JS7uhT7CuGN8h0GaS4DSbQhXItgAAb4ZF86
	98jE5zCR7iQ49JsGXDuatU0bFhdP7CYdLw38ln0WAPBmdcOkASbDiMy+M+lY3pmHmd0mVhYcdeg9D
	YDPPX4JbRR3J0tEQdV5qrIU9hgQ2uQ9kfUYerRB8teyLdCOu9fCRzSiuducytuGcTBnw0UWyVrsXP
	52oBwdCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVKxn-000000065Tw-0UTT;
	Thu, 01 Feb 2024 00:29:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVKxj-000000065S6-1qsN
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 00:29:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ECD996194C;
	Thu,  1 Feb 2024 00:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352D0C433F1;
	Thu,  1 Feb 2024 00:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706747390;
	bh=gz+nsKjWk8Nf+ei6d5uAUW8VaFlVj2RhKbdd6i4rq2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WhhsmhMbTkyACy6mCL1R31KCILGpC3hoRhqKiUKSL4Vx+EiiUft4XBm0eZvwTx1L6
	 BkkPrUn84E01Q3t7fS14rNSCghaScEzX99XS5DEdfNj1euax0N7DQKjLY/7uET/zaR
	 D9H84OEoo8t+04syEQexUs5Yv/yWFdov77fEbDNYDi/PYostV1aSj6Ic+SATOvN11T
	 ygwiOexfKC/XIQiDAbo6vbwglsKSlcb/HIHxd2LMqRJGH/DgfvZDmQ3S6YMmR+tZQw
	 9/4h7K8B5FYEFuH7UNSNBoloqExxFBti93tgYepOgs9q40KK3ftXAEpWZ42ixw9GHk
	 JGSRBfhV4mrag==
Date: Wed, 31 Jan 2024 17:29:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv4 0/3] nvme: enable retries for authentication commands
Message-ID: <Zbrl_NlShaG9-vSz@kbusch-mbp.dhcp.thefacebook.com>
References: <20240129063948.3105-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129063948.3105-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_162951_543083_4623AA6C 
X-CRM114-Status: UNSURE (   5.75  )
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

Thanks, applied to nvme-6.8.

