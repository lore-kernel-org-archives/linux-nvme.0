Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE5BC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 09:57:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5779864DA1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 09:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5779864DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aXBqH1nyFptDFjtMKS0nk22QmUz2/w1SOXMABtLIJdY=; b=Ft3DEzrbck9YC3iZdb7+lNw9+
	fpnnIxudJr05qjbeaZyqvbZbOrL/EyMR0PcRjHCphDc9RF1uiEzlqRcVyyy2oQgmd7L5T7yKRNeie
	V5vIbp8iqqLuRU3xoQmwf7zO+XmKgJ1KuNJ48wNbrC3HP64RY3yysM4BMlHxTiJ4rVx6N/HltBb0Q
	rGhCfRC/1W0cu4FJxSjptNHFyCcDuLDrYqcB+NcUPfw6y6ImPosNu0H9xBUgfYQCmO1dJzN/hTCn4
	Q7er/1VK4X2VQoisXEN8zdXiL137wuz9LAPkAJBoBdILtBDvL7MB+zO/ajCuJb01ox3KzNvhQ7BPB
	Ozlvte0xA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEUR5-0006IT-9m; Tue, 23 Feb 2021 09:56:55 +0000
Received: from mail-bn8nam11on2085.outbound.protection.outlook.com
 ([40.107.236.85] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEUR2-0006HT-Br
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 09:56:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYljbvS698ayM2JXVyp5dY2TmGK3IBRJJWLszhH0riRirYZxrd1TgFH1dTikKQ+zL8X6kBr1WivDhg5fuj4vnTMcr1G6K7NAvSwMipcQy8/eZetTOeq32F19rCy2X98pcyNTxoROJERgYNlvcr9cXMp77xIapmcAJIuDewzHW9BNQk1Fy3/q4Rlanqi0zGNMCoPNJ9EF90MlDr7wcWQNPR0A5EnpviAoyXLKawsU3LAfnN1/MiHVczg01CATriy86yWYrBkVmBth7qo86qSUqe2z8mB1VvqfYVUkFyeSgauwWLRu0nJGVBq7MjDInWIYLVGJRnuv+vtMAjnroCBPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIQ4UEPtOpcj+JDaQ1KchxRiF5qATZxvw4QrC+u+MBc=;
 b=cDleYCRqMhE0wIfzVsgNL9eQ5qHeRkyb29P9+ZFUye4xDXbtrm+zaVwIV1PGDa6qNIm+cCxBFGlNdJ1OH+GE4gaW7QQTNfXvShCtvRorLnkUUhR3a4J0SLcRqhRZUv9hbc2FHLIvgv2HEytWa/ZC0Sl1oYH0JW4bPbRFi23l4wRHR9hMaeT4TGihwyHaSiwu78c8LrWLmflaJBB82hKGTWSJSP0nXCS3sKugkELlRqvIbXu9LPD6BVATj4DDLlLCmkEjXUdWsCkbDKih1r2PlwXQ6nAov/mH0jCtTieSg0trSXf7/Ce7C/9QxCtHVCSGICV44jXyGKUIAY6ZK+aWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIQ4UEPtOpcj+JDaQ1KchxRiF5qATZxvw4QrC+u+MBc=;
 b=z2yOyra1if9QaoKyFFY13e/bWtetTl9G0cjlbDZxKm9XNtF0C+eRfX2B1JKEcSo/vRAbJUmoKOpJBSL3mxPD7iU8AQo/LIW6N1UpOvjeCykeOF544kJfNWqaoN7xR7t7vUmpfPnoZuKkP04jSDkLHaQibTLYYb/7zB/vJOU5fpuH39AF/fc6ZMPYo1IImntYaDFxgRzZpO/H30ltLAJxRiGimHRg/M05hg7bBe8r3vgmxC5N3+E3+tR9X7vZ9Fk9CHSGr+mFTX5rKxZlDrH3+Jrm6Y6jBQeBNEWQ4aCqSEvSnnkUizYGfuHjcev3kk3rGqcHNiy3aztqsWHsopwchg==
Received: from DM6PR06MB4634.namprd06.prod.outlook.com (2603:10b6:5:ff::25) by
 DM6PR06MB5659.namprd06.prod.outlook.com (2603:10b6:5:3b::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27; Tue, 23 Feb 2021 09:56:50 +0000
Received: from DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::59f8:5b0e:ed9f:2998]) by DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::59f8:5b0e:ed9f:2998%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 09:56:50 +0000
From: "George, Martin" <Martin.George@netapp.com>
To: "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] fabrics: ensure zero kato for non-persistent controllers
Thread-Topic: [PATCH] fabrics: ensure zero kato for non-persistent controllers
Thread-Index: AQHXBdwVCJJe3ZOHYEapjHnhbLUW0apliK4A
Date: Tue, 23 Feb 2021 09:56:50 +0000
Message-ID: <59b2ebd8d9c8940840172fbb64d7823ef9c69100.camel@netapp.com>
References: <20210218095422.5696-1-marting@netapp.com>
 <cb89029d362a3cd61504012351f56731cec9c6fe.camel@netapp.com>
 <BYAPR04MB4965AD8096D8F313B2BFF74C86809@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965AD8096D8F313B2BFF74C86809@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [202.3.121.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6130d60-3fd0-4250-0e31-08d8d7e15739
x-ms-traffictypediagnostic: DM6PR06MB5659:
x-microsoft-antispam-prvs: <DM6PR06MB56594B0E3D1AC7B393EFABE595809@DM6PR06MB5659.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fugLzpMPqzPLMGTogVwQl82vDvFhqlYd3GgjDHN3DFAqiJz7ZpxDX0wZNtfdoUun99/2romM3ebmUclMlPHiHlSCefV06LP3QB6r7CyJ34m37fK8wFlEDgvui7ayBpyl9UtFNU5PXgRL8BjRMEuoRbGMhGNkAjmxrJHX76RI6OiQJGvvAj9IyNqby2hXhdtMzxAWcP3K7bYfPo9UaNp8/oZOFy5EDnpPLTiBmT4Q+G7p9WxjS+PXbUrssxpaM3Aje/VHy1PgT8v8phqYUz+Qd/Gc4u2ZHkuU2kFiHdLBEESLQBh5fZodFKM9jbgQENyTdNB5QEeGDlMMsjH1zCpNjcLUtdWU1q2fcxgd6PWooge6g8pjC3P9T4VzlDpbg/Ib72fly4u3PcAE7zrXZ3xIrRF+6nGU5TJO3A2sj3IN9YayqaiuawecWlyj+ibhN4oiTicjEqs2GuUZ6DdmHKaUJRYsmbDe06aG4FXeA95r9hXD1nroajl3deEqLAKBarR3Uz6uP5CyLwPqEbNVs+00gw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR06MB4634.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(36756003)(6916009)(478600001)(2616005)(6486002)(8936002)(6512007)(86362001)(316002)(8676002)(2906002)(66556008)(4326008)(26005)(5660300002)(76116006)(6506007)(66946007)(91956017)(71200400001)(66476007)(53546011)(66446008)(186003)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?SXlSaVZGSTJnSENkT3ViVy9ZYUdWeU5uMFlmcDBpM2xjUENHVU5wTkVyN1hp?=
 =?utf-8?B?bVdIWVY3L1lTZUFXNG1sN1pwQ0l1SGxjckpRK3UraW54NEVpcXVaTXJSRW5C?=
 =?utf-8?B?bmVkOFduRU5WaGFjTDFuek5uOTZkUzJObXlIUGdsMjFKeXZlekR5WWhPcGZl?=
 =?utf-8?B?bkdoVW5lSFhMR2hJRE1pYjVDUk5oNGtucmUxZForYmdhbm13K2VFRWhib1NB?=
 =?utf-8?B?VXBYL1d5WUk0aERrYURTUThEaGMvQjRqSENHb1Y2WjhzcWtZSEJvbkgxVVFT?=
 =?utf-8?B?a1BjaEdvNFlrUGlJTXo5SWpCQ2dlaW9CTzVWZkNyZXBId2dzMmZlNktSQmhG?=
 =?utf-8?B?a2VUUjV3bXJ6VTc5V2lndllpQytkaTFOb2lObHBVV1l4eHlTTjlCYzAwdFFV?=
 =?utf-8?B?VkNKNTZJV051aUkzNUFySnl0K3pMQ1BVaEVRd1pCRzJuYnpueVJFZkJOclha?=
 =?utf-8?B?MXpHeDdlYWhtcjVyNkptMURoOVdick1TWGVtcGNlVnVmQ21aUkxzU0VYR3FY?=
 =?utf-8?B?RHBEZU0wdnhGNXNHNDlHa0ZwTE5NNFNOczl3SktuYlZ3K2JkWHYrRG1QRmlq?=
 =?utf-8?B?Nit6UUhmckNjcXFEbDY4M29DR2l5c2VnanlzM3BhKzIzbEYwOEsxbDA4NUdy?=
 =?utf-8?B?bUlFUko2WmlMaGlXZ2RXcFNiOFc0eE1BVnZEQ2NSQVVxT1NwYXBneHUxbHJj?=
 =?utf-8?B?NUxoLzBSUFZLK3I2eHhNdkF2d2orM2t3bjdqU29Idy9Vd1hlMi9hWEtwcGlE?=
 =?utf-8?B?VlJmZXdzbVZNeWJmSG5oanVmYkJ4dVBJMWtFV0N5ZlhNWS9pTW9ERVMxVkx4?=
 =?utf-8?B?M3YrWk00RC9PQ2wvdW9CTW5uZUlTdXgwUStMcTZPZndFN1lqTHdzR3RzQUtu?=
 =?utf-8?B?Sy9GKy9rNTNsTnJVSVlvaGNoMjNvdDl6ck9Sd3FvQjZJdlB1NDhpY2RuYW9K?=
 =?utf-8?B?Y3R6dDhSdlVNZWRTbGNpVEdQZXJKbXJqNXdBcUgwZUFYcys0TmtkaDh4K2h1?=
 =?utf-8?B?V21VNVBJQ09Od0VJekN4cDZ1NkZQSDhtcnh6cFgxNDFvWWlKUHE1RjB3Uk5H?=
 =?utf-8?B?OStQZ3JJeGpHL0xzaTB2WWdOY0FuRy9Bbi84c1ltVEMyeVl5Wloyc25xQXRF?=
 =?utf-8?B?aklTalJkR0VtVkJCRUVEdEdFSHhSRExtMUR2ZEdhN3NGSHJHQnN4a095aE1a?=
 =?utf-8?B?UThHQm0wZWxxWjIzNWlpandkTkE1Nk1aeCtkUEtTYU5BRjcxYUxRaVU2OUxz?=
 =?utf-8?B?YkFwSHNMbGJjcjNSbmVoUEtaUEtxSmxhclJyQ3djczVKWUtLTmxWMXVycnhM?=
 =?utf-8?B?dnZDdXZqOFNaQXNrclRjS0hYRC80WDRmWkxSL1h0SlRXT2dPM0NDQWtwVUlx?=
 =?utf-8?B?TXdWOGZHcU1FTkxlQmRubFhSbHV4QXlTcG14V0Y0S0orcUlBZ0JIVU9qV1ZH?=
 =?utf-8?B?VWo0SlNFUXYzM1JYdDNrMkEzaHRRTGNTL3plRDY1K2hWNUJGZzhsTWNnak5P?=
 =?utf-8?B?VEkwWG5HOEMrM1BRQm9xYVBVZTlOaHRIaFVOTHQ3SGM2NXhJNDBLTUZNSXpF?=
 =?utf-8?B?Qmd0amdOMG5oaHZvNlo0TEhJZHgwYTVoekZwOUVCM0xOLzcwb3FGVTdBbG43?=
 =?utf-8?B?VSs4U29pRTBDd2lQVWtqS0dxVm9lZHlHcGhMQmdZbUZKSC9pTlNZcElBaTF0?=
 =?utf-8?B?aHpJTGtyc2o3TnZuYUN6QXVGbk1KdXRlZHZSVEdwQkMyVTBBa1hpZXREWkJw?=
 =?utf-8?Q?tEOgqf78sWhJubn3ThimegUeIWFIbb7ZKsQhA9s?=
x-ms-exchange-transport-forked: True
Content-ID: <713E95AB010AA24D8CBF32A0310958D0@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB4634.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6130d60-3fd0-4250-0e31-08d8d7e15739
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 09:56:50.3655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83sO1on1PBeK4efoJniH7JiwNVD7C+tq+nlvM73q6Sed4hZaBoISMIMHSgbyjkjyFCWG01zRzDuTmGpZbHYN6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5659
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_045652_663646_431B8097 
X-CRM114-Status: GOOD (  20.11  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, 2021-02-23 at 06:06 +0000, Chaitanya Kulkarni wrote:
> On 2/22/21 21:47, George, Martin wrote:
> > Ping?
> > 
> > On Thu, 2021-02-18 at 15:24 +0530, Martin George wrote:
> > > Along with ensuring a non-zero kato is passed to a
> > > persistent discovery controller, also ensure a zero
> > > kato is passed to a non-persistent discovery controller.
> > > 
> > > Signed-off-by: Martin George <marting@netapp.com>
> > > ---
> > >  fabrics.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/fabrics.c b/fabrics.c
> > > index 1880a5d..ed15e08 100644
> > > --- a/fabrics.c
> > > +++ b/fabrics.c
> > > @@ -1399,6 +1399,8 @@ static int discover_from_conf_file(const
> > > char
> > > *desc, char *argstr,
> > > 
> > >                 if (cfg.persistent && !cfg.keep_alive_tmo)
> > >                         cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
> > > +               else if (!cfg.persistent && (cfg.keep_alive_tmo >
> > > 0))
> > > +                       cfg.keep_alive_tmo = 0;
> > > 
> > >                 if (traddr_is_hostname(&cfg)) {
> > >                         ret = hostname2traddr(&cfg);
> > > @@ -1474,6 +1476,8 @@ int fabrics_discover(const char *desc, int
> > > argc, char **argv, bool connect)
> > >         } else {
> > >                 if (cfg.persistent && !cfg.keep_alive_tmo)
> > >                         cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
> > > +               else if (!cfg.persistent && (cfg.keep_alive_tmo >
> > > 0))
> > > +                       cfg.keep_alive_tmo = 0;
> > > 
> > >                 if (traddr_is_hostname(&cfg)) {
> > >                         ret = hostname2traddr(&cfg);
> Is that if else if ladder code is repeated ? if so can you please add
> a
> helper ?
> unless there is a reason for keeping the duplicate code.

Ok. Will write a helper function for this and resend the patch.

> Also can we remove () for (cfg.keep_alive_tmo > 0) condition ?

I'd prefer keeping the parentheses here to be on the safer side, unless
there is a strong argument against it.

-Martin
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
