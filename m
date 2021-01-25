Return-Path: <SRS0=SsZO=G4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BB2C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 08:35:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE42422CAD
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 08:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE42422CAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=goy+2ehdrmWFzRrjfN8OZz4zvLMu5O7w5KyOO5SgIqE=; b=Q5vtH7p9rCxS0b3zgpp7LgkAc
	g6TJ2Ov2BBHQABT7hFpFt1wRpQS9AE5w9mbajwu/k5q2a5sbjSO7UmeiRwecbODYOL8pqgYqvejJu
	LAXtcUAfsYx2Jdd97SuJk2FRhU7iPnOLJ/Wi/H57TGSqm3B+n9e1sjk9jg6V/VugB8R836bc9wU0J
	S5IB7pI5rpFuZHp+pN+byxkHWQ1R+x7ehlv6tUmI/lerlwHFYGbUG6nPhE9oKeCK6ZV6A+k/G6vvu
	OsiXrfWxaHyqdfx2XnvF4IDD2dhxuiDoHpEgHWVpza/2nuGW6MVpwOBtJSqHfJ2oM8DjSDVMLjp2b
	pEOzZxsFw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l3xKJ-0001oc-BX; Mon, 25 Jan 2021 08:34:23 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l3xKF-0001nc-Ah
 for linux-nvme@lists.infradead.org; Mon, 25 Jan 2021 08:34:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611564056; x=1643100056;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0w9VIgszV6guRkkqirdSlssfTh89OngDIlr2kdlE7Yk=;
 b=g8mookt8Es9oZgEw228W3sgaIloLYc0lGDCHn/av5bpJgWzwup5GGLBf
 RQjD1SA6Ab/hnP6vl1TMCucPWjIRIlSdE+AITJtcf70b8oGFBK0tZSKtJ
 n8h4y5wr2Hs1I6IHw/zp4tkMVtDjZebsBUvVVUcomwYOczlZVI4NC0vj8
 jCzMp1lsvZX2bTzRxdccPXMEj/hNlQD1dYkcpS2rM1B3Xy/yGsrbmfBbS
 v4xXZydXpiBJ9X4OKEHLv0yzopTLtFikX9NFQNtVggIlx3vfHQSl/FtmT
 VYHBep7YZJ5f2gpOXnPps7+iqkbB6aaR+k+oz2n9jRUzCND6tS4DnWVI/ w==;
IronPort-SDR: NVI/5vFox8c9E0uwgy4jK3v77kJLA2ka38V6fwIVuETSt5fAMVmWRbVDvifY3ybcTbTMKmvXAq
 ePMWNFrKK0v2OjLZmxUpiqalmqLL1tP2Y61v3QIalC6/wO5mAFrbJ8+gapvAjT4nM2liTnmsUE
 81FpHyBHVWHINq6Nq7NCCUPKgnBkDTBLvMPXYTLeMkPHm6cFr5uwrJatXlxUAqOolt65VPFtMG
 IvN+1i8vnB51tYr04rOLskfzkB+LHzfZNKTOupnkfK06peH8g2D8pJ4iLdsUa9j1aIKKneGkTp
 a8Y=
