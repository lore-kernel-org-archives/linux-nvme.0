Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5589C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Nov 2022 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:Date:References:Message-ID:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s54Rc04Ypv+U+0E2oEmpgGBsMvtvxJGA/m5Tt39xz2s=; b=gJmwC7jH/9ZNkXe9bXi+yLuOxS
	UJx9VrQJKJAYv8CJaI5QD5vIxYMK6jgvF1azZg7pDGm1vQw9XyaaaT0eDwuP8XZpZjsavbVO7sDKK
	LAK3yVnBy8Qq5JDXJFVIPVe4ncN4YL3Y+1So1WOWVJ9IbmPFr48LivkxH8g2/G/PHkf6M2GTN+qvj
	i+H0pMac29UgislneR2+vt/HWfFxFQpE4bwp1Ar6vNFUrOMDgOFdTM0C2hi24qGe8TjQ3fQQVoHVm
	qCUUT1rp32zSJu+RSkS85wwgA5jNngL+U/KB/Sd267Lf8MgSGR5N9HlWORKNwr+tqgy5PlCwe2aBe
	pL5+6KbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os5eD-00GXO6-KV; Mon, 07 Nov 2022 17:10:57 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os5e6-00GXMV-8e
	for linux-nvme@lists.infradead.org; Mon, 07 Nov 2022 17:10:51 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7H9TrX006945;
	Mon, 7 Nov 2022 17:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=s54Rc04Ypv+U+0E2oEmpgGBsMvtvxJGA/m5Tt39xz2s=;
 b=kLj90Z/F1gqfrlnal9PAH6dDme3kwNjK7JOXmKyH9ndWKtFsxPYX52/VbX1UrhB2nWcD
 gnPe/PUf53L6mxRNgo7lsUQkCeBNXR9ppChrnxDxtE6GBFCykXFXEuIKxypCzUopVKSd
 rdyH3yHYRgQIzUxiQGysw1iYepYmGBGqVWJGmy1c7nbb7C6WNlkO5Y+cFUEhgditp1eg
 Kd0lf92pwgPLwl10yT79Z+j2oTAB0fP6r8DvC0pyOQvmKMgzaGiQuQsxP1rvfSB3o3vn
 83Vlkx4k5dedTzSOcSlhbYJhxilXkzD26V4qILDA7oDALY6gJBdicg5JyKdZpYn75P+K pA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngmj4avd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Nov 2022 17:10:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GkTWP025506;
	Mon, 7 Nov 2022 17:10:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqf1md3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Nov 2022 17:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LT0XKGTtB1IHdfXAURykkst80iemeeDfE6zyPHghYH9fE3STayeKgkCIxWUTZSr+i/mtpoYEgUBfjsXp2s0HTzCnZklx2mHd3kdwu8frSEwv8//6xAOD/7MEvvZlGXu1071KWrvlhRAq+NXuqVsA50OkzeSb+3YFYl6AY7hTcBmhyjOJYqK/yi3xX8VekUq5jzrZUHa/V2jmgy8zq+qfXzrIhsgEj4GTlG4G3fn3UmmG4Hpl2xAP3Q8OuLEHqIe8Q3pMhAtQEN8zl/HKxUiG4QJGz0/HsXdkDsI6iBNbqWQqYBVoXbYE0NQsNgKpCAtKP+taulnpmqVBmcqLjdWVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s54Rc04Ypv+U+0E2oEmpgGBsMvtvxJGA/m5Tt39xz2s=;
 b=G+cz7NjaN+ILz4PRMTBThLR0LdocL7tzzMob1CbGZhUySUa2pUDeeyoPVmnKc7n2wz7R6OuCn60cD07vVizIHq68H34gfpKymqgAeRVCmNDTCHYSnQ5ELehSlFIpmNS+k+swJ1ZHHO0PL+BpzDePczaMUpHbe8QHVZmAOA9L5Dd/XnVIIgfvuoySRBbZnYD6E8Y1jXf7eQ8McnnG1qERasLc2Ht987warq7h8XDelZeUiLtqvB9dlXvtvf49YJj4sNEjlilWzeSumrkkEZCqw8lprm2D7gW/vzdKX1YaV8BbgNRE0g0Wdv/E/mZHELhtZ6d/jljV8JXpeCXjRsmEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s54Rc04Ypv+U+0E2oEmpgGBsMvtvxJGA/m5Tt39xz2s=;
 b=hs78QYR4cxERXg1MVI/Fj7vQzS6GG2vjYZDNw/ILtnhdJ40COvDuW0hQ25zkKZR3wwEX6Fc6/tYqLH8Kyfv2ajny2n5cAQ/0zF067y5qniie1KARqafAqChF8TM4XYSpumwroHTWdUK8D0yM6AQmxuoL8iUnS32loTyY+Ep6y3M=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5050.namprd10.prod.outlook.com (2603:10b6:610:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 17:10:38 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1%9]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 17:10:38 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: implement the DEAC bit for the Write Zeroes
 command
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zgd2lmi8.fsf@ca-mkp.ca.oracle.com>
References: <20221107162108.1777681-1-hch@lst.de>
Date: Mon, 07 Nov 2022 12:10:35 -0500
In-Reply-To: <20221107162108.1777681-1-hch@lst.de> (Christoph Hellwig's
	message of "Mon, 7 Nov 2022 17:21:08 +0100")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: e451a809-f29e-4be9-b298-08dac0e2fdc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Rnl/w2s9K4jgOI1Fs/MTM79HydhRzz2+FzjuLdaO6PLDDYmDIQKr5AV+9TcKvL3yZ5rCW5Axy99lvLycAVMOq88oezj9DfMsIyuh5f3OoasqLgk7gd9jaN0lSjIc1gIo1hDVpDmGLANLP++3c2qfG394OsCtW6CRjvYqOrNIPAASFLy5N1u1Xhv9wy/60wdX0TwERjzcLQucrXMhCyYTwIFCDF2aY38pZBU8HcMp5kv6TwASv5Vadbr6m163e6HAJcuxjrVFd0EcruqtsSA83fkJqnGm/hu/s6twuKMXMgxg1QmIUbD9BSBBQMdqr4ib3bNIlbV2pMf3dpQ//n0xzQ0QQpoyeUlCv38tAY0V6yOsfP61uu7SoeBkiQPRdczOyaD7gY4Rdcn/TTH3y9xQXzvbNXJYcwhnME2DQDf9k3Hu54IxNhZiYutDiJlRR3v3wOBuBhKo9VhFnNyDDrvY69a6+vAUA+q2wPTaZCX5GAZDVOA0W/HI/r/stk/By1qkS9QDvTeH+r5qQazgJKnc43vURVFkMwPo1ItwhPRNclO+0Ky7kiCRv7YzKDlprtLTGWrJmQs+3QqMIBQBOz+C0HB3lwS3Mh3u5DQGqCNnW0oH5tBnN1IInoIZZ519/14SSLCSyeSD+gYV/D+oupT+bjueMWOZAHF4GJ+JgPFjkQkcZOMIUPjuBYsgfkvgWk557+erOYA0oQ3FEXTWqUvX9A==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199015)(186003)(38100700002)(26005)(6512007)(36916002)(6506007)(6666004)(4744005)(2906002)(8676002)(478600001)(316002)(6486002)(41300700001)(5660300002)(8936002)(4326008)(6916009)(66946007)(66556008)(66476007)(66899015)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?AI4aVB0KQSsg+VmaxPxVE/PdvcCxi+11NmThv60uQyUSpbV9JNDLMcT738kI?=
 =?us-ascii?Q?tWP2VVj2doeFFoQECiPsB0H4txyMeA3i86IW43tNiewPThbImWWQTUN6KyxE?=
 =?us-ascii?Q?GA5ovORLyCYLU9GiZQiwCIbUV8veAM9WMxKAZF4tsSxnRzCmqMn/JMtGalTh?=
 =?us-ascii?Q?yZsVEaj4hkYpxEJcc6oBxGcOrRDu75OGch10hGKKPXMTw56rbEk/hWlF9vAf?=
 =?us-ascii?Q?adbsBbjb0+feSqQ7cx/nmbfzB0UP2zGdOHO8ixFC0KIVXf+g7hOog0o4bPLp?=
 =?us-ascii?Q?iVKn1kBX333gVwnac2EfGaeXdW4yuBn5bOpQqyV7wgvFv4uEGU7SwM/i+RX1?=
 =?us-ascii?Q?UzXawitrSlgYoaiR/YIk7aLxFPS3sMEg+CmaXBagliG/A0qPxOkgTAtk4ClZ?=
 =?us-ascii?Q?VxPUPK5pwQH8iw2HutqP3KIvlWZbLNIOZipfjmCkgKdbhf8AReID4jenvpN7?=
 =?us-ascii?Q?kRJaYu5RTaQZvJ6SqbeIELGUY+dJJZyJ+cRXTOg/Jxe3ynlUz+69Mu6BfdZB?=
 =?us-ascii?Q?gnCOYapum7AsuiR69svjeEG2EPxO3++Nhaq2cxuSVbZ2y5bA8VRavCcsbFze?=
 =?us-ascii?Q?qdi0Qa1z1RecMF+ByG3E5ijYrbXLO+5pjSxDFWMB6tghkuERNlctxSIrJDoP?=
 =?us-ascii?Q?jiKauwBKv70yqi/32ovL195mLxU+Ev0e8FMeAutKf6d4reb1l572Ae3Dapy4?=
 =?us-ascii?Q?IPVrvwr//+J5QHxg8p5yrJ5mIX4cOxCp1ODyj7ozOaecKoOiuD+kUeiZNyWf?=
 =?us-ascii?Q?MUt+ixVBBPgPFRCC1lr19KI+PLh/zVVuNi8g6ItK22qiVpD0rz3/jzHI1YhC?=
 =?us-ascii?Q?4hZGrEYVo17BF+8li+sViHNp9FebrFVnQGt3UkL2UBxHRdsm/E9Rey+TPzK9?=
 =?us-ascii?Q?FzJG1P8DzFTHe36nidPLNOKCjlKBE7azAlqyPpDUPUPPmgAsi6RcwbodquO8?=
 =?us-ascii?Q?iGi4qTp3mtsmbjGXjfoN1uTK3JLmg4+zKd2rrH7KudkP+1nMWQSH0jwQxKu+?=
 =?us-ascii?Q?xQS/BN31EgiV+ittrQdtIWW2Pfg+r6QHSQniJaTgWR046Wa5w8A6TjfQ3LNz?=
 =?us-ascii?Q?h63RBz/cIExtDUXMr6SqcebtlvYKJElIbMFWr1Hk/vdDorEsNBsbO893I2tQ?=
 =?us-ascii?Q?XYdb8rZV1ygnQovuHhUGxFKv2a1avdhAfU5SKz74QJhEh7v+umhFR/WWvM/m?=
 =?us-ascii?Q?MLqudUeuN1zKHa3O8pm3E5Q7RtbOt5MrzvZfvMAZYIjDKcl/DoaD+bikNw04?=
 =?us-ascii?Q?dMSCS9JhAG6QO6evOuva19AH3sUN8hZDQG6AGrUFWnXYhPfWbPcSTqmYKZpl?=
 =?us-ascii?Q?PLt/b3qh3dxfmsxwiO6PSiLXAe9K+saadXyp2to+AOiEYNKucjGkdQ3E+Eei?=
 =?us-ascii?Q?ee0d9yl15PlScmeRtNn29Up84QuIYMkcgq5h3rCApKPTz8+n3vxamcBMaxKb?=
 =?us-ascii?Q?YjFQmpQvGdxIPbqrty8Tegpmg8pDkhE4dOzljBhgO8a59a7qZzWZxXFcLPTL?=
 =?us-ascii?Q?4mmQ7yFrl2xgFI2WbOWsG4jYPToqnoz7HSY47pc5Vh6jZg91ZUABIoHc0Zmo?=
 =?us-ascii?Q?X/GpvlkykpOym3t+QSwHWsKxECajGwv0ABJarWyBjVy6b/928YGWbn4X1O1q?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e451a809-f29e-4be9-b298-08dac0e2fdc4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:10:38.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/22GySEkhM65Y2w5rVXw1+NciBoJFoTld8O92b21rr1rRlV5nrMAVHdNaf2VzfYJtkD+LCH6pbm8cV3cSHpmRKE0yUgVcDvZ0xO77dRXbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070138
X-Proofpoint-GUID: 7CXDr2p5WeyU5BqezO-1HyTq-o94K_Fr
X-Proofpoint-ORIG-GUID: 7CXDr2p5WeyU5BqezO-1HyTq-o94K_Fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_091050_460769_1D3C30ED 
X-CRM114-Status: GOOD (  13.37  )
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


Christoph,

> While the specification allows devices to either deallocate data or to
> actually write zeroes on any Write Zeroes command, many SSDs only do
> the sensible thing and deallocate data when the DEAC bit is specific.
> Set it when it is suppored and the caller doesn't explicitly opt out

supported

> of deallocation.

Looks good.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

