Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39EEC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 15:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u0vqinxgI93GxJS6pGeFpD/Z/aGmOBSCrZJIgCSBofk=; b=qbyonCQb7ChE1rHu8CzGt8wHvn
	slZWcS1EiD3NBn1wSEEXG7sgQqFl7etQYTnUnAvWOTU91l1vKfSn7qwchQUxoGKerxu98x4rh9JHJ
	bnZq/SHh1UkxWNqRAyzt6kB7TLV527dBoX99JL31kF/kG/M8Q63YszI+fvpm6APqN0/BCLB76lXlA
	ebQL4DmbULTTqy92C6KgqR8a95wSohAEGAZFXglPfUMUwN6QR7pJbUMagafiRd/F5UcP+Z9x4EsPN
	24KKZ+eXW8u0naGssUUGC12vvD3wB6l8VohvGF2fcH1CubpKL1i9xl9hwvxYF7NaG80e3YhjcCuQ/
	Ug4sYUwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3JJV-001FdP-6k; Mon, 20 Jun 2022 15:27:41 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3JJP-001Fcg-Ib
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 15:27:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 7BD21B8120C;
	Mon, 20 Jun 2022 15:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CACFC3411B;
	Mon, 20 Jun 2022 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655738852;
	bh=C160ci2Jg/MpBwPywHpQUs6DyohwjJWURvf3+rO7Gk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1HGH3mQcRoX+mNi/4tHHGxCNMQ1nHYEjBZhMp+Do+RBgGPC8+bAYHo8/U6E3ClmS
	 SA69tjtH53L5ejhbO4yMOO4CX6o7+fMy9IZlUPoka4dgkstqmWWZWZlO03Kmp1Wyla
	 +t1ZBl8LLLWsjmtK9K5fQzlyNVkq4NM4Vi4TVnSaOpsjc2zcFm8FCcNSNFTkhaZf3l
	 smZjMh+TWQwRwy3HSqgwIbne/OvyfMUSZrpoPT2xsOJWBeMNTJoa8r+7MuSxK2w7Rb
	 rzUszD5a81ct93P5Ax80i2Y/bMoMpbx29RBcOhIHHDwEhlm9ZLhbAzkZJFOfqgB6Tx
	 9l62jW8mbiO0A==
Date: Mon, 20 Jun 2022 09:27:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Leo Savernik <l.savernik@aon.at>,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 216147] New: NVMe quirk needed
 for multiple Micron MTFDKBA2T0TFH SSDs]
Message-ID: <YrCR4Bjcto09kJyQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20220619132039.GA1243474@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619132039.GA1243474@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_082735_801523_45996838 
X-CRM114-Status: GOOD (  15.48  )
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

On Sun, Jun 19, 2022 at 08:20:39AM -0500, Bjorn Helgaas wrote:
> The proposed patch itself (also see attachment):
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b925a5f4afc3..2e5c33f3b868 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3372,5 +3372,7 @@ static const struct pci_device_id nvme_id_table[] = {
> NVME_QUIRK_128_BYTES_SQES |
>                                 NVME_QUIRK_NO_DEEPEST_PS |
>                                 NVME_QUIRK_IGNORE_DEV_SUBNQN, },
> +       { PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
> +               .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN },
>         { PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>         { 0, }
>  };

Coould you send this as an actual patch to the mailing list so we can include
it in the next pull request?

