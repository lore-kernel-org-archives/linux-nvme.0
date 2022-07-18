Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E02C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wFrbxXwBB4zBgyn+WB+no3NE/1rNjdSMrZq6Lw2lI0o=; b=nCl7w7hfpJYtvvfqE15HduC+7u
	xkwaW1wNIsFiLyCRELgAvIp2aOQYI/OFGmqmqiGPGjB5JUfLrDg1ZeCc6V22VcD8kVNeG73qqLyzE
	7lWdfoMNUS1JU5tCeC9Cx9I0c4ERY0O59LDgO42n5KfhRo7ZGp9+I/6fVlNDoJORLF+Qj1pyfc6zC
	zxwm2AMa0K9FSuEetBa293xZQRnGLrZEyb2hOVZQHWY4xRkiIdXeYkVf51LiQBHzZYT1hZUllQFh0
	V3dswajvisE6sNjpa91BS7cTA212/uv0toCmvP9fOREGc1KdK7zMPoeYbVgwMcL3Us2UsZALuegCM
	wCRpbZTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDOdQ-00ChfL-Uk; Mon, 18 Jul 2022 11:09:57 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDOdN-00ChcJ-Oj
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 11:09:55 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB44Oq019928;
	Mon, 18 Jul 2022 11:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=wFrbxXwBB4zBgyn+WB+no3NE/1rNjdSMrZq6Lw2lI0o=;
 b=20jwU/zfcwWl2e8XdmXteF78nJOLne9/N5npvzXnFI75fvUO4jIXm9+7uefy6kQTcEmJ
 4a+Ou8Ms1NJcB17IQDrGz8IHqvTNIczo0kr6II03PuTVFjKkyHdDjCDbLN4mw9M6wg47
 FRfyHRpCbI5pegmWdqf3UDiXDQaGmBJE3RI9PVULrakVpp5DMUZvZvon3RFvvfVYwSkB
 2TbPWpR5cQsg3Hnq+kI/pLc1jXByaTyQbSzAAob6gtVSecTmTvg9XvC0PE6lSgMmu5CK
 X259EPmQvyEYVzr6BeCOJ/SmrQhef7U/K0P8beKHBGXF+o3eHIqiSiD1499GOZaVJvte 9w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtax5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Jul 2022 11:09:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26I8XtZY003989;
	Mon, 18 Jul 2022 11:09:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3qgdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Jul 2022 11:09:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8CLsMmPUCxlv1oocv7gk2u7AaJjfSTPhpW3RvxB8lIBchQ7UunlRf2GorCvryxXBwkB49xrxCZu2cMgJWFBtDzqrAoWbtQfNNXmC5ykURYtSGt5N2A5nguCNkevhBZR9tPRPD2h8vIymQQk5e59id4wva4GOSUkoYbkl4252wj7drogvISGyLXwFILQae/Gb75pWKoEHjVF6DP9DEu4eU8tb9IdJiwPPAnQS+qrn57qteCZLfqqVfE/J+FrfgWkdmy6zcKmG7+jqAzq92lt6vOnQo4a+bjnGl+HyyFuCwSdSkrgbtA7eXcZzCsyAISJeaytZWzxqJqEu6rGRd4MfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFrbxXwBB4zBgyn+WB+no3NE/1rNjdSMrZq6Lw2lI0o=;
 b=j41DLuVYHKcM1zBpFn4G3PkU4mGwG+nzEqFLbQDeHus7LWAdXbMQn7aY3Bbm+WXWXd7GMYeelEL5jyD26HFaILkS15T3F+PB0WoDNtOrTGcvP3IiKwcm2RAIqfxbUOsx8jWKLLwp9cyN0mgCfua+XWtxAfx5GYjaXXbvXEq/ha1BY5VVHH0mrGIYaRYvgB84neqYsMBq8a3G8c/WEtNplR+uq6j6gMKOD6Qo/ZqKlvnCXAsESdIk36T3T47D4P2waBu6eP7z/R3OM6LR6pGB85lsXQHLaLzQBHydB0jfZ+PwKUAJOCLjc7ZfAAYQFy2Fl5W2bl5lmXJ1sMymC7ATkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFrbxXwBB4zBgyn+WB+no3NE/1rNjdSMrZq6Lw2lI0o=;
 b=sVkEhj6Qo36xnyNDHB4XBINzrDAHzIImE+ervPqfJqoZr3tf+CnZwllTcDX3lKjicfx6jrMJQB8UT7Ad5HhBtVdEXSa+vG7zxEXL6j4s965RgcIp8mNhmiCTtyGQ3qM0ebWhxz3pEznkk3z3irQzuXN4unEGQnxxVILPmTIHBu4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4674.namprd10.prod.outlook.com
 (2603:10b6:303:9c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 11:09:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 11:09:43 +0000
Date: Mon, 18 Jul 2022 14:09:32 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme-auth: Fix off by one checks
Message-ID: <YtU/bFMYRCrx6tgp@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c27f8219-af0e-4c0a-0890-08da68ae043c
X-MS-TrafficTypeDiagnostic: CO1PR10MB4674:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	7iHScYAkbqOyWOuYkt+eJ56kIDdeMdYBSxgkTurox0HwMz37yRzDYFILNAjoDxujrfjlWUkkoXYXH0BWYMuX50o9mF3eNmRJwYgiXatngadf2E/dmRJHJWiZ/jbxfhpKCYCzVvsjVbbT53Dxg66OedIBp/0BTDI01E7WxV5SfaIx8uHUDaEeQvZoDd3ke5nzjfAh7i+HERw3v3IaPUBgDuRrCkO4+fFPIHkXLoUYe/aF4aylYbwC8nGwTA+33GTW+iVcrVIuLEGBk3MTcD9hBJ1nwUgpEn88oJbui4sL/WPSHK5RgreeA1HdIq/kM9CnDnDzMkb/lMjhPHQuLx5aJXwhH/nRCS8osYqTjMx/jDjNh3aWkSqVJ0cXafZ6Kba4Tsxwgo7QZwV8VNrE3KjH2OtmVFmKYizFjeQgJz5MsfL/7Zg0bwvYjM9So6MiSeiqgiai6fr9PCUe6v6SGimzJKb/em2ipcqtNvnHjl9Ab+IQx9cb7dWwa8a3UOum5YMGPknv9RZBeMiRCIeV8zYnYgy+vY59/ePGITVgavgnzEWCjzgzaeYIs9EoS5/aoR8iqf7I6Dibo1LtVnoYSuhlzbF4J29ZWt4m6rZuAVyNImwaAQ9oMEoCttZ7ZX4LUTy2eOT2UgXBipUPzvgEzKbUPhZ5hJ0PMthw5kcT4Yi17MR8PZe47HUosvmn+hM4OX9GJs5P/CqoREvSNneNVJiKH+8nANP/FYJ3GWtEUt5mNrXh0Q/OFpHRpW6xqS7Ykby3PeQu9cwNWya6hwIB7onTnyTLea93SC44Vk0aWy1v5AMGL2ilJTLKOK51nN1FzziW
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(136003)(366004)(346002)(376002)(39860400002)(41300700001)(6512007)(26005)(9686003)(38100700002)(6506007)(6666004)(2906002)(52116002)(38350700002)(186003)(83380400001)(33716001)(6916009)(316002)(5660300002)(66476007)(8936002)(478600001)(66556008)(86362001)(4326008)(8676002)(66946007)(6486002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?NJ6qrOLiVBXYpdyWnE1F6kBSHDOuzsQ7mA5BT7M3pakRmhLDBw2rbk5ztt+I?=
 =?us-ascii?Q?JiiwcDUUMQtzj1+84CQZqLR6ydSIN/tAeeCOYAXEEEOEup9fl2Z9PPmKKxy8?=
 =?us-ascii?Q?K4qVAL6WUN/Z5tnxA+K7UwKWdFwpBKekX4mUHcOuGSKOMmEU79vO6k6vY4gv?=
 =?us-ascii?Q?jZWJ70lm+Eqr0h8Vr6k4kE71CCrGL5FjKw91CQq65uYM06Wn+jroUXmnDK5T?=
 =?us-ascii?Q?eHYDa0lzyRzGRsRDgmHIc4xQwqxZvRj1pVsekibUdHPVe1nIqjImOUn1x5UA?=
 =?us-ascii?Q?a768SnMUmq1YTPk/Xl0EaS8xH878sYAs2wb2kVaTXSZhFnXlsfQ9a3sZJG4P?=
 =?us-ascii?Q?qhpb4hEFPMJXFuvGKNPOZ8xdC4EMTwZggE93xJAumyCZ341xw274C6J1DeZI?=
 =?us-ascii?Q?Jf50iODDwQLpCl6rnknyetBGkQTZI1YVrjP/B/hy4qMiXftzgfTqo3fDUK0F?=
 =?us-ascii?Q?X5oRXE4kfRBz/KOv/Eb2+8ExiKDYDwYJh21ui3UzdKw94eTAKEcyBP/EvduS?=
 =?us-ascii?Q?tAchyYerP+spCoUDO4nvxlugQ1/a99xBAQSOjbElJfMudC45+xoQj1Hp6gQT?=
 =?us-ascii?Q?whhdZtLlSOILxIfUSSUi5x0cawxevsFe19LREW6zUzR3sLXTCm7nlrxvTNt1?=
 =?us-ascii?Q?/AukX2gV6dHE+8oGO4ci66fH4VPIXqYMScGoG3T4cZY1yNEd5fpfTVR3LJFu?=
 =?us-ascii?Q?TtFWX4D6x7ezlEYYe9i27ipwuBq1gpUbGEtqrrllClKCyaP2X9ACXJ+4kPcE?=
 =?us-ascii?Q?Nij97EEcHbInWhYmw2+cYKZLQdXyrw81QVWWovjC87uD0J/LJTFebw1BMfmc?=
 =?us-ascii?Q?P18aJ8HEURcyo33ArkTnZjILrSNCuHvCgm3IM+aK1fCSDwMVkBBU+ymcAIBU?=
 =?us-ascii?Q?9PhTpemaVhS8OsaWhW/D8t0nf1UOOoMfnbKeo7CA/uxFqVHIwTDYA15CHwsv?=
 =?us-ascii?Q?s8bqx99QWoaW/ToXkg1gmsgz0ttKnB6U1SATNiF3jQFeQDgwXz8yyXEzFhzl?=
 =?us-ascii?Q?jSnADULUmz+KqZIDkbfFBRGG6ZoL2vLOMz61GH4q0Lbx3tOn3o0A9S5tza/k?=
 =?us-ascii?Q?2cT/QVN4AuuhXYjKgeswlrj8RFpvyXqAHmoMdRf18V7BDt9T4ahfq4jiErFj?=
 =?us-ascii?Q?b1Fe4JBBi6r/6+khz2up8v+f9fEJZMJn5LxelLPfIcd7vduSL6Vpfp/QnqTY?=
 =?us-ascii?Q?Jwt5zueB7zN5FEHcXHk1nb2TmZWgs90Eb1EyHHrS2iMusjroHtJA3Qtbi4UK?=
 =?us-ascii?Q?K4cIr0t7ZR9vjxLHI9ZrcHp7SENqUsOYa0uCA2bs6hzlyn9GUB7xAJBF1hK1?=
 =?us-ascii?Q?+4+lBqaeWWBcuko4BxEP+9hOigoDIrVZiWQ/gl+Rpygf/wQtzxCPZSntFWch?=
 =?us-ascii?Q?QBtOz5oJFrC8r4ABmB5RLnodonPk1QyGTGb0oNseUF6h4TLl6QhmynV6Fi60?=
 =?us-ascii?Q?iRiXY9Cv5okhZ+l62sJnu1pkXySKZ5XuSaTS/QJhgxdgaCeWzsHNHivvcPgd?=
 =?us-ascii?Q?PZDQzbM9NSWI8k5RFF7OlqMa82CfjAdpnN9XldOZF+lcEUnkPraER6CkFhRE?=
 =?us-ascii?Q?U31vcR9ts/i70rtoalZsZZWbu9Ij+VPoW1O6/L/H?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27f8219-af0e-4c0a-0890-08da68ae043c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 11:09:43.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SijveKTochsgnpI79S1tYgxjZeEskqK41TWAfZTi12nNhbyAecrTASxGKRJ3S89Dx3aNrbfGPJdLZqNrwqBsCjA0TmekKPgfbwYkEFGBI/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_10,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207180048
X-Proofpoint-GUID: 0l4PVSDrHu07ji-AQjnp1Y8n9-r5h9Tj
X-Proofpoint-ORIG-GUID: 0l4PVSDrHu07ji-AQjnp1Y8n9-r5h9Tj
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_040954_072664_5E13073D 
X-CRM114-Status: GOOD (  15.81  )
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

The > ARRAY_SIZE() checks need to be >= ARRAY_SIZE() to prevent reading
one element beyond the end of the arrays.

Fixes: a476416bb57b ("nvme: implement In-Band authentication")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The MAINTAINERS file needs to be updated for this new code.

 drivers/nvme/common/auth.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 0c86ebce59d2..bfb16fec0aed 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -55,7 +55,7 @@ static struct nvme_auth_dhgroup_map {
 
 const char *nvme_auth_dhgroup_name(u8 dhgroup_id)
 {
-	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
+	if ((dhgroup_id >= ARRAY_SIZE(dhgroup_map)) ||
 	    !dhgroup_map[dhgroup_id].name ||
 	    !strlen(dhgroup_map[dhgroup_id].name))
 		return NULL;
@@ -65,7 +65,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_name);
 
 const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id)
 {
-	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
+	if ((dhgroup_id >= ARRAY_SIZE(dhgroup_map)) ||
 	    !dhgroup_map[dhgroup_id].kpp ||
 	    !strlen(dhgroup_map[dhgroup_id].kpp))
 		return NULL;
@@ -113,7 +113,7 @@ static struct nvme_dhchap_hash_map {
 
 const char *nvme_auth_hmac_name(u8 hmac_id)
 {
-	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
+	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
 	    !hash_map[hmac_id].hmac ||
 	    !strlen(hash_map[hmac_id].hmac))
 		return NULL;
@@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_name);
 
 const char *nvme_auth_digest_name(u8 hmac_id)
 {
-	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
+	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
 	    !hash_map[hmac_id].digest ||
 	    !strlen(hash_map[hmac_id].digest))
 		return NULL;
@@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_id);
 
 size_t nvme_auth_hmac_hash_len(u8 hmac_id)
 {
-	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
+	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
 	    !hash_map[hmac_id].hmac ||
 	    !strlen(hash_map[hmac_id].hmac))
 		return 0;
-- 
2.35.1


