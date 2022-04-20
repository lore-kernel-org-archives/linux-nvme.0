Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E5DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 22:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M1z+OxJXcDSX7p5Wb0GO7SoW3HBeBp6iMZUPIa9lIqc=; b=ZD6cj6ptvKG2nePoS/B/n9ktPq
	l1o3KawsodFxFcgosVYHNr1NduG5/G2otsKUMvirnOZdqzEM34tsxN4yFzdpzwGY/vklVb2EHpks5
	WCH5NppxdhUsBSa1kQN593Bc5OlB8rC2Krz7KQQT0VsawsDADFCzUpWWHz2Jz2SrvVfoUC4tjaMOw
	oANOUAt2Qfi1MIaTT76FkWpRGgTqqP2DcMNB2vJs4Hf/4NFWCJRBXzTRo98kMqvN/MPYp06SL7jJ5
	8RBbu2U9Z3AaRzJb9UvpSiQmExpSI8YdhTWbdlu1IVsoo5rCLsjXGKSeGB0djFpqTZraVnYrkgNzH
	fsbqDxAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhJ3N-00AlfN-Ld; Wed, 20 Apr 2022 22:44:05 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhJ3L-00Alek-0O
 for linux-nvme@lists.infradead.org; Wed, 20 Apr 2022 22:44:04 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KMWo3E009531; 
 Wed, 20 Apr 2022 22:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=M1z+OxJXcDSX7p5Wb0GO7SoW3HBeBp6iMZUPIa9lIqc=;
 b=DkIYybquAmxMccbBZLEK8mC5lIrTjmsIUrDHEewJSXbfKpZ/RgQRY8A7uSTtx9W633zv
 L2UXXE920VOAOnZLTDOnd7R11osTUAA3oLVeY33UzZ0QllGKIH6R/6YSQ7zexqJf5gU2
 SzLfnKwH1JtMDmJk38kPgoJRFavA1uV50SJ37v8AIbRhEpocxry9jrvaAKQnV0xqXtZR
 ms0+tO4QIqWE11/IBF6n4ZyWiqCTg6txySzvNnudKH+YW2MrQ9CSBJWBXBL37vfTdw7q
 FkI6q2WGUNW6oLdGoLwxHaEOi8lyo+dcXnL+51aq6/BMlKZh5sXjmBIa8ToNLi0zsfcn DQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2tgg8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Apr 2022 22:43:46 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 23KMQ4nh013075; Wed, 20 Apr 2022 22:43:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3ffm87wt11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Apr 2022 22:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOzJBAgTbN/wHkAtbma4Nc89UTqn8RrMwYjon3FfM/O/RuZCpyKefhcTCXKbGqav3v2GkxNq45+M0v5WEnZjReeM/Hixvtf09iHj+9AHVOA3xdpSt6x0RrVjXA+1nLy4lky3SjUqhUh/+3hylgVnR0GCio21YrwlwtV6YNdbV6qEOhmv4KzQok1SSZ6fZaQB54BJl5CcAo9PvmVuFQ5XA5YRO2C/bQhF6UZbSs2R1NccandfGec5US2HW/QaoZv3/sTZMNMw+rLAqCYeubR/AG/aJw3Eat9P7Sb38HhYkIcpJG8P6cGPymU4OF/FpZFVGaX0pbY+1Ic0Pl3M05sBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1z+OxJXcDSX7p5Wb0GO7SoW3HBeBp6iMZUPIa9lIqc=;
 b=n/bUx4N8B1R8oStfvlXPStcitE8EY3EnlGxdG2ciO9qPoo7d0LbSZDeHFACUcOCRc5oa9Aym0duvfHZmuks9aE3+058qUmSCVlwsTVSydgI5au/TUe8ngP6fBw5Fm8tWaB/OdZkvVSSXAOpqhzPhOsnIwtrRH3kUq7UjunbWpXyp5VLB0PmcoRbBq6LheJXI6HBi+yie4u0GVXFNFUsWYgt89/HyamPt4VDIoh1M6OoHsk8qyikZja2+aNUTRZhA8tCTsfXaZrtdbmCRylRYp8sd6Zr8Gl+o4/YkUb2aj7E6g0P9YzEX1ofDoKocmzSU9kzO7JL3LKstzdxHS2fj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1z+OxJXcDSX7p5Wb0GO7SoW3HBeBp6iMZUPIa9lIqc=;
 b=PCokSZoKUn3f7/LYnFA05BP+IyVyNHjQTbrkHs2JVX0pWFah+yqvCk12hMYkADDFQzD9PIXuOfYIpVBdFNfBsOTbCyYp6Tz4+X7Y9Wn7EwhZhYtr+CtVRDFmnTqq0PYdecXN/Yd0H/xsZzF7r9V4wa9RmPQwleW9C9+w8V3M9g4=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DM5PR1001MB2204.namprd10.prod.outlook.com (2603:10b6:4:2e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 22:43:41 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f%3]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 22:43:41 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
