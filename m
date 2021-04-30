Return-Path: <SRS0=VOor=J3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00283C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 19:38:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6B761400
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 19:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6B761400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tJ4kOhflT6uw1tIIM4dEctJNZx8FgTv7WEycKwUymms=; b=QZ7hIvWliVo9a5H0lsxH1jnO6
	ZWgxatddQofPvuNQO8KEzYJF+Jtesw4oUf45IcmUG7UUJaLH8cxngfaLH8MpLW/ZeTYt1SoaEHw1P
	pmtnLtGyUm7uvAEa2/p5eJ9levF5zlNeFSIih7s2z3lZvtxLoqVjWfPfZKFiqocuKZ1d3MZIH7OIZ
	lrA+w6CKaGkNCnAK3c5n+GceA27Y5iXRQLHiBeiPaMd/c3S2ueaKfY/0G2RhnOQEKTYllKRu0uSvD
	f9Plx1JkC2h4vc70tYpsNBIRzm1tSIkIAsx59R/6ofCM91yNPLFhcLg2or34RR89oBo+juNTVoDhZ
	7pH+wcC/w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcYxZ-008R6m-Dc; Fri, 30 Apr 2021 19:37:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcYxB-008R4i-3e
 for linux-nvme@desiato.infradead.org; Fri, 30 Apr 2021 19:37:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Description;
 bh=2nCTnj2BBbOCj1lAT2TNX+vzckzamsfGAcMxAybPeEk=; b=hRu6uJVtd0p+sYx6dk+B+H0UWt
 6+RCgGO8ejU9sD6QX+mmxPHFKMJKV7q0p6JGuLZ+MDWGXPdCMVwJWoqVx16NncnhSBxrZlxmfknX/
 XlOT7oAAz0OtbU/INvwfgYfSUth1VP+uCEIEacpvWoEi92hIMhesHXOHErevVZ+pb518yVAOeNWAH
 QPqwpWKDBhdW/CQBLSAXmQwLTKw5YAs6k6EO+GM/Nau/u+EdyACVZZa0VognUQDjg3lyl+JBJ3MQh
 HuaXQ3BjXN8pYUmbBA8WpvtWJEFpQOvPXcTJGcoH2TebAD6crWhz+IWHxKMFOoazEsK2u5Tsdo4od
 ocBRHuEA==;
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcYx7-001c8A-VX
 for linux-nvme@lists.infradead.org; Fri, 30 Apr 2021 19:37:31 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UJYxjB136474;
 Fri, 30 Apr 2021 19:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2nCTnj2BBbOCj1lAT2TNX+vzckzamsfGAcMxAybPeEk=;
 b=sb4A5F3fknaiZGdQIzaPnz9xj+HJOgukWOf7QyLgIlfzoLWcS5VE1C8r2c8asSw+FM8w
 TG8DDro2xOp9cDz9vvvGt17shCjUQPYMcGJpQjcTjtKbZZ0iQoFS4kxByCeCv3giIpMT
 Wwi/pNUv1SatfSbURJ4/6Oip/RfldfNbp7Zl5MiMCdD4YR14Sd7ySiM4htA7Nfz3TNMT
 /+0Cgmlcdf3W3vYFomDJgXeqjfMElnc1kEQDxL+/teI3WZBF1fkUTWNFMpMg02RlaA71
 swDulfPUkUF7EzEEmoDAoeV5+tSHVZ9nH7Uk3vfuVqXSNnVjDUXMuxWepJ00D7DSN1Ce PA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 385afq8u5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Apr 2021 19:37:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UJZ0XT144396;
 Fri, 30 Apr 2021 19:37:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by aserp3030.oracle.com with ESMTP id 3874d5bdqp-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Apr 2021 19:37:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XX+g8/fqx+ptFaSKyu0IG79JcajA5q8Ffx8CLg/BDUdYG74YEasYG0HV5k/FgB/LFJlNXPcECppXHi/T/J8V4WAomqCDfAafASEopPaRklTNHqFfepA+KJavRRG0ob1lPH/UkdC0dnFPUWfSMP/KsP7sdnFgFC3jDaZfyWyZiPfjWbSIA0zD/hT/5hiVvAzSoVDpS74a5RhtBQb9/rWjZGbm5s0kSVkAb/2NFSnuEi8Xqup+34YPLxHFI4YgqrmIYPXjAp3wqzNAQAqt5aQsCLEmif1KwAaanm1iBz5192HH9ZuVX2/FUJD8XMSpguAO6qHEE/wyxaXbwyvCOLvcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nCTnj2BBbOCj1lAT2TNX+vzckzamsfGAcMxAybPeEk=;
 b=AxBzZud0gbdOaycBUXmIMJiln0ehI83SzoCFTompozVVY3swYzSVKRQ3C9eXf+ekb26VYgpRt2Alnx5zKO8nAPTl8VMck+cg0iVKRkcklL9cTf63fInQpUizHnDTIloBAhy5oEmYidIFrrsgbRmmbSYH004YjdAa6ziIlKVnxC6I38NnekQ+jjALW7V7GVh9kvFQmXVrCrCjv6itnmVLQSuen3I+Z9UDhSngfbi8rfxUf/JaKJ6ZdUTt1RFwwDcBXMoujsai+73t1JyPgAShzjDwLsYdZ1Zj/WOKOoyNv9OXR3BGAaDqGzbwmeq4zcPAWXZamjSiHZnrOWkUxpllDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nCTnj2BBbOCj1lAT2TNX+vzckzamsfGAcMxAybPeEk=;
 b=uJONi68NXod0W5XVnjJeblR2HjXkAVc7FgfBlbvu/NfdeQBagMawrj7zMHuKuVlTuLBOsOo5GOUvWR9cCrP6HSlXVqedlcuOmlrnseGZ9KU0+H8YjvGSgaFgztkTlEq1xdct99VPfap6MPABcAXc9YNy366zDYlcENi1laEOKNk=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2701.namprd10.prod.outlook.com (2603:10b6:805:45::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 30 Apr
 2021 19:37:23 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1%4]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 19:37:23 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Muneendra <muneendra.kumar@broadcom.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "tj@kernel.org"
 <tj@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hare@suse.de" <hare@suse.de>,
 "jsmart2021@gmail.com" <jsmart2021@gmail.com>, "emilne@redhat.com"
 <emilne@redhat.com>, "mkumar@redhat.com" <mkumar@redhat.com>
