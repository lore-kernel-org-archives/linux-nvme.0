Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA243C6FA86
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kcc4GLsvhzClZly9suaO7QvoRi2qQ3JC23nOnWwoTIA=; b=UKUpnTqf8RlsVLSuUNIxyEgx73
	RiNfkeU7+zSy1YIoGaF9853MOecGAcpFi94XauECL6p6FFUBWI9ejCi8gjyceUnYdv5sgt/vrNBN0
	WnVksz/Wbojt1/F1ZxqECVqkMAmQj+TW77nEwVOogMxo9CZH+3UOeG+RzdR9V2lrWqjiH6BaJXWnt
	KhlEzYqHKnH7BmihokWqkhWDNjue/VNcM8dfxwXDVwbWRV5JCpq57mrUnfpwM2V3/yZtMS4NWYGj7
	0ep9ILqQF2rtgXNmZFdeWlIaty7F+h+vDRB3Y25RqvE3bRrWLyicQV3JbRDp6+X/q0kabckLqShfD
	aNoG2Yzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVb40-00FAoW-Lb; Tue, 06 Sep 2022 16:04:36 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVaZc-00EqAV-UT
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 15:33:17 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286CrMRw009305;
	Tue, 6 Sep 2022 11:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Kcc4GLsvhzClZly9suaO7QvoRi2qQ3JC23nOnWwoTIA=;
 b=bfY7rqpAAnvdCPnIk15QDx19/quu7BFixQ58CpEcU+hZYyQy3J5j4Dz0muaHwcMETedC
 RbTswTf0YT3e04DudW+JGQqv+apfRaqpvHLu5viPzlpGVFBkMwr5ne59Q1FLUWU/pVfO
 LmO7Aj4MAxE/3uHRwmoySqdrX6WsSoHl3HHeBJA1K493yXPQKb2p+ofA8j9IpDXrJvP4
 4dNDjv65DOgbFMlI+EcsTR7CoPsn98vXBliRqrIs4GVjjJDrc6itr6o92wVeM+4tNd8z
 DiQyyHtl58BMrcG+1wODTQdv00v7OQPMYKKretGcR2P9eo1ztLmZ9sS4VMvxB0A/tALu lA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3jc259b5au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Sep 2022 11:32:51 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286FQVjG005678;
	Tue, 6 Sep 2022 11:32:50 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3jcktynhb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Sep 2022 11:32:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKRNBfuK5VgJUAYusLQCyWq75poreHaJr34yjPSJvF27yaqCSX/99voAZAU0tXnEgiCP1pwAPs2LFcwOTVn4E66AnXVbT48yGmoUi29UpY3sj5Xgc++n3tYqKOudkFiejY/6LSMfGjVYW3RkfJFpWC+2xngXol3svWWSEslz3wIQWvb3ONxN3kmlW7Mp6/0WWc1V2VHWit/Vzf7dENKCRG/t1MgWEhVSc4SpjFpgTBAkpCbL4kODUxIpT3/dWGzDO69wyk0N27i+7O15beE3AGEztIoM/Kbe/FylI907Gg+RjuZDKzdg8U8QVE7ExtSeIBvgJNy8AdArEmS8sd0Bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kcc4GLsvhzClZly9suaO7QvoRi2qQ3JC23nOnWwoTIA=;
 b=JTktgCAvtFMNby1WGPxniHR48Qq1WL5zjeGst4L4QiirDbRo1MQLKKnOEIOXYGpFWjtxN9nh0Yb3odebowqHS6tOitrbp3F6+36phn6ap60WahBjM0D9sT+uUOqbOfKxVFmahqbLOhZJFzVAflA04ismsmKfT6ijnbLd+RztXtqbb9rK4LRuyZicm/uGFnKJR5p8tc96uMshyWmp3qQV+rrwpwqseDZc7POFe90yC3cSXvcnu4/+vzGfPtr4CoYVmQDkerQi2Icu7dWLYYifCtqpoJqb1AgqZFGbeVMrO2sysluPsxJzl5SXkZ6Mm2UXxaldLgj5POpsOdwtO9VI6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by SJ1PR19MB6209.namprd19.prod.outlook.com (2603:10b6:a03:488::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 15:32:47 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::ed2f:81cb:243e:72c5]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::ed2f:81cb:243e:72c5%8]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 15:32:47 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Martin Belanger <nitram_67@hotmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH v3] nvme-tcp: Print actual source IP address through sysfs
 "address" attr
