Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28398C61DA4
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 16:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YphgT79BldApbeFZu8j9NPCPGP73MCyAogQvQzVjEjo=; b=yYuXJFOqlAhoQi3JIuxv6vhpAX
	HwIdDLK0fDSkvJ44I/2KjegfnzsRk7enj4TrorRR6bzL74T9mE4Gqf5xEvITVulUoizQdWRoaGmU4
	JhkGNhzgO5Ypg8C3FWQU16d1NTsSDrg3TUf6A8tq3xH0Bv5JuMXC+AwSApX8iR9G1vnJk2yxVl0I4
	Sls58ewfxPNJXOASneiW7abMWwGFnEL9fNRjdE5Z3AvZryW15byStr6gzcpSamvjnSW4U7DbO4uEW
	GnypmjDMJR/mrO951WbKw6bqcpjylfmRxMwB+MiGdLTzaLykix4PW2JzA+q1GAfQhdzU6IROrQuay
	zlNwAVJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNyv6-002uv5-TG; Fri, 03 Feb 2023 16:28:12 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNyv1-002urc-VI
	for linux-nvme@lists.infradead.org; Fri, 03 Feb 2023 16:28:10 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313BXsqC028819;
	Fri, 3 Feb 2023 11:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=YphgT79BldApbeFZu8j9NPCPGP73MCyAogQvQzVjEjo=;
 b=eyDLW1L2V8bvzeV+kV7yJey6hMSruo8/DBmIZEGn+32IVqxJwflbbhVcI52zYoU2TtDy
 drP5LwoclNHx4qUUYJgaHQLrJIA+fsD9ep24R2o+QkCJkWc9EOhMdw8Rlgo4o0pxR9HK
 nrI8Trs4NPX6ZeWAMCA4eiqs571AY/+k16XD1HIJWg/c76SzgA5DXTpk84pDtLttJh9L
 KIq1hZje2RIUYFqf7yZH7EZ5bq3ubUV6/izBDQPteTq5BpANvBhqVqW4/RE8EfGXjkR6
 R3TwigUaLiGnEToVrDPS5ORsWyyQgjK01jjMQFvXyS5vzKMlQMRH7yZ6SBaQ29NyBgRm Wg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3nfmv6mn94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Feb 2023 11:27:29 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313G1iHo037861;
	Fri, 3 Feb 2023 11:27:29 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3nh338jhh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Feb 2023 11:27:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxiXTVULw3T4WMI0CwOd4+tMzqwjy3NSDVdxOT0wSC/i1vIVzq8EhF2AarCvbV22LdNGWbEI6dr1dV3/w0C4omKpzGp5mtcJMfkIVnK+AZ90PyHOA2ElS5/k2p0fGP2eWF9SSxBdXCVq0Ps2yykN4o/YPoDJCOvZogE5VBI4nX0Btk2spRMuV98HzLeaoFQdWturFjLlPjZQaNrkTj/hCjdMpo/OaCwdNnQzhIhaYTY4EXSmIuIMRDwy3BFrCICOPXjxwlBhIXS34r+3qPppf/xn06zDfUZMPnMevrB1z2U+aJYgi81LEvolKtA9uNI0nXcxTuIF0tsVFKennp3UsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YphgT79BldApbeFZu8j9NPCPGP73MCyAogQvQzVjEjo=;
 b=hj/+HR8fyyzSXz91P+p6AC4qGQV2Toji6K2g7Vxk8YOp8msy6ogtxNbBrD0VRmUaDkFtwWNVUHHP6w58uOxEEpJHOOfKq9S/5igvt41bGDcd+kvQ3vNjfHExgo9KycXKGOzGmNtvrXGNOgc81dnMxcYbjyp7056EefUtyfU2nVJ6PeroRoi54uuDcg14bqo7Lq41Jz2U7Se5JN8cnjuDm9xIDyAxJ2kZdnqSmzmH6F3MAZ5MDCejydhDm4mp3dC0Lq0o7aVC5dfoqNoJJB5LG8jLQdGuPIbRRWRBCktR/W2d1I7/07kC+qNuP8AJtM1grGvzV1iTlxES1N70DAjb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by SN7PR19MB4750.namprd19.prod.outlook.com (2603:10b6:806:f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 16:27:26 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2f42:cd95:5173:5c02]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2f42:cd95:5173:5c02%4]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 16:27:25 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Daniel Wagner <dwagner@suse.de>, John Meneghini <jmeneghi@redhat.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith
 Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg
	<sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        "Rose, Charles"
	<Charles.Rose@dell.com>,
        Martin Wilck <mwilck@suse.com>
