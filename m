Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F28C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:41:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531DE64DA1
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531DE64DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=rrBhvIvUB3nEzNl1lP+9OcO7tkoqgoJwN1AHdV1uE74=; b=EQzEzMG0pp9dBwQ6ASCmZbBr47
	h4eYEO9eIYXuafZ44bNNRSz60GAeZbkYXXhr4uEJMd5rJWmdHAcX9y86m6N9ZXxHj/d8ZNiyS/Cuw
	6Sk80gLbBIksRz5Vas1JHHdHBgkeVmwlB3qTjpOKYcach0aup97EcRgWUGrBsyDZHnP7JaSKRHdnP
	ZrjcZe0PnheaCcGBYKCV7aCDg5vmt/t3PGJT2y9SbGi0tWP+Xgej0dKmJGmbOpHWnCbJzC8C78D6v
	NCLVsIvR+ALS/WTygdsEpKldbWmHWSrGszJMK5hYgGnWg0t2CQVPs8ZU2gMAGo7deRco+RvG7xGAd
	D3+MCofA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9KqB-0007mM-En; Tue, 09 Feb 2021 04:41:31 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Kq7-0007lE-G7
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 04:41:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612845688; x=1644381688;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=MmgyetGZjXFhr0HZka1/E6B2XvQaTFRZX5w9jc2xElQ=;
 b=FzTbPjTD5H4F6lgAUsQSaprqQ41R46fBj1hd6OaeYimcOOpwqmuItFXN
 EcVILTEYnn73FUtwFpQilrQJKHcPYPBeDYSpOBAq/0rcUDnft0Lau9sc1
 V54HUHAE6Vaul0UmJf6xtB5NpXfZ/nyoBd4fPYzAIA1MXkbUeWvTIKt2i
 C/rmRCLQAWkrGCMfIfSBSAQCWtbBzVWFmxhvkb1B+JeusaRheT1ssx352
 IyJ/yXYn+KShF/J0Acz6QAtoE7+ASqMRITpr+p+xWTk/3bxFlxppBxHrO
 juxO1gaTiChCC+9wKZUO/3KOWaDe3zRJbWgarRpmEH0o3ip/eye0U3fOe g==;
