Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C23C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 23:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wiDQAyAaS7vUI/941wjW+lu1PHQdWfToyTAfLXbDuZo=; b=nfFlKQK9UNTNIF2dfjrYLUn+19
	w+NASRaxJA9KGvYLNPXzWnbO2LCT6JxnA4KwxpED+hzJmYFcexm2frTmT3B56rIsxiYjaXjH0EdkL
	k7iLDSuaaMwvigN+/uNpB8p5hFLXKcq1cMgjgfSLAd+GXusAu4+iOCCpbNeWKzU3uh9+o8738VvnR
	jkt5b98NPC7T2RMpvxRfkhDrArVU1J4jB62rdVBf0QGGMEADi6avfojHtxvL+JpJKM07oGlgk3zXo
	X8Fy3v9UCwhJgjrL/3j30yYV8RcYMQnTG9fQcULjFZEbrUGDVNGpUsafELIZlwgGkrVJmTgNUV0pI
	wKWVdbKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDaGf-003jg8-J0; Fri, 28 Jan 2022 23:02:57 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDaGb-003jfN-CA
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 23:02:55 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20SMmBSF014304;
 Fri, 28 Jan 2022 18:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=wiDQAyAaS7vUI/941wjW+lu1PHQdWfToyTAfLXbDuZo=;
 b=H5gLjuIGSChEwwqQVfQTjhh0EzvozSZO/aBNAfclH7B2MxrWOn7zsD+ykdHbldCHvAH9
 Ka9C6pCUrQArA5h3QQMNeE9qfEhkaHMFE6jA5bACZHhDkAGWDr8vtkmLOC80zO8Eby56
 rzsfiSzZnL0QYSnsZa0SLF8EsIbNAJI3bgrgENO9sZoEqnoopyFrck2wv/seZbMd4IRm
 +/+7/sj52OYgvyJ6I0aCE/O37nFCOKAILHkuOfZNGQ3p685xoSTceqZbk58d8LZW2+Ss
 FIrg5kWOUN0dcSMMEDVUOKpES8xEaS5JGeug3Z2CKBZpQ/iRv36g3XDX7th2Gcef+Dxf Ug== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3dv3xtd48v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Jan 2022 18:02:26 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 20SN0MCc031463; Fri, 28 Jan 2022 18:02:26 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
 by mx0b-00154901.pphosted.com with ESMTP id 3dvatw4wn2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Jan 2022 18:02:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkLuARFddrlupugkfElM7EqhpymY879kPS9awB6BOl6/RF4WqLNEFke4iVbg2MLT6kQFFQ2HgTTjFabWIEegY2vtUmhxJpIoAozOMav5zT9o8MqWn/IO5P66drej8Y/aM5psCYRP4yT2CQGJybTPvY2eajQ4HZ+TdM3vADlJCULeJVAt0m4SmQ1ahexoukt94NK/GSAMdWFVx8HmdNvdfkHEKcbSYY/FNpNhuSYw9rq48rfZLKMnv4JQm6qLd/vGIB1Mxm6TsmDaxtBLsUOoQYegN7p/vVdUPuw2jj0Mx/O7BMlTwM5U805ddbFqdkUApN3WXwBX3HUZSWB62244wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiDQAyAaS7vUI/941wjW+lu1PHQdWfToyTAfLXbDuZo=;
 b=ZCyA/23FbOY1VKN7xSDNt5NCjXuPRIVmbtr+vC7jrpBFft13AjPYtB70ouz/gmwppjC7y7Y4n6+LspmJi+Av08AIILJR/v2AevsIyP1NLtlq4t8mGFxjFCgauElkPEm/X9kL34E5D5CMT1zH9zv0xIsd746qrHw7NsfKKBp9FDj5Sg9t+BPF2y32Vtlx2cC386fVRwA8JD3rL4V1KeH/gY7yrIj99QT905Zt8VbWrowGhkM5IaMua3xy/5LmT41nxOVoFbvLkPQI4apaELtEKovKNChH0ntzPj7AFNYu3ClsH94wUWGzZ2YX09fo1uVUXM23iIjmlQ6i+g7LwN2LMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BY5PR19MB3761.namprd19.prod.outlook.com (2603:10b6:a03:21a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 23:02:24 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::f01b:bbd8:4187:36b3]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::f01b:bbd8:4187:36b3%6]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 23:02:24 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Martin
 Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH 3/4] nvme-fabrics: add tp8010 support
