Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A490C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VWuCxFBZC/ajOXbVexMsZcBeX3oC5eU0Zo5uF6huMrE=; b=CeuugFC3jbI/r9Z3yr0hVtOKjA
	FS6UtgR/W4UYMe2hyG8vwAHUdM0XrFyspzd6LjGzc50YSaAvA/OJ0Q/smd7fuIzEApgKkUN1S3tSv
	t5hsobO7BYOvb6DHkRPQchvgh/ydRbx6GqXMkVocWFwq3v+Cw7SwKmvINPl5N5tcvyz8a2wg7pq3N
	U/OZUAoEmknZ6gTR/wFNcbkCAMzfCpcG5tD5dWkak3gZBpJBY+Zbcls6ObuKXE10SqqFWQslRVu8I
	KZgHU9HKQB397ZdNII0tEzcNOwiTvKCqyiseDuI1upeDlbuswrtxxGFXXb0G6YPWLh1keHd1FQr2O
	QXkF9P9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyEJb-001gxP-5k; Mon, 06 Jun 2022 15:06:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyEJW-001gvg-Vv
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 15:06:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF7AE68BEB; Mon,  6 Jun 2022 17:06:38 +0200 (CEST)
Date: Mon, 6 Jun 2022 17:06:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Stefan <stefan@pimaker.at>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220606150638.GA9668@lst.de>
References: <6d463ee2-62d6-e36c-7059-af7fbf8639c8@pimaker.at> <20220606064055.GA2450@lst.de> <Yp4UdgApXyWTn6lm@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp4UdgApXyWTn6lm@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_080643_219619_79F14EC5 
X-CRM114-Status: GOOD (  15.81  )
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

On Mon, Jun 06, 2022 at 08:51:34AM -0600, Keith Busch wrote:
> But just fyi, this sounds like the same issue as the phison controller from a
> different brand reported below, so it sounds more widespread than just this
> particular adata model.
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=216049
> 
> The reported didn't provide the device id, though, so we don't have a viable
> patch for that product just yet. Perhaps we could add the vid:did to some of
> the messages to help shorten the report-quirk cycle.

Yes, that's probably useful.  I've also been wondering if we need a
kernel command line interface to enable quirks for given IDs, similar
to what SCSI has.  With the amount of amazingly crappy consumer devices
our number of quirks will keep growing exponentially unless we can finally
get the NVMe interop group to actually test for these kinds of real life
bug instead of silly crap like status code precedence.

