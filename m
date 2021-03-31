Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6765FC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 01:12:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1063C619CB
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 01:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1063C619CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=4DJA1YxvON50Kss+GTBt9Yce2zD7B2BA8FTmBOSWgYA=; b=Qy6cYJBhQlayN9SKAxlDbuQ3T
	EBzsut4fyowSEhH6PMZZdWClEH83lQ0WRX90rS3h8yscc0LOEjq2NU+4IvKJrO+JZq9Icc8d7zU63
	LRoK5rDCT9As04X6/avzHr4Eq6tMcot0UUXrzE6RSJJpGBh/B2kFkXqAqJlvuuoGs5k7wX9Bv4EtD
	lUf8pkS7sGYw4PtcbREADhgKygq1N/fgctpKtdbnzWj2KIZuCImVHaQpvzTsO03t+U2e3z36/h8qC
	Nt4OuZQVt39tlctHPyfsIFyAetgt9pSdWmbNEKPHAru7HH05dVNzVFr/Wat0obLP3VINiGB2+Kmqq
	oQtHg97Mw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRPPe-005EaJ-Ba; Wed, 31 Mar 2021 01:12:50 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRPPX-005EYP-U4
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 01:12:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617153163; x=1648689163;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=89y9AIJc+Mofv3t/Bi8mXpLwiA4jkX/0FZ3o325nnmE=;
 b=bq+41616LUp91gNqJt6W23+Up5wVKGDUQ0CRK18IgV/f3oiRRHErDWBG
 xVH6q/L15qB6jdt/n5pZfOYy3j3DLn7lPuU2xIDtBV/cTNCR+597by7QA
 Uto1CXMQq8Cf/9PWO9BW+uRxQB070OEOkTixxSWaRkWaUZI909W1a8VGw
 dLU17WnQobns7DXVm5y83TH3rPFdW+am4XRWYR3DPGJCtNyWyPY5ovQ5P
 RR/zr/E0MwE7kWvMiWIqB0NEfUK5s0sznGzWBrRk2VFaIOI6pI6VPCoyN
 1e5l6I5NMlNB+Q2/WmF/iOFDVFp/qmn3HzE0Vm2Wd5Bh+hicddGc2JJ5i g==;
