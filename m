Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194CEC30658
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 05:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ejr2RXw1WOuLvxvWEI1bL3xjzRwQvkL5exk8a2bVl4=; b=ODfiAAroAciGykyCMH5v7xLV3u
	N16i1eD0rfmFfAzaZG9FVDDdzEhZf8qBSgPOg4ra6+ZRMWE9n/Sa39MhkArwQfOAa8fMiucGfIH1x
	PRoTUNVFD7m+ydKW45TzKhFjDh4/lcHXqTQoij5caF2BefprIVQAxSjYp0C/ykufShHhls8ZUTwuW
	F50/cYUlJceaxlJ2rejVqlpsZXvTcC/hp0mXP4aOBYXDLtpDZnsmqsUcF+iUhN4lO/bfbzLX+RbLf
	lDoM/dLEpLEcQy0vrynCQOhkVJwJz4L3OEjJ08C8q9j+1hk/0XVNNpOsh3ZDv5+YvCSWGYxZ95cU8
	nlq9MFsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOVgp-00000005YLd-3hox;
	Tue, 02 Jul 2024 05:04:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOVgm-00000005YJE-16Ft
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 05:04:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 632E168B05; Tue,  2 Jul 2024 07:04:14 +0200 (CEST)
Date: Tue, 2 Jul 2024 07:04:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 3/4] driver core: shut down devices asynchronously
Message-ID: <20240702050414.GA22160@lst.de>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com> <20240626194650.3837-4-stuart.w.hayes@gmail.com> <20240627055515.GC15415@lst.de> <8a7ae125-883c-4c45-8b89-791066fb5866@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a7ae125-883c-4c45-8b89-791066fb5866@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_220424_465035_3C4E7978 
X-CRM114-Status: GOOD (  24.71  )
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

On Mon, Jul 01, 2024 at 12:57:40PM -0500, stuart hayes wrote:
>> We discussed this before, but there is no summary of it and I of course
>> forgot the conclusion:
>>
>>   - why don't we do this by default?
>
> It is done by default in this version, for devices whose drivers opt-in.
>
> In the previous discussion, you mentioned that you thought "safe" was the
> only sensible option (where "safe" was driver opt-in to async shutdown)...
> that is the default (and only) option with this version.  Greg K-H also
> requested opt-in as well, and suggested that "on" (driver opt-out) could
> be removed.
>
>>   - why is it safe to user enable it?
>
> I guess it isn't necessarily safe, if there are any drivers that can't
> handle their devices shutting down asynchronously. I thought it would be
> nice to be able to enable driver opt-in from user space for testing, before
> changing the default setting for the driver.

I was mostly getting into the contradiction that either we think the
async shutdown is safe everywhere, in which case we don't need a driver
opt-in, or it is not, in which case allowing user to just enabled it
also seems like a bad idea.

> I can correct these lines. I thought that an 80 character line length limit
> was no longer required, and saw another line a few lines above these that was
> even longer... and the checkpatch script didn't flag it either.

checkpatch is unfortunately completely broken, it flags totally harmless
things and doesn't catch other things.  > 80 characters are allowed for
individual lines where it improves readability.  The exact definition
of that depends on the maintainers and reviewers, but outside of
string constants I can't really find anything where it does.

