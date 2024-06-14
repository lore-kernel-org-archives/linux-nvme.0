Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188CEC27C4F
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 02:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Date:References:Message-ID:In-Reply-To:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q9vFbZ0DIMsC7v/gFiQ7R3TH78A1FcoXJtRx9CEthaQ=; b=uMoaxeTxyp3MBfTbGwVJ/cc7AZ
	Ay9FiFNuWVOdK8A2IGs3kaVJFvAsP9o0A8FQYgXzJswd20wrTiriwgYjGwObPrwxxqCbMEJp4ngXO
	S53ifTbW4ThS/kECqEI8Zph3NSOCzfGEG2xNsmlES7mPHmmq2+diGPZVoKhaA4JSGTotlgRPUUOcM
	0qnJuPK9WL0jYxg8m6TKGXM5oK9b84+8lbIQKrkDDyuVoLXDq2Mf0Sno0xcuRgzZDTmbbAZy4zIHh
	wu+xoCTpVgrFQPIvZN7t46JJcVx2c+XPXxpQ815QcHaJKIKrQX/LFkDxCAH8dAVhONkVijnN2SenY
	rhRofeTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHwQP-000000015Rb-2RV1;
	Fri, 14 Jun 2024 02:12:21 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHwQM-000000015R6-2BNV
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 02:12:19 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E1fYVp003508;
	Fri, 14 Jun 2024 02:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=Q9vFbZ0DIMsC7v
	/gFiQ7R3TH78A1FcoXJtRx9CEthaQ=; b=OG61hSyV8Qlrb1v13AtEqy7PigdVga
	Lr0xcJMmB+jX69rmHcj8nnjEfCtnPg0qhzUTaDxvXh7uqqN+TLDWNVkYNhn6zpko
	TU+CbOdb5K9LpfUMnSoKFzIF6fWpvP6bt/Qkg7TQ8h9tAhruhKCs/RNjN2ihuiy9
	RT+fYwGS12axea2w7/32f+OsRh1LqoGiZwHR7LWuHIu48FVVoeIE/GkihYUn11J5
	Cw5B6X9CReNslWJiKVYZpLfSLStxz5pHsNz7YXzmqlAruVO0X82wbyAlEOL4qvXp
	6B8GrpCWSTijhmFx0VGxNHuvolevBjVqu4oN469zFg9DL24Mz5hmCL/w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhajats4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 02:12:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45E1MGi4021157;
	Fri, 14 Jun 2024 02:12:03 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncaybcr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 02:12:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqnUrVILV7poQuzieXXX3xpWeuzkLIbVjYhnaTiiXQQ8xz0pPHQ1f5Zuo0nm1gnOZ9u3g0W5/CV8GD2UZxj7BNKrqaDr4cllP2qsiIfzquvdfiIjYkEybIrk41k+qHdHTa603q4aVHyx+RwnnEI6++gsKpaJ0k7/OgkMjjUORYLFSejszlcFojDZiH3yROcleWcl4TJqEfl2dIZuyjJ6tks/ARI1fS8omUVtlEOlQaJby79QtFJHqYccxb8R/5HXtBlRefrb0m7UmaTpU7WuB+czhdqfxSwasv2zIao06Dpa1OxFT6yFg/3jsVutULnxt19Jt4tyies98iF7ApYxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9vFbZ0DIMsC7v/gFiQ7R3TH78A1FcoXJtRx9CEthaQ=;
 b=bj8RaGS1UEprQXFA8s4Tds0bgsJJciOyvi+6pcz+ysVo85bQenHgAHxCE/JL0mxD1WYz0MU4nPOu2fnQ6Hs7BNF/yR52veHB9Ft9uvoqR34MPJ+6tP2X+m6vGEf9b0DiDql6yJvSIDge488DHuIMJtRT3aHYkAODCBC+e1FUR1w419rzFN6TjlUf0qSwKrA6CzUoaK0Ef0ZS6urkH88KlGUy5NkDMWDWEbAeX7Az3HmRT5m1w5+o51zom3Pex5SETaL9byQhOvWPt6uylERQ6sHXV2YhgYRp9Pz5Zu9zNi7x/UHsSeObT1u0ljDujdSRLrKUsmShjTQwcRqXjPyl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9vFbZ0DIMsC7v/gFiQ7R3TH78A1FcoXJtRx9CEthaQ=;
 b=jaSGuaKOjYD5IELhZ0f/P2BQNk46uSkyFPsRHsSOKLXRUMvDKuBf7WvZ7qrp/XXM54RxgM56Th82qoY213Qb9jD9T74AUbwftTjQyL1PBv1aty+VVKP4MGnSVw0VGZ5H2d0yTwsSbsDjdGuxgFT7IE+mwlpEZhG0Mt9+VU7PgYk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB4896.namprd10.prod.outlook.com (2603:10b6:5:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 02:12:00 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 02:12:00 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas
 Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
        Yu Kuai
 <yukuai3@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        Vishal
 Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Ira
 Weiny <ira.weiny@intel.com>,
        Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH 11/12] block: invert the BLK_INTEGRITY_{GENERATE,VERIFY}
 flags
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240613084839.1044015-12-hch@lst.de> (Christoph Hellwig's
	message of "Thu, 13 Jun 2024 10:48:21 +0200")
