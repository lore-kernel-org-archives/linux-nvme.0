Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FDBC43460
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 18:39:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE6061423
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 18:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE6061423
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=rB7bW95zgJPlT6t5JwBJTUE73BPiUpyBWhpPsgB29XY=; b=efbUDbqqyFxkMOcLzMFbjdpae
	/272ZuMhOQ/0XNx7a8XP06kjRjMiAA4zhivQUF0m1yDzQ1mrSeVx7FoIIfEAfoh97DAOQJJjPTUBx
	LfafsbIAhdkQdKtBuG2RYsWBATT81lb8DEqGVyZbSwtgjA8/HCoCTQuSdAaxtNhV+cxepEro3eN0h
	sx8UrRN21eTsXYPVEdTbOKrG4ZAeI4Pe/thspePnVHBul41rouffoY+gd0Fnz/NCjdjlogL488B3t
	Hjh/q3naDYqc2LXQ4T4np/UJF1zgbPOwQbCILRB1rKGaD4YxZMDM7G79gpgN+2z3VlewBuGByT6mM
	ezpQ7fd1g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbp67-0045Vu-0T; Wed, 28 Apr 2021 18:39:43 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbp64-0045Vi-8W
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 18:39:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=+K4ruTnJHVZsk1WIgOIKFjsHx0hvQ1mbDJYCXI4ITHY=; b=KowV1zGT5LGx9TK1Qnheto2lr7
 ta8thRcjQ3LMZFBiw6uNQu6eNPY+mgmDsSJCmcZddjZ3RdYMQvlprDFogdutiJ5f7J7Wnv6Ou4ezi
 Ey9mo+mjV31Z7jcz0YXGJnHyKuY52ykswmRUSbLN4LOnT49rRKWAUAWLIgWmI4b3UTK640413dZbD
 H+wPpEbUD/no0EQsV0YsbU+LMd3YyrwnlzL7ESaOU52JUIE7ml8mL0w+CvyBdOgk5cd0cCYT/Azep
 ylj8z6214kIsxw3E3mz43wvMy+oZK1bTqqUXbeB6cJWWtzTMhGOPDk3TCS9VIaOVDLDEiQxs9Chx9
 bALQe3Sg==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbp61-0007Ic-TR
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 18:39:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619635176; x=1651171176;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Ua+xoiiYz77UxTsoaGqiX2apZiFGJ7b5WADQlPLZp1s=;
 b=n4wgYbZxzVOwtB8PZealzEpIdasmq+MtcblRwfZdVsuUzOKB7+unrJjx
 QItaweBYyNknlW/AtqCcLFlAJbITKUn3fEJcBrIT57d1Lu11b+cDwFVjO
 GnMqCF+1tLTdZVDPKCaKvgpIW21RRdPNa9yrUDLTN0zRnJczz8dKTgK8z
 hZCxCBeL6Lqlp5ytr7YsuF3BeOxUlJvR6O2GFD4ymq1JcPY4BoeqB2hmE
 j87IjTsQlMMHn3m8IytIXNYEzpM8IFziTQHMxcGwtL+bf5YxFkSNTzttj
 HFA5sETwcxy2oc7FPj7SucsFGs5DKuyB5ikQGVTfaIb/oIhxgEUMvd3T8 w==;
