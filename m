Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E30C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Jul 2022 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kyao6ux2Oi0CPubvRIyv034ggKSZ0VAhBLxea5f0PrA=; b=Eo5KsoVNBXKO7brKIEc4NKt+zM
	hUTNg+lBAYMlDgaJmg+O9wnZNWs4s+lGlJnPrKRY7PVyTO++/EkLbV0pAoWYevDPKPzSkahHMSzm9
	M7QAYHLwxX7Fu53cNv1mvb3Z6vYfx+OYkFbLy1Bs8bgtK2Hs1ayMK1N/BituT4YFSUx6QakCt1wko
	UvsLynLtrvLu43n3jGZNlZuJeTHrJd4QYLW8K5QG5TZAK8XpRMkgCZZHUmg3J3OisJYbkUHwxPK0B
	MwujX1PcdAlLNSilc7JBficSn1OUJwgrAcLjU8Ln++wG7mG+Tdx605JAPWyXs7OldJtuYuAmwF36+
	WbchaVdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7IJc-005Zod-An; Fri, 01 Jul 2022 15:12:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6wxp-000c40-Ju
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 16:24:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 26F096201D;
	Thu, 30 Jun 2022 16:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD74C34115;
	Thu, 30 Jun 2022 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656606259;
	bh=Kyao6ux2Oi0CPubvRIyv034ggKSZ0VAhBLxea5f0PrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oeaGOmnO48BqYna0op41w17dtYjRdzYVWNsmVE6RYGcn6VShmcr0NvScCL5iIgmn/
	 Wdpy1QqTitoI5SnpcasINYERq9fdXtRxBF7hvePGkVMuxVuLP+bhLJzgvfff4nKyVp
	 hFo2v4cxptJt5zr3F12OkanQP6vgPGuPD9bIO+1e46Ol5mUHRtfMH5ZS6LqWoGziMQ
	 LjIZD087NiD8ShiN44aWCXEdtXctDYBfa7hYyH7XuY2isQW4OEW2RH8ryenKG2vB4U
	 FepVqO2g8i9vrucY8Jznu9Ou6pI8XMaLV3TgZ/YQvj0oYqEcKbPEvUfgMxCY2JbVtr
	 27mUqo4fntUCg==
Date: Thu, 30 Jun 2022 10:24:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, agk@redhat.com, song@kernel.org, djwong@kernel.org,
	hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	javier@javigon.com, johannes.thumshirn@wdc.com, bvanassche@acm.org,
	dongli.zhang@oracle.com, ming.lei@redhat.com, willy@infradead.org,
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, clm@fb.com,
	dsterba@suse.com, jack@suse.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, jlayton@kernel.org, idryomov@gmail.com,
	danil.kipnis@cloud.ionos.com, ebiggers@google.com,
	jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 2/6] nvme: add support for the Verify command
Message-ID: <Yr3OLiEd+/6wryCx@kbusch-mbp.dhcp.thefacebook.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <20220630091406.19624-3-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630091406.19624-3-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_092421_822104_EE8297D7 
X-CRM114-Status: GOOD (  10.38  )
X-Mailman-Approved-At: Fri, 01 Jul 2022 08:12:09 -0700
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

On Thu, Jun 30, 2022 at 02:14:02AM -0700, Chaitanya Kulkarni wrote:
> Allow verify operations (REQ_OP_VERIFY) on the block device, if the
> device supports optional command bit set for verify. Add support
> to setup verify command. Set maximum possible verify sectors in one
> verify command according to maximum hardware sectors supported by the
> controller.

Shouldn't the limit be determined by Identify Controller NVM CSS's 'VSL' field
instead of its max data transfer?

