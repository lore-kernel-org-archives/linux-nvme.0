Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2830BC369C2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x9aJD4fa7ifhV1WO4TxWA45tGDL43JAJih21KQg1NBE=; b=Y83RXag1AlE4R8qdC90/d/7Sv2
	tI0afXoWtozXp1Du65fL4TM+cr6Vukl1Eu4MBuBSYcpMSFf9osd6ZAYHIRQ6KeIYFc5hNHCod6XsE
	UMMtGDuWTxaDSUePaph9YlpjoOYE7xH2I2bYnDIQiYzrrVDpxT9KD2ejDAbW38kLndguzU8Szab0d
	Ov7k5zBwLgUrCjP7YXA+/IVNdcdbd39EA6TfEc/N3dLgCcnOHX5ACQaSKGOQlwp9znj6QCklD+My+
	rpUDKDOnRAAXuitEG0CYosLReJQ9RUcVo4gM3hNnm0rdrFE47iScKwbxERKzqtSYKM7GnbYj94gk/
	USZdp3Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u54bt-0000000A3he-2s64;
	Wed, 16 Apr 2025 15:23:33 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u53le-00000009tjw-2zzd
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 14:29:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3BCDD43ADE;
	Wed, 16 Apr 2025 14:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A71C4CEE2;
	Wed, 16 Apr 2025 14:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813771;
	bh=QZR7K+m5bMCeMe8HEga4qXFtScqiHtKvCnlqSryClGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idqCLCqUj3EbyS9tOj78B1pA2U9YXWHzn9fjIHQZE6OJ35Jt8955jqFPyTRrTvFhz
	 rZSS3svKJm3taNbmWHkV3T0ndk30TIcfQQGUnpIylM8CjE690c+Wt3S8AkaD18e8hh
	 ZvxceNALEDJMAbc/bssgJEAHMpe6Aht7CqZfmHAW30XcGA9A7WTIkkb5Q5PGcmjYHI
	 eU5icZEtRz6nMVrX5/lkvLvVbtCXmMMmPCVIHVYHS/+gLWSIf5ctxWjCXBakU2ksVu
	 b5xoCaj5HZio5Y/trONxNXS62YIxwsoOL/w8EgIlV6FrNzEf+G7v9qy6y97Us+qRpn
	 fntxisPMR5zCg==
Date: Wed, 16 Apr 2025 08:29:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Aithal, Srikanth" <sraithal@amd.com>
Cc: Christoph Hellwig <hch@lst.de>, hare@kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fixup boot failure on nvme-pci
Message-ID: <Z_--yKAKWnAzqDvf@kbusch-mbp.dhcp.thefacebook.com>
References: <20250414120509.49638-1-hare@kernel.org>
 <20250414122616.GA14884@lst.de>
 <e8c11699-459d-41f4-8af6-75a70e82d12e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8c11699-459d-41f4-8af6-75a70e82d12e@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_072934_775889_EA374290 
X-CRM114-Status: UNSURE (   8.42  )
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

On Wed, Apr 16, 2025 at 12:18:54PM +0530, Aithal, Srikanth wrote:
> Hello,
> 
> When will this fix be included in the Linux-next build? Please let me know.

Pull requests from the linux-nvme tree usually go out on Thursday, so
tomorrow.

