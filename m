Return-Path: <SRS0=Sfb4=II=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AA0C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 13:22:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA5864DAF
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 13:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA5864DAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aL9onWfBEhB2e/lSi3BrGdGyLJiBfrs4qA/mfZKVu3A=; b=BII0ThoUkhds+hfXEoqGJ3x7e
	njuwednSzzoyeK7ukxo+/mFthgvsOjBT6G1P/yCy2e7uhyQTzfw6rSzBbCpqMRNXbU7l/K57FKnsZ
	gq2mWscWlAU70X+igYpZ2Tq26Yb5nq24Hl9BqinbFzPTz7HEUKB3BmS41aQTNDLFQcwV71lE8/0zd
	yFSnKtpEJcH0MkxYZ+FUCJO/1qmP5gmQAHxt9WBDdvbTTKAl+atMSnBkwNs2hcC81mp2oleRdOHAr
	Foqs4b+xWVYQZ1bcR36usurBmhmIt7Ca12nE8OhhG7xRajbMlg5xLKKLKdfCXASw7qs1Navh2Be1z
	FaOhURngQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJymu-006tSG-MW; Wed, 10 Mar 2021 13:22:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJymm-006tPp-4h
 for linux-nvme@lists.infradead.org; Wed, 10 Mar 2021 13:22:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0FC3A68B05; Wed, 10 Mar 2021 14:21:57 +0100 (CET)
Date: Wed, 10 Mar 2021 14:21:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210310132156.GA12145@lst.de>
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210310_132200_528368_43895639 
X-CRM114-Status: GOOD (  20.43  )
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

Can you try this patch instead?

http://lists.infradead.org/pipermail/linux-nvme/2021-February/023183.html

On Wed, Mar 10, 2021 at 02:51:16PM +0300, Dmitry Monakhov wrote:
> This adds a quirk for Samsung PM1725a drive which fixes timeouts and
> I/O errors due to the fact that the controller does not properly
> handle the Write Zeroes command, dmesg log:
> 
> nvme nvme0: I/O 528 QID 10 timeout, aborting
> nvme nvme0: I/O 529 QID 10 timeout, aborting
> nvme nvme0: I/O 530 QID 10 timeout, aborting
> nvme nvme0: I/O 531 QID 10 timeout, aborting
> nvme nvme0: I/O 532 QID 10 timeout, aborting
> nvme nvme0: I/O 533 QID 10 timeout, aborting
> nvme nvme0: I/O 534 QID 10 timeout, aborting
> nvme nvme0: I/O 535 QID 10 timeout, aborting
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: I/O 528 QID 10 timeout, reset controller
> nvme nvme0: controller is down; will reset: CSTS=0x3, PCI_STATUS=0x10
> nvme nvme0: Device not ready; aborting reset, CSTS=0x3
> nvme nvme0: Device not ready; aborting reset, CSTS=0x3
> nvme nvme0: Removing after probe failure status: -19
> nvme0n1: detected capacity change from 6251233968 to 0
> blk_update_request: I/O error, dev nvme0n1, sector 32776 op 0x1:(WRITE) flags 0x3000 phys_seg 6 prio class 0
> blk_update_request: I/O error, dev nvme0n1, sector 113319936 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> Buffer I/O error on dev nvme0n1p2, logical block 1, lost async page write
> blk_update_request: I/O error, dev nvme0n1, sector 113319680 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> Buffer I/O error on dev nvme0n1p2, logical block 2, lost async page write
> blk_update_request: I/O error, dev nvme0n1, sector 113319424 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> Buffer I/O error on dev nvme0n1p2, logical block 3, lost async page write
> blk_update_request: I/O error, dev nvme0n1, sector 113319168 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> Buffer I/O error on dev nvme0n1p2, logical block 4, lost async page write
> blk_update_request: I/O error, dev nvme0n1, sector 113318912 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> Buffer I/O error on dev nvme0n1p2, logical block 5, lost async page write
> blk_update_request: I/O error, dev nvme0n1, sector 113318656 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> Buffer I/O error on dev nvme0n1p2, logical block 6, lost async page write
> blk_update_request: I/O error, dev nvme0n1, sector 113318400 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> blk_update_request: I/O error, dev nvme0n1, sector 113318144 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> blk_update_request: I/O error, dev nvme0n1, sector 113317888 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> 
> Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> ---
>  drivers/nvme/host/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 17ab332..7249ae7 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3246,6 +3246,7 @@ static const struct pci_device_id nvme_id_table[] = {
>  		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
>  	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
>  		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
> +				NVME_QUIRK_DISABLE_WRITE_ZEROES|
>  				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
>  	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
>  		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
> -- 
> 2.7.4
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
