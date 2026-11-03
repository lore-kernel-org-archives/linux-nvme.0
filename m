Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00759606A332
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=36tS5igR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=14bHShu2iPXe36kFNXnmMY1PSKPIdcxdfamaZqMSzpY=; b=36tS5igRTQU3hhnfvLLHlj8OpL
	vKHgMGe5Ly5jFwNc1lO6HTO/+BrV76m/Ho+ian2mTcJuMGiVB8+rJpvpl5wuqGclg4OEO4ev4dNvO
	Pwhgx9AUQkDW4F2xpoK08k8X1Jk9Zd7OQLazbbVxn5Q4JqlP+Nvc7239EBB5qlVEmE4+e6imCM7QD
	ENIXVun6Bzj0MYo+yY8PFdH8jVlgJrv+8ytLcY8sppdw4kaC9zQ1JFlz8jKxL4WKl9qvki4LKIrHM
	xN7jlnMN/SI46nmsFiOLGtEoV8fmt7HkZ+AYgePT3D6U3MmISAdEHOm5s2yeQA6sGYY0suV5mONRu
	ZhyucYxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9Pv-00000001Snx-2ooR;
	Tue, 03 Nov 2026 07:58:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9Pt-00000001Smz-3RZJ
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 07:58:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A470668AFE; Tue,  3 Nov 2026 08:58:45 +0100 (CET)
Date: Tue, 3 Nov 2026 08:58:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robson Cassiano <linux@robsoncassiano.software>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexey.Bogoslavsky@sandisk.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_NO_SECONDARY_TEMP_THRESH for
 WD SN740
Message-ID: <20261103075845.GB3882@lst.de>
References: <WnzOhxjlW7w5jwpSIQmUzrvduOStpoX2h3FS@robsoncassiano.software>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <WnzOhxjlW7w5jwpSIQmUzrvduOStpoX2h3FS@robsoncassiano.software>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_235850_015634_8860B517 
X-CRM114-Status: GOOD (  24.35  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 12:05:13AM -0300, Robson Cassiano wrote:
> The WD SN740 (15b7:5017) reports two secondary temperature sensors in
> the SMART/Health log but returns the 0 and 0xffff (Kelvin) sentinels
> for their temperature thresholds. nvme-hwmon exposes those as
> temp2_min/max and temp3_min/max, producing -273.15 C and 65261.85 C in
> sysfs.
> 
> Mark the controller with NVME_QUIRK_NO_SECONDARY_TEMP_THRESH so only
> the sensor inputs are exposed.

Given that this is an older device I suspect we're not going to
see firmware fixes for it.  But given that we had quite a few devices
with issues like this, I wonder why nvme-hwmon can't detect these
obviously fake values instead and we could drop the quirk?

> Assisted-by: LLM
> Signed-off-by: Robson Cassiano <linux@robsoncassiano.software>
> ---
> Tested on the affected system, WD SN740 512 GB, firmware 73100004:
> 
>   # lspci -nn -s 01:00.0
>   01:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD SN560/SN740/SN770/SN5000 NVMe SSD [15b7:5017] (rev 01)
> 
> Before, on 7.2.8:
> 
>   temp2_label    Sensor 1
>   temp2_input    53850
>   temp2_min      -273150
>   temp2_max      65261850
>   temp3_label    Sensor 2
>   temp3_input    38850
>   temp3_min      -273150
>   temp3_max      65261850
> 
> After, on 7.3.0 with this patch:
> 
>   temp1_label    Composite
>   temp1_input    45850
>   temp1_min      -40150
>   temp1_max      83850
>   temp1_crit     87850
>   temp2_label    Sensor 1
>   temp2_input    59850
>   temp3_label    Sensor 2
>   temp3_input    45850
> 
> temp1_* are the Composite thresholds and stay exposed; the quirk only
> suppresses the secondary sensor thresholds.
> 
> The quirk also covers the other models sharing 15b7:5017 (SN560, SN770,
> SN5000); only the SN740 was tested.
> 
> OEM systems: Dell OptiPlex 3000, Lenovo IdeaCentre AIO 5 and Samsung
> NP750QFG-KS1BR (the test system).
> 
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 77317e5..4f1f10b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -4170,6 +4170,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  	{ PCI_DEVICE(0x15b7, 0x5009),   /* Sandisk SN550 */
>  		.driver_data = NVME_QUIRK_BROKEN_MSI |
>  				NVME_QUIRK_NO_DEEPEST_PS },
> +	{ PCI_DEVICE(0x15b7, 0x5017),   /* Sandisk SN560/SN740/SN770/SN5000 */
> +		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
>  	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
>  		.driver_data = NVME_QUIRK_BOGUS_NID, },
>  	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
> -- 
> 2.56.0
> 
> 
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> 
---end quoted text---

