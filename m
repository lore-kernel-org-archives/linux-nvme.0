Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A729CFA3743
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:Date:References:Message-ID:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MMq48UXWr44Q2jFnkGiYv1DWSVFBp9Fz+AAYYcD+isY=; b=yoRuykhgsZCS+2pmUI79X4BqRX
	yK0yO3U9JB/FvSCxvGTYUhj//JsW2bPnvpdmsg/HjnHnqRp3JOAV4b8ARKsQJuZUDFJMmzdm5uPut
	+ayP/cdPQ8C7yS/bN5mvOvZZp2HoTKEq3ziiWAA10CRF9tP28IVCQ98C/WQhpZbcIbIsJ52BR+Mlp
	ap6B0kQzrymlKqSd64WvYlks2cWHzLNuaYgE/7g/3ez/A+f8rSuEKZSIg2a1DhRxu1erKK3uv9lI5
	dLUwmtjNgrCkS8xbHaLmguTuWaSDdp/RiU8Ig87NnagMPxyACd3Ggmq6u/2w8irpjsj58RIlBYMH6
	WPCcmmJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opX1W-00CkTR-8Z; Mon, 31 Oct 2022 15:48:26 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opX1R-00CkQw-FB
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 15:48:22 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VEnxsf024064;
	Mon, 31 Oct 2022 15:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=MMq48UXWr44Q2jFnkGiYv1DWSVFBp9Fz+AAYYcD+isY=;
 b=uH+6UQjkvZsEEK75sc2RTsKftXpwpxrHIDoSS8nsnnQkEGl4LPNqhWNxbSUpgLJpOAIC
 1agsDfvBv40QAFY+IFG8Y8DORkE9w75u2/wHMsnU1l6llBQNYzpFDde4AMEyPZBAWZg/
 yk3KwooONiS9TVpJhB2QV0Inp3CzKAw3FNzdAYvG1cdQ5gjy0/wUP7nNTMYfP+k1tocX
 p9JLfZLbjOLKPj9ouaT/bUpumhITMcUdSNuXrnrAOsLky6mF1mPCvr2WISuDjw9pSndp
 SHZtIgJg7EkIzoN24q59xrPsnIEJvMMysU9y31/ozx4qNTaQTmV81kl4trLTCETXMA1N uA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty2v5fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Oct 2022 15:48:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VErtSk016265;
	Mon, 31 Oct 2022 15:48:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9q77s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Oct 2022 15:48:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhlgcamoigSstcpy6jrZ/ovFRROiw9oEe2omxrd9nCWKGHJyyQNdyvG0r6D+mRBajSDWEbjpNxzbRP41p6ZRrK7o4mL4Ovvwl50YXzgh6gnvq5hyIvximGwOKdPPtok+9cR8HaNvALn4uGLNrnF1ddY1k3L/FdG8wI36pGTFc9vg79vPraWYNh5W399/sr3sixHu4j+5jw3ePd16KlZ4SrgnJp/aejnghjn4r1z5ZNWzHqBc6hSBClhDBOMvSz4NXTt4VIU1Q5/47bryv21/zWYOcL5X7u56dWgERrOpFE6VDK9Q22eCJElEESOpFZG0pMIr1CWCYuat9DtQNBcwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMq48UXWr44Q2jFnkGiYv1DWSVFBp9Fz+AAYYcD+isY=;
 b=MTkUb1aj9TUVWFLzwNKE9RGuk8j5S6xoFgz8FpSmzL3uosFH6cpOngmse1RuSgsFIW4aFDJ/XpkOjSh9xhu64Be1e1QpCbvJaqVOyQDw4DDWxTkdtFTnIX1Is1VXWlanMjUdt6cCDq9Cw3wspwcc9mGPC6Nj9/+pqIi0MZAiTCjeZghhF7l4Fsi9ZZyIffLjJuNRijzGFnqP45zm551pwS8QlzscBA+SDSi+06vn84QsIz7KWPkG65MRSifNBQGTiX5xvmoqAbwnGf4l6jE/J8O6rCLEIzJpgo6cJ7Ofi68fiYzCP9DSkiMbBuwsDqWobXhVfD+Rj0ew4kxHbfbdsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMq48UXWr44Q2jFnkGiYv1DWSVFBp9Fz+AAYYcD+isY=;
 b=V/vvwD7hhUdRizagqGH13Ot3Yg9xKNCvXuO+rBUTbE9Z272NpJeNL3vUlf+5EL/fAXzi7uroF9T44420LfUqLwLg9dZXya2L8qZHzMpdzWcgJFyRN2lKaZcOWYeP3YNBUyAuaszmm/bjt4EiA8DEXeQxWKRBzPFaK/Ft04455SU=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 15:48:11 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::13ed:5c00:56c0:93c4]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::13ed:5c00:56c0:93c4%9]) with mapi id 15.20.5723.033; Mon, 31 Oct 2022
 15:48:11 +0000
