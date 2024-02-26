Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8F7C5478C
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 17:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rTpRfX6Re6BPRP1QicrEwIdjg2IWzfcdHeRheN+dgZk=; b=hQ3porV92XhEgcufgdHpIn6d/P
	aPfWL4vFnVICJEdANEBXQiu7O1tcxgKl0fT/mM6FkdBrItfVIt9efDquRZbp/JoaReEWt4UDIPDOA
	w3Gd0SEc+lZmjs/uwmCwgmK7u9ud3HdlegGVNcXb29TFFdEiW1f/YRsXtHu6lBRZ3lE6qhYEkeHY8
	f4zr+X+fS660rINazFIsoogvrc4rBnvlM/8LoeuET9uknVgiTIVd6FOuXcdgnvPtcN+YN2XYdC15J
	HFlexKeySS1mb9Q3Fe/gipPgSXroFcdUAIV78HITwROV2QpMxxWMxhkt86avrHwwZ7ge7Qufiv/66
	Kp8bYjUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reeuv-000000021Br-0M0Z;
	Mon, 26 Feb 2024 17:37:29 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reeue-0000000210i-1BAf
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 17:37:18 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGnG3p003882;
	Mon, 26 Feb 2024 17:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=rTpRfX6Re6BPRP1QicrEwIdjg2IWzfcdHeRheN+dgZk=;
 b=OuPH+x0sOsgxH9KW5adNyEj5xDRDHir6008Z726fF5BZXPEDYCOD5PR6wTI/8rcjVRXZ
 kHY7qlEV67MeUUme+ewKeDP7Oxlwg4G8enYIXdi3HY27asaBMUlku4tmqr+QBS4gTCgT
 o7ohFIv6NnUj7rBwaHcQQU5qBPwG3Qvsebv6xjMn/JronqotyF0D4EP0yF9Pa/7sPpp/
 HiI59qng8HbGQ1uLc25pBxOGIABD1VYRFkpzGUsUsoC90Th4ZakmWOpukfFtK6c+o3ad
 4nNjFJLDp4BZn4ZwtbOt60zDQgKfAPgHWHhSlvzeoVczxlCxL3pgY7I4C+WmXDAKdhTE TQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccd5tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 17:36:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41QHOTtX009826;
	Mon, 26 Feb 2024 17:36:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w5wa79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 17:36:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgN2zoelF1G4tCVhqpUQ5Orqwq1YroOTBIaRPw3L8pBHVTPktKhOGuE3lcv8t4Mf0JWOScBxTPDYIt9hTCutCrZ9vhzBXInG8fBiVoTVkbD7cn/cUmI5VggtG4tKLi6hRdWHAzhxPG27xlj/fLiRqNzODXhkdjJxucNcV/JauNNI8vOFy8YsNJHQNAwROaNBJ9urMXZFq+LTnClZJWXp9nL3QwLZc24dFWIfn6JsEcT2qIeURNCwaCLQlcT2I5rnGgyC9wxbjvymTnqM014hHwymeMBqZ5Kh7OXNV2SR1gJXt1cjTwSi/MJyT6lM0Ba9XPNWMMenUmINetQSo5lxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTpRfX6Re6BPRP1QicrEwIdjg2IWzfcdHeRheN+dgZk=;
 b=HYq2fHy4ADp1e/FxYH1JWOqn1okPwyfm7i2Twx42M4/72ACPO1TTzHyrfe6kGJUoscFzeVhGwzHq+qW9euNMauHEwBf/OegnmyVUfk7AQGM6UR6dID7aCQdIT7Sk14yO8nva/FzEp6sEP/NlFZI1jxN8zvp1YUlruzVCWZWro/RibMvlW9S2WEx2oV5YuP5OYmI8iVhvSCuNkbETWvMTPfc6gH2GF40oNpIzd+IM2l+eZqAzVoWpPAh12x3fMp/Osyd+9Wuk3rsK6vsFobIWIARo/QZQRqjDNNmbvTy/KHr8wTY/iXxe/uM6ah2sR9JunD6F4F2f8vuDbkBZJCBuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTpRfX6Re6BPRP1QicrEwIdjg2IWzfcdHeRheN+dgZk=;
 b=ydrfVX+KnOpBZVC+M5hnvb3kXk+V9PRmawodI8URezM3Dv2IfYOs2QIu6zXb9jhfaqqNrOKwDSg+JNn/qjp87yQ7lFeQMVZrGK4GBvc2ZE9Zx3IQIDMvAJmjzXcouncrenuzrY2LIyUUXiulPrFYZA8FBASA2bepCRYVUVMU71I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6298.namprd10.prod.outlook.com (2603:10b6:303:1e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 17:36:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%3]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 17:36:47 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ojaswin@linux.ibm.com, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org,
        nilay@linux.ibm.com, ritesh.list@gmail.com,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 04/10] fs: Add initial atomic write support info to statx
