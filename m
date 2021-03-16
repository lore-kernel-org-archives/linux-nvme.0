Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF18C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 15:46:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57708650F2
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 15:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57708650F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HKMUP1rYjzOQTRXVqa5uZZGZXT5+gbejgQ/A104q8XU=; b=hXLpt9d4jzjo478v2/U0+9OEs
	IEPw4Iv5cmUnK5UHQDe+VR8quvaPJz/UYlpD4XQT26oQZJzSF9pK9B3epJPV6EPYW3r30CAoBt6nr
	M9GfYTi1tMBR21jm7wrLF6N0t6dHcgOIxzdyWPpFzBs+xHGG1t5EhCHfzL/POmdcIaL4s1lmDERyG
	J7ctJQu5JmC7C5VbMS+Ms8sK5Gj852th6e6no2TH5oeP12F0o5ZHqk9k13DBoEa+IN9MtGetngkur
	EdXIBOQGQGg2hxWz1nn+gDpthJeqLnutu1XmdblnhFwnat8Xd+e3ALmqo5Y2BSWBn2zxS/DocfFof
	/8vOnsykg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMBtM-0017Nc-KU; Tue, 16 Mar 2021 15:45:56 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMBt9-0017Jq-FN
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 15:45:46 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12GFhC6v011749; Tue, 16 Mar 2021 11:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=3Io71V8yoqsUPLv61S6HuvOM9SGsjNWDNCCs6HW06s8=;
 b=UaIFxALJ+asLmav6tDUs26smVOR1H40iNa6pVPkNZLBvA9DQ3AQ2PKsU/vry/BUDtzMh
 ug8ql3AfU8XcZAgWvIo26Ip5xc9Rd1S29S59twJLZnCc1dxQRZpj895C7TMvp5J63ZRf
 BT6tTH90Ahs+a5PWvP2Z2wooDjyehOhjB0oZLOrSHly+BkIYXd6ImQdCZAz+nQ6UQs39
 m9fbObbElTAxVbxwXKJoMjRNWqaRbK0JkEz45GJKNTbyjyoEF6R8xMSMqLvxkpFcg7jN
 WVVt79TmcGDgzun9c/vWzSNktIEgfF8Ha6JfUiqmH8uPLoR6i4F6/i035GmFrp5MJawU dg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 378sgch71m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Mar 2021 11:45:39 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12GFe6s9049918; Tue, 16 Mar 2021 11:45:39 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by mx0b-00154901.pphosted.com with ESMTP id 379b5ttv08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Mar 2021 11:45:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw3JmCBZeWCQFj4OZ1/k/Hoi00Fv0SALCCLLcJ9VLOQRBq3TLdYpM3gDnFAJCewh+l+wWi3NrlhzyCoLas1AUrRvnG6TW6QvIh6Gs96HMMZHJGbit/+5PRUkLtwG3Z80RMrYhOGy+8L8T9JQYlFwg1Eh7SjKOEESBQaGljpia/19R6fk6pmlnMxnFF6/OcPsrWbzGmearmmuvNnJShYVkT1OlVdNaJUGMkOdNqfNcqD2hpUeDkwaue/Ye1OSwmvZsxB1gP2c77GefuqVQYbZMTc94FmAwThzb39Rpp2JbDS2fRiHIo1lBGrtTj96YjJGvte0jqPAXr1q7FIhXNX12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Io71V8yoqsUPLv61S6HuvOM9SGsjNWDNCCs6HW06s8=;
 b=jpjCbus/mHuYxPsaLkINjptQXEGoxy4JdOO/kk5mftRFqPKdZqb+tgEUoHgxr2hRJvAYODcQF3hKLdp/hfz7EizIA3DXnZME/r3x2Zo73sPK3ugz3pRIFGne0GBzwVOgvemBF4i7T1ir/Th1n7vAgtl05Eklo7TQiKBMnQ1usGcaB98kpyZH5PIgsDsbXbRtWdQIncmmOGMHZeOPe1bq5BQU862FQ+M4mzPdOA6e9AZ5VhbMEYjVVKCmu1IUlMLBf7l+ICCtHslxlYoHHfwu0kkUY+VbZHAW+hFjdeyQFOZQm3CE3g02nubzgG0mzI210D4bIc6buaLxAFwRQXPc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM5PR19MB1642.namprd19.prod.outlook.com (2603:10b6:3:150::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 15:45:37 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%8]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 15:45:37 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
