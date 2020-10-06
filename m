Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E9BC4363A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 02:56:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD5A206F4
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 02:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rUZIpzH+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nwRlGO9m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZIjjxZt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD5A206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=VXCl7amYBmfbCeyIiCQZbRWwYlg407sAzrNal5EWfLs=; b=rUZIpzH+uukehBS2a/xT0OlQI
	+dPCdfU3EBh+oEgFsgGlLYsKqFJAfDBpgDJwm70V0EfwAoyD+He4WRdb68j20+KNV/eTT++Pbvy1O
	tQ3+8zgdE6ZDKHEKKz/WWTQoYsIl6jkrAuo4bM7wYmlpe8FnWd8ZMux7X+DMW0f4aIJfKjreKT0tW
	ey0IKZblSWolCdMxY+Un4R54m/TH1Ud33M5Bz/ZnqcdKqN3dEL6Ya/j2MzA2L44gQQnk3bMm8+B48
	E9vsLojiHWK0Rg7Ym5QjYzNLvUEsRalLBGszkYQqvfFBJUgsdMmRedWe39t+jzp+ZG803lsKgZQYl
	GHM7uImhQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPd9h-00013p-Ul; Tue, 06 Oct 2020 02:56:46 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPd9e-00013M-Nz
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 02:56:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601953003; x=1633489003;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=9S63t9ZGoUVmJb5cKwrmcNHKo6YdvwxE3WgbOCQ+5iw=;
 b=nwRlGO9mCr9KWN8Jjv4CXT7i5Ge5mCf1uGdm68G7+in70g3GWLiP9aRv
 ErR0eBlCIZSu4rmY7un7JqKO4BUYifCdZXwLZElHMOpLgZly3m2VLn5BD
 ESlm/UlUhINmWVoSexBi+/ltOGQEQ8TATLnhHs4RlZiUFZvBYkyPlsdMT
 BtPFKTpC9nMAOgXB4maamER46v3b6kekqa2TUtz53TUf5ZqmMx8Ufyx1L
 1dNjyLIvoZhilihbus0nDxoiDgRxk83LHYOS7Vgezj7V2ymFPpv8mmeWE
 SY3V14zNjD5gRb7q4V+0IIszMQSCbb/Qmu87KTIBl/q2Jd/joxT83BzJP g==;
IronPort-SDR: cltIfBR/RD0j9KDITN8Fb4b4As8vQtGJQBl2hRz7TbVmy5V7YiUbGCm9v9yKYRhWYq9+IfRkCb
 w6GeTebKrv246OgQI15WOLTeQ2SLeL7upLzbP0rOOnAS1p4i7RIaGkg21Frr5Vs83ql50qNbVb
 UW5FCN/O6Oi/kKFmpwgUVHQWanW7JWxQzj3tHEiJ0iO0l7biZBLuSDU2Qt6tGJGPiOYfdxq8id
 Dr4sq54WIz+3pRTEXo4hfOuN5iHfVKOrmv2GAQyajo1wb5EOZ+LfOi46liqMPleXpZy4AfUxU0
 /uI=
