Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD49C19F2A
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 16:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d9/mtF8iJ+M0IENN4lGBIKoVRKSGdPWV/93yaqf/ZAc=; b=piW5nyxEZsnY7l6f6RYJmATB4h
	u4NEbfgeqOX1Zd0OtFHs59kTPvyUy/qOrc9MQdUXtDo3YXnqYKwDw/nBstYNitdGldd5+HNoCgl+j
	tYLtWzQ6n1DAdT1uYN817jOP0xq5+xJFEavjXeUDRGxAHk+Z/1BsoArkg9oj74wc4IpUsWo+5Tr/q
	29J+FSDhkCYzHbUwicaf2V0eu1z8jVc3sYqW2C5do8eFs8NZmV4v04f7eqzvBQ1kfZ1GeQEKLvYvH
	Hj/6MJprTVYXgFPtTLQJ6kEmxe+x10+FFsomGvAOlSQQVen8dA/s9VM1RddXvVXZWq3EV4V+eoNi0
	McnDJVmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIYA5-007pQh-Vn; Mon, 01 Aug 2022 16:20:58 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIYA2-007pMo-Id
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 16:20:56 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271G2q6X002976;
	Mon, 1 Aug 2022 12:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=d9/mtF8iJ+M0IENN4lGBIKoVRKSGdPWV/93yaqf/ZAc=;
 b=Nlsq0Rru/R8RpxNPwknSRuuKQFsZlKvPnEgjXb83ALjYYkbz1vWIaL+zn4k3D5C4nahw
 JDiktIw5CuVIvcE4r5nf0H2hKYpZN6rr3UPKKnTg6ZIM/4NYqhi5yI6VRvT9pZ6BUaPe
 LnJ2mNtVwMPs2Vtv/Wq5ah1Hl3YkGSMuIh9Elxt4g7MJ/P8wcVEmzff0Gv2HEPucRkvn
 VHkQKmRho8vEqUSPNc3/ZY3K+ULMgyQ9AvTccWw+GITVH2fBKVmv5d8cYaF1pwZpwPB0
 UnTOhM/qFsM/U1ZUopo2QvIf9ViC4wUqfQdQ7E+5yYzRePn23ABFDDj8/8F5OI5RWjks 7g== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3hmwquxjus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Aug 2022 12:20:48 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271Fuuq1005183;
	Mon, 1 Aug 2022 12:20:47 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3hpdgavw3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Aug 2022 12:20:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHXU/FZXXEp79hWs5tV3Qcusxv7eAfbDH6/BThrG3yZPkw1aWomA46oGxbYIkq3Z+m2AhOYb8tZ3tbKKjAJ1kY8E70b+mJVP8LZYSR+ks8xVQ6UVLKVZYSgRt3O3H2Kms9KO+fLWzQrYaPLCwltJVuEr1lqWy0K8rDO9vzIciu1OMDedOQSmW/Atx9ACDK74lbTqQoflMZAnIpQdpxXUiXuNFJoob4alQUjZlVjqLsjjF1XQ/1Pl5CwR6n9UtghBWCAQLxxmRdcYCgJ3qd9C0YVOVqhx4GyEbV+RmF5bIB5Q38YeGlCWIn1P8zp0KaVjsD/th3BMcSHvfc5VyWfKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9/mtF8iJ+M0IENN4lGBIKoVRKSGdPWV/93yaqf/ZAc=;
 b=FGqBIvUzBLvLEfqrxatDA/YCYXWDQW0O9vGXpHcyVJ8AZFdpznY1SLzYAN5Bc2PX5xhk6keXjaAABgw+RPAqBF0qmWsZK2lvORQFPD6d1Hs40No9C8zlsPslfzAVxk9RtUXxD3pkkxkZKCdfOb5SHzd3BJaaoe3OGZ2mwMxXo1W7ZtHI1sqcYP7cJl2V8RSeDSpKu+iJiSL1kuzdit9P0XpBlJgj8DWzVa3tQDenQge07zYNTWrvtTYezz5QShBihD0MnFrYuOvfWD54q0jKwjgJ0pvB+wmyNGjovvwD0pUGOUBk11nUOOllJlryl6F8ZcM8CbSjNeex5gJi0m5BDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MW4PR19MB6649.namprd19.prod.outlook.com (2603:10b6:303:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 16:20:44 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::a98f:3e77:243b:d1b9]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::a98f:3e77:243b:d1b9%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 16:20:44 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi
 Grimberg <sagi@grimberg.me>
