Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E35C531D0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 14:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qK3lkBk6AMO6uPD8k8+31xg3i0UqKbmcVPIzGyQMgrc=; b=CQOSR4RwYpyKXExrrdOX7IUYsG
	r9C3wgPn1r4mNPsumF6sX+xeQfgtKI8Rb56srLr0dfY9juCTDam4TOqA+3j7vWqIst5DjdNzHyN3a
	o0XT0q7DBPMJ3XuiEFF95et4ED7SL3ovZd21Q0BWU2AnVa96pkJWEHYts/ZvWpbqSpY6L5Ui2q+v8
	Zd5pNgxUr16IH20fbB4+1s9/V4G7djzjz8PErXMWJK6zWS5fD2XKTjBaz6XACPCGPeMcinhwFIbmT
	uyRhWw5tkGiXDtKZ2PaMYTDGpbzdYAG1sbVR1ghRkCoQ1o7BbF8+5HIy4q/xoQa+x7D22nMZVWKCk
	PRv1rjAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woMYe-000000032ow-055W;
	Mon, 27 Jul 2026 14:43:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woMYc-000000032jY-0vZR
	for linux-nvme@bombadil.infradead.org;
	Mon, 27 Jul 2026 14:43:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=qK3lkBk6AMO6uPD8k8+31xg3i0UqKbmcVPIzGyQMgrc=; b=aFJJ/z6wtfiSa5c79+ZM3X3Efn
	g8W8G8dwh/bEgl/KAs0FcEob7FzNHjKXLeuBY9gcUh8yi0NjlP49eAPNdH5RrnMR7JphAHpuIC67y
	FRonbEKNz3vIPVNK+SQ5fZUQE86q4dqLCPoDz8kBRXxFBspdTSvHtaAXZO6M9u0AJn9MfRETbLjON
	L64VjR4gznrxWlwBgSkD/9lVmuuKZ1SUhz3Doqsf8TeIj2ST1avQ7xyREoqMSRfVSoWidXa++Xie4
	XlGWuLZsOSTmB1O+8PY64Cp+hH84goj9Yr/YxDRu0IzEYPXSoitUXnC5YW2GiTsWQOZDjQCr1Mu+N
	tw4QS/Mw==;
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1woMYV-00000004Aj5-4Ai0
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 14:43:51 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RCTG3d2355226;
	Mon, 27 Jul 2026 14:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qK3lkBk6AMO6uPD8k8+31xg3i0UqKbmcVPIzGyQMgrc=; b=
	kcEkSU9C8Qb29p6pVVfsxBmyO5TD8H+8b6SblYW6JbIveg3wqEPvsouOCO8ZXGl5
	/gXckzcXYCStxOMPdXWZhAJcJbrswonLAMj6CDougKEFAlT184f63km9e6E1T6um
	KcFekuzc7aDQ9DtsA4e/sDI0mINTWP9kWNFc2/vPbrYg3bqBo9Bj2sLBBwlaNOmU
	c/iSk2/rFOJVUOvw8usR0PQ4k5Hdkquzc40GxjkAO3fsRi31PDCR8jyJOYm5DxpZ
	wkjQFrL0pyH9I3ZbjXWaMuub0nlTGfq5AXVWqJgstIemaYEP+xP9VlJMaKsU5+0x
	cBOCsjYeBStMqE8q/Z68zw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr011yee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:43:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66REeZHS021402;
	Mon, 27 Jul 2026 14:43:33 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh8gewv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jul 2026 14:43:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhOGq31btC0Y2IEOMDWCUUky60LbKhM+qONhGJ4dcGRkmCgHEjk9oKeyXLQY+GFEnFpl0Zrbhjcu7d4raIkD3pkvMmzCOLVSiK49+JPH1JCJQlBv5pmLtWe4TKUJEaZ8PTARBx3OKjzwWdXiTesdJWkMHxL6UI3vzY+Ah0f6b/LieruhK1Chr+dcY5T3isTpMurw+NRS54OzSfY5hxCMvbuWsz8zsWxHaPJu17uk9++jYkaFRXVBv29Uajkg7gwIDNY3jdHdKs1x4UIm0fBz0+qDjauxf87PQCciDP5cUegrm7h3R+MyDqY4LV/SvQ9ucmwY9NYkH8bpw+7az8FyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qK3lkBk6AMO6uPD8k8+31xg3i0UqKbmcVPIzGyQMgrc=;
 b=cnCzt8Rc3kT9uf7WRrF4+9S0jvjveiCq45fz+KTk5BA/iAvPNv3Djx6clhY2LcmgFlk928/QdT1SBRpD4RF399OgOUxWld0sISAxuuUJV6vFFmGQkz/vR8DNxrRrnaf8XxLdvrgh+nqY/3CzctGBwgX7nnFiK6pElWIM9xVMNCjdoET9cEHZQTnjFE6Z7PaKhN5f6uEkedP1RTvZh6Gjd4pBleBJk7h9upIaZyP8FeD963DxtkbY4URYlIYDREQgJcNhh9AXp7OPDZgC//NYGc1bAK/gXnFaHd7+oaN0jd0BcEekAjfaJrhYzsxqXj7HtoL21MpR0l4TkxqJ0dIldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK3lkBk6AMO6uPD8k8+31xg3i0UqKbmcVPIzGyQMgrc=;
 b=rtBgw5Bu4kQ6biM+9+ZKspQhDpUuCJG6JMhwvRYglHBVqTtVzLyDMrp98DROV+q/vdWVRl9xHLyKZ+jiPvm1Nm6lVPC0VWBGZTWA/OQ6pnioBprZ19bK4jz5xAJAWtC+ti0qiEbvUXlO9k9BdqRneqxLiKqejdLwhzDcqQwzSBs=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DM4PR10MB6087.namprd10.prod.outlook.com (2603:10b6:8:bf::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.13; Mon, 27 Jul 2026 14:43:27 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:43:27 +0000
From: John Garry <john.g.garry@oracle.com>
To: martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, nilay@linux.ibm.com,
        john.garry@linux.dev, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 21/27] scsi-multipath: add delayed disk removal support
