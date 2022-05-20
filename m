Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01938C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 14:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nEuXvaLw8bk6M+ZFvd1GIQYT76m1dVoc0euR3e6fxsE=; b=itaXhBPFl4nTTUZh5Mr2kp6Gm1
	JtvhEMi2I2Vq9Hd4N2M8ySOAZpqPSHyjp0n8hh+0MUl4ODG0piZ2dsLfQOnN3V/kAyV8ycIJ6z3fR
	jh9r7TO0+wLD2WDOA0w+tgylPIjd8iiFBt/V5hpijRvi09vBuENRruHLSV/YKxzqd8ZQQS9/pnfVm
	37Zjda4NJSen0kVsjjPXK3S+LAaivbCLVdFwh3TJxyU6BwG12WBoQYH8jz7UqSzfRvvN+CwwuD6dP
	wbyfM6YCtcv/+0a5mn9dM7Rd+5XQ+TzG9XS0MM3Ny7NIUXwLoVhzlO8wgll50Pc1kmJsdWtj6Ls76
	NNnrq4rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ns3NR-00Cqtf-CH; Fri, 20 May 2022 14:13:13 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ns3NO-00Cqsa-O0
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 14:13:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 44472B82B4F;
 Fri, 20 May 2022 14:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97433C385A9;
 Fri, 20 May 2022 14:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653055988;
 bh=S7PiT9V2HMtw7xlVVXCSddMSQV1CdKxdbapHYWotkQI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AyArb2RCE3mBOcc8ogdW78EjXr0hQD62PiA3kxs7zallJRyzQhKLvLcviNrE6fY/8
 cRhFZ+i2HuSl+YHQuzOGMCd4AqjBkarmS0MyPXTTModkksq8Lz3P8NZ8xVweLwGZWL
 R0EjqF69/goR8NvqnoiFR5cY3ffKm24eQTbejM4rKcnOJyBy7otlTqpXg6bOq/eOhs
 qqa31OzYaaEtIKFQYeCBcYxnKfjT9OTPamPUv7g9fNU7lZSm45JENHKrnDOmXO3MwN
 laFd8bqbXrl4P+nJDcSX1tHbV0S3n3GOsizhir1k9n0zsZd6XD7lvx2RxyW4lRpUwl
 O1v2D3yUVKZcA==
Date: Fri, 20 May 2022 08:13:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: add support for TP4084 - Time-to-Ready Enhancements
Message-ID: <Yoeh8KyvZbOPOrqy@kbusch-mbp.dhcp.thefacebook.com>
References: <20220518064040.3223894-1-hch@lst.de>
 <YoUEf5nsyhVzeDH/@kbusch-mbp.dhcp.thefacebook.com>
 <20220518150044.GA1359@lst.de> <YoeA1Lh9oxwyao2S@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YoeA1Lh9oxwyao2S@x1-carbon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_071310_946658_7B68DA37 
X-CRM114-Status: GOOD (  16.21  )
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

On Fri, May 20, 2022 at 11:51:49AM +0000, Niklas Cassel wrote:
> From the CC.CRIME description:
> Changing the value of this field may cause a change in the time reported in the
> CAP.TO field. Refer to the definition of CAP.TO for more details.
> 
> The definition for CAP.TO:
> If the Controller Ready Independent of Media Enable (CC.CRIME) bit is set to ‘1’
> and the worst-case time for CSTS.RDY to change state is due to enabling the
> controller after CC.EN transitions from ‘0’ to ‘1’, then this field shall be set
> to:
> a) the value in Controller Ready Independent of Media Timeout (CRTO.CRIMT); or
> b) FFh if CRTO.CRIMT is greater than FFh.
> 
> This phrasing is quite confusing IMO.

Yes, that is rather confusing. I see you started a thread on the nvme workgroup
reflector. I hope they can clear this up.
 
> It would have been way easier if it was just separate registers for
> enable and disable timeouts...

That just makes too much sense. :) The two actions could reasonably have very
different expected times to complete, so why squeeze their timeouts into a
single value? It's not like we're running low on register space.

