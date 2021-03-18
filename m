Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740D9C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 08:31:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B747964F33
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 08:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B747964F33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hL9YiHXuP2+XjMTtgspdM0CGQgkjzVRg5J4rNVZlJRc=; b=dEU0PAonoE+lQAJBhtZMQfVt1
	S2Zm+RRTdYb5CtqW18SyOc/vbYju7zn7TWB4qpj/QU0HvBUTvFjKf2GKEmiTC2wI/0EHq0XSKxqFM
	QNPkcBnv3gsrAdHipk49DPTkU0l00cxUjTVBZ+xQjd7lhqI+BqbvuMXfCsaQQ4JF04IZPbsfw2YG7
	kEsi9NkJnpSVuHiU0qpXf0HeSBAiY7P6yRmO4m3667xMwcYQK/BkH8vQ3xGwurEUdJkxx/WPPn/uZ
	6rVWkMGOx2BKu5Dw50FMr4MwpJRgumnED0UucP3LcqIAvMEoWJGkaZDr4nXHrXdClX5Zk9TsT0xDC
	LoQLtbRgg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMo4C-004o5s-3h; Thu, 18 Mar 2021 08:31:40 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMo46-004o3i-6u
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 08:31:37 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12I8QrMw005701; Thu, 18 Mar 2021 04:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=gG187eYb3CgZZ0zliXrPU7lBwDtqkNAFqUaFYaSPYqY=;
 b=X8b16/K2QFZc0StTaCYLCVPCyNBqMlmVWt96ONVQ5v6H/f9tU8Lp+O7ZvmUeiYoLmhfF
 EoJ2hcNV8rdT34ter1yct66nQqHHRJYnbJlFCTiemLi0SmBqSGhIJuCB0ypw0Nd5LN5r
 Uta7nYEQNc81U2OZvTGaudnTFmO2smR3dZn103GR/vRYz4p3BB1mBROPxmt5bTMvws8e
 hvhQRa3gc0/3i2vHL0ryqdZJbJfU9I6+Rkx2cNyL/VTi4gpKhUuSo9WPNkXkNuowg+kx
 lGdANhGSPvKX44dXOu/LcgyUeIznQ3hZnVapOJhEd7oBSZc8LSlI+//sI/ZkZ/EG5+0v 0A== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 37969pfv7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Mar 2021 04:31:25 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12I8Q3qT051165; Thu, 18 Mar 2021 04:31:24 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
 by mx0a-00154901.pphosted.com with ESMTP id 379ba2yaxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Mar 2021 04:31:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOAtCrKIH5zAHqbUnYmhyhHji5FRZ+NJ9jhpmev1raL12e/96hcOW1iLQ06vZfNKR9mP8FpMJS/6KO4vLhjQpHqs8/xrvKOK63nb5pJwhqPrhLT9kY15BqkPauT9HRhBYK9KselbrpW/g99E1nXYyyAuXV8tdQ9eupKxyHiVs6u5J3GmvWX1hweqWHb4TfQ+TfwRVHpwtTJ7oRaL5bQmLzS8bM5ksRfohImORxBYYT6V+mZvOFJf9WRGllnOpS2m5IHMLc3gk96SvZycJu2RAT5k6YWbvB51Tgnnjc7ZWGbodEqWMR/OokpAe4xUi1rS9tmR/AReid/EUSLrq9f8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG187eYb3CgZZ0zliXrPU7lBwDtqkNAFqUaFYaSPYqY=;
 b=k15XSOwNA45/W2DrRx3kDaVACGXESowOkaVI71KPqp/190CPPmLTt51m97OK7iZOC9DqlkiK/8987ehrCVTwyY+Fit1k0G4Qh235rL8nOdnmc0rRQyXdTm3jpmffri8DzxdseJ8pYb5m/yM/8j5OzKGB/0zRvqSumlCwNq59a2MYCkurZLWQKTs2gOLp4yNLz3o1JWEYWZZCNFCm49Xrc5saJKMs8XvStHFi5UbyHCdgfpRgNYLMoyPxCpEb/hFrBHpTwwtZMzMUQu+RG3xJ8p0MlqRVntCIsQjjmm04AbPVkWnu22HIp9qGbihYCWOMTijvBGa5JTIBrrycRaQlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM5PR19MB1049.namprd19.prod.outlook.com (2603:10b6:3:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 08:31:23 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%8]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 08:31:23 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Hou Pu <houpu.main@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
