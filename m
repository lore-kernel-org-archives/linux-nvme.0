Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8C7C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 01:17:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349C661264
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 01:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 349C661264
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qjuGJTtYBCfskAohVJlWccIw/btoTq8Xz/eF1v69Jf4=; b=ro7ufKlBUjruXd
	6m5hwsPW6zQgIDT2CcYCNsJ6Ao/IqBRo0FenfL3mlDZ+cg3iILgJ/cdlSRrfWtYjilJ8dTb8tgl7v
	KWgfLfOQNYEOxcbIPg3/UsAiNAjsQZGiacCHFmD+dHgEHc6wAnwTeZsAyYi21lguzNRkN+a3sEZzW
	cxdbVa2Wh6An7xDdd9DWq5kBuWx/k612p/WbcO/PeMm4DjlSl4KHmHtLFqmUliDWE/PVYYZsYNftM
	vRl3h9gEY6uVhBsTjoDOUPgURMsEEo+alQYkbGwZS+ZlYAUer62Qx2vuZ/hNwPiwmjMkX16XE1mhl
	1hrk7XeUURidBi6jEnIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSqsm-006TTj-4V; Wed, 22 Sep 2021 01:17:08 +0000
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com
 ([40.107.93.44] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSqsi-006TT0-Io
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 01:17:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjfGd++vbqU270RrKEjC+H3vtlcNGBeqOD0uY4CSNRw4FhlsYNJT8pkBmpn7gDTM/WJFlpFzZW1HUY71arlbYc2DA+Yaqkxj1rtw5aWgQuPb51z8NN+BDnrHPdxrBbsdUNNTXcpMsRbV03NfwCBON4Tp6+29lFKqqmfheyhhMS3jdiJe2MFvtjwJxh2FaFyysfVcIDg0MxG1JJ8E/kIW2NXYejDLVVADbFx1vcwvuNiBCe7KS7Sws1uN1ItBi8v6cNEMyU3nKDJv3j7/fu0g5aCzOP/kZZwrYZj1Dt8qnm/AHVh4IM5K+jKfvTx/1JBgruQoQtqo/9mIH/AW5zHe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=pO7AFdFp+hocbfUopVTMmVzxdc3tN6ukrz9oTjSuZxM=;
 b=Hg0AngPn6DgWZj81wrOvApxjpYVBV5B74v2KFD5/mchWddK+mok3laTWukfVLU3vE3XQeVtGJ4jpM50ePNAcTJMAO6MYXWjfJqoFeSA4pJGS+3AnAgVULQTIv8V1Ms5mL2XSBYdr0v4iJtMjKoBeyxeCkWstdTvYxB+XPESLQkb+7lewXMYYPsMqy+yUBAbjm1FYFC7wc5v97DTwEQDXOKvNA6Jo9tZZXUEIagbulGwschACYxSBiyYM+XiY2w9HARO6Uks4rXOyX7hI5tREOL8Y5z5j6g5H6l79r2/lLbR3dhhCHh11VvwC+WtxbZVNn1fbWpBdmNmYHoEBcYNUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO7AFdFp+hocbfUopVTMmVzxdc3tN6ukrz9oTjSuZxM=;
 b=VpgH2wZ3Lw8CkpN+ppPkhaskB7VVlMA/4r9XKqZIokIHqrA27zyLx3SzZ/xeoHGItp94HiRnuvM/AFUwYsWOa0UufB7F8uQwORAVVHmOTbmhhbpdJJkD8s9nfS5IzAFTzxQBCIADvzJeDLZRLfgeca0+3hexRlFI8PbQJSjRdaMyEwY9BUxTAqF4hFH9hLm5+EhJLppNJWXVK/nu65XJNtK6G/TK+PyfGBxqxnPf3jKQLRopiFv52pwMi43aV3hMT9Mk99xtTS4lAr+nNu6TSN17iidcQ5XrB5l/isaGSST/5MVeqEIReGQd+sKjjpeLnk2dmPlYc6yt6PmHvkLL9g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB4665.namprd12.prod.outlook.com (2603:10b6:302:2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Wed, 22 Sep
 2021 01:17:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 01:17:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/6] nvme: add CNTRLTYPE definitions for 'identify
 controller'
Thread-Topic: [PATCH 2/6] nvme: add CNTRLTYPE definitions for 'identify
 controller'
Thread-Index: AQHXrvv2JWij0uW9SkGXZSMIoUV51KuvQSAA
Date: Wed, 22 Sep 2021 01:17:02 +0000
Message-ID: <9ce71613-746e-2fe2-32f0-415d4f121a8e@nvidia.com>
References: <20210921151529.29419-1-hare@suse.de>
 <20210921151529.29419-3-hare@suse.de>
In-Reply-To: <20210921151529.29419-3-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ff7eccb-22ca-479d-4517-08d97d66af11
x-ms-traffictypediagnostic: MW2PR12MB4665:
x-microsoft-antispam-prvs: <MW2PR12MB4665420CE4CF4049AAAB83FCA3A29@MW2PR12MB4665.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kaQNLqYd5UVr/KD9BgWlPfv4aAZV9CySg7NepuwwRymXUSatoGtDx8/MAzDxA5A18ts2mcsJ5qDZ1FfsQYeVyxl3w/mE1hv1AxOkFS+Stvo2dl7DxYZxEt1uwIOT/FOBrmfi59QXayuqN1QLO9IB9Mer5PPxWkxirdHTfMd+Dn9QNjLTfPDSh+r1q4C+ejvt+MMfhqDvZ6ikL1QWqk4tRTuZZ08ZrL0DdtNt2lwV17PwzCe7FOO4s5tPntWhzmBe2AP+dI6PVUf+Dh22iqSwb+a6FSxl1i3nZlc4oLDDUP5rEVSKyN4lZj09xvtqKZ7NPHC2W5MgFggzGvR8mGXp3oF4JGSyxz5OFwogXQOfj9p9rKTiwJn3B2h7eu8IHMDdn3mn2iTBsnALEkCsW7KG+7LkE3N7IOXWzq/Josn3YjbVQ6mDSK5E/FNC4RB7x4pR78n81dc6waoCVs2EnpVJyJrCub61bugyKfpDq2LmJWexqufc8j2MfgZPh6ljg68EHDdndnp9q91NalHwjXCmiCNR0mYUm+EuDayXcmJWjSJsFC37PNyQcT9EeeyYlOFU3fXjUKuHx44hvvfRrKebpcviEmbdrcko2+5Cjo9BNTcBHRiYfeF3KXJZcDRxpuU+tj9lsXmbKIdJpx4oWoYx9h+Oa+f/OfKtB/Ph5uob7PjM0qK80a7ucvPBWcJvpmujCM+XWmeA7YuKE2jbQlHIlC/o7AQqCB0lfOnmRS7dLVGeX16mfo9UZFwOcwr72ClDdcbOpOZRwCg7N4ca7DUEXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(31696002)(36756003)(6506007)(4326008)(91956017)(26005)(66556008)(122000001)(2616005)(508600001)(316002)(53546011)(186003)(66946007)(8936002)(86362001)(38100700002)(2906002)(5660300002)(558084003)(8676002)(6486002)(71200400001)(6512007)(83380400001)(38070700005)(66476007)(76116006)(66446008)(64756008)(54906003)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEJOREZ3dmV3N0Q4Mks1cWxiYjl6a1hqM05SdEJJWjczWlBoWDV1dHoxaUZn?=
 =?utf-8?B?Q2g4bUtGL21WbG5WTUdhQjBJa09odnAyOVU3MW9JbDZIVmdkUCtIbkROZjVk?=
 =?utf-8?B?cWVING5paENhd3JzNjZ6NGx6cUY2WjBmd0xoazBlUERPOWU2R2NMZnI5Slcy?=
 =?utf-8?B?Z3BjWTB6bEpmeUhaR0VvcUNoUGgwVTIwY2pzelNjKzBZcUwwbTdZZWNWK2Zk?=
 =?utf-8?B?NmNDRDVuaW5vQUk1czFPVHdpeHFOK1pwb2dxd1ZpZjRuQTZ6T3FqZUJUUXgv?=
 =?utf-8?B?N0prRGFpQUpWS3JGaHR5VzBoOEc4U1pLRUVLNFRpWlBVTFNsc3NFQ24rb1Q3?=
 =?utf-8?B?ZUthcld3RnhxaXJnWE9XNU5PbnhlVE5vVlBuTEJwWUxkZEtVRmQ5QzJZdE1F?=
 =?utf-8?B?a3pLZFVCbSsvRXJic3pJOWR1NVVyM1JFYWsrMjZ4M0srdi8rdzNFd3A4WEN3?=
 =?utf-8?B?MU9kc0xuMVBzei94YWRlY0Z1MzdlcmZrVDJOY1BrZEZaZWxwSm9BQ1BDZlFU?=
 =?utf-8?B?NGFTYnJKVHJQN2N2Nk5scjNpQzB4NGs1VFlseVVpS1ZUcnB3MDRYdlNISElI?=
 =?utf-8?B?bktkaVFnUmJyRnRaLy9XbkhweTlQbEJKVG5VYWxMS1N0RThJY21mai8yeXMz?=
 =?utf-8?B?NzNhQmx1OUNveWVueDRxd1k3MlBwSUo3azROWTVScUhXMFE2dzJFY09MSDN6?=
 =?utf-8?B?S0Z5L0FjN0pBQ3lPakRjamJXKzY4UnlUOWR5cThoSlZHSncxdTR4WUJhbmZi?=
 =?utf-8?B?S3BPenl2SGdhbEw2OVQyOTlaa0ZpZ2UyOVBqRjA0N0VwbDNvdks1UVczZnlM?=
 =?utf-8?B?VVdxU2JpbEdtQmRQR1hrcXExRFNLV1M2VWJGTkZZcnUydyszZjJJZDBiL1pl?=
 =?utf-8?B?d2sxY3cxSDVZWjRBdThDSWFkcHRIUjE1WDRlU3AwbTdGSG5KVFBJMEdLWjNu?=
 =?utf-8?B?WG9JbkM2OUZXdDhibjgrSERJYlFOUkhMbHgwaW5YWW9ZcUYwL1dLc2Uyb0ZG?=
 =?utf-8?B?MUpZR3lOZWlvT2s2NEJPcVNWS1RzVVlZVTlLWTUxRzlSSzl6WHJSQkZrd1BW?=
 =?utf-8?B?dHQ0NlRNV0paQWxxa0FuRllpREtYYWJ5OWk0ZW9ibWd6T0pGcmt6Z1FrMVFY?=
 =?utf-8?B?R1lNNHUrUzhLODRMYUlIdklrWjk4aHpxcnNsWnU0VlpPRFhtc3h4ZUJ6aUFV?=
 =?utf-8?B?eTBtZGhCb011bnZBTDR5bWZza08rNngxNzBJS2pwRC85RzUrbllQOXdlbTd5?=
 =?utf-8?B?SlgzNXIyaWlFd2VoUzJ3WG9xUXVyRDE1VVZTZTY3bEZ3UHBpLy9sTENPSjMr?=
 =?utf-8?B?d2o2TXdwc01ubzRrb2x1UktRRHlCSURSQkZ2aUl0L2RVT2xLVmpBajRkeldr?=
 =?utf-8?B?bUJvSlorTGtGNllETDlERStsZG9rb2FjU21ZeDRpVUVpb2puZ0ZIVFQ3WGE2?=
 =?utf-8?B?NUJ0aW81RmVtMkFzUEo4SFd0Mkx6RWJSV0pTbzlBYXRXRjllLzhaQkxpS3dY?=
 =?utf-8?B?bkg3NDZtdGFuajNPbURFb1dKcXRvVHByR2dnSk5mQVFHUjNkTHZ5bml4K0Zl?=
 =?utf-8?B?N0UxQzJKVEU3VFVoNXkrcDJwS3pIRDhTMEh4OENLcVBFWE9GZDdSOXJsNHUr?=
 =?utf-8?B?QlptWnk4SkJWbWZrdkRJalc2U3Fna1NkMlJleDgrd1Vtdnh4NkpLbmFaemlG?=
 =?utf-8?B?YU13NDZGWGlJZW1UWHlMaU9NYnZaS0xsSlRibUsycXYrWlRUSVp5L2hLQWVM?=
 =?utf-8?Q?D19WzuxTxPB/JGKp7o73LuQGcNBueb/5kkemDVu?=
x-ms-exchange-transport-forked: True
Content-ID: <7CB132204B7B9C4A858B503E8C406494@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff7eccb-22ca-479d-4517-08d97d66af11
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 01:17:02.6207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDpbAaQxqKdi79odvRU4sUxlU77FB+fhQQYolHbYJjrMhp2Vi0yOrNBRfgq32jlD+26Gy97BXnzGItGZeDiuoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4665
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_181704_665332_D4EF3C18 
X-CRM114-Status: GOOD (  10.70  )
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
> Update the 'identify controller' structure to define the missing
> CNTRLTYPE field.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
