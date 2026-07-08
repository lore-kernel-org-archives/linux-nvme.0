Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C15C43458
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ta1LvuxtTvBLeSagRyjO44/xlj15EWzcg4gKDuWwVVc=; b=NFIAqSlWr7i/qy6f+1/eBkP+VG
	GGtpUaqHC1FW7OLvxldnXJvEl/NuOLsEUKvwWlnmz5+ysmZOq1oV5F+c4rJuq+hJlqt2yxL1hgrgq
	sWqz77Y1tHeEEwdabVuGsi5xT/IL4IbOLXPhQNAt5YmtEN3oulTqMqaFSKR3s2BcLF3kn7gFFTORU
	APOs8qDFnHcxktVH/SIKIOFs6sXgZbOE/0m9N28iqrT1Omk0oNqUq8TBQe3OlTp7lwy6t8dgWMMWE
	POVDYOPISOQzMViPA8Qur7IUVvlXCxx1L9FSAMP5ot0AOPE4BoFyYaZz39VJS7EAHAdRkTXNGdcUq
	wD3+vuqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whUz8-0000000HaEO-3wFP;
	Wed, 08 Jul 2026 16:18:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whUz6-0000000HaDV-1CFq
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jul 2026 16:18:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B81A668BFE; Wed,  8 Jul 2026 18:18:46 +0200 (CEST)
Date: Wed, 8 Jul 2026 18:18:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC] nvme: fix NS head cdev lifetime
Message-ID: <20260708161846.GA2262@lst.de>
References: <20260706130146.617258-1-john.g.garry@oracle.com> <20260708092740.GB6513@lst.de> <d27cb4a8-cf04-40ac-a271-c7d83dadc8a1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d27cb4a8-cf04-40ac-a271-c7d83dadc8a1@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_091852_472588_315D3F02 
X-CRM114-Status: GOOD (  19.74  )
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

On Wed, Jul 08, 2026 at 10:57:02AM +0100, John Garry wrote:
> If we put the nvne_ns_head (vs nvme_ns) in the driver data, then I can't 
> see a check to know is the driver data points to a nvne_ns_head or nvme_ns. 
> Unless we keep NULL for one, but that is not so nice.

I think NULL just for one is fine, and I'm pretty sure we already do
something like this in the nvme code (or at least used to in the
past).

>
>> but shouldn't we warn for the nvme_tryget_ns_head failure as well?
>> Or can that even happen here?
>>
> It should not happen as we have a pointer to nvme_ns_head. If the recount 
> was zero and we referenced ns_head, then we have bigger problems.

That's what I though, so we could do a plain kref_get here.
And maybe replace the annoying krefs with a plain refcount_t one day.

