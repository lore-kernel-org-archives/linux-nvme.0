Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75E5C4727E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 09:44:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B542075F
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 09:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q54vzbEN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IX5VkZSb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pmqeWSJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B542075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NXo7ciuSSMf/YVtIioC5BauM6s2xgKo0i0jZQ320iyk=; b=Q54vzbENKdcf/qFLE+SUnPAg3
	X6im/OrbjlqbEvyJwr3KbkhKvn3ffbqrlJDpkzXFim71Vrj2uNs/MmRMEaz5nRrwC3Fp2vapnZYAN
	3NkDTMyEICinGpf6540R3fQ7oNQNjAlGXvCu/MxChNFe1s5SA1as/dxgEkQnwTsqbKbqmGrGFK0KB
	im8Qv7twNGFoQsIrQsRX2IGKDLCaAQO8eNN10stwJEHIM8dEZJVIzN6Q6mKVhIN/EQNitH67ddhjZ
	/lFd9AL2jqGLb8M8Zr8Die3zgF0iUgVmVx3ahHdYBa5flm6lmGVRg1K6GrDYzuZyiZdHGoZKQ490b
	Z3WdaZ71w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNYf6-0000lC-Rp; Wed, 30 Sep 2020 09:44:36 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNYeo-0000k4-7i
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 09:44:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601459057; x=1632995057;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FFNaGwogvYSyOtcytar4TglvRxde8pYAtQpwgqhdhNs=;
 b=IX5VkZSbWAY2pLa0RzJ6lywt8Pl3WZAVprzmVwzQuJT8UuhKlN2hfgx3
 nr9IfXyMZVEFnhOJBMT+GolebsxMJrQOeozhz6dJzFI/B4Cpi0WaxUKzH
 2IFqPSvum7W/Gm6p/kkl0Cp0nleyOUzhte3QNvCOx2BGcOr1ELMZLmU+w
 Bx0kUyisMm/bWLemVg0JYfvpKa9mHl/Ktg+BNvZD3j5QFC+GW1uBWvUpA
 aQz7cQYHduT5Y8j9suFj36hUsI+sRjyNab+PU20W9EXrYFrttAn+bo7AQ
 whyoIcRd2AQSHJWiieTIcHKUlMlv4HaBJjuK+4HSVhbEIyM3qJheJNIhC Q==;
IronPort-SDR: w1OakuW89t1ocgiaPRmtiZGlzYq4hPyvMaCveJ6BAIVPu7M9a5JGUPHX7eOuj2lOxKe+oVzTnt
 jd/BjYAdXQFMYHvftPNi/UVOT+TMD5pqWcvkesfwLUyNbrDLMhU4I0wsF//AvqANYVrTPtBEXe
 imTpzynxdGBBdVtTUmhtaejqAi023Mbq0c8fCOoNzRhZvcsqeZxOM8sT9wvf1ofl+KWEJzo/AA
 8XNuiTYcTb+tAXOMBsZP1/BYQk5+ECrMqitmJhmn158wx/6gPR07ovP3dyD3E8UgdfoZynP2DB
 YSk=
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; d="scan'208";a="258384602"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 17:44:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6LKIz5Fpvxl29WUAXaGJ44qq2EeBNzFVtcLiwLQgUnWs8eNU/6sVpbXnXVDB/GK9IFCLC2wZijIAI/XkqGdml3yIwh54jHOu1/gDunB2iBmII3waLR/JQ7NbIv4gFKFSe2MG4pIpyF6Tulpjxul+pb/kbZnhT6tgk9ClO/SycgDkfpKqXoiozSRsRha3P/SpqM24uuSXdJ22uDP3xrddedymu7iWzOWoGm8wuVw1apa95ComTQ6p38NhuWh7dyyI5867yMFBjJ2rxwriDSj2Sn/asMoIwugs+X17eD84CFWddoY0NSVO2QbPwgyBVuW47cKBGLeqD2KLA+FCEgnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jO99ETMhaAEVC3xiv4yp2QXovvDoOML26ocnPSZZ5Uc=;
 b=PHqh0H4Oe1Y7i9C3BTqFiH9UdwWFZd/5M+7kWBhKjvQubPIviuYaXUDv6QHq4UFlJEqs+zxXry4CEhLDti7nCY53pOFOa8shhZxBlG1Xkc74fh1B/N3qsVc0R23UX3OJM9fAg38/rDBWYn3PJXq15d2d0J2tiGoKmlDZL2iFunlXWhdufvOjzTDOzQJ1FwvYMv+fB0KZUR0+DFZGG2jQds1h8zf6DnPEj+DT2pWb77zd0CCFRG7ujma9ZsuDWVsRX2JzgKB6bvU7LaoN93U6BCauSDVuxGuIOv0Ywdyc9B+XUPivJnneWP29/1bQlyY1Lso0sj7JE2mnCCN/06J70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jO99ETMhaAEVC3xiv4yp2QXovvDoOML26ocnPSZZ5Uc=;
 b=pmqeWSJRFHxQ++b2nQiGMK8QiXmhswrIBJ8GuIi/WydfhUyUR8hnWeqLP6tzSQsocnvy2rI/QcET+P9af395NdWFX0zMtQhtCNl4RaYQhxSnAKE3395rZGpaa77oROfr34WWxAqDlIR8oDDQ5pJAySskTg4Za25EEH0J2/cUV1c=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN7PR04MB5236.namprd04.prod.outlook.com (2603:10b6:408:3c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 30 Sep
 2020 09:44:13 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7%9]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 09:44:13 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 17/20] nvme: query namespae identifiers before adding the
 namespace
