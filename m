Return-Path: <SRS0=zNed=5Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFDCC2D0EA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 15:25:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D68206C0
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 15:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o8fC9d5b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C6g7o0bS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sEFYNBfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D68206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=4mtJDXgd/lTrpCC2n3VeFTSMqqYUr7GaPc3k10M5FGM=; b=o8fC9d5bfxNqOh
	T9uEbkCoTKaw430JhMK8FCRASJ0I1GEM1Lepvq9Xi6WYFzyiLwQbLTrqOVE3gGta+XlR0ARHt4bCP
	pKAv/PvEVNidIDhq7TDYKhdRPzZzeM4gbUG+lLwM+U97AxbxD4IWKGuZTRNWqU+YchCx5M+Evavfo
	/Vmnz3PmVeoXPks9PDTU0k3+x8glFXFWF0RIwrITdMl9r/AiUZu1XAKpqQ2TYsHvntlsyhzBx+3hl
	OSDRErrD+GjdPMwqBM0NFbLbbgq07QMMZPlYupJdvaLkbr3Za/sgv3b6V5XmUVtYQ9dTQtaGC073V
	BiN/E7cwoJA4gR/wrRUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMCaG-0007fi-OB; Wed, 08 Apr 2020 15:25:44 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMCaE-0007f8-CL
 for linux-nvme@lists.infradead.org; Wed, 08 Apr 2020 15:25:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1586359543; x=1617895543;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Yw+pqyacmkv2U7nkGmvXLmC/J+6yPEWFO/3u1frfqVc=;
 b=C6g7o0bSmTja2GQnkvA0DElw0CYtmF1eWbH4XiWYGtyisb6PXQaxbCOt
 wvFJkmqYC5xLOCOrBfnw2kKwvDwXNFPrI5vXncfMToEB7R5YU3D2kCjC8
 lDtrpvuqPHBju4Rq/TJ8P5tN3KFQp+b0OSFpb+Nv9W+rRG+P04k3Jjxrn
 6IGR/E8AhD5ruzY0qdMCIImt4eE0o378NEtyJnrEiww8JEosVPYug6V+e
 TxFfzlsOeyQUI4ejyOO8HMx08kBDczZH6Qn2F2K7a/8NgqdsoSQYnwXFU
 kxr7GdBocWOZBgxp4FRpZuEt2acU54NHAzc8As9IQkOOUvBomMhDDKODt A==;
IronPort-SDR: MdTkx22K+DLIwFPxewjrUwOPacaJMwLwmMeprnDbv74LRccpNRa9hxlareFeDgpqTwFw23sT4L
 pPlbuUy9owkjFU/ABgCmKXum6hPEfzSaiVaDsJRbTAct38Sz5VyV9FcSht+zsEqtgcgSULRB+z
 RjfLUfo1dwQD+iLvD+sUC1yosOFvxR/Ek7bVsGo6iTIJxhEp3oawsQ2StxtGUVFnJNcFpcfJBw
 eVhFeJsWvugjcj6T7bLSP1Lv4xihd35huU5kM030czDXJ60ZJd8gxbSoBLS+NBPkBKxgf1ImJX
 Z6A=
X-IronPort-AV: E=Sophos;i="5.72,359,1580745600"; d="scan'208";a="135195720"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 23:25:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBHUrexRGiaib4AJvnfcIU28hlIx2x4XH1m+FQO1WsN1DoTE3MDtdlLSgq8rue9yvmm/BQHq4xw2AC0PC/+XfyceWRX7Mrz75uRzD/OTzGpkI2KmDmIhtMJmPF1VeIPLtoCWPTGieofrhHyToi1m18KBOvurdpIOkcUOGyIglF/M+a2xs0T23oUOT09rDLAeS3LNuoAnYTedLJxrPAOf1lnsxpfeg2/WybWRlyRdihUR9Nbg9pIm1ml+s/dbe3RtX4REA7fkF5nSYwU9+n40uU70Pw0rm4TZt88sG9OzZ0x1ck/oF1pO/1MHZqGtvUeRbZyJbx/tyq08fSGLXSAw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw+pqyacmkv2U7nkGmvXLmC/J+6yPEWFO/3u1frfqVc=;
 b=amgQO5HAOzYhmtObDnIJfoI8QPwuALFlK8R2IWDPYbW2LVmHLSDLGQ9rcG2SW+OdB7NoekzoDwzaNC77CcVZQYptwCdeXV0/EspOI/J16sHsLr5rHcESG8YQ/mVXY6uHUxppRZvtAGDT146Snx+xKPHtWJkmahWDxO/mOFUUGn8zL+JSzFOS2o+BTEBwE5yL7L8K18i8njfEevyUL33LV+EpDPVWWL/x3cTW5ZGDpOI/q4sGjpIsVixFM8cvKIsc4OjsmDgoDArOeM5OIOV3coZa7DmwKhRZTYG/J48YhKEQkbl7g2HAJR7OGOgQ66nRsMupSzCZvSeFlPRVv+BSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw+pqyacmkv2U7nkGmvXLmC/J+6yPEWFO/3u1frfqVc=;
 b=sEFYNBfusJKuy5TuhFpAhh9LwMz9SpN6hBTri6znR6MGJyzQ/n+i0aIfkZQI3wkfXh6pG5pzXjFymzhcKwGslEDCDY4uVCK/zvBq/jC53YwR2IGUk6tsr/ekn3uYA6GzC2QdtxIj6vaTh0bks25d+tH5PDMZqvtxX3nMcVIm0gc=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SN6PR04MB4431.namprd04.prod.outlook.com (2603:10b6:805:32::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Wed, 8 Apr
 2020 15:25:38 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::b0f4:a811:73dd:6c4e]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::b0f4:a811:73dd:6c4e%5]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 15:25:38 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Anthony Iliopoulos <ailiop@suse.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Thread-Topic: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Thread-Index: AQHWDVyGx1h1rDwyCECcI/Bh3Diljg==