Date: Mon, 27 Jul 2026 14:42:28 +0000
Message-ID: <20260727144234.3802948-22-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260727144234.3802948-1-john.g.garry@oracle.com>
References: <20260727144234.3802948-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DM4PR10MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c391780-d8cf-48f1-48bf-08deebed6b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +H71i66DNRn8i3LmofkRspdXZv5Nu3FSFv5d+60RynT/dnKKdG27NIRYf44QkyVKWoj/hCDz51e1BQWLauwKCia6o+de4RyiFZiER2GYJn4MB7S8eekuynb+hOIdbV8CG6qSNsrX8skJuqjBVXFAjzmaMu1TwdGY7IIaQ5J6fM8nK5z6hoxyuJtYAT4pkzxT/tWGzPC1bkxoJtEU5uBhxQ2JBkb9xOwWmAOaSYTMAuo2ZQKJRWuJmT6o5lpVOWpruZs+8Yi6i1h4oU/fM0OJK7y/JdyWWZyCvunmbIFyY4ptL+8L+55ph+zp68+rzesv0Sk6JKvIvXfvTmFWrN4WTygn5zsa5XwEph0dq+3f/H9LEOR97Q1ThWCZY1DMfUiTm861Siud19jYL9tPBqJcfbFsax4251Cz3qPNMuYHFPKypSmPUUuNHLROugYOFQNjO/3Uf4NUBhZPf20oyBH+2u5HWeilYy21x21g4Mzn46VgbVdKRWM5IqfSGonzCU7Tlwu2atj2pR7ftKsxbvKiWnRXZtAGHmTcN7Q5VZozD6EEY4mYHTt/TBqNHb5cH5GMMc80g4FeNAae8r3i6B/Lb0/IKK8xUscHz1dNbzD4cAAG4Zl130EctBb4i73iL8fZq4R/QWMNmpy4E14hB8rp2+m65hTCn82vDkqM7OC38H8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IbHwBRZfglYpbqJdoOeRxosGYiJYirKnWbwkB3j9vt6hFNgQqqDm8yFwKc1E?=
 =?us-ascii?Q?cn83uX/SYPn5tAXfnqbdPabFYOir1ipSEk4pdGPkd/V2c8hrzRym/M3H/lS2?=
 =?us-ascii?Q?WIVyP/aoHx5b7UV7yRyMXmEVDwaNmg+NGshRW2Lz5eKFeZOoQLm23rHj2rJW?=
 =?us-ascii?Q?zCEp5gZRRjQE4lo9013rT9GB1st/HKgG60KP2OTuCE2cw4bSzlf3xRQGRd6c?=
 =?us-ascii?Q?T9ANRr+PAKIDWK5yQ7VQ5XnBh3SU4T/krW8pZTTPJ61r13OUIH5YoHvbac6/?=
 =?us-ascii?Q?GKMW6hJcXQ7dyHBNzWnENlhVkoev9uRne8EBWYPwheTGfwoA4A3YL+m2AHYw?=
 =?us-ascii?Q?i/2/4NUTBjnFV+NKSlen80d5ymNTh5VkJXPBRsjs/Rhj2oPFE7EAdMLD/1sw?=
 =?us-ascii?Q?fQaDWu4zW2g5WDk7A7UXqb0sTJRSFzEAv3KeVrsmqIUm10D2ipk/La0vy3em?=
 =?us-ascii?Q?9HhM3AjCMpu+Yt6EqDpykTwBtnxSBbNK1BVaVMQAbk5nWxihnv0wSIN+ruP1?=
 =?us-ascii?Q?h3EkviM7thA+xLMG69lZv1b2b1pMBGgGQ/CfjAt1px4TG7vr5SILHu+D0tAF?=
 =?us-ascii?Q?sBNOIHQWU/Ug0AY2Jt3XPubLql5w7Dm5oLC7dOPtUUBqyzkrsmaAUnEwPLsC?=
 =?us-ascii?Q?M2SVJPKsZYnODAN7Jy98YwmFG5L58is8oJZioiGNCW3sRVMUrG3Q0iDUnk2w?=
 =?us-ascii?Q?ecrAvKThhzIV1pDf0g1ypt+sOikXdrghzcNP9WspVDR9bV/q7oeF/VngDREv?=
 =?us-ascii?Q?d54Pta6WkdA5f+RGJzSCcEyqLFdix5Z7SiQwmGjR1w4acR5saAKWQ+htPYIQ?=
 =?us-ascii?Q?ck0/RQ3ax2WXdovk8Si8efaVAq3B2z+htV+ynBnBQciLU1rhmkfIkTExX0I2?=
 =?us-ascii?Q?AFqtDVDEKFwJ5cecYdcrClea8C43pmAImceT/XkEQeYNKWskPvdYrgNuVltu?=
 =?us-ascii?Q?aWCxu5bEQaO2voP5ucKfoMfqKwxA7k+GsBTbl8AYrkVGEdf9JNb+wMaECRTy?=
 =?us-ascii?Q?NqD9EjLuadCj/1y6NbNUpKO8fnW5+upLGp9Qg+u0bYFX3j8uvO8t721Tfv4B?=
 =?us-ascii?Q?qOiueNrNtt9siDLGdHDGgjWjId+wBZBsp5x5Az1RlUgn0Yz9hNYVgIGif5pr?=
 =?us-ascii?Q?2UFbL10xRZqK4Fg5MOASp++aoAuCqC0QRa0nsbWEjT1WaCrrTSH7Tkl1haqh?=
 =?us-ascii?Q?hkBrvksIBIbnM7nwW5lVc3TlYJDbo7CKhmyDeXZcpxLi6H+zSygEey5b6Lyb?=
 =?us-ascii?Q?1x+SyWY9K2pEXwPQLM3Xrz5JMH2kW1lkBzBtcb46mdd0/PviUzDzKvZX5hv0?=
 =?us-ascii?Q?OTma3kg/y4BW03ekbeSrvLIXT5rPbqbLZFxyzbekvTmWNFyd5/EwQaZwVTZq?=
 =?us-ascii?Q?xZwfLtpCpXWGLr+uTi2aK3zm7vDL22HNlwsWClWMLAfBt/3ToY/r+RwQj5VL?=
 =?us-ascii?Q?XohfQjq/v8I+hlHTomGGtiEMCc2GYow3Gs7L7A+JZ/uycEdkvyS6DYJUOXVR?=
 =?us-ascii?Q?B9GHUnaIbQXDUY5HvX0UOOONcOOVDO3a9/FAVpVA3pOQohLgdYsz07iiISAy?=
 =?us-ascii?Q?esXfj6l7kLKxx9M1fkH1wm5HNNMUYeXjF4Nv/B25bLBji5SIIRzuNd/DuNp3?=
 =?us-ascii?Q?Dm/H36LBiZQvFojmh/X7enDYZ8w+SIwz/8AzXYI6Wt/nrrLK3J0oW56eJJ8s?=
 =?us-ascii?Q?LKzlqctgY4of4lj/5nKK1SB36ba7JfZ6fLWucO5/l2w9mCVluoz04EVw2IEQ?=
 =?us-ascii?Q?CXX2j3eJmbnCWqREQFJcs5c+Ti45YWQ=3D?=