X-IronPort-AV: E=Sophos;i="5.79,373,1602518400"; d="scan'208";a="262238338"
Received: from mail-sn1nam02lp2058.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.58])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2021 16:40:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMYnPtkViM0q+PIhHxXVGRfqb/qx+O2ppQ18NoSzgoTNQTlloVrIQkaJtUXiN2zfmm0lCD5Vrqe52gdlUMHmfgG7tZy5/K2S4vf9jT51ifbBlnGpydjFfMWF/jj68uQhu6PNx7QTxclDR7ILJGF9z0bMmRp6IdaJ8BlLpzaTqBwnnAOdNTBjXLTdNUq8J+wcVbDPjrwCW2gchCol6d8U1stuqXOAb77EqC2C4xCKJha+FPVh78dy39hV+Ppfi4KfQc4r/RPlGVSo3ZDI681mQqSE8O6YTOtYdKmrowHVBaVqmpHvs6bJBHNbEOhYAtMeluEa95pR67QGRkwm9kjkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0w9VIgszV6guRkkqirdSlssfTh89OngDIlr2kdlE7Yk=;
 b=BW6FfSvPiScdcz9E7uDLIaNGs+sVAO3T/JAZgjBYk9E1N9IxFMZPDv+ajEp/dNUGwDxNv6rJENQ8BbbWKRjlG28t4FdSPvHCNJjVU8hSziiBU1iwkkag4Pw3T8y4Oro+XNpnxY6vUTtTymqCtx7LpqPBr5MWbXWr6RdEfGOsxJu/fLFekbkngcvHHwfoLWVKwU8OJY3DuhqvOFI0QTJRqBc+almTC7X1QQN2Qpz4feOumYGZalcV9kfBYVLev3huNe7G95g8WD6ny91GFdRZYNplg+y/wutxZQPt9WmEspR6c/5/fLO08fpNCx/Mn6guAm78ILQdGEOWmcRjOpeLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0w9VIgszV6guRkkqirdSlssfTh89OngDIlr2kdlE7Yk=;
 b=CdaLL2ljI5XY6pu1AnL8W86d0N5U4LtbLA0NdfTpCprMuZ9uxEwDvjbwPoYPE8CPVL6vi3r4ePEiBpwqOeyvjQiohEtuOboMqEd/BRviSQbs/xuXNYLCXvrU2Pg53fRFr+c//u731ihL7NFsMpAvggaiw0+ph6unGuXK0Gr2KUI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7550.namprd04.prod.outlook.com (2603:10b6:a03:327::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Mon, 25 Jan
 2021 08:34:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.016; Mon, 25 Jan 2021
 08:34:12 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
Thread-Topic: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow; 
 use-after-free.
Thread-Index: AQHW7QO5MtNnJXjl5ka4VClzrgzGFqo0apAAgAOgS4CAAATT2A==
Date: Mon, 25 Jan 2021 08:34:11 +0000
Message-ID: <6709E718-ABD5-4B69-B4E7-883C4E4CD178@wdc.com>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
 <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
 <df46d7ce-ce70-1f43-0efd-7153761bcff0@comcast.net>
 <20210121124459.GA156577@localhost.localdomain>
 <c48abecf-8e4f-b76a-c751-1a0d239c99b3@comcast.net>
 <BYAPR04MB4965404638B4C43DBA577D1686A00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR04MB4965342B52D5C3C6D8A7892D86A00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <23f49172-5d0e-618a-199d-d568f695dc30@comcast.net>,
 <20210125081654.GA226984@localhost.localdomain>
In-Reply-To: <20210125081654.GA226984@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: comcast.net; dkim=none (message not signed)
 header.d=none;comcast.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:270c:4b00:9d7b:396d:fa13:2212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d50f451-3319-42af-5e10-08d8c10bfddd
