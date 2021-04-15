Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF7BC43460
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 09:44:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A6A60FD8
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 09:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A6A60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zTV1z8llMbTFIUKz4764DRykKC9lyzVD29VEuAFMRg0=; b=f8+ELrSVJ9+m6mWgcRe4lxa0O
	bzGz2zI/CqTVzDBY8VmbASQ7ZzT4oea2FYt8CTDRDdwKXti0mZTsgQZatFMKcqoJZlJMZ5EMCSmCs
	j3th5OUGjfY0FEolnd6JQLVYGl+IDSuA1jncdW5YmWIttYns9cQSsZ+N28ZuHV3tbuwKp1bnGVG0r
	31CgaIBvuJO3L3WXyL0cfcFy12ipyMSsGrNiOaX7w2bSd8vnlmZVuWkmuX4ka5dj0j16mCDsMM++A
	8aBWGHEKa69xMr33OeUYDi3b5cfiiA+QWvgwJS9U7dBCiIPp8iOQQc9OdndUEar6+8MHDlFHJgAY9
	JNTbojGBA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWyX5-00FasX-VP; Thu, 15 Apr 2021 09:43:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWyVc-00FaIr-4E
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 09:42:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=tIfRHs+Ulo06Wpi1i+CbjmdTvruNa2UqIrcCj+EDKWw=; b=Z9c3cwIyTZpMKB0J4vouZ7q2j0
 gpQGNIsTJpJmIFhv4mmJFhOrLP1CI84ZHo6cIezNhhtNoKerNX9mu/kOl+Ov+EXu7v2O1a7gH2IGC
 dcju+2hfE/D553WkPP6aoMLNzZtWrWffVn5jy1mggXe8BImddjHVXMjzgp/VqE606bptl1/wjBa21
 pygQHZ7sx5LFpyvbKHctnu3nKgIyEvTse/iKSDQ8AnqYkCPRg3oGm86PWleWPUTsv1DINssrOvvfV
 W+UNERJIQjbOy/qG5P4lIqInHf8Wj04tW59f5l60VgyJikF6kwKV0SDDjzcv3+IbTDuOWSe7T2KtY
 V5mkaokg==;
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com
 ([40.107.237.58] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWyVY-008RAS-Dv
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 09:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBMArs/zx0cyMSP+rvZj6QZJzdcETdGu8xI/PEP4tnq5BLRen0h1kPWkS7fPJVwnfnAWiQU4mVRbeApbpIRLILMrC7qfPAaH8Khu6gvCfcQsQFK5yzaHOdrPInlU7+jbW7qTw7NJlcqrNqdst6R5JCMnX8fxgSI1YAyHF3mA0WCqoUIM5USyPliKRR9hg7zSoyuu8Wu/LCRJvOHqJXuQIFFgbb/3z4us9ROra+gnTNRZ0kfSBXjN6eKDkRQmSRNXmVDzcr1K37bzDCQoR2KVUD64LkSp/XGuu6hmA5m9NGug2gm+TI/bIvsdD8aI6oB+cHUdvQZclH4w+gNKcs0WEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIfRHs+Ulo06Wpi1i+CbjmdTvruNa2UqIrcCj+EDKWw=;
 b=lUiQfGeXn0bDATttHhS++BY6yJvKacAL1fsGae+s9Oh8N+R6nkjf6TtfnRtfNTGs5GQIDktMHNSm97o18wuYRppc9z3O9roqH3qWDqNdACo8Ge7USuOWY9lwioMqVzncDpPX81P1UDd4e/0E5LdLXYI8MSfPDGT6eGYm1Fjo6fJM/VJf7ObzMfkfQPU3jjRqvg2WNAjPAj00uKRzMQ7RIa/dacGdeiB7cW2imXhnlnt3nP0CglTtdCV5BdQb8+TDgBQctFLvAePQi5coTRKzUuGwW5k6yJoRt4hWZ+BZYFaLvxpNrpyyVBPVkuYOjx8PHubBjDR6ebhgD4qrN34VRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIfRHs+Ulo06Wpi1i+CbjmdTvruNa2UqIrcCj+EDKWw=;
 b=nSAcZY5k2dDI3p1EmfrtLmDqkRz6NpQ/otmHJpJ6E1DP999WUYl0okRPR3LTNr+9UsaG6vIHk6F5vNZDwZcHXiagZGliFg2oVjHal7kBoXiiEakrPLSjH2LEA3x3YPWxnjC4q0VVlZsHHQwTtQ8DNyX095KYJ/gaVv357ghbmBk=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Thu, 15 Apr
 2021 09:41:53 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 09:41:53 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: RE: [PATCH v4 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Thread-Topic: [PATCH v4 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Thread-Index: AQHXMarUZvDSGRepoEyCkC/coFRS7qq1PS+AgAALBBA=
Date: Thu, 15 Apr 2021 09:41:53 +0000
Message-ID: <BYAPR12MB3238E0366477A6CDE7AC9B94FB4D9@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1618458725-17164-1-git-send-email-Prike.Liang@amd.com>
 <20210415082057.GA1973565@infradead.org>
In-Reply-To: <20210415082057.GA1973565@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f9d4b40b-d32e-4f23-8d2d-65ede04a420b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-15T09:00:34Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ab8d705-5706-4185-5acb-08d8fff2b3c0
x-ms-traffictypediagnostic: BYAPR12MB2981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2981AECE3B44443338AB36BDFB4D9@BYAPR12MB2981.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6XYUMQUfo3GGuHvSZ1iADjGGMwWxMTT0N5o3eVFzHVvnqV3D5GaCMZ6hpSzWqmqa7pg5pF23hfST8eMyGy5ViepFqr0BOTk5fdvqpFkQNiONRoLvu/z365JTNRuw+y/PdgEEMaqGSZhXXCzmk1y8acxZZjEcGwbQ+Be16xG75RiGkh+Zh6pEcqojPLFbOhxFu+w8GrKtl6cd5BQrP64V9XZ7Razl08Sw4QrQyQPkFsYrdqt7x88bRqPd43PFUTZzyj2mhLvjKaX79bxaMQeXfCArFngyu9lhNSiIetz1lbi4ESEqb5Gqsq6T9Ty9Vva0PlVSfg/aWzuZRdBxY/daA8mzwnSjXVUNmI5LEXiO26HLs+BmFsMC0XblgCvb7ygEiKIQBJYWfg3AoP65AIbTp3eXbJb9VOij3gUIPQM+WT+7hpbhK/0OabhWAguIvBLJDSkGaSijkzjDmorLPBPqYO1p3nKLUFcalYn67Ye9SV/AKYeRcSZ6+o0L2ilLwhpU0yDMKshDcctZfvv1T0FiwkTiMYsM0sgtOOw+tfuX8bDh+CQ2o+RmcSXY6OFPjAq3F9acsFPSonbGhWdrRImnyRnanXIcEKDRKyzuOX9viI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(2906002)(9686003)(55016002)(8936002)(26005)(38100700002)(83380400001)(186003)(316002)(52536014)(7696005)(4326008)(6916009)(54906003)(71200400001)(122000001)(8676002)(5660300002)(64756008)(66556008)(66476007)(66446008)(86362001)(66946007)(478600001)(33656002)(6506007)(76116006)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qFavSWqugsnvQ+m6ckAJhZEzD8Yirg9SxfVF08ECf/HGtFC9D/arxAxHFCcz?=
 =?us-ascii?Q?u1pLPpjryRpgbLrkx9yixJnnnwRpfkoPCuCdtC6P0Nu+JQwiRgvlKZixYUAm?=
 =?us-ascii?Q?tKvA40S6sn1w1jIR464a5skZtYJuaJjeLsmmLTvoO+z/tvDqzkTxMeSMA/IW?=
 =?us-ascii?Q?OFo7tXA21PKq6Blxpt4jSfMVs8gpBoerOhVnCvlK0/OXS1NRW4sOVrgu51bb?=
 =?us-ascii?Q?o4ehh90Ax7goDxDV9GqIKYM8SHd9PCSZBu/tBIjf0EyKZXCCanPsBRgs/1Wc?=
 =?us-ascii?Q?wsYSPE9i0+xZnm6p3F67IgI46WR1ZOqKUy6sOmREaKYf5nPgjs6yRRmWlQ43?=
 =?us-ascii?Q?usJ0GdgE9MH5hHdyM09jNS0aKkY/u3cKWrjn8Cr0ICGg3n1ol6t/hnG7rXtJ?=
 =?us-ascii?Q?8WAreeJnxMt4caizLbJNWCGs4OlTeUfjwxOfzPNL7BWnsGnKtwPxBKEybOZW?=
 =?us-ascii?Q?Dj9XPJTpXLjmeqXocs0tyEOyjYbLJU7Og+m2jjmgUvrGuYCjD7fiQZr3C0Bc?=
 =?us-ascii?Q?z8wwxrL7hbFBlkdGC2zotmcGZH7/w4YJz+DhCZSop3+B+RELWou7HLh6gauf?=
 =?us-ascii?Q?2U2Sk20OYyknkxJyg21LTj8gqRVs1w0QmNj7rOFGcz/sTDSoFcyusrQV5+Zc?=
 =?us-ascii?Q?tCyel2Lvh2NalGt+NPIb7bVnvr84BFn1ZlGtFfDZS+5wej0KInoED0ljpt/n?=
 =?us-ascii?Q?se0ypkOSuEElfYzggp7LFEjwKnSF24KbeUEb/LkK0eK+Zq+XRiIBugXHSvWN?=
 =?us-ascii?Q?/BXOUcpnx4wVXDcxdPN8CvK9tpDva9b3MYR92qP0EpZZ5Sty9wThq/wjnaTY?=
 =?us-ascii?Q?PdPjkGJ3LJNTuKKVEF0LwQ4D4ZAZgDCKo9Jf4ioRTfof9MQqXIXN6vSfWdJl?=
 =?us-ascii?Q?DO2Ey7H0ueVDAIwSJmwOFdUm8zdtV9c8jEj1fVWa4csVfJllohAqkTkm0KwA?=
 =?us-ascii?Q?tGkVoO4YdUqpgRoFBCnEMjVpgCNFhG/xTDDsAaGnPQuatkWInD+JJEokcDrD?=
 =?us-ascii?Q?VssHVRj79drprhu94092ECwspv+PpwrDqDdeu94cpA+c/nPDTaMCTWwxRiEK?=
 =?us-ascii?Q?wfJduqS81E5z/OAj87LQhoOyPSMbREz+IqG+9hNbGJ4p6F2vM/IG84cCgkbV?=
 =?us-ascii?Q?YV6ru5ILJnkXxTR/oqSOJfhPhH5mTD2lYUFMX4DLOHSV4QRsQZl/3WVN06GA?=
 =?us-ascii?Q?Gews2ZZfyOl9KzEmUA5Q67JXZ5v8oOJ6w4eefqcD0nngcQXqYJCXuP0nnzzQ?=
 =?us-ascii?Q?feLk5umrfYZaBfdOpRXU7nbezPe31ceweywgmr2w2h149iEIco5XcAmv2N3a?=
 =?us-ascii?Q?2upyj8/PyKknMSq57d10d7Yz?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab8d705-5706-4185-5acb-08d8fff2b3c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 09:41:53.3932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3ir5JmYiAn9W7QeZ6JPfjNlrMTQWrBvRjq9IikIjYB/+DRLKJGrsv3UnMLVIbJ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_024156_496381_39B4C94D 
X-CRM114-Status: GOOD (  24.69  )
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

> From: Christoph Hellwig <hch@infradead.org>
> Sent: Thursday, April 15, 2021 4:21 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: linux-nvme@lists.infradead.org; Chaitanya.Kulkarni@wdc.com;
> gregkh@linuxfoundation.org; hch@infradead.org; stable@vger.kernel.org;
> Deucher, Alexander <Alexander.Deucher@amd.com>; S-k, Shyam-sundar
> <Shyam-sundar.S-k@amd.com>
> Subject: Re: [PATCH v4 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
>
> A cover letter for the series would be really nice.
>
Will add a cover letter patch for overview of issue background.

> On Thu, Apr 15, 2021 at 11:52:04AM +0800, Prike Liang wrote:
> > The NVME device pluged in some AMD PCIE root port will resume timeout
> > from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> > This issue can be workaround by using PCIe power set with simple
> > suspend/resume process path instead of APST. In the onwards ASIC will
> > try do the NVME shutdown save and restore in the BIOS and still need
> > PCIe power setting to resume from RTD3 for s2idle.
> >
> > In this preparation patch add a PCIe quirk for the AMD.
>
> The above looks very hard to understand to me.  It uses some AMD specific
> terms, and also is overly specific to NVMe.  Any other PCIe device not doing a
> runtime-D3 in these slots will have the same problem.
>
Yes, but the other peripheral device seems all can reach its min device power state during s2idle
suspend process. To be honest, I don't dedicate to the NVMe development and only from the NVMe legacy
suspend-resume software sequence can see during this default suspend only do some save-restore
APST link states and the NVMe device still remain in the D0 state and then the device force to safe shutdown in the SMU firmware. Then the NVMe device will keep D0 un-initialize state during s2idle resume and NVMe command request will be performed abnormally and eventually result in accessing timeout.

> So I think you should generalize the flag name and description to describe
> what broken behavior the AMD root port has here, and only cursory refer to
> drivers that are broken by it.
>
Will give more descriptor about the flag usage.

> I'd also much prefer if the flag is used on every pci_dev that is affected by the
> broken behavior rather than requiring another lookup in the driver.
Sorry can't get the meaning, could you give more detail how to implement this?

Thanks,
Prike

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