X-Exchange-RoutingPolicyChecked: KFIzx4sOJw+MdRk62pkVJzTzSUqHRz96q9hCM20IapWwvSk5cO9dfPz0mV57BHflt6ZkEGifQZ4+uOIsQsxd8fRpuB2nTJoqWpfeBNOQQYBLIbzlxXXlfvAyXaWHl7gskCRiy+JtZrszgt5KfHae6DmnVh81I72vuXoNg2w+9JruBSnK4htjRzhJiVpHmV8aMFGCCShDGpfkwAs+UYXBV5mifFhV6Y9WJoOVe9fFsr9E+W9ifPQScf5+7xgw6+H3vocgUckP7xaG2AVLKjrLJPSeIRtub7seJiRORxS5gmwiP53cva89PGw5PApMa/yV7Ism9gYF1uBB9IBBkCYhaA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EF+7J+ZmUa06r6GMs6kDdIJllRhPENj9GQsCU0M9wloksxPFeUeNzlg0tU0NW2SgRDVT6fdQrm362kwMYmCdEGvDTK6K9szlLl4/IbTec8EDHSDOjfFjhaDgDRmG+LX4teBA0DCj+8MqOqCLKEztgHgWdcrVXHLAQAkFp/kL/mMBi6eFGXIUC8jqZ/baLs6sfkeeuU4aT5DZGa1/wCKUl7kMhZPIgG6CUHfTkqXNCTkRy2433yCo9/kcc/ZTRjYpy7BSzQBX1DpS/DPvVThnKVcilG4Gy0oN6OO5TscDsULn6eM7xk4kZc4BsL6afMIw9VjwYjVeQALLKhQjQXFzHpZkpxbgWri8izt6uxkpEQjteGYs2HKqpH4jS52os+AbpRoEwWrXPkCNKe9f/Gu8YFJxNH1nRJTigcq3WojoexMIy31H4r8whE0UhQlFZh+7nvtL25a4Jyt5hqsdXcTP2SQZ9BVZCrqWTuM+06fnTyuTkk4vTYo2I4rKSf0+W1XvdonLEh51CkEej+y9wkgQ15hTGfl2AT7wZcf2w6D95f2AHgSGfvp8kNleOYk209K0MTLdjUIGZ0WezzjIs3G0D7srYF4SVgCVoUKFNUi14dE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c391780-d8cf-48f1-48bf-08deebed6b5c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:43:27.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTZf5wFNhRip7F+WpSyhNlHXpgIwevvF0X8sFfWdzg6w9hQEYfl0TaztvdNqF8j9T1DjPhDuvOjZ/kUjqnF8kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607270139
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzOCBTYWx0ZWRfX7b4wllV4xjUx
 JRB1EGRtII+zu8m0ylA5pdAel0r/DtDJgH2Skn0G5jkSMmDs5YG46cSzRBiUUql2gk9GCtNL6V6
 7RaZujQg6Jo78PyCirzbbT0gQENz9biGHNpYCZaPpN/VnEDzClzZ
