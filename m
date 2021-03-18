Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5A8C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 19:16:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A82164ED2
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 19:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A82164ED2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=WoAREmfyk275encxXxo5GIUslfEq1Sd++6zP3QQRxwY=; b=f3agXGClTtD16WVT6WcwZ8z00
	mYkwPSFvd0rw4WVnDGPXkEawsxb8NhQXqHDA9/nBh0437ahB0c8ZXOEGQJvbBXumx4HqjQDR0Exkx
	UGG51fC53h1B5CamKTVQD0T2TjjvJEV/b4LJFYrmSBnr0hJPQfI4hBZLjVIynOekQxgRRKnbLONgn
	Pgdz/e8Y49B9OlIjjOaUHFjYKnVQr6TERL8RWiHD4IgHiKWdwwLFqEGG+WWYPXPkKS/2rJAyrx0uy
	JKHbOq+l6upecCSqkDoGQIztIXLEofvlfFMBL1HVe0e39oI+ZtgJRMgsv45zypJ+gmLNnGpxqPjG5
	2vNaE33fA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMy7m-005v6Z-HE; Thu, 18 Mar 2021 19:16:02 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMy7g-005v5Y-2m
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 19:16:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1616094957; x=1647630957;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=EfbOgeXZQcsfyq/SPdwPk41l77H1mIj9hTqTOjf/A+Q=;
 b=ICu/RBQBTfzLe77xpW+qDME2axF/ZLUSFYKxCwfMgm0kG14kgtBozQOj
 YsCQ9K1b1ej7AzumHwAGxWiS9wJ1eOthW7xe8QoPRlIBZtE4/edwioJhG
 LHbiN3OpWL2w3MLcxeQvmMlgmiI8dkZZtW2PGEkLkUOFxwL+nCWmDPLB3
 hox0UwvRbQpOzqhlM/Ectm8MjOZ2KODKoUWzWg+MSfGqrFclzbIDZOSJp
 mp+/CQ7lPb5CZLcFHE+/DVifoDwE1eD40UjeEXgnFkXs6LIaGABt1PbXg
 OkcEo36YfAluHhHShL0aYVFFD3H7s1ii1CQa0APKFUvRDpR6yInOoaHlk Q==;
IronPort-SDR: AFyqVQcWPy/KFUR6qj6jaWlSmAQkkROam2DeunwT9DMo67KZsfL5whI40L0GePRqB+EA8yAL4G
 D8CGDe60nql3xnhWNNjr+fMN54jQOerOeol12J3bsuh2ENmRWAca+uFH9l7iPVVTHxOxRkREPj
 YbxYn/MOQf7EeOhESw3FVh4fk8Xfz9td89NXDUcrbcH3A60pbnXSOzQceZuUwm8g9SRUFGreVK
 qBV/kz/6U2tTpL7iSIa1lraPauhosOfhaXgrnYxrGQNTbfF4Ux/dh3ODXkoqUetfgjhvpWdkzL
 Vqs=
