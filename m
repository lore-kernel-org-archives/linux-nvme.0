Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B34C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 02:06:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B9660FEC
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 02:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B9660FEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=JgfYmpYO8CX7NcZoop56vEodGKfXZfoL2HH9GaYJcac=; b=e8PmdsFBqt0FGAoD0mL8/5OrT
	8spZyJaqlEEYQhAO2g0LvND6CiA5xAgUa+6Noh+GnhRP0dqrrMG8v/B8yFD62v1gR3BiuQpkTFKLj
	UNPcqeAxgMgLvZUc2T/YHLT82GXdoeXuM97HMxkdInGHCQgGjf4QzLJE9dvkcrV9N+SmMu9miCaZ1
	5zDdVLktPvkbAXvas8vWAnUkVVY3oBdSHNC+t2MJxRvWwWt6isDkjMilqqjkW+xik09gMJWFt16+y
	gc0TYxclNoWGO7+UMBbfGstg/6j1bHomGTF6PCzztK6YwmfnmGuJRvcN8AV1iTbayyBsxIYjTpbLk
	spSq2nkTg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRmiW-008BWg-I8; Thu, 01 Apr 2021 02:05:52 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRmiR-008BVn-Kr
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 02:05:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617242748; x=1648778748;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Rh3LsqdXSyUnS9RbEWeOE02zeynjvnXNwecsq+CyaI4=;
 b=KnOnk74xMmdx66e10P3yuHj42B+7QeWkplq9d3E9fGb7DwpzFiAXJpUb
 GppXiVYf9NnvHHdQHt1uT6Uzh9J++8nXLTHDDlEdVs/eJ2focVYb/wbLF
 FWguA1X8SgF80TODn2ItsKlak24shwHB4j9RtrW1Lk9EYHLv3a7zSQJgq
 cU05rE4oLbQYJ5aLA0E0fiHIFhBNCLxygssPhYeEuetv1CNfbVlKiFbO+
 dYpbYOLVjNmMmcYsL50mWgsK2nz2iU0IaJTjPd65PPdk+draGv4cUIus1
 RfIpcqyHgHJbC6ffbRxn7yhhB6J3QIUvrrIGLtxlqHilo1T5SFsZ07Ysq g==;
IronPort-SDR: c0qTwOysMoYb9Jj0A1IEex2t9Nx4Hoed+X/WwDqAebW7a9Znx1qmhM/ytEaKBvGL0440mA3PKe
 NDESZoo7E12xvOoiokGwLkdT5PsYo2cWV58Le8dQvt1iN+oX4ylm28Ww3gsg7Jo189tt2mVPjo
 1fbMw+R2MHC/vFyMgUEt9rDE+k759L5SKkvtmblv2Ye89gRwMPZdOZlGQ7ypBO9Lt2nPU4ywjU
 /TGJxUd4R6pSWXC+CRIXpFfCpZWgBEdV4JAbFnAqy1sUnF3RfXpVfnHCYU0G4p0sh4B0chGG5A
 o5g=
X-IronPort-AV: E=Sophos;i="5.81,295,1610380800"; d="scan'208";a="164541566"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
 by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2021 10:05:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd3FyBT7WzWFU+hqpkn+gzy6/gOviYYGwA5r2vXoVdQAJdSY07iS8cdkew6jKotkHog+C8qw9irdRxT/2D9X+WjcRo80CKd9VaNQH/+w45M0nAdMZWd69Syf1XLkc+apfd8CiWCAv8BVMVdOxpI3/m//79XTaSWZU+/X9j2jdERl+fmM6l+pM554COZfSrwo8YPwkPCsQyf7mnY0hVqfTs8LD0X2c7wucwsarPX6DPMqa+4/lwb9y0Yasp/cq8w/y40892AZslMZL8cv1aFS8jC3EPFOaS874NTT19/boKCUwBz42pVvQ/JT9VfBPbXvzb/6iLC9viwaTgtleLSOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLc98r6VfJ1ugZIQNzPEcvK3saYZSRH5yXxxjHKNmus=;
 b=QcaMpfhaJ7DnExkDwCelTFxJ1fPYe+2jXIAzijbKtnDKRSEurow1wLITEx/FrnKzclnCNab1P4tLFsaXnFC7yBhjyxpSJFLjNz72kmCSypbCXxEepaQ3SJGNs+mlPr5AxHzdwn310wRWiQulBbEvp4oYDeTqtVcqV+P9axH/c7rA1yVPcAVveyg5q+v2TbkLJOQLPbuj3h2hlq4sv/DYDp78CaS5BpnCiritzZY0xM26sc6kNW+1m7T2RjEwV5kHpLck3yMUs4TJJnZ/+ffkmhPzEtGSR1wjc2omHAdnNSMfOikd70nvBe8WtKROBBLFczeHeGa73r4VIy1JWSu2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLc98r6VfJ1ugZIQNzPEcvK3saYZSRH5yXxxjHKNmus=;
 b=RiFvmOHeCaR5TJkIW7mi7TO37TvFwi6zqXuRGhnOUu8B5wTcmPGIyyf9FN43GmCnQVPxi9+z/ksi6iEMAsTLc9xUoW46WrDOljEFyEYqX90fVX1hOFzdL1ShC9jB9JYEwvMYxjDWKcef2aqzCROlDAakg5L1bmQYMe+uHLBgiF0=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB3801.namprd04.prod.outlook.com (2603:10b6:5:b8::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.30; Thu, 1 Apr 2021 02:05:18 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::882c:527b:8a9e:8c01]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::882c:527b:8a9e:8c01%4]) with mapi id 15.20.3999.027; Thu, 1 Apr 2021
 02:05:18 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "Liang, Prike" <Prike.Liang@amd.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v2] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Thread-Topic: [PATCH v2] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Thread-Index: AQHXJiw4YhwKlHNl7kWS39G6IJDNjQ==
