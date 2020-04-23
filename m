Return-Path: <SRS0=YD4V=6H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CD0C2BA19
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 06:03:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1ED220781
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 06:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KvRlHRtK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L7gFY/wL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VZ4kIXm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1ED220781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=MeN5+C8vstaQbPB1zdFqznD5lrZDKcMtXYiMX/XLPEQ=; b=KvRlHRtKahWVyV
	y58Q+V0GqJYIaYKZlORY749EZmF6FYE71WfoGuae3u8WBvGcUuXOE00w4j4gDy3/vP8j7Ko7+6Gdv
	5T1NDDT1AY19BwGPbzzxi1Q/Vx4MhVTo9m+iM1rHbdCHK/PKP2TkidnJCXjHpzd7K4OSH9XhOTuJd
	HCiefH0NsrIDhg9CBHon7zsXeS48PQDellydoDUS/wg8oKdTfi9XBPZL0GBj8TTDz0ME/7l7UAVXN
	ucrCz/XxtZbe4G7BtRdggFgM9uhNSnCnzCWU29E140xJI/55oeTEwoLJsXkg5VCLx8paW3NbFG5WI
	goipJVzbPLgp1xkkqG5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRUxC-0004uD-6x; Thu, 23 Apr 2020 06:03:18 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRUx8-0004sZ-IF
 for linux-nvme@lists.infradead.org; Thu, 23 Apr 2020 06:03:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587621794; x=1619157794;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=YW/Ru5d1gCuwlI+tdy0ZnAkegykvFkB4Zwao6z72kV0=;
 b=L7gFY/wLj5IsPgByolc+zASZzha6N85bsi/YQhxnxaeDGzrF7lHArXG5
 o/McIwVVToZiRhk+4e4dYiEfSFAkjTs7s66z4CKnaczlkJbIv3CP/nZJh
 bA9eyzhp2Ii8/HTk+d/BmUX8od78lik7pFz7DkYPB+ShP9Jj5SyAijq/L
 4pSCwMZKcoa1bO6uD6a9beb48zY/e8BAxvwLpeUAOOCON8fCko5/yGqZs
 wcvaFGKJfpydIHrD9glGH1P5doteprvOEV4Nb0dOiRKQbzNvYmR4Lojo9
 NfZyiD0K1spstX6KFUpi46IBlSxo4Y3sXB8/65Pwpr2SaI+DT9SPqlqjO w==;
IronPort-SDR: r0ZBWN5iHShklIa7+bhyGfZwsVcc8s/LCIJyF+esjxxnMYOxcoDXY0lHnYPk5C1Yvf7kXcmFyW
 gbOuezY5qV0ogICCKP4skkitRCQAqOwNOi9fva8Pmb84InyCQrx1zxA8U68ryJ4p+cBLtIWl6f
 qiWmymSZTEgW6vVz9Zxsy5sFKJuoe5s2yIGtHXLew1a6fe0yQ69fjkYbGzrAoY4e+797qetmb/
 bXhKEF+8BsSfCvcuP9CCEkoFDv4vsRia6omLjcozB6VZS+Qxt++qdEXYZqQAhLCsn6xnjfdLcl
 AwU=
X-IronPort-AV: E=Sophos;i="5.73,305,1583164800"; d="scan'208";a="244679102"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
 by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 14:03:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TB2qEBqoFMGBXHFSV8H36e30FOQvvrGjftcnWczd1Ul4L59SUCYiBgbr9LBP8sjXfFVpax3c01QFjy0C6Lh0D+y3Ew4yVEtoyAoqtQ921xgU010wwuQjFn1ieCPTRXOXx4KZWo6QZa6Cn5Kv/oMDAtdI5JDQ0rnnIckplXWOY1c4zF3yN+drZpQqdfY9DKSrZhKRxoE/kIYwnYZE6ugK9rqqq/V618etLuGo4tac6SEZKGduE6K8IR6+uawfyRsnkeMC2pqOEv1mSB0z9oMru8z1JC2yS9hzzo6kiAqhUBapr7kx2cnMJ2H/ZLu8Oo07jZ9/wTyJFYsZ0WbPkxMpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU3vpYWJ19if3AoKeZl5wlIZNQpCUuJj+si/1VIohHY=;
 b=QZX/91PrICZ7/HuJfrK8VCxT4+2oSP14b2xLkjWzC53ai4JNKm0UXfAVHFzmguwEwQLl3imHFgIJ6cvsWre+0QDrMwVF+tcg3CM6DbVelEse6x2W/csIks/JhRp1L6Jo6PMbppECpx44+3goWk4LjU1x7dtFXiJzuEGGDD/T8xZAEk9ku0fk/qDccufwVePdAIkj5adWj0s1JFD7tfOgvtDvFTKHBZelZh8eMFa4nIE93pZ5oCNL3NssVFw/D5W1MWEQAi7UZYC9G5szHAjZkdxTvrYqkBxvftzlzQaWquKRiI/cYeEujlhWD1VMoSkfwbP2WydapZ72RY/2W0dpZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU3vpYWJ19if3AoKeZl5wlIZNQpCUuJj+si/1VIohHY=;
 b=VZ4kIXm7Ws3RWQ12rqs8DFfCNg+oMbpMQFl6VrGHdv66jPezVgyifzT4nHqZtnYS3tDtgjGqK+vbij1s+2YBTJAhZfiWYLVEtTMxwuGvE98SP6eYURLzBHVAXwZwqtc0O9fqYETEMQBgzgvom54L6YwinnZ3iXPFrFzL2VXgFi4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4165.namprd04.prod.outlook.com (2603:10b6:a02:fc::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 06:03:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6%6]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 06:03:08 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 0/7] nvmet: add target ns revalidate support
