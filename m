Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E9FC433C1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 06:23:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98764619B1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 06:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98764619B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3I/zjUtAzJlNgrIX19lwu2uRJgC/KGSVxfEB6/W3/rQ=; b=jJUEq0kPTRnc8hIWB+DpWcHdg
	8YNwZbzNdiFQ8CDaUNSRNWhFiiPuF0jm6+a8cZN7k7ud2uDG2enQNARMggXhaUy83H7S4+T+Yu39h
	V0jNnsc77YLyvZaglMdPdnwmOWVbgVfrZ4ynha+004L0xZUGgET3YFhY/XGHVQaBvgKJrfD5+nmDJ
	N70lyuCNn7nRaRG4JoGJ5p0XmDRuZfkh3aqdnvvLjWxpyFJp+YMOW7D5BkCWjckdMWab6N75m3up/
	vqlg8U2WCYoH3mkTeKFMxn9c2nxyEv+1ugDxi958brLPT1bpSpMVzlDPl+X41VkKxQSj4P6PahDSS
	uOyBN9Ejg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRUFU-005brs-Gk; Wed, 31 Mar 2021 06:22:41 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRUFK-005bqW-P3
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 06:22:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617171751; x=1648707751;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0S/Z3EorJ88pc6VMMBdOoEIETo239Jnnm85592nUNLM=;
 b=A16abKITT01wS5vmZRB2qtXi8xF1PYqIMov8KnmATcWOzRU7VwI1uenh
 ckAOfkQwGJkPcjgsEnpI7HdPGOZe4Fp1DYw8XVIRQ74VRrCWDPor354E/
 QcOCeXBkoF7YQ0822DkbxsP9bXRetGLeCgTEA0HCHBHgDKCz7ISc0ZMSK
 Ae/XpptsEHLv3NRElSg55LpeAX3zG0fT2Vrk2bp1J6Wq12clw1LQPg5Nx
 0C3vKdQNFVvnQtKsfTSfDRhzPa/0lUumWMz6P+MvCPdscYujbgr4DBys3
 wXaALsTD9vitpOw0fRHFud2wm2FfkiYSiSWW+VYjr6lOZaGyhy+TeTnWa Q==;
IronPort-SDR: FOsUWuL6b0keXoLX5fptUvtWAStJyoIPOa05jZ+/eKyjUfYyEsKY8TzUBo1PT0ccnRvhlea5pD
 K46SVR26Qg7RSoo9vHtF3v6b4cNLrJ+rmtQHvhxvHiidF4L3j6nKj+00IjNeCOF+ssADTTzIv8
 6bnxjDgg7+7EIHCcqQkiIlnMAOKDOEYajm5F87S3r+r2eLrS/1gikkPZZo1YuTzuu9emLssWek
 Yb57v7+MYGSjLxzyVjMFy1adTDAg6wWkIUvPlvdXKdkL4Nlp2gBHQ0QJRTwDgOD4whpcYiOjzW
 jCw=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; d="scan'208";a="164469032"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
 by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 14:22:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWNhD59lA/5HGLglM1Lbm6YYsc7N8BH62QRd+yOS8gc7Y+X2tinUloURe5pzJ1QGQ/3Ca2lQIj6jzMkhSAewHBIr87gD6RgoX/VVZV7j38LVeZzwyFcXSv+4gTMLBK0gTRlp+ykREW/6uOz3/c/M7Doh630Geebh8e3FXCk2Q43FIopiKVALDJfgVP5OHEuSmOYNzHb6ROzuiThWN11tSQYs+e4P9iYiVzhRcmTI50+on87gDzqLYfPlaXFDKunCtwARlOvjlvow3x+XeU3ZeCrPkeMvmlqu/qr/hOAfgC0tj0z3TZvW96zdmYff6RO/px3+80toYL8IcKxcdaIshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S/Z3EorJ88pc6VMMBdOoEIETo239Jnnm85592nUNLM=;
 b=WaUjxHOUK0SAW6ZcGWhJ/o3+2pC9qf9sF4qjvYpNq0hKM9VX+CJBjZlC6ZGQycd/wSVAA4qt+RROBWq0HI7prch9K2yNrBJ/eF9nuFPPqYdxZc11m45vWQT4OUeYhQisgeimwZCL9cS60wizH0A6+a2VM6SlG37ivLizBaofrMONywY6tMewVUnipayvRDbGUjvIK/aaVHt3wLlYdcnyzyJMoFuxeJ85OCc3fOr7eczj9LA61yQcdEox/rJB+9fZuOemgs7QbcSAagW7ZsEpYO3BGq+JTfQVJ63nEkGer0WO73X6Vl4t4o+/er3wAgHAj0UkvnU6yxUcJWOiN442xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S/Z3EorJ88pc6VMMBdOoEIETo239Jnnm85592nUNLM=;
 b=seD2MTwVF2ITX2Gnt51qmAhSR1Jh9uAquVK9GEmayW0HGc/EahvUXeRBlULjRmTczXRUtE99CYbroz0UynzXoV3Sd5Xrz1CSAW/LWH9u58fAIzMql5obcpI6jhc1wBNxN8noFcS6ROoJ4GNpKGgnOTk/kPGJlcuDm0J8zvqsQuo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6021.namprd04.prod.outlook.com (2603:10b6:a03:e6::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 06:22:07 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 06:22:06 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Hou Pu <houpu.main@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/2] nvmet: remove unneeded code from nvmet_alloc_ctrl()
