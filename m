Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0972C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 15:28:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9AC60235
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 15:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9AC60235
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KNm/sr1n71IfJchRMRh3nsgY4qAjdFqORASusWrvRyQ=; b=GcHPhdlCRwyYiNUocz+MJoUb+c
	88PZ/wLm2AudvHthjrm+PQT+sUBgocCVnXwTe9ZLz/qA/eohz1PxmRFcXIRHPADM7nJbewhl6dOsW
	KT2UWfubsyChbOtdc2qDyeQ+pvbwfGsdsVuy/zfFxw+xc/YbC5GEhmgGtdfoDcMuhWOIV8wkkvuqB
	whZkirIzPirkToLxLDBq6UN15eLRqKahXNfHjhnGa/XVmyZI3E/WWkLHIdF0/HQylS+oRbL49ZDxp
	wVJWbmUDE7+JgSKVl20U9NSww1q50TE58FVzdmKJ2D0MjNYAduuVyNSedJnE/tDPqaJU+cEEEGP1a
	A6vuAE7Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l59DR-0007cU-AO; Thu, 28 Jan 2021 15:28:13 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l59DG-0007YU-Gz
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 15:28:04 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10SFMvfL006654; Thu, 28 Jan 2021 10:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=obhnIc0cweuWF/FfZtND62SFdBFG1A8RpI/dwsysWPU=;
 b=kY3pERfiJW7ggjXvKI0Cx4nDI/ScbJEajQRFv/BwROe4/hwM7zMVY4lv954ChNigYg17
 QSZip6wO8DmlB0f8eDwKdAZs7mOiR+9zYvnk9U77XLJWdCfho6ils0mRqhkdDVJu4dgB
 TVEfVr1NPE9Mz0A3W1obBkbOgH4A1BRZ1lHjpbVAuRXk5TBZ2JEOPZLylRKpwQiJnm3I
 IFTSZug8Th8yiepF35oqJBTDM1TPI7agdZTZBw1hBBqCoYrGAIJtvcYyHQqLOPUSYE7v
 pTNxXizECBYFGd8XGC07iKig2FsOQG4HZ55lJikUJmTFaANLEOBuZBNIE6BE7XJPtTH+ eQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 368fr89cf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Jan 2021 10:27:58 -0500
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10SFL6Xa172588; Thu, 28 Jan 2021 10:27:57 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by mx0b-00154901.pphosted.com with ESMTP id 368ey7nj11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jan 2021 10:27:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaX1qC381NhdJHEHRzRnlE3JxP7RVb/eMaDb4KHwDGeK0+n05Z/Vt1lfl+vJsSGY785xVH2vj9f7ailwQoZ+bdOfGdr8WGyYPb6Ndp8WLWtbszogxlMtwFXJvRpcv4Tzu9DYvLWyVABPcXNS7/5DqnlgkBopEQs+pahg0AXQgN51h5/aBxxTIP8lC05pLbPrtrauNXJLt0xQLGHwymKCWPX3FySAhn98zxo1VHzHc6hm2PC0knKgMldAJlAARt2Ff2/L4eCFhbQ88S3fQZiUqfAdWYeatp2ocTwFxLybESoFUKOo29rsLAe5cfnfXN+J9kLl6JyzIGYusSHk7SVdrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obhnIc0cweuWF/FfZtND62SFdBFG1A8RpI/dwsysWPU=;
 b=XMIAzhhzfxXBnZ3Y99SjvJTjhjfmZjKf5eGUXbmee0RDNZsYlpCKKzaXkJWN2e3Cpav3fZUMcCIixq0bFFtm5h0RTKRxM6K3nNzipQC55wBdejbGibrH8dlkap5IKjRRZwaiWkWRC3DFh6f5or9AFkLoOgRmkbZz4yYd5HCFokZ1L0d2Hum5FXVSwxh7XeyU4drJpgunuSDFkN+Xmx1YhPj+WtbAzN0+xCDmCmAte8+GvWdwmJa4lvty+Txzarl/c96IMCYrv4KysLDXlE59V2rjHRoR8xXFHL6aUrACwjwA9t15W2x2HV0gMTl1YmxZ9dBbhPMhZ6oyvnq/Sazrag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM5PR1901MB2166.namprd19.prod.outlook.com (2603:10b6:4:a1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 15:27:55 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::a416:4c53:4922:67d2%5]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 15:27:55 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
Thread-Topic: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
Thread-Index: AQHW8/k/U3pQBfwXBUmczEPPrx5mS6o8rcwAgAAK5GA=
Date: Thu, 28 Jan 2021 15:27:55 +0000
Message-ID: <DM6PR19MB401119C6C974C85810425C44EFBA9@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210126153757.99451-1-elad.grupi@dell.com>
 <8eead62d-a96b-46b7-fc87-71e599d3d83d@grimberg.me>
