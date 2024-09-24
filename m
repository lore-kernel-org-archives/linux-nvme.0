Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A476CF9C71
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 05:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CJO1+eknrcO/xCcK/ZREiK1Tk/lTFRx+Valy0zXDX1Q=; b=uUArHiRqdTnohC2ptS1a81jN9p
	6CUb/e1wLb0LLD3MVwwQxr9LM9ORtL5vLc4bWrhDYYF+LWVLJ4N9mub5EXYsXx8T3NWTtXMI33lHP
	y8zPbxHFDP32DpZ/M8XB9NZs5xzluNFYwNMZi5AS6wvGGfkTefzo93yfpbcpg6NAS5/M7XKHrJ3ci
	l6N8p5JbmcD3HHLDifCbUk5n5T9L48FzfSOzCcrKLCkV6QfKX/zIVljxs6shlVsxUaUISYMc0XcyZ
	NvszTmv/085IfCckUGk6/ycnlw9+DLMKM+5t4EmPzH7+Qng1dlui4e4/t8XZ1PJ/MiZEAq5dgsI7p
	5P7aYyig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssyEF-0000000186A-2xNt;
	Tue, 24 Sep 2024 05:36:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssyEC-0000000185g-2FTr
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 05:36:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E783227A8E; Tue, 24 Sep 2024 07:36:44 +0200 (CEST)
Date: Tue, 24 Sep 2024 07:36:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: fine-grained PI control
Message-ID: <20240924053644.GA10569@lst.de>
References: <20240705083205.2111277-1-hch@lst.de> <yq1ttgz5l6d.fsf@ca-mkp.ca.oracle.com> <CGME20240918064651epcas5p418d61389752da25e5fc50e6a50a111b8@epcas5p4.samsung.com> <20240918063910.hqntgm5jy2jisys2@green245> <yq1bk0dhlko.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1bk0dhlko.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240923_223648_741922_06CF3FAB 
X-CRM114-Status: GOOD (  12.90  )
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

On Mon, Sep 23, 2024 at 09:59:10PM -0400, Martin K. Petersen wrote:
> Originally we had code in Linux allowing filesystems to attach
> additional metadata to bios which would then be stored in the app tag
> space. This was intended for backpointers but never really took off.
> However, if we move the burden of PI generation to filesystems as
> Christoph suggested, then we can revisit using the app tag space.

Just to make clear I want file systems to be able to opt into
generating PI, not get rid of the auto generation.  That is actually
kinda possible already, I just want to make it nicer.