IronPort-SDR: yyLrNbHND+znY1Ba2O9XOgIrzXLoS0lAGm4/KVmmayno8ipPBRvpc8ZPWrT4q1Ba1WsjoLTKQe
 /0aghUYrvUkP6RhWHHfcJbQILJAs3WqQTxVGSowX+5YA+qiAfKLkNBeiktKB/bGrhEoXfeL+wU
 /FpUG3KvV+Xhl4dypaQ9nDerM/U3cpN4HLsDplPDpd8RfFgeaQfGRcYVseY6StvQFsIyyEyNZ9
 jE380th1vHYAyPst+InIqHdjmcH24Td2q65fdpxD1XG75I32dB+rncjAce2O/f2DShNSYo/ExV
 Z5g=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; d="scan'208";a="163393780"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
 by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 09:12:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVl6tMLTusaMo9+Nc6jtTYaOeA+Usv81d135eRmfzKWydi3uquee2zinRl0LVCh2xBvuc0ZaflR2w6qOAggunOwssUfBzyd6Er3cknNllWxOW1uUnaQV1EKmNhjOxi2bfKZhLem5dS97RjIzqE1IACO/my2RC4aIqyruULOZOHlaxWrMkFzld3repCJbzoEbb56ws0bbWdcrLMJkIpYbz0V8sIdgfMcNFpuTpeuxRUyZMK5xxX0RSYPAgi2TyBqBjo7gylehlTD+9oglMtpNhqWri0RYgpcttrS1zRdeBqQgeZ5rPNDsFe99+uB8htlPpWHiN3LBBe0/AwEhCY1caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kcT+n4Q0aHworMwvFGEmW9OTlA5AXfmFirv/O/A1MM=;
 b=YF98l6i4+s4McWrNZCCvaAlo2wSjxAjqt04oVLNBb9SJIBPzxP0G29Pc93st1odIJ2zXV8/+r4SRBBg4fy8DFsTd2ZPFfv3Vdnacv00MzfK9ZBClRUxbEED6QivJVqPVsHMe0APAdQGV2+l/rIQcgaDvfvPxqgX0Uj+5l/z7kuuoX+7+qXmOxZK6dijJUv7hH3/TNUC1nk5zwSqaAGKhNg/tZNabGeMpwJ3v80AUR45tf3O/cjl88VM8hF3bbiLNBgIl8a8A+7k8Dea4RHGVFXpnDW5bwgvvG7A3XrjuD94iiHmfQtlzFwR5vuI4uwFKcPdxOhltVgDEgWQGlC/wUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kcT+n4Q0aHworMwvFGEmW9OTlA5AXfmFirv/O/A1MM=;
 b=TcTiJXmHC8aMUPr8fSFbAD2YjM2w1NIF1fOfUrVFIfPj9Lw6GT6Iv1Ojvz8WfFzl9v3z82toUT+LxUQEo+owgssJrHf6ctban+GBSARofpiJMnZ0Q7RXBzWuUaRA+kxXFGwrPdry29pk3qu/cKlAdIN+ee/dL6yRwglxyYx/sEA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7456.namprd04.prod.outlook.com (2603:10b6:a03:2a3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 01:12:18 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 01:12:18 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "jsmart2021@gmail.com" <jsmart2021@gmail.com>
Subject: Re: [PATCH 1/2] nvme-tcp: check sgl supported by target
Thread-Topic: [PATCH 1/2] nvme-tcp: check sgl supported by target
Thread-Index: AQHXJbiftjsKfN1bOUaAz5beVkORRw==
Date: Wed, 31 Mar 2021 01:12:18 +0000
Message-ID: <BYAPR04MB4965DB825E1EDF0EB73827F2867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210330230120.268671-1-mgurtovoy@nvidia.com>
 <20210331002952.GA23886@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c6f7b4e-da24-4f4d-0674-08d8f3e207a5
x-ms-traffictypediagnostic: SJ0PR04MB7456:
x-microsoft-antispam-prvs: <SJ0PR04MB7456C15B4A1685B67A245FD0867C9@SJ0PR04MB7456.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qcDPbh4Lkob7e26iGLKMZnkiAlSXwjT7NYO38n4qb7gWA0BSHZpkbedHSiuXlDpKrrubxp5r/y1/OdlDiIVGGHGX8MS6tYXO9aOGwq8svsHefzS5VxJMsAHuaO9yeHJ52EjqxeBRB+GtXM0IgauTGOU+0hgA5gUBY6hDHu0qksVn5xNjFBWwFyphgXdlLFFGUli3Xf28HBfrIL7o1gnLgF0sC0DdMJ+Mkp3pzM1WtF2j/NmWRUN8oYSY+fPm7IQzbpKXke5/3AakGzDUlin9Pt5qE5HKEfZl2G+4dkqeN0PZPzghknWIs1TM2ZTJqqk2hSotkQi3d1/ya/+CtD5+bvaO0k586n0RfN0Gxg4RGt9TAMCBtfy2QH8xTcTqNPvLJUMtAJ7937fLSUbMTs1CdIaHRWCJ+hAapGagSPJatievM40vrF0NuOPOTdPin2AsgATi45PWiOhDL7Nq51wxleCBZTcG9+8gTW3JWzlgNxyrmsi/u8FGa3gOaC9exFLuf+ZfMDolMKLikpeAxmUJSyzp6sQ4br0psrmlpfZjwnxWKauTRid9KG1xq9k3gtl2+a2KZYzciE1mITKthl+YFoIDfe4hctBYx7A1FsRDzQo7P7nrQN7DcD0xOtheBcxzg16nA6JE3zJQtm9KB399I8CMwzFpR6lo5epyZfRN9vI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39850400004)(52536014)(478600001)(86362001)(76116006)(8676002)(8936002)(33656002)(9686003)(4744005)(2906002)(55016002)(6506007)(5660300002)(71200400001)(7696005)(66446008)(38100700001)(64756008)(26005)(316002)(186003)(54906003)(110136005)(66946007)(53546011)(4326008)(66556008)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mc5wvfdKiZtDULJAQROzQKL+jX4nEYdLg4QphRIz5aOB0vvXWphA+kCVLaNA?=
 =?us-ascii?Q?CTvcG68cle4/DFEMk6MOSmUNwCt5WChtzamYJqHaquqHP/LGm4myEt17zL3/?=
 =?us-ascii?Q?XQcNsXDW4fLANmTobd2ykG66ZwFRFFbNPMAplOR76o+pLweurfTIdKbZTxWb?=
 =?us-ascii?Q?HOff7cyz1LjJFZkyYMn1q3DiN0j3u+acns3dXnUijJtNIICdhjGr+pisDSih?=
 =?us-ascii?Q?9Jww8Zs1pEMAAa9KaVtKHv6w2/S3YxAntHAy7juMXV/UfmVAIcV+owhj2w7y?=
 =?us-ascii?Q?JOz2r8Qjr9nPMPpfj5VP9WatgjJBIy6hovNUH3qz82pK1x71pzB/eTHwWzV6?=
 =?us-ascii?Q?T7AxL9WRfi/7jTxMVQoEgT7MSuQLAhpNJS0yGH4Nu/WpID0tR5nTkYREdQSs?=
 =?us-ascii?Q?meovuX4umiCavO9fym4UAYpyklp0SfXzxwEjzT1heZJNGJx2jMxIFuIG0AQL?=
 =?us-ascii?Q?GfM+u2vUi9Z0VZ/bo39zb3MpqtNgS+pL1KoPQwzGDrvviXHlA03xfN82xS7j?=
 =?us-ascii?Q?1J3CtGvJ5tkwnRYOR65S+eBesDaynMU4a+g/jS6BOOR4z25htIq1/5wKorF3?=
 =?us-ascii?Q?FA40dJg0u2BD1QZ2i/GoiDCKPOPqZyiV/YmsRDEAJOo+qSU1IRJMd75ciDPD?=
 =?us-ascii?Q?qiobZQXV76Msu9yRfg6vlOdZCd3LkjEEEpYtWZdRsZqh6ngst4Br0PxCPluS?=
 =?us-ascii?Q?zr7N/y5TS93D4sjrCqYzvhNojdemc+aSoYXzTvsSPtk+AGY2qR0UFoG0+mCu?=
 =?us-ascii?Q?nDjb+mYRzCCB9JzxQ9F4l/5J7cypVqxupRfQyVtbC4HPTuf0/TUruXcjuf4s?=
 =?us-ascii?Q?sdL4Yz4r8earZMiL6og59GhsPZ5ZCSExIhyTLCzZ3Q2tYfYCmE91XwwH4Z7J?=
 =?us-ascii?Q?jmcPUvhLVGXaiPlbNak5KZFV6m1WzN3zsg4FZzist7coVPvtJhTU8EDnTW0T?=
 =?us-ascii?Q?a1nudCq+kd47gmIHYCKBjXFx3UsMm8NRpUSUOhQBLdBEzsy0DRi5gPaCB79j?=
 =?us-ascii?Q?YnnWsNYAtNG5Fb3+tQ3ac/3fKS3mCU662yD+izi4VLNeCtAEAmpzeODy9Cp1?=
 =?us-ascii?Q?uwvSeAJrZVbEZ1pBfBIHf56bSM9iAVmJWf0DIuYs56Q4OkwblOGoR7nmFNHa?=
 =?us-ascii?Q?/t5gSTJ8V/S830L6qpEr0qVmPU0FD2xADRziYq6MThSNL5tpHQNBcLUpU/kB?=
 =?us-ascii?Q?V6TeIa8jnjHVClmzoP/EXPGgeceXS7y2pNyR2g/B+zzLNn9OovI1n7vZ5QKe?=
 =?us-ascii?Q?SDJX7b/VAG8eiQNGHlIuBlh4bfueeyDdtmtHkojaAMX+n7bizlsqkaW2rL4q?=
 =?us-ascii?Q?j/0qCw+7BQKQIo2whD/aIWeB4YPFV0vDhpbPVwTK+Y7UHA=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6f7b4e-da24-4f4d-0674-08d8f3e207a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 01:12:18.7150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9rIJbi8Q6P0+VBv9ujiUGpbhVzlpEU6Zqn+wT4sL+5WfmLCu663im/yplONHY/rYRp4yqZpDCn5CYMCkeBOCMiYNdbFOZrHv0GyIRuRCnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7456
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_021244_975773_2FAF32E8 
X-CRM114-Status: GOOD (  14.20  )
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

On 3/30/21 17:30, Keith Busch wrote:
> On Tue, Mar 30, 2021 at 11:01:19PM +0000, Max Gurtovoy wrote:
>> SGLs support is mandatory for NVMe/tcp, make sure that the target is
>> aligned to the specification.
> Logging an error seems fine. Are there existing controllers that do
> this? If so, what currently happens? If they just have a broken Identify
> Controller structure but still work with this driver, should we proceed
> with trying to use it anyway with the existing assumption?
>  

At least I've not seen any, in case they do exists should we consider adding
a quirk if at all any of those controller's start showing up ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
