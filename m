Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B1FC32793
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 22:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S55Sz8gIGLeBZ0gKVGFlmm2cwRoTnLsEEPBC36F1WPU=; b=Jrkkh3k38sLQvdLTlStqKMBrcn
	7XZSqdZWl8lMrSL0q4oeaHyBKjKjF3yzotRvfmxTdLJ0q9kI88Bnb22i67oHM2yhbypM5W+gqWzBJ
	g5+JbMSUVTKKtOXQJ0ETSBH6JIOaYz1IIRk94JChKRg39vfN1uIrAUhI8z+XgZWr3wTiyJr21DIPr
	wHBNn9IC+Yp9XS6Sou/MZZwbgXAnDFlly8ck9C5fVPxUzj9VbS9Iem0fXcd2S1tQpFTbcpza4j+3v
	NSmPTraQCQZQMDtcxzTmxmKILaAaqi8Y2ZKRJUfqrPnoRk7UutNsbSxqICPP1zg0AHfDZK1W1iJ9F
	EEVETXKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIGtA-002qx5-G1; Wed, 18 Jan 2023 22:26:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIGt7-002qwS-2i
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 22:26:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7037A61A1E;
	Wed, 18 Jan 2023 22:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A592DC433EF;
	Wed, 18 Jan 2023 22:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674080792;
	bh=S55Sz8gIGLeBZ0gKVGFlmm2cwRoTnLsEEPBC36F1WPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hpvmf94AB9ewKF6hBBIlNOp68MKy0T25hi2gPzJsbROrYtx/cVPbepBfSra3HqgJF
	 pTflNafLTv4jwnESlZBh6yzbgDOd5RVk2ElzXvZisZ5gVR9vO+toC/vN/eXj5WDaGb
	 +kHZyp1gjXn6k9DdHuJdVLkUE5kLeXnSYQBcJzrnc297YdZf+Gw7mL6k9/GVhVa8Rp
	 1xJXvVlsPKwdoRN3jo64BsQi9eeQV2Jjr9/Ls1+PPMNu1+tUZEsNZEYr3TMyfJuQ8q
	 qVgako9WraMux2iq8NfTc0Wi4YaZA5zwHljInvPprUF28MN/iJfmgzGZulmkWl52Bh
	 Oq0j+95sWJUVg==
Date: Wed, 18 Jan 2023 15:26:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <Y8hyFcsYbvLOQ+XJ@kbusch-mbp>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8AG21o/9/3eUMIg@cormorant.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_142633_197040_ADA8D715 
X-CRM114-Status: UNSURE (   8.99  )
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

Klaus,

This isn't going to help your issue, but there are at least two legacy
irq bugs in the nvme qemu implementation.

1. The admin queue breaks if start with legacy and later initialize
msix.

2. The legacy vector is shared among all queues, but it's being
deasserted when the first queue's doorbell makes it empty. It should
remain enabled if any cq is non-empty.

I'll send you some patches for those later. Still working on the real
problem.

