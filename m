Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3D5C47E49
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 12:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+uSIUXjANZFukgMeeMVkRq+TTUtGdQJp3I42PgVd64w=; b=L09uFkO+mto+EUgQIh8QJTg08u
	/0gNUEyD1EAET/twOb+ddBRJ96FZPF4Pl4iIEW3BUYso9oTvgkDopEUZGOtWswEjsqJ/iu4M/1lXi
	hFnsFqh9JPK6IGz951JBu8rY+UWcqEczSdyho4cHRac60Rqe2aW9HFH2UAsD/A3XDn3tgY/2rrXeT
	Z1u+M8D0RfKdk+rYp73QTVgF5q59mI0VNjDAxZhjN8NH+HrSh5gWQw4X/alotSGmgl3DyW4Fpp8Rw
	8bB6JQPbyDLTYz0HJM/D/fW5p76WDhUIZIWU44n6DDHRr9n+pU2x16iAVfKPSb784thGVlYG9DnJ9
	ZTWs16rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rScdY-003IxT-30;
	Wed, 24 Jan 2024 12:45:48 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSbbM-002pCT-0J
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 11:39:30 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAwiDg019763;
	Wed, 24 Jan 2024 11:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=+uSIUXjANZFukgMeeMVkRq+TTUtGdQJp3I42PgVd64w=;
 b=QP9OpzxD5vzokSry2J7zk4QTQtMGfA3biq5C8IK8FpCPZzoPm1oU8FkomqG4oc1dICJ9
 /0D65cIKGiiNH39Qz7yBwcX3kSwJK/FDdFpmQXpp9PUAcVDy1Gy8VBYn5/F7pULOKB0p
 MGRrSQsu2E3PLOSVFqvnfVQfqriZdC3Lel0DtbQqKDqD4hGDpUSVcLlSxOPOOb/7X+4a
 +xqSasBOXjQOtnn8yABu1gAgJwV5YY3FMgLMw9W5xHWugmzdFucO8ITVQr19D6uLCeBt
 k877ICE5+0vYk8t0GiXoYcqdSBJLjHOYV9acZMXHMmUTCw2r22It3k4oj8Mpe5QVyF5p vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79w2600-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBOr77040836;
	Wed, 24 Jan 2024 11:39:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs316wnqu-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koaaPhm+BXKhX0GoWZTVs7XYPhR0sNIDaHqem6jDcrDO36o0a6hXUfBWSxPmwHIEMUWnPDPiF5MYk3M5lensTEa9uEtn21WpGhI0BGAOQ0U6nHZQFulRFTA9oPphJHJ6YSlgsDibGZDC3EmwD680UeqGB6uoSa1ZD0MP0Xawyyljd7hnBXlK2MKOd2mWpDGdK1pKlAnf4OqW8AoFtUfU6Z5nCOrsLFQ45WgRGQdMnaBYJoBflF2HUF2Xo5sNdEFuuDRO7SzOIX6o+CgcOeGo8KwZVkq7ESdgqY8oTn1TNi0y59shGXfTGrNj3df32hyKhnhFkoV2U1+oieljpU1hQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uSIUXjANZFukgMeeMVkRq+TTUtGdQJp3I42PgVd64w=;
 b=gah0Fe7Lr1WbKE6pdwrD/Saywq9WfG2Y5AlNPidMbGaj4rnrqZaT3hoQxn5BBdfXbr/OwiNnqNREF85j5D8FkzBb+ZGaaG8VKJazY26mnIljw+IAyyzEyxNsxGIK4OZbRkdZQ1EeKBzISIeQt/uT2Yv0LIGdlSPQHQzBX3Jv9lN8g1EOv02pUqsX2Mt4JRSwJAyxUZcmOpIZdQsfxNzjHuZDlcyKms/Bp25NwC3QMDN8EA0QGYV6buxVrMmaJZE6MBncv4FXn2OE55r/yq36v3h9DZn2pwGHjjnEJAolFETKFTkbL/bP/WitZyhljJ5C8NpnM0EYXVzjq8aE+qg6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uSIUXjANZFukgMeeMVkRq+TTUtGdQJp3I42PgVd64w=;
 b=qz0+jyWu8/UQWNkstq2+Qt7BDvfZYfNv+GZOkmLfsTFLriR3tvG48M48EUiojZbaN+alyHmST70GnHhzIePXKKcnfuBJU1hu6IDSiKSg/LxdvmvbU7FEKMoM7VE0QZEo4TZtsUB1DhU4grrvhG/TT8FaXqo/ax6Z33/AjrSF6Po=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:10 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 02/15] block: Limit atomic writes according to bio and queue limits
