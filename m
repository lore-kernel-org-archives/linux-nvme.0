Return-Path: <SRS0=Ql1M=JB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771FCC433ED
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Apr 2021 06:26:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7DD261247
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Apr 2021 06:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DD261247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CFWSo7p8ws8z9MYIhqDIagve1oWIJm/Sro6M2weFW9c=; b=VjZ39JjXDFxXj+HJNZdfUeiKc
	OZY5XzOWGXZG+TQoNv6bR3JBEMhFhrS8XRPsBkrhbCc+F5dipbA5cAIg8y9o9qzomgO0EpxR/H44o
	Bt4jEtsEWBKiXv4gHFlLdLAOdVkoejh5gc2CVLTgQLpkBS1TFAmbGxb5WGifV1XIHRDBTmjai/KaZ
	OP10vkvOjso/bXXGvJMUaHkopIlVI7wuAiCKwZYqP4kziG8UNjpdIomP35ppEkVLWhafZY9/z7F1O
	TokY+TiFTQ44j81vV0hWDhXooSKjexf8Y4eBNzCSr58f9IX2JoA5z0NqX89eavfhf+IQNrGUpbMtx
	gIIIGr47g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSwDE-00FTDb-F2; Sun, 04 Apr 2021 06:26:23 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSwCy-00FTCw-Qu
 for linux-nvme@lists.infradead.org; Sun, 04 Apr 2021 06:26:07 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1346DKhC014933; Sun, 4 Apr 2021 02:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=g8cQ8sGm/PYKdj3v5i/wK5lvDF5ELJNE1T4OmLB67Fo=;
 b=NMF8OJyRBd4J9hn7Uk6Kj00jTdEzvHqWE3MuaHsOhfC1CcVC62MqgbN/IOPE2mt0y62f
 pLVGKFdiY9oDgc9fWOueH+D/Nl8Ids5biutKmapK30RQUnvIPp9jh/7TW1oOY6cz4ueg
 nkU7bhiq7rk7Afk9LDf/aFZGrGG8tVmUCrzRnkZHJVGQU/4EhYa5mdn+fLYHMQ0NNdqh
 QAku/ygKa7JHqd9lTdS2139NC7eTEt91lq8PLJgauXVR6gBWyQ/g6e57cMMpjT+PusIl
 0Vj5BbZrrMTIJmKDDNtuKNOFrDXDNvEnem7rSwuxp8mDX83GZRArjTfKTORFOPYGa1u+ bg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 37q2nr8g1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 04 Apr 2021 02:25:43 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1346B8k9063057; Sun, 4 Apr 2021 02:25:42 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by mx0a-00154901.pphosted.com with ESMTP id 37q5cvh4jt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 04 Apr 2021 02:25:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4N7S/SDecSmQQOKiRiZ0fUsc5MTGUv8CcOm8Bqag1TkMAvFieilaqEqwmabVT6Kif4O581gpQss+Fx3x34Otojy90LpVcUy9zlNZTZ/RFwJqywpgDKOuZPja+b4Ek54F/53q3YRK5puF5IO1KWWXaK0c7STEW3Wz/ep+dvGuWAHpoMtCcC/ppafBKimfzESkM9CEcTzrN45J6lRaQ5C9gjdIlu21QQPBihkJi3kZnhZbqlPKv5PX3HtBj73ZKq0IJqzR2nZ0WYKjlQEOr5LOTTPhzKgdbmJux5uDkMGzCb+EeeVUYSIhtKniTA3Pvhv2vjBEJxZhKOZFNjfNIaQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8cQ8sGm/PYKdj3v5i/wK5lvDF5ELJNE1T4OmLB67Fo=;
 b=nZwIfat0N5QGp7sruyO7EGGOwkdHYLcNJWRRwll3RgAIZ70/D4ebfdyAU0hF3bK3t1NJd2t6t7xPDybOGXtr0Jv7mvIwR9xQAw8OOg+qAsM5+ns71olzaFlDUom9HGfsQpAHPJpxVyVihnqiHapORyhgo38Ya/0g5icqsjoIASQ3O4YH8Jyyys7DWGM0RRXtgULDSJv7dImvzdLDV/bGtL+pT/ch7OC8REnLZn9RZvivKDHmp/WpLWkW7Su5hZiH/LRgWuI1ymCgDVK0Xt6fnkzvXQ1BN/L1eFvc72gn+2LpBTvFj3Y0Caq7bSqSsJmMcDLrZvnAwihqaz8TWEWAnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BL0PR1901MB2020.namprd19.prod.outlook.com
 (2603:10b6:207:38::12) by BL0PR1901MB4676.namprd19.prod.outlook.com
 (2603:10b6:207:34::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Sun, 4 Apr
 2021 06:25:41 +0000
Received: from BL0PR1901MB2020.namprd19.prod.outlook.com
 ([fe80::60b0:a3ae:37b2:2e25]) by BL0PR1901MB2020.namprd19.prod.outlook.com
 ([fe80::60b0:a3ae:37b2:2e25%7]) with mapi id 15.20.3999.030; Sun, 4 Apr 2021
 06:25:40 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Hou Pu <houpu.main@gmail.com>
CC: "Anner, Ran" <Ran.Anner@dell.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>
Subject: RE: nvmet_set_error ignores error_loc NVMET_NO_ERROR_LOC
Thread-Topic: nvmet_set_error ignores error_loc NVMET_NO_ERROR_LOC
Thread-Index: AdcaQlC1JQMsBcUcQtuIzJaPGyvIQANUHGiAAGIRf0A=
Date: Sun, 4 Apr 2021 06:25:40 +0000
Message-ID: <BL0PR1901MB2020A5D62B69A2F276C180EFEE789@BL0PR1901MB2020.namprd19.prod.outlook.com>
References: <BL0PR1901MB20202EA160DFA04E828A3719EE6B9@BL0PR1901MB2020.namprd19.prod.outlook.com>
 <20210402073531.23753-1-houpu.main@gmail.com>
In-Reply-To: <20210402073531.23753-1-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-04-04T06:25:37.1860918Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=651274f2-b6c6-4485-8f37-8ad71753b061;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [152.62.109.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a079f197-1672-4f8b-0620-08d8f73277f1
x-ms-traffictypediagnostic: BL0PR1901MB4676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR1901MB4676457BDE78DFDC5DCEA532EE789@BL0PR1901MB4676.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sRgCaWPoUkAK6EC/teCO2B11SwqbUDzE0C/Dcsf5WO3ikjNbMs8aouanPJeTH9tiMa8EbqQpS3AdJ4OxVHkPdOweLuKcTV+n2sQWuGyuO91XW6KY9R3lbpf8yTG5ncEVFtLNOhinE1XR3zHk16vlnIARFN6JkhD2kSDLfP8UUYdFPV3qfxrEf4/r2w1LwmTLnzmVeDH0H54WKJfN9yqt4xYCPic0H4UNVerB+X/36BNIocJ0XutNmeSe+J9q1BZUHElSWGDDBGLVl3F7GqkOWanBKuwBMrBvY+iDZnzDdlub7EHr4LKx6HjAJI5k7VelqSP2XxlFseFXFanSUwy6G28zK/yasaOlY+pe+t7pSKZMVuALS8LCrzCHw3l0O+bryVrnuMHT8mikSlnVG5Iq1egcqvkGERfKH3lAbeJz274NV4X9tfx9s9XsnJdIlK9pZ1iW0zFAF6MWlHgqVetd7xTXg5Rt8MaNTxogs7lCsJ/lDKuF6o2pEwwXMRk76d+dAFwx43EdlCyteRA8MjvZKoafv79R3jx/fM2Guu4n/FPzi0uZO+ag9+Jp+N1CZynQ4/+qocIeQWEfpnT9W9FbMjDGsD5RqgDxvFFzsEwx8XgHSFuAPtQX6PombgjVVpZka2siQYGPQLlFZXLVeoLnf/0HcLIMYB/fi+7KWzIPNJA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR1901MB2020.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(66556008)(53546011)(66476007)(76116006)(4326008)(5660300002)(52536014)(6506007)(66446008)(33656002)(8936002)(186003)(54906003)(7696005)(64756008)(2906002)(86362001)(55016002)(66946007)(26005)(478600001)(6916009)(9686003)(8676002)(316002)(786003)(71200400001)(38100700001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8nP/7KC44692xBPHGwrHXC0I32I/OBEFVG//HNlDw1NwpRZFR1H6DkkxJb/K?=
 =?us-ascii?Q?ki/knd7cpE1V34Q1178cpRMPdqj7IMzBO3AQIHObX++Ei1jI7bhQBlgxufPt?=
 =?us-ascii?Q?ROwOMO9p43LnaMbeF19TImNbf3T+Z8erdDMTYP941R1zvWzATfq1bgeHn8hy?=
 =?us-ascii?Q?IGXMSVwe0AELFpZSMrLJ61tCSiWPC+y/b4RrALIzCL9jb5uTjyB+xkSH8e25?=
 =?us-ascii?Q?je3lCV+nzGcARusdOAjnKIh6ng7JSc9+D0wmaHi1N60zH07EjG4IT/03lzQL?=
 =?us-ascii?Q?xIKARn7c3JRPwLyZEOs7hzu2ahHbB3GcdBZ/0GBT3S2iKVUmiPWEbeIuUrSq?=
 =?us-ascii?Q?z/JP/+N+g07tca6+lW2u1VMtNMWtaT4NcJwdjSLh2H1MPqz0HygRFxK/sCsD?=
 =?us-ascii?Q?Kp4veQ7g9GPQtOcmC4v/bcZjbTtWK8F5nS38evLf2ww0LAsI+WawT7BQda7Y?=
 =?us-ascii?Q?6DQcDdorpHQZTuYJPRADCaMMObrT6EsDx9xM/wqtnk8fQzz8ER/xLK5e6cS1?=
 =?us-ascii?Q?GO4ANrVRjjVnZmXO57Mn8fpGjgG4YnwnMmBzwHgx2hRy4YbeCmcwH81hvqEA?=
 =?us-ascii?Q?IQtoZpE17qaQ4gPz1vlVWY6lWbe08sAYM7m/LB9Nj2GiKxO0nRF/fn6XQZU1?=
 =?us-ascii?Q?93atZ1Ye60pb8PJISBZNZlgQw8KRHvtWey0vojRNKKAKhUj8KUzyqQa9/e03?=
 =?us-ascii?Q?gyrT0T06QF50/UppPur7Ky3PhBkqVX2tZmnb4SM/2D7mMKZkiMdawVCqNQ17?=
 =?us-ascii?Q?9hnZEFbygTo1aDsSbqtxc+fVvMRSg3LMxH1qHiVLRxp0VnPKnj77ogcF6gDv?=
 =?us-ascii?Q?FIXdAteAHt5aZbBGrLDGeWRBuzM78j+cwyC8I7wTZuOMWzrs8v8EJoFvGquj?=
 =?us-ascii?Q?M8OP9R23c403m39utCgSC8ypw/z8G5TZ6SdKagaBTpMrcp+4VngedKO4+TFB?=
 =?us-ascii?Q?/+nkOy81lkY9rt2bmdDepVQpXyIqGbsy45hFhQetS04dNnfblS86S3CujVKw?=
 =?us-ascii?Q?INVQs9v1IxsXgBvFvXK5f2DVw8MnpfV+e02tJbebm9z9a+uzFlIC6xzIBy5j?=
 =?us-ascii?Q?bCS3VHJjTQ8kBFHkoEbcEQp6dztHc7cY4S7IsM3Gk5r0Ui5pRh6UDw+OfLZg?=
 =?us-ascii?Q?o1InhwZqWgvLsecJNyI9rm0b3rGUzo9Mh3/k6WVpRKGGK1PynmKqMOPWtEgj?=
 =?us-ascii?Q?pJSuoqIXVGP2mlGmCDJv/BNdBDxWBs2BVB+Zi+4JIqUmb60S14AjKVsjpFoH?=
 =?us-ascii?Q?sDae+pN4NRA3kDN/0W7Zb+lL/Ay1YK61/U+rDZQGQvs/jitpPK8DAh0hcyCz?=
 =?us-ascii?Q?9+q8atVjNSyiD0H3aEZEw1nI?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR1901MB2020.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a079f197-1672-4f8b-0620-08d8f73277f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2021 06:25:40.4875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1L6KoHqegL73JR/P5/VOXtXYCo9u8/SSloEbtxDzksKaOg5o98iDPsymUqHPJ2SKNImQRRG++zkw9Pj3XtnMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB4676
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-04-04_01:2021-04-01,
 2021-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 phishscore=0 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104040043
X-Proofpoint-GUID: kjUvxgSWgb_GbeVaQONiwrqHwmUAomft
X-Proofpoint-ORIG-GUID: kjUvxgSWgb_GbeVaQONiwrqHwmUAomft
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104040043
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210404_072605_404105_39669D4B 
X-CRM114-Status: GOOD (  18.94  )
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

nvme spec 1.4
Figure 195: Get Log Page - Error Information Log Entry (Log Identifier 01h)
Parameter Error Location:
"If the error is not specific to a particular command, then this field shall be set to FFFFh"

So as I understand, the error log may contain errors with error location value 0xffff

-----Original Message-----
From: Hou Pu <houpu.main@gmail.com> 
Sent: Friday, April 2, 2021 10:36 AM
To: Engel, Amit
Cc: Anner, Ran; linux-nvme@lists.infradead.org; sagi@grimberg.me; chaitanya.kulkarni@wdc.com
Subject: Re: nvmet_set_error ignores error_loc NVMET_NO_ERROR_LOC


[EXTERNAL EMAIL] 

On Date: Tue, 16 Mar 2021 08:57:08 +0000, Amit wrote:
> Hello,
> A question regarding Get Log Page - Error Information lid 01h:
> According to nvme spec 1.4,  bytes 15:14 refer to 'Parameter Error Location'
> "If the error is not specific to a particular command, then this field shall be set to FFFFh"
>
> In the current implementation, nvmet_req_init initializes 
> req->error_loc to NVMET_NO_ERROR_LOC (((u16)-1)) Then nvmet_set_error has this condition:

> if (!ctrl || req->error_loc == NVMET_NO_ERROR_LOC)
> 	return;
>
> means that the error log will not contain errors that don't specify 
> error_loc is that expected ?
> don't we expect that param_error_location log page field will be set to FFFFh in case there is no other valid req->error_loc ?

Hi Amit,
I think the specification does not tell us which error should go into the error log page (or does it?). It is decided by implementation and current implementation only records errors with an error_loc other than NVMET_NO_ERROR_LOC.

So the problem here is that:
If some errors which do not set error_loc should go into the error log page, we need some change here.

Thanks,
Hou

 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
