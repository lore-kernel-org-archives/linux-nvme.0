Return-Path: <SRS0=3UZ0=PO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A0FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 04:15:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9682C6103B
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 04:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9682C6103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5p+n+ZRG80jbql5OekKuKqhuYx3gVa/l0Ah/SrSPFoY=; b=mMG0jxe+uFIDtAWvNH0i39EMBR
	VLFGhxL1QFSz14vcj+dDwqktnh6JJhDFYU9YAsTr5RULrWyPXqGQedzxoNoEtkK2hlhzEvtwqNWYb
	rHUjoL8Ralokau/Jh/wH0HY17rvqRhoXLTQ6neAd3ytlZ7lxsYLI88tuDgLqzQLKjHjIla5O2017X
	3/npha0kQ2BjQC/ofAoj5JNIqRWgEbyZETsvH2jq0cdYmSvknSQc6OR/PXqZ7lwOJX8lz/81g1HuM
	TDAKVG6WfxevYaQTRyB9Yx8wlljyUbt13f/LFj0SkGQ5WhLQMFFu4RT3lejIKxsxPlOyhyTL2HT/r
	FxTGIezw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfDsH-000ZET-70; Tue, 26 Oct 2021 04:15:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfDsE-000ZDr-IA
 for linux-nvme@lists.infradead.org; Tue, 26 Oct 2021 04:15:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDDD360EDF;
 Tue, 26 Oct 2021 04:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635221741;
 bh=Upw18BMnAJNHZIJJpkphWj/uFqecyQTLJdSZFRJJJPU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rzAfIKq2hSoaUzW7YoqAGIOnLTuzUnaq2pQdkh0Iug5i0X7VdQz6TG/2QxUbIg80t
 2LBsKVXMtntLEKIhEGSzVo8H8nvxZalkrQS8XWjlT8PPIjj0TF8Y8NezKGjRHRo+6+
 WRehkG7fs1xGbuooYpfn1xccuePsl7oKhBX5eDU7h4f4uCg1wzT2aVvPyWad5MZ7cD
 oCCmVtikSjUPj9qU9FlSYA3Mxn/NbT7jexhdTVuCwdjN6LhCsooiozVuhYlEkLwDe4
 QOYpytUkqhZws97aGeK3Bmw49JefgJmPlS5/mZgY6DxNhIl9G5ygHkM5HnUofhhRKr
 6wmGShRuGQ+wQ==
Date: Mon, 25 Oct 2021 21:15:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Li Chen <lchen@ambarella.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Tom Joseph <tjoseph@cadence.com>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [EXT] Re: nvme may get timeout from dd when using different
 non-prefetch mmio outbound/ranges
Message-ID: <20211026041538.GB2335242@dhcp-10-100-145-180.wdc.com>
References: <CH2PR19MB4024E04EBD0E4958F0BBB2ACA0809@CH2PR19MB4024.namprd19.prod.outlook.com>
 <20211025154739.GA4760@bhelgaas>
 <20211025162158.GA2335242@dhcp-10-100-145-180.wdc.com>
 <CH2PR19MB4024372120E0E74C8F2CB685A0849@CH2PR19MB4024.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR19MB4024372120E0E74C8F2CB685A0849@CH2PR19MB4024.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211025_211542_654914_3FD13B10 
X-CRM114-Status: GOOD (  16.08  )
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

On Tue, Oct 26, 2021 at 03:40:54AM +0000, Li Chen wrote:
> My nvme is " 05:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller 980". From its datasheet, https://s3.ap-northeast-2.amazonaws.com/global.semi.static/Samsung_NVMe_SSD_980_Data_Sheet_Rev.1.1.pdf, it says nothing about CMB/SQEs, so I'm not sure. Is there other ways/tools(like nvme-cli) to query?

The driver will export a sysfs property for it if it is supported:

  # cat /sys/class/nvme/nvme0/cmb

If the file doesn't exist, then /dev/nvme0 doesn't have the capability.

> > > I don't know how to interpret "ranges".  Can you supply the dmesg and
> > > "lspci -vvs 0000:05:00.0" output both ways, e.g.,
> > >
> > >   pci_bus 0000:00: root bus resource [mem 0x7f800000-0xefffffff window]
> > >   pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
> > >   pci 0000:05:00.0: [vvvv:dddd] type 00 class 0x...
> > >   pci 0000:05:00.0: reg 0x10: [mem 0x.....000-0x.....fff ...]
> > >
> > > > Question:
> > > > 1.  Why dd can cause nvme timeout? Is there more debug ways?
> > 
> > That means the nvme controller didn't provide a response to a posted
> > command within the driver's latency tolerance.
> 
> FYI, with the help of pci bridger's vendor, they find something interesting: "From catc log, I saw some memory read pkts sent from SSD card, but its memory range is within the memory range of switch down port. So, switch down port will replay UR pkt. It seems not normal." and "Why SSD card send out some memory pkts which memory address is within switch down port's memory range. If so, switch will response UR pkts". I also don't understand how can this happen?

I think we can safely assume you're not attempting peer-to-peer, so that
behavior as described shouldn't be happening. It sounds like the memory
windows may be incorrect. The dmesg may help to show if something appears
wrong.

