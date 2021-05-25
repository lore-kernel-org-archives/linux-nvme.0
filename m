Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8597C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 14:09:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936D7613FA
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 14:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936D7613FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FYEM9ggVgrBIKzYb0gFXuwGiuuL3h3//UpTwxf7xi4E=; b=slp/LQrp2M+VK4
	1zmrSwAe7h9CnzGjRAaXLNQKqgziIWaIbLorchJE1Yno65NTONaUjU6hTSvK1uFQL6ZAqmMnL8dAT
	j0NwzZicJkvy35RgPyB9VdiIu9iLzuDAIgV1of+DoJ15uzUW9rT7xACv4y4d1+AK3+fa92QBUeBAp
	QdEscUC4VwDp3cFshGfErc7AmDxqv2sM/Dg5NMuqFLkfMwpat8Sr1c3kbNAoPpFHbq7oKmgSWVNHT
	rVhGzcBtWVZISFRU4Jp8pH4TVamsaExrL7PkWfmG/7rhEF4Q3xuuIIVwZY03DRKsfQbkEO9QhKL3E
	uyDKLnKKkdkXdJ683ecg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llXkV-005Z3N-D1; Tue, 25 May 2021 14:09:35 +0000
Received: from mail-co1nam11on2053.outbound.protection.outlook.com
 ([40.107.220.53] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llXkR-005Z1p-Hb
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 14:09:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pr38sL4iwqz2SQLbMnCKpFq5gLYE/1PJY1TLnHZQLuC32rkPMlq9MpClD42WabV5DQsafsd+NvBXfZHx6+4PwfuK3Vxyd/cR7OwtSA8+fPtcLwpsHciOPQFZIkSS50nZ2c+6SBE8HqHskwd6qHVuSrHSoh8+UMNnTnSvhGWu7z/HKKKpB7yRR66eBxQ6fqDUdxhsx3K3CDtvfAeIai3pBK559Fnbemh6R4fOILFJr73CvOtWmDy18prT3qKJOXtamXYXAX5M9c2n4DOBEiIYSjN6bi9b3DbzSlIt2s7boS0MU6pNVcXAV6k3of8kdM+6rHMdMxoMZDNURB8F11+Ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdPVvGWEvGeP4RfT01ikhJVS6AjSYa41zI+VLtQOv90=;
 b=kmh+jUvTswRczKMB15uurAh+5v7hOv8EArgFdV3GU2a+zHi4HW5VAmdBgCtW3FWjWm/BGHloayoV2camO80Mt/0kMehr1ShhxEOkfjXNjeA7w4prSwX8XJuZYpxuBIicmBGg+ocAEUUeMyY1h718LP1oeu3P9qCwh8gdwWLQPtEGi1mxZlDB530DjqzBSVNzKxVFVtHpfBqkwB9eogBmfXIwWiz/UQGoTTYPfIIC5RYwdPX9eumvlNr0OlCgsoOQx8d7RmvtXLS0AIJfFJunRVId1prmUx9Zr1LaR/6eJcSzlfb1in2GB/JBmZ0GVepI6LdFGmaRKy3ak1oD9byGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdPVvGWEvGeP4RfT01ikhJVS6AjSYa41zI+VLtQOv90=;
 b=j8E8CfYs2WQQ4v8sh7OiogYG5H4mWyt039RKuZCRc1mpuzvTxM02ro6LZoukcSlaVEIctP8DeW8WoUs2LQ6O2GMWDnW+fK6/r+bAcV7Bd7I2mP0XhJ2tm4Htxaefqb6zWFv5+O4+7FGlLIq4/TFrfsCmuuxPEKEMvi5I2okiDrA=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 14:09:27 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5%4]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 14:09:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Hans de Goede <hdegoede@redhat.com>, Christoph Hellwig <hch@lst.de>,
 "Liang, Prike" <Prike.Liang@amd.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "S-k, Shyam-sundar"
 <Shyam-sundar.S-k@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Topic: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Index: AQHXURCjLivNyY/YxESi16LnrA/EWqrzujiAgAB4RtCAAAZGgIAAAZwQ
