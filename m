Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CF9C47E49
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 11:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h2FSGXiK1XSt3ABLXU91mMGcMxp5pW+utLdk/RUQ6Hg=; b=FPDRB7Ta265ndBY+iD6pwnQxWW
	46iFcm5iBX3GTw43xFY0vjqoCNAzQ/sI3iM3k8JjSC7FiA3Zv+SjARtbBXbFIXxYXjNtBxuU7BRut
	1AwH9W78cnkepiZfL2Jb04edPVD+gGA/7gyqCqmZaM3EVdOZ9fq4FZpdM6YWfXo2QCwHeCnARiBP0
	uuBF2dThMSSqK/1Kk8Qi1FUH5extDTyBAGuMQrwBy51ZpOqRMP3kEd7o8V1Pl5EyqBASfLe6vpzmT
	GAR3baotWdso58KwTEXfswzWNxOYAQh2Ho5asIj2NxDhdPsHCY6DGe10u8r5hu0T/70gk/AYchwQM
	wxKjpg+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSbbY-002pLK-34;
	Wed, 24 Jan 2024 11:39:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSbbU-002pI5-18
	for linux-nvme@bombadil.infradead.org;
	Wed, 24 Jan 2024 11:39:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=h2FSGXiK1XSt3ABLXU91mMGcMxp5pW+utLdk/RUQ6Hg=; b=d9j2c6DZXiEeLOh0uEMaMio49Q
	SDJXKU491sW0xd1/bWNfxHkkkgC0KHe/miM3vtMa6xVHzqBKu9uHE0QiDKHHh72qoJz9kSifr8ziY
	usAPkcB4mMt6uJb8BuDlec1iv0oUkeLq6Gb7581z798TMZah7/YGQyKO4Wo6mTYOlc1YURxwRPndT
	Efu+pJoCTANXyl+X3hcviafWymyXG7jSKkjQTT4RP4PMkx1QBCcPUpHGg590ZfUXQuQUmGJbpOuaa
	KK9OjulrfOeAbnWPN1h19EwmzdZmNMLnFhbEbkDZyiu8lqqg94sY/vShV2j0ZhRmLSgzXALwV2QMU
	CTYvwvpA==;
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSbbQ-00000004RN2-3pKW
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 11:39:35 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAws8R009422;
	Wed, 24 Jan 2024 11:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=h2FSGXiK1XSt3ABLXU91mMGcMxp5pW+utLdk/RUQ6Hg=;
 b=Q6co/w3CxBm/jd/LLbwhSrcuwAV3hb/UWs8DsulL9XzEe1WWefJ+6LuSsfvdt1pk3/eZ
 vK+ARzX+isRnatdZ3Daoa9uykMDQBxTkBOi0TjpFAie59ClaBLZB9j+0N8FyPmPUYitZ
 QHLQvcrbeygIx4wmB/wDp/qPV5/sZGY6sWNi3urfmCtEA/NsPwEsLSaMzvn/MirCaCmr
 w46F5FAIRoFTf/M/kepBOQBuYMr2PY98zRRV5nJsBl5r3673y3ca/rOKFJm7jOchnZQt
 lmfa2Nn0Nc4PMGRoy0dWI+m6Jg2+di3GBgwSY1ZDdSm+xw33VRktKA0zt8Ap9pf6kfdg 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy1tw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBZPMc015042;
	Wed, 24 Jan 2024 11:39:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs33un2su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwPI4tneY3foXVxTxf4kK0mEy2um1szYa2xCY4UuxRtl1zZK82AvViH5sRaaoht4BQ6Q6zYe4WOWbk3TV12aa/fxvZ6OljtGCTTUqmG3eYHQfcILfdo6RQg41ug5GxzRedFDw91I4kz3idgw6Q6w3dddGbA8yl7fRf2Nk5afOXnfSxwKWXxpMJBCarkNjaNiU0OZBSP+hy+XeJLFhfmcK0nIhv7kjEn2M4AEymuDnipVLR/4Z8C7hd95BpKynumYiKOoah/CAUsNZlwe0TKHDh+vhhsV/qtSkq9K1tvlr7Z4lUeCnDUdE8Oz20UQOx5PNzL0QNei0d/Pu0nlgMzEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2FSGXiK1XSt3ABLXU91mMGcMxp5pW+utLdk/RUQ6Hg=;
 b=P47Hv2swv3OIDCAHxlTvajfrlXqqcT4GkuJQP44pEHKF5+NnUnnIJevvAWUct4srwJM/2n1JjtRfLSC3RSMCX4CcaRzpxRWnCESwaf4gh8x62xDec2sKhsmo0AzlXtgMt8tqFnR9E4A9+RSu3UhPmm3UzRbPJIWp4LQooXduS7Wx310cYDFk/5eHMbGewcMR8J06Org6uC7+EqgvRVi7Sg+IjIWUySKwcRsukONy9jTvLLqYkX2ASU/QM28zDMTCHK5IvEaCBWXS7K+oO3EPvd/SWP1PDOphYlSK6tJ2LtouXYBNr6qswIHRywrGlcSG3t43tNGi/MRJTiBKvCkGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2FSGXiK1XSt3ABLXU91mMGcMxp5pW+utLdk/RUQ6Hg=;
 b=aCxoVDEcBrDMQvf7n4Zv57SBJMItLuCcVdh7B3jvKH8XESPwk0tvizD5qn3PJiwdxNp7hkWIYFW0kSPBLFNdDumQA7Cfjiboc/XvApiPEuZhPiL53BDFb29KljhPF9JujZU2BleoQ1icHwBt/VcREhEWoikUwh9XnOUA5pTHFDM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:15 +0000
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
Subject: [PATCH v3 06/15] block: Pass blk_queue_get_max_sectors() a request pointer
Date: Wed, 24 Jan 2024 11:38:32 +0000
Message-Id: <20240124113841.31824-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:208:32f::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: a6caf9e5-7237-4b57-57cb-08dc1cd117a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQWphHaf0LoKd1I8gqEfEW3i/xMgSwAL4WrUmFdbfZXFTzNbRlwiLYSVBBxFM+MKEbj1JnENbzwwqfEpClH+GrZ5VPJKY1Vu6MrtJM5GbvMT5X+3z2heq4LgVRf93iLffOqt9SV6uwCeFanJQFsvAWDbqKttuwyIWdzw6BGGctzjDDZBzG7wOg0KHdw3xkXnDpl4bRC6/difL9mFoMEF27NIXd6zyS/rdUzERtmkdMTcUM2hq8UaH7sB9fTAKxgh9vClBouzSorB60EbdneG4XR523tPfsVG45VPtSbiUhuQozZr+IqsBqyJXwpdN5wsAFX1GfKLKo8nCiC0Ordd8tmIzfoCEf6HNSc8KviylEemaV0nSjKqQdlImcglJOy5h829KvjTscf66/OuF5Xuxm9FfyUp11eioBMt1wCpvZo+J4d7a1VBNZ5qSmmh4+EkXmPhu2ef0eNCG3RSQ+12LjdZmDbEvaNALUhZwBUPL2Bt8xiXp2uexiasvQ4G9VyPYWjrZAdHl/yiTdXQCOKyWGyQPRnx8hbzuMW4C9Pho5Pu8R9Q/lwquYlN9mNPX1VMtCh78w1EGppZcsK07ik5vTKxcgcrm3cJrvZxxq0O6co=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8676002)(8936002)(66946007)(66556008)(316002)(66476007)(921011)(2906002)(103116003)(36756003)(5660300002)(41300700001)(86362001)(7416002)(38100700002)(6506007)(6512007)(6666004)(83380400001)(26005)(478600001)(6486002)(2616005)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F3cVd1AXadHer715j63ESNqI6Bs7k9wtBkBxC3I4QAUHuwtDODwzlbLnsawj?=
 =?us-ascii?Q?WEhW9P3OKoCk2FVrLlsNAibyYPuCtiZMWL2+BLu0APLtRerNNv5f6MnRQpDp?=
 =?us-ascii?Q?HyRWJZLcBv9qqYEG+An9IRUc3MQyzJuiBI93PywGnjtLU4p+A4Wow/TFB2YS?=
 =?us-ascii?Q?dj3j+VQHYV/MzXnHQ7gif2T4aDQRUnb8hO5FC8ZhSXn3LHqEO6utq3ZH4WMw?=
 =?us-ascii?Q?Fn2711HNwfQzuMpeQJOgBFmQ8VAUf9U66gtvPFMRISaLNJXqHxJfyX2WBXCw?=
 =?us-ascii?Q?5DX9TSAE35EWnuHWN7Y7ttJ3wuVKDIVnHHFUd0nt+aS80JAlE+cLR+2bdEAO?=
 =?us-ascii?Q?0vV8gy1ImN/D9/M8KNy+KAfwROCE/jbLivhLnFEUgATvxZ+7uBZxD0qF5w8y?=
 =?us-ascii?Q?B1BA/wfJiLnSZ5v8BkeaDm3DtORF1kD9kuUaZpoSwdNQ0xMceOLanikBeZQv?=
 =?us-ascii?Q?WSWmOsSGX6J74n/yZiiAQqi+ZU2u6WyxpDDEVW1iETnVvtUobjsTVP49lczN?=
 =?us-ascii?Q?7uHrUF0+jIMp1uIPAcukUfn0ThOnhu3dmqbmOBwyh4s9E2dit+Kiuusx35Vt?=
 =?us-ascii?Q?VXay6rDaqZCTpJdAfUhTbeglXQnoxptWJFDkI4OzIqnoOWTqR5L993wVIvt5?=
 =?us-ascii?Q?RURptQdAPbPgqi5EN2xceirpb3XYVvU8eX3KKGpIHgmGS10PwplHFSGwQDij?=
 =?us-ascii?Q?FhA5lpIhfhz0oh+gqataKL68rg8HOxeSB1Sr96VMJFpYW+5tDwX1EkcRt1B1?=
 =?us-ascii?Q?UvMZQOBQaxkLjJvNiPj/dhWHumX0v9gqPmml6X7rmHWRu/DamBF6MhGRtK2q?=
 =?us-ascii?Q?qxFx2aTGjot+RhHQY6EcVWIPNsJHc9ArCbQGZcX4Cz9Gx6gqWTpCnoT86/3q?=
 =?us-ascii?Q?ICa8iWck9KZiEtnYEmwL5dBBHe7xrs8OCt9SWgVm8NKV2+2slT6o9naRtdAi?=
 =?us-ascii?Q?EVqjuKEPH+jTzcCaYvvJhA/1/dUJdUTfIyZVywuyc9S5Zgo/tCl/oeZLgX5Q?=
 =?us-ascii?Q?q6wwUZ9E6FMe88XLgV3tI95aTcg/zYNMysem0+ZnVpRXbZk0QxYANqUAZBBm?=
 =?us-ascii?Q?GDwDoiILkSN9jOh0AvDnMUI1ArP3YCVmzzjSsamAGPRjzpoYeGO4yuwx/0/z?=
 =?us-ascii?Q?LMy9hRZNhLpM67um6Sg+qwuzKtxju5CBciioCEyhyfZiDTqN870/4fMMlJc9?=
 =?us-ascii?Q?pnlws79Jtwk7R06nxuTFr9EjtHJdFq14rcuhJYfijUhqvtwpZnVRUVfkp+MW?=
 =?us-ascii?Q?5FqmiQGfdke491lN6b+jlGtC+2InFHcoTnXD+R59Uxz99tarqQ/hc9iuG9M/?=
 =?us-ascii?Q?Z2fDsno5hiMmYLY12wb+nT4waxbtMli3Ud+AU7UVPIIC6VCYPRZ88RQyqKt4?=
 =?us-ascii?Q?6YfdbJkZSb0MJnoWZGYjiKkzjqAiv5DvA3IjFSsIvTy4+Fyct9RJwpQ6ZczE?=
 =?us-ascii?Q?W8nOexvIJL2xMwf5Qbi137GU6nZdcnAO0zlR+kJ3m+WdkaoA1GFDzk58ZDAT?=
 =?us-ascii?Q?iHgw8McKQSJPRwQHEU+VdkdovtdYl2JXkzMj7kc4Vw2M3RjG8dEUhVqe2LSA?=
 =?us-ascii?Q?QULI4G1f4CiT8rUtnjMyA5dtIGCWZ0e/Upe7QPx+7Op6k0PwBHtL3cD+zoj/?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /5gzOFoP3l2JYN9/ZAn7+czf32R2mUvSn3NSGKce2+J5nvfbZdEYVFEU0isAFDv1HWwdNLYSyKhGxz8Wpn26pVpdlTd5G4JfN5TkFQRIHZSRF/FapayeEt2Xej5xhvg9g5hgELKvKtOSZjR/HY8Gx+gJQZpSTayP6xgp61GYOlE04Bez7lpftDQHygE6GMO4Pg3Q+Jsp8v8SVGSH8RhMw/aa/E+OoFE62Of7PbCZPFZMOlw3DBg+BhIgPoF3ioEQmLvTF7orNLp9B7YdnDi7WJcYYcbs7LtfB7Qkx3XXTqVjvdnyEjKbIBXj948ukXQw5GNRaTkULEbqEw/xUWFAK+wTdoY0vnxOtMHofi1C+Iv+AwcQY4c5HhWIKKTi+yglQNdTMAtCz7nHQtLftRC6FKGA0vGjvz8hV0uG1G9EZiLEk2ZE8nuwS/9ay/JcQWoAwtIATbZDOIzQOugaEEgQmimw79dbvKCYfN5t3GY/ajeZtMKFhGQi+2Jce+949pb9uKUYb4PtrAOlcN2S4IM47uF02GNl+QecyDwa6c6yXCXPPziHnlRR+DRU5K6xewD9MlwBAn7DPzlGP3G2uNMAI83TAfrIcaTkS2bbVBGZvLU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6caf9e5-7237-4b57-57cb-08dc1cd117a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:15.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNCTVkz9r70Fu6AeLIMe2dqNTqUarPgEPyVVMPabIs+o/NdyT1r2pgpqTNbWNg0pOXenwC8T6qc6l/Ewnwe9tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401240083
