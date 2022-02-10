Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723D9C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8PielWDi3bzcMiRDbh/3OPxsR4t8/dU85IMocsSbm+0=; b=ausu6d07rV3Xd+Rzt+wL9rbfrg
	w0Y3P1kbmTnz/76I7+97XPnDh2Cm9K7ROvaoAbmzh6VGKlkkwrMNI+iwmvOyJNbu3O+LPuwggLXrf
	Gr8cakxqN3Bc5hevKUPxSiQimzFrvRvz3D8EY71OnFRaxmfg7zB3bowyjknViSXEcZl4CB2mPEeYK
	vLWP7w7PBZ3XeytZK72j9SkJm65v8zir1gjQ4JSTAWOBhwkhmNIpwr2VXdMJo1nPcpEND4Oo3WtvN
	aDfYaw+ndH++ksm+E9GR6MzfVXbzRgbgkfv763rGfvLX8brDGmCU2CNwpues66LqI9zfUBw1R0Y/s
	ykw2RHTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIEkH-004idi-MW; Thu, 10 Feb 2022 19:04:45 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIEkE-004icn-SS
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 19:04:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 78A11B82725;
 Thu, 10 Feb 2022 19:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733CAC004E1;
 Thu, 10 Feb 2022 19:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644519880;
 bh=wz/CdZorfFHWlSqN+7ZDozbR07LEsU/eeljIy+oXNh8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gw/2JQpYdEpG0z4AKa6gfM5FwzjZ92a4UBh5SD7mdRMlJopWrw6LvowC9gA2D/WRo
 /arBEknMaaOh8XIDzo9a0jUiNTyUcjCp9hjE9MtCQYOJfI2SFpNEHc3gZvfTX6k9dy
 KZcpKHFHaHe5ySUnfj1VW3wzFJ93+olpaFH9o4V/cznKOMxHyrMdJ0kA4zSPtcEcp7
 fUr2xIzZGyGQcgkzhxDqJDpchfIjkQKv2YezWWKgN3GjVr9C2/v54zdLEUcQXibHdY
 MkQF5SdB+cnpAe+LWg4wEcU+jffysL1kYjdluTzirAlO1UXZPOLzWPriD6nUQM2Hzd
 ZVB83J8dS5aog==
Date: Thu, 10 Feb 2022 11:04:36 -0800
From: Keith Busch <kbusch@kernel.org>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v2] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Message-ID: <20220210190436.GA1658231@dhcp-10-100-145-180.wdc.com>
References: <1644512104-24035-1-git-send-email-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644512104-24035-1-git-send-email-quic_nitirawa@quicinc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_110443_095456_C3A14336 
X-CRM114-Status: GOOD (  21.26  )
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

On Thu, Feb 10, 2022 at 10:25:04PM +0530, Nitin Rawat wrote:
> Enable quick suspend quirks for Sc7280 platform, where power
> to nvme device is removed during suspend-resume process. This
> is done to avoid the failure dring resume.
> 
> This enables simple suspend path for this platform.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
> 
> Change from v1-v2:
> 
> *Moving the check condition outside vendor/device check
>  to make this platform specific
> 
> ---
>  drivers/nvme/host/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6a99ed6..fa25d9fab 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3032,6 +3032,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>  		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
>  		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
>  			return NVME_QUIRK_SIMPLE_SUSPEND;
> +	} else if (of_machine_is_compatible("qcom,sc7280")) {
> +		/*
> +		 * Append quick suspend quirks for sc7280 platforms
> +		 * so that simple suspend path is executed for this
> +		 * platform to avoid any resume failure.
> +		 */
> +		return NVME_QUIRK_SIMPLE_SUSPEND;
>  	}

Did you test this? Because I think you said that this is the Kioxa
controller matching the vendor:device in the previos "else if", which
means we won't reach this part.

