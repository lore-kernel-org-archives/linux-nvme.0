Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04150ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5NHyhfhnQ8KDlBmUfwnggZyr3m6gJNtac4NIBXddULo=; b=TSwNX1LyR2YJAxwqZUMtSsKwNF
	7VhXvEZ9PD35L3EzRhfDf/0uNr+VfqM3rR5v9oZBtkzN+hLh8Mo5ODLIaRYzLdNTQw8J78PBuJW9v
	gPBK2TVLLmO3ZrsNPcFSXUbjsMsGlO+IUfCIqW/SsTA01C7eqnF7vQiVwCN7S+uFXNInEYnxPmLJx
	pKziSsGDdBfm2ZGhsWyyZooNsVyWQp0nCMPCM0xamvHG9NZGbahLb7VtxUGKCLLhajmNLBL3brDmr
	/Hw+4ao8xt14FcS0PDWmCe76HQq2Xgg+WYuO/cGgpBn5pYazTGpUilBW+WVCbIa/889npkBt8Kmvc
	mijvGAhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSgOw-00BHNH-3n; Mon, 29 Aug 2022 15:10:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSgOu-00BHLz-0f
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 15:10:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D775161055;
	Mon, 29 Aug 2022 15:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA1DC433D6;
	Mon, 29 Aug 2022 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661785806;
	bh=a5fmWaWeaASCn9rRtbokZR+t98Sgv0zH8DSDDO5JftE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvG6WtAgve2NEbSAZcbZY0nkQq53lBuKfFQ0BNOri4nAZXCaUN56tih1q49X7gUJn
	 zgOz/CChunerTwRjtXN1cunkD9MLatLpaT7WU22uML+QYk9Cnv58fZ++4hxD4hxayN
	 QoMQBMVSyMjtOB52sRlXZr6kom5qCBcUPSaoiMPknoV2jS8xynBMALP89P5jOI5eQM
	 ou8iYZz2r6fN5xBgYy2zwNDWj21t83Bj3GNap7Mmuvl5o9DkEo7/LHdZQenVPhGvm3
	 HWo6j+hUictfhwU5I901/UlK9Bpp8RnbRqKp53ebbFdV1XIHPOegwUrbJIZUwwrpgk
	 +ZnfI7XumRYIw==
Date: Mon, 29 Aug 2022 09:10:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
Message-ID: <YwzWyrFahUlqs2fx@kbusch-mbp.dhcp.thefacebook.com>
References: <20220829081256.24570-1-lengchao@huawei.com>
 <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com>
 <59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com>
 <ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_081008_142633_DF67E0C7 
X-CRM114-Status: GOOD (  20.14  )
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

On Mon, Aug 29, 2022 at 05:56:39PM +0300, Max Gurtovoy wrote:
> On 8/29/2022 4:16 PM, Chao Leng wrote:
> > On 2022/8/29 18:43, Max Gurtovoy wrote:
> > > On 8/29/2022 11:12 AM, Chao Leng wrote:
> > > 
> > > You can mention that also in iser, if supported, the default is to
> > > use IP_CHECKSUM for DIX and not CRC.
> > According to DIX define:DIX = IP_CHECKSUM.
> > To reduce CPU utilization, the end-to-end DIF for SCSI protocols is
> > DIX-DIF when supported by hardware.
> 
> From what I re-call DIX was protection between host_buff -> host_device and
> DIF was protection between host_device -> target_device.
> 
> If now its defined as DIX == IP_CHECKSUM and DIF == CRC please mention it
> somehow in the commit message.

Where is this coming from? The NVMe command set spec says this is the
difference between DIF and DIX:

  The primary difference between these two mechanisms is the location of the
  protection information. In DIF, the protection information is contiguous with
  the logical block data and creates an extended logical block, while in DIX,
  the protection information is stored in a separate buffer.

Regarding CRC vs IP Checksum, the spec also says this:

  In addition to a CRC-16, DIX also specifies an optional IP checksum that is
  not supported by the NVM Express interface.

So DIX support doesn't imply IP checksum. Even if the host device can support
it, the target device can not report it uses that guard type.