Subject: Re: [PATCH v10 03/13] nvme: Added a newsysfs attribute appid_store
Thread-Topic: [PATCH v10 03/13] nvme: Added a newsysfs attribute appid_store
Thread-Index: AQHXO/Bgt8Q7z4GdAEuwS6ZaFyom2qrNeJuA
Date: Fri, 30 Apr 2021 19:37:23 +0000
Message-ID: <C2A9BD9F-58EC-4512-916E-7FCCB2CC00C1@oracle.com>
References: <1619562897-14062-1-git-send-email-muneendra.kumar@broadcom.com>
 <1619562897-14062-4-git-send-email-muneendra.kumar@broadcom.com>
In-Reply-To: <1619562897-14062-4-git-send-email-muneendra.kumar@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [70.114.128.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15a3d029-6493-463d-60e3-08d90c0f60c6
x-ms-traffictypediagnostic: SN6PR10MB2701:
x-microsoft-antispam-prvs: <SN6PR10MB2701EE2AE923C0EA74BBF011E65E9@SN6PR10MB2701.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xQQwDjSp9zHnZt1u6K1QQ4rYL3WfZF0/0RqhMNleM4/dix/3MQWQXSkB4zV6eJhNe9UFvqbQPc0yrxuJJXQjeeF8tQthomaFyD8Z+uD7NdC9P6QLLt9459t3fXzPPNtXas187FQbyIehpQOG35hkrK9hunLUyvoWFNs8b+waFGj2DhtbKXE9HGHpNOtH9pacbIjYCwR0IYtlDZHQ0dGNO+ZUgYHV/MnC3a9lugvRpowYoJzJnMH3Ti8/7u7Emr1ELv0IbCHlRuIl9C36/1oLrPHR5sBjl6mvDH/OvRun/MW4w3j8I1hwuHQX+xePBP0A9iyQ4uCH0dU8O7Yfp6IXNs1gxiPUevYuYTcOSYdviYJKepaFkdGG/kHZK6VD/crTGuhtCBTqglYTFGgiO9+MxHay42yYQYB3d6kQWlW/WF/0aVfx7kolx/N9YDFwgc84RAAPTVNDe63UUJNXwoxAfr2R4qzZdIXI7PsT9rl41+yNv1aN/FwHcNLeyxpIuJ1G3QnKLiNxrkzDY22HcSdRYpQz8v3vCiSJbzLThMTYnMkR0wz08CYmbP08LDh2uLm3ndCUNz1ZDe3Jzfen29bi3WiFv21okLG/31ijnEQyeAbFRx2cP+dRrZ4Bih0LNnQqgT8ttyGKHBAuWbGiu5RhHajm9/6Y2ivUO9cyd3g8KpE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(396003)(366004)(136003)(376002)(83380400001)(6486002)(86362001)(33656002)(71200400001)(122000001)(53546011)(36756003)(6506007)(4326008)(66556008)(478600001)(44832011)(5660300002)(8676002)(6916009)(316002)(26005)(64756008)(186003)(76116006)(8936002)(2906002)(2616005)(6512007)(66476007)(38100700002)(54906003)(66946007)(66446008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4jmCiIyBTAPjDe48BoY2uBdR2rl9Mji4qAOO4+vpqiBrQdC+brLqEx8FypO8?=
 =?us-ascii?Q?zCtuahJMPgPgz+nrXqxW99moSXq178Zs7quWllzHnq7vuqIg/UeFi1NT+S+Z?=
 =?us-ascii?Q?6TCjF/0Xc50Rr00P4/PJqPl6nFdvnG7vzQHDNFJIFNr0ixQo5rZV2Hhof78F?=
 =?us-ascii?Q?C3Mu28kEMA+gHpMN3C0suYgYQE0rABfNUl7ogLYxNx1NTcMjA0cAcD+qF8Gr?=
 =?us-ascii?Q?sZ5mEMgDXCzscCOM0L1vBz3quVqbtMr1MV6f8IPX+Rn7X4CB7IUTEJlNL049?=
 =?us-ascii?Q?kRwLmFPdOLl2ZTlYCKurpEURlio9VIngcF3puQcgXTB7qNCs2/BqCLAq4Vlu?=
 =?us-ascii?Q?K4x/SnPyD/eXw+p6LI/3ePYNLdftI42Zwbs8kOhEOUta9h9qIEPNVmVtmNrA?=
 =?us-ascii?Q?flLlA3Zh+U/mxAz/24aBvrpGtamp6dTTho06YzenPVTT+wbY0zPWACgrw0Vm?=
 =?us-ascii?Q?f7g8mQ/GHUzScKxN7ngVakiR1QkR7Utk9NDy8+AamoW5dfpeucDPZG4sBZkL?=
 =?us-ascii?Q?rJoekTr8FPciqhVBMAcwTxG/su4lzEeBlWKy2azTsc7Rpd8jtAVTpvpg21ku?=
 =?us-ascii?Q?F3vxZ+yRT3An6NLb9of1+V9FnNzp+P2fr0fy9ZkMtrjkHZk0+jAeAyAd52dC?=
 =?us-ascii?Q?vr0jR7m3ac4bIjIHGXV3UeOp5igp9A4IDYuvl4Uc2hc9Gc7FaOeQaPV3NFg4?=
 =?us-ascii?Q?3QooYKAVwdqQ0c/7pogl0iGMlpybq8sYcDKVk6cytvpiRLUIdX46Mi798RDw?=
 =?us-ascii?Q?TKZ7HM3KyN9mvH0fIkcrrFqGAQSp5SI0c2dZl35rVbjRqccR5n8D2miAb6MW?=
 =?us-ascii?Q?sJyfaRYvVUkgLH2uM1eWAYBvTH1gvyeAFaejeM2ncn5OWhdS1+sRu+CBUuHC?=
 =?us-ascii?Q?mQ2GU5twtm453Va69dw7t541CiWcJutqyti1DNmR1DWnQf5RWJ8+CA7W/2Fq?=
 =?us-ascii?Q?MDsuF5p61pNx75AzOv0Ir8O6C/p6sdJe3Xtohs+/c/W3swaAKriBBrgZ2Ser?=
 =?us-ascii?Q?SWbxdq+aDi7C2YhtI+aKW4SwFyxTJCeAWDGN37rj4QNk3DmF13F5qe8w7Tta?=
 =?us-ascii?Q?1LgOSJyuyy/JMUhWxw/LLl8GPXR7xbre32d8f2XDbTVp2jkzOMFHT4VtuE6Z?=
 =?us-ascii?Q?P8b8bVIMxd0R4i/VxylgIf4TTwef9z5/pM3sCjdV/TJIOcXY/9rifRgd0L5e?=
 =?us-ascii?Q?3KN34KZQ1V+dt7fSOTTp1mfJOuxk1HeNPfAVk4KP18TtCzNh9MTul1rbYdPd?=
 =?us-ascii?Q?YfV6X7z/j6AorHKSaEkAmUFNLG77W5l3M9FEQyLLVg4IhjJCb/gT4TpZsvaN?=
 =?us-ascii?Q?FsfkHxZy1xiNGxNP+s4QGX6gvslyIkEFdj5Lzx9p5jGO9A=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <23A43E7A8D48DD4C92F47DD69953E533@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a3d029-6493-463d-60e3-08d90c0f60c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 19:37:23.6622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tm6SPURLgRDPTBv79xWWLKro8uljjdLGmAosgtPJkPSvYBEDRN0R9eYa7tWJ2GxNOTUzbZU0F+Rh/edx9F0fGEwVl3kg9on8seixYywuwWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2701
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300135
X-Proofpoint-ORIG-GUID: JNrAGyieoKgXvUHVswDWqwBUBQPl5lQy
X-Proofpoint-GUID: JNrAGyieoKgXvUHVswDWqwBUBQPl5lQy
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9970
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210430_123730_132491_1E85AA39 
X-CRM114-Status: GOOD (  33.84  )
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



> On Apr 27, 2021, at 5:34 PM, Muneendra <muneendra.kumar@broadcom.com> wrote:
> 
> Added a new sysfs attribute appid_store under
> /sys/class/fc/fc_udev_device/*
> 
> With this new interface the user can set the application identfier
> in  the blkcg associted with cgroup id.
> 
> Once the application identifer has set with this interface it allows
> identification of traffic sources at an individual cgroup based
> Applications (ex:virtual machine (VM))level in both host and
> fabric infrastructure(FC).
> 
> Below is the interface provided to set the app_id
> 
> echo "<cgroupid>:<appid>" >> /sys/class/fc/fc_udev_device/appid_store
> echo "457E:100000109b521d27" >> /sys/class/fc/fc_udev_device/appid_store
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
> 
> ---
> v10:
> No change
> 
> v9:
> No change
> 
> v8:
> No change
> 
> v7:
> No change
> 
> v6:
> No change
> 
> v5:
> Replaced APPID_LEN with FC_APPID_LEN
> 
> v4:
> No change
> 
> v3:
> Replaced blkcg_set_app_identifier function with blkcg_set_fc_appid
> 
> v2:
> New Patch
> ---
> drivers/nvme/host/fc.c | 73 +++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 20dadd86e981..f0ce876700d6 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -9,7 +9,7 @@
> #include <uapi/scsi/fc/fc_els.h>
> #include <linux/delay.h>
> #include <linux/overflow.h>
> -
> +#include <linux/blk-cgroup.h>
> #include "nvme.h"
> #include "fabrics.h"
> #include <linux/nvme-fc-driver.h>
> @@ -3782,10 +3782,81 @@ static ssize_t nvme_fc_nvme_discovery_store(struct device *dev,
> 
> 	return count;
> }
> +
> +/*parse the Cgroup id from a buf and returns the length of cgrpid*/
> +static int fc_parse_cgrpid(const char *buf, u64 *id)
> +{
> +	char cgrp_id[16+1];
> +	int cgrpid_len, j;
> +
> +	memset(cgrp_id, 0x0, sizeof(cgrp_id));
> +	for (cgrpid_len = 0, j = 0; cgrpid_len < 17; cgrpid_len++) {
> +		if (buf[cgrpid_len] != ':')
> +			cgrp_id[cgrpid_len] = buf[cgrpid_len];
> +		else {
> +			j = 1;
> +			break;
> +		}
> +	}
> +	if (!j)
> +		return -EINVAL;
> +	if (kstrtou64(cgrp_id, 16, id) < 0)
> +		return -EINVAL;
> +	return cgrpid_len;
> +}
> +
> +/*
> + * fc_update_appid :parses and updates the appid in the blkcg associated with
> + * cgroupid.
> + * @buf: buf contains both cgrpid and appid info
> + * @count: size of the buffer
> + */
> +static int fc_update_appid(const char *buf, size_t count)
> +{
> +	u64 cgrp_id;
> +	int appid_len = 0;
> +	int cgrpid_len = 0;
> +	char app_id[FC_APPID_LEN];
> +	int ret = 0;
> +
> +	if (buf[count-1] == '\n')
> +		count--;
> +
> +	if ((count > (16+1+FC_APPID_LEN)) || (!strchr(buf, ':')))
> +		return -EINVAL;
> +
> +	cgrpid_len = fc_parse_cgrpid(buf, &cgrp_id);
> +	if (cgrpid_len < 0)
> +		return -EINVAL;
> +	/*appid len is count - cgrpid_len -1 (: + \n) */
> +	appid_len = count - cgrpid_len - 1;
> +	if (appid_len > FC_APPID_LEN)
> +		return -EINVAL;
> +
> +	memset(app_id, 0x0, sizeof(app_id));
> +	memcpy(app_id, &buf[cgrpid_len+1], appid_len);
> +	ret = blkcg_set_fc_appid(app_id, cgrp_id, sizeof(app_id));
> +	if (ret < 0)
> +		return ret;
> +	return count;
> +}
> +
> +static ssize_t fc_appid_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int ret  = 0;
> +
> +	ret = fc_update_appid(buf, count);
> +	if (ret < 0)
> +		return -EINVAL;
> +	return count;
> +}
> static DEVICE_ATTR(nvme_discovery, 0200, NULL, nvme_fc_nvme_discovery_store);
> +static DEVICE_ATTR(appid_store, 0200, NULL, fc_appid_store);
> 
> static struct attribute *nvme_fc_attrs[] = {
> 	&dev_attr_nvme_discovery.attr,
> +	&dev_attr_appid_store.attr,
> 	NULL
> };
> 
> -- 
> 2.26.2
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
