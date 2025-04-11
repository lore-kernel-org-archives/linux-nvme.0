Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4FCC3601E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Apr 2025 00:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QLrLCkbG4+MmTKqGtzjpdUQMTQG3poId7mGaG8IlM6M=; b=CZQiCGcr7DCSYlExznETg/ixfX
	npKgPxdIzyDOFuZctzxeEGjRmQr+6sR4ypHIZQzuPTOTJbU+axCKV98xqVmIBneXVVicvaw59NyCv
	uL8URO3emX6SAwLucm5M9emH3tL4cTOLFCqSqkDGlBMQJPBylqRfSzBnVMm75IHc1n3dVoIcGaTbC
	lnaHfVXyM1bZBj/z8Sfgg3NAWW1fa6wdzwL9CkWCTutVAn6GZPEl9LC0fWUzA4HwsQ/Cb4AqU9i0J
	hwuQdpTZRRlsZa2swJpp7/CiMDgDCxTA3FCSgVYyO8O1GrMpuPHvqoD0k3PPrVsCwohL6gECP+sm0
	bfJle5ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u32Nr-0000000C8sQ-364L;
	Fri, 11 Apr 2025 00:36:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u32N1-0000000C8qP-2EEt
	for linux-nvme@lists.infradead.org;
	Fri, 11 Apr 2025 00:35:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C915E5C58F9;
	Fri, 11 Apr 2025 00:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AC1C4CEDD;
	Fri, 11 Apr 2025 00:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744331746;
	bh=XtJJOOt8gWa7dnIvjuaS7+ixKnGnSqsS9mV25ir/iQE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WzV7QqjQOsS/fktdyia/PILd3uWW944OYIkE+6bmEzOI987WvcVShdfd8MqT644Ju
	 tTiDtgu083PCbVeWOX2aol8U6/ZT/ZPWdooGSAO0QpO89NFnPfy6+GtCJPiqKmOvWc
	 tUAOMjsmOV9QTEyMsXd3QRIfKXHUIDPt991IIqHxVOKH3CkhJrWO8rrsmtHuB1DNuM
	 BrIJVzTsrNGAAm10xL6/Do6ev1oYimI3hJT7iaVompvAOWJrJgLDK/8/XIN+J1n8i0
	 LW0A9D5tNnZ1ZWtFhukrjdFnvZl6+qwjbJ4OVQ6Rlgya7NEh4swSzumn72C7mvUUHt
	 8tI8TBdzB/HUw==
Message-ID: <47d0ee0c-2656-49f2-a5c7-3c3c8a6ef18f@kernel.org>
Date: Fri, 11 Apr 2025 09:35:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvmet: pci-epf: Clear CC and CSTS when disabling the
 controller
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20250408024733.690966-1-dlemoal@kernel.org>
 <20250408024733.690966-3-dlemoal@kernel.org> <Z_exWy7bMlkaLMb2@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Z_exWy7bMlkaLMb2@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_173547_635499_0558B377 
X-CRM114-Status: UNSURE (   8.86  )
X-CRM114-Notice: Please train this message.
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

On 4/10/25 20:54, Niklas Cassel wrote:
>> +static void nvmet_pci_epf_clear_ctrl_config(struct nvmet_pci_epf_ctrl *ctrl)
>> +{
>> +	struct nvmet_ctrl *tctrl = ctrl->tctrl;
>> +
>> +	/* Initialize controller status. */
>> +	tctrl->csts = 0;
>> +	ctrl->csts = 0;
> 
> This can be written on one line:
> tctrl->csts = ctrl->csts = 0;

I am aware of this, but really dislike this style as I think it makes the code
less readable. So unless the nvme maintainers insist on this change, I prefer
leaving this as I wrote it.


-- 
Damien Le Moal
Western Digital Research

