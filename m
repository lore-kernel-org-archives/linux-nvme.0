Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7600DC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 17:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xG5YddiReqvXPNSpdv/OrIBj+NyRhXhn285gJz7nwx4=; b=2/593Z1pz5359nnXz5uzLB/QZV
	ABV0IxSInLcYG4CfAtE1HvnyksnOQ7WTnfCBqvp61apWuDIOa5s/5vceTJoqF5dqf9wfuiLRdKCca
	e+d4ymLXSL6QKmA8lDmGjGqKNOpuqOOHmMglkuasETuPY/rEj5wxBP2PwB5RKZIQ/ACYCd7LxBcJ1
	Gh+4HK+37QFQNX2hj8qwbFwXZ3ks50LUPc9ikwuH4TPCjZ181d9dfKSgMlKOaZklAfu7ETifUMBNU
	D5YMTzqTPujqlSC6le5vVG4qIFsp5p8ZkfW3c4gxbEjJnTiL/0H+omavrBIh7fe0dfcmvqVruzdIb
	hqWv412g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeK8z-00Arte-HK; Fri, 30 Sep 2022 17:49:49 +0000
Received: from mail-eopbgr60129.outbound.protection.outlook.com ([40.107.6.129] helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeK8w-00Ars4-Is
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 17:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYfEUGz8baSVgLeFnS/kZFUZzxh5mQA5HGun4CkCLQyvwXjA9ZV9c96Fy2yO0WBYHozHrt4VXgHcC7cJo2zHwwGvy0BWTfOR+vnZ9QLyNRX/0fce92ZT3RtPllspRIUXU3NZw+ETlfxTcViD7pJUWeMTi0wvcyS5vwuq5OMHGzpH8R8TEFF3zRzJgdB7Epflf8ZUT0EJV0fpt++mPzVeSK0f/2xozQ8Y+J/ho3B2QHYQWBxJriJm8Kk1QrTa7xV/PrA03zwDrLOw7oAXsKkObiA+fEIvL83q7HoytzfA8Jq2NeXR5kbFFSn3tGo1r9Wb+OUb1Bn3IV8MRT8WpwfIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG5YddiReqvXPNSpdv/OrIBj+NyRhXhn285gJz7nwx4=;
 b=Pjud6pqi62eRaCeUOjO69K6VrmZSZ7k8UWLRWEQX5rxnH5MwpH50+syljjrX71wR3xMjONBMnwu8NChQdKr0qoPWKGAGEevKqj0wqTYfqZ1gm2twUv5QtoMuKm7TIlGUyiTn3eJOEUDvgiTa1y72lHmeIBuQF5T1ByFRQ7npDA5VPSEa2xxbZF1Fexz/XQjlWbM6agY1FDZ4wyP6iMZzPUSMA/g2Ys6iFz6GRCMNMaJIyFbBLniacEZ7n+RoyHfiCBbnAHazffyPVRE4y50E01ggL8UKAZnOdj5WTTp8jDePTKruxs6v8PB0DWJgqqgggzNF6McNEgDUZaPq1+FDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG5YddiReqvXPNSpdv/OrIBj+NyRhXhn285gJz7nwx4=;
 b=V96fupYctRcWCwIUVjjsWvVP4Nl5qzqvuSEomd6876CZAPQe2C2jJZK1Bh9DnuIyHbxLe+CvC3RjIf9F9HUHTXb/qy1orip1warFLa8d+0nkKDNNzfMGRoLmAaOBMeBHM+meS7W7a2LB7TxNRjO7sxNmWlI4zHgmmYxc9YXt8js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::11)
 by DB9PR10MB7361.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 17:49:39 +0000
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5502:605a:ea4:d526]) by DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5502:605a:ea4:d526%7]) with mapi id 15.20.5676.019; Fri, 30 Sep 2022
 17:49:39 +0000
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
From: Gilles BULOZ <gilles.buloz@kontron.com>
Organization: Kontron Modular Computers SA
Message-ID: <9ae13173-44ec-707f-46f0-edbe3c35e0cb@kontron.com>
Date: Fri, 30 Sep 2022 19:49:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <YyiDufvEa+dEtziJ@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PA7P264CA0099.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::16) To DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3ef::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB6252:EE_|DB9PR10MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0a6bd5-dcef-4d83-917b-08daa30c25d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	92NL/vptO1GDpFkWJpxppni4D65LRvwJ69DFRwcTwzhJtjpQ1TDZ7JHG/JCJijBSzXL2laaoWlKgFqMuSVa+o2B4c9tUiojXpvcKu2E/IG3plIYEWBRIG2OaE6K/f7JzS4ZBHAp6Y44Eidu6MV2+87WOwFpGEGIViGfTjVMT0IsSjA3Ax4/dgJ9wVgRQTXmpCxZUxPy7SP0x7WzqYn0jc8LeVXO1wVUjXugxS5SK//CORejMcSso6rQJ9UlSP3Fs/8Y0knIb4wz4jmmmNIo/bDwcLuD8M50pus2h4s1ApsxFjO8+EBCiUwmCXpQvGHu0HP9oltX8E/dZIhVV9ukoCZnK3QJCq7A9eRbWWHiIkaJxMJcKt2o2RAPJcnbi7DovEL7KSIblljIZnvYdNJqRzA5Dvk2NsF6J33sSlb9VWca51SapG0m0VmUFQCiPeFWoxtCrkEcke3ZtVV2lyDgjuvsfaXzAaXDURue91C58mtd8/84kXDVhY9ADF+rO/+PgvXkIWH5OZ8vh9arSifjf/9ORVfTTA232XmJRUcNqImmUyYyMtZRLg3QVbn2NCUI8+8zi1AkqdXklKfOtN53RdrcK+IAysVSJsQx0z+2FYDm3bmJ+R5M4vjSUNETB1IeFLQrcNYLxbf7L1jmBUlHBrycP5KUi+EUph3Wdv4JusO1FHCRu+JinWFg5VvRtaYrx5PGxXj2LvME0qR6mMXuv1wPdVpQUksaGtc/EJsVtsyUV1RaZDSbkQuYqKV/fm2JCp5/HPrO22CkHXnpQNGiMEz9wqaAsDsKvGeGYCxSCffI=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(8936002)(38100700002)(5660300002)(6486002)(36916002)(2906002)(6512007)(6506007)(26005)(83380400001)(3480700007)(31696002)(186003)(2616005)(478600001)(86362001)(54906003)(31686004)(41300700001)(66556008)(66946007)(316002)(66476007)(36756003)(6916009)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?ek5HTjRkQWp3Rlp5dDFuRFBQRUpXZkZtekJXOURBOXJSdW9sTUFONVdHZ0lP?=
 =?utf-8?B?S25mRlBlY1JrRHZpNVAxZ0xIRmtxNzFFUmZQclJQaTBFd2I1RDl4dFZScWUv?=
 =?utf-8?B?aTM5SWN1WWlPK2hTSWZuTHBRdzNxQ0p0Um5zbEdmMngwTkI5dTlzZWpHUGpU?=
 =?utf-8?B?ZVBreWVvam9yTDVQeXFLcHR4SkQzemVCR1ZiRHpjVTdpUGk1dHlobEZuVnZa?=
 =?utf-8?B?MVEvSVR1SVQ5aUEwaWl2d0JMME5jMjlCelpWZ3IyNWpGTk9XMlNveWExa1li?=
 =?utf-8?B?U2kveG5kOUJvR0JNeUFBcVZ2RzlvRDNjQnI1aWNxdUtablIrRWxZei9NRk05?=
 =?utf-8?B?OEdoeHg3Z0t5VHpFWEpmdFJ1SVRZeXMxRnVkOGJIaXN2ZHhqMTNNZU9wb1RF?=
 =?utf-8?B?RmltdGoycTl2bVg3ZTQrTkx5N2VtT2FIYWRvZ3ZrelQvVStpUi8rcWJGWjll?=
 =?utf-8?B?aTVWZ3BNaXRGSFVrM2hpcXJCNjRYNERnQk5yV0JRVlpNblJ0ZkoyVXVUaC81?=
 =?utf-8?B?c1RMcE1NcC9DTjdmay94ZERwMlJYZnNCVWdtT0xsY0tFQ1ZyMnZFMnV2aTF6?=
 =?utf-8?B?TlpyMlpCR1FMTkZwT3R2QVpvWXd4Yk5WOEV6Y2ZjSTZhYU5mUldld3ROd21R?=
 =?utf-8?B?U3ZOc1RvdnBaeUg3OTJLZGhMaStmUjM0L2QxSE1JVitTVGlDdnhMSnpTUE1k?=
 =?utf-8?B?ejBJUXMzdDRROWsyUExKbGFYOVpNWC85bm9CRG9HTFN5QUViK0JzbDRkTTg4?=
 =?utf-8?B?VGpVNUFHUGZtTGNnZnNkTVZwbXU4SG4veGJteFg5cUZoc1p4NEt2L0JwSC80?=
 =?utf-8?B?WWNBZUdGa3lZV3BXamtXRXJHYVhhUkI4UmU1N09pRXg0TVMwZUczRjlHeFR3?=
 =?utf-8?B?M1pWUWZVdjJDT0J4azdJcEtIRnZZL2hoWGFqRnFNZ3NMUWYvdFlpb0hXS0pT?=
 =?utf-8?B?cDBwdENlWEk2RVM2VGJnZVIzZEtGd2IrUTd3WWhXNVhEK2pYWmFBdEtjZjJu?=
 =?utf-8?B?SnJZTktZMUxJZFBTNnhQRTY5T0MzYjJzcWpLZG5RdjZDUlpYcFBpWVlPQVUz?=
 =?utf-8?B?cnovOFBZc2g1b0xkOHZ6WkNDaysweWtlOENUd3hRS2JuQVN3d2dNWlpKZE5t?=
 =?utf-8?B?b0J5RjVNbnhwOXVnVVdrdmo3SGs4Zm15QW42VDRDcmNYdXU2N01Bbm4zd01W?=
 =?utf-8?B?VzlUVHhCQkUwT0JGaW9LWENaQmJBdWNjbk15alc5b1VKTjcxb3pFTlNPNncy?=
 =?utf-8?B?VTB1MElVMnVybzh4d2NxZ1ZqQUE3ZGt0TVNQYTFkUFZpdElsU3lCNjVRdDFX?=
 =?utf-8?B?OU5yeFMwNktFMDFJSVl2K2hZai9kSmZBMFBzdjA0MlRZNkdSUDQzL0VoSGJh?=
 =?utf-8?B?REx5WGhxNHlUQzFjdFdONDR0UVcyVmhtNTF5eDJlamVUNkh6SzhxTlFnSlRh?=
 =?utf-8?B?OEpNdjRUNklIalV1WENZcDZzQkFnMVZtd0NnSlZ2L2F4a0NxSUc0YnE1TVpa?=
 =?utf-8?B?b2FqZWN3YU54bW94eTFQQnpXZVpSb2F1UjkrTGJZUGlBbGwzWGxhQ0pzcFdt?=
 =?utf-8?B?cy90VmMza2JzZG4vTlAyYWpaWW4yblJvSE9BSUdQMFJxNVVHWjd4QzZ1MDlP?=
 =?utf-8?B?R25MYzkvTUt3emlRc3FFOEcwRmQ0K3h2UDdMRGg2dzhCaFVrY1E2anlIaDZ1?=
 =?utf-8?B?emtudHlaSWUzWTRKR1VmK1FYejk3V1haTTFoVkl1bkNjamQvRUFUdWNmajFo?=
 =?utf-8?B?RTdMSk5nb1NycGVCZFFFc3l5bnB2bWhrN3podFV4cDRVRVQ2a21YNjBkVkdR?=
 =?utf-8?B?eEw1YjMxY0cydnAwcE55TEJ4bzVNSHgvRWxTa2QrMnMzODNqWFFBNEROKzR4?=
 =?utf-8?B?SVh6eGZDaVVtOFdqZlFENUJRNzlDWUlXNzJrUWxRV3hKVWRCUUhiUkNCc3JV?=
 =?utf-8?B?aHI5MmhqdHA3TTVsam1nNjdYNXJnS3BZazVWcDlFMWF4OWlNaHFJL1VUVXUw?=
 =?utf-8?B?ZFdDU1NBalNNMlI4eXZWSkgvS0tZZkJzbGZPbWg4eERXdnoreFVGODFaVGt3?=
 =?utf-8?B?U1BEQ1lDY3dpSmJtZzBtejdLUENNSm5JUXVjUTBsNTJ0YVdOQUN3engzUFps?=
 =?utf-8?B?SkVsR05ybXZYZG11d1YrelEyZEV3NWU3Q29HeWQwb3REOGhUcWlNMDZUbWth?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0a6bd5-dcef-4d83-917b-08daa30c25d2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 17:49:39.7088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzlp+d9kUX58pFSnwUaQkZoCCwsWNG5J9poHZ16Vjm46wlLA2tNrn01rAc/2u4oHM2fkP4akwh8aLHmUQ5DKc/2S8kZebVPtCEC39EUU+L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7361
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_104946_844421_A90843C7 
X-CRM114-Status: GOOD (  22.05  )
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