IronPort-SDR: 4R9IJAorsaYqewuezsnUHvrjTecc4HrS8N/vTV4WdfQysymHzAc7VBLzmdkMllMXZcgN/jAow+
 NYrQe1tft9jPbnDiVfypB50Rkhas5/iDNXt0f3Lw4LhUHHgZZuGhXEMMiPeKmiR6Zgg77aCmQL
 TWpjfMMXhCvaNlNxMtVQlZyoVeonjkDD0pX2EjhzbkBJ+vhTFG1ZBagkhrv1S93FWUSaqo51Xn
 /oUPrpdKPDgHP8LkJOpKbDgjefrK6o24DNOf/d4K71e4oaX0I3jLQYcWWUvz6Ze8+y+kaZVJ24
 9z8=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; d="scan'208";a="166573999"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
 by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 02:39:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITdcXcBGzpuasPZxG5i0D02RFCQ+Tn9kcv6JmBajzDqKRnYIojQVBmEjwEVFynFpSIgMiCDsh6DcG7RR7xephCx+Jm6PbGt7JKaJ5knE1U6W1BmJ4U6K9jgBj1J5qorLH7QtHfWL5IwMmTbWpONe/vawhemop4VpvOsV6E3ooYtCLa0N2JKU/aZZML3mXyOja76K159sPW16OazFiqRKHktjY0mIoXuzqyOJqfeY4Ww+OVXwJ0rFGXm9HL/pqqgl5r9TzZLStMye87cRL6Ws+iHIZJnBjzJZ5VErN9Ldfdk+lFios8Ps/UFK2uhFsZPS/dF/AcXTgNlQHG6mNARgNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+K4ruTnJHVZsk1WIgOIKFjsHx0hvQ1mbDJYCXI4ITHY=;
 b=QOBvgVHaZqbgy0+tyQhi8Fmb6TVDM519lLZlPZKD2mkP3fRLyFQcwqAD0Acld4qJKKxbtMI2XDV+LJ/sD3G1mIRptJT/W8vt6s+JR1PZFva5HJI4492sgiIgW740P7o/uO2d0aNtEZEoOjc5drYAEUCHpXVEJ5vp/6QTLLE3BaNurTFdpWcBWoD8or3/iDu7lU7vPKZZlQnpiF9Yn+YN/kkif4qPeAb65SeYGTC3JzhcNkc6pEp5Uos39fypqLn8Fjmqcjp4bo+XvLs4OIh8xm2KR0bi7tkkvmNnjKazzcOSnuowcItEkCF1qe+eNqdon1uLEQDANS4VEtsEPr1sag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+K4ruTnJHVZsk1WIgOIKFjsHx0hvQ1mbDJYCXI4ITHY=;
 b=iLQ9DhCk18/denPnphp4Wy9dP0gV2AFkO7nxyk6ER4KqKdOAGYNGRgu8KsVOttCD5LDyL83wTRf+PwTPE3kRfUE9xDZ1vhs0jD3bjsxhvQxW5J6XJ1W28ZIPCnVmrZnISMmrPBP9tX/sd5OejkMxB0vDW6/CKs72RlK5FBCyadg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5688.namprd04.prod.outlook.com (2603:10b6:a03:104::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 18:39:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Wed, 28 Apr 2021
 18:39:36 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "wenxiong@linux.vnet.ibm.com" <wenxiong@linux.vnet.ibm.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "keith.busch@intel.com" <keith.busch@intel.com>, "wenxiong@us.ibm.com"
 <wenxiong@us.ibm.com>, Wen Xiong <root@ltczz405-lp1.aus.stglabs.ibm.com>
Subject: Re: [PATCH 3/3] nvme: Update several detail information in pel code
Thread-Topic: [PATCH 3/3] nvme: Update several detail information in pel code
Thread-Index: AQHXOtH7WAkrtd+TmUmE4jBaAmQeDA==
Date: Wed, 28 Apr 2021 18:39:36 +0000
Message-ID: <BYAPR04MB4965E84427B8D5C8930C6EB486409@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1619459538-3998-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <1619459538-3998-4-git-send-email-wenxiong@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none; linux.vnet.ibm.com; dmarc=none action=none header.from=wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2fa50d5-a4fb-4715-2e17-08d90a74f91a
x-ms-traffictypediagnostic: BYAPR04MB5688:
x-microsoft-antispam-prvs: <BYAPR04MB5688FEFEA019760FBBDFE8AB86409@BYAPR04MB5688.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZCvSTmB9vyAh0cV3F5L6UaESHmpO2boVwYqQQE6vkqAZNt0hih7HfPJ/rupbpQGlZVHa76DfRZAr1k/5W64wn63gUs8SVISmQJw1Kv+5bNV2V2mzaY8oVYl/LvRqbfUViorZR5OU6TccTnBx1b3tlqH8OGiRxdVfwTBgmnlbF29l0XNGKC94lZv7VqkhOk/yhWBhlV/8AfDIi4jT9J8YeZjgQIEv4TB7gP+JS9m/eyo4yttNtSoRtbTxq/aTuVhWDo0HKKahNe7NF6taFlPEtCRY22Oy+gG32NbMkCZTR6Q/Y6UbGSu4LTSFPap0t/Hu3bNhvJZM4tgmjzlXRTT84wWZF9f7LayP5GV12J2VQtfoI2b8qobRPfQ8PfU+dv3Vyvxnk3yYnnC6mGCkuj1ImfgGmJL4zvBGSrf5N1IJ2veIF2NTPqBu+wz4aSLfwjgQ6k65xCMobEcNSLNeTxfdj6BGHKOwskLtl851lN2ikh9pJkbD6eoxUjG0XmSveCPKZNj28Nc2HgUC4dSGTLeSz4HIa+CdJ6c5nFiRRlBdXpLIz/1W4ae/nKQFp09w2a+dEHIM/CoGesvXwiSmf4Y5DC7hmeRz3dnFq8Y9hfNyi8s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(52536014)(53546011)(86362001)(6506007)(8676002)(9686003)(186003)(26005)(71200400001)(558084003)(54906003)(66556008)(66946007)(38100700002)(7696005)(110136005)(64756008)(4326008)(66476007)(316002)(76116006)(8936002)(2906002)(478600001)(5660300002)(55016002)(66446008)(33656002)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?T73ZhJzCc6IhrnprQL879IGq16hnoPfe/8DsIDwAAL+uQYoQ2lfrQAE8SQ3l?=
 =?us-ascii?Q?mibWOXJEuiAEGT5K8cXpb8lWxSW7VRWtfF2FW+EdGZ1XWgiiQnWnlcs8QXY6?=
 =?us-ascii?Q?GYJOg8f249gUqhK0cTBR50i0JTennyV8+yRRM1rFN4K88iWGWl1yntwpZFcl?=
 =?us-ascii?Q?tub1fHApb+iYPR8lFDATeZ26Lh/Bn0f0Rf7SuqSdFdpZ+jSFVe+MssxwGR9V?=
 =?us-ascii?Q?tUzXzwI6cpYCwcH0RoXjlDTGHnd45flqa/pjdDp7Qol2p8CyedwCH0YXRYCZ?=
 =?us-ascii?Q?Z+W1ROSFNOQORq/vXDv0B+4kllNnms3EThvCsDsO/Igex6mau2IPQtYWrGqq?=
 =?us-ascii?Q?lBJYwjdgWbrkqCUu19t/G1vibEValadLNuICWs6Ce5dW1BYu17Y18n9Zxf0z?=
 =?us-ascii?Q?jbEyAflldSB5XHDLcPZGfsmFLofqrxv3czDyrPkoF8qUdza8v7xFMyLBejij?=
 =?us-ascii?Q?ltest590zJeCkT1qgDF8acruVqU1Poxp10/ViAtExilOk/yAxY1GCiIyWDH1?=
 =?us-ascii?Q?XaYw2PyH4QiZDGzRiJNIPJXwssOEE3SRR1Jwz4MbatZsIjJBB4r0CyduIQSx?=
 =?us-ascii?Q?teo/N0QXF3wypAunXrHHWrV8C4EydSKDVFq2XZ9Y3QXbSkNrotQw9L2h3Dzt?=
 =?us-ascii?Q?zwe0cKYPnBAop5IaynTZImW9MBq1vWzFJC7g5Wr1uJQmV0KRpp1JWRsVkgNu?=
 =?us-ascii?Q?lkM0xTP8swVJKKm0UKBt2FyOWg3aEG2/FNDqoH1xB3Nmub86x89Cy+b8kj/Y?=
 =?us-ascii?Q?coWT/TqEgYLrKNs1vMv3uRgYizruY++XQB41LuCxOJraQh069B8P3N0/w9O/?=
 =?us-ascii?Q?KJ1TcSoEitIodqH4Iyfv4j+qAFDjq0B/qqYH/DYBTpetGIBB+StcQxE3uJv9?=
 =?us-ascii?Q?sTy+c5As1UOvuZP8H483/Q3xlgKQBtTPA6lm/cFaXdNDSwy5SaX9UrWSGkEa?=
 =?us-ascii?Q?1Bccje+Wui8fWHdZT8FT9SO4YgscaNZ/zFsDXlGZu/IdwmeeO+oovZStVRin?=
 =?us-ascii?Q?Dl8fIF097Y0G3RIPbFy4zbpwtJmzdn95x7aLTmY6RpiSODrb2Y5ZjTHmhpEI?=
 =?us-ascii?Q?PRRcVorsndnnWwg+pl0GVavuMGyKZ+DPLAgngftR0MV1d5c4aDxcet7IWlsl?=
 =?us-ascii?Q?mckPfkezkAAxFw/w5PcSSgm07GxMQxSlyJFHd2TvGrYw+ly8skA4jtmhh+HD?=
 =?us-ascii?Q?nI+Iom0p/lKKduBeuBJysx/fCHJk/uOT+B4QpiO9cJMLVqRuCU1BVR+vhY3B?=
 =?us-ascii?Q?fx/t5vHGNMlVI0/cGR92af8I4P1gLRZ7xjmQQSKvA73jszN8T5Z0MxIGB5JK?=
 =?us-ascii?Q?t138R72Vsaktmp6CBryn5gvL?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fa50d5-a4fb-4715-2e17-08d90a74f91a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 18:39:36.0113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RYu8Vx37FvWC6QPYin6J9kedwkxdtt3xeor+upSfleqLo9k0rKDuo+b9qcg69+5LsKKevlMLnBbNiMMNs3riJza4ncKFXyJzocsTSA3D2MA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5688
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_113937_981084_ED99F2A3 
X-CRM114-Status: UNSURE (   8.30  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/26/21 12:25, wenxiong@linux.vnet.ibm.com wrote:
> +	char *ptr = &buffer[0];
> +

why not char *ptr = buffer ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
