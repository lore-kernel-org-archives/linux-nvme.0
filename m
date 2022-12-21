Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17971C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=beJP4Kkr6h/TSuOC2Qdh8B/D19ZPOqfTigW9Np05uSM=; b=3WhY7MoxLtybrB/112jNktqAcX
	EBBFBODqbXbCAh9lBjZpfPmKPkB43fV+4Y6/efJvkaW8pvnR+IkVdmTkHiEYmgOVTkbDleuSHVMyM
	4v4ZbMNr4FE8M6GtOWri/D19s+qvSCm9ntHv+CMqT3xwIAerXqR0YSVlaGSC2vUSpgTa0IrlNZ4nx
	u8wUylp1GwcwYIPsYh6kUWfEPx0lrvLvd/fLDTTqPevv0rLw5FWmp03bWm+YdzQxiYxiD3n8ycrid
	SyhlP3K40w77/PEVxPIrIYqh8XmOOqWEl3e1P1KJk7GXrtVT8o3f3xzihSO8iDilR4mfPX2ZYnKjF
	HB5AKKWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p80LA-00FjTv-Gy; Wed, 21 Dec 2022 14:45:04 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7zPf-00FExf-Pa
	for linux-nvme@lists.infradead.org; Wed, 21 Dec 2022 13:45:41 +0000
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 93009377;
	Wed, 21 Dec 2022 13:45:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 93009377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1671630333; bh=beJP4Kkr6h/TSuOC2Qdh8B/D19ZPOqfTigW9Np05uSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M/yTZSKLUuE/4gSu73sQpKftAaDPNioV00WJlWxHkM984l79P3miE6ozHL2971BcL
	 sCpK6Vnme6hcPU4TElZkLAV9opZwnlH0NMxxkmoAPRnA+Tb4xdnNCFUsdFOKottDjK
	 YWx9B3VyiZvBTsSnRWzOU7N0e1EZuUodYTJMg9WLS1fK1dJ6e2mxIFbOAUIHXkGIGq
	 W+79MiRh991nxm7gL3piE2D7YszQcFSIYf0M6YA3Wr0/3jhDZZO8pORUvtZV5SDLXl
	 pvOiSYSc14RBoTXd7e5dsj5CG+SeYa87mjkkdDwqnqNNPcKmYznwf5kvHWZaQ0WB6x
	 s59EuAWyoFFZw==
From: Jonathan Corbet <corbet@lwn.net>
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
 kbusch@kernel.org, linux-nvme@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
In-Reply-To: <20221221083450.GA23903@lst.de>
References: <20221215125130.261098-1-hch@lst.de>
 <87zgboddb7.fsf@meer.lwn.net> <20221215132622.GA21083@lst.de>
 <20221221083450.GA23903@lst.de>
Date: Wed, 21 Dec 2022 06:45:32 -0700
Message-ID: <87mt7g27lv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_054539_910767_3F1DDEBB 
X-CRM114-Status: GOOD (  17.99  )
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

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Dec 15, 2022 at 02:26:22PM +0100, Christoph Hellwig wrote:
>> On Thu, Dec 15, 2022 at 06:08:44AM -0700, Jonathan Corbet wrote:
>> > The document looks fine, but I do wonder if it wouldn't be better placed
>> > with the other maintainer entries in Documentation/maintainer?
>> 
>> Hmm, nothing in there looks very similar to me, while process
>> seems to have real policy documents.  But we can live with either
>> place.
>
> Any strong arguments for moving it Documentation/maintainer?
>
> I'd like to merge this with the fixups from Randy through the nvme
> tree ASAP, and need to decide on the location.

Sorry, the argument is that the subsystem profiles there were created
for the very purpose of documenting subsystem-specific patch policies
like those found in your document.  The hope is that, someday, people
will be able to go to one place to learn what special hoops any given
subsystem will make them jump through.

This isn't something I'm going to dig in my heels on, though.  But at a
minimum, could you add an entry to
Documentation/maintainer/maintainer-entry-profile.rst ?

Thanks,

jon

