Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669D4C35FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 06:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bv2jIVNOXcju3HkEsbDvcanVq0usMz/kinZaGx41xIs=; b=Igu0+2nCQN3VmnP6jX5IP/8eXa
	V1ytOpNzcORUiGHt9r9M4EUbzxJbYzB40p9oddYCrqMpkRPtMnN7Dt6dINKx8B0/yLSJ12taOrnwU
	31aAwLJ4hkHtOIBXy0IYWAy6e2PqzPXaOl2W+W1RW67ih2ruQfsCieWiv5kfXu7Uwp0nN2lV9MDgu
	D17Tg2cQsqaQQ2hqqLs3b5g74m9z67KD1zBWyPEXoKR8dt6fS14oh4VR92pt+g0Opn6WRn1F/eASD
	aCVwQRl7ChjGJ553HHZ5zxMfgnnHUCkBcPUrX00/VJ0lTuLwW0/Adb0s8UXS5AnZW7sv8tWnSxrXN
	39eLcRNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVYf-0000000DxFG-3vjg;
	Fri, 21 Mar 2025 06:08:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVYd-0000000DxEs-2uSN
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 06:08:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 518B968AA6; Fri, 21 Mar 2025 07:08:33 +0100 (CET)
Date: Fri, 21 Mar 2025 07:08:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/18] nvmet-fcloop: sync targetport removal
Message-ID: <20250321060832.GD3007@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-6-05fec0fc02f6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-6-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_230839_872664_6A52A4C0 
X-CRM114-Status: GOOD (  15.51  )
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

On Tue, Mar 18, 2025 at 11:40:00AM +0100, Daniel Wagner wrote:
> The nvmet-fc uses references on the targetport to ensure no UAFs
> happens. The consequence is that when the targetport is unregistered,
> not all resources are freed immediately. Ensure that all activities from
> the unregister call have been submitted (deassocication) before
> continuing with the shutdown sequence.

This needs to explain why that is needed.  In general a completion
waiting for references to go away is a bit of an anti-patter, so
it should come with a good excuse.


