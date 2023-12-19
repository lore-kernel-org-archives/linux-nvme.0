Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4310C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=baN8nImSBKBLQmJyElcaqE4QREh7oO7NQzpEacqSzIg=; b=r+YX+2BnSfR74pLiCE6Wk4U8m5
	exCq8oP9VwquZhGDAp7WG2KcsxRBA2B3cdVMHQdZdZhyIZFHn5y0e6xhYI9Eenc9QdTskmsz26elk
	fuaC08iFhm34CzTVARk4vHhEjv7y0OwDMdlM66Q1qJhGCWW9QbK1qdK0Sg7uJgFGGYaaFG1q4+UcX
	AzV2a9RQsHrWzLObPz7QtySPjio4SdwASuVK/vdnp1YWwxR1ASPhMg9RhlausTH4j1e4HNmvG+4L2
	29Jm5E1zmqVIi7Obh5hT2XI65gbOgaNU6wsoUXu67adscXasME7ECbP5OmMk1YuVPPYQF1vNHxTdv
	Jmw0Eemw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFbIp-00EPmP-0T;
	Tue, 19 Dec 2023 14:42:35 +0000
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2009::601] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFbIm-00EPkZ-08
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 14:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqRlpY14uZXnPeD0ETWMfRHLaWa3GLJwMO9aalIBkyj7Hgsjnfw+JeuEBjVUhUtdtpmIGURFDolg5kgW6g/Pxg1gIy7ZXA96SlsnOyf/VRBbyBKrcNVCpEJD1Lsa02yVvL2raDct78QQ9vIR5Gc9UM5X72HvqQ5yr0ctM6XuZ7ULaHe59m/n55gOcVAEAibqQj5e4CIzC4/UXpqV7nLxOam0jq9LTpq+AdgOyZLf/6bXsd5tTfSvYSIRFAOOzLMOqEQvB4Ba+sgRo9zgbpWy/XyJsicYtgJVEjrwYUNl5/WmF+ZtEWwHxVwtHPxcJP/oFq+zRQ4e3oGz/EAp5m2zGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baN8nImSBKBLQmJyElcaqE4QREh7oO7NQzpEacqSzIg=;
 b=UsCdVBJYJP+rET64f3L/5ZFD79mQ6j2Y9WP1OwuURfKb91LkZhtVmJr66vmRZQEK19GEL7zpFkm+S4fw3aaXA7kBChnZzIc6Z61wV1V6E/yQeU61bc+gTz/aRqADoQB1IsyiInWuGl1bI+w6EwLRH+c67ocTPqX5RpVlFt0m+70rktnJWHJW8rF7w8tOqN4Tsyt1gjBuvWUqnUBCu1DXsxgb035wuNYk3DvX/hSmbs/FMOw158AWq3W7GcOE/flbFGCpkZP4nt2pnqDjw9bxfPlfW4FRt7MBJNn/30r9NNz53ntp3SA/r4Umx38qXmxBcsuO4xjUGIEUB7IVpJK12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baN8nImSBKBLQmJyElcaqE4QREh7oO7NQzpEacqSzIg=;
 b=Yu9lYrTmKSd83p0FNlu7G2DJ9nP1Npm+GR3ulinro/KmJ/Z13yGx+Z9p2G5S+WWaGE5bg6hNYDMVjl6mhF93ITNjj7RTL7ObVwXY7gINcZwtbd4bupHF2gRFx0uC14diwBvFM+QEqKYjAvrFff7K6KwykJloCqHNjXIsbKBf/2n2dTHy/eHG0QStGkWnFrMe92wTZv75A6vdpKqKojmY4j0WePjVRfRlBn2ttGVPMe/jNB9EDQma2ryqaX8QnciC/Rq1oBaY5upnx7PjKBWjZB5FW+HIIw9agOZ2HfCILCtC7IvlAzcoT9Ic3bZXNbx88EdKhSCnyvWSdzHR061aUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.39; Tue, 19 Dec
 2023 14:42:26 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:42:26 +0000
