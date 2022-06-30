Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24831C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 21:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+PqAslWOdcQpfqnsVgKrOFWm20hheSU7TnPATfl3jlM=; b=DmF8gOFptdjIjuYkoYZMz9iM+7
	eMSo4gxaKYI692+G+Tzr9WfpmSaKqPFgbrx6bxKkxFYiwmo50blmhStt58za/j92eLlZ55lXvinmP
	TTKiZZ1DJt3BIbu9UVGVsb8kbgo9KLiEYoF/M88AALWqO3Bw4qrHHqdMcwVcL0FXnr8UpJNV69orS
	Yw/7+7pBJAKoRNi/ykVHvnDy+J2R/AEu60xA7yYZ4fjL+GI1rhDfC919dWz+Wl1tTV3+W2udXw40T
	Kqv+sfSSEv63vPtk3F6pkej04WrBIjjAxrCjpTGBxqf/ACi8BvB5X4L2YGlCBdRCGrP0EqqyTpypR
	tXBidbXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o71ed-001daq-FO; Thu, 30 Jun 2022 21:24:51 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o71eZ-001dY7-ML
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 21:24:49 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UK3ka0022367;
	Thu, 30 Jun 2022 21:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+PqAslWOdcQpfqnsVgKrOFWm20hheSU7TnPATfl3jlM=;
 b=w4h25LmBDDT+Lh/T6NCLudNBPnNO1lhXWUU7UincjziNefWRbs+oUtIHHaZtuB7yiX28
 zc3wZq7/xlWcaUTnrQhWE1pIWLLmN3EfdB27+khDEyhRkiHIkM5xYPm+r1wLh5jDyD7Q
 szCRFboXyP32I7aJnOcPimhOQY22rpJOZVsoJLM5sUDb7bvESl2vB20pH6sTYJCaGaXB
 ew9vps59W8ltHHza7T4JYJForqpuRNW+KkCH6moBADRxRNX+bF2EXPG/qnUicZkphtlh
 raekbgK1DJvRPco1vyaZVZeft4+UslxHXItiXZHdNsADxkE364Ztu8R3Pip7D307P3iD Ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscnags-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jun 2022 21:24:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25ULBoak016327;
	Thu, 30 Jun 2022 21:24:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt439yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jun 2022 21:24:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhGH2bbLQzrgH2tfP3Fd7jwRYZLS/DGIj3hig9nKIBaE1E3287cpHi6Zy7k0pJBPhlv5UM7A1nHbk/9NY1Gx7bAsMAqlh/hwIDRnmipuVojhJYM7/k0Z6aORYhR+0BIq9gSpQ3nsA+tw1J+7BEh2w8DiZGa00dzr5HwFIyVH0bQBBEdsOz5Rd5RiE3jQdbELzUeO6m/UerSAOU5f6f4J88C2IXpoyN0KNlX81guwOJ2SM8qRxZWVKlCpxS++hHGHd2IH4gQPKRGvCyL9bxEVKpLKgGq7wk8bkigBb7qk6ItGvM9iKtlxETSi9PuiF/7Egb7TsLh0scF+zcjNctpBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PqAslWOdcQpfqnsVgKrOFWm20hheSU7TnPATfl3jlM=;
 b=T9oaH6pogFf602FY7F94KjeL2ir0OaYOgkCxtESG1weZnK3Z/Szjd+gfDrHHmrcx3o0BKruHHilFkG3Rmgvgi7/7yCPbjTMk0rqwFrXlQKh83kOpvOg2+ReRsW/Sw5zDH7kguQoB4kFEaXsqQ6AfMg2+KVM1bYBWzuZ+Vhc5wnlbEBu7EAohuXpleoxS16OtHKYRzjHgixNGdy+YfaRvnZ1Ab57DEVe7YP+1Aiup8uQ224fEtrP5H5WqSW+lDyBJQtUFRg8mDxoZXJwkj+Y+miU0Q1UxStR30GBY4zWx29bpYS1f1iCzCfgqCr0sKSlweQC+iddqhu7wZMviZuxDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PqAslWOdcQpfqnsVgKrOFWm20hheSU7TnPATfl3jlM=;
 b=Z4oWgyqlGcU848sos/skkHXop8eM6KUpwQFLN0Q2frG7Nfj1I+sDUVrsEVRBG+J5eH6ZM3N/VcsPWYX2O0QGbhD2VJVG0igtNM10LGL9OigQPmO8hXv+xTxFLv4iYEXQPpqQnzFsW9XWvTkRUj94iLF0IaenmjTZSpHAAbXn9X8=
