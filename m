Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B5ACDB46E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Oct 2023 15:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wNJVV5+/IPl9X6qWoMFoH/v9vdJQWuTP8SOsjEWwiy8=; b=pTkA0n+pyb/I74OKpCJ6mA2Y3O
	x9bXnv13nWxI5G1g+DDPOs9Y7j5z4WE5wU5IQo3nYH2xCbA8LjePXtRN5Pu1jWEGT1iSzj0K43HL+
	YBvfIPsCWkfqJGfZYRMto86VMU3lMl1ko9GmsxTXsFirJB9HoyA1i5JeHZkzVFkwPHBSIi06ZWD/v
	2XxVnYWRpEeNwxqTWbRLzL6r1BAlm8aObdXREs57q/7X53c0fFdzebsniht5RFwQFp2zMsaTh1o0P
	8JuN+TDbTprdkySB/Jb8Dd/0K4mgKiIWLA0S3mWNYBIUSwb/WRIC9APTgs50lFJDyq1s1mSh0iAl3
	I5INVbIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqxJa-001FmF-0S;
	Thu, 12 Oct 2023 15:09:30 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqxJU-001Fl1-1K
	for linux-nvme@lists.infradead.org;
	Thu, 12 Oct 2023 15:09:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9205ACE2912;
	Thu, 12 Oct 2023 15:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F54BC433C8;
	Thu, 12 Oct 2023 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697123362;
	bh=Wr0ndcQUHYxoAwTptPi86bdrPTdYxMQUIlAkGaiGK44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKu5zmrb5pjO0cc9uTPWdr8dJACwyM6HEREntnyBM0+Gyyg1P8vtjV8acdN/bZOcx
	 HDWAHOnc3628ELs1ULtR+P803cQFFSfe2jPGtx3AMwxV3jRgJu0P4xp3izGTwY7nrT
	 cb3Ji/MsxbJckueZXLMeMlUMgolwQ3Lq2YUl7SyfvyaQtGmSV4gj573melqOIVE+wK
	 zEpFGaiN702/DJPRJm7irdCHgzbievpbWy1o+ZGnPPTEIXXWo59F/IRhCCe2XyQRK7
	 iYGbLAFRNLdp9ahASUYHnWN84GLemOJjVkFYQuBATu6n5tniDDd35b83lYT6C6nUsr
	 IBa22guGMKF8A==
Date: Thu, 12 Oct 2023 09:09:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: use 'spin_lock_bh' for state_lock()
Message-ID: <ZSgMH3uNeccez5Gf@kbusch-mbp.dhcp.thefacebook.com>
References: <20231012125954.58709-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012125954.58709-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_080924_662171_D067D721 
X-CRM114-Status: GOOD (  11.04  )
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

On Thu, Oct 12, 2023 at 02:59:54PM +0200, Hannes Reinecke wrote:
> nvmet_tcp_schedule_release_queue() is called from socket state
> change callbacks, which may be called from an softirq context.
> So use 'spin_lock_bh' to avoid a spin lock warning.

Doh, I missed you already sent this fix:

  http://lists.infradead.org/pipermail/linux-nvme/2023-August/041593.html

I can apply it on nvme-6.7, though this feels like a fix that can go in
now. Depending on which way we go, it will cause a merge conflict for
either stable or the next merge window. Do you have a preference? I'd
just do 6.7 if you don't care.