X-IronPort-AV: E=Sophos;i="5.77,341,1596470400"; d="scan'208";a="153540085"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
 by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2020 10:56:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihTpJsdN51AFQUKZyFzhKhpF9N6JZ3bm4mIytt/mTQljkqxtNJaxA/+nb3hcBdmwc8jG1cqrolMroyt8AxeqwnzWPPD2+bW3YwLd8bp8GujXMXrHsTxB256rbpsF21qAypTufPccDUale76D3K6SzGSdm8cD0pv6iFKl3ydvmzBCw1hW7usNJeqgtACQJwurxhXNeMUdb2BEbSlgiMq9MEKBHsMiuYTO+bLQy5m4sbHagrzi4BsBh+v5K9FxeSZ9yisottRZi+f+8kGKvkjjKIIN8/lL0tP0+fzdrSFAg+NjqayMPUvTlbo23V/SNp1pn0aBQmNl/3mvAogbB4HtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFzf+6Ctr3RoNwemGo6BlS/FlfB97qq8Rs7guUY7BKQ=;
 b=jaumC3uRUoPlcNiMLGwiQ3bfi0NZ84dy1vslsogPS0h8Y5LQfTCjKRzFo4+Z7gp7xi0gGLYwsB7Q32zR+1pw1Fk0cy2XYQUtHVsQ9/6nUcBHmFqzhaH6Js7WBQ3rojCFmEB3qMwWYsj+fuU76OYSbif13pBWt47l1lIpSVG/IFHTT05I1dNw8zfusug7YNd+Mb1uuxlSf14jVumMluCxXPZuJtM/M/yq55Qwz+zYGM//pvCoTb3D7vWW6CrsLg/IiUJ2PpfUDdG70KgnxSAJ7oiaL7jNseoAKZZpwfSZ8IuR7JF6Nq+pErqXnE8q9642hEtSqIloci+v0V1vekvN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFzf+6Ctr3RoNwemGo6BlS/FlfB97qq8Rs7guUY7BKQ=;
 b=ZIjjxZt3EdF8NH0o2ImJRuUWnJMvdCwbeE1wFyR+e6TN9J1NTsGpAg/PHvvNSNkpSiwya1qTuu4302c3o+wnxm7RuDAGGNFvV3tep8nJFDhoYR4yei1kn02VrR/UK6Z8TmVbqfavuhmTLv1webxmo0jDLgLA3q6XWUcagFPEAfk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6753.namprd04.prod.outlook.com (2603:10b6:a03:221::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Tue, 6 Oct
 2020 02:56:37 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698%7]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 02:56:37 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 1/2] nvme-loop: use xarray for loop ctrl tracking
Thread-Topic: [PATCH V2 1/2] nvme-loop: use xarray for loop ctrl tracking
Thread-Index: AQHWluYG9ioAYtsfu0yDp2Ss9Mw5HQ==
Date: Tue, 6 Oct 2020 02:56:37 +0000
Message-ID: <BYAPR04MB4965356BA38313308C7A5D75860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200930045557.53669-1-chaitanya.kulkarni@wdc.com>
 <20200930045557.53669-2-chaitanya.kulkarni@wdc.com>
 <20201005124605.GA518@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80c57de1-cb83-4770-cc90-08d869a37138
