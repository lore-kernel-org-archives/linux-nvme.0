Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85303CA0FED
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 17:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ukKoVtirAExIh7Myr9qrHvYyBmqYsM+ZvCkxZsLrPEw=; b=gYD+wSd1Ws/+VkU02c8x2Y1WpV
	KR0uQUOj5RKesKokmpy/p31J9TuKgv+VfdeCG04JLU3Cgzk+rv23yJHZs0lrfnWycbybgEsEru+jd
	3ma1WEHWz6Zk4nHFazNqg1wOkH6sbd1FhJrrER7yfWLQSG16dxjI7GRS2Ksmv7VBuwAyHms/LrFVt
	SCMmpkyenmAT7wVWZjRavmFF5dlahSMh2gHJOvuLNHE1Imlb0uy4u5w2GB0nB12TJ3lm8GY16BQAC
	OKmTeQguYHfuyWkvOJ+jHjfvYVOCt/0rYfE968BfQjesvsAkXmQf4JNMGoTEmEwXso7Rkn/t4PCLr
	EcVY5QRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqaYn-00000008kOv-3yOm;
	Mon, 25 Aug 2025 17:00:45 +0000
Received: from mail.tuxedocomputers.com ([157.90.84.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqZjB-00000008cIh-128D
	for linux-nvme@lists.infradead.org;
	Mon, 25 Aug 2025 16:07:27 +0000
Received: from [192.168.42.116] (p5de4594b.dip0.t-ipconnect.de [93.228.89.75])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 491512FC0047;
	Mon, 25 Aug 2025 18:07:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1756138039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukKoVtirAExIh7Myr9qrHvYyBmqYsM+ZvCkxZsLrPEw=;
	b=Y1/YsxUImZ/OEgAYb72dpxNT8GMyxFNjV5929hD47M+DJtLClhZDzjj9TIUw+dUA+NqfkC
	GppMVmfr0O6zwgRMMK0Iy50CHNoFI+DaoM3+EQs6Zqho0LFUlY4Ny/JyBQFm09GLsYo00f
	bdo3vJoNSPH3TqI12qg25I5rlA5X8Fw=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <bcd2fe8a-c80a-4556-9944-83fd2b493567@tuxedocomputers.com>
Date: Mon, 25 Aug 2025 18:07:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Add TUXEDO IBS Gen8 to Samsung sleep quirk
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250701205630.64031-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20250701205630.64031-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_090725_720994_6AB61199 
X-CRM114-Status: GOOD (  15.30  )
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

Hi

Am 01.07.25 um 22:55 schrieb Werner Sembach:
> From: Georg Gottleuber <ggo@tuxedocomputers.com>
>
> On the TUXEDO InfinityBook S Gen8, a Samsung 990 Evo NVMe leads to
> a high power consumption in s2idle sleep (3.5 watts).
>
> This patch applies 'Force No Simple Suspend' quirk to achieve a sleep with
> a lower power consumption, typically around 1 watts.
>
> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
gentle bump for this not to be forgotten
> ---
>   drivers/nvme/host/pci.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8ff12e415cb5d..d677080e67d33 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3198,10 +3198,12 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>   		 * Exclude Samsung 990 Evo from NVME_QUIRK_SIMPLE_SUSPEND
>   		 * because of high power consumption (> 2 Watt) in s2idle
>   		 * sleep. Only some boards with Intel CPU are affected.
> +		 * (Note for testing: Samsung 990 Evo Plus has same PCI ID)
>   		 */
>   		if (dmi_match(DMI_BOARD_NAME, "DN50Z-140HC-YD") ||
>   		    dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
>   		    dmi_match(DMI_BOARD_NAME, "GXxMRXx") ||
> +		    dmi_match(DMI_BOARD_NAME, "NS5X_NS7XAU") ||
>   		    dmi_match(DMI_BOARD_NAME, "PH4PG31") ||
>   		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
>   		    dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))

