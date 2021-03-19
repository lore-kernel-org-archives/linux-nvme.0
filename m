Return-Path: <SRS0=D92Q=IR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691DDC433C1
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 17:27:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F4A61974
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 17:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F4A61974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VRaBRSH6KBbNy2krTA/7CQz6Md0Cxy92RyOq0S+m+IA=; b=jDxbO3eEg6wZqS53yKkBw/b73
	jNI4Fz5jX1cFknWqiwtaOOMEsmXvP+Vt0NDgCvRKbNOrbEvH2BKFz+xjveI7xcy2qObXGcEWQe/RA
	vub6+dBHS4Jlglcr9RZ5QgNDlPU2zC150DbIip/+GWceqGFDX/Wox+rXabWNPbVd5hhXNTTEmB3Du
	ZMk2WX435lZazDiCAGGdz68umnk9kAzVK1ERXLN3Wvp5zVTD7REC77MK25hwOZ5Xf49KPU4qEmBXg
	qk6gwB9KYkQOGnSYxIrG89dEpyE274N2C0Bgxj00/yu8Ky6JT/If1r9c+XAW/eIKRJVWoISNZ2NPX
	oAI5OoEuQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNIty-007qHk-Mh; Fri, 19 Mar 2021 17:27:10 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNIts-007qGd-MT
 for linux-nvme@lists.infradead.org; Fri, 19 Mar 2021 17:27:07 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12JHI7Tj023375; Fri, 19 Mar 2021 13:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ZLjB+igtWbXCIJ+XSa4CAMPaCYTbQZiJOsSPRrxCInE=;
 b=l6tQHnIg55MNzqRrDtH/PjxAqNM33uAO8jzkSxKC8VC5ngE3ZMcJZDgAgLnhIQtYe3E5
 xpdXziWiOKte+mV+YUDg2g+XVBDsGPYz2X8AEcFTyv0/25RvXhzMpbyhELWFXcRegqbA
 gzGNx34xD0/PcdFI9fDu+BRuB99K99I8nY6QdhXgG6gvxno4/lGMy80pQD9c8L/MCGGs
 0wI+OlAt6U0RYLVYOrZsBoP1IGWbS16ZhmDhfhs6jlu3k3EAN0TqXnslAUl+4rEMwbOn
 VNHZ9VyfubuVwcb0Jdl/WVV5z7wLHEr8muaaT5bLdXF6jLW4HhP63TGY5VIFenT+hGsg BA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 378skpe5mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Mar 2021 13:26:50 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12JFnNXc146410; Fri, 19 Mar 2021 13:26:50 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by mx0a-00154901.pphosted.com with ESMTP id 379bx8y1ky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Mar 2021 13:26:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9V0Bar+Lt/NayQWpWV0+NykfONaibmj8vBbZcYqpMmWt5qVqnSenkhXDtur6inmTfBUpsVEnQByjyXSQcd6NvktoMldRmg0eBNDGuzpwW/K2pU0WpEXfmI4yYp6HzTgVQ1BY80+IPzfhb6bzsIiFiMYA9SXAHDd7QBZpeFSrb4umFXAZbM2i6r2OamDrXCzYszWB4xRxWt/GYCEc5xSA3we9ZR6ZthttyqVhBtd0HNg3Q3x1BjlcY1NNmKo9G0GJnhdEE2m9raTqZ6WppvpVGfEIEdj8DhRdXn3F6/7IRbibekkI25MQgCTvebOdF9ihQxFSidPep8mPCny1n+FZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLjB+igtWbXCIJ+XSa4CAMPaCYTbQZiJOsSPRrxCInE=;
 b=JTW6SaprDiB0k+hBy2nGzsBBvFnk2F1WRJLDw59faegwALDLp9gwZBOS3yEXdbn2b1jzF/pH9kUbAVuOdKuosQi2mhHa/h4L87DyYGx+KL2w0e3faGVkb3xkSAx3H873zTMtM3oTxkltI9N2TL1yJESlxUgKKrwWUp4ZJ/9O8yEP107jX343Srd7XP38PdYNK5Cgo82N/0qPi9aiyDHFRc6XoMJlIS+OvpOl/ef01YI361G141vXVD1GWIJPcsx7YkIrt+6J0nXdS9L7puYboFkw1EY38GpmrE6sl0gXBhqlO0MxAuv4oeCwRsAcsvZLZHo3zWRHpmRfTYXgSiep5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB2940.namprd19.prod.outlook.com (2603:10b6:5:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 17:26:48 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%8]) with mapi id 15.20.3933.032; Fri, 19 Mar 2021
 17:26:48 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Hou Pu <houpu.main@gmail.com>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Topic: [PATCH] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHXG/X3WiVU5BueckeH6z3aGkWAn6qKrsWAgADiMhA=
