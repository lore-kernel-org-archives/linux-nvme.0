Return-Path: <SRS0=Nmzz=DV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8333C433E7
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 00:16:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D8920776
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 00:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ECMAIgYk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V0NoDyyq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d07gDs37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D8920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=TVSXRO3CtpJpOgl78GjkFAVbcAJ5ilQhrxjkk0Mwg5I=; b=ECMAIgYktlAylVLEiJiBQhl0a
	Ru2Qs/e/XSpdUYNj67u/grQ3fu6YKchvkUZ56hbhhqiFHlVtvpPNIxIMpOdf4HVzSJywUZsnSD+0J
	I3ewZUbeakNaSeiHB83IhRtPAk8VNezI2CJ3AwT53NpAuAxBCExvRJZQy88OkfAGLdkhkstnSmI3z
	j0z4oeR6D+1WfSVwecJkMy3GMLhWdKfK4hQx7STD1hEKr6HZadqgZp8qp1qBp8E/F4y7a/Tri76bK
	zsBwPRc4PbED2cLXR8lGVEEr9HQgpTCQ014LFDqpvcjhEa8vTzftlYhXtHLnx/7ETHsc09HDoa9Bd
	/1/ikqaSw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSUSx-0002pU-0X; Wed, 14 Oct 2020 00:16:27 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSUSt-0002p2-OW
 for linux-nvme@lists.infradead.org; Wed, 14 Oct 2020 00:16:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602634584; x=1634170584;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=PzroMWmYMhOGc/OCTG99XTk8I40ftu8u9inKkJqhOC8=;
 b=V0NoDyyqmqnAr6mMn2XqCwnW62VtHMVlmVCq8bRNjOsn+SJ3vqPmh/Hv
 dXafyjqQpqFAMoM11J82HiTaIjBBb8grwNfvKHDrhP7bPwMbC66PdalRV
 rdlE4XKBdeX0Ag8Z2CZZM5T54vC3ut9PRPB19vjwAcsIC9Io3yHhfjmPl
 bSJRbvI6M+Gsp5K70u7pAKu1mUOJS3bKnisf/gpgsnp5Ks1kx+5i07kPt
 /wKk4ko8OBKqM4fTrZHc0cwuVtWgXLiW2Q6w5iksvwXSTV3YFwCZf3Vi5
 tF8oOiH/PKA/rTcLPuuHBk6MhsHSkupdKuONVbseNDeVX2teVd0nA+BcN Q==;
IronPort-SDR: wjxLQ+eSwQlFT4rkNXXkeVdtW2bi3nsvvwiC94ELNFV6aqBpHuT/5rMICaiZrayLQ798EE88Sx
 CAlSyguJ9Qn08htYFVv+bP+7bIwzJoUam1atQ7FgFf2i22SFx5mnH0VZmqePadASli/44nqhw3
 qBVXS/87wKGIvpL2rxfcD4RMAZkDw63d7HchQQxVsmCQwukAV6e7ssfGOd10xkTgbaqrLr4kV3
 +/5Bp2mdWrg6dUZHwDpZowGhUeSLD0ZiEdBrfmdcGNI93Tk8T1Qkj8uZdTLkvBIPz7eRIrP9BK
 PsA=
