Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0ECC3ABB2
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 20:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wF5C4wcZ0rXDMc3mSI5rw2uXtLlFXVaGBcLaNEQRddc=; b=slqeWNcfOK5WT/ZAZqoGQV8zrU
	e0N+3wfx2gbp6QoSNFDSNix9HrwBnfxJlDYHQW85RbzkP7dHMabMstfxNoS4bRrBGbwg2LayM02n+
	zALT4t392mf7yCOOyx1LWQyoZIw/DmyOby4cndJsAdWPDsycaPVrr7MS0E/bKTcPQRQY90w/3uN49
	556u/LAM9fbcemfYJJG4XDzCIh13mc1J7bmNsvDf1S4ryvzHIgF0ZtQmS7lY+CB8LLCbhev5IuXdV
	RnRwhjRppzCD4X1SeReaIlJkDriw9Xl50KQ1pTVEO0I4g61Mnw4ZDyqo4k0tw8cWTZHsyinz3m0k/
	hOYVfHVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKNUY-0000000E5QL-0Fk7;
	Wed, 28 May 2025 20:35:14 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKNUV-0000000E5PX-16C5
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 20:35:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C9C2CA4FAB1;
	Wed, 28 May 2025 20:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C70C4CEEB;
	Wed, 28 May 2025 20:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748464509;
	bh=dX1YNS7LzArpSdLc+wj0p77V76KjsGKcBq/WdpAJU28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ola6vbrOSxDQLxICFKORcaJJmXay8RLHrGKQcaBJFsuFOCCkC4Kb8XeCaw1TijFTQ
	 cZtIvGHB/I55XTpWQ6btBvPqbGeFNF//Oi9kwQG3Ets0kkt70msqLSyYcFmX/WY/WC
	 Ibn3SxRnML5OmkP8CLFF8/nikVQ0mNpWGOGtwRVtAEVvuOX5rGCi4mDLPCSd6romFL
	 CKNhFKwhIADTBebCo31KhS0Pw2YARrmnhO33tDLcDmwLaDmdDpOJ++pNjMcK5TO+BN
	 7uW7Yb6lEtYvljj/8haA7qm6x+0iBmN1hCql6eeU+nC3yhPYprh1Xo1RQJgddvOYMi
	 ya2FGacqIZaag==
Date: Wed, 28 May 2025 14:35:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: add NVMe controller statistics
Message-ID: <aDdze52GrviTSmFj@kbusch-mbp>
References: <20250528170350.5514-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528170350.5514-1-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_133511_374640_F6DAA9C9 
X-CRM114-Status: UNSURE (   9.94  )
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

On Thu, May 29, 2025 at 02:02:56AM +0900, Tokunori Ikegami wrote:
> +static ssize_t stats_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct nvme_stats *stats = &ctrl->stats;
> +
> +	return sysfs_emit(buf,
> +			  "timeouts: %lu, aborts: %lu, resets: %lu, disables: %lu\n",
> +			  stats->timeouts, stats->aborts, stats->resets,
> +			  stats->disables);
> +}

Specifically on sysfs attributes, the intended use was one file, one
attribute, one value. That makes programatically parsing these much
easier. So what you'd do instead is create 4 new files called
"timeouts", "aborts", "resets", and "disables", and each just print out
a sinlge number instead of this more complex output. If you're concerned
with polluting the nvme device's sysfs directory, you can also make a
sub-directory called "stats" to collect such things.

That principle hasn't always been strictly followed, but let's not
introduce new deviants.

As to what you're tracking and reporting here, I'm not convinced it's
useful. It's just a snapshot of what's happened for the lifetime of that
instance, which may not be very long.

