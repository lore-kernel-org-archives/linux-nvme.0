Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440E2C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 17:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=USy+0o+mhIGAQlFrkb9ZHsa61MZ4eCzwBCbP5NigrBU=; b=N31L907UNwSrTzyZOVfHTWBU5v
	JolF4okquP23x5VmCXny2TvdnEq3LV4fBQ9jRWqZd2tEDvEdjVFrvEn0sW0Wq5biMHkIhMMV7YQjc
	PIF2vZLllCKwQTB68GnBM4hhLYY6+Dc6Wyav3newcX/5WBUkh7BkkYe8IXvIqxj7HE6Wsre8sebqV
	4JWQ8iTaY1fyW1xmlOBwsOk+5dfG31BrxgYO6GXFy1I+BrtdfaOGUBa2ChhGpM7jq+zcZ3TX+d9MH
	cLjmQMyOrZljPtUieB/8zw1feBncEtYRRXVdO0ezJl1IuIUK/NbkcVi+/OAVbZ+VmD0RMkIQ82m/h
	gvzrDxcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olZOC-000s2X-Gd; Thu, 20 Oct 2022 17:31:28 +0000
Received: from mail-am0eur02on2099.outbound.protection.outlook.com ([40.107.247.99] helo=EUR02-AM0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olZO8-000rzg-Ur
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 17:31:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQqmqiS3drJ+B6rejKzw4zjrDusgoyd4PSOsIu29EL4Hlur4T/xAmOEzDJJC/Vz+8WZOiIHkDSdN2X5VdRB1cbak3vGTgveg76FPEYIZK9ZR726ehMtGTkr3TsNGXyNRdtB+3FybFI8jfe+j6WsYH/gZnhejlGQ64Q2HrzBggBzivpGMPt9z6KXNznw3l/DveD5zYmSI13YlEc9Q/zcc5DCrBOzs3HUtm70CgwPGovQmcKrg6GJC2HG9RsF2SvgzsNNWZoCPZ12QjL5i+vXDElMklIMy0oA8YlB+Slo13BicjUwuMC7ZY0nmQYGkJgcwZYol84TXmsFZ0t9kmwx1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USy+0o+mhIGAQlFrkb9ZHsa61MZ4eCzwBCbP5NigrBU=;
 b=Vr2xgXlEeALX/PS0bxnqUZhyxze2znPcZ2xT9mBrp+aRP/75fw6EhlRVwk+J8b72jVrHxseV0iiLplMOYfCY9baVKG0G1dS8weoduVIVXNjm6xVl4xeU+mYAnWJVUZwzYOn0DXCJbcnyHxJkFJ4iVKSMCzL75Anf7ipjG8Oor3blGPRtwZ5SbjulB5hnI0GMMSmeK8CwfIJlcq+/R1krQczoQlZIS5YN5VeGbEA/EQd8kQPUBC0LU8NI+lSelRUcDm6uVC3ir+m8YfFTfrzN/G9MkjK1CjySMyaqU1Mi6btylOz4zmzDVEoOcYReH+5dTuauBzVlh4vqzPiXHd1O8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USy+0o+mhIGAQlFrkb9ZHsa61MZ4eCzwBCbP5NigrBU=;
 b=VH5scw6mHnH7SgwSR+szQtHyPc4GKyecDRVzdwVRhUncJdlNj/soORwnGJxCZ2GmbWkd5UAHCnHjLxnukTq5ir14RoF/KjWXWX6pOR0qijJpDnjzB0GQ6/PignijIbs578e5mP+6XSGtQ+CI5mXp3h6HBOjUCyd3LgPQ89zwoIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::11)
 by AM7PR10MB3780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 17:31:19 +0000
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5502:605a:ea4:d526]) by DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5502:605a:ea4:d526%7]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 17:31:19 +0000
Subject: Re: NVMe write protection support
To: Christoph Hellwig <hch@infradead.org>
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <YugctzU0uDZvfAal@infradead.org>
 <DU0PR10MB62528A77489B4ADE66503166809D9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <Yu4nt1bzSynhmeUF@infradead.org>
 <DU0PR10MB6252E237D18FCFB37CB17B8F80729@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <6a50bd55-e8be-283d-1e57-731958bd1820@linux.dev>
 <d92eae14-8ae7-a142-fb6b-26cc40791741@linux.dev>
 <e49c0b48-cf93-9247-6362-c3f2efd40ee0@kontron.com>
 <YyiDufvEa+dEtziJ@infradead.org>
 <9ae13173-44ec-707f-46f0-edbe3c35e0cb@kontron.com>
 <YzqAMcFwXysfS0Le@infradead.org>
