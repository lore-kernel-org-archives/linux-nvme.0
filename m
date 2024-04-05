Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7193AC67861
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0r0sJ6YigZjoyHye3XS3rWn9OA+3tvfWQJ6eaNd8K7I=; b=wZ/3SL2WCPPUzNO/4lKmvi5Smh
	wyHCNMP51aOzOhZcNC/l0g+hmAmtNfF0WMzjzip1r1RCUIdTk6aEZXQmArwctRRd4RFjS2JGbmUrU
	B8NK/mEmQZbyVsfOhtA0s1cR2MGowzgKUpvtXlk/kMNWmDVrt7TqxKADAO54O1eo+3aJZaUkrusfN
	5y35KmaBHCB6DWoOBZEqCPJ+B8wNrR7vxhjH5eDbX85MUpqno5fU1KVbSW7hxXDGxp1Jpxh6KcSbO
	dw2UZzB1XB+aDqtmRTEkUvxPXeXVnrMfl94E04LKiYAwqgHtgdl1eQ3Y6jRSLjatLic8r95h93Gxm
	rlORV98g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsktc-00000007a3e-0Fmr;
	Fri, 05 Apr 2024 14:50:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsktZ-00000007a2B-0uVN
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 14:50:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8DC3368D07; Fri,  5 Apr 2024 16:50:17 +0200 (CEST)
Date: Fri, 5 Apr 2024 16:50:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v4 3/5] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
Message-ID: <20240405145017.GA6844@lst.de>
References: <20240405062055.GC3107@lst.de> <3qh6d2fensgck2rodnbhreirfwkf7lloqwvk6gyfafu4fvgxss@jxb4b4kzu224> <20240405144752.GA6352@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405144752.GA6352@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_075021_818842_CF62A65C 
X-CRM114-Status: GOOD (  16.32  )
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

On Fri, Apr 05, 2024 at 04:47:52PM +0200, Christoph Hellwig wrote:
> > Are you sure I should map this to errno codes and the back to NVME
> > status codes? Sure, this is possible but don't really think it makes
> > sense.
> 
> No, but we should not overload the return value.  Pass in the req
> or sq, or add a new paramter for the auth fail reason.

Or make sure all returns are the status codes, change the return
value to a u8 and clearly document what values it returns if that
works out.

And while you're at it please fix all the overly long lines.