Date: Wed, 8 Apr 2020 15:25:38 +0000
Message-ID: <SN6PR04MB4973222BC905A09B9CA0E55586C00@SN6PR04MB4973.namprd04.prod.outlook.com>
References: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
 <20200408041633.20632-3-chaitanya.kulkarni@wdc.com>
 <5e54afaa-7de5-a89e-5740-88df15c52bba@grimberg.me>
 <20200408095500.GD1329@technoir>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64ba7776-5ce6-4fa2-2eb4-08d7dbd11753
x-ms-traffictypediagnostic: SN6PR04MB4431:
x-microsoft-antispam-prvs: <SN6PR04MB4431DBCCA9F29DE2E5CB7E5786C00@SN6PR04MB4431.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR04MB4973.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(81156014)(2906002)(33656002)(26005)(76116006)(66446008)(8936002)(64756008)(186003)(52536014)(66556008)(71200400001)(316002)(54906003)(66476007)(55016002)(91956017)(86362001)(478600001)(53546011)(6506007)(7696005)(110136005)(5660300002)(81166007)(66946007)(9686003)(4326008)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2jauPJXaGsCBhNCz6YpeC8iPnR614c8oSl/tAC14mEhHcaxlCduUOl2uLwR1vb66psTWpX7WT44m+8HynTXH2t/JubN0RhwC1kDh7qzE6vqjhre2KahG9x4ydILOSyPCDjo/pbIvo/Wm299VEBYEFTr5eAMjpgm9F3bxn05N8cv2etl3KTGo+BaKNtjhlL2Qt2i1jRJvzkU1dUcKX56fSwIu6xnKrUvk3j4PMGi1050Imii2dQZPnNBCXbQrPyDdYoirQyJkZooEHMC4D5+oNOefQbeXeql8cDdlQqtkFtU9AFc4PSWby5ymnMWd4pZVW/jaVF42Q73kyEo+bI5mpTlg05XnDHRIrUSNT8dwqoA2yoxKs5QW/UzFK6Dv4+IJAEmglzctUYZp91T+PtxbBBSOKsrjF+NFd6lMOuuPb8mxvooKGER8xeNBRh2f56gZ
x-ms-exchange-antispam-messagedata: 6083urafoM3e97f1s76VZ5W5N3L2wMixP7oQHX9Y3QsuN8XlKQDO1yuqvpMQw9cjGmGBRXHe35PHruw0NnIfKA6lydEKQQhvXxtXaQHN9vo5Sw5bq7Up240PEpd3oys3QjURsoTZHGHXToQ7njIlvA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ba7776-5ce6-4fa2-2eb4-08d7dbd11753
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 15:25:38.0280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIeRsswk75WOUGXYtuncXR4amvU7SaUMRY74hvwN1VxwGMJGZSYTEACXLo/P5ixwVAzpT8kbt+98q700tLZ6RLjJkTHNYte0wROAqkuppp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4431
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200408_082542_433145_D91B7937 
X-CRM114-Status: GOOD (  10.96  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04/08/2020 02:55 AM, Anthony Iliopoulos wrote:
> So in the original design I had assumed that the burden of AEN
> generation falls on userspace, given that the resizing of either a block
> device or a file is something that userspace would initiate anyway. As
> such, the same process could simply issue a nvme rescan ioctl to effect
> the capacity changes (this is why in the original patch I had wired up
> revalidate with identify).
>
> With the udev notification patchset in place one could trigger the
> rescan for bdev-backed targets (e.g. do a nvme ns-rescan, or toggle
> the existing nvmet ns enable configfs attr to induce the change). Some
> revalidation actions will necessarily remain in userspace, e.g. in
> blktests where loopback bdev is used, it requires a LOOP_SET_CAPACITY
> ioctl to reflect the changes (losetup -c).
>

> For file-backed targets, userspace may leverage inotify to achieve the
> same. Otherwise a size change notifier would be required to trigger a
> rescan (e.g. see fs/attr.c:notify_change()). The issue though here is
> that there is no immediate way to associate a filp to a namespace, which
> means that the handler would need to iterate all controllers and every
> namespace to match it - not very nice, and probably isn't worth the
> complexity.
>

We need this for file back-end since it provides user flexibility about
managing the ns.

I think we should at-least try global maintenance thread, if that didn't 
work out we can always get back to the user-space solution.




_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