Thread-Topic: [PATCH 17/20] nvme: query namespae identifiers before adding the
 namespace
Thread-Index: AQHWlw5AkP94OOyeD0CkZEE29Sn+/A==
Date: Wed, 30 Sep 2020 09:44:12 +0000
Message-ID: <20200930094411.GA189371@localhost.localdomain>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-18-hch@lst.de>
In-Reply-To: <20200928123502.435373-18-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ac79aaa-422a-435e-3161-08d8652563a0
x-ms-traffictypediagnostic: BN7PR04MB5236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR04MB52369A6E9130D249C0F02A8EF2330@BN7PR04MB5236.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UV+ldZTkObCvMHRUI5HL28ImjKcxIolYqTQ0ldOVRnnZdO7BrZhc4YEKdMezxOHWP7wdqi3VGczaDAkxZeCPOPSdvRSzHAsQXZ5BPkb4oVuzv1GU3jVZGcNKJ4Cb81JJgYhjto5Nu09QKRl4qZIjDp1drX0zMBvgBfCkQgWYqeyI1I+tyuR165UZ7DEO5qPcuIgnWyeOnYZ4+wgY0byi2YL/G5LIpHsZrwGVovUyZiNHf9dWjiP8SQwAgAiLL2xOnYzKlagK7cwHmM6CMXfxx/rIet91NFLHUXawxyGbZz1BqAyFIVjxI+OjPC+I9JQ+EhAp0RSaz2Bux792vLEfGcP4RFJqczhnXknBdivZA4guVyRlti3ca4SjzlbEZRdY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR04MB0724.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(5660300002)(71200400001)(6506007)(478600001)(54906003)(6916009)(83380400001)(6486002)(6512007)(66446008)(9686003)(91956017)(76116006)(66946007)(26005)(66556008)(66476007)(2906002)(64756008)(86362001)(8676002)(186003)(8936002)(4744005)(316002)(33656002)(4326008)(1076003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: E7f9FvqeYQmuZrqGSgkl6w8i7+4inj+wKGJ1AoK7D7WG5T8oX0yj6wT6OmFIlFuPhnAOhFyWoZc3WfeY9EsPS4RJJJM6Z2P9ttgyndl/dZTz197LDqiPJgWuOJsJSp0rnZKHF61JH5xBNXNrI+GL4ySqOHau5FAhi5kBvjW1aJ652JRb1iOPMo4dIornHDgUOWPW4TRW52FQkVvcI8l09c8VCbQSQW0Y/ojzvVaEM7lwur32WQT23IMSY2yZr8szsCLMf0aeZWMslz8ToxnfsCcQlRpLnR6ncHLFUzBr/RifIIM/YMtrr3gEUrogxbxS2Q+8NcvKvFCjVkZCdOxvwNFtueFzDi3qQ+w5wtRkLLC8XYHwsZvdjlMye080dIZmbUDBdpP4l2bit411dgr13wY3ajJxk3E5O6tpuGw4Fs9HYHCgwt0W6y2bHBX08HMxLZftLdPqrYVuasdGASdaaKOpvs4oCmhO3jPuTrbPwvipsiizUeDdLN3XfCWeewJFZldeCWZEuGDTQyB6TLufnHY3oZmZbb6Y8fLElyq6U9WrwkwG2wXg6HA6maE7T/WfjQsPCtUzPMi4b+M7WR5Zdcz3gOG7qqyB6pPueRmQhA0QFKQvhIEmR5N9Odv1zSnAlB263QUAm/ba9W5ZkCbsiA==
Content-ID: <74A4ABB1E63AD14A802A3F8AEC8FDE16@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac79aaa-422a-435e-3161-08d8652563a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 09:44:13.1573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ry9utYLBogiO5cMW+VadcRga0S6vQIZK9hmOapMRTRqknDdSpVaGJq+3XDPwKxVcmJQoyDBAt8pK2pVdYCK8FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5236
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_054418_505161_3400898C 
X-CRM114-Status: GOOD (  19.17  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 28, 2020 at 02:34:59PM +0200, Christoph Hellwig wrote:
> Check the namespace identifier list first thing when scanning namespaces.
> This keeps the code to query the CSI common between the alloc and validate
> path, and helps to structure the code better for multiple command set
> support.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 116 ++++++++++++++++++---------------------
>  1 file changed, 53 insertions(+), 63 deletions(-)

For the subject of this patch:
s/namespae/namespace



In your v1 series, you had a separate patch for:

"
nvme: remove the namespace identifier verification in __nvme_validate_ns

None of the identifiers (including the new CSI) can cange over the life
time of a namespace, so don't bother with the extra query here.
"

which now seems to have been squashed with this patch.

Squashing it is fine, but perhaps you could add that information in this
commit message?


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
