Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5DDC47082
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 18:04:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5317D611C2
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 18:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5317D611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OXzF7UHxRHhR4XQdOg+DOxFMytHMnD9WOEz/z8K97Jk=; b=VCb51FqA6qvvSF
	439u3t84X7B6OuQ3mFOaSedID21qQDetYT8zMhP1ZtE6GZubpgvAI6R0WPG6vWvqEMwxlf13U8uIj
	Py38vM5O6TY1V2ZazGiybiYe/lVDbTZZ4byYylXNpfEdnbos2TSR4ubcGEB+L5F15DwD+JOGrNUEn
	VCxCIl/tkbZXnBPaasDaVASma5HTVDr/hqByEP5VW7PUGGFTuGMBdurI+mnG5VfJjMeFwdy3h11xn
	bccGQrQhl2C2wb74DBKlRWn/sLYMG+JTyN0TrgWc5yvqsIIRdMLNpmuj67C50+v86BM/YPm4AoSKO
	sMOxO8ewtw/q5AlMDovQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llxsU-00GLq2-Bs; Wed, 26 May 2021 18:03:34 +0000
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com
 ([40.107.236.71] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llwv8-00Fwlt-6V
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 17:02:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqmihrOV77XYbjNyFq8+ie7GEC9l0X/m2S3khqfVTpqydBm+u3MKC1veV+ZjNHASCbIqCdH1nwzhmklRYhvVNbWYsJP72DVH4TF1RNTtGC7DxxMgqnu2INb/6P73vj0/CmTbc0GXIsVDJOn6pUAIyWQAbKya1fLL81TpmDWzFs/jokHwJXacroW4wixkRfWPf1nldQxOZVjgbF09uSSi/RjgyMtXJhOvfvHU7KOR9Y7B5ch27pnZKcmGPXAbb/yNxoCmr4g/1EN9s5wj9QKVOD1tRxLTAxh33y9JPWuyo+WBd2RMk05erixL14/t0p88rR62yPP5a5Kj4eXS6yLiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXnqqUUgUObfdn2MdZUW+cRDBghI34MdX9X/EGDzIYQ=;
 b=f8mdkdzIxQSw1dlSndiMGg9q1SJtFeAO3cmSjwa20BoAlX8uRgApSsTLa7WiU9G7zQwaVxKUiiAOvKfvAwBIdF0aOz6IAab+dWWVpT8KHaRCye9CPUajbYtFdrco2Af04Zbj6KVN4gcSt0mJxXuQ8iHUNH6uCVf1rij2MfuZdRB/VFGhAnWhKHnnW7wgckYO7YAiSvvLhbuDV2XdP0oQ8+TH2h5ScnlWbFkjLPZ+TZW+M/15vmkEcrJvkZAEDqLaFAaNB9ieZNDWY6mxeVhAUBCWkoENzgXrs0wZUVuOG+9F6jzISqxhp3E4xh2zIF4ww7EVhP+roUVNICMNAdN42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXnqqUUgUObfdn2MdZUW+cRDBghI34MdX9X/EGDzIYQ=;
 b=pD4jhulrh9jwQkaSJgpvVOr3NaIq0VcaRvee+1gcexDKdbnWToj2RBM5blSYfbXIR1nHFfj6R6zqEWmcva6DZVv53I+3M2lG2vXl5RrVyyqU2R2BHc0r3jhT1dZKS4mO19Rgum1+axJpt3MWtY7qZ7/8Dk23QxtMoGDF6mOLFh4=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BYAPR12MB4983.namprd12.prod.outlook.com (2603:10b6:a03:102::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 17:02:08 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.026; Wed, 26 May 2021
 17:02:08 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede
 <hdegoede@redhat.com>, Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "S-k,
 Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: RE: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Topic: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Index: AQHXURCj33ZwIr9nkEeZsNaCQKwCY6rzujiAgAB6bICAAAQggIAAAH8QgAAFuYCAAAaCsIABMVKAgABimACAAAKygIAAIsow
Date: Wed, 26 May 2021 17:02:08 +0000
Message-ID: <BYAPR12MB2693CC654BD9AC2409AA556AE2249@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <8eb98344-cee8-df6b-8e72-1771b16702b6@redhat.com>
 <20210526144528.GC3704949@dhcp-10-100-145-180.wdc.com>
 <5734923.lOV4Wx5bFT@kreacher>
In-Reply-To: <5734923.lOV4Wx5bFT@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-26T17:02:04Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=61c05627-43c7-4dad-a487-4d75da176161;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2600:1700:70:f700:a1e7:c926:724c:a49a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89121460-8544-414d-e500-08d92067ff26
x-ms-traffictypediagnostic: BYAPR12MB4983:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB4983B44E1F84FA7313D54291E2249@BYAPR12MB4983.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JHPMRS83NwnZf2l44qedc7I4vK8PNRci47cEXKU8Yb1tPCceOf6eBTEEcSLjeEqS8IXLDnDDRlQsAXJoetPfUcqV6ppXgtSFETYimtyvLwz/C2RmA5yYFVWlCPvdUlQv4BPhuBBtuA+ecUwiPKpnMrb813TgOyJMPxWBhFnGiS8oveA7AZ+HuRSscZpwBWcdkN5TzOApO/PllJCrwbMYk3ZWj7EiLo5uIZ5y3FRRzEAVRy+08r5gqgRk172CNRf+77dU9NWg01hB3LedKg4WO/Qf49RMlo2T6eMqEQAF+du90k/9m3HHwmV4ETM7tSkmoCj3Hwm4yhUC40vEyvkx6Prp2uteyGc5jZF/vCaVZoPnff4IrYaSrpYvWOTvWtLrDoFrLqWHzYx0yifOgh5X2S716ixJHUv8G3/LosMsKScTzcA0JWoElrIYjgyFmSSuYnBiYZLACxxl5hEmUKJiGSv+19iwYBI/Dud0ArMxtINxQFhRXp2o0e8psOxALgOFoshyFO+x9otiW1DyRfehj2/yDIdcCNDcrCYOXpAXkYZO4+8LTAzXa9WADOmtbJD8UEan0q7cW546Y5zoMTZSHS2aVEn2a6kVFxFKMigBktE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(86362001)(66556008)(66946007)(66446008)(186003)(110136005)(7696005)(71200400001)(33656002)(6506007)(54906003)(5660300002)(2906002)(316002)(55016002)(9686003)(8936002)(8676002)(4326008)(76116006)(83380400001)(38100700002)(478600001)(66476007)(122000001)(64756008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?NUV2Q0ZMTk1GTjk5UGx1Y0NUL3ZOY3dqTlNtQUd0WE5nVFBEUHJjVVo2eldE?=
 =?utf-8?B?T0xUSTluUVhSeFNRdzdkbWpsb0xrNkVlR0RvNzEyRkEzK0ozMVZUUEFneVNj?=
 =?utf-8?B?NjAwOG5iL01nWnlXa0pObk9DOGJvMU42THRIVS9wMDhoczJxVFhiRHZVZnA4?=
 =?utf-8?B?SE5xK2pZSTJzRUoxTHVJenc3TllEckczRTBXWVdhWGppbTd3bkdqT0IxT3Jx?=
 =?utf-8?B?RFB5S2FzRFlSdERZL0s4ek5KU0lCN25XMVhBUTE1RnZISGpsUTBmU0hnTmFh?=
 =?utf-8?B?K3BvUkRZcGpSQnBoMys0RUhOQ3Z4VjNzK0xCVll6VXEvSDB1WlZET283cjg4?=
 =?utf-8?B?cDFsbTE3SjdVb2FROW1mdnVLRWoySjVPRW5hZUFxTitpZlV1RjFnMEQ0WFJW?=
 =?utf-8?B?aXd0QTNRMkJITzB6SXgzUm5Bd2ZqSE83Q0xBbXJpTE0vWFVBR1NZWCtXbmJ5?=
 =?utf-8?B?UjN2Ui9hTmZPNzJsTEVEMjNFWXNIZTdTdGpEVmJNaklWY25VUEhlKzgycTAx?=
 =?utf-8?B?cUx4V1kzb1JKQVpsaittVExFTEE0RG50UDA3V0ptUzhTSXRWY1FPNS93ZzNx?=
 =?utf-8?B?cDR0TDdMQW93T0NsQWE5VHFDL1J6L1lPaDhwbGxVUklnNDlkMEQvaGJhUW1Y?=
 =?utf-8?B?cEhtbFF5eXVJS1BrdHBqaVF1R1F3QmNWRmloUFBGWmU5OHRNRWF1SDZrdURo?=
 =?utf-8?B?K05ZVWJPeEhUQWhsbzJNVjVoRlBCTzdaYmEyRGZveE9BYjM2L1R2L0pUN3Qz?=
 =?utf-8?B?U09xN1dsRURxNU1jLys2OW1ua2JEWWtUZElhSU9aQ2RFemw3bklFSkFNOWlT?=
 =?utf-8?B?VUN1L2hyRGd2ZUdKLzhDV0MyUHFtalFyWWhxTWNQNTB6V3dXaGFSUG1zOWlN?=
 =?utf-8?B?b0lCUzVOSkh4ZzhWanlMUlBnV2Z4bSs2dFdTL3Ria0xYTWJyT2F2M3VrUE1W?=
 =?utf-8?B?THZKMm9ta3NuajhJNHhFeHFOOW9YUjhoUkQ1eWl2aUgwclB1MEhpbklZY2hu?=
 =?utf-8?B?cnN5YU1lWlloNzdpOVZ1cVZNSkpjZ2ZSeDJsOExUT2F5M0ZUWmI4ZlZaUUwz?=
 =?utf-8?B?TlNnNzZxWkFCYlZ3cktqcUdFVmpISUdIZm1qbStTaktTcUJGbE5UM1NjRm5Y?=
 =?utf-8?B?cXVIOFR5Z3kwZnZvSHYzRmNQYTJnU28yUkF1QkUrOE9wbUUzL05rMGlDb1pa?=
 =?utf-8?B?ZHoxMGJ5Y2FWb2UwcmgwQ2pqVys2VlFQakRGa0N5UmZORDIxRWMxWE42ZVRi?=
 =?utf-8?B?NVBmVENUV282MjUyM3MyZHdwSDFiZW9PbnhCMmNrT3EwUUZ1Qm1WYzlITmds?=
 =?utf-8?B?amJwR2hrcUZ6TzZLdkRpZjd0M2YxZnN0emNiT0hzcHMvd1RzMFZQWGFDOEtN?=
 =?utf-8?B?bHlYSGl2ZUdSV2JKUE9OQ0IvZlpnRWRWYXNJNFV5ZmJ3UEtKYUd5bmdqN0Fl?=
 =?utf-8?B?RFhoOVFvckpVTCs0Z2VWNW5saDdtRWN0bitCTDJGOHhOYW1yNmJZOHhkbFNw?=
 =?utf-8?B?MWtRMmgycVA4emN4aUFJbFNjb3p0azRjdTBzL05tOUhHZVRyVnFzNmN0ZWpn?=
 =?utf-8?B?dDRVOVp2QkNaNzRNbnpZMTkyaVRwZlZBSnlJK1hjUVNLN3FtVVpSanY1bXda?=
 =?utf-8?B?dEZmZTlzU2NpT0I0bmt1OUhGN3JyeFFhanZtMUczMUdwTXE2dnFqZU96aWY2?=
 =?utf-8?B?eTZOYTEwNkhBdEJJemtXT3lCUHRrRFRFNHd0aFZxMVkxc0lSa25BYkloYkly?=
 =?utf-8?B?YzJNbThwNXMrc01ERHd1N2FtODl5cnU2aks0Rm45Z2gvUkdZV0ZtSXArVWtE?=
 =?utf-8?B?QWY5RkRVVmd5aGdrM1pkQXhFUzZGNGxuNXdnc3JBNjFySHlnb3BMV2lUY01R?=
 =?utf-8?Q?SD5e/lVw9JKXa?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89121460-8544-414d-e500-08d92067ff26
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 17:02:08.2386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IiyrSz+rJ3Efpigj8SseX+i/PaAckdcbTMPT9GL1cMzai6Y28rJKZBCkfywqUS/EYS6K7z8N6M5qRkIjRGt5DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4983
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_100214_295415_CF1652FD 
X-CRM114-Status: GOOD (  25.90  )
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

[Public]


> >
> > For context, here's the summary from my understanding:
> >
> > We (linux-nvme) received a bug report that a platform fails to resume
> > after idle suspend due to mismatched behavior with the nvme driver.
> >
> > When suspending, the nvme driver checks pm_suspend_via_firmware(). If
> > false, the driver assumes platform firmware will not alter our device's
> > power state after the kernel completes its suspend process.
> >
> > But this platform's SMU firmware will remove power from the device.
> 
> How exactly does it do that?

It's running as a result of a platform driver notifying it to run (amd-pmc).

> 
> In particular, how does it get a chance to run?
> 
> > Since the driver believed that wouldn't happen, the driver did not
> > prepare the device for this powerloss event.
> >
> > It seems that the kernel's assumptions around pm_suspend_via_firmware()
> > and pm_suspend_no_platform() may not accurately reflect what the
> > platform's firmware actually does.
> 
> Note that this is not about whether or not AML will remove power from devices.
> 
> It is about passing control entirely to the platform firmware at the end of the
> suspend transition.
> 
> If instead the kernel executes AML that happens to remove power from some
> devices, that is a totally different case which should not be confused with
> the above.
> 
> > I do not know of a better way to detect if the platform will remove power,
> > so I'm looking at quirks to suppress PM_SUSPEND_FLAG_NO_PLATFORM for
> > this platform. I'm hoping there's a better option, though :)
> 
> Honestly, I'm not sure about the clear understanding of what's really going on
> here.
> 
> 

We'll discuss internally and come back with a different proposal.
Thanks all for your feedback.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
