Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF36C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 04:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aooz1IwiZ0hxcXczuwcd/95W0W0EnTXZo6gVoTNHYPA=; b=JiU9uGLluI2ctkD+3YIkgZkxPQ
	KyRaIBk1rg+c7+V95goWr4wXR+QFGRpfFECvSavkW6jeuLMujlzSC8kJpTPcIl9N1Fsr/eS7qWLyZ
	DmAlq89funLAgwC/UkRMzqksLp5vy/bB78NIBBLYGsZ3WoMkW08IPCvnLtbG+FnOPqCp/LH/LBDt5
	Pwk9A6KWMxr7o1INdmHe0zwJ5EwrX0n22dfhm2GEZjpTsmiJ3NAKF4El15Hycjz44jgfhh/Rxskku
	G+uW9LQVpCAcXfuCMKJvjf0tEr2Vt4oUk8DfjI4s/aGWDh6FxxM18xtIg0T55Iu2H2ygETnE8lSNJ
	RcJCDHHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0xv7-006yaS-VC; Tue, 14 Jun 2022 04:12:49 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0xv5-006yZx-4Q
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 04:12:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655179967; x=1686715967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=74g0qRnHT+LSLb9TYWwUugarho/O4pVJtELjFmFX6Ss=;
  b=F4y0RRBHa0gNAYseXVOR34SwxF+opxDyq7TGmjIOQYIxtJ2LS19iY/7l
   bvPQ5V6JlMpyKFUz5KBYzIMV9CnFLAIKSsl0vlIJjLsluZ4Gw/yw6NG4G
   iWPsIU0fZWjKW5/rkWr9T00jTuF1HHLxT2Qr2OSIPmez8VdgbuW9Phkmu
   pqhsHRiqFiK1igfXqNh0uLdMqqQY1q3WI8+I7oY/S94eVPyhWusr/s2L6
   JNS2KBnZ48i+X0H5GMj5OtYRFB5EQt+MnYNar5f7oT+i5brSKBMaoKq79
   VmciMlHOq8Kwath1q0gMciWjnqSEDRQaH8TVZmWh6eIj5pXwyoksElWJS
   g==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="203829677"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 12:12:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8ju53yQSjl0C+Aimna6YW3GD37PIhN6Wjk6LcGO/4fb9L3IHsTZAHlCdVZiM3f+Uieq9r2aeZQbLqVqh1wLUzDEIx4ntcJIMm/AgNUZIMG/wMfUaST2t08mDVxq3i4/yPbMqniMdLzSD/uGywkxxB4WKiLLTjonWE2ckLaskzQVAHjaoFP4Mo/aoFVOstSeWWq8tse7Dwu0qGosTR+hdUbfL67idE2Gw4E5F7w0o4+ALTjjkTpGws4uCtODvkL29AakOGZ6ziq3vOxgT3kM8CCppwzCleRipOgswTF/D0cn1+O7MHweuPLt04uF3puVPyG0lzBPyO+2unP4IsgNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aooz1IwiZ0hxcXczuwcd/95W0W0EnTXZo6gVoTNHYPA=;
 b=jIcUxr9PAWuORfESG4c9LiJnh/MCaQD5U0WZp4F+UHGcfeVxGkhaI6J+qPnlCO2HVcRiud3JJykdkYjPUMBDEHz3I0FNyjAq+qEgYqSndU2oZSMtfqfIg9jthE79E6ewf5TOhi+I9iZT9EyuLT/skseVUG638SklPr5Wfc4czTa0WhrPnqf6lPztexIoXvyUCuY0AgF8aVVKWDBVclDnGVZY6EjOIVHLVAYDr/9+mBm0Rq+/xIECLBFcRbmJ0TdiAhUodyG4A53H0L+1xurDVRpzix6ekquEZzqLGACxUPlRZohmOezsUst00UAiy6e2E+hfCafIxHRfc4eu9BZTIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aooz1IwiZ0hxcXczuwcd/95W0W0EnTXZo6gVoTNHYPA=;
 b=bsUNEJCn3MVZQlRsZKbwVBxBQKmKvCjYo0IlK3KGDbs2Pg/AEvTpLUuoRzV7zBKuIX1XxIdU7SW+bprsw6+5LOtX+iUsJ5e8BKJlgpbmdiOVO6NMWfIlQpL+AO+h0z9WEcBU+ywWSNpMYf1NMDLQcODHpYe/Nl6FLnl8zV5FW70=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO2PR04MB2230.namprd04.prod.outlook.com (2603:10b6:102:d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Tue, 14 Jun 2022 04:12:38 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 04:12:38 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 02/10] nvme/rc: clear allowed_hosts subdirectory
Thread-Topic: [PATCH 02/10] nvme/rc: clear allowed_hosts subdirectory
Thread-Index: AQHYfL3uy+e+7SKN8E+X+CPSQkRfgK1OUHqA
Date: Tue, 14 Jun 2022 04:12:38 +0000
Message-ID: <20220614041237.aivy2ecbb2xzecfi@shindev>
References: <20220610113324.10294-1-hare@suse.de>
 <20220610113324.10294-3-hare@suse.de>
