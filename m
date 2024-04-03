Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B56CD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 06:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8HR7X9up2EfCUQGV2Yw0CkaJ5m2RB0WExM9eJyIhtZs=; b=IYrKGhlTcxrXKlLiZCsIYekYIm
	kE5mUop7Do2hMZ23//FZ3LDkfl42zcMntiyVa3wVuVW7FpV3JtJvJ2u9oeiFr7KSsn3f82Smm3rAz
	zGJJzdehAMbJOhMPy+Ka7aux7cMHD4pn5aLbLqJ37TYRsdrUH6O+EZ0gzBnwb69DWwyvcr22qJPQo
	K+Hb9qmX1MaIHOOke+TQTuWtNGZ5FL16dw8h8GU8pfhCmiHpRbbRY4wExt7qpFRmUMffh6OyJNZxy
	B40zzeWZf2hqVXbJdH+K/PCwYj98BscylczHxg4kMA7KNmuJbZgQFFEh/MnZLivLzxA1WDZe7Nx04
	WWDKBj9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rruEN-0000000EHJK-0Loo;
	Wed, 03 Apr 2024 06:36:19 +0000
Received: from mail-dm6nam12on20701.outbound.protection.outlook.com ([2a01:111:f403:2417::701] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rruEK-0000000EHIV-3IbE
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 06:36:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STGdP7XiFnc+/iJiv3CyILv1Vq3Xz72xbXxzLbyafvUqePnIAyPUf/oU/n1ctKIt/B8POfk0IbjUVB3W63vjw4EG4Wh6SS0h+BlTkCjZ65yGbvdqm+hwL/wLP6piYmwdzV2S6vMsGXhtn2xns56tyRPP99XQ+fw2xvm9imq7S6yjxROFIqZj1FKoC+Jzff8s4+pCiP4238thfws+kND4lyteCgTgpewRz6ZjujpKI33cxwfFsr3jX1oTWenF1wlEulpHwyDm9HgZ7zBFsIUJsJMTN2j/5Ygn9srGEUItA2WBlv3ihrJBj9RDskLosBSQkutdzgCorbRA0DNHaL2b6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HR7X9up2EfCUQGV2Yw0CkaJ5m2RB0WExM9eJyIhtZs=;
 b=cupJr9FPwHjgVZ2U8ICOde2eVEMtBmHcmo3xSOGI1c9q0fGYgrTyVn8rvnIZsis4OiGAXxStPQ3Q/TUQx5v/nsOLefL/G2Ff7OyGHEnsGCDQs7CU1jFlsPxZ3q4cLV49IPjqflFMaCL+rD5p7pvY2/ubkIniVEFH89XYJzbbMmtEaIWB7k6Rqr2vey/vQ0sEcRrNOdzzU7kdsiV9axLoAlI0WugWWJF2z3G8FwDpuiGczslDUsl8iWy7B/RaWqGFKcwQCyzmOJK14ft8hh21UFtAPB0GPHk0aYefwK/l1yV2o3+A/IHK+2F//LsCbKr3wtMQ4Bsd9JAhk5m6vIztSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HR7X9up2EfCUQGV2Yw0CkaJ5m2RB0WExM9eJyIhtZs=;
 b=i7ELPtRo9KXGRfHBEwc+0WILgZbVP57bMR3StOLmGSacdIMe7p6Jmq0C62IJCbjmosA9fj6P7ATpxMSXiIK4WnXxO59N7XKeBaEvwY5y244tOZXwCc7/q+/1++4HFsj3I40XcUFi9rndQkHZseAmt+87UHaYbkTH5cA/4qt6rwzyrN5RVyiufQoGs8vRIOS20kKxcQVRLusZ1CRQa0wWBeaQEMNg9OlKu5OlP+mAtunHW93pmktwK9LXHnsrQ4+L/x0qBBgCNczO0GX9L/53n4fftq129mVimx1ogejneDH50hShvvpoD+km6VNxx5lpM1+lN8/m2w5/XdDCBaBEnA==
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 06:36:07 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::5340:4193:8d39:c441]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::5340:4193:8d39:c441%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 06:36:07 +0000
Message-ID: <23e3079f-de98-4560-a7e4-7e0f31d4a304@nvidia.com>
Date: Wed, 3 Apr 2024 09:36:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fabrics: Fix fast_io_fail_tmo option
To: Max Gurtovoy <mgurtovoy@nvidia.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
 <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <1712060292-11054-1-git-send-email-israelr@nvidia.com>
 <8f0b2d97-3497-4057-8035-c9466bc62d10@nvidia.com>
