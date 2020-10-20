Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437D1C4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 17:07:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4892177B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 17:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qj9wO6lI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fOREjGBt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UpJ0jXM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4892177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=3pm50HRGYXcgcrRQmL6/ryXPkJztvico79QtWxAXM2g=; b=Qj9wO6lImSc/NMY7s55cBKHyA
	rxQLeKgmV+IHQv9QLGCF7FqmtHD5RVf2DDFg2O1DpDhK6IOGUQDJChXKgH3DF5lWEtDgY/PE8tYeD
	KWcxfDpUmHC/GCYqdJP8EsExiW9rPlMT8aHk/1VhIWEDftFH5LZgdv7j+S1gov0NgknjIe+PJrlBR
	dQJisxtzW2Xwj9qabY3cEPjbSyjfZgT2U4mBeUsKRnZzKt65k+JloyZbxeoxiq6ojRvOvLBaL6MHB
	u2MROzy9F3djwHOAes7uQBrw3kj8B+XHN7KhosC/wv1OSZfG/FeRKrhxIVBK261JeLuS6lNTfIk2J
	PbF2krlxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUv6D-0003si-4j; Tue, 20 Oct 2020 17:07:01 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUv6A-0003s8-Mm
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 17:06:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603213618; x=1634749618;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=bJnzJ3FJm9bEoYlAUIoCKcvNo8fl22knyPHIxfrKT2E=;
 b=fOREjGBt2eZe7nf85vypn/ncXTUgOPZH4rGfVi9UpBqV8x8KQ8TgQXmV
 JiAS86y+s3ah8aFDJHsQV18M5ZtIDjs1KFYjLv8m4ThkixPjGz9XopQW5
 RQENAzqzre2/srcx+Xw/ksvZ1vyVG7/pQ2jvMdFTYADjwEgqRtBby9zas
 GaOEnX5P8M2Lhu/3n6Oh3g2Oa50tgkVcJe9p4p+lsrBdkSeyT8OPVbexK
 AB2LrzKi91JHxATLsCxExgl4bkX3z6pNPgI4Rhwdqf7LOxWO6cxdq8Xu/
 mwVO9vH2UGPLnpmgV4uMfL9s0zrr8JbJNlhd16nO3C0OP8TTTZIvpzOON w==;
IronPort-SDR: j00apa0YzMDIbzlyHO0Nn1qPZtowbmzJvVWntrLkffjWGjguiqjjeQbBceDqiKTLXnXighKexN
 zdD1FhvqGXrX2OiD24kxnJSfwnu0DldAX0x70GWenoHJsX1ft3FGyZmBuLxDzgC9kQb884Uv7s
 Pt3RRykCff5yC2k2muGhacydM7iRvnk9WVeHjRRni4COIWJhfc3ze8YN38oIFvTopUAnUAzqrm
 XcOcTDprhtfMDVslk8wlM2qveSEzCKHqITfxZYUNtfcqlPfja3YTijYl6VblR/KelfskN6mnCV
 RLo=
X-IronPort-AV: E=Sophos;i="5.77,398,1596470400"; d="scan'208";a="260320803"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
 by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2020 01:06:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P51OQMluxRdr7G2Kf7lH0z00zIWY1TYQD3w0HdbwU3TcvZ3jV+6xQJ5rMKkhF/+LVBu0pMoZpo9o7N/6RFeXa0UCBggUdtdF+iFvJaqoZDf8EEuZfWCscSLqNHMoD99YE8u29+PDtR6PAhztj86Qx+qFEKN26E8E/akDJ0aAHEnHfXG4w0pe7B6gr/vXXJBqtsCQQKIYzsO6Aw475i5+kjnRkbOIJg+uE+KfAS1V4Mcj9mvtpxx3c6r41Ruex1a+N1r7vXOc5WEwNsdpKSG3wxOnGbdf75LZk8Mz3MQ0sST0TDZWPQONDgyN5KX08+nPsNWCuM2IDG4ccJFNF06DcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJnzJ3FJm9bEoYlAUIoCKcvNo8fl22knyPHIxfrKT2E=;
 b=KviBsoINJGkguiFl93AxAwDNNB7XR3qYggyaM+xGhgEBUDrbwKTQNjLmSYQsU+A2JrXqCCn0fC7O5Yiz5lDJ3dF/p+wBPh73604DeTEgRrTckpYdRWtCWfw2YuPQMyX0RaHbw+PvtOZK+ld5YPO3q9OQnNpoNz7eYQD+vgShnmzlKIcPZUU+nzXhDaeE1AU4nbzg3VMgEG4pO0wH4mNc0Ve9gQTOSS4rSLIbbnGgxoc6kx8buWxh/9f9sl7mV2/WtJDOmalFmP+ZAUQuZERnK866lZjKM+G4xX+u7A0BDw1H5yt4Hn+JDxEv9tvkvnryqDygMvUq6HbB7FUaAfZchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJnzJ3FJm9bEoYlAUIoCKcvNo8fl22knyPHIxfrKT2E=;
 b=UpJ0jXM8uGgZUKbdZHtVyrpKGiVq3KSLgvF7N1m2Dsdl1cHNveNdWZ09sILOGrPySH5RJfaG6ibce0n8hOFu8XgnqWOPsYKJjM/82gxZE3r/rtVmDhdmK3NerU02OKnroPOkEgm1QPLBzed+N25+pbH5EIJevNOuIZmHKbD0sTQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4039.namprd04.prod.outlook.com (2603:10b6:a02:ab::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 20 Oct
 2020 17:06:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 17:06:53 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Chao Leng <lengchao@huawei.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] nvme-core: introduce sync io queues
