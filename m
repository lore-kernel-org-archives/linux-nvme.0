Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E4AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 18:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6biFt4HB8pzwrPPto0vC1YeEsbVIVy6n7qB6i4uONWk=; b=IesCzoaHXe9WenuJNw3ixIWIoG
	2/yZwhicoqBBMAIJYhSMWqeGHF1lm/2+tjE5uLNLE6ejfiPf16P0WXpRyXtWHshjAB9/p9h28kqeJ
	dkVlj84qswai36hB49eb0TRMI9FEE67UZU+y3siI/3mL1R7PvWyrSYqQpj+IFFAJZK+6BWsLnI+GR
	nfk0/1k94gtOH8V5rKPsCMZC5psHzjVUjEySgUPJPzXtYoIFV5iLPPVtNFnD8FLEsT9NXZV9ffrWZ
	e8QtOzNNGKvOG7DQGVkO035taQvIbUUpbQeNZbODTwV9VPOcNMlQ0DmLnewOu8HfbEhQy/1QiY56X
	nTz5euig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK2mS-00488m-CG; Tue, 15 Feb 2022 18:42:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK2mP-004881-7m
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 18:42:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BCD8468AA6; Tue, 15 Feb 2022 19:42:21 +0100 (CET)
Date: Tue, 15 Feb 2022 19:42:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 0/7] nvme: cleanup ida_simple_[get|remove]
Message-ID: <20220215184221.GA24543@lst.de>
References: <20220214090732.479193-1-sagi@grimberg.me>
 <c6d8ce0b-7d75-7d6e-ecc7-e505de85aa4e@nvidia.com>
 <02763496-0104-4616-ef57-117eb741b82e@grimberg.me>
 <fd7fe925-370d-b369-97ce-119b852248c9@nvidia.com>
 <705ce6ee-3c1a-c4a0-1662-2f0794b1a6fe@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <705ce6ee-3c1a-c4a0-1662-2f0794b1a6fe@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_104225_446187_0C8B7DF6 
X-CRM114-Status: GOOD (  11.72  )
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

On Mon, Feb 14, 2022 at 12:59:49PM +0200, Sagi Grimberg wrote:
>> I did cc you, here is the link, somehow it takes a while to appear
>> on the mailing list than it appears in my mail box :-
>
> Yea, got it, just a tad late...

So which of the two versions should we go with?  Either one will need
reviews :)