Hi Christoph,
Our disk manufacturer told me their NVMe does not follow NVMe specification 2.0 but 1.3.
Is there also something in 1.3 to handle the write protection cleanly ?
Currently the only thing I get is a medium error, or an I/O error due to an aborted command leading to problems even when working at 
block device level (using dd) : the device file /dev/nvme0n1 disappears ! So I can't imaging what this would do with a real 
filesystem on top of that.
I'm using kernel 5.18.13 (fedora 36 with updates)
Thanks
Gilles

Le 19/09/2022 à 16:59, Christoph Hellwig a écrit :
> On Tue, Sep 13, 2022 at 07:17:57PM +0200, Gilles BULOZ wrote:
>> But in my case the WP pin when enabled would make the initial state of the
>> namespace at the time of its creation be "Write Protect". Or I could
>> simulate a transition from "No Write Protect" to "Write Protect" but this
>> would be without "Set Features" command.
>> In both cases I would be out of specs.
> I don't think you need that.  Just set bit 0 of the NSATTR field in
> the Identify Namespace stucture to 1 and ignore the Set/Get Features
> parts.  If your pin can be chaned at runtime, make sure that the bit
> is updated based on it and that the Namespace Attribute Changed
> AEN is sent when that happens.
>
>> Also if the implementation is correct in the NVMe, and assuming the kernel
>> already supports this case gracefully, what king of kernel message would I
>> get (in dmesg) in case of a write to a protected device ?
> Opening a block devie that was set to read only before will return
> -EACCES.  If it is set to read-only after it was opened there is no
> special handling and you'll get a good old -EIO.
>
> .


