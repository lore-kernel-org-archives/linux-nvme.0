Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA86C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 20:47:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB0761059
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 20:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB0761059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=oRuQ1qBlLSc5fy1Sasw5KVdoD1ppIEYzDxomHBiUXrs=; b=Ih5vRCBcyteLp6DvXmQq1vGJs
	6czZQOe+CLwPzKXoHsM8zmiQZNOEcJIqhewH0eKCLcg7P8nMnAAFLOZ3l0WBJgdVVUgXkja6LosgQ
	qo7cKfG3Gyki2YsfDGQrY9oUdOLyijM090+RI1EgrD4a8IVqV97Ck3uUAeqhNIh3X7JFX1lo1oSjd
	UtcEQw6lPDb/ALTzeQPBIuqZoRXi0NrPzIFaw46CsIBOhpb46m75TRqHPBjnYf1DDxIfZjzvFpfAc
	KFNrzCDhIPqRgCrM41qAvCV0ri3RrNXbClQ87R/qNUf8Kw5q0/Dvz9G6GPtUvhznrmVxYBhd+O1ph
	0IBmk7NWw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRhkM-007YJB-6W; Wed, 31 Mar 2021 20:47:26 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRhk4-007Y9x-7M
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 20:47:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617223628; x=1648759628;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=aV13zUcf2lK7m+20d+8+rcOM0YuCKdeygEkYcAbTyEE=;
 b=gQXl2xkqAzF274vI+IO/37OQnmb4/hWepCV5gLiQY7D6mdm5mPe8vVx3
 CsCAY+54GrTfFr/SwuAPU47MHECP82vUXNkxYhqGOKRCcWiiMHr3Aun8E
 bUxv9bRDiBTxz78U7O+943W5y3K1f3yaA8EeKCxwVVTG9Vc084GM2PZEz
 8IHMQWGMaiRt0B7a1T34TGdC+bpjmet5QdY8Zd+ZcpqxMY/DOUa18008D
 dc6gbRf3QYhm5T2T68Vt9l6rAGjYVy89wXOa5b9bH0+WNZojmkC8Vyg3G
 iYJAxppNUlDzYx/OZdUmpikBW/GCjMO28LC/zcCkmbJ7iukBs8eBvFiUN Q==;
IronPort-SDR: cgk54e9yr7DI6UXRkrARM9GneH8H6ihyJEahxWLsJdZSNhs6SGfdZrP0DFDXKBOoIRfGJ+Zmvl
 jbQUJ12fqh2l9+JHxK+BdfhxryT2DzbZJiKUOXFersEUKTMGqeeEIGV1LMjcAoVN7snk/0ILjj
 WKsNXQuccQ7iK3n6pXIT47xBn0wIPbiogYKbF7un86ikUH1ZsDmOD0Ow1UQU87sgpK/jDVQUqG
 6SVfxA+ycJmNGImD3d7p3q/efSf2b6xXsTptXEx7Mr7Ojh+5ntLlpkF4K92G3SdYK3KBp61DP7
 LSY=