Date: Tue, 25 May 2021 14:09:27 +0000
Message-ID: <MN2PR12MB44881E28B1BD38E89E2F95B6F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
In-Reply-To: <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-25T14:09:20Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=40868666-5355-400b-952f-18b41ba01183;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3518536f-4e5b-46e8-d369-08d91f86b505
x-ms-traffictypediagnostic: MN2PR12MB3661:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB366113F2C2C863238E90D70DF7259@MN2PR12MB3661.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ByS3UbaGN7hXbiIx8MehKGOn+bwPGAIj8mv+vuL7sjoIaAlrT+94vCENAsfEGjfTWoY8FYMDF9cSaNVATps2NFbkphopwPeux9cVLYn/55xQ2JfmgbNTlhIEW4D1HrYpGuARfSLImBVIQ2LKO1iaXoKC4m0Fc2Cwtc8zYi/4zcXdhubhABi1KfwUWuxJxg4XWwpHO6uu8O8ag8jrjub4dCgad4pWC2ElowKL/tK/YVpE9kKfQ4bf46jy2vwWlGq7hsV4jbcA+SgW3BJvcmzI8PrTNAOrRekg5gUrFnrz5RIdHvyq4OLhy4TwPchjCO2ExEqzW3r828g3gkfZgGGE81Wf8SQdq5BbLea4juldDqSbeNJkDlcyXT+LmTgvoj5lYgoJt337OcYi5WLObD+wcf2I54V+f/Jv6Nm37G6Cd/BnUlKN9w6seaaOmolXZkNR66ueT4JQY3Rm+FfF7H5/PxrsurPJPpYruppmFCiQ4oPHv07cecsXKfpA4eDLBEXHAaGFm0e53TV5wGGo8m4mRtWonbdgSa2BnwfUZStsNAq5lJdTwYq7+5nSzRivahFw6dbPW5NJb2ttuCW8GsZfBTQSeo/nQmVUxM2UsZn/9C56L5YoqwiY7Ve5ktyYPjVvI8r1IVlQDu6VjRfursszla9cDpCoXKAW9MyIIDHeynlCn3saubdB/hb2yF0+Y7lsFO5kb48i/rwVB93z5ZZoFg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(6636002)(83380400001)(966005)(55016002)(478600001)(38100700002)(5660300002)(33656002)(9686003)(7696005)(86362001)(122000001)(6506007)(52536014)(71200400001)(53546011)(76116006)(66556008)(2906002)(66446008)(64756008)(66476007)(316002)(54906003)(110136005)(66946007)(26005)(8676002)(8936002)(4326008)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RlVJbVY1N24yNlFoM0lTUUNyNElLL3pVckFVaXpZMkc3eUl5UTI4VXZkbzNU?=
 =?utf-8?B?REJiVnJhVTBhaXVBczRNWWZIWVRvVXpqNk5Wc1ZlL04yYXRyaUNkbWFUVUNU?=
 =?utf-8?B?MHl6RllieVNvbVB5clJyK1NQdXNQUkVtVEt0TzNERHV5aG1JOXJERmhCSHFu?=
 =?utf-8?B?RDhFMzc1WGV4azQxUmVYMFc5WVBTWEpLYzdMb2ZsazlrSUhOOTVLRVN3NkN5?=
 =?utf-8?B?RUhNSVFYMGROeHFsWEtyL0QvT09CRUMvdEhkSGcwUDhVVTVDc2pMamdsUmh3?=
 =?utf-8?B?Y2oxZjhEY0o4OTJKOFc5alpnMjVhM3pHVnB0Q0VuenJXUnBvVGZtalNNQVVt?=
 =?utf-8?B?aUxqUEhpTmN2eVNTR1NLQUE5WVNNYUcvVHZOVG16aXdpWUNjM3BidUJ4ZXFw?=
 =?utf-8?B?ZS9kbDVybDdqRDVGc0p2QkZyaThBbXN0MXdhV0FZZ011eWtrakZSeGVSaW4w?=
 =?utf-8?B?Uit2TkhBdkY3MzlOZytEQWFxMGJ6aTBkbFVtNnBhSkFXQVB0S0dYNy9oVmc2?=
 =?utf-8?B?MHA5N2NHYkNtQnp0UEJtcGo1U2IvOHZ5cTBxWUg2ck0rV0pxYnBJSE1MbHM4?=
 =?utf-8?B?Qmx1VmxvY3ZXNXdOQWVZVDZMQkpsQzl6NHoyakhnemkyb1dia1pyYmV3NHpj?=
 =?utf-8?B?UzQ2VGh3eW5kMFd2dGFSZG1RUkxPR2JiVUM1T1A0OUlPcEhCZjQ4cjBpN2hF?=
 =?utf-8?B?aTlWV3QybHB0alJ5b295RmJaZ1REazFDQ0tjZHFHWDkrV3d5cFJ0TkJrcnJP?=
 =?utf-8?B?a0JHL1liMlNzTkg5a216TWh4YStaYnZsa250UGN5ZjNVcjlQRm1CaExJSHly?=
 =?utf-8?B?Z0ZveXdQMEdhWXUrSzVHeko5MSswQmp2by9RWGNkQUNMSHpRenNUMGRvRzdQ?=
 =?utf-8?B?VVh1eW9URzVtRmx1YlJBSzZxb0J0MVBiYnNrTTRpOG56TWF5RW9CdE5qTWRi?=
 =?utf-8?B?YkJVN0RTMVdrdzREV0d6dWZaS0RqVGVjbjFuL3MvdnZiYUdrcElDa2pBQnh2?=
 =?utf-8?B?dXA3NWtmblUzVjJ5elZYS1RyMG5mdkRPWUorVUo2ZlJuRjN3QjZTZ1ZlVXFJ?=
 =?utf-8?B?SUNPaGl2SkxudlBzRWF0MkR3dkJsZTZ4TzVsU1RqNElOVkUzeC9iTUhoWWlB?=
 =?utf-8?B?ZktBYjJuYWF3eTdCSm5Qak84cHZMWXZ0LzQwYWErOWVCOGxBM1FqWDhyYVkv?=
 =?utf-8?B?MTRmeUhuK3JFdlhXWEsyUFVyK09LSXI3bW8ySGFLU0pUQnYvek1lNVlXdWpr?=
 =?utf-8?B?S3lDZG9aQTB3TVhpVWp6ZWdBOXJqVjVqV1VGWk9hZVNkL1Vad1ZCeXZEUVhz?=
 =?utf-8?B?L3NRSFZuNUZTNDNIOFdPRkJVbmlaN3lrNUF6eXNQcHUyRHQwaDJhMk5RNk1X?=
 =?utf-8?B?U25uRXFQUDNKdURuMWN5ZWcyaXE4amN1OFp3dWRMYTVTRklGV1plMjMxSWZZ?=
 =?utf-8?B?TFVydU9MVTlFVEVDWUFxTnRicnZ3eXl4cVlJeUFKekI0WXhTNGIvSGhoWVZI?=
 =?utf-8?B?bCtnN3pGU2MyeStHaEdRNXptUEdRVW1uR0duUDFmUkVmazhZQWpBRWNZb0p1?=
 =?utf-8?B?RXJlOHhHQVc5VlNVbCtXSGNkZnV0ZWZSN0wzWVFkbTBzY2U3N09ZZzBzTHVo?=
 =?utf-8?B?TkJJV3lnQW5kWnpaS3Z6d1BGTFV4WDhZVEVLSE45Y0tEVEd0UmdXU0JWemFk?=
 =?utf-8?B?VThWL29LY3JWdTV1QXFGZzVOMjR2S3ZjYisxNEtoT01HSHVmOUJnVXNIYnFH?=
 =?utf-8?Q?24mazpLHmAwC+yXQR6/+KjMSrc7DfwEU2jd4/Ki?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3518536f-4e5b-46e8-d369-08d91f86b505
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 14:09:27.0671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jv3mOISU6GSwVWdc/Vf1eci9f9VCpf9k687TYXNLpXN+zEH/F6Q/sfGdeIPGyefK3Z7Gt5t3+vJ6Fc5e56s4qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3661
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_070931_649868_C4BB984D 
X-CRM114-Status: GOOD (  39.10  )
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

