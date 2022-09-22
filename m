Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E353C6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 05:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VEUuXH1wJwT7DnWdTGmQ6tvd4zeMna005D0inzt3B/8=; b=d0eXO5D/02bn9XWRHLpREhF3Sr
	IdiR8Y8OaINWCl9OIIsM7jpIKrhZOeTCJYNlBW3l7y2xos4zT+4EbjJ+9KESeN2D/Gfbk7F1lnF5o
	gw1B7/alVqMFNpTN4i/IrTS50+1ils/g7E1QB0YxfU6oEzFP8J5RpBjCpj40Kr/nh0NzJcYnoeWR6
	6xMncznPguvGOzvgAzztCDycYvJ6iLurU2yDQ1RND6N7AGudl8oqTdLiPeyiqzWIFscjflZ33196U
	dSVMpgG8pDrLi7ny1AirqbiP+hGcw1ffdo1Pzw69BMSSHCKp15b0lvwT/4q4zZc+IZPZwtb/WWocZ
	4VhUZ8PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obFE6-00DUJU-15; Thu, 22 Sep 2022 05:58:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obFE4-00DUIx-3h
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 05:58:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 593C568AFE; Thu, 22 Sep 2022 07:58:15 +0200 (CEST)
Date: Thu, 22 Sep 2022 07:58:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Rishabh Bhatnagar <risbhat@amazon.com>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@fb.com,
	kbusch@kernel.org, mbacco@amazon.com
Subject: Re: [PATCH] nvme-pci: Set min align mask before calculating
 max_hw_sectors
Message-ID: <20220922055815.GA27619@lst.de>
References: <20220920191932.22797-1-risbhat@amazon.com> <871c0e19-9272-e92b-28dc-a50ae705bba8@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871c0e19-9272-e92b-28dc-a50ae705bba8@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_225820_314196_DE87DB96 
X-CRM114-Status: GOOD (  15.88  )
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

On Wed, Sep 21, 2022 at 11:10:58AM +0300, Sagi Grimberg wrote:
>
>> If swiotlb is force enabled dma_max_mapping_size ends up calling
>> swiotlb_max_mapping_size which takes into account the min align
>> mask for the device.
>> Set the min align mask for nvme driver before calling
>> dma_max_mapping_size while calculating max hw sectors.
>
> Does this fix a specific bug? if so it needs a fixes tag so it can
> go to stable backports as well.

Hmm.  Basically this is another fixlet for nvme on swiotlb, which
already drove adding the max_mapping size and the align_mask, and
it seems we still hadn't covered all corner cases properly.  So
I think it basically has been broken since day 1, but nvme on
swiotlb only started becoming "interesting" with the trusted
hypervisor schemes.

