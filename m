Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909EDC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 13:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eOU/4kgdYa1NmofrKSxxCaJEpCEXiIYHJ7aAx/AF+Gw=; b=o0rGg4yRRAtfF9EvzteRft9cQ3
	T2lzKOFHD22hc5q2vE6dGl5Yrkew8KfgYmF0YLA3cuKv4sgWAyi76rBiV8PNeYdTreehp64mnWDCZ
	/3Kp8+bltyAsYsopS6dZF7/RByMS0knjdWMsQzlMFVLJUMaXbd86xRKUfHYfqqVKU5pWQtQMNVe10
	vBsqyZ2gF76Bq0dVgr4e31CnSClT5/Te5cZ4MCaRVHVjvxIXtuN9yrF8zJ2KlCwVcZKvtuDOSsbsY
	SKVfZsaQsgDG12SgtA71Tw6ydU4VFpJ5ENWdMCeOhJMCzNO4bz11zHZ6f+tPD/0R5gfDLu3O5urUf
	AkcWRbQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA8J0-00000006Kn7-3KXz;
	Thu, 23 May 2024 13:16:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA8Iw-00000006KmY-1nyS
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 13:16:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F59E68BFE; Thu, 23 May 2024 15:16:17 +0200 (CEST)
Date: Thu, 23 May 2024 15:16:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	sagi@grimberg.me, emilne@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, jrani@purestorage.com,
	randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <20240523131617.GA23604@lst.de>
References: <20240522165406.702362-1-jmeneghi@redhat.com> <Zk4sEpypKqeU67dg@kbusch-mbp.dhcp.thefacebook.com> <20240523064525.GA28524@lst.de> <fe13bd05-76c5-4bf8-bfda-f9ecf08b2272@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe13bd05-76c5-4bf8-bfda-f9ecf08b2272@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_061622_630261_5424CE49 
X-CRM114-Status: GOOD (  12.45  )
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

On Thu, May 23, 2024 at 09:12:21AM -0400, John Meneghini wrote:
> On 5/23/24 02:45, Christoph Hellwig wrote:> On Wed, May 22, 2024 at 11:32:02AM -0600, Keith Busch wrote:
>>> Christoph, Sagi, 6.10 merge window is still open and this has been
>>> iterating long before that. Any objection?
>>
>> No, it's not.  The window for development closes with the release for
>> 6.9.  New features must be in before that.
>
> So what's the next window for new features?  6.11?

What else?


