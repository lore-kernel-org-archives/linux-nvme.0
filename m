Return-Path: <SRS0=isN7=4S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B393C3F2D1
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2020 07:43:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F3120828
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2020 07:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u+6rHbZa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MJSyGwkJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zUSGXSOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F3120828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=/riORlnQGb2u1faftog0qCWEISb/C0hcZ6pdrG0B5/o=; b=u+6rHbZaCoW42p
	xHTO50NmgDmSe8aNNAN3QfxMB5SDERQPf1e6Zbb6ySBg/iDJdNb+zYw8IYYBT4zGBOfof2P8EOEGH
	V8IFr/mxPkO8lQyMrt1JPKJ9N9k62lHcy467aEOcXn6TPJqxAHrOivwxDpc/LVwsCnbazDToeL/OT
	i63lG6Nevmu0q8y0mfySUfn4hHQTVRPehTTobKPVo2n7rwjZN9VFS5EDTzNdD0RmOwKVE+qKl0k/O
	cjSxpdMC88HHtP5u/FighY/wh+zaCMb/HE7qcQwbmeOhMos0/C0h0kfg40mZ3DZkkJ2hlzdHFroof
	Fb/gza1XZf5M4eOfKz/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8JGF-0001oy-J9; Sun, 01 Mar 2020 07:43:39 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8JGC-0001oW-NM
 for linux-nvme@lists.infradead.org; Sun, 01 Mar 2020 07:43:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583048626; x=1614584626;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=fMGW1mkAYG6MChI6kwDCBRUZKBCvyKzAvo/sHwiJYpQ=;
 b=MJSyGwkJBJ4bkXmNSQKtvQqzy7x+7Xpd3Z3+3tfpAXlp0PTkpr0Z4DYJ
 oeFR9LBpgH9iiCv0eilmRX4wwh87Y5nM3248bO0A4M4fS9/Yw/07dL95e
 9aU8JuL9JbWho7HxvLaGIhTOdnySRIchMcRG0kPIUDmdNV3xJqVTsGtXk
 EngkFuQYC8KO1E2jTaT72OXpQootL6PVlOgB7m9cQN+MN+LhfcACVFk8B
 rOr7BYhegaBsddfnF+1atlkcGkLkF5vg8GKuys8lv6kdw15azBylNeVl7
 eT6d81WIN+OinE/p7OVBpuZ+SfmzSZiTcjMS6HwBVIcbTp3B2SKUdSZq5 A==;
IronPort-SDR: 4AicOqJdefEKrMv5HGJzkumHowugGZ+Unw3mvux1CaqBi7SgIKIZOQke3p+CA3O54Bav5KrMdK
 14w5HLCdBN65WUljGvTRrFJXU4dWi8CevrgBBPxJgIjTnvhWRj/TKqoFHhBJvJtHdDTAJSiykV
 IlXtBoSpNii+B8krIL39Y+/Ss1AAgEj4v/By/1iIWN6sPo7A9KrJe+eud857zUGEVXZnbrtYb6
 /K7+sMVGuBJkbmFFO0vZuaQxHkz5tYEZh+Aeuc982EtG3q87bkBBqoxiR3CHwuUr1C+Ufcsmd7
 hyM=
X-IronPort-AV: E=Sophos;i="5.70,503,1574092800"; d="scan'208";a="233031250"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
 by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2020 15:43:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AM5VkWUfCHh9IC39om97fpvoGiT8PzqoFvqldcFOs9a59urhRjook7bJ+2J+kSZTI5TcTTyGsCjUaaKPNp9n1RMNzhGN2w/erfoT2g/dxiHJsEAZnHLuymUPC2JzVTBiTybcX7ghNmu6/HdGfFa/Wf85jVLoCw/XZYeul8gIauHx5sK9mWPznKk0eqMMuAg81k/BUNtp185082N6QAXqSH3AYEKriLhbNnyq2UVZlgJSij3G++Sj/dAMdr/YjndR2Pafil2pLm8F8c/06MaEkBr3INbwqvj10JyK68gkQVZgcpiQa4ENsslnNdvNu5IRswq8w2vykCWj4W5389zJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uzqi5nx9uHMIjP3TokvcDlukZOt7Y0CYnacC6NWhIQE=;
 b=IBkFxVfr23aYgZVoyCgNDtjiuVbqcEWS/xChrwNJuqJ0P42iOD58IbpoyYp6odkN6ipKnDJ5ZeaYmBm0yf7x/RywWh6a1HCHcsju1BOoxk56jndFLrXs2qJLY88PxAqFcGCFV3ScsaQEt3xthxW8Tj391iMIhA03s7T/LzHXjwxhIXScb9fh/4242lWOOi/Z4YzrcCSqQDPANxxLwMepimIQAj93lAQYDGFb4rAKtU6Cbk9rJ8blG5R1dIYsqT89woUtsNGHtKReZ88lf8SeXzf/dipgWU0BNIG+rrMSj8oFCK4m9XnS1ZG5ETDN2TLV0JdW1y0v8u3Bsb2tVWyKuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uzqi5nx9uHMIjP3TokvcDlukZOt7Y0CYnacC6NWhIQE=;
 b=zUSGXSOvi0OBvSdSztKKxpB6Ls89lg2FzKVJlkyUpcmFoM2v5RWmhC7KC8q8XH1r6bqZJryvDEL/uq52+Ki45S/mkgH/xRr1/W66KjA5odXNCZz+XcqkfgmwcmbdnQ8coufEfiNRvsA4kzwdnrcRnDFnhF4WcWDOXOUjKADXE44=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB6117.namprd04.prod.outlook.com (2603:10b6:a03:ef::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Sun, 1 Mar
 2020 07:43:28 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2772.019; Sun, 1 Mar 2020
 07:43:28 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH RESEND 0/2] nvmetcli: make model and ctrl-id configurable
