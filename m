Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7649CC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 08:29:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B365360231
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 08:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B365360231
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oNCkfXq5Gf3pmHreOuyZoSGE6eIZF5/Rc1NTCzwCBqI=; b=OhvjDXMevmB6vSuPk8mGX+NK6
	46bguu6UwdodCovcHSfQg6ZK8ue2JPRvGAGR+BzQB0SNNRWPAdpz+3weZ3G2YFtBMo+yD8Zh0y7pX
	6n9OpKhf54rLlxjuzTwBS59jWDor5e6h6hshEw/leYB+/y6Ysu0X06M7pJzVQZYA6aCdbsRSr/Pw3
	aJp0bMUIiXdDVXAxuqwzBl20Zohy5BMBrhYuhItgp7vZMKMriwbpWzerINA1R5CbqpILWYfhulMiQ
	RozmU/FA1ZUTC3R282RuGc6BdVrs4DVK3aH5bK2vCMjr4zt4FAa2OHKjtTjEwBNYJkYFJYX0kqWJH
	Iy3/XJT7Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRWDh-005wz9-H3; Wed, 31 Mar 2021 08:28:57 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRWDc-005wxl-N6
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 08:28:55 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12V8RI7Z008731; Wed, 31 Mar 2021 04:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=VidoAZxIFEL/8OPDIWjZc7BIdiP61vGQDQhLi2/dzEk=;
 b=LIaERZgj9yzSKVyiYC/dEM4gv1pXfZv/cp2GHLB5/HpjZ5Nsaa/6LxhFVPJamdNGPBbs
 ONY3rxpCazi+NWFrGS5j7n0oA93zAdMipcZ4cFeOJ3+oZEqXSpDTx7pZoj/JmxcD5i9y
 alGJV8lwphBkurwnk2U/XNm+I8MXh5mT2yi2yQIbCUuwDu/RDtvjkeyXHXiBYwpMJdxV
 mVhOrykx3RCipYwjmqDvOd91l9CBi/Z2MgIrytRk62dsDUbooTKDbFlddv/8IO3x6I6e
 wE8nabPrZPzhdxd/y6rO8pxyOS6tFHTG4LtHLvA16nuK+dd9xs/44ZW1OZWPpL+N8+EQ GQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 37mbqghrum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Mar 2021 04:28:48 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12V8L8vg180398; Wed, 31 Mar 2021 04:28:48 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
 by mx0b-00154901.pphosted.com with ESMTP id 37macpqsgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Mar 2021 04:28:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOrFlojLbk6NNcBvchP0LJwtYDGbcUqcpv6nqzVsG5pg7swNdaqi6kI9kWAZ8U1NHHjhyRKqNuapOvQ8/X7SQn0eo9EoZiLMDE7pc63J+QCajMtqeVYlXPEEOc9hUEo257UMyJKNRQNE4uNRblugqwlKjt60V0nuOihGfmlxeFEF07BfnPdU+nau+nG1iWhvlV8m+XYjc030i/Uz+rGfXXQlrpkvV8JecENBLSQf3xFUXCygnKNJtLef7ghW1xf4VizUUHwFy9kp/wshkSzKsqc4ljLs3mfdm+H4CzsC5xn8cwbd/ybdxugPDfMEwKIFevdGyo/jg8+MkjQgCfBBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VidoAZxIFEL/8OPDIWjZc7BIdiP61vGQDQhLi2/dzEk=;
 b=SDAl4vkan0qZq6gY7YfqZPqMH1VxzA3AHO97e/CPJtGz8l0kPVlcJJTnLK3/wRnFmZX1fg2uYzwalKDPfcN7lGNSOJ/3YRYHtrys9+D0DvkH0Gm2i307fWxZKdGM+hBK35fma8Lfn5EhpiVn0AtauQ6UsXrPq+ZrEryjx1W4nAX0txj72qN8xeFRE69hQp7GheQFIgQCz9Vrzi7klnOhP7rWxK0ueQU/OtAwPK24+0gbK0WjhGXQGlZVCMaoGsWkgwb3apcGID6XH1MaW5R0djQe6NFDx8hvWeJiLPMqZxaL4JA/7sJoH1Fr6te1Ms5eTAo3ocqWt6TTRkCpAo7dgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM5PR1901MB2040.namprd19.prod.outlook.com (2603:10b6:4:a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 31 Mar
 2021 08:28:46 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 08:28:46 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Hou Pu <houpu.main@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH v4] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Topic: [PATCH v4] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHXJYmFWNPDZWEGj0+lTpdIzo7CNKqduYcAgAAKYmA=
Date: Wed, 31 Mar 2021 08:28:46 +0000
Message-ID: <DM6PR19MB40115FE64DF309D2591B9879EF7C9@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210330172407.22936-1-elad.grupi@dell.com>
 <20210331074856.46966-1-houpu.main@gmail.com>
