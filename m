Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBECCDB483
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 14:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l0Wdhjfw3olsB+qL4N/Mb16zdAUjaAEj0ZmM4ZBQEqM=; b=N3mApR7P2lRqbsTwX4QGspOZ8x
	4RnScfExBGbI99wiVeQWrmonMsPasRf2LQqDxJK5uTgOkN7hNW8FGB6PHPCyYPu8yJ8hfD67drMIT
	u9Ql0uYq1e2t3S7C3l0Zi2m9GNcOqhaJgPjEXe4pbaDVnt/QvDlBlCrqywauwChd/cj5/7ho8zJLY
	wfxlTeRLd1MZ4Sg4LP6HtOUpBcSHMepxpDhf14+fuWFaxtyFiyTZf84/94w7CcIknKY23uKJ0JGn1
	oiCSg5Q5iGavOGBd/QscwJ0GbAIi+W+631R4xnytwISelb1fboIM2bXz0cw/7PaksqvmvMz5EvqC+
	/xatqmUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrIvS-003ZQW-2O;
	Fri, 13 Oct 2023 14:14:02 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrIvP-003ZPm-26
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 14:14:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B5555CE315E;
	Fri, 13 Oct 2023 14:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675F7C433C8;
	Fri, 13 Oct 2023 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697206436;
	bh=M5cG4RpybhGR4hgZg1XQY4kjHzVg92/Zir9uslnYWVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nulF5lL/9q59T08g5Jh54kmdx/pI15HMlErRA7Gy4E1nW0V/L2zWevrswRKrFaMqc
	 XXd4/SZA3onZzggnvri5E3Vswty24s5nlzuhAoI5r7kXns/UsFyolUI3RaatPedZTZ
	 n5D8l9nxjw77Ewxc0jDxNl6dYRT4SQj8fV4TISl/mfGo5IZppsOnjPxvaaZ87++vmy
	 LdP/CFEylCbhxH1bADHqHKeavtobUQ+8KNBGNbDDcymzL80ejnq+5x+oDoMHr79omf
	 zIJIo+ienRq+MTUUz1IDcnjGK9447sCCbxtjgXwU/JxQE8yh0XoHHPq0oYPUAmE1J6
	 WQYEgAc51FnAw==
Date: Fri, 13 Oct 2023 08:13:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: update firmware version after commit
Message-ID: <ZSlQobW4LOuJd018@kbusch-mbp>
References: <20231013062623.6745-1-dwagner@suse.de>
 <ZSk/5Fubv+BYPQ3z@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSk/5Fubv+BYPQ3z@x1-carbon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_071359_912894_6AA62910 
X-CRM114-Status: UNSURE (   9.33  )
X-CRM114-Notice: Please train this message.
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

On Fri, Oct 13, 2023 at 01:02:29PM +0000, Niklas Cassel wrote:
> 
> However, when upgrading firmware (even without a reset),
> can't more things other than FW version change?

New firmware can change all sorts of things, but I think firmware_rev is
the only exported sysfs attribute we expect to change. Other attributes,
like model, serial and unique id's, should be stable across these types
of firmware upgrades. I don't think "activation without reset" can be
used for firmware upgrades that change fundamental ways the device
operates.

