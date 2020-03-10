Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77561C10F25
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 00:09:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB472253D
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 00:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nE1cvELK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q2B8W85i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iPtiwAYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB472253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=8BIb5IZdIEinELniF6G45VYHH6iRonto3IIVEamQ8sY=; b=nE1cvELK3gZ8Hf
	/4bQiyZ7l4UblT5KTYFkeTzAoV3P2jpLy8EyQNVtTzShinC7Uk9ZkRyzsXJVvAMlDYEnIqX8UOnBT
	GVjWWjfQKSHJGi0Ch64J4MmlH0QDzpsVwfMIfP1raVI/FIceONfToD65siC3pcXS9JYa3EDdSq4GY
	n3ZvZcYvcQogZ9CS3TvS5FTy4XozHzWIzXreE5He+nzXR4pqhD20P33x0hAPjL3xZVsKiSdpOu41o
	oLFqX4htP+ySwGlTvzBd4lb3ydp1m/yTmgq0yj1Dn/3gXktH2aBm1Br51h1RuolwcGzDIxn5Ft3RD
	fR5zJSE6vk3wC0YIPxDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBSSW-000208-Ew; Tue, 10 Mar 2020 00:09:20 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBSSU-0001ym-6M
 for linux-nvme@lists.infradead.org; Tue, 10 Mar 2020 00:09:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583798958; x=1615334958;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=SSasrvtMIUcF58bZgUj49nSWJ0ElY88x7bgbCWiphTo=;
 b=q2B8W85ikrZUNrsTNFZdy61ErfW2uPXwNiYzm846y7q3aQFY4OGFOtj8
 w23m7bvaRx568g7/WNzedrra1MArHDQHZTm+yD1mvwm2go9wuYC++/ner
 Oal03/3UaG+Dfk2NAhvV4EwttLnfyZrvmOIoxIxvmfzcdsHRckYJcv1yd
 oPkOdu1oHH4LNQiPGkeZzRDKUak9FPP8JBEwpYb9mC8Azu1PhhOwRkXbw
 ynN3A5EcubuDsIaa0MuEs0bPqk7IT3kK+8y4g5h2Q6CeezkupozMA58Oo
 BxR5HEj+2qSUuRg/aawo7hrvVxQFRoU7ccRuguga1GZsaHkragCslL8YZ A==;
IronPort-SDR: QL/tXyvAeQApdahxrfw5MK/B1Dcb+Z5CLU8hfeyIj+xDMoVVLqnZGH3URUWLW/kkm8fvigSjOm
 76ZRrgxEfFD+SW6EzRFxLcAKPycX4WqjhxioZ9Hg2bbW3s4Xfeb/61zqVdEMopdjvfJf4247E3
 Fkwzh/Tm970QJm6AgXv9IBT/48M3Cj6blrEXQpb50hB+LMvOyHW3Y5h2qLh26nkeS9vpjOIBDw
 Ymnn55c9LglQ2wzAstOuozKQLrGQrYA3VBWfrR5mjNFlAmibOIYVG5TkhPv1BujA+6CYVz77YS
 IkU=
X-IronPort-AV: E=Sophos;i="5.70,535,1574092800"; d="scan'208";a="132480467"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
 by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2020 08:09:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmI+dDmgRQJFALcei2TVs3KZxvjC8lF1scxtGZ3yta3eeSjHB4nNubHeS3mUZhvQ2vvLIT/Xveo9SXpqkjzsL+H4Q9GrovfgO3pYEdBPt/hcEytHZUhRP2VtnyAidBwXuLLBVNWrJ9dEAPNRT8GBzWfgHZrr/eke8wEYbMyuxWA0j2v7R6XNulFDWMOsTKD2jHqCefX7mHukYvOYezawrYseig0POQrpSHxQtCTBEb8GWYO6svzF7LogdkRtfppx09kUXEgAFoaVs4QTIsCyjxOG7AWABX18BcSYpwxaq0ExIfM/H4FSZpVZisPFWXovictgVg/zW7wPhTT118l84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szAqxxsSW1zW1Y3Ua4/BKYa4kMMcg1+qNDv/yxtq86g=;
 b=hVjPB9xYJQLnqiKOJ/LIfGfqln872OO1mQf3y8mUkatcbeqfxWcrTMb6w3K2S4TRr7uNCxljtxlzPHgSnp3BHGZnvA/sYtHV2lPYWHw94Sfa/IP0Y+CTIqbSCbq/BeOZXOrWeZ+0OnzvDSoT8WwTFfYPEwMu8NwHTI4s896VgRTna4PC/9zasC0etoqtCGDMB7IObSQWuCTCNIpfCT4ND58F6A+ur+JffdNbKYFoYHQnAYRZLaZv5opgMUDNCC3jxX+mGo0xU5I5dPDRwI+vjVTBpZ3jvynVV0r+CtzyFYQzCHyxEgHoymwXl7JBl5PS9qlaUzWr9cdB/D4Y4bupaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szAqxxsSW1zW1Y3Ua4/BKYa4kMMcg1+qNDv/yxtq86g=;
 b=iPtiwAYdSFs8sqS5/QUym7h9dOcSRId9ChgzSqSh06XkZhO0GxgCTr1j1MpFuzvezsmJY52sy4So6ep41Ek/UaZ3NpY9sYBieV4st10b0NUU1Zmx1WQBnqNwm5vX7pkwObN8BDY0kQKb/g/wAhlP43VqQIoyU0naB7IlT2zXt3E=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB4517.namprd04.prod.outlook.com (2603:10b6:a03:5a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 00:09:10 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 00:09:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Hannes Reinecke <hare@suse.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V4] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH V4] nvme-fabrics: reject I/O to offline device
