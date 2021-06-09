Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62C1C48BDF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 07:49:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B1F6128A
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 07:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B1F6128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tOyBFdXxyCabeAipPaH4xEOX7IhFpFSLHkIwbAg1ras=; b=mAiJCxIs1cS7W1
	6vhGso0S2e0Y3gbl+qdzhJfxTqVHMGQ/BIv/o4YMB1F4kXahRQKJPXUmntVvVFMe3qNZnWJi1wUs8
	Hy3t/JsUSGrECyQQ2dIB+a7YUANpmrjk/1BxiZpq5bORnBNSJbviOGT3B0xVcWp+GbeTcpgx5gx7K
	s8PDY/0lbGw9GIBkxpQEbdYfggyIAS+SK6f5KBahc0oeSUhMf4o5MeSfumQ7jx9zBOHNVgosR85yR
	qr4i5A2X5BTEycaA7QCamPfgKnP93+c8neKeVqDE2uX3EaW1RxC3AKgnX6D69PKWby9dj3PlYefC5
	+ZM2QyRDh0ZYxhrlqxVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqsxZ-00CAjc-L4; Wed, 09 Jun 2021 07:49:09 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqsxW-00CAfK-LN
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 07:49:08 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1597m92e022911; Wed, 9 Jun 2021 03:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ZqBtvXHBhqfUZEtC3/dQTAhQsjGhoCrtImNcFmMSjZU=;
 b=MyeYlw/zIVFNRJ63BILYmF9/tz03KsJ6jGJqaJ8Kd33RGyGnU945bNiOJeqQgl/JrCxs
 5BOFDHg8Mk6chR4KFkEg8BzZiQ0NleFGPC5DjHMddCwS5VUFJn59cL8x5OadxCGe8WMT
 X4t4/lZAiC3CBQuPpjcayFFOfCZTx2Qu5l3fj7kWiIGgNoklgEFS1qXky9ZyU4ihxvcF
 pwWFhZAMnL+GDEpWzw7ujik5sOtgxOx8RoejRyimNxcvkOAXie2gi6i5MEFM7D0aq1gh
 MJMdDfUDc5K6MVN5JQ3MCAKvsYbAuvsXtAGJRBOge+3SPhTOwuqXKLGywU9W7cJxVgHt 7g== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 392s2pg47c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jun 2021 03:49:02 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1597dtvV113086; Wed, 9 Jun 2021 03:49:01 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
 by mx0b-00154901.pphosted.com with ESMTP id 392gu8ptua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Jun 2021 03:49:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYCAlC7AhAEa8RtKQ1inSp/nsNptR8l2Jo1mdWQedwU2QhveIUUEu3Rh+vkIUVyTuMQpdVzM29FUeDSyKt9rS69vdazBOvJSCWwifoAG6B/BgMQJ97bSJV1GQj9VANclxb2jsI6BtN4DJMztwwYO00qsSMvHbQNq3qoZOrsGYMrTaAKTAvlpkm+Wo8HSNaGyyFft9G4aC6RS+cjdAhcLS3qiOe+wJIsIYHL1A8nmeegda3rYmnCc7sZpS/35UQVt5oWJ8cGD0TibmMCd/RBzKPjzDwbrtCApw5hxrrIUbHlPrgICbwLfpLXPoWIuUXQTVOAcqkTRS3B4i3E685YyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqBtvXHBhqfUZEtC3/dQTAhQsjGhoCrtImNcFmMSjZU=;
 b=mOkRPDbLmgWa1uXsOUXWIk2x0jooDy4YtQx6wODMbMoQIwJgon8DNpBc+3RL+JGJqn+nqwKy5HwGOACery/3LH0Zgyq8X/ReT0CnXPZclNsZIv+LWsEIz21tVitkwtjeIGLfn/sY+um5jJ8ytHSRBhrEgjjR49PvEtYN/v8B2pDX/3VnuH1Nxo2qs/GwQe6cRrEKZ2McW9WLA1Bn9dK8KU9EebF5uXmvIJ50kcbUfpnK0Mt6es1jCRp+zzNbgvlvO2ru+AgTpEvUnCkH0Z5aBFdRO0QIpMp63elFy1SYRDK8t4x2zJl34fLG/t1wcHsKxHOWPpzlvy/97KdkUqezew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MWHPR19MB1517.namprd19.prod.outlook.com (2603:10b6:320:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 07:49:00 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::908a:1c5:2beb:42c1]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::908a:1c5:2beb:42c1%7]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 07:49:00 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "Anner, Ran" <Ran.Anner@dell.com>, "Grupi, Elad" <Elad.Grupi@dell.com>
