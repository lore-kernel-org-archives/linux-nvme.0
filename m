Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3490C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GYGzyzkgR/rYPrMVbdP7rjEVKe0/Bk0Twcm4LdpnhDI=; b=h8tx2B30XRXuzQGoYKU9QOHEIf
	dI60kRcYBA12SnKN9KHlaUar6uSbctPs5LUCuPDz8Q5Wdp5a3LzxWB17dNBFSnFSy4mpKMOCKBkOG
	XfKN2V+7alcduE7BQAh5igp6ZcSlWw0SNn29hRcXguDHOHTD83r7ImS6Y/D9EQnsQo7kl81/Yw2bv
	cxur54+j7IyyNSDQHW+a7c4Ei6ZDvbKImuAMO354JgwxfgouHwscit3/rfrf6Ky/yT4EXYFeR8Gs/
	Kfa2YW53MfWumJqGiyRpKLtSgDy04QEvSmrIU75XT/fgveooKah++rU0nQIfnD4oARHIGTzNUPUvq
	17IxuIEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nICm7-004SMN-Mk; Thu, 10 Feb 2022 16:58:31 +0000
Received: from alexa-out.qualcomm.com ([129.46.98.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nICm4-004SLK-J1
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 16:58:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1644512308; x=1676048308;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GYGzyzkgR/rYPrMVbdP7rjEVKe0/Bk0Twcm4LdpnhDI=;
 b=gMhaOV6Bm1FoQeJDv2Wqz0PKSAgnLDbJw98xambM8igzN4QFL2rU5wBz
 uc4fDIObVcyGgHcW/9s/4TXjOupSWLr33VtBHhCh20X/QOsIUQ0C8beQT
 /YTbhh+9I624I4JVgTzXeZQ0LGI+LEctQ1JY1KR0mKDb8JTdLI0zWJRaL 8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
 by alexa-out.qualcomm.com with ESMTP; 10 Feb 2022 08:58:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 08:58:27 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 08:58:27 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 08:58:26 -0800
Received: from nalasex01a.na.qualcomm.com ([fe80::bc64:9e8c:e944:8704]) by
 nalasex01a.na.qualcomm.com ([fe80::bc64:9e8c:e944:8704%4]) with mapi id
 15.02.0922.019; Thu, 10 Feb 2022 08:58:26 -0800
From: "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>
To: Keith Busch <kbusch@kernel.org>
CC: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sajida Bhanu
 (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
Subject: RE: [PATCH v1] nvme/pci: Add quick suspend quirk for Toshiba drive.
Thread-Topic: [PATCH v1] nvme/pci: Add quick suspend quirk for Toshiba drive.
Thread-Index: AQHYHni/VohKdx1dg06GCWGFwibsxqyNZ0MA//+aLKA=
Date: Thu, 10 Feb 2022 16:58:26 +0000
Message-ID: <eb186ce5e5f84bf193bc3fef0860b92b@quicinc.com>
References: <1644495676-8124-1-git-send-email-quic_nitirawa@quicinc.com>
 <20220210150114.GB1617879@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220210150114.GB1617879@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.37.205]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_085828_698148_07054804 
X-CRM114-Status: GOOD (  17.84  )
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

Thanks keith for review.
Yes moved the condition check outside vendor/device check in Patchset 2.

-----Original Message-----
From: Keith Busch <kbusch@kernel.org>=20
Sent: Thursday, February 10, 2022 8:31 PM
To: Nitin Rawat (QUIC) <quic_nitirawa@quicinc.com>
Cc: Jens Axboe <axboe@fb.com>; Sagi Grimberg <sagi@grimberg.me>; linux-nvme=
@lists.infradead.org; linux-kernel@vger.kernel.org; Sajida Bhanu (Temp) (QU=
IC) <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v1] nvme/pci: Add quick suspend quirk for Toshiba drive=
.

On Thu, Feb 10, 2022 at 05:51:16PM +0530, Nitin Rawat wrote:
> The Toshiba KBG40ZPZ256G SSD is having resume issues on SC7280 platform.
> Hence enabling quick suspend quirks for Toshiba KBG40ZPZ256G on sc7280=20
> platform so that nvme device is taken through shutdown path during=20
> resume.
>=20
> No issue is seen after enabling this quirks.
>=20
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  drivers/nvme/host/pci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index=20
> 6a99ed6..04c5954 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3032,6 +3032,15 @@ static unsigned long check_vendor_combination_bug(=
struct pci_dev *pdev)
>  		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
>  		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
>  			return NVME_QUIRK_SIMPLE_SUSPEND;
> +
> +		/*
> +		 * Toshiba KBG40ZPZ256G on Sc7280 platform is having NVMe
> +		 * Resume issue. Appending quick suspend quirks for sc7280
> +		 * platforms so that full NVMe device shutdown path is
> +		 * executed during resume.
> +		 */
> +		if (of_machine_is_compatible("qcom,sc7280"))
> +			return NVME_QUIRK_SIMPLE_SUSPEND;

Shouldn't this check be moved outside the vendor/device check? It doesn't s=
eem like this behavior for this platform is specific to any particular cont=
roller, right?

Otherwise, looks fine.

