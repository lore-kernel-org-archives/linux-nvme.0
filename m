Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B41C3ABC9
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 08:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:From:Date:Reply-To:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZfcXXbLu04Ihmd4/VqI8RechQUZuo8v38Xgr+9qfl28=; b=DOzaU0p5HfKZIsRhO9GA/LLxvC
	uCcU7EKScA3qm8K3gJl7nO8agTY+qYZeYqDxCR2CBxeXssDkW9VXFj3PcKjh7EwZOCImvQWRrZKEp
	eX58ZiIMW2Gk+obG4GQvATHK28ry4HCoS1ZGCtVklNoMhqucNwfb4X4Zl2phunCP3oWkMo9/xLwYE
	MGkogWcrFjJ62gn1sUyWKPBOIcMVo34PM3Bkc+4M+2yRc33rWwsA7ywnqSSYjqDmIKT0HpKfAosKF
	RuPW28mVkC8hXHQupBiThhLIc3O/FumDu4i0nxHcPt3IGnEtYW9Wl25GOirpN07Y03racF3xJgyUh
	N/Oztq1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFTwC-0000000HWrK-0Tsi;
	Thu, 15 May 2025 08:27:32 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFTrE-0000000HVI4-0eZq
	for linux-nvme@lists.infradead.org;
	Thu, 15 May 2025 08:22:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5C02AA4C5EC;
	Thu, 15 May 2025 08:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A78BC4CEE7;
	Thu, 15 May 2025 08:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747297343;
	bh=piaEIoXYiRaM0pzGRF6hln61Zsnfo5l/oIHqGsZXPGk=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=l0KQSoHIRy+MYGWIomQunUeGUSBra72wWeg6Q3DZZ7nvzPFElUjiNstqxDYg7inJo
	 15HeoECw1bwMeaGZX5Wu4VJPHL0sBsBskNEida11QN6wAh26Y6JhoVWCqxLUIWUB8Q
	 6SPLdRg74MQx//hXTAUkj2p5bzoeRiTEnxxy4tMewt+g8xgj12m5yHZ3m2N6QCQNfc
	 1Z9OzNOgCteVBNYYsX4k7WveOh1EMoCIzbUskvhLHpSZG/I4gQRwBTbrgre1dFAP8a
	 g8DyB/CJHxBJvLe883B83QDjgYrhKVPaSuuDF8Rws1Nw1zaAXTadIFxMalC0u/hwkZ
	 4i+5nWtw3dcnw==
Date: Thu, 15 May 2025 10:22:18 +0200
From: Niklas Cassel <cassel@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
	hare@suse.de, kbusch@kernel.org, sagi@grimberg.me,
	jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
	gjoyce@ibm.com
Subject: Re: [RFC PATCHv5 0/3] improve NVMe multipath handling
Message-ID: <aCWkOhlsfma3w17c@ryzen>
References: <20250514130322.393656-1-nilay@linux.ibm.com>
 <20250514152244.GA32525@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514152244.GA32525@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_012224_258151_831AFEF5 
X-CRM114-Status: UNSURE (   8.54  )
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

On Wed, May 14, 2025 at 05:22:44PM +0200, Christoph Hellwig wrote:
> Thanks,
> 
> applied to nvme-6.16.

The patches for this series on nvme-6.16 seem to be missing your SoB.


Kind regards,
Niklas

