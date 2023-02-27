Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F98AC64ED8
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Feb 2023 11:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=paqsCZv9r1uZgJCqpd7E0wX1a6XsD4vJiU3BCN/D0k8=; b=ZqdB88eCT31Ix2TTjf5x++BHqv
	L58lUpZdrveRFoAqn+h1HksjSnijygSeCBJEljM8CPkbEQwUTQDEXt2APayZ7UACElBuhPCDVDbTd
	9O5tdhujEuiAJo71UI/77tuvUMO5JbkOolUbmSjxbwxFoloCdKrCQ26s7nuZ7FPG9/ib+Z1b/45IH
	tQkwZYpCtwrxHe1uOfTAz784/D1uB8CT7DqcXQwjmGHCixttM8bre2wvm7uXYzKI+GlcB4ZLzcPC+
	X6uj+lTR7atYDwXc2BiK/po1ZHsoPZFgpKsVtLOzfB7e6GdUS65ic8idU76AOjiYkhwsdbgqKqmt1
	EBeUdeUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWc1s-009Rt8-NX; Mon, 27 Feb 2023 11:50:52 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWc1j-009Rlq-W3
	for linux-nvme@lists.infradead.org; Mon, 27 Feb 2023 11:50:46 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RAcMU2030298;
	Mon, 27 Feb 2023 06:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=paqsCZv9r1uZgJCqpd7E0wX1a6XsD4vJiU3BCN/D0k8=;
 b=MSYmcyKum7pkEFSO/F1IJxx8eARZMtA693XebRYm0E2j+3OwfgTw4muTSCO+fjvjWxtx
 x6PC5x2EkWPG/vAYOqVSHHamUOhKvIx13LzEViPWlSNDZaarGNmRgoMR1KVLTBgPGvLK
 V+DKk5In49yWJ7EZ99kOb6ItQLvmYBb5jGGY/nD9/9FrF0zi32732CzPoCFsH8SxssRW
 wiTRmh6l2zcEUE6bUrc2IyrDpZEIRskRHR7ISig7D8QJhX5USKC6bTqZF0FTGcumwS6w
 G5ILsgZa6GdcmTnTyihZfda9EfpkSgkQshxZ/BDMjgU2JWxjeLmafC+zKBaBqR2RG0qK MQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3nyecjd16r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Feb 2023 06:50:25 -0500
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RBiHrV016971;
	Mon, 27 Feb 2023 06:50:24 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3p004tkbms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Feb 2023 06:50:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG4wgFRbSosUX7BNfRo8++qv3WL9vIkOtTsajRrRjZaopgAwctqnKLyRw1ytuwue89+8c6tVdzm7b/uxCp/ku7tZCLODAhZ99sdxepFB035xEgsok/EmTdBkHJaciN2Pyq/h8e3CGqQvh7vrXwL8PDPU4qu1QYGk2xK85lvkC7qTkB9Ot7pAmQwSs7L4U+15V/LFl+VlByLG6BvTnPB1Dioo6c5135yTJakGeXeg9loHZ8b1lfpUFwEQ1WJLbM4H42uXyo6PvPPgjqzCceKowd5wz0EZNF1AGLyhHo8AHwDBRPkzVVtfP/T4FyTJrZs57sH1qBeECvFpPEq5kKTN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paqsCZv9r1uZgJCqpd7E0wX1a6XsD4vJiU3BCN/D0k8=;
 b=DsAqnOpgMTTPBG7SL+hylHao+YTmrbPLeMiq4Xr69r1KThc7hO5shZpJv0i7bALKY74aCKEUnx4QZvSasGvFKpefQgt7EebQ9WLCTZLG7vXgPgR/F/xjidclCWoG0G3kwm7KV2FhPHwB284HFUj3kVW08v63wmUtepFekmOoCw4Hm5Fh0fR1Bzl2hO7Jp4dJ81dHOuv4RqLfS7u6c+zK4X3QRpO5mXu8kJ8Mx3KUz+oxVe2ihEAuAkCdYEn0+jjodJ1uO6yPjqSHp4p3fZZ9AMXSL90gcdhEWt+tBq9f8onYVlWJt9FT/KGtWqYkiVsDwgQi5fEbLLkPVZyUGk/sxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by DM6PR19MB3931.namprd19.prod.outlook.com (2603:10b6:5:247::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 27 Feb
 2023 11:50:21 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2f42:cd95:5173:5c02]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2f42:cd95:5173:5c02%6]) with mapi id 15.20.6086.024; Mon, 27 Feb 2023
 11:50:21 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Hannes Reinecke <hare@suse.de>, Akinobu Mita <akinobu.mita@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe
	<axboe@fb.com>
