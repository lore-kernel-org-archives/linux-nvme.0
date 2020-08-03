Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0B5C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 07:12:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D73206D7
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 07:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1t/0MTBV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SAzKLCfj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="m219D8be"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D73206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=O+bnMPbPf6weEJjpExzR6Q3r7sstzIq/odnbO6q5pqE=; b=1t/0MTBVvAuV82v8dZM9f4AU5Z
	qrWAxFEwomfzb0Hvp9bw8idak7qXQLKJdscPWtdJJWoLbTClLm27rniOOtL0th6JLhd3i//GeAtbY
	KR7YSpwaLScX0NNsdGUEkCAAmnzJJJCNZAO5+pi8Q6yzHQB+SbKJnP7cRkMZTJm0cST1QV0p/DFmp
	ks1XoSjqCqBxLDXcB+5z4w7FIgn3kXizfEGVP5KslcBf/0vxN1imkpgIoun7nmfpX3oyFrbRuZsLk
	7LQ9U6WK2YxlmwmUKLCwx0rhONoICr8ArLcKxBT9hK+Zcmphrl5lME1AiX1Dsm273NeAUH2f8vc9d
	IezgKrZg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2UeN-0007NE-V9; Mon, 03 Aug 2020 07:12:47 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2UeL-0007MW-Bj
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 07:12:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596438765; x=1627974765;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=QjTZ2J8kJkOaJ7xIcENYTPj9MvBigSgLVrteVAcaO4w=;
 b=SAzKLCfjQZVpV6zK3tOmQwzMuVkNq2bT5JT2n3FUf8COCOBAOXMlEQxM
 iX+/tp/PNEeqVUvXiZiVdTWy1WLEZDh6TthikMX55uoxQxW33ba3Ito9n
 FayYkhpTrHqwWhRTTEy+33SDjsRdpN/C6r0QVX93ZmntZE+Mlnc+xt7LM
 lNG1StJ2i/z40tjlX2Y12tWYBTrke41xv89gsAR8x+s+hHTVZPSkZOI7Z
 cI2G5O5pkevUtepcLlasMP32x1BOg9Z5JvSso356o5NPM+jyjttcUPLGA
 ecyi/ASCWUCMDy+jC72cMQPv7FviKpqq62OBNJNGB5htjRpXYEg3vLkbe g==;
IronPort-SDR: lp+4EKXWhP9ZvpkUtMu9mQe8RthmwB9wxVXKXsYUXBy9vFnQFkxnZxxF4zQckVF8n4JAfKhjlt
 M0Vg5/UDOM5d0q5KjPzxbk/eNSqJqxd/jAqaj7/amIh3HFyg8zIuAT4VfuGDDBdaeJN8eIFDL4
 wa8HQ/sN2AryklNpwGFZ58er96T8BzxfbpD4m8cN8JraRKvsVOUh5n2ojzmIYTXgGI6opyp9V5
 iLPJpAlVCod/qUQd17xUbEKmekkg1MbhHyZWSH9vUemFxYMsETPn1YH4S/FYsSVPNVYKKClygr
 E3w=
X-IronPort-AV: E=Sophos;i="5.75,429,1589212800"; d="scan'208";a="148304002"
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
 by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2020 15:12:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Buy94bofRfwePEV+IUK5eQpkGF4wAC2BAkt6h13QoqRpCkHNYyPpoOkCNfazVpW9/hXNoEug0yz8CMC1Ujq5dt1fvRAUZGylYC4g/6WykHrFQQJCj/o/hufG7uuh3h45xQa1HkOIe2h4L0cpRktdnSDayLWsR00HySSNP7KXstf/hdvspsdoHjxyN5UZST+z2XotLOK2g2MbSV9xGrI3I5a4NHsc5kE1iaduy9z8T1gx++Xb+ycuqV67Oq3M5PO+Zetqr5RfIzoqEPL5YCoc4RD+8BYUeoCovsg5TXO0ix3YN09/jgivsf+qKVTdqQc8obIttKEkgf/Oh3e2MmbqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lRC5WJe+dU9h0+myVfNXHjjsegXQtx9pXgsHUB7kck=;
 b=lR+Cv1Ob5FqZYcKwUNB6jTyBlXPES6JMfs1jDaeLkYhuhrhQEabnkE9eFkgQdonakdzzIZnCeX9PQwxmaSUnQ4qJ6oRHqqMA6aCnA2IIQnqlcrvg6HppFfW+nivkNp2M287icmX3YQhz+K/1UB79qk8bUHfo7AIBBIL0TFQ1KvFFGexA6CWXTiTA1A2y0XomJcIp9jJLvSdsGs1tRnFhcDd62ELQREXFieCEISpOf932SUFNkMwyLVU/VgyFmUYNr5h8abFu7JQ9h5b/7HpK211YX/XOCLWbWfWJWx2u5fK2TiNlyNto2aq2a/9Xh5ILB3aXdQPGB177GkDMKB6TMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lRC5WJe+dU9h0+myVfNXHjjsegXQtx9pXgsHUB7kck=;
 b=m219D8be6b+xVg+/hq4BN+v8clQAzGle3nYsLBfHEC6X/7jI+fD84LfuChGOPIkY7LLTs8r7ZOQaNBZMOG7Pl582WP/6v8GiQWhYMG7erCQ5YpJsMs7MoKdiYq4lh5vN7I2upV5YAZt63SxHic0OtAkwrVONmDbojM1IhMMOtOI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4464.namprd04.prod.outlook.com
 (2603:10b6:805:b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Mon, 3 Aug
 2020 07:12:41 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 07:12:41 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Johannes Thumshirn
 <jthumshirn@suse.de>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH rfc 2/6] nvme: consolidate some nvme-cli utility functions