Content-Language: en-US
From: Israel Rukshin <israelr@nvidia.com>
In-Reply-To: <8f0b2d97-3497-4057-8035-c9466bc62d10@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::11) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_|CY5PR12MB6225:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BOLBvS1S91ByjYvbuFEelXgzDa5qAO2TW/+GdHaDGcw3YhyGLjxTb4ZdnVfa5czBjkl3K39aTTqO88g8dz7MvpUQZzJniTbqG/C9WgxIZdM1VHFNOXaRSZCV5W+U4Cgul7W/tP6AA5JeRCTzqYSE16+C1h8rCzNM5g7ASF5e4hFN/LEM06txhjGIkPPk2AGZYP+47cbd/uuE8mxbfmtXc9sy+P2iD46W0xn9xurJQq4Ho1OnLBjDQYyvpj0xgtu5E0r6uGT9tHMuRAK5LD54IhANMTilKUsNQw6lZXO/U8waaGh7EblBrv5catQXLz8AA4SkyWfOvtfHySoTPcZ0Y2guM+5XYpcjOQgVZwzCrBAHiNyUERF+TbH48oRGM6/v14xzKozUP4iu/oBrbNjKTepnH9LhIBkUrd2moVEnMjyshubwn2yfm/3IXFlkww+jw6MMqzi8TqmHCiCIpLhmj7FBA7MDiwvcxwOsoJfkZFGty/o3WSCAg4LhE6grFSuoZYPp5cNgn7Cw5hBnmNeTW2HiDWAvAJMXMelSUJqRWo++7zBb/JEnnY5+Tr1WSpIgJP8Gtrj3rzAtgJUgsN8JEWmKMFLOEmAhPKwTCu63A3ln7iQSxfXHrjvs1KEMaL7s7A3T+/N/OEqOU5TkEVne+yMXk4k386Rzsz+wFmhXPjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4409.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajlGY05BZmhlcUV0R2hhdFRBck45TXpXbW9ROXBIV3g1S1JoUmc5TlplNG5T?=
 =?utf-8?B?dDBBM1JNVkFnNExPRjlXN1dZYkhOOUI2Y0ZsdTlmem5URFJ6bGZtK3VuM0pM?=
 =?utf-8?B?TzRwOTJjMkJYSjdkVkZCM3JYRSs1bGpsWmgrRjd1d2c1bnhXamFSWUFTOC81?=
 =?utf-8?B?K29oNmdpVGZTb2VjRWlXQXAyUXJYOTd6eU15WE1kYTBCY1NKWExJVys1cnhp?=
 =?utf-8?B?VDEveVgxbUhlN2F5M0pDQTJTSVpiVlJQSTdkNENOQkw1dGw2QnpZSmZ0VkEz?=
 =?utf-8?B?RVAwUGFUSFdUKzVFVmhES2JiTUNTdldmZGx5S211WkY1UDMyWlZnamRraklO?=
 =?utf-8?B?bG4zMThPY09KNVY0Nld0ZmFkSjdJczJWM0hLdzJMNEZiSE1NNU1SL2JmTHQr?=
 =?utf-8?B?MGJ4SFN4ZEYzcU9oTG4zSTdXelByOTh4VENvQWl4TmU1REV4YVVCNGxtZE1B?=
 =?utf-8?B?Tk1FcXRINTBaR3k1L0F5NzY5ODJ2bTVQeFlxeUhpZVRtb050K05SclhCbjBK?=
 =?utf-8?B?ZHNWL0Y4UWRpT3hGQ2NadStOQ0pyeG5JbGlSamJDR1Jub1pWWXF2TmJ1RFNw?=
 =?utf-8?B?TFF2eUNkci9yVjNZT2pGZlJ6WGdNUmdYN0FIemVQRERvbWNqS3JiY2JGWnpW?=
 =?utf-8?B?UFdzZ0dCeWJKTk0vOFAxT0VvN2luU0ZWaThmRnZMcEQ2NzY2UTdMdHFwRSs0?=
 =?utf-8?B?T0dTaVdRcjBldU91SE5ObE1YejVGc1BMaUdsYkJ4a0lhWXJnRXA2NHVVYlE2?=
 =?utf-8?B?KzRDbFVJalhHTG1QUjRsOVlMUWcvOWpFN2JCL1ZpaUxIbE9nb3pTdnNDTTFV?=
 =?utf-8?B?QmFJWmI0WGNvc1E5VGtDQ2VEZVhWY0JWcDk4cUhoY0JzSU5NUHIzWlJlTkZN?=
 =?utf-8?B?anFUMXpvcVhFVUduWlRIckRYK1cxTE1ubHgra0d0emNhVjhYZE45MU1QRk9G?=
 =?utf-8?B?VkRFbDhDeE5RSG4vSGc4dlE4NkZ1ai92VVVobis5dkU0WnN2UGVTVnRjcy9u?=
 =?utf-8?B?T2J0NTVQc2xvUjhqY20waklOMmxzOVAwcUJJNmc0VExRYWE1RTFOOFhydmpH?=
 =?utf-8?B?WTMzNnI0V3JwNE5ZYnFwWW1vdmtqSjBQTUcwQTNodUh2TG9pdTlpeTE2MUlu?=
 =?utf-8?B?WnhHTW52bEdYcTczMnBydU1jREhtZktibTBQdUNxZytTcW9SRnlRcjZ1UDVP?=
 =?utf-8?B?MElZcElocEsvL0xjM3pkYUZ2S0tOSjQrQ3JJRU1FNndScnJPWVNQcS9aUnNG?=
 =?utf-8?B?clRoL3hhUVZ3M3AwUnM3N2U3VlJLVGc3NUpVQ2lSbVBKTUpNemdQK2xDc0M5?=
 =?utf-8?B?dUdvbDhhRytQQnVNaGt5WXM4dTkyM0lnTnpRQnl6UzdJQUVweEllOWk1YXN5?=
 =?utf-8?B?RzhMNFdJM0ZaVWMzdlB3UUx0Y3dSWDVOMEJUc0VZNi9YT00weGpPai9hbTB6?=
 =?utf-8?B?VnYwOEQydDdTd1JteXp2RDdadHpvMlRjMWpIaXhXanVmUG1YL2V6M0NGZU9U?=
 =?utf-8?B?UW8vOGFrVEwwaUJhRC92K0o3dGJsM1RLUGhhNjIycjJuWFZDd1RsUUZxL2M3?=
 =?utf-8?B?ZUpUeHhOQjVuZ3ZSN255Z2t1aTBjZWErRzZUTmN4Y2k3Y1RyeVlRamZQeEQw?=
 =?utf-8?B?akV4TkR3TzlnNktHUTVrOWNLd3U2UTMzV2k2SGx0SnZEQjZLMDEzbUwrc2dn?=
 =?utf-8?B?K3RoQmpobHRtSzlFbzF0aTlpTXZ6WHNBbDVGY1ZiZGFzanIydXRYdHVzcVh6?=
 =?utf-8?B?eXMxUS9EcFZDay8zREdRWEJ4dUxpelBSczc3aERDVDd0THo4Q3JPVWU2MS9r?=
 =?utf-8?B?TWZwYnBGQ2xoM25yZE8vaXJ6bVRaY2s5dHcrTUZpdXllQjY0TUljdUdpNkc4?=
 =?utf-8?B?dCtUaS9QbEZidTJNRXd3WWxLZjd0c3N5blo5YlpXNWZJcUkwYmdYbDlJblE3?=
 =?utf-8?B?aVppZnhtVndWRHBDRExBL2llUExoRG9wb01xa0doT2huVHUrbnJNcDlFNkI2?=
 =?utf-8?B?ME9FQVYvZU80djByUTN1d0ZCV1IwR0N1RWY2QjMwR1RQcXFkS252NEs5azdr?=
 =?utf-8?B?OWF4cWF4STRwbU1GNm1sRWZpYndIM2g2d1ZoUjR6QmlEZS94VkNvdkpTQ1pV?=
 =?utf-8?Q?cWaRtcJr/J7mjleOjTrxa+T70?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3b735c-78cf-4b57-66b4-08dc53a85785
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 06:36:07.1357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JasEItU5IXOcK11iFfS2pwq+3vSZPX7XpBoku6MI0VS6cRyA2u9VQFclL6sTfUsz4pnFF1sq/j3qR4Jye4fdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_233616_877525_A38E9CB6 
X-CRM114-Status: UNSURE (   7.60  )
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

On 4/2/2024 6:47 PM, Max Gurtovoy wrote:
> In the previous version I've noticed that the short symbol was 'f':
> "
> - OPT_INT("fast_io_fail_tmo",'f',&fabrics_cfg.fast_io_fail_tmo, "fast 
> I/O fail timeout (default off)"),
> "
>
> Any reason to make it 'F' now ?
Yes, 'f' is now taken by "host-iface".
>
>
> Otherwise looks good,
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

