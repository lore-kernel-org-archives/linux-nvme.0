Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AE0C433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Nov 2022 07:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7wfuoqgLHu+7PG+WgqLUhnBYtbC2HW1/NOxjIygQkX4=; b=KaKZxLhY9Ud9MbV4od2PWB0BMB
	jo7dMfgrCGKJgO2mQ04yBEdQi2abaqIo9kjyq3svx8vZY4OfythS04SddIrxwHTkm0w6NktpSdtPE
	Xp0GhQlVwErM4nfyTyTuLhLYvcK/ww6nXzXgXekPPhEiJd4yIuJwX8eJzDHsgMGEpDGCv5boYadIH
	maUZlKLTkfcu3C8oJ7YhdnJ1ihk61vO5Fv90tlpRKw+feILwYGhrwFZCGzTHvlYKjYd1HSfRPUmo0
	zsyZmgOfFhBbeULQzEtskarrbMuITk9wHc9b3R7A8ivbTxLryfNSdXeBuqKVfjMW0UXQcL4PggXer
	I/NiiuzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqqmX-002iX3-S3; Fri, 04 Nov 2022 07:06:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqqmU-002iV1-Oe
	for linux-nvme@lists.infradead.org; Fri, 04 Nov 2022 07:06:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6074D68AA6; Fri,  4 Nov 2022 08:06:17 +0100 (CET)
Date: Fri, 4 Nov 2022 08:06:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: implement the DEAC bit for the Write Zeroes
 command
Message-ID: <20221104070617.GB17463@lst.de>
References: <20221030162906.3390-1-hch@lst.de> <yq1cza8qc6o.fsf@ca-mkp.ca.oracle.com> <Y1/kw75JaNsnt1iy@kbusch-mbp.dhcp.thefacebook.com> <yq17d0gq9oq.fsf@ca-mkp.ca.oracle.com> <20221101095804.GA13058@lst.de> <yq1v8nypu8w.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1v8nypu8w.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_000622_977040_A964355B 
X-CRM114-Status: GOOD (  17.62  )
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

On Tue, Nov 01, 2022 at 11:49:06AM -0400, Martin K. Petersen wrote:
> Yep, but many device vendors messed that up due to the initial ambiguity
> in the spec wrt. how to handle the UNMAP flag. Based on experience with
> the SCSI UNMAP command being able to ignore blocks and ATA DSM TRIM
> being non-deterministic, several vendors ended up not treating WRITE
> SAME with the UNMAP flag set as a data integrity operation.

Uh.

> I was just concerned that this practice would carry over to NVMe. Bits
> 2:0 being set to 1 is an indication that somebody at least thought about
> this scenario during device implementation. But again, devices that
> return non-zero blocks after deallocate are rare and we can always quirk
> them if there's a problem.

I'm fine with adding the dlfeat check - it is trivial and if the bits
aren't set, sending the DEAC bit would be pointless anyway.  It'll just
make the people asking for names for the unnamed bits even more unhappy..