Subject: RE: Timberland nvme-cli/libnvme upstream merge - dbus dependency.
Thread-Topic: Timberland nvme-cli/libnvme upstream merge - dbus dependency.
Thread-Index: AQHZN+Y5f8quL79Qt02qir10NmOn5669Z4uAgAAA7IA=
Date: Fri, 3 Feb 2023 16:27:25 +0000
Message-ID:  <SJ0PR19MB4544DB4A38A27B4D9FBA9E91F2D79@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <50a55e73-ae2c-8704-65a0-d47b8bd04192@redhat.com>
 <DM5PR19MB4679B0881914F4022FA5A02798D69@DM5PR19MB4679.namprd19.prod.outlook.com>
 <5dc13dcd-b67a-60b0-0bf1-b03878e0d82b@redhat.com>
 <bcfaa7e1-787f-f7cd-e7e2-5b5f591253e3@redhat.com>
 <10211ed275a0dd73f88d18f111bd4621f356ab0b.camel@suse.com>
 <b28e99b4-0459-e592-140b-61c427073abd@redhat.com>
 <f3f3ed82-f00d-ab81-6de8-d4da01f74296@redhat.com>
 <20230203162213.yyzz5oq2udjzj63q@carbon.lan>
In-Reply-To: <20230203162213.yyzz5oq2udjzj63q@carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2023-02-03T16:27:24Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=9e1967c8-e2d4-4467-a54f-2939232b1622;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4544:EE_|SN7PR19MB4750:EE_
x-ms-office365-filtering-correlation-id: 5e031131-d95f-4fdd-04db-08db06038929
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  qB1FMjTVZlm+uKsG9vr1YNTLHEF5uCyHM22WfepS7MCmoO7J7My+CdogXhUdr0uVRYEMcHgEO7L+BMe294V7AbXgQpE4FAONnDx8wzdWJX4SicKCauw36t447C+gz6THJlaIBCLxru72APo3j+cI5e4YiB0Ft7gokygZsHb1GyJKs1ClDEHXeExOzW84QUHHygarZUC83vhQ6SwzXyNoA668WpfENJr7XD+m56Fpg80M720wy5jAoAeD3Rn88W37OcZ4hZ8OWQBi8OyTCnldtwQ7wmkUXWeUk0yYfZGnXnSvyD81aZ2/aG2hSccveaydYMjLH7L8AsmcR6yVrXlYScIWZaRToTOXOrlp5OhNwtbKUaCXgJLCUht6tLHQXxJM0ZnoI5DhN+wKh92VMbpY942mtVvu4OUzPEi55YrDsbEPdCDbYXtN0eXHMLYRxMt50FhzWRpNobKQNlGDHi7TZnk6nB4omH6Hfqebwa3AFJ5czbQkk0f40fK6K9JKNdxSq0l4tEF7QWOCUbJDRpHtltxdjLmT10JfSYxR4gIQLfPOXOYPtATFtAdDLynThkFUtFE/IX9EeqxUQ2B/MslxzLaRdGbQJmuJrCiEZGfY1S0oAv+zjd75mkW2GigSTK/WYfbDlFHDMe2SJSNQ0L7jMjuzN7GR5+jQhjKpcwKRoJ+VQZQWTy7GDzXlNddHdwDaQpiq24l5JjW5IWOtRjWMxQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4544.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199018)(38070700005)(33656002)(86362001)(82960400001)(38100700002)(122000001)(66476007)(316002)(4326008)(41300700001)(8936002)(66446008)(64756008)(66556008)(5660300002)(110136005)(76116006)(66946007)(54906003)(52536014)(8676002)(786003)(55016003)(2906002)(83380400001)(478600001)(186003)(71200400001)(7696005)(26005)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?pH5SZn1CkIo7w7SBhCpQLuag6Q8MI8woUyxpZCC8AN5feRQo7jKZbPRs3lHx?=
 =?us-ascii?Q?b6UPxm3VK8Cx0mipaDZwey4JrG1fUL9wz11x69vpGCP0ZK6YPhtOjNBLSotx?=
 =?us-ascii?Q?5VwlxjjpGKKzcBPSeM8GXQgv2gJjKp7P/adfozVtkG6CEgaj9javKlt10pkK?=
 =?us-ascii?Q?wcm1Yh3+0u3SDZhvHwdlhvFVcxEkz0zOWu6NIBrsLPbDO4TJjLC+vwXuxdOW?=
 =?us-ascii?Q?lU+tJyMcjQZnyZvz3hJkkt0jBQS6iemIez7pRjUlRlUh7tb+Pncasu/vtwsY?=
 =?us-ascii?Q?kBfLgVMMHMgKuWeh2RkWb+kweN0kr+HlcyIXT4+pNWbVfnfG+36aIgr4iMZZ?=
 =?us-ascii?Q?a8a/xVw02CgR/YirHs36YCdaJ0JNwt+YU+PfpErQ4ZOEU30yNTuxp5+nby35?=
 =?us-ascii?Q?AqC1+7xanionKTp1lQgxSXlIQQ8kQ3S58kpRL0WVmaHGtdifPW7bBPY2IML2?=
 =?us-ascii?Q?o9wGfoDbFDy2KO2TOX+b3uFwEC7zVJRolBJuOhhBtyCjTd5ffkl2LeDbRzJX?=
 =?us-ascii?Q?Qo05ip5xq6RA24HZHUBggUZc13LobtUDlDlrJ7DLotPlK2YEmwbWO+CAhjW1?=
 =?us-ascii?Q?H4yTEGFhGmPh4+qir2Ua75imBDKpub0Wg3keH2TQ+HSaRsOi2jA5W547LPBx?=
 =?us-ascii?Q?3+qyo5CazwWoFhivWeTYUYY41XQsKEAof+k9rsgA1GJcB2bj4SCJFWVSVPz3?=
 =?us-ascii?Q?V5j49pvm83XJ+lOq8/W+WamEWGwbQaXfay7uvVk34BAov+uv6fKBLS/mPb5r?=
 =?us-ascii?Q?igupAJUa78jEkZcYAGL+SJanczjg6UAODzqpba/dCGs9k23w8hrfUCkb5QUh?=
 =?us-ascii?Q?eZZD7IFqN74o4dDedVsC4zzsvaPqJ+rYjrXA7ehVedhUBjRWyNB0/A61BUgk?=
 =?us-ascii?Q?YefMMXcqTomVXcbwcvGYvlFGmiWWPoUlaTHFebsPdqrUkzgLafG8mnFYtUdj?=
 =?us-ascii?Q?Own7afCZ/m4AoXr8rQb9KlaSMtq/F36CHYpySTruntVq8fLlrvOrVeO5BprS?=
 =?us-ascii?Q?3u/cC9vFz5MTWuny7PdM0w5R/f9vE4gs7wupy/waHBbqicJpa6FFt39hnWFR?=
 =?us-ascii?Q?/+JWrqo0W2Yiad/HmgqF3hCpl5vvdvuy72UYcfO7SztCyQ5LWgMq2euvgQ8E?=
 =?us-ascii?Q?osmjfEln+XU0YSyDuupnfJutU73JdFeYdsixqSeBmU++8NvkX/m6QSPvfC08?=
 =?us-ascii?Q?Vi2mhbIniVBJDvxCbO2qc10sPWTkTQvbC1tMaJftlbtExQu4Xof5jmQfiZkO?=
 =?us-ascii?Q?AY2XzgWCi9rkc7qe8YFWpqDrvlpXJjC6kCM4psEIZtOXs20/w1gJCTbkAtKv?=
 =?us-ascii?Q?ITOvbjc+s415PTbDfZGBrIuS0c2OnSwaIZwyA7AkLnuzuBCwKBwoRckXpQQd?=
 =?us-ascii?Q?+KHSSs8WRqEIkb8wP6MUjuwRFBx7Qd2LfKjj8aSGA6SMPSDyBlk+z7B2SCcS?=
 =?us-ascii?Q?tB4MnqS1cjSDlRQAftNz0gpTsBU0n4pvA9mlPz1TE+5SRdrIY9msgPfPlyZA?=
 =?us-ascii?Q?uVZtI1AIkz/VPwmTpzHe+bSc33WNuc4eZY17h4fNub+8VLli0zAilj4wpmyM?=
 =?us-ascii?Q?Tl7HUrpKY/i4ihN+eiBa/CT4NfZN/NzwVA090HGZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e031131-d95f-4fdd-04db-08db06038929
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 16:27:25.8736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZC8F5IFNkw/1fFt+dFf1aZM0d8jyEVpak6NZf7f2ilE4yoSwgZn3sekXiPvz2GSARJJSbWTpBqo9PY5v5NTIZzFnEmJGbaSXGN/db7usqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB4750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_15,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 impostorscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030151
X-Proofpoint-ORIG-GUID: rVop0FmRZpnrZOEXZKfQY3PcZXYwDfIr
X-Proofpoint-GUID: rVop0FmRZpnrZOEXZKfQY3PcZXYwDfIr
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302030151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_082808_251911_530AA918 
X-CRM114-Status: GOOD (  24.81  )
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

