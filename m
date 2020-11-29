Return-Path: <SRS0=SC3Y=FD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8282C3E8C5
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Nov 2020 21:13:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058E12078D
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Nov 2020 21:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sg1u1/Dg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gdcirsuc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JDKayUjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058E12078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Il3LymOmHniLH629myeBAs/bnAAO4GcF+B2t9ApofZ4=; b=Sg1u1/DgSYNmwnAHQVwo404Ne
	61TBwQUHXYalN6Y3+n6Wd9pV64xQbeqKkyiJyExsp5s7jXMrnjQh3CvpbEiLwgLuTzOkPrlsYX1QK
	XrFwZDDmmOTbmnOqnsSQgI3TcpieQrRi4GSut9TuBsdFTcsjh7W4YQWS4SlGqySRS1IIVfj9V+uDC
	PQMj6llWLroJ66/FDH2EuVOIvRa4CWgkTQNHwODvW0KIsooy3qu4JwAdTA1nb4nszAoWKTds1/AKr
	0Q2r6cH2YF5fCA/uwf4LA4r/jwZOuMHlckrR5P9ilN7SxZ+PwY3exZTHNEaW5FZRrhLSaFvHVKGP/
	+ldz9/eMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjU0n-0006UK-BF; Sun, 29 Nov 2020 21:13:37 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjU0i-0006Tz-EQ
 for linux-nvme@lists.infradead.org; Sun, 29 Nov 2020 21:13:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606684412; x=1638220412;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=stdPNdUaf0rQkS5eKvbh0klPbJuH1ENoQU9qFGAWdaQ=;
 b=gdcirsucPiQncYR4Vcj6/icI1FDG2YTtewo8SiupCFDze8POc8qRYlV1
 Wb+dTq8smOl7uZcR1V7CWWs85byyssA4KbBWfNEumMHtyAKyS5xTkRbeq
 Vg0Su+ugDGUYGmg3zzX2ljN2wRNg1XtSF6HiM1YpSNXZHVwa6curEwIXM
 lT919YcmVODeqpg132PjEbq6bzjlArWKqkJsp/jjKgv/UrdpyAAp1cdKT
 oYAi94zCitxyHvs7mNdo2ZyeW9fiD81R9aA8ObSCX3IBevuOXO9esaXJ5
 AfeuzRjoPTIQ0DYTj7XLjxjeZfjaUP9DBciCubTxMnnvXPKvnjFPNPu64 g==;
IronPort-SDR: QPMWfJwqOi+qHGPsHvAs+N+CXHYfGPyK6FhUcFtW9J2wY66ThM15PQpozopHR+sPl23Pg/t12g
 jYflHF2Oj5C6WuA2yY+MUgJhxIJmGp8e6BigoDG7YKEHsKAlEgg/jRPHmipGTQykWVb70sK0U9
 OgsHhOUVCznlM5plObUeheI0kyYddZVTwpl3W4RAP8Q3PUztg3/owmaXnJX1qv8KjwTDrZHyZj
 8phJDXHbJg/uKgyZHmxyU2j97oMMQ4IoD1+A0DessIFx+lMPcm2aIrT2dR9gqw9W1beEbuMJPn
 hjo=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; d="scan'208";a="158225416"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 05:13:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdiN531j2YGnYNycd30iGouZCiaQIdMFjzS/KPEXyh8NcDL/pzHoi2qbZn4/XK+rNTvoKGWb+PPXN7SHsJ4VzCLGTxlz0HWX0r/hUC8LRv1ptpRkm87ylqwyr409diyA4bmthAha/JsT22MEBhbWPgwtivv8YmYktuH+H2xFMCMe5vjpN9jeS8EPyMtsG21L+0PQ34zr0hu9Cbv2mX8EuHRLDVns9u/hKvXUalOlhz/Dhl4yjCHZn3eBmfAKQwc2Vwi9u1pYSM/qASF6f2NgxZ7ROuNWqPxKw1xCXnwJo2EH64jWmWTf1HHO3fADnFjF1izSQqp5cNimClFB9wfmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KjWeOYKd+UZhCEN8TVsriA4i7nDwqd4b1YR26gFkUQ=;
 b=WYuwkHrDushfFutHn26c6E0A6GXUATrT8GyzuzVH550bGxvt41w6nAbcEJCOdW0Iku3qDCow4ifGrvV0SH6qtLVnGCwXyTNXBNJpCzudYF3Uo2ioUZQsE33AXUm44EAcO1REzUo57Svs0WTeIEkgBLKe3NB+Ag44hHEuSx1KRQH1UiFb0S78wpjyO4CL1mbpa/rutZLF1zDWmST9H8SH5ZZUbSThDgdRfsYM/aUnwUY3nVO3XfjCRGXhO2H9aE++MOAdVjYfngmdJtaxD6oXF24M/CfrCurbBClM7I2lV+QIQ+hzk+0AwhazQBJK5mDPMTpJAoDpcGVydizwoV27Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KjWeOYKd+UZhCEN8TVsriA4i7nDwqd4b1YR26gFkUQ=;
 b=JDKayUjNeCW0zHwGDqPZQIjhKR1Bd7y0nO3GrGxNS+iacNidzNePWQXOsclW3M0GDeoupzVHfAJ7rlQk9HBsndWhD7yVC9CWva6aOcd646iBrzaLcqIV4g1X1S3xJrAv9Bw+Ixh8qDEAmPGtqTpoV7GAUa7D4E/LDEAh81g5B6E=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6021.namprd04.prod.outlook.com (2603:10b6:a03:e6::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sun, 29 Nov
 2020 21:13:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Sun, 29 Nov 2020
 21:13:21 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/4] nvme: allow revalidate to set a namespace read-only
