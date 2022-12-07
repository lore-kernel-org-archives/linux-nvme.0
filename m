Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0EBC63705
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 22:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DqtapQlGzJiaVJwAyZNl+yEO4InZt+m1TbMtiT3QL5Q=; b=h4QsQcmJa28ZEs6eRByT1t9nCF
	v9hsE2Fwg0X3S6T5FKdfJqegGRfVIoyQmqFhrCNAIIbO2M+npkrmboE0EocZcYPUZfc5uKW54ATNY
	IE8jvI2oudCa7//elv2zTwhlG/mPRIuHJFcH8U8mQTl2EiJwfJbhzXZ9iLk6y0P73bnRnTX1oTr3s
	8zyADAkA/KC7LMg4dN9gQhhfxeEnRKiwsbtcVmzK5/VwanvWYprnpH8MJ2PyXG9vQSwI8B9WI1D0J
	wxzYh8iZFarw5LD5lZSemRDR7ayHf11ADgcZvSbLrZxTo/aqro0DV6m/htK/80nANTisATdH30JPm
	9X+TEySA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p337b-00EToO-1b; Wed, 07 Dec 2022 22:42:35 +0000
Received: from out-127.mta0.migadu.com ([2001:41d0:1004:224b::7f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p337Y-00ETf3-Hx
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 22:42:34 +0000
Message-ID: <ef7bffa5-5d74-ada2-87e7-2f0a442f3240@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1670452947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DqtapQlGzJiaVJwAyZNl+yEO4InZt+m1TbMtiT3QL5Q=;
	b=nJxZNEmokp21qEk9nuSPIXQkdkCwz3MdUf0PiBPp6toOadezALmgjyIqNpLpuknUt00yxv
	4C3mFhGH9YywKSAb2rCSJwbyVOTdYSdpyYQNe9hfS8JNVt+AChXvwYzysZfbRl1njDqb7f
	T5cAK+F5pfTVMw3Ns9GZzbKKELUw/C4=
Date: Wed, 7 Dec 2022 15:42:25 -0700
MIME-Version: 1.0
Subject: Re: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
To: linux-nvme@lists.infradead.org
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-6-lei.rao@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20221206055816.292304-6-lei.rao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_144233_037500_D2A4D9B4 
X-CRM114-Status: GOOD (  19.23  )
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



On 12/5/2022 10:58 PM, Lei Rao wrote:
> The documentation describes the details of the NVMe hardware
> extension to support VFIO live migration.
> 
> Signed-off-by: Lei Rao <lei.rao@intel.com>
> Signed-off-by: Yadong Li <yadong.li@intel.com>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Eddie Dong <eddie.dong@intel.com>
> Reviewed-by: Hang Yuan <hang.yuan@intel.com>
> ---
>  drivers/vfio/pci/nvme/nvme.txt | 278 +++++++++++++++++++++++++++++++++
>  1 file changed, 278 insertions(+)
>  create mode 100644 drivers/vfio/pci/nvme/nvme.txt
> 
> diff --git a/drivers/vfio/pci/nvme/nvme.txt b/drivers/vfio/pci/nvme/nvme.txt
> new file mode 100644
> index 000000000000..eadcf2082eed
> --- /dev/null
> +++ b/drivers/vfio/pci/nvme/nvme.txt
> @@ -0,0 +1,278 @@
> +===========================
> +NVMe Live Migration Support
> +===========================
> +
> +Introduction
> +------------
> +To support live migration, NVMe device designs its own implementation,
> +including five new specific admin commands and a capability flag in
> +the vendor-specific field in the identify controller data structure to
> +support VF's live migration usage. Software can use these live migration
> +admin commands to get device migration state data size, save and load the
> +data, suspend and resume the given VF device. They are submitted by software
> +to the NVMe PF device's admin queue and ignored if placed in the VF device's
> +admin queue. This is due to the NVMe VF device being passed to the virtual
> +machine in the virtualization scenario. So VF device's admin queue is not
> +available for the hypervisor to submit VF device live migration commands.
> +The capability flag in the identify controller data structure can be used by
> +software to detect if the NVMe device supports live migration. The following
> +chapters introduce the detailed format of the commands and the capability flag.
> +
> +Definition of opcode for live migration commands
> +------------------------------------------------
> +
> ++---------------------------+-----------+-----------+------------+
> +|                           |           |           |            |
> +|     Opcode by Field       |           |           |            |
> +|                           |           |           |            |
> ++--------+---------+--------+           |           |            |
> +|        |         |        | Combined  | Namespace |            |
> +|    07  |  06:02  | 01:00  |  Opcode   | Identifier|  Command   |
> +|        |         |        |           |    used   |            |
> ++--------+---------+--------+           |           |            |
> +|Generic | Function|  Data  |           |           |            |
> +|command |         |Transfer|           |           |            |
> ++--------+---------+--------+-----------+-----------+------------+
> +|                                                                |
> +|                     Vendor SpecificOpcode                      |
> ++--------+---------+--------+-----------+-----------+------------+
> +|        |         |        |           |           | Query the  |
> +|   1b   |  10001  |  00    |   0xC4    |           | data size  |
> ++--------+---------+--------+-----------+-----------+------------+
> +|        |         |        |           |           | Suspend the|
> +|   1b   |  10010  |  00    |   0xC8    |           |    VF      |
> ++--------+---------+--------+-----------+-----------+------------+
> +|        |         |        |           |           | Resume the |
> +|   1b   |  10011  |  00    |   0xCC    |           |    VF      |
> ++--------+---------+--------+-----------+-----------+------------+
> +|        |         |        |           |           | Save the   |
> +|   1b   |  10100  |  10    |   0xD2    |           |device data |
> ++--------+---------+--------+-----------+-----------+------------+
> +|        |         |        |           |           | Load the   |
> +|   1b   |  10101  |  01    |   0xD5    |           |device data |
> ++--------+---------+--------+-----------+-----------+------------+
> +
I'm assuming by using these vendor specific opcodes and id-ctrl's vu space, that
you should make this code be protected by some kind of vendor/device specific-flag
or preferably something standard.

No way of knowing what 0xC4 will do on a non-lm drive, for instance

