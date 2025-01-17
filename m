Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0026C02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 19:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9N1z/h1aszj4YgybVI9Dvy6HuqK64t8ooLuPXhu8htA=; b=hhYkjoflBquzEkcB9XmMuTvuE5
	hSNRbTa4HYQErcB2Lzvqs5W/P/6d5zbEWlvqBW8EycNesk/FuXWoVebkve7a5/p/2oSpkelRkflmq
	IZ8/JfpPZb2Y2OYca3hH+jfFqt6M2dDB5sppuIbF7avhjhlAwUB5HMCkGM+yBoprab+fiyDGD30fa
	lHQqayzn/2yk4F0APnzyYpw4Fs4zzM0nj7yQpOIwfFbNqe8GwW+b4HpV6nSd2USK471YHt50F5NMp
	J4jppre1stt/TImiHKHRW7LgllZ8d956gQ0wMBYMrj2CMECA09Fj/MsIaq972DyhMYMDHd9x0fIn6
	p1Q8vGlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYrs2-00000001DrR-1gNe;
	Fri, 17 Jan 2025 19:19:06 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYrrz-00000001DqP-2Ueo
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 19:19:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6EC96A433C4;
	Fri, 17 Jan 2025 19:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FE9C4CEDD;
	Fri, 17 Jan 2025 19:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737141540;
	bh=J37cCHEzW87hmQdTbDL6PucFuy2wSMRXNjvrHD6jXa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVR55YIZuTWG3V+qHa8tYkRZh1dm2MJRaixfybFG5tqIdfNHX3J49XpwnYMYNERV6
	 IFtnUZGCtCw33FG/2a+BhWweQGPQ7RvsXJMvEGg4qEc0V80gInHlLl0SPGWHHHAfQF
	 hOaErtjsaJZhMV7twuD80MN+/DNOjfr2sGjgh82NzsAN+XzzkDMg/JuUXN+csbci1W
	 LYWt70QVtzeb2hK9SMSm8ccJdGrB5KUa3CqYLZ452Hs1y2Oi8pjF7L0RltTrnjWcz5
	 AyWAPopCOk7ExEW7K9K+aeR4ZQGBcAkVsOLTxJT95YF8YkJBc9nXNwQtjQ0wU1AMtV
	 qmP15JURuiH4g==
Date: Fri, 17 Jan 2025 12:18:57 -0700
From: Keith Busch <kbusch@kernel.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme-pci: Add TUXEDO InfinityFlex to Samsung
 sleep quirk
Message-ID: <Z4qtIe_qmA_Anb4b@kbusch-mbp>
References: <20241216223145.135942-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216223145.135942-1-wse@tuxedocomputers.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_111903_699168_C5893EFB 
X-CRM114-Status: UNSURE (   9.45  )
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

On Mon, Dec 16, 2024 at 11:28:03PM +0100, Werner Sembach wrote:
> From: Georg Gottleuber <ggo@tuxedocomputers.com>
> 
> On the TUXEDO InfinityFlex, a Samsung 990 Evo NVMe leads to a high power
> consumption in s2idle sleep (4 watts).
> 
> This patch applies 'Force No Simple Suspend' quirk to achieve a sleep with
> a lower power consumption, typically around 1.4 watts.

Thanks, both patches applied to nvme-6.14.

