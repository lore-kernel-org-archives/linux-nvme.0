Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE92C001DC
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 06:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JthLDtARMLNyNpQomgLPy+Cyu1CS1zAgGiv5TDWvHy8=; b=F2nbR5Cg0nSo9wNKMfKtg3FLX6
	VqroSsML5rDxjTLu8cCGCWVKY3aUVBubase37bXMLksv425y+q0HioV4tIhQi5x1iJ/qPEjmRLpCQ
	T3ApCS6ZWexcdyHH9uqJSuqAsz47185wWUF0H+zWtKO3AOk0ValMOLimIkv+uHZLlORaEM6kR7eXN
	PARGx2gxuVOXPzegBWYLMm22/BXIpEcK4ppJgri0rpUQnxSXCx36+khudpXvaU/4dktdPXcYO6a4M
	E4SO46/pfjXIw8b9H6yvQykUp2uE46IByoQtN6nuk9xMJfEc5xDACIF1JBXhnJWsDiCKJ5Wsbsskt
	ULkjlhUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQLyI-00E5nK-0w;
	Mon, 31 Jul 2023 06:01:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQLyF-00E5mc-2P
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 06:01:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE17E68D07; Mon, 31 Jul 2023 08:01:21 +0200 (CEST)
Date: Mon, 31 Jul 2023 08:01:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Varun Prakash <varun@chelsio.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
	Rakshana Sridhar <rakshanas@chelsio.com>
Subject: Re: [PATCH] nvmet-tcp: fix data digest calculation for multiple
 H2CData PDUs
Message-ID: <20230731060119.GD30150@lst.de>
References: <20230727150731.5905-1-varun@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727150731.5905-1-varun@chelsio.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230730_230131_929539_79542AE8 
X-CRM114-Status: GOOD (  12.07  )
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

On Thu, Jul 27, 2023 at 08:37:31PM +0530, Varun Prakash wrote:
> On receiving H2CData PDU current code calculates data digest for the entire
> transfer length, it works if host sends only one H2CData PDU per cmd, if
> host sends multiple H2CData PDU per cmd then target reports data digest
> error.
> 
> This issue was fixed in commit fda871c0ba5d ("nvmet-tcp: fix receive data
> digest calculation for multiple h2cdata PDUs").
> 
> commit ed0691cf5514 ("nvmet-tcp: fix regression in data_digest
> calculation") reverted the fix done in the above commit.

This simply seems to revert this revert again and not address the
reason why it was reverted.


