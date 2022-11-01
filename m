Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9ED1FA373D
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 09:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=swzusoz02ZVbid5qbK2GIMUWxoPoF2kcpNFoG0ZQ/JM=; b=WSkN0W7tZGYi/KhEBtAM/ng3UV
	zODsEYdxNimR2nLuUJfP1VRmeGHfuf9rgue873fIKc+GIhlpeeh7scaRM2hFFEw80CdtJn5JA4Eqh
	3K3au0Y22iv3XQwWYlnakwSVsuicqgCV5yoNAqul/TgdxEN8SKnuWYS6sR2sXBhbJEPFc8zCoRmN5
	GeBJNhIriV+smLQLYaK0KMGFaPHxP975TPu1XEQnOqNn2ARWZC8MgEWCaeFNqRPtURKlo6JJ8bmrx
	0Ii6/mTtz6qEoCuzE0AgP4ZMTGqkyEa0KejwqVZeyQ3GHWP0TZflKk5UAEneq8xYShTfIEf1BsObz
	akLyOJmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opo3l-003rc7-63; Tue, 01 Nov 2022 09:59:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opo3h-003rZR-41
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 09:59:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7387668AA6; Tue,  1 Nov 2022 10:59:46 +0100 (CET)
Date: Tue, 1 Nov 2022 10:59:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: implement the DEAC bit for the Write Zeroes
 command
Message-ID: <20221101095946.GB13058@lst.de>
References: <20221030162906.3390-1-hch@lst.de> <yq1cza8qc6o.fsf@ca-mkp.ca.oracle.com> <Y1/kw75JaNsnt1iy@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1/kw75JaNsnt1iy@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_025949_366755_C6C35382 
X-CRM114-Status: GOOD (  14.65  )
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

On Mon, Oct 31, 2022 at 09:07:47AM -0600, Keith Busch wrote:
> Minor nit on the patch: I think seeing the dlfeat value as an enum would
> help.

The issue here is that the bit doesn't have a name in the NVMe spec,
so making up one would be a bit odd.  But Mike is set out to eventually
name all the bits, and if that happens I'd be glad to add a name.

That's also an argument against the check if the lower flfeat bits
that Martin suggested, which shouldn't be needed but is otherwise
harmless: due to the lack of naming in dlfeat it would be really hard
to read..