Date: Fri, 19 Mar 2021 17:26:47 +0000
Message-ID: <DM6PR19MB4011CB40F6635EEC2AEF86EFEF689@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210318125518.27121-1-elad.grupi@dell.com>
 <20210319035257.96267-1-houpu.main@gmail.com>
In-Reply-To: <20210319035257.96267-1-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-19T17:26:45.5443699Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=1e6cfcb9-2db3-4578-89d0-6c6528215667;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [77.126.55.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4aa9014e-8b40-4045-34b1-08d8eafc2d17
x-ms-traffictypediagnostic: DM6PR19MB2940:
x-microsoft-antispam-prvs: <DM6PR19MB2940FAD5EF7C2D26736555E5EF689@DM6PR19MB2940.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tdnuI6M0YxTPC0Efup1COZ4/ZOvltzWVMTt6Xurcg8syVe4mOPkWKaVNAanAbg+35i63mAeqFVIKCiH6RiUQVVbvGKFhubeIQ/Y5j2DghK1VlP1IZo9ZGJKZeEObeeq3HKD26k3xd6HRV227ckQ8pxW9lO4E7b/WWCzo6foFQ/lBRVcEuHW/tTzYtiKxzki2dyQ1jGI7DwpHd+R3/qMKro5JYZkt3eUetpVlgnnnQMGrjj5aYRk/xagx2QcdTtThEntqTEtJR7TIifv6fCwICkrupG4znpgKe2qX35GI2wcXXedgu1rEWOo7koAkgzuvvu1RwQZPlkWrwr68hDySrcG+w3GbbUZe/SDgbltvSr2tWbX+/3TVmJWz5ByoejIF0qO+pzDNi7GUGqVg3Snn2aauogMcJuMSnr8wPI/ZIpkZD3Bc4ANqBaUR3bGYB8u7dBDMCsXalbDsFHFF7G23cFwlOfZivV7CHw4Wiktvt37ST1bpFVj0QfYrnVrOHkQiFKUG3h1A/0DUFA9CoIbi7fXZun1ts9tfU24Byf/PiFzkTGdQIki+ov3rhbbpFh12dSHLvCyJhJgsZ6W7y8AYqtI/obEDUMvQe7gOLMrsV/YQplYG7LEgLCYmGsUBM+BTwQ8/5fcr6IBOEdXWLP+EiWKZJmsnZrLtxK4Oqp/wwc4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(26005)(4326008)(186003)(38100700001)(786003)(55016002)(71200400001)(86362001)(110136005)(5660300002)(9686003)(52536014)(66556008)(53546011)(7696005)(66946007)(66476007)(8676002)(6506007)(8936002)(66446008)(76116006)(64756008)(478600001)(83380400001)(2906002)(33656002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bE4wbXlRVlo0aUlwWHovWis2WVBUalU0WDIvM2NKWHBSQVhITGcrYWFaRjYz?=
 =?utf-8?B?WTN4VzdnMEVJUG9YTkhqWW1aSjhBelBPL1RoTHBUb2w4c2ZPWkZ1LzlSUlhp?=
 =?utf-8?B?aVdteDZWd1ZkL0NIdUozUU5ObFRDL2F6QTFWWVFsL2VUTFh1SzhUU3lrdmJw?=
 =?utf-8?B?V000WFZZdzFNWlp3RldxZit6T3R5OHF3WjNYRkduOGlNQy9raC9Ra3FMV0JS?=
 =?utf-8?B?MVJhTHg2UG9tQTRoc2tRS2JkR1NuTGtZdnp2L2kwc3YxSGFGTDF5NlE0NTM0?=
 =?utf-8?B?bjVkcllHeW9IcFlpaVhHdXNYMW5JMEh4VDRlUkFFN3JQTVBST0RtSGU3VUpO?=
 =?utf-8?B?aEZFaFRnUC9zTlVZMk95TWRPQUdWSlJxWXNWNDlRN0V4YWlyNk10ajVJcS9Q?=
 =?utf-8?B?aHg5OWNQYnFLTkFhYm0vOHVkRTMyUXYrUXpTV0dhb0lJek9ZcCtUeWJTYzN1?=
 =?utf-8?B?SkpCb3JDUCt1Rlk5eDMrcThHMU9iRCt3eTQ0cTZ0WmRiUHRFZkdSRFMyVFJq?=
 =?utf-8?B?VjhMclB2YmFXcUx5QWdTaWo5cTVCeG5ZeTlIS1N2dVUwa1ZaOU5WMDkrU0x1?=
 =?utf-8?B?U3hVRHFYZGNSMHRuTkIwKytiT29jd3lTV3krcFBPVVBaSnVoK3VxVkh6dHZW?=
 =?utf-8?B?b21BMTIvSVNJdXlUTzV3WnBnNndmaGMvK2FiYVRIK1ZTenFSREFoRC9wSjd5?=
 =?utf-8?B?QmV1L2w5Nm1Bak92R201aDk4OWtEdkdMRzl3MlQ3aUw4b0hKVVRVZFZob1dB?=
 =?utf-8?B?NWxlNkxLU1dERXkreE05VEJMMjcxTWExN2NHME1Za0Z4VWJCVE1kQUVoZVgr?=
 =?utf-8?B?SUZaVkd0Q0VtUHhsN29MQWZEdlowSHN3aTArNjlaZ2RzdkIxbTVvajUzV0RN?=
 =?utf-8?B?SHphUnk3amNLaSs5bDVqdjVEMVNydUU5S3dZQjMwTURmQXduZnVLR3U4VFQ1?=
 =?utf-8?B?Snh2Mjg3UlAveE9qWjArMlA5SVpXdXc5YTFyYW1najdMU1A0Y1pEbnEwK1hF?=
 =?utf-8?B?UXlKaDZQN3Q4TnVPcGxWZzlWZ2VrUU1lN1BGdThSdjNxV1F1REc1UW1lUU9y?=
 =?utf-8?B?aXNFTzd3MVNzTVljRk4xWWFONlVZQzdWZlhWNmpORi9zRnZDZkdSSll1V3pn?=
 =?utf-8?B?Q1lVUUhvYllnUkNQelYxc3AyUS90WDlnUGd5VFJWN1M2UndnTWhiUEJXbWpq?=
 =?utf-8?B?SzNyMDZDUUYxQ3Jxd3c3S3dWd0hNMy9scjBpZGF4TXl5ZmlkUU45VW80TnU0?=
 =?utf-8?B?T3g3S1J6SnRScGNqa2ZiUVZWWld4cjcyNTVXN0RDaEMyVHdTS1VSeFFDcEtz?=
 =?utf-8?B?Tlgxam5TZHUxZDFEcnZMUWdNZDgyakRTVGFUN2RXWmJiV25EK3RaRkwxb1JC?=
 =?utf-8?B?bzJLbmZKZ0dzclFLZ2dYdGVWeWIyenZ0OStQWEpzOTlOUi9JbmNRWGFsZDFs?=
 =?utf-8?B?MWhrN0lRTjFxM0pSSjBOL0FoTnhqUnNuanE2VlJoOG1aMGtNOWNORDRBcFFD?=
 =?utf-8?B?WXZySUVqU3ZZVHlQUHI3OGUySnZuR0lvRm9YVHovSEgyRE52YkFJM0pvcUda?=
 =?utf-8?B?Q2xJNUFsM0Z2b095Ulc2Sk5RNFQyaEsrNXh4dnI3QlNmYmpCbll4Z1h1dC9J?=
 =?utf-8?B?WXhHdkd3Z0x1OUVpTE9Id2RTVWxMQ3dEVW1NTG9xOU9mOExta0tMTFlQbkIy?=
 =?utf-8?B?NDlxTmVpNjBnWnlCV0lWeVZSM0swVmVUdFEybVh3RS9Sb3dQdFo1TlhaRWEr?=
 =?utf-8?Q?E9AGq6kH1ObMPGVvu027PMSJY+ZIsNdnegMVouT?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa9014e-8b40-4045-34b1-08d8eafc2d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 17:26:48.1083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jzYi1wXgj/ALZtcIUuUNxMNqEBCod76K9LdliYSLYJ0YesqhFZFi+mMpu9QYiDIsHSBoGtB/79we0d6+kO0yIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2940
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-14_04:2021-03-12,
 2021-03-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103180161
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_172705_228334_9E00B546 
X-CRM114-Status: GOOD (  25.14  )
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

Right, I see.

But when calling nvmet_tcp_queue_response, the flag for NVMET_TCP_F_INIT_FAILED is not yet set.
The flag is being set only after nvmet_req_init returns in nvmet_tcp_handle_req_failure.
It is possible to block in nvmet_tcp_queue_response any command that has unattended inline data, will that work for you?

Thanks,
Elad

-----Original Message-----
From: Hou Pu <houpu.main@gmail.com> 
Sent: Friday, 19 March 2021 5:53
To: Grupi, Elad
Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me; houpu.main@gmail.com
Subject: RE: [PATCH] nvmet-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 

> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
> index 70cc507d1565..5650293acaec 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -702,6 +702,17 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
>  			return 0;
>  	}
>  
> +	if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> +			nvmet_tcp_has_data_in(cmd) &&
> +			nvmet_tcp_has_inline_data(cmd))) {
> +		/*
> +		 * wait for inline data before processing the response
> +		 * so the iov will not be freed
> +		 */
> +		queue->snd_cmd = NULL;
> +		goto done_send;
> +	}
> +

Hi Elad,
Although this works, I think Sagi would prefer not adding this to the response queue in nvmet_tcp_queue_response().


>  	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
>  		ret = nvmet_try_send_data_pdu(cmd);
>  		if (ret <= 0)
> @@ -1106,7 +1117,9 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>  	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
>  	    cmd->rbytes_done == cmd->req.transfer_len) {
>  		cmd->req.execute(&cmd->req);
> -	}
> +	} else if ((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> +			cmd->rbytes_done == cmd->req.transfer_len)
> +		nvmet_tcp_queue_response(&cmd->req);
>  
>  	nvmet_prepare_receive_pdu(queue);
>  	return 0;
> @@ -1146,6 +1159,8 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
>  	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
>  	    cmd->rbytes_done == cmd->req.transfer_len)
>  		cmd->req.execute(&cmd->req);
> +	else if ((cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +		nvmet_tcp_queue_response(&cmd->req);
 
Here we also need to check cmd->rbytes_done == cmd->req.transfer_len as we could get multiple data pdu.

(BTW, did you forget to add [PATCH v2] to the subject line?)

Thanks,
Hou
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
