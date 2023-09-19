Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E8CCD54BC
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Sep 2023 11:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pu8n1YpPIt+GSzyUeoOm76CrcdGH6kFNErE0fviQcLI=; b=MuUNbZTG8x2fE6Ptff/u1ipVFs
	JQ0o0C3vmHRP9HpRzjG2WX2TdvP0sD7RIBcGhJI0Po4onafaOJNPkgQookaxN1JUsinvr41o6gScU
	FvMZksP4jiZYBOlegvCaNybIyeJAtEnuMMcOVTDIBIwyXY8hUBE+kQWBOIxGBehMmi6rlviui72O8
	3QZmH3ernmJvQMTqqqdU3VlzBRbobjQEqb7m8WSsyo85s2/z3i5ElTDXHDPGMdGEObNdnAqQcZA6H
	khvChqOSXgVXW+KtsF8nPJoFI6FpCaDaSQJKzaxl9faUabRHZ18Sv63DNT5Vp/0BT6VnJfE1kU9L2
	JbBHIwdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiZH4-000KxQ-1z;
	Tue, 19 Sep 2023 11:52:14 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiZH1-000Kwn-3D
	for linux-nvme@lists.infradead.org;
	Tue, 19 Sep 2023 11:52:13 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JBC8t4015978
	for <linux-nvme@lists.infradead.org>; Tue, 19 Sep 2023 07:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=pu8n1YpPIt+GSzyUeoOm76CrcdGH6kFNErE0fviQcLI=;
 b=ww45sDbU3J4wh2YhYpx9R3O03GwWTfNxeF2u1Y35xa1ddAif+UzU2PuLEtUt/hKlnegf
 rXFnSOFTwi85L2adnyzic6WryOtUS/GUdHPim/yI50g8hnYZXgbumL8ER9Jibdbqo1tt
 b/kE4f8sX0p+mjB0IERWx3meMPf7S0rYl7rHhLJmkMUWj+8Zm6i+5HIVeS1JLiyAee4m
 B8A7LnPJ4Fa0T6M3g35UvV/MzHxJZLizVyYhT0/6P6sHvoqcTU9b60fK2aQuHf2n7xD8
 IP6ULy7hfbkq9Rp5hLwqx8XydXIYhWdYlkhioOGmCvEUMwW93qgKii9lWIxvaGwnSIKX qA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3t586yuj8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 19 Sep 2023 07:52:09 -0400
