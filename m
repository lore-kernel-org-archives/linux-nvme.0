Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EBAC64EC4
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Feb 2023 22:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AM4N36Qysv92AadxfDFC6GvkuGkY/hSxUvGyMnlFKA4=; b=2dudZsI403O798Of4zEoMgI5i4
	vZX3gsZyCKfxrUdGb7JdLoCQKrBS2/c0b5qvEdmPp1p5Maqm/D9UDCNVFqgbVE/nE9FJRmuUSw+5h
	r5Nnyc+pQyJfF3ENV4KIqEfLrgQdljfI8z7esd5fjXPa7QEOKanmOwTmGHJYinPTCDHuhdPe0dmtt
	IVzzLaV9mNdLJVH5S0zmzEPil3sagGY6Go8awLD+pasptum8dDrLFWUKKMfaFGGvzl8rK8O/cVyEm
	pVDfjVU7gIawm/p9P5/wInSlc+T5+uwYp6ucxwJSxxgcen0MDNffUFeMJwbprUc5Iy2U9tY3ralED
	aqxknxYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX8Y5-00EUUe-O3; Tue, 28 Feb 2023 22:34:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX8Y3-00EUUG-Gk
	for linux-nvme@lists.infradead.org; Tue, 28 Feb 2023 22:34:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AD4A8611D5;
	Tue, 28 Feb 2023 22:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8715CC433D2;
	Tue, 28 Feb 2023 22:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677623650;
	bh=YinmanrDphP7CYw6RU6G56QD3buUexPR5spDlNZcpSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZw4vR0ubEvDXEjwSdYeB1c9RhPrdRxrIl4+qLezs2XdiOHYTzAoPDF3kXG7PLlT+
	 nPV2dzXKri1rImcxGh3ACfbQFPKXssyGPCENZQDJ1F4R5cSHYIXiphcs1g1bLqvJ7P
	 ZmBsYeffig+uLgnkyTmYIeeQAZm5bSsVBpZj4LnJ3Ph0y32zqHaoDDqfXTKEambywk
	 V34YFQqYhJB74zsBH7lg2oSgMGf/AdrHWBZXuGqsc61oOlJiolkqBLxXY3QvmDkWeh
	 wbuaTFGbkCzUE4rTuH7TExa/QY/0wI+B8El0eenQPKkGT/NTSKR5SXohCDQ5SzEuZg
	 LvBN3VJbykpWw==
Date: Tue, 28 Feb 2023 15:34:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, elvis.angelaccio@kde.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Add a module parameter for users to force simple
 suspend
Message-ID: <Y/6BX58qVUUx/Ey2@kbusch-mbp.dhcp.thefacebook.com>
References: <20230228221148.2672-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228221148.2672-1-mario.limonciello@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_143415_617751_C9AA1D0A 
X-CRM114-Status: GOOD (  16.64  )
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

On Tue, Feb 28, 2023 at 04:11:48PM -0600, Mario Limonciello wrote:
> +static bool nvme_use_simple_suspend(struct pci_dev *pdev)
> +{
> +	if (!simple_suspend)
> +		return false;
> +	if (simple_suspend == 1)
> +		return true;
> +	return !noacpi && acpi_storage_d3(&pdev->dev);
> +}
> +
>  static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	int node, result = -ENOMEM;
> @@ -3128,11 +3145,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	quirks |= check_vendor_combination_bug(pdev);
>  
> -	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
> -		/*
> -		 * Some systems use a bios work around to ask for D3 on
> -		 * platforms that support kernel managed suspend.
> -		 */
> +	if (nvme_use_simple_suspend(pdev)) {
>  		dev_info(&pdev->dev,
>  			 "platform quirk: setting simple suspend\n");
>  		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;

Do you want the user setting "never" to override the driver's default quirks?