In-Reply-To: <20210331074856.46966-1-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-31T08:28:43.8188166Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=49b24b51-2b59-41c4-88f1-dd8ed04d4306;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [77.126.55.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd94b3c3-0e58-42fa-a52c-08d8f41f008a
x-ms-traffictypediagnostic: DM5PR1901MB2040:
x-microsoft-antispam-prvs: <DM5PR1901MB20405B0D7FAC62151739C5C7EF7C9@DM5PR1901MB2040.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XbVdOKQIvoVMYsfslh7GwXXYc+A1/5kuBO4neY3ZeYMC3FilJbYZ4aALFCOXBXyMlnu0rlISAVg0y5EDyNb4FbIlysvuw8unNN2tLDftTtZsiK//yi32N6BXtem29np94Z8kLhLtgLesfbmtzr/C1PVqCeD2NSCsIBKVUIyhGwhVi2HP8HRxKzwldTbrcN2pg9Wf7KDfRTf18AOIGrOkVn+CWHZdVCSu0S6ny7JRBcsXQTI7ezTFVE15rq8/0f8JoGZ9eOGFzgOfapmV7ZsypJ+eDhEGFo4a6NaFs/sSW9HBeOwRwR6eCNMyJ7VN513QbgXbJQrcVMn6DrSeJem1xj6Wl7K3tertoMMItjKa8M7W7gFTDgJV5xquimYAcbZbbybFLXY0kni56SXiHNogxt7sHlVMDNF5cfIkzE5aun5PyLtCV8URSvcm4nTRDZzT7x0NmhQe9xm5cceGLpifthpA/aBr+cH7Tw9zXZtUXeGHnb/2zyPXoBeh3f5y3ObNUlmtc43xTc/y/UT8jUn8OoyV2wp3/51WGpB5ZvrPud1vzQikrNBpYN9o6AQba9Q8EnZ1tceybHwPPQJM0f0p0BPACt9QtdCcHwNBoyvRly8VgdGbKSFvj+qGXF6vVWmQPQWEJtibWlgz59hrwiioCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(52536014)(66946007)(186003)(26005)(83380400001)(53546011)(6916009)(76116006)(8936002)(8676002)(33656002)(64756008)(38100700001)(6506007)(786003)(4326008)(9686003)(66556008)(86362001)(71200400001)(54906003)(7696005)(478600001)(66476007)(2906002)(55016002)(5660300002)(66446008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?MWk0OW5yN3NORVU3VXBQTXpyaHhwRDUwZ0lhdnh5Nm1Xc3JkSUt2NWxTQVov?=
 =?utf-8?B?TVdCaG1nRW8welNYTk90SVlUSnRDOUJmaTVLWmRQeVNaUnBYYVZhZmVFTEpR?=
 =?utf-8?B?bTJQWUszektNaU9takQ3TVFRa1BDTklGbTBDejJDdVRONHU0UkpPSjRHSTZn?=
 =?utf-8?B?bHZOZmFEY25YNFlQOVp3Q3R6NXQ0aHFPZmJhMGRaVGZNU0JFaTFYZTVROGRB?=
 =?utf-8?B?cnMxeno1ZGFaQ0wzYlMxYUxONmxNOXpOaFRnZUFLK05mcFVnZ1lvaDJvcUYz?=
 =?utf-8?B?RmZra2orMkdtRU9tWXZOa1J3SHpFTWxpbjl4UmxqZVV5dEdoL2JpRm5RbERO?=
 =?utf-8?B?UWEreFYyakJqa1BEeXJ0TkRNQjVlOUlMSnQ5d2ZKU0ZIQU1zS1A2UVRyVnAv?=
 =?utf-8?B?cThqQ01tVkZuVngvekU4bzRDa05QN1Z1S2kwelVnbkJ1Um5XelNVUWhDeWJx?=
 =?utf-8?B?M0NiV3AzSUVnVXVUMkJkUzRIYTUrMGxwc0o5bkluZTJrL1FHNjRlbTMxcUZO?=
 =?utf-8?B?OVRZc0dvZHYrMFJpK1dtSmkrK09nOG9mRzhGbU9IdFpoaGlUU3BnbHBPVjlR?=
 =?utf-8?B?cnBDU3EwWm9RYnNZbHZTbHFER1kvUkZQTjFtM0MzUXk0ZG1qN211Y3BGL3RC?=
 =?utf-8?B?Z2h5S2puSHZ2K0lnRlB6VzZPOWlpUkpzSDZCMnhsRlJwejF2TGxJTWppNDVU?=
 =?utf-8?B?TFdmblFrWUFtS1lESEVOdmxhdWQxRXB6cHdWRXp1Q2JrMTNoa2VRYytmeUx0?=
 =?utf-8?B?MkZJdVFCT201a2VMVVdmOVA5MCtqL3NSeWxWSDlyaVZtY1NiV1cwR1ZIZWI0?=
 =?utf-8?B?YVd3aDExT2xQRVZsY2lSZ1BIYnlDaG1oVGxuZzhiMDZRNDZ4UlMyN00wTkxC?=
 =?utf-8?B?NlpDNG05bElZdWRaZXVWbnJuaGJZNjRoUDRQRllqUmk5VmhXNS8yN1Rld1Bh?=
 =?utf-8?B?bkQwL2t0VFlZbmxkdENwendaVy9WaXEwN1R0UXBPcTY0VTRFZFV4bmRzSXFz?=
 =?utf-8?B?dkpKVFowZ1pNd1RoYW9kS05tam1DdmdYMm9YWjFmRm1EbDdMZTdiY2Z2ZFpi?=
 =?utf-8?B?T3RJeHdvdkUwU2VneVFmRW9hRzg1eU9IRjkremVvamlUWmdJMGxxQ2tqZHRp?=
 =?utf-8?B?L1h0MTJ4M2tBMlpMU1BZZlY3QVVNUElBQTFtaEh2NXo0V3VYallLc3ZFQzNs?=
 =?utf-8?B?UDUrRG1mSCtyWDFBWHVVSWo5VWs5M3d1ZG55emdmQXlQd01MMFBuellxVXJI?=
 =?utf-8?B?ZzQ4bTFWaHVWTEJaWjRSSW9UTXFoK0x0aFJEYm9SRklCTSs5QWdpamdmK1dW?=
 =?utf-8?B?M2ljSWVna3FsSDN1NXB2cWpjWUp3SnR4MHR2bmlTbkVnelZkMTFvS1Frd3FX?=
 =?utf-8?B?d051ZXJmbXVXRmFsWEVNK0UyS1JiQk1zMWhpeU0ybThIeUxnSm9xQlByK09F?=
 =?utf-8?B?cElDV2IzNmJjVmNRTGpnYUJsVFVsNWJnS2ZZRUk4SWx0MTNpN1I2dFBiU29Z?=
 =?utf-8?B?WjhaeHlJZDZ6QUU3UmczRy9EbURGdDUwTVdldVJiNyszdmJwaDBwVEVNdlVi?=
 =?utf-8?B?T1A5VlBzQzU1Ny80Qm5oRHRDVURoVDdZaG9PZnZVZXZsNzJSUzdUYmlRNzdh?=
 =?utf-8?B?c29ZNTJLNG9TZkIwQ0UrRGUvRWpoaXo0UWowQjZEM1Q4R0Q1YTZFS1pUK1kv?=
 =?utf-8?B?ajFLU0RnVk5pYUFjZDBzeTkxcXdFMHB6VXhNT25iYnRvRktVYkFOWTI1dWlV?=
 =?utf-8?Q?R6nwPAdRlLwaQskBDcnVl8xSB77yRkhqN9dkx+9?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd94b3c3-0e58-42fa-a52c-08d8f41f008a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 08:28:46.2318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: keSpOTDRCHH64Q5jo2/1Knw6kI8fXiA6+4OUrKedVADeb+QuXCk5mn4J0wmDMv3sMdmBBXqOEJwKyQtNmK8VpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1901MB2040
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-31_01:2021-03-30,
 2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310060
X-Proofpoint-ORIG-GUID: 4o2pZ4AHaBUbfmGiWX2suBtoY2u4SnrU
X-Proofpoint-GUID: 4o2pZ4AHaBUbfmGiWX2suBtoY2u4SnrU
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_092853_186205_B2685411 
X-CRM114-Status: GOOD (  17.87  )
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

Not sure I'm following.

Once req_init is failed, nvmet_tcp_handle_req_failure is called and changes the state to NVMET_TCP_RECV_DATA.
In state NVMET_TCP_RECV_DATA we should not queue the response before it is get off from the list.

Am I missing something here?

-----Original Message-----
From: Hou Pu <houpu.main@gmail.com> 
Sent: Wednesday, 31 March 2021 10:49
To: Grupi, Elad
Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me
Subject: Re: [PATCH v4] nvmet-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 

On Tue, 30 Mar 2021 20:24:07 +0300, Elad wrote:
> @@ -960,7 +981,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>  			le32_to_cpu(req->cmd->common.dptr.sgl.length));
> 
>  		nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
> -		return -EAGAIN;
> +		return 0;
>  	}
> 
>  	ret = nvmet_tcp_map_data(queue->cmd);

Hi Elad
By returning 0, the response is queued twice before it is get off from the list. Even still returning -EAGAIN, the cmd still could be queued twice potentially.

I think we'd better not queue the failed cmd in first place.
Please see my following fix later.

Thanks,
Hou
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
