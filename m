Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA246CD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nGCtbXNnJq+2aY0vErg0xC3U1CiHSIKiHusBc1rXYY8=; b=MPgBK8qY+ZVmfKLA0CcGjPREAc
	bW1/JAy6/p5qgT9dr+0VBEJaGZZ9lNEdkfhm8okpsoj5DY2DMdTMDF5RcbzvL7fwKxjRuIfJ6ZrwX
	sHDCWdb7jaCPQLCRzrdHNLlerBmO0202PwtngpLDEJF3F/VTqMoym++9EI9MYhO9kGfjTHAizYt75
	CZDO7dZ+ZhC62TTLVEcnASaRE/c2SA3YpdN4rdZA4evkQGtms5EaIz+tJt1iWggofYtfvRANoRljj
	7OMddTYIfuO6RVpzKsAJ6GOftYuqZiZeQB9GLEXJximIafmFudWTDsBQuOVs3V59749T+0lRN2wwo
	0+plwUYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFc0-00000004KUQ-162o;
	Wed, 27 May 2026 14:52:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFby-00000004KU4-0KcJ
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 14:51:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5654041989;
	Wed, 27 May 2026 14:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EB71F000E9;
	Wed, 27 May 2026 14:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779893517;
	bh=nGCtbXNnJq+2aY0vErg0xC3U1CiHSIKiHusBc1rXYY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=foaa6McCRTLWwYsm6nDgvptHxFYCAkpbTLEzyxQZhICccth2a4yA3LwN4aa3t1HpU
	 IzOVPhMUUYGBSYcAoOwNEBRAbJIta+UZwC/cuKhedCGebW2x429J4uPlDmNPxi7vko
	 bDdxxWlzh84YN2QBPv2zAtpHOO3v9/XVr9MyRDtPGispdwoHt0ncFNyOeJhlg9BDHp
	 r1EpPQgcR3RVugrsYLY1Ck4mAb532Jd2nL5Jv8QSmcpg2Hm6VuNJO5FGAc/M9gJg2Y
	 AlNAZTIM0BzNvw7miAXIRaZIfzT1Qhg6AqAA2B8yNAjTZq/AEQklwYfS4RU3BYAu9p
	 J6e1STK+UX1Xg==
Date: Wed, 27 May 2026 08:51:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v2] nvmet-tcp: check return value of
 nvmet_tcp_set_queue_sock
Message-ID: <ahcFC6ItvdfAF7QP@kbusch-mbp>
References: <f83c3bb5e83450b46394f3c14c50f07860c0cb10.1779787436.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f83c3bb5e83450b46394f3c14c50f07860c0cb10.1779787436.git.tanggeliang@kylinos.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_075158_132785_CBC1C8C8 
X-CRM114-Status: GOOD (  11.96  )
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

On Tue, May 26, 2026 at 05:28:05PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The return value of nvmet_tcp_set_queue_sock() is currently ignored in
> nvmet_tcp_tls_handshake_done(). If it fails (e.g., due to the socket
> not being in TCP_ESTABLISHED state), the socket callbacks will not be
> properly set, leading to queue and socket leakage.
> 
> Fix this by capturing the return value and calling
> nvmet_tcp_schedule_release_queue() on failure to ensure proper cleanup.

Thanks, applied to nvme-7.2.