Thread-Topic: [PATCH 3/4] nvme-fabrics: add tp8010 support
Thread-Index: AQHYEfxP/F7s1ilTfEGG+nDhesZTRKx2nSQAgAA92YCAAALhIIAAkHMAgAFJADCAAEaUgIAAEf4Q
Date: Fri, 28 Jan 2022 23:02:24 +0000
Message-ID: <SJ0PR19MB45440F98F8693F571669C012F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <1ee5410f-3af6-8ca7-a860-e3fc1bc49a0e@suse.de>
 <92c36bc0-9489-ebc1-3176-fb215ccc8646@grimberg.me>
 <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <12b4824b-f704-fe25-5511-012dfcdaf514@grimberg.me>
 <SJ0PR19MB4544136C4622118DBCEBFFA1F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <37587400-076b-059f-f163-fd90babde443@suse.de>
In-Reply-To: <37587400-076b-059f-f163-fd90babde443@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-01-28T23:02:22Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=e6a0e7da-b05d-480f-a5a5-74a2e6fa1963;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cabce82-15e4-4832-dcb4-08d9e2b23f59
x-ms-traffictypediagnostic: BY5PR19MB3761:EE_
x-microsoft-antispam-prvs: <BY5PR19MB3761014D6685EB64079F1FEAF2229@BY5PR19MB3761.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iq35xcgLFkBcEwSjy37L2kKStvuNwmAiNV9xo2lMH8pzVFoqhQYSSIrUx3oLmbNL+Zn6PcVnAQkGtSF+J/PpjIBR6T24rqUOEmWaSg/6N34QR5W+kpGQD9X5oJsmwj/yb/KrvmBWrsexE0Gp2+q1j3YDk+srCjGu7BiDviJLM+EE4wZiN57Ob7pF8xtcvTS4tfL5cseWmki9u9bq6a3BuG1bEjDBl+KWAkcxcPLALfL7Yn5pApRrK+2Y0ulsDQgH1VCaUMiykb1KtY2+9L6PgTN3rYDmdgWIsjdszLb918imdoSOmdQDgHI7jUfcToKMa1AhkR9geVeZy6iV5uRQZyA5AglR7ixaJ3wequNo5p6tuFGs2TQOhdqSjZZiLA2j2QLu3drX025sPi1oRgoN9kxRjhp6aArppNWOeWKY/vMsMBYgsoZTxXjBBCZDINkMvI0j+aH8/1xmMpiT2aCSLF21G6XyxVDuPYFonPxELarnaGBMEfpYITRcwggALuMDOWBadRsQCtYeEV8/SbpLH8mDiKS274cjOY6Rsfa961gR+hc2p8XZRH1D7cNR/ktIA0nw4GArfRwRfoUMr91plbu7Ud0cAH/FK/bxypBXp1v7R0RiaDxj3Gl4HHyV1CdIyrPho3Rra0mAR/5zz+TMmgto43VEra/KAOBhs19J5BFURMZx/GP+nKTuKH8k6azgYs2zl5MVEPl6QAbHU7tLwA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(71200400001)(6506007)(53546011)(508600001)(66946007)(4326008)(64756008)(66446008)(83380400001)(66556008)(66476007)(122000001)(76116006)(5660300002)(7696005)(52536014)(8936002)(8676002)(86362001)(54906003)(55016003)(66574015)(26005)(110136005)(786003)(82960400001)(316002)(38070700005)(33656002)(186003)(2906002)(38100700002)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UktuM0JRalkxWnUwdTI0VWVjWjFuNlA0Q1VNM0p6TDBybFZnZ3RyUnFvYlp1?=
 =?utf-8?B?c0phRFl3RXozZEdKZHFVSmxaVU84SmtpRlBnWjhHVllsbGlRaHhKZWRKMFhW?=
 =?utf-8?B?cTVxVU02dGdmUURORjRZekN2WUtOMmV1ZUJXemdJaGY4aFBjbEJRRlZYT2Rl?=
 =?utf-8?B?c2lybmNjYVN4aXhuTlNlK2ViWFltbS9zODZvZk93V2RsOGhkblVmUFVCTloy?=
 =?utf-8?B?T0FjR25MTUhwYUhsZjdwb0hUd1U2bDlSWnNLZlcyZDlLQU5ibGpOWnkxUkdn?=
 =?utf-8?B?TDhka0FUeGxvNkE2RmNsbFdYV3NYOFQ0MlI4L3hJSXZpUW5yN2Iwc2lqcmtv?=
 =?utf-8?B?L1RCRWlFZnAxd0l1SDVvSUpJZEpwSW02bGdRQ2kyK01yWHY2blp0WEk1MitS?=
 =?utf-8?B?d0NMOTgzMnJnWXlQYnlpT283OWpxMFNQOWIydEdnSGFyYWUrTkY1bml2dTVL?=
 =?utf-8?B?cFllOVZmR3AvOEFuZXZuUk1aTHNKMTdSeDFzdXQrVG9MTldiNHd6L1FPU0Nv?=
 =?utf-8?B?a0JmWXZCcllSWnVEMVpuZGNZNFlXbENUbmhEVkJ4cHdtMndtZUpFVUdXdXJK?=
 =?utf-8?B?djNPSFRmMXNTa1lDTXVjdzFqUWMwUTV5KzBIU0N3Q1VRcTVjZjFCWVVRNk0z?=
 =?utf-8?B?T24zTDNmbHgrczFjZENUUWR6V3hLZFpFbVVnVWxCNUEyZXFEamNVTTZzRFZl?=
 =?utf-8?B?MUt5c1d4WEJyR0g5OWo4WVFoa0JoTkpnWXBCNFZ5MlI1WnZFT2NnS25OQTlN?=
 =?utf-8?B?UStQZlpPcStQeTBnRmd4N1JvcHJDdVJrbkgzUkdZTUFUMXpPQWpDMDdkeTls?=
 =?utf-8?B?T0x4S2l1NDliZFRrbkhYTm1SZi94dWYxYUN1SnU2akJ0VmQ1Sko5QTlVUUpY?=
 =?utf-8?B?Y0NDeTIyVmQwV3lMbU1QY09qK0kyUXAweEJKdm11bU53VzgvWmxHRk1sUVBw?=
 =?utf-8?B?MTdLRXYrZldTNzU5QUtIMHJEN3Z6TEhaSFI3amVYUWRkNkVIenMxeXR0d29R?=
 =?utf-8?B?VWV6Z1UwTlk0U2V1dERjcXM3K2JldEpXeTdmMVkwMlJkTEo0aGU0QjVmekl1?=
 =?utf-8?B?OTdKdWJ6dS9kSjBrZm5FRE51NnVFM3lyTnJhZUQzR3ROSXhmeEdHaWJ2Sng2?=
 =?utf-8?B?cDcwODV5WHp4WnQwU1IzMlV3ellNZzl3TkZSM2NiazJGa1FtdGdNV2MyOXBr?=
 =?utf-8?B?WjllYys2Mk9hSFc2S3RpdVc2QTFKWkpoNmZMR0lib25jZGJmNjBmc0ZaTFd0?=
 =?utf-8?B?QlNuSXJUNUp0RVh5V01seE1NdFpSSlVDd0VqMVRBNnFHU2hiYjl6Y3l6aFRp?=
 =?utf-8?B?UVcxRUM5TjFIUlM3Z0tDaTdnbG9iK0hLcUp2eEt1UjQ0aGdJQlQ1cHYyVzZC?=
 =?utf-8?B?Ukx1azYyZmNtUWpnTmFiUlNFeVEzZnhTOTR0N0VPVEJVak9YTTdOZGNhdktY?=
 =?utf-8?B?VVJNZzU3WW5ueTQzSFcvaWFOdm9UM0Nhdm13Qk1MYVo0ZGlsN2hjZWxNYmVJ?=
 =?utf-8?B?K3M3UlVBSHVaT2dRZnkrZjU3SU1nb2FjdXN4TmdOWVFtaGJrczhQbXNOY3Z1?=
 =?utf-8?B?NXNibHBUam1zaHVoNEp1RGZtYXdGL0xNR1FsWjlpTnF0SUdXTyt5ZStQazR3?=
 =?utf-8?B?ekh1d0hJMGVkWW1tWDdQbm94RUtzZVJEbnVvdkxZTmRoWWUwUkxHVUhRV05W?=
 =?utf-8?B?UldVeUlYWDRyUFN3UzVETDdXekp5TUFZK0NpaTA1Z0JFd3RKSW4zaktwanJU?=
 =?utf-8?B?a3pYTnpoSk1uY1pKMS9wUWdwY1RkN2I1Mkpjb1RIMjU3dTJlamRISllPbmNZ?=
 =?utf-8?B?S2RvWWZWWWpoc2h5cFBpUmxCL3ZXdGJXQ0haVGo1OWJBS1Z3U2tEeUE1QXYv?=
 =?utf-8?B?KzdKVmFCa2RHZlNBZFZIczdFY0h2Q29EdGR2TnV0L2NRM1Ftblg1NURTZ3NZ?=
 =?utf-8?B?WVRoVmNxZ3E3ZHFHVnVSUVdGUEJsck5aVzhHL3U1cktnOUhTVWJWOCszWGlq?=
 =?utf-8?B?emE5Y0EzMW0yT3RTTzEzdVVjbFBlWEtXQzkvbDNNellCbUxQY1NaZ294dlBa?=
 =?utf-8?B?cEtRL0RFeks0UWk3SjNjTUIwYk94d3UxNmZCYmNFTlA1Z1NNZ0pwZkdCZVRC?=
 =?utf-8?B?bjRzS1N5L3AwaUdRbTV1Q2diVFVwUTZKbW9ydU4weEtFT3VQcVpZYUQ4WVc5?=
 =?utf-8?B?T2FQdWErc2V6bEMzTTRrQlpJcTZSQUswSEtjUUNSYVIvd2QrY2VLdWkzdlNa?=
 =?utf-8?B?OUg2SmJ3NDlrWlcyWGtINEFjWUV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cabce82-15e4-4832-dcb4-08d9e2b23f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 23:02:24.3764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bj/3VQeKTvVJVL3YTbgp7fuJIL09f7z97fSmcjc+iSOjlIy2VNAvtaRNOCEds5EYL8hftp9rWJ+eeEtsJ9dbOQ8NJVAAfGrU7bJGWOQQYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3761
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.816
 definitions=2022-01-28_08:2022-01-28,
 2022-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=816
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201280127
X-Proofpoint-GUID: kvHx9DOqf7bkRh10k2DhTJAn2u0YAjPG
X-Proofpoint-ORIG-GUID: kvHx9DOqf7bkRh10k2DhTJAn2u0YAjPG
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=907
 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_150253_629062_8508E08E 