> On Fri, Feb 03, 2023 at 10:43:04AM -0500, John Meneghini wrote:
> > I have a question for the upstream nvme maintainers.
> >
> > Why does libnvme, as v1.3, now have a dependency on dbus?
>=20
> libnvme-mi uses a D-Bus service for discovering devices. Initially libnvm=
e-mi
> used libsystemd as D-Bus library. libsystemd is only available as shared =
library,
> thus we can't build the library statically (yes, some people want to do t=
his). We
> switch the implementation to use libdbus. I made usre that it can be cons=
umed
> as suprojects. New library, old optional dependency.
>=20
> > I thought the goal was to keep the nvme management plane as streamline
> > and daemon free as possible.
>=20
> Yes and it is optional. The new feature is that you can compile it as sta=
tic
> dependency and this is what you currently see.
>=20
> The current nvme-cli meson.build configuration for libnvme is always pull=
ing
> the fallback. A workaround is to build libnvme as separate step as you wo=
uld
> do when packaging.
>=20
> > We already have a dependency on the udev daemon.
>=20
> Not on code level (no library). I don't see how we can avoid this and I d=
on't
> understand why this is now a problem.
>=20
> Concerning meson version: We always used features from 0.50.0 hence the
> min version of 0.47.0 was wrong. We just updated this.
>=20
> Daniel

In meson_options.txt we find the build option libdbus. Maybe the dependency=
 can be disabled simply as follows:

$ meson .build -Dlibdbus=3Ddisabled
$ make

Martin

Internal Use - Confidential

