Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801B0C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6j4EpDYrSHllH4NJKJ7wCFF3DPtB6gGgKQqbRnvQ44=; b=yfbzEZmWVsYTDA+3aXDqOApt0j
	0UHip2Sun+pfaFrOnTgZAeQ9BrdH586LH0rfR1Jzt5WBTfcAq2r8eotRDYVSYT2+mFdLWABGE+q9i
	VR1/fZTTrUvN280/9ase26/1BzJeW23bP+ylr2LCnjWitZd2yvQeNakBwEIE0pYQw9BfGmLDjSwmg
	lgCqbhXvwwq/VkQl5v2VlhfgHDYHMpNTz6mOrucmRbQVtv4Vf4yZSDG4RpjTiYXP3/Z9BWupsNOw8
	u9u9+tpA+pKgtvxGC7YKDMubXULU1WJkbnrQyE3xBJ6riUBTvmLbQNatvjLCJvXW3up0B92rGVb7g
	UbcOjYvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKMrd-007c0b-US; Wed, 16 Feb 2022 16:09:09 +0000
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKMra-007bzA-4A
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 16:09:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1645027746; x=1676563746;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=R6j4EpDYrSHllH4NJKJ7wCFF3DPtB6gGgKQqbRnvQ44=;
 b=VNPGz6hia9eTgXefZWmqINij2Ov8PNAUapW4gbfoj/dXPDaa/Z+xABO1
 /BLMH38Z45hbimDo3IyOAWTrpj3zHkqRVWNHKqAAed6v5Iy9vw6U4kKF9
 DJvAgAbOTd1zn53T6V+aIde8kkRXquzAe1Ure9J0xIVffZoQY+nU+r9RM E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Feb 2022 08:09:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2022 08:09:05 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 08:09:04 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 08:09:03 -0800
Received: from nalasex01a.na.qualcomm.com ([fe80::a58b:cd8b:e019:f01d]) by
 nalasex01a.na.qualcomm.com ([fe80::a58b:cd8b:e019:f01d%4]) with mapi id
 15.02.0922.019; Wed, 16 Feb 2022 08:09:03 -0800
From: "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>
To: Christoph Hellwig <hch@infradead.org>, Vidya Sagar <vidyas@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg
 <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Sajida Bhanu (Temp) (QUIC)"
 <quic_c_sbhanu@quicinc.com>
Subject: RE: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Thread-Topic: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Thread-Index: AQHYHsBOpLTvLkaTP0STBN0OK3zww6yOaCmAgAfvxCCAAAk1EA==
Date: Wed, 16 Feb 2022 16:09:03 +0000
Message-ID: <fe6f99c47e2546429311d090999cd9df@quicinc.com>
References: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
 <YgYAs7R/1G2Y2kpz@infradead.org>
 <9b291987cf914f119788c42b32a08a12@quicinc.com>
In-Reply-To: <9b291987cf914f119788c42b32a08a12@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.23.73]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_080906_201068_A3CAF71C 
X-CRM114-Status: GOOD (  11.58  )
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

Hi Christoph/Keith/Rafael

Since we are giving control to PCIe (NVMe power rails control), it can vary=
 from platform to platform.
More over, PCIe driver doesn't control these power rails directly from PCIe=
 driver, they tie nvme supply with one of the pcie supply and control them =
together.=20
So i think it would be better to either have quirk based on platform or alw=
ays setting simple suspend and platform which needs full suspend can update=
 it through some means.=20

Based on below link, Looks like this can be across platform ...vidya also m=
ention similar concern for tegra platform. =20
https://lore.kernel.org/lkml/20220209202639.GB1616420@dhcp-10-100-145-180.w=
dc.com/T/#md10b0108b3ccbb1254fe0ad8dbb6e98044a8820b

Please let me know your opinions.

Thanks,
Nitin
-----Original Message-----
From: Christoph Hellwig <hch@infradead.org>
Sent: Friday, February 11, 2022 11:53 AM
To: Nitin Rawat (QUIC) <quic_nitirawa@quicinc.com>
Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>; Sagi Grimbe=
rg <sagi@grimberg.me>; linux-nvme@lists.infradead.org; linux-kernel@vger.ke=
rnel.org; Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platfo=
rm

On Fri, Feb 11, 2022 at 02:23:28AM +0530, Nitin Rawat wrote:
> Enable quick suspend quirks for Sc7280 platform, where power to nvme=20
> device is removed during suspend-resume process. This is done to avoid=20
> the failure dring resume.

You need to sort this out in the PCI and PM layers.  The broken platform wi=
ll also affect all other PCIe drivers and not just nvme.

