Return-Path: <SRS0=9uHX=LG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99504C48BE5
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Jun 2021 19:18:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7D860238
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Jun 2021 19:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7D860238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=tsXSK3UhruQSEPFNb1pcQtwoA3d2I6zFgytWYMUHskY=; b=qdNy4nnIe7w30p
	ojFIWLpUc0VZfYEUApoZqTMqO+py+3Ktd3zxBX2EPhOCe/cS49glmJCvWTey6c/ZNojvOxxs6dUE8
	6IHxQAqNn7mbhY7WGmX7OfszszUXsU70IjrMdvrhnXjdEye9NW4DpV24mdUHgJr5r3cC3celoX9el
	vWCkai/QdxvkcxExpLqW9MKIbnfw/P4CIqC0TVJkJ8Nj/qCe6FimjYrK+GaD+dW6TNx+Tyr0GgCvg
	LJHb8YKCRvaJb2zIjhID9o+ceIFpKik6tKd7haKULPLXiCvf2jmd0yGtR5YbMf0ti20uPAxdEnPnx
	ZEYD77tlqrPeRlh5DtUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ls99L-0090xN-Vu; Sat, 12 Jun 2021 19:18:32 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ls99B-0090wh-Oj
 for linux-nvme@lists.infradead.org; Sat, 12 Jun 2021 19:18:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623525501; x=1655061501;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=0ka9o54FB0h4LpFjAsijTJ5byjo0m7WEVx0u6VmFVuI=;
 b=p+ObZFo3YieZQJ+sOndTfp175eHwUSrnIHgCAaRzUw3WFMNN917Qq3Jw
 +reOcMeAHOHpOUTKB5fZN4sZhQ2GN+3BbAlZcPJ0yJPxZDABPXffX0VvA
 snMz1P/IbGZzElfOongTYnps8JQXd78S/6tLfmaxDBlPBJcVuWWzKfuYT
 18Ohlb+S86YKAe5xL2pq9uK+qNDHjd3WGAAYd2dfAcqk+2b//QPb/PvtY
 DcLeKpXGC4iWHGj5nsydIpmVuUtdvz0Z3YZWBFM1jNggFIUvj0HWMbtSr
 y4XqfRSIQyOkUZZR3Pg8rYsAZnOe1NNzR/xKeO7LaKVBIunmLjjoXAmmH Q==;
IronPort-SDR: xu63OzZDeJn/t1eBsv8kNbPEhnFilC3KihJmtnUWo+cdW43nlkXh3zqWKLKG20mF2h1KUNnb+J
 p0sHC1z6EdtKjaGDXunXy+ege31qn75ReRw1YmH/Kybk+A2nkaCQa3m32vbC+AuWRYLmkThERn
 HmB4TWdmyGgThu9QFdpaOqpdqOUt7dgK5lraDinTeMe151VvUGVWJMQeAVjqXtMaPy/ZaxJJZE
 L9+z7dMWxkLV2+9ZD8AyQA/fHFfBdsl7gnKGQDihTWDIbAfYF0FGKnl9IowKi0USgPBZ1AaztS
 ZgA=
