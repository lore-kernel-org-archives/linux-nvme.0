Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E47ECFC52F
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 09:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZTilPAshgeafEnZ7NpmlHAYn9VnU6E9tgUcFSoDCaqk=; b=N31tyT3Gu1aEgcQQXKg905dk+w
	T0fNzDDBkERJJ0VwRE/A5YzPQ3x+Nmt61PxCmVRF10T7n62+N7EI8h4HrRw6jGQ/D1ZSstKVLu12I
	eOd1QT6UexVh2HPsOeNDdupI0Oz/CYMTybhtacLxAGbSlDpsRvgnMBEMnNdX45KRPd202aX7zlgit
	UubngeqyeHL34uanVEA65HJMBQ5oo8l/qlXvp5V7E0+xW2cscU50Hw2qDE2ua5FPSijB9KZGuUloy
	5wEOoJDusjMTxh5QQwGtB9U6yYWm5amZ7DS2dNnMmgwIrEAfswZYd/ptRdiklIJBXGey0JwTS6aUy
	4D0cQ88A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0HRa-00000004XQ2-0d4h;
	Mon, 14 Oct 2024 09:32:50 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0H6B-00000004S2P-2qD5
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 09:10:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8881EA4178C;
	Mon, 14 Oct 2024 09:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DCFC4CEC3;
	Mon, 14 Oct 2024 09:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728897041;
	bh=trSRhS03qp4HKvL2dERLbqHVvB36sFOgTjMjlWIPVuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XtFuW5uCiYp7xKZwDdaxhC1273sMW+l6VbwktiGz9lUaAAg4emkH2wQfmRnCavdkD
	 KqS631jpHLYiV3m2bugF5fx2tsb2RHLX3NPJUvSyzO3KT4blNSmkBy2uHW0d/IW8lN
	 KOT7CTsY+vtgoIETjqiYlZYpms7vDj8UdiO5LdrfjvtZm6DZ6q+SM+8hrutVaS7Puj
	 sOUrevOdahGVztw+riR9FifEiFEpsaC9vrWJBsEqoJRMPgEVstl7kLrU3QiEVWARgI
	 Htbu+EAKTgFYR+QfBiU+6byHzoRKRoo1XbTNUxsBa+rMRIRaNRg/0n1dHS3HP/yWCz
	 +RZA/I2mbv5Ig==
Message-ID: <62ba5cda-338e-48bf-b82e-60e4721b1bfb@kernel.org>
Date: Mon, 14 Oct 2024 18:10:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] nvmef: export nvmef_create_ctrl()
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241011121951.90019-1-dlemoal@kernel.org>
 <20241011121951.90019-3-dlemoal@kernel.org> <20241014084219.GA23780@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241014084219.GA23780@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_021043_819981_D251B4DB 
X-CRM114-Status: GOOD (  19.25  )
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

On 10/14/24 17:42, Christoph Hellwig wrote:
> s/nvmef_create_ctrl/nvmf_create_ctrl/
> 
> But evem looking at the code later using it I fail how this could
> work.
> 
> nvmf_create_ctrl is used to implement writes to the /dev/nvme-fabrics
> control device to create a fabrics controller out of thin air. The
> biggest part of it is parsing the options provided as a string,
> which most importantly includes the actual transport used.
> 
> But you really need to force a pcie transport type here, which
> as far as I can tell isn't even added anywhere.

Nope, the PCIe "transport" is the front-end of the endpoint driver.
What this patch does is to allow this driver to be created by passing it a
string that is normally used for "nvme connect" command, which calls
nvmf_create_ctrl().

The entire thing was created to not add a PCIe host transport but rather to use
a locally created fabric host controller which connect to whatever the user
wants. That is: the PCI endpoint driver can implement a PCI interface which uses
a loop nvme device, or a tcp nvme device (and if you have a board that can do
rdma or fc, that can also be used as the backend nvme device used from the pci
endpoint driver).

I only need this function exported so that I can call it from the configfs
writes of the pci endpoint when the user sets up the endpoint.


-- 
Damien Le Moal
Western Digital Research

