Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4345C4828D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QPVBLhVSW5YSdLedUd9rTw8YWx+BTkXpEKLgj08EVwg=; b=kLHGA+A68QpWw+xuAPY3zaV5l9
	GvDjCqWL4zYsJpP65FyMWnYQM8dM5+uT9CY9N3PftMqZtR2Afn0cer+DjMva3tuaP1+OIX9TAxMJi
	To5QcmnvFEryyDgRyzWXIk3XTUpxriOUBbVq0PDak64zulohnKuFMcRc4V5zb6wBj0/PKnOwnlaI8
	M9RMkDcdaPJjlFMNR7PLR3fuda35vAtc0tQYB0PbiAcqa9rk518Wkg82J1Y1PeLkSM5x97tazQJLx
	nwm282AOuwVCYZ1QkrDhRNmiwc5oC4KLRxbHd3pjgGt4KVo0qnxCmNBFfVQBTjz8kxxdA3JKnOCQH
	mMGkjlfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXNxZ-00000008CZ8-2mhB;
	Tue, 06 Feb 2024 16:06:09 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXNxS-00000008CYI-3u5N
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 16:06:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 38A01CE0FF0;
	Tue,  6 Feb 2024 16:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C2BC433C7;
	Tue,  6 Feb 2024 16:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707235560;
	bh=ALfHYl0MoXJHPoUjvcNbkyX2HW96qPEysivhR3BrbR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/h1UbZRUJdNrtpkXF0YdBNd8H8n6iDZjagv7XTjBYrHAq5orobh8Eiv4mvs3wjcF
	 /23KWcZrGqcepGAgBoJS6EhgCqIiAg6fRYPLBF7mhPtF50TiQ+BecvrPwNoBI6rEXb
	 8LmpcGn232IT/BWfsb54Yfhcesa5bH5RU5c1+yvUtP6RN0JdktvWCEGtCa2UipbvQ7
	 6wpY4FHaqZ8dPbLvJUSBVfy5LQTn0CsR1A2+qggVFkJ2fb+oRmm9S4AiSeXhRdPFnY
	 EmA9KGvDSERm499e9T0X3aavwsanIAgXgPDJOUptLsN9CREJcqMNNqOWSq63eiX4VN
	 z5bP6HmISYPaA==
Date: Tue, 6 Feb 2024 08:05:58 -0800
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: implement support for nvme relaxed effects
Message-ID: <ZcJY5nSY4Zh690do@kbusch-mbp.mynextlight.net>
References: <20240205191703.2990948-1-kbusch@meta.com>
 <3c8443fd-fd61-48ef-b4a3-0e6545990140@nvidia.com>
 <4efa4fd8-b351-4948-a6c0-c5969c973bdb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4efa4fd8-b351-4948-a6c0-c5969c973bdb@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_080603_160995_C9DA4DF1 
X-CRM114-Status: GOOD (  19.35  )
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

On Tue, Feb 06, 2024 at 08:34:39AM +0000, Chaitanya Kulkarni wrote:
> >> +		if (effects & NVME_CMD_EFFECTS_CSER_MASK)
> >> +			effects &= ~NVME_CMD_EFFECTS_CSE_MASK;
> >>    	}
> 
> looking at the code again we are not using NVME_CMD_EFFECTS_CSER_MASK
> anywhere in the code to guarantee the admin-cmd exclusive execution
> guarantee, is there a specific reason for that ?
> 
> According to spec:-
> Figure 221: Command Supported and Effects data structure
> 
> *Bits 15:14
> *Value :- 01b
> *Definition :-
> The command associated with this structure should only be submitted
> when there is no outstanding Admin command that affects any namespace
> and no Admin command should be submitted that affects any namespace
> until this command is complete.
> 
> IOW, don't we need to freeze the admin queue when controller sets the CSER
> value to 01b until command is completed ? or it is not done/needed for
> a specific reason ?

The user is trying to submit an admin command, which wouldn't be
possible if we freeze the admin queue. We'd need another mechanism to
allow just the user's command, then a way to defeat it if that command
times out (we send admin commands as part of a reset sequence).

All that adds complications to the driver, and since there hasn't been
any communicated need to have the driver enforce this policy, we just
leave it up to user space to know what they're doing.