Thread-Topic: [PATCH rfc 2/6] nvme: consolidate some nvme-cli utility functions
Thread-Index: AQHWaWIr+io+eDetmU2zfj8+7yVEKg==
Date: Mon, 3 Aug 2020 07:12:40 +0000
Message-ID: <SN4PR0401MB35987890796D42008153A7CA9B4D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200803064835.67927-1-sagi@grimberg.me>
 <20200803064835.67927-3-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20f54224-24e3-4876-03e8-08d8377c9c4c
x-ms-traffictypediagnostic: SN6PR04MB4464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB44649A49AC42023C20F85D489B4D0@SN6PR04MB4464.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tkZ6l7nG3h3IalvcKAlP1jB5sa9frpGdWqOAV6rs+gOO5gRf21tX9GmBl9rq1x1V2A+/7l/u6LnKAyIaQ8utbBND1zEODOcW/Y24otdev9/dbjx+oAG5EpXtEON13El2cVQoH6nvf2K9mnS25968Ncd2TiS3DXvVGjvxYujjg8JT83hKyfK3bUeU5uG/dpoWeDtoSxksijfoJ5bkd05rdJSkfra2CXdYBHTpKrJXL/z2rcMhLjRQTunV14OZYAtNNNiJtCQ/NrqMZIrl3BT3uYoG+VXsiI247CdJGcHwu1+GYAinqSDvWy53Qo1JGGXrhlHWYGsOPoZUxilDSwO4jQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(66476007)(66556008)(66446008)(64756008)(55016002)(8936002)(186003)(9686003)(76116006)(53546011)(66946007)(6506007)(7696005)(71200400001)(33656002)(26005)(316002)(91956017)(2906002)(478600001)(8676002)(52536014)(86362001)(110136005)(4744005)(6636002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: hy5PbseYKAPITCzoPsrPFsQ4nrrbxBiGzgpCOKtKJS5ESicUsX9MUjP0h3HiBbtO+kgwREZjjqjKn8OpkLlvebrWWOkDBr54CbPB23juIuJAyaa6mv6i7H6+nHdM5Jc0h+MmAvEz0ZonDb4MrVNPEq358h2+uzybLfINjm7L/b2NAtJG1jHlKNbynsTQJ16rQxM+z5UpyPkFKf6e06Ctm1iIGwbz6Iub68iOWzc3Y6SPblDGLveYnCENpQUtLNuJLKwTZbFP9f9qQeGmacg108xov4IZzrUo6dBWSahQg15+tlZ8lK3zU3yXNUyAwYGuP/XnKWevJKgeG97HXCb+cyiPrsI60uQzXXclqpzfTlM4fJ+rxEgQV0j7WZGVKz1yFl3OBU6seeL5N6LNHdOv6MMBRiCooFjkRtdPa740AFTKqDNiZJ8nkM8o9Pm1onG/khR4xW+KGXkGnghs9Z16/M2MpEpdeQnDM66uYcmjSW6G6aKKDS+8Zv8dQp4UVaDdE65fjyCS2F2m70q6/6EL3w12RcwwQ7SxecKB4vQhR1lrWt6LFrr/thcITMjUe3xhCx2quIf9ThVCzOVqySwQIQv5JKuOZwkmEzGwWe8TYKiebbsw9PSNYDdItyR7J52+voZLMjDNSacRw8+zMJ6+WQ==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f54224-24e3-4876-03e8-08d8377c9c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 07:12:40.9315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDYlSXkVYVepG7DhQ8vY7hipvUYovKmt/k9aqjoRgt3SyHJhVBgMmhgQkCYSYJjcQ0584UWSRBHSuv5KbTKvykiRCyEyze/f9k6KrWQELns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4464
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_031245_571238_532EE75F 
X-CRM114-Status: GOOD (  11.56  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 03/08/2020 08:49, Sagi Grimberg wrote:
> _create_nvmet_port() {
>  	local trtype="$1"
> +	local traddr="${2:-$def_traddr}"
> +	local adrfam="${3:-$def_adrfam}"
> +	local trsvcid="${4:-$def_trsvcid}"
>  
>  	local port
>  	for ((port = 0; ; port++)); do
> @@ -109,6 +152,9 @@ _create_nvmet_port() {
>  
>  	mkdir "${NVMET_CFS}/ports/${port}"
>  	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
> +	echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
> +	echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"
> +	echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"
>  
>  	echo "${port}"

These look like they should belong into another patch. Probably 
"[PATCH rfc 3/6] nvme: make tests transport type agnostic"

Otherwise looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