Subject: RE: [PATCH] nvme-tcp: don't access released socket during error
 recovery
Thread-Topic: [PATCH] nvme-tcp: don't access released socket during error
 recovery
Thread-Index: AQHZSd/tu5x/1dySBUmaCCBErazT867idzKAgAA3y2A=
Date: Mon, 27 Feb 2023 11:50:21 +0000
Message-ID:  <SJ0PR19MB45448B95CD8D968F2068E42AF2AF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20230226124254.59970-1-akinobu.mita@gmail.com>
 <4e057da2-9168-43a8-452b-2e5b354afc98@suse.de>
In-Reply-To: <4e057da2-9168-43a8-452b-2e5b354afc98@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2023-02-27T11:48:22Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=0a26382c-ca1b-444b-8edc-1bb87ba1cfd7;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4544:EE_|DM6PR19MB3931:EE_
x-ms-office365-filtering-correlation-id: b6627c6f-44f8-446f-4436-08db18b8ce61
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  a/JSZi981lPe44evhfM5sVdCcvFk2sPMswO71alJT5I2wHltEuba1agtSSzlsP5Yvhx5YwnybzO8ZlPvYm1bjeqSu6Q6FDqh3sw4mz7nKRgSftlcoTqGdnsDS/RpG7DF8vgtm3skJMQ5cB4RojFX3qLRMITiaa0yI6wgsPmD9gzT6QMqRKXm8UsD3Qv5wiKr3nxeM8pHFm4sAKkyqB3uzNTwsPoWQHk/6S/GRsjjdQdhppPKWxDC3lR05OJwRXT6mBj6XccEI2uebc9PKrmon7Rleh0d8JxCMZ40p7e0TxMjHzXNir2lLIZEmHhnW5Iwda/1NqbtDC3j+hKI/M3/7R6+7caN8lpfag4zyqPQttwB5foKZAXYkkRjfjvaY/olQ8LDcRiwrneX2l1LqDJkSzPyEWODigCm4NqIeKnHNUpPpBkTt8PQNux8DiyqIzULIpFLweVLy/LvDLQFhkoMzmj36IJqTaJw1Hr+DU5CL26g8KNogaOMdooY4XER9T28edQWGOj98EOH1rSfXiN9KyRRIjUmIEwlXKY6U+yXOdX+a3DU9/TgDAog7WuoblW/wuaSjUiC3sRks+b5peEGJLArWZruw5pAarJKKp0Yrl5jy5Ew7bj3ntAtf2xqn3NgNm60xAZtcSoZKeowyH/YrbmLPdLrGZERcHS3MMDqmDMS9ywGVFRYDThSNcGhYz3T0Y8aGeolQXt8h+mJBnjgdw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4544.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199018)(86362001)(71200400001)(8676002)(76116006)(38100700002)(83380400001)(316002)(66946007)(786003)(6506007)(110136005)(122000001)(55016003)(9686003)(66476007)(186003)(41300700001)(38070700005)(4326008)(7696005)(33656002)(66446008)(8936002)(66556008)(5660300002)(478600001)(54906003)(53546011)(52536014)(82960400001)(2906002)(26005)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?c0lVT05rMlJMZG45QWRoUUl4VFZLQjhiZlp5NVlJZTdUMmR2Uk90MCtmQVBG?=
 =?utf-8?B?TzJBdnkwcmV5TW13MEFjaEhLd3VXcDlsSXNFd1I3NzFwVWVzK2ZWYnJtMzdt?=
 =?utf-8?B?SWVzUW9yMGl2SHZEOW14MGxjM09mMEdzcEpvaHpOL1VhdTV3UWdrWVB6eXNP?=
 =?utf-8?B?TDFBZk56Uytma0s3SXkveHowY1VpSjJHN3NvWFEzWnE3eHEwRDNxL1docUNF?=
 =?utf-8?B?emt0QUZNcWZuYmw3ZHAwVWVDdFVoVmg4ZldwMHNseEgrS3hqSDlyaGhFQkZR?=
 =?utf-8?B?R1pnajNBYmxOQ2RLbWVOdFcvSVU2SEtrcU05VHFvSjlxb053dWg0ODErL2tt?=
 =?utf-8?B?RWRHc0V2UVIrSnBoLzlydUhiNThHK0NvN1FKKzgzbGVVOHlnemd5Q2dBMGZi?=
 =?utf-8?B?QW5KaHpYZ2Y4NDBMcmVyL1YrRVc2dVV5dnVIenNtWnFiWVh6K2IyeHJKZSs2?=
 =?utf-8?B?eEVJMytYUGI5amg5SUZlSmFZU0gzQUNxRzBEamZlaHJxS0R3ZXVYd1NERnZ6?=
 =?utf-8?B?VGF4RTJnVmUyR2NtUzc5MVRVSitrU0p4NDZJeEEySmxsWVBrc1RER1hJRXcy?=
 =?utf-8?B?Vm1IYmFRb041VysvUFNOaUpHSGZWYkhPdHp3SGFtakNvRSt6QkJ5OWloQU1Z?=
 =?utf-8?B?Y3BPSlNGdHJ5c0sxUHBVK0o5SUw2TEc2dFc3dWNLOUNjWk1iZFVaSkJtZmFS?=
 =?utf-8?B?R3RuL0lCQW5TaGVpUUdhMTdJbHY0WnV6aVR6Y1BBalVYZU1vQnR3aXd1TUlZ?=
 =?utf-8?B?aDFYNXZnSGFOejU4SHhWdGdtRlJWVlliSVJKVXg0QllITHB0SVY5WXI2VkNy?=
 =?utf-8?B?dkJKeVkwNlQzb0tpaWE3OFdndVpWYUVtRFZQSVc3NlRYUm05aHJjSjNkT2JK?=
 =?utf-8?B?a3lqalg3R3NNL3dKMlBwdit2Y2lQclB3QlJsMTdCUWZDQ3VOQm1aOS9iS3ZR?=
 =?utf-8?B?V0QvM0Q3UlVYTm12MWdHbDIvcG1SaGVMVHpGUTFUdGhNekkrOTNWaG05dCtG?=
 =?utf-8?B?VjJ3MVgxZC9PZ3l0TUVBbVJ0a2hhY2s3ZEZBeE1TNWtlNmpYdk1uVnNLbDhS?=
 =?utf-8?B?d1lvazVyeHUwSnJGc29vbzF4MXNOQ0tQdyt3anFvOEhyVTJpNzlQTEFTNmZ6?=
 =?utf-8?B?eFd2Q2xtTnhrdVFiYnMxRGtnUDRSMHBUQmpkNElKMGNhUC9xT0QvV3gwM3pR?=
 =?utf-8?B?SU5uVEY2Sld5TlpqVkJCRDFiRkt0Q2YxSjFuaEh2K2wxcGxIeHdXS0tNYTN4?=
 =?utf-8?B?ODZEeG9vMWd3QWh5bW5KTU9nVW1pelJHSHQ0dVRReFFVdmNwZENuZmFlcnhQ?=
 =?utf-8?B?WmNPWW9vZGIySXNwMm5aNk83dmhsczZENkVYMlB3MG9yWDA3RUNhalR6YUor?=
 =?utf-8?B?YUVIRXF3UFhabnJzaDFCY2dsenZrYzllY3ZPVG1hUjJNU3E4b2Q3SEgvNkVZ?=
 =?utf-8?B?ckVURmxSUUxhVGZpeGJ2ZDdGbUZMK0FCSHJHN1NJL3dTaldvVEExYlUvbGRD?=
 =?utf-8?B?WUU1T1luSmdlSEs1MERCYzVGT1ZHSW9PYzlrRVVBWXFQeVhJMWpHYTJndVFU?=
 =?utf-8?B?Q0Q3RTNLSlo0eFA3OWFaZ0xiNHd2cS9rdGgyNlJmNFpjYi9pUGVKVU94Qmw5?=
 =?utf-8?B?bHhsZFdwekVSek1tNHhnbUxQSjZrbXZ1Sm1oT09vTXdFTWg0N1RtT0RNYUFH?=
 =?utf-8?B?WTVxSlNoNGxqSkliMlMwaVhVdVgxTjF2TTQwa1hZME1xUWFFeHV5QVFBWHli?=
 =?utf-8?B?RUZERkVIc0RnNzA2NWYwTyttY2hYUXExalBQTytGd1M0YjFhMEVCazJJVXJZ?=
 =?utf-8?B?Q29ZRmVKdWc3TDQ2QXU4c3ZnRDBpMTR5ZHU0OGd4NXU3Q28vZHVTcXY3VExi?=
 =?utf-8?B?MDRCcU84c29IVkwrZ0hzVEhlRU5NdGdGWVpVMXdrRHZoM0JCbEw0cEhscHJF?=
 =?utf-8?B?ZzlDN2xjY0VaRzZpVjJtY3pjMUs0eXFiVW5pTW5rTUhDdk1vZXd0SnlVWk1z?=
 =?utf-8?B?RjZRcjRyNWgreUVmOFRPOFFBUEY5V0YrM2RHNE5UZWREUjRzQ2N0N055NDVv?=
 =?utf-8?B?bFNvVHRmNlM4bVQ5b3hURUFGOUtIZ0VNd1hjRjlaUFVha2pMaVhhZUFmdTZt?=
 =?utf-8?Q?tOeBiN0cx5mVl4JTccmpUdqVW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6627c6f-44f8-446f-4436-08db18b8ce61
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 11:50:21.8431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7Yy++UM2izhhtAyOiqdm+FLIXdd477hAJyU7CkQ7T/ZtBppu07d/dxjiiURlnbAZXnEDyDFrASP1lUpR6oVQKxTfXDHjqyZp23cVuJAzbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_08,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=918 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302270092
X-Proofpoint-ORIG-GUID: LNmgbaLOegmIcuBuDQVI5p01XW6FUbkR
X-Proofpoint-GUID: LNmgbaLOegmIcuBuDQVI5p01XW6FUbkR
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302270092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230227_035044_170105_2330BED1 
X-CRM114-Status: GOOD (  25.22  )
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