Organization: Oracle Corporation
Message-ID: <yq1plskp920.fsf@ca-mkp.ca.oracle.com>
References: <20240613084839.1044015-1-hch@lst.de>
	<20240613084839.1044015-12-hch@lst.de>
Date: Thu, 13 Jun 2024 22:11:58 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:40::36) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB4896:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a73892-434d-46a7-d5f3-08dc8c175fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|7416009|366011|376009;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7B47YFBTbJH3ecZwRawb/KUwltfAkQlZKNLZGDTgQkx3kdmWpEY1u5rN9D1t?=
 =?us-ascii?Q?40aw2ljTVcxctrVUuG9GByCm4x3UNYy2yL12ymFkif+vHGKkhw/Qt7awlQ5H?=
 =?us-ascii?Q?kyIzBOD7UC7evwpyP+fmbH3lGCtNT6X/L/P4zFeSC6dkecjcAQLsAm+G1iX5?=
 =?us-ascii?Q?MCbGSFjbTocRWXRQoQxGAoNNtU0Heo4M5wa7DYOsot0nM5VlYxbsVXu+m8za?=
 =?us-ascii?Q?LST/JPhnhuZKxsPXACrHgwIeaDAgh6iWa3KbjJhMZk0qLPBdg+DRz5hCn3ke?=
 =?us-ascii?Q?ToVHqG/7YUzBEUb6QIBBhDKHz7KqpIANiTbM3RBoZ/G63FwbHgCuMc4N73Ra?=
 =?us-ascii?Q?WL84f+TR2VNyJiYiQbej1ufFyYo+3niqyeq1lG/g7aJNsM7D78nZmcjj1fxE?=
 =?us-ascii?Q?BA++fpqmgzWU1t5Ou//c3yadkO8y5+tuQ7DJ5Z4I9tYp1OQZKWzESx4lwV5d?=
 =?us-ascii?Q?SxKPQb/Wt/CtmdWqL2GWCmCUtNL85EKra4lxiJlPCmsNSxPM+7BsFl4WSd++?=
 =?us-ascii?Q?yzlMBbmqm18NfE81Khj02R1ph701GKuRvg3PldhZum4hXvJZKygYnp9myhKJ?=
 =?us-ascii?Q?3TXb5zFUDbB5s/GJCqxhKd0cKkDj480McxLmJ0zZQF5u2b3/egSLF1/hWEBb?=
 =?us-ascii?Q?7lI9Cukr88MBmnKI9GwzN3BDexdu1kPl9yWiZJB4QjKgWkl46KzP6mjM62r1?=
 =?us-ascii?Q?Z9JR2s+ndHQH+5Y87XYrQEhSRvgqoiJHFj4e9VkIjIse8uy2hD4Nni6AvAjM?=
 =?us-ascii?Q?1fOi0TVt8JxXPSqfhdqZAGNwb7MtvWU2XhHYQOskw/uCDTuspuBpRBLpA37v?=
 =?us-ascii?Q?4vyMljZ49xZ/lvyZtQd9gozliRO4UiXgJnqbBORZPVbwASnTR9K7S2BTjrM7?=
 =?us-ascii?Q?/ZCpHpWUWIUPONsABgla64SMUcbSB4MQaafi65BsZA16pjNjsp5RiK/D5J3Z?=
 =?us-ascii?Q?W3kH9vU9CppKhVCiWADF/+aFLBOG63GLM4wZkRY0BZOjVyO5zXWvPprd50OQ?=
 =?us-ascii?Q?B08+g8CSXmunlth4S8NtG4eCcCytMtz1oEMc7C4jKArU3PkHOagZp/xknlLb?=
 =?us-ascii?Q?rE/YNVV9A8S/1GLlkp9CLdB7RI4cLuvZjJmKCoh3sPpI030ch/uv8zETT7Qr?=
 =?us-ascii?Q?5Kn3t4/WLj5xUIaqTrzHjsAD+FaSLIBgORG6JhXjpY5fZYGCFEYaBj0cW3B8?=
 =?us-ascii?Q?9T2nDUT+9lcQJprQzRCSmzuCtEwIV2KZHypUZFOjFktEhUHGFW6/68r2O+YC?=
 =?us-ascii?Q?ZnBrF4w5mFZylTnoGfmOMZY8Pk1Ghd9/5dmfkyLezfArzlqJaz92/5U5J2D2?=
 =?us-ascii?Q?yRlez65H+APcyuGhnq44jdfW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(7416009)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Y7BzzZIhGM3QBarvod7YWWbaAfH/g/7N5Ndw1TxQZt90AFw+QQxVPUVN3iW?=
 =?us-ascii?Q?NyKcEo7WFi87+UqPgi597R+aGu9b8MZHwQFVC872WsQAGofs5OObG0inCJnZ?=
 =?us-ascii?Q?zf2YqZlRiXOVFMlhoxqipEhuP9PlnrJj3f4b1Z2TdAtzJuzIlfKWlw6Hzh/V?=
 =?us-ascii?Q?VauWZf1bwnWLJmSmQev5qc6nUFqLZpJhV5t+oMXPeypE/AqJst6zgfHZfZT1?=
 =?us-ascii?Q?ilhW2bujhElGgaI8HR0ZZsc0CFaO1Gp6ixDCiW2/3JKFzsoHZYt8d8eP0SYj?=
 =?us-ascii?Q?hv5/dFf96sxNGPIeqn6za1PKSgKQ0rKMrKmIaHHmhCa2uImZURU5/I5vh74l?=
 =?us-ascii?Q?KZCnra1Dr4/Wi3pphLzqyWAP02xtWjoz/rIwkEhgZCUv9G+cQMhRlmjy4ke7?=
 =?us-ascii?Q?YN7PZ5qN81Kb88hARd1pCEW+MKqUaoVBtz2Pf4GVZnDN2V2jpGU0z+sENL5w?=
 =?us-ascii?Q?L8wMCiOGElYpPPSJ1Bh+T6Xn/yTddBJV06Tq0XEWbDD1Ky42a+dyBVXjLvH6?=
 =?us-ascii?Q?uDb6UcqkMnjmsY4Ka678UI07hz9S/d/XMBwNmxhU7LQ+9wMk7ErPUhFoZjZT?=
 =?us-ascii?Q?WppbwUpQ1JXeUm/1aw6CMEYADoH+ip8VCDHGNa5k/lldNjYZjnYpYc1nLev7?=
 =?us-ascii?Q?npZ0sNddDrFnzpHtw7U8KuRyl4ob50vsBHRhUrF8aBNz4fzM/NwHNyp2X8kR?=
 =?us-ascii?Q?vTF3OaB8kF4kLaJQsIZ/VM/caIs1NJVAavqYeV06zMVC7mHdDpFIy4yZxY6S?=
 =?us-ascii?Q?zqGS3BqQO8e1bgDOhx27vxM01P20/qc3R9JDLcvY7IommfigxRNLfvqH2hg+?=
 =?us-ascii?Q?C0h5Kl0KaAHzeLbUvS+vJ+Ebj52Z2yGFy0uLxP8Xpoii4UvaY29dD1MY8+F6?=
 =?us-ascii?Q?ZtWTFc9WqS/F5wuqjgNjyWRGI26WPR6AWtC/mFYXK6VN37zQvw4e8a3lXvwK?=
 =?us-ascii?Q?ZQ88IKXO4rUxiLpAjs0667K61dpyzHlSQom4Ur2l9aGGYv8Fxv8EGlZPZjoT?=
 =?us-ascii?Q?fwTSX4UWJKNwLUmOcMfNJkMqtUlB3WGk5np46READTWjXlO2c7cN9YyFgWpp?=
 =?us-ascii?Q?Rnd0pOMOwgLbr3EJHYUYb8luBtqreZVQ9N0Pss3FYZ3vWfwfxellRVJ6dxbY?=
 =?us-ascii?Q?bhPtyQbfj7GVrxipelWrt/p5KEMDblpwaEYxdIDavVp3hiZJx1etZnmFHAvV?=
 =?us-ascii?Q?ijFS6Xv24m88jNnpbCifhANhGyrOE5DCnjNqk4avl78b/vLYLKV1szHgbfIN?=
 =?us-ascii?Q?ElpBJBsj7W3QjIxpNC6jxQfpyt/DjnhroWqZUj7ARP4SuLvatpw5oxPFPMiV?=
 =?us-ascii?Q?yGxtRAbXAspKMvz9XyGJQz/3WhLrDDsJ8wJScZEWAMzk12RpKLYtVaHUyJ9Z?=
 =?us-ascii?Q?8EI67pxJn184iS88sRNBnwH7Je4tQqWemWZmjaP/EsDODE8d1kRqFLrXLb6B?=
 =?us-ascii?Q?egaKyrpZaNRTgObxTAIeUqaeaxqLAz5xTmBdycNW49qLJVS/CbOjCvSfIi7D?=
 =?us-ascii?Q?b2H8ft9gwtDn48H3b/CfdGr9AviuA1X3pdEZk8bwOcOq1hXnAzhpsPFSO74o?=
 =?us-ascii?Q?+Iaqm/j95SgXetQ0Am/gEZaVB10VtPAsqo6oO7fxFzeGqsPoM+LIFjrC6aRm?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zF1QJ/cMOwBzHJzob7UMlkufX9ieCPgKYWtBn+JQMsZXhExMXy3sYjiUP8Zrltl9dfnb+RXJMxYFCn+835t2tOFdVHkUSrPTeW96FG9xAJqqoS3LmiMFV3SbcYH3MXGNj5sTDJRG4PBxloZYJ9Z9ayPUIX4+N+1gc8NTbI/PZpi+hnV6UuTJhiKQ6u4J+ShuGty7QoBNmg+HcqbZIwSrb0i5IB2cz0VwrLGRBvbBPvy1X4tI2UN0WYUwISuHsO1IAqoU3KVURfDGD0FNQfv5i+CFzjDFc9Y62uwYJcnsp6CJTIQir+PZQPB4CwKUkr41rEI6hBGyKjT4HUElRg3HCRRYBm4dlftOv45sM+yh9NW8DkrIoQzaAnKMdxYW/hoC89miqZY39oPDR57trRTX4zRAJJlRa1sTCxh5S7KGzXyD9HZM8AelurxQkxC3R/4Jai36vP4xvidyDpvMqSoF+J73okmfEPduyeLp3epJItp/pIWZJ42Wf3F2WaltAgX7EtJsgzcPMuQ/jpGUg9gF3+RhQjwKYWIYkJIAZNGo8ZJDE9hmJUtxx0m45X0ZgtzaEciVKwGtxPreNozJk+R8OLMd9eIg73LRI0d63xTBbrw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a73892-434d-46a7-d5f3-08dc8c175fde
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 02:12:00.1209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUXiR3PT9xFjzxH0MA6IwocDPS6F82jVMCdazk0d/LSgSuwZWZ5mc0EiXcajYw06PwrqnajDhm3jSGhCs+8Yh39DPscEWglbbQPKZjNdYSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140012
X-Proofpoint-GUID: oYr_HFqug3fdYQVdjcj6A3HErcXkkEe_
X-Proofpoint-ORIG-GUID: oYr_HFqug3fdYQVdjcj6A3HErcXkkEe_
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_191218_611723_BA21F4FC 
X-CRM114-Status: UNSURE (   8.76  )
X-CRM114-Notice: Please train this message.
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

> Invert the flags so that user set values will be able to persist
> revalidating the integrity information once we switch the integrity
> information to queue_limits.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