IronPort-SDR: 8Uf5YTtg1jR2XJ6/rjDP1R5Mg/UeSW0d//zJl/ML4xwqUQEudAu/0HJbFsxnizASR8aDeN/P17
 hNoY0E69P86mXhVUb3qDZGBbIX3T4lp/Ga8rte8WG9ITBcm2nDheT567wvdPW+ZKIS09UuSkhy
 qTIjCO7PQfj7noecseTP8W1uWradQDs8IhyzdkGJbDedBdzlYsERSZXFbDZcSqsW6jT70fxuXT
 9i5hs9Cq9immDRlF6iFnF9sHPk3Dc/0HSIFw4QImfs4h+gIuBGnaSfHB8kI0cDDHswl9EJCMSB
 xIQ=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; d="scan'208";a="160675578"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
 by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 12:41:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5IzCC1/6h3x+SPEQRvDhXh/CgJF+6PwNMteDam/R2+UfIYr5USxpQz39GubS+Dbto7lcWsbmW5Y2GeTUgOB3Y+8UW1CynDZniTDlUI+TqfFonaCQ+H9aubKtMpCfsjlcaAk00pl75v0Ytt1an0XYHZieSM3Tmf5C78RaXwrKLUROFOLMy+IWRlS3nw41VQBBgXy4WCpDygpS/TxMtfGJMaGHr6z7x9wrW8rojP1tAoI+FJMz5ufw7tXQOsd1eeZ+IRJ4P/1+gfnhB6YYevcu5pG6ZZK0K+YCPbzlozmd3hJyB06olw23G0mLgyhs37ynf/q/ExoG48jsNVuPpeipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmgyetGZjXFhr0HZka1/E6B2XvQaTFRZX5w9jc2xElQ=;
 b=LexiXRHqstOm6QVJiPTISxuN8FQ0ZS7TrJRSNDO3O7GB9g+NQQGdPk3RP/VZP4CYvch+PaSh64VVzzCbJ/DDfWq/MF9bPZVtEZSr+tfN3i6DP7EP9Sb/FmWV1rJO/ROJ5ceXVXwMN7oFNUFfuJuwWgqFoxViO9LDc9DerYzqAq/ywSKFWWA88BkAx+LSNItuOr0Dvl6gsOTtC8UpvYH4iPoi5xp61kxOVWyCTdmxPJipFWbBt2JVzkaXv1XxRsmZYkMbFQLLKOpYm/z2rAeEG4csvgP02sZUS9NQvxOMaRomQsb50peW7pea4nL884Fc9v5eiaVUzNEhbwJlNlMhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmgyetGZjXFhr0HZka1/E6B2XvQaTFRZX5w9jc2xElQ=;
 b=PmrDCr1W+lE307H4oOgZPDpxA7G4mMNvZP/r8VJ6UEFVJ3ktXVhLLJOZWtGJA0sayDnrjmOlvPCAQi64OIic4jn0aF90EcisCzagvNPrW05gKZV3pnMV7rbFufZyVMHZ/mCI8zN2fh1i8C/Yug7jbqOmBiJl2a2ib8IUZmCI0RA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4984.namprd04.prod.outlook.com (2603:10b6:a03:4f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Tue, 9 Feb
 2021 04:41:21 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Tue, 9 Feb 2021
 04:41:21 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Roman Shaposhnik <rvs@apache.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: vhost/virtio fabric
Thread-Topic: vhost/virtio fabric
Thread-Index: AQHW/pw4fOXGciw2LU+3Lp8eHNONHA==
Date: Tue, 9 Feb 2021 04:41:21 +0000
Message-ID: <BYAPR04MB4965EC7FB74B38612065CDF5868E9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <CA+ULb+v-2jigmQA=Z2WmWP0n3wCbEs_s94oCoNbjJMw14ATCjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: apache.org; dkim=none (message not signed)
 header.d=none;apache.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3ae6cb2-8550-442a-f096-08d8ccb4f2b6
x-ms-traffictypediagnostic: BYAPR04MB4984:
x-microsoft-antispam-prvs: <BYAPR04MB4984BAA4DFCC5A254687A3BB868E9@BYAPR04MB4984.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IjfxQN9VSipVQ82x5xO5xfZ/Ie4at2dbKIpN9DHXKkTh2pE/y5gpcbLt8r+yOogVR3kO5T7xzOfXJLIaEWNOo4hqmqLtWCsW+d+KxQm+B6rXa8zFQOz5WZQSNZuGbeuxXmXcraXHCUCkL9uEWv+z6Dp66nhu+gY+49fwNV6Bf3MzJMy5NjP4/qRY9TUJQ0AnnreyquvKTWw7b/MtnnglJR1gza6/Boxme9PzIsWImxL7pAIql9PCPO8RvJ7MYEjqojUQ4hUnreUaIole09iVIcCli0FigtlLpm7hnd8XOnD+iGk5wpdMLS5w+Gdyt+QSnWYrhYU3u2PEY3aOZErcunBYBtDod4uOxhbO+crAZuw2ZoUrhYgDfB+27552gP+Qy4aSvgvSS906G6FyNWOotrnLOHjxmN7Z5MfUJfhDi4tYrC73F6iYG1q+nUsAu/3U/Yx7GyymCvxMQJjQj+ITAzrWrUzUVuTe9JePKnBC29A9SQJ8jSR1wTl7Ut2pVLxBjG3SC3IYR+/HWG4UHHYuTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(66556008)(66946007)(2906002)(76116006)(186003)(55016002)(66476007)(5660300002)(86362001)(64756008)(8936002)(110136005)(83380400001)(53546011)(6506007)(71200400001)(66446008)(8676002)(26005)(9686003)(4744005)(7696005)(33656002)(52536014)(316002)(478600001)(3480700007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?W+w0tsnR4mWm33Q437cM8imip7yH1n11ukN2M5cLAGK3InSQAK4GUtOBqXZM?=
 =?us-ascii?Q?G6iOwYd1p5KfhV/yglXp+lKo0RVYqxeGIMzS0cCnBYYtyYzfQdf4vNJHGseg?=
 =?us-ascii?Q?puYzjvJUVKl9htaJfSO3HJBcPUh2AxCFbgcSU41RdGSV6vD1MWV2oBnJpqPh?=
 =?us-ascii?Q?2CddvOlG5FR4lJNjfGvyCxIWYm8orUQY4CBcDYl94DYR1/YGCO6JsuAvVpq3?=
 =?us-ascii?Q?kr1ZDvB65WBJZcRwHj5tGVngSXIOVsyMhcsi4jJZyNOfJjYpvK30mHbTEspp?=
 =?us-ascii?Q?2DO4VPNggx2chsLYm3ODXdVR2yrIYLgETeAYHE2gyFkSsZYrjiNzkGbDnoJI?=
 =?us-ascii?Q?nRx9pywqiPxJYtgIUFzYle4+Gi1DtJm3Dk/+7CGArOLLBl2KCSlOsKo1Gy+7?=
 =?us-ascii?Q?6Ymfbc7NzpAhQjdYo+dG6eax3wQRGGaK+jhSZn0U8+QyzTLMwuAXYPkhUTTl?=
 =?us-ascii?Q?UrviQiJ7Ay2tImzu2V1sSQ3mzgaUbA47uz1pT/Ed06RfffzBlbVuxLcPBIaP?=
 =?us-ascii?Q?1O18nSnZuIFKJngd0F8mSPnmu1+VKYVV1OB8uiMnrh4cZ1DQyAHJcQKdWcOP?=
 =?us-ascii?Q?t2d0Sh3DOebL52U04WY4MMHBrUT+oNu6qV5c6yqfqJKFY7KFfC1YNPq/VQzz?=
 =?us-ascii?Q?XLmTHhyuCHg5a1tJuIeAl7AuPFqlLZU4QWwWLHxYpY1iNlsBxz1vLaiIQl8g?=
 =?us-ascii?Q?wHmR/Z/mBD91GNFTHBz8/SaHXccpwgiRgQpIo4v9QAj0YcYOeCTU0+2I/ys6?=
 =?us-ascii?Q?lJRkLo6RQGGvGSae5ypIM+Jk6EnCS5B12lZ6n4df7Uas4kA9bsFpm7V94Eq7?=
 =?us-ascii?Q?W9r0WcvbwemudOCNcZv6QavcshvUQuZn3ijBd+uOSQuU29JibpbV3sT6eZhV?=
 =?us-ascii?Q?nSdBL5tdJRJMmHVvF8pEi+cn4frBsPjV5wVTZZGJmfKgeaiUyfBxEeUXsvzb?=
 =?us-ascii?Q?gIBDRO6gim2/65MtYhHGwmx+ZJJ4XlEeEBRFLmY9b2nzZDr7LCmKDxN9self?=
 =?us-ascii?Q?Yn490BUkiWbge0jwT2peCYqYhLhe+oh/MKDyjCn/BEQRv2R/ogcldDSaWQct?=
 =?us-ascii?Q?1xnzMwYempFH8fHRMmKh8BJ5wuYs1HcuiAFWR8AQoS+7BIG5p8TyoBBFwi/q?=
 =?us-ascii?Q?FavlTePYJ5Uo3F7FiBnwivpX8PW+gdWrwV41r7CA0pH+3cGZpuOAZ+2oZR3D?=
 =?us-ascii?Q?CNzsbb0XCuK+wHraj81Fs1qAyqzXA2By1CCJtsMEg2sP0aATV6Qocsmv6XcB?=
 =?us-ascii?Q?ypUXCJRTKpkcu6CkkhFutJPpshMc4nCFLR9jqnU0ekgnxZ41TowvnfsImIrb?=
 =?us-ascii?Q?Xz1el4+4dHgETiltN2HkCsfR?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ae6cb2-8550-442a-f096-08d8ccb4f2b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 04:41:21.0580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJeonoFoCUkSZYR11eQyUoQDzslUP1eJ8bn1ulJcLYH6p+oz5mudGKlHfHDrGDxukwXGT7JJcSOWRktc4+zjgSni22JJ7OWIpAnt9YDNMOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4984
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_234127_812108_72285852 
X-CRM114-Status: GOOD (  15.68  )
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

Roman,

On 2/8/21 20:29, Roman Shaposhnik wrote:
> This search made me come across an old set of slides from
> Christoph Hellwig that did, indeed, mention that at some point
> vhost/virtio fabric was considered.
>
> Please let me know if there's any work that has ever been done
> in the direction (even if in a form of unmerged patches) or whether
> if I need this functionality I'd have to implement it from scratch (probably
> aping a great deal of drivers/vhost/scsi.c).

At some point of time I've looked into this because that the next logical
step in the ecosystem development, but I'm not sure if this will be
acceptable
or not or do we need to have change the spec. If there is a strong use
case I'd
like to definitely work on or contribute towards the development of this
feature.

I'm interested in knowing what everyone think about this one ...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