Thread-Index: AQHV8ELvo82ERkhI8UeMpldGRX4hDg==
Date: Tue, 10 Mar 2020 00:09:09 +0000
Message-ID: <BYAPR04MB5749681A4F3255DDEE989A6086FF0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200302033004.19474-1-chaitanya.kulkarni@wdc.com>
 <64155ff6-f4b9-27d1-9dcb-97afddb5840f@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd6584b6-9bbb-4df4-6675-08d7c48741da
x-ms-traffictypediagnostic: BYAPR04MB4517:
x-microsoft-antispam-prvs: <BYAPR04MB451757DA85D2F9115C45126786FF0@BYAPR04MB4517.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(76116006)(8936002)(5660300002)(8676002)(66946007)(66446008)(81166006)(66556008)(81156014)(53546011)(66476007)(2906002)(64756008)(6506007)(316002)(71200400001)(52536014)(9686003)(7696005)(4326008)(186003)(110136005)(33656002)(55016002)(54906003)(26005)(86362001)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4517;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MnwWrIr9E3Wfv8TqDKegvrT/q9i8QGMelSAqtZqjHC7G1DcqB+anFNypZGGR4ZxuIa3fFN+YMN3jeBpLnyi3pylls9nauOunyGCKAc+Jjyu8c8ZDIT5t7vLeRzLxqlLTVbLWnwhz686vzbDOO1ZtI9Y6E+MvQG5eRKEUP5PYZGMmTywfevdLac8frbTH73UIyRkE31HEQFZfMu+cBKG7alyif3beQGyto4m/kJ1bByMfKMID6uv05kIJrcaGnAXsNHWLU0S+DUQeTu2nBW+95TCFYznW2Wbd5LGk4YyFUHrnBUfBSqRHFDQk9mQTJbcrXXEzFRxsTHV3mITfJqSPnU/5clmLdzswu8CKponrVG+b6Am4oT0qcehUG5Ct7uBGW3extjFUNOMCAoW94msc68Jk2qwZs17u5njCbzE6ilNsKRwKfqvKIc2wk0JAc1c1
x-ms-exchange-antispam-messagedata: e9kdH5VuXiIhX7A+4uv7Xz+sVQnzhCePKjc0BODdScBiKZDK5gNqdSuNHx4Lti7iNfilW2klftDsBKDsb1DWqmTkxbb1AHG8UD0HklNkrxn3GY6d280V2HjsK22ldfqEqlMbbcrZz6pGoPq5I6JLXQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6584b6-9bbb-4df4-6675-08d7c48741da
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 00:09:09.9916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rh51yvH92POOMIJm0TxnM7N1BNTaNKZW7i+Y6z1uPuIeYtRicd8blwPQwaoI8XUDGcrAkK0LwD07DpJ/u6lasHijShCQY3FZkVXScVe+Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4517
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200309_170918_324973_885AC04A 
X-CRM114-Status: GOOD (  10.67  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "Victor.Gladkov@kioxia.com" <Victor.Gladkov@kioxia.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 03/07/2020 04:15 AM, Hannes Reinecke wrote:
>>    int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>> >   {
>> >   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>> >@@ -395,8 +428,21 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>> >   	}
>> >
>> >   	spin_unlock_irqrestore(&ctrl->lock, flags);
>> >-	if (changed && ctrl->state == NVME_CTRL_LIVE)
>> >-		nvme_kick_requeue_lists(ctrl);
>> >+	if (changed) {
>> >+		switch (ctrl->state) {
>> >+		case NVME_CTRL_LIVE:
>> >+			nvme_kick_requeue_lists(ctrl);
>> >+			if (old_state == NVME_CTRL_CONNECTING)
>> >+				nvme_stop_failfast_work(ctrl);
>> >+			break;
> This is a bit awkward; nvme_stop_failfast_work() will call
> cancel_delayed_work_sync(), which in turn might need to wait for an
> already running workqueue function, which already has the ctrl lock.
> Deadlock.
> So you need to call 'nvme_stop_failfast_work()' without the ctrl lock held.
>

There are two calls for the nvme_stop_failfast_work() in host/core.c :-
1. nvme_change_ctrl_state() :-
    Here we unlock the ctrl->lock, then call nvme_stop_failfast_work().
2. nvme_stop_ctrl() :-
    This is not taking ctrl->lock.

I'll read some more code, but please correct me if I did not
understand the scenario that you have mentioned.

> Other than that I'm very much in favour of this approach.
>
> Cheers,
>
> Hannes


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
