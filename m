Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15912C47DDF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 06:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8G7CGuaKypP3qF9ydNjYqzjvV0d/99blPt8xUOKu/uw=; b=rUNjVotaOXfAPhJiDoCgl+U7ZX
	pFxwVrrVIpcg+S0k3P89ozAO8/5HO4sbtRqEMiCB2X81+C231cTnXtjoeg4HUOT51AAxbhaZxzmOh
	7j42PYaNV0B8ZFHW37h/82uZZdar04g3P+InmtQzIgdpoWIZiwHjdi4uT4xBm4kiF7vp9sNgdl7+p
	eud4A4Kt81HaL4PgPjvNr36AzgZrndVV8Dy3aOB7iN6fiQpyB6olORpThhd5iqFUJqS8yW8ZUHCLn
	RY00dRf0/HUOoVGSL+5ubKRShyNIwfefRiISXnWzSqfG5oQ4Tu68v4vdpV51kuv0pT0GqSX6WQPIW
	2BE64q+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKgl-0000000BOiS-48Wu;
	Mon, 29 Jan 2024 06:00:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKgi-0000000BOhQ-2W35
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 06:00:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB4B768B05; Mon, 29 Jan 2024 07:00:05 +0100 (CET)
Date: Mon, 29 Jan 2024 07:00:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>, Martin George <marting@netapp.com>
Subject: Re: [PATCH 3/3] nvme: enable retries for authentication commands
Message-ID: <20240129060005.GC19136@lst.de>
References: <20240127093746.40246-1-hare@kernel.org> <20240127093746.40246-4-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127093746.40246-4-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_220008_819780_39619959 
X-CRM114-Status: GOOD (  16.21  )
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

On Sat, Jan 27, 2024 at 10:37:46AM +0100, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Authentication commands are normal NVMe commands, and as such
> can return a status where NVME_SC_DNR is not set, indicating
> that the command should be retried.

What command is not normal?

> This patch enables retries by setting NVME_SUBMIT_RETRY for
> __nvme_submit_sync_cmd().

I think what should go into the commit log is why the retries are
desirable here, and not for other admin commands.

Otherwise this looks good to me.