Thread-Topic: [PATCH v3] nvme-tcp: Print actual source IP address through
 sysfs "address" attr
Thread-Index: AQHYvteZ8MDcNF5ar0CkdLJO3LxfEK3Qd70AgAHiM6CAAAvOgIAAI3pw
Date: Tue, 6 Sep 2022 15:32:47 +0000
Message-ID:  <SJ0PR19MB45442094F8606D2371CEBA69F27E9@SJ0PR19MB4544.namprd19.prod.outlook.com>
References:  <BL0PR13MB42919EA6B50B34A1A60455969C7A9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <e98a1c28-4994-470d-6fee-ed569de536ed@grimberg.me>
 <SJ0PR19MB45440F0F979FB14315AE6B4DF27E9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <c9399436-3d45-90b0-731a-6baa0605f918@grimberg.me>
In-Reply-To: <c9399436-3d45-90b0-731a-6baa0605f918@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-09-06T15:15:15Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=d994cbb7-3f0b-4483-a1a0-e8af36193798;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b129b57-d61c-4da5-f711-08da901d0cda
x-ms-traffictypediagnostic: SJ1PR19MB6209:EE_
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  fLyh8mFIY/xSahTDcQTPv8q5oEPA3REnc+iTlIWkLGDcxrYmo23sKZyWr4TA310EDBl7/GkKZaHjyrJLROyEl4i0WE61UTEf9Q/iJw6Oe4sQWtfbU8GRDTMsOD37SbIeMsx+xhoRUmpzEk3BHJlheqV70JZ+3nzUqobt91qS40EA/gFRlLXhk2OH/vLqtR3AV789LoRnx+Pd1c/dVqfHqfiBZJrbJ03r0uPEVXk31BmlXEkh6YF0y+Ef/mIqm+ZR1AUsMiL6HrqasEO62o2kmR1pZkEOJc7UmtkN4v/loxWUfSdplOmAUspLHUUUovboBQxa2Gij8Z3xJl8f4OtFF9uLNeZ7Yj+IxCQhh8s461aK05v0b0mJsIERFvBjasrj7Bna5ur9HBX97bjd/Lpv+hJ265cbbGC8mF1H7G+/y4dTgEfs8cQtbxMSfIJb/mwrpXSUjgmUzFcEZ9A39Ml8Q4DKBPdWh+lKmZc4J9RD6G7T+WzsG8F4xxqiu/WevDce5hxA1kZ+G+c1mse3k3RHeioI39Tk0rChnVpWGK+yVF41uD02TfcpsLv0E0Hw8pRYEypHOHBqrbs5LmSvDvU7y8PWWrcjbll8b8cE44sJjEbOh4eTfY55rw4zUdsTn/F72Mn0HfYG+nCoxnZyCvVa5E5vJClQ3AtZmvKGK5ymOrrdAOHeEYY6cYGEEiaiFhQh7MBYnHRSu5btgIoAwswEdMD5W0HdUkGLNdplrwGUG1SJHcXZKZQ09GfXcVpbOAfmstWpmENKTRkX7xN1gN+KFg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4544.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(8676002)(64756008)(66446008)(66476007)(83380400001)(76116006)(66946007)(66556008)(38070700005)(4326008)(33656002)(6506007)(7696005)(478600001)(2906002)(5660300002)(26005)(9686003)(8936002)(186003)(52536014)(86362001)(41300700001)(316002)(122000001)(786003)(82960400001)(55016003)(38100700002)(71200400001)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?SlViVDlubHliNCtQZkkwa2F6M09QRVZrenNVUE1NUFZ6YldPMXdhK0lvcWVT?=
 =?utf-8?B?MkhUZGgzNHpaV01iUmtQNGlwR0FJdGViV2hQRFlDTjNHRUwvMTJYeng1Sitv?=
 =?utf-8?B?ekFnKy90d1JGbzhWRERmeVh1YVZyckNxOHZTeEd4bk1oak5kZjRlRnZTWE5U?=
 =?utf-8?B?ZnU2aUVtT0llbWtmUis0bVF5NFd0K2ZSZXkrVnNBYkQrWkpHalFrMHl5QTMw?=
 =?utf-8?B?THd4d2tCOElRV2h1MXJHbmhIUlliQVNpUUw2OWx5eWhXekdjYktGS3VENVJ3?=
 =?utf-8?B?TjhYOTBreHNJdlR3NFU4TnhKWEtUUmRZT1N4czR4bklWMllrRXRmWGkwVUpU?=
 =?utf-8?B?a2JIdWdtQWdhNWZKaDdPUWlmVU9qWDFnRWIxY3FSZXE4N1lVNTliZ2RBQkVv?=
 =?utf-8?B?ZldJVlc0UlBUMFRXNVNOYWVpU0RGWVBNZzRHMDF2QXp5MHRmemkzS0ZrTlFl?=
 =?utf-8?B?VkVzRDQ3THFSdkZ5ZWQrWm4vN3lhU2ZsT1Fyam5TdGROVTVncTduNURXMG5r?=
 =?utf-8?B?OEJzTXpXYlFaemlrcmhTeC9vVHVqV1JRQmZoUlRzVEFXVllLeDJGdFk1bW13?=
 =?utf-8?B?ckhxaGxFYyt5UTZPSEVOaHBMUEorOVRPcjdWRExKMHRySC9SMXpLWTVxZG5R?=
 =?utf-8?B?c3VZT0xnWE9oUGhZQVpnMUdrNjh2Ulg1YndFSFM2R3VQMXpvNXFhUVJKaldn?=
 =?utf-8?B?UmRmaDd2T2xQU2V1c3Zkam1nemVLUTgrR1lpbUVsUHdRSjREUFNYL2o2L3B2?=
 =?utf-8?B?N1lYZGl2ekVTVDhmaXZjVVRNaFpHK2gxQ0dNcW9xVUxrR3NwYytOMnBOOGJo?=
 =?utf-8?B?NE55cGgzVHh3UUlzbkZBWExnMGppZ3VJYm9kSi9RWklnVnJkTjI1UExndUZM?=
 =?utf-8?B?Y3N5QTF1Z1RhVHdSS2V4WTVPVVdVQXlSMi8yOFc5bm1EMDBLS3Z6ZzhSK0dX?=
 =?utf-8?B?bzdvdXozRWdYb0o4bEw2bWhjbmNhTlJ1VUFPRlBpUDlhNkhCbG41K1pEMFY0?=
 =?utf-8?B?OFliZlQxSU5GVXh3WDM1NTRTelo4aUlXdzJuUklPNW1uYjZZNW9HVUMzMzlq?=
 =?utf-8?B?djd5VXJSc3ZvQ0t6aURSc2sxbkZoWkVKbmZRcURBS1RmQkF2K0RZZnpYSXNM?=
 =?utf-8?B?bmdreG15blN0VWJrTlZoZ2c1eU11M084MWpMNHFHVjhDNlZCRW5xQ3dOOER3?=
 =?utf-8?B?VmNxNUIrQlhUb01IYUFTY0dFaldCcFh5ZHEyNVcxcVA0cWNOZEowZ1Vsd0lr?=
 =?utf-8?B?RjFFUWZRS3orZHQ1ZmhJcnBNYXNYTExqRW9lTVFqNTMwNW12NGx0ZW1KWVdx?=
 =?utf-8?B?VnFMM051TGNTUzh2RG04cTV0d21YQ2s5R0E0dkl1Uno2dnJHTFlnNVh4c1hp?=
 =?utf-8?B?UjNKQ1pNNTZpTVBIZ3hHK295aktGajRlaFI3dzZTUzZ2NFZleXhab01KT1lx?=
 =?utf-8?B?U0sxU2RCTFA0dUs4TmVRVCt6aktvWXFxRnRxZEpNWGFLV040TTFQZE83djFz?=
 =?utf-8?B?bWxnTEg3dTNIRERhVTlpSHVDSUhSZXVoVEFCKzhGaUIwK0c4dTRkNStRN0VC?=
 =?utf-8?B?RWZ2dG9aZHlqZ1pwZ09wY3hIb2xybnlVeWxGRGQ4RVVkcXFlMnJFbnFOZ1E2?=
 =?utf-8?B?MVVxYmdJU3pPRVV5QS81RUtpNnMvTE56dEJhNTF1eUJOK3RySExobjRNczRy?=
 =?utf-8?B?Y2N3M1pBbDJBNnNLY2x3V1VVV0lIdytRMU5sUFpJUXJVcjh6a0k5ZnY5ZlpD?=
 =?utf-8?B?djNPYllwQlg5MlRJdVVnUmJYTi85OVB5NitOdW45NGVsT3diZnZtcHhPWEdh?=
 =?utf-8?B?MGhmb1psYlFyVGZzRmRlRkY4TFFQWUZ0Q052VTdpV0t3YUxwWjJEWmY4Kzgv?=
 =?utf-8?B?NHBHZGFDTkRDS0Rsa1VDYnhHbzcwZEdhcDE1WnJrQ01yc1gxMUZ5c2NCRVFk?=
 =?utf-8?B?MzVMbEVpZXhxcytHemJtbkRCM0lrUVlzcnFjd0Y1cWswUHdsam81aEpTais0?=
 =?utf-8?B?dWx4QmNjNEV6UUY3ZGs0OERld1VNVnpWVXZsVVRJZ0FsTWs5a1hCWGZaZUg3?=
 =?utf-8?B?MHN6TWx6Y1FRSXlQRlh4cnltSGRNQTcwTEJ3ajhZWlAwaklaVFVrdHRPSG9E?=
 =?utf-8?Q?/vI2wPBwLfPVw+VwdeXVO3nek?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b129b57-d61c-4da5-f711-08da901d0cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 15:32:47.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +v7dKAltAzXax8gPO3CQLm8SzzpinbnXQvUCpyXn1v4qnnBm+/+lFPVUn15hlLkL8yxa7F8tCOwAD8Umi2OTYx0/m4M7N9S4dDo+RFQbqv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR19MB6209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_08,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060073