Received: from CO6PR10MB5537.namprd10.prod.outlook.com (2603:10b6:303:134::20)
 by BYAPR10MB3303.namprd10.prod.outlook.com (2603:10b6:a03:153::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 21:24:28 +0000
Received: from CO6PR10MB5537.namprd10.prod.outlook.com
 ([fe80::fc3e:f74a:c21a:fcd4]) by CO6PR10MB5537.namprd10.prod.outlook.com
 ([fe80::fc3e:f74a:c21a:fcd4%5]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 21:24:28 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke
	<hare@suse.de>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests v2] nvme: add nvmf reset/disconnect during
 traffic test
Thread-Topic: [PATCH blktests v2] nvme: add nvmf reset/disconnect during
 traffic test
Thread-Index: AQHYjJlIoYiPtnn0kUmdnn3JmqgYoa1odluA
Date: Thu, 30 Jun 2022 21:24:28 +0000
Message-ID: <34A68ACF-A167-4B5C-A0D5-507F58174C33@oracle.com>
References: <20220630154444.475600-1-sagi@grimberg.me>
In-Reply-To: <20220630154444.475600-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56ec5f93-6a0d-47f4-a797-08da5adeea4c
x-ms-traffictypediagnostic: BYAPR10MB3303:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ODbRrd9c9NshPapb34w6S5nXHZvntqqs1vy0QrTt8Qlnyuh2WRxMKL24fHA+4gZgPileHxaN5GAHARJxHAXn+7dWC2OcgasTjDZSbRwecKf22XB3EsZUU5mH+ouNog/6avy8M3qtuYLvXW2X4EI3WtrTNbwE86Haz0Yh6+6bZ9qVWQs6ZXBj1pKcK0Phgz7miYr/V+gUPBKBpcu8E2XpLOT0t1voSA5i2Gc07Ya9dEaw2YjrX6xuL3O4jK+jx93qUB7zLufkhihP7Y0wT04EFMI+7vRONtPQ/x1aTW7TVyn4ztmdh9nev43sqTZOTgxk5jPOgbvhvjp+1TgBXxm1Pbdn8qZZMnudDzUwEDMPqyaWjdIESxTFAkWLPQtdPeAy+sSQNaisDXAAPcyngIUwXMqLAxcNsLfePB6VQVgWwOg2JaVqS7dbyBfKINDkrN7NRUOtsamatANTqido8M7uv7ncHme+2CzIuprb9L5Quc+c3sNCH3TXu1MFV9SshMWtMBkvZH9DIYuXfbhmMXiHDXw5ykIq0/BtKlVeaxrY9Niyujx3iHkuNUB5JlrpSj+kT9osxWPcxt0PR3/Yedd1egrpndRpFY0D25ZEhxYkkuN44hYp6iQxv7EtydppSSy3r3SHfqVWhUUq9PSJ86V6GXkAmnjwpA49/jfVZ+bJuI/1lKgf3I/32lwH97s9CrjKWCpYjKvzEaahS4dcE1hCKzAOqaXhO0IPyAE2ttMywgeWYFfwSTXwxD5P8Yy8dh9/UMfE0JpGspPrbGWh+q0rxLfEsC1mw+CesAZFdHzEenjAIkcOEIG9LnVD7UBdJ9XdH6/qwwGiFYCRVIXTaWh895+wSssoGkvjmFPQpiR8eHM=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5537.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(396003)(376002)(39860400002)(54906003)(6486002)(83380400001)(6916009)(478600001)(38100700002)(71200400001)(316002)(44832011)(122000001)(186003)(64756008)(86362001)(36756003)(4326008)(53546011)(33656002)(6506007)(5660300002)(38070700005)(66556008)(6512007)(66446008)(66476007)(2616005)(2906002)(76116006)(66946007)(8936002)(8676002)(41300700001)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Q3dDL1A1aUVKZW41d3JHZFB3Z2hOem50NmIxdzd2ZUp5YzZNZmo2bnpqaHpq?=
 =?utf-8?B?UkJxSWo0emtWWmZFRUo3by9Xd2U3YTU2QzQ1RytNOUlXV3l2RTV6TXlqTUhm?=
 =?utf-8?B?WlBIdzFwRUNsMUdTVSs4Zk1nTlJsSWFBRlJhaWIySUpiV2FWelJ1a2cydGI5?=
 =?utf-8?B?RHZ6bkhkVklMeUxpTGtsWDlITUFNTDBUaDFsZTNOMW43c0RJckpENUtyWHlt?=
 =?utf-8?B?TlRwR1FyaU9aOGxuWjZrU1MxN3pGYmNaaS9heTRiNVZLM0JiUGlqa0UySlZD?=
 =?utf-8?B?bFF2L2owWCtaRkVrMkU2REZZT3YwUEF4SE5CY05SelNhQjFZQnBNdElMTE8r?=
 =?utf-8?B?MmhjQUp6YUsyMXV0dHdERTQzZGNueTdHV2czU1gwVXo0ZUUxWm5iTTNBckN5?=
 =?utf-8?B?emhZM2JCaldZWDZvVFIvdTBOVVVVUXRJRWhtSGZmQXcyQkhBOWdsVERJMytW?=
 =?utf-8?B?TG92bTl4aW5SZy9salpEWXdJTVFTek1jTWh0VWJvdS9oRC8yeUpqNGRQalBZ?=
 =?utf-8?B?cHVCU0Q2NFlVV1lua2l6YlhjMnVZakY2TldNdzVCRmlBOEpObGhTa1VwM0pv?=
 =?utf-8?B?L1lST0J0dGhzOU8xSTJrckJMcEFaRFVtQVJwc0JZWEgvM2VyWHd6NHpaTXlK?=
 =?utf-8?B?Q2k1RFZoTHQ2UHNmbzhPZ2k3b2MwamRFaXRUaHRQU1FnR2ZXbzZHeCtOakdt?=
 =?utf-8?B?dVlxdm9ESExzcUlGRU9ySnMxTXdGMUJ6MFdJWjJKcFg1Q2FqQzRLYWJzY2Va?=
 =?utf-8?B?R3RWMWhwMnlPTjdkWXo1YnI3OEZIQjY0eFZWWGlTODlRTi85M2p5RmpJZEcy?=
 =?utf-8?B?bitBbHhXQzFVS01Pb2hUNm9ZeHpHRVpJUSs0MThZNlFTK1FiV3oxSSs4LzBL?=
 =?utf-8?B?YmcxNHNkOGg4OUk2QzhUYjl5aUxoSmxOeENremZjNFdlZTloSVdQblNoVHBI?=
 =?utf-8?B?SExYYzhsQUU2VnBEQWJwYmhSUXlYWDVrT0cxVXFQQytKMFJUQzliYWF6bnBS?=
 =?utf-8?B?dE5pWDkwVmg0ODY4WC83N2VvVFViV1hRUGwvMnpaWFpuZXNCRXd5cm54bldN?=
 =?utf-8?B?ekhEVDFzT1VKMmI3K3A3RTIxTkVUSHdRUnJyMUZua0NsM0x3ZFhWSEpJRm5J?=
 =?utf-8?B?NEVnSVp5TVhFSVVSTVJwbWpHZHV0OWE0QkNRQjY5Ym9oZGJNOGkxTTBLZXAr?=
 =?utf-8?B?K1AzRXhyTWsvR2QrVmtzaktKaW1veTgwUmJQNjZsdkE4ZG9UYjhlV25NN01R?=
 =?utf-8?B?bEd4ZzI4L3pwdE5NcGFIUlhCSk8wSDYxOVNWMlJPQUR2NXczb0ZCMWhUUDZJ?=
 =?utf-8?B?RVprZDRnWk44SXZMRzRCQ1BrZHlzcWJiKzNLblhuUkhJYmFmelRqcUNUVWpN?=
 =?utf-8?B?NmZBSDZ4WHhjbTRYTVF6SGdLNG42VHJkU2tTVTRremxDSnJEbXJiSGpVUi90?=
 =?utf-8?B?bkUydm1NYmVyT2Y5bWdXQ2tZZ0JiWlpVRkJHUHVwWUY5ODdzQU5PYng0UkZz?=
 =?utf-8?B?SXFqbUdrQ0duRkFvOFNtbFA1a2xlWSs5ekZHNExDMG1BeWxEVE5JL2VCa2tD?=
 =?utf-8?B?YWtyOCtxZ3dYd3lDdVRHeHkzSlV2N2VHaUQxVHZjWkkzb21OWGY1eWQ5dHYx?=
 =?utf-8?B?MmxockZaMHRlTHVqZnByL2RPS1k1YWw0cE1Wa0xQL1ZkQmk5UW9jU1EzNmM0?=
 =?utf-8?B?MGR3eXlFUXVWdUtCSis5OFpBNkNpWUpROHowQUlFTjJZTlAvR3VhODhLd2dL?=
 =?utf-8?B?aW9RQitmSWRrRVVRWTVucjFGc2JKcVN4Z1J0RnJDbWZ2cEZiL04xMktjTUZD?=
 =?utf-8?B?cGJ2TjNiMTZoSjZYM1ZFK3hYN0VSLzJ4RFo2RHdZYzdhUGxBVUpVNEZVa1FF?=
 =?utf-8?B?T0xzWjArL1NPaTRSQjdna3c4RGx4NkZBdWg1UnRrOWV1cnhVd1dpTjhUQmhO?=
 =?utf-8?B?QWFOR1RMeGtRbmdaTGpadUtyR3NMWm5QS0o2K3Q0S2dmbUlQSDdzR3IwMzVI?=
 =?utf-8?B?eHNDWkpSMk9yN0J1V1ZEeEZ2SzhjbE05WTVvM1NVOExsK1JGSFFxcEhjcFRJ?=
 =?utf-8?B?WUVjM2k1aExYbWJDdmlsVjJacFZoN0pNNldWS21CcG1HZGVGcWFzek9qcHEw?=
 =?utf-8?B?b0N0cWdmYzlZaDF4V0xGSVN4VVZ0RzJXMm9vdnk0ZktiR3JDZlY2Z0wwVlc4?=
 =?utf-8?Q?usB9KvPVczJBUrhhcVKgmEOftYPc88coNIKP95rkUEZd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FFA182B9250CC4C9F11A60F9405EC7D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5537.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ec5f93-6a0d-47f4-a797-08da5adeea4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 21:24:28.6321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmZ6n0nHSkB9o205fHLhcwWFyzdAbmcjzCyyv1YjM0v7Tka04Y54MyRlpWqwNfYY0gNL+CTTQ9qx6qVu8RbL0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3303
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_14:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206300081
X-Proofpoint-ORIG-GUID: z-ChLUNgs1G2mE87vRcKI3BoN_71L5HZ
X-Proofpoint-GUID: z-ChLUNgs1G2mE87vRcKI3BoN_71L5HZ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_142448_096537_E1CF8EA4 
X-CRM114-Status: GOOD (  27.59  )
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

TG9va3MgZ29vZC4gIEnigJl2ZSB0ZXN0ZWQgaXQgb24gbXkgY29uZmlnLg0KDQpSZXZpZXdlZC1i
eTogQWxhbiBBZGFtc29uIDxhbGFuLmFkYW1zb25Ab3JhY2xlLmNvbT4NCg0KPiBPbiBKdW4gMzAs
IDIwMjIsIGF0IDg6NDQgQU0sIFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+IHdyb3Rl
Og0KPiANCj4gVGVzdCB0cmFmZmljIGNvbnRyb2xsZXIgcmVzZXQgYW5kIGRpc2Nvbm5lY3QgZHVy
aW5nIHRyYWZmaWMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdy
aW1iZXJnLm1lPg0KPiAtLS0NCj4gQ2hhbmdlcyBmcm9tIHYxOg0KPiAtIGZpeCBjb3B5cmlnaHQN
Cj4gLSBjaGFuZ2Ugc3Vic3lzIG5hbWUNCj4gLSBmaXggdGVzdCBjbGVhbnVwIHdhcm5pbmdzDQo+
IC0gZG9uJ3QgbG9nIGRldmljZSBuYW1lcw0KPiAtIGZpeCBzaGVsbGNoZWNrDQo+IA0KPiB0ZXN0
cy9udm1lLzA0MCAgICAgfCA1OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+IHRlc3RzL252bWUvMDQwLm91dCB8ICA2ICsrKysrDQo+IHRlc3RzL252bWUv
cmMgICAgICB8ICA4ICsrKysrKysNCj4gMyBmaWxlcyBjaGFuZ2VkLCA3MyBpbnNlcnRpb25zKCsp
DQo+IGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9udm1lLzA0MA0KPiBjcmVhdGUgbW9kZSAxMDA2
NDQgdGVzdHMvbnZtZS8wNDAub3V0DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvbnZtZS8wNDAg
Yi90ZXN0cy9udm1lLzA0MA0KPiBuZXcgZmlsZSBtb2RlIDEwMDc1NQ0KPiBpbmRleCAwMDAwMDAw
MDAwMDAuLmQyNTk3ODQ2OThkOQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rlc3RzL252bWUv
MDQwDQo+IEBAIC0wLDAgKzEsNTkgQEANCj4gKyMhL2Jpbi9iYXNoDQo+ICsjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMy4wKw0KPiArIyBDb3B5cmlnaHQgKEMpIDIwMjIgU2FnaSBHcmlt
YmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gKyMNCj4gKyMgVGVzdCBudm1lIGZhYnJpY3MgY29u
dHJvbGxlciByZXNldC9kaXNjb25uZWN0L3JlY29ubmVjdCBvcGVyYXRpb24gZHVyaW5nIEkvTw0K
PiArIyBUaGlzIHRlc3QgaXMgc29tZXdoYXQgc2ltaWxhciB0byB0ZXN0IDAzMiBidXQgZm9yIGZh
YnJpY3MgY29udHJvbGxlcnMuDQo+ICsNCj4gKy4gdGVzdHMvbnZtZS9yYw0KPiArDQo+ICtERVND
UklQVElPTj0idGVzdCBudm1lIGZhYnJpY3MgY29udHJvbGxlciByZXNldC9kaXNjb25uZWN0IG9w
ZXJhdGlvbiBkdXJpbmcgSS9PIg0KPiArDQo+ICtyZXF1aXJlcygpIHsNCj4gKwlfbnZtZV9yZXF1
aXJlcw0KPiArCV9oYXZlX2xvb3ANCj4gKwlfaGF2ZV9maW8NCj4gKwlfcmVxdWlyZV9udm1lX3Ry
dHlwZV9pc19mYWJyaWNzDQo+ICt9DQo+ICsNCj4gK3Rlc3QoKSB7DQo+ICsJbG9jYWwgc3Vic3lz
PSJibGt0ZXN0cy1zdWJzeXN0ZW0tMSINCj4gKwlsb2NhbCBwb3J0DQo+ICsJbG9jYWwgbG9vcF9k
ZXYNCj4gKwlsb2NhbCBudm1lZGV2DQo+ICsNCj4gKwllY2hvICJSdW5uaW5nICR7VEVTVF9OQU1F
fSINCj4gKw0KPiArCV9zZXR1cF9udm1ldA0KPiArCXRydW5jYXRlIC1zIDFHICIkVE1QRElSL2lt
ZyINCj4gKwlsb29wX2Rldj0iJChsb3NldHVwIC1mIC0tc2hvdyAiJFRNUERJUi9pbWciKSINCj4g
Kw0KPiArCXBvcnQ9IiQoX2NyZWF0ZV9udm1ldF9wb3J0ICIke252bWVfdHJ0eXBlfSIpIg0KPiAr
CV9jcmVhdGVfbnZtZXRfc3Vic3lzdGVtICIke3N1YnN5c30iICIke2xvb3BfZGV2fSINCj4gKwlf
YWRkX252bWV0X3N1YnN5c190b19wb3J0ICIke3BvcnR9IiAiJHtzdWJzeXN9Ig0KPiArCV9udm1l
X2Nvbm5lY3Rfc3Vic3lzICIke252bWVfdHJ0eXBlfSIgIiR7c3Vic3lzfSINCj4gKwl1ZGV2YWRt
IHNldHRsZQ0KPiArCW52bWVkZXY9JChfZmluZF9udm1lX2RldiAiJHtzdWJzeXN9IikNCj4gKw0K
PiArCSMgc3RhcnQgZmlvIGpvYg0KPiArCWVjaG8gInN0YXJ0aW5nIGJhY2tncm91bmQgZmlvIg0K
PiArCV9ydW5fZmlvX3JhbmRfaW8gLS1maWxlbmFtZT0iJHtudm1lZGV2fW4xIiAtLXNpemU9MWcg
XA0KPiArCQktLWdyb3VwX3JlcG9ydGluZyAtLXJhbXBfdGltZT01ICAmPiAvZGV2L251bGwgJg0K
PiArCXNsZWVwIDUNCj4gKw0KPiArCSMgZG8gcmVzZXQvcmVtb3ZlIG9wZXJhdGlvbg0KPiArCWVj
aG8gInJlc2V0dGluZyBjb250cm9sbGVyIg0KPiArCV9udm1lX3Jlc2V0X2N0cmwgJHtudm1lZGV2
fQ0KPiArCXNsZWVwIDENCj4gKwllY2hvICJkZWxldGluZyBjb250cm9sbGVyIg0KPiArCV9udm1l
X2RlbGV0ZV9jdHJsICR7bnZtZWRldn0NCj4gKw0KPiArCWVjaG8gInN0b3BwaW5nIGJhY2tncm91
bmQgZmlvIg0KPiArCXsga2lsbCAkITsgd2FpdDsgfSAmPiAvZGV2L251bGwNCj4gKw0KPiArCV9y
ZW1vdmVfbnZtZXRfc3Vic3lzdGVtX2Zyb21fcG9ydCAiJHtwb3J0fSIgIiR7c3Vic3lzfSINCj4g
KwlfcmVtb3ZlX252bWV0X3N1YnN5c3RlbSAiJHtzdWJzeXN9Ig0KPiArCV9yZW1vdmVfbnZtZXRf
cG9ydCAiJHtwb3J0fSINCj4gKw0KPiArCWVjaG8gIlRlc3QgY29tcGxldGUiDQo+ICt9DQo+IGRp
ZmYgLS1naXQgYS90ZXN0cy9udm1lLzA0MC5vdXQgYi90ZXN0cy9udm1lLzA0MC5vdXQNCj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi41MGQwMmQ0ZTNjZDANCj4g
LS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy9udm1lLzA0MC5vdXQNCj4gQEAgLTAsMCArMSw2
IEBADQo+ICtSdW5uaW5nIG52bWUvMDQwDQo+ICtzdGFydGluZyBiYWNrZ3JvdW5kIGZpbw0KPiAr
cmVzZXR0aW5nIGNvbnRyb2xsZXINCj4gK2RlbGV0aW5nIGNvbnRyb2xsZXINCj4gK3N0b3BwaW5n
IGJhY2tncm91bmQgZmlvDQo+ICtUZXN0IGNvbXBsZXRlDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9u
dm1lL3JjIGIvdGVzdHMvbnZtZS9yYw0KPiBpbmRleCA0YmViYmM3NjJjYmIuLmRmZWE3ZjNhMGRh
NCAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvbnZtZS9yYw0KPiArKysgYi90ZXN0cy9udm1lL3JjDQo+
IEBAIC00NDcsMyArNDQ3LDExIEBAIF9udm1lX2Rpc2FibGVfZXJyX2luamVjdCgpDQo+ICAgICAg
ICAgZWNobyAwID4gL3N5cy9rZXJuZWwvZGVidWcvIiQxIi9mYXVsdF9pbmplY3QvcHJvYmFiaWxp
dHkNCj4gICAgICAgICBlY2hvIDAgPiAvc3lzL2tlcm5lbC9kZWJ1Zy8iJDEiL2ZhdWx0X2luamVj
dC90aW1lcw0KPiB9DQo+ICsNCj4gK19udm1lX3Jlc2V0X2N0cmwoKSB7DQo+ICsJZWNobyAxID4g
L3N5cy9jbGFzcy9udm1lLyIkMSIvcmVzZXRfY29udHJvbGxlcg0KPiArfQ0KPiArDQo+ICtfbnZt
ZV9kZWxldGVfY3RybCgpIHsNCj4gKwllY2hvIDEgPiAvc3lzL2NsYXNzL252bWUvIiQxIi9kZWxl
dGVfY29udHJvbGxlcg0KPiArfQ0KPiAtLSANCj4gMi4zNC4xDQo+IA0KPiANCg0K