In-Reply-To: <20220610113324.10294-3-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28236ecf-8402-4b99-5a7c-08da4dbc1e62
x-ms-traffictypediagnostic: CO2PR04MB2230:EE_
x-microsoft-antispam-prvs:  <CO2PR04MB2230CD7FA79D811E9EC3D61CEDAA9@CO2PR04MB2230.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  upTJvVAuusL+5YVnI613yRajLWxHWawS//DqsQvsKqwqkorCg/+JVjcH8Kow71Pg3Iju3NiAcdpTo2xpRb7FyrSaqzN1k20vDZjgW8mZkPnUx0Kha/wZrD9YAbLWlmWM7AFjfKdPaiZjU0iJ+CRiuHYSJS/H9Juy1WsGNaDH72OC/o8cWN2+hF5PCeet694eLskusrZryLHg/a0E3auLLQ1gkoU5GG0GybNBuK69uR+FsRsLkPCt+rDrskmUVCeFwjipQubtTxPTmKfMemTCxXsfuWTdt9h4KcDzhu2+Ez/eKq2cpeOcfkP7b91aKm9p7GVZ8hCa56Kz42wKSAshUfGTeIk7jcw+fcnuxfEC/q4XX2wANVBw14YRT2ucEfuQxLKuaNGyhkXlBYNb8M9pLc3hkUARrIRhNTXCFMjIK9gLHcaB/MLdqbRVGt/iBvTH+biYruDtBGRby9EkDGWTVaiUp/VNkyP6xoBui5CoW8sUY5aKRiAh9CBmr0Pe3q4zUd2L/m8Tf89lRAFI4E0ObDwjcGVvjtfteZTQNWJv/7tGaKigfx+0RBELxyCowrEhie28TgHLZMW7QIJCy+2QSH2SBLxXGH3wkZYFB6LFXriRD2MGQb2+ayumjZriK43NQchdwdx7w8ZNgscH61q+4exPTaOFfCV4mCnda7kLoY1I+4WRBvwCcP4EZ9jl6bqWIpwOKBuaGCBiG5aO8hhXsg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(8676002)(4326008)(5660300002)(316002)(66476007)(64756008)(66446008)(66556008)(91956017)(76116006)(66946007)(8936002)(6916009)(54906003)(44832011)(2906002)(71200400001)(33716001)(508600001)(6486002)(38070700005)(122000001)(9686003)(26005)(6512007)(6506007)(86362001)(1076003)(186003)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?ogLs5bypAMkxpoOZvxULUPgGo69A4HlkU+FHKC67s8nUk+EdBu/9nzETSitL?=
 =?us-ascii?Q?cZucxjMvB6wWLdpvlRQ1ayBzXUFIgaou8hejdo0q0tuGiZVgl+9QLRS8P0qJ?=
 =?us-ascii?Q?OswLX4E2eGl1I9FYDLcbFi/Nw45dtMMR76bKWFnZzsd6DXXQCLm5KaIJVUpd?=
 =?us-ascii?Q?3nXLcj74qTeVuFmfu+/x60+n1miSvbkUMOIuxop7pnt8r4SUiLBENgrMUcVb?=
 =?us-ascii?Q?OwXTUECM6Okj+bLQq0hgrCmNnYNcRWvWbXqT6K1VjeJXEKWDPJEGmXZd64Zl?=
 =?us-ascii?Q?VDi20ALbDVv2Ff9PZCBsaka7+BXO3CjU36anhNig1KD0+B0ISoQjJQWiufMr?=
 =?us-ascii?Q?zasrGIynfZ+CeEdmKJ26LhLwGIzPun2+vhB5Wl77c7Ku5eMma3NvyAZXNK/+?=
 =?us-ascii?Q?1tBXuCCh6+TG9JSOV5H3hIOvDgZ99/CZOs01osKhrcegaqwVra3sjNE8HSuU?=
 =?us-ascii?Q?QjYl4FtEAt6rp13gY3ZjV77KLpnek6mqo6u/C4vlIXetHvn4yN8X00BLliq7?=
 =?us-ascii?Q?CHfVjP9ORIYj9SyffPI1trNcYadlkUi+6VSJdycS7tQOrQ0hmkAsvQSHl5UN?=
 =?us-ascii?Q?bH24Zus/i8aOuC6hjRn1cZslfNJeke/532wi2JBPn3O9eQznX+neRFIaOw+6?=
 =?us-ascii?Q?hoj69hWw4CnFnbGjNEc7xUbBADi92H+OCUDUNyStgINz0MUjm+u+jcLnRyVA?=
 =?us-ascii?Q?nA9yCO2Gvt3gIAcb1XbUEwSEeWm0hzrI7TxUY7bf6O5P1G0/8pxUwmKt+DyE?=
 =?us-ascii?Q?ONcUdR6yK3b9gLBWwKnamW0DKSdefqLTZK6wWEND1fPXRLOtjPuB8h+wTLqM?=
 =?us-ascii?Q?5g4VfUnPV5FIp6mXvazlY+reYha/LoCJ2aRnpBkXKVnn/pfDh1qbSYUIvR8y?=
 =?us-ascii?Q?j7gEt1tQSUS1fY4kwE6DdQWBaqdzV2y3PBe31fKG0bxKWhnmcLBSsKj/7ZKi?=
 =?us-ascii?Q?TPnRpWppXXJB7xN4oxETTIuf7RhWyKx4Fe/qLmwL9z/F2+EFCIEpVuNeMsf6?=
 =?us-ascii?Q?CRc9XBm1lnIupN5SHqK1Vj1TYhU/JqQa16fYQte2yjCk2LwqYY0d8Cy0aEhR?=
 =?us-ascii?Q?VgbTdQUgdU2HdZr8mU1Z/qkGigV+76xLxQJaGh5nNbuYiMHMSDUSlewXbq0f?=
 =?us-ascii?Q?eOYTOLiPqvJl0ffSRyNFUxiNxt3aTI07uM/ZwLzJCOXKxlVKxRPsKjjMXL1o?=
 =?us-ascii?Q?nXO7o1cnysPEQMsHzhVcOhUM29du0LAHH/IjinSwIPoeO+oEbA12r5knn13G?=
 =?us-ascii?Q?bAvRnHZdAKlvmluNZybHt43gS0tVIK9XkzDX2PdTsSEYHE4ofvLWVE8tI8DO?=
 =?us-ascii?Q?aAdJl4OksIwx9IbshfsV8HEHHyqGH4uoDcNx5aQLfJ6hIjufXBvw2WNaj2gh?=
 =?us-ascii?Q?RGShSLfYJfUAJ9YxaCX+ICMx4DucA+NMaBLx3D4lQLZK3orITVCle9VMCS1f?=
 =?us-ascii?Q?eZe3n/G9B3T/ar7L53lgiHFmYF2f4WVtCUoiJKx3nEUUzfEfm5JiP4MzunoE?=
 =?us-ascii?Q?fxPGr1oTojSYnbJMfMoqTSsxz7xJG6ctPJ7LcREskCcnjB9uyumDLO1yk2wf?=
 =?us-ascii?Q?N1WC5QrbSemXV6gqGa7kjNNMNvjlPAyuzXxeh1u1L9gOOsdflhQFOkNtSZtO?=
 =?us-ascii?Q?CZ8JXYaNvc79bwzW/S+kx7mmKXw7nY2GH+meIIC2Sm0rMOVtcBrNIPyYjmkN?=
 =?us-ascii?Q?gneW4zIOzpPhVs1VZHAdWpwFVYMMepw6TyXUfCjm8c1PQsfvANpCZ1XEdGu2?=
 =?us-ascii?Q?E68sTbZJOVBr+nXc8r36rsHxxaigIxq3GRk4p8NhCSQ/FzgYOoRc?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C0481900A728F478C3D550CE7A82D7E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28236ecf-8402-4b99-5a7c-08da4dbc1e62
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 04:12:38.4830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EftBFemfbnVSLX7u+6ZeCVAh8MWFocpm0AZhGZ0LgJA0bb6DT1QdjGkGLJIiR6aPHvh4yZMTjeNlNxnj1EctHk0JOK66ggjyJtO3V1f2zyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2230
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_211247_484041_F247924F 
X-CRM114-Status: GOOD (  20.12  )
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

