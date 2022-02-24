Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2469C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 16:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xFtJiu3RIfsOfqxFpJSGdbtwAK16FCV3nu1/f/g2mDA=; b=aW9cX9nxDJdRwhb/vnfzVSgwjc
	zNWo4kka3rD9dK/k3g3/98dkX+GzYfQ28rcxmI0GJNHjpZ9TQ5PJ5dzIqMSxFWjKS5EZsOG+fgxst
	dJ9flECg8N6f7C8UgB4DDENzQY1nHC2a4kA2fz0T21qdQooAXHGy8ohMG84Tl0RV/9VRgu1dx9fuH
	BpJ4uYOTFPmus/cxUdqsiovQ5H1YbO+Z6mhgP9eBp15VKQyCKpSY2b0k++AIacETej86QWbmqcgjD
	yiiDSuyPItL+cebEctw7CUFpGUDr6H3zTTV8hITAVrIS8LzYuEJuByjp5xCjBSdyde1cGoq3kzh2h
	+mGHgZOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNHLU-001dHV-7K; Thu, 24 Feb 2022 16:52:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNHLH-001dCl-7q
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 16:51:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AE6F768C4E; Thu, 24 Feb 2022 17:51:40 +0100 (CET)
Date: Thu, 24 Feb 2022 17:51:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220224165138.GA32261@lst.de>
References: <20220224105852.862715-1-hch@lst.de>
 <20220224105852.862715-4-hch@lst.de>
 <20220224154304.GB2976831@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224154304.GB2976831@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_085147_442680_8069A3A2 
X-CRM114-Status: GOOD (  11.43  )
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

On Thu, Feb 24, 2022 at 07:43:04AM -0800, Keith Busch wrote:
> It looks like a race condition exists here such that two namespaces with
> duplicate IDs in different subsystems being concurrently added may not
> see the duplicate.

Yes.  But do we care?  This is a sanity check.  The alternative would be
to hold nvme_subsystems_lock for the whole ns_head probing, which is
a little annoying.