To: Keith Busch <kbusch@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig
 <hch@lst.de>, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: implement the DEAC bit for the Write Zeroes command
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17d0gq9oq.fsf@ca-mkp.ca.oracle.com>
References: <20221030162906.3390-1-hch@lst.de>
	<yq1cza8qc6o.fsf@ca-mkp.ca.oracle.com>
	<Y1/kw75JaNsnt1iy@kbusch-mbp.dhcp.thefacebook.com>
Date: Mon, 31 Oct 2022 11:48:08 -0400
In-Reply-To: <Y1/kw75JaNsnt1iy@kbusch-mbp.dhcp.thefacebook.com> (Keith Busch's
	message of "Mon, 31 Oct 2022 09:07:47 -0600")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::33) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: f01ae610-a3d8-4b81-e10d-08dabb57502f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	L7QwO3fELLyKDg/WDNm/6BEjIWn5oAF07K5nJLmE6fbm+qIIuFbKGoQCdpLfCSyzNEwxLpLv3ljvi2wd7yHCiSX93KYb4oLS0TZLI/nra9WGwUBb408dlDDEnYKJgXIxMK3fjbKtsamtkHy/RG/vJsv3eMeaMd2pjKNE6tXnUtsQPu3ct1l5jFrPkKTd/OYSgOwr6DSdInU2j+LJW6kpPyHnP1u6SpxlwZy0eiyCpFmASY1pEqSZs8b8Qq2YjmLQt8YInKQhg3uWBwDvBqTufx9fNweZJhaL32kg9AJ/J1Xv+GMeC9bIABevq8f0XeEw0DinFye+W25UBCt/r//IrDZDHsRWfhL8b9XOIlAHZxPZ/HoFAhzTW2za7B+IUVr3ngoKIwQkAhe3y1aw9hlnvMvYHyICM2p4aYKi9Q4cSK8ykXNcX0YTbG9Yoyxf5CEgI5MmssTivb6HMLpy0NOyWHBSlrw2CLlZ40RnGM0xV68yBnta0SiMbLye/sStptTFhI0QbBFfnDtkYXksk52Q4FqidZejdQ3Bvbu9cFWByieuC4iaUPdoo8Qdlsy9FQHLt1YjwfBZ7cjaxEP8Udjg36q+kSBrmuwXh7jgbUVKMyylCUNLqmvjoQgrCxQQE/Xu/KcFc0VXRmhZcic9i5OLx4rZ16TcDQLl1OUbjt8JLjuUCJK4IKLmfVNUPNSD4gBphH0oIDdj7AGzkf6WsCN1Kw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199015)(478600001)(5660300002)(186003)(6486002)(66899015)(4744005)(36916002)(316002)(83380400001)(8676002)(54906003)(4326008)(6506007)(66946007)(66476007)(66556008)(6916009)(6666004)(86362001)(8936002)(2906002)(26005)(6512007)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?BT2MbNHr3rpF6b6BhslnzK07t+pJcW2IFXCbbORbJswLJcdtt8zdbOPpv1Bt?=
 =?us-ascii?Q?/fSVyHugzjzeAY3AKEP4iZ0fxjSAX8xigdsPYy9R+Uz0rVEM1UV0YjVki9Es?=
 =?us-ascii?Q?kvhdvRvBYoYyr/96TfqqZvlt0PGmrzk4Vbf4QWXdUqjppyherq/pwEYEtmms?=
 =?us-ascii?Q?bHnXmgEtOwy9VmfZeuBwlPUd4h+j321iEn44a9/A9TlKg9IDe0rNF4fb917V?=
 =?us-ascii?Q?uX8sxj4SwAPLXStLQR/M+fKYsaqOKMsPCzO89IzTYCBvRHfd2uEb6gsyQBgA?=
 =?us-ascii?Q?6QbT2fGztsr5oymgU49yWg7CdWqOzwzQ6YNJec88mXBpZ3YvwSazSK6GVIce?=
 =?us-ascii?Q?tyrm2tF4ZDzuAmGQH/JHeWv4bCPnIN1K+MJwoR4Ff1n7f4fVdavpAt5HQp4a?=
 =?us-ascii?Q?1wCdjiH3x7dGdTammodM1zJM2DnI+qASFrNhCqj/Y/UYvncWjheLy9V90nQU?=
 =?us-ascii?Q?GJPbeO2UiaLxjkci1Fl1Ite7fBd/p/unXbPNS2bDKtN+Bb42YqIQUfI/cn8s?=
 =?us-ascii?Q?jhVdmQB55hTuahaTBPg3UjYX6Lv5YKGoUYUogty7HgViFtaQe+g0expwjL4N?=
 =?us-ascii?Q?k8KyvwrWWZJZmWZmWBAqCP5Qp9VaLoLPi9Me2uVZ7Vgc9VIcfUfUiq8X/9Fe?=
 =?us-ascii?Q?4bZageSsZvRxEVBF9dgrLGvk6FyZZTG6U71xJh2b4QJ4dBsBwd1b7O/qK/25?=
 =?us-ascii?Q?GrhVITRQrvso9rLl7vp+uyIAEnXexATBrGanoAwxS8+57v/O2EYNb1uzrXuP?=
 =?us-ascii?Q?17PzBXYGyQ/0okjdUXTwDYIDPdKnGVQm/Iagddtk6iCCzhPi48Qbmd6uXAdx?=
 =?us-ascii?Q?c2UDjF/4M5zT01jmZ5fHNNF8S2XzdSG6xuulZ/wy1EKtZ4mo54CYtlCEs0hX?=
 =?us-ascii?Q?H5X+6+tSrm7BgW8pZa3v3GEHGgbyEWWy+yx3Hpcc8nudujP7Q5p74U6Qfnof?=
 =?us-ascii?Q?L6lHqfT005yBTch6TmhcMcS3WjvXMzg5FtmNlZQ8Pida0wr77c4gPsONd7+u?=
 =?us-ascii?Q?BAgucy6Ql/Ylt4g5HUTEasc0RCptV9y9ZR/uSIVEUe8NWZJs7TFa7wdzOKOs?=
 =?us-ascii?Q?xJEhh9v/ikrMsfSAZMuqbp276qGrygJGT8lZAoboglu+0adgumWRKzVJTwND?=
 =?us-ascii?Q?oN7np9L893z7hXYpktVKxsQn+QWSd+q688pd2Q8RF/rfvwViEAUSOCp8suCM?=
 =?us-ascii?Q?fBpxW0DS2SWlNEK1sf3o2os55iYU/aFRG815X9ZxJJ2Xi6RhDJQxQec9R54D?=
 =?us-ascii?Q?5+U9ypTe4nTYYgsEkG3XTqs2H3YJ7cb09WI9tcrlc39SGHeWxPrRY2rMkN+C?=
 =?us-ascii?Q?ortKG28V/oozTnP/Q/sC6VX/OoO/fkFEtDNbz7WXqqq416S7JEenifu+CJL+?=
 =?us-ascii?Q?qV0qnipz5A1ehTRWry3497qcpPc9rDL4ixw2K0Gt1zVVGG5ACPLP3DSmCRsV?=
 =?us-ascii?Q?otYKvlqLibBSrFk5DZ6uqiYpX6FwvKHYvc1qwqsDUNOQYl2YP8V7H1nyAdNw?=
 =?us-ascii?Q?XAEhQJOOQaziztcObuU3B5Qk4NjzAPKtjF7+NhNerkhHbTTl0RdZvdinKVy+?=
 =?us-ascii?Q?9YhB0VJsOShXDx9HognaKXIW7wmNY3TnK5Nyd0r76+E6pJMgGnCB+o8uDq1S?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01ae610-a3d8-4b81-e10d-08dabb57502f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 15:48:10.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUcwhi3Sq160s3nSKEpU9p3kdFOKX6h4W4U4x1cl7wjPwG7Kj5cWQUqyalZ2VSr+6tfpXhWe33QiEbU/nNlEcs988bfyenhVBHnUQ6AisVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_18,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310099
X-Proofpoint-ORIG-GUID: MO1e67aQnwmx86K74keycTH1bKXDE2Zj
X-Proofpoint-GUID: MO1e67aQnwmx86K74keycTH1bKXDE2Zj
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_084821_648574_6F7B6562 
X-CRM114-Status: GOOD (  12.22  )
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


Keith,

> The device must return all 0's for the range covered by a write zeroes
> command no matter what. The controller shall not deallocate the
> logical blocks if it can't guarantee reading deallocated blocks will
> return 0's, so I think it's okay to skip checking the lower dlfeat
> bits.

The spec is sufficiently vague for the does-not-return-zeroes case that
I'm concerned about "shall not deallocate" being interpreted by vendors
as "free to ignore" based on past ATA/SCSI experience.

But we can always quirk it. Devices that return all-Fs are rare.

-- 
Martin K. Petersen	Oracle Linux Engineering