X-Proofpoint-GUID: -ad2DE4_p1rnDzCa8dSb7f55CW1KE__N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzOCBTYWx0ZWRfX2t5ODxl7gpOI
 FHIej2MQiEyS1ULf+6CC5C1CJTwLSmYWUtOt7AysZDQ/NInKA67kgqHLg0kfEp6l7vGLcJcNsXZ
 /DEBn9o67TTzQALvn6KNw74j7yn/a+NoQF91P5wYNDcTBS7o6f9Yg14mRri2wb1BEekPWho1cyg
 s4ygT7k43kk2Ak8HKbGzgiHai/d/sX96WzVyhlZgEI1V0MlWebn1+lR/H23oUPlnMN24fTHViSs
 d51gq9nNngHu1UV3mGC/yuUFZXk8xolQ4vQhRIwc624g4gg4TfZdhqiDHDLzbe5RducJDAtKb8R
 qr4M3tcPanszBe4DCdKGSQZpuGJ7XRC0k3crVEPP6qXbcWzNYSy8ukhUC7qA/kO+SoCk41UHzR+
 eT7eFr4ucJykzxb+kQERrvnn7mnZnsUg4Os0aeamnxSBQAVBZzmnwznhX2+nVef/d4EsA/bDWzd
 oNfLBgXJ7djH6+N+IkT+KfVjxOyzeH0KpxmAyN/4=
