Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CBEC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 12:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HzR08Ju5hThQRevIluwJfRDdiG9fA6+pnEowTq5Zh34=; b=fwcuDKa+12LWZ+AofY+qC8x+kX
	9lQIx1PUCQWL9c1Sn9QkjPIv9lAKJ3G+CcIxSHe+xTPcWsEIt1x+plWS8VHb0vl/S+6BF0y6wnOnn
	IDAKzlqKArGP/BfwxefHUEh8oOI+6lo83ab06YNMRtEe1Z//Syu+DFKqfJJ1Ow7Sbb47i+evOYH7K
	XGdR2l8qmL9pjl8CdyVIX8gZvCrLWLwIuizPp0mN2gIk7CwBBxl/RacKLLNvtMWp4aT6/zrRrCv/k
	EMZgf7wHg8uU1HUU9/p2xrY87+yJucp/rsTWh7USpzalOxTRFz1yGqokA0A1wj6KrFcZyF5lF8BT0
	2ySQq8yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2XWd-009Snx-2v; Tue, 06 Dec 2022 12:58:19 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2XWY-009SmG-Ig
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 12:58:17 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6BIHkd011964;
	Tue, 6 Dec 2022 07:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=HzR08Ju5hThQRevIluwJfRDdiG9fA6+pnEowTq5Zh34=;
 b=VkzzZueMTZkZcHCqZbEf/ElTM79JTEj1NuSvkqJlzj0uIu6S57BvJUYhqjKdsl8uzM5V
 Ox/MR8Y1PhtNWtbqsq28Gqr5oOWnUg5RdYC631BZQzFXg5/HO0Zhgkpbxy4tXqGsOCvH
 rihQ7UA6GhIp5Mw+x+Twvff0tk4mHdmNXv8gJ0nroENkT6EFbNX9wgMEiTA/C71fcDG1
 QzNOZ5+esFUiEBAlWrgnZu6BB3mrgBNl7nxoHZ97iENwli9c5yqpJxzifRuJCyrkgjel
 vW2KU/oh572PUo+VDLJZAahbs7J0/B76PuOe5xYxEWlVUIQu1wMuipuYPxiVfNyxgTlC qA== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3m82jettfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Dec 2022 07:58:02 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6CgvBo029804;
	Tue, 6 Dec 2022 07:58:01 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3ma5jugqh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Dec 2022 07:58:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieLiKv6yX6RA5O7Mv0krf7IGg16iAsA4Ds6n2jlJL+7hp37RQEy2dSaYZ2rnHqLAfz+OmY+OT5khJObyzpoODCJH/6pDMekQ1S0k2phveoImqvBGI6+EXcs1seBM33SFUZQIW9VxtZvtw9ARig306gmzXZ5b8psCdqrLs/qi59gt1xyfxCWuWOIurr55E0ipXNaruQ+1wt6KVPmXwP0og4C5k9tybw15yEopUt5RblXx18pY1QiHWzmmPmSIZGVrch8x+GO0e9MPSsscTDpDH2m+ci62e6lLAP6Pux183etOIFFnxwqlgF8AudLlxV0eTVbw//DtAzARPB+qTXC2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzR08Ju5hThQRevIluwJfRDdiG9fA6+pnEowTq5Zh34=;
 b=C53G8EQoL8Cbrr6+9EewfEzuriFS+BeILa8slv7kfhS5Mmopk2IAZsd5vKOpEa1rCyy00Y6KKaApCgrXbRFckpWZaQf+bbkxDLlrIBw7tApm5R8gort6EBJn1mgiP7pRuXjOxsx0cuPSx8u053cPTRQI+eMP82bqdcCEJYNDTNr04JaBPwiov4fZzO+WNCOyXEp4Ys0GrwCy/dPDzsqlTgRU0OF+Xszis8b8+OhlMxd5f284ANtzVx2HqPVDzYKAeLDY+mBac1j40OGiNRGCaBEZr87LJ3Hm0IbqOFj75ZcuOR3ljHMmTXBUhBeFBirXirNNKLoIRdqt2wz/ckOaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by CH2PR19MB3781.namprd19.prod.outlook.com (2603:10b6:610:a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Tue, 6 Dec
 2022 12:57:59 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd%3]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 12:57:58 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "Grupi, Elad" <Elad.Grupi@dell.com>
