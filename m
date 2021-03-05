Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962E5C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 04:14:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D375A64FF0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 04:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D375A64FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=+c2jc06L8NUcXW7LTPrM++5xTHfPzt0i5KsKzh8ZwL8=; b=lRWTwa80bqw+E2mUJytOW5iX0
	PiVwWUrOyX8joOpYCD/PO3KDLxIbIBCFF4iJ3TlQ3wgE6R2r1vWY7sG6SalkaG2wszsw6kj24BuHk
	ow73i0WAv4GZB0fISxWJRlMs46zuFriIDLTfKaOPwnhDej7UB7Ug80xxtQvXOPmqSPeEBHelCFlaA
	26bm3EVCJxlaFT32RA9KEhp7PbTD0AUBfkoL5jCB+S7nrSmtnE+SZdCqOcPlO4zckM64l02qgTeHX
	xaBowBhBJ04MHjsKc2zSouu/ex1X2COV0oQ+J3Gfs+70f5hPJyIW7i7Bjn1KCcaizS15WuZVkBlcW
	YVUYl89LA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lI1r8-00CJvO-74; Fri, 05 Mar 2021 04:14:26 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI1qz-00CJrM-US
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 04:14:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614917657; x=1646453657;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=lngAJebvLNIKPqe21Pd/Zt4nK4VJXY566p8PQgl/fZ4=;
 b=lduZga4cb+ZGnpWxe3sAUGwFYNf7hrP2nwe+wX7xKZNbkgT9BGb+yS14
 tHHIdaV1jsB0FQFyNBUKLlBb/uE4hi8nYJ1zzdFeW61HfiEaRa6JO84aZ
 Sk8/xu4B3EkJDvhVKn1gnbE+jNxGviNAwG0/gPxigwyVbVvFF8OkVXn4k
 zrjt1+3dWw3kirJvZgNGMH5W/dpicSqOoqTocI21i5l5neFjDjAq96h4b
 NnXuz8GjJ3yzhcI9gK/K0cg3Ek0TFbXnQOAKDikhFh0VMC6ro+xQKe5jC
 HGI1MInR9nnQ3SxQSYpD9GulQdiDATJByFDtY1fZX8Rh8u25CDtXm4T9D A==;
IronPort-SDR: 2y9CE7oPO5CmkVI1lNg/mH48zHaYKhMa7Q7zCYGb9ZnmNEzj86mTQtD6TzrdM+Su7iZIKcJ6Tj
 o8zLxIyMqaPjgoZ0jPffVNuvRs7u3dQgPCgiJA3pIEhVPsM/y6ditjAsnF0+u81oCFi6Ml/gFh
 yslWQqmEBkohjDzwVt3YOu3Z3kluJ/FtT5M1a+WLb8E3IPbpDqavvX6OJeOHYbRqEkQGEwi7iE
 FUBtaYH9E2/TyHYudCqm5+kZK2sf7iHBUTADYjGiGajD1oxyOBipCiqFX0XZkS1lPGmXHE9o3q
 xtM=
