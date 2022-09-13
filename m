Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C8AECAAD8
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Sep 2022 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wEVbpnF0lyl7oGZp9mf8sf5usOI2ZBowxUHqjXmw5Do=; b=xeXVaBt3ptWxIAav8kJTo88CGk
	/rxO1hnnW2Zk1uOMqJqJOjD+fY+K/ZZ/OgVJ023Dgk7zcIie8uThQLPX2eztn8uPXNX5rdSvrQNs5
	kL3c9RDHC+F35U+cWblWFA2n+nug57adfrbUIijK3YQsox5AhvBP/wVnAfsDCvaWQkM0BIUqb8tme
	FL2dO2UTlmH7KXgJ+VM9LOOm93+f1U8GvsmW8++Kk9/q6PoTr3WSK8wDPsy9VyyMY9NOFerS1HAZz
	ZSQCC4wjKJflZNLI1fNqsoYVEX+NPd/LbIiO2tsoy3ydo5TSjrKSmbBw7ilLsBwgU6orbpkqAT4ZI
	xzeccD8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oY9Y2-00DtKt-Jv; Tue, 13 Sep 2022 17:18:10 +0000
Received: from mail-eopbgr80134.outbound.protection.outlook.com ([40.107.8.134] helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oY9Xz-00DtFk-48
	for linux-nvme@lists.infradead.org; Tue, 13 Sep 2022 17:18:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIbdwzR1QkFj3rE1rz+S1onaI5frIhZdqyVCF3oxwR0FFWd88GP6+pMAzfGGkcbLi2oq4Zoqz5qtgrMrLlZLajWP4I+d5a2Gouu5u0uEwHuwpJrL7/raM9//aMN92PHD7Abio2DwFse8y2NSWbtBtgehR6ohYC1Iih9TsZZVjgnm7af9UKY0xrZd8oWJ97kVxmdw0k1NCW/ilKyA4h9wk+mQhKd90vrRANWsKLItMoIx4czpMu0TqvNpXIPguf6vaKohMV6ckEO5OpjYi72EIw6Cd94/8KHRcPwIgE6nu8olvY4vmI+Bj+/RjswW7pvmq+1x5gici5AU9cV6H/MDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEVbpnF0lyl7oGZp9mf8sf5usOI2ZBowxUHqjXmw5Do=;
 b=F2aX2VSO0mw36TVh0gtqwFalNqbY+AN3f0lTDYRpYB99KR5pq0jjVtwVvfWPgTSLZ7uXiLXvv78cTvmhnecq8O+YWP1CFuUO2Ha1tLc9I5owLb4OnWa2JbEG/wdSHJGiz7piRRdNTSzaV9UPwDiKMlOhWwPmeb2olSm6jGrby+v5Ba2wqeEkJRfsh5yLOd18ljxeDqrfw63zlopTh5gzLFmszPGExtRFTf/2fJ0jeVxTCTigY+T62Ro84uwLRGhK0j9fdu18fncJ/kMFEwSYRoGsMGpF/nj3alaaLegZJPEnRJdk6L+aU1iwo4LlqGjPmG2ur0PIsbSXMgfREYXTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEVbpnF0lyl7oGZp9mf8sf5usOI2ZBowxUHqjXmw5Do=;
 b=BhY31/QQciaIOshN6Kme/PUI76EHqIILmVEx2nEzOfEPOd8/ZoG/757P8Jwt+guFLD9vrgJ/sVzwTsjFbGmaj1C6Kq6mCwCC30GrE4Lqz00Og0ehNZb1fWh2lBpClbbGidLZAqEfyA82Mit6INp+CHJhusxIldiaPwmCgqKYp5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::11)
 by AM9PR10MB4038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 17:17:59 +0000
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1dbf:7734:757b:af45]) by DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1dbf:7734:757b:af45%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 17:17:58 +0000
Subject: Re: NVMe write protection support
To: Jonathan Derrick <jonathan.derrick@linux.dev>,
 Christoph Hellwig <hch@infradead.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <YugctzU0uDZvfAal@infradead.org>
 <DU0PR10MB62528A77489B4ADE66503166809D9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <Yu4nt1bzSynhmeUF@infradead.org>
 <DU0PR10MB6252E237D18FCFB37CB17B8F80729@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <6a50bd55-e8be-283d-1e57-731958bd1820@linux.dev>
 <d92eae14-8ae7-a142-fb6b-26cc40791741@linux.dev>