Date: Thu, 1 Apr 2021 02:05:18 +0000
Message-ID: <DM6PR04MB49722AA7EB8BC1BE985FCC15867B9@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <1617194885-459-1-git-send-email-Prike.Liang@amd.com>
 <BYAPR04MB4965506223DD3DE08DA3CC22867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR12MB3238BBBED21B92C3BA69B682FB7B9@BYAPR12MB3238.namprd12.prod.outlook.com>
 <20210401015112.GB28381@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 435a2323-5354-4fcc-1461-08d8f4b29926
x-ms-traffictypediagnostic: DM6PR04MB3801:
x-microsoft-antispam-prvs: <DM6PR04MB38016FE5DF073111CE4AB719867B9@DM6PR04MB3801.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T4yr/5o75WkoTbzNnbNAYUpt4QNkbzoe12hnGtQ0Tc2gNUfgtryx9+zvDTqTYydbSSd4nKbny+OQENIrPNRzxO/X3cVveQhlV4pSV9KAtBF0tHK1Yq21wwgMChWB+CZ1EqPRmGms5oP+pkH9cX0+zvjduOkPy0zC9IkzO+PV2pLFADkCFt3Kw7YiXprZbsjZBf4uzMjzbUn00AS3V7Fa7d6fBEU9pAjFPhRH2u2jiP0gFlaPJFqkQGOBibz2acHWJsJToXlbXCHZjR7HdAahltTetYThRS7KmJQ1ql1aZQD7BWN2pk/7oXkAeUI+OvvZdyuJUuKjAmmkfM4hquwdPP48edP9iLfWE25R09e6PVoSHHfa/8ZyiGHWh4E3KtNkqAB9njOskGR+mg/l5n//znsQq61RRi9fc9yC6TukwyOCGt9us99PyE2l2pNOUKud3A0jmYNHsGkCgdU+p2N2L3A+YzRizvbetVRE8U9v1LdvpfwcA+95tNZm9fXjohPm7mvYg0qkT43Wp9EcBptSCw+x2oC/hvLgNZroVoGlm0+JxbohHsz7hJFw98YpY82jAlCRQ5LiTIpMwj54N/sxqQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(8936002)(110136005)(91956017)(66446008)(54906003)(33656002)(76116006)(6506007)(55016002)(7696005)(26005)(2906002)(38100700001)(316002)(66946007)(64756008)(9686003)(66476007)(478600001)(5660300002)(71200400001)(66556008)(86362001)(4326008)(8676002)(186003)(53546011)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fza7qcb9mdlLFXt7zOJ2NS7w+1xP9Zxbue1AzhtgEeN7l16D6re4moyQbC9Z?=
 =?us-ascii?Q?WmMqvH0TXaIM6NYb5EOVPs9TGsnSkeU9Swg4D4J/Cmweg0d8ppgMHf6uUprG?=
 =?us-ascii?Q?Nym8+6L5wpXGfBz8KKaE+nlSC6DkM+1KPENkA0pUp5VTKPKsjmk64jLplCNs?=
 =?us-ascii?Q?8jCcDlkT9NRVf7bkYEQF9W2mNKKiZniAQm+HPKnwI28jDnn28PXotbQXoaiO?=
 =?us-ascii?Q?Ez96dQlM4QWygYlvqUPoY5sixEl27xZq4l1VXUGuP3y7IukH2o40kxiAAYw/?=
 =?us-ascii?Q?TOZYgcuQRW/2dv6BLHST3W1hpvGtaUr3aYw9ek6xyj4/SUHN1ty94gJZLA90?=
 =?us-ascii?Q?zRw+JCsk/NDh0XKPvaMT25M9Si4xHX44brHU4NTxBbF492huDMT92n9wXCly?=
 =?us-ascii?Q?yv9rCj8DQEqxOTG/QBeYs5oxa3xzgc/wkIvYIBJOB8BfGjI0NNFyXogysjup?=
 =?us-ascii?Q?STKAIBKfXLf8OMJguTQ/3xatYf1ix6Y6r0V1/Tmr3i8A9wQbUYKr20j8Up6q?=
 =?us-ascii?Q?5GKzNsR/uc219pDswjdaI/zQPH5naNGDzgMcryeAqO+JHsLJbIoBkM+ctUCc?=
 =?us-ascii?Q?0qL6ds6LhOfP++w6U1SEi8XQrCLe+JoSyXP/tilSYD2l6r3wK8zQUrKN1Bb5?=
 =?us-ascii?Q?RVsIxUK/5D3DxUFb1SzjMl0Ubz5GhlSEEaImpzt/7/dhoyt3uNRwkJRh5x8t?=
 =?us-ascii?Q?9gqA83nlyXyxVBbtxm+yEz9aSmIYFGxyIcpcW4GtIiu22uhsoTzN65ipDWw9?=
 =?us-ascii?Q?0iv/n6X8kFl+eGwoCdI1blrXKrpysgdKPYdQU5Vr4jfeHW4TxZ1CzxsupO4B?=
 =?us-ascii?Q?6Tz6rWscgYIyNxz0j/bqxChjy4O7BRrMbbtuQ/1hHV7M/1/NOhWkC9rHG4HZ?=
 =?us-ascii?Q?g6kpLBVagIKLwrelAeojq5ic5Ar5v7E+6Ng39N/IQ6BAtSpnvmC2QVIkLEdq?=
 =?us-ascii?Q?I6DAPn9wXlEiKM9NQTIBhXmOthMFlH8GGq8hChDLxNBV/HBuw5tGFtGbrawA?=
 =?us-ascii?Q?1HQ4BWlcL35DAFAPBo9fv1XbPxZ3Hfl+GbOJwNPvyboWNuU1IQc0wHI0GMaT?=
 =?us-ascii?Q?5pY4w71aiPhj3sTWcZSNhw6mKyT56i/+UgOnI/umXDamjRPS3xzNH7IOTloi?=
 =?us-ascii?Q?z0BJYqQhOSvmqpuidrnejhmI2tROBjOwilgTIe3oDCX5+zUVfaPbReAAZHAL?=
 =?us-ascii?Q?txiTkcqz7mGaa/jmFWMsWYhPU/xHjsJtxXjC+K837vtaTn9XpPemxxqxKkSk?=
 =?us-ascii?Q?AtVkpC027nt0FeRFsaJolywUBAjRMu+cMTwxnJUf64O/bFQNZC73XCEm4bxR?=
 =?us-ascii?Q?yacuCcbRIxJ1Ai07/BjJ0sLi?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435a2323-5354-4fcc-1461-08d8f4b29926
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 02:05:18.2931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEaly8KhdjPHsWowFpI0dTd1lcKw9NK9Ez48djfxa8efkES1hYbIhYMA7oZpSr/EKLqartBXrwlNOgDzxcT9yDNmXRMczfgo7R9Aog4dzNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3801
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_030548_257663_B67B340D 
X-CRM114-Status: GOOD (  16.26  )
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