Subject: RE: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Topic: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Index:  AQHY+oZ3D5fYZrPgTEKaaKTSawClOq5HuhEAgAGKjLCAAAFEAIAABSLQgAAsj4CAFIQ9EIABL5iAgABoTmCAAELfgIABGHsQ
Date: Tue, 6 Dec 2022 12:57:58 +0000
Message-ID:  <CO1PR19MB4885A074EC54F0171CCC2BCCEE1B9@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
 <1668690824-2034939-1-git-send-email-amit.engel@dell.com>
 <4effaa95-0357-7d65-1701-8ec67ce7cc11@grimberg.me>
 <CO1PR19MB4885EB9E323178E235681F9EEE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <8e6fb5af-2992-dfe2-10dd-383c2c058f8b@grimberg.me>
 <CO1PR19MB4885EADF8C1E970867C71487EE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <a6fbc43b-7f7f-91f6-a157-186f2663b734@grimberg.me>
 <CO1PR19MB488579DCD958B74B2C8E38AEEE199@CO1PR19MB4885.namprd19.prod.outlook.com>
 <9021ae71-646f-8183-7772-7dae38a60d47@grimberg.me>
 <CO1PR19MB48854117F203A43ABFFDB17FEE189@CO1PR19MB4885.namprd19.prod.outlook.com>
 <87decdfb-1a2a-d0df-d869-0e3b54e52240@grimberg.me>