X-Authority-Analysis: v=2.4 cv=KL1qylFo c=1 sm=1 tr=0 ts=6a676e96 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=S0-NFRiyq58gb8qD-mcA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12115
X-Proofpoint-ORIG-GUID: -ad2DE4_p1rnDzCa8dSb7f55CW1KE__N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_154348_673598_C0AE6CF8 
X-CRM114-Status: GOOD (  16.49  )
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

Add support in core code for delayed disk removal support. In this, the
callback calls into the scsi_driver to do the necessary removal work.

The scsi_disk driver (sd) must ensure that the scsi_mpath_device does not
go away while the delayed removal work is active, i.e. it must keep a
reference.

No reference to the scsi_disk multipath structures are kept outside that
driver, so that driver needs to provide a scsi_driver.mpath_remove_head
callback to do the necessary work.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_multipath.c | 27 +++++++++++++++++++++++++++
 include/scsi/scsi_driver.h    |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
index eae5864ce5826..ed9c83189942a 100644
--- a/drivers/scsi/scsi_multipath.c
+++ b/drivers/scsi/scsi_multipath.c
@@ -360,7 +360,34 @@ static bool scsi_mpath_available_path(struct mpath_device *mpath_device)
 	return false;
 }
 
+static int scsi_mpath_remove_head_drv(struct device_driver *drv, void *data)
+{
+	struct scsi_mpath_head *scsi_mpath_head = data;
+	struct scsi_driver *scsi_driver = to_scsi_driver(drv);
+
+	if (scsi_driver->mpath_remove_head)
+		scsi_driver->mpath_remove_head(scsi_mpath_head);
+
+	return 0;
+}
+
+static void scsi_mpath_remove_head_work(struct mpath_head *mpath_head)
+{
+	struct scsi_mpath_head *scsi_mpath_head = to_scsi_mpath_head(mpath_head);
+
+	/*
+	 * scsi_mpath_remove_head_drv() could drop the final reference to
+	 * scsi_mpath_head, meaning that we pass a free'd pointer further
+	 * drivers - take a reference so that won't happen.
+	 */
+	scsi_mpath_get_head(scsi_mpath_head);
+	bus_for_each_drv(&scsi_bus_type, NULL, scsi_mpath_head,
+		scsi_mpath_remove_head_drv);
+	scsi_mpath_put_head(scsi_mpath_head);
+}
+
 static struct mpath_head_template smpdt = {
+	.remove_head = scsi_mpath_remove_head_work,
 	.is_disabled = scsi_mpath_is_disabled,
 	.is_optimized = scsi_mpath_is_optimized,
 	.available_path = scsi_mpath_available_path,
diff --git a/include/scsi/scsi_driver.h b/include/scsi/scsi_driver.h
index 249cea724abd1..d92b63d357f2a 100644
--- a/include/scsi/scsi_driver.h
+++ b/include/scsi/scsi_driver.h
@@ -8,6 +8,7 @@
 
 struct module;
 struct request;
+struct scsi_mpath_head;
 
 struct scsi_driver {
 	struct device_driver	gendrv;
@@ -22,6 +23,9 @@ struct scsi_driver {
 	int (*done)(struct scsi_cmnd *);
 	int (*eh_action)(struct scsi_cmnd *, int);
 	void (*eh_reset)(struct scsi_cmnd *);
+	#ifdef CONFIG_SCSI_MULTIPATH
+	void (*mpath_remove_head)(struct scsi_mpath_head *);
+	#endif
 };
 #define to_scsi_driver(drv) \
 	container_of((drv), struct scsi_driver, gendrv)
-- 
2.43.7


