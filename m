Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C084CCD6E51
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2026 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0w6zYF8AbOQ414/tNXkjIf7qAh21STz/SV17oxV/kCk=; b=Dt7s064yP/TW52BhXRnuiiU5hR
	H4Gh1u6Z7tn0ra2gwlBxRQ348YzsTOjzStUypqfrWpnrWI9RGHis3CjiKyNXpc0QCZ0rcofCAtE/3
	kU/guMGM7NpHH+ToKk1DjRLINaJxP/DpOyGqhtptEadUbWdcT+GOqoIlPxwU0CilqOTofC8wyhAVB
	nk7VWbfCmZAZtQ3IiZG2CrswBiGl4pwjqaVSAQe/HujEOw4lySt0fLsVGZWFMsImxT4WNNcRoD0aJ
	FDOtfEApn1j8fqXhum8cF88IFW6H+V2IXPpYJQ1JFHdP4lu4t/2mp2bL5eBgaQLlFpAhuU4pFKbeL
	2wFQLfSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSyFv-00000007WT4-1Azh;
	Fri, 29 May 2026 14:32:11 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSyFs-00000007WSw-37VM
	for linux-nvme@lists.infradead.org;
	Fri, 29 May 2026 14:32:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CED71605D5;
	Fri, 29 May 2026 14:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECF11F00893;
	Fri, 29 May 2026 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780065127;
	bh=0w6zYF8AbOQ414/tNXkjIf7qAh21STz/SV17oxV/kCk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YiWa20TQmrue5rLRFPE/D4ifPV5/SCxDxgghPPLtsjKAiyVEdyeFwQ+e0HNArc4pn
	 nyrRFvE6ioDqGWoppVoqZqc/Vvvbl5bd0MXs7+cPB1jFJT1CNgBeEGBu3QHlH5Cbay
	 pJaGLBYeEVa1IqM77C8N4lqFzMmtKcXt+GYHdcNICcFcCK/RfhxIh8l4amEroAVviu
	 mmICUniiqEnUfCcGSR4r3GUcKKjYvgaOX2/T8Lzx4BO1uiAr2DQARaSRjVZc86wj7i
	 yvApIl+TbaJhEOT4X3uNmwRsdOm2hkObFGKBPJwxQJjPdCRZemfDAf9sFZjzlZnFfa
	 g2wrHRpEo4IXQ==
Message-ID: <f9125ef792fa3182983efe287175777a134e8696.camel@kernel.org>
Subject: Re: [PATCH 00/11] NVMe over MPTCP
From: Geliang Tang <geliang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Matthieu
 Baerts <matttbe@kernel.org>,  Mat Martineau <martineau@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan	 <shuah@kernel.org>, Geliang Tang
 <tanggeliang@kylinos.cn>, 	linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, Hannes Reinecke <hare@suse.de>, John
 Meneghini	 <jmeneghi@redhat.com>, Randy Jennings <randyj@purestorage.com>,
 Nilay Shroff	 <nilay@linux.ibm.com>, zhenwei pi <zhenwei.pi@linux.dev>, Hui
 Zhu	 <zhuhui@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
Date: Fri, 29 May 2026 22:31:56 +0800
In-Reply-To: <20260528084210.GA8141@lst.de>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
	 <20260528084210.GA8141@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

Hi Christoph,

On Thu, 2026-05-28 at 10:42 +0200, Christoph Hellwig wrote:
> You need to talk to the NVMe technical working group, not us.
> 

Sure. Thanks. I'm already pushing forward with the NVMe membership and
trying to reach the NVMe technical working group.

-Geliang