Thread-Topic: [PATCH 3/4] nvme: allow revalidate to set a namespace read-only
Thread-Index: AQHWxnyPNSwY+7eHi0eeVdR+L+5epA==
Date: Sun, 29 Nov 2020 21:13:21 +0000
Message-ID: <BYAPR04MB4965E58F8445FB072BA752F786F60@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201129181926.897775-1-hch@lst.de>
 <20201129181926.897775-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43fc7c48-38c7-41e9-f5ce-08d894ab9a17
x-ms-traffictypediagnostic: BYAPR04MB6021:
x-microsoft-antispam-prvs: <BYAPR04MB60214E1D27DD0DAD0D6F2D2186F60@BYAPR04MB6021.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QbQeLyB4L+lXr0eGLFppAXEbdwVu++5FZzVUsNcdOtBWDu6r8xZBWEzRKfira2836sKRu83C+oV0fA6kryLy5Jl3o55aX/v7Wd5gfceGobVgypGUXAmINBpyoC/xoQEl6lOsxtABBJ5sWOPGFaeC8fePaCCdcKDWjnI3Epi8thlUng6kdo86I1rSHKf+y0xoe3J+WY2jEtzJVANE7gPzp9s0V1Ivr0qrvbAyItUjJkvqCp7245K5wGsiHw9OT2WhC8KQppu0JikNWPLme74t3olB+qXw4rQg2KWWIu/M8HVcLPSgh7shRjAAG5zw2KPzpwfKTvpKEtPtF6hMpMnSEw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(7696005)(53546011)(2906002)(186003)(8936002)(54906003)(26005)(66556008)(110136005)(71200400001)(6506007)(5660300002)(4744005)(478600001)(7416002)(86362001)(83380400001)(55016002)(52536014)(8676002)(9686003)(66946007)(76116006)(64756008)(33656002)(66446008)(66476007)(4326008)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?y0voHwWuXgCFoVkgEEWyzvUYdiS9grJG/Fy7RmYZRtK34TJ1YZ0H5sx6+C+e?=
 =?us-ascii?Q?IryFz42iXHRBrAv2yLkLQGXTdo4eeH1HBVNRJj7nZilqbzpQcKKWi79e9qC8?=
 =?us-ascii?Q?ftJ4zFj6cxaIWRz/e9eS+35VOn8VoeFmJrZHaF+qlMC2vk0B7uMnVlI/wns+?=
 =?us-ascii?Q?neqrlPMVCa/JCwQhTpbt8MJQ/vX0PqEN1A/Bfc8BEkf4WymHuYfnqS+8sBt3?=
 =?us-ascii?Q?KRx04oevE0thij02QvGMXQDCMvVVz64fRF0IH1qJRNZc+M3Xwgu8RbJNoNtK?=
 =?us-ascii?Q?/ENEcOjI1UqyWH4PzFskbt6sGO30a2QlWuvwmoiQ2UzLNcP1sY/CAid9FpBO?=
 =?us-ascii?Q?JRmWEcGlN/dnm9X9KpjC42bP0MYZTHcctfsk4KREnF+eihZOSfQYDJQFzZrm?=
 =?us-ascii?Q?1bqpnLodfe3RcTOyr0olY187vU0MoXepz1LsyBguv0kqnghLH66oODFIxSFa?=
 =?us-ascii?Q?YGMstJ5sivItKlHyVUVzf7nGPFE/Qi2r53Bc2YwTXmRVSxGXXTy5Esf41zq/?=
 =?us-ascii?Q?0z3xCE4rdDMLLI8SSjerk6hJCK+wJNPcPht7reOwsbTwpYCBkrat87qGLWd7?=
 =?us-ascii?Q?nslFRVVQSMsEkuGRJ+bZ0mnMzsTlz15Dv//atiA1HqFZ7QgpGG16beEGs6+y?=
 =?us-ascii?Q?QjWbMQYQB8pVZy8ua7rGdoDO4fp3ZlRuPiPP8JQbUgcZWvhNFmfjt0fghqN5?=
 =?us-ascii?Q?y6QBpUdL1I6TOH/SodeyEyJjLQ+/dT2soDneIu4e0KBKIl7r/XfOOJRStdLB?=
 =?us-ascii?Q?CudgghLZkLqADDvQyvYFLQl+kqTMtGgrjQyyDudguoCBnrt2Xr8st0K7CMQz?=
 =?us-ascii?Q?z4ZLj9BkvWBm570VX0kheCC87HmFfg4OoBjo70ilg7BKGsI7QvvHVozmRgaN?=
 =?us-ascii?Q?LCNMGcWC3DdpM+n7zqwYpbRU6RfFWx9UB1UxqYgYf5dZKRmrG4xm2rmHUrvc?=
 =?us-ascii?Q?rpJ9N9+Ef2AVh7hTPd+F+AJ56khIVGzzPTzGif3fbvVCzI5r8WgfN3yJdto2?=
 =?us-ascii?Q?tXd1?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fc7c48-38c7-41e9-f5ce-08d894ab9a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2020 21:13:21.6286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2HTxwqmyST5ic5euC4qzK15XcgbxMr15XHpHuS7QhbTBHs+vK61cX9neYsEMhdlNlkuyuTHjdLX7vvDDhaJMrl1yyqYWdNpktadydlr14k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201129_161332_828661_C2C9A14B 
X-CRM114-Status: GOOD (  11.27  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
 Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/29/20 10:22, Christoph Hellwig wrote:
> Unconditionally call set_disk_ro now that it only updates the hardware
> state.  This allows to properly set up the Linux devices read-only when
> the controller turns a previously writable namespace read-only.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
