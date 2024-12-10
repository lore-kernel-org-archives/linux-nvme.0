Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F280AE7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 07:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1YzGj78D+UvcHXVFubR27MR3Mg1f/0dznaLFRM6PIhY=; b=xFgEz1gmmFaVVmyG8//7z8jvJi
	UamS2js4OWCeATAdu2s9oGBSHwQhE9hDi8yxiulQfncepLI6NMMYCyWMHcOBIv1XZDS2yEZv6BhSl
	i/J0clQSThPg5d4ui2iG3Dt4bGAWCj9e4kq5NjLBPTPgl1jstS9Lb2p9LaSkcxBzEuFkBeTagLo0y
	d2UKLBKf9QBZkBVr1pREjiiDTrysuZquQvpO0/QJ2S1XOUQ0bHwVlxOETq2CESfF8l/s/Xgu9EgFD
	KQDwsr1VTjD6tHraqgOVH/KQbP71lw167LOK3VqwPScwQGDFjkRFIxpxeL4CH0Aiq+7gaCXtP1gyw
	Wgo7T7MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKuQY-0000000AWPJ-3Hhl;
	Tue, 10 Dec 2024 07:13:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKuQW-0000000AWOa-1TVO
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 07:13:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A863168C4E; Tue, 10 Dec 2024 08:12:54 +0100 (CET)
Date: Tue, 10 Dec 2024 08:12:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Javier Gonzalez <javier.gonz@samsung.com>,
	Matthew Wilcox <willy@infradead.org>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <20241210071253.GA19956@lst.de>
References: <a7ebd158-692c-494c-8cc0-a82f9adf4db0@acm.org> <20241112135233.2iwgwe443rnuivyb@ubuntu> <yq1ed38roc9.fsf@ca-mkp.ca.oracle.com> <9d61a62f-6d95-4588-bcd8-de4433a9c1bb@acm.org> <yq1plmhv3ah.fsf@ca-mkp.ca.oracle.com> <8ef1ec5b-4b39-46db-a4ed-abf88cbba2cd@acm.org> <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com> <CGME20241205081138epcas5p2a47090e70c3cf19e562f63cd9fc495d1@epcas5p2.samsung.com> <20241205080342.7gccjmyqydt2hb7z@ubuntu> <yq1a5d9op6p.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1a5d9op6p.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_231300_531629_EFD451BB 
X-CRM114-Status: GOOD (  12.75  )
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

On Thu, Dec 05, 2024 at 03:37:25PM -0500, Martin K. Petersen wrote:
> The problem with option 2 is that when you're doing copy between two
> different LUNs, then you suddenly have to maintain state in one kernel
> object about stuff relating to another kernel object. I think that is
> messy. Seems unnecessarily complex.

Generally agreeing with all you said, but do we actually have any
serious use case for cross-LU copies?  They just seem incredibly
complex any not all that useful.