Subject: RE: nvme_tcp BUG: unable to handle kernel NULL pointer dereference at
 0000000000000230
Thread-Topic: nvme_tcp BUG: unable to handle kernel NULL pointer dereference
 at 0000000000000230
Thread-Index: AddXDsk20ALf75QRScyvzkSG+0qIDgAm6yOgAUVC6IAAEPeXkA==
Date: Wed, 9 Jun 2021 07:48:59 +0000
Message-ID: <CO1PR19MB48850B44ED23C179A4E4F541EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <CO1PR19MB48850A829FEF374C7FC156EFEE3E9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <CO1PR19MB4885314DCBFEB376C7305C98EE3D9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <e40414a9-41ef-f82c-7d1c-2583d8251c26@grimberg.me>
In-Reply-To: <e40414a9-41ef-f82c-7d1c-2583d8251c26@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-06-09T07:48:54.4303984Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=aa916f87-4442-495c-9bc7-aafec05390f7;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [188.120.129.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c697b9f-f1cc-4486-cc65-08d92b1b0b1a
x-ms-traffictypediagnostic: MWHPR19MB1517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR19MB1517FC0ED16262BB5C5927F8EE369@MWHPR19MB1517.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 56tu9byXn1U13Y+4lg7qVBAQhhDl2NKUBFffJ2WF8Z6ASBTvsDKoDLzHQWWQb+ptG89//w1N8G4s3sRmFCnjSvk6lRlRYTwJrjxj77nmuEJqcFowgCASCfhDVtJhCSGPEJw7mGOkmcdjEiioKRvODMqZ+q5wT8O/yMBPftfSVHDy2f7uEQ/26ay4en1qGyguiQMVq8k9WQ1QCsqHovHMm0DEK+NrxM42C07u6nyVVxhKQtguJwCneeffyARF+/I6WY2FEfnVxmPYRycpdaAhTMQu6vcANwCRgBr6gLmMKDMrMKfkLSDZj4UghXxBRek/YlbeO/GFGL/2yx4XHIi4NytxNvrfIM3QDOwr64esq7l0ArU8bwrvzCjGn7NvAtuPqPtS0wgrHih5rU3l4xygs9cxBTyjQe+/nGfTRhW5h/Q6Fk3KScSiNnyYIf/13f3j6DIZ5VrZZFHJFS5s4elgQR4EBcn1g6zvDJdPWnWdqZkWUtJLyM9MTRDLBtSz/Ak36wCGEFzhcbC7eyWQqWAiu2S65A9aBNKQ24ZAqsrZY7UhQ3sEt0+PIb2mZWMhEqa2GoPMPB4UeXCnysZtnBy85b7Quj25TPcCiJkAkWYRulY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR19MB4885.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(26005)(186003)(6506007)(71200400001)(66476007)(66446008)(53546011)(122000001)(9686003)(7696005)(66556008)(76116006)(64756008)(8676002)(55016002)(33656002)(52536014)(107886003)(4326008)(110136005)(5660300002)(2906002)(786003)(316002)(38100700002)(478600001)(54906003)(8936002)(86362001)(83380400001)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jID4RjmC3DtE9SKu5MnW3vcL9ebFBQKAW1bRxmf3RhaRmprUEKeQThtzkube?=
 =?us-ascii?Q?iw/iSJS/fH4/t9ty6TOWMpoKKjed0cdH8jsimE+WsSVBvErCKGBjsXQTH+E7?=
 =?us-ascii?Q?GBXeo5ovdpbiN7iCuXz1aU9L1vI72Mg5b8IyGzx18xTx9LFquuSmDHhn3AsO?=
 =?us-ascii?Q?LPkcTG2qExgMMq4woxY+rGfBteT/HABfuzALpoUJnzogk0yKLa3YdJoaGMQ5?=
 =?us-ascii?Q?+bLwxwgKH0ave76Ssh8aQ6aqvY0LYFs9u/Jnqvcet4goRubc/UW4dWquS6Lt?=
 =?us-ascii?Q?+jdIgMPVdf59ozOh7hgq7Xx2+UHSexgCUrVGlU6Pz/03VBeFBqddklR2iPdk?=
 =?us-ascii?Q?VCWZ06bc5LZdwviFHFU6tQSiWkzeMCoZRbCq+phlLFEE7cXzXEcWsSBxY+UC?=
 =?us-ascii?Q?mvkxk1cvlhxl5ZHwArVAj6r3/6NEaMJfm7WL+n7soltZd2rhMoePRteFUNzu?=
 =?us-ascii?Q?d7FKrzzleB3NWgqkBbt/lOT2U3PydgYiIZBxYFnptR+fLKujByfnzXFlXd0U?=
 =?us-ascii?Q?tGVj/oxsjrUUUCJ97CIVJ1beTGSAMB6cp/ZNA9nQTTXtrTQeaWfMKHvR4bqX?=
 =?us-ascii?Q?mITH2jUjTxr5HaoYmbfbXs8QlkNC9h5zNhv0jF44sX0Zpjo2N5NcI/ZHI6PU?=
 =?us-ascii?Q?HHoqJwOgwwNQpiPySkkmytZ7BMCgBSv2QsbO/DJYUw2AsIXPtHynDU/JEMqT?=
 =?us-ascii?Q?K/uyt2CgffU0GDd8PhE8tj0PmPlf/WXz9AauLO6QRlneloc1hwCust4oyH78?=
 =?us-ascii?Q?lZBTvz5xFBfndj4W7F5x0Fa4jBVlWa5Ce2ONCbKuHPXTgzRZ9Y8RTuQODTBs?=
 =?us-ascii?Q?HeQVcvNse9xk/+6DPJ8c12uOprQnRd+gkH2DJWPJi0JtLVGgS73Hh7Zmg6gd?=
 =?us-ascii?Q?e3D+tgePbeYaC3d97UEoMJOU6INEYYF8wTO1vqaGaJVKPwGyBq+VCZKY7hqZ?=
 =?us-ascii?Q?GgmAjK7Pwjz7aJ9dOfYBTs4RjD7o9GuEiAEEkBUn2uWugYHy7DhJxROk4TjK?=
 =?us-ascii?Q?Na8ti3LzWUTTw3SG0nVoFRtyx2Kc5gikAT3CAtS1zyDwRH4IyBFVALXK/cnt?=
 =?us-ascii?Q?dLCUTXhsNlr1bVulKqw2kBcgAjHXRPyMG6uJpO944OslfJ9/t3B7B9WIV5p6?=
 =?us-ascii?Q?Pdmiqr9dk84BM727E5+Pwn7zz/b7IFpIAvOAn8ZI36xhOSLp35VZvqmmBvfd?=
 =?us-ascii?Q?Lx6zPsgBKFLqrR0J8Z3gl8Z57IcVOxpNW5/BbiuFrGT3oK6Z2/aWIx07n4Y7?=
 =?us-ascii?Q?0PhVjvDp8SnPTwXY3FNJMrznmalVHES/Mo6CoMjFuoUQFOY5SwTUIH01OTbE?=
 =?us-ascii?Q?Y69sIAUypXIDUYwYH6Ho6GvG?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c697b9f-f1cc-4486-cc65-08d92b1b0b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 07:48:59.8728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbKMDeEp1MK2R1JfQDEUI3ReL4V4RXfds+3kB9PswJpncD147qWVRJsqh2tlY9TERcf3gjZIwEjHd8w9mEEpQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB1517
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-09_04:2021-06-04,
 2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090031
X-Proofpoint-ORIG-GUID: CXulavovVAEMug9C4AbIl-zfaPyoe0sW
X-Proofpoint-GUID: CXulavovVAEMug9C4AbIl-zfaPyoe0sW
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_004906_775465_85824696 
X-CRM114-Status: GOOD (  20.15  )
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

Hi Sagi,

Indeed RHEL8.3 does not have the mutex protection on nvme_tcp_stop_queue
However, in our case, based on the below back trace
We don't get to __nvme_tcp_stop_queue from nvme_tcp_stop_queue
We get to it from:
nvme_tcp_reconnect_ctrl_work --> nvme_tcp_setup_ctrl --> nvme_tcp_start_queue  --> __nvme_tcp_stop_queue

so I'm not sure how this mutex protection will help in this case

crash> bt -l
PID: 193053  TASK: ffff9491bdad17c0  CPU: 7   COMMAND: "kworker/u193:9"
 #0 [ffffb2e9cfdbbb70] machine_kexec at ffffffffb245bf3e
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/kernel/machine_kexec_64.c: 389
 #1 [ffffb2e9cfdbbbc8] __crash_kexec at ffffffffb256072d
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/kernel/kexec_core.c: 956
 #2 [ffffb2e9cfdbbc90] crash_kexec at ffffffffb256160d
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./include/linux/compiler.h: 219
 #3 [ffffb2e9cfdbbca8] oops_end at ffffffffb2422d4d
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/kernel/dumpstack.c: 334
 #4 [ffffb2e9cfdbbcc8] no_context at ffffffffb246ba9e
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/mm/fault.c: 773
 #5 [ffffb2e9cfdbbd20] do_page_fault at ffffffffb246c5c2
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./arch/x86/include/asm/jump_label.h: 38
 #6 [ffffb2e9cfdbbd50] page_fault at ffffffffb2e0122e
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/entry/entry_64.S: 1183
    [exception RIP: _raw_write_lock_bh+23]
    RIP: ffffffffb2cd6cc7  RSP: ffffb2e9cfdbbe00  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff94b2aefb4000  RCX: 0000000000000003
    RDX: 00000000000000ff  RSI: 00000000fffffe01  RDI: 0000000000000230
    RBP: ffff94923f793f40   R8: ffff9492ff1ea7f8   R9: 0000000000000000
    R10: 0000000000000000  R11: ffff9492ff1e8c64  R12: ffff94b2b7210338
    R13: 0000000000000000  R14: ffff94b27f7a4100  R15: ffff94b2b72110a0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./arch/x86/include/asm/atomic.h: 194
 #7 [ffffb2e9cfdbbe00] __nvme_tcp_stop_queue at ffffffffc02dc0aa [nvme_tcp]
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/drivers/nvme/host/tcp.c: 1486
 #8 [ffffb2e9cfdbbe18] nvme_tcp_start_queue at ffffffffc02dcd18 [nvme_tcp]
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/drivers/nvme/host/tcp.c: 1525
 #9 [ffffb2e9cfdbbe38] nvme_tcp_setup_ctrl at ffffffffc02df258 [nvme_tcp]
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/drivers/nvme/host/tcp.c: 1814
#10 [ffffb2e9cfdbbe80] nvme_tcp_reconnect_ctrl_work at ffffffffc02df4bf [nvme_tcp]
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/drivers/nvme/host/tcp.c: 1962
#11 [ffffb2e9cfdbbe98] process_one_work at ffffffffb24d3477
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./arch/x86/include/asm/jump_label.h: 38
#12 [ffffb2e9cfdbbed8] worker_thread at ffffffffb24d3b40
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/./include/linux/compiler.h: 193
#13 [ffffb2e9cfdbbf10] kthread at ffffffffb24d9502
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/kernel/kthread.c: 280
#14 [ffffb2e9cfdbbf50] ret_from_fork at ffffffffb2e00255
    /usr/src/debug/kernel-4.18.0-240.el8/linux-4.18.0-240.el8.x86_64/arch/x86/entry/entry_64.S: 360

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Wednesday, June 9, 2021 2:39 AM
To: Engel, Amit; linux-nvme@lists.infradead.org
Cc: Anner, Ran; Grupi, Elad
Subject: Re: nvme_tcp BUG: unable to handle kernel NULL pointer dereference at 0000000000000230


[EXTERNAL EMAIL] 


> Hi Sagi,
> 
> A correction to the below analysis:
> It seems like sock->sk is NULL and not queue->sock
> 
> As part of _nvme_tcp_stop_queue
> kernel_sock_shutdown and nvme_tcp_restore_sock_calls are being called:
> kernel_sock_shutdown leads to nvme_tcp_state_change which will trigger err_work (nvme_tcp_error_recovery_work)
> 
> As part of nvme_tcp_error_recovery_work, nvme_tcp_free_queue is being called which releases the socket (sock_release)
> 
> In our case, based on the below bt:
> nvme_tcp_error_recovery_work is being triggered (and so sock_release) before nvme_tcp_restore_sock_calls , which end up with NULL dereference pointer at 'rwlock_t sk_callback_lock' ?
> 
> Can you please review and provide your inputs for this potential race ?

Seems that RH8.3 is missing the mutex protection on nvme_tcp_stop_queue.
I'm assuming it doesn't happen upstream?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
