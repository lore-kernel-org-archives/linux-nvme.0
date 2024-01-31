Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723FBC48285
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 06:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yaWYQDTLKWFQ0wLBsir1jmf7Og8ba1x0W8Ujyj7j5XU=; b=a/hLjN6viHD678RzjJkpP7uKxE
	4AtUpCGT1/vn/4JOCvsejYg2UgJJ4Ho+Ooh6CRdbuacESE/22nLHc0GvxJeKpcU2Ofel9VEpgh6WE
	vtcNzvQLroEHd6QTNTanSEv+IxBP3brJ+p3TeNI+zgk4cb8IGbzhVkZDAArr2CIWecj5alxhU2DTK
	0bbOwRKrer+15iQjIZA/ccRvzod77N7EHsUYW6Mtk2H9zTs94M6L1gJylXl6NliXo15YtdUW8lhPG
	wh26AScEGJlMbkQIC8vmphpmG1NDgMMbMaGJnzbHQl1tpPPYEal0wBsmXIFkQpJE4HK/5kXWm2o8o
	8Meh9YtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV3xP-00000001crA-0FbC;
	Wed, 31 Jan 2024 06:20:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV3xM-00000001cqc-3wOb
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 06:20:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F1BA268B05; Wed, 31 Jan 2024 07:20:17 +0100 (CET)
Date: Wed, 31 Jan 2024 07:20:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Allison <jra@samba.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jeremy Allison <jallison@ciq.com>,
	tansuresh@google.com, hch@lst.de, gregkh@linuxfoundation.org,
	rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/5] nvme: Add a new exported function
 nvme_request_shutdown().
Message-ID: <20240131062017.GB16030@lst.de>
References: <20240129181953.1183084-1-jallison@ciq.com> <20240129181953.1183084-5-jallison@ciq.com> <6dd1fc75-e5c0-4bde-94cb-b0509a5d8e3c@grimberg.me> <ZbkyfB03maJLX4aD@jeremy-HP-Z840-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbkyfB03maJLX4aD@jeremy-HP-Z840-Workstation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_222021_147509_2C182440 
X-CRM114-Status: GOOD (  13.23  )
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

On Tue, Jan 30, 2024 at 09:31:40AM -0800, Jeremy Allison wrote:
> I think the idea of adding _ctrl_ in the name is a good
> one as it makes explicit the level it's operating on.
>
> I think nvme_ctrl_shutdown_start() is the better name,
> so I'll use that for the next version.

Sounds good to me.

