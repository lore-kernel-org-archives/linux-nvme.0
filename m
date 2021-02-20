Return-Path: <SRS0=hrUZ=HW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27930C433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 08:41:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1BF264ED5
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 08:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BF264ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Content-ID:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+/Ynkf4ouFPgmSjzuMLTC4CsaQMo/x1hIIxS/uEi34E=; b=vaERkMXosL++ET82Xx7+dSh2Tb
	7s37+UVSHcgA9EBd7KooqRwx3+oByHBbmM99i9Ix9emtneGCH9MuwFQTFbIBpVdLNy7se/vbYOkt+
	P3r46FjQ9BmP2iHu8uytMTQsjCTH44cf+53hmR+Bd/GOjF/t6CI56/lPp77DcWiHc0OIhAntQFigq
	FQIOwf33ASwBRU6z5YONBbWa/UiTPDFMXdLSLaoOkpnMO6x2IJMeYhygxoELWAX/SLQvyb5cjbR4g
	ChVAdm1JWAQMEhpplRsmdf+pSfffw4Rv8rMS6K6SzeTtuocXIoiO0doRYBaZKi/PF6Cmp+nDH2J0f
	WgWgns2A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDNpE-0003iG-Jo; Sat, 20 Feb 2021 08:41:16 +0000
Received: from mail-dm3nam07on2070.outbound.protection.outlook.com
 ([40.107.95.70] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDNp8-0003hj-9g
 for linux-nvme@lists.infradead.org; Sat, 20 Feb 2021 08:41:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUD1LRxe5qu0Hrg9yg6/jF6cWTGdQbiPy8w9Eo8FbXx2cjyumF27jczWpm1mOxZGLYL4sUolefhxJP85mPhpik4Wbbrr+DUyMmGlOhw+VKAdt18Xlf+k/gaDt/cSqdGlR9fKKy3n5nQskXEpVfhxpLDzMYAOo3/Sf7uXCIEIvWgXvjBhY4CbaFugL/9dfQmnAhogvOoqS9TyDubDPD1OS6/o46hJT3D8MpVINhCWafzsdEsp80/TdLUJfbTF4ti6JWIXqCFyardkhwvOblltF5HZ0epRbuyb/RnnWvAMrTMQwUsZZA7Q8KEnhbZswqG/lJOiqoiUtP3mBmq0TDdl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfNOSqfIQSJBNm2pFi25uEPb0xyUm9eKFRW+dLH+/2E=;
 b=EO1rMrrkUzfpj2q+RVyU7fyEhNbU22J30XhIf8J+KG/5S5ADJzXT2+IAzmXo7qoY+gYDL/CTGgaeiHSc+vo1oEr2+7BKzeg6tRNwKfh5JWrhR2qIT+/6heKebbmDjZEUrZsBsn2H60ROmlIZ8oVEXEjcorkt3rIp9ha+4Xpw0IPNWRd7vuyWY8kmrxsz0X4YKtU9zqB6qcPcIcYTojW5yU8VXB7cBtP5wCJjUI1yNYC0EpnsPaPl+5MvBPa6i2OZdYf9gwyQyjUR6nYVqbKRKqmxqEl5roPXQrpPrKxFkOoF7JIcurneJXUG+9LpRBoizIYwGTGJwm+oaeGEuWHqKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfNOSqfIQSJBNm2pFi25uEPb0xyUm9eKFRW+dLH+/2E=;
 b=RSbdVDN4XqMSlL5GRl6cAKbC/u8f1W1zTjfT47lqIWD3acgKWEVARQ7VAtfgPTJQGdRAfs3AEzj5WBkT/EVXwsSVQ2GRbRSMSh6GxS2OkFvd9FWRmLe5BSsQbzak2gucPyBN8Ze9Qi9HI3LiEcetwb22ETGDtGVoi/mG0qqj8FDbkwBX+gbhbf8CgNikSFoMi8OFoBfUvgOrQ+Zzz8qkTT9hIQHMiCBGLIqA5WPVwyXqatKbsyRCAGiZERVE7+aE04FKJLUa+Aprbj+uWt4KzQ5f1wwkdn+UaKHImbgCV4APerLKqCC54PWaUODzh2/MiOmz4m2h3ocNo59BTrMMcw==
Received: from DM6PR06MB4634.namprd06.prod.outlook.com (2603:10b6:5:ff::25) by
 DM5PR06MB3241.namprd06.prod.outlook.com (2603:10b6:4:42::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17; Sat, 20 Feb 2021 08:41:04 +0000
Received: from DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::4d4b:2384:6405:a603]) by DM6PR06MB4634.namprd06.prod.outlook.com
 ([fe80::4d4b:2384:6405:a603%2]) with mapi id 15.20.3846.038; Sat, 20 Feb 2021
 08:41:04 +0000
