Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870B7C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 08:32:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFBF764F33
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 08:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBF764F33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UA/siYrK5e9K21dloeS69WD1H/5mViFLREufEaYwNsI=; b=NO3b/1KfgNC4Cv8JescPKyMBv
	mh4N4OWuWNgh5ehviRfw8dsl0Aj/iPM6CqswDYFBGP/dXJ6fSP8nQhWNAAVvXjebG+I1RCKM2TxOF
	tVSF3t8rvSPzvS5cYmeeOCqDt2hWzcculV3O8LL3VwKIuEVn9k1mja/RbmKFdmWDBaXA5BPFgUaPP
	QQ6eN2SSD4Vthem0WTm13Ft2dWH4LyEvX0k++Bau/oM71WSB0huv6mjVXyeA9o+yX1WaIMlT43q40
	q/O62lE+sX1FYvQJPD0Q3rmX4tachskvUF55oSJgKKUunmG8I/SWo4y8UJwIQ8Mwh8hVKg/SeMBhm
	YybOF9//g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMo4e-004oBN-Ul; Thu, 18 Mar 2021 08:32:09 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMo4S-004o8c-HO
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 08:32:03 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12I8RKGH002188; Thu, 18 Mar 2021 04:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=K12wbV0HnR2be6rHhr9ehBY3ezAqpBSqt9xcit5HNFs=;
 b=BbMrpUUNN7FusfUjfIQldaJfP+gk02BL9AElv0QK0ePRlqWcR4upSMKF87O8Kpj1B/kr
 jU+qSzx490dMnLuiZRmfS6o97L5Mb3KDdPHIK4IgJS0BBXLgNVA139aon1oLcC3f+orX
 1NmrFd65+4Gt6rwLrNoMnDKpfrPP32NqxpcrzGqK7NJsQ2mw1E830IKPrnHRlZZHZKCm
 OvGnM5aF5MFIFVNsekJu6/kjyZCQxmWvpe7eWvQaEFNzOs6nlOv4w/k4FT7n80bVQVmM
 MvPEIZlytkT9xn/I/5RCPCHlfyqRgzKZGoNHDWCfR01Wt7xw/Fy6bRF7owWk6AZ42Ijb xA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 378sgcrgbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Mar 2021 04:31:53 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12I8QFrA092323; Thu, 18 Mar 2021 04:31:53 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by mx0b-00154901.pphosted.com with ESMTP id 37bfqe7jsw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Mar 2021 04:31:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARz38KSBH3Z9+xrijCAH84HiExZ0xPVE6yjYW2hTQAPwhKBfa5fyylW65955k93Dwb77uKU0AhhM/GYSIR4Fn2YwDkoo/7t7Rik6BwxXbaF0w/+A8MZ3klYHlN6puY57Iii90jwxumRuuhYszQDoAmEM/4KyzER9AA/DJC2zsTf1zbxkBwYUdGXMN+lSWOMEZq7P8NVhdHGbmO2AMY9YbD0IoKQyqT3raOuQdgimlQdVfb7XfbvUkonDQ8NpJ5stVwYr/Kk0NWyY65qTYJyPVGrlc4F2vlAXowLplqDzX1vIGiDBLQ7mq3iChcqaYWexoURkTofWNI16ittmAA3fjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K12wbV0HnR2be6rHhr9ehBY3ezAqpBSqt9xcit5HNFs=;
 b=ifSicuCIpgPX/Bt4PKRLYfg1h84ladBmwK1v02DGvHn4P84GzS2EQZ8jd0OI04dFP3Or+7MKomawlU/o4ODuHxxM5+lI+8wnRgVAPCtoH03sJ3RDmO/Wr5Erm9mnNE7T7Qt3UvQsT762W0a6L2XTvcfMTknD9Di0eNmzU2naVBx0GCFhN7oS/lbXlO8xwKog56TC5Ju/zZK9WktC2mxCcJkUZxc9RyfE5/d+m0jWRaJNO8daA4K0ROx3g81GypkqlvFcH0Vpry0AItTyBroCT7pflIhS9pXGkqMxsHJoE7JayQkWbb2A4mgFXntA5FsQHCX2MWp3pT6zDVsWYsfYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM5PR19MB1049.namprd19.prod.outlook.com (2603:10b6:3:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 08:31:51 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%8]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 08:31:51 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
