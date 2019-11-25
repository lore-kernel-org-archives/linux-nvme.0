Return-Path: <SRS0=N6Q+=ZR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D4AC432C0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 02:25:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6659420718
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 02:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FP3HX0I+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Sw3QYmJ8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CfVXGX89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6659420718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=wjWo8uoPWc66HTgp0LMsODUU8NT1pFwg6McoWLfSxV4=; b=FP3HX0I+ek7uEW
	m+wuDx9AypwjX/0ZWsfP81v9cACO6ggTTdOSriynYEhvMUWRwpWcuYonat4RvFZTPQLdWMKiQTZnD
	VL6nU/7EfYGYaCnjiKjiQvREBRb9pbMLQ783jdP3PRv8wyeZ7SiDBkFzPOex3cZvmR0lqvduCM8+w
	1Hx8S90zlDt8um/ajU5Lxw5h0aDxZGaRBuk/NfciFn2nK4zZ3PTU1n/kkUb+uqRxEdqnhrLVcI1jJ
	+fieyHfAv0lVoXbpfXwAAQt9ByUiNErnwceniD3U3Jl8zf9cur6Lpj6nUeL4UvrpDpIITFJ+god9i
	S5GF5XIU2DyEopwThJ3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZ43i-0000ER-4E; Mon, 25 Nov 2019 02:25:02 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZ43f-0000DA-7X
 for linux-nvme@lists.infradead.org; Mon, 25 Nov 2019 02:25:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574648699; x=1606184699;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=7nKrrFILw3409c6fpKkVUMvUIep+EXUbAq6EQUvopsA=;
 b=Sw3QYmJ8r1vKO5fTHof2dgcby6M/zqE/qtj07PJcxZgKQZg4oFOcFLv1
 h8U4PmZ9fV86L5LmlkSb6Ey3ox1UnAzh8GVLfLhfgGi3vCkWZhruYaqYS
 aDF5EeXFPxgDfhUTBIX08ToBgbqnkUrTjMcc7H3wgsEvUAW2U6x5te/8n
 YqR6NcNQllcBpDIUd7969332Buf7Zd46iPPiHuUR6NBLNOLYYEiySVOBL
 DwlT3CisgpyIOlhqRhrhtKt0Mo1zdnMrQ1qrL9FiPJoaH7HWt38knB2Kb
 LsUt8cruE7U8Jnw3w6+flpye965CmPvM5BzjfgYK7StxeGuWDqMhdb+UV Q==;
IronPort-SDR: DS8FuTIFUyWuyCX/pLfVXysu0OHmATQT1ydhjltksWrervZY/eK7afgkwG/1NQblsufHiHjJ5J
 8JNJugOuUAX51hwPAES1Up5monD62KMswY1gxy1uWaIM9LYQM6q4JU2+cKIKGoMj4D31JagGeW
 sqU1OZcocopl/5hoCrrQAFnGFn7WGuMv26wwg+z7xEMFR5TgKq2bXpz6O94UYKsw/w7mRoeOD6
 2IuUKMr7GcD7qP5laSpcPbtQe1LD5RvTTokWbn9vSDG0fUrfH3aaNt4kUnf9R8sKEBmHh1udSU
 hzk=
X-IronPort-AV: E=Sophos;i="5.69,239,1571673600"; d="scan'208";a="123890607"
Received: from mail-co1nam05lp2052.outbound.protection.outlook.com (HELO
 NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.52])
 by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2019 10:24:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkCNT1EgJphaqCLUXvX+hzDU2yfHoYQX/ovxs0ic44VbcC+6IN/EO856fmnwsQuJo6Uu1wNhbisXIx6fcky1Ns4CnneXNKNlV6bKZMWt72DTLvHw2jl97q5hf80TbV9TbMYNAV4KBW4/+CKO6Oa3vapEx/5cDWI2qVFPljwPSB9B42JwQK1GGr+5m4xds6YMcxuaOfolepACQ0WbORhXaAQeP44gUhX1uKInG1LsPZSLcfrJOIqV7TuJq21KiU0Ue2Ioq13rBVk9jmDJDifBln3r+Eh79RFH4u59KNxsAzhb2gy97f+6i3g6vKMo2wJzbP7W7p17xu3u7g9LPP+MyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nKrrFILw3409c6fpKkVUMvUIep+EXUbAq6EQUvopsA=;
 b=Vzc5AzoRlVEjjhPHk4z1xA56vFE0WrU3r6hLi8h5z+olaDnPdrG47+D+OSQboyKMm7EZsEyvmrJL2ZCDiWboxGAWS9ezPDX8fA97UtQUCC89Sm8pCycmKTL7EXGc0oqlsSygjOOImxh0icqGgrXp4WGIVoJs2yFYtigMvWICd1sr/aGvuflEqpNE9CFMKBRpCMvlwVBT3mRiqbpoLRxiYnmVxkX98cqMLuQHPG69T169N/aysUN4FK69mg18kaxqgONlTPUE6RGosSMvUm6YKD9tIzVIxVDAOV4ibFENel7S/Af02QjUlGiBjRw04pO7wtABNWxgKsMuPofNgon8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nKrrFILw3409c6fpKkVUMvUIep+EXUbAq6EQUvopsA=;
 b=CfVXGX89pPWmwe4IweLHWjMGarTElfpMaQrjatq13GzAUuwOXJK5Wlp7kVQGMcDAQzPYCe2jPa62gi6x8YByq9PQeNaPYWa5/oqLUacx0yG8/KAEgV89bevs8YnneJDiZr2AE6FBKNWHTNQz9KjOgEhbaeHhFqyWT/4dpjCGkjc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5301.namprd04.prod.outlook.com (20.178.49.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Mon, 25 Nov 2019 02:24:53 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 02:24:53 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Israel Rukshin <israelr@mellanox.com>, Linux-nvme
 <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>, Christoph
 Hellwig <hch@lst.de>, James Smart <jsmart2021@gmail.com>, Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] nvmet-loop: Avoid preallocating big SGL for data
