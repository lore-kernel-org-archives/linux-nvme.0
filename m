Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99A2C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2A66023F
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2A66023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ybFMGullYRAImCSn+DJpNy/4gNPThbykhsNBZ5L93VM=; b=FTQw16JSApi3TMvOKQ2RFwCP2
	XP46griUkiajNAoDmG/h8MeZo7P8Nj0chpf3lsdLaTCtDHFCxQKDdChKjPp/3X48L1gnQBaU1M8eS
	HJIEhTeEDN79hf9rblkPblrSfJdfGRbz7hHqAYfqUC4csxyPtAHyaNgcEQSTsjBg1iJvl83Y2M8Q3
	NJ4mo1j/2MdrFi9dYDWYSVU7YtRyh30KOVNkSIdG8QGHPC1kVwuuNJF37JiEmkRI4f40+KZpv9y6g
	L+iNUIQ7Sk3fGgtsj9I8dtrMCbJBLKrBgIb/QB7J+AAVAezWtX7u2RmVM8A6b8Ip4nWI+szOheXtq
	+0GUJ7QoQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRmUZ-0088xX-3o; Thu, 01 Apr 2021 01:51:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRmUT-0088wJ-DU
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 01:51:23 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85E5B60FE9;
 Thu,  1 Apr 2021 01:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617241878;
 bh=w2EA5FH58acAY+G7QuMkmrc8UXugNENCjnxmndfLvio=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=h2FaTDUDCAakp911VjtWsfjlObXfZaliMqSIQ28OGnfFfuJPhy6zDHWiaO+f3WFKe
 XQW5vhJsW0MDBoog3H2axoxStFpJcDwAABa8QHGhZqYyhfbJurplbFCVy5ul3Wrtac
 uHC8Vpw4uhtio3gC+IOg5zMji/nJ27+o1eHcOG2tCsB1VAWsq2p4xdo3meYAHRuLt9
 /dwguifKvin9dZfw5qQtdJv96Ts+dfpkX0jvA1sVKXL28lXke6HnpAlQ0bmh4e1xlZ
 k2IxXAbEKj7ZgOqvhPSwWQoyybTJytj9Dalf4J3k2QVXPTnYgp9jvlVdkm8+A0WSM8
 xoNb5YKSk3LNQ==
Date: Thu, 1 Apr 2021 10:51:12 +0900
From: Keith Busch <kbusch@kernel.org>
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v2] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Message-ID: <20210401015112.GB28381@redsun51.ssa.fujisawa.hgst.com>
References: <1617194885-459-1-git-send-email-Prike.Liang@amd.com>
 <BYAPR04MB4965506223DD3DE08DA3CC22867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR12MB3238BBBED21B92C3BA69B682FB7B9@BYAPR12MB3238.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3238BBBED21B92C3BA69B682FB7B9@BYAPR12MB3238.namprd12.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_025121_783553_C3E4C3EF 
X-CRM114-Status: UNSURE (   9.34  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 01, 2021 at 01:04:43AM +0000, Liang, Prike wrote:
> [AMD Official Use Only - Internal Distribution Only]

This header is not appropriate for public list communication.

> > > +static const struct pci_device_id pcie_ids[] = {
> > > +{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_RN) },
> > > +{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_CZN) },
> > > +{ }
> > > +};
> > > +
> >
> > why new global pci_device_id array is needed ?
> >
> [Prike] This pci_device_id  array contains the platform root complex DID which need shutdown the NVME in this armed platform for s2idle.

I think Chaitanya is just suggesting you move this declaration to the
scope that uses it. 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