CC: "Engel, Amit" <Amit.Engel@Dell.com>
Subject: parse nvme connect Linux error codes properly
Thread-Topic: parse nvme connect Linux error codes properly
Thread-Index: AdilwqEduD2z73XkS3+NnDqA0RR8Bw==
Date: Mon, 1 Aug 2022 16:20:44 +0000
Message-ID:  <CO1PR19MB488539073167D496A9A7D991EE9A9@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-08-01T16:19:27Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=22dea1ef-8cde-4c5e-af85-1010ec9c0ff8;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bfba010-96be-4948-5634-08da73d9c8ff
x-ms-traffictypediagnostic: MW4PR19MB6649:EE_
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  oaSbKVg98FtEetFHhQBh+sO00z6XxqhAW4TNkJhidiWlIAoxzhsesAVVLKVo5uGMR7S7bg3yaw6mmbQastVZ1VUNl5pdcSOiKKR/9qtU4SihO9vzdq50Gts4Ti3mq1Pi2OHWCLqcWG6pJ2lIlvZQ2nXCfHS4eT3R6DPV3YmU8RiOw0WmyOhjCCI/QNBFjyrs1lsjMTVOPSFKCdcdqsMxzcf2AEwS5fXQj+5NigtOjzMU6yVVap6SejeutmIGgRrG1RPI7rt4mbNIq8gqAdclTgeN0DfRzsHeDt89JKw8TNgWcpGwccufEeT8hHw99QL5/5jAfOnZlihGC7fOxdE45fXN31inrJ3xkcNPuRlknj0FnaJHed3IV/+Nos8zphWmlZ+i4I0fSTS/M7tESY4h49o4l0tJTdLMRnUBpRReX5VO8j6whbQY69hyVyiFEHTRhMQjYFqJFbaNIyHuHOqdmwJ3FzqOdVpK/+OTKevklP9vdcJ320uGhCmYOp6x2sBVFbImIyxDrA5H7nkZFaBPuphMZwio0zyBwi1xyR0/sdvEBD5iD4DcQ2pJHo7IEzcKGs57mprG7E3vVrMfG0NZ8AhU3FAwQVLMtRCVvs/rgpZ0A0PRh8Z6i6YiMs03WuzSpZlXjq3OINUsor8werjmv3F44mvEMJ11IMKKqBQwaNZkUJ8QXjalRwP+QAtkY8GRvHwTM1kz4kali0a5Kndi3zs4S3B4s1pMvTjNqSJSKF3K244ZDZ4mMniyUwWds1/GHofeGYIcQlokzlhRzA/hypNKujhMWR1IEdVa7K7b5nuyZdA5yIC5CyKNHl47rBqy
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(66476007)(66446008)(55016003)(71200400001)(76116006)(478600001)(4326008)(52536014)(66946007)(83380400001)(8936002)(8676002)(4744005)(64756008)(786003)(316002)(110136005)(2906002)(5660300002)(33656002)(107886003)(41300700001)(66556008)(38070700005)(122000001)(186003)(7696005)(38100700002)(26005)(86362001)(82960400001)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?raOR4K4bukRGC739v9syHjnyCWjnjUKj1/tcHrXuZhLRljCC4SOeEjOm+aKn?=
 =?us-ascii?Q?Jx5bIFF7JJkmf9aI2rGd4Qt3L51Yr97l61TUaDlMsmeZzlZuNQLI/Gd0S8jJ?=
 =?us-ascii?Q?Dtkjbr8+GJeBeqrQ2KbeRyXa6TqqgwNbpavcIHpeX8rjRKQQ9jlvCMY+nqjZ?=
 =?us-ascii?Q?YV69WGKgf5kdY3SwoCGKy/hsgn1tFABFAyFKMWnyAK+bWubZv+6vm71fLF1N?=
 =?us-ascii?Q?NfaavFiz8B7UsDJ0D7+0iF9SpZB7b8+AU5VAR+BD1tAyhZOLp45BS/2ut/xd?=
 =?us-ascii?Q?cz69/YZrMoCrgMq5/8kkOJo9UOhcMBG7IBZAIbPoq0ZSzXRN44YkXloBWLLD?=
 =?us-ascii?Q?vv9ywJHBb/DiTjTDzVvBx3/TtEkulpAwmSYcOfg0b0sjL275FXSk9T3yIexH?=
 =?us-ascii?Q?Qgl8QjY/myDniZiBuPy9Pn6KytJKQBHXEdx/sShPQZyPk5W0aH98LC+t/uH5?=
 =?us-ascii?Q?LUDzO3RXuRdH71iYtAFaZGImps5KvK8H6KhBKjBLgQaC5a30y0lvO2yvbCLf?=
 =?us-ascii?Q?sPLYB5pNHbiw1MTIEqaiVv1Kp5QSDV78OzpzPQ/UDwJ/P22SEkVtXa3rQx6B?=
 =?us-ascii?Q?qjuErF6nv+vQ9K7/af3zvUfckLYCxQosddkYIiIBcQbOZtMpyoyS23EdK1aJ?=
 =?us-ascii?Q?8w3qB1GRhtd4HlDvLdWE4ACkZ0zoLdPwKd3zLZHO8p+rLBOHv3M1Ogf0HmAa?=
 =?us-ascii?Q?OVZCz9WIsxm4CwScSW8BR/uq24Lnr4WNn5u1ljpBL57QN2QnhT3gPWLnQ3kt?=
 =?us-ascii?Q?y9/bMbb+vk6K/NyRs8qWAPWRs89CZnxTRfLwljEui43F+/bAlZ1RwITsanMm?=
 =?us-ascii?Q?N55ViXDfSjz7kRhad8odNn7ypCQLYbn6eND41zYGoDcQ8/qYBlCGo6zKd4zx?=
 =?us-ascii?Q?13YHBold67Hr0LCNeDT5SY+VxQwjwkN9koGe2m8K6yHELC53rXQBQG3H9HWu?=
 =?us-ascii?Q?dKa63oKNSejSVT14NcOWKH40L34Gptt2+xOtVs2soV+oqZIhbuQWp7MrfsG0?=
 =?us-ascii?Q?u0F5nRl1WCbD78LmlNYj8YRbfr8Mu/TzheogdJwBVPG85OPw6+BfN7/+Ra3I?=
 =?us-ascii?Q?T0LyhyowQOs0+e8dEMg6koBSE5hr6eiXD7f6S3JW20uWFBhu8vwxm7axrdse?=
 =?us-ascii?Q?jwTZfGw10pmewXOV1G7VjA4sL5ymWfbQx6JoIk1TH3KQFp0HvBQUXU/ifoPG?=
 =?us-ascii?Q?c+4JuYATMW/0/2wQSV9D85TA2KTw9rjeqLuwRAt+nM4eqRVwMYw+fhDFlaqP?=
 =?us-ascii?Q?iyjvIM8LraQjlrBHGrZzFylMYqbtHw8Qs/mNR6B6fhIj7t/XFAmWZo7sCz7b?=
 =?us-ascii?Q?BbO1VxK9Hu5c6DHxLFfoYfUB6mR2qANFFhCPZPR0L+hz1VMwIGZWs7cb+9h/?=
 =?us-ascii?Q?4+UVt0uJslkDu+D/42dKE0/3L71NzzFNbyXPs/9dQRhIhTkqDf633rpq4j7i?=
 =?us-ascii?Q?PMi2+7lQf+4eZHXQ763lTHJ4N0Rw/Rr73DrSPGNkSe67NADNLdcqFISi82M4?=
 =?us-ascii?Q?XbyxD1L7GLk9EfU27ezEyGlvko7ZJlwPx/feXC5mcepRMeJVem3fcFYlU7Q4?=
 =?us-ascii?Q?ghoit8Zu3DXI09gTqtE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfba010-96be-4948-5634-08da73d9c8ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 16:20:44.3308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WouwEcEb0sLMvH1JrL86KSCdvIa+klQPnUQDen4zUBM3k53+AqCp15jt+JUTAykMzxaB0ldBD4I6y0UouGPkpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6649
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_07,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=874 adultscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010083
X-Proofpoint-ORIG-GUID: 1-7K_IakbqKqy5DZ6JT4dplfVuPMrsTe
X-Proofpoint-GUID: 1-7K_IakbqKqy5DZ6JT4dplfVuPMrsTe
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=985 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_092054_979099_0497B28C 
X-CRM114-Status: GOOD (  13.82  )
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

Hello,

we have encountered a wrong nvme/host/fabrics.c behavior as part of connect=
() failure.

Current nvmf_log_connect_error() code is assuming that 'int errval' is an u=
nsigned nvme error, so it clears bit DNR=3D0x4000
The code should check if the error is negative (Linux error code) first.
If so, need to have a suitable log and return.

I can provide a simple fix for your review if you have no comments to the a=
bove analysis=20

Thanks,
Amit Engel

