Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2741E9537E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=kI7g9xnk+PDZC0qJXy0MsDOIVC
	blZsvVZicccMbqmBdSBx8LuTe9hWBFURWwD5/Hke1oQ0m86ODxk/qHBSVZ5PH8KWHDc0zG1bbHt2I
	n9vG5K9GZ5UNpTXGjPYUTJK7sd1Z6lAjrMuYsseogJPu69TT1tiJBO/kuwAOMXRUuX65Y9ELs24Hq
	nQoWOUxmemQ8NmRRrsgNcVZkY48u+mP8U6Yfs9o6WRWJphv+vEDcnqm7Kj3WEwFMyHR6G0l3YbG8V
	kM/SPxusKv305O0qMB5eTbQYLXWi5GInZPkjEMRi9n0RQ4k/nsUoF/60q56K4k10vWDvfI9CtEuc7
	UWcTedfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnahf-00000008KSI-2J49;
	Wed, 04 Feb 2026 11:05:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnahc-00000008KQp-2nVX
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 11:05:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C10A6732A; Wed,  4 Feb 2026 12:05:40 +0100 (CET)
Date: Wed, 4 Feb 2026 12:05:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
	dwagner@suse.de, hare@suse.de, jmeneghi@redhat.com,
	emilne@redhat.com, mlombard@bsdbackstore.eu
Subject: Re: [PATCH V3 1/1] nvme: add support for dynamic quirk
 configuration via module parameter
Message-ID: <20260204110540.GA6231@lst.de>
References: <20260204105555.173661-1-mlombard@redhat.com> <20260204105555.173661-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204105555.173661-2-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_030544_845670_C553684C 
X-CRM114-Status: UNSURE (   8.85  )
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


