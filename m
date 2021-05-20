Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1A8C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 18:30:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCD0611AB
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 18:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCD0611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0eG98hOPx8IP7DShBWTS3yrBmOSpcbjvO/G+CXpbOBg=; b=hjqJAqOjU/1k63/U/g2X0/EP6p
	tK1/OtcqEUIDzurMLtsScPsAsmRowH2ERhpR+2t4eYLHWDpeILm1kd/YUJdCrGD/jWFT75UsSPRqd
	P4fkOdf/6xPGEXbHPWveTUvZ1t0Vja1e2bhf3Gz1UlF/9dJrlz2xFEY/W5XrIO+4YGLuhnRtrrPPN
	2UFn5Hy8ZApph03cB7avyFTzmmEJs3Rwl1lQHgypsUJ/5lh2uSSBCVLaqExniaJXIytYVXJasi0Yl
	27EIYQfXsIB8qJ3NblAthSTQUhpY95147g8NUfz43h8Qw+WZ+U0SWUbP+omz8A1hroqhcbU2TnMtL
	hFCI134A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljnR1-002GMk-15; Thu, 20 May 2021 18:30:15 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljnQy-002GLh-Ne
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 18:30:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=pkFFSY1J8eroyOVNdYg1NZhE2HwZKkEzflM9dggQ5ug=; b=JQaciV88XNJ1LWrGB6of3DnEvS
 7poUV55haiUoxrE6a7lgLKxUNWN5mLRt5twlFKwOiZKV/A6l8FbJLGOo51k3AII7JKU9p1NkxVX6D
 2WWslJHWJU5vKZj25Cd9i7ugwuPUIVAGpZBEABirZ4Hd4tBC28WD5iDYS/iMAmNosaXB55gbJEsPi
 s/N5WGrQtb07ODKXf+4B/EPAILJv6yR4E/KVgJspZA8gmvvqhRuy3pjRckXGtz1s0gDjpngB5wlH2
 JxuCwJVdehdcJ+VdU4v4KKRj/NSZkATDZYnhOlggW8ZuRVuTb3XG25mHr8lYDPccXgXi468QROByM
 SU0up0sQ==;
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com
 ([40.107.94.76] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljnQt-00GZei-MQ
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 18:30:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuLzFmvGhwVYOrhEZnPLUip2zXVKOKE1FD08kJ+aTD65rL1xq/bcQNwQ8HZ1GuZaiz/q0/fTbXnxIk74hD/+kabxhRrdnQYkB/8pLY7EvOdkNkVdooIborqK0tbVNHsVFrpGsp84FEowudiRzUtwXtk59nqlsTuQ88mUH+RoNWqX27KGDFRrZLUPh+RlcNfKv4EmefLPedFpPuhlYIXPztH6tDvPUL4X4K2GAqKMx/WCOjj4NA0KeZavo6R0SIJy5jFYjMqcTuKMC/LhBMhlUn4eYH350OpU0dsM2O5Px3zxLBdaQndc+WycNE7ROAYQWxLowqFtdqR6WM4Xec7paA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkFFSY1J8eroyOVNdYg1NZhE2HwZKkEzflM9dggQ5ug=;
 b=E9pkMTdbmJFLhcgbUG8RUG5AprqVyYS3PVnVBuLFBaYoLzfOAR+3a+zR56kVaMOXz61rBNKysH0nBrUJl4cPRsaXIrW01kQPckvLfDU1Y03N4D+08Ad9aKkOEbdswHPprM/8bN/gVYCbXUfkCGC9rgWrxlfp8Vg0s0AWdgEz9+gt7LadJdi82gvreaXhIjbW/RH19sL7aj+TAdevO6wcoB3IxRYoItmqWI27afNe4NNH6/VwKhD1Pp21NSfxWU47u/mF13vOsZtKZEo+WuaWHp6cdIpeqzPF9GCGfJEWNM1qbHNyopXR3WsnqGb/F13nwWBTLAOu6wfCYlGJl61H/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkFFSY1J8eroyOVNdYg1NZhE2HwZKkEzflM9dggQ5ug=;
 b=XnUlWNWfmbhenYFWEfPw2Jw5HNFJAaOl29v7O66hq5qjRoWa6iDVmos8RDa5CLk91sjbUBnWxVijxSIww5aENxrl72dVhpPwkENBYcdbOTCweUHvtDxOvD8aeT39pFyvH/IKl+6wuOs3IzYHvVEBhxuwJIcap9+OMZqFsC19nHA=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 18:30:03 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 18:30:03 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Keith Busch <kbusch@kernel.org>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, "Liang, Prike" <Prike.Liang@amd.com>, 
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "axboe@fb.com"
 <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Thread-Topic: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Thread-Index: AQHXS40NYCAeCNVqrkmuKdHrguQgGqrrVkGAgACdf4CAAKfzAIAABtkwgAALSoCAAAbUsA==
Date: Thu, 20 May 2021 18:30:03 +0000
Message-ID: <MN2PR12MB4488F011F9B018C9B52A862CF72A9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <BYAPR12MB3238055D4B08CC91D9ABFD39FB2A9@BYAPR12MB3238.namprd12.prod.outlook.com>
 <20210520165848.GA324094@bjorn-Precision-5520>
 <MN2PR12MB4488F16CE50BFD4E1F453CFAF72A9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20210520180343.GA3783@C02WT3WMHTD6>
In-Reply-To: <20210520180343.GA3783@C02WT3WMHTD6>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Mario.Limonciello@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-20T18:30:01Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=46886c5d-354d-46d5-a86f-5cde5ed65eaa;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.10.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea5e5d6c-ecf4-49f0-d3a3-08d91bbd490e
x-ms-traffictypediagnostic: BL0PR12MB2401:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24016DA1ECABF284335FCFABF72A9@BL0PR12MB2401.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZaM5lCzxatmdh38P4DM6MQaC8mX3B73arzo+U/YBIW9EPpR6JAOPNOrKdZyhe1/5E34yR0/UF8ywst5690w+fkkWVLLYGhykiqlZ9TyJpEL6Rbe4FrH3OqSkvD3yVXIe+Nd/Neyr/rkNltc6o6FEsYqTObMldM3GgUCYMP7pnVlo8K1is8o9XZCDR/K/Avzg55SJDSSS+asx4SLGGyk9vpQF8+B4F7WcELyvM4vVx5Z3qdivpgigElmsGrH2vm8un9Fr2eyn/vHo5ObDTbyU1NdY6VViVVxalzmNlXa9Tk0ttNKTE81PsV+/P2ki9ewQvUq20QzllKKXTt1DDF1yKeRivF8GyIQXD+kAXMWvrgGCIDb8a5M/Bv4+bMujPff37G0dsYc1E2Na+JSwHI7P1UgHNSZkS/jDugZiwOd2O/k/GEsCAdqYuLh0z7+c0jjMMwls/dFUdzp5UFW0iAlGSIkTEMh87OucFxIGRfL1+Z9UTw9NEZhxqdMZyl0+d40U6tr1pIjp9G4RSES9dkNIHmdlru5Zfb1E9j6AlVa+oQcRNdhEar5Bm1kyyjbPrzWE8RtK4GS5yXRLCR/6J6ZCnWzt7fvLuUjTvIexBQG3r4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39840400004)(136003)(366004)(4326008)(86362001)(83380400001)(316002)(110136005)(8676002)(66556008)(66476007)(64756008)(66446008)(52536014)(8936002)(54906003)(71200400001)(26005)(122000001)(7416002)(38100700002)(55016002)(7696005)(6636002)(2906002)(66946007)(6506007)(5660300002)(186003)(478600001)(33656002)(76116006)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TrTx4SKwWJUdRTZqdgRvR4IAxPRoxKuJK541b/yOXHDErNXrwXzCMdcfrH5E?=
 =?us-ascii?Q?JPBOQIXeyCshnXrR3/vOZf5k0LFaBO71HXLdRRiVPFRhDivrz1gBLIPnuy0u?=
 =?us-ascii?Q?lv1j5mcO2Gdyi4BXcksVxqhexpd6fo+u0jfylsPFIQIZTF3zPT01v3UmJEQ/?=
 =?us-ascii?Q?amt4Z10N8wr/5//1cpLXT7PU9EMPbfYYAzjuvG1TqAGDfMFCf5AibyO56EZC?=
 =?us-ascii?Q?iKOFxBKOlQqFjZiyP63NqWgapa553Eot+IDfIJp9KnsMr6lKowmXAqSKyRDo?=
 =?us-ascii?Q?IWqPqJnmIUE9yaIMNvbD7rlEkc/9Mx/+Ny64SQ2OIUZz/HYeTYXscmbBitkt?=
 =?us-ascii?Q?j44hkUl4z/B9jrfhl6ea2OIYlQe1ExX1q+Mo03T36pHPCX4pzflYG6T+K1WE?=
 =?us-ascii?Q?BIgeqLERgXkwoSAhLSGaoEIRx8LgEarmUHxHGXhu8VO4rui8biO2tJXdu/uE?=
 =?us-ascii?Q?9D0huAEXh0gaDYDVx4IQFOHuQ89FCkx3vkq5A+uddXnxoCNnlx7yeDo/Xfb2?=
 =?us-ascii?Q?Tloxs7JFQAn4JZqaenApiCNV+DrkWqmU3KamsdwzBlnMBJnv4rE7JyiIDaML?=
 =?us-ascii?Q?X7TE8l5TDOc3c8bTxjOTTIvx6xQVe8OyWDujGXeV4Umi7OsEzwvrAnWt1j5s?=
 =?us-ascii?Q?ZCGF8jXTOMDOOlMumHXx/RRGLfMBUpQZDe1cJvK0w0dPSX2i7TwpZpCWScQi?=
 =?us-ascii?Q?MooKMMK87zM33QjTln9tJnmwPpVnJ1cdRRXNrIHd2JaosT38othpacbcqASi?=
 =?us-ascii?Q?3gJ6rE/OsiESrMbk0fOuKFWOpzX8pq6SVLbDf3SSZ0Y/LcmXjxGgFoE8RsWr?=
 =?us-ascii?Q?xWCuM/nveUbOeGTRrK5KZJUA4BoqzSwzLBnJEeIhKiFlHkCf1Ap8qM9lOotJ?=
 =?us-ascii?Q?A6AiYBe9MjjzMlK4G6/cPUZmvuZkTYdSSCgwa2f+gY4b3qxnaog88XSP5vLp?=
 =?us-ascii?Q?s3vjTwwOC6fX5Tnc2wRy7m0Y4oDfcNkGV2jIxNwkee93dq5gLQ8OdICliuz4?=
 =?us-ascii?Q?8I8hPaMI2RD0pAW0rJlY0y1vDdTBs9/Hv4zjMMU1peoz7xZuuTwCYUblEaVG?=
 =?us-ascii?Q?fpcRFVH5X5U+8nniYkZKc+8DDNHRfBAH/cr+fL/c7JXw9HY074wNwcvJaDUV?=
 =?us-ascii?Q?t5RseFi+k3UDDiM65a3jztbbZGEpPIp39wNyTtyBcFcnP6EeYq079Nv/v5dK?=
 =?us-ascii?Q?vyTUVvxZYzgiQpMk9GuVJSoan0XJCkEgm4/gvs8gUU7M2hOkSzaYzgWh0GxE?=
 =?us-ascii?Q?Lw266nM/EKgo9uI8AgeJmbaicugYvj2bTs5QTBiF2KHAp1IylCsLMJY30BXq?=
 =?us-ascii?Q?4a21vINy8wB3v+11IJyTQ9WY?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5e5d6c-ecf4-49f0-d3a3-08d91bbd490e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 18:30:03.5504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbjXJ2KZtIg0EqHL9Jdtx5mR2I/mZgoqyOuaMFIwfN/zH7sqHDd5TSuUkDwlGDRtow42R5Pcc0aZGavpIuuvOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2401
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_113007_848159_56B0780A 
X-CRM114-Status: GOOD (  19.19  )
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
> From: Keith Busch <kbusch@kernel.org>
> Sent: Thursday, May 20, 2021 2:04 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>; Liang, Prike
> <Prike.Liang@amd.com>; linux-pci@vger.kernel.org; axboe@fb.com;
> hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org;
> stable@vger.kernel.org; S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>;
> Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>; Rafael J. Wysocki
> <rjw@rjwysocki.net>; linux-pm@vger.kernel.org
> Subject: Re: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
> 
> On Thu, May 20, 2021 at 05:40:54PM +0000, Deucher, Alexander wrote:
> > It doesn't really have anything to do with PCI.  The PCI link is just
> > a proxy for specific AMD platforms.  It's platform firmware behavior
> > we are catering to.  This was originally posted as an nvme quirk, but
> > during the review it was recommended to move the quirk into PCI
> > because the quirk is not specific a particular NVMe device, but rather
> > a set of AMD platforms.  Lots of other platforms seems to do similar
> > things in the nvme driver based on ACPI or DMI flags, etc.  On our
> > hardware this nvme flag is required for all cezanne and renoir platforms.
> 
> The quirk was initially presented as specific to the pci root. Does it make
> more sense for nvme to recognize the limitation from querying a different
> platform component instead of the pci bus?

Maybe.  I'm not sure what the best way to tie this to a specific platform is.  @Limonciello, Mario?

Alex

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