Thread-Topic: [PATCH 1/3] nvme-core: introduce sync io queues
Thread-Index: AQHWpsEykOjjxzMkTkyqFgEurzpY4Q==
Date: Tue, 20 Oct 2020 17:06:53 +0000
Message-ID: <BYAPR04MB49659A83BC2C4763B1CF2E6C861F0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201020090817.27755-1-lengchao@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae9d18e3-e946-4de1-6d02-08d8751a8b29
x-ms-traffictypediagnostic: BYAPR04MB4039:
x-microsoft-antispam-prvs: <BYAPR04MB4039A85F9F544FB8EA640ED9861F0@BYAPR04MB4039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZjTg12iCz+8u/ZIxwfVfqAhfB+smIqeyk71t2g4PQ7LldS2COTd4cTTWf0CSuyekYiJWKb/tLu4MjMw496MESwLVLK3iEwWo04FMPsTZnQgfJvYlU4B70bQmVIvT2aQ86mCO+gkiPG6MMudr8Wsnl/yNBQR6403A7/dpVBZND5lXNeu6GT6EnabkKVTC15wI06kEPJvbvzRPk+TC+SDtbp6YAuyjd0Tm4XYyZx/RTMgvZYK3SW8LNFg40QDIFUg3KH3aj3/2AmoBqN9wzD84jlkO13cLpz3hkP7AcBcw0AfSbs/kYTf8TLsBHJvGq4/ivV6Zdk4ryHNUKaYNEuQYuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(66446008)(8676002)(9686003)(2906002)(4326008)(186003)(26005)(478600001)(7696005)(8936002)(55016002)(53546011)(6506007)(66946007)(76116006)(66476007)(64756008)(66556008)(558084003)(316002)(33656002)(86362001)(5660300002)(110136005)(71200400001)(54906003)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: G9n/5G0R5RvgnkAt58XpfLss57/8mbeGDyCeC/LN+dsmkTcUuaoCw9NEkW0Hb5KI/h6dzCGsTCT5KTpuuzHfpAtkcsOBKuFOHnaxs0bV2UHUqRj3f29B3Z5XBuTzzYmbMDk0TMMW8j1w2SVIchPEO3zwBqHpeeRR+jBwCtFbNkXpUXUE2XpYlyuMwTWMbPDP+O3OhNXTA9NlJLTgMQ14T46ZrOjGNlDrnsTh5VhGs4cqOzGkfGIJIdSWx7IKwh6JJR1jvmzWzBupSuAAmpa6CMCtfrRtdjO03tvBDCm5v4e1WXWhxHPcrTGU0F2hhzAmSZJVamYbCWyTO9svNwP8W3nuBvBG5AG8iJ3r2pzBs+guop0x3tWK0o0OasuZBhlZqJL6lpXmYbDGHWE5yslfi+cwzLAl2WWWmKlJ5mZnJWxIp7kGb34FJdMzWWW0/36BR9jM4djJU03DNjxWO9tNFpS+0iePqrapnEWYae8cSRf3o8SWLxCuTuzM7dcUqQgNnOM5/DJyNNOsGGVyvndMewApzjmqnQ8KejUIkGVmsQGXjEcoYOpJZ1WVK0ZXW9bgXsKcI4py+cY8HFp8ptaw3RY+qrY1BRdQWMVjRNkNy7w1Zk/ZmufpJs10RpD3Sbe3Tt/rH89IQJ8BUJclAgUVjg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9d18e3-e946-4de1-6d02-08d8751a8b29
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 17:06:53.6682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j6MWEgS4mEhiQf+GOvepc9wkGt9PSIWppWSx3+AtkkZJKWwixFq/1+H5YD11we+GmEtEw9ZgGpYTB0ZiRlsfH9MzsJKzg2ji1ouz5tZfWVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_130659_054060_5687F083 
X-CRM114-Status: GOOD (  10.23  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/20/20 02:12, Chao Leng wrote:
> Introduce sync io queues for some scenarios which just only need sync
> io queues not sync all queues.
>
> Signed-off-by: Chao Leng <lengchao@huawei.com>

Can you please explain the scenario in detail ?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