X-Proofpoint-ORIG-GUID: lN-IDjInfJq3q_32xQ6y_QHw-gi4LHTD
X-Proofpoint-GUID: lN-IDjInfJq3q_32xQ6y_QHw-gi4LHTD
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060073
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_083315_188244_AFC14E98 
X-CRM114-Status: GOOD (  36.04  )
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

PiA+Pj4gVENQIHRyYW5zcG9ydCByZWxpZXMgb24gdGhlIHJvdXRpbmcgdGFibGUgdG8gZGV0ZXJt
aW5lIHdoaWNoIHNvdXJjZQ0KPiA+Pj4gYWRkcmVzcyBhbmQgaW50ZXJmYWNlIHRvIHVzZSB3aGVu
IG1ha2luZyBhIGNvbm5lY3Rpb24uIEN1cnJlbnRseSwNCj4gPj4+IHRoZXJlIGlzIG5vIHdheSB0
byB0ZWxsIGZyb20gdXNlcnNwYWNlIHdoZXJlIGEgY29ubmVjdGlvbiB3YXMgbWFkZS4NCj4gPj4+
IFRoaXMgcGF0Y2ggZXhwb3NlcyB0aGUgYWN0dWFsIHNvdXJjZSBhZGRyZXNzIHVzaW5nIGEgbmV3
IGZpZWxkIG5hbWVkDQo+ID4+PiAic3JjX2FkZHI9IiBpbiB0aGUgImFkZHJlc3MiIGF0dHJpYnV0
ZS4NCj4gPj4+DQo+ID4+PiBUaGlzIGlzIG5lZWRlZCB0byBkaWFnbm9zZSBhbmQgaWRlbnRpZnkg
Y29ubmVjdGl2aXR5IGlzc3Vlcy4gV2l0aA0KPiA+Pj4gdGhlIHNvdXJjZSBhZGRyZXNzIHdlIGNh
biBpbmZlciB0aGUgaW50ZXJmYWNlIGFzc29jaWF0ZWQgd2l0aCBlYWNoDQo+ID4+PiBjb25uZWN0
aW9uLg0KPiA+Pj4NCj4gPj4+IFRoaXMgd2FzIHRlc3RlZCB3aXRoIG52bWUtY2xpIDIuMCB0byB2
ZXJpZnkgaXQgZG9lcyBub3QgaGF2ZSBhbnkNCj4gPj4+IGFkdmVyc2UgZWZmZWN0LiBUaGUgbmV3
ICJzcmNfYWRkcj0iIGZpZWxkIHdpbGwgc2ltcGx5IGJlIGRpc3BsYXllZA0KPiA+Pj4gaW4gdGhl
IG91dHB1dCBvZiB0aGUgImxpc3Qtc3Vic3lzIiBvciAibGlzdCAtdiIgY29tbWFuZHMgYXMgc2hv
d24gaGVyZS4NCj4gPj4+DQo+ID4+PiAkIG52bWUgbGlzdC1zdWJzeXMNCj4gPj4+IG52bWUtc3Vi
c3lzMCAtIE5RTj1ucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzcy5kaXNjb3ZlcnkNCj4gPj4+IFwN
Cj4gPj4+ICAgICstIG52bWUwIHRjcA0KPiA+Pj4gdHJhZGRyPTE5Mi4xNjguNTYuMSx0cnN2Y2lk
PTgwMDksc3JjX2FkZHI9MTkyLjE2OC41Ni4xMDEgbGl2ZQ0KPiA+Pg0KPiA+PiBJIHdvbmRlciBo
b3cgdGhpcyB3b3JrcyB3aXRoIHVkZXYgZXZlbnRzIGV0YyBmb3IgYXV0by1jb25uZWN0PyBhbmQN
Cj4gPj4gYWxzbyBmb3IgdW5pcXVlbmVzcyBjaGVja3MuLi4NCj4gPg0KPiA+IFVkZXYgZXZlbnRz
IGFyZSB0cmlnZ2VyZWQgYnkgZGV2aWNlIHByb3BlcnRpZXMgKHdoaWNoIGFyZSBub3QgdGhlIHNh
bWUgYXMNCj4gYXR0cmlidXRlcykuDQo+ID4gVGhlIHByb3BlcnRpZXMgYXJlIGZvdW5kIGluIHRo
ZSBhdHRyaWJ1dGUgInVldmVudCIuIEZvciBleGFtcGxlOg0KPiA+DQo+ID4gJCBjYXQgL3N5cy9j
bGFzcy9udm1lL252bWUxL3VldmVudA0KPiA+IE1BSk9SPTIzOA0KPiA+IE1JTk9SPTENCj4gPiBE
RVZOQU1FPW52bWUxDQo+ID4gTlZNRV9UUlRZUEU9dGNwDQo+ID4gTlZNRV9UUkFERFI9OjpmZmZm
OjE5Mi4xNjguNTYuMQ0KPiA+IE5WTUVfVFJTVkNJRD04MDA5DQo+ID4gTlZNRV9IT1NUX1RSQURE
Uj1ub25lDQo+ID4gTlZNRV9IT1NUX0lGQUNFPWVucDBzOA0KPiA+DQo+ID4gVGhlIGNoYW5nZSBJ
J20gcHJvcG9zaW5nIGRvZXMgbm90IGFmZmVjdCBkZXZpY2UgcHJvcGVydGllcyBhbmQgdGhlcmVm
b3JlDQo+IG5vIGltcGFjdCBvbiB1ZGV2IHJ1bGVzLg0KPiA+DQo+ID4gV2l0aCByZWdhcmRzIHRv
IHVuaXF1ZW5lc3MgY2hlY2tzLCB0aGVyZSBpcyBvbmx5IG9uZSBwbGFjZSBpbiBsaWJudm1lIHdo
ZXJlDQo+IHdlIHJlYWQgYW5kIGNoZWNrIHRoZSAiYWRkcmVzcyIgYXR0cmlidXRlIChmaWxlOiB0
cmVlLmMsIGZ1bmN0aW9uOg0KPiBudm1lX2N0cmxfYWxsb2MpLiBUaGUgY29kZSB3aWxsIHNpbXBs
eSBza2lwICJzcmNfYWRkcmVzcz0iIGFuZCBleHRyYWN0IGFsbCB0aGUNCj4gb3RoZXIga25vd24g
a2V5cyBmcm9tICJhZGRyZXNzIi4NCj4gDQo+IEknbSBjb25jZXJuZWQgdGhhdCBhZGRpbmcgdGhp
cyB1bmNvbmRpdGlvbmFsbHkgbWF5IHRyaWdnZXIgc29tZW9uZSB0byBmYWlsDQo+IGR1ZSB0byB0
aGlzIGFkZGl0aW9uLi4uIEl0IGlzIGFsc28gY29uZnVzaW5nIHdoZW4gaG9zdF90cmFkZHIgaXMg
cHJvdmlkZWQuLi4NCg0KVGhhdCB3b3VsZCBoYXBwZW4gaWYgcGVvcGxlIGFyZSB0ZXN0aW5nIHRo
ZSAiYWRkcmVzcyIgYXR0cmlidXRlIGFzIGEgInN0cmluZyIuDQpJbiB0aGF0IGNhc2UsIEkgd291
bGQgc2F5IGl0J3MgYSBidWcgb24gdGhlaXIgcGFydCBiZWNhdXNlIHRoZXJlIGlzIG5vIGd1YXJh
bnRlZQ0KdGhhdCBhbGwgdGhlIGtleT12YWx1ZSBwYWlycyBpbiB0aGUgImFkZHJlc3MiIHN0cmlu
ZyB3aWxsIGFsd2F5cyBiZSBpbiB0aGUgc2FtZQ0Kb3JkZXIuIEJ5IHRoZSB3YXksIEkgYWRkZWQg
YSBuZXcga2V5IChob3N0X2lmYWNlKSB0byB0aGUgImFkZHJlc3MiIGF0dHJpYnV0ZSANCm92ZXIg
YSB5ZWFyIGFnbyAoTWF5IDIwMjEpIGFuZCBoYXZlIG5vdCBzZWVuIGFueSBuZWdhdGl2ZSBlZmZl
Y3QuIFllcywgaXQgY2FuIA0KYmUgY29uZnVzaW5nIHdoZW4gaG9zdF90cmFkZHIgaXMgcHJvdmlk
ZWQsIGJ1dCBpbiB0aGF0IGNhc2Ugc3JjX2FkZHIgYW5kIA0KaG9zdF90cmFkZHIgd2lsbCBiZSBl
cXVhbC4gSW4gZmFjdCwgdGhhdCdzIHRoZSByZWFzb24gd2h5IEhhbm5lcyBzdWdnZXN0ZWQgDQpv
bmx5IHVzaW5nIHRoZSBob3N0X2FkZHIgYW5kIG5vdCBpbnRyb2R1Y2luZyBhIG5ldyBrZXkgKHNy
Y19hZGRyKS4NCg0KPiANCj4gSWYgdGhpcyB3b3VsZCBiZSBsb2dnZWQgYXMgcHJfZGJnIGluc3Rl
YWQsIHdvdWxkIHRoaXMgYWNoaWV2ZSB0aGUgZ29hbD8NCg0KTm90IHJlYWxseS4gWWVzIGEgbG9n
IHdvdWxkIGhlbHAgaW4gdGhlIGNhc2Ugc29tZW9uZSBpcyBkZWJ1Z2dpbmcgYSBjb25uZWN0aXZp
dHkNCmlzc3VlIGluIHJlYWwgdGltZSB3aGlsZSBsb29raW5nIGF0IHRoZSBsb2dzLCBidXQgd2hh
dCBpZiB0aGUgc3lzdGVtIGhhcyBiZWVuIHVwIA0KZm9yIGRheXM/IEkga25vdyB0aGF0IHRoZSBz
eXNsb2cgY2FuIGtlZXAgc2V2ZXJhbCBkYXlzICh3ZWVrcykgd29ydGggb2YgaW5mbw0KYnV0IHRo
YXQncyBub3QgdGhlIHNhbWUgYXMgaGF2aW5nIGFuIGF0dHJpYnV0ZSB5b3UgY2FuIGxvb2sgYXQg
ZGlyZWN0bHkuDQoNCkFsc28sIGFuIGF0dHJpYnV0ZSBpcyBuZWVkZWQgZm9yIHRoZSBudm1lLXN0
YXMgYXBwbGljYXRpb24gSSdtIHdvcmtpbmcgb24uDQpBbiBhdHRyaWJ1dGUgYWxsb3dzIG52bWUt
c3RhcyB0byBydW4gYSBjb21wbGV0ZSBhdWRpdCBvZiBhbGwgZXhpc3RpbmcgY29ubmVjdGlvbnMu
DQpOb3QganVzdCB0aGUgY29uZmlndXJhdGlvbiBwYXJhbWV0ZXJzLCBidXQgd2hlcmUgZWFjaCBj
b25uZWN0aW9ucyBpcyBhY3R1YWxseSANCm1hZGUuDQoNCkp1c3QgdGhpcyBtb3JuaW5nIEkgd2Fz
IGRlYnVnZ2luZyBhbiBpc3N1ZSB3aGVyZSBhbiBJL08gY29udHJvbGxlciBjb25uZWN0aW9uDQp3
YXMgbWFkZSBvbiB0aGUgbWFuYWdlbWVudCBpbnRlcmZhY2UgKGRlZmF1bHQgcm91dGUpIGluc3Rl
YWQgb2YgZ29pbmcgb3Zlcg0KdGhlIGludGVyZmFjZSBkZWRpY2F0ZWQgZm9yIHN1YnN5c3RlbSBj
b25uZWN0aW9ucy4gVGhpcyBoYXBwZW5lZCBiZWNhdXNlIHRoZQ0KdXNlciBmb3Jnb3QgdG8gYWRk
IGV4cGxpY2l0IHJvdXRlcyBmb3IgdGhlIHN1YnN5c3RlbXMuIEJ5IGhhdmluZyBhbiBhdHRyaWJ1
dGUgDQp0byBleHBvc2Ugd2hlcmUgYSBjb25uZWN0aW9uIGlzIG1hZGUgd2UgY2FuIHRoZW4gcHJv
dmlkZSB0b29scyB0byBoZWxwIHVzZXINCmRpYWdub3NlIGNvbm5lY3Rpdml0eSBpc3N1ZXMgYnkg
dGhlbXNlbHZlcyBpbnN0ZWFkIG9mIHN1Ym1pdHRpbmcgdGlja2V0cyANCnJlcXVpcmluZyB0aGUg
ZGV2ZWxvcGVyJ3MgaGVscC4gVGhhdCdzIHRoZSBtYWluIGdvYWwgZm9yIHRoaXMgY2hhbmdlLg0K

