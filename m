Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C77EC47DDF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 11:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1YTAJOF+4ePPmPXuGvY0i0t3F3h+6l3GyGG7ssfOAMk=; b=xWIAwhi97vLbSpJMtxLAUjKmJh
	x4S814ZIc7hnvxhErorQju9+o8LiLcEX/fp1n1h1t/Q7ZErRB+/9tGRA3iliqCaj0fb4kahhQ073e
	symTJYIh9C2KvncnwPAQhf7PqM+1dloBsBQe0/7DycWBcn2LDPeWZOQFYkJtanfgEJohKnh2ctbjD
	3p1Xzm42s0dNZTrzGKjxzg5WidAVYSTF5m4czpTn3TX0n+bCTkXGrAikdyW78MPrjrVAnLzTb9UYQ
	dLICa4Z9tsYF9tco5g/TgUxX873T5rO5sFKBNfRUE6WAr85GJMnSzfiZiGgNQt33sCfHWtox1joak
	aoQwcq1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSbbY-002pKk-0I;
	Wed, 24 Jan 2024 11:39:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSbbU-002pI4-18
	for linux-nvme@bombadil.infradead.org;
	Wed, 24 Jan 2024 11:39:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=1YTAJOF+4ePPmPXuGvY0i0t3F3h+6l3GyGG7ssfOAMk=; b=PjS2T4kdanQnYxHpkh9v6iVmow
	38x8PTWfptS6vNlYjJSRUs8GJ6GlrFxzBXX+hDu+8V5yOsshemgk5FfFOvheNNbHcq9QOfrdMmgju
	1Hzkp55HOLzmuVUR7HqI4MEKcAvTKcPvOO3gUaUXwudmyQ22R/SRq9dnj87vTERlgN/QDucj7fp6U
	eElgtmPlw0XHlGbBn9J4dITl3jQU/TIglPlJ2ZOXDVQdovHkEkiYHnegox01tqlUeKc6vez+gMpoL
	5M5ME0+8KO3lCAVqMouqXfkZSEfP3nXLY9CUsxFI7vJdTAXqHV+2JwUpT1Dln3Y3HfqLU9K+E3kQr
	+cs0JPaw==;
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSbbQ-00000004RN3-3dPA
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 11:39:35 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAwjmf002360;
	Wed, 24 Jan 2024 11:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=1YTAJOF+4ePPmPXuGvY0i0t3F3h+6l3GyGG7ssfOAMk=;
 b=OfRuYyAvPbPIpYGe6+WDWnWmKCo41zmpd00y9IrUrvatj2bU2NI+K31Rhikpc378F4p4
 tmfnGEm862B6/eVpFhAp1asmkz6+bjwCGSHbFa4rvtZ6id1G0s6MHGFzVTpN2lgT3vzs
 yCME/4dHOvzygaxeqh5GOzLBl+Bcd1cPLoaBjAOlKQKU6un7QJGwqoKWS2lPNFOklcnM
 vIPcoCMkHjI7xM+lPCMIG0/IXE8LuFwMU8ypO2G/ZvMhwkxzhvgE7UeJJoV5Wh5eoe4C
 a6iFARwvKeRrLtuIHPi95HexFJoUWi3ogrx1cidNEnXMRxDpXMNQJfQSAG/XubSg7gwa Ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7n82386-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBZPMe015042;
	Wed, 24 Jan 2024 11:39:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs33un2su-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BImEE+KydubLouKDHY5lgTl9DNAoSZv5rbPWN1cZZ/HPpNkdPRLZVBzEzhCtJAkz8D8Cdv0gIp/WJvXvHQJiOyZVxvTztr5T+7WRPultbYKAMskytZIDUytWhlmpYE//A5phMXa0WHASaWgxJ1p9zLg3rRvYaK0mp/RVsyxnrPjlPqvVcmCa1gi4ov94BrERlfGzlxRMVssJuU2+mdWXKJaEsWeQZeHkRuOwPuyx53nfK33eJ9HEr5PgiqR/C9wUFxLJw/xTgMDSwL5PMf9S19mBUtF9DyeTRdHXj213nbQXpJVUsmRKokJwcO6brnc7MyFEoqOMQtpNJhd0GSMKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YTAJOF+4ePPmPXuGvY0i0t3F3h+6l3GyGG7ssfOAMk=;
 b=bFKG6ZkDyeRF9tI5RO2O+wlvhxAThzlcT5Ej5F7PVRODK9tnTyfbsEiz2w9EL4w5HCYBwSMDxtnXZRqBiAMcxflIgZmykC5I5CNziSb8RZg9fwacxUUKYz872LLI3wrD1H7ny/oqMK831khvPEfVK9KM340g0qtUuyXz6Vb6hXBcHuaUnAOZzsoyvY/jg6h/D1XmfY74zLRQ5ixoV9Tk8IiF5DEXJYpz0j/DcNWDxLU8WD36lkxmtmZ1OAhoo+bpwxM5Vl6dbGYGJaGi0j2LYDexLDSEJDIpCBydBnjvIqyVT0ryOGH/Z6774+fdUBZvPM/AP5uDSXE3SBNHf8tRvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YTAJOF+4ePPmPXuGvY0i0t3F3h+6l3GyGG7ssfOAMk=;
 b=ksWdp57P1mIQFvEcc1ko2L+WCvfW93ZFjQj/XJbGb6pStIlAX/b5RPgC/JjOyifeYTVKZIR/3IsdIX5L7+cUSOZLgcVN2XOAfqwUs4hzbbmCjw0+GEexx0tOscVY43YH+rMLyFOD7IsRw3UdBpuujvxq/9tFoE6+OtRHWQ8exDk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:17 +0000
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
Subject: [PATCH v3 08/15] block: Error an attempt to split an atomic write bio
Date: Wed, 24 Jan 2024 11:38:34 +0000
Message-Id: <20240124113841.31824-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:208:32f::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 8414207c-901f-451a-e7eb-08dc1cd118f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i82BXslXlNYB8IZXRp4Oa+Cvot8bCEvNOmBFuema4M9FNcoWpCK+kV+J/kt9k0vcmbOc5B5YncBSh08K7IrAb4e4/pfX+lz6dIYvt2u4SaTjQJYDdzQ9Zp2Tdzhi5Y/cBuStMgYKHTn3bJ5fij1B7eKsvG8rES7IAHzj2PDviMMGwWT+lte09gr/DSL5bmPcmGBDusq3hI76httjADWaQVGTVgmPG1RVUNEUc3a4UgwIpVR8na9Y7YHOmtQhMJz39F5miDZ4pS899n1NNZvrVnocZ/Mk2hMKqQCVnSR25/EMQmuILrBvpW3AFwIHf8BUkdIeVTztQmRax14qXQREsCXCqcCPBWoIWpFdt2GXcv0a//wobLwBHlgliEGcXaNK/TZfyaHuxVFnsqpfGD6zOF1chb+DmtDSjrY4Gma244+tlFpU8tpzAgxXWGyuggsv0Ncj0fqmyqrIuZXe3qPtvglCsJOxgacCWZ5AVn+38HZVjKLj1poeWKQS2F0/ohIds8Fci+JClElFM4l16vKg/NDODiuo+fhmtnj44XeWwVAIzmHmLA4Bh/RaMDzJg3yy0na8d2WwABDqyY/5C76cSnbT2ECgDsM0RJEFPl77tTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8676002)(8936002)(66946007)(66556008)(316002)(66476007)(921011)(4744005)(2906002)(103116003)(36756003)(5660300002)(41300700001)(86362001)(7416002)(38100700002)(6506007)(6512007)(6666004)(83380400001)(26005)(478600001)(6486002)(2616005)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5qvsSSThlztApITZWYnJgMil99a5DVdi38OXVbxEljg4GBFaz0OVeirdx5h/?=
 =?us-ascii?Q?oFzwDzQWVnaTlOrWoJ0/9IfENzNksYa/sGiMsdeRgalyH6eUUnJ//6Qln4Sg?=
 =?us-ascii?Q?AthuCwS213BdIHPDaSRju+/2IgGGeJs9aHJq5sOV7YzFCA3lkbVOhTsMqVD5?=
 =?us-ascii?Q?QybeR33caHAKS6yf2IU3jEcu5cx/h4yEPxQWXrxpExkQFLlYmTl9F4g/7LLk?=
 =?us-ascii?Q?+wOBIiH2tfMaLTpfnnRO19ADPinGXaHjnNuQxKmf/9z6aWrZdq664rVFY414?=
 =?us-ascii?Q?wIl7BYdaAL8luJH5ICsAihm08DqBkISLdZWi+d+xIMDK7RVr9RaQ8DVob+nH?=
 =?us-ascii?Q?PsTU7d3qxWej1vQgSZIlFn7vq4IYzS25+UiBmwYfkoV3RcSoAosABfRu0DmY?=
 =?us-ascii?Q?Jx+zxlpfkWaq+BylNTuKaVVpck+pCZpSjz9pMohG8vwND1kc4Hki9PqPp4Ws?=
 =?us-ascii?Q?SJxDbrmJPnD+B7qS8qMaMDCpbVsgqAIc+DFSKbjDeocyGqQbl/GZGKlkXAt4?=
 =?us-ascii?Q?/4NhpFeRuHhN3oFEappGHJQy4z0oVRF3e7T4TScXFrA27690MSW97u7150vX?=
 =?us-ascii?Q?XbLlW6oGtt8YnjPkOE3adOuTNSuBmRcQOYp7rNO8p/NLbOjef4wr7/D8MpEK?=
 =?us-ascii?Q?o4xIPz1M9hJqlH/LlHJ9je04SwB9/HvvLIQGXyGwH9j7n6dSwZt5sSsmXvvj?=
 =?us-ascii?Q?hod6LAyhx7GutwZUzqXzOhzcn6fIRYjN3nuGvQ/6GutBpp4DE1TKboapKu/Z?=
 =?us-ascii?Q?QZ2wo/8DnTTk9Hpur9/ErkgltMjYxbDbDIehrb/E9mvCdyEv5Ffek9BgoR22?=
 =?us-ascii?Q?eUDMWFSG5m1WqBZrqTHzNOydNXRIaHQQyKKbDtYE9+swfMPk2bgAgHGZAMOv?=
 =?us-ascii?Q?useJbIO/+mZcnYYXA9y5BM8rsCRyMta1mpJO7eUeegbYVaYI6Qc6WRGWvYYO?=
 =?us-ascii?Q?Pg6gg5xcMCi/GHLX0ibVHFYD3qRqas7tGY38gGb9x9t07S8q6jPpFrFi52hT?=
 =?us-ascii?Q?A+ycTq3aLZ99G/wR0Kn59coyX3jY1KBy3Vw8wLEI9H7h/QbojYDuNAvzQlFA?=
 =?us-ascii?Q?bAhXgYp+xpXxFwBgCViut3Luyg5tS3OWjKl2y8qYPcYcekXG1DDG+50/s8E1?=
 =?us-ascii?Q?2hJ9B/EwmOiETGyLPjHVttNn7Gzsl/NThoSs9dMiuWgBTck9e4wku9H/aKFS?=
 =?us-ascii?Q?c/9JBgUx97yTESqgki+rYxefVixFqr5XP8qADFHmhDheywZ/wcaZAwY77AtP?=
 =?us-ascii?Q?fQ2yQG+dSA0X5Sx5Ny/SfKwCSSglRfYQHmiE7EIx3+RR5Zk3DX7fIHWmdAZV?=
 =?us-ascii?Q?9o1naeSoKFvfQH4rPyWEqk7JvGXW8noMF39dRgs8kN8skUbI32wwotFy647D?=
 =?us-ascii?Q?3YqkhT52PjChYazG3QhVJZuzEtWzsL11LmT5x8idk57AdU4mObCerkEu8CZw?=
 =?us-ascii?Q?xM7yGjNLIJwYp1rlCcdaaiIYzQDBPjWYNjcqgNDeGSdtkycpjOIVVfvpTLmR?=
 =?us-ascii?Q?kLQMYaknoqcqCFPBdBfoBsa114j12myV++s0ObjeIISt+ujbObPaN708jh5z?=
 =?us-ascii?Q?fNKMBohniU2ROA2kceFCj2MDz/e+mwP1fJf4R6wHP2D6t9LIqdQcZFX0oI0d?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /jOK+InweULA/4vuxnQNvdV2N94y25kcMUboyXtwhNpKx3x/+UAvKzvzXa3wi7Gs5ExgUT97ZHsPZs/s2LmXq9UmswFqSoGAyjWB6Mha2aSCv79mmqemRIii0oeAcj683mVVcPznxYNuZZqEfnQgxR8mfA1j8ZaovNgeueRM6c7x5ffDFBSgJAaERGI6FxYLt1Y1PCcKj9KzpJEHdZfWHK5w1iIs0pcuSQjYti0t2MxtjhpWsVGN5uRcfOz84/hsRqAdS0baY5uVTj5vxSK06v+24gdiFNjxEHNObhq/16YZN7gAZ2EM4Eb24Ht6ZDQtDQd68Oqm/jqgD+Sk2zZJkzumT+/3jpnz9PxrZWfDFSuoX/ynSFubcQ2rCJXvaa2vu0PdJ+MIS4M24D4MaPAQ2GfXWQT3z8LlhHDkJtzUCqrHY8reFm+knkZnyefImBEHJOGBjOVTInN45hRBNwt352ols2CR8on6d1rd5kK2lMXwi56nHjwWPNsGhePxvo/pd6jjBHNiT8X6VUppnCqyKgno0NhU/JJtlgP9KQ7g4NeQjfAKxWs3lXfhVUAUs1HEYR0Qd7xMTaelBPCJR2t8WWLeqy5XP/9bAHdBJp38evc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8414207c-901f-451a-e7eb-08dc1cd118f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:17.3148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiBQnEcRjn/INR6HcM/fhualmkIzGF/UN11xglg9i8i23A2ut5xCP+OndrkQ8GYPRSa4IYiFNNZt2fZGLe4xlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401240083
X-Proofpoint-GUID: jY6U9HDvX8Vdjbo8dYcbm-Yo5BTOlyZ7
X-Proofpoint-ORIG-GUID: jY6U9HDvX8Vdjbo8dYcbm-Yo5BTOlyZ7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_113933_346403_D8D550CE 
X-CRM114-Status: GOOD (  18.35  )
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

As the name suggests, we should not be splitting these.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-merge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 6306a2c82354..9d714e8f76b3 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -314,6 +314,11 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 	*segs = nsegs;
 	return NULL;
 split:
+	if (bio->bi_opf & REQ_ATOMIC) {
+		bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+		return ERR_PTR(-EINVAL);
+	}
 	/*
 	 * We can't sanely support splitting for a REQ_NOWAIT bio. End it
 	 * with EAGAIN if splitting is required and return an error pointer.
-- 
2.31.1


