Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD1BC27C4F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rVPlAjAlhtvNZz13iCRFmdfNKWh8F/6TQa8ai2eSbT4=; b=C+8dv76JO28smoGEG6fQRcztKs
	bcsPXrEkyy1C4g9fPPUpgLbRkYrIftKd80u66OSFgYhPZm4evs7ttz9m6icQLms34C2NIBimC3qCi
	lii0Kqf+CiGjluCxYfqzKiKeOpCKMmhDHwVy1xgJwxX/UOlaF+Uo9Wc8eh7c/HKz3o2WFDnxDR3q1
	FdIf5bD1EgYKlMVtEBA0bFTrgaIhJ4VthxxH7hWA419OKVbgLhseaAR+9COIg+6rE3KN74S6DErki
	d0Ldb64jxUjU54DJklEl4Me3faK4mrEC7edRmhqZVrMcdUI0Y7my+/shLUln62Nwu6hUuw481RjW9
	QsfoSqhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKgiC-00000009qD9-3cNO;
	Fri, 21 Jun 2024 16:02:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKgiA-00000009qCd-3X9B
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jun 2024 16:02:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 493C962725;
	Fri, 21 Jun 2024 16:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F87EC2BBFC;
	Fri, 21 Jun 2024 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718985722;
	bh=BhhIfYxhnGI7UNOa6/F/m0GhEPggPqs/TDVs9MpevqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/TXNyJAJQU3mqdklRQTIqxdmfquX9KIuyqcOmv1yK0f4XQo/aacfS6MBXi64xA8d
	 G4GYYhqvuxs/Wp0AnTkDLW06fmbcoZEe4ftDE6L943VUFunhSxLjK278dpJByJP1X0
	 KSPQTOWNPXed6wzNjzZ+r4qEDLZdNKGZoY7ErC4Zg8i9LY6SzsfewXmzVIXYVoqzjn
	 K7suRyM9hXhyk6HuTk6xzirLu5lQdbyOB63MmBwaLw4Ze7eHZupckt9C3bR3+aIrrP
	 8hCGbJgxKk3J2vHiHROOM5LTIX7NZLLQA+nvGujFtzVkcO7AM3XPCokaGxS+ezN7GY
	 pZo7iNiFdD1Hw==
Date: Fri, 21 Jun 2024 10:01:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/3] nvmet: fixup nvmetcli save/restore
Message-ID: <ZnWj9w3f9pZvet4h@kbusch-mbp>
References: <20240617072728.134728-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617072728.134728-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_090202_953795_C54C61F0 
X-CRM114-Status: GOOD (  10.38  )
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

On Mon, Jun 17, 2024 at 09:27:25AM +0200, Hannes Reinecke wrote:
> Hi all,
> 
> I noticed that there are some small issues during nvmetcli
> save and restore. This patchset fixes them up.

Thanks, applied to nvme-6.10. The web ui appears to not show the branch
anymore, but git says it's there.