X-IronPort-AV: E=Sophos;i="5.83,268,1616428800"; d="scan'208";a="170982301"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
 by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2021 03:18:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGdr1K+QW5cVabjxrOjkmuXfVxE4ZEL1hhFT3R64QnfMVbNtVOmubkcxX/k0jgq89hDZWBTlKhf9GqGwkdtWynUPHlq6/ndIuBNpq8y3zix/aErZJguMf1lqcZLTUB3q1deNP3OgBku6SIf+J/J5yPLQppPvKUolnx2Wi9UEi3NAk7e1R9EjPdz/9EaMuKCUQ1hVMWfS0iNd00edFXIdOuVWIT8B0iSbHm8B8JfIEwLXNvZZOwXO2DHZ1M5q7YHBnT8W3QgSxWBbHo7rYnCIv/Js7eubHYZSajStayy8P2nmdyCEnZbtYbew9Af+nWrbCkjeeRZYRV/Z3QzUnKIxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E+HXvYO1MYoWoFXL0tGAiLlvEcXHJMnbVrP4AyK+to=;
 b=UfzSCYXYgIWVXazY0dJ+2VHJrzzOQYUUn2s5FzxKFau/ykDkPp58EOJWDmY+5oHGIeTjT4/vqr3oHi31jutWnYHH6vd7L9yZdOYnIYH7QZe2B7CEWwcT8x4NbxZKVOiZVdEibZyX1anWG7RbrsDPopecudiko5MgQp3SfctdpD1KPfCGZeOF8f6nqWfaoYAocfkpnfu7zfI7PUfR6yUEzVydgC21aSQYbkBPznc4XpthYaQEjOst2zEFCE8htiVIJuSNcA8iA/09Mk50rcEzaFYbqrLO+IX0WSIjv1usse0rHuTUcZnNyAsW9DbITeJOx+Pq1pB0B8UT8P+6Eluq3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E+HXvYO1MYoWoFXL0tGAiLlvEcXHJMnbVrP4AyK+to=;
 b=0J1Zc3RMrVQKKMoN4Td7DJdYwAVrmVkcYC6uZabuOfjPvn7xaPg5xo1yUg36CkrgUycJY0ZIK9n+T6F016Y3jCnQFpnpqs8o2YwjNid6YR1X25YroOP5pprQKxVuWFBZ3Hk/jARGfROBQfJJxzzsvXuvCbjt+cQPTWsRdhGqtAg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6422.namprd04.prod.outlook.com (2603:10b6:a03:1ee::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Sat, 12 Jun
 2021 19:18:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.021; Sat, 12 Jun 2021
 19:18:17 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Thread-Topic: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Thread-Index: AQHXXaK3o1g8yliZMUm7tWfZRJ//BA==
Date: Sat, 12 Jun 2021 19:18:16 +0000
Message-ID: <BYAPR04MB496572D850722F58672395B886339@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210610024539.28875-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB49655A9B821FEE29D7A89E3986359@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210610074546.jyqjalpldii6reg6@beryllium.lan>
 <BYAPR04MB4965AE59EF50A714B12DF42886359@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210611091742.6iefvwlxjlm6oiae@beryllium.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28d8f20e-64ad-4df7-aaaf-08d92dd6d50b
x-ms-traffictypediagnostic: BY5PR04MB6422:
x-microsoft-antispam-prvs: <BY5PR04MB64225B6338BD5BC0A48EA9AA86339@BY5PR04MB6422.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pPK1DQbCyhXvxRd4ouvWeWTIjc8okNzBRMEsGfKH0SG2NdreV23NED7+ZlwpVGhwkMMMPBni4elmD8vpPO68nR/hlke+Wf0CJbi/pBR8XU7xMOH3jz4IXtBUBakboUMKgLHgTS2PVD4dhI/Mm7DSaoWI6NH4Y3n7IeDkY6nTFUG53rdf4c6S8U80bReQek7Cu3pEm+SF6t5KPh3fjtTJng1mOWzfUXonLyqwCmtOj4yyrpuSMN7CCEr2DjtGodtDkxXzp7kbhZBT1Vt2paKZDOmr/Fse43flQtZGVsscVgMGGnjKPDho4GBcs2SEAOof300X2erhZtdhhr/DFm+NRsGx2ab57M+0XSWH6/nVKHCwDiVo/V+pPrWAQjvxu5GwRDxZ4ciU9IPkYPE224YARi8cTkIakWBTB6aqA9ZHmWcBA4hmr4sdGPviOrXNoNMryVHPINQTeUnF9+LNQGDBwDL2617On+uWOjlZLzKOtSNDaQ4IUJkVgvmrH8jsNnRgXILNDNAd8g8DxqxRl7veowGEd7wi3o4hg7M3ZH6t3GJPHOjwatq+9TBP38boJoHzksOKtHkta6qqb0jZDroom+Cygdb4q/g3LU4t6tqccEM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(6916009)(33656002)(26005)(2906002)(8676002)(15650500001)(71200400001)(9686003)(83380400001)(86362001)(316002)(66946007)(76116006)(55016002)(8936002)(478600001)(38100700002)(66476007)(66556008)(64756008)(66446008)(7696005)(6506007)(186003)(4326008)(53546011)(52536014)(122000001)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XxWP+WuYTxBNQTZuywmZd/bw+ho7yBGhgv3Up7RcozDsXpSLyWViMYqhiJsP?=
 =?us-ascii?Q?T7csQYZzQlCj8CB8Pl5K1bMzAZscMTyRJ2y6Sxavg8YMbj7Tq06yp1cM4IFw?=
 =?us-ascii?Q?ZMqZoFkZduMXAZk3HrBUfHFTzIcnGVJWnK1UH1p9DW9qz5ily19Ct4RzLwIc?=
 =?us-ascii?Q?OzMikHjrr/dicu8RcwgAy325+YikKvvpiSwUuWRyuNLgE40QRkD/VJTqjwiL?=
 =?us-ascii?Q?X8W2gBy0ToEHPJh8+rEpz0ck7d5waOmACpNEILr3UdYTWBZ7f6Zdf6KFHHnm?=
 =?us-ascii?Q?RSWF0Kbjca2Z7h2lA1hE4wCJv9TNV98sUsTQWZcZ2Yi5uNN+m6H/aurC0BFu?=
 =?us-ascii?Q?BMv6/5cJtxv9gyY5LpIl5UWqyD+01BatTIOCUsi9+2DlAxwxAGEVudAdpf5h?=
 =?us-ascii?Q?KE94PlTQN9wROuJo5azB0N1SWW0ovepyodUhUMSnWZSIVNGVaDBET5TXmlJu?=
 =?us-ascii?Q?NAXllRuP8DQ62GIbNo+4p9JR7Y0BuHWZKJNC6zHu79K+YDEXjD0OE9d9IJ9V?=
 =?us-ascii?Q?2EeULhOIzfJZP3USu/OXaxvnf++iZO5vr+A+eRq/wj9/gUD5KpM3g09fyVIp?=
 =?us-ascii?Q?OIZ4FI/lDndjvuPr7mzWJBS5j168JrryLNxsoRnXVJjjVcghv9gAD8yENvcv?=
 =?us-ascii?Q?/dnYbKZPAotbRugBNqQyIEyhYQ6FlfgsRw92nywzn50qq6WZJXYHi0Ug6kM/?=
 =?us-ascii?Q?EnBjZh3I+XZWANSszpgbgY1wikDJhHsBfZpxhQxkqWszC/GbePZ+JBOplWAd?=
 =?us-ascii?Q?W6zDXQvS4au5g6PU6E9fNQkAjp3KGd+ZpOgURZjsPxiC0fsr8tCUTqYmO3bE?=
 =?us-ascii?Q?mvty1E48pWya0aM/PFBZX5moLOgjHx7lcfGi9gY3ILxO3ZShIXAbKCB9dcl1?=
 =?us-ascii?Q?df0El25c4LlUFKxoQ+mK45GdTBg/NG0VyKoPuKhFX1xp8228JPyZOnvRzu5a?=
 =?us-ascii?Q?DP0pWg2Ix4SggeS8YBFYiLLpKX5WKnKZgbHZkYov92dw8LUia0ZlhhE3OK/U?=
 =?us-ascii?Q?mKHuKZUPk9jK939QCzJKQEH8i6aVn9OGBojNKoLefQyLOlvEPORMD8cyOCaw?=
 =?us-ascii?Q?vWTts2beKJr893uj+Tzwj6EkRNSLDZm2Qu/IQTK0lvA9f8vmVYlgbthvTQoP?=
 =?us-ascii?Q?S8vmE5Y00Rs93162y2DltwrJ/CJuAUDOPZo5KNgbc1qigKZFoe9VHL5dskHR?=
 =?us-ascii?Q?u5ZfHwdfxiSsDSWY8iLqaFuqhmao69TEtX2Vg8clfugp7qp8Yz54k5UWcDM4?=
 =?us-ascii?Q?3FTQ5Q+EpwJAKhDzHnmE9l//ORUK1yIyhIgKvdwJxHTsRpUU1XE+1XlTdTvx?=
 =?us-ascii?Q?Vs+hk3L9zUQfKtmOiFWkXO53?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d8f20e-64ad-4df7-aaaf-08d92dd6d50b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2021 19:18:16.8479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bMvJVpnTeijKb1CO+C7y+v5efRUhrbB2xyXpYAxoeqobFLfBo0WUJIG7Avu8ofVStZqIduZf5oE9SVM9KLCuXNZ7EdE73T7rLrVnNJe+0AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6422
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210612_121821_962385_5B0A1AE3 
X-CRM114-Status: GOOD (  15.97  )
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

On 6/11/21 02:17, Daniel Wagner wrote:
> On Thu, Jun 10, 2021 at 09:01:14PM +0000, Chaitanya Kulkarni wrote:
>> commit 1368a1a5e7566d726bf74234d05895c3f0d54690
>> Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> Date:   Wed Jun 9 20:07:00 2021 -0700
>>
>>     nvme: fix the comparison in the mnan check
>>    
>>     The existing check for the valid mnan value will result in the error
>>     when ctrl->max_namespaces are set to the 1024 from NVMeOF target since
>>     !1024 == 0 so it will lead to next comparison 1024 > is->nn which will
>>     be always true untill target has 1024 namespaces.
> The commit message doesn't make sense to me. NSID is not limited to
> 1024.
>
> From the discussion in the other mail, I though the argument is, if
> there are no namespaces on the target the MNAN is allowed to be
> zero. The original check assumed there are always namespaces. The
> proposed fix drops the first half of the specs statement:
>
>   ... then this field shall be set to a non-zero value that is less than
>   or equal to the NN value.
>
>

But that will require any controller to have at least one namespace, with
current implementation we don't enforce that behavior, maybe then we should
check that in the discovery or id controller path if ANA log page is
supported ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