Thread-Topic: [PATCH] nvme-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHW6aKA9bVKdUdQXk+axFkWm5Fl+KomKNIAgADakqCAAJ7gAIAABJXggAHRIICAAh/SYIBbJGOAgABnaXCAANBYAIAB2rTw
Date: Thu, 18 Mar 2021 08:31:22 +0000
Message-ID: <DM6PR19MB4011A7E962AB8F8DE6A5B63EEF699@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <DM6PR19MB4011D61F1BF2A4F66228E9EEEFA50@DM6PR19MB4011.namprd19.prod.outlook.com>
 <20210316093539.16125-1-houpu.main@gmail.com>
 <DM6PR19MB40116B3A8A9751C4BA926521EF6B9@DM6PR19MB4011.namprd19.prod.outlook.com>
 <e7286d8a-a364-fdf9-c839-7c5976b4fc70@gmail.com>
In-Reply-To: <e7286d8a-a364-fdf9-c839-7c5976b4fc70@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-18T08:31:20.6880513Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=d4e6cd59-8630-4568-9614-e6939be04fed;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [77.126.55.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81f02e30-84cb-424c-ed86-08d8e9e83692
x-ms-traffictypediagnostic: DM5PR19MB1049:
x-microsoft-antispam-prvs: <DM5PR19MB1049562E5B95E0916344FE6AEF699@DM5PR19MB1049.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KtbMzs/LUmIbdgpoUFn7cgeLBh1wbMOBpHFrgIbEsENpeP3v5rejp36Hwlqyhro+47MdY3Vzbse6N+ShA9s+5spo0Iz+QoN6Kj8/XjeKd1VHM8QJzl2UxMndovFPmqhQd4ppEnCkst25Yf+5fBX6nE85kikKPj5KJEpqVY15++IgVuwVND/415UJk7maie0WFs9p7HTOzenK3j4lY60xUENLvmWPch+9vkBJ85W8Wgma2qwfxpfoLWa7wRfFUiIrIK0pvoDprKvYGM1cQtOBBQZ+e6nt0wo7rvTdwrQLQHFm635jTDjwKdltCmzKBRq6xmyQaQVzX/T40NpS6MVkrIipuZyKmh0l1zXzjV/Hd7LYDn3RKI11qD0ZyrnAECO2c22EE3vdJjSP2o0Pb/G5hxz5b3X4/2OadKASlAdX93auMDOxj1jGOt5y9/ztL5iidnB9W2poQDQq7L0aAI1b0dqozdgvwiMu/jbOVKjygibN1nKnxy15nML0Slxx/pcvfuLVeEoz08q9Ra1mVu28adW1bfcDjyc82xsVulu2BlD4QWu4WbO3FI/wnPdikBECw3HoIpbyW0aK/ivnljQJV3s6JT1P5xr/DRB+1fC40g1oazJfIVQE3wLKHRodp2NXyk4xcIYk8iXF11EDMUlaAvYifdo/i+eTl5sBzpQHX6914/7iVTpsnzs+Ml3QuxZznmUHFMYlT0Qj5buzIbWLIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(966005)(4326008)(478600001)(38100700001)(55016002)(9686003)(7696005)(4744005)(5660300002)(54906003)(8936002)(316002)(786003)(6506007)(71200400001)(2906002)(6916009)(26005)(8676002)(53546011)(186003)(52536014)(86362001)(64756008)(76116006)(66946007)(66556008)(66446008)(66476007)(83380400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?dWFrZitwYTNtWWpZaDhrNVJ1SDB5UGtCdExrbmhJOTRjMHc1aDdPdEVKZzBE?=
 =?utf-8?B?WGZQZjBtSTRpRFdUNEFpRmIrWm5NY0c5aVFOc29aUkVEazdnTitjSGpXcUd4?=
 =?utf-8?B?Rko2N1pRaUppbzdSOFVrZmhIVU1YVzdCckhMMy8vNXpNb2l3b3g5QjV4VUIy?=
 =?utf-8?B?NG14eDNjMWlHR1A0YTBodDByVlZ2NnM3L1FWbkdjVXFyM0tDM3AvZVN5TC9T?=
 =?utf-8?B?QnJuWEZaZU1maXF2U0h4MHZPUlpIM2FlL3RhUnR4WUYwY1J3Vmw0YlhOamcy?=
 =?utf-8?B?bVlFTjAzTkpzc21tUXlFU3VLaHlSTGJVcUZ5NHV1RTVXYktZcWtQbHc0VDgr?=
 =?utf-8?B?WnpnWlNqWHJQSjhzeDhtNHU1bUpHTWQ0RXlGMklTSmlCd1dEMG8vNjNFVVhB?=
 =?utf-8?B?K3dQblFZS0NlakorVHJmLzE5c3ZuZkt1V1JueHZQb3c0dVExQlZ0YzQ3OFJI?=
 =?utf-8?B?eS9OVzFla0hDMDlEUWVmck5HTDkyR1RHVTBicDBCSytGenA4MGFZcDdobXJD?=
 =?utf-8?B?YjBYU0Vpa1FLS05aSktJZU5ZZGN5aGFFdkFUY2lQY3kyREpPSXdtRzFrcVFh?=
 =?utf-8?B?RjRyQVNQZ2oxOTVuQjlnV0NhcXZrVVlSM1A3MktPbE1FQzlPWHFBcEljajFU?=
 =?utf-8?B?UitRek1rN21XdTRnSU5hUGkxVkZheUFKMGZvbHpTODczTTZmbWEzSzRoQWRj?=
 =?utf-8?B?VGIvK1I1OFJkdXRKLzMzY20vUTlCRTdCbHBueHd1M09wdFREay8yTzJDU3Z2?=
 =?utf-8?B?YXlqd3pZRyt1Uk1OVlYwNjFmS0NhQzdiVG8wbkZidXU1SFlSY1h3cDh1b3FQ?=
 =?utf-8?B?dmM4RkZHMy95ZjIyeXZGeFBmMUxxV1dRK3l3ZjZlYkcvVVRIWUVJa3psekxv?=
 =?utf-8?B?Mkg4WUlybUYxU2RmU1RHOEhwUVV5T1Rnc1JaeVVCRkxKL0dRVmZ4bTBpTVhi?=
 =?utf-8?B?Mmp1T2QzbnF0UjBTZldLNkwzeTdRTzRJS24yY1hQb25zdVJBazN5Y2hqODFx?=
 =?utf-8?B?bFlJY1lLaEFpQjJxbHdiazFvbE1CSTBuSlpud0ZUN0p6clNjdk1oTjdoQ0dh?=
 =?utf-8?B?NXRreUlSZkRnZnB5M0RzR2kwRXFvWnVQVlY5MUZzU3RSVzg0TlpLeU5ZQnpK?=
 =?utf-8?B?elBGM0Z5NE5SZXBheEJJWXBxQXNvMkZldGswQ0Z4REZEOUVndEkvWU9CamZi?=
 =?utf-8?B?WXdUdDU1ZXhOamZSbmd3ZW9idVpHRm5BM1Fzcllxdjlka0pZcjEwRGtjckk3?=
 =?utf-8?B?T1hKOG9OaElPMkl5YjVUNFBsZ25QZWJ2VVpSVEJWOW1CWVJtUUZsWi9TaFQ5?=
 =?utf-8?B?czRCc1dOTW1xWlVMcXhRdEhpb0VGREhGd3JXSUJ6QWZnNTV2emFiS1QwbEYy?=
 =?utf-8?B?ZFMvL1YxNjl6VzNRdGlHdTVlYU1ucGZPc3A4MVNUNWZ0NTFQYmRFeXZuWFFZ?=
 =?utf-8?B?WU9MWk5raW1oWVFXZzQwTFRpcnlXZXpZY0hnRWJTM3A4ZUh5RVoyd1dwVHBq?=
 =?utf-8?B?dENmTHlSZGNuRUZDd3FzbVJVM0J4bUZGeDdaNncwVUluODdzWnpxRGs0b2N0?=
 =?utf-8?B?eDRRK3FoTWg1c3YxS0FXalc1VXhjQ2hIR3ZVeVhtSExsTW9BR1NpQXQvalRk?=
 =?utf-8?B?c1JMUFZhaFV0RDcwbE9vTDBvaUpYUDZqSmRqK2hYVjlUdW1kZjZJbU8zQXl1?=
 =?utf-8?B?K0ErVXlieG1aYWxHaDRBY1lsWEZ5YU9mUG94QlA3QzZTY1JySE5BcFNocDhM?=
 =?utf-8?Q?dUwOdoNIhHy8UwtUC1gSfSirSHWYUFZ/bIOrKQG?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f02e30-84cb-424c-ed86-08d8e9e83692
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 08:31:22.7988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SLfk8tH0P0UacWxj7nR6l1jJi35nt1hRg1mIPcU9ejifjHu10K4wV7bdj5e9oRrDHtVVFqpMYC6Ziserl6dxrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1049
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-18_02:2021-03-17,
 2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180063
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103180063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_083134_781918_5E5DF9C3 
X-CRM114-Status: GOOD (  20.63  )
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

I submitted new patch that addressing the below issues

http://lists.infradead.org/pipermail/linux-nvme/2021-March/023824.html

Elad


-----Original Message-----
From: Hou Pu <houpu.main@gmail.com> 
Sent: Wednesday, 17 March 2021 6:11
To: Grupi, Elad
Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me
Subject: Re: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 


On 2021/3/16 11:52, Grupi, Elad wrote:
> Hi Hou,
>
> You are correct, this is the same issue.
>
> I have reviewed your patch and I have two concerns:
> 1. As Sagi mentioned, you might not have all the inline data in the socket at this point.
> 2. You might get hit on the last round of the budget of the receive loop, so you will still have a chance of hitting the response flow before reading all the data from the socket.

Yes, I realize my patch has these problems.

Thanks,

Hou

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