x-ms-traffictypediagnostic: BY5PR04MB6753:
x-microsoft-antispam-prvs: <BY5PR04MB6753D38FB2048BCA4BECDE4F860D0@BY5PR04MB6753.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I25KixDHNM4b3o+vE1q1WJAElO894dHqQU4pI48JxCpHs0XqXOvvJOfN7L7tynRe7VtHqc/zVmMyqGMwP58/X6u8tYi9gKvyD35ETfNot7LYvEXcM7Vlorqw2QagBkJpejn6AbAEVgKkeWWR277NOVazg0ct7c6Nk5JsIjLVAdhxFRoSmODqIpYRgJkpR+EvjgSBmPEC+gjE2fvCsiFKHKyQirsEBczv+VUeJR48jcyBOVzO0OUrhc6thvz7v53nWoXxiazMaw3xFoxIT0mRbsDH0ffSwYfyg6S5qfrRYEbgrs+4FURfyazRW5NiuU6G+GKUDuYMCOGU2XvBsuLiZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(83380400001)(4326008)(86362001)(33656002)(8676002)(6916009)(8936002)(55016002)(9686003)(478600001)(54906003)(6506007)(53546011)(71200400001)(5660300002)(52536014)(316002)(66556008)(64756008)(66476007)(66446008)(66946007)(2906002)(7696005)(186003)(76116006)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: OXbfHuhHp8wUy1qPPQflKMohWQTQX5fYTrq6IXr1XirP/Ioap6IlKZ1vsYrmRMKPr5nLQem2b0id98ETKxYH/vcbUnadYcsDfp+Xw84tJn7y/1YLwwZnPqKqPtHQZ0BPc+/OKyU/mJlpndOXgEo7UJ39IXOeSzdkY1WIufXCa3wLpv1xxPUhiN0tdS5Unke0nU6f3RWyl8oQSLf38yKuEx5TExW36DdpSSmfSc31wuH3uhq6QJxCCtLbzv4CAScLu96U2eQ1RFVkDtkBCv1YrrpDxV0206V5KIAb8GASyryh8C4hxcirlGW95fwMJTjB9TZReJL/MMqyAYDdpBHd5gbwEhqXEe99hvR2N5XyTwgDKC6hj5Zd2ENOkDT9dIUfOxqAIsTDC8GjLiiLyOXUc27QtG8DV+YOQAmzR6vc0T7B1x4viuE8SQywxSLsBS74zGyeIgjbDmrImpQhSlml3eB8jkksm1ZMGE0YUN1EXKMDtzTqL/aLUM4il8f5m1hA19SVKvUidSbRt/GQfMcoU7f2P6oJMEjZJ14cNEvikJ5gnx3VfhWnIQ2sBBm4D8+nfUn7iu5bgO5SKML/ednYgooaN5ahgC+5kiee0EILKcoZZuVWRjCFzv7BFxdAs3D4vbd1FU5/NEjS6ozOmCd1EQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c57de1-cb83-4770-cc90-08d869a37138
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 02:56:37.1499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00kJwsh6xwgj5jTMVNuZdSdT4Y8rnfFk4pPrUTogG/sMM/vMlsWIuiyh0yfKWw+T7YjRiuA+kTPI+x36KHMLpdikNqtv77SOCZXJ0mfjYQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6753
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_225643_113877_757D1E43 
X-CRM114-Status: GOOD (  20.50  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/5/20 05:46, Christoph Hellwig wrote:
> On Tue, Sep 29, 2020 at 09:55:56PM -0700, Chaitanya Kulkarni wrote:
>> @@ -262,12 +260,10 @@ static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
>>  {
>>  	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
>>  
>> -	if (list_empty(&ctrl->list))
>> +	if (!xa_load(&nvme_loop_ctrls, nctrl->cntlid))
>>  		goto free_ctrl;
>>  
>> -	mutex_lock(&nvme_loop_ctrl_mutex);
>> -	list_del(&ctrl->list);
>> -	mutex_unlock(&nvme_loop_ctrl_mutex);
>> +	xa_erase(&nvme_loop_ctrls, nctrl->cntlid);
> xa_erase is fine with an already deleted object, so the above xa_load
> check doesn't make any sense.
Okay, we can certainly get rid of the xa_load().
>> @@ -599,6 +590,12 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
>>  	if (ret)
>>  		goto out_free_queues;
>>  
>> +	/* unusual place to update xarray, makes unwind code simple */
>> +	ret = xa_insert(&nvme_loop_ctrls, ctrl->ctrl.cntlid, &ctrl,
>> +			GFP_KERNEL);
>> +	if (ret)
>> +		goto out_remove_ctrl;
>> +
>>  out_remove_admin_queue:
>>  	nvme_loop_destroy_admin_queue(ctrl);
>> +out_remove_ctrl:
>> +	xa_erase(&nvme_loop_ctrls, ctrl->ctrl.cntlid);
> This looks weird.  Why would you remove the controller when inserting
> it fails?
This is wrong it should be "goto out_free_queues:".
> Also did you do an audit that none of the lookups will do something
> funny with the insered but not fully initialized controller?

Now looking at the code xa_insert() should just replace original

list_add_tail() and do the right error handling for destructing the io

queues if any. Will adjust this patch in the next version.

>> @@ -678,7 +673,7 @@ static struct nvmf_transport_ops nvme_loop_transport = {
>>  	.name		= "loop",
>>  	.module		= THIS_MODULE,
>>  	.create_ctrl	= nvme_loop_create_ctrl,
>> -	.allowed_opts	= NVMF_OPT_TRADDR,
>> +	.allowed_opts	= NVMF_OPT_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
> This looks unrelated?
Yes, will remove.
>> +	xa_init(&nvme_loop_ctrls);
> DEFINE_XARRAY seems like the btter choice for nvme_loop_ctrls.
>
True.
>>  	return ret;
>>  }
>>  
>>  static void __exit nvme_loop_cleanup_module(void)
>>  {
>> -	struct nvme_loop_ctrl *ctrl, *next;
>> +	struct nvme_loop_ctrl *ctrl;
>> +	unsigned long idx;
>>  
>>  	nvmf_unregister_transport(&nvme_loop_transport);
>>  	nvmet_unregister_transport(&nvme_loop_ops);
>>  
>> -	mutex_lock(&nvme_loop_ctrl_mutex);
>> -	list_for_each_entry_safe(ctrl, next, &nvme_loop_ctrl_list, list)
>> +	xa_for_each(&nvme_loop_ctrls, idx, ctrl)
>>  		nvme_delete_ctrl(&ctrl->ctrl);
>> -	mutex_unlock(&nvme_loop_ctrl_mutex);
>> +
>> +	xa_destroy(&nvme_loop_ctrls);

Hmm, let me see if we can fix this in the next version without adding more

complexity.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