X-CRM114-Status: GOOD (  40.06  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQo+IE9uIDEvMjgvMjIgMTg6NTUsIEJlbGFuZ2VyLCBNYXJ0aW4gd3JvdGU6DQo+ID4+Pj4+IFdv
dWxkbid0IGl0IG1ha2UgbW9yZSBzZW5zZSB0byBkZWxlZ2F0ZSBleHBsaWNpdCByZWdpc3RyYXRp
b24gdG8NCj4gPj4+Pj4gdXNlcnNwYWNlIChpZSBsaWJudm1lL252bWUtY2xpKSwgYW5kIGxlYXZl
IHRoZSBrZXJuZWwgb3V0IG9mIGl0Pw0KPiA+Pj4+DQo+ID4+Pj4gSXQgd291bGQuIFRoZXJlIGlz
IG5vIHJlYXNvbiB3aGF0LXNvLWV2ZXIgdG8gcGxhY2UgYWxsIHRoaXMNCj4gPj4+PiByZWdpc3Rl
ciBzdHVmZiBuZWVkcyB0byBsaXZlIGluIHRoZSBrZXJuZWwuIFdlIGhhdmUgYSB3YXkgdG8NCj4g
Pj4+PiBwYXNzdGhydSBjb21tYW5kcyBzbyBpdCBjYW4gYW5kIHNob3VsZCBtb3ZlIHRvIHVzZXJz
cGFjZS4NCj4gPj4+DQo+ID4+PiBJIHdpc2ggaXQgY291bGQgYmUgZGVsZWdhdGVkIHRvIGEgdXNl
ci1zcGFjZSBhcHAsIGFuZCBpbiBmYWN0IHRoYXQNCj4gPj4+IHdhcyBteSBvcmlnaW5hbCBkZXNp
Z24uDQo+ID4+Pg0KPiA+Pj4gVW5mb3J0dW5hdGVseSwgd2hpbGUgdGVzdGluZyBJIHJlYWxpemVk
IHRoYXQgdGhlIGtlcm5lbCBjYW4NCj4gPj4+IGF1dG9ub21vdXNseSByZWNvbm5lY3QgYW5kIHVz
ZXItc3BhY2UgYXBwcyBhcmUgY29tcGxldGVseSB1bmF3YXJlDQo+IG9mIGl0Lg0KPiA+Pj4NCj4g
Pj4+IEZvciBleGFtcGxlLCBsZXQncyBzYXkgdGhlIG5ldHdvcmsgZ29lcyBkb3duIG1vbWVudGFy
aWx5LiBUaGUga2VybmVsDQo+ID4+PiB0aGVuIHRyaWVzIHRvIHJlY29ubmVjdC4gT25jZSBpdCBz
dWNjZXNzZnVsbHkgcmVjb25uZWN0cyBpdCBkb2Vzbid0DQo+ID4+PiB0ZWxsIGFueW9uZSBhYm91
dCBpdC4NCj4gPj4NCj4gPj4gVGhlbiBhZGQgYSB1ZXZlbnQgb24gdGhlIGNvbnRyb2xsZXIgZGV2
aWNlLW5vZGUuIEZyb20gdGhlcmUgeW91DQo+ID4+IHNob3VsZCB0cmFwIGl0IGFuZCBkbyB3aGF0
IHlvdSBuZWVkIChleGFjdGx5IGxpa2UgaG93IGRpc2NvdmVyeSBsb2cNCj4gPj4gY2hhbmdlIGV2
ZW50cyBhcmUgaGFuZGxlZCkuDQo+ID4+DQo+ID4+IEJUVywgSSBhbHNvIGRvbid0IHVuZGVyc3Rh
bmQgd2h5IHRoZSBob3N0IG5lZWRzIHRoaXMgcmVyZWdpc3RyYXRpb24NCj4gPj4gb24gcmVjb25u
ZWN0LCBidXQgdGhhdCBpcyBiZXNpZGVzIHRoZSBwb2ludC4NCj4gPg0KPiA+IFRoZSBmYWN0IGlz
IHRoYXQgd2hlbiBjb25uZWN0aXZpdHkgaXMgbG9zdCBhbmQgcmVzdG9yZWQsIHdlIGRvbuKAmXQg
a25vdw0KPiA+IHdoZXRoZXIgY2hhbmdlcyBoYXZlIG9jY3VycmVkIG9uIHRoZSBob3N0IChlLmcu
IG1heWJlIHRoZSBzeW1ib2xpYw0KPiA+IG5hbWUgd2FzIGNoYW5nZWQgd2hpbGUgY29ubmVjdGl2
aXR5IHdhcyBsb3N0LCBldGMuKSBhbmQgdGh1cw0KPiA+IHJlZ2lzdHJhdGlvbiBtdXN0IGJlIHJl
YXBwbGllZCBldmVyeSB0aW1lIHRoZSBob3N0IHJlY29ubmVjdHMgdG8gbWFrZQ0KPiA+IHN1cmUg
dGhlcmUgaXMgbm8gc3RhbGUgaW5mb3JtYXRpb24gYXQgdGhlIGRpc2NvdmVyeSBjb250cm9sbGVy
Lg0KPiA+DQo+ID4+DQo+ID4+PiBCdXQgbGV0J3Mgc2F5IHRoZSBrZXJuZWwgZG9lcyBzZW5kIGEg
c2lnbmFsIHRvIHVzZXItc3BhY2Ugb24gYSByZWNvbm5lY3QuDQo+ID4+PiBXaGF0IGlmIHRoZXJl
IGlzIG5vIHVzZXItc3BhY2UgYXBwIHRvIHJlY2VpdmUgdGhpcyBzaWduYWw/IEknbQ0KPiA+Pj4g
dGhpbmtpbmcgb2YgdGhlIGNhc2Ugd2hlcmUgb25lIHVzZXMgbnZtZS1jbGkgdG8gc2V0IHVwIHBl
cnNpc3RlbnQNCj4gPj4+IGNvbm5lY3Rpb25zIHRvIGRpc2NvdmVyeSBjb250cm9sbGVycy4gIElu
IHRoYXQgY2FzZSB0aGVyZSBpcyBubyBhcHANCj4gPj4+IHRvIHNlbmQgdGhlIGV4cGxpY2l0IHJl
Z2lzdHJhdGlvbiBvbiBhIHJlLWNvbm5lY3QuDQo+ID4+DQo+ID4+IFRoaXMgYXJndW1lbnQgZG9l
cyBub3QganVzdGlmeSBhZGRpbmcgZnVuY3Rpb25hbGl0eSBpbiB0aGUga2VybmVsDQo+ID4+IHRo
YXQgZG9lc24ndCBiZWxvbmcgdGhlcmUuIElmIHdlIHdlcmUgdG8gZm9sbG93IHRoaXMgYXJndW1l
bnQgd2UNCj4gPj4gd291bGQgYmUgcGxhY2luZyBldmVyeXRoaW5nIGluIHRoZSBrZXJuZWwuIElm
IHNvbWVvbmUgd2FudHMgdGhpcw0KPiA+PiBmdW5jdGlvbmFsaXR5LCBoZS9zaGUgbmVlZHMgdG8g
dXNlIHRoZSB0b29scyByZXF1aXJlZCBmb3IgaXQgdG8gd29yay4NCj4gPg0KPiA+IE9rLCBIYW5u
ZXMsIFNhZ2ksIENocmlzdG9waCwgZXQgYWwuIEkgZ290IHRoZSBtZXNzYWdlIGxvdWQgYW5kIGNs
ZWFyLg0KPiA+IEV4cGxpY2l0IFJlZ2lzdHJhdGlvbiBkb2VzIG5vdCBiZWxvbmcgaW4gdGhlIGtl
cm5lbC4gQW5kLCBhcyB5b3UNCj4gPiBzdWdnZXN0ZWQsIHRoZSBrZXJuZWwgbmVlZHMgdG8gc2Vu
ZCBhIHVldmVudCB3aGVuIGl0IGxvc2VzDQo+ID4gY29ubmVjdGl2aXR5IGFuZCBhbm90aGVyIHVl
dmVudCB3aGVuIGNvbm5lY3Rpdml0eSBpcyByZXN0b3JlZC4gVGhpcw0KPiA+IHdpbGwgYWxsb3cg
dXNlcnNwYWNlIGFwcGxpY2F0aW9ucyBrbm93IHdoZW4gdG8gcmVhcHBseSByZWdpc3RyYXRpb24g
KGlmDQo+IG5lZWRlZCkuDQo+ID4NCj4gPiBJJ20gbm90IGEgdWV2ZW50IGV4cGVydCAoYXQgbGVh
c3QgaG93IHRvIHNlbmQgdWV2ZW50cyBmcm9tIHRoZSBrZXJuZWwpLg0KPiA+ICBGcm9tIHdoYXQg
SSByZWFkLCB0aGVyZSdzIG9ubHkgYSBsaW1pdGVkIHNldCBvZiB1ZXZlbnRzIGRlZmluZWQgKGku
ZS4NCj4gPiBhZGQsIHJlbW92ZSwgbW92ZSwgb25saW5lLCBvZmZsaW5lKS4gVGhlIG52bWUgZHJp
dmVyIGFscmVhZHkgdXNlcyB0aGUNCj4gPiB1ZXZlbnRzICJhZGQiICBhbmQgInJlbW92ZSIgd2hl
biBudm1lIGRldmljZXMgYXJlICJjcmVhdGVkIiBhbmQNCj4gPiAiZGVsZXRlZCIgcmVzcGVjdGl2
ZWx5IC4gV2UgYWxzbyBoYXZlICB0aGUgImNoYW5nZSIgZXZlbnQgdGhhdCBpcyB1c2VkDQo+ID4g
d2hlbiB0aGVyZSdzIGEgY2hhbmdlIGluIHRoZSBMb2cgUGFnZXMuIE1heSBJIHN1Z2dlc3QgdGhh
dCB3ZSB1c2UgdGhlDQo+ID4gIm9mZmxpbmUiIGFuZCAib25saW5lIiBldmVudHMgd2hlbiBjb25u
ZWN0aXZpdHkgaXMgImxvc3QiIGFuZCAicmVzdG9yZWQiDQo+ID4gcmVzcGVjdGl2ZWx5PyBQbGVh
c2UgbGV0IG1lIGtub3cuDQo+ID4NCj4gDQo+IEkgZ3Vlc3Mgd2UgYWxyZWFkeSBoYXZlIHRoYXQ7
IGNmIGNvbW1pdCBmNmYwOWMxNWE3NjcgKCJudm1lOiBnZW5lcmF0ZQ0KPiB1ZXZlbnQgb25jZSBh
IG11bHRpcGF0aCBuYW1lc3BhY2UgaXMgb3BlcmF0aW9uYWwgYWdhaW4iKS4NCj4gDQo+IFdoZW4g
bXVsdGlwYXRoIGlzIGFjdGl2YXRlZCAoYW5kIEkgZ3Vlc3MgdGhhdCB3aWxsIGJlIGZvciBudm1l
LXRjcCkgeW91IHdpbGwNCj4gcmVjZWl2ZSBhICdjaGFuZ2UnIHVldmVudCB3aGVuZXZlciBhIHBh
dGggZ2V0cyByZWluc3RhdGVkLg0KPiANCj4gU28gdGhhdCB3aWxsIGJlIHRoZSB0aW1lIHdoZW4g
YW4gZXhwbGljaXQgcmVnaXN0cmF0aW9uIHdpbGwgbmVlZCB0byBiZSByZWFwcGxpZWQuDQo+IA0K
DQpKdXN0IHdhbnQgdG8gbWFrZSBzdXJlIEkgdW5kZXJzdGFuZC4gV2hlbiB0aGUgY29ubmVjdGlv
biBpcyBsb3N0IHRoZSBrZXJuZWwgDQpzZW5kcyBub3RoaW5nLiBXaGVuIHRoZSBjb25uZWN0aW9u
IGlzIHJlc3RvcmVkIHRoZSBrZXJuZWwgc2VuZHMgYSAiY2hhbmdlIiANCnVldmVudC4gQW5kIHdo
ZW4gdGhlIExvZyBQYWdlcyBoYXZlIGNoYW5nZWQgdGhlIGtlcm5lbCBhbHNvIHNlbmRzIGEgImNo
YW5nZSIgDQp1ZXZlbnQuDQoNCkl0IHdvdWxkIGJlIG5pY2UgdG8gaGF2ZSBkaWZmZXJlbnQgZXZl
bnRzIGJlY2F1c2UgaWYgd2UgdXNlIHRoZSAiY2hhbmdlIg0KdWV2ZW50IGZvciBib3RoICJsb2cg
cGFnZXMgaGF2ZSBjaGFuZ2VkIiBhbmQgImNvbm5lY3Rpb24gaGFzIGJlZW4gDQpyZXN0b3JlZCIs
IHRoZW4gdGhlIHVzZXItc3BhY2UgYXBwIHdpbGwgaGF2ZSB0byBzZW5kIGJvdGggYW4gImV4cGxp
Y2l0IA0KcmVnaXN0cmF0aW9uIiBhbmQgYSAiZ2V0IGxvZyBwYWdlIiB3aGVuZXZlciBpdCByZWNl
aXZlcyBhICJjaGFuZ2UiIHVldmVudC4NCkl0IHdvbuKAmXQgYmUgYWJsZSB0byB0ZWxsIHdoYXQg
dGhhdCAiY2hhbmdlIiB1ZXZlbnQgaXMgZm9yLg0KDQpJcyB0aGF0IHdoYXQgeW91IHdhbnQgbWUg
dG8gZG8/DQoNClJlZ2FyZHMsDQpNYXJ0aW4NCg0KPiBDaGVlcnMsDQo+IA0KPiBIYW5uZXMNCj4g
LS0NCj4gRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBB
cmNoaXRlY3QNCj4gaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5
IDkxMSA3NDA1MyA2ODgNCj4gU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0
ci4gNSwgOTA0MDkgTsO8cm5iZXJnIEhSQiAzNjgwOQ0KPiAoQUcgTsO8cm5iZXJnKSwgR2VzY2jD
pGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcg0KDQpJbnRlcm5hbCBVc2UgLSBDb25maWRl
bnRpYWwNCg==