Date: Wed, 24 Jan 2024 11:38:28 +0000
Message-Id: <20240124113841.31824-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 1470a19a-4204-4580-242d-08dc1cd114f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVf722S+2N5J0cadwaKUqAZoxAovU88dKdrNdThMLwqOJonZetvaNQEbxVujOz5buGsC/yGoVvS13V1dhDwyCaXoL/JgkXT53hFGSacgZd0w1arwd4M5ltIs4E1BbgCoDgd3Cii3m7MFQMHncYPpagK/2COfY0HA/LwDlvCc2N2AkIPOPb8GD0bYdGeLJDFrHN5joxgGLyMheJ4OenQY7Q2nZu2HPl6wDisaPTbxhT/yD9OBJzIZafypu2txR/w4QpUl+olfMEVVDI1G5xRwV/SfI9N2nsAPUC8tJHIDHY+BspqRhLjbgTnUkaI6OEjExWwTr4YK7cAaThUgohMLgu4n609K5Prr9tshNFrWorn2zTNFpzotmMy9cq/fuiDHo78yNXSVLD9rpU7s40d4HdCkwEgsHraQJF+RuTUyrjV8Gdas1TQFiHKEpQyd9+TtKHhEYIQegafCCBrBU5rY+yBbMrTfILuIGDe066erQaBXryjw6GNAf0ZNrUqW2pceh83op9an0+B23WdlWu8Vf953LhfGjqoN70dsfAdKvc/IwdS4euDVNNaZhh2lCrOiAKTPmMYFNef1e8juy4ZsSBqQx6tY8ay4DjM4kjWaMds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8676002)(8936002)(66946007)(66556008)(316002)(66476007)(921011)(2906002)(103116003)(36756003)(5660300002)(41300700001)(86362001)(7416002)(38100700002)(6506007)(6512007)(6666004)(83380400001)(26005)(478600001)(6486002)(2616005)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YILztSYGQnrkzNH58UozykSyR9A/SSFK3p4PbL93L9j4OmFPw7h7K+f6TS5A?=
 =?us-ascii?Q?42WrwUBh0rkRi/2pXsUGkHFNwPX0u070oOLpUv1ZxCmsZdqVVHfzTnUgUaLe?=
 =?us-ascii?Q?wpJqd6aWVrc4Hyy4Q6VJl/5LDy8BezJalihGr7FvGOru+DmjsEYliS1bgnkx?=
 =?us-ascii?Q?ELGWDndG+jKpYdTi2tDzFkiVYRrWc8LQkl3TUy/4/H9K31ox+r8lffQzGYg6?=
 =?us-ascii?Q?WF28s80/gjQpviF8VKrPOLcOYFilmFh0uHxqtC5BUi2Uhw4vt+BpS6oxLCr8?=
 =?us-ascii?Q?o80qXq35tF8OSgd/ZO/9lVo95ZTxEFNsUMJyZZSW9qV9ihUZ2xu7z8gTqjEi?=
 =?us-ascii?Q?juufXQ2WJKVZmObIyQzlxsuH5sQskDgzSs+L20h3Xjyeeb1zh7Z26A5WFCIq?=
 =?us-ascii?Q?+DKIwIbU9s+WECxPG54LRVUuBKD/Lb9aYw+0jYsHeJ+iH/WDk+VNKbjsvt13?=
 =?us-ascii?Q?Zd59t2DXIKZXQYagXVVx1Y+KeMGYtQYmEe/Pu1k8cWM0TgOjZh5wHuvNlOF5?=
 =?us-ascii?Q?0gdh9cz1tIPmdQU46YsfqvP+ob72RWgIBpsa8/5npadpbpacSKpZN9dI5vb5?=
 =?us-ascii?Q?e58MoAGu6whevpTBRZRslhdK0PxXnhfyyV47JfsjloaPiTKN76ehAB94y0UB?=
 =?us-ascii?Q?+DKWsVdEnOw+eqjRfe5ya3gr7zneb9pGMug73Kg+iEKCKpeWc1wfyszOnHx4?=
 =?us-ascii?Q?GwBzTIwrAvRG6OWwiTrrudhcHAtuGwGj99o2xq6/xt0HcbjvgIsnvOBrPHdR?=
 =?us-ascii?Q?fFZz4SzQzwMH5oA4mB5Yyj4isuZR2fQODnbqJFuhKugdG7QVgd+bSLe2jYFD?=
 =?us-ascii?Q?MIDLz6v2H5zj440l52pB3ppqmUnZXEqxfUoFTdU96wbRdNyRV+RM443isahY?=
 =?us-ascii?Q?nPrQVhyUXGRl1jEdLmcmzXq6ScjuMdmFjupKSHQK4PE4n6APrIHhCS0dIAIw?=
 =?us-ascii?Q?kKx5yDgyNQZqnRjMMMA/cE5LLbLT30VO4T4fbN7H5Hpd8mEBfctkHEVKs5nZ?=
 =?us-ascii?Q?cyeWYHoRht1N0i07ycwNBy6icUyRsSNpCGar/+ElpoVc17fo5w/d6B0n7WR2?=
 =?us-ascii?Q?6z/HloW5m7M9IBRc3dcAMh/ZhcQ/7My68awJEP/cCHFFgj5XWCKK4fKDaQsQ?=
 =?us-ascii?Q?M8Hexz1fnzi1L+1yGHcZZ1Y7VqdShGJu1pivAnsdp3n+SuDk4wnU2TZ25bVf?=
 =?us-ascii?Q?RsZxZKUI6dNwBCTjdaA/Cq86cHl964CR80sFdRM9fUYYtYF4ludnF9KssVJS?=
 =?us-ascii?Q?tDEqgw3MromO8nCjFaO1lInpkSHHkqMefr7ZgJB7jpBMqzB8Ca+yGBPO8+nF?=
 =?us-ascii?Q?KgycxZK5rPEYLUXI5itqx0dga/pGQxjq/tvSdFG6OAR3qmpuD3QdPbAaYHa+?=
 =?us-ascii?Q?WqaHm5UjGHkIBuZuu3F+MNKdSZ4+VVJzsLRYfE4WrZmOrnEHyHdKIVzUsJip?=
 =?us-ascii?Q?8uTciNMN+kUbnWRZiuIk0TAyXYeuYO82FZVwI6TzKE+Kfv7YcpEoWmZj+8My?=
 =?us-ascii?Q?FyOwHB7e6Ufjmf4qmUTbejofmWC7WcSIYYd5i3+kouaExwm51XjtaNNaCqRI?=
 =?us-ascii?Q?fvQSZ1f+hYk0EntKIU5V9JKSNXfFrHc+3ISkeS1Y7bHIcDt6ySIIFepEI08W?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kD4EBZqYiKW76YIUlKxLWPl19dD31OHHZ1p+q33iYhX7uqxf0zr53rcrApGnrZwG7LP/UZIaqlq+yh4viQMsvLYKI4zyMqJz2Tu36O5OxaxUSmXXhU4uhjSKP2nIEzHkyhtHUSCHaPylwmBxt7VCKkS9xUbMSjeucI+t9tYTD7kg7ngxuF6btBCP808/zD72uyEFc8GYMPXj6T88S3kam7Rg/uSXrNr6N9yn5sqUI1GLYxYFZ94Wl7/6JagB5jyrqp+lWcylv6eD4AKd1Fi3E2FTslX1w7twKkETu/lZJQezI0mtUxPvIjWmfD/ZAv2sJt2YDoGz9bU2FviX4nPiO8mOGzrrtmeI6KLNP6zyjGidx3wQjqTXe4uS23C/U14nCV6uG1KodO/qRrsGK2ADf+f9ItsBDMB/Lq76RM2aYHIH4sePlMx3DkKSFzSCUpfEG53ELMrfkIXNJ4EbWyGl7T/Up7Xnkl8lXWdIpsfjO7zkqU4p2DQrQfkB+W0nEDr/9n44nNvveIKsLINLEv7d7RTKJpHvl1zeI5qwrMBOzjo0IQpvVNihKogtjsF1RZHgxra1+KxjPgUJ9Gnv65jlWLQ3x05vBVhItOM/2BDqfAA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1470a19a-4204-4580-242d-08dc1cd114f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:10.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mLAtLTPZJD3VbvzoFllLIR9mEVdNT1xTNtCtPrseAgJMnDDxD/jjvRoG0d0pe0e/sLHI6GAE5fnEjk0HWBmjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240083