x-ms-traffictypediagnostic: SJ0PR04MB7550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB75505689D65ECBC1E985B3FE86BD9@SJ0PR04MB7550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rfIck85hzdGULdlfrr8HdfvJ6/XQ1fKzDoR7z3s/p+Sgj5Ls6iDKO/vCLoIhvBNCKysrBZVPn+ITlAmWt1hyuZiZkFTzKz+AOsQxM9g0rXlnPRNWzyIWINDufwgRE6yHHDFg8ZwhQbazmZOXgSgNkJLPCa8uDqXSd08lwlrHUa1xswvY8rOvYcIC+4MSCukr6VPYy7GTjTr6OBaruHa9/OHf+M6+7twDvAMI2nMgfkuCPCHpG0jjGCO6hpKXKaHa7exf8H6sDZJA7QZKV8q4RaVuJvOwLaWjUfUoA28Mqh9OkF0s7KjNPzkVa2AIjOnAdOApS4f00oFhCT4VIgZ/SorDLLsPWv2VYIp9NrdBl7jKYMnUX00RsTmAwhWuhoc2dxGQb0UmcZ//GvwvDVP3TC+pMgqFD1grhisBMwWBetbd9g8G7GiOCEZwBpvkklQq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(53546011)(6506007)(66446008)(64756008)(66556008)(6512007)(36756003)(76116006)(66946007)(66476007)(2616005)(54906003)(37006003)(478600001)(8936002)(8676002)(33656002)(5660300002)(186003)(6862004)(2906002)(86362001)(6486002)(4326008)(83380400001)(316002)(71200400001)(6636002)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Y2RrZG53ZG1xdko0SE9ReDRMaklQTEpZN3JlZ1VGNjhWZk1yWERlRWRPRTRD?=
 =?utf-8?B?eXNYUnNsV1dOcFVFcTdWd3M3aHRXNGU3bGcvVEFrVnNrUzFzc0VKSWs2YmhO?=
 =?utf-8?B?ZGdvbWorSjdGSW9zQjlhNGhOUzVuR1ZtaWR3S2lqRDZmaTlOWnB1OHVUR1oy?=
 =?utf-8?B?MHhZWWFnMWNoRlRkNStCRVJuT2J0bjN2ZUN1KzNEU1pWRm82N1ovWEpOektJ?=
 =?utf-8?B?YjBnNnI5NG5SVUJyYTRBY0RJb3NkUXBmeVVXVTJWSXlqclhITTNjKzBGdlVH?=
 =?utf-8?B?K3lFV3gxVHc1STdUMTlXU2g2M0U0aWM5STc0NHRUd05vRzc5bUJQcFdzZ3lC?=
 =?utf-8?B?dU5QWktmSXdzY0RGcnlSbVkxTEw0NEJiSEI3NHN0YzRVUUcxYVh6TjJXdGxS?=
 =?utf-8?B?UUlYYnNHUXdRaHJjSmFsejljM2VSTEJIRUV4Y0YyRXV6R1JFRnNSYXE0dHNo?=
 =?utf-8?B?R2dsNTFuempSc2FQUmxKUlRsYnYxQTZKZmNCUE95MGxzWGp1b2lJbElIdGFT?=
 =?utf-8?B?bDNyTWZ6aUlyc0kxRkRMNjNkVXE3US9wTmw4K3Q5RTh2Z1BZNW9tVGtPNW9S?=
 =?utf-8?B?MENya3ZRL0R5ZFk0N2QvbmNZUWZkQW5xSlAyUk93NWgrM1RsY043K1FRU09s?=
 =?utf-8?B?Z0l5ZlBwcENRN0hzSHc0UENDbG5DWXZtb2sxMGNjUEVITlJSZDBvdnprN1lI?=
 =?utf-8?B?M3VUWUdKRU5iVkJsT2J5RVlPK0F3UGxMUjdjL2U5bHBERVpCdHdqa1JVbXM2?=
 =?utf-8?B?d2FzSGZYSFhuRXFDc3c1UVluMUNScnRHM1QzYVppQzNBR2RJM3JTcG1BRkdB?=
 =?utf-8?B?ZkpoSWNvU2haS1ZNRmdoRXRSNEJ5eXlxU2RXWnJUTnIrUzl4WnVoUFFTNDZy?=
 =?utf-8?B?WVdhQUtMbkljRERpYjZvUXVOaWZXK0Y1NzNiL2VXZEcwbllSU282QzF1aHg2?=
 =?utf-8?B?c2hjQ0V4SUFScVVhTmppZjIxYnJwRHphUHRaTGxpdnNIa3d5MzFTamYwZk9r?=
 =?utf-8?B?VUY0OTB0MG5VdUhmYlkvREhGeDBKRkJ0b3l5OHIvN1loVCtuOVc2WjVWL0Q0?=
 =?utf-8?B?U2RYbk5aam1ua2szR1lTQk5NbXFYMGd0M1B6anlLbGc4TWw0R3Z3TlpQd0dM?=
 =?utf-8?B?RCtlQjkwMGF5bjVqVDBWWWVUSjZNellzRWxKSGEvUWZpR1B2MnFES3NrWTZ0?=
 =?utf-8?B?N3kzenMzS29maXVjK0FaNTF0YUROSlRCWUZoWjQ3MDROMFBVVmU1UVBiVzBB?=
 =?utf-8?B?VEdsZlhhaGc1SFFoYjlUMVplcUVOallpc1ZQL3VYemlvUHhkSktGZjlsV2J4?=
 =?utf-8?B?anV3Q0lNSFBFV2E4Z1NFZnE5cC8xR01FVkZIOXh6dTF5NFhRbXpBbThFdzR3?=
 =?utf-8?B?ZGVrODZza3FIZDNQWE8rNy9IbVY2Ni9vQjJEbms5STk5WVlCeHVFQldnODBm?=
 =?utf-8?Q?gx/S8/Ku?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d50f451-3319-42af-5e10-08d8c10bfddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 08:34:11.9710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qd0lYeFTpRkTsFbBOOwaoSybSxIiXh/9iXuyZTwbiuM4GaVo9jjZMz3qWMr+jWB5/90XEeZSqmqN4q8tRJUQFNoOcpQ/Qe4BF57kTtc3Ukg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7550
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210125_033419_662412_1D3A248E 
X-CRM114-Status: GOOD (  19.16  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Bradley Chapman <chapman6235@comcast.net>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SSBoYXZlIHBvaW50ZWQgdGhhdCBvdXQgb24gZnJpZGF5IGFscmVhZHkgb2ZmbGluZSB0byByZWR1
Y2UgdGhlIG1haWxpbmcgbGlzdCBub2lzZS4gDQoNCj4gT24gSmFuIDI1LCAyMDIxLCBhdCAxMjox
NiBBTSwgTmlrbGFzIENhc3NlbCA8TmlrbGFzLkNhc3NlbEB3ZGMuY29tPiB3cm90ZToNCj4gDQo+
IO+7v09uIEZyaSwgSmFuIDIyLCAyMDIxIGF0IDA3OjU0OjI2UE0gLTA1MDAsIEJyYWRsZXkgQ2hh
cG1hbiB3cm90ZToNCj4+IFdpdGggdGhlIGZvbGxvd2luZyBwYXRjaCBhcHBsaWVkIHRvIHRoZSBO
Vk1lIHRyZWUsIG15IHN5c3RlbSBoYXJkLWxvY2tlZCBhbmQNCj4+IHdvdWxkIG5vdCByZXNwb25k
IHRvIEFsdCtTeXNSUSBvbmNlIEkgbW91bnRlZCB0aGUgZmlsZXN5c3RlbSBhbmQgYXR0ZW1wdGVk
IGENCj4+IGRpcmVjdG9yeSBsaXN0aW5nIG9mIHRoZSByb290IG9mIHRoZSBmaWxlc3lzdGVtLg0K
Pj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252
bWUvaG9zdC9wY2kuYw0KPj4gaW5kZXggMjU0NTZkMDJlZGRiLi43YmE1ZThlOTJlMTkgMTAwNjQ0
DQo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KPj4gKysrIGIvZHJpdmVycy9udm1l
L2hvc3QvcGNpLmMNCj4+IEBAIC0zMjI4LDYgKzMyMjgsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHBjaV9kZXZpY2VfaWQgbnZtZV9pZF90YWJsZVtdID0gew0KPj4gICAgICAgICAgICAgICAgLmRy
aXZlcl9kYXRhID0gTlZNRV9RVUlSS19ESVNBQkxFX1dSSVRFX1pFUk9FUywgfSwNCj4+ICAgICAg
ICB7IFBDSV9ERVZJQ0UoMHgxNWI3LCAweDIwMDEpLCAgIC8qICBTYW5kaXNrIFNreWhhd2sgKi8N
Cj4+ICAgICAgICAgICAgICAgIC5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJUktfRElTQUJMRV9XUklU
RV9aRVJPRVMsIH0sDQo+PiArICAgICAgIHsgUENJX0RFVklDRSgweDFkOTcsIDB4MjI2MyksICAg
LyogIFNQQ0MgKi8NCj4+ICsgICAgICAgICAgICAgICAuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJL
X1NJTkdMRV9WRUNUT1IgfSwNCj4+ICAgICAgICB7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9B
UFBMRSwgMHgyMDAxKSwNCj4+ICAgICAgICAgICAgICAgIC5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJ
UktfU0lOR0xFX1ZFQ1RPUiB9LA0KPj4gICAgICAgIHsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lE
X0FQUExFLCAweDIwMDMpIH0sDQo+PiANCj4gDQo+IEhlbGxvIEJyYWRsZXksDQo+IA0KPiBDaGFp
dGFueWEgYXNrZWQgeW91IHRvIHRlc3QgdGhlIE5WTUVfUVVJUktfRElTQUJMRV9XUklURV9aRVJP
RVMgcXVpcmsuDQo+IFlvdXIgcGF0Y2ggc2VlbXMgdG8gaW5zdGVhZCB1c2UgdGhlIE5WTUVfUVVJ
UktfU0lOR0xFX1ZFQ1RPUiBxdWlyay4NCj4gDQo+IERpZCB5b3UgdHJ5IHRoZSBOVk1FX1FVSVJL
X0RJU0FCTEVfV1JJVEVfWkVST0VTIHF1aXJrPw0KPiANCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4g
TmlrbGFzDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