Message-ID: <acd4f5b1-b1d7-40e0-ac80-573e2d5cfe85@nvidia.com>
Date: Tue, 19 Dec 2023 16:42:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] nvme: add csi, ms and nuse to sysfs
To: Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20231218165954.29652-1-dwagner@suse.de>
 <ZYDN_G-VP2_pn3kC@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <ZYDN_G-VP2_pn3kC@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0160.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::19) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c92d742-f570-48f1-9e2e-08dc00a0b7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AEHO73r8AaSBMfv3s9go3FfvK0Y2wYhQsjAcSSsqghCd27R8Ju4KPhtgaeDzJmG55o+K0DVLkwE6rJDE6uo5XtsTg5cgydR6qPYEengUTLi0/jA7wKK04bHKVnCkeHpYO6b3ArMB/N/k3E8wOOkk3u83KVhqZWC7VIH6o3YQVONf+J7/CBDpNq4Avm46TbDCgNjkQl89sIukG0tgsz224Vm1e+k4LgymM7BFOrU47HU52DVlvU4r9wSV06LapvIjiYRn7shR0pNJAK3mSzWj+sK14hYHkHapCxAV/yc1dwZx7IGTzNqex3inc3lfGeeiL4gRN8bliuILz2rWTRIwigvlKWMC0DBZ/xRA/ZXzq2h4HzYspERTo/CfL9WlDf4dARjY7y+2KkVHryT8DT32iMrvJ2OPM1YwSV+wLgQ+d8fMleVB4Bqur+dYYq65vKrWpZ+QmzkvqGUGKXGVuaXwrbtfuEtMXkMEkfOSN3ZMWl0Srpwbo/zJE9+2+6l7OIEgbrY3mNOJv1AZrBL+a+Ut3KiQ9YapuFgPV+UPyz5ZFc4EeX0uZ6cVM4/RwIYBcxt1FiQO4mHIp6RY+YKVTUiQApepeibi4PgeXPJlo3wCC9gpFotvBS9/p36+54KXzbRu4wxUMuF+UrJRJRvgFJqdhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(2616005)(107886003)(26005)(36756003)(86362001)(31696002)(31686004)(6512007)(6666004)(6506007)(478600001)(316002)(54906003)(110136005)(66946007)(66556008)(66476007)(4744005)(4326008)(8676002)(8936002)(2906002)(5660300002)(53546011)(41300700001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ai95MFlEb0U1WWNIOG95R2JOd1BYZjNZUkRPL0l6cXpvQkJ0bXVGNmNxRnF4?=
 =?utf-8?B?YnB4RDIwMUppM0ZleURYZklPaXlUUjdpU3paeXFQQXJYSGpjQ0pBcHp6MjNL?=
 =?utf-8?B?dmI0MTV6blFnRjRtZXlRM2NVWUw2RzlBQWlyYWdHYndZRjVjVVp5ekxPb01G?=
 =?utf-8?B?dnc4Y25Feko1cTd1Q2lISDBXU3hmZ1Q4MUNNZ0pqTkdNTG5YenFOS3huTnpz?=
 =?utf-8?B?VWpwclhtYkVJWExMNi9XTHVwZ01sWWpZWG1ZbFRGNnRuREhSR05LckpaVFJp?=
 =?utf-8?B?bERWdGNvRGMxRlZiTjFjVHVMUG5vV29NT3c5NWVDdmkrUmdrTmtFaUtBWWht?=
 =?utf-8?B?OE9DZzJGOU5lUnZiVzVuc0I0cmZTdTMzV3U3UWRDRk5zRzRtMHBiSUpSZmwz?=
 =?utf-8?B?YVpPUEZHdUtKZms1WWx2S2ZKY0ZZdm42OUNYa04wb1k1RW4wY1hUait3YlM0?=
 =?utf-8?B?SWNaUkRDeE5CNG5Nck1JUzR5a1kxcG85NW5Ua1ljYzdvOWN1U3hubXcrNy9v?=
 =?utf-8?B?Q1R4ak4vTVh4SzBCY1YwZkgxWGh3MGc4UGllTzdaUWEreERmSzR0aVhic00v?=
 =?utf-8?B?a3RPYmtYWlY3UGtLTDNOSVZxTFJRTjJZa2NYdzlvaldGQnBmcmlESDBoa0V6?=
 =?utf-8?B?WC90Q3BqUWI3MU1WTEx3RGNBQlUrVnRONmdVVXR3VGw0dnJSVElpdVp0R1Bp?=
 =?utf-8?B?UnVrZnlFUG9VMFFWa1BaWjAwUmNndXY5R2N5WlNnM2ZBOHpGVXMrUXRpM3FZ?=
 =?utf-8?B?dmNBZ3BYY0czRlY1a0dxN21SN3ArVXowaVZmMlRYNHg4NkZvbFdWSkN1U0tR?=
 =?utf-8?B?bFZhR3pWa0RuQTFRK0hlRndvd3Vod3RQZ1A0WVVGNGg2d1dONGRIWmNoZ1dB?=
 =?utf-8?B?OExMaUNOZDNGamRKQVVqL2lCVFR1bmJIamcyVHpqcyttRTJNTmtQTWtUTEdH?=
 =?utf-8?B?dXZLWTF2ZTJPUGV5YlpsL1pIZWV0WVQ5UEVBWjd6SmtNb1V1QlRONk1vVmVy?=
 =?utf-8?B?MWsrcFBzTUlURjI0eEVZaTYrczF0NFNsVWRNYlZEOFJRV0lQd1lTcW44R3N5?=
 =?utf-8?B?RDd0K21vdmdjNlNPSGwvYU1kTFdwOU1sU1JWMCt1Nm9yTE5vZldWdWVaazg0?=
 =?utf-8?B?bFhWTVcwMHRKWkF2SExadWlWTlY1MHRkWnhTSVhWNmIxZi8wMk1ObzJSa2ZF?=
 =?utf-8?B?WWFxbHFKN0FYVHNCeXljd3RmdFNXYTdKcTA3SEpMY0Npbk1wVGFGWUtTbHI2?=
 =?utf-8?B?TUlsNGg2c3RDcGxFR0tvSmRRUWw0SHVhNXFhbzcwWTVZbFpIUEpQQlZEUC9O?=
 =?utf-8?B?dXlaZVhrcmFEdkI2cmI3SWt2eXcvNW1qdnQzNTJ6SlAyTnJCcDloWi9lVVk2?=
 =?utf-8?B?aUhQL1lNSzBET3R1a1pyTGpZUU1Zc2JIYTB6V0xDNWZ5M0gyMnlCZEkrOTFH?=
 =?utf-8?B?Vnd5NXJ0WjdLRktKUmlUMXFjS1BqUTl3Sk5oNnROVTIxRzlpL1BtL0NtWGFV?=
 =?utf-8?B?eXd4VkNOc1VlUTB3V3p3Zk55VkluSTB2TENad240VU5ZS1hZTnhXVjNGQ2Yz?=
 =?utf-8?B?NnQ5Z29PbUduSlpaR2V4Tkc0SmZ2UXh2MEdkN2hNZVFKejlKRzhqV2pyR24v?=
 =?utf-8?B?Q0tpaUY0WldpbGExakhPdUxsS2lQU1JKZ3pEWG95ZFJ0NVE4QmJneGtheGVL?=
 =?utf-8?B?NTYxdERCbEQzK0c0Zi9aWnc2UGJzc3BpckJudE9jdDMrV0dJeWRWOUxsN0xT?=
 =?utf-8?B?cUZDQlFTVWpsV3BZaGp1d1loSWdGT1VBRUNnQWttc1lIbnpoSmhsVjRyS2lj?=
 =?utf-8?B?YjExeDEwODdSUGVLQ1VVeU9aOERkVUtsTDVPVUZZeGg4aUYyZXhwNWhTZVNq?=
 =?utf-8?B?Y2pVWFBiTnVDdCttZXFhRzNYTERHNDZQQjYwZnovZWhpbEs0Zm1EeFZXa0Y0?=
 =?utf-8?B?d2NhSjdHNFUwZGlqRjJuajIrS3lGTTk5MGFUZkJtb2laUXJ0ajVpSW1ZZk5P?=
 =?utf-8?B?cWJFaXkzdllSTlBwRDU4OERVRWdCWjA4VXVzNk1pMWZPeEFYcjJJNDRkNWw3?=
 =?utf-8?B?eTFuM0pJTW02N1FDYjNlVk54TkpJVmJWQll5R0lLRWZJdFN5Q085TWZNZHU3?=
 =?utf-8?Q?LMs7hqPSXxYo00SotHvDGFITF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c92d742-f570-48f1-9e2e-08dc00a0b7bd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:42:25.9745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBC7kDDtQlIjTcKLiczVJs15HsnDsfImiwsTP2nSTsPrGOpFk1p7Nerk0nBNmlWZRr7m9zTKGNmqwB9YNyvtKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_064232_173023_9EC40913 
X-CRM114-Status: GOOD (  10.49  )
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

Hi Keith,

On 19/12/2023 0:55, Keith Busch wrote:
> On Mon, Dec 18, 2023 at 05:59:48PM +0100, Daniel Wagner wrote:
>> Rebased on the current nvme/nvme-6.8 branch and added the Review tags. Also
>> addressed the printk format issue pointed out by Chaitanya.
> 
> Thanks, added to nvme-6.8.

I'm rebasing my fixes to the PI bug (which are not trivial) on top of 
nvme-6.8 and Daniel's series.
I've found that this branch is missing some fixes from the master that 
I've added manually to local nvme-6.8 branch.
When do you plan to rebase the nvme-6.8 on top of master ?
It will be helpful, otherwise my patches will not apply cleanly on your 
branch. :)

-Max.


