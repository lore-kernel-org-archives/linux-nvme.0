Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED71CC67861
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f68L9lxwc9WaVL1KEsKB4jdVjRpZZAeI31DC9NMUAUM=; b=atD42NWvEKlm5m5nwAb/nO6ECd
	WT91s0LxtI9j3k4jj92AZThhWSUbLX2hn5M4BeQWbZuauzgiB2OPDU9W80/E/eaMEdx54KJmlYU7M
	yRYxL1jvps9HEICkXwsMkrrV/jr9ZBdJnJ/OzKwsSj2Xr8F5MI/Imzyl/v38Qja9x3cJ3d7GvkkFc
	+Vk2kKr6IUOzU+UXndS80dSZx+vRJVPzE9/fGRrCo71Eyq4YhhqgOsn+Jt3IhRd10dnxpAtq0vloD
	dyvNNYpjd3rDT8MKBIgyD+5MkrC00Pf9JmHb5QKp1RVFZ4mKlzT5QWgHzDBlNqoX8WYcOl/A7L7Dd
	aBHwUNUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruCK1-00000002O8S-1jMz;
	Tue, 09 Apr 2024 14:19:37 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruCJz-00000002O7l-1BdW
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 14:19:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 13C52CE11E4;
	Tue,  9 Apr 2024 14:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C28C433C7;
	Tue,  9 Apr 2024 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712672371;
	bh=ipvByJlQbMhDIHncEeYM0+ZGZ3uJPApzqK6ZIuhrZWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NiIqJQHerCE3M6RqEE96Og7LHjZkKeO54nm5ubNaTSm3YwvZKkUoTpiSprROk8ZSU
	 ShQ1kvTWDOT/EEPALQdUDv7APbePy3vRdvww257LtufpucuqGkeF20slopnz2vJNjD
	 aRb1giqwkJfnN4pk1HsjV7kRjdelSgmv6IjZ4BQuZgdZnABgVTS/fNiYKqxYPtP/jV
	 DjRvXxmWKpo/9C+/FDZiNJ3O9ZWJhImgHI2W7s8fVDuXsZCrBALEFADg6cUzpejxsk
	 20A/l4PwG6LyTO4zwmBKUYF7VT2Ux/4SphV4qCtIAYHgK8D620sfOKu0/OT3v149J7
	 RKx9gx/8Kynjg==
Date: Tue, 9 Apr 2024 08:19:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v5 4/6] nvme-rdma: short-circuit reconnect retries
Message-ID: <ZhVOcGMuBzC3nyMB@kbusch-mbp.dhcp.thefacebook.com>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-5-dwagner@suse.de>
 <20240409140054.GC20883@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409140054.GC20883@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_071935_654932_B7C67717 
X-CRM114-Status: GOOD (  12.46  )
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

On Tue, Apr 09, 2024 at 04:00:54PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 09, 2024 at 11:35:08AM +0200, Daniel Wagner wrote:
> > From: Hannes Reinecke <hare@suse.de>
> > 
> > Returning an nvme status from nvme_rdma_setup_ctrl() indicates that the
> 
> Shouldn't this an be an a based on my highschool english.  Or does
> Eeenvme count as a vowel?

It depends on how you hear it when you read it. If you automatically
expand the acronym, "Non-Volatile ...", then it should get the "a"
article.

If you instead try to pronounce "nvme" directly, it sounds like you're
saying "envy me", like commanding everyone to acknowledge your
awesomeness. Not sure if they had that in mind when deciding on the
name, but it's kind of amusing. Anyway, pronounce it that way, it gets
an "an". :)