X-Proofpoint-GUID: 0dgEDptt4ip3xmm9QzfOK14mBdPqtszO
X-Proofpoint-ORIG-GUID: 0dgEDptt4ip3xmm9QzfOK14mBdPqtszO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_033928_276078_475F5BD8 
X-CRM114-Status: GOOD (  22.04  )
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

We rely the block layer always being able to send a bio of size
atomic_write_unit_max without being required to split it due to request
queue or other bio limits.

A bio may contain min(BIO_MAX_VECS, limits->max_segments) vectors on the
relevant submission paths for atomic writes and each vector contains at
least a PAGE_SIZE, apart from the first and last vectors.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 11c0361c2313..176f26374abc 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -108,18 +108,42 @@ void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce bounce)
 }
 EXPORT_SYMBOL(blk_queue_bounce_limit);
 
+
+/*
+ * Returns max guaranteed sectors which we can fit in a bio. For convenience of
+ * users, rounddown_pow_of_two() the return value.
+ *
+ * We always assume that we can fit in at least PAGE_SIZE in a segment, apart
+ * from first and last segments.
+ */
+static unsigned int blk_queue_max_guaranteed_bio_sectors(
+					struct queue_limits *limits,
+					struct request_queue *q)
+{
+	unsigned int max_segments = min(BIO_MAX_VECS, limits->max_segments);
+	unsigned int length;
+
+	length = min(max_segments, 2) * queue_logical_block_size(q);
+	if (max_segments > 2)
+		length += (max_segments - 2) * PAGE_SIZE;
+
+	return rounddown_pow_of_two(length >> SECTOR_SHIFT);
+}
+
 static void blk_atomic_writes_update_limits(struct request_queue *q)
 {
 	struct queue_limits *limits = &q->limits;
 	unsigned int max_hw_sectors =
 		rounddown_pow_of_two(limits->max_hw_sectors);
+	unsigned int unit_limit = min(max_hw_sectors,
+		blk_queue_max_guaranteed_bio_sectors(limits, q));
 
 	limits->atomic_write_max_sectors =
 		min(limits->atomic_write_hw_max_sectors, max_hw_sectors);
 	limits->atomic_write_unit_min_sectors =
-		min(limits->atomic_write_hw_unit_min_sectors, max_hw_sectors);
+		min(limits->atomic_write_hw_unit_min_sectors, unit_limit);
 	limits->atomic_write_unit_max_sectors =
-		min(limits->atomic_write_hw_unit_max_sectors, max_hw_sectors);
+		min(limits->atomic_write_hw_unit_max_sectors, unit_limit);
 }
 
 /**
-- 
2.31.1


