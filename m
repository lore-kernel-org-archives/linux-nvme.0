Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B7CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 13:55:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD4961108
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 13:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2FD4961108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y7NA8WVY/2BYl/7v+Au/OH6O+bAUS9Sbi9z419CSlGU=; b=sq7t574G51rnhj
	2isCxkwEpFdt1PLuhaUBXJhuK6UKMIN6EMzy79uB6fnOUSY9tgvqwGUfl0cWkwctpIKwO9ms0HL+P
	wzo4bccV/kpEgpjIBUKwPNPxly+UQmwVgry55lkMnb3PmNQ5NyJ1cqN0LptenaUNvUKooTg2fvwpa
	wVOQg68nWt5hEQO1Z2U3U8KfYhA9BxeJWNhfBzVZn/czbvazlZ9p/WjJvfcekOec7vcrYgYhBg3dZ
	gWbSN2bC+Qvrtuvra3rjQGW5hk3YSMTRAwQHBRh7fWtB7Bj2IFWE/xY6yq2FRlCxm7coBbajh3L4n
	C2bb0QANfr7WgIdjdF8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ8tH-005uUA-KZ; Tue, 14 Sep 2021 13:54:27 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ8tC-005uSN-KO
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 13:54:26 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18ECdNo0025165; 
 Tue, 14 Sep 2021 13:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RsyrLE8+j6W3vkLyrJP68aIlXCcdr6Ur3u6TQgo+ONM=;
 b=bWR8WM71zPCDwb0JGsA4GlbDZVyeX/t8wjDHG740LmYiKUFY9TtJSPjdhT2z0MWYAmmu
 cxzKA4kyg6DW7gqiOeSRAOj+j52u1PKXyHtB7cqJDgv+ecbQO4xe5IxQl31ZGRll0vEr
 P6XJcwAz6Ula5HfEuaqQjEToWsN/0JEv9XMLSH7WRDhUB3qgdJMdUSphLYwVJcNZYDxI
 H//WmLpFoGC8++hl9f2IOSOFo+3gT2PfREUun6nP/v6hohxaPLKI4tkgIos61T/J3ceQ
 iw6Ubjdq6/4TFnrq5J3lv9Z5bFOKqLuUiDWHrMljHvPJ8xO+X+0uGFq5A0sTIesYhJFt ng== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RsyrLE8+j6W3vkLyrJP68aIlXCcdr6Ur3u6TQgo+ONM=;
 b=IrcMkLeJazroXL9Q4ou5luGLtY1atRHCoHey4abc1k+YG0W1UbWdHrorGQfzQilzo4Oo
 WVEhE+/bJN89gsO7MYGIAuTgYouHQrDC63bbS4cS9Tzk7txKhrMZ34LHkec0oLmc8lsc
 +wkVjENamXaSSo6zZ0YntXmmmc3yf8OZOk3jRCsBeQvu/XILtZWQ0fHO1kDrL5SvR/4t
 NPC1+0XxE658GrAiv8kZQ7Sbq72FUIllPTFev1K4NP+1P680gDN7r95F0jFNOwUoOfld
 LDEjoKJjyNub4q2/9n3gO7qGS8RFSggljCMz6DNPAizExvBbLWTYMOAqMb6eEr+oS5f0 Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b2p3mhm18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Sep 2021 13:54:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18EDoXve083121;
 Tue, 14 Sep 2021 13:54:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by aserp3030.oracle.com with ESMTP id 3b0jgd5fjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Sep 2021 13:54:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzVX/VZZQPDacbot34Hd1+0x/9oD/C9ZQAeETINjBh74uW5FT4JlhBk8trNob5f1qGzFmm9om1XLV1X21Nv9VoOhnfOELGq1mFyr8Zqumd8sV+HVaUP14nGwV/rlxd+LdXdyJ3GAojFSvdW5GhF6QURlgiDyXP/4ZQoIUZbnBYI+oY20Gb/JAsuVhqRSQRFhQAsCfRli8qXpvJuyoLWUqG5zgd4onrtq/d71NU0CSEyGIfwSEqUWCgFXEWv+VuedvtklM8kjCJ/Ze8puHapVhniu/ej1CrKeN4qsqlSiA24jPGKlhf3HPsw0aUojB5UqOs9SCtCv0h5zkRY+3wlRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=RsyrLE8+j6W3vkLyrJP68aIlXCcdr6Ur3u6TQgo+ONM=;
 b=RTMAPqV/VbmR8gs7ZILzgHouBG0xAQ18PMyfLj28SRW6GAiXuP839EL9UJcVuhYK/m1+mGqQ5Z5U2T1Z5Nu3ZDwn5NAiewnKwvD+m3v5ZK2VSXohWck69nvnhBPmFTKCEZ8/Ng4udMtYoqAuMGAIflbuiXTEDSK6ugIa4VGEsWvArTGto1bxdxY8tJ5z6OaaZoKhz5pKdYbA+X5cclZ8BDvuJpKCGZyLlDX7Jbtnd+lUu7lJH+jKhLLz5SmpemFrBG2B1HdscZHanO7fjL5H3PnEHdSjp9NFmyiY+zogMqrvGXN81YbO9JHigY9swe6OdzYQJw2tNClt41veUIbEAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsyrLE8+j6W3vkLyrJP68aIlXCcdr6Ur3u6TQgo+ONM=;
 b=Hpu3AdAyHESaZhxD0xnmcb+lhR1oUW+CanQAW+2LO00Ru61Z8isNApza4OxcrHItkhjdGOtsn9mWwrZJhmUq2O8lLRVPtQKDHPFXIgpVU8UUoWwIQho1AtLrmUfhPJm3vqT19YNQrTDF9TisATVsrdGuPReMBKg54RViQlB1no0=