On 3/31/21 18:51, Keith Busch wrote:
> On Thu, Apr 01, 2021 at 01:04:43AM +0000, Liang, Prike wrote:
>> [AMD Official Use Only - Internal Distribution Only]
> This header is not appropriate for public list communication.

Yes please remove this from next patches.

>>>> +static const struct pci_device_id pcie_ids[] = {
>>>> +{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_RN) },
>>>> +{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_CZN) },
>>>> +{ }
>>>> +};
>>>> +
>>> why new global pci_device_id array is needed ?
>>>
>> [Prike] This pci_device_id  array contains the platform root complex DID which need shutdown the NVME in this armed platform for s2idle.
> I think Chaitanya is just suggesting you move this declaration to the
> scope that uses it. 
>

Yes, something like this on the top of your patch totally untested :-

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fa81cea41f48..8b2f619eabab 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -42,9 +42,6 @@
 #define NVME_MAX_KB_SZ 4096
 #define NVME_MAX_SEGS  127
 
-#define AMD_PCIE_ID_CZN 0x1630
-#define AMD_PCIE_ID_RN AMD_PCIE_ID_CZN
-
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
@@ -73,12 +70,6 @@ static unsigned int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth,
0644);
 MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
 
-static const struct pci_device_id pcie_ids[] = {
-       { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_RN) },
-       { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_CZN) },
-       { }
-};
-
 static int io_queue_count_set(const char *val, const struct
kernel_param *kp)
 {
        unsigned int n;
@@ -2835,6 +2826,10 @@ static unsigned long
check_vendor_combination_bug(struct pci_dev *pdev)
 }
 
 #ifdef CONFIG_ACPI
+
+#define AMD_PCIE_ID_CZN 0x1630
+#define AMD_PCIE_ID_RN AMD_PCIE_ID_CZN
+
 static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 {
        struct acpi_device *adev;
@@ -2843,6 +2838,12 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
        acpi_handle handle;
        acpi_status status;
        u8 val;
+       const struct pci_device_id pcie_ids[] = {
+               { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_RN) },
+               { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_CZN) },
+               { }
+       };
+
 
        /*
         * Look for _DSD property specifying that the storage device on
the port


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