From: Gilles BULOZ <gilles.buloz@kontron.com>
Organization: Kontron Modular Computers SA
Message-ID: <e49c0b48-cf93-9247-6362-c3f2efd40ee0@kontron.com>
Date: Tue, 13 Sep 2022 19:17:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <d92eae14-8ae7-a142-fb6b-26cc40791741@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0205.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::25) To DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3ef::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB6252:EE_|AM9PR10MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3d3ba2-135c-4143-b840-08da95abe7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	CwnjvQ6Fr3nz0Zi7EYYEMuDTznMAe3lW5FKdeISjTs5dOrg6gPYomTpasZrVqB+DMJxsumoLvXcNgX+5Ta1IM/M7ubjnd7rtKWHNHsIlVbo3L2sdiCkmYIrA2pAa569wJQnLI9JEVOwtFRcZYsNP1+aXMQBTtnNzfm/Ui+6ufKc1z6dBsjwD2SwjYIQM35hfA0WQ6hFvNaYOLloDpj2kv2YvDYszJVCmuEN+d72llgdZeHTwKY1pXd9FsZCliNAr8pM/Lz3ddk7YboROlnYSzSZshUVYcVKXhlQ7hiG2fk4TJcHHt3hKNGd4xcYabyHnsgNm209R+grRkPyys9MWxtXDImPsBuTdHlX2aurf2RlFllJ+B7uT69w/t5Qyx2w5JJMnHHKmEleYhKKQsLmxrRTlGSM8xD9+P2qrzGCvAa2BwPREgGRi0IqHea5BOM7sAOVxG+zEPrNRAdmr1vhCCnk5pUh5IiF6d8I2Huo9DX2rClaTHoENlPG2VTVXPHwtdVMfcsrLkmg0M1PwgkEcgMr3HyXigRRD5rZDzJH4LGMECwTg7A7M35hLlu6wQ34wO76wLVgjA+Jkes6Gwcgub4w0EwYuSRM5A6zLDiwyMXOzsayPlOyRDDaljKI7HT+QFyJt26/zbQzMEbPvPXcul8SgvEcr4KdWL4JutHVLc/m8L7QmUy8YVq9N7ABQgs+Yibp1iCz9kq6ilw+oEja3JaH/fgL7jbXRJzAYH1wQAS44ctba85qs8k7U/Sp9dA5rmxDpMy3Qa3hM1rvML+Tfhb3uJXpbA7WGrz8zC1xdm1y6kcvUhciMdF/mybeTsPmtm/38fBe+dYionzHnmuvvng==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(66556008)(86362001)(8676002)(316002)(31686004)(110136005)(83380400001)(38100700002)(966005)(3480700007)(8936002)(478600001)(2616005)(4326008)(31696002)(6506007)(36916002)(41300700001)(26005)(6486002)(66476007)(2906002)(53546011)(186003)(45080400002)(66946007)(36756003)(5660300002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?RHdZeVp5ZkdpZHM1WVlpdHU0K0tpYWR1WWp1RVo4eEREdGZBaWlWWDVaaFU5?=
 =?utf-8?B?ckNkcHhOWjhEUjhFZXFWRC9VR2JySzhqSW5iQllwbEltUkNXTThYNlVqbElw?=
 =?utf-8?B?ZWNHVHJzVDVRaURRK01CUkNjbENkM2RWMGJlM3ZWdnpOd1pTbUdZRU80MUZ5?=
 =?utf-8?B?Q2hlc2t5eUMzVy9ZR043M3hST2xueTFHd0dtVWFWa1JzdVhMRkNzcE5xSUE0?=
 =?utf-8?B?QU56cjVUdjdjbDdpRDFORDA5UUNLY1Nmd2VpVDRSdDNwcTVZbkRnVWlpTUs0?=
 =?utf-8?B?MTdRSFdqMHJYRTVXcVpLelF1Q3R2UkhTMjBRQUU4NGxLUUF0ZStWWU5ZcjY4?=
 =?utf-8?B?SGsvd1hYRnpUR3NYV1ZmUVdSNCtCT0FqZEY2ZHYxNDJFQW4zb05DWGNkZXRx?=
 =?utf-8?B?NEpQei9HVmt1UCswZElrTTRBMUtwZ0x2VXA1ZHJPMDVYSmdNMVp1blpTTllR?=
 =?utf-8?B?Q1ZURUExV1BOYlB4emRUS28zb21La1RDcEk0d0ljTzMrTDZqak9oREhZcWNv?=
 =?utf-8?B?SFlPcyt2Y1FrREJpS3VLaTNRL1FMS25MV3JZd1BHSTZ5dHFONmxkVlljREJS?=
 =?utf-8?B?SVRFM0I0b3pzYU10TEN3YTRGd2taTGNYVVNkOGF0V3ZtbE5rVUFsclY0dXpO?=
 =?utf-8?B?MCtKTzd0d2FkRTdvSzNSRG9MbzJzNnNFUHRqYmFUeHFwREp6bURNUGJaRUl4?=
 =?utf-8?B?dTBUY29aSE04MDMzRjY5ZjVWV3p2VVduQTVucVAyQTc0YjQyVFlSZTlXTmJP?=
 =?utf-8?B?L3BJNXhvczZjVVRTY055STdULzNVaDQrdVRNcEV6Wkp0OE1BZlJrQ3lucU9w?=
 =?utf-8?B?NHFWVXF3UXZPMlRaTUdDOWlYN1BUWm5WclZNdllWSkJyS29taExzcU5zVVJp?=
 =?utf-8?B?REFqSVRPb3hsZUd5MHd4TXhjazB1eWlOZ3VSdFpXa3BWdkxsQkhKRGNnMXpS?=
 =?utf-8?B?dUNGN2dsdCtkV0kxdDQ2bW9WMnY2TnljRDRMWW9HUXJtMmYyNnRyZHBDVUsz?=
 =?utf-8?B?ZTlWQ25WODZ1NUF0N2R4YVp3OUF4QldMNXpBaGpoNEdnWkkwS1A3UWlQRi91?=
 =?utf-8?B?cjAwdExtK0szQ1VSditNalIzODhyVmtqRGJsUzFBQmV0bDd0Vnpwaks5Q0pC?=
 =?utf-8?B?TTFkRklPT2RubExGa0ZOMDExdlFFWlozZlNpTmlGbjN0MEZkY09FbThrU0Zm?=
 =?utf-8?B?SGZTRmQvUFdNT2UrQVhOMXo1cG9VK0ZVRmRtMmZEVDdIOUtrRjAxUHRCT3hr?=
 =?utf-8?B?MFA0SjVNTDlQNHVWMkFwSExSQVRXZCtPRjhwZHNlZk9iNk5VdC9mbVAzK1Nu?=
 =?utf-8?B?dGFGSE5TVmVxUm9lODhra3FYaEZlWDdYTzFTRzlNbk96S0dZTEphM1ZKWUpt?=
 =?utf-8?B?V2lJSUhNR2oxUDU0VVZESjBmR0ZhR2xDQkVBYXh3eE1xdmI3Y3l2NUtudU9J?=
 =?utf-8?B?UFFsWjJ2a2k2REY2R3dIREJQZkZlTU5COEUrZGx2a0FCTTY3NDJ0elFwLzl2?=
 =?utf-8?B?VWtCZGtPQVZxSU10TWFEWmYyZXB6SmgxcWZIRXcyZ2hsRXovbHlrUzhMYS9j?=
 =?utf-8?B?emFHY2sycFpZcWFDQjdJd2RBRTJmTndFaC8zblJKRElTOHZISmVSendwbDlw?=
 =?utf-8?B?N0JCU2h1ZjgvZzhTR3NlT1diSnJySGt1TlZqTnhkdkxYU1J3dUpvaXh5dDZz?=
 =?utf-8?B?b2c1MURCc1l1N3BGRVMwVzVZcm1xd3pWdEkrSVNuRHVWSWZKNi9jQXVnd0E2?=
 =?utf-8?B?UTA5M3FBWXJpdWNFTmFpaXZ0U3dyN3QwSFFKWmtDcGpIcVNnOVJIZVVxTDZH?=
 =?utf-8?B?RkJleXNFVWowWGMxRGErSEcxdmFCazJnOGpoM3hLMEFzRTN1bGh1K1l1UXFj?=
 =?utf-8?B?ajdZRjFjQlBwOVN6Q3RyWkRpZUI0RkZVVEJpZHpQMzB4RFk3Qk5QY0tLYXND?=
 =?utf-8?B?ek5vUGFuRXVVOVN6T215bmRiVzNIVEl4bDZPbThYWU5XbktYVVpCVTArSVJx?=
 =?utf-8?B?MnhjaCs0VUFadlBFMHdCQ3Z5OFhoUWVCVThaSmk4T1lRQXd6a2IrdTM3UzB1?=
 =?utf-8?B?TXV1ZEQxcDZFbEhPYlpiU1NTTW9WcG11QUZ4a1QxdGtmWlkwRkNCVitRc3F2?=
 =?utf-8?B?N3hKVUpIUTBrZy8wMWdLKzczdUNPZThCMjlRakpKZFcwSU12Qmx4dy9BdEVP?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3d3ba2-135c-4143-b840-08da95abe7d1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 17:17:58.8667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLpwKPFvMtnrONS58UfVKI2krNo9krRiSKEXSDEeynZu6NlVNSpFAYR3Qex0/QY/qNSJ5JEfzAJayYN15xc/3XqCLEVN21hBWDfoseRBxqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220913_101807_286017_7D9608E3 
X-CRM114-Status: GOOD (  26.28  )
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

Hi Jonathan,

Having a look to the specs at chapter "8.12 Namespace Write Protection", I see
"Figure 430 defines the transition between write protection states. All state transitions are based on Set Features commands unless 
otherwise specified. The initial state of a namespace at the time of its creation is the No Write Protect state."
But in my case the WP pin when enabled would make the initial state of the namespace at the time of its creation be "Write Protect". 
Or I could simulate a transition from "No Write Protect" to "Write Protect" but this would be without "Set Features" command.
In both cases I would be out of specs.

Also if the implementation is correct in the NVMe, and assuming the kernel already supports this case gracefully, what king of 
kernel message would I get (in dmesg) in case of a write to a protected device ?

On 8/26/2022 9:40 PM, Jonathan Derrick wrote:
>
> On 8/26/2022 1:39 PM, Jonathan Derrick wrote:
>>
>>
>> On 8/25/2022 2:26 AM, Gilles Buloz wrote:
>>>> On Sat, Aug 06, 2022 at 10:35:00 AM +0100, Christoph Hellwig wrote:
>>>>> On Tue, Aug 02, 2022 at 09:20:02AM +0000, Gilles Buloz wrote:
>>>>> Sorry Christoph, I'm completely newbie in NVMe and don't know what
>>>>> "Namespace Write Protection Config" means.
>>>>
>>>> Take a look at
>>>> https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Fnvmexpress.org%2Fwp-content%2Fuploads%2FNVM-Express-Base-Specification-2.0b-2021.12.18-Ratified.pdf&amp;data=05%7C01%7CGilles.Buloz%40kontron.com%7C1d97e0a70c1c4da35b4c08da879acb89%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C637971396556129208%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=CUa2QovHH9%2BWJH001d3vDHrSD%2F3KyKuhigo4EuQ4GbM%3D&amp;reserved=0 
>>>>
>>>>
>>>> and search for this term.
>>>
>>> Thank you for the specs.
>>>
>>>>> What I mean is that all the NVMe content seen by the user is write
>>>>> protected.
>>>>
>>>> And that is what this feature is abut.
>>>>
>>>>> Our NVMe manufacturer partner has dedicated a pin of the module for
>>>>> global write protection.
>>>>
>>>> There is no concept of a 'module' in NVMe.
>>>
>>> In fact this is a M.2 module : a M.2 PCIe SSD one. A M.2 GND pin has
>>> been reused for WP with a pull-up on module, so that if the module is
>>> plugged into a standard M.2 socket this pin is connected to GND and
>>> the module is not protected. And in a socket providing WP on this pin,
>>> the write protection can be enabled by setting the pin high or
>>> unconnected.
>>>
>> In other words, your firmware needs to set bit 0 in the ID-NS's NSATTR
>> field [1] in the Identify Namespace data structure(s) when WP pin is
>> grounded.
> s/grounded/set
>
>>
>>
>>>>> But if we enable this protection and attempt a write (we should
>>>>> not), we get a "critical medium error" which seems a bit brutal for
>>>>> a disk that is still valid but just write protected. So I would like
>>>>> to make sure the NVMe manufacturer has used the right method/status
>>>>> to report this write protection, and if possible get a less fatal
>>>>> error feedback.
>>>>
>>>> It seems like your manufacturer needs to read the NVMe spec and
>>>> implement the correct features.
>>>
>>> Yes, that's why I requested some tips from experts like you to be sure.
>>> And with the features implemented correctly, is a the case of a write
>>> to a protected module already handled/expected by the kernel ? and
>>> what message the kernel is expected to report in dmesg ?
>> Search for 'Write Protected'/'Write Protection' in [1] spec.
>> You will need to support certain command Status Codes in the controller
>> to convey state information on commands that may change the namespace.
>>
>> [1] NVM Express Base Spec 2.0b, Figure 280
>> https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Fnvmexpress.org%2Fwp-content%2Fuploads%2FNVM-Express-Base-Specification-2.0b-2021.12.18-Ratified.pdf&amp;data=05%7C01%7CGilles.Buloz%40kontron.com%7C1d97e0a70c1c4da35b4c08da879acb89%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C637971396556285269%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3xwpGWKfZwzL7PAisPNw9zRJTubYQjNxtoK3jCYufYU%3D&amp;reserved=0 
>>
>>
> .


