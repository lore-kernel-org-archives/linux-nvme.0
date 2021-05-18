Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED02C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 07:15:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AA561166
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 07:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AA561166
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RLGZFHXzvm7JuH1gVLAn4/MqjBJBmGxmSwoos3mx/1k=; b=Ty+cXwPN6IgO2drQNxf2n0tD6
	QnQIdLQgpk2hA7blRT+JGMBpJYwOtw9BtZOTchxCs5vJ6jByiWBDiFVpBpR924uFecrHGc1nQZE/2
	E60cIEDMces2kmTVAn5GDOpqTsPXEAOOIysYEsgybDURnSrbRZLOquYqeSym47ZKm3FzwoBohddN+
	x3BMhRhgYNXcYCsU0RoVCnyX3QW4o0tJrKo0dTW6LXavxH8yZta3gLFZxYsi5Y0QXI9ibbSSG3h8U
	ZAImuyfWhuCeP5Br8LBrTvPoEuW62gXnRFfPxvW+MQsh+lAv4iOB/JyjAp7VEb1NbWmpAzdjQSTrp
	n8+u9AzPw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1litwB-00HGmK-Au; Tue, 18 May 2021 07:14:43 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1litw7-00HGlA-SV
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 07:14:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AyyyboSdxcwjXKPkYSVa7TRAc1iRiz5AGbFIF5JmJfA=; b=u3SBkRr/82s+40upl3jgkMsJHl
 GXNYlLjYaxfof1p0FNIl0UgzOyoSln7hie4n7ITmFe/qowAGDPfqVFKzzfquiI123V/SeultBTXHy
 4xgNwavCzfwGkRebnjzwI4PBBUM+3DcKuE1rPvdeAsy+LStNAP/l/dZ1WumGOxPcTtsdw7qaSefZp
 QK4ufuGyNvB6eeNUu8SuoAuHuTxrTLqOetXE5bdCEtd77vPBtymPUjKxFQMIvuqnayoMNGaHcTHtZ
 buYcneRC2YMgmutJkv5QEk2G+kq/awu7JiWQR8fhtpU7cx7BxwIxqGbrFY/mWlMBOO5hcOVxDOE79
 +wvEM+yg==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1litw5-00EOdj-Bd
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 07:14:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6379267373; Tue, 18 May 2021 09:14:34 +0200 (CEST)
Date: Tue, 18 May 2021 09:14:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Prike Liang <Prike.Liang@amd.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org, kbusch@kernel.org,
 axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, Alexander.Deucher@amd.com,
 stable@vger.kernel.org, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH v5 0/2] nvme-pci: add AMD PCIe quirk for NVMe simple
 suspend/resume
Message-ID: <20210518071434.GA8635@lst.de>
References: <1621304675-17874-1-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1621304675-17874-1-git-send-email-Prike.Liang@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_001437_564302_4764E990 
X-CRM114-Status: GOOD (  17.58  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This looks ok to me now.

As a note to the people in AMD who came up with this scheme:  having
to shut down the controller every time s2i is entered not only generally
uses more power than using power states, but also means every time
s2i is entered the SSD needs to write to the media, which causes massive
endurance shortfalls.

On Tue, May 18, 2021 at 10:24:33AM +0800, Prike Liang wrote:
> Those patch series can handle NVMe can't suspend to D3 during s2idle
> entry on some AMD platform. In this case, can be settld by assigning and
> passing a PCIe bus flag to the armed device which need NVMe shutdown opt
> in s2idle suspend and then use PCIe power setting to put the NVMe device
> to D3.
> 
> Prike Liang (2):
>   PCI: add AMD PCIe quirk for nvme shutdown opt
>   nvme-pci: add AMD PCIe quirk for simple suspend/resume
> 
>  drivers/nvme/host/pci.c | 2 ++
>  drivers/pci/probe.c     | 5 ++++-
>  drivers/pci/quirks.c    | 7 +++++++
>  include/linux/pci.h     | 2 ++
>  4 files changed, 15 insertions(+), 1 deletion(-)
> 
> -- 
> 2.7.4
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
