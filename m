Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82842CA0EF8
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 10:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=54LF51HHxq2Wl+hhuJ+Et+s0H9E/BboYvNSrUenLqSE=; b=1YgKkYNgirqWOH0eFwsmkRfHv+
	rIRQMcO6aUik34yWICdpXDxRm1RIVALKGG7e71Nkkf7d9w2ZilNBpvmw/YY1EO4vAFy8kCovnN6Dl
	O5h8zUdpUK/AxCVvtpRUmTRupa+lWUKCIxrdCn9o4ZfyFrGJ+6N/7uDlX+8FcvNL9Sq+f1QoQbe1s
	TMeOZOHdJ4KovJSqybkaGxsSt4S7MXfepQHtAbcpd3iIbqPsk3J2edZ+c6LlxgKACJ331/+n6Bnq+
	3P/FX3xxicDFe0YUkZBWgwp4Z3htsVpaABt4EncMNIwI09ZjDvM/pDFl07UXedBdSpcEGjpvnNB1x
	1eH2OYXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up2aF-0000000Gcch-0N2r;
	Thu, 21 Aug 2025 10:31:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up0lq-0000000GGpG-1uwG
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 08:35:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 17E06227A88; Thu, 21 Aug 2025 10:35:38 +0200 (CEST)
Date: Thu, 21 Aug 2025 10:35:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, nilay@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, mcgrof@infradead.org
Subject: Re: [RFC PATCH] nvme: add an opt-in to use AWUPF
Message-ID: <20250821083537.GB29224@lst.de>
References: <20250820150220.1923826-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820150220.1923826-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_013542_631702_9B1DB9B3 
X-CRM114-Status: GOOD (  11.47  )
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

On Wed, Aug 20, 2025 at 03:02:20PM +0000, John Garry wrote:
> As described at [0], many parts of the atomic write specification are
> lacking.

I like your british understatement.

> +	list_for_each_entry(tmp, &subsys->ctrls, subsys_entry)
> +		nvme_queue_scan(tmp);

queueing a full rescan here seems expensive.  What about just keeping
the awupf value in our internal data structures and always use it
for the physical block size calculation, but only apply it to the
atomic limits based on a flag?