Thread-Topic: [PATCH] nvme-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHW6aKA9bVKdUdQXk+axFkWm5Fl+KqGheuAgACdheA=
Date: Tue, 16 Mar 2021 15:45:36 +0000
Message-ID: <DM6PR19MB401129067320A4B74CB68827EF6B9@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210113115152.69692-1-elad.grupi@dell.com>
 <28156d77-5346-03f9-bc3a-2c19417aa0d2@grimberg.me>
In-Reply-To: <28156d77-5346-03f9-bc3a-2c19417aa0d2@grimberg.me>
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
x-originating-ip: [87.70.20.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bbab5fc-34e9-415a-42bf-08d8e8928b25
x-ms-traffictypediagnostic: DM5PR19MB1642:
x-microsoft-antispam-prvs: <DM5PR19MB1642EA4E490FF38F80AFAC81EF6B9@DM5PR19MB1642.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R1GClXWsZE4i61zmznM0a8TzgXMFjK3mo2+14JtOJVSRENLTbC9djqY97KM5GcuezKeljYc2mjespWmbBufHLkVgMWpqvvY49sk4x7WnytLI9Z5wbgve3d6A2b81R7Y5VHv7k2rj2jb/adrBEb831hUDzf73xgHGh+IYBih+r4Y4q7arhuD7Un8P/Mc49GGbqAVfebMrZVOB/BINS8nn6t1VsUBmFHaFamqplY5ItGBySdzN+/SpMYPT+VLVE9CylzjLvONxzqbMwBzeNTs3GGco++R+r2QfDW24EGOfI1BgjIlMoVTVpdRW8NY3hS29E0xM0C3VMnz6aGHJrPUxAHnOsPQ2oGjOp3Umjis3Xehk7uT5PRXEm5vQVRzM3QCRGuKYixK0iOYu9q9CIpCqN5wKM8q9QZ1p13kxqQvo5uPl2sHFyXbDnzlAt7wZBKMArvpacJrqUES7ziUbNwKhVrr2E8SpgYUI746tnIyYn/DAKdfOjxNjCk04hH30+fNE3uttcwi7EzxwB4BKe0GUouO2TA3f5cmXkbtdTO54NQWp3WUpKuIdMQcyzGDIwxbU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(478600001)(786003)(26005)(55016002)(66946007)(76116006)(66446008)(6506007)(83380400001)(9686003)(66556008)(186003)(64756008)(8936002)(7696005)(110136005)(8676002)(66476007)(53546011)(316002)(5660300002)(86362001)(33656002)(2906002)(52536014)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?V2JCUUorYXR4U00vQUZwMU43RnNJRVlXc0hwdkRSd3lkN0VkbzRjNmdQWEVY?=
 =?utf-8?B?eTdPZHZoZ3UvR3FnNkltVWxCcXNmTjU3UFN5dU4xYnVEVkZiTWtHMmJqR1Yw?=
 =?utf-8?B?WWdLRGFocDByZXROUnVjOTVTZkRKWU5WS291c2hRdEd6R2Qwdm5oK0IzR2xF?=
 =?utf-8?B?QUZGL3hsRUUvMm4wQjJ6bFBhT08vNG1BQmltK2dYYk5Qam5HbHlEV1Y3czNK?=
 =?utf-8?B?RzhWR0F0WTV2K2Z4SlR2REZxczc5WkRtTE1uTzlMVlRsa3h6VFBHYmNrWVJJ?=
 =?utf-8?B?WWpYQzdCK1VXQU4ybmxGS1hLZDk4UUxzM2poK2Y0STNyNkl1ZVM3aTRFdnNT?=
 =?utf-8?B?SlAveVNVQlZtb2o3eXd5YUF0ZWxKWjg5b0VrZVJaVWxqM2kzYlZHbFlYV0tN?=
 =?utf-8?B?TUZlUmhSNEFub0lDRWs2cWZJZVI5ODkxcExTaUlGUlRBN0Z6b3NhdUFkL1lp?=
 =?utf-8?B?MmpoZkJ6cjl2VHZFa3FJVE8rV0F3YS84VEU3UHdYQXFqaEp1VEFLdzlwVzNF?=
 =?utf-8?B?SEVIbmRBUmZYQ1BydXovMUFNUUtweDJTQ1NnY1pkUm9ScWV4UWJwNXdZZStv?=
 =?utf-8?B?SjVSaFZsdnBHcVFDVlZraUQxZGV0aC9WTXhYY0RyTGZVTndBbVJ5VUJGRVRh?=
 =?utf-8?B?UnJ1WWc0aWJLVmVWMVRWS1B5OHVIbTM5SDRoS2hrdEJia1loMWRQeHdGaHB5?=
 =?utf-8?B?azBhd1FUODFOU3hZWG5OTWlCWGc1aEMzUHNoMXRGM1RqR1haaWM5ejJPSlF2?=
 =?utf-8?B?NUhwcjBBUTNLdUhQb0JmclJkdXpjY0h0MnZqS3JlU0xzOG9KamRWc2NVTUNK?=
 =?utf-8?B?eTMwTlB0Y0JLS0VMM3pTNDFMVFA5a0hEWVpHb28yWDFTbXQ4NEtueXZvSjYr?=
 =?utf-8?B?RGh1NkRVR3R2ejdKcWFaeCtheWVnVDM0V1lvbW92czNJUGJOd3dkVkl3NzA4?=
 =?utf-8?B?YzVEbFRnaUF2V3NSZWZxMTYvdWV3c0M0UzZJTTdkUndKOU9qU2gydGxvZVU3?=
 =?utf-8?B?S2c0aEVjVmZNS0k4b0luQTBqdFNHejV6TFZHWVRVcEdTdlVBczZnTlprbE9x?=
 =?utf-8?B?Qm16Y2Q2Z3lJS2diTzQ3UkNYZjFPN0pJNjcrbDRHWG1QMmQrUFlnUEcxSi95?=
 =?utf-8?B?WkdJNDRMaitkOEo1TDAvVVZKVDRkMnE5VW9sSHBuangvL0xrSm9kMXovaVNE?=
 =?utf-8?B?aFlxdm1kMHBJcmg2dnd1TUtuSnplQm11TmF4RXhKNWc4NWcvREVNVUltNUlx?=
 =?utf-8?B?cjJqc2pYamNCRWxoN1NmSXBEbExzaDFMdGZQTW11S1dYWHJHYUlHNHY5d1Rj?=
 =?utf-8?B?MG1RRWpaaUZiS2JjclVwQXJZZ3g2eVhyd3ZsVmpUcHpGNi9kTjRuS2FMOEhY?=
 =?utf-8?B?MVI1MlpDNDQ3aDVmanJFd2xLZVN2QjVmRXc3a0hZNVpvRlArQTVLbjhoeURX?=
 =?utf-8?B?b2tCQVVPcUU3Z0tXNDYwNkFNeURxZkNxNmZyRStwSVZEQWw2RnJ3MkZVbVdX?=
 =?utf-8?B?RW1rUnBHYnNzcDQwNURESkdFZnY3dGhEdlU0Q0tsZytJei9rcFhKVG92TGJU?=
 =?utf-8?B?VkZNOTU2YXlBbUNWVTBkTUxER01UdE1ZanVxSGJpdkFUYUd3TDV5N0plaUhD?=
 =?utf-8?B?WmZ3cXU3ZGpYL21NTnMvM0lsMkh6VSs4aVpIM2g5WWhObUJFVXI4TFJHSm9y?=
 =?utf-8?B?Q0FUaDd4SXhYRjBTdUNRTUZNazl1VGVzSWJZQlJXWWQ4RUUrYy9xYzNTSFdp?=
 =?utf-8?Q?cIguTcn1i4h3pPzYHg=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbab5fc-34e9-415a-42bf-08d8e8928b25
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 15:45:36.9452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ho/LFLppEa/Xb75w7+8GsZSqzIGAk7jUZiV0KhuQued/gOgaLdtzWBNaS8ePm5ud78p/Q59HDO7X4lV6TeynZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1642
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-16_05:2021-03-16,
 2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160105
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_154544_027989_DFCDAA1F 
X-CRM114-Status: GOOD (  31.19  )
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