X-Proofpoint-ORIG-GUID: XH3RTzd40sCm-b88R0rhnSkO0mj0DOze
X-Proofpoint-GUID: XH3RTzd40sCm-b88R0rhnSkO0mj0DOze
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_113933_471045_D1E03639 
X-CRM114-Status: GOOD (  20.44  )
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

Currently blk_queue_get_max_sectors() is passed a enum req_op, which does
not work for atomic writes. This is because an atomic write has a different
max sectors values to a regular write, and we need the rq->cmd_flags
to know that we have an atomic write, so pass the request pointer, which
has all information available.

Also use rq->cmd_flags instead of rq->bio->bi_opf when possible.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-merge.c | 3 ++-
 block/blk-mq.c    | 2 +-
 block/blk.h       | 6 ++++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2d470cf2173e..74e9e775f13d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -592,7 +592,8 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 	if (blk_rq_is_passthrough(rq))
 		return q->limits.max_hw_sectors;
 
-	max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	max_sectors = blk_queue_get_max_sectors(rq);
+
 	if (!q->limits.chunk_sectors ||
 	    req_op(rq) == REQ_OP_DISCARD ||
 	    req_op(rq) == REQ_OP_SECURE_ERASE)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa87fcfda1ec..78555e1a2897 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3056,7 +3056,7 @@ void blk_mq_submit_bio(struct bio *bio)
 blk_status_t blk_insert_cloned_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	unsigned int max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	unsigned int max_sectors = blk_queue_get_max_sectors(rq);
 	unsigned int max_segments = blk_rq_get_max_segments(rq);
 	blk_status_t ret;
 
diff --git a/block/blk.h b/block/blk.h
index 1ef920f72e0f..050696131329 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -166,9 +166,11 @@ static inline unsigned int blk_rq_get_max_segments(struct request *rq)
 	return queue_max_segments(rq->q);
 }
 
-static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
-						     enum req_op op)
+static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
 {
+	struct request_queue *q = rq->q;
+	enum req_op op = req_op(rq);
+
 	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
-- 
2.31.1