In-Reply-To: <8eead62d-a96b-46b7-fc87-71e599d3d83d@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-01-28T15:27:50.1438107Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=0c087c8f-ddf8-418c-89fd-0b95c72a418d;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [152.62.109.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bdaa0a7-170c-4b7a-ee7e-08d8c3a148fc
x-ms-traffictypediagnostic: DM5PR1901MB2166:
x-microsoft-antispam-prvs: <DM5PR1901MB216657B32711F8A6F414477DEFBA9@DM5PR1901MB2166.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QXdYkCCEvzZHvR2uPIGF7zjUlYHK5qQe8UG5KAR529/OYRMInWaHSb6lqrlyNC0hXVB3qA8XGlTG2Jg2R4U4f2SvucuE3XHtpF+yUOelIpkPieWg8oy052hl0EsP31Tdygb47VEqhFI81fjhysn3WYyssCT38hhEWi5ndVzqQRqfciuaXPhqpvJgdhC1R+QEaFBd36CQHlDGqeAiIVb/r9p6XSeHUZ/7HHqzGdg1l+PfYy4Vm2sftRiY0kQI/gvv4x9SlMqNvTLriAIlf63kIiai7yAxJ0G4ebxFQQ0A7zG4nC/dUMqAFj+ubgul+mXnvWm0UiijIQrRiPGaIlsMwfA3jZ9iXKkqj9BoZmbpVnsYbxqRHXoVMWzuC8wc3T45PrYu3nmeBdWUl2m5DNkxkPdJDgpMqjPuMMKNzDEFlX1NZEo4/jP+QyTjKA0K4PPrUHNHHPPdHI2wprxY3asQ6XySPMmd9H8Wfoj+cG5pP2vmoiaXK5G9DlGj70uMikgIyIqFheL2CORhaOGo5FAVUA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(64756008)(26005)(66556008)(66476007)(8676002)(66946007)(5660300002)(316002)(786003)(6506007)(66446008)(76116006)(53546011)(110136005)(83380400001)(186003)(7696005)(9686003)(86362001)(8936002)(71200400001)(2906002)(478600001)(55016002)(33656002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?SmVMalVqY3I5bHIvRHVDRElkdTVBZ1ZtTFg1NS9DNVcxbHl0WlA3U1VsMjlW?=
 =?utf-8?B?UkRDLzhNQnhUb3czdFlLWWVYamNRVXA3eFlPZUVZeEF0UkRjL3F0Y2FWUHdO?=
 =?utf-8?B?WXQvUm1zZENKN1I3REV0NFRmV3BJQWdnVnM1UndQR0V4ZnpNSVRTR3REWFBC?=
 =?utf-8?B?d2VnOTQ4ODRWbTFONzZaSHBraHdPbW1KLzczenNDeUFjSUNZclJzT3VmcDMv?=
 =?utf-8?B?dXJZM2tESktuZnVxaVpScy9LQkZscHRaRjRzNzFvdWVjejVUaytBYXRjT3Np?=
 =?utf-8?B?ZnpRUEZyYUVsL1hUSURpWHdmVVN4b256TncxU0crTmZwamFtZHpNbFJtYm9j?=
 =?utf-8?B?K2p0VGFYMUVUbXhUSGVRSDBOU0drK200UThScDFtSWlYcmZKNzlmSU5aQkxJ?=
 =?utf-8?B?RGhINGpzcitkTGt4Nk5RMExvQk1Ib1JoanNEbkl1bzJUd1dPbldPSGdsdnd1?=
 =?utf-8?B?ditJMWt2OWZvdjE0R3BMSVN6T0V5TUY0MG5aaWZNeFc1M0ZsUWxEN0VGREtp?=
 =?utf-8?B?T1pWZ094eU53bkZ0VUhFUDh5cG9XdlMxQU5YZklBbGM0UXRJZmQyUCtNSWg5?=
 =?utf-8?B?aEFNZHBxbVdoUXJ2TU8yTFhqOVFFWUZXM21tZFJYc09FV3dYeG1KektMd2dR?=
 =?utf-8?B?QTd3cnBKWDdxWVkvMWpqTE1SM1N2QlNEVFB2K0tQNlo3cTBOOVE3STlUSnpz?=
 =?utf-8?B?dVdxOURVcHNlUGRiUU9QdGpXbFBzdEFyNUluOFNOcElCMkJUcHdTY1ZHaDh4?=
 =?utf-8?B?blZJb2xSQWdxbnl4RC9TSE5LaWxnRXRWL3YwZGxFTUtRSDdyZ01JQjduMy83?=
 =?utf-8?B?WG10UituRHBUa0tKeFlzS29yeWJGVklobUk2Qm5BYWdkUGU2Nm1FOWQ4U1FR?=
 =?utf-8?B?N01DM1E0ak5NT2pvbFhnWG16UkVKZlhuSEpWNGhTdWZNc3lSQWhiKzFEUlFZ?=
 =?utf-8?B?ZC9MWmJITkFieU9KZ0wyblJJUlQ0MGxwYXkzNk1lL0JnMlR5N0JTdWtmVFZ1?=
 =?utf-8?B?Wk9oRnBkbG9IbWVTbk1qQ09Jc3hjOEhDVG1wVmtEU0VUaUZYVXY1aExVZUFs?=
 =?utf-8?B?OFh6ZTNodlZvdmJmOEhiaWYvVU9PMUEyV096V0g2YVRoSENSZjlvUWVIbVFC?=
 =?utf-8?B?WkJKbDdIaE5QL2lTbVd2WU5yQ0NDYTJFSU9YK0UzTGRmeTlaYjdyRlRDTlNU?=
 =?utf-8?B?aENWQzNKU3V0RzRLd3A1VFJmZUxtdDNpVS9xbjZFMkVFWjEvM3BLSTNINDVk?=
 =?utf-8?B?bnBpVDI1aWRCeStMWTZ6dTRRbFBwbTVWdVREb2FLNkZMbVBkQkJvWGRmK3hO?=
 =?utf-8?B?TG1UQ0dWNFF6TnVHaU1FbUFGMmtFL0xUSVBTZlFMMUlvY3FaS2xmWjhSc3pG?=
 =?utf-8?B?aEtPRzdQWmR3TXhtWFJqd3F0aEc1OHA5eVE5NUZrUnpRV3dKUlBPY3MzeTZF?=
 =?utf-8?Q?3iu4Go/1?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdaa0a7-170c-4b7a-ee7e-08d8c3a148fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 15:27:55.3745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnEc8CjwijlWoSRgcjDTD+jx73FsBM3klnhgtzWOOJByt8Z4pKBxCrk6XWm9vxQucrHqs7uOaEsXvG1CoJs1+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1901MB2166
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-28_08:2021-01-28,
 2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280079
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280079
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_102802_847467_C3071E5F 
X-CRM114-Status: GOOD (  29.22  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> But we need to call the release_queue work, not sure I understand how this works.

If the tcp socket was closed before setting the socket callback,
nvmet_tcp_set_queue_sock will return -ENOTCONN and everything will be cleared by goto out_destroy_sq.
No need a worker to clean resources in that case and everything is protected by sk_callback_lock.

> io_work is going to run with release_queue_work, because it is also coming from the backend completion. The right way to solve this is to correctly fence them.

> Can you describe the exact race you are referring to?

Correct, the fence already exist in the code, cancel_work_sync is called after nvmet_sq_destroy in release_queue_work. I will remove that part form the patch.

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Thursday, 28 January 2021 9:55
To: Grupi, Elad; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: proper handling of tcp socket closing flows


[EXTERNAL EMAIL] 

> From: Elad Grupi <elad.grupi@dell.com>
> 
> avoid calling nvmet_tcp_release_queue_work if tcp socket was closed 
> before setting the sk callbacks.

But we need to call the release_queue work, not sure I understand how this works.

> 
> prevent io_work from enqueuing while closing the tcp queue to avoid 
> race with nvmet_tcp_release_queue_work.

io_work is going to run with release_queue_work, because it is also coming from the backend completion. The right way to solve this is to correctly fence them.

Can you describe the exact race you are referring to?

> 
> Signed-off-by: Elad Grupi <elad.grupi@dell.com>
> ---
>   drivers/nvme/target/tcp.c | 26 +++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
> index d535080b781f..937f2a746d8b 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -647,7 +647,7 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
>   	struct nvmet_tcp_cmd *cmd = queue->snd_cmd;
>   	int ret = 0;
>   
> -	if (!cmd || queue->state == NVMET_TCP_Q_DISCONNECTING) {
> +	if (!cmd) {
>   		cmd = nvmet_tcp_fetch_cmd(queue);
>   		if (unlikely(!cmd))
>   			return 0;
> @@ -1196,7 +1196,7 @@ static void nvmet_tcp_io_work(struct work_struct *w)
>   	/*
>   	 * We exahusted our budget, requeue our selves
>   	 */
> -	if (pending)
> +	if (pending && queue->state != NVMET_TCP_Q_DISCONNECTING)
>   		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
>   }
>   
> @@ -1453,9 +1453,27 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   	sock->sk->sk_state_change = nvmet_tcp_state_change;
>   	queue->write_space = sock->sk->sk_write_space;
>   	sock->sk->sk_write_space = nvmet_tcp_write_space;
> +
> +	switch (sk->sk_state) {
> +	case TCP_FIN_WAIT1:
> +	case TCP_CLOSE_WAIT:
> +	case TCP_CLOSE:
> +		/* FALLTHRU */
> +		sock->sk->sk_data_ready =  queue->data_ready;
> +		sock->sk->sk_state_change = queue->state_change;
> +		sock->sk->sk_write_space = queue->write_space;
> +		sk->sk_user_data = NULL;
> +		queue->state = NVMET_TCP_Q_DISCONNECTING;
> +		ret = -ENOTCONN;
> +		break;
> +	default:
> +		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
> +		ret = 0;
> +	}
> +
>   	write_unlock_bh(&sock->sk->sk_callback_lock);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port, @@ 
> -1506,8 +1524,6 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   	if (ret)
>   		goto out_destroy_sq;
>   
> -	queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
> -
>   	return 0;
>   out_destroy_sq:
>   	mutex_lock(&nvmet_tcp_queue_mutex);
> 
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
