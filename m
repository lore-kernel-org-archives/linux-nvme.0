Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9630CC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 16:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WcsaikcdsqdWbHQf6JYNRK9cbQwEZZjn7ZoR6uw5Vxw=; b=xUHnfUjkqVdsIBU1mei2PY9VkK
	mcKoF0mfhaqx1rZgNrXdmRvnZ4oWka3ioomeRRs+b4lmQiAqFVM8o74xl73R29AXcooHBiBfS+eIG
	v/mcFLM0Dk/7o6mqQfThY8gIeRphhbxIlIWKHIp6nK44/V1ZS2Eg2qKMXiIpQVwLTeeEHCQs/rdTb
	r13EJ24wWxXHuq9/RA8y02x4fMCuAvW/GYuHmwi5zGm3yhadQVEAcAuDVMgI6HMWqMpEDOSTF9Sxg
	aazLe1XaPoBsH05jDLFo6xXxhMjabFipMUI/vyNmCCKzBxpNngouocsY3kUPxZfWvukh65cjrcjjh
	CzGL6e8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okTFF-00Dp8I-Df; Mon, 17 Oct 2022 16:45:41 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okTFC-00Dp3t-D1
	for linux-nvme@lists.infradead.org; Mon, 17 Oct 2022 16:45:39 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HGdj4u013759;
	Mon, 17 Oct 2022 16:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=WcsaikcdsqdWbHQf6JYNRK9cbQwEZZjn7ZoR6uw5Vxw=;
 b=uzpm4BCmia+lpz+S6epMP5J/f8N/aExS8TfGv0BFYSlqqu0s5HtrjsM/BMJ6LB3iQyA4
 E4KBaGN/FxNJ0eM1WI3lAI3OAcDNPnNu49VwNw7STN4IBf/bgsCTh3D43z0EdR/yL4OV
 TC8CNmBXPDFGUrvk6kORO3IsrWZgXBQf+ZEV1yXQHNI4wVIL/J0/5eIW14pRsED5USmi
 oYeYrvilZnAcSzXxzfPqjGurAqJ2QOl80B3E/K2HAu0KFw1OuzgnFsrYIOabtSDvfQ26
 XhujJ7BKPTkQ4p0mjHoZDopaHaY48wPxs5KymsN3dRtFiZaxYjXvPBvU/B9hwtZf3KPH CQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtcfce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Oct 2022 16:45:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HFBGlV017478;
	Mon, 17 Oct 2022 16:40:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu650nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Oct 2022 16:40:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEnR5YFjQDkVpxnaWK2lrOMtwoGsmTVif5JuqikYQvzOdvT7TxajDf+iNB1+77N0Y6IeUjGu7tUoI9YyBoW/9vpZkeXR/uNSTY6z1AmooTaFXLT8T1UsuRCM5YjQsKMzWXNXYI6e/I1w0rHAi7HYUXOSMhuOSURpP8w3br9HFjyOaJZ/xeVd0LO9UU7jCiZ9lKRV4+ncbNTDGG2MkEWd0cKUR1S84y5cedBte2PRXdXYze4NNX414mFRCnMXAsYq9v36m1KXHNaVR5UIRTZUTOwEo5VdO81c0flBoyuO5xDb+AVIS2siwjevufYGaBFfHfdIqTPhqDJ52iwRwZlm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcsaikcdsqdWbHQf6JYNRK9cbQwEZZjn7ZoR6uw5Vxw=;
 b=ZZQL6ihRFeOx1zB/PQXvHp0cZnEOAQii1PPtxP/rspkh6a+lVnBdicZUZn2rfYXteXcdz3n59vJvlgr6bOa1IfcUKiRUOSmZKtV+NWwxXDK4I2ikxSZPhXKvAK/TU/KzNe9YOtNOJTyNxBFtMFn9xM+6Cb9vKDpU83ufpTuS48rDjuAC3d31VfoZSVCTW1ZOhqI02PyWnhCF6MNBHXNiSTMbQbd5BfCkyuAS9RY2d+tdx/re670HnTkJSd5+x3YoeO+15hgViC2Aai7lQcY6m5wcAjg1xmGq7c3lq8JaLP6wpmkMikpGhVdDjoecXCN4rLm+BllRVFzh6VQuahrrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcsaikcdsqdWbHQf6JYNRK9cbQwEZZjn7ZoR6uw5Vxw=;
 b=cmyPCckfUKmr0mjjCdMUM11oCoAScuXY/gNalIIxrBZ84AMb32A/LX8KGmMNXR2Nbc2AvFiTHb8JY3/jcRAqCcwJcqamzrsyce5GKEOcI7VqRB2OqjAF5AQcls+SiGQbsrT0CJtkowZeQ6DzkuLnRBMzcmTQVs55X3fp4KrXRVc=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by IA0PR10MB6914.namprd10.prod.outlook.com (2603:10b6:208:432::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31; Mon, 17 Oct
 2022 16:40:25 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5073:7685:8742:9ce2]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5073:7685:8742:9ce2%5]) with mapi id 15.20.5676.036; Mon, 17 Oct 2022
 16:40:25 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <dwagner@suse.de>,
        Pankaj Raghav <pankydev8@gmail.com>,
        "open list:NVM EXPRESS DRIVER"
	<linux-nvme@lists.infradead.org>,
        Yi Zhang <yi.zhang@redhat.com>, Tomas
 Bzatek <tbzatek@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Martin
 Petersen <martin.petersen@oracle.com>,
        "gost.dev@samsung.com"
	<gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v1] nvme: do not log errors for user commands