Date: Mon, 26 Feb 2024 17:36:06 +0000
Message-Id: <20240226173612.1478858-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240226173612.1478858-1-john.g.garry@oracle.com>
References: <20240226173612.1478858-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:510:2da::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a44e6e4-2e65-46c1-b627-08dc36f1816d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5WcoaErkPW+GClvQWLRjzoFRpFi91x8qzn8I6owRb4A6FhglZeaCOycBFa73kcT3mBjm1ez1s0awc5MPW+PolhmJr+VFEJjrf2YnX7LCjEU7GhimO1/0fM6mC+qEDZ61pz8Z6mj11m6sI5ED7g7Tg3xq60NCBhdTmgjpP0TW5Bvm3eUdqZOrF0KtXMawvLpNUxg7JS9a6sNscLcL1LipEy0ODd3hmYzkog4NbS1jq1kFipZWwB6o4UNjkWvvySepzVCiojeBrA3TuUa5f7rXgIX8ymX3ShzGO/MCFU8qn8WwAvZFL3wJKPh7+uYYf+wSlW7C4GKeILVjiHSmuhfVcjtbSUB/42PrKA9G0ZXcCq5jWneIbsW46l2USxMq7Nvr/81YG/7QkDvrQx9rK4eyIiqNvs+7fCCwXKkXdNJcNksCsLxR/z5DCEKTRLRyhS/nREBC/2Uo8lsEWfFLjDP9d/g154CcEDkmTBnSRI18BrRJqIyxCj3rfO9jZddRB5lZYAMoh7Cwjp9ezW8P+A/pT3RIZ20PwbwT5kXkUIOzqq3g1FnlHwXw1+2wR1vEtkOxMusvZyPgL4xivj5MNntk1iHQN5t9ZaXfWTXYEa90R5t8U/MnfikW5hsyGe9BtYPk7eLWhoQf3kNpM1GkTxcrE5gsJQl1GbQGVmNjHWtEvMWYiMmbVmTYIeZnQqQsZDtB8KBePbN6HwxlviEpAHAFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3p0IuGi915oa7aI84Ry0ZG+Vh1JEXzH84602fV1l98v/4JRcgphG/MCwbJbZ?=
 =?us-ascii?Q?TLa16km2UqKJheVB7OOz4x1bbNmBcm0vG62+GbUs1qQpNo2KX8EHSj2mhO9V?=
 =?us-ascii?Q?bi4GQu3F2r40vC6xh0cgiRZJ4MYMUQmccLhy1Z3Lge1r/mYGe3EmuBU6zPcI?=
 =?us-ascii?Q?7GOO9wZv1QcUapASdLSgegLdxbKj5Qbni7lwX7xxS4YU6EoWTLdYBbPPziMw?=
 =?us-ascii?Q?V8OHcSwz6D2H37JnzYcwc9LsIil8e/Ir/1jHcFiOUlPXRcEZERIKpdUDsTr9?=
 =?us-ascii?Q?g+DVHMth2ee/5RS3BE/oXSmTlAxaCCjEK6KuTPNvvkz7rdSp9SdJCi1NfW/C?=
 =?us-ascii?Q?Qg4//dUrXPAo380RC1nsRO4maMs9LJ31C8K1QRfvrKreYk2JcBoEGZiSyN2H?=
 =?us-ascii?Q?KPpZBrEVma93xmddru/mk/GrXLBYUyu/JVgAaogG54AZN0BdmRplWLnaWKJk?=
 =?us-ascii?Q?QOM1ZrMrxZ75tJlq2ekWZf7QHFAoW7Gr8U8+vPbuaR9j4CSZldZiR//3iJFu?=
 =?us-ascii?Q?kctkgXrcIZgZtbfJ7cSNpZ2w3y0Qcphl/xNIrPc7hdHsEtNKUg5B67hWaugJ?=
 =?us-ascii?Q?KB7D/9W5Jt4XUJuJ3nzvKcIBhtWq5LoRC8BxQu6NcQA4v1041pzUyBs/O0/Q?=
 =?us-ascii?Q?5SH2IGZznMru4ykyl3rTPtLeSW/HvItvyyvxYgyYgQvm/UOM4HDgNAtMmjDK?=
 =?us-ascii?Q?VxYcQHoKVi0OjqiwBiLy9c0vwyzezYrzNjPPfNbq4e/odxZkbgtd5uDwK2my?=
 =?us-ascii?Q?r5+L9CshfOKvn0bFUHnGTPkZLoogBuOqiuIhPep4Ru5krJkAe1YI1NGUDRns?=
 =?us-ascii?Q?uOvB99ItahZPKUCVDsyowbRir80rN0ZhKmB5MisPdV0SySy/6jW9rLV/5S2q?=
 =?us-ascii?Q?zSvBSeFzlXWiGoBiuEKS/2pUI7evNKLgbrnZubnoemfZa+m9szN/kKyTpyNc?=
 =?us-ascii?Q?yYWACUkNKiS+2sKc5DIt3H6JZlBdDMr/EY79LUgu+V4vvzXUP7YQT8SsLknL?=
 =?us-ascii?Q?+xWaKGptX4nLqO/JSBoYbuy2bwmd1CeQ1ntSxF9+XqGBFwyJoYy/vQ/NbCQa?=
 =?us-ascii?Q?CBiNDUt03YyHpRP7zj9wPf7WNO2QOKHPjSdipNwstw2JffeEV+NxwXKdn0VG?=
 =?us-ascii?Q?sjuaZaP/o4AeuPa9L6o7jN98V0AjUNuP1uroCEIUOlW0GjTMYxZK/0Lzq0j6?=
 =?us-ascii?Q?jO0dymKFdZZmj0/cUJ6zxlkkOSc+KKGyLjSHd2vv72pXN80MqEvdWWIc5oAW?=
 =?us-ascii?Q?j4C8bA0dOQSsuye0fGTql1JcweC7e54nvOzNkKJs4MpmS0TaLei3jAHG7dF1?=
 =?us-ascii?Q?3NoEsFBZcKUvg+E/Nc3gXPXTUpnyL6lJ5Gp52fnH8RW73DaxuwTi6LBG7CAW?=
 =?us-ascii?Q?dN+RbkXuuXTiheOe3mPooMGNbXfreOihwuDg81HSaJb9oiA6O0gfIHzTODRI?=
 =?us-ascii?Q?Uq4zPg73qt1MjlRBU7fk8J3Tm37919wrEEe6RyjDDgpZPiLmz5iwb/68O318?=
 =?us-ascii?Q?0BlSJ7PiVSv4iC0rWKgCXnY2rcVAN4VtugAPgh1xrVgf61QvlexwwxUHkBtJ?=
 =?us-ascii?Q?uGl/ArZawMrx5TNHYrrqGQqDo8xyMn7FwFeOY0lWpn01297KXXnmHPOGPUtV?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lrxoOcudu3BtpmjLeTItMnVfbpJgx70P/E2PT0PniBXs5N0VxXSTLyST5Zgsxg+vmPLciYvcuw08Xeh+KvO2lREmASKYZRnGSqb/zNhYCBdW/rRJOrhWhuq3o3zAFe15awa18zo2Zppq6TiizaSdlNAN9qDRRHCIxGP6hct1hEfGHjcBt0kxwVYIgbHoSmOM4W7cyasLdqrpspZJ/aqMoUNCKnvvMsZNhB/AEtomxFUMx5vzv91xgqB/QKq0Y5IpaH5n/NioX/kiGgKKGp2O/gXa0R8wf/GPIE88vL/3xP2E0G21mJ4fAY1ZTPz/iB9Bi5jeRSW+eyGqwQdbALU1hN+aSFEg8+iCo5uqHqjzGs4QHOW8celQo7M3xfY1NFJjNabVDd/7xUzIkBmU73mmcuwpiURER1wIFcJhJwZ7du0eZn6hy16DRWFmbH8CG0l0lAk3diSmyi6wMh4nH52Hl2jykLpR4Fn4B0ArDmErj9EM6WgrjDqvWsHtOKyvlqA5PYP+tab9bY8Tw8KMqkAf3dtuJFx3xBcokK9E2fAoZpXLr0wp654Zj3oIGXFdTzSbivCVDGUq5djXP0+ZXLz28v7gd+hzIcKXbiCPiR2PxPM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a44e6e4-2e65-46c1-b627-08dc36f1816d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 17:36:47.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4SmK3ZXy7Oq0aPySvufqv6TU2EV6ayd41h2qd9RZZ+TNKlT8qRovi0xUTH5aL1gv0XvGcxFNaonMszS20XlLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260134
