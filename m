Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C519FC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 01:05:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE4C61055
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 01:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE4C61055
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/4vqZO6YH820H2b4qB1j6u9e0kvNnxTVhwcCOWwNjTI=; b=lMOkMXA6AcVk1XbXBnajL3tDR
	6JWH0RO73IHIxWe1nUpaUEd3nhZfEZA5yb1i1uSD5+ho0zoJkVfcWdzB6zEn6oQpeNOokeHj1Aokj
	/mTXYKNjjG88weDfoCw5wqE3qtKWWmdoGBW8HSMC43Sqbskk/v5LSPlQjjUGIR9Wwejs2X65/yBJt
	IG1VWSDMMWdThkVl1uKoGzCM2GH8dQBDoBzKQO5+lm7ZlfCl5WP1SrzAFar0irBRT/hyvHRoAY7qP
	KbKrDDwAxBnNklj1XVA3uxacu9H/DhE4x/AQwOyx1IhmGptx/T7RnwrqkuJ+S22DGXLBctuWmADUn
	csxuGgAaw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRlle-0085X6-1J; Thu, 01 Apr 2021 01:05:02 +0000
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com
 ([40.107.223.47] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRllT-0085Vd-0N
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 01:04:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlNOgVOHUkBRqUs9ih6bA65hoHikgFvmLbaDoLGezZt0tJVjCULywscHcEB29CgMcH76VF2R6G/K3C6FpUp+nO+7JanlBc1/yitz7+iq1+cpbWdJXLuYgeKuqfrFzJ+qYKjM1mUd7ZPcaNnxztvB1D63U8uxGMgbaKW6eNVe8eY06KjL/VyTTZAUT3ADQNBrooCpOQsev+Vwq0ycj9ulLbl4I09H7IJINPsnSWEWa8G7sGc1UBwPMtqoSau7/C9+DVik+hsOvZp7NWzm2vKieNw2Z122NvXDbJZrFG9XeU5FTOO4w48G1L3mfjNKJiP+RDZWnqrIRUKmDxtGkLNKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFVPSxJKu68CWIQeyCSiQ2gJw2TfEYtILxZAqvqHUm4=;
 b=dLrqZxITMlrqdoUE4N4gs5rFQnNFR/0S4Nc90c1X8luRBJP6mlNBXk2Kgu44oyrES0xD/exoWEM3KynGgSNmBBgTlWzATUYLSke/2Ry9hOFSGauxjbTvHtzJEwJ9Nq2ppxo/+/a4+wcgt8+cprVJCZla8elBLUXHrByCZhfkcTVuXHJ+EXhtz97y1ZmQr+VHRiBz5+B6abeSgCG48k/1os4bjrwS4bERpVNkWo/Nxm2VZBCh3mx3MOOz0+OOTi1zz5SyMSSOIQitw4fmC9QsjiPu7yxOj/2V15vFLDU1D4J4GZmmBnVWs1afHCk1Gy646hyHUyzpRO6uBRJwLU5luw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFVPSxJKu68CWIQeyCSiQ2gJw2TfEYtILxZAqvqHUm4=;
 b=2lu3tWCpRE663KDsMDkltY3H1Bu9kAnq21QnG7gPbi+aJlJN8ocEiRlz2Kp1vCohC9nMIwb8YGiSdULpckfa1PRGD/+kJptPhTilnqQnia9ASaVKzIsxKHI7HMIi2vfbtQx6i4Cu724iu4l9M8JbsDY/BcFiidG9V+Z/HVGAFL8=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 1 Apr
 2021 01:04:43 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 01:04:43 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Thread-Topic: [PATCH v2] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Thread-Index: AQHXJiww8yAELa3I40uYp87vDTMXuqqe1hTA
Date: Thu, 1 Apr 2021 01:04:43 +0000
Message-ID: <BYAPR12MB3238BBBED21B92C3BA69B682FB7B9@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1617194885-459-1-git-send-email-Prike.Liang@amd.com>
 <BYAPR04MB4965506223DD3DE08DA3CC22867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965506223DD3DE08DA3CC22867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2e9bdc6d-8c02-4d93-a4e0-62ecd231d1ef;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-01T00:51:55Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.227.235.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3292340d-37f4-4df8-777e-08d8f4aa2293
x-ms-traffictypediagnostic: BY5PR12MB4307:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4307A8A650A4185A9E00B4F1FB7B9@BY5PR12MB4307.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eSTStBc+kS59kUtQeptXBWxxvrLDOjEwXqotVqGaiwSggMhL3xg/lVxISF3klZfVeJJAsfVd1zylZZgY+9QJRuHL+T23Ofq37othCtMyGTl5UkFt/jUhEFNGrFLCSSkCwz3oyJfaZYg3+iR0J8JpbX+mxiVAWSfLbyWYga9+2p2GcltBD60BnNLyEcmmFqzeA0y2P7CY+3bY4F11JWzXFBROpF3S8h65w4OAHnUtd517PvblHAjcOpdr0Z0LGTLIaJPbtWHkqeMLVrAptnx5KHufj7U7O3dgI7y4k+WNAOX9CjNgjRm16kBpRO7fR0LdayUkXE3M0buRKyJE6at6oQ/iud2mczZSBp0TtQyQ9K3f8oPTy7P6mj3uXXuk1/wV8aKR85EyDnN+IFpz/jJH82kpGgmlPUNZ9m9jE3P7U2Dhp1JinUOQsWGnw+FVCpjMTW7CYzBznIPch0cHl5u20wDLvTANw3t2CXFOHyVCsweWXJClv+6UxRGxzwL5PIdCZvs2e4L8s8tMujqer768ZInu0zQjfwGrSqMdbDMpYl0TkqDYx2EN4GfsiquFtTUthP1h8EGsewEz26Us1cL9y1ShBKoOh/OHjZ5dxiRLwCSysSzt8K9XTQgY89A9XfaBH0M25gFp623MeiWkTBv3mB4unLi66khFiN0Zq7p7tXo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(4326008)(8676002)(55016002)(110136005)(66476007)(498600001)(38100700001)(52536014)(5660300002)(33656002)(71200400001)(66446008)(76116006)(64756008)(66556008)(66946007)(2906002)(186003)(15650500001)(86362001)(7696005)(9686003)(26005)(83380400001)(6506007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U0H+heBpbEUreYXr8S8y65JCyD0w4DPSMr8cPL+by9vy178DaM55dXiT7Gz0?=
 =?us-ascii?Q?8ZhQcpl18mGuOovbQZ41tz3HYFI9HBZkd5lQNMzxEnBPDOORCOFXNuF78tsb?=
 =?us-ascii?Q?tQ0IYNd376NUEc7QeDgKeoS059nuEZ/WvOH3chXfRdHrxRAU+iiK7acokr5f?=
 =?us-ascii?Q?Wxg8Kfivb/YzPjYbYQhegWaRUCpBISHGx11Ip5CRmV/KFGKvaD80ucQ62Bry?=
 =?us-ascii?Q?Dk1Sr2ltyKzAXG2FM+VD/go2axl/YY+jxw9T0lr/E7GSYcP+j5YP/o0E6wNj?=
 =?us-ascii?Q?9woYN8Iz305DtWNc7WOwA19kMDp1LIdnr9jhgrGjTm/seNF3LjLoxjlzmKx2?=
 =?us-ascii?Q?dBceo7cd5UlEe80ERpTOryxQxrsRu5QuJ5L5PRzOEubZquE3zQskxEZ9mF06?=
 =?us-ascii?Q?zOz+pPV2QWCpuKYh3RwQxw9QWE+vg7W9VrdmVbo7Tn98DogRHpMjPmkveafT?=
 =?us-ascii?Q?/olUe/e1x81CniwGhzsnI3iAahYdulDsjWYSlwoRXa/SiJx3tmGbELV9sz1j?=
 =?us-ascii?Q?4Yii5duiBQ7XGZwRdf9j6uOEorbaOJo0t+rZ4gSJhsA4RUQo35pkF7YkLI9n?=
 =?us-ascii?Q?bXKHJ1pjkqk6lssyOlRUzLHx2IBK6y0yllkvSBb7XNyxJqtnwJEvZUk9qdIj?=
 =?us-ascii?Q?h8MnF2EA83mpNM+bAWtmjIbxq/qVXxlHTDDYyY2LxVRmR2wFd3EU7MNfLWrs?=
 =?us-ascii?Q?ZTzl4BbuI08QyFVRNN/j+wxzS69A2mDHSNpt8amyrZcv7G4KNyYtHf4TIkS5?=
 =?us-ascii?Q?AgAVW+mY280RF5Z3MPqRVDvlTnPYDXAQ2DQtvbqB/PTNw5iA44FJFsWUmnzr?=
 =?us-ascii?Q?aSkY/WNf+GR5PIC5NNt3+I/mi285KpXBi+qJOp/mksLxfoSMbuTBGiLYA2AZ?=
 =?us-ascii?Q?2TTpMIdlMyxtFZ1CS0HYgcNIMUCcpSXgEzsuh2gNvf3VRdjt0/cS8WCBsgPN?=
 =?us-ascii?Q?7hTKjCqswWN8MZsxo2UCuyPiQnW4hy0FP54saDHIVK/Uwf5nqTCvH80z0eM0?=
 =?us-ascii?Q?6brkQdSrdv5m7ANg8uzytOmfyLxOWkTo/Z3tNF0lgwd5h1agxgBndPl+/a3l?=
 =?us-ascii?Q?uIUyud+RjV5MlXzWdxvz9CVEXidYDomWy9PlA3sJcBHgIbOw+rTxRB7H01HA?=
 =?us-ascii?Q?b0vjDXDto2NV8ttpadZBVG7lhAHeR95pb3sFqRvf06ZIbz7znoON1LCpQcNq?=
 =?us-ascii?Q?B3qaoJYk6ztNCk1j68To8rviUQoPe4P6LyWRFFsUd0aAH+P40AK7/E2/GD/C?=
 =?us-ascii?Q?/FVyvPt7+d80PscVclCqVbSsTxUBCt89cgVhPl7As95en+HuFRmHuNMlrC71?=
 =?us-ascii?Q?81u6z+JcgZJkpISbl8e5vuhw?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3292340d-37f4-4df8-777e-08d8f4aa2293
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 01:04:43.3383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHILvMPAVR0B//CvyRiLJ0m593RclQ8Vj8qmSfnCtDEIjYn1ShLgc1gSFHNZ4qVd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_020456_916301_998817C7 
X-CRM114-Status: GOOD (  23.60  )
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

[AMD Official Use Only - Internal Distribution Only]

> -----Original Message-----
> From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
>
> > try do the NVME shutdown save and restore in the BIOS and still need
> > PCIe power seting to resume from RTD3 for s2idle.
>
> s/seting/setting/ ? idk.
>
[Prike]  It's should be a typo and will correct it.
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> > Changes in v2:
> >  Fix the patch format and check chip root complex DID instead of PCIe RP
> >   to avoid the storage device plugged in internal PCIe RP by USB adaptor.
> > ---
> >  drivers/nvme/host/pci.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index
> > 6bad4d4..1952da1 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -42,6 +42,9 @@
> >  #define NVME_MAX_KB_SZ4096
> >  #define NVME_MAX_SEGS127
> >
> > +#define AMD_PCIE_ID_CZN 0x1630
> > +#define AMD_PCIE_ID_RN AMD_PCIE_ID_CZN
> > +
> >  static int use_threaded_interrupts;
> >  module_param(use_threaded_interrupts, int, 0);
> >
> > @@ -70,6 +73,12 @@ static unsigned int io_queue_depth = 1024;
> > module_param_cb(io_queue_depth, &io_queue_depth_ops,
> &io_queue_depth,
> > 0644);  MODULE_PARM_DESC(io_queue_depth, "set io queue depth,
> should
> > >= 2");
> >
> > +static const struct pci_device_id pcie_ids[] = {
> > +{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_RN) },
> > +{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_CZN) },
> > +{ }
> > +};
> > +
>
> why new global pci_device_id array is needed ?
>
[Prike] This pci_device_id  array contains the platform root complex DID which need shutdown the NVME in this armed platform for s2idle.

> >  static int io_queue_count_set(const char *val, const struct
> > kernel_param *kp)  {
> >  unsigned int n;
> > @@ -2832,6 +2841,7 @@ static bool nvme_acpi_storage_d3(struct pci_dev
> > *dev)  {
> >  struct acpi_device *adev;
> >  struct pci_dev *root;
> > +struct pci_dev *rdev;
> >  acpi_handle handle;
> >  acpi_status status;
> >  u8 val;
> > @@ -2845,6 +2855,15 @@ static bool nvme_acpi_storage_d3(struct
> pci_dev *dev)
> >  if (!root)
> >  return false;
> >
> > +rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> > +if (rdev && pci_match_id(pcie_ids, rdev)) {
> > +/* Detect NVME device which pluged in the Renoir PCIE root port
> > + * then force use quick suspend/resume path for handling the NVME
> > + * timeout during s2idle resume.
> > + */
>
> The comment should something like this :-
[Prike]  Thanks point out and miss check this during this quick send.
>
>               if (rdev && pci_match_id(pcie_ids, rdev)) {
>
> /*
>  * Detect NVMe device which pluged in the Renoir PCIe root
> port
>  * then force use quick suspend/resume path for handling
> the NVMe
>  * timeout during s2idle resume.
>  */return NVME_QUIRK_SIMPLE_SUSPEND;
>
>           }
> > +return NVME_QUIRK_SIMPLE_SUSPEND;
> > +}
> > +
> >  adev = ACPI_COMPANION(&root->dev);
> >  if (!adev)
> >  return false;


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