From: Gilles BULOZ <gilles.buloz@kontron.com>
Organization: Kontron Modular Computers SA
Message-ID: <9b751b0a-3fe0-3cfc-9ab9-29b887cab2cb@kontron.com>
Date: Thu, 20 Oct 2022 19:31:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <YzqAMcFwXysfS0Le@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PA7P264CA0094.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::8) To DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3ef::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB6252:EE_|AM7PR10MB3780:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbe8468-b266-47d3-4feb-08dab2c0e671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	slfmdHiZApi2aVigBNbdV2Ktzi66auXxrvopHUhMak5JgfK7Ne0c6kQxL/pfEKVeoAq9tUHV5N1yPmYOgK2gUch3Etsl74pa/JtfLZ/TH206Rg3OYEsw2es30NePUz9WE+uiuieVjYLkoZdfI7nn4JQ81Zk3CVUl4NBe9HlDEGUSo5e6KgWkig0ucDJmw4OKMRNwEReLNkpq8bYbalawHnSJGewpF7GbrzKwuYzaC7fLHzP/JannZJeFqeiBtQcTPnQyVacF689v80jb8xtKib8OIvOu56h7XUxIZHzaB6vHWQ0pHNlUzg3HnyZF3XLFOtRYgPiVmGMR5zbUOaVT6VY8L4lup5XQHCKzO2/81+kq/ebsDJD4AfrEGFWuobM/O4JfDF9PjoO9mrb+SdSTjIkvY1oAwrK9/hWaGJt1P3coSRc8XuhVUPhE1ZS3Ro1Oh3pq7EBXoXV2x++BQmSbAHRnWKm4LvhZOw7Q/milRknt656L0bJuiYB4diUP6gaulbWikRrbm+x79x7Z57mGTssC+F8Nu4PI7sGCNve9fcQQktTgdw/2uJFh7YgL2SrslOTqLMyHKptbgJez3oZZts5lAqYFEiNqFqdfSrQUep1fu+8kab+rddSt8o2RkYttGpHcG3YRTitIHRx5hnDi7qbgzYYItU45kJj+rEyrBZxkKKiL4l7JX8+QsrcWe/teWaFZlpuqAqJeKdMb6j5kbLQbR5vV3aLWKve8uf/raViA4Bc5tI6z7S9r46LFIE46IUdvtzOZQK7ML0u8YomQfmknj73vSLUnYEqzznrrPqA=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199015)(2616005)(41300700001)(2906002)(316002)(5660300002)(6916009)(66574015)(54906003)(4326008)(8676002)(66946007)(8936002)(26005)(66556008)(38100700002)(83380400001)(66476007)(478600001)(36916002)(31696002)(6506007)(86362001)(6486002)(6512007)(186003)(31686004)(3480700007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?a3ovNTRUaXhNTkJ5L05CelA1bCtYZFo0TGUyZWZtVHlVaTBjU1lHYWk4Y3Ax?=
 =?utf-8?B?MU91cGVUOVRORGttaGlsQ0Zvbm03WFlreTFaYmtPYW1iSlFFdlhaSE1Pb3hw?=
 =?utf-8?B?U3JzbElXQWR3R3ZVcHJVdUE4OWk2YUNlb09ibDhEdnB5M2g3R1B2OVFGNnor?=
 =?utf-8?B?VGVBZTNYRXBFd1VremFjTEVwdlgxYS9LU2t1elhleVE2UEZDNU5hRG13aXhO?=
 =?utf-8?B?TldWSEZpY2NXd0tmdHBrakM5ZVZtWnUxeXFaTFJsZDY4WWhxZVNuYTkzR2cx?=
 =?utf-8?B?RHNna0JFQUpOTm9CM3FhZW1zQ3JGOHN4bFoyN3hJc0szb0Y3YUlWSGVSaVVk?=
 =?utf-8?B?alNvWWZCb0RJWVFSclc5cGRsZUF0M1VueXBXYnhoK3Nac3pWQTF2THZib0s0?=
 =?utf-8?B?dXM2VGplS2ROZWxBVEx4RklobE9TY2JtODd3blVkK0cyNkEzaDE0eTJUaDZC?=
 =?utf-8?B?YUFraFA3bUN5OUsxNGM1ZFpzL0VJdk1lMG1ETWE2Uk8vbmdVYnVGTTVpMVhr?=
 =?utf-8?B?WjNkWENhZU5HVmNiUFFic2FXTEF5N2hRMTMzOXV0ZUpEWlk1cHpKbnBZUE9s?=
 =?utf-8?B?a3F6R2dtYmZIdTZNMSs4cGI5S1NQYmQyeDN3MGNsSzBmckxDUlZacXU2emJ0?=
 =?utf-8?B?b1hvMUZaVVdwT1VEV2dlUURHemYxWk1OTTFYYkNHc3UvOTNYdG5lQjBEeXp5?=
 =?utf-8?B?VVZqYldJQmZJVkE2WEVqR1c5V1gvaTFsQlgyM3ZNZUw1ZjZtNG1oc0ZsZkFu?=
 =?utf-8?B?czZFWmUvNUJFaHVJWkpJc0xkNUNCdWQzOHRycXo4cXNFL0xjcTBOaFdzaGpZ?=
 =?utf-8?B?UmFLbC9LSE8yazBRYkc1N2g5T0VRRVY4RmZFdGdXMEcvTDA5dEZPRTFJQUd2?=
 =?utf-8?B?bnEzWTRYalJwbG5qNHVhaG5BT0dJanFLdlhMQ2N4WXBpeThyWXFGckNkVlNU?=
 =?utf-8?B?b2tyQlIzZzhpbWxCY2tTU1ZieEpzSmljbVFGNTlQK3lsN2dGRzJzcGY2amRN?=
 =?utf-8?B?clY1VWI5TG1vRWJ5Q0dOZUwzaWlDR0JWbk9pZDErV01NeFUwTEoxZlFndmtQ?=
 =?utf-8?B?aTZPei9sZ1IraytjV1Jzc3V5c3gwQndJZzBPcW1saThTZ0g3S2JqTkE3R3dU?=
 =?utf-8?B?cnMxUjFzWWs0L0dlWnczNS95bnZvaWdFbUxabXFtcmFqcXY0RXNnYksya3BC?=
 =?utf-8?B?OHoyeUtnOC9Ec2tmNG9mM2pxMmwvRm5mNkxpTFMvVDFCak5NazFkTlYvUG0r?=
 =?utf-8?B?c1lBY09EbTlSRjkxQytnRitwV21DY3BMb2NPM2ltNnRJLzdwaFlabHJJa1Ro?=
 =?utf-8?B?RGpBbkE5ODJrWGlWM1lCL2FxaUhCaUE0ZFNUbTFSOU9oQ0FkdTRGWDJmRG56?=
 =?utf-8?B?ZzdyV1NjbUdERWFtRXR5MFppVWhTcC8rbVpnQlJ6Zy9TRFVpYzdrUllGL3VU?=
 =?utf-8?B?d3hFZElNMERXdGhBVmkvbDdabFFnUCtnUGU2eWVUbHV2RTJ1Q0Q5Z2hleWVp?=
 =?utf-8?B?OTRldTFycHBaaHNwckNwS0tsYm00c1VwUm4ySytQVUc3d055QitoUGJUNDdY?=
 =?utf-8?B?R2dVdE5aQ0NnRnowQXNZTCtoNTFMZzNaZmJvMXlEemUwUWJMaXVJWHQrNENG?=
 =?utf-8?B?anNUZjJLOUlPVDNObE5ma3BYUVR1Y2g2ZXdSeFdWS2hIT3g4MFBML0VkN0dn?=
 =?utf-8?B?MmxYRUMwOVlrMlI4LzZUbnJweUpKZWlwOTV0Um8yK1kwbFNvd21pVWlBNkhH?=
 =?utf-8?B?REd3dlVsL2MrM0krQTQ0OHpzRXR1VVhoT0JBNFVyZHk2Z2c0QjQxRzUrWWlZ?=
 =?utf-8?B?VXkrSjlQcW01U05xMWFUUnVYaTIrcXdzKy9SWkZuOUNFd2NUS0ZPWTdJekpK?=
 =?utf-8?B?bENIa3pzRm5XWGtSaTdHM2xRY2NDbk5hbzJDN1JoaUxMZElsOFNWcnZWWVdP?=
 =?utf-8?B?aEdiM2dqTE82TzlrTTZjNlhQaHZwZ3FVbFJkY0NwNkozRHcwTTNpREVOazVN?=
 =?utf-8?B?VjUzT1BEdEhHa2dHYStlQ2N6NDJrNXU4b3JSeXFxcnRVMVBsSkErQU8ycWwy?=
 =?utf-8?B?ME55aU1qT25udVB5cGVLR0ZVOXZaVndURjBzT2pJNUxsamtCazdIK0pnVnVv?=
 =?utf-8?B?aTdLeHprbmFZZlNJcjhGeU1FUDNoRkVJcGMzNTBSbWRBTDE1aEFZWnpiK0xp?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbe8468-b266-47d3-4feb-08dab2c0e671
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 17:31:19.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7/u15V2hk+MINiWUO5fHaNQDZRwjaxktjZ516pWvUq3F8Zy6rV3T+LG4qEmtbqiY2fgdoLWNRLZMTGE7lMIcYmmW/BV90t9gI/m3i0clcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3780
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_103125_229449_504DDE62 
X-CRM114-Status: GOOD (  14.82  )
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

Le 03/10/2022 à 08:24, Christoph Hellwig a écrit :
> On Fri, Sep 30, 2022 at 07:49:38PM +0200, Gilles BULOZ wrote:
>> Hi Christoph,
>> Our disk manufacturer told me their NVMe does not follow NVMe specification 2.0 but 1.3.
>> Is there also something in 1.3 to handle the write protection cleanly ?
> NVMe 1.3 has not write protection feature.  That being NVMe is designed
> so that new functionality (new TPs in NVMe terms) can be implemented by
> devices that comply to older versions.  So if you just set the bit as
> described earlier Linux (and other drivers that know about the feature)
> will still do the right thing even if the compliance level is left as
> NVM 1.3.
> .
Hi Christoph,
I confirm that setting the WP state in the Namespace Attribute (NSATTR) before Linux boot (without changing it later) leads to the 
expected result : writing to the device file when protected returns "Operation not permitted", and booting Linux (Fedora 36) from 
the device leads to filesystems mounted as expected in read-only mode (writing to them returns "Read-only file system") giving a 
functional system.
Thanks very much to you and others for the time spent on it.

