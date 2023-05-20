Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B1BC77B7D
	for <linux-nvme@archiver.kernel.org>; Sat, 20 May 2023 04:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RF4gB8K8VCuBN4dY0MShQbAe4z+8VDnFUtaw+PIp1DY=; b=wYCR8BZIJR30Bn4oU4UrsaP1Pz
	CxdP2Ot+n6gqV/Hq8YNQ6IjC52TRJKOnpGIXeNICwGVWYoS/wKZsZCBDgksgNgCZn9pmEXvIiWgWC
	jjDi5GlnvND91eRY3NjkjrxDYbluqnvUn0Q4x7MiSKIAAz1ceii/9gyk6RY7NPTG2fu8OZyg+O7WJ
	p6WKpqyLJm/s/L3pLbZKhSmCZyhbM12KtrclcxY1lmAj2qzmBj5/gML0aGy4r+evaFBOmWJOuokPx
	YsD8zdQI5v4e+jJGjxvfrRqE8FCB8cERGJSrEcZTXJFrY6w+prGBxubY+47w8YwZ/t+bwe8zYoopM
	tvKV7lww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0E7R-000emd-2G;
	Sat, 20 May 2023 04:23:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0E7M-000ejN-0d
	for linux-nvme@lists.infradead.org;
	Sat, 20 May 2023 04:22:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 871AF68CFE; Sat, 20 May 2023 06:22:46 +0200 (CEST)
Date: Sat, 20 May 2023 06:22:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tatsuki Sugiura <sugi@nemui.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] NVMe: Add MAXIO 1602 to bogus nid list.
Message-ID: <20230520042246.GA31780@lst.de>
References: <20230519175603.169196-1-sugi@nemui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519175603.169196-1-sugi@nemui.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_212256_374361_474BE50B 
X-CRM114-Status: GOOD (  20.59  )
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

On Sat, May 20, 2023 at 02:56:03AM +0900, Tatsuki Sugiura wrote:
> HIKSEMI FUTURE M.2 SSD uses the same dummy nguid and eui64.
> I confirmed it with my two devices.
> 
> This patch marks the controller as NVME_QUIRK_BOGUS_NID.
> 
> ---------------------------------------------------------
> sugi@tempest:~% sudo nvme id-ctrl /dev/nvme0
> NVME Identify Controller:
> vid       : 0x1e4b
> ssvid     : 0x1e4b
> sn        : 30096022612
> mn        : HS-SSD-FUTURE 2048G
> fr        : SN10542
> rab       : 0
> ieee      : 000000
> cmic      : 0
> mdts      : 7
> cntlid    : 0
> ver       : 0x10400
> rtd3r     : 0x7a120
> rtd3e     : 0x1e8480
> oaes      : 0x200
> ctratt    : 0x2
> rrls      : 0
> cntrltype : 1
> fguid     : 00000000-0000-0000-0000-000000000000
> <snip...>
> ---------------------------------------------------------
> 
> ---------------------------------------------------------
> sugi@tempest:~% sudo nvme id-ns /dev/nvme0n1
> NVME Identify Namespace 1:
> <snip...>
> nguid   : 00000000000000000000000000000000
> eui64   : 0000000000000002
> lbaf  0 : ms:0   lbads:9  rp:0 (in use)
> ---------------------------------------------------------
> 
> Signed-off-by: Tatsuki Sugiura <sugi@nemui.org>
> ---
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7f25c0fe3a0b..dae0f8ed0af9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3422,6 +3422,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  		.driver_data = NVME_QUIRK_BOGUS_NID, },
>  	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
>  		.driver_data = NVME_QUIRK_BOGUS_NID, },
> +	{ PCI_DEVICE(0x1e4B, 0x1602),   /* MAXIO MAP1602 like HIKSEMI FUTURE NVMe SSD */

It seems like the vendor ID is MAXIO, so I'd remove the
˝like HIKSEMI FUTURE NVMe SSD" here.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