Received: from pps.filterd (m0371675.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JBHVUo007806
	for <linux-nvme@lists.infradead.org>; Tue, 19 Sep 2023 07:52:08 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3t6trgc0q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Tue, 19 Sep 2023 07:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0wTB3E54VMyEzOKDFKglr24u9vCox+zsq9HxZEYpLyFtVTIU6zGx5yQKfia15qAk/PGwNUlqxCNy0HMDIvZ3UT9omPxTXGV/ZEOV7CUPBCSLE4b/2ofiyqks6JCNRZ9BB1YCJ6RPfWpTSMup7G/1dmkE6eR1V75wLnhfLBgRlqQTkQXN1ImCHDj56igLk/aEh0h3wVxE0QeCP5k5sBj8d/8TmfxLwLBBYdblKu5fANhKK/RvKqtwNJ4vavhcKe0d3gWGLZA1VtPqCMDKhZ2US1augakPaaK1vkFHPoGpk9nNX7LtzKAKoG4Ea7Uyg1izTW1PF1+cdycaTi4vCiynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pu8n1YpPIt+GSzyUeoOm76CrcdGH6kFNErE0fviQcLI=;
 b=LmHue76p0psjztJxlmcCg2+WEGN7JWDvIOzdJIJkRF61uklxH8y+nvZfS7Dmsn+JzAIiGuzhGPP31iahTHrNz0Sa929nftTrpYbjdVWclu/3mKrMly07ZoeRjpmtWJVvX5XRdDueQEZDV/40fsSJHNhJozCNOhF4e/dFyZu4W24JP4QpMxdok1xXh1frURLlRSycBqBx6tTrBODutwzO6Pns7jelig9M5ZSMe+07p1bE1h+KbsoRT8Et3hK0kWHabT727Xl1arwpQijtDTHaebaNiZcW+kwHDBU2rK3G8cXXekFBqtFpiK8q4twUld0NYsBIS8mSXISGjaycY3X8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by CH3PR19MB8325.namprd19.prod.outlook.com (2603:10b6:610:1c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 11:52:03 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f12b:cb86:53d:ee6e]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f12b:cb86:53d:ee6e%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 11:52:03 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "Engel, Amit" <Amit.Engel@Dell.com>,
        "Zinger, Eldad"
	<Eldad.Zinger@dell.com>
Subject: nvmet_sq_destroy stuck forever when data digest is turned on
Thread-Topic: nvmet_sq_destroy stuck forever when data digest is turned on
Thread-Index: Adnq7iO1RAClALWAT0iWmuSPClnDIg==
Date: Tue, 19 Sep 2023 11:52:03 +0000
Message-ID: <DM6PR19MB40114101A791D54572BD88C2EFFAA@DM6PR19MB4011.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2023-09-19T11:52:02Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=a708e209-c39d-4dda-9378-55750bd9dcd6;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB4011:EE_|CH3PR19MB8325:EE_
x-ms-office365-filtering-correlation-id: 03402fc4-efaa-4663-e754-08dbb906d75a
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGqdw9sNR4Q39a04a4shSEsCv6vEZVhAX33lDijlrWe16q4pPYCwbcOCcirPx2I9SifLwATBfDdM4ibh4wns99MMFKVISo2JjVWUDLQQEeUxYC0bpziJgJxcsf7m9YaiTxjBMl991dE8GFl8R1CGWoBCq/m3yxC5hZXqSQ0OkSBzEAqMvhe7vbaNfdYhPx/WrJ1SocgyIgG0r/jZouTF+LwT++kTKu/xXprjfrJrgQGyZT87zrOwyWcKIPnMkbzWOFKA+guJxrQ/xb7jOKORWjQWPR3LoGPwjxBhqmSI523MxquLvTspmV2F7Bf+URb/nfa+QN0dDYPWEBS4wNZB7ujjKvAi+0xmtJqV37XVxwOCuoPkKVGWqeyZHG8rwrqUqeoDiVNtanggUdawwRgF8XnP0NncJ8vPbynAwo9Bu07HN2xykOm5oqVwPawSkGxhIrPVTQg/Mnx2AvGXjr7SipH6Y/n04NMjFMsK9PqG/rfSOKJVPMe7Q/6i4uEeOKb/kcw1Y3KnA1hxiJtJsfrLghuSICuZQ0eVTEn7UfULkUb0ky4j+5GNEFVh8I3VYheiozp+u3FqiYuDYbMXfVxhq6F5lx2eD47HWhKFopnslSHw9K/pIpUTJVE3RF3wGtKs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB4011.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(136003)(396003)(186009)(451199024)(1800799009)(9686003)(4326008)(7696005)(6506007)(26005)(107886003)(8936002)(8676002)(83380400001)(82960400001)(2906002)(122000001)(41300700001)(66476007)(86362001)(64756008)(66446008)(786003)(66556008)(66946007)(76116006)(52536014)(54906003)(6916009)(316002)(38070700005)(38100700002)(4744005)(33656002)(55016003)(71200400001)(5660300002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFBuVWppaEJoY0JUdHlSSDhqdXQ2RXdyRjZGV29JRW5IRExvVDYxdTIva2g4?=
 =?utf-8?B?OUFkYURwMzRmajhwSzMxcThUQUhRakp4TGI3MUVGb0lYYm9VNXhOYzJGQld3?=
 =?utf-8?B?VldKVWRCVVBBTEVqVElPMW0vb2lyM21ibnZYeCs2MHRuVFlLdlJma1dpWFVt?=
 =?utf-8?B?YzhLcWZuaU1OWjBvYkVHcXkzTndIdVdFYldvVGFUUUNvaWlTUjVlWVlPSDRP?=
 =?utf-8?B?clFuSkdOSFN1SG9rWlNHM2J1a09LMlpGN2ZVNUlNQStvTmhnenNnMlNqUVVQ?=
 =?utf-8?B?T2N2NW4zak83d0cxajNUT2xDcmNPSU8wVzZOUFdpS04vaDRLT21Ka1RjRnRZ?=
 =?utf-8?B?UWhNUTdvN1FIb1U3TzBnN24xMXBMMFYvaUk5Q0FxVENPZ0h3d21wdS9HQjRQ?=
 =?utf-8?B?cC80SWR5NFZrWndheDA4WkZicmptUUFYekpyQmlVZ3BmTkZJb3ZRRWJSaTlB?=
 =?utf-8?B?YkpxNXJDOEpPaDVjenJYakVpQlZPdDdvaWZWc3Vja2VSSXQ2K2cxTUQvWGlK?=
 =?utf-8?B?TzZlYVRQQlVDRzd0ZGFkMVZQNmJaOFF6VmlZcU9TZ2FWeXRtT2ZKY09TNFo1?=
 =?utf-8?B?WjFSc0pEVjExbXdiVVN1NzRRb3lpbmlleDRGNFBlc0RiQTFaSEtRcDVPTlZO?=
 =?utf-8?B?RzdxL1VzOHVJVXFqdzQ0bkF6VGFIN2k4dmh4K09xWHZJNG1Yc3BOR3JGWkd0?=
 =?utf-8?B?TFhNRFljbXNBcG9uOGkrc3p0Q09CWmFGeWVnQXpQempCeUFVVFM2aFlabnJZ?=
 =?utf-8?B?cGV1RUZzL1ZDeGNWekVldmNOZktFSVdrM0NLNU1SdFVlZ0M4WTZKVldlby8w?=
 =?utf-8?B?anhUekY1VTJEeWs2TVFwNytEV1A2ODA5M3dJMC95aUs0WEUvZ2lDUHpEeEUv?=
 =?utf-8?B?emNwajFZR2ZJdE1TWDhvNnBDN3hpcU5WYXplZXN3bkxlVU1NaUg4bFdyTEJV?=
 =?utf-8?B?MnJSZ0cvNFB4MDdHaTRTaTJEK0tEdXRtVlc0UmtHcXUxWXpNdHZIbWlJYlha?=
 =?utf-8?B?b05FanM1aDVBYjhLTlN4clQ5TmkybG11OEZkT2dZNUNVcnlVcHBXTU1JUDYx?=
 =?utf-8?B?dzN4VjZRN3o1NGkvbjhLMzdtZi9Ma2RUcWxHVnV3RDY1ZG9jcHZJbTJMZjNW?=
 =?utf-8?B?YjRBS0QzNUZSRUhBRUhJNkE1b1h6QWR3K0NtN0J5TkNweGtyRTRxN3pqNTlR?=
 =?utf-8?B?SlNDTnA2cHJZK2JYeFpXMzBJRytwaTBpNVpDQlNsanhTK21JeG1vdkhuK0R2?=
 =?utf-8?B?bWovdUtCd2FuSG9VQUxEY3UxczJwNWswbVU2QkVxY3B1Z3BuSVpZNk05a1lI?=
 =?utf-8?B?K3YzWFd1ZDZuUDZ2bkwvbU1DTFRTblo1SExrQjdvcDZMN1I5WEZOQkJGUWlr?=
 =?utf-8?B?Mm5tOWdnNFFqNVJaL2c5WjNEUjZFZlYvUDZsM3pKdmpMdUVkNUo3RXZsUWZK?=
 =?utf-8?B?OFkvL0hUYnVoV0VkbE1TNkw4dVpCTGswRUJVaktKZXAwWEN4cDhMU2ZGYXF1?=
 =?utf-8?B?czhRTmUrb3YzRE5BekRmeGdwa0dqZ1FmNG1ycEVLQWM2bXpvdkhCL3IrYjZk?=
 =?utf-8?B?Y3Brclk5Qnc3cGw5aDFZTnU3U0d6MU55VGNhcWdCNlJiaS9oZ05SL2QrZkN6?=
 =?utf-8?B?S0R5Z3JtMDV5TDJYa3hBZ3pnNWdzaStlbUd2U1BtMVVZdDRDaC9MTmJhdWhQ?=
 =?utf-8?B?SWpSZFFVVWRlL1JISTNkeHduWjZXdWZwVFRyaWo0ZitRTmlHTWtpNDZmcTZx?=
 =?utf-8?B?Wm55R2k2enlSVktSQWw2Y0YvaTdLa1pQOWlNTThKYVd4MHlLZVZjb0pPMXAw?=
 =?utf-8?B?Q3RoZXhpTUgyZ2s3TU9IaGM4K1ljVExrcCs4cW0xL3BIOTE3dFVXczBzazls?=
 =?utf-8?B?Z2gzTzNSNWZURDAwUjVMNkVyL0RlZ2tlK0xxT3pDeWk1RG9TVFdrNGcxaGhI?=
 =?utf-8?B?bFpHUU1UU0RrdWJEbG0ra1NQc0xlOHFPRU83b2hJVytjYUhxdWg5TXVnUFNr?=
 =?utf-8?B?STd2Qnd2M0NFSnRDbmhBL3VzVlRSOG94YnRyNWZCaWpsczJaSjhLTEJiWUFY?=
 =?utf-8?B?VnB1a283S3Z0ZUxiTGo4MXFXZmQ2OHZwRFFlcndBOEtLOElpYWdxWXNYdUoy?=
 =?utf-8?Q?pu5CBWCgS/jT5XOln//eyfgRl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03402fc4-efaa-4663-e754-08dbb906d75a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 11:52:03.6833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3RIWIXmHboHB/C8MTDww/EZZy8eecugVrmXeAqs7r3nb7mX5PYomR949M5AdHlfRxCKWsVN+8NGQZibRSEQ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_06,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=557 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190101
X-Proofpoint-GUID: uCTJ6MIQXKi62vDn7z3GY2I6t7nrRrUJ
X-Proofpoint-ORIG-GUID: uCTJ6MIQXKi62vDn7z3GY2I6t7nrRrUJ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=634 priorityscore=1501 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_045212_350286_AC71D68D 
X-CRM114-Status: GOOD (  16.73  )
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

SGkNCg0KSSBoYXZlIGFuIGlzc3VlIHdpdGggbnZtZXRfdGNwX3JlbGVhc2VfcXVldWVfd29yayBo
aXR0aW5nIGh1bmcgdGFzayBhZnRlciAyIG1pbnV0ZXMgb2Ygd2FpdGluZyBmb3IgbnZtZXRfc3Ff
ZGVzdHJveS4NClRoaXMgaXNzdWUgcmVwcm9kdWNlcyBvbmx5IHdoZW4gZGF0YSBkaWdlc3QgaXMg
b24uDQoNCkkgYW0gaW5zcGVjdGluZyB0aGUgY29kZSBvZiBudm1ldF90Y3BfcmVsZWFzZV9xdWV1
ZV93b3JrIGFuZCBJIHNlZSB0aGF0IHRoZSBjb2RlIGhhbmRsZXMgJ2RhdGEgaW4nIGNvbW1hbmRz
DQpUaGlzIG1lYW5zIHRoYXQgaXQgY2FsbHMgbnZtZXRfcmVxX3VuaW5pdCBmb3IgYW55IGNvbW1h
bmQgdGhhdCBpdHMgZGF0YSBpcyBzdGlsbCBpbiB0cmFuc2l0Lg0KDQpUaGVyZSBtaWdodCBiZSBj
b21tYW5kcyB0aGF0IHRoZSBkYXRhIHRyYW5zZmVyIGlzIGFscmVhZHkgZG9uZSwgYnV0IGRhdGEg
ZGlnZXN0IHdhcyBub3QgcmVjZWl2ZWQgZnJvbSBzb2NrZXQgeWV0IChha2EgcmN2X3N0YXRlIGlz
IE5WTUVUX1RDUF9SRUNWX0RER1NUKQ0KVGhlIGRhdGEgZGlnZXN0IHdpbGwgbmV2ZXIgYmUgcmVh
ZCBmcm9tIHRoZSBzb2NrZXQgYmVjYXVzZSB0aGUgc29ja2V0IGlzIGJsb2NrZWQgYnkgTlZNRVRf
VENQX1JFQ1ZfRVJSDQpIZW5jZSBudm1ldF9zcV9kZXN0cm95IHdpbGwgYmUgc3R1Y2sgZm9yZXZl
ciB3YWl0aW5nIGZvciBudm1ldF90Y3BfdHJ5X3JlY3ZfZGRnc3QgdG8gZXhlY3V0ZS4NCg0KQ2Fu
IHlvdSBzdWdnZXN0IGEgZml4IGZvciBzdWNoIGFuIGlzc3VlPw0KDQpUaGFua3MsDQpFbGFkDQoN
Cg0KSW50ZXJuYWwgVXNlIC0gQ29uZmlkZW50aWFsDQo=

