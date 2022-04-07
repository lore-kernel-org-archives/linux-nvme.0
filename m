Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67A8C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uP/q/CpvaYWAuV1HMtYwRkzIT9M1P6gnh9ZF4CF1cpU=; b=iKmSva8p2P3oxtTnxaJPPZqRYj
	zI6KD9aeA6R9EebaNcAPeFGbQW+Oy8CLQoRXuRvgnGvNjSLEwDIdvcUsnBjB5fY+KHs44xb9mUoYf
	qgWHlPUIQHQBo7ujKz6Dbqv51JQ9HquWWZ7iM2I9g2qj09HIDnOGhiBUw0C9CZzgoPnVtKN7EUImu
	07R+1VkDBEeeRid2qs4+AqpMLnuCTYxqrn2guXN2Fj7inARZvw3T3U6GCGNlC8x7EDNSTL6hYUZrc
	RSk+D+PrxiIoKmV/OkzhUClrja46UqufFognudVEVYCplZw3VtfYdI3n5h9YN9MCzJkEaTE7sRPT6
	AJcHoBkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncSH1-00CAHf-Kh; Thu, 07 Apr 2022 13:34:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncSGz-00CAGK-1m
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 13:34:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D933668AFE; Thu,  7 Apr 2022 15:34:01 +0200 (CEST)
Date: Thu, 7 Apr 2022 15:34:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in the
 discovery log page
Message-ID: <20220407133401.GA7294@lst.de>
References: <20220407104808.29007-1-hare@suse.de>
 <20220407104808.29007-4-hare@suse.de>
 <81dd2585-3c71-370f-70da-302072f3e9af@grimberg.me>
 <f28bed4d-a5a5-b1e4-020e-c76ded479c5b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f28bed4d-a5a5-b1e4-020e-c76ded479c5b@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_063405_287414_AFCE9D8F 
X-CRM114-Status: GOOD (  13.00  )
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

On Thu, Apr 07, 2022 at 03:31:51PM +0200, Hannes Reinecke wrote:
> On 4/7/22 15:29, Sagi Grimberg wrote:
>>
>>> When a per-port discovery subsystem is used we should include
>>> all configured ports in the discovery log page, not just that one
>>> through which the controller was connected.
>>
>> Why?
>>
> Because that's the whole point if it being configurable.

I'm really confused about this.  Please try to explain "the whole point"
a bit better.