CC: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme: mark internal passthru request RQF_QUIET
Thread-Topic: [PATCH] nvme: mark internal passthru request RQF_QUIET
Thread-Index: AQHYVEKzJ4meZHluwk2y3ePAy9Z1Dqz5Z6MA
Date: Wed, 20 Apr 2022 22:43:41 +0000
Message-ID: <64AF6C29-7E0D-42CF-8794-2B2B5E19319C@oracle.com>
References: <20220419225351.29762-1-kch@nvidia.com>
In-Reply-To: <20220419225351.29762-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 692e5f21-f253-42ee-21e0-08da231f3818
x-ms-traffictypediagnostic: DM5PR1001MB2204:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB22048362186BD8A50C1BBC84F4F59@DM5PR1001MB2204.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: //hmTm5pj19UR+jm5smCrVubEZQM1URYJ+KTDKqlPxZm5gE1Q69QlW/DKIFrt0Bux6O5o28/o0mqyv4GU8mYCIuLbE5mvOOyZn1Qxe7WqMqWErTu8UfX2M/5L5LkmbXSkUEDE1ThYkq1p1/ah5L4DbVxoe3xJlPxLlJMYMa58zb7HW3euzBH4z2Gyf8W3l3BBaYtfq+F2CRtemNpbS0kB0/verqyeoGFp0WDGyZ2/gMPH1fZva9I6baraEPSuVM2rv1uMAmtUolfN0nP+YZZL4MphOhQPKdkVO/j7qMqbQcb9B+zXwGWr7pUQgwKckf8mTUOEX9bT0xWYILNLjau4d1iNfQkmtYuf6q+z8lMKTW+ahFfDH6j8kYbukLZx7YouL4EziMPiF3rVAYZs3jBSX3RDUY97TsMx27V14O3KNWGr4/SZO/3eDr1hykvLpUTGsDYoSCM81NuLFyQyinXObIcDAMysxZUdDPi9fVVx73nga++sPdcTAN3U7eFIjUivqBil2P32B7Fa1vvkuIOx93cyDdOYI6bkqELid9QJ5Q2epGi0XgrjSrMxnb9a2KFUPiBWzQTCCpzC/hibSEGSbOvl79bNAwoU8I5+Pvl3Quvj6lBXSwLlkrZR/Df6kAbW46LzYNJaJYW+Ic4FLXPBhxqc1DnANWbmil9mmRNgY0c6a5QooDBqB1vbMieNRafQo8Hoj+LYaaJ8vcw+pQe0XE2kGkqQc5tCoFHSTryqO8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(91956017)(6506007)(66446008)(2616005)(66476007)(66946007)(33656002)(4326008)(122000001)(2906002)(83380400001)(38070700005)(316002)(44832011)(38100700002)(53546011)(8676002)(76116006)(71200400001)(64756008)(6486002)(508600001)(36756003)(6512007)(54906003)(6916009)(5660300002)(66556008)(8936002)(86362001)(186003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/7UyCVehu+olEsavXvTGqrZmA7x2HS6ISjlXkf5PFraT7fD9Nn7gRBTRQK+M?=
 =?us-ascii?Q?qe7Q8ZAwoT3Wn1cx1HSj8Xuz/eyRjqI3uguTgLG5qz08ojzzP7hoU961ZZ3F?=
 =?us-ascii?Q?CCZx8XZv89pHDdBw3k0xXB4KspNZY4L40Rl1XcJ+l34WTpHkduaBHQhdgT4J?=
 =?us-ascii?Q?COvlt11Y4A4G2wERovfJMGhlszjgT2qjmrWMeOcsRQ+5l0LUEidKNaNKxlvQ?=
 =?us-ascii?Q?Dfpy1jhn54PQTejI+S9eO968xGtbzthFE18CcR9cVQ6PK0i/Y9dz+lHL88NT?=
 =?us-ascii?Q?Vhst2wCj7iKHUPM8BcohP1Xo23mUSHXyiimQ8E/yTnHBtdJRG3bMIDNOaK7N?=
 =?us-ascii?Q?YP71NWgeZty+PgjZpXW1jRkcKHLZetkTslKxrJkTq3fY4oGWMEQkSCgtkd20?=
 =?us-ascii?Q?5cb6EwlJMiddJWrSlRm5PvuPOUdpjGXTlvgQjRSIZDx/QSOjqtv2jnUa1/MZ?=
 =?us-ascii?Q?f75yNwhRS71kAf4nuKIgiAYMfeSheu8FLpPlseory7oIzkzwxZe4u7TXkeE7?=
 =?us-ascii?Q?jPvFnjcTCZIaY4d7X/uZHE1XhRc0raUcczf0gqycQm+m5KyU1w9RRfCiQtFu?=
 =?us-ascii?Q?oaZj7Os/N1bqEM5hhuzf07giD1NMgcGPz9INHF9IMIok24+GaAvswps7TsYS?=
 =?us-ascii?Q?Rx6dck1SAYmtnrD4IIlxQrAR2sCXclXv5+RdSlA/b/LcFBAWTRh8fhDzRbRQ?=
 =?us-ascii?Q?YkfKpxmPTkZQsC8ssm6bP6TVTdj6Vqksmdo5pQhxMeVGxY2gc/1i1IWc5JfU?=
 =?us-ascii?Q?P8VzDV7FnA93G6mvtNTSdg7oX22QnsBDeuNV5NHlURvKRI54ltkDxUwJJbR2?=
 =?us-ascii?Q?H6M8FRdN74/cVSMjInncgxWXpzRNe+ffs/isl1hyXfKAyTlYwAquqtnBWHcQ?=
 =?us-ascii?Q?vhkqC8p9KCgtpOln+ldwaPAdz+2CfBbXRM/eK0O8xjow1QjtwEnyFd6+CfqW?=
 =?us-ascii?Q?3P0VldI08VXZa93pYTo1dIFfgeVmM1KrESzAGnCdsmTxGYd5yR7v75R/k7Vi?=
 =?us-ascii?Q?FxKwwGyfLSsSU7231PHLLc9lDDBQIb9rDl+cGsmQKu5XOuY1z8CAvLN7/FTs?=
 =?us-ascii?Q?VEbBwZrE1f9MuxOrVXHYe82xWROskj57hxcgjs/VOSwbdcUMzPW8qTU70Qpn?=
 =?us-ascii?Q?y4QpQge2OsVuIiyxmGeEfepISDQOMK1vSACGmI6GuDgrjNbUbitnG3M1Ekq0?=
 =?us-ascii?Q?+c1Q3FDcOoAi36GrpzcK/d1T6jIqPF4Ug73ARbNPY0Krw5evDLZ9eRS37Q+H?=
 =?us-ascii?Q?j17WfsKlYxxJfHMvWxgHgVvidgDnM5if1JFSm1Vmj0NBusp7DkQiZbkOwHYj?=
 =?us-ascii?Q?tWa/0xrw3Buvn9buDTmK0p+hu9pT6W74bNqj74wPHcOPo3Qw66NyAlnIGAPE?=
 =?us-ascii?Q?Hu2Anjaky/3UvZdshaGN/6sra/wmU4XXM7bTYfqKqE6+guelRj8brEnGLB7m?=
 =?us-ascii?Q?NwnJMeXy17dVZZ2p5hzJ00HD1a3eOHNlKnYAlhq+QZUuyy+LBlu7W1z6cSlF?=
 =?us-ascii?Q?QW/xUMHBjJwxmjZUsEkjfV5su+ZjWGk02m2i9rrtD+cKG+FZro77owVy6d9c?=
 =?us-ascii?Q?HUDnV6Q0ZLzg4jpELHAURN4bKpKmoyY4j4VltRP2Wn1e3+Sc2HkVNmCVoadH?=
 =?us-ascii?Q?kR+1TxHbKKg7cSILs2eF4iO4dSbyrNBYfvMpnaqMrbFVYpESLvVZjzL0XbpS?=
 =?us-ascii?Q?Mu/jszSB9LoI2GcLtiNvbsTuBKJrL1tRXeZARZKLin9YWuM1/xc+6FtfCmPk?=
 =?us-ascii?Q?jx8SG5fYWQ9etvQYBhC3Y0/ve5QP5E/b6e7Y9qEPeV4E05OX+LVEpRpkC9Xb?=