X-IronPort-AV: E=Sophos;i="5.81,259,1610380800"; d="scan'208";a="266888456"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
 by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2021 03:15:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGZPjdGNyYc++V9mZ9Cfu3ghWn7zGbsXq8+cSdPBsulaQYeBjjY+QjmsQ3hTQyvsOg0lclElKbaMHjntD2yCPRCf6cmP4IOnR3MWn1c6EEHHchhNzDqDGSWgpYcKcnkitet+U0w8VaCtCJcZr5duRmAkfT+ZmZ6KjQ96F6mEV8efseV7j7VPo4l+pqLAIDec63d5dW+7vYXy4Nov0PEJz5/cQrKbH+SyGpvyXYHCEb1/Cciz4+/bYWTLU7eSks2CeQZO+9eluNWeIuPIQ8VohBHTe+zyE+JlfufGE+tFA/OFyKKzsDyCo3wCWH+IQ3+xizMnpHIsmET7fUYPvDtnpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzk1ywjk1je1X1ojaTqvL6NoYUao6CmfTtr0giCtRp4=;
 b=iAyuudaPsPyuufcFFCBCuHDqRpWGuSBSMf/GvQpTqxSjAGq5xGUohzWBVLsA0kxbYkDby5mGa5S4zaRRC0KhbjbI+vUz2hlKNpXzgAv4Zj/JhNbY8tlXEvSWTkUN9Gs0I9RbKqneZJ6Ss+EyNfwdAVB0scJHr7DaM9ysiUk+luDOm6eMK4XDsumR77NXijP6zW6gB5He3mplLxjWmp0Vs3Sl1fhNaBLXqRRqk40v0Ob/RJBC8892e6+l581amWZwENvpUX0jf5PNTsvZKzJj0JCe3wLghCYg4J/fsXE31ft9mKJQxwh/pkG4k1Ns5wCwi/c4efq4Uk/8qLSlzGYQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzk1ywjk1je1X1ojaTqvL6NoYUao6CmfTtr0giCtRp4=;
 b=qFLIHZL2GoKfAZGxqw4/1Z7U13VV/UNbruXUU2/EhA7vw2Ig0OBQ7GFBSjjekibgwFwdtG8wA4K2Q7kWA3l+9/cfUSShQbDmcG58r1s8BZAT9CJnU8JDnUdEwmnqyMRjIsQxvN60gI09liJieJOTvJLKK51Uxk50UWldAiE05/U=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7122.namprd04.prod.outlook.com (2603:10b6:a03:222::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 19:15:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 19:15:41 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Alan Adamson <alan.adamson@oracle.com>
CC: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Topic: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Index: AQHXG3E1EBkiIIuwPkudn1RskRqzKg==
Date: Thu, 18 Mar 2021 19:15:41 +0000
Message-ID: <BYAPR04MB496524879B3C3A1D9F644BAF86699@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210317204615.13971-1-alan.adamson@oracle.com>
 <20210318043828.GB26988@lst.de>
 <0D18CE6C-4390-4040-98A6-14204DE33253@oracle.com>
 <20210318165213.GA31675@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f06f071-4e6d-44a0-71c8-08d8ea423903
x-ms-traffictypediagnostic: BY5PR04MB7122:
x-microsoft-antispam-prvs: <BY5PR04MB71229E1315ADD610A8DC8BA586699@BY5PR04MB7122.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S6cmbEwXSRcrkptSX15H5HrBWEtuTJaelXLfhqblLuJXCbameGBs6zsMXI+gr3HroB7uHurYgn3dq0M9yZW2SXK6lDoA48hIxexg1rtH4+kIjkQnNXRKHONrpfPYb/vpnn5ib83N+qi3w873GU32poI2cOCIE3htW19P/k0ccujQFj0BVDjp9HEM2TzI3ZBY+a9++rO4DSWYrC2Uj2Y48HoHvw4aQyOq46BQ4dhFyJ4Ie3FVAjcAIhBvMVSN9WV0t4mgcvMrGhtkZuxJ5IOwzwTh8NOjDxtrRHQ/JMzkf15Kyukr3wg/EgF5HfXkvI8fiPoIP4wB62vlozmvJD6IU1Vbb2f6ZfZvvOpV1kFd0cO3ZWaQASb5iIWCqHLQ63v0A8kIcEtbU4oyTQdRZOFxwZ+ldxWFe9vllC201o5+xTgKCcsL6dNK7PCXB9yge4FYIV1pPt+yMi9+BkbrJJghZakIvWBABMi2RnpSQqLx7bn7QHlcWB2Fo1O83LqHQMaeKtORuRMDvpr7DXM4rqCCxYim5/LYqhRbcI65QXd8zey3RrfL5mx96u9uRR54xqEArk0GmtrsD3WkAX0shO9Gtmd9lwmsQU6Em3jqkcG0WH9utqpqU+DIaydj1Gzb+zS8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(64756008)(66556008)(66476007)(186003)(66946007)(6506007)(26005)(71200400001)(66446008)(2906002)(33656002)(86362001)(91956017)(53546011)(110136005)(5660300002)(54906003)(8676002)(55016002)(8936002)(9686003)(52536014)(4326008)(4744005)(316002)(478600001)(83380400001)(7696005)(76116006)(38100700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cET/KL4LJIWmzaa6D481S/ZUq7EOJ9vVjq7W5QDATxNV7RmDv62xcRivYmDo?=
 =?us-ascii?Q?JeQ5PsrOLkPsshQeORPtVcu7LdQq/v+SAcUuJeb6IDQzF3x0MCh2yBX8fTWl?=
 =?us-ascii?Q?gZKa/25T6F2FotvsAdpLLpmpG9YXNPNU560PJGCQM5vaEjb4kQGW5zSfD4VO?=
 =?us-ascii?Q?Dk9JsNkBOmIQ6rqhoRiAH/feOCaclrm6bQe4S5nT98Ov//3ZCdUBkWuQ3HzO?=
 =?us-ascii?Q?+MDhkRoGu2TG6SP2EuMpOW4WxYnseBEEiN6wPbL0UgyZkaczanUc1WSuKWOg?=
 =?us-ascii?Q?WGREBI6xjaqcTI+iHFSpDWxuvnW5/s/TqLY4+tFBl1UF3ecyV7xT14KJiRrk?=
 =?us-ascii?Q?4QJvW2PgZEHCeRmQtAhRROMeEVcBKzqHaRU7SWaqF9wpZGLoqAWizFLRA4k7?=
 =?us-ascii?Q?8FsTeBnpmDqDW6ecTgzGdMv/Py9pIYq/4t/f0Da8+0x9wgKQxfSywdVZTz02?=
 =?us-ascii?Q?1yEc10Cz7RNDp69xFBAM8BrsoVVjUSgIwAwAPjkY0phx3oGUtwEzNyd8NHwR?=
 =?us-ascii?Q?NqOkeMfriISqdlnlFGfe2o5acw+fzeBJaFyydEIq8vknRzcsU/W3JN4YfH3c?=
 =?us-ascii?Q?GbBfa3K6asTGprAuwWj9HUwBcoxHEGskh/cgOaFuMqlwpDsp7x6QqV/BXMlN?=
 =?us-ascii?Q?3R4eoLdQ0nYwk7kgi7BBpsjMk5c9tzfuRVcZslCnKmh6JbVJwTjOlJ4bZgc8?=
 =?us-ascii?Q?97Wg1485P+eAbHqD+MPtwpWBrhiGrMDJG6zFAFJRgWoIcD6Oz/cyp94gqO/U?=
 =?us-ascii?Q?R/HOrGAXge+t8vHfEJmM3huJKh7X6E8lWdVtOH6iDMMJAb/NiB09s4esmG++?=
 =?us-ascii?Q?mBL0d4txKUQcGMEhtaWdbhih2x9pX/gUWrCL6zFUS+Os3zaYoZwgW1EJZ3Hs?=
 =?us-ascii?Q?BrH5CScCm2Th6Yi3qGfuGTGf4ftXFSnE9+2/Tc3NdztWB8kl47ZN1/eeM61o?=
 =?us-ascii?Q?8LCwvXjv5RVeoi28Ml2D+9it0EEzVe6+EbDsJUbAsrDpZrDmUiCVAocTf2w6?=
 =?us-ascii?Q?R6qjkKOv/T9rnFJ+Ho/ml2CtzKzDT9rv6buyPOjBAj2Kzw03+mXNhbrgSVRR?=
 =?us-ascii?Q?2jGfMW5ND9AxSaf/AE+Vh6e4h8V+vkAikJ5F02L5pCdfqjC54hEhRjiVZmKy?=
 =?us-ascii?Q?iwi/dyp7LePX50OHunsVwKcy+pfaXdXlhHqoP48zxJ/ioAtP6nq/VbwVpym0?=
 =?us-ascii?Q?K3AX/n7VezpJQdn1ivRBR6i34/pyArKcCvXwRRjU5uIqZLyp/dl92GiNxC9c?=
 =?us-ascii?Q?kmTbxU9wFMMg2kRgujYA+W3bPuzMilqYNnJPDgGQbgcpCt3VT/WJbhB2jAKX?=
 =?us-ascii?Q?Tn8THAJbh1z6GmlC/tlsqmLT?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f06f071-4e6d-44a0-71c8-08d8ea423903
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 19:15:41.7409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kad6arZL2J35ULKFAocoAiSH+pCvLerEqyc0zDfk6T7Ks9hmBjCb0uCRsGpIu9qCDRjGDbQfHnovk58nD6OtdnZKaDwJOwd1+tzb9old7M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_191556_869743_139BED71 
X-CRM114-Status: GOOD (  12.78  )
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

On 3/18/21 09:59, Keith Busch wrote:
>>> So what is this application doings with it?  Should we just have a
>>> ready attribute instead of exporting a raw register encoding?
>> Was using nvme-cli show-regs to manage nvme devices. This is no longer an option.
> Most distributions ship with kernel CONFIG_IO_STRICT_DEVMEM these days,
> so that user command will very rarely work on PCIe targets anymore.
>
> Perhaps we could introduce a driver option allowing read-only mmap on
> this memory?  While you're currently asking for just one register
> attribute, it would be nice if we can make all future requests available
> without piling on more sysfs properties.

This will also avoid further code changes seems very generic to me.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