Received: from BYAPR10MB2934.namprd10.prod.outlook.com (2603:10b6:a03:85::22)
 by BYAPR10MB3127.namprd10.prod.outlook.com (2603:10b6:a03:158::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 13:54:05 +0000
Received: from BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::d477:c047:7008:7696]) by BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::d477:c047:7008:7696%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 13:54:04 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, open
 list <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>, Sagi
 Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Ming Lei
 <ming.lei@redhat.com>, Wen Xiong <wenxiong@us.ibm.com>, James Smart
 <jsmart2021@gmail.com>, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v7 2/3] nvme-fc: avoid race between time out and tear down
Thread-Topic: [PATCH v7 2/3] nvme-fc: avoid race between time out and tear down
Thread-Index: AQHXqUm6bQoXhM+Hf0qUpfm3K4xMBaujjWEA
Date: Tue, 14 Sep 2021 13:54:04 +0000
Message-ID: <5A104918-0FDD-47A7-A667-7071AB2AEBA9@oracle.com>
References: <20210914092008.40370-1-dwagner@suse.de>
 <20210914092008.40370-3-dwagner@suse.de>
In-Reply-To: <20210914092008.40370-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca0c4b21-4907-4fda-7817-08d977871d86
x-ms-traffictypediagnostic: BYAPR10MB3127:
x-microsoft-antispam-prvs: <BYAPR10MB3127D71636F3208C6CED5FA4E6DA9@BYAPR10MB3127.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27NQSYlp1Bk9rLBLkcR6MfKunTtU7MLDV49cwMAHNYpbGsd4XPclreDuuEExvnzyzwxno6srDB0MtTCna13x0fvjMo0In+KZ/b0A31pJGCt01avIe/Bw6HU6J7HuflOHIhhfDJZV+kMxWBCMXUV2k8797RlbU4zInC1M91DJAbKh7JdS/X4sFIO3fy4GnCTy0I0FGnHqpMg6t8QIS+Acr2OnD/DmJCpuiwDVJSclAieMHQwzhHTPrR1k2xz0yJNd9HFggbbWSVUuyGDGSL9Wl0NCZrB4soz4+x10lUNA6/4yHIUe1LBqGKgqnKsMss5F0aBvXnEvZW7o8UOiux0P6NzBMVXgUZA+4qrrZXpn2yxwcpCGurm/8D9ThBs6kaKsZIlncXe8S83lVGN8jjM7VMB3BpuWM4upz7FYICRWwMqESJmNv/o72dCmdFoLTHQPkh7RT8pdohMyUWLU07o6myY+7S3TMLph69nM/2w/nhdGcKTVm+Ou3ftkGgCVXVLsOVXUA/I8iteDZWs043LFc1rNZqgmvxxGZk6KN+e0azkLura0STIvS2ggsKEA6taYDDkjXGeKNyQlnaIViq+6u5ttPQuWHt5N90ZYDdc74ToJ9p3xtpL2GAKxdj2xllmmQbJH8IqD7rP5vXAf/8ksHLtuJJ9zn/8qiQXukdcudf0/0E1mdyAtqmDGmqHHnFSQms11bG54Ag+Is++LiUBicbR6f3TOb1nyvwZSHNQFEHItO9CXMlzacjukrkD3zYcj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2934.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(396003)(136003)(346002)(366004)(39860400002)(66476007)(36756003)(66556008)(64756008)(66946007)(8676002)(91956017)(6512007)(4326008)(76116006)(122000001)(86362001)(66446008)(5660300002)(38070700005)(6486002)(38100700002)(71200400001)(6916009)(478600001)(2616005)(186003)(33656002)(44832011)(7416002)(53546011)(6506007)(2906002)(8936002)(83380400001)(316002)(54906003)(26005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SXfbfXj86TrWMDXJyR1lhuqDYZ6Oi+kaolAiWJyrQNRWcu17DL85oQKSn/pu?=
 =?us-ascii?Q?Nhf8Ec8R897nCHiv2Bh/186qoeiYGvaBn53J26tvDyHNtgJZ0NWIGaW3J6nT?=
 =?us-ascii?Q?zZp2il6M2Dv7GLOA5wiVw41N/SArxwaVlZlQeZszvq4g3fTnxNGVp1ckAJM9?=
 =?us-ascii?Q?mo8qoJEQ5nG/2cZwq6Qv7JJmAUyjG09Mj9Wom28Gwlzeaz2TDB61EuvBprtM?=
 =?us-ascii?Q?HT/ZspgbyDlIHO6N2kowWezZ79kxdOsd7c98aN5A3QYmMfmUiNmKsHunqAv5?=
 =?us-ascii?Q?AiRnK8bTvrw0o98lxZXZkz+xyf+zLiPPUdKys9ynfpCWqs8bPPx5Ew/E/HU0?=
 =?us-ascii?Q?v50HhWmzLdeCb76TbFJr1SneYSju+qSFZEi8mJOUdLDatsdBYCYFGCz1JurR?=
 =?us-ascii?Q?3iT7Bt7tXyfG9J5QAN+CkU3keTorErd8b6dNHlufgXMEUnzyBiOlFSo5btnu?=
 =?us-ascii?Q?Y7WqIPYLkWARnA/xrCP7bbfkTefUPs99piMKmE2D/Zs6zyvsvqTqk1ZNAIfd?=
 =?us-ascii?Q?lcCIRrSzHY/QdW3pmWOG2F9rs5QPWPBRt0bhzO7I+re4cyw//MJyjMP50d8n?=
 =?us-ascii?Q?N6OyvkTn1TWCGbkTWp+4/IfBEW8OZLfXHLSqcPxt/DzfqMYQ2i+gEKz6RwUZ?=
 =?us-ascii?Q?bOeu1Yq6aPAlNJigPLGE5h37aTmH7JxYtsRm0Qrhq/YN7QjElnVN/IMnRgbo?=
 =?us-ascii?Q?N5kzjkA8lVJQkzopo+5fVcEHxpK4jAjJgXvgrtX2IlM98ZJjYlI9naouTaEp?=
 =?us-ascii?Q?Al6yTyUPmHxeZRsR4YLKx6LxjcVwLn5pIT5llCa50iOmmmQ4uAGJECyZwXAB?=
 =?us-ascii?Q?WJrZmTtVX7StwYWdZ3ZtWsIRA6fy4zoM5X67RkWxQS9WnG5Re+RolQxRuRUK?=
 =?us-ascii?Q?dZA06dlQfOJqRgrIhv7NQnQE6J19ieH2Q9S7OEf7v6neUCY/qW5jhsr28H0O?=
 =?us-ascii?Q?+bDGjoslizecBAW36z1DF5bnaJjEx5S1GejUWek+uDNB4Bg9+M7S9w2D03B6?=
 =?us-ascii?Q?HNPaHU2PdpiNVNSGcwdRsoP7oBAlja6rojbUAafMHSLWKU4G7pcNO8wRj1iL?=
 =?us-ascii?Q?9j2es6fjGaf9F3cwulG/QeF6GqbUYe2M1E+BCHniV8zR/WiYUc/IRZZPG+1p?=
 =?us-ascii?Q?oQpm1UxAHs+zfvhkRrzvH/cVbl+XwxS2XkA43+4JEDVYt1i7Yalqbhrwg8BI?=
 =?us-ascii?Q?tEO5ybvMnzfa2Cv3dTo5eI5OH2JY/Uqgk5Yy2+sScKBrOSA33y9bleRS3rYb?=
 =?us-ascii?Q?6mOBTd+3Yl/uQweM7wO6k7ckYJ+nvLL01WDbEXdPi3U5YZjKnL90PRfBdCq0?=
 =?us-ascii?Q?8WEzS4zLvGVaUt/0fCMU0AAzIZ7mt839RF4g2P94veOMEw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <8177ED2B50AA2148AA47663AE1FE5E2B@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2934.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0c4b21-4907-4fda-7817-08d977871d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 13:54:04.8928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3m8FP0a1k0h/Tbo/RQRasJD+U9BntSuH0HMrU+SKgNQ3Qc0Laf8d+6BfSywRyCOfoOoyMpBPFwGB0ITq3i/psrIvCKODVQccZS9C58J5lGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3127
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140086
X-Proofpoint-GUID: SC7T5Wp8erbUgmdqO8GVBMW6ni_HJKeG
X-Proofpoint-ORIG-GUID: SC7T5Wp8erbUgmdqO8GVBMW6ni_HJKeG
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_065422_724479_6CF9FCF9 
X-CRM114-Status: GOOD (  25.28  )
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



> On Sep 14, 2021, at 4:20 AM, Daniel Wagner <dwagner@suse.de> wrote:
> 
> From: James Smart <jsmart2021@gmail.com>
> 
> To avoid race between time out and tear down, in tear down process,
> first we quiesce the queue, and then delete the timer and cancel
> the time out work for the queue.
> 
> This patch merges the admin and io sync ops into the queue teardown logic
> as shown in the RDMA patch 3017013dcc "nvme-rdma: avoid race between time
> out and tear down". There is no teardown_lock in nvme-fc.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> CC: Chao Leng <lengchao@huawei.com>
> Tested-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
> drivers/nvme/host/fc.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index b5d9a5507de5..6ebe68396712 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2487,6 +2487,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
> 	 */
> 	if (ctrl->ctrl.queue_count > 1) {
> 		nvme_stop_queues(&ctrl->ctrl);
> +		nvme_sync_io_queues(&ctrl->ctrl);
> 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
> 				nvme_fc_terminate_exchange, &ctrl->ctrl);
> 		blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
> @@ -2510,6 +2511,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
> 	 * clean up the admin queue. Same thing as above.
> 	 */
> 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
> +	blk_sync_queue(ctrl->ctrl.admin_q);
> 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
> 				nvme_fc_terminate_exchange, &ctrl->ctrl);
> 	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
> -- 
> 2.29.2
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
