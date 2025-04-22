Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077C9C369D7
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 08:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qjAEaFCJA4OjppkDOoxF+thc23GKeGSOO3qTSEWnNUk=; b=xyr+EYO+4RlLWlBZ2rAcYoRvas
	+sLHb47jN9y3Ci2BLHH5GUgS/b4LV8lbetzQ5JKJGphTgzLN2Mt7YPVQyAyQa1ewOq18p5FF3zcwv
	F8BPA+Q42VC9SJD03Rw1Kt9qUx/G+ltVI4J7bBdnls5ZJ40EMgJZEtnOJ9Uhrzk9PxqZ6Z8MX2pC+
	3MvcqharMV+93X76UTnE0dO8vTulSpDgwU/RBU8qaFxLmxhzEh+M5cKGVytj3e/jPZPxHW8uXg7wh
	r11JAGKlLysflfPy/9+vjDJUjuaFcEOO/eUcZHEsEneeF8yW8QJEqzqN+X+DeQeEyfApCsSrj6d7Z
	awrsLY4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u797J-00000006LFC-0sFS;
	Tue, 22 Apr 2025 08:36:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u78Bd-000000069Bp-1vNo
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 07:36:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2CD9268AA6; Tue, 22 Apr 2025 09:36:54 +0200 (CEST)
Date: Tue, 22 Apr 2025 09:36:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, kbusch@kernel.org, hare@suse.de,
	sagi@grimberg.me, jmeneghi@redhat.com, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [RFC PATCH 2/2] nvme-multipath: remove multipath module param
Message-ID: <20250422073654.GB31849@lst.de>
References: <20250321063901.747605-1-nilay@linux.ibm.com> <20250321063901.747605-3-nilay@linux.ibm.com> <20250407144555.GB12216@lst.de> <f05dd764-9299-4c20-998a-f3b1d45bacf8@linux.ibm.com> <20250409104515.GB5359@lst.de> <e50e568c-9a9b-4306-a2f4-e108791e83d2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e50e568c-9a9b-4306-a2f4-e108791e83d2@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_003657_637390_8064F926 
X-CRM114-Status: GOOD (  16.60  )
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

On Fri, Apr 18, 2025 at 07:52:06PM +0530, Nilay Shroff wrote:
> I don't know how to make this option per-controller as you know the 
> head node, typically, refers to namespace paths and each path then 
> refers to different controller. So if we were to make this option
> per controller then how could we handle it in case one controller has
> this option set but then the another controller doesn't set this 
> option. It could be confusing. 
>  
> How about module option "nvme_core.multipath_head_always"? The default is
> set to false. So now it becomes two step process:
> 1. modprobe nvme_core multipath_head_always=Y && modprobe nvme
> 2. echo "<val>" > /sys/block/nvme0XnY/delayed_shutdown_sec     

That's probably the best we can do.