On Jun 10, 2022 / 13:33, Hannes Reinecke wrote:
> When removing a subsystem we need to clear out the allowed_hosts
> subdirectory, otherwise removal will fail.
>=20
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  tests/nvme/rc | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index ad4324f..454609a 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -264,6 +264,7 @@ _remove_nvmet_subsystem() {
>  	local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> =20
>  	_remove_nvmet_ns "${nvmet_subsystem}" "1"
> +	rm "${subsys_path}"/allowed_hosts/*

When the allowed_hosts directory is empty, the rm command reports an error,
and it makes nvme/003 fail:

nvme/003 (test if we're sending keep-alives to a discovery controller) [fai=
led]
    runtime  10.481s  ...  10.481s
    --- tests/nvme/003.out      2022-06-02 10:18:53.539739780 +0900
    +++ /home/shin/kts/kernel-test-suite/src/blktests/results/nodev/nvme/00=
3.out.bad    2022-06-14 13:10:22.804354624 +0900
    @@ -1,3 +1,4 @@
     Running nvme/003
     NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 1 controller(s)
    +rm: cannot remove '/sys/kernel/config/nvmet//subsystems/blktests-subsy=
stem-1/allowed_hosts/*': No such file or directory
     Test complete

How about to add -f option to the rm?

--=20
Shin'ichiro Kawasaki=

