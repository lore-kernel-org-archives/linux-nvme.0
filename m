Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBB8C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 18:28:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB91D6140E
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 18:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB91D6140E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3OWa14YWWhzKwUsAD9tm9kSFcrCz9S+w/Z7Xngg3EM8=; b=y6qs5+MbBGINGE
	Va/D3XrvPCowvGKHJwNlQdWeIPP/Hcn7Jy+pwMk5jZb6ZgzKrgm0RMCLVwRtUjuSd6MzHV7W2Ygj3
	svOVZ0xp4zz5fqQZB3906qrKpyroUtNugZt4tk3kD4VbHkSQNKMh2+BBBtzZZBkf8XkXPsqVk5MWP
	DBqct9knp1LjVWD3bMgbU8Z7MsG7uuO0hW21v8F38tFHlt8IuXbIAAy1FmV5rHOfIgmQASP6INkhc
	PO/tmF356tBm3FEjUOxqKB95eemCFqhi7BNR0HlS+YRLhuGijdetssRS7VrnxRzd6ovIpjBYC6aHM
	78NY3bhx0k428sfqPN1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llbma-007GVs-Q7; Tue, 25 May 2021 18:28:00 +0000
Received: from mail-sn1anam02on2041.outbound.protection.outlook.com
 ([40.107.96.41] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llbmX-007GUb-5K
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 18:27:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9tDA6LHzcb3lXQnEUPYw9/WA6y1cKisoPPPQyCasD0hgaXdrgeNe08Bx9gvjLS5PTFzJ1g7RER7+ZPH++TJiIjAx8cCV7m8QsDj8M0AwLCNLGtxSn480V69TClUrpIIiZBIqkVIXEMen2mMEGU6+NhsePLYTmTdUmCt18prvsbZEE4j+Tw1h+jJXN33nI3KZQGzWi4RWGO3anpZ1qehc2sy5AMa4FaSnBiPAIZR6rnv1+ks00pyH78h7xmq/EsK06DYTLqgk4ceLj6k2UTcWDYXWZ/nRouRUvo5J1oazOo4+74TSBB64iztFa6pX8SGIs9lMN3oSVC5c1bPahsKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZYeRTlU1Ub6AKc8sg6apSduyKH76NBLuiwyPRvjieI=;
 b=JlVkaIjOvEoef5G5l/MO61eIljXNiXfUPD1NLyqBrhMrxDuELcsO2qZfUVctOSwS2DT/8FV6GkIRPde3+o/fmPazW9z1MvTXwcL+h6Yz9I8usB+d2ZigA2s28tRrkiuQoybhaqO/f2b0wnMgZXDn10SRjPyA+aZe8SuztL/RGOh0bTaLdCmfdQUwRTyMMjFYlEuo4ezb6YLm5CT4dlwPlJraIc4TeSapPaccdM481WfEVhiGascJy6mAJsEj78lfLM18Flf0VgTgO1h8VqfAJr49aeivCL3HgIf7hSi5V0amMrVm8KpNM7z7L6Kfm0iFle9iAwM4xiiOuGGH7uRBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZYeRTlU1Ub6AKc8sg6apSduyKH76NBLuiwyPRvjieI=;
 b=Hul15TT/y9MrxzdBAYKJr1AaQVeIeROfxoiJQ+G1iF5/DTnLJKiC0TOD9in3aYofablR57yz/cJtXk3JLI7NYJBSM6+1H0aPkHJpGwvGLtREAredhoRpTikeo5aaU0ygRLXjoStnihvGsk47/JPR04Cxn6x6H9F7c3e4S8ReMqU=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BYAPR12MB4760.namprd12.prod.outlook.com (2603:10b6:a03:9c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 18:27:53 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.026; Tue, 25 May 2021
 18:27:53 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Hans de Goede <hdegoede@redhat.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang, Prike"
 <Prike.Liang@amd.com>, "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "S-k, Shyam-sundar"
 <Shyam-sundar.S-k@amd.com>
Subject: RE: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Topic: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Index: AQHXURCj33ZwIr9nkEeZsNaCQKwCY6rzujiAgAB6bICAAAQggIAAAH8QgAAFuYCAAAaCsIAAM8SAgAAIR6A=
Date: Tue, 25 May 2021 18:27:52 +0000
Message-ID: <BYAPR12MB2693CD60B17E4FCEED7DD5FCE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
 <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525141631.GA12576@lst.de>
 <BYAPR12MB26939EE6323113FA9C43E875E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525174505.GA3704559@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210525174505.GA3704559@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-25T18:27:51Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4e9e2723-59ca-441d-8193-99561cb2a6a5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2600:1700:70:f700:a1e7:c926:724c:a49a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccae563b-4cff-4b85-bd7d-08d91faacf6f
x-ms-traffictypediagnostic: BYAPR12MB4760:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB476090CEB5B3060BAA028A70E2259@BYAPR12MB4760.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LJlxpmzlPNMoeEYOFxaeu19UuCZAsNeqcGuvkmyBweTkM6Kz7DcqU82zLuwFPhwvTwNfL8EQJX5f4/KFHTeJvcim7qE1iABRuLgXrZYy6LECfk/xWvm07P9SUOWGeQvGs1ZBz35IILQ3blTWlGGIX23SR9LWH0Uk21Koq26Yhfd7vgYC6p58CAiAvQ9uctvbvFZSkbwnI2FKBTNjKNwgqOy1NQ8JIj/MOyUczsy1Zl4nyXBeh51bVM4Lr1jfvXkBpUyzyjs7lrrhjpCE8PC0iGpzMx7ag7EvMnhgzRDUH+0fbKnrTwsPK8HgIMm5zd9HzHSKoicmjDLyJeHHMgY3tM1Bz3jfosHcRiKz1s7A6+0lgMJhEyp+wY3cMl7tjqfvc18xTGtjQKCL0KGQrK9k+ndQHXJErNMtbZIXuZMxB3vvmtb9h+aEf0Wz4BqXFs+P1hlC95Snn1FhzzjY4O4+5G3gCmhOeQo+1F1QKOpdIN5pBvAzQnIVpySq9P1LyKneweD4JgDwGOt0UF2hiD66t/7Svjs2ShV0knVOFXtZmmtSXDTOuHNmvnS9xgJtRNH7Z0U27zk2XFfi86Q2kDuz4UQ+xPLcDxKOhT/UjF8yFqI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(376002)(346002)(136003)(366004)(396003)(478600001)(52536014)(6506007)(9686003)(76116006)(7696005)(66476007)(66946007)(66556008)(66446008)(64756008)(8936002)(4326008)(5660300002)(122000001)(38100700002)(186003)(54906003)(86362001)(55016002)(83380400001)(6916009)(71200400001)(8676002)(33656002)(316002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4nWV/zSy+9rYPm2wXXFqkYq7oaBobO/JBmWuMLP4oqez6XOqV3KU0aZuBzF4?=
 =?us-ascii?Q?Fj4zoO2gQGRc10cWLqasRS8ENSStTZhmiuRe7SKUUeePdpOFazB9PAgNnxZw?=
 =?us-ascii?Q?2c45LZAdLGevdYvXELIqIsQIKELm/vrse9XgaWfmc1jOXoRr87C7lBOR7DDU?=
 =?us-ascii?Q?pDCb/qycl+hd5eY3bvaPNKuI17nPYr4RBJArVRwnPW2rDSuK/dI9aoK4qNp1?=
 =?us-ascii?Q?5UKvB4YCtpg2c8hU9DJyIBC5EA0PzdYFi72o2C2JnO/YRNtgsaisA419iOAF?=
 =?us-ascii?Q?qUW3N1cYVl5o29O4LmK4rezz5E+uOpm6nnh6oFNH4oT/D9y2ag1D1zO9BFq1?=
 =?us-ascii?Q?h4WRxjhR5nQjU0gD5iZFYGjCHtP6+8Nz1svxCFetLr15Pg1Nq9B6gNkRk/kr?=
 =?us-ascii?Q?agJVne0VjzveLOttbE8VcBBCTuTx7zWrPcInSBnIZXwO3lb4ZhN9w7d2Zoj4?=
 =?us-ascii?Q?LTJC4NfVxvTQQD8farkpl714bCdwziYz42+9Z4RBD8iwAWmliLD3IgASQZJJ?=
 =?us-ascii?Q?pmAEgShfsO5LeTMXDapjC9siwbCwPJzqsfdq8bc1sxB3i+jLdv1XQqVCVB4p?=
 =?us-ascii?Q?DLOUb3094IEC7oqbBlgsI481HkJye1DLmNH75Yjh6opiWJk+mgwn2963lbah?=
 =?us-ascii?Q?tuUfHntkwbuMD+HflZOj8dVf9AYtGorMMHRJDtQvHvsESUeJj+y6ZVqFSWyO?=
 =?us-ascii?Q?xMiGUe0Jt5TZJYmwswXtSCKQUsj4QMEs2gH2NZs7WMa6txlenw0eyTs8Eo7D?=
 =?us-ascii?Q?aievpvDJ1M2gxUMk8e1/rxmWodiNq067vct6zzS982DGSfETH/ucn8E0OmtB?=
 =?us-ascii?Q?Fx5xt5sOFrJpPgW3EkncKvyB61asLozN5hMJtTYCUmzMzUX22Q4cQkTc63sP?=
 =?us-ascii?Q?SLprQKEHwEnOZiv6rf9NeaqBuA09rALF6BSGtIP8F60/GzSpERwhns4YMWBK?=
 =?us-ascii?Q?89sWuIORnEAH2xOPoKCbG7RoJwfLb83RrCLFe8mRGrESRKSs4NgG/4OT3oYX?=
 =?us-ascii?Q?ngpkH9lpa6Pei4Wc6e74/5Tzk0qN9wcrn9WGgHHHH10b90+pGZrjYLk19j5t?=
 =?us-ascii?Q?i+lXv++4Kk9PVRdgj2GWsruIZPz6hLKhbBTXfv/Xmkf8pvdmcEFLQnaW0lxD?=
 =?us-ascii?Q?3nPC/KIs78BQF1h/0xlXZpBgMyhOAA/LLNWsNNK0lDqrD9II8RXB5ZNk30zT?=
 =?us-ascii?Q?o6JTNc7vusbsGZGf6JqO/MWtR8UW0rCoS8ee2OO7ngrI5KrIqOvDUy7TGiIe?=
 =?us-ascii?Q?L0/jvZU8xoJLIz8Iijjd9kR861lW7oD3FQe585Ht/PPGnsGQGl6UJZW3gZQe?=
 =?us-ascii?Q?e06O95ZtSX+6nXDVcJxM34ElrhQd1vXgku5/S2KyWAOqse/kttyqPhwAQuhA?=
 =?us-ascii?Q?XWbo4Wt1fDCnopTR/RgK9nNl+LBj?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccae563b-4cff-4b85-bd7d-08d91faacf6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 18:27:52.6438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ELQheWK6LWha0BRQImJf8bC2GWh1zUcCsMsiaYggy9xeTFbmdSJl1mu5nf65P6m+vZCiLnqMaSyR716E0/6utg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4760
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_112757_385503_591BC2A4 
X-CRM114-Status: GOOD (  14.95  )
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

[AMD Official Use Only]

> > This seems like a gross assumption though that evicting the quirks into a
> > central place that every driver needs to behave the same.  AMD's case is
> > specific to NVME, particularly because APST will be used otherwise.
> 
> I don't think you mean APST. That feature enables controller power state
> autonomy, and we do not messed with that on the driver's suspend path.

Relying upon the drive to go into the appropriate low power state via APST is one
aspect of it, and then ASPM for the PCIe link state.

> 
> We do use the explicit nvme specific host managed power state feature,
> though.
> 
> But I also don't see why this is specific to nvme. Are you saying that
> if a some other protocol device was in the same slot, it would be okay
> to use its protocol specific power settings? That doesn't sound right

Maybe Prike can comment more here, but all of these s2idle designs we're talking
about are mobile designs without external PCIe.  OEMs make the decisions on
what PCIe devices are chosen and how they go into the lowest state. 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