[AMD Public Use]

> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Tuesday, May 25, 2021 9:54 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Christoph Hellwig
> <hch@lst.de>; Liang, Prike <Prike.Liang@amd.com>
> Cc: kbusch@kernel.org; axboe@fb.com; sagi@grimberg.me; linux-
> nvme@lists.infradead.org; S-k, Shyam-sundar <Shyam-sundar.S-
> k@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage
> device to D3 for s2idle
> 
> Hi,
> 
> On 5/25/21 3:39 PM, Deucher, Alexander wrote:
> > [AMD Public Use]
> >
> >> -----Original Message-----
> >> From: Christoph Hellwig <hch@lst.de>
> >> Sent: Tuesday, May 25, 2021 2:21 AM
> >> To: Liang, Prike <Prike.Liang@amd.com>
> >> Cc: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me;
> >> linux-nvme@lists.infradead.org; Deucher, Alexander
> >> <Alexander.Deucher@amd.com>; S-k, Shyam-sundar <Shyam-sundar.S-
> >> k@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> >> Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage
> >> device to D3 for s2idle
> >>
> >> On Tue, May 25, 2021 at 10:48:59AM +0800, Prike Liang wrote:
> >>> +#ifdef CONFIG_X86
> >>> +#include <asm/cpu_device_id.h>
> >>> +#endif
> >>>
> >>>  #include "trace.h"
> >>>  #include "nvme.h"
> >>> @@ -2828,6 +2831,16 @@ static unsigned long
> >>> check_vendor_combination_bug(struct pci_dev *pdev)  }
> >>>
> >>>  #ifdef CONFIG_ACPI
> >>> +
> >>> +#ifdef CONFIG_X86
> >>> +static const struct x86_cpu_id storage_d3_cpu_ids[] = {
> >>> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),
> >> /*Cezanne*/
> >>> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),
> >> /*Renoir*/
> >>> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104,
> >> NULL),/*Lucienne*/
> >>> +	{}
> >>> +};
> >>> +#endif
> >>
> >> This is completely unacceptable.  The NVMe driver could not care less
> >> what CPU we on.  We need information from the PCI or power
> managment
> >> core on how broken the power management of the root port is, not this
> >> kind of crap in a low-level driver, with potentially many more
> >> needing the same kind of quirk in the future.
> >
> > Hans,
> >
> > Any ideas on how to handle this at that platform level?  We need to select
> the NVME_QUIRK_SIMPLE_SUSPEND flag on certain AMD platforms.  This is
> a platform firmware requirement.  It's not an NVME specific requirement, it's
> not a PCIe specific requirement, it's a platform specific requirement.  DMI
> matching doesn't really make sense because it affects all AMD platforms of a
> certain generation.
> 
> Honestly I can understand that Christoph is a bit unhappy about this, but the
> nvme driver seems like the right place for this to me and it is already doing
> DMI based quirking for 1 specific Lenovo model, I don't see why that would
> be ok, but a CPU-id based check would not be ok.
> 
> Both are ugly, yet both are unfortunately sometimes necessary.
> 
> Reading Christoph's reply a second time though, I believe that what
> Christoph is trying to say, that this seems to be related to some special
> suspend demands stemming from using the pci-e root ports from the CPU, if
> instead the NVME device where situated behind some pci-e switch, then the
> link to that switch would need to power-down for the CPU's deep-sleep
> demands to be met, so this really should be a (probably new?) flag on the
> pci-e parent of the NVME device and then the nvme/host/pci.c code would
> set the NVME_QUIRK_SIMPLE_SUSPEND flag based on the flag on its pci-e
> parent, rather then having the CPU-id check inside the nvme code.
> 
> IOW I believe what Christoph is suggesting is the following:
> 
> 1. Add some new flag (or some-such) to pci-e ports/links inside Linux to
> signal the requirement for the link to be turned off during suspend (or
> whatever the requirement actually is).
> 
> 2. Make the drivers/pci code set that flag on the pci-e root ports of the AMD
> CPUs which need this (based on the CPU-id as done in the original patch).
> 
> 3. Have the nvme/host/pci.c code would set the
> NVME_QUIRK_SIMPLE_SUSPEND flag based on the new pci-e port/link flag.
> 
> Christoph have I understood correctly that this is more or less what you are
> asking for ?
> 
> Note I don't know it this actually makes sense, because I don't know all the
> details here. I believe that AMD is in the best position to decide if this makes
> sense or not.

We tried something like that:
https://lore.kernel.org/stable/20210416155653.GA31818@redsun51.ssa.fujisawa.hgst.com/T/
But the issue isn't with the pcie root port, it's the platform firmware behavior.  Basically this requirement was standardized with the ACPI "StorageD3Enable" flag, but these platforms unfortunately don't implement that.

Alex

> 
> Regards,
> 
> Hans
> 
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