X-IronPort-AV: E=Sophos;i="5.81,293,1610380800"; d="scan'208";a="167968262"
Received: from mail-cys01nam02lp2050.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.50])
 by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2021 04:47:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H20Jxmqwe1xNR3gbG4BW7ymDNu8OBOk0W52HXcvbmu796Tl7xiGABzJCU40Ei+9Fdj2arvx9xufW5kbGSfQYdayjBQCRh/Ll6stsWLQsnPh+3suuNeCaInzLhJ/q0Hw+ruRBVnLrLQ/PtCGSGwiJS/Ok9Ycx0VnnlQz5xeCQjEAl7gdMKbcNoFRgKC5rjzvo/r6RqYPVvBPa3TeFNNlqkVKFqAnU7lptEX9Cd7hK5fVooJuRS7S8rJTJ8uw2xRM/UccMWJFsIY86rMG/zT7zEpANpCU2oKDEE35VqPf2cZllYCUGERZ5LE72a+VtbznGPAu3mIsYM8/4iaxCTus+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5J8nonM6cvyQ7okFyXtDCcO6F1jJ44RlPBzv72NCUo=;
 b=Xg1WjsjbZvKL8W1EzwgMu4lv0kL0T5wLEqkCQI2LgMSNBy6ayjABiAv8UhNG+zOxkkNC5CirSlYPSGMt1CyqwoH8Y6ec7H2DjFsYmhhB4T1FYST+A6UKHjeM2KrcnSyc5r0N6t095HcwsGzhaKGzVhArYlqCh839tLY2gLsDWR6cIg8FnQmblFxm/eY9Lq2U/b5VneN4bgeZvzs//whe/S8o+MbbvrY57z+JhYovjaWsilYlRmsICXomcv65doWC4bV9PQS4xE5liLhyBqzDUYiryI5RfRAJ9Z5qFwUsDMRU/ECb05QZbmZKpuWhuXBnWtcGN2QGxIwykBJSY7/Qyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5J8nonM6cvyQ7okFyXtDCcO6F1jJ44RlPBzv72NCUo=;
 b=syOXfEUkK2Jo+j8z6yv/ZirbEosmfmRCTxCTs8a0OjwFpTZLLJXLGakdFvVMq8Ap+R8sx4oQhgFfp8VxgJHE9iSVkQXWkFvzAeC0lkeVLSymszW/QF+NlEejNn8iVIowHKN3sz1Afl8uRYqTTD5ndCo8TuWpfT0cTyoOmsG165o=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3960.namprd04.prod.outlook.com (2603:10b6:a02:ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 20:47:00 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 20:47:00 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Prike Liang <Prike.Liang@amd.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>
CC: "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
 "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v2] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Thread-Topic: [PATCH v2] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Thread-Index: AQHXJiw4YhwKlHNl7kWS39G6IJDNjQ==
Date: Wed, 31 Mar 2021 20:47:00 +0000
Message-ID: <BYAPR04MB4965506223DD3DE08DA3CC22867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1617194885-459-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83606ec1-4588-4d05-0a00-08d8f48621e8
x-ms-traffictypediagnostic: BYAPR04MB3960:
x-microsoft-antispam-prvs: <BYAPR04MB3960DF587BB4421ABE8E7D6D867C9@BYAPR04MB3960.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q0vP3KWBBFykbHNUU+lqczwNnZ0s7rCP8IMu9ATxEdAq3CM3XoV0cSsw4Pq4x2/LfnZ2Ghb4/NlLZH+etey4mivl72rUJLniFAuv3q3JTDlsmUn0TVbYxdWEy2WHccWplL1iQ/w/UgrBj9F6zVBtR8QOZFDlMB48Npr7oSoNKxU7TZUOuYYK7w/6XSAQP36UebqhpEa+sHeYk0EueROmwPph9ETMl70Gu9WSqdzBQ23Cot4UCZ6VHa2ogq8fJQmtIdOPaPzky3qe+WLExEMfBoZit5VNn/9myMwrsUeG6MhxgREAKh+3Je88xVb1yZJCbL/QO/uel8OmoDOTwN6LD/XzTMXQbdb9/303K2iNONdPDiE60cYb49PIwy0M92jNmPascmIZcYZphxRIT6HX1N2fQHgGni1I4MSCmPV/zrLIioAgQW95xIatxFPTvXtNgQT5moq36CrWT6a537afjkUmzP3JvgxAAvIF/OcjRCvU4Erf6TaEdL1SV3ls2+n79wkEWYzUGqk8tPOOTZOjpSrpHwil/dP0ahUr+50gz6/mQP8NqgBXD7L/Y2OmsDSVkyzgTWJzTro3D2PpoG8rWzqV8Jb/+clAsXWwmqkZemSU1uKzUseAo9l6RmN2UqYI8693gGMhxu+3JPEiKHbkcwVAOkMpN+5WMUvtwXHZUNk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(4326008)(186003)(86362001)(8676002)(8936002)(478600001)(91956017)(7696005)(66446008)(64756008)(66556008)(66946007)(66476007)(54906003)(52536014)(316002)(15650500001)(110136005)(76116006)(26005)(9686003)(71200400001)(55016002)(6506007)(38100700001)(33656002)(2906002)(5660300002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?e48rCHwAEioV9GE7VfASHUZgJjb4aA5fYuLknHBgcNXk23w/LacqowEfxKcf?=
 =?us-ascii?Q?CAxRDmU2E71V/y83Pq0TdV7K9ie5chbwfefeRpd9QusXVA5ID8E8tUkHNDi/?=
 =?us-ascii?Q?Oxi134yUzIBJGOPKluwtcpTKCDkCTnRCCGNazUh+plJFxSbVrbjm57/mC94D?=
 =?us-ascii?Q?55eoT+6ZpzibOTFCL8d7S9qq+qjOzB3hEfzD68RYu1tdNcH1imwgQNhugICL?=
 =?us-ascii?Q?iD1740I6KtxypnOwIqmHUmFGFOCqlGJDZsy2gDz0UDUgUv8/+HAcYUh1u1Gb?=
 =?us-ascii?Q?Fn7Sx3Js8tyKBQTBHMXoW8a2aMwj71G4prv6yqkcp9/au2IGCCv/4cJjtINA?=
 =?us-ascii?Q?4pSC7BYC3yElVmc2RY7U66y5fsc5iZMDIydZAGjRXdQexpuA7P5RYlVIZUCQ?=
 =?us-ascii?Q?ejVuREcMNxXY5idjiqcVo21wbwney8D/MONjYHK9One4CoQKHa6k7mSx5pmN?=
 =?us-ascii?Q?ps2q0ehwmDx8WGMPWCQg8y2RirAVhj3kXSJssYQ0TLc6+5Uma0YNe/QBTrCP?=
 =?us-ascii?Q?GT87N7C3FmVsojUD/ZOOfrjGG7tqC5e+X5FTP6cGW4ZK9edE8Ro4JLtHgbt5?=
 =?us-ascii?Q?l6JjybdFJJ3NdBozuuWWu27lfRAn7Hkq0Lprf78yBAUuubaqgdxK8V0CnzIv?=
 =?us-ascii?Q?tDfFz8ws2spbL2LNDQGoTyx4uj1RuFXkNWf9Q17Vb+QRp4PQ+QoznWuunuhE?=
 =?us-ascii?Q?1qMIEWNLJz856U6mh0LG9REh36yvtJ0z3wRPtSTvBNC8gLCJyyl2YIC01T27?=
 =?us-ascii?Q?ia+ZKaJVmQJytdPkx0PfOay2bXdGDQrZLfxGj7CGcpoKhQ6N17PGkwjXThEe?=
 =?us-ascii?Q?uWTScPFIv7S1/0vtSNcAvNSdAHKH2k0eH2phVEQFT2d77V7X231gHyOLY9AO?=
 =?us-ascii?Q?NsUJzIeIbYGJa54/l4BeO6t6cHVHGLhRFh7gm5scfSom4e6VDa5fZnyQDa+P?=
 =?us-ascii?Q?PrqEiDvCKbhV7mKXiM9PY7psvZv7M4YjEw9s/XpYZqZcgRgPiHmSM9H4fzX+?=
 =?us-ascii?Q?O3ybgeQKvot+NrZld03Y1Hp06Xyrj2pz5fwkR4SBQaoZHdBsgocjvxf0AWU1?=
 =?us-ascii?Q?OxFDYrDIjWW2dyGWOwshAttJETKr0N8O8YhvquGtBNP0weEE7ut6I3En81XV?=
 =?us-ascii?Q?+uyS5nIIsuM1tTNqBFamrzRM1Zbmb7L1mo2VEFowpFNmtBhuUoAdBRK7uutt?=
 =?us-ascii?Q?wvSS4qErK2bZqnzWKOR049FmPNAwcXGPiNI4/N5KPYhd9wVwn/upIvyCVa5P?=
 =?us-ascii?Q?SEH4l7Ons+TngsyHmBHAe5d3kW+pEkRh3yOPls5XchCLTG88NDKDmtxcrJ3P?=
 =?us-ascii?Q?G/3AcL2tGcFyVTm/MFBkBIP3xIuKvB0ra1nUQuzENAkBAw=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83606ec1-4588-4d05-0a00-08d8f48621e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 20:47:00.3295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODOEVLJLdASRW4O7LH+2oh7FxWsqoBl9dGcGEcsg5CF+/lqAjnim9TDsrR6lP5RK4bsCUZspHtLkm5RMsvVgrY6zMGXRs9pevnTeuJnD+l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3960
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_214709_096581_AF4CCB0B 
X-CRM114-Status: GOOD (  19.28  )
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

> try do the NVME shutdown save and restore in the BIOS and still need PCIe
> power seting to resume from RTD3 for s2idle.

s/seting/setting/ ? idk.

> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
> Changes in v2:
>  Fix the patch format and check chip root complex DID instead of PCIe RP
>   to avoid the storage device plugged in internal PCIe RP by USB adaptor.
> ---
>  drivers/nvme/host/pci.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6bad4d4..1952da1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -42,6 +42,9 @@
>  #define NVME_MAX_KB_SZ	4096
>  #define NVME_MAX_SEGS	127
>  
> +#define AMD_PCIE_ID_CZN 0x1630
> +#define AMD_PCIE_ID_RN AMD_PCIE_ID_CZN
> +
>  static int use_threaded_interrupts;
>  module_param(use_threaded_interrupts, int, 0);
>  
> @@ -70,6 +73,12 @@ static unsigned int io_queue_depth = 1024;
>  module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
>  MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
>  
> +static const struct pci_device_id pcie_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_RN) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_CZN) },
> +	{ }
> +};
> +