X-IronPort-AV: E=Sophos;i="5.77,372,1596470400"; d="scan'208";a="150999774"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 08:16:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlXK0x1xxk+v92Msxud8Pd8nQFQTSVJKtE2ZlAg0U5+Kvf/ECqeoyu8s0Dd4qsXUL1++bE/Z59gcgQJGIRKXqsdCTALBfQWpX5bqdQxeqoo5iCqUF0MxRpPZJ4n4NKnDVY4zdxG6YdBAm5L2yQnQd5+/BboYPrsC+GHWLutQOU189fDuz09taHw0sPA+Tsd09E44lcOyOgvr831AvatQPn3Lv0bpW7hmqRgY1OSzXKFhhiHviAu7tK7OZ50PHamn59gpW8jMmh8DkY32fMdM0tJK94i0oWbY1ks1NejtGrynJ+09mlJp4rXbMAseqzSpjhF9CbmyvuqeTgvidhjTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzroMWmYMhOGc/OCTG99XTk8I40ftu8u9inKkJqhOC8=;
 b=XczYw12WihG+eZwdjvO2NGb50SHgNgamB16xc6CHol8PHGhxG2Bcai1eUvCvGt4KVyY2rEK01pUGqIzQL2KvFwrDNgPTH5AyLnPcQ8EyrJlc0Rhk5I7hGjJKLkZwqTWCDCUWiHJbMsEQicltxiukWiwB2MYYlPI15CVe5dlokKrP0/Qr2mjUkIoZ0uOSJdFuW/Yw/f2nTDHbKGZbQ+uABzMWG3zFySRIo0qOuDChk8MiyPlpj8phZ/X+f7nExcfkrCrx1eH5X094GdiAVVloMlRosPUSkRZqx1y9/r59wTdhAiGOum4aTQRbhraqdNY0j5jQGmOo7OGOr8uYsIVAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzroMWmYMhOGc/OCTG99XTk8I40ftu8u9inKkJqhOC8=;
 b=d07gDs37k5Tw4PUdYlzZ0hVEfjyOJgk9N2m/xOhoe5tGByfngpbmlkDkHueXklQ7e9JK7vE6EG7+6sT/bs3xdJwjlcH2BVx647E/CfUqrDgRaP+7OJuVvYklArIzqgPocnS7gqSIANRh6j9NyUHYrEUAFMwska841iWjVN+bS+I=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5527.namprd04.prod.outlook.com (2603:10b6:a03:e3::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Wed, 14 Oct
 2020 00:16:19 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 00:16:19 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet-passthru: Cleanup nvmet_passthru_map_sg()
Thread-Topic: [PATCH] nvmet-passthru: Cleanup nvmet_passthru_map_sg()
Thread-Index: AQHWnpKB4t9kkbWTmEazQV1spdywRA==
Date: Wed, 14 Oct 2020 00:16:19 +0000
Message-ID: <BYAPR04MB496556A3CBC239BC57EE588B86050@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201009231816.1524-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c9e5cc1f-17ab-4d0f-56d9-08d86fd65fd0
x-ms-traffictypediagnostic: BYAPR04MB5527:
x-microsoft-antispam-prvs: <BYAPR04MB5527A1CD422E1E41BEE07C7986050@BYAPR04MB5527.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zHbmcxzKllHzfASq4tFNSKcxwjfpXatBB+PnNgKXtfGOssIO+Kb0YT66OQom2h/sg0SePqLCVr74MT+eUPZPOhjJwVSkDfPIBEMYsS/ZLy36EAuaR3rP2zmwJOi/q/8ACwxU+8o3fkE4oI0I/rQwk4EjPnpiB0QFPuLfGtgPfqHpXQ35NsSpcidFnB0kkxQkfjhHMWUsRM0baw3j1m2nUwsYeAgihMAGPBIyrmOxUGHdIsOnc4pMFJW/tXK8ddY7E1i6Eno04PjdlT7FvzjXa0jbrR5qrzvK4oYKbRq+f5wgLi4JDbx0f+VKkCpBmM8tZEYgHGGfdms+bGaap3f7KQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(4744005)(9686003)(7696005)(8936002)(110136005)(71200400001)(8676002)(54906003)(83380400001)(186003)(316002)(5660300002)(26005)(55016002)(76116006)(4326008)(6506007)(53546011)(52536014)(33656002)(66556008)(2906002)(64756008)(66446008)(66946007)(478600001)(66476007)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: uWmAtotUu1HG+8usls6itcpRejW16d75mX7RYVyhzveewcF4jH9sZKK1hUE5ktR3oVwYYxhANgtIkIN7t/SZeIbN/yiXVceI6s1qgxxKO7ovlNetWpj+h6Z2CGXP4jmo8wfkrqasmjRjRQaDYrzYw/mmYcx8aZVrZAqB1RiLuuCYaG6F3MSBIZwq89K2r37GRHvHIRR6AOofNU7VmZpK/a4/L/IBXtK5yheTR0QishkrZMLwA9KX8Y8k6fNpcUEkLwugGGZojYipuXjgWU7xjMnLAhZERjRXoj8yK7q2GXz4SmOJE40M1aw7GZtzsB1ERGB9+vy9LUd5X0hOelxuAt4d7IUc4zbYxvjZzCAeGOfjN9319biEmaNL4Kb2o7vtrvMRm2+OBkjSQGz0Iz3vHT9SPlFuxi5UbRKlBei6zLZaQFnM2uC0l1qvyCo9gKx+r7texwD1AU6+5dme+Pa0t8HYRMWHipI0px8uqIN+nt4ku8cn2hFPWqk3fTOvFSAdtd0iMJBXbYvohgtaMsI+J607wiFmz9n46g2r+L1wpfRy1WR4ppCvwUAwQPdiIHcshCASIXQOmGc0FLXwlN+NPxPrjbSv7EaoiE2NTPc7Ft74p3OWP/W0i4NX+x/wH68cIvbki/UWEMPzBGMKhkP3Cw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e5cc1f-17ab-4d0f-56d9-08d86fd65fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 00:16:19.2189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylkL6Vi6/5TGghgt+N+Hv/dfZs3/30xX7z7ATdNHP/dSSVdcHXkCZeJdRZrj4TUCqQnK3cYEQVNEursHlkmwryLL8chVUEPaMA0eiU7VutU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5527
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_201624_076225_A73CEEA6 
X-CRM114-Status: GOOD (  14.82  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Douglas Gilbert <dgilbert@interlog.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/9/20 16:18, Logan Gunthorpe wrote:
> Clean up some confusing elements of nvmet_passthru_map_sg() by returning
> early if the request is greater than the maximum bio size. This allows
> us to drop the sg_cnt variable.
>
> This should not result in any functional change but makes the code
> clearer and more understandable. The original code allocated a truncated
> bio then would return EINVAL when bio_add_pc_page() filled that bio. The
> new code just returns EINVAL early if this would happen.
>
> Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

why the prefix is nvmet-passthru ?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
