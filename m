Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3497AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QAaAbXJ7e4c3dVTdbTY33xCntjtiWNhLHiEy2XiG9UQ=; b=bqgwPY/FEHbrC7us7y5cAoLAUw
	V0m42hmYDUomVoqPsMi6xUKFc191uNObaEJbfIVeOSo7WFWVcs7TE5GP1QShSzHw6Fa3981Wo3bde
	PZVZddLFvVGy8qbMiESwRm5YdGH8dZc1hwWeCeYE5mxGRdq8EwvXFk7/07qO0DBjS34cnqhaWk9gL
	U5C84PMwrYQD/nk12dHYxKorY/ZzCWxGyf3bfnnkl6QiiZYb0RzwrNysLx8mqGseFEl3YNdtAgWT2
	jrnxlolVjOb23fsjPXH4V9JXyySYfsemgR7nevs9HsKAdd2FbYd+bgQPCXJS42lfW2iUZMqpjl8Zo
	EhgFzPxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpYsJ-002xcC-G6; Tue, 23 Nov 2021 16:42:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpYsD-002xWw-NO
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 16:42:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2C7B668AFE; Tue, 23 Nov 2021 17:42:22 +0100 (CET)
Date: Tue, 23 Nov 2021 17:42:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: print out valid arguments when reading from
 /dev/nvme-fabrics
Message-ID: <20211123164222.GA24422@lst.de>
References: <20211119083912.38260-1-hare@suse.de>
 <20211123162204.GB23957@lst.de>
 <36c5cc0c-f12b-b63a-89ca-d1d3971e7e61@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36c5cc0c-f12b-b63a-89ca-d1d3971e7e61@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_084225_962608_6DEAA20B 
X-CRM114-Status: GOOD (  12.80  )
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

On Tue, Nov 23, 2021 at 05:38:22PM +0100, Hannes Reinecke wrote:
> Helper: sure.
> But we don't need to distinguish the case where the controller has already 
> been created as this is handled by the if condition further up.

Well, a token that the reader clearly sees that there is no controller
yet