why new global pci_device_id array is needed ?

>  static int io_queue_count_set(const char *val, const struct kernel_param *kp)
>  {
>  	unsigned int n;
> @@ -2832,6 +2841,7 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
>  {
>  	struct acpi_device *adev;
>  	struct pci_dev *root;
> +	struct pci_dev *rdev;
>  	acpi_handle handle;
>  	acpi_status status;
>  	u8 val;
> @@ -2845,6 +2855,15 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
>  	if (!root)
>  		return false;
>  
> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> +	if (rdev && pci_match_id(pcie_ids, rdev)) {
> +	/* Detect NVME device which pluged in the Renoir PCIE root port
> +	 * then force use quick suspend/resume path for handling the NVME
> +	 * timeout during s2idle resume.
> +	 */

The comment should something like this :-

              if (rdev && pci_match_id(pcie_ids, rdev)) {

		/* 
		 * Detect NVMe device which pluged in the Renoir PCIe root port
		 * then force use quick suspend/resume path for handling the NVMe
		 * timeout during s2idle resume.
		 */return NVME_QUIRK_SIMPLE_SUSPEND;

          }
> +		return NVME_QUIRK_SIMPLE_SUSPEND;
> +	}
> +
>  	adev = ACPI_COMPANION(&root->dev);
>  	if (!adev)
>  		return false;


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
