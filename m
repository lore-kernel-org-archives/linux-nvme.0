Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8ABC369C2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 16:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rqQQxRUt2fHEWL0I20rkT0QAODykTg1VAd+Dl1bH3uM=; b=JZdi+3WTdl08GRc7t4vpERfFGU
	e+YLWhPDnxHpGtbLRd4ik/u/9zu2cS5p7nfKDXIkOK3rJlYfFSf5atbL+KOxEsyK2RINDrC8QNRIp
	r6MKZmZvfTa1lGsBz411ePLB0ReOcE5yjd7vVEXFf3OD5roirHNXsVwfiMJuxa2PJuOA0oV2OxucY
	5N9osAAJENg0rggcHDOVAucOs7nlsd5C1bo5/LDfvOYyWEjDVQKpfalVdiIEgxANXrUIHBW02TBSP
	VuMf2wIKt8fXzNokW9wP9V1lr2DNB7wQL3rh2c/iV3FNLmyFNpyrkgayxH7NANa9goWGAUzYAyk/O
	hpU4HK/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7z6l-0000000EfUy-01nJ;
	Thu, 24 Apr 2025 16:07:27 +0000
Received: from out-178.mta0.migadu.com ([2001:41d0:1004:224b::b2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7yPO-0000000ETuL-0qVY
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 15:22:40 +0000
Message-ID: <634e9a87-dcde-46a0-aac6-b29ac9bb00eb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745508151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqQQxRUt2fHEWL0I20rkT0QAODykTg1VAd+Dl1bH3uM=;
	b=qRL944iKPO5i9SISvFxDpLIxiB/BXHNC6KeqKdAgRLOBPoqcDIcfdtJE6UT9SWKDZsxGSr
	xgsZdZJeU/MO3fu3iaLXSU3+GuQs0/5qKtJm3amoEw+m+wc36KiwiuCYhPjk+9T2O8STBy
	xq1Ixx0GqCsAQhexwA/5baK4iL4MUp4=
Date: Thu, 24 Apr 2025 11:22:27 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] drivers/nvme: Add quirks for WDC Blue SN550 15b7:5009
To: Wentao Guan <guanwentao@uniontech.com>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de, linux-kernel@vger.kernel.org, hedgehog-002@163.com,
 rugk+github@posteo.de, wangyuli@uniontech.com, zhanjun@uniontech.com,
 niecheng1@uniontech.com, wentaoguan@vip.qq.com
References: <20250424024010.308175-1-guanwentao@uniontech.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250424024010.308175-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_082238_844168_761D4BAA 
X-CRM114-Status: GOOD (  21.68  )
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

On 4/23/25 22:40, Wentao Guan wrote:
> Add two quirks for the WDC Blue SN550 (PCI ID 15b7:5009) based on user
> reports and hardware analysis:
> 
> NVME_QUIRK_NO_DEEPEST_PS:
> liaozw talked to me the problem and solved with
> nvme_core.default_ps_max_latency_us=0, so add the quirk.
> I also found some reports in the following link.
> 
> NVME_QUIRK_BROKEN_MSI:
> after get the lspci from Jack Rio.
> I think that the disk also have NVME_QUIRK_BROKEN_MSI.
> described in commit d5887dc6b6c0 ("nvme-pci: Add quirk for broken MSIs")
> as sean said in link which match the MSI 1/32 and MSI-X 17.

As an update on this, in the link I say

| Well, the response from WD support was "we don't support Linux, and if
| we did there aren't any bugs in the drive anyway".

I continued following up with this (which involved running some
"diagnostic software" on a windows machine) and eventually they said:

| Please allow me to inform you that the provided part number SKU is an
| OEM Lenovo product. Western Digital Technical Support does not provide
| support (firmware or otherwise) for OEM (Original Equipment
| Manufacturer) drives. We would suggest you to contact your Laptop
| manufacturer. 

and that's as far as I took it. It seems like this bug is still present
in other SanDisk drives, so maybe you can take a crack at reporting it
if your drive isn't an OEM SKU.

--Sean

> Log:
> lspci -nn | grep -i memory
> 03:00.0 Non-Volatile memory controller [0108]: Sandisk Corp SanDisk Ultra 3D / WD PC SN530, IX SN530, Blue SN550 NVMe SSD (DRAM-less) [15b7:5009] (rev 01)
> lspci -v -d 15b7:5009
> 03:00.0 Non-Volatile memory controller: Sandisk Corp SanDisk Ultra 3D / WD PC SN530, IX SN530, Blue SN550 NVMe SSD (DRAM-less) (rev 01) (prog-if 02 [NVM Express])
>         Subsystem: Sandisk Corp WD Blue SN550 NVMe SSD
>         Flags: bus master, fast devsel, latency 0, IRQ 35, IOMMU group 10
>         Memory at fe800000 (64-bit, non-prefetchable) [size=16K]
>         Memory at fe804000 (64-bit, non-prefetchable) [size=256]
>         Capabilities: [80] Power Management version 3
>         Capabilities: [90] MSI: Enable- Count=1/32 Maskable- 64bit+
>         Capabilities: [b0] MSI-X: Enable+ Count=17 Masked-
>         Capabilities: [c0] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [150] Device Serial Number 00-00-00-00-00-00-00-00
>         Capabilities: [1b8] Latency Tolerance Reporting
>         Capabilities: [300] Secondary PCI Express
>         Capabilities: [900] L1 PM Substates
>         Kernel driver in use: nvme
> dmesg | grep nvme
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.12.20-amd64-desktop-rolling root=UUID= ro splash quiet nvme_core.default_ps_max_latency_us=0 DEEPIN_GFXMODE=
> [    0.059301] Kernel command line: BOOT_IMAGE=/vmlinuz-6.12.20-amd64-desktop-rolling root=UUID= ro splash quiet nvme_core.default_ps_max_latency_us=0 DEEPIN_GFXMODE=
> [    0.542430] nvme nvme0: pci function 0000:03:00.0
> [    0.560426] nvme nvme0: allocated 32 MiB host memory buffer.
> [    0.562491] nvme nvme0: 16/0/0 default/read/poll queues
> [    0.567764]  nvme0n1: p1 p2 p3 p4 p5 p6 p7 p8 p9
> [    6.388726] EXT4-fs (nvme0n1p7): mounted filesystem ro with ordered data mode. Quota mode: none.
> [    6.893421] EXT4-fs (nvme0n1p7): re-mounted r/w. Quota mode: none.
> [    7.125419] Adding 16777212k swap on /dev/nvme0n1p8.  Priority:-2 extents:1 across:16777212k SS
> [    7.157588] EXT4-fs (nvme0n1p6): mounted filesystem r/w with ordered data mode. Quota mode: none.
> [    7.165021] EXT4-fs (nvme0n1p9): mounted filesystem r/w with ordered data mode. Quota mode: none.
> [    8.036932] nvme nvme0: using unchecked data buffer
> [    8.096023] block nvme0n1: No UUID available providing old NGUID
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5887dc6b6c054d0da3cd053afc15b7be1f45ff6
> Link: https://lore.kernel.org/all/20240422162822.3539156-1-sean.anderson@linux.dev/
> Reported-by: liaozw <hedgehog-002@163.com>
> Closes: https://bbs.deepin.org.cn/post/286300
> Reported-by: rugk <rugk+github@posteo.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=208123
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
>  drivers/nvme/host/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8eee28282b1e9..b6153f595076b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3453,6 +3453,9 @@ static const struct pci_device_id nvme_id_table[] = {
>  				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
>  	{ PCI_DEVICE(0x15b7, 0x5008),   /* Sandisk SN530 */
>  		.driver_data = NVME_QUIRK_BROKEN_MSI },
> +	{ PCI_DEVICE(0x15b7, 0x5009),   /* Sandisk SN550 */
> +		.driver_data = NVME_QUIRK_BROKEN_MSI |
> +				NVME_QUIRK_NO_DEEPEST_PS },
>  	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
>  		.driver_data = NVME_QUIRK_BOGUS_NID, },
>  	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */

