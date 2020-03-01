Return-Path: <SRS0=isN7=4S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86F2C3F2C6
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2020 02:01:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84850222C2
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2020 02:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iXK+N6YN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qrc10WEi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JtrkBpE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84850222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=CMI6FUeenBVp1dzsLoe6LyCSx9kjxUZMqa/EDw1M6zc=; b=iXK+N6YNfY2hGS
	LXRfJ3dxbMUZTbPUX+DCDTAMrxdim3rQwQZlgSlFaUYt8MfyWP9mLD7Wt7hDyJK5S04rwUUuntFkU
	iABtZHBg6/aNaTELTHa2fbUBVYBPR5Iw8KC1YGYG/zfjUTlJm/CWYg4QDxH/5GPd1oBSUtPBsn9Hz
	XaBBWWKaY9h4FbswUXP6i/eP5Pu/MeYkMHsRY19fmC7DnZrEkURx4enDWOUMR2BQV3y9wouVSIoeb
	1iN1R4NfkspsCaR2mnwJ91ACVzWvsIZDoN/0bN59hQRLDNcBJobnffeot+GbnG/I1Nud7SyI+Nqlg
	cSdcDOYrDd/TRMpZn2uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8Dv1-0000cf-Fp; Sun, 01 Mar 2020 02:01:23 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8Duy-0000cB-RI
 for linux-nvme@lists.infradead.org; Sun, 01 Mar 2020 02:01:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583028081; x=1614564081;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=p3NUnq7+goAE+p4i6WEz4Jyb1QmtbD/PFYkq8IdPASo=;
 b=Qrc10WEijvS4AM1tF2euYgdvbGg7HYgg9H4i4jd87eYkXydQs9U6Rv/j
 whrZAqkF54RUZPn7rn4ydTAww1xIzHrXIt5Y0y6hd94QVKoHPG2SnSHb1
 960a3z31l2zhz5ldG+0NFBVhLhGoskVUUmGPpxFzqGyvr0v1w9rgmeJsA
 qvi5Bky4tTsbHI39GnYUtmn7DKICWXFDRWCzU+Fg2D38fa8KdPrXBpavk
 mAS5RUzqohUC819BpwdUqzZOs1gKAYAlHzL4sPitQJ/kwxdX5Q8tUIbDW
 aSRzNVT2CmIrSOs+iorNc4QiwrF4H0Qx1C5N7xtceoTAO6b/cuw7UzZnH g==;
IronPort-SDR: wLRr6LamsSd8y30YAAPRxsdQETpyYJ3RPiflzsOqOjnYW+A5aHZ+IvzeUucGYu2J7nJ7S5Cnq/
 gObFJOY68JaL/Z0mkENmxRCJJT9aZLMhlP26iS6hXvAqXOyr73VkyHyY80kCvl5LWrJSgscg0E
 /sMILGSJDSi8DibGNyNPnTkNuliIesTdjy4rq69h4csMoVmtozjH7bSNZnHVKSD1l/FJZ1mfFU
 tKZ0X3K7ZjjjCGpVvbHaBNpbSYf2Cg7tnUjjaR7t30Zw/oJWV4ZDcAzZzV9zen+pyCoJwCFM+t
 Mxo=
X-IronPort-AV: E=Sophos;i="5.70,502,1574092800"; d="scan'208";a="132528117"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
 by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2020 10:01:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqnqM6ofREIVGel5Ea1Lr1L1+M8jMlteS87Lf9Gm7D3r86LiC9udeG6jtsd5YAwdrsMLaH3ybxUX9QyR2QkM+vN//RE4LFi2CIGM8nIFKY2wjhOXMor0y7g13lnGJZl/Zeu5rdtViiBXXziPJdwO71akLwmAeQJTxX2f2jmq698Zsm0UAziw/cbm7kAAXYyhbIRreaXbcjCl1o+eBZ4KGLFEqDwY01sJK9skPqWMsb74LkHQdz/kumYZNLYdCHJlAX5NDkwQV11HOvrxrN+HnUU5rE3hT1DesNMXwS5rzxoU7VjbCEEvqgMY2bx2ORFeLHZyGtQ9Ifhu39rZ8XkdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yz8V0mtHeZaZpikD8TZPmq6BFxKa31Mb/NMcehKPzg=;
 b=AlenQ7rHxWHWufMOqk4QaK92lI0vS01PbktrHWgFGWGnENDLlzR6PO+A25jIJd8vBZN4WhKsuhIseXWsrylL+NsjZFsXm60MXefeoKRSwHUxWGyZb9/3G55xeLwqpsvG8oWdIJD63GzU1W6ANyXxQ3MRNXCospZTAjRXCRzpeWfsU4xpWxwYnpMojSyz01QFLbLh2MBkYoIhUrVNQ6rNpn5sqdVZrFarQQsS9qJNzVKj6Du3b+EAdfz2scOfabEg2RclU8IsCNx3PY/vvw8r046XjnOfg+zdsXRrKcqTp458AIiBge90pohVrufTzO///22iTWKFL7eiTpNQYo4jSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yz8V0mtHeZaZpikD8TZPmq6BFxKa31Mb/NMcehKPzg=;
 b=JtrkBpE4XRsRrXnspEbSQmLLRVncEOfQyJwgH7xv4ZDuNHemRy3Bdm3b5HfA0yJvJDIz5Ik8xhFeh/JrngAN9Yb5W7MJmGE8bdgtK/2SBkZTWiPNkSgSTa2NyTm8neVA5idK09/gkHzQkGHQWLpdlocABZcYjhd3osWeNIrZnUk=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5333.namprd04.prod.outlook.com (2603:10b6:a03:c2::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Sun, 1 Mar
 2020 02:01:06 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2772.019; Sun, 1 Mar 2020
 02:01:05 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Josh Triplett <josh@joshtriplett.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
Thread-Topic: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
Thread-Index: AQHV7qtY5m6g7a4cOEmKX4VCzFI0fA==
Date: Sun, 1 Mar 2020 02:01:05 +0000
Message-ID: <BYAPR04MB5749363E3AC8C583F5CB076786E60@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200229025228.GA203607@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: faea1525-f000-4ef5-7505-08d7bd84670a
x-ms-traffictypediagnostic: BYAPR04MB5333:
x-microsoft-antispam-prvs: <BYAPR04MB53333DB2F5C7DB868638487186E60@BYAPR04MB5333.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0329B15C8A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(199004)(189003)(33656002)(2906002)(71200400001)(478600001)(9686003)(55016002)(110136005)(54906003)(8936002)(186003)(76116006)(4326008)(66946007)(8676002)(66476007)(81156014)(81166006)(66556008)(86362001)(6506007)(7696005)(26005)(66446008)(52536014)(53546011)(64756008)(316002)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5333;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Fk/SZiJL0k25JQ4iymZ0tl+RvWnE1x+j5F8X3LjvBeW9rn7G5HTwn0VNx+7Lh/IkuYX7fdrTxszOIbk7sAtD2FF+1TFAY2PSfPVGkJSEMyRllJz0+V5fmF0PtDYcXJFcMNHJKzI6YF9Eii/dujgivITIyTf1Bkmgp4zQ06i0wmpmxyUNAcwa8t0J2XNU49U04adkQd0YOFqd4j9wLFRtLrtzAVSwLNkB/0S9G23oy4rmxLKrZWniMrlubOiYNTf/X4+LU81Lf/VQbDKlQCCIIZO1OhVu2qoTk6yEZ8mMx/zR7oMKRzZXQXDlbjMLg5k4PhmaHpA/2Ve5owrADSWXye4kjCRv4Zi3uZRdJjhohv9+kgZh59wf/q/egsnjYshlqLonJCsninTtn3D8dwf+8WprcGtm+ZF4YD34wv3hznLWnmQnOynS3HusZPU2jf0
x-ms-exchange-antispam-messagedata: W0nmT6bxdf1B7FyjcxGDFV053XY4RqsrUKJHPK8vDlHTuxfNRVdgBuDT/5qTMFgvXWw3LItieCg7AChrB8MNRRkgqbKphuSF+pRlGa7XjelK5KnoPm07bsYP7KrOxYQ6udblIVX/HmDMKridFWI0Yw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faea1525-f000-4ef5-7505-08d7bd84670a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2020 02:01:05.7226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C+G+8ygP+IHfT7dOLobsy5gXLo8UoZqP07G1Ml5JpqlrwuNy3XVVOMxlwO4hVN2rKYIjbiskEG0tqZPGMG7UWY9opqco6DbRCKSowX7Kv5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5333
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200229_180121_286004_52B2B480 
X-CRM114-Status: GOOD (  17.71  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Nit:- please have a look at the patch subject line and make
sure it is not exceeding the required length.

One question though, have you seen similar kind of performance 
improvements when system is booted ?

I took some numbers and couldn't see similar benefit. See [1] :-

Without :-

714.532560-714.456099 = .076461
721.189886-721.110845 = .079041
727.836938-727.765572 = .071366
734.589886-734.519779 = .070107
741.244296-741.173503 = .070793

With this patch :-

805.549656-805.461924 = .087732
812.199549-812.124364 = .075185
818.868111-818.793779 = .074332
825.636130-825.554311 = .081819
832.287043-832.205882 = .081161

Regards,
Chaitanya

[1] Detail log :-

Without this patch :-

[  714.456099] nvme_init 3133
[  714.458501] nvme nvme0: pci function 0000:61:00.0
[  714.532560] nvme nvme0: 32/0/0 default/read/poll queues
[  721.110845] nvme_init 3133
[  721.114112] nvme nvme0: pci function 0000:61:00.0
[  721.189886] nvme nvme0: 32/0/0 default/read/poll queues
[  727.765572] nvme_init 3133
[  727.767814] nvme nvme0: pci function 0000:61:00.0
[  727.836938] nvme nvme0: 32/0/0 default/read/poll queues
[  734.519779] nvme_init 3133
[  734.522099] nvme nvme0: pci function 0000:61:00.0
[  734.589886] nvme nvme0: 32/0/0 default/read/poll queues
[  741.173503] nvme_init 3133
[  741.176089] nvme nvme0: pci function 0000:61:00.0
[  741.244296] nvme nvme0: 32/0/0 default/read/poll queues

With this patch :-

[  805.461924] nvme_init 3133
[  805.464521] nvme nvme0: pci function 0000:61:00.0
[  805.549656] nvme nvme0: 32/0/0 default/read/poll queues
[  812.124364] nvme_init 3133
[  812.126975] nvme nvme0: pci function 0000:61:00.0
[  812.199549] nvme nvme0: 32/0/0 default/read/poll queues
[  818.793779] nvme_init 3133
[  818.796581] nvme nvme0: pci function 0000:61:00.0
[  818.868111] nvme nvme0: 32/0/0 default/read/poll queues
[  825.554311] nvme_init 3133
[  825.556551] nvme nvme0: pci function 0000:61:00.0
[  825.636130] nvme nvme0: 32/0/0 default/read/poll queues
[  832.205882] nvme_init 3133
[  832.208934] nvme nvme0: pci function 0000:61:00.0
[  832.287043] nvme nvme0: 32/0/0 default/read/poll queues


On 02/28/2020 06:52 PM, Josh Triplett wrote:
> After initialization, nvme_wait_ready checks for readiness every 100ms,
> even though the drive may be ready far sooner than that. This delays
> system boot by hundreds of milliseconds. Reduce the delay, checking for
> readiness every millisecond instead.
>
> Boot-time tests on an AWS c5.12xlarge:
>
> Before:
> [    0.546936] initcall nvme_init+0x0/0x5b returned 0 after 37 usecs
> ...
> [    0.764178] nvme nvme0: 2/0/0 default/read/poll queues
> [    0.768424]  nvme0n1: p1
> [    0.774132] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data mode. Opts: (null)
> [    0.774146] VFS: Mounted root (ext4 filesystem) on device 259:1.
> ...
> [    0.788141] Run /sbin/init as init process
>
> After:
> [    0.537088] initcall nvme_init+0x0/0x5b returned 0 after 37 usecs
> ...
> [    0.543457] nvme nvme0: 2/0/0 default/read/poll queues
> [    0.548473]  nvme0n1: p1
> [    0.554339] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data mode. Opts: (null)
> [    0.554344] VFS: Mounted root (ext4 filesystem) on device 259:1.
> ...
> [    0.567931] Run /sbin/init as init process
>
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a4d8c90ee7cc..04174a40b9b0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2074,7 +2074,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
>   		if ((csts & NVME_CSTS_RDY) == bit)
>   			break;
>
> -		msleep(100);
> +		usleep_range(1000, 2000);
>   		if (fatal_signal_pending(current))
>   			return -EINTR;
>   		if (time_after(jiffies, timeout)) {
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