Thread-Topic: [PATCH V3 0/7] nvmet: add target ns revalidate support
Thread-Index: AQHWFqUc/6G4R90/W0uFjlLgMy0bYQ==
Date: Thu, 23 Apr 2020 06:03:08 +0000
Message-ID: <BYAPR04MB4965850E7D094ED44D1C360786D30@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
 <20200422081936.GA25035@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e40:3000:3595:2b18:c2a4:29d5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b43932e4-92fc-46f0-1f63-08d7e74bff2a
x-ms-traffictypediagnostic: BYAPR04MB4165:
x-microsoft-antispam-prvs: <BYAPR04MB41654E5BE98585D1728ABB8786D30@BYAPR04MB4165.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(66556008)(64756008)(7696005)(2906002)(186003)(4326008)(66476007)(316002)(33656002)(54906003)(6916009)(71200400001)(5660300002)(66946007)(66446008)(76116006)(8936002)(86362001)(81156014)(478600001)(52536014)(55016002)(53546011)(8676002)(6506007)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0xC30kghHAyqgu7zc27pGabZLe8xaf3QyD9iJuOJu0QnVI/EjCHY3Be6DCvuNPtnMx0aoZQRYCssSqk0DWHDmLxG5ZshiwKjLUXggay2B0aDIqTjQQw0su85hRAMYo23/Q0PjCYD7J5tO7KxMmsn+Li3EZTEowS1onR/pb9yuDfh28x5CQlCbEkmtS4bK00cr6cC7ulbX9jy/tbsu7iBqR8pKhBzu4tNJ0la6grOpLs3iUkeyXcDKMWRUu3HMDluIQmAuziV5KjkBobqRt/ijY4LobUwQXP3r1TBiI/5lma9yxNreqcow2YS077TCN2/kvviUr1+QXKoCR+0Zw06EiAr6VbGQEkOAItwZ2Ll+LiuH+5a0/i/lWkRf6Sgwwy5CG3cxt6KxzDpV2pAtA7EVvDzvmNT5ntsU0xUBADMqInA3t+448A4FtsJVpws56Wd
x-ms-exchange-antispam-messagedata: Xg33+dozIgXw6f+/AUiSkYpsj70HsX3wW6QCj1ThC/PMn8eXJqf6rwCVQEkaaEqKnaR5nI47uEzVfVUInBVlYHDwP9fzJvTquo7vBSCkBq39NDQSpCOx+Kfq78dWXyXRCgozxcLiWhdTj8oZQo8i5fD8cdqhkEk2JuA50ptCaIA7FTyr/K/S/hSDLy1Hwg3JhUkp9o3cmuKh+RUm2VzeFA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43932e4-92fc-46f0-1f63-08d7e74bff2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 06:03:08.4299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMXbNk1Q/Ep5yMrVqFybH59aES8VPa1oKSHG4Gqzosmu7p87kg4bbpGAjrxvGna6xJGZwVoGyT4A3+ykWAS1UCkMEzfAVp8LB5LuXCCnnas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4165
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200422_230314_682731_3E208700 
X-CRM114-Status: GOOD (  13.10  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04/22/2020 01:19 AM, Christoph Hellwig wrote:
> Patch one looks obviously sane to me, but the whole polling thread
> thing just seems like a lot of overhead, and I don't really see
> the point.  In the end the revalidate only really matters when
> either the host queries the information.
>

A. Regarding host querying information :-

That means host needs to query id-ns periodically to have correct
size for the block device, until then it will have wrong size
(unless it calls ns-scan) which will break the host software assumption
about block device mapped on the namespace. See [1].

Isn't calling id-ns for size validation also defeats the purpose of
whole AEN mechanism that we have implemented for host/target and
present in the spec ?

B. Regarding Overhead :-

Can you please explain what exactly the overhead is ?

With my understanding :-

As mentioned in the cover letter this design provides
a mechanism (since it is a driver feature) and not the policy,
so it doesn't force any particular behavior onto user, i.e.
users can adjust tunables provided for this feature and use
feature the way they want it or even disable it and rely on host
based periodic id-ns-size-change-rescan sequence.

Overhead in terms of design :-
We can change the current polling so that instead of scanning all the 
susbys/ns then sleep, we scan in batch (N namespaces) for each poll.

Overhead is in terms of code then we can :-
1. Move core.c maintenance thread related code into separate file,
    (name suggestions are welcome).
2. Add Kconfig options to enable/disable this feature for target.

In case of performance :-
1. User should apply policy based on their requirement through
    tuneables since different users can have different
    machine/platforms/environment.

> So I'm tempted to just apply patch 1 for now and skip the rest.
>

[1] Inconsistencies with lsblk and id-ns execution with only
     1st patch/no AER:-

# nvme id-ns /dev/nvme1n1 | grep -e nsze -e ncap -e nuse
nsze    : 0x280000 <---
ncap    : 0x280000
nuse    : 0x280000
# lsblk | grep nvme1n1
lsblk: nvme1c1n1: unknown device name
nvme1n1           259:3    0   10G  0 disk
# truncate -s 5G /mnt/backend/nvme1n1
# dmesg  -c
# nvme id-ns /dev/nvme1n1 | grep -e nsze -e ncap -e nuse
nsze    : 0x140000 <---
ncap    : 0x140000
nuse    : 0x140000
# lsblk | grep nvme1n1
nvme1n1           259:3    0   10G  0 disk <----
# nvme ns-rescan /dev/nvme1
# nvme id-ns /dev/nvme1n1 | grep -e nsze -e ncap -e nuse
nsze    : 0x140000 <----
ncap    : 0x140000
nuse    : 0x140000
# lsblk | grep nvme1n1
nvme1n1           259:3    0    5G  0 disk <----

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