In-Reply-To: <87decdfb-1a2a-d0df-d869-0e3b54e52240@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-12-06T12:55:49Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=d1dfeef3-6b56-4974-9447-422dd27b72f6;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|CH2PR19MB3781:EE_
x-ms-office365-filtering-correlation-id: 75f1a6b4-77bf-40e3-b670-08dad7897ffb
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  8Sru569PDMukVgtQU+6B9uXkx3GXf0GfR+EOfnmhSjoWe5JFbSQ5aLbz10AHw5r1pbCCLGvxK2DlCP4wDBMeVbaP6Ol1mQvyXjr7pbeWyZQvWHE6UGijYkUUcpWANXrLzpPMoaGN7W41hC3cRJQ8UKGUuiVUPqXqSpm2S9oBqgXGicGBQLjSyRapxju673DSOkH3/o9EWLESX1SNN9sTgsoqZ9viDvho8+RybjaZfNMSbr1IKPMCfaQk7uDk8sma+DePAmP53+itWFIMxSIBU5lS/gsnTbfQnzHGwOxy7J9bXa/pGXwmFU4rsmmsf5MJWWvMm2fFUWhEtimjYjuDUZIe9y6Oj249t0sg+l5FLvkppIGIPPGbGOAH50BpWmK5VAdwpHEG6hfEQNj/HVSjizTS8/eOk0tXChTclf8+E/BUF3/Ewbog5F+q0lTQDISokP7qidww00uO7O1AuagQcvXGBukUSnRth1GypeQGQYKbVY04AUQq4e1nMSnEVTdbvp4d8KWJlz1WbWu1X7RbMQOWpIigXeVB138gnWBNd+Whn9nrkKl69vMP1gOLQmh/rJ6kNNtJ19Mpm7HbWlCci3eACyAhorUF1sLJYUkacqHmXK1d9Ok1nd37hEcd1vrKlVrYtqxTQKtH737ONX6wwcSPjxupUxkOxwS0N9OoPTPgOeKzX7tmXX7hWGORlrcMFlAFB+Qn8gaFTtHcNtSqgdgyJsD1n7X0zvQF33XKL64vjevrQjyBLghJ5LWXh3VE
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(122000001)(83380400001)(8676002)(786003)(33656002)(86362001)(82960400001)(4326008)(5660300002)(2906002)(41300700001)(38070700005)(4744005)(8936002)(76116006)(52536014)(186003)(6506007)(7696005)(64756008)(53546011)(9686003)(26005)(107886003)(478600001)(110136005)(316002)(66556008)(55016003)(66446008)(71200400001)(66946007)(66476007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?eGVMUlo0Q2VwUmJ4TUhpWXRGblRJNTRmQmhFN3dFVlI4OW5XSmIraE83Kzdq?=
 =?utf-8?B?TWZkWndPYWZtTlRyeU5UdzlXVG4wQUpPREV1YjJqeURlS1EyZjBoTE1Ec2RQ?=
 =?utf-8?B?UVRxODl5SzNuQU1ua3NhMk9HSEEyWkc0TFBJTER2cFY3Rk5BU0RBRGZ4djdR?=
 =?utf-8?B?dHJDSjRZeDR5elBkYk5zRzVrUmVicW9ZQzg3SXFVRldYWkt6OXNyelNGQXJO?=
 =?utf-8?B?cFNLVE11eUhTdjBIdDhhOUd6UzIxRjlXWElEMXd2aWFJT0lkUkw3SWsrdjZT?=
 =?utf-8?B?VVlFNjZ1WThlbTM0Mko0VTF1bFhWRXJ3OFJrV2QyMGI0ZHIwV3loYnQ2T2I2?=
 =?utf-8?B?NFl2RWNCSDVWVjJrN011RnA2VmY0TFFtSDVjOEpQMG5oTmRxaFRrY0xOYmEr?=
 =?utf-8?B?TG0zSDB2R0tNNTNUYXd3Ly9NcXRQRkxaNzFNMmtHK1ZkdUlSVnFScTMxRHZH?=
 =?utf-8?B?ekNyaGgvVTZhTXNBVGtLMkw3dmJsZHNwQTcwU1RKOUt1clp2N0toemE5WFF3?=
 =?utf-8?B?a1I2KzNTR2x5ZXFBRWdncWZkWko4ZTR2Z2xJSjRTa3BqekJFS2FJK0hNUlp1?=
 =?utf-8?B?ZDhZWkhsUTZJY244cE54QXVJelowaEwreEg0ZEVJWmVDMklCclVGV2xjNDdT?=
 =?utf-8?B?SDV6UnROUERINGxjQVVrRGJMZmNTR0FBa2htaHh3NURialVPRFVyenJBVVBK?=
 =?utf-8?B?SVNwZFNXUlZVQ1UrRGxVNDlMTDF0NGJXRmhidXk1cERTcHR1VG9HVUF0L3kr?=
 =?utf-8?B?M3ZqWlRvbmxjN3ZnT1NKSzVOdFphckVPY0wzK3B1TStDUS9pSEdKSFZyT2Z3?=
 =?utf-8?B?UmFDVFdlK2hBTlMxZXp0KzZpMGFoclg2Qmc4QlFDN3p0UXVMcE1WNVIvWTVC?=
 =?utf-8?B?azBrOUR1WGJyMUZ3K3pBOVlXYWVnU1l2NlNSem8xTXN4bngxYWluRnFPcXAw?=
 =?utf-8?B?RUsrcFl1Yk9mejZ5NnhVVXZwamN6bCtQNkVPb3dMWnhmM1FTNkYyV1FXWjlH?=
 =?utf-8?B?ZWY4V0tIR0VhSUI5UUZ1bTNnUzhIa254ZjFJcWZxNzV2emlEai9kMHVBYi9z?=
 =?utf-8?B?ZTBvUWNNdzltcVlTSVNWQkNXRWwzNks3VFFITS90bzF2MGFBZFlncGdjNFhw?=
 =?utf-8?B?NGVQSkovL3ZRenFhMHppd0lVWHJKNGxaQTRiV1NGd0JPTFd6cXdmV2IrN1dw?=
 =?utf-8?B?aTdERGJFcGNlRVBjeUxKM3l2Rzlmd3FaVVFTWEJnOUxCMUVVdnAxcHlWMDJj?=
 =?utf-8?B?RzNaYm9DQUtYSCtidzlmcXUyUjVOMG9SSWZIT2VFRHVXYkhjV2VBdk13Um10?=
 =?utf-8?B?UE15OGlPUHFzK09oSTJEQ1IvTDZ3QlhtOU9iTGhkQUxJWVIxWDNHTjNyMUdu?=
 =?utf-8?B?UHFGY1FLaW5BWmVxTzJHZStBbkRaak9UeTk4NDM3ZXB3S1IyQW90b1ZsUzR2?=
 =?utf-8?B?UHlNUjk0MWcwYnRzOU1UbUJqWWxzdzdrRnNicFlVN0h3VVdvdGNsTnJMUWkv?=
 =?utf-8?B?L0JOUDZsY0N6cU5aUXpJYWs1cm5VbXNHckJOTmdXTTJMZmpFS0VMWW5UV0xn?=
 =?utf-8?B?K09IV2x2a1NhRmxsV040Y214OVhtdUFyakh2VjYyc2NLR2wySExyME1idW9E?=
 =?utf-8?B?c0VWNjlFRFZXY2xmNklyYnZ3T2Zkb1M5VEpMREN5T0FIbHlrdXpzbzBpTW5N?=
 =?utf-8?B?NEhOL040WXR0Y21oK29hRCtGVkg0ZFp5RHhMV3N3S0RkZU4xUzk0UDlYU2sr?=
 =?utf-8?B?REczRkc0UzR1N2VYVkZDc1dSUjdtOURGNmJaaDEvYkQwY2FLekxZWnQ3alQ3?=
 =?utf-8?B?dDMxeXV4amtOalhaakt4cEQwN0h0bG5wVlJTdWN2OGlzcC9nMUtVSVI4NW9Q?=
 =?utf-8?B?R1Q0N1VwL0lpS1pJUlpyMVRvMkxzREFyWVgwYnB3N3RheUVpbUxtSjBxVUY2?=
 =?utf-8?B?MHNGb0ZIVjg1bWFsalFHT3lyS0NJWk5tMlYrVlJHVWxXR3hSR0hmcGdPa2g4?=
 =?utf-8?B?V01JcXlZYkJzSWNhdTVyQWlGNDJtWkVlR1Q2YWNlTzlLc0VPRTYxaEJnRG1V?=
 =?utf-8?B?TktVNzBGTmc0Qi9SUXlIYUNRbHJQYUJWVjRMNk9aK3MvaGlKSkZKdllxdGZV?=
 =?utf-8?Q?YT4qsgfHcms+F/1uoTOy4Tevv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f1a6b4-77bf-40e3-b670-08dad7897ffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 12:57:58.3415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mR+hhvS3xSgwPumQQLay5+Hn+MvL0XB6RdiOUOgO6o0kW+5C2H/OLeyH6Y99XoUq8xu95wLP2ueDgwV2fOVR0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_09,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060106
X-Proofpoint-GUID: 55mrWSmA2N0qagxTjgRBzNRzLpeFpsFD
X-Proofpoint-ORIG-GUID: 55mrWSmA2N0qagxTjgRBzNRzLpeFpsFD
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_045814_846349_7F5B91A0 
X-CRM114-Status: GOOD (  16.36  )
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

b2ssIHNvIGxldCdzIGdvIHdpdGggY2lkICh3aGljaCBpbmNsdWRlcyBnZW4rdGFnKSBhbmQgb3Bj
Pw0KDQpuZXcgbG9nOg0KDQpEZWMgMDYgMTQ6NTQ6MzggbmM5MTI3MTIyLmRybS5sYWIuZW1jLmNv
bSBrZXJuZWw6IG52bWUgbnZtZTA6IHF1ZXVlIDk6IHRpbWVvdXQgY2lkIDB4NjA1MSBvcGNvZGUg
MHgyIHR5cGUgNA0KDQpFeGlzdGluZyBsb2c6DQoNCkRlYyAwNiAxNDo1NDozOCBuYzkxMjcxMjIu
ZHJtLmxhYi5lbWMuY29tIGtlcm5lbDogbnZtZSBudm1lMDogcXVldWUgOTogdGltZW91dCByZXF1
ZXN0IDB4NTEgdHlwZSA0DQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNh
Z2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+IA0KU2VudDogTW9uZGF5LCA1IERlY2VtYmVy
IDIwMjIgMjI6MTINClRvOiBFbmdlbCwgQW1pdCA8QW1pdC5FbmdlbEBEZWxsLmNvbT47IGxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZw0KQ2M6IEdydXBpLCBFbGFkIDxFbGFkLkdydXBpQGRl
bGwuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gbnZtZS10Y3A6IGFkZCBhZGRpdGlvbmFsIGlu
Zm8gZm9yIG52bWVfdGNwX3RpbWVvdXQgbG9nDQoNCg0KW0VYVEVSTkFMIEVNQUlMXSANCg0KDQo+
IFllcywgaW8gdGltZW91dCBpcyBvYnRhaW5hYmxlIHZpYSBzeXNmcy4NCj4gQnV0IHRoaXMgaW9f
dGltZW91dCBwYXJhbSBpcyB3cml0YWJsZSBhbmQgdGhlIHVzZXIgY2FuIG1vZGlmeSB0aGlzIHZh
bHVlIGF0IGFueSB0aW1lLg0KPiBTbyBJIHN0aWxsIGZpbmQgaXQgdXN1ZmwgdG8gaGF2ZSB0aGlz
IHZhbHVlIGFzIHBhcnQgb2YgdGhpcyBsb2cuDQoNCkkgYW0gc29ycnkgYnV0IEkgc2VlIG5vIHBv
aW50IGluIGxvZ2dpbmcgYSBzdGF0aWMgdmFsdWUgdGhhdCBpcyBvYnRhaW5hYmxlIHZpYSBzeXNm
cy4uLiBJIERvbid0IHNlZSB0aGlzIHByYWN0aWNlIGluIGFueSBvdGhlciBibG9jayBkZXZpY2Ug
c28gaXQgaXMgdW5jbGVhciB3aHkgdGhpcyB3b3VsZCBiZSBuZWVkZWQgaGVyZSB3aGVuIG5vIG9u
ZSBlbHNlIGlzIGRvaW5nIHRoaXM/DQo=

