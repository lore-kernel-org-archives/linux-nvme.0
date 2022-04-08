Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7866EC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EkpYTbcZ9SMzh8/6bx/Q0XMM0h9RFXMFODndVc2aQik=; b=gsY91rGwS40hiGs06g6DyHL/sL
	fpqrYK3b8tVxW7vI4QZ/Gavs2ZJV5wb0N6ct2kG6mJ7nXdKyQAZ4OnLPIFLSnFyFozxzzzH0GyVRU
	QaprL/bHTcIamXfXjSbfA1RjNpkXakAl9psf1jznN+AlHhVWmVD1XAWmDddNzng6DFRvMLVZGjCM7
	KCzOC4G6SvDz8m8OlK/lIhJX8b7BON+NvDzI2fdFYorcJ9o24KYikMZ/sxZ+ksCDkuk23DrMvmlYu
	s1DQl+URi77d4C4H2gWt2ck3AIxA6iqEj4GKQk/QWUsQdGqRr0ntwkC08fRJaDBH5LqKn+gEuwGyD
	ElbytJ1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncrCN-000Q8K-KK; Fri, 08 Apr 2022 16:10:59 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncrCL-000Q7I-1F
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 16:10:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4D66468AFE; Fri,  8 Apr 2022 18:10:53 +0200 (CEST)
Date: Fri, 8 Apr 2022 18:10:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220408161052.GA28661@lst.de>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-5-hch@lst.de> <Yk+KO8hEYpnKdGu3@garbanzo>
 <20220408052907.GA31990@lst.de>
 <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220408_091057_259776_9B02D28C 
X-CRM114-Status: GOOD (  11.81  )
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

On Fri, Apr 08, 2022 at 09:19:04AM +0200, Klaus Jensen wrote:
> Odd indeed. With “legacy/single namespace” setup (drive parameter directly on the nvme device), the uuid, eui64 and nguid should be zeroed.
> 
> Using the new -device nvme-ns, QEMU will randomize the uuid. However the eui64 will be more static and only differ with the namespace id so it will not be unique across subsystems (this needs fixing in QEMU).

Well, if that is the case we'll need to quirk the affeced qemu versions
as duplicate global ids must not happen.  Can you help to come up
with a heuristic to catch to affected versions?