Thread-Topic: [PATCH v1] nvme: do not log errors for user commands
Thread-Index:  AQHY2WchbFAzwvMd90+50EbWjPLAZ64BSCWAgAAUw4CAAhUngIAOyWSAgACfXQCAAACvgA==
Date: Mon, 17 Oct 2022 16:40:25 +0000
Message-ID: <79E937D0-58DA-4AE2-A0B8-A30185CE7FCE@oracle.com>
References: <20221006093628.22089-1-dwagner@suse.de>
 <20221006121635.awoafzxyu6nkrqfj@quentin>
 <20221006133053.mmzw7m7wbfsapqbx@carbon.lan>
 <35A47E59-90E0-4F6C-80EA-A98F59213FA0@oracle.com>
 <Y0z/NRKwg0SRgYiP@infradead.org>
 <Y02E5PjYfdwjJdez@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y02E5PjYfdwjJdez@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB5550:EE_|IA0PR10MB6914:EE_
x-ms-office365-filtering-correlation-id: a1e0c345-795a-4bb5-a706-08dab05e4ac6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  hs0fd6hXcNjwtCWQHi+eBxbQXvlzEeDRAKa6wda4vgo3wNnD6IBgaJW52Bitg6M86DQmT2lZq5a1JodWlSYvYA29iHIdjJYbiFKZTgSU65VigKiefNVZPrhu/pVAv9efOqUnxcdlJAgDVtO0lFtRFgY2v3qjENhM47lD0o0DKxgU0YcP4YYzRBzqzpa+C/WdeSpxKeZH3osxvHWO2EGQYdJRZyV0HgnFxA04OSLV1xtl/oYIW4LOMhfCX317fbxWHaE23jsJ4R4IQJhs+b/9lG0ORJjSqY5n7fFOFWPJuQ4uSvX9g330QSEzNedJ8zgpfAfQFcunHpPyJsEZf1FJd/sWoWf+Gcco08t3vPE67QA0hEVL+czjpDEEPAgghNi7LCM/69PiuA99BI+a+ES0yr7FRGUJbMrWShbjLLTlXu5TuCBrF9tbJZVld2S7EN3Ymh1yR+Ku7L6hCFBSnx1K1RL6+SXd//pslmCeH1cjI8FmE7JKSFLlIc/nIxw82bxT7Q62dTY2Y0/KakYNIdgTzwiJTTqgwdod2qiBDkU99mZdxoO3H6nwmExEoKF/V+iSqOLuPQCc6rzEqI03wrWjYShDHnLsLVbDUlTXwvihZsm02aO7sUMgmLx9orxkDpMEWKRPjsb60cEsUEgcRKRrhE2dCGzBkC8f4qhsRSOL+x+BgMFJa41Fm0ONdzZWOhYskyE4n55s+g70Zkyefn54+/HhAvzdnWsdBCPzmqdHXcdPM+91a7FGDeWdiT8Ipdthb01ydExo04lXHShDqa+05z2PktvhfKc0TlcV36RPzBk=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(38070700005)(36756003)(122000001)(86362001)(33656002)(76116006)(38100700002)(83380400001)(91956017)(66556008)(66476007)(64756008)(54906003)(8676002)(66446008)(316002)(66899015)(66946007)(6916009)(7416002)(44832011)(5660300002)(4326008)(186003)(71200400001)(2906002)(6486002)(8936002)(2616005)(6506007)(478600001)(6512007)(41300700001)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RlpXbTdCZFFUWStoWVRLcHNIT0t4N3hUTmsyaHBNNTJZQWtCR2dLU2dsY0or?=
 =?utf-8?B?eEc4K3VxcnB6UzFIUDlTZ3lWWmJnbEZlVm1QLzF6NFhiZDc0d1VvWEkveFlq?=
 =?utf-8?B?ZytYYXQwNHNlSnl5ZlFRUmJwVGdrNUtvMlpNb1FtWnVpMXlNVXJFNUE0eHkr?=
 =?utf-8?B?NHliR0NDV0ZNSzBKQ2orVWNacXJTK0RZckpmekZIT1FONW53M2I3Z1ZJa0xu?=
 =?utf-8?B?Y1A3Z3czZTgxaGV6OHJMUzZPYTRkdUdTSm1VOElJRmtsRmdWN1hOcmo5U253?=
 =?utf-8?B?V3lRK3ZqUlJiL3M3ZHRnZFJnL1UyOWZRcXpSei84T3Ewb0ludUdDTnM2NTFs?=
 =?utf-8?B?SktVRnZ2MFE5WkF6cytDRUxYTEd1Uy9QcWRxUVkyeHhHVit1YTlOS3Z6Rzlq?=
 =?utf-8?B?cHgvZUdFWnBncHlFdjEvRUpOSDR3WWNDR1REZWNwRlJuVXlnMHhDaTlEc1Rl?=
 =?utf-8?B?WUFGYWp4WmlsTkJUYUpTdktTZEVVelRva0M3ellxdGI3ZGt3aUdMSjFGLzJu?=
 =?utf-8?B?OU5SZXdBTGxxMWVBcFF4M096ckdjM1lpNHAxUEgwdnY5Qm10NHk3T0JwRzNo?=
 =?utf-8?B?dHBjeXdYalZ3cHFLaXBuMVV3N3NhMWNkSUpTdzFVbWp6SVZqN2h0WitnN1BE?=
 =?utf-8?B?bktzeUdOd0RGSWVmZm1wb0IrcHdtVFMrYU8yZUVzRUJIbnZrNDFaZHM5ck5U?=
 =?utf-8?B?M09yZWFRR2U5ZlRBaEdBU3FDeE92WlJiMVdEUS9SSEIwYlNDb0d2bDIwYXI4?=
 =?utf-8?B?Uk4vVUJFbjMwSkMyQUwyNjd6QVB1WHNiY0ZsV2VtaEpNY29PY2huR3ZBdEJz?=
 =?utf-8?B?ZDQ4Y2JOYmVybWlDMitiZFBVRXdGemZTTDU4a3ZGYUlEcEFBZkZCSmhFVlp3?=
 =?utf-8?B?UnpUTWVLNHd0UVEwUlFRWDZIeXU5RFM3OG5haEE1UUtnejJwZjZING5GUTZ2?=
 =?utf-8?B?SzlwblJsSDd0RTlEbFNCUGZDb1lHZVY5ZVZ3ZjJieFgvWlhJNlFpbmorT2lp?=
 =?utf-8?B?L1JKOU1aQmROdnpmWXYrb2FTU04vOUpKWGlrNDBiOTQ2NVkrZTgyNDNaeTJw?=
 =?utf-8?B?OUZpdVhlZ0ZCbVd6UzhmemJYdWFHYlFGTnhmUHRQVER0ZTZSeGdhVXNjbkR2?=
 =?utf-8?B?Q0xzbXVWd3RteG1OY1dNd1d3LzFsaXpEUS9ucC9UOUdGWGprcndGOGJaWk5y?=
 =?utf-8?B?WG5nT096K3hHNkQzdzltdTAyRkF6ZGlLRDBVOG5UanNINElrbE90eHF5eE9r?=
 =?utf-8?B?QWN4MDZtL1lOWjdQbDFrbEkvOHZqWW1xVWJuTU9uS3kzZXlZK0tUdGhTdzJ3?=
 =?utf-8?B?VnJGaFBDTkptNFFzTzdqWHhzTjgrYkkwdEdCM1A2b3l3cFd4WEo3K3NpM3lL?=
 =?utf-8?B?OTg2amlLUXNMb0FwQkhndmJvS3NTQjlWT1FCaTcwT3lDSGxTSjR4ck9UMG1x?=
 =?utf-8?B?QXU4N1g3Z0I3b054bjNQajZjSGFtdlpRekdtZjZ0ZGtmRHpncEg1aXA2czMy?=
 =?utf-8?B?YjhtVHg1ajRWcHV3NGFXb2FYS1Yra1ZQbnNzdzNVTmd0NFgwSW5JZUg1dVZI?=
 =?utf-8?B?MTk3STh0ZE1RbnNrMFIyZ0hzZzMwY1U0QjR5anF3Uk1uRDkyTWFFVUVucGps?=
 =?utf-8?B?dTV1L29WN1FZdGY1dlB6WFpTcTFwS0V4NmFwbjlYNmg5ZnJ2ckU2VGJTbVhJ?=
 =?utf-8?B?dlZBMW92dWZVWEhNZ25yOVFNRG9ydzVFaXZGWnJVRE9mNTBPUCtiWlkrN1p2?=
 =?utf-8?B?ZXpLSkxWR3BJRE5TeFlVbGR5bE9Wd0hKMGxtSTh5YjN1bTRxa3lRbWZ0c2l2?=
 =?utf-8?B?aXpuNWVEU1hVNzkzdEpXOUwycjJmdktSTXI4VGZXeHMxRUEzajMyL0dhSkZ1?=
 =?utf-8?B?SGdlWTE0enN5bUJ3T3d5OVowT3NmVlJMNUMxS2ZWaEhxVWpsNjV5UEI0dnJU?=
 =?utf-8?B?ekgybXR0MGdjcXBEeno5YS83N2FRd3U2K1l2ajl2a3ZzeHVaMXZzMU5oeVpo?=
 =?utf-8?B?MjVRaHl0Y0hwMFhjamd4MnorZ0ZoR1FVbk1lODU5R3BGMlFBZTNSbTRLUWlE?=
 =?utf-8?B?b3RBd2lMRzEyTWx5WEZVVW5xWVlRM3FuQUoyVGF2WGRBZG51UWpPQUJFa3lt?=
 =?utf-8?B?aloxak55WGU2WHNWemprOXRQVCt1QmpjbDVrQkFtejFVWGJnUXdlQUcrQ1dl?=
 =?utf-8?Q?vHAqFqxw3nUdikWEtc3286r3Se2S3Wy1vJz/1XebyF09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28C30C05D64C164CB323D12561C47F26@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e0c345-795a-4bb5-a706-08dab05e4ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 16:40:25.4137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Qwmr0xJSLV/Gt5HgQyuVW1WMcnKzoiFF0GdziLIN2dHN0P7sTr6jZKXEAon3wmT8wpNB4K4YU8VK76SPVskIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170096
