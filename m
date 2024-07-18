Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A774C3DA61
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 19:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KgwV+1nt4FvvNQbW/Fj9Mz5QXOTQ+P3ijW/Y+vtB6yM=; b=FTeUoe7YM+sP4O9r0jmHIDnbQx
	W1Jm8+95A4SB6QDFhahKnQxzqHKRxuoIxqhwVtPbDFm26WVGyLDioIKlhaPoU4wJIVj2L8KihUFw5
	tBuZPDII29MZ+iQsjRFjPZKvLms+IKrIMhFPTnzu/KPtvjuJBt1a2D9A62wQs4z/aVZfS0ivGlp+r
	U5wGCrimLyQwpDdmd99qkzHsL1mdK0aTV0hP8Gt8yNGdD2nT02yQMlGwvaogvp/unQus0owYxGgvq
	eiU1fsjkySswuXvXdTAYWo4JlS+HOT+ZzB+FgAPzVqLn0uK4iskQPrU+YZWivdEsEMKRnX817pn5v
	LIHnegMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUWaD-00000000S5d-0rLY;
	Thu, 18 Jul 2024 19:14:29 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUWaA-00000000S51-1cnk
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 19:14:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 699DECE1986;
	Thu, 18 Jul 2024 19:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6971C116B1;
	Thu, 18 Jul 2024 19:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721330063;
	bh=hjw2ZHoWiAAWYOiH3UPbafpIIzKkmrgLJRhk4yJ82G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tnX7RWM6+lksDboMwSPGdwb6e1sP9iabDwBZJMh8Hf52hZp7aIkbYsSgMLf5FVQSg
	 172/yMT7pomiTNl4lyzg40Pl7x6KkeaAGFpyHkGiapiKCHpvnf+eshnv3j88hMvL3e
	 qxnbC1jmXLRytwvPzLHSTYTMUhtGfbbMVElDQTcjspSRyP18mmfWDPI4jIuG0svlKZ
	 MdxGIcMymW6gy8EYCRSD3YVVJQE/rGmqMZC09bZC3b6Dj/NOBlWhgYZb5fIUtKOhmS
	 qmX/GBLjhYthQy8iK/CLyhNTWbHSPJRbRiW8FQXPiYinHxU1CDJX9zmDx5el29FVtF
	 /+xkFq4al4JzQ==
Date: Thu, 18 Jul 2024 13:14:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Martin Wilck <martin.wilck@suse.com>,
	Ayush Siddarath <ayush.siddarath@dell.com>
Subject: Re: [PATCH v4] nvme_core: scan namespaces asynchronously
Message-ID: <ZplpjJqx0lySDzx-@kbusch-mbp.dhcp.thefacebook.com>
References: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
 <Zpgtr33uqbMogK7c@kbusch-mbp.dhcp.thefacebook.com>
 <6629583d-4681-49bc-8a7c-a87c3051c30b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6629583d-4681-49bc-8a7c-a87c3051c30b@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_121426_620548_5F4A52F5 
X-CRM114-Status: UNSURE (   8.26  )
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

On Wed, Jul 17, 2024 at 09:10:23PM -0500, stuart hayes wrote:
> I agree, you aren't missing anything.  Thank you very much!  If you want
> me to submit a new patch with this and Thomas' changes, let me know.

No problem, I've folded in Thomas's suggestions as well, pushed to
nvme-6.11. Thanks!

