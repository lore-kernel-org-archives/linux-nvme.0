Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB01C47073
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 19:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JM/6hXmzkg085gIxAZRTCShI6qQvzuqfmxHeqablSD4=; b=Jf4t8F0o3h1bg4UrrxqrLrgeMp
	qR1kncRqhF4Fp1OPrl2tIQSE1AMRkY6o95y1pR5GGKIRimEgxqt5I9kWftSw/KVVz5BQ3w3DnPQuq
	dVfPMTWTTF4K5ZflZjQa1dBeZRQbkabM8LmlHJxBcPvKxIiANmlHSPwIwGPowkTYlB++iupdaXhk2
	258Wt8TjDvWtKPZAE7zur8ZUbo4XS2jcvb0vGwBmxWTcm3wpBKyOcbC0aSRguQYq+PDCYAlI+53HG
	IABK2ynOHI3Ghw490cEphje2+MFp9mhZOw8bWArkPSrbnHAnMbImWMWPk9N8grogMGhXOePwR0vOu
	LukE5PWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLSxk-00F0wj-2m;
	Thu, 04 Jan 2024 19:01:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLSxi-00F0wO-12
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 19:01:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BF0EF618C8;
	Thu,  4 Jan 2024 19:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6949C433C7;
	Thu,  4 Jan 2024 19:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704394861;
	bh=JM/6hXmzkg085gIxAZRTCShI6qQvzuqfmxHeqablSD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AU8pSzTOIm+1atA6VvE5tLN394XjNABiONcSlE2G5cJCseUZzibOLHSldJwZGJwIm
	 4Tt4qeM7cZZzdOYwrRSFqcdNR5LaOxWLBJck0ylutJ1o+JswFsYPcj1Z03fTr4qEhq
	 0u2zhqWsnRWUR6LYZ7boyEJLCe33Civ6v9/VBZFDkF0GujipJeJplsgPWqxnt9eCYn
	 euhPJaMrpIsXfyW2lrBLU44H12LMxChfaOrKqZVkJ1g+atszFNzDAj6Xit1UYadgNy
	 coPQpF5l5Y8JPfGNyoZ07r8ir5Y+bubVKSGL5U6/b87iGaPfgG8m1QNvHK6r24uXZW
	 5BBrr5t8UwxHg==
Date: Thu, 4 Jan 2024 12:00:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: Make NVME shutdown two-pass - Version 4
Message-ID: <ZZcAalQmy377L6dz@kbusch-mbp>
References: <20240103210405.3593499-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103210405.3593499-1-jallison@ciq.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_110102_401652_90E746B9 
X-CRM114-Status: UNSURE (   8.72  )
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

On Wed, Jan 03, 2024 at 01:04:00PM -0800, Jeremy Allison wrote:
> This is version 4 of a patchset originally written by
> Tanjore Suresh <tansuresh@google.com> to make shutdown
> of nvme devices two-pass.

I've tested the series on a few systems with a variety of nvme devices,
and this noticably improves shutdown time, and no problems observed. I
haven't looked at the new code details yet, but it works!

