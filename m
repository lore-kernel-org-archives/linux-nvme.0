Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14367C52D7F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RSdXWX5XdLIldaTJ9QGMNSP6bCbqttNJ6Oyf/MIp57M=; b=OUgVSTVgAEWA2vtAvvTScx2jEa
	m2sIN2BWgQE/XeZJT8pSa7ND/fEppwVri+5DjYG1lrfyrY1iQgA7xMYPRrhX1DQANQOMAGyfCxBP7
	cPzbMK+F2Ezz0Q3khkG/WcXKcxNX1KpYydUuC+ad8afyd839y8p7WXJewfnB1eODun7ABDC2s5uxL
	oOffedflElAGPS15ZgszyW8sJw92q4EInn4QYOcLxRsvhYtxhrRn4n45YSL7suL01c9DhBnzAw417
	Ud53JnmQOVlXRsgx2QhGZH10d+9hU0VDoqV08ysUFgXJlWL0mEqO/2iqBWQ4pmiEAPuOGhwy0UsWe
	udWZem2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sduao-00000004OEh-0kyM;
	Tue, 13 Aug 2024 16:41:54 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdual-00000004OC1-2Sve
	for linux-nvme@lists.infradead.org;
	Tue, 13 Aug 2024 16:41:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4CC9CCE1478;
	Tue, 13 Aug 2024 16:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89FDC4AF09;
	Tue, 13 Aug 2024 16:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723567308;
	bh=RSdXWX5XdLIldaTJ9QGMNSP6bCbqttNJ6Oyf/MIp57M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYd0v3ecu23Ylp1tMITYp+OqsiJG5xg3E2kpdvnjsz6THZOp7INfQMho+yl/0sGRK
	 6ws+RVwzVEs/qbuSsEqZGnvQfRwQiaH9o1sdOze3pbKtTRYuDeP6LTQ35gjISG+kc8
	 /udZc2DfZanIGjE/87y7ciAvKmbiA4boOrBSxlgOnySHnoyUF/EbLdvj7d/HPl3Leb
	 46NPxMZtthKoTRvP1zgjw0hzHOlOInCFomX5vca2FSIQHP48JPlEneOwyU6sAuu7ys
	 gax3/p7VUiVvdmdvwEgbW2Bxva65pwffU9k1GKkFu3Gjwlvl1LTn3UqOA47UWD8eh2
	 IMN6FHp+d5z5w==
Date: Tue, 13 Aug 2024 10:41:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Mark O'Donovan <shiftee@posteo.net>,
	Changhui Zhong <czhong@redhat.com>
Subject: Re: [PATCH V2] nvme: move stopping keep-alive into nvme_uninit_ctrl()
Message-ID: <ZruMyQZKEZZcVZKD@kbusch-mbp.dhcp.thefacebook.com>
References: <20240813013527.666491-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813013527.666491-1-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_094151_863512_9E466197 
X-CRM114-Status: UNSURE (   7.02  )
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

Thanks, applied to nvme-6.11.

