Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2D3C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 10:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FOEMKh6uq2RwXPpRw8Og9sgBtzLkE0l3csvPd3bdlK8=; b=yLRlNPPHzdwrojd3pPNv3WZ3yD
	EDnQQivHXexrnprdk7imdbfUbyPSGxOhxQUDgtneFo3/btW0n21/Lk00m4JYKL8N7NncO7bVCJ0uf
	eCzLsgwHRSPZVGWUhuYYFZA1LgFozrwQxx1gpIcKYLD/5316lYZw9SY/dHi3Ak8luizqhoyOA2D2t
	1ZZowfHl4BCl9df8U4DhxEOV8UQzq3gUIskMNi+lDVM8aGHTbPfBeEL2H9pGq+K4GO1MdIJkKMc+b
	AhmP5q7A5XnLqrQQxbrYoCB7iUSRovExYATmm+8fznqqUfIAS2oGs7IaJ55/82gs8y52lKc73CpHV
	4APvOtvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPitY-0065yl-Bp; Thu, 03 Mar 2022 10:41:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPitU-0065xd-S1
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 10:41:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3742968BEB; Thu,  3 Mar 2022 11:41:04 +0100 (CET)
Date: Thu, 3 Mar 2022 11:41:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Adurthi, Prashanth" <Prashanth.Adurthi@netapp.com>
Cc: Christoph Hellwig <hch@lst.de>, Randy Jennings <randyj@purestorage.com>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Prabhath Sajeepa <psajeepa@purestorage.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Uday Shankar <ushankar@purestorage.com>,
 "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: Native multipath across multiple subsystem NQNs
Message-ID: <20220303104103.GA14744@lst.de>
References: <20220211220714.GA370236@dev-ushankar.dev.purestorage.com>
 <20220212063422.GA16561@lst.de>
 <20220212212221.GB1660900@dhcp-10-100-145-180.wdc.com>
 <20220214081252.GA18231@lst.de>
 <20220225001547.GA3454995@dev-ushankar.dev.purestorage.com>
 <20220225005306.GA904231@dev-randyj2.dev.purestorage.com>
 <20220301110840.GA2005@lst.de>
 <2A0F911A-7900-401F-B75B-7D0C2866C33A@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2A0F911A-7900-401F-B75B-7D0C2866C33A@netapp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_024113_096146_541AB10F 
X-CRM114-Status: UNSURE (   8.46  )
X-CRM114-Notice: Please train this message.
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

Hi Prashanth,

your mail client completely messed up the quoting so I could not easily
find what you actually wrote inbetween the full quote.