Thread-Topic: [PATCH 2/2] nvmet: remove unneeded code from nvmet_alloc_ctrl()
Thread-Index: AQHXJVwu9IEuRQM9c0O+ybFKv9NEJqqdXXgA///OzgA=
Date: Wed, 31 Mar 2021 06:22:06 +0000
Message-ID: <5F1FE896-F02E-401B-981B-D7D8C0E5CBC7@wdc.com>
References: <20210330115907.15432-1-houpu.main@gmail.com>
 <20210330115907.15432-3-houpu.main@gmail.com>
 <BYAPR04MB4965E59C632B8A45D015B4EC867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <0eb32563-a2f7-3b20-64b5-bb17c6981529@gmail.com>
In-Reply-To: <0eb32563-a2f7-3b20-64b5-bb17c6981529@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.47.21031401
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:270c:1100:70af:1378:4a7:424c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6be82e50-c375-4386-fff0-08d8f40d4eee
x-ms-traffictypediagnostic: BYAPR04MB6021:
x-microsoft-antispam-prvs: <BYAPR04MB6021D898A3E394F851E7F96D867C9@BYAPR04MB6021.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqWSYJNqrBXv4b7g6ZQfvdtrsEbUU5FRmfu9q//abZjean+dqJHoGBDoPvrrXXyTQFGQpd0J5B3AkA3qOFvR9CyO9ICvY0Y77KY28d1aeUAYP2RyIT0X9VQNMYOr24sFf7bIUQ6UMbPRXG13C42OHxIECfw0MyxJz9+vY3BwpXgb31wV9jTQd4E4fH3ESoFPrRn2jSx0E5QdGxaiYTBbHF96dPhG0gSSExqtrU7PdLz3dePNtLK7VXK3t3HdwwFumuIdmca1vpQvbsmSmM9D0zgIVWB6fp9bSL/JL/vrp2oEq/S8qeDxCrFkgEQ0B6LTUSMgPMh+zkROqx12IVjzDAHJdw5jJBzwCgNnqp/c7WLFsfPnx2OC4Xeb0ptuabFGwzgxmR/UnkWG9vospFa3U3MOtGbAyNeiJGydFt6oE2gl56R5d/ZZ47icUdf0LsfyYzNoJyX8+n2ql6gzchJSc37Ab6glpt8M9U1aZuiNy9wn5sQI8Lnbyqap7weO4Sk9AHBBWynzyndoufQlmDAuAS7NZdKfRPtMRhPh117NmTAXDzqNieH+bHU8chcvQWTQapb8bHROElY6ZpFuK24hYXggXJ3/L/5kgUjaRYLGKK0r/UDwiBKKM1PSZfM9NoBEGow9hS6QmZvr8VCvnlmx8neDZWKGtlMUT6pC79SYSVB+DxGJ6M9J0h0zNG4kG4fU0lCK9AmEQybtZxTgFTksD/2YdB+dwJuAszaA9yvwYxCjJpdjULITiawnaHl10pTKM1ofEa2S/EVuYxjn5bhLrQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(33656002)(66446008)(66946007)(76116006)(186003)(6506007)(2616005)(8676002)(64756008)(53546011)(8936002)(71200400001)(498600001)(2906002)(66556008)(86362001)(36756003)(6486002)(5660300002)(6916009)(4744005)(4326008)(38100700001)(83380400001)(6512007)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RXhibVhwbkpvYmxXQkh0UFI3WE5wSVlqSVNlclppUDk3aWQ3a2FtS1gwT29P?=
 =?utf-8?B?L1Z1am41aHlPTVdUUVF0dzNHTU93MGN5MXZrMUJGZ3lUZGppMHUrbUZhUUpZ?=
 =?utf-8?B?STF4cUY2a00valY1SU1jbjVzZmY4YitHWWhaRzRuYVZXNUF4eHFIUFNoUDhF?=
 =?utf-8?B?cnVvL0JjeGdUOUxPcWVZRVZvcUw4YmkzUG5PWUFXU1ZjRFh3V2JoWUlNdVlu?=
 =?utf-8?B?dEl5Y0Y2akNlMjZrM1dqNXQxMXA3SmJSaDExVGw4RkxBcm5yVWcrNkR0Ymxn?=
 =?utf-8?B?aVhsb25YTlBxcWJlWnpXUURFWVh3czRqN2FGTEhHeUpVblRjczVmRUlaS3lh?=
 =?utf-8?B?dFpxaWJ5NVcxWUkwdVh2MWxzZGdxbHBNTWpNbUs3a2MrY3pRQ1BTZG0xTjVp?=
 =?utf-8?B?b1dhQWFoTkJxcWxGR002Y0owWTcvK1BYUFcyNHlna3JPa3ZURGpIQjBsY3pQ?=
 =?utf-8?B?Q0NwOWZ3a2cyc1YzdEdLWTZiTTdJbCtwVS9SaThBUVZMdU5oSVI3VFRQWHlU?=
 =?utf-8?B?Q01nN2NMajBJOFBPc3dGMm1rcXpnRXY1bE93U1hEMDZKa3NCYmlRRUhNWlNr?=
 =?utf-8?B?cmpOS2xLeGpUSGIxcHVUQ0tpY2k5azVtUUtjSDFKY0JJeHYxY2xpRVNxQzk4?=
 =?utf-8?B?TEtrUnk4dWVUTDd6QjR5UnpCUWNvWW4xcnNqWlpjQVUySjNNc29vWmdmdTVl?=
 =?utf-8?B?MWJDS0NOeXFPME5Pc0xjQlVVV3JiOWNtUjBMY0RJLzVKeFF0bStrcEZQREtB?=
 =?utf-8?B?bThDZ2N5N3JvNlFob0tITFBXVzNpMVNuTkl4eGF3VUhQSnpwdFpVZnNFRldO?=
 =?utf-8?B?bCt0Smh2enNZRExBd2VjRFdLa2dBZHkwS0FaM1JQZjgzZlVXYzVGWGdsMWVT?=
 =?utf-8?B?dXdVU0RrTTF4N3p3R3N1MUk5eThLdXNCc1dsUjAyd2dOSytxTjhxVWFjUWxx?=
 =?utf-8?B?RE9XTTljd3NGRVk0VllUUGV6bHpheDNEbHZjWDZSVXJuaUZxYmszVXNkUG9U?=
 =?utf-8?B?NlFpeG12ZmVyZytESlhoVlN5VzBwRGhRL1VySXZWZXJqZnFVWTFjTkVoOEFq?=
 =?utf-8?B?VWhneTA4Nmkxd1ZZOXQ3T2FqMWFiZFY1c2RQQkdJTmNYeVhRVExMeWNkaCtZ?=
 =?utf-8?B?TzhOU3NyMm5JOWVEb2g5Z0V1dmNCVUpRRkRzT2E1Tk9hcWxsV3lkWXdCaWVO?=
 =?utf-8?B?UExYQUpYSWtmMW5hdnpWNHlEREw1dzhzY3NDWU5BUWltVEl3aEFrcDdXQ2g5?=
 =?utf-8?B?TEJra1JtQUNORFc0bWcvQmdXOUVCYVBiSHQ0WkpLWWtFNS9FOUhBY0dpODdT?=
 =?utf-8?B?ek8wYjhnKzk2RUhIWU11YnJBMTBFWWVpMXlqcjZacGpqU1VRY0ZtY01VU1d2?=
 =?utf-8?B?cVovOFN2S0gwT2dYLzhpZTFYcndBclZNeUlqRDUyQUx1blduODZUVkVReGV1?=
 =?utf-8?B?c3RRTFJVNm03ellMdGJWeENVMjF0c2k3cVIybEplTjFjRUdURks3NndvZzJu?=
 =?utf-8?B?WFFTdHRUSW53SDluNiszeWVSbC9yV2VIVDdKNVFuNEk4YkRMTkxld2Rpc3Zn?=
 =?utf-8?B?eGU1OWdCOW8reXRCYURhNHJTcFBmdWVBcytFSGNuMVRoQzQwU3I4amFaN3o5?=
 =?utf-8?B?NFkzcC9vSmIzU1BwQnVRQnhhaXgvV08xRW1temp3cVowMzhtc1RZc09nTUR2?=
 =?utf-8?B?NWp0aDZJN2gyTjFpcVFPYmZoVEJLYi9sK0xGcFRyYXVlN2lCSTVOYTl2QnVB?=
 =?utf-8?B?OTlYdzFWZlhuaWQ3ZXYya2VmQVBDOHh1RUxZVkRFdlFndjJFV2V0UUxrK1p6?=
 =?utf-8?B?TzdoU1lOMmxuNjZpQ2FiVUhYWGpiZ0gyMXZjdmF5QVJaZWNpL1hmR0tyZVQy?=
 =?utf-8?B?WTBOeUxJMzZreUtXSUNHQkpRUEtIOFlIS3FsTWFqUlBXd3c9PQ==?=