Thread-Topic: [PATCH RESEND 0/2] nvmetcli: make model and ctrl-id configurable
Thread-Index: AQHVxqpUXzd8VxYIIEalrO1b4yEvMg==
Date: Sun, 1 Mar 2020 07:43:28 +0000
Message-ID: <BYAPR04MB5749A8956067EBBA427672B986E60@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200109050448.5758-1-chaitanya.kulkarni@wdc.com>
 <DM6PR04MB57540A44AA6DC1E2DC67180686350@DM6PR04MB5754.namprd04.prod.outlook.com>
 <BYAPR04MB5749D99EE2CD10AFB322988486030@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce1d9350-a4b1-4ff8-2914-08d7bdb43b6a
x-ms-traffictypediagnostic: BYAPR04MB6117:
x-microsoft-antispam-prvs: <BYAPR04MB611775028F05EB9E943C196986E60@BYAPR04MB6117.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0329B15C8A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(189003)(199004)(8676002)(4326008)(4744005)(2906002)(55016002)(26005)(81166006)(71200400001)(66446008)(33656002)(9686003)(8936002)(81156014)(6506007)(53546011)(76116006)(7696005)(316002)(6916009)(66946007)(64756008)(66556008)(86362001)(478600001)(5660300002)(52536014)(54906003)(186003)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6117;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WjWetfNn6DjmGci+x6ZpvAuCrg2RmE+QyhilwB8puR+pzY/jKglMSaHObgFOGAuo7PdIYK2ysvDhUdsJ+UX/LXoddE6b5xajpiWN2YBkGJbnuXCKgJYO7wNRnEs4xJOIvCSG5ONC7YYn0+4nX8eo29WzSNsCovEcsdurtwDjvG6fB2vqA3RVfPuQlknR5Eh+LjNlt6G/G/hHL4PQnJkS03l++uUtSVo4vFFxu4Z6pKi7ayDLSl3Ld73ZkEJ15STl+3tCJxqHRbWE5OetEKSUwds7q1q1j+FTqxGp2yPnUZopeUBvxmkkZjOb2T8+Oz0DiUzJruPO9HJDpTu4wKyhulBNRTSX+6RKqt/UBExJnOv1M/OxsDy++4BZSGShN69vzy6BAD6YqqV+pKqpELqk3hpycpVdFuMIZXxMxHLbfYVD0IenRqZONVLD02HhICEn
x-ms-exchange-antispam-messagedata: 7eHVnemL77G93nBjnm9HhFGZC7c6nAWBOXRhTYQNuV2QbKoIE6Jd3PrplgOvtetdKbCPXin13ezTls+KLmgbg1V4J1TAAbdf1LR31IFk2F0IZ0ZIvWkqcKn0KpEVv1DWTUw5eXR/8REs/4fM+RXKGw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1d9350-a4b1-4ff8-2914-08d7bdb43b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2020 07:43:28.3131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KI9sPwE5RPLLu6dbiUQ6NBP3O/4Dxf37+cXikMB4YR0s9fEhTJP8R9XF32+WkRqpLGFks7U+PsfQZ4XisMy3394KbrnylDX9aACVb5XOAJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6117
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200229_234336_959325_9E05A9B5 
X-CRM114-Status: UNSURE (   8.79  )
X-CRM114-Notice: Please train this message.
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ping ?
On 02/03/2020 07:27 PM, Chaitanya Kulkarni wrote:
> Ping ?
>
> On 01/13/2020 03:53 PM, Chaitanya Kulkarni wrote:
>> Ping?
>>
>> On 01/08/2020 09:04 PM, Chaitanya Kulkarni wrote:
>>> Hi,
>>>
>>> This patch series allows users to set the subsys model and ctrl-id
>>> fields.
>>>
>>> Chaitanya Kulkarni (2):
>>>      nvmetcli: allow setting of the cntlid[min|max]
>>>      nvmetcli: allow setting of the subsystem model
>>>
>>>     nvmetcli | 25 +++++++++++++++++++++++++
>>>     1 file changed, 25 insertions(+)
>>>
>>
>>
>
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
