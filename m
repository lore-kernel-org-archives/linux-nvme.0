Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FF5C87FD1
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 07:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2fLaprrdUjxeFd5uNjqmZZ7fKybPHr7ssa9Qnq7+830=; b=0qbvSrkgw4fgP+s/Lfp4YDAl1d
	ztvUcdE0NP/Ki/D3pxsOaUK3dEwfrpcEwP6zJEf/vxS6yNFVB/9E4DjA/FNCgIijb/q+mfnycykrD
	gdXTUAlfB/BeHF4lNccP3+Hu3T/+7u2CVteOCGQC5FKG1hxEgnyDP4UqLi4WE0Ff9PxpsCoajpMn8
	mRMIefFp+T9kdVD+bNWQTpgtfNOnHa5/DheYWF6grQLI6oTiT0PVOZDQc3wM84Bl9apHvpOXae9ex
	/Ft/v+U57oyVikPl2a9TBGOGsOnbXE7OyqK0fFYUAfE46X8Zu2GhLQEGvfmjHfW7ZFR5h6IWli+b+
	3F53LWIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujYmV-0000000EXOV-2ur4;
	Wed, 06 Aug 2025 07:41:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujYmT-0000000EXNu-2Rim
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 07:41:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7ECFC5C5D5E;
	Wed,  6 Aug 2025 07:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A6AC4CEE7;
	Wed,  6 Aug 2025 07:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754466108;
	bh=gwhG0da8HdDBKjPV+cqoDGiqFtghkdn8AaI5nd2D1MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=grjGA284y4QQGvqUJPPkW5fgqOTg2Zuj5Ru1fnSanG0zshFj7BK7UfiRaXLmVZHsh
	 er7pBWTipyt+yRSf05qSKfHgYjBmqzDCKmhcYaAycVIkNpkeIvZvDCHuVe1lXNDsv4
	 9fjA/NuYvvyXXDYlCVyT4sw5rLKoC5FdEJ3R9Nbd6TI1KjE/fHXFrygYpNxElKO4Rs
	 l8oHWPpX7RpaIm3XYY72ey9X/dNJOeejzeu8uwbkng4rxRaz2rJV3HaGLX8nig7/Zb
	 bWZeZtDbif/s/lpDoMj/SYq8iSid1O1f2X3mM5bqtuynYuv/RfoiTIxlCP3b9Nhd7x
	 ssDM78WOngWHg==
From: Daniel Wagner <wagi@kernel.org>
To: linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>
Cc: Daniel Wagner <wagi@kernel.org>,
	dwagner@suse.de,
	msmurthy@imap.linux.ibm.com,
	gjoyce@ibm.com,
	tbzatek@redhat.com
Subject: Re: [PATCH] nvme-list: make verbose JSON output backward compatible
Date: Wed,  6 Aug 2025 09:41:41 +0200
Message-ID: <175446609508.121387.12624077505802713214.b4-ty@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250805102055.3375272-1-nilay@linux.ibm.com>
References: <20250805102055.3375272-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_004149_662589_B1950244 
X-CRM114-Status: GOOD (  10.08  )
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


On Tue, 05 Aug 2025 15:50:50 +0530, Nilay Shroff wrote:
> The commit 64bed0a87a23 ("nvme-list: fix verbose JSON output for 'nvme
> list' command") changed the JSON output format of the nvme list --verbose
> command. While the new format is more structured, it introduced a
> regression by breaking compatibility with tools and scripts relying on
> the previous JSON schema.
> 
> So to restore backward compatibility, we now leverage the existing
> --output-format-version option. With this patch,
> 1. The default --output-format-version=1 retains the original (legacy) JSON
> format for nvme list --verbose.
> 2. If the user explicitly sets --output-format-version=2 then the newer
> JSON structure introduced by commit 64bed0a87a23 ("nvme-list: fix verbose
> JSON output for 'nvme list' command") is used.
> 
> [...]

Applied, thanks!

[1/1] nvme-list: make verbose JSON output backward compatible
      commit: 80ad62ba75f1f1dd5b99c6f56769141b48344485

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>

