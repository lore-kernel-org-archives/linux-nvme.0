Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC334CDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 06:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=AO2puDA8F/l8/A6qnFLHZ90uWw
	drecrVKZSdVsblDLsMSztLD9fUKpU2wWqxivUIjF1e13Vh/jX6i74S9wyBMHGuu/DuBxQLZh9iXUS
	Mw1uEegY6hk9FRSRcXwy4Ld7qq6DS2IjWW+xiVVpLexB5liF7siFR5LZwhey/0hoFkwHWFszm5BPD
	ylV7zm7uXkgOlJRf+vf4hia300WCdZi9i1yduRgoucQbIIlrsS3NjRiDadkEIjK0JOIyjZFreyqqQ
	ZDMoR1AKoRd7v/NREWuHnjhYtX8gr1JajjWt+0msJauLYQOU1yrDDk65W5udZOj7mGBXPfHak5+E5
	3I4MTsDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd078-0000000AbOK-385G;
	Fri, 26 Jun 2026 06:32:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd077-0000000AbNx-0Mt0
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 06:32:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 76BB468C7B; Fri, 26 Jun 2026 08:32:25 +0200 (CEST)
Date: Fri, 26 Jun 2026 08:32:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 01/17] nvme: update nvme_passthru_end() signature
Message-ID: <20260626063224.GA10731@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614131541.2017845-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_233233_293297_056B3B8B 
X-CRM114-Status: UNSURE (   7.66  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

