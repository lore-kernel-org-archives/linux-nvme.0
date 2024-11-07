Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB90DD5D68C
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 21:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xcVOgqLijhcblkBLUNTTQauxk4YeWojWV+ZWEiRFM80=; b=E1KbD/eaPUIdIdPC4SOeSexen3
	ISmoD7qm5JSMARV3EkOwDCfrYdv7gNuI+vXN6hiEn7mPHk8YEBVPGGIo6NHJi3PR4/pM2THoic4c7
	RoRFcbzPMuOJGvpw/hUKiwDFmvRgPHntpgoW+e0IVJYOu8BnPbRwtzHixPCc7R4LNLcKwDNPjw4kN
	TUM4EWmGJbjnD0xdDxWeEpZsEG/GvRpSuImry2J81cCimVUPF3qgVR1dSc/+md7vHsCP1Czxys/5K
	5IiVO0ZIktIXUftWI6gtFhZXpGxp2eR9gcg9xkXXC+r5m/FSU/7h687nS4ey4Q55MhPS2HRayK/GB
	hRJa26Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9ACY-00000008Qp1-1gmF;
	Thu, 07 Nov 2024 21:38:02 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9ACV-00000008QoG-0uYw
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 21:38:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A7692A4271C;
	Thu,  7 Nov 2024 21:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971EFC4CECC;
	Thu,  7 Nov 2024 21:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731015478;
	bh=km7FClHykeOxAjNiBwdUIOV2CU2+UNt1lyW4p2s4PtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0V068E+7lCQBqQxcPXaBSyRtrvQ8HCTt4ubdodPVTww8C6xee8H7ignLsO7pU/vQ
	 kkvLrzyQCfoCKy04+FW18p7yQ1AbuUSJXTplt8zqsrzkO/AMkMgKZLuY0P2Lg6nYwf
	 WXNU0L3sK+2GkZA0rY5htN4ZI76EteBxWXLFGqBg490kaKp0km6/l9l2kdeZ5aFDam
	 7r0F2jJzLXUztBm3o/x/G9t9Z4cp5lm5f/ZJ08IkmN3xtTsCZ+KRSQh/O+6F26YyeC
	 VkVQ1N2C3B4gbycbWPN9Of441VKQmFL8c+BkvSU0to5UZZbbZGaurKwE1qsPw13QjR
	 iOF5IJj6A/s/w==
Date: Thu, 7 Nov 2024 14:37:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] nvme/multipath: Fix RCU list traversal to use SRCU
 primitive
Message-ID: <Zy0zM8Qc0-9SVVpB@kbusch-mbp>
References: <20241105-nvme_multipath_rcu-v1-1-2d7450c1cd84@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-nvme_multipath_rcu-v1-1-2d7450c1cd84@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_133759_337623_488FA83F 
X-CRM114-Status: GOOD (  11.50  )
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

On Tue, Nov 05, 2024 at 06:42:46AM -0800, Breno Leitao wrote:
> The code currently uses list_for_each_entry_rcu() while holding an SRCU
> lock, triggering false positive warnings with CONFIG_PROVE_RCU=y
> enabled:
> 
> 	drivers/nvme/host/multipath.c:168 RCU-list traversed in non-reader section!!
> 	drivers/nvme/host/multipath.c:227 RCU-list traversed in non-reader section!!
> 	drivers/nvme/host/multipath.c:260 RCU-list traversed in non-reader section!!
> 
> While the list is properly protected by SRCU lock, the code uses the
> wrong list traversal primitive. Replace list_for_each_entry_rcu() with
> list_for_each_entry_srcu() to correctly indicate SRCU-based protection
> and eliminate the false warning.

Thanks, applied to nvme-6.12. Sorry I missed this was posted until after
I'd sent this week's pull request, but this will make the next one.

