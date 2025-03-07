Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBB8C282DE
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Mar 2025 15:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OlEisHKuQK34o0mynFX+GlsxHUAHeZDfE7A3V6JTEvI=; b=m2tXvhjq/td36mTedLcf7l2r7m
	eV3uwjujTZDSvevCCfzxRuca8HRqugqfOJ5rz/s2HC/a/ViL+QQ/B1MRJVdUuua11EQLb0L7tH3jV
	i6baZ7qqeeQO/2VsennISxdGA2J6kcA5cCi4xLNdZP4hl1hrI1sI+2AzoDvC+PWqifwYVTAyTlfCC
	W0ZhfO3vYz8YBi6zHEHaJtHycbV9K6dxqJtozFpGjjAkjY/0dM22AYEylRFQEDV0ynkryZxQoZpj2
	Iv4h81aoYTaR6KxIwH/V3ejY3t2RZeJaZujlTPyfEzij86WBThSIK3qbrAbMzM8whZ4/onNTt6Lj2
	HX1vR+Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqZvo-0000000Ekyw-3DFR;
	Fri, 07 Mar 2025 15:48:12 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqZqt-0000000Ejqe-3tXE
	for linux-nvme@lists.infradead.org;
	Fri, 07 Mar 2025 15:43:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 79C35A45882;
	Fri,  7 Mar 2025 15:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47CEC4CED1;
	Fri,  7 Mar 2025 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741362186;
	bh=VgH0UurqNrPQRnOJzP1srSiyWoUpHvrVJDCtSjug9hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9RYZvUOBW79UPzNkSH0OgKtZkU8sd2kvkXsm6zBBkOzH3vxuIcrU7GiSwVDNW9Vn
	 uDv1qYJGRcdBVrfB1CHZL2xdLoL7+7z7g+zdrsyPT3opqGx6u/8NAgbFnaVgE008VK
	 D+untZ9txPJfJrTQmko297MppiWSQTnL8BWh8o4z0TbJr56cEtieoupy5QZ+2fgMHm
	 vFX4CAKkA6rnKEF26F3AaRu2UdPfKiOPi743+8nr74Jl2fMHHIwrdkuJDS8JqBXFeW
	 3HZvOOiHbKbhxnk38f14j7VnlJiud/p3fMaF59Fb07NC1iV22R46t4vfBsQ8vZVaTU
	 ZGINQSE44SQWw==
Date: Fri, 7 Mar 2025 08:43:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z8sUB2bbbMsurZmu@kbusch-mbp>
References: <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
 <20250305235119.GB896@lst.de>
 <Z8jk-D3EjEdyBIU5@kbusch-mbp>
 <20250306000348.GA1233@lst.de>
 <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
 <20250306141837.GA21353@lst.de>
 <Z8m4vzE36UHWjwep@kbusch-mbp>
 <20250306151654.GA22810@lst.de>
 <Z8pB9jQALxMN6WaA@kbusch-mbp>
 <b2c9df64-0afc-46cd-9e8d-6a3f41a4f1c7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2c9df64-0afc-46cd-9e8d-6a3f41a4f1c7@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_074308_049455_1E4461F6 
X-CRM114-Status: GOOD (  14.45  )
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

On Fri, Mar 07, 2025 at 08:49:09PM +0530, Nilay Shroff wrote:
> On 3/7/25 6:16 AM, Keith Busch wrote:
> I think always creating multipath head node even for the disk which doesn't 
> have CMIC/NMIC capability should be useful. That way, we may then be able 
> to remove multipath module parameter? In fact, you already mentioned about
> it in one of your previous message. I see two approaches (one of them you 
> proposed and another one Christoph proposed: 
> https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/). 
> 
> Maybe in first cut we should create multipath head disk node always for 
> single/multi ported NVMe disk. Later we may enhance it and allow pinning the 
> head node for hotplug events so that head node dev name remains consistent 
> across disk add/remove hotplug events.

It honestly has potential to solve some real problems, like
re-enumeration triggered by a link reset on an in-use drive. You'd
currently need to close the old handle and open a new on, even though
it's the same device. It may not even be possible to do that if that
device contains your root partition, and then you can only power cycle.

The downside is we wouldn't get the short cut to blk_mq_submit_bio. We'd
instead stack that atop an indirect call, so it's not free.

