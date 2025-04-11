Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD14C36010
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Apr 2025 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eNQLS0jR56DHCpeL8J/qmrAKTd7wMAWUFVNJ6TjYzrQ=; b=OJqo65DIqwjTBpHRxwk6tzJeqd
	wQd34sDiddg1Jmk1A7XnPed6wza3p12UGpv9T6s/TOXX2tB9ZCUPESScaq9tUTlkL9AN3ftgL60E3
	9DfolGFZvgB59kPKrmolFm2G5cjFaEBZFjxXBvLC2lp/uZXg754F3dZFn6puuScNB2Hxf0tu2U7r5
	gg4vGbcUcXTTyNN7ly86LuFTg/8eBs9wXTh4NVJ3yzi928EeKT3nLufgeC7XSCn+lU73NUWE9VMuo
	o46dFOLAlx3dxjelvKOGZNomcKI589JDnn0ex7CBuRhZ1oYIdgQQsRAphsfixLEh4PdXB1VLtOiUz
	4YLN0heg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3EWU-0000000DwfM-0NIJ;
	Fri, 11 Apr 2025 13:34:22 +0000
Received: from mail-dm6nam11on20617.outbound.protection.outlook.com ([2a01:111:f403:2415::617] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3EMx-0000000Du4c-3IzR
	for linux-nvme@lists.infradead.org;
	Fri, 11 Apr 2025 13:24:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqKDeEHIQ8t+UpoGdcQj8WMCP+e/w3l6ruLtBCFobVbs6GLMqnFZ/+1PvUF0ofKJD88GNKOdP9qjTBjXxVg58TKgTjIjJOwcK15LgILSLDon4tFZO+UGDK05p871H95Tfi+cJ57U+YSdmVUp9iFwffKKusIdEr9SqSDTDUAWXQspo7q0dToGFCz3bWwReYuiQ/Wo3Z+u3pvinQtdtbtg16ozboJ3Cp4o2KVswq25gnUbVpqCBXUjoqi6hSyl2GPlCZiubyAgB+WkpzXywQB+niWaayuwoi0C5DDQrtPW6EOLDpoQco2hjAY0wSMHZWeEOHZO0yV2oOC3pFgVS1emNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNQLS0jR56DHCpeL8J/qmrAKTd7wMAWUFVNJ6TjYzrQ=;
 b=C9N27G5Vp8y/q8EikAivgz4M6USXdN/niHXbG83y2TOTiimjTysOfSAXSrpGpVc4lYV+HjL1QgStY8Ri1FHQL8pxeoxZf6epYx1MoW7y9o5E1MfscGfk7X0X9VuhMg0kmxljvbJNzRCp3PfUi+juuYAgVjAhJY6L8hG9pd0PDF/CpkQhIksibSe5MDL82Tm4qK9MFKVMQ4Jq7VGyfI36mm3SkM8B4O48a8wSpwmgQc32My8AayQMioqBRw8MLcwBlcYefwcA7EfvdRiF4Jk2FbS87tBiE52MZgWfqT+GZ57XQauK8VgJTmuqfnVCZyFR+8eSc/h5u0QNl+uN+nywAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNQLS0jR56DHCpeL8J/qmrAKTd7wMAWUFVNJ6TjYzrQ=;
 b=bQUIwyrAqG7+ELjg0Y2S/wiMCipH9VaW6G5cRZYaL816eRI3JpTmziIMcVh09KuaFYUqpOum3NLDgZ9oEochoS/5szOloo3dvJ+YKiplRcg6hsvAYutRlmfgy3Fw3/5MFque0xfUlEj9h6jbEESJ4RRZNkyiilEGUrDU9EMolFV5JVWTMrhLpumE2Yhrvd8R6WnOUZyYL8DacasXDuvs59BDcyxMx6UVp78PJBWhGw5UhNzGdciWoSQV52oWEwM5R/wnYgGadOtJ9xwDONyRoikwymLwhRL9Gj7vmC8l5nwidt8IC5xgUEqG9Ae+91zj3R4YOeWoYMhvhsVw4703xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 13:24:22 +0000
Received: from CYYPR12MB8940.namprd12.prod.outlook.com
 ([fe80::49b0:41bd:54e0:cce7]) by CYYPR12MB8940.namprd12.prod.outlook.com
 ([fe80::49b0:41bd:54e0:cce7%6]) with mapi id 15.20.8583.043; Fri, 11 Apr 2025
 13:24:21 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me
Cc: Simon Horman <horms@kernel.org>, kuba@kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, sagi@grimberg.me,
 hch@lst.de, kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com,
 davem@davemloft.net, aurelien.aptel@gmail.com, smalin@nvidia.com,
 malin1024@gmail.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 tariqt@nvidia.com
Subject: Re: [PATCH v27 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer
 registration
In-Reply-To: <20250403044320.GA22803@lst.de>
References: <20250303095304.1534-1-aaptel@nvidia.com>
 <20250303095304.1534-16-aaptel@nvidia.com>
 <20250304174510.GI3666230@kernel.org> <253jz8cyqst.fsf@nvidia.com>
 <20250403044320.GA22803@lst.de>
Date: Fri, 11 Apr 2025 16:24:18 +0300
Message-ID: <253cydizv99.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0061.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::25) To CYYPR12MB8940.namprd12.prod.outlook.com
 (2603:10b6:930:bd::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8940:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9cc933-8826-4956-52c3-08dd78fc2bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?08HhBuB/SzZYWbmYxKqLxxjiYAnDDYf8skwUd+3Sn4yrS0kZFAbokgC8DTmw?=
 =?us-ascii?Q?sxWzkNjq8kA0LEBLNIO/kcYBjBKYbjLhw6aIIdBeOczLLGZjLtYvMhVxRz5c?=
 =?us-ascii?Q?Z6JbX2fOpqVcnqlXERT/KpK/ZeoACPg25rrAOdpevJHYmDAyqaDfRF/Rr4rB?=
 =?us-ascii?Q?KG4qi9F1w3RQf1kc1KAZirOkYVWj1u2lE2/JbAeAfpweiFUgkpu0ig0Yh9qm?=
 =?us-ascii?Q?LqffiNajdIuYE38xDZbpIQMfKtLZvDol4mkc/hFjOqwZ6nvh4twwZOKPheWs?=
 =?us-ascii?Q?RuD0vN18uWqEWG/ez6Mb5vGmJU8zt/X9IgnumuphrWnxMt1KwuCy60Q0su7W?=
 =?us-ascii?Q?PUE8BxTL7g31qysh8d4VYPDn4IwiOg7g9Kc4c5MYQ1GpekZdj7dPjpxI5nIt?=
 =?us-ascii?Q?5Rhp1/gZjN9D7Bez1wpsvX9qibqz6GWynE+VgSJW+jxg65QgqPfD+zeoDqty?=
 =?us-ascii?Q?T8whbyVqxHujJmMfLLqvCjosdexc9q9Qqs3BysyiNKkQwXHmYv7ZQnyuXGUZ?=
 =?us-ascii?Q?+1MiUWxB+4sr7DLBCsiZ1d3I6rM8eT8drMcvP+hkNRd9rO90V1et1FSDkFs6?=
 =?us-ascii?Q?xCBXh+5q4YtAU6RWy73SNJ4rWY4ea3gHJAZ5/86WWXePyfA9z2+cIMeoRaMS?=
 =?us-ascii?Q?/e4gDdjJvCylAh7wWbZtUqGPqSE5+/ZiWQGqXIASKltiyjIZLQUfIV0ILC5x?=
 =?us-ascii?Q?5T6iGS0pAc+lD8RO/PhV4g8SA5GxeXqpoajTkLC+6fHifjFBh1p0go3TTxqU?=
 =?us-ascii?Q?7GDxdshH1XXVosiIg7G+Y70RBSihoHigb6pi+VcPBEwIrIFf5kdCatUVxEJY?=
 =?us-ascii?Q?J9o3ZFOYB65ja7Ok/FjsC/MnmE2Rbc9ZuUcVRjDobNomf+rkRt0w6Caa/5L2?=
 =?us-ascii?Q?GD7QUPd6rNvuZOdNSBZt5xyXuUWuYt1XcF0aa72xGLc3QJdtXE0EHXzBC2dB?=
 =?us-ascii?Q?bPi8G5nztD5c8+HBMMuYdJt4V1wKAi3rqrI7PSpPiulhWOdObyQqVa8Dpupd?=
 =?us-ascii?Q?E651Hb4kjpoPpyyeAc69hidWack/FW0u05HXDALgHOvYr8i2mTrxygFZLEZC?=
 =?us-ascii?Q?GAYXdn58PRAttnSwo57mK7JMsch9twDt4zx3WSpFsZef9Tbbcz7hNwwlc8QD?=
 =?us-ascii?Q?LWhX6ydoKbFDCpc3+S369DsLdMo3xmruD/nPnt31ZwxCajTlAPR2kAkaOcpc?=
 =?us-ascii?Q?vsdJ48eyLDOQEcQv0cYqVHT30MyPYUk0QB08fIJTgDWNhFgKdGwB9FPX5x3X?=
 =?us-ascii?Q?RkL/xo2JUyCA4iR7MqA7XPjz0XbuEy1eCCexrnWyaTTGaQ3kqtwL0JifsK/x?=
 =?us-ascii?Q?5heXPfMl2qzuV7Yj2z5L0aPyJGGH7HSRPftnxX05uTP+VB9NZRHTpEhcXVMU?=
 =?us-ascii?Q?KVX7JyVQgNIl+hcc1TpSE7XXoiS/cldTEqdlIE1WlAz0oeAPPF44WVj4NiL3?=
 =?us-ascii?Q?ymTICjPbf3E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8940.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DpTNIh9Nx51r9tlhK2yRxkGK7iYIsJ/bJmWmF/97Sc7eNX0mjpeSDpYQEKNH?=
 =?us-ascii?Q?vVNBfRSvhNs3+hwzH33B5pOfeHg0vVrWXnTEs4Yk7NWtSarQ1yrUor7YJFA5?=
 =?us-ascii?Q?XvuD1sQzjTXPM9X9V4y7XRitOm70jCQ8XJ3IjzdCFHC0McQ3CbCsvkUIKt+6?=
 =?us-ascii?Q?KoUQoFyHrDLlxcN2xLTTSr/k3OwahwKYQU72C3JzVQaxATpNAyBgVL8qboag?=
 =?us-ascii?Q?pmxlw1YJJYcR8t1aRn0fhubWLoGBZwanVgcZ9OBjUiakfNq0OESbk+SNYDZH?=
 =?us-ascii?Q?VhcipSRtXgHiH7YvrH/CjhtXs6Nz84mwAMarEXSqQRbHx68dgdrp5fofnSkv?=
 =?us-ascii?Q?eF5ktllNrU09238SC9eqBASIrUu4BZfynuxjKSTuWQ6QpJXjE1ne6CiKCfk5?=
 =?us-ascii?Q?1Mb8BjnpcmdMQT41XmqFgSBRTP8LCi8ExIiUUyw9QktL+8eQJBC5ifkQyTUq?=
 =?us-ascii?Q?n0fhX9AStnw9bVvzgC+E1P80r0+5BzSqwoqBY7L8EyNUSVs/H+9P22euyxGj?=
 =?us-ascii?Q?1hXJhL/7n1ghJcjn09miRrq1F4aNPKtKhDGVzf4xniZGTwhnrrHsKqflCxb1?=
 =?us-ascii?Q?KjwofMzcf+3N78Qbi0FW3RTVM7wu6XT+cGGzcykKLIZaiaMDdbIoUNgNoqpz?=
 =?us-ascii?Q?AFYIGzPNcUyPhQ/8IjCBnh7oOJHypOOIq2Et4UHXob9eiZ+Oh/0sx4qoQpKm?=
 =?us-ascii?Q?uXWOtyz9HVoPpe1SIYOirQWMSCA9LHoDBVPEYIyPdjc7ySwPwAL/zwFnJcyt?=
 =?us-ascii?Q?vxRqfgP40k9UUjVJrffMHxUYoIcxJm1xcwtTS10j4lJkse1vHKF/7lZcNQoI?=
 =?us-ascii?Q?pvbyhdULYjGHtpwX6VSh55aRvOJT2TPriyn3vD2PQDfoCYKImMP+CsfrTSrK?=
 =?us-ascii?Q?Yh9JmIWDs55WzbCNCSwajM/8CWTLBPBVjTEB/Vou5N4LS1F2IctumYUYK0A4?=
 =?us-ascii?Q?EWot6sqOlpV+K94NrwhyFhMhvbJpSgLz7CZs1SETBWdUOBUPdRPe0mCG8A4G?=
 =?us-ascii?Q?islMrjL5E9tGMcvW1F1oGDtV9sSYf7Po4b0me4znD7ZMBnWbJNX2F0ltcbp3?=
 =?us-ascii?Q?upe8E2u6c2TuhTfRFl9tUeb0rjciyYN2FXb9XEeKJXLbUWCSa9Gg75pxLaDq?=
 =?us-ascii?Q?2v3kj0ghRTDU7x4281xUzcN5kFjqPc4pinOyjq2yxvj/wUXzxxm0Vdq81x7Q?=
 =?us-ascii?Q?6JihOYiYDHSgCnPNOhIbRbPTXxnr7v67IIXq5DHp2mjnsOxUFJJPCpYwLsz0?=
 =?us-ascii?Q?skv4utXj8uMYTSdqERVcWQ8d7itWIIBElOMEGhEEV8n+LDDFLHK0Dne56QJ7?=
 =?us-ascii?Q?ZEcheGbp6b3ZB75iV2CCWoWGjbL1aVKp/vmTD9OCXcbP4o97O5OKbQfu57ew?=
 =?us-ascii?Q?nYTrj16dzQaVSHbt5C5r5EyoMe90xG5XxocO2CFtxrIyuYnmVcyM/6+PtaSf?=
 =?us-ascii?Q?ArmboK+ljIbef74iYM+mXJkNBiCqQ3Js0eLYa0d/qP9ofq3yS4FiAPMZLldy?=
 =?us-ascii?Q?g7vEUJYTnJvy3sqL8bH86fWFual1u43UmBrBQwqYxJ87bLQiXXfF/Zd1AZFO?=
 =?us-ascii?Q?/x1uVrfuoRrIZ+ro8ZyBHl+jsLBdREOSzfKfqaw3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9cc933-8826-4956-52c3-08dd78fc2bb0
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8940.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 13:24:21.8581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sb5agvQPB/4YKDZB6TzHlmWJ73GdUwAuhi5V3xFUiqv0wapxHl4ocqUsN4vwW91HC5tXKqtnfeA7cQlC7iJorg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250411_062431_825899_6E2A9495 
X-CRM114-Status: UNSURE (   4.91  )
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

Christoph Hellwig <hch@lst.de> writes:
> Btw, just as a reminder nvme code has to go through the nvme tree, and
> there is absolutely no consesnsus on this feature yet.

Sagi, could you give your input on this?

Thanks

