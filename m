Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D729C54E41
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Feb 2024 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f0PbvSq3nDc3j02ajfzyPPfl50MLGLwn69wzLpl02tg=; b=kib3IPhqpyWPZRM/Xk0ZPGbBAj
	Y/KbizDYTq9rq6z8eb3CcLgL4/twBhhAiAjFOm2Y0Ozz36VC//RDZGTBJRsWrDVtOYYJI1xhITTpk
	Wk4Me+uPj70AZ0UAta4BWhM9LI2zoF49utta8xzysoaryekS35D/TCtgB7z4KcjCIP7CNCdrHlREp
	l3Vjps27qa7SxUokRju8gG4fsR7meMM64YUxdScC0JQo78IctMUPpphijAExjOzA2PND6n7iybDdA
	O92NOoTUt1hsr2HEQ8f4ixVC1tWq0wMq0RjMafI0S+d40jQUzT5/jI1+fW82Nj4vEKJWvKqJ0Z4gA
	5aWvLYIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfgrB-0000000DkmT-3iFP;
	Thu, 29 Feb 2024 13:53:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfgr9-0000000Dkkz-0wRu
	for linux-nvme@lists.infradead.org;
	Thu, 29 Feb 2024 13:53:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB60668BEB; Thu, 29 Feb 2024 14:53:45 +0100 (CET)
Date: Thu, 29 Feb 2024 14:53:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/21] nvme: split out a nvme_identify_ns_nvm helper
Message-ID: <20240229135345.GA7816@lst.de>
References: <20240228181215.873854-1-hch@lst.de> <20240228181215.873854-14-hch@lst.de> <a142cd4d-bedf-4666-8dc7-fcfbfc4ebb78@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a142cd4d-bedf-4666-8dc7-fcfbfc4ebb78@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_055351_425953_3C4F116E 
X-CRM114-Status: GOOD (  14.07  )
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

On Thu, Feb 29, 2024 at 03:52:08PM +0200, Max Gurtovoy wrote:
> I actually had a similar logic in one of the patches of the PI series I've 
> sent :)
> BTW, we need only the elbaf field from the nvm response structure so we can 
> ease the code a bit and free the nvm inside the nvme_identify_ns_nvm() 
> instead of in the caller...

Ithought about that, and while it might be a tad cleaner currently,
as soon as the identify_ns_nvm structure grows more fields that we'll
use that'll get uglier.