PiBPbiAyLzI2LzIzIDEzOjQyLCBBa2lub2J1IE1pdGEgd3JvdGU6DQo+ID4gV2hpbGUgdGhlIGVy
cm9yIHJlY292ZXJ5IHdvcmsgaXMgdGVtcG9yYXJpbHkgZmFpbGluZyByZWNvbm5lY3QNCj4gPiBh
dHRlbXB0cywgcnVubmluZyB0aGUgJ252bWUgbGlzdCcgY29tbWFuZCBjYXVzZXMgYSBrZXJuZWwg
TlVMTCBwb2ludGVyDQo+ID4gZGVyZWZlcmVuY2UgYnkgY2FsbGluZyBnZXRzb2NrbmFtZSgpIHdp
dGggYSByZWxlYXNlZCBzb2NrZXQuDQo+ID4NCj4gPiBEdXJpbmcgZXJyb3IgcmVjb3Zlcnkgd29y
aywgdGhlIG52bWUgdGNwIHNvY2tldCBpcyByZWxlYXNlZCBhbmQgYSBuZXcNCj4gPiBvbmUgY3Jl
YXRlZCwgc28gaXQgaXMgbm90IHNhZmUgdG8gYWNjZXNzIHRoZSBzb2NrZXQgd2l0aG91dCBwcm9w
ZXIgY2hlY2suDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBa2lub2J1IE1pdGEgPGFraW5vYnUu
bWl0YUBnbWFpbC5jb20+DQo+ID4gRml4ZXM6IDAyYzU3YTgyYzAwOCAoIm52bWUtdGNwOiBwcmlu
dCBhY3R1YWwgc291cmNlIElQIGFkZHJlc3MgdGhyb3VnaA0KPiA+IHN5c2ZzICJhZGRyZXNzIiBh
dHRyIikNCj4gPiBDYzogTWFydGluIEJlbGFuZ2VyIDxtYXJ0aW4uYmVsYW5nZXJAZGVsbC5jb20+
DQo+ID4gQ2M6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+ID4gQ2M6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQo+ID4gQ2M6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPg0KPiA+IENjOiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+
ID4gQ2M6IEplbnMgQXhib2UgPGF4Ym9lQGZiLmNvbT4NCj4gPiBDYzogSGFubmVzIFJlaW5lY2tl
IDxoYXJlQHN1c2UuZGU+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL252bWUvaG9zdC90Y3AuYyB8
IDYgKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgYi9kcml2ZXJzL252bWUvaG9z
dC90Y3AuYyBpbmRleA0KPiA+IDE5NTVjMGVjMjA5ZS4uNzcyM2E0OTg5NTI0IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jDQo+ID4gKysrIGIvZHJpdmVycy9udm1lL2hv
c3QvdGNwLmMNCj4gPiBAQCAtMjQ5Miw2ICsyNDkyLDEwIEBAIHN0YXRpYyBpbnQgbnZtZV90Y3Bf
Z2V0X2FkZHJlc3Moc3RydWN0DQo+ID4gbnZtZV9jdHJsICpjdHJsLCBjaGFyICpidWYsIGludCBz
aXplKQ0KPiA+DQo+ID4gICAJbGVuID0gbnZtZl9nZXRfYWRkcmVzcyhjdHJsLCBidWYsIHNpemUp
Ow0KPiA+DQo+ID4gKwltdXRleF9sb2NrKCZxdWV1ZS0+cXVldWVfbG9jayk7DQo+ID4gKw0KPiA+
ICsJaWYgKCF0ZXN0X2JpdChOVk1FX1RDUF9RX0xJVkUsICZxdWV1ZS0+ZmxhZ3MpKQ0KPiA+ICsJ
CWdvdG8gZG9uZTsNCj4gPiAgIAlyZXQgPSBrZXJuZWxfZ2V0c29ja25hbWUocXVldWUtPnNvY2ss
IChzdHJ1Y3Qgc29ja2FkZHINCj4gKikmc3JjX2FkZHIpOw0KPiA+ICAgCWlmIChyZXQgPiAwKSB7
DQo+ID4gICAJCWlmIChsZW4gPiAwKQ0KPiA+IEBAIC0yNDk5LDYgKzI1MDMsOCBAQCBzdGF0aWMg
aW50IG52bWVfdGNwX2dldF9hZGRyZXNzKHN0cnVjdA0KPiBudm1lX2N0cmwgKmN0cmwsIGNoYXIg
KmJ1ZiwgaW50IHNpemUpDQo+ID4gICAJCWxlbiArPSBzY25wcmludGYoYnVmICsgbGVuLCBzaXpl
IC0gbGVuLCAiJXNzcmNfYWRkcj0lcElTY1xuIiwNCj4gPiAgIAkJCQkobGVuKSA/ICIsIiA6ICIi
LCAmc3JjX2FkZHIpOw0KPiA+ICAgCX0NCj4gPiArZG9uZToNCj4gPiArCW11dGV4X3VubG9jaygm
cXVldWUtPnF1ZXVlX2xvY2spOw0KPiA+DQo+ID4gICAJcmV0dXJuIGxlbjsNCj4gPiAgIH0NCj4g
UmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KUmV2aWV3ZWQtYnk6
IE1hcnRpbiBCZWxhbmdlciA8bWFydGluLmJlbGFuZ2VyQGRlbGwuY29tPg0KDQo=