Thread-Topic: [PATCH] nvme-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHW6aKA9bVKdUdQXk+axFkWm5Fl+KqGheuAgACdheCAAqt8cA==
Date: Thu, 18 Mar 2021 08:31:51 +0000
Message-ID: <DM6PR19MB40114D428D4A81DD9505E5B0EF699@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210113115152.69692-1-elad.grupi@dell.com>
 <28156d77-5346-03f9-bc3a-2c19417aa0d2@grimberg.me>
 <DM6PR19MB401129067320A4B74CB68827EF6B9@DM6PR19MB4011.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB401129067320A4B74CB68827EF6B9@DM6PR19MB4011.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-16T15:45:34.8936403Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=d425666e-4ed9-457b-b45f-49cf730a14c6;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [77.126.55.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2027f172-d724-4e0a-6402-08d8e9e8476e
x-ms-traffictypediagnostic: DM5PR19MB1049:
x-microsoft-antispam-prvs: <DM5PR19MB10496295E79609B2B83B0791EF699@DM5PR19MB1049.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b7IKIhOQgqoiTHsO0hLo5UUcKWeVc0lyELOXKsD7pNo2Uti497SvaT/uRorFaosNGcmm0dwInU6EqKLC2FvUB1QwKZ8FKonOV025sN9Yzjnnp5qotGnFlRZYsNxuYsNXA/beaVIBtUkaXMFBSaEorV+YgQiGrcB+gge4SeXgVqqCeahTtGKnxHVY9tRX76qSr2O/Brf9pv4xJPFzULSSIYhhIb1PbPP+md3SlTmJLJTPySLbSglrUS+4uqSbtryWGfRLTh9T/YBwHhblZnsKeFLNKuVYk9HJkOegHl5EEZL07mmh9aC+5qjmNs5vzKQKRvvFbH9jHLk94qxTKvt2rMHRnOp0sTSdB7RhypsmvUw+M9MUh1kqhfo+QMXKQD0Dm3lKbbWJ+HTRj4wm+kMXg5Rt35duv5dDmGgdoydZLV80QVm5Y6zT3tk/r5QWrSOoMQrP2Gf01Ng8qG2h/s3HlmI11d9/EyyiW2B07Ta4U0/VV4f8lW/Ow+JMt50e4QJp2vKY47nClpM5y4Q4vf0x9xJYdkvIaNZj3lcGAI07AUVzXntb9bnXk45rYOxVhWYLDATidvEPJNn1gzdj0JbVM/6jwVb81ks/jW/wRMuZPPj/UrKqfZ/pLcpeOvPElW47CJhv9Sr0Fd4nLv5cJb5s0K89oE4v6kvdmtrjU8EvI/fAZdVHzXLiMYHdliQdDyLMD0MrFrfXFw692EqYOvVxpQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(966005)(478600001)(38100700001)(55016002)(9686003)(7696005)(5660300002)(110136005)(8936002)(316002)(786003)(6506007)(71200400001)(2906002)(26005)(8676002)(53546011)(186003)(52536014)(86362001)(64756008)(76116006)(66946007)(66556008)(66446008)(66476007)(83380400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?a1JzQzRIQkxRTUtSajFuTEpLYXFaZkR1V1FXdmszMHR6blBkRHNOZGJURVpM?=
 =?utf-8?B?VHkwa3h3bTNqWXozYWN6NGV6dm4weVRrc2EvY0x3UzQrQlErbVJRdWVVbGdq?=
 =?utf-8?B?WDRQb1BUanRuR3Q1NzRYZEl4a0w0bkdzV25zNEhqOWVBRllGWFZXSTZQZlZJ?=
 =?utf-8?B?UXd4Tm9sM2hXVDdPcGJyM25pWFRmQmpoMFJsWGdGcHJUZHJoNWJBUzJKRi92?=
 =?utf-8?B?VlZ6L3MrTnpXN1NLRWJLYjgrajNUVm4ySVpDVTg0cmhGQUI2RnZ0VnhLbkJv?=
 =?utf-8?B?NTJlNnBudHVHNy9rMmVDenRqeE5FbTc4ZVlBL0xPaXArNXNieHNRbUdFTzY1?=
 =?utf-8?B?cHlZVURPT3dyb3BLc3ZXUUc3MWQyVEJqZG1RQitEbGR1UGx4UTRGcXJORGFM?=
 =?utf-8?B?RTg5d01KUGZCYVJBOWd6NGgrRTJqQk5ncHF0T20yU1FxT2RpT0orVHZtR0VY?=
 =?utf-8?B?Z2plcmRoS0lBRytsOUpReXN2bmw1cDhWb0piVmhSaFRqeXVSSXdLOWZHbmpM?=
 =?utf-8?B?TUpaQ1RwZjRmZW9kWE5rQWhaSmdES01PcFdsSzR0NVlKVTA4N1JWWWwvbEJs?=
 =?utf-8?B?ZVJGeXZGRE4yWXV5cEdKaGhzQUtxN3JmaytGR2NJWDBkNWxKNVM4c2JGSlJv?=
 =?utf-8?B?SThwNGtmS3lhdHUveXpTYUZpck5jelFUczc2cXdHb2JDenVzV24vay9UM3cz?=
 =?utf-8?B?Y1JyTVhISmtSQ3lLblNQUnpCNGVHVVZ1MUN0enZJSVYzSDA2Q09VQ0tpTElK?=
 =?utf-8?B?VWRIUER0VUJXSDVDRlVXUVRzcWJNM1l2bDNoNFowU0RobFoxZ0RQS054Q0lu?=
 =?utf-8?B?QVFCSmFtMTk2TFppOFQwOVRiTWVxekFqOXdRUWdnMXo5TW9kd1ptVkc5aGg1?=
 =?utf-8?B?S2Z2OVRLT1dWQjR4RHZlQkp0ZXZIVnhGbmpDS1dhSG9ZM01HWUJIWElzR3Z0?=
 =?utf-8?B?dVVrU3cvOUllNUtkeU9pUm14QjVYcUJEMTFSRHFxa1JIL0lNd0k3cElobXNu?=
 =?utf-8?B?QkZHOVN1U0JyZ2p4TjhscWhScmczV0pna3pUeDhJUTFNdWVPQjJuMTFuOEpS?=
 =?utf-8?B?b3Z0aHJoa0JjdDVuMlhxU2hleEJrd0Y2VHA1RkxobEdNWi9LT040L3c0WEo3?=
 =?utf-8?B?WG9tand1TjB6bXBSakphVnA1MFF2MU1YTkVzZjBjMkFndUVhZnUwdzlPWW1t?=
 =?utf-8?B?NUxYZ2svU1gzTkVDbkY3TDkrL1JJY0hFZFFobncxUGN1ZnZIeWExa216V1pl?=
 =?utf-8?B?TTQ2R05wVVlScXRCNmM1dDVGaGNiTzF2NXRLVVJxU29IZ0xlM3doNDM3Nk9s?=
 =?utf-8?B?RWVOMnBlS3NaTmNZcEhzNGNpb25RNU9wd0tCTE5pVFVmV0lMNjZUR1kzVDJV?=
 =?utf-8?B?UVV1WXQ2VWE3WlVnOUpiSUpZYUs3ZjZRVk01Zk1hejFlRlpNTGg3ckNXN3dY?=
 =?utf-8?B?MUpxREIxTDM3NC9nY0FneTFJemlpK25ucG9OK1BBKzVIOVRJb0xoS1lmOU5l?=
 =?utf-8?B?T1ZGM0kxWlhtd2MwOG5lSUhmcXErcE1NWmVKWWpNNzR1Y1NCYkt5bGFSdVFG?=
 =?utf-8?B?cjhUUEIvZmtOeWZQby96RkdWa0xxTlZmdDNaYkZFNlpnZUhpaXlybEJSalJJ?=
 =?utf-8?B?clMxRnRodElxL1JVemo4cmpiK2hIaHZsSU5mWS81Y2dmbWs2OUFXMWxoWkFX?=
 =?utf-8?B?aS84YTZVQTBPNEsvWm8vemlxaTN3R2RFNkdZZlh6REt6VWFtTm1vWkRBOHYv?=
 =?utf-8?Q?7OMUnJ55Dx7xicHMQkcTMOvKrhc0pG/bC9TB25T?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2027f172-d724-4e0a-6402-08d8e9e8476e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 08:31:51.2249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4mtWoxOxQTF2QzOf+O5Vp52LcpCDYzYS6kWY/FPxbDIFYzjYLFZ+1K6mlsSOQpdKmqmZg25b4sAAYpgSMKG8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1049
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-18_02:2021-03-17,
 2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103180063
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_083159_061985_881C759E 
X-CRM114-Status: GOOD (  31.91  )
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

Patch is ready in a new thread

http://lists.infradead.org/pipermail/linux-nvme/2021-March/023824.html

Elad

-----Original Message-----
From: Grupi, Elad 
Sent: Tuesday, 16 March 2021 17:46
To: Sagi Grimberg; linux-nvme@lists.infradead.org
Subject: RE: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error

Right. I will address the comment below and send new patch

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Tuesday, 16 March 2021 8:21
To: Grupi, Elad; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 


> From: Elad Grupi <elad.grupi@dell.com>
> 
>      In case there is an io that contains inline data and it goes to
>      parsing error flow, command response will free command and iov
>      before clearing the data on the socket buffer.
>      This will delay the command response until receive flow is completed.
> 
> Signed-off-by: Elad Grupi <elad.grupi@dell.com>

Hey Elad,

I just realized that this patch was left unaddressed.

> ---
>   drivers/nvme/target/tcp.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
> index d535080b781f..dea94da4c9ba 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -146,6 +146,7 @@ static struct workqueue_struct *nvmet_tcp_wq;
>   static struct nvmet_fabrics_ops nvmet_tcp_ops;
>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>   static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
> +static void nvmet_tcp_queue_response(struct nvmet_req *req);
>   
>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>   		struct nvmet_tcp_cmd *cmd)
> @@ -476,7 +477,11 @@ static struct nvmet_tcp_cmd *nvmet_tcp_fetch_cmd(struct nvmet_tcp_queue *queue)
>   		nvmet_setup_c2h_data_pdu(queue->snd_cmd);
>   	else if (nvmet_tcp_need_data_in(queue->snd_cmd))
>   		nvmet_setup_r2t_pdu(queue->snd_cmd);
> -	else
> +	else if (nvmet_tcp_has_data_in(queue->snd_cmd) &&
> +			nvmet_tcp_has_inline_data(queue->snd_cmd)) {
> +		nvmet_tcp_queue_response(&queue->snd_cmd->req);
> +		queue->snd_cmd = NULL;

Perhaps instead of rotating the command on the list, maybe instead don't queue it in queue_response but rather only when you complete reading the garbage?

Something like the following:
--
@@ -537,6 +537,12 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
                 container_of(req, struct nvmet_tcp_cmd, req);
         struct nvmet_tcp_queue  *queue = cmd->queue;

+       if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
+                    nvmet_tcp_has_inline_data(cmd))) {
+               /* fail the cmd when we finish processing the inline data */
+               return;
+       }
+
         llist_add(&cmd->lentry, &queue->resp_list);
         queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
  }
@@ -1115,9 +1121,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
         }
         nvmet_tcp_unmap_pdu_iovec(cmd);

-       if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-           cmd->rbytes_done == cmd->req.transfer_len) {
-               cmd->req.execute(&cmd->req);
+       if (cmd->rbytes_done == cmd->req.transfer_len) {
+               if (cmd->flags & NVMET_TCP_F_INIT_FAILED)
+                       nvmet_tcp_queue_response(&cmd->req);
+               else
+                       cmd->req.execute(&cmd->req);
         }

         nvmet_prepare_receive_pdu(queue);
--
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
