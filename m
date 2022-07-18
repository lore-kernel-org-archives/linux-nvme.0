Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294E9C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 13:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+pV8Xx9jR29eUncemAUK2DjRC9eqOObkCY56dgrRhdI=; b=huLcEwV7IAKt+72JlqhkZLC4gs
	Dv7NTjJHuovPlzGghVTi0IMu1ROvwvbs+F/1MWze4oIT1eCsjPzV1aU5YROzRBzhrFnZiNSeCmXMN
	fmFvM+3fTltHOpZXK5aad5yT4Nn1KQ1nmFNoTSuxIuaQMlhNxUFbe40mnbcdtSyHx3dCRHHRmgKmR
	qjU90QTpL8mmGEBYzGpImZ9B0BO1XW1kLoemoDZNG2udumGgH7di+JDTh5LdfTRR3gnG3ftyYUJ6J
	KNqivyN4d8Thk+tcFY0o+FhwEDZNBBwIBgRg/qiSTNM4UOMRhhnb24VXsjA75vUM7uEkfWqKxBm+0
	opmOlIMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDQaD-00DdcX-Aw; Mon, 18 Jul 2022 13:14:45 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDQaB-00DdaQ-FN
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 13:14:44 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB4L9M018815;
	Mon, 18 Jul 2022 13:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=+pV8Xx9jR29eUncemAUK2DjRC9eqOObkCY56dgrRhdI=;
 b=Z1VuWYP3lpvNAd2a68B+O6yPvMYGtQhUI8+/w8TEYu59JOCs6PCXlura9w/Ydg8nnLob
 cUS2+2r4bICLHEKGxCAa1IlAqajiuKEX2OVJ1tuT0vtCfzAIbh9QT1MggTvWCV8FES36
 UQoffkYr2+c5Q++whtDBMh/pAcUNnbAa2fyglIaMjh7o94cueSuyGU9nU792d90Bx6Yz
 UPwWbYmxc3K6qaq6+brdk0ZmB+jxPO+i1BP/nYvcRSly94coEAzLKKye/iLBWOsfQE+/
 CuJt5meVUIBhIZGoGVW2hVqWILYsA+PpJ+RArDWvnflAjlg2bFH7bNDsOdUp3dcvu4Ie MQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a370f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Jul 2022 13:14:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26ICMXJ5007954;
	Mon, 18 Jul 2022 13:14:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ekk5vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Jul 2022 13:14:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbMN2oNaIaWN4eAUEqUaOQAicZdxKkWbsgrIe0MF9GwDcGt2l/mGvRfz0GW5xtx0KyJBu5v9Wb1KSKrxLh+79ScuoJ+EkOIdhH4eNf4jyVVD3pZmZ87e6DRDIXRbEn28mEACQguRZIWKou28GS11sXQ73cNaBUiMejbYF0N6oc6yZ2MyMSYINB868K2Rzgq5t4kwy+wf5q1UlGMEXSWauiOnNT7dMmbAiQBteZUSjogZ941q656Sw8Ip9EAiZOZgfaajGVA0V8bQobbbHtuCgcCqH2Wj84Q8FHr63weFRaL7u7uHsEnOy/p26MsZWHtgLaIw7fyrEIZiBI2a39HhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pV8Xx9jR29eUncemAUK2DjRC9eqOObkCY56dgrRhdI=;
 b=YQ6yKko2F7SkyuFwHESN9yHFY7ke765DB+he/dTalFvfR95PaJxK4vYwl/H1Jq/iekv+ZWV2so/GRLlU7j1586Ql3SthAAw8gyetA90danoKfQN9wnEyW6KpC6HjAfoPVEVFd9Rn3mWYXehN16m4foW/ldQpdJ84cgzqeBtX/yTNMA8OzrTEeoi9+lZ2TxK5o/ONJPJBLSBczymSa9bUwGIqJP9lyWrDnTss5D24JqB/8+WCkszRnCJdU/+TcvCRCCw9O4iQY5cVQ3P8KQR7u5+mtPYhFPPlxD2fXKqvVDKrs6MyrnjrJLyzTylL9UMzF7imzL3EP7FWhxIsIyTfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pV8Xx9jR29eUncemAUK2DjRC9eqOObkCY56dgrRhdI=;
 b=GJVvdpMqRfD21RDVp8DjnOvPPf8eTOSxUDYqoZkKs7AhbT190qfSfo0jDxbsGLHjv4Pxga5mLjyO3UaycbS1Zjx5ErHfDrfREuPkONhjFjeUdYiLQ/89UKxzXv+KOZ1w4PEsuPcuP/vy/hZ4Sec8HTBJ9mYvEsXNRzwODAXDd8s=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3196.namprd10.prod.outlook.com
 (2603:10b6:5:1a5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Mon, 18 Jul
 2022 13:14:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 13:14:38 +0000
Date: Mon, 18 Jul 2022 16:14:30 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: hare@suse.de
Cc: linux-nvme@lists.infradead.org
Subject: [bug report] nvmet: implement basic In-Band Authentication
Message-ID: <YtVctvOUthLBZeir@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZRAP278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c823dc31-1f47-41c6-688c-08da68bf77ee
X-MS-TrafficTypeDiagnostic: DM6PR10MB3196:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	iDgpHm15IUJd2i5rsXX3nrKnCzEFf7D28dvtZ25UjMcJ6wlu+VqRKVa5+acEZB0MyRp4NTK14Y9+Ogm2di5NoWB2RUfD3wwteo54qm/wUrvsqwGsa9OoH65Xy1VPxatNfz1zU3kPtZ51IKH6UxRhSNcAYRnb51yU3OP/AJTmn7QYVPciNAe+Ij95PImb+oNn0MsDtjBgXvWLmuLXyhf39v2h/5rE8v6U4zcqk8dg9Q7NqJNChBXeS2qXKmw4RBcsVYQLiVtKuOY++jSqrSBrfkQRwMH7iS1OtDgnX714Zxqpgl7nLfEueTFrwt6Xn55Ve7RjTFiLFRvoOSBz5aZTHFNMjyatKV+Bg9FB2EpA+T22DSiB2SoXuXsqG3t0fAKswDYquh9+2bcmO9JFlWPLm1UMOyBo9LQi7cvVNVEGA4BTAE9M+Fxw3UmyCYTkZP+8aEQOscu4xDcpG+H/bIjuuWDRhkoEeNi2HsRusaGLPIcNpqiYkTTwB+hzf9T0e4FYmL1d9zLrMHo0NIEVwCCXDpb3vosNukR4ZaszF0CC9m3cdQtUIdil33neElxfqhwiiqK+S2EKUXgRgA3dmyxhHR8r5w1ok7NM+8EnBdzTNtJ1HC5idWlMub+iVsuqB7vYw1vPZlvsoE5fGMlYT1LRSILZMkhMSP1yrw0VnY49x8OHVT4K2zOf8OCBsUXLzb+a6zrpvE5KFTCxxd0VAbGa+4CCJ2qK4wY71z/KcBKLjAjrO6yAHGY1cINiexDbBArXSiLKHaFGAwXsBkiGRJKVZZGQjqCVtq4OLMbJ3o8KOd6fjBB5H6d4VjSzW8lczIem
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(376002)(346002)(39860400002)(136003)(33716001)(8676002)(8936002)(2906002)(66946007)(66476007)(66556008)(6506007)(83380400001)(5660300002)(4326008)(6666004)(41300700001)(44832011)(6486002)(26005)(6512007)(9686003)(86362001)(478600001)(6916009)(38350700002)(316002)(38100700002)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?xfDZ1sVSoJe/f2D373UeJpDfvuVgEcmLq22rRLz3iWKV9qC9EDSasjiYisf8?=
 =?us-ascii?Q?AMT6g6F6pLRWL3w1Kjf4I+mjAaagM2EmaJo2Bvr1cAX2/UJOVsXAeeM3AC7C?=
 =?us-ascii?Q?uMs+iN2NuvdV8WdyDMKZVaBUTnrSt07Ag1rM06q5ueycnBgFkXo7Idorln/m?=
 =?us-ascii?Q?3iKCTrpK21Crtl8Uu8O8Y2kaQL0HYvxwrIb5fIONkYcTAPG+xhPhXY0i9j3X?=
 =?us-ascii?Q?4orFbB2LHN5Mh82S6gwaZLj7j7a+Lh7jWNM/lS0RlkDrN7CkmVCPHRgaNVjU?=
 =?us-ascii?Q?NAA0MTHCkFl6AfO2QAqp6R5XB7RZYeYtgWJcZuyty81xQm2r4+Rcp//LdLt9?=
 =?us-ascii?Q?0oZD1ZI+q1RQY3iUPtV8z/oQZG365LxLCbeuTPs0at08Rp0O50idD7+7ju0F?=
 =?us-ascii?Q?Xb3jO4IuHUbHL0gzs0B0HdUpA+eahGxIRPhT9nmiXRCeINmpu7mrzNI8DAwB?=
 =?us-ascii?Q?fLNdhWYnIXRPoTVvdUtMmb/MSPxa+A0uVzYJeOJ+SPGXuU7lKzUD+B4J/JPi?=
 =?us-ascii?Q?/B5Dczlmn2RUtnEVQ2mrxkNVV8eRzGwgUo6i679SqYzSrZR/e6aOXEa3QRMo?=
 =?us-ascii?Q?gDyP81AjftwqC3XzpIMvb9lgX/aJC4wG2x66rP2JC5ZdC15zBmTx+Xq0B/GX?=
 =?us-ascii?Q?vwaZwR0QHJL6KQmGPUgUAhbHSKFrMkORGZxOUOUUTUfUNh2YyauvOR5npUEw?=
 =?us-ascii?Q?CQuG7+sZPdH8VQwNggFfm6pmqMBGfU3E8pdmOK6fo7PC639kImfIm0z3q7CC?=
 =?us-ascii?Q?FKG+vunB+u6kJeLKDE6P0hTvwpwi+0Q1HwrZ4ixL0GJxnJQyIsXLtZ33XgfL?=
 =?us-ascii?Q?eO1gNqp5TW+9mAWimGD4vqqV2XRfF3uv2C0KQn0zTRNyDWAjR1LEX5bv11uL?=
 =?us-ascii?Q?UvoqMXDll30d5n2d/a7bUbTlG5Ypewx8thWAwXPPL77haBQKRTitroVAZNWb?=
 =?us-ascii?Q?Ky0oxpzJZgEFIogq1I/nRB5ooqUXks7J92ZWj7Fwf1x2Vfmy3apNca8uA/+w?=
 =?us-ascii?Q?XijCRgigVjWdxFf+8ikolrsUf9eNsVEfCkoz/ax+EXNYf2AkjeCBK8tTNozA?=
 =?us-ascii?Q?xd5y2QVL+ViEfMaE53unH0Jbm/4f8HBiXtqE64oSKW7WLvSjfR0FPNy+O5dc?=
 =?us-ascii?Q?9Pss8GQaLx4BB9C7XqiSiVk+JLhdKcbxOkfm/nexaRfk8m9lhu/MRQElL9ME?=
 =?us-ascii?Q?UDlSHtWYxilXjtmklIknZPatVAu36ENdLTfVnSwGXYAu/FAxrP4GOgQfj27u?=
 =?us-ascii?Q?oiK361LK2n+TcTrkbsPuDpgQOd0VbJTxuLmB6pG2gbqvUUrho3Uf8m7Y45S0?=
 =?us-ascii?Q?8T7yGpMXaqUIuZD2zlf9p1ZvVxt07B44/yEP6XEUm0tIrotWq1a32P2udEJB?=
 =?us-ascii?Q?A1jTmR5t1W4Hr4zXiO5LGlGOnuhM6Fv3Ue0VI97LcKH0eDfC7B7i4t9O30+K?=
 =?us-ascii?Q?GGckE0RXuE9Uqr6olPT9IeT6X+++obZp/nCjOjahq76Q/HjMCSW3jneXce7v?=
 =?us-ascii?Q?6GQtAEaHxWR8RVqVO6+M/6v+BqcjPpabSnOwfkXWXv5klC8IMMKOeqjbxTI9?=
 =?us-ascii?Q?3l2mie/t5AmheQeBBG/4X+ZSDTbiU09veE8JZaKRzqYDZIechl7WVRKP8NEq?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c823dc31-1f47-41c6-688c-08da68bf77ee
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 13:14:38.7907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VBuj/VzxOYik9uDBzA4a2ONPKog1O0CMFbNMxT1wmimsJmU0SykMcTq1YvcuN7eiGm8Ox3TG88xmtf6c5ZWjSMpBWywlZAO6m61XAoHQRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_12,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180058
X-Proofpoint-ORIG-GUID: fSudPzSTsqfk79kD_tjIHQR3J5VF06LK
X-Proofpoint-GUID: fSudPzSTsqfk79kD_tjIHQR3J5VF06LK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_061443_542480_1F98DF88 
X-CRM114-Status: GOOD (  11.04  )
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

Hello Hannes Reinecke,

The patch b281bec75946: "nvmet: implement basic In-Band
Authentication" from Jun 27, 2022, leads to the following Smatch
static checker warning:

    drivers/nvme/target/fabrics-cmd-auth.c:251 nvmet_execute_auth_send()
    warn: impossible condition '(status < 0) => (0-u16max < 0)'

    drivers/nvme/target/fabrics-cmd-auth.c:488 nvmet_execute_auth_receive()
    warn: impossible condition '(status < 0) => (0-u16max < 0)'

drivers/nvme/target/fabrics-cmd-auth.c
    187 void nvmet_execute_auth_send(struct nvmet_req *req)
    188 {
    189         struct nvmet_ctrl *ctrl = req->sq->ctrl;
    190         struct nvmf_auth_dhchap_success2_data *data;
    191         void *d;
    192         u32 tl;
    193         u16 status = 0;
    194 
    195         if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
    196                 status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
    197                 req->error_loc =
    198                         offsetof(struct nvmf_auth_send_command, secp);
    199                 goto done;
    200         }
    201         if (req->cmd->auth_send.spsp0 != 0x01) {
    202                 status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
    203                 req->error_loc =
    204                         offsetof(struct nvmf_auth_send_command, spsp0);
    205                 goto done;
    206         }
    207         if (req->cmd->auth_send.spsp1 != 0x01) {
    208                 status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
    209                 req->error_loc =
    210                         offsetof(struct nvmf_auth_send_command, spsp1);
    211                 goto done;
    212         }
    213         tl = le32_to_cpu(req->cmd->auth_send.tl);
    214         if (!tl) {
    215                 status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
    216                 req->error_loc =
    217                         offsetof(struct nvmf_auth_send_command, tl);
    218                 goto done;
    219         }
    220         if (!nvmet_check_transfer_len(req, tl)) {
    221                 pr_debug("%s: transfer length mismatch (%u)\n", __func__, tl);
    222                 return;
    223         }
    224 
    225         d = kmalloc(tl, GFP_KERNEL);
    226         if (!d) {
    227                 status = NVME_SC_INTERNAL;
    228                 goto done;
    229         }
    230 
    231         status = nvmet_copy_from_sgl(req, 0, d, tl);
    232         if (status) {
    233                 kfree(d);
    234                 goto done;
    235         }
    236 
    237         data = d;
    238         pr_debug("%s: ctrl %d qid %d type %d id %d step %x\n", __func__,
    239                  ctrl->cntlid, req->sq->qid, data->auth_type, data->auth_id,
    240                  req->sq->dhchap_step);
    241         if (data->auth_type != NVME_AUTH_COMMON_MESSAGES &&
    242             data->auth_type != NVME_AUTH_DHCHAP_MESSAGES)
    243                 goto done_failure1;
    244         if (data->auth_type == NVME_AUTH_COMMON_MESSAGES) {
    245                 if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
    246                         /* Restart negotiation */
    247                         pr_debug("%s: ctrl %d qid %d reset negotiation\n", __func__,
    248                                  ctrl->cntlid, req->sq->qid);
    249                         if (!req->sq->qid) {
    250                                 status = nvmet_setup_auth(ctrl);
--> 251                                 if (status < 0) {

"status" is a u16 so it can't be negative.

    252                                         pr_err("ctrl %d qid 0 failed to setup"
    253                                                "re-authentication",
    254                                                ctrl->cntlid);
    255                                         goto done_failure1;

regards,
dan carpenter

