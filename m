Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893D7C4167B
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Dec 2022 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=10HlNeOsoQFn/FRFUnZcNlYh5zBRUB8hgyQWAKWAoHM=; b=mKIy5ubV5GqKUTlOf/2DJifxLi
	qhf2m9E1md3FB4dZ84NGTRNq2jLT5LZZJVQBgClu+CDY9iJ6hPYBKIWpFSDR8khm/uBs+yZiax2Ha
	1A9UPt7p4oisZp+6iUfz1bIE+nbffVLHrhY7kHTH1Ym0tKq+cGB4y7lUyyuf5lUiRYEEx+oT6DPPL
	l7rPlgqAzsXtnUib1QynYNBO+NkIzrpqEvs+kU4lOZr/8yIXhleH3eDKULPDGXp2CxcwmYe6pjTv3
	DqHFUqRrrlgo6f8xo4RdOmPYsNFwTkYTzkYNDguTcJ+19KVEV7MQnoacGQggNpj0NEB+QxibzBCyo
	jT8Rtfcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4MHX-000ess-Rn; Sun, 11 Dec 2022 13:22:15 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4MHU-000elq-R2
	for linux-nvme@lists.infradead.org; Sun, 11 Dec 2022 13:22:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670764932; x=1702300932;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RztrDnNT2eY1ztKijWBaI3J/CIZzZZxiDZRs6Kx9kbs=;
  b=lMRdtJUs4GdJl5DboWeHOBugh2Rhe/nok7osMiOL8+zp7TTczokNAB2M
   CPUh72owTtSd/3moLOJOZO4vfby5DcKh1mGxbInWs25zJMavf2XveN61y
   fzlOxFGq4NXj91FdXDOQmAQLDEUF2fVph+mobO5oe06RHBkVJ3aCxVeio
   3KSP/J/tKVfc4q7KaP9AZd5cqBCE87AjjsNnFyOTgMt+vDzc6hUHy9dAB
   goYczCZi5e/HinXzASIuHWF29nd9AshMGTHD2vAixfPK0htopEBtxjLGl
   KJbDBo8kCbCy+VnET3gmcpLgAz3ySrejtkPuRxZHoY4ZR1fPzxJ/AlbAY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="315336653"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="scan'208";a="315336653"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 05:22:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="716507454"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="scan'208";a="716507454"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 11 Dec 2022 05:22:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 11 Dec 2022 05:22:02 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 11 Dec 2022 05:22:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 11 Dec 2022 05:22:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 11 Dec 2022 05:22:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpftOkHoKIQvUaWo582Yjhij6EAh0lfG8VsFBiUrOBJMeZJBjIIjoht07rsvrXJz7sTeZcIir7BEaxpAbmPmk+nJE2hENGv+cv12uNFWanDmBWfKiw4BCtNIOL+Wnc3UbD2mNVdtaMZxAF/Rz1eX5w+tCbScP21fXv3JD2LVEbJBG/4+pnlF8Af3Qj7O5bxmQtlrhyBk7c64yUZL7XXcZDnbqT7yNmIiX+QBE4QI/TUDYBjX0RtiZPKXdU+majxePFffvNPGS+ZQFzPr/YyQXyaQyNiPr6K/+cmlV5tncaS+JxVG62TsQ5V/jwya18WWXirfvBNcntB5HyMzOE2fzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10HlNeOsoQFn/FRFUnZcNlYh5zBRUB8hgyQWAKWAoHM=;
 b=UXsDyM3UU0hCndHC5jiLnIylgdJBRB1rLeMqX5UdqvyrhxNYLqHkCt3o4O5B6Hndmx1VBEo9Y57dfY519jbBKZKZBs2KdUw04uC49LUYclcK8FhtAhT9+3ckPXYSPIHO1QrUK/vvjRp3a78s7q2bApYjDPu/p2PZgXIe9f3zXgy36U9r1EfrHgRcWiei+tf4D2MuG/KwB+FdxaKshzn8vlOB81dBjwDFGMp4af3boL48ieTFHQSBD9JRoTnsCuVDsJRVNdmzU6zAIbe+j5x8CFq/+wqBrExKPbS/lZqZsOM0Kb/pS+1d3BNKwd2//ATqzFGkUZkJf/6ZafbU97GWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5640.namprd11.prod.outlook.com (2603:10b6:8:3f::14) by
 SA1PR11MB5900.namprd11.prod.outlook.com (2603:10b6:806:238::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sun, 11 Dec
 2022 13:21:57 +0000
Received: from DM8PR11MB5640.namprd11.prod.outlook.com
 ([fe80::ba45:6089:4ce:18a0]) by DM8PR11MB5640.namprd11.prod.outlook.com
 ([fe80::ba45:6089:4ce:18a0%6]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 13:21:57 +0000
Message-ID: <cf88c2ec-bdd6-1df3-6c77-64a17dc3eb86@intel.com>
Date: Sun, 11 Dec 2022 21:21:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jason
 Gunthorpe <jgg@ziepe.ca>
CC: <kbusch@kernel.org>, <axboe@fb.com>, <kch@nvidia.com>, <sagi@grimberg.me>,
	<alex.williamson@redhat.com>, <cohuck@redhat.com>, <yishaih@nvidia.com>,
	<shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
	<mjrosato@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <kvm@vger.kernel.org>,
	<eddie.dong@intel.com>, <yadong.li@intel.com>, <yi.l.liu@intel.com>,
	<Konrad.wilk@oracle.com>, <stephen@eideticom.com>, <hang.yuan@intel.com>,
	Oren Duer <oren@nvidia.com>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-6-lei.rao@intel.com> <20221206062604.GB6595@lst.de>
 <Y48+AaG5rSCviIhl@ziepe.ca> <20221206130901.GB24358@lst.de>
 <Y49JNvdmRPNWw26q@ziepe.ca> <20221206140002.GB27689@lst.de>
 <Y49PqoAhZOeraLVa@ziepe.ca> <20221206143126.GB30297@lst.de>
 <Y49WNo7XWZ2aFfds@ziepe.ca> <20221206150131.GA32365@lst.de>
 <9bc8e614-a687-e419-f9fd-e3177cfb41dd@nvidia.com>
Content-Language: en-US
From: "Rao, Lei" <lei.rao@intel.com>
In-Reply-To: <9bc8e614-a687-e419-f9fd-e3177cfb41dd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DM8PR11MB5640.namprd11.prod.outlook.com
 (2603:10b6:8:3f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5640:EE_|SA1PR11MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: ad908262-54b0-4d1b-f7b9-08dadb7aadbe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y29nvz6AWbOMkcn7brTiHKyf2OEFVoBlzVetdpj/+FimYczG6WQIhdoe5JauZ8IFIILRgFk9MflQcvqvALjlliCKUfqRj+3ctEZDY8b0jkuY/bQZJkUAUIILot/ehPIS3wsB6BlCssrn8iToW/tqc18q2/2Foq7Mwsv6MPum+BnWuze7VCfhxhjaLebWLGsuUqW3bHX0nPL/AZyvrV1tLM9pRgv8uX6hAu/hZV7KxmRplKaQp4retM8iJFwKmkgCU0au6bGnGA0BBGZWRCrQsqsEL8vb7IgnPM5ONXXtlfQZhhIqCXr02kChmoSKv1MywrGOlsPdQzwO4CKvL0nBUpPNDRzWStubkRaZp7KpZySSoCF41JGjKQ2EBphoYH+s1k+CXVJAy4xgDlyBc8d/ujS7jHLvq8Ndm8xguvLNN3UNquyHRpJMYDHnVceElr2lcjLQPpdoQp5/p2iDH+t7rWcSzO+7nm7ZN0xgX11dNX+0FjM4hr43RLxIKv7NEbw8bGLeV1uO8ymAUb6a+zsH9Upru5fJadbew0PXmDiChA+LCJUAYsq7hs6DgQfNMz+XAeRUerO/qecUwmw1CedQdRoMB8PNjAVV8XNbLtKyoWL6alIfpRNLgK/9SQD6OVxZqxKMgJRLlGBFvXwR7npGrWqOTVuKPrFQKRH4DC2TPCgldhHq8FkUULCcKyRbV4Jao4+fMCjh6/n/qJ3mAMXWZxAmTDVDEoMFl0sx0GSO/HE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5640.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(36756003)(316002)(83380400001)(6506007)(53546011)(6512007)(26005)(186003)(6666004)(110136005)(6486002)(86362001)(31696002)(38100700002)(66556008)(8676002)(4326008)(66476007)(82960400001)(66946007)(66899015)(31686004)(478600001)(41300700001)(2616005)(5660300002)(7416002)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEdLaS9zWkxXVGUrNFFxckNGKzdadi92Sm1QZFAzc0tNUjZIVGZrS3pGWUhz?=
 =?utf-8?B?ZXhPY0t3aDhWVmsxRUpYYVJqb0ZXR0FiMTYwbzg1RkpRYnMxRk5UeVlhVUFp?=
 =?utf-8?B?MWloNlk4UUt0eldSbysyNWdJYmpSdTBESTRPeDBWanlGbERyQ0c1ZS9vbU44?=
 =?utf-8?B?bGhwRkFPY0MxZ0V6R0g2ZjFoSllBd01iYUpPaWtlV3dkNXd3MzUzRmZlcXBR?=
 =?utf-8?B?bzJtQ3I4bmZwNzVhd0dvWi9EdHd0cE1MWXk2bUlFMmcwRTF4RVVINmVWR2Iz?=
 =?utf-8?B?b1Ewdjk0Vy8ySm52VWI4TmdkRXZ3WHRWa0JpbzhaTEs4U1JnditvUStTYmtk?=
 =?utf-8?B?dXV1L3kyekVGNTJWSm5tTGdiSkVzdzl5VzJuWWhzUnN3enFMYnhqL0h6bDYy?=
 =?utf-8?B?ajRZRWYreUdhQ0lvcWxOUE9ET2tlUCs3enM5eHNtbTRMUzFSUWpyZDFKRXNF?=
 =?utf-8?B?cEE5eUQyR2lWUnpmdWlXTy9OMFI5TDhKdHdTeHlsZHFOZ1VZMnFTVGNzNVNG?=
 =?utf-8?B?VlNUQXRzZUNONjlBQ3FsY0lXeTBWRjJPbmNBcFJmeDNUSktuRVhnZ0VZS0Z1?=
 =?utf-8?B?NDB5Q0lQSVlYR1RpL0tRSndIclltUzB4VU5rcWpzZU1vZ1c4cElUTGF3ajhx?=
 =?utf-8?B?MU5LaFN0bENieVBLZ0JYejBtR2R3bjVIcFdUQ2JkdjN5c0kwd2g1UStucnRD?=
 =?utf-8?B?SnVzbk9PRWYxY2I0TnR4djUybEZkV3BjNlE2aXZCaFdmVGkyQitwQTFvNGV5?=
 =?utf-8?B?cmhRMGNjbDJnVkRZMjRvN2VuRzJFRXdKWkoxaWVFNjNWajBNTnpkbURWWGxu?=
 =?utf-8?B?cTJpTllCc0ovUUJKaStOeUZjZGdUbVFXSWptWUVWWXkzYUNUdGNua2NmTzB5?=
 =?utf-8?B?ZlNtTEQrNXdwaFI1STNwbWlzVFVUV3ZyZEgwQ2Y3NmRPeFpJRXJ0SWxpQysv?=
 =?utf-8?B?Zk41UzFkWEJ6VlR6NmtrandsTngvZVJjS25DUEY2NG1GSEd1dDRGbkhZb3Qr?=
 =?utf-8?B?bUhQd1huenNwckxiMTljMzRPeUJ0Z1hsNFZCckh0UWdQOGF5bnBjQ2ZtZEwy?=
 =?utf-8?B?STJsNTFVZGFxdHdVWHZuLzBZRDI0R2NEbUNaOHh2TG8wU3FZZ004MG9laXgy?=
 =?utf-8?B?MEoyVk4rVGZKbHR0TTFBV05IN3psODdnV0J1cFN5ejEySXZ3aWhLVUdRc2tk?=
 =?utf-8?B?NDVjUUFNcFo2NktWL2pqUVpKaGpCc29qNWU3VW1GUzRlaThUTHBhL0x3ZTBh?=
 =?utf-8?B?TmdYb3JkK1JaeXhwSDFkbHhtck5rK056TDhPZFIwcTRvQTR4SGFEcm9saTly?=
 =?utf-8?B?bFRRZUoreWhwT3NtbURLRVpaTVZmSGNKenlMellxcVdQOFJLV21aVkVWRUZt?=
 =?utf-8?B?VVlBb1NpaTJKQjlHSzJGRmRmUUkwRFVrZlhTTHdnbWxTUnQrVHArT3c2WG4v?=
 =?utf-8?B?cDV0SVhORUVtMVdyOFRPWmttODBpSHdRZXFySGpUaE81bWZ0NkY1NDA3ZVcw?=
 =?utf-8?B?dU9PMnFMR0ZhczltdmFyNGhhdUMwblR4SUtJdUxBTk1hVjZDWXVVcXpQcG9P?=
 =?utf-8?B?MjJTbVRWLzVQemdvSExaMUlEUEF4cFBrc1R4NzNuSUhuRnJ4dndaMENLNlpz?=
 =?utf-8?B?czNDMkVOUzJORWVsb253eVI4cnZNb1VXOWQzRnRHMlJXS01WNUlCaWEzdmJK?=
 =?utf-8?B?UXprUlN1RXdCYXkrYWxid25rd1RJd1JVakQwMVpUdlpXRDNTYWVsV1c1bDBH?=
 =?utf-8?B?bU5SR25VZSticTJqWDFLYlg4NjVYZkU4SzNDRlBYQWhpRnlUZXBVYlFlMVhj?=
 =?utf-8?B?TVpiNFFSUi9wY29XcG9QK0dQZnM1MllqTTQ4dDI0M2FuWGF0TkNKTlFtNXI1?=
 =?utf-8?B?YThmRE1rdjlFNklPbWVlTElxUnlTcmNseXVQc0JTRURUa3l5bEZjdUcyOHBn?=
 =?utf-8?B?SzgvZ3R6M21KNW82OXRIUG1ROVpyRVpIa01DUW1HZGV4Sis0aThFNEVYekxP?=
 =?utf-8?B?elNYUzFBSFh1aUhPSmtQZ2JTS2s0UW41RWp4SDBhQVBwMkVITXE1ejhWOHBr?=
 =?utf-8?B?bDhZOGVWRlErS1lWM1M2anRtMk0vQUg4NTMybkJQK21EVXFPMk1tM3lkaHo2?=
 =?utf-8?Q?/DXIZqvHbqJVm7MFkIejqSqOH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad908262-54b0-4d1b-f7b9-08dadb7aadbe
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5640.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 13:21:57.7562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8fb9RO4A3rZq0LVz7lIvDHYKQXYhtrsoxeAEmC6n/xsEZS8DYLXdtLw3FcMJhNqt2db2q7qYksxWmkqfJxKAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5900
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221211_052212_919741_655AC5B5 
X-CRM114-Status: GOOD (  24.69  )
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



On 12/11/2022 8:05 PM, Max Gurtovoy wrote:
> 
> On 12/6/2022 5:01 PM, Christoph Hellwig wrote:
>> On Tue, Dec 06, 2022 at 10:48:22AM -0400, Jason Gunthorpe wrote:
>>> Sadly in Linux we don't have a SRIOV VF lifecycle model that is any
>>> use.
>> Beward:  The secondary function might as well be a physical function
>> as well.  In fact one of the major customers for "smart" multifunction
>> nvme devices prefers multi-PF devices over SR-IOV VFs. (and all the
>> symmetric dual ported devices are multi-PF as well).
>>
>> So this isn't really about a VF live cycle, but how to manage life
>> migration, especially on the receive / restore side.  And restoring
>> the entire controller state is extremely invasive and can't be done
>> on a controller that is in any classic form live.  In fact a lot
>> of the state is subsystem-wide, so without some kind of virtualization
>> of the subsystem it is impossible to actually restore the state.
> 
> ohh, great !
> 
> I read this subsystem virtualization proposal of yours after I sent my proposal for subsystem virtualization in patch 1/5 thread.
> I guess this means that this is the right way to go.
> Lets continue brainstorming this idea. I think this can be the way to migrate NVMe controllers in a standard way.
> 
>>
>> To cycle back to the hardware that is posted here, I'm really confused
>> how it actually has any chance to work and no one has even tried
>> to explain how it is supposed to work.
> 
> I guess in vendor specific implementation you can assume some things that we are discussing now for making it as a standard.

Yes, as I wrote in the cover letter, this is a reference implementation to
start a discussion and help drive standardization efforts, but this series
works well for Intel IPU NVMe. As Jason said, there are two use cases:
shared medium and local medium. I think the live migration of the local medium
is complicated due to the large amount of user data that needs to be migrated.
I don't have a good idea to deal with this situation. But for Intel IPU NVMe,
each VF can connect to remote storage via the NVMF protocol to achieve storage
offloading. This is the shared medium. In this case, we don't need to migrate
the user data, which will significantly simplify the work of live migration.
The series tries to solve the problem of live migration of shared medium.
But it still lacks dirty page tracking and P2P support, we are also developing
these features.

About the nvme device state, As described in my document, the VF states include
VF CSR registers, Every IO Queue Pair state, and the AdminQ state. During the
implementation, I found that the device state data is small per VF. So, I decided
to use the admin queue of the Primary controller to send the live migration
commands to save and restore the VF states like MLX5.

Thanks,
Lei

> 
> 