X-Proofpoint-ORIG-GUID: M2Cwweb-YkKeXbNmzoNqo3abNzgu_Cr3
X-Proofpoint-GUID: M2Cwweb-YkKeXbNmzoNqo3abNzgu_Cr3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_093712_602997_E3B662FD 
X-CRM114-Status: GOOD (  25.23  )
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

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

Extend statx system call to return additional info for atomic write support
support for a file.

Helper function generic_fill_statx_atomic_writes() can be used by FSes to
fill in the relevant statx fields. For now atomic_write_segments_max will
always be 1, otherwise some rules would need to be imposed on iovec length
and alignment, which we don't want now.

Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
jpg: relocate bdev support to another patch
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/stat.c                 | 34 ++++++++++++++++++++++++++++++++++
 include/linux/fs.h        |  3 +++
 include/linux/stat.h      |  3 +++
 include/uapi/linux/stat.h |  9 ++++++++-
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index 77cdc69eb422..83aaa555711d 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -89,6 +89,37 @@ void generic_fill_statx_attr(struct inode *inode, struct kstat *stat)
 }
 EXPORT_SYMBOL(generic_fill_statx_attr);
 
+/**
+ * generic_fill_statx_atomic_writes - Fill in atomic writes statx attributes
+ * @stat:	Where to fill in the attribute flags
+ * @unit_min:	Minimum supported atomic write length in bytes
+ * @unit_max:	Maximum supported atomic write length in bytes
+ *
+ * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
+ * atomic write unit_min and unit_max values.
+ */
+void generic_fill_statx_atomic_writes(struct kstat *stat,
+				      unsigned int unit_min,
+				      unsigned int unit_max)
+{
+	/* Confirm that the request type is known */
+	stat->result_mask |= STATX_WRITE_ATOMIC;
+
+	/* Confirm that the file attribute type is known */
+	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
+
+	if (unit_min) {
+		stat->atomic_write_unit_min = unit_min;
+		stat->atomic_write_unit_max = unit_max;
+		/* Initially only allow 1x segment */
+		stat->atomic_write_segments_max = 1;
+
+		/* Confirm atomic writes are actually supported */
+		stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
+	}
+}
+EXPORT_SYMBOL_GPL(generic_fill_statx_atomic_writes);
+
 /**
  * vfs_getattr_nosec - getattr without security checks
  * @path: file to get attributes from
@@ -658,6 +689,9 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_mnt_id = stat->mnt_id;
 	tmp.stx_dio_mem_align = stat->dio_mem_align;
 	tmp.stx_dio_offset_align = stat->dio_offset_align;
+	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
+	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
+	tmp.stx_atomic_write_segments_max = stat->atomic_write_segments_max;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 95946a706f23..506c9230333f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3170,6 +3170,9 @@ extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
 void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
+void generic_fill_statx_atomic_writes(struct kstat *stat,
+				      unsigned int unit_min,
+				      unsigned int unit_max);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
 void __inode_add_bytes(struct inode *inode, loff_t bytes);
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 52150570d37a..2c5e2b8c6559 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -53,6 +53,9 @@ struct kstat {
 	u32		dio_mem_align;
 	u32		dio_offset_align;
 	u64		change_cookie;
+	u32		atomic_write_unit_min;
+	u32		atomic_write_unit_max;
+	u32		atomic_write_segments_max;
 };
 
 /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 2f2ee82d5517..e94418777172 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -127,7 +127,12 @@ struct statx {
 	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
 	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
 	/* 0xa0 */
-	__u64	__spare3[12];	/* Spare space for future expansion */
+	__u32	stx_atomic_write_unit_min; /* Min atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max; /* Max atomic write unit in bytes */
+	__u32   stx_atomic_write_segments_max; /* Max atomic write segment count */
+	__u32   __spare1;
+	/* 0xb0 */
+	__u64	__spare3[10];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -155,6 +160,7 @@ struct statx {
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
+#define STATX_WRITE_ATOMIC	0x00008000U	/* Want/got atomic_write_* fields */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -190,6 +196,7 @@ struct statx {
 #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
+#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.31.1


