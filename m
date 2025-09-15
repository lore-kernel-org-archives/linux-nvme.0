Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192BCCAC597
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Sep 2025 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1VghLHM0/iJ2cKvzF2sAbqNFKICbjFA5CnEQ6xuvsOo=; b=EGrb9Mv7R1gtj/No0X/E9U8HKw
	+8qTOgwSlM0z1q0gIyIZotK21KpdPSufLB0R5pI6Lach2Bb3rUnhFwRYd0sFX8Z9WG4Sthzfrn3Rn
	LVBnaIUql6axv/rFtGclfIr9eiRm/WTOvwzrEdhOpjBX6FJW/3FIJ+DtAr+BN9W3Yg2CofJaIa7zt
	jGk5hN1i64xPc2H+JeBGpbQZQmsCdLCAmqAAmzNta+SGZ2ZoQg9DGXv+28kzcs+gqNrGFBImaGKyj
	4mRwO33BumYsBuOF9HMtWMcdDQXbhLQ5A/DQhDxXZNOwsRAig4QoBsHw8rcIRQyn9l54DFgrYbJ7X
	hP1o3iSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBOL-00000005055-2L2q;
	Mon, 15 Sep 2025 15:45:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBOK-0000000504Z-0vqp
	for linux-nvme@lists.infradead.org;
	Mon, 15 Sep 2025 15:45:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A1D4A60202;
	Mon, 15 Sep 2025 15:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D83C4CEF1;
	Mon, 15 Sep 2025 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951119;
	bh=BMMvAIX8lIec0W3uLHniFYKWitkFVyM8NgNBQoOTamI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RuKP2GDeTAJFF9RHJInYDhTSDClkGNHxoPZHaj9zZVLcJhY8+d/Sv834gCQl4sa4x
	 4LrfugMlueEbgXC570jY+hJLF3obWH5m5hyWrlLPFuqxx520R7hX2N+tA0KlZnYKwR
	 YEJVspy3FJ6879O820NUiJuInNsBu6gk29GeD2ih6KyeJ7Q0Dpaa9ymnpQqf70C+Z1
	 nOtP6AlT795L8ny1ujN0UgvNb+NWyeNGh5AYQ/wMuIzA+YykzOx1AZDpiFTlF8xEkz
	 JhM6ENN4hyuq3fy3myPkaDhMJbRHTTxDMAy2mHHNr4EYJU/wBcXyv6SBcFK5nX1a9b
	 m3HBL+b+E4BLg==
Date: Mon, 15 Sep 2025 09:45:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com,
	jlayton@kernel.org, trondmy@hammerspace.com,
	anna.schumaker@oracle.com, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev, neil@brown.name,
	Dai.Ngo@oracle.com, tom@talpey.com, hare@suse.de, horms@kernel.org
Subject: Re: [PATCH v2 3/4] nvmet-tcp: fix handling of tls alerts
Message-ID: <aMg0jDkXOd8E7Ihj@kbusch-mbp>
References: <20250731180058.4669-1-okorniev@redhat.com>
 <20250731180058.4669-4-okorniev@redhat.com>
 <CAN-5tyF=5oQLyy7ikbbhFW10OrUfHh0Sr3D=G1nHN+pEsfiSzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyF=5oQLyy7ikbbhFW10OrUfHh0Sr3D=G1nHN+pEsfiSzw@mail.gmail.com>
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

On Fri, Sep 05, 2025 at 12:10:21PM -0400, Olga Kornievskaia wrote:
> Dear NvME maintainers,
> 
> Are there objections to this patch? What's the path forward to
> including it in the nvme code.

Sorry for the delay here. This series is mostly outside the nvme driver,
so we need at least need an Ack from the networking folks if we're going
to take this through the nvme tree.