x-ms-exchange-antispam-messagedata-1: ZTcdj9GXh/Hzzw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B4CA5A794F2A54FACF82D3329AC8EEB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692e5f21-f253-42ee-21e0-08da231f3818
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 22:43:41.7316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yraMx+xq2ES8kRBw357TntLxjDkXsREhtHF070PKh4NwHufFpFcdDdi8QFKROIxrG1w7WOoziqMMB9BnryKVtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2204
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-04-20_06:2022-04-20,
 2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200130
X-Proofpoint-GUID: ZQxYPVTbuYyGsjznkVMmFfyKH_0_28n8
X-Proofpoint-ORIG-GUID: ZQxYPVTbuYyGsjznkVMmFfyKH_0_28n8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220420_154403_233726_9838C978 
X-CRM114-Status: GOOD (  22.37  )
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

Reviewed-by: Alan Adamson <alan.adamson@oracle.com>

> On Apr 19, 2022, at 3:53 PM, Chaitanya Kulkarni <kch@nvidia.com> wrote:
>=20
> Most of the internal passthru commands use __nvme_submit_sync_cmd()
> interface. There are few places we open code the request submission :-
>=20
> 1. nvme_keep_alive_work(struct work_struct *work)
> 2. nvme_timeout(struct request *req, bool reserved)
> 3. nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
>=20
> Mark the internal passthru request quiet so that we can skip the verbose
> error message from nvme_log_error() in nvme_end_req() completion path,
> this will be consistent with what we have in __nvme_submit_sync_cmd().
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> drivers/nvme/host/core.c | 1 +
> drivers/nvme/host/pci.c  | 2 ++
> 2 files changed, 3 insertions(+)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e1846d04817f..c6809045aec3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1207,6 +1207,7 @@ static void nvme_keep_alive_work(struct work_struct=
 *work)
>=20
> 	rq->timeout =3D ctrl->kato * HZ;
> 	rq->end_io_data =3D ctrl;
> +	rq->rq_flags |=3D RQF_QUIET;
> 	blk_execute_rq_nowait(rq, false, nvme_keep_alive_end_io);
> }
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3aacf1c0d5a5..f326261456ac 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1439,6 +1439,7 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req, bool reserved)
> 	nvme_init_request(abort_req, &cmd);
>=20
> 	abort_req->end_io_data =3D NULL;
> +	abort_req->rq_flags |=3D RQF_QUIET;
> 	blk_execute_rq_nowait(abort_req, false, abort_endio);
>=20
> 	/*
> @@ -2486,6 +2487,7 @@ static int nvme_delete_queue(struct nvme_queue *nvm=
eq, u8 opcode)
> 	req->end_io_data =3D nvmeq;
>=20
> 	init_completion(&nvmeq->delete_done);
> +	req->rq_flags |=3D RQF_QUIET;
> 	blk_execute_rq_nowait(req, false, opcode =3D=3D nvme_admin_delete_cq ?
> 			nvme_del_cq_end : nvme_del_queue_end);
> 	return 0;
> --=20
> 2.29.0
>=20
>=20


