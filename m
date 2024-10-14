Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1DCCF258D
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 10:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=asrMHu4/nIoSMVKPEYgAU043GWE1R0YNdsEzEZ+2nYs=; b=JSdTI4Y2LbDBnxEPqIEuKaIcPX
	kwIC/T0x/Dx5gu+3T4Qi4By1plxXXOabdtvkYjz2SGoc8yxhDHSr2sRxjdheSOAOx35duKMebuFWE
	72tO7/DgWLo6kG6bGNXpzPlz8ZsUffTxXhhLIvbOM4lGB5M9rDm2Ftvna6TpCMZ9R2PiCJ1FJWl5w
	RvWCZuXX1Ci1vvQ/Np/+Pv/1z+lOKD1LgJtp/L+Tl5qgYLAboZF1Jl0GoUnyJEAJuCdVPxKgNK2u9
	odgyrGKvKvT/ep8kwcVJCXOYkZCuMv/4fvHWEYUp3WiQr2Me0gDTTegccMXX82unJjsYQ1NawuUIo
	tIMp94dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0IXJ-00000004iyy-0JrS;
	Mon, 14 Oct 2024 10:42:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0IVu-00000004ipf-3gEd
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 10:41:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E52DC5C51AD;
	Mon, 14 Oct 2024 10:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC83C4CEC3;
	Mon, 14 Oct 2024 10:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728902482;
	bh=B9CmGqSiB0qg80nzJv8rM8Wv+9unf2VSkjZ7TkKL7rg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ElZoaXLt/T7F0mSPpWzd6vA/w6/0LR/Z5wYJ7JqL66xEGSs4AHCFkvfzVziOMssvh
	 GyuzvJ0BsvJWN4EnokWdtzlnGMWOp/GUt+HSED0lv8SjnExhuVcfqfvtps5mxbrAER
	 DBWnpYpvdP2RIU/7/hsBGWJiffvd/cSTHMYXZGhyE73sr4t2S7oun9vdm88Bgqt6sC
	 +X0gWw8cx99OOpsfOHhKNfzty6hM0Q54LHYNAgWaOuZ9D/MFhvWDI2QxFXdiFOdFKt
	 go4z9picDkPzPIAGmqel6zJyjGfjf6mGtMzwtEBdijo4EzjS9/546X3DAFSFKioV+G
	 Y6w/4JS20XJvg==
Message-ID: <79e57ebb-eef7-48b1-b337-845d2ef6ff49@kernel.org>
Date: Mon, 14 Oct 2024 19:41:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 4/5] PCI: endpoint: Add NVMe endpoint function driver
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
 <20241011121951.90019-5-dlemoal@kernel.org> <20241014084424.GC23780@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241014084424.GC23780@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_034123_219245_CF8F505F 
X-CRM114-Status: GOOD (  16.24  )
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

On 10/14/24 17:44, Christoph Hellwig wrote:
> For one please keep nvme target code in drivers/nvme/  PCI endpoint is
> just another transport and should not have device class logic.
> 
> But I also really fail to understand the architecture of the whole
> thing.  It is a target driver and should in no way tie into the NVMe
> host code, the host code runs on the other side of the PCIe wire.

Nope, it is not a target driver. It is a PCI endpoint driver which turns the
host running it into a PCIe NVMe device. But the NVMe part implementation is
minimal. Instead I use an endpoint local fabrics host controller which is itself
connected to whatever target you want (loop, tcp, ...).

Overall, it looks like this:

         +-----------------------------------+
         | PCIe Host Machine (Root-Complex)  |
         | (BIOS, Grub, Linux, Windows, ...) |
         |                                   |
         |       +------------------+        |
         |       | NVMe PCIe driver |        |
         +-------+------------------+--------+
                           |
                 PCIe bus  |
                           |
        +----+---------------------------+-----+
        |    | PCIe NVMe endpoint driver |     |
	|    | (Handles BAR registers,   |     |
	|    | doorbells, IRQs, SQs, CQs |     |
	|    | and DMA transfers)        |     |
        |    +---------------------------+     |
        |                  |                   |
        |    +---------------------------+     |
        |    |     NVMe fabrics host     |     |
        |    +---------------------------+     |
        |                  |                   |
        |    +---------------------------+     |
        |    |     NVMe fabrics target   |     |
        |    |      (loop, TCP, ...)     |     |
        |    +---------------------------+     |
        |                                      |
        | PCIe Endpoint Machine (e.g. Rock 5B) |
        +--------------------------------------+

The nvme target can be anything that can be supported with the PCI Endpoint
Machine. With a small board like the Rock 5B, it is loop (file and block
device), TCP target or NVMe passtrhough (using the PCIe Gen2 M.2 E-Key slot).

Unless I am mistaken, if I use a PCI transport as the base for the endpoint
driver, I would be able to connect only to a PCIe nvme device as the backend, no
? With the above design, I can use anything support by nvmf as backend and that
is exposed to the root-complex host through the nvme endpoint PCIe driver.
To do that, the PCI endpoint driver mostly need only to create the fabrics host
with nvmf_create_ctrl(), which connects to the target and then the nvme endpoint
driver can execute the nvme commands with __nvme_submit_sync_cmd().
Only some admin commands need special handling (e.g. create sq/cq).

-- 
Damien Le Moal
Western Digital Research