Thread-Topic: [PATCH 3/3] nvmet-loop: Avoid preallocating big SGL for data
Thread-Index: AQHVozOQbKDD4FN4w0uliUhVssge/w==
Date: Mon, 25 Nov 2019 02:24:52 +0000
Message-ID: <BYAPR04MB57494D9693539C308A75AF23864A0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <1574613512-5943-1-git-send-email-israelr@mellanox.com>
 <1574613512-5943-4-git-send-email-israelr@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96f5df20-7a5a-4dd9-a61b-08d7714ea7b3
x-ms-traffictypediagnostic: BYAPR04MB5301:
x-microsoft-antispam-prvs: <BYAPR04MB530167A88574F5B742957F14864A0@BYAPR04MB5301.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(189003)(199004)(66556008)(64756008)(6436002)(66476007)(2906002)(76116006)(66946007)(8936002)(52536014)(25786009)(229853002)(55016002)(9686003)(8676002)(71200400001)(71190400001)(66066001)(81156014)(33656002)(81166006)(6116002)(4326008)(3846002)(102836004)(53546011)(6506007)(316002)(7736002)(7696005)(6246003)(26005)(5660300002)(256004)(110136005)(186003)(74316002)(305945005)(14454004)(478600001)(66446008)(99286004)(446003)(76176011)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5301;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?cbRU5hfhwsCngsSkJjCFLjp4eCU/J5p6vUoD1pxP+BlyUWTKtklAnqmZCb3j?=
 =?us-ascii?Q?RGpqAhGcfj0ddBaDLBQezyNceNKo/io9bfftH6N4GJVDXUB1XEgxFF6xCzfO?=
 =?us-ascii?Q?7l/aWfW1ctMRmufg68Dbpc31AIUQvpi6MFNNhJhWPAmwS+RfFvrRuucKoLB8?=
 =?us-ascii?Q?HEXm0lfkGt6Bviiux/cHTQay/J14EGV+a45r1y6n7gABrBmToH2MmRkWYU+G?=
 =?us-ascii?Q?m4YpWWfOVtAj11A2LfefD17QmSdM6DJsbM+Xn6qV0JxEjgRPiQexQIVdjzOb?=
 =?us-ascii?Q?nIt+Cim04jtklqziAgM2Sduo7scYjHqYS5ALhuEms5Hme9TwqUOxDMtUG/+M?=
 =?us-ascii?Q?5HTdBzdmPxCIGCrU7orEPyeQs/xBccmBnh8680ivVCefj16uEbAMnS4xOtUw?=
 =?us-ascii?Q?JFJwTQ7Y0GM6RlZGUExCVvjzjkAfcmMgP1bnrZF4nwb8S/QawsQzuy+En/zZ?=
 =?us-ascii?Q?odBczKtzwpdfor3G8Y8idMPt7eZkZ3OxMtKt+X9TkfhxrWmxnbz44aKSHvo+?=
 =?us-ascii?Q?2UIKgo/639XFUzykMteuOPHLaWVFtPt/jJdtrlF5YdwbizgS+Uu0PL+m9Qry?=
 =?us-ascii?Q?ig++YNuT2OUqZvZw5BXlhYjUW41U4Q+tX9X3BAliJkF3/YRXtkqIEkzdBB+x?=
 =?us-ascii?Q?WcUDGull6M1ll4T9qxme1FsE195/w0CMERHWhvY6Guio5L3AyycyoLAYlMmB?=
 =?us-ascii?Q?fNoCYj72FQB+o2QZKHTesDu9tn+3FLGvuCnILA18caHee2hCGIKV8OzFJdy0?=
 =?us-ascii?Q?vph03uONIjMwROcLKh5lPsoM7QmSGDXC4yNmNxiAyDYk95vysfpwRkr3H4Sh?=
 =?us-ascii?Q?mmRpac1neTUkQQWZ5KjhCrxmE0AU9HbJNOijOnuFk45W6HBh4hav1NGtfN8t?=
 =?us-ascii?Q?BiOPxTl1LCU4U75n1OVesPxI+dUXQ7ImKDiZfV3W8BBi0/kWeCwxXOmF2WHb?=
 =?us-ascii?Q?j6+nVo9N3YUEvWXb0CisbZS9ICysynaFtcAwnO1ujMh+Mdlvl+0IK8zU5zzY?=
 =?us-ascii?Q?kaDu33G9Ih+4cEgYgMmZt6AIn8ydUrGnwF1zhqNYzGx9/yBqs9JJaJnW5NNJ?=
 =?us-ascii?Q?nCM5vkMlCcGV64yD06gqQtLitNNQ9ge3tE3YSlMsK9NcPRqZla494dKJkehU?=
 =?us-ascii?Q?fMJ9UbS4FvkTCjLBWbsu5PneMFCMyQ96bDBf/h3icGGutpDX/Zy1MihQcqXT?=
 =?us-ascii?Q?lm3KAYPWiu6yPxb4WHdpAx3C0hhlNAVcDel8Z4O0y/KDTExEGHrKTVV953BU?=
 =?us-ascii?Q?EsegUbqbjG8qtCpNFto9fZb1Rlhl62uxQrJFaEFCVZ+0sBW1VeGDQP7HIxsq?=
 =?us-ascii?Q?WQ/5y6AWgcQ+bjgyjngvqznzvLl8YrrA1YBoONUfU8kEYyaj8ZRMopOLXBAi?=
 =?us-ascii?Q?i/mvwaxr5RktHZ3c5i+PhJyKB9BdYcmG6QCg7Q3jIw7z9hJZiePjbuLt2Y7T?=
 =?us-ascii?Q?AavhLakwZKDAIS+Kc1WcRKQsAxsWkBctHx27EylFi5uxULMPI9K4OHCqc+sO?=
 =?us-ascii?Q?XatbLFNqIr6WQrWjePJs72NYHaQwK69XTMpwWzKqNcfODIk3CmBIFeiDjkrR?=
 =?us-ascii?Q?RXvvAa+fYqe5+LHyE6EqvXiSzvfuKgEe+IT6xi+p+5/1Odc6z3dRZmjHoLgL?=
 =?us-ascii?Q?Ozf3i8FATnPw8vSeAGnt0KFQ1S9mfm6jjA0rmw2P87/1br08CVW9HvVP53t0?=
 =?us-ascii?Q?iH8VSQ=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f5df20-7a5a-4dd9-a61b-08d7714ea7b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 02:24:52.9201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hf4DkpYCtnQhIu4pSQO005Yyj5UaO7lBbOo3/6fQQJgQl6yzADAEeHS8mw+8P7mYaVbFnC2l1mKHkPHEgPBPWqmep6MgyrPYYGpsHowBlOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5301
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191124_182459_475377_6805277B 
X-CRM114-Status: GOOD (  12.94  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good, tested with simple loop setup running ranread
4K I/Os with fio.

Tested-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 11/24/2019 08:39 AM, Israel Rukshin wrote:
> nvme_loop_create_io_queues() preallocates a big buffer for the IO SGL based
> on SG_CHUNK_SIZE.
>
> Modern DMA engines are often capable of dealing with very big segments so
> the SG_CHUNK_SIZE is often too big. SG_CHUNK_SIZE results in a static 4KB
> SGL allocation per command.
>
> If a controller has lots of deep queues, preallocation for the sg list can
> consume substantial amounts of memory. For nvmet-loop, nr_hw_queues can be
> 128 and each queue's depth 128. This means the resulting preallocation
> for the data SGL is 128*128*4K = 64MB per controller.
>
> Switch to runtime allocation for SGL for lists longer than 2 entries. This
> is the approach used by NVMe PCI so it should be reasonable for NVMeOF as
> well. Runtime SGL allocation has always been the case for the legacy I/O
> path so this is nothing new.
>
> Signed-off-by: Israel Rukshin<israelr@mellanox.com>
> Reviewed-by: Max Gurtovoy<maxg@mellanox.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