From: "George, Martin" <Martin.George@netapp.com>
To: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-fabrics: fix kato initialization
Thread-Topic: [PATCH] nvme-fabrics: fix kato initialization
Thread-Index: AQHXBd2XV2GyjK/QBUW152OaVPgV5KpfsNEAgAELYgA=
Date: Sat, 20 Feb 2021 08:41:04 +0000
Message-ID: <795b906b46f27880af74aaeb0c1fe116add5e0f5.camel@netapp.com>
References: <20210218100443.5854-1-marting@netapp.com>
 <03826110-0d9c-8b25-9975-b427036ec2cc@suse.de>
In-Reply-To: <03826110-0d9c-8b25-9975-b427036ec2cc@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [136.185.146.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c797b875-e7ff-453c-514d-08d8d57b4290
x-ms-traffictypediagnostic: DM5PR06MB3241:
x-microsoft-antispam-prvs: <DM5PR06MB32417D0DAD15821174B05DDF95839@DM5PR06MB3241.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t3TZTsTdLfHmWeXSXpMMe/u2eCpmcV4f/unsVH2e5ICUzOWEmp3P1gTRyUuOAxowH2qrbte4JuTf2BvCBDpOBe4PxIgtrL8mXfTWvDZUcX4QCTd7JZ51rC36pZ02AlVdDSKfGH/5D0HU2rNHA+NAyKk7nC7VHwL9QNCkBSxa84qBDTybZ94j52tGWo09cAYCAhda3/sx0QA9W8gSasgepGLB6GzoA09JyvH7427ITl9n62fg7lMc0TyafiZUEYPaPd7Gf4TDj/n8O5E5GANUFalVUlN6LVG8rpQ6NpiZYDyZqAQoJlLwqPy8WY76SaUP+mAUb+MHmBlhV/HkHBcIEDcgrG+gqQLxGTv6ZBWarmrIVyrYLTiHmJ3RbUWuOjlY4+hDjt1Pt0A9j73Bdpq3eW/8D5GBssexEvkBeFsr5Pxyk9iWjCY/zipeMPdF1qCznnzf4xD9R1HWUNo3dsTCogN8uRbD/W3qKMtYHhJ4vBxI/IiDOuqvY3m0s2nk6gVddNCdwiPdXCRxESA6bgGv+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR06MB4634.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(2906002)(86362001)(71200400001)(6486002)(26005)(110136005)(66446008)(8676002)(2616005)(53546011)(66946007)(478600001)(91956017)(36756003)(83380400001)(6506007)(66476007)(316002)(186003)(64756008)(66556008)(5660300002)(6512007)(8936002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?VGZOcExxQXNGWUhBRjdCTlZLYlgvL3crQW0wdml5a0hHdFZLRXJTc0txdXV2?=
 =?utf-8?B?QzZ1bjRnTFd4MHh2KzZmbThqVWg3eTVEMG9Ld2p5eWNESXo4blRHQ2JYRXpV?=
 =?utf-8?B?aXRuL3BDd2JyZzNLSzVVbDdTL3QwM2tRbWVzQmE2TVNoOGJsZ3pmdm9EbVdI?=
 =?utf-8?B?WGRUNFhnd3NWL25lbVJRMlpGa09rVTBNbTRHMDNBWFlXZTZUc2djVEVjTUFh?=
 =?utf-8?B?cjU5WDFiaDJjSDZOYmlrRk9EbWFlMUlHeWRpS0t2UjNOYnVJMnlPY2Yyc3pC?=
 =?utf-8?B?Nkh4cDR3OThhQUp2c0JFT3dUQVd4bEE3Y1RQZWVZT0tPSGRiQ1NmUDQwangv?=
 =?utf-8?B?MDY0ZDBhUFlJTTdXandpcE03eGR1RmpSL3FhK1UrVkNKellSOVk0YTdzK1V3?=
 =?utf-8?B?MlZ0RHhaMGd2VFhJTnhaYUJSOS9VREg2Ym9UUDZ3REdGUi9KWUVzVGk4SUNp?=
 =?utf-8?B?eVBXYXJEZ2pNcldDbGkwMElEU2kxZEs5cWxJZHBZMFAyVTRKd1NNbWJPdlAy?=
 =?utf-8?B?NnJqZm9XVG5VTGhwV3N6eXRkRDhSZitWQ0lhTW1mTEsxU0IrYUNPSXdOalhX?=
 =?utf-8?B?a29Pbm9idkVHS2phZEdjZk5uTzNWMnplV3NRalRHL0VRZmdWS3FKOGVqcmI1?=
 =?utf-8?B?SzQ3SW9FU1dKSDVQSDNVTFhlN052Z09xMmJUU0pCaFhDVEJvTmdsWXVwMXRs?=
 =?utf-8?B?SUx2cFZDVi9acDlQaGZWcmNraXQ5V3hjSG1sc09wK25vQ1VackRCTnM5aHBr?=
 =?utf-8?B?VE1HOWtGWENpUHlHQmhSWWU1OFBIUi9NTkljcUp5Zm55ZVFDaFVZMXBXUnRv?=
 =?utf-8?B?UGlRdVhjL05SeEhaNG9IbUJ5ZUhWZ1dRTk8wNlR5S2ZKZkZENWZiRFNmaXNl?=
 =?utf-8?B?Q0Z2RmQ3S3A2RjVXaHcxR0RLVkJ6dllNMkJwTnRYMVZ1aXB5RzhrTFQxT1ox?=
 =?utf-8?B?OEgzcHpreG1TS1kwQkt4NjFDRFRjaDV5eTZ1YllQd1JWRS9EWTRQTW9wZjJn?=
 =?utf-8?B?N3JVZ2lzdVd1ZTUwR29qb0NGMVlLSkpPZXhrRndMaXFmeFA5b1R3VHhxUm5N?=
 =?utf-8?B?RzBaaGtyODNSeDgrME5SK2N4SHFpRUJhSFZGWXV5QTFQbnIzeU8zQnFDRkhi?=
 =?utf-8?B?dDd4ZWNkZllPcm9sQzlHalNxU2R5SHRvNzdiTVVyM1V3NGQ2WUVsUmVMMVB2?=
 =?utf-8?B?SWU3cTVXa1VHckg5UlUyRjRtUmlVb0VpV25IM3U1Y213T0o0dC93Y0pzSVpQ?=
 =?utf-8?B?eW1IUW1qMzJ3YU1ZQ0M5cWJIZm85WDlMcnhQWkNZYWZjZ2gwR0dzaGk5K0ky?=
 =?utf-8?B?S2t3QWtFTWUrWGNHTCtrZWNIYjZkWWlnVUdsT0NZbnFPZzZ3QWViNEsycjdv?=
 =?utf-8?B?NTk3N0g3ZUFhRi9GZmpkbk53SDlJMFl6SzYyV1dTa2VaR0o3L3F2empnS09V?=
 =?utf-8?B?S3pIVlZadHZCRTdLemNJKzFpYVh0cU9vd1NhakdhZ05jVFhnMmhyR3FxQm9U?=
 =?utf-8?B?d1djRkt4bDV0QUJIR0FoNEVDbDRpeTNtVFdHTmt4ZlpwRERyN0VnOVFPT3lw?=
 =?utf-8?B?VjlPbFBQRDFDNUVDTTNQNWxMODBldkJyUE9zWlVYeVpBaERmOStqYmNnWG5Z?=
 =?utf-8?B?dmRtVVoxSmQxMFJiVFd5S0FrZ1hGTi9WWjU2RnEvclhYT08zZGxEaDdra0tu?=
 =?utf-8?B?Sjh6eEphSVNBNXhXLzVMbncrSm5EMC9xaUFjMDk4b1YwY0pDY25KdU5ENXAz?=
 =?utf-8?B?ZXpoVFFLalhZUEErL1pham1MZURwVERHQ09XZjFKaDB1c1JSN1BkcVIyb1Zn?=
 =?utf-8?B?Vkc5Q2d4dWd5d3NFZkEvUT09?=
x-ms-exchange-transport-forked: True
Content-ID: <246E13FE945CE24C9C2988F4E900DCB4@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB4634.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c797b875-e7ff-453c-514d-08d8d57b4290
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2021 08:41:04.6273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +qVPO8EZ8C3WSDIbsm8cjhd98CoEAIVRfRGu/ZnmqiEtHXYdaYF8J3a3IRcn1lItY7+EWKo2iQKbXwDpwlGi4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3241
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210220_034110_869388_4F933D8B 
X-CRM114-Status: GOOD (  23.34  )
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

On Fri, 2021-02-19 at 17:42 +0100, Hannes Reinecke wrote:
> On 2/18/21 11:04 AM, Martin George wrote:
> > Currently kato is initialized to NVME_DEFAULT_KATO for both
> > discovery & i/o controllers. This is a problem specifically
> > for non-persistent discovery controllers since it always ends
> > up with a non-zero kato value. Fix this by initializing kato
> > to zero instead, and ensuring various controllers are assigned
> > appropriate kato values as follows:
> > 
> > non-persistent controllers  - kato set to zero
> > persistent controllers      - kato set to NVMF_DEV_DISC_TMO
> >                                (or any positive int via nvme-cli)
> > i/o controllers             - kato set to NVME_DEFAULT_KATO
> >                                (or any positive int via nvme-cli)
> > 
> > Signed-off-by: Martin George <marting@netapp.com>
> > ---
> >   drivers/nvme/host/fabrics.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/fabrics.c
> > b/drivers/nvme/host/fabrics.c
> > index 5dfd806fc2d2..604ab0e5a2ad 100644
> > --- a/drivers/nvme/host/fabrics.c
> > +++ b/drivers/nvme/host/fabrics.c
> > @@ -630,7 +630,7 @@ static int nvmf_parse_options(struct
> > nvmf_ctrl_options *opts,
> >       opts->queue_size = NVMF_DEF_QUEUE_SIZE;
> >       opts->nr_io_queues = num_online_cpus();
> >       opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
> > -     opts->kato = NVME_DEFAULT_KATO;
> > +     opts->kato = 0;
> >       opts->duplicate_connect = false;
> >       opts->fast_io_fail_tmo = NVMF_DEF_FAIL_FAST_TMO;
> >       opts->hdr_digest = false;
> > @@ -893,6 +893,9 @@ static int nvmf_parse_options(struct
> > nvmf_ctrl_options *opts,
> >               opts->nr_write_queues = 0;
> >               opts->nr_poll_queues = 0;
> >               opts->duplicate_connect = true;
> > +     } else {
> > +             if (!opts->kato)
> > +                     opts->kato = NVME_DEFAULT_KATO;
> >       }
> >       if (ctrl_loss_tmo < 0) {
> >               opts->max_reconnects = -1;
> > 
> Can't you merge this with the previous patch 'ensure zero-kato ..'?
> 

Well, you are right that both the previous patch (i.e. 'ensure zero
kato for non-persistent controllers') & this current patch are jointly
required for assigning proper kato values to the various controllers,
so it would have made sense to merge the two. But the previous one is a
nvme-cli patch, whereas this current one is a kernel patch. That's why
I chose to create separate individual patches itself here.

So I hope this is good enough. If not, please let me know what's the
right way to proceed here.

-Martin
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