x-ms-exchange-transport-forked: True
Content-ID: <F7AAA0D2A89AF34992A4192733DC5A67@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be82e50-c375-4386-fff0-08d8f40d4eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 06:22:06.7963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9MtTzdBDmTZafu3GKWneRDRJgqLhAt8M8TpxJu1/L0n/svHjaS7GkXyaecu7abQPNxUAT6wpfJX6hrD7V9Ud5kc6Jd6uxEASROCXe+hjgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_072231_652074_4F035CEC 
X-CRM114-Status: GOOD (  17.01  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQoNCu+7v09uIDMvMzAvMjEsIDc6MTggUE0sICJIb3UgUHUiIDxob3VwdS5tYWluQGdtYWlsLmNv
bT4gd3JvdGU6DQoNCg0KICAgIE9uIDIwMjEvMy8zMSA3OjMwIOS4iuWNiCwgQ2hhaXRhbnlhIEt1
bGthcm5pIHdyb3RlOg0KICAgID4gT24gMy8zMC8yMSAwNDo1OSwgSG91IFB1IHdyb3RlOg0KICAg
ID4+IFNpZ25lZC1vZmYtYnk6IEhvdSBQdSA8aG91cHUubWFpbkBnbWFpbC5jb20+DQogICAgPj4g
LS0tDQogICAgPj4gICBkcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYyB8IDEgLQ0KICAgID4+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCiAgICA+IE9uIHdoYXQgYnJhbmNoIHlvdSBo
YXZlIGdlbmVyYXRlZCB0aGlzIHBhdGNoID8NCiAgICA+DQogICAgPg0KICAgIFRoZSBwYXRjaCBp
cyBiYXNlZCBvbiB2NS4xMi1yYzQuDQoNCiAgICAoaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy9udm1l
L3RhcmdldC9jb3JlLmM/aD12NS4xMi1yYzQjbjEzMjgpDQoNCg0KICAgIFRoYW5rcywNCg0KICAg
IEhvdQ0KDQoNCkkgdGhpbmsgSSd2ZSBmaXhlZCB0aGlzIGluIDUuMTMsIHBsZWFzZSBjaGVjaywg
aWYgc28gd2UgbWF5IG5lZWQgdG8gZHJvcCB0aGlzIHBhdGNoLg0KDQoNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