X-IronPort-AV: E=Sophos;i="5.81,224,1610380800"; d="scan'208";a="165897514"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
 by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2021 12:14:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRxgLLxQUlW6gt6mrOPEbgxM7KxfiHZUzgXFus88O++CP+XPYkU4PFy0wAC/lT/I3ZHlrPtRSwOHfjJ97fFFjshqQs5BAZ2ZvdrYrnBaXcdispInjNq31o9U3FddELjn4dHRNQC6Y4m0+s19ThCivqm2WH0l1PyLUkOM2l69NwMU0/uWf2QsCnDaz+oa46z6OF9ATI4nZrQeitALMy6XKwL/Xo7VPHhb0CkJPHXK0b9nAZxbW/tOV/0VnKPzYTNl7Fym/hLIRc1WnPWrtlw7XzQuVkxzJFEhv14IJoIWF9VsfBChe7CSzLQiU88WH9A1iJGrMjhbJmEcYPzRUqYvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RScwyRXRLizNHR00xBc7A82nfvR9o/ArcmXzNbmpy9k=;
 b=HqeQB7HYaGog+024yagdfLeqZI4KhfTo1rZork29Cdn6C2KnzE0EORtU6fXU1N3MqneFgA7/d6ihmVj+lo1T0QslqoX14VBwlepvLbt1OUJne4TDowHLaMFzyzqen/5m4UZa/v2TwjaGHUb4qKZTqB8ihViPYYjaiem14d9oL/6/tviW2y1lT+c9HdVxTB+CVboy1RfGJct8fr8MOnkq0v5QjQCgxotIRvdd0PQtwcxwfYpGvAIt2LeiFM4Yrc4w/lYvZH7PCCbbA1gC2eUWVbJXoSPhuOlq14DKeIBFjDelBeRWmlEO/cRB/zDYFPiUEtXijq3Zm8PfUDC0CnVEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RScwyRXRLizNHR00xBc7A82nfvR9o/ArcmXzNbmpy9k=;
 b=aNsfzNngWZTE8/+yz8J44gBa8a3nsJVWsZNP2geXV9HhOFyERmFMBCyciDhNvGNMw4zaDEFOOnD2J28IRMFuYZ9dfv0J8p/kTYloRvfz9wjPlJsAiFoBDGK4VfIPWJDIXBCJ+dn4iiEmtxrPBqz0gEhbE1tRsdwE97O4BHs+aZc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3861.namprd04.prod.outlook.com (2603:10b6:a02:ac::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 5 Mar
 2021 04:14:11 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.034; Fri, 5 Mar 2021
 04:14:11 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Kanchan Joshi <joshiiitr@gmail.com>
CC: Kanchan Joshi <joshi.k@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>, "javier.gonz@samsung.com"
 <javier.gonz@samsung.com>
Subject: Re: [RFC 2/3] nvme: passthrough helper with callback
Thread-Topic: [RFC 2/3] nvme: passthrough helper with callback
Thread-Index: AQHXD/4EOPP4CH9isESsU82uWJlGPw==
Date: Fri, 5 Mar 2021 04:14:11 +0000
Message-ID: <BYAPR04MB49658E6ACD06FAC7F6F26A6886969@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210302160734.99610-1-joshi.k@samsung.com>
 <CGME20210302161005epcas5p23f28fe21bab5a3e07b9b382dd2406fdc@epcas5p2.samsung.com>
 <20210302160734.99610-3-joshi.k@samsung.com>
 <BYAPR04MB496566944851825B251CA93686989@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CA+1E3rLCSWDmLa1rrZ986xnbx6fcsGgBE6NPP59eJj4swY+gQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8291c884-5e99-4059-43cc-08d8df8d2152
x-ms-traffictypediagnostic: BYAPR04MB3861:
x-microsoft-antispam-prvs: <BYAPR04MB3861B319BE32CFB3BD50870186969@BYAPR04MB3861.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A6uhaPs6+L2FdcvOKXJOFbCwdQCD0YHjKtUmfmGxdIrYFHWxVkKLqRccqdftDiqWFVUc5CNoXWzsm9hiFD1cJ+hAa6P2we74WgEK+V3oak+HiDzL/UQ9rU+bSXIHRXgP3sHaiALvKn+JRXH62v4osUUw2ePwq4hW/7jPx4MrclaacMidXTfwHaLVUr/30rkwkdRxihHIbZH2+iv7oQUViPvcdbYQGtfm7qFZB/IXlDyvmS/rFW03JnmdKK6a9FDyV9zxh3LN3vsRkboNiJomfje9JWFi3a/235sdzmNbH3bnxjcN3QSkTiu3GH0yxRzmCJ0lJEE/P+tkHBUm8sK5Lu/E8acejPBLt9QDp2xvQEwSPbifLtguCqonGtEsjyKYPMyZir35/LZh6rRq6Qf0zSUHkm1paR2CsuKjvPp4pgqByn6tskyCAe7kJBmL6/YnAaD1xZz2A3mOd8LMv7ZlbCrB2vcSoeK9YiuYuCJup1nmUATqBxU1DNJ4r1B7ntcLSyu6Q+wtutgIGWGobIPrAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(2906002)(478600001)(83380400001)(316002)(33656002)(86362001)(54906003)(26005)(71200400001)(6916009)(4326008)(52536014)(7696005)(66946007)(55016002)(6506007)(66556008)(66476007)(5660300002)(8936002)(186003)(76116006)(64756008)(66446008)(91956017)(53546011)(8676002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HAZVDIZRKgKpgWZRCJ3O7G0hyuu1G3DG9CDsj6Omg7MtH683zBikl2vTntUf?=
 =?us-ascii?Q?MoH9HDGeAAmYGzrQ62mDIE+4LXz0JvHb03m2usoUG0I5UJ41cE2fATQXS3YI?=
 =?us-ascii?Q?6qWmRyfOnECgmaT7ajIhYp8viDBzoZn4orx/elYq74RGITsPAhWaiCkDbhjE?=
 =?us-ascii?Q?By0uomVOboIv2AA8RYDTmUQN6FgFgSTYHyqk1N1Gs+PxQxRdJ0MtZJj0Pjh4?=
 =?us-ascii?Q?uLtiZsNQFHbbmMyOklcmir/x8j3M9wLSz2S8mKHm1jlVjdOSh5vYynplvJY3?=
 =?us-ascii?Q?ykmh7MJvXC1U6U1E3bwdIIe6XQIdID+JUTdrXLB8SOXjD+zZIotl6/eKEDEj?=
 =?us-ascii?Q?S0OtH8X3i7XaoZ2qYrX91eK0ZiSzqcwjOJ3g/v3cUJQWMigElQMM+P9Dsblo?=
 =?us-ascii?Q?ogrbI0b6rFvRetaqKSUZM+yhnSHlCeM2QlZOpRpCWd4ZO/k5FFQBCzNkQ2vm?=
 =?us-ascii?Q?cQ/eXaeicWRtFDbZ7XPdJP5FjEFgl7aEkLzSA162wkikzmTt0OoGHxKzF6cB?=
 =?us-ascii?Q?Q6Q97gyBf1Qxzbf7TqNJ9opmqFZYlK8vbWcbrMc37jvD/EMq938/zkcrze6I?=
 =?us-ascii?Q?MEpt1t4UnGDd1nwRCxa/84ypseJmTLQuGMSyjYV/DKiKmJHWHHFAl+X/f9N/?=
 =?us-ascii?Q?jLnkYzsGZzuCFSarV1i5g7yD5fRomms2q6NXLtTaF2bteJGXQenTyMIENl/P?=
 =?us-ascii?Q?NkpyBhu3pXlu+S8qjYGk7kLdZjqxUis1FOTIRnN+CcZuUrvr0oQV/iv0jQTN?=
 =?us-ascii?Q?QbSarEEvWPd6AthjAPnlVAo1S9Z4ICjO7PCklYNFq6gGJJcn3BfFpqcU/iCQ?=
 =?us-ascii?Q?m2PZZRzt/czdFDxEIyo85mVHWAy03/JtMKYJirXBjHLTeClnj6KVKl8G4M72?=
 =?us-ascii?Q?cCXOfaXvHwWeHVDnV4d6qrr+7pmjubFkUhuPSuiuH/9RpByPAi0Va4Ox60PP?=
 =?us-ascii?Q?hsxugUdMLRhyLr9Yz2mKSPoStEPug25Dh7Cm/jNbD8Cn0U7tSFU8pD6mmpqf?=
 =?us-ascii?Q?TpNKpRLXq4NzMEgb8ssYU+MNJ2CziOEj6y9/tLXKm4LFxiwg0wwBCY9aYq9/?=
 =?us-ascii?Q?EQs3bFg4oNZqMDxXX1O8O+QQdeTa45GK4ldOnsFPpkOoTQmhxitdcYdN9cWw?=
 =?us-ascii?Q?N4pFIQQMSS/Qqg8WMnaqV/zXdlAOU7ZzR8rsIhIlzTHnpH/sVVGj+32A3esa?=
 =?us-ascii?Q?UkNbgX2DyBrZbPpg6fkvn64fm0KDItGHFWjfTVHs45CmEwTUIDJCzQVQiWyn?=
 =?us-ascii?Q?6LpIM+oPMTuB2O6ZDCwUuNFLNmW9GLWvY/SxP7sK9T2e6wkmA5KRWQ8wn1v5?=
 =?us-ascii?Q?l6WYDNbvJP3IyiAEAcZSXK/q?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8291c884-5e99-4059-43cc-08d8df8d2152
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 04:14:11.3628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqd83NXh2H1xTkBkDLL7okq5jJv9fp7O9+6nYeaGiFIt87spHsiP4yeH1NRsFa0BS/u6u3LK/dK9IJhi4OqOqgBP3aRca0ZuVh/mKkvaTmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3861
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_041418_355782_F6F2C227 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
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

On 3/4/21 03:14, Kanchan Joshi wrote:
> On Wed, Mar 3, 2021 at 8:52 PM Chaitanya Kulkarni
> <Chaitanya.Kulkarni@wdc.com> wrote:
>> On 3/2/21 23:22, Kanchan Joshi wrote:
>>> -void nvme_execute_passthru_rq(struct request *rq)
>>> +void nvme_execute_passthru_rq_common(struct request *rq,
>>> +                     rq_end_io_fn *done)
>>>  {
>>>       struct nvme_command *cmd = nvme_req(rq)->cmd;
>>>       struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
>>> @@ -1135,9 +1136,17 @@ void nvme_execute_passthru_rq(struct request *rq)
>>>       u32 effects;
>>>
>>>       effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
>>> -     blk_execute_rq(disk, rq, 0);
>>> +     if (!done)
>>> +             blk_execute_rq(disk, rq, 0);
>>> +     else
>>> +             blk_execute_rq_nowait(disk, rq, 0, done);
>>>       nvme_passthru_end(ctrl, effects);
>> This needs a detailed explanation in order to prove the correctness.
> Do you see something wrong here?
> blk_execute_rq() employs the same helper (i.e. nowait one) and uses
> additional completion-variable to make it sync.
>

There is no gurantee that command will finish between call to
blk_execute_rq_nowait()
and nvme_passthru_end() is there ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