X-Proofpoint-ORIG-GUID: 4aLsAFfzHzcXwO3olmZUSox45ptMrqF3
X-Proofpoint-GUID: 4aLsAFfzHzcXwO3olmZUSox45ptMrqF3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_094538_462494_01B49BD8 
X-CRM114-Status: GOOD (  23.21  )
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

DQoNCj4gT24gT2N0IDE3LCAyMDIyLCBhdCA5OjM3IEFNLCBLZWl0aCBCdXNjaCA8a2J1c2NoQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBPY3QgMTcsIDIwMjIgYXQgMTI6MDc6MzNB
TSAtMDcwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiBPbiBGcmksIE9jdCAwNywgMjAy
MiBhdCAwOToxOTowOFBNICswMDAwLCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+Pj4+IEkgZG8gZ2V0
IHRoZSBkZWJ1Z2dpbmcgYXJndW1lbnQsIGJ1dCB0aGlzIGNsZWFybHkgcmVncmVzc2VzIHByb2R1
Y3Rpb24NCj4+Pj4gY29kZS4gSWRlYWxseSwgdGhpcyBjb2RlIHNob3VsZCBiZSBvcHQtaW4uIFRo
ZSBvbmx5IHdheSBJIHNlZSBob3cgdG8gbWFrZQ0KPj4+PiB0aGlzIHdvcmsgaXMgYnkgaW50cm9k
dWNpbmcgYSBuZXcgQVBJIHdoaWNoIGFsbG93cyBlbmFibGUgdGhpcw0KPj4+PiBmZWF0dXJlLg0K
Pj4+IA0KPj4+IExvb2tzIGxpa2UgYSBuZXcgQVBJIG1heSBuZWVkIHRvIGJlIGNyZWF0ZWQuICBJ
4oCZbGwgaW52ZXN0aWdhdGUgdGhhdC4NCj4+PiBXaXRoIHlvdXIgY2hhbmdlLCB0aGVyZQ0KPj4+
IHdpbGwgbmVlZCB0byBiZSBhIGJsa3Rlc3RzIGNoYW5nZS4NCj4+IA0KPj4gWWVzLCBJIHRoaW5r
IHdlIG5lZWQgdG8gZWZmZWN0aXZlbHkgcmV2ZXJ0IHRoaXMgZm9yIHVzZXIgY29tbWFuZHMgYW5k
DQo+PiB0aGVuIGFkZCBhbiBvcHQgaW4gLSBiZSB0aGF0IGZyb20gdGhlIHN1Ym1pdHRlciwgb3Ig
dGhyb3VnaCBhIHN5c2ZzDQo+PiBmaWxlIGZvciBhbGwgY29tbWFuZC4NCj4gDQo+IFllYWgsIEkg
dGhpbmsgd2Ugc2hvdWxkIHJldmVydCBsb2dnaW5nIGVycm9ycyBmb3IgdXNlciBhZG1pbiBjb21t
YW5kcw0KPiAoaW8gY29tbWFuZCBsb2dzIGNhbiBwcm9iYWJseSByZW1haW4pLiBUaGVyZSBhcmUg
dG9vbHMgcnVubmluZyBhdA0KPiByZWd1bGFyIGludGVydmFscyB0aGF0IHF1ZXJ5IGFsbCBkZXZp
Y2VzIGZvciBvcHRpb25hbCBwYWdlcywgYW5kDQo+IHNwYW1taW5nIHRoZSBrZXJuZWwgbG9ncyB3
aXRoIHRoZXNlIHJlcGVhdGVkIGVycm9ycyBpcyBjYXVzaW5nIHNvbWUNCj4gcHJvYmxlbXMuDQoN
CkkgYWdyZWUuICBJ4oCZbGwgbG9vayBpbnRvIGEgYmVpbmcgYWJsZSB0byBvcHQgaW4gdG8gbG9n
Z2luZyBvZiBhZG1pbiBjb21tYW5kcy4NCg0KQWxhbg==

