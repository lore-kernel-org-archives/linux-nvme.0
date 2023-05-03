Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08347C77B7F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 23:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GMnz2/tjaRj0eLfpGdlKRt98h5x14hF9thH6ejg9YYM=; b=QPNv6VFWlmdDN1ys9eS0Ygu3Ip
	OMhS0V3WFVcri6Q/hQp2w/wx9sQt967HJoxSeuwEaOp4qq3vaKVvQdxDnPX7ZPDmFB+k0DhMOQYEU
	c3iITsbJngO32Z9PNfjCR2E4eiivtNVBVjjqheSXi7+nsl6Fc7PLs6EVrkxU3Dmt3b0m4ttBKo6fS
	xMEfZOR2VUPLtl2dT10aBD/vZkJCWAajIyReq1aRzzvI/KIIvXwUMiKhDMRmprTNMqLos8POCbKUy
	2g43sH+fS6CtB4BuiLiloCpBQnribf49ZYyyaNY6pbuLN6tuAe18ABHx8GSQTpo/eJVeKNS1IGurG
	E4vS645A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puM7F-0067eq-2q;
	Wed, 03 May 2023 23:42:33 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puM7C-0067dy-2Z
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 23:42:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DF92B6309C;
	Wed,  3 May 2023 23:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA7FC433EF;
	Wed,  3 May 2023 23:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683157345;
	bh=ygoZYBqc+MgS/E5JfqeI+QYE2ey17vUNkWBN0+w7Ihg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rR60sSxOq1wMexhStoRwCNd6mFnVEtm3r9fdZYObhwYmhrC5HKxAVDYfVWoLFo6yG
	 g6RErlInF7G86qSog+Q77xb4bSCb7YMKYV0KXOaLUexiGdINrHv6XPauFTu64ZHoWE
	 p/rPENKJkgh4PJ7FNnYlTdPSOzQ56N0Xat0sZMRmrd9ik024nCRV6Ha+AGt45KU/CF
	 SzisRbQ5tsaCa29EqTZC3xUasdE0troUtBh0xCJ1wnBth3WNVO353aC3WCbSfejiZi
	 pJk5ipXdZpSpJ8Ozfo/X8381WguMYgf7YjgD30CX2NqjJZqwaHEteB/YacZYGFikJW
	 DyxBxZQ9XC6YQ==
Date: Wed, 3 May 2023 17:42:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: jiweisun126@126.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	axboe@fb.com, hch@lst.de, sagi@grimberg.me, ahuang12@lenovo.com,
	sunjw10@lenovo.com
Subject: Re: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Message-ID: <ZFLxXjiQUPl+tV8L@kbusch-mbp.dhcp.thefacebook.com>
References: <20230502125412.65633-1-jiweisun126@126.com>
 <ZFKLxfet7qUIwScd@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFKLxfet7qUIwScd@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_164230_879225_5D7C5BC0 
X-CRM114-Status: GOOD (  14.44  )
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

On Wed, May 03, 2023 at 10:28:53AM -0600, Keith Busch wrote:
> On Tue, May 02, 2023 at 08:54:12PM +0800, jiweisun126@126.com wrote:
> > According to the above two logs, we can know the nvme_irq() cost too much
> > time, in the above case, about 4.8 second. And we can also know that the
> > main bottlenecks is in the competition for the spin lock pool->lock.
> 
> I have a fix that makes pool->lock critical section much shorter and constant
> time. It was staged in mm tree for months, but mysteriously it's missing...

Well this is certainly odd: the commit I'm referring to is in Linus' log, but
the file it modified is not updated. What kind of 'git' madness is this??

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a4de12a032fa6d0670aa0bb43a2bf9f812680d0f

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/mm/dmapool.c

