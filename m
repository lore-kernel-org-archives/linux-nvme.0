Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8ABF364B2
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 19:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=3qBIy5ZisNuazWWq2mAKldCUKEFaS/s3dYzq5xoM9VM=; b=RlTb5Ahag/GMzc
	OjsLd/ZlBuS6NrlnW+hvMv+wsB7e4vg9V97fbzPmZvkkyYXFe5ffE3vaDZuEUroOVjEoeqaZovAsi
	UEX8Dzy4BSmW8pZqlOqZupFvKIY53zio9eq2qGCh6EAciSNme50x3DSM0/5lkinwHbjYbWz67vRwL
	rxKVirmCfgECEQXPpzgVUjrfoRxTsN38qvW+yzpnBUkXKyMmYAqCIMYORVLnCRgpMDe+lcQeFmz7I
	SVtXn3j8WQ8K+NUilIUcji0WU0lrHzpc3r3cZc6mwr+MGvQ+qzq4IJfzW1/4n52UYFKHER75Pm6OR
	LxrSYFqbTvnDqK3Rsh5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAugp-0000000B8DT-1i3f;
	Thu, 09 Apr 2026 19:05:19 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAugo-0000000B8DM-0Zbe
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 19:05:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2D990600CB;
	Thu,  9 Apr 2026 19:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B340EC4CEF7;
	Thu,  9 Apr 2026 19:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775761516;
	bh=5aNjZOyeKYoSPBrg6F+tZ55XEXLPMHj30+4MKI/30HQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P6mPrAhTDzJ3LoSeIIO/wJWeaLl/PA2qFqDGAvgGhfpOC91FBviGv06+TblUEt8B6
	 Jh1PEng/KFsT5uI68OEaQIEbU7Ygm5tBtVC47h2doopJw9bqrH8uRl5V0Yqn453BRV
	 d5Tl1XWek2KI4eKqjbV3ez0uBfhKZfJ9JGs5Oc7y97yMFMd4rvuyotdlVYmOn4P1ZV
	 0cHAGqObqHjC/sUHNOcNtEVF34ABCYMtgQvNI5/TvOkXnRSRnaPKOq8tfxlVbGbWsC
	 jJF9pJVcJQDXfEgAVTC16dfJ+5uur0aJenks5Pyu4Mxxq7IPrW0W1Dus5Xw7qcy5OP
	 bDm/w1lfRJpIA==
Date: Thu, 9 Apr 2026 14:05:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacopo Labardi <jacopolabardi@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [BUG] Lenovo 83JL / WD SN7100S: intermittent loss of secondary
 NVMe after s2idle resume, root port 00:02.1 retraining fails
Message-ID: <20260409190515.GA407093@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANrGBMBDftu58R71jvEcZ94D8vJB2Y_dHG=BbNSsNMOS=3k0+g@mail.gmail.com>
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

On Thu, Apr 09, 2026 at 04:52:20PM +0200, Jacopo Labardi wrote:
> Hello,
> 
> I am reporting an intermittent suspend/resume failure on a Lenovo IdeaPad Pro 5
> 14AKP10 (machine type 83JL) where the secondary NVMe drive can become unusable
> after s2idle resume on Linux.
> ...

> I collected a local bundle containing:
> - full kernel log from the reproducer boot
> - systemd suspend log
> - lspci -nnvv for 0000:00:02.1 and 0000:bf:00.0
> - sysfs power-state snapshots
> - dmidecode output
> 
> The raw bundle contains machine serial/UUID, so I am not attaching it publicly
> as-is. I can provide redacted logs or specific files immediately if requested.

Providing the complete logs with private information redacted would be
a good first step.

