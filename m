Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245E6C3600B
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5pO0NmivV495EdD88afuDpBhkA5QvfKZikHvhPPHPfM=; b=aPWxl5T0kM0ufBh8Ios8Gzj2DF
	yTwvznDPaC1IdCWsMkXYZR/i/VKae1PrRLiI6vw9IGtjYg8AQaacYHt9xmxY1AORKCwfSlj+eZZ27
	4yROmrhvFCXhl3jJ+Aq2KfBZbeO9R0aXNdcMFS6bCAaLepvkmuqp5j+InqyIACWrYuNPhkGZKhgum
	x/r22WwppHwjK+z0J2e/D2LuwiUjruFKjMxlVeQ2LRqfPJIRHkVqcrB+Np6iRE/frD6ctNMDwG92m
	h8Av/uJ62FLXj+C4T5za5jthdwUazX2AfZsHevfgDEnxbSRqpWWl5cY5nnxISUpPmqI6J6ZDzkDfd
	vof7dq6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzH70-00000000oA6-2YV1;
	Mon, 31 Mar 2025 15:31:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzGsp-00000000jtE-1vwU
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 15:17:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 88D2F43627;
	Mon, 31 Mar 2025 15:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7D4C4CEE3;
	Mon, 31 Mar 2025 15:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743434221;
	bh=2AodV4yvj2+rgAaOyKWVbIruRtW1ISODTfEgsRBjMrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YlGkEbWoHhKHt60SaahgZIyxdel7gsBDVy3PLmz8l3UBX1dneAz+qEHhHpPLosU+p
	 f3SZ+peFzRwUKzRj8SL+FOszWa8CuICJ2+/WxqKPrP2MFAyxNWzK8Y7eQ7Mob1hQ7H
	 8qiB7HbId43UIHYHFC9cPnnlNlkyWS7Al+ayW74JX76Qwe7XLliCpGLH2Sh1dyFp00
	 4dfF2Jc02RfoAKSrgDFEfcdJ29Fp6kkBGB7DSgkP8eQUeWXMk7YEhwe3FEXjtY4+iZ
	 bH6GIWeHu0dDAybybLmech+6MSNxz+EwxLuj0kJSrZal90eDQcEMxL2b5glXlNoKBk
	 WzX/A3K8VCvFw==
Date: Mon, 31 Mar 2025 09:16:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Yuan, Xin" <xin.yuan@intel.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Questions about I/O queue number of NVMe device
Message-ID: <Z-qx6-h4nLX4lME8@kbusch-mbp.dhcp.thefacebook.com>
References: <BYAPR11MB26469ED9A1BBA947924D551E9DAD2@BYAPR11MB2646.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB26469ED9A1BBA947924D551E9DAD2@BYAPR11MB2646.namprd11.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_081703_515912_71B0E31B 
X-CRM114-Status: GOOD (  12.85  )
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

On Mon, Mar 31, 2025 at 02:28:20AM +0000, Yuan, Xin wrote:
> 
> I have question about I/O queue number in NVMe. Generally, the number
> of I/O queues of NVMe devices is equal to the number of CPU cores and
> is evenly distributed to the cores. But in some devices, I found that
> the I/O queue is limited and less than core number. For example, I
> have a 14 cores platform with Kingston NVMe. But the I/O queue number
> is only 8. Is it the limitation of NVMe driver or hardware? By the
> way, I cannot find the I/O queue number limitation on the hardware
> datasheet. 

It's a hardware limitation coming from your SSD.

