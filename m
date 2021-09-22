Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D351C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 01:16:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E4E611AD
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 01:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30E4E611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PUl4vu5hIdeh3BYfnlv07lzw6pu7NnkdBpHdh5ni9fA=; b=0q6oXMvVKAier6
	YOWpTI1gY6AaajjHzwUoNByG0k57zeHV1p0fiZit6Y3BZ5sF+BKCuD0e12VfAxY1G0fFSPnSCkpph
	rFm5/BNF/iARCZc2W6ZhbpfbVRnVHJUf+F4v/A+MqyGViiGE/PkZyfcEM1NMzFWbxlPpVkIDzguHr
	cYpi2kog84Og5Edq90529n4MpoJ+1MnkXJkBzcsm43Ba75ttzDoRKM/sxrnwtwwwZJ5B0G8WP9mIc
	HkrO9VnikX9EZCTEIqnfKdLuV/vk3yx7HvU1qo1QTWQ3WS8STHN09ewFLAhAM3+/3RMcnPPjGgpax
	X0BBQAk35TKtdVB8hVDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSqrQ-006TL1-Pb; Wed, 22 Sep 2021 01:15:44 +0000
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com
 ([40.107.93.61] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSqrN-006TKG-Jw
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 01:15:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/H/xKH83xK06EkueT20JuDeyeRadkrbZ7A888JxzbjkgRmHaKIxxgEl9JWIZiUANqEH9MAcCzrtS2Be3yelGhUeGFI/FcVFvaWe82ExUb3uCdImr7vRyuHlFhwQjB3i1h4jOBPfCyEYvrY5LTpzbhgjg5j362jhx7GPWpJS7ECVDsW8IgA2KKwVJU6ZlElVJbhwI3KlE3vZuGylYHNIPEeaEApDyDnobTHeJohlw86f6TSRhJuTvxXPB/UqpvzSE7zhvBohmtAPhutftZZDefzmxaHrnpThMqSJmDWcwE844bofqigWSTj+ZQpwIualeKE1qr3hdCvifTd1yMkk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=kHFtDYqkR0L/61U2pb+EliIpENhhhQHOaxI9/0YTn9E=;
 b=OeyyKENVOWsSU4B/+VI+ebYALFVqBE9o3pPskvrjSRLkMWYo/jBjFR3H3dKITIMwXQ0tfW7d/Xh0jQZLgTr39KxQxNd6n1FR2JBbji2XCIlh9EArlARWaJY6KewBxoA479X/yBhqZTgKaRMGuLinXz8fcg56YXlf4Pd2tQaIRlKzLhjiz8HZUEQkk5TdJ/EEV8C4e+/82q1XJrZOoMFCARbTJggDy07P2LTQDbjoH/WaMuJwiIWI5f0QYH423YTAgeM4Yf2CkcJG07bGSp6Qat0HI0+RMBJIIik1+lCvCLYTzyNv2MRf9Mn0V2fE0/zdZ4xq5v4LV5ylgK0cncTA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHFtDYqkR0L/61U2pb+EliIpENhhhQHOaxI9/0YTn9E=;
 b=d4r3ZqA1oG+f8oHMeaZybsw8NvveSLPKkcsNqhY+j0g2XHrLqUpKswkWmvW6nN1gMGdveJC2YlFDteVqrisoNjmWSYWg4Vp4lC9FQsLofPIcfh5G6DeP7uFeg8Gtfg67GoFS2nnxfWphoWigLib8S9ruc29AFCsvyBCX72T6+y0G2STxISq0rWih7yawu7hy2yItEBTjLyL5ZCDVtZUw5cQuhpv793J4xEf6VoAZ1EU5MBzmpWwuwgppEi54HaXr5cIEGv6SaBXngBUiGg2ov9/b8r3I8l/TOmAqPABQARQkcVIKKu9mqO7RM9xX0Ep+D6k5UixWyTpaSKoW3Nm21w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB4665.namprd12.prod.outlook.com (2603:10b6:302:2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Wed, 22 Sep
 2021 01:15:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 01:15:34 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/6] nvmet: make discovery NQN configurable
Thread-Topic: [PATCH 1/6] nvmet: make discovery NQN configurable
Thread-Index: AQHXrvv9H5vas7Sdt0+jK/sXDb46rKuvQLaA
Date: Wed, 22 Sep 2021 01:15:34 +0000
Message-ID: <26c0e93d-a0f9-5e91-80a0-1c76337ab993@nvidia.com>
References: <20210921151529.29419-1-hare@suse.de>
 <20210921151529.29419-2-hare@suse.de>
In-Reply-To: <20210921151529.29419-2-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfc9cbef-addc-48ca-3d12-08d97d667a69
x-ms-traffictypediagnostic: MW2PR12MB4665:
x-microsoft-antispam-prvs: <MW2PR12MB466590F32EC377AE54CFF4DEA3A29@MW2PR12MB4665.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k5NxvV30FiREyDeUDe315cI1xfOp8eyJfapURTxjqXMr4U+73LMfq8JDGef+8oX1XpLyp+nLgr0/Q7KETsj4/AOsR7LvxW0xv5n+r5SHS2N6KWC/YlBXDFJ9TaFs8pforwPiVpUwVSn3+WgaboFx6kQ/BFTPpqy55Qu8XTrZqPgrPtaeZrjT1qnGhxwMJ4QwrLnCPi4briPNhhMk7Ii7e46wyzugQudJTGl/cW6IJcDl8WG6qVHo5Rbq20/yO2MP+9y7hsNgvtO2UG+tdBDfE8/xmSj3DS1FET6qMSgmAqtseDMEFJAvH/LiJd9K2dpYa/NQtrlzcMRnOt8tH0AJsdxooadvlEx0bXKVXihiZlPaTbYSlrvfpuEYNVqVlQM3NXbsGf/BQImPok7XHmUoYrE/iF9QbjkH/nW+1dZfqshGmxcf14JaG8BRtK+sxC/hwJTmbTytJun2IDIfav5z6oAeAmFVNoKuCik8Hf4RKffzdOthKUgi0lZOOoxcjz2k7+4YebBR3ZpEcHqP0sa4Bs9tV+eBQMCfAZPSp+rZUOa2jXHZhX3UO/V1V/bqQR47NFaEGPfCkvBoikRTIgD1OM35gQE4cS7XUEU476vg47AdPWf1qHClwdyueFznmfn1+dr7DDJYJOqE1GCmfPcj5Y1OTZ4WIoP5Vp/XMP6fqTsIJvSyPZJsXH7O3TKrG9k4/b8LaEbM+YVV95e2BIhgFoob5KOkEQSxrz1DeNEPDGOgNAOeparwoi5GknRrmAT+WFEGAgMPRaSTVNOfxV/Lmg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(31696002)(36756003)(6506007)(4326008)(91956017)(26005)(66556008)(122000001)(2616005)(508600001)(316002)(53546011)(186003)(66946007)(8936002)(86362001)(38100700002)(2906002)(5660300002)(8676002)(6486002)(71200400001)(6512007)(38070700005)(66476007)(76116006)(66446008)(64756008)(54906003)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjVKQ2V1QmpjbE4rUEl5QnNNWHljOXAzNFpYMFR5Q0NSVXZiZWtvdjJ1K3No?=
 =?utf-8?B?NjlMTW1lVk9RMFVXL1BxaE9DMkxRbGpCeGJHMWM2dE1BRDJOYWpuY2Erc1pM?=
 =?utf-8?B?MU9SOGp4NTE2UUc3MDJKNDdSaXVGVi9KR2s2NnpFWVlXbDNtb0orTE03VDIr?=
 =?utf-8?B?OEVzWVFyVlJTUFpBL1h6dXBhb2lOTTR2b3didmlmd0RKcmVOMnI0YzN3amtm?=
 =?utf-8?B?TjNRTXAyN3g1d1grSERPS3VpTWhtMlVPWFV2K1Y2aGJvOTR3aVp3QVkyM0d3?=
 =?utf-8?B?aU82WTBYQjNkNENtOW5VQ2IvTmgzM05XMW1QT3RRNnBmWXRZT2pnSnlpclds?=
 =?utf-8?B?MkJEc1VaRDBoY1dRVkhXQ0tTY3VPV0J6eW5BcHdpSDhDYkozMFVUcnNvbm9x?=
 =?utf-8?B?MUxQSkZITEhsMWpnS0hjNkgyY081Tm51bjA2d1JLM2pORDl3NFhBdjlHSE5J?=
 =?utf-8?B?KzhXZ1Y5QU0rS2U3LzZrNDZWdFAxMFZCdzRjbW1OTU1iUTBuOFBEc0FIM0k0?=
 =?utf-8?B?MS9WbmRleEhpaVdVOW9pdlFOZmYzc1BMYklXcTRUaTNPRDNla1FMdW1KQlBH?=
 =?utf-8?B?QVlTRU1HU0RRdVRFdjRjbzMvdjRONjlHVlgzOFk5RXd5b2VtQURNSkFEYXN6?=
 =?utf-8?B?T1pTUXdPUVdBSCtUNGN6QWxnRnIyMS9FdWlCdW40Z3BveHlqOHFESEgwQngz?=
 =?utf-8?B?aWQySXlzcEVOWC9VelRndFdCZ2VGNng2MGxZeUN0elU2enFnRDdwOEE3NFJk?=
 =?utf-8?B?MlZZbXJvMzBDZVB5UEx2YUFUODAyWkVzTHQ0eWdLcXU5NTFDZ2labk9uQWpl?=
 =?utf-8?B?cEFSL0lQMHpDc1FzcmpqL1RGYUd0b3JQODgxaDlpSHdPc3l3UkNPL1p5Z1dx?=
 =?utf-8?B?NE1OeTMrVThsMXpod0xTQjBlTlM0U1VibnQ0UUYwRyt0MFJRbE9ZNDF0Umxw?=
 =?utf-8?B?SXZUWS9BTGZrM2RUZmRpLzdGbDI3M0RpVVh4RjBrR2J3RkozWXJFUE1zUEkv?=
 =?utf-8?B?USt2dVdUQXhWQks1ZWdRamg5TzZPRmg1NGV2dWZCL284N0pZK3lTbVFCK1VM?=
 =?utf-8?B?QjM3RjRNN1ZWWk9NZXQrU2FyanZXeUJnWjdaYmt1dVpzT2hEMXEvQUJ0VHdE?=
 =?utf-8?B?ZFBQM0ZvT2R6ZGZFYmg4Z1lLRVVCWnd1M2g2bUw5Q05kaHlraEVmVGVWU1Fz?=
 =?utf-8?B?dlBseWRVN2pHMFlneDNRVFVaNS9LYitsQmNyMEZFckZPTlEzWloraTE5SitE?=
 =?utf-8?B?V1h0YTJEeUhMWDVuQzhoUUNndmdaTzcvTHNMb09lWElOQjRsTWszZmdRRjdz?=
 =?utf-8?B?QlVYOFhJblZ1bGQ3Y3hxcjlwRUo1WnlPQldiaS9uczhORjR0bUtVdUE5Zk5y?=
 =?utf-8?B?OFVZRUltQXR0N1JpYndiOUJQOW50cHFkYkxoQzQzRXBleUV6aW1DbzloSmJU?=
 =?utf-8?B?YXNOZ3pkQmk3YXdUaFMrS0lYR1AvRWV4K0V5T0Qrc3ArSXJxV2IxekhZOU5K?=
 =?utf-8?B?WlZtSG13L1VyWTNrS0h3Y2MyNHBZak9QWnNLRnBraXlGVUhQeFBZUGIrYXFo?=
 =?utf-8?B?U0FBK25QK2JzdlYxTTBpaTFlZC9kNGpOcmFPOUIyRSsraXVGbnNRZVBZMUFX?=
 =?utf-8?B?VlJLY2ZXc1R1c0k1R1VDblA3SGRVQmJVdHZWTk5RLzVmZERkS3JRSUdjSkxD?=
 =?utf-8?B?RGhmS2FTZlBPLzY3YVc2dWFwRUZNWExyVTJVZzR5YmxIUjZKeHhUeDJldlZH?=
 =?utf-8?Q?66pxdyfxYw/2pnwW7Pcxo1a64TwQ42PliihWgDM?=
x-ms-exchange-transport-forked: True
Content-ID: <A48FEC9D26162C47BC636284EFDDD9FB@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc9cbef-addc-48ca-3d12-08d97d667a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 01:15:34.2869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KsCu2X1p+xtEjoozV4R7YzCowIuTz/D4pi1fBDLMPRsKuP28EKbBnRTMKgGpAC34J4fAjX6AxUxkQvmNz/vVKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4665
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_181541_702774_B74CB019 
X-CRM114-Status: GOOD (  12.99  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/21/21 8:15 AM, Hannes Reinecke wrote:
> TPAR8013 allows for unique discovery NQNs, so make the discovery
> controller NQN configurable by exposing a subsys attribute
> 'discovery_nqn'.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Couple of nits to avoid two extra lines and remove the unnecessary
local var, please consider following :-

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index d80717b9779d..33200dca6a7c 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1236,10 +1236,7 @@ CONFIGFS_ATTR(nvmet_subsys_, attr_model);
  static ssize_t nvmet_subsys_attr_discovery_nqn_show(struct config_item 
*item,
                         char *page)
  {
-       struct nvmet_subsys *subsys = nvmet_disc_subsys;
-
-       return snprintf(page, PAGE_SIZE, "%s\n",
-                       subsys->subsysnqn);
+       return snprintf(page, PAGE_SIZE, "%s\n", 
nvmet_disc_subsys->subsysnqn);
  }

  static ssize_t nvmet_subsys_attr_discovery_nqn_store(struct 
config_item *item,
@@ -1258,8 +1255,7 @@ static ssize_t 
nvmet_subsys_attr_discovery_nqn_store(struct config_item *item,
                 return -ENOMEM;

         /*
-        * The discovery NQN must be different from
-        * subsystem NQN.
+        * The discovery NQN must be different from subsystem NQN.
          */
         if (!strcmp(subsysnqn, subsys->subsysnqn)) {
                 kfree(subsysnqn);


with that looks good.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
