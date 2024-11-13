Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647E7D41C01
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 04:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6BYagoCnPbssPZEJcMZhMZZNAAo/0TH0PAINX/aRqhI=; b=b+COx3NZ8NnYL+NhdqVuZddmLk
	1WSwc29+v4CHnkiP4mrIWuK5b/Iyu4XtRt0YEq3TYudk05dJfrTAn/1fccpombWs/4d53KpkvGE47
	u5hiuGr2FNtY/0rK+UpzPx9RkDECMCHF3Th7bE5oLF4hLcgo+qpQxspR9pvOVSFRe8zMbYs+3iIZn
	N6/r5THCo/5puhB2zVzSFDNEUalWWbQXfVDZZMz0fK185+TjvE9YQRTRM5YkHTRDO01nUUaPNGKj0
	X/PsFvv90NNnF6vDfubbhWkHTgaXPUdkRUgZ8BpCQk64YZ3QiRry8jaylDVE+qRUkCK2pZRVhiaKn
	YRMZZtnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tB5IA-00000005kqb-1sEU;
	Wed, 13 Nov 2024 04:47:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tB5I7-00000005kpj-3O6k
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 04:47:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E9B968AFE; Wed, 13 Nov 2024 05:47:36 +0100 (CET)
Date: Wed, 13 Nov 2024 05:47:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pierre Labat <plabat@micron.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>,
	"javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [EXT] Re: [PATCHv11 0/9] write hints with nvme fdp and scsi
 streams
Message-ID: <20241113044736.GA20212@lst.de>
References: <20241108193629.3817619-1-kbusch@meta.com> <CGME20241111103051epcas5p341a23ed677f2dfd6bc6d4e5c4826327b@epcas5p3.samsung.com> <20241111102914.GA27870@lst.de> <7a2f6231-bb35-4438-ba50-3f9c4cc9789a@samsung.com> <20241112133439.GA4164@lst.de> <ZzNlaXZTn3Pjiofn@kbusch-mbp.dhcp.thefacebook.com> <DS0PR08MB854131CDA4CDDF2451CEB71DAB592@DS0PR08MB8541.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR08MB854131CDA4CDDF2451CEB71DAB592@DS0PR08MB8541.namprd08.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_204744_155978_B2ABBA36 
X-CRM114-Status: GOOD (  25.31  )
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

On Tue, Nov 12, 2024 at 06:18:21PM +0000, Pierre Labat wrote:
> Overall, it seems to me that the difficulty here comes from 2 things:
> 1)  The write hints may have different semantics (temperature, FDP placement, and whatever will come next).

Or rather trying to claim all these are "write hints" is simply the wrong
approach :)

> 2) Different software layers may want to use the hints, and if several do that at the same time on the same storage that may result in a mess.

That's a very nice but almost to harmless way to phrase it.

> About 1)
> Seems to me that having a different interface for each semantic is an overkill, extra code to maintain.  And extra work when a new semantic comes along.
> To keep things simple, keep one set of interfaces (per IO interface, per file interface) for all write hints semantics, and carry the difference in semantic in the hint itself.
> For example, with 32 bits hints, store the semantic in 8 bits and the use the rest in the context of that semantic.

This is very similar to what the never followed up upon Kanchan did.

I think this is a lot better than blindly overloading a generic
"write hint", but still suffers from problems:

 a) the code is a lot more complex and harder to maintain than just two
    different values
 b) it still keeps the idea that a simple temperature hint and write
    stream or placement identifiers are someting comparable, which they
    really aren't.

> About 2)
> Provide a simple way to the user to decide which layer generate write hints.
> As an example, as some of you pointed out, what if the filesystem wants to generate write hints to optimize its [own] data handling by the storage, and at the same time the application using the FS understand the storage and also wants to optimize using write hints.
> Both use cases are legit, I think.
> To handle that in a simple way, why not have a filesystem mount parameter enabling/disabling the use of write hints by the FS?

The file system is, and always has been, the entity in charge of
resource allocation of the underlying device.  Bypassing it will get
you in trouble, and a simple mount option isn't really changing that
(it's also not exactly a scalable interface).

If an application wants to micro-manage placement decisions it should not
use a file system, or at least not a normal one with Posix semantics.
That being said we'd demonstrated that applications using proper grouping
of data by file and the simple temperature hints can get very good result
from file systems that can interpret them, without a lot of work in the
file system.  I suspect for most applications that actually want files
that is actually going to give better results than trying to do the
micro-management that tries to bypass the file system.

I'm not sure if Keith was just ranting last night, but IFF the assumption
here is that file systems are just used as dumb containers and applications
manage device level placement inside them we have a much deeper problem
than just interface semantics.

