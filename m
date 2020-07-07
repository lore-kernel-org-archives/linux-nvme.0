Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F298DC433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 15:53:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2332082F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 15:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="POJ+VkwX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZGBmBXHu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c+CXoS8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2332082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=tUX1DsSC68mXTB0Ty9czlB/irYInkhDEh5kMfH5isO0=; b=POJ+VkwXxhxVQOOsU7dBzD0hX
	oUnS2oTYRtsRRCyWujC+ZBH4uWeUI56X2KRk1bHuKROI6GQAZ1M/BAB3OXt89gmqk12yfWGU/KPAi
	33F5ziJ0nD+NIDyrIEX+HtBoRTy0J4V8HEOsgRh20VVVQg/5UyqND/MZByW3Gldu1Odp+U8eQYEKt
	YYGpENifvKBNZg9oVZSzTAiomlksRtD8IlXWjXXI9O9yZcwv0t4FmHY1nvuQuspHndb6B//H5WVAX
	ERRE8MPIfcOxWoa0ii7U2frqiwxRLL4QGhmt7295jwtEWgE25dtgP6Xv8YpoCO/QbSOtCgM60upoJ
	SxWtgn08Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jspui-0005gY-6k; Tue, 07 Jul 2020 15:53:44 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jspub-0005dS-IQ
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 15:53:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594137218; x=1625673218;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=J+DyljRk3z1pBEvepvSbE6CvIkpOILf/MqQFzLFg8mo=;
 b=ZGBmBXHuj//8FmD99xe5FRwJ8FkFQTPNsogfQDlNvtLpfNJhnLG0l1ww
 BXhvtFS+umjGk3UNPimiBXswZgXxy4VedcP9miJ5sisFu2fOKcD+E7u74
 JJhvEN/xy+DHSjD46B8LiaVH+L3iPKBCKbSnNqBVQAGt2vtETlpyZU+wt
 DWTHjzlTUMtbaR4zt5fp9DHdSUYIYYipfVfZLcQthgL8LhMvNcHHrhTw8
 zwmlhL2+FIvkxlzbS9gHCbLajtsTShWcEKzrAzP2OZiZ7ki6CgpS0/yh7
 3V5aDxmqErFGrMgRR/nrKIgHyaAvpE1w89fQu2T5R7aT80UIEPTJyH95E g==;
IronPort-SDR: Bzzfi1TBZOGAnrNPAeh44mvSZBHaLIalVi2H503RevSdytcRldeaYZ6YfM+XLibmJ3H1rqD+rR
 EDl1LUTF3PokCFUsKuLPYKKRHMKa2Y+7v9gSeZ0meRWztj3x9puw437tdiYmsgxih/reYrwZhr
 ZRODZ0h6FTuD0Hmnu+WFSCHlPYBGw2YwhS4vwFmNmLTkmOo/6EKoH0fr+SlteLtLX+mUjW/BsG
 gtIalC+LifqaMLIH6Sjj5PzXaQ6kv+yHu1roznxuMWBeGD4pFwQgofUwxDP6a57ew9P7V794ht
 Rio=
X-IronPort-AV: E=Sophos;i="5.75,324,1589212800"; d="scan'208";a="244861903"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 23:53:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADRsZdvG20vIs6czvu/vzYxyelCoIrQs4AXEmJNWwwvPrVOmQcRjwkdNpUQhOrJdbQSyA5olY8TVnHga/UCUVrydw25U1Tb3C1/zqhyOyhD3QOl0xhZZoD65A3jYidi6ah0YDoigyPZFyCMxPRYvA9xma3Lai/Lpl9W2Sj4RtYORlzeTV0mHII8CKc1yQrS3P3yZHA1EvRY5xPrMApQUad+WX+Q7ZLHv7z4xfcvazFFfjLCg0+nSCtPG0cd9eMwPFbgsIonyTsv+47yZSDJ44FZROl/6rXMsSxsmL/ckp8yjE7onlzUgNFlCo/qmJW+0YEpGqDl81DI4u5wzHeiuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyJp9ib69bXsIT1i4W0bImCEdJT0U5wF6pKViPquKeM=;
 b=gwj5odqo8bLHral1jA8dnl80+fwZu3rwNHy6y6gt2U4G+X8HaYZwstxYlPmndKdkFfjA9r6m/B9aTruBbgJ0p9MrYXu6QmaogBn6kl0NogV9rgRKLDY7JvqChwBWdyQbqU74BQFg+DmKMr5X3tZfvCru0vNx+1tWOV1UOoFb9EpmhItkbPd/cqzuxPSSIe7baERiar82UujpGXSb9fVi8GN3ZS9g5iOPIwS4+aaIyUHKs6ZuheUdQuZm5cr2fLMdDZJUDpPv1wOl11wSBWASKOcUHXQ+a3h383LXE2C+Kzi8YJ34djn8dtLPkvlVdTktWvEcqYzy73WfDi+LV8IVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyJp9ib69bXsIT1i4W0bImCEdJT0U5wF6pKViPquKeM=;
 b=c+CXoS8zTc89NS3uOnmXE0MPNvb7/F8R8bDc61REuJPnPItsr/gw2BE/vwWuB3w3kst0DII+KTpafcfA/1Dt5QWiqc1JjMbKqEJY1ws4bLGxMT3yCyAU+aj7OjKLT7T4Qc0CfppW4DxIJRgWrg9MOPn6ntzwaLqQ8NQJkr2Lhvs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 7 Jul
 2020 15:53:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3174.021; Tue, 7 Jul 2020
 15:53:33 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RFC] nvme-pci: remove the unsed code in alloc_size
Thread-Topic: [PATCH RFC] nvme-pci: remove the unsed code in alloc_size
Thread-Index: AQHWU/F9s8xVGH/T8keH5BbvDz026g==
Date: Tue, 7 Jul 2020 15:53:33 +0000
Message-ID: <BYAPR04MB4965D0C92C76B7EA9AC15DDD86660@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200706225305.14892-1-chaitanya.kulkarni@wdc.com>
 <20200707084659.GA26962@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d25da06b-71ab-4c94-5e79-08d8228de6e2
x-ms-traffictypediagnostic: BY5PR04MB6849:
x-microsoft-antispam-prvs: <BY5PR04MB68497DD24ABF0009A566B3BE86660@BY5PR04MB6849.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uVh4vmDl7+xG/p7Kwd3FOlilgp6NDjB2nb0P3O011DfUQCZO8dbFqQO5WHXJd3Dx1/nj8Jul8RIC1StIV7xPh3/ba/qksSRFyDBJbrhMhn4hHl5P+0PKr8ZSeEtPbVY/1aH9SeMTzv/s6rOU5bbZI/4TUpeWxaQ9fKTXX/hNfzcajIzWuxHXww3ymXf71ypmbvoJ3TzRrjUL8jeBOOt5ufPTNcYhVMBpLYM8lByrB+ZUupCQ2yI72aIceDCA1PLPqgKZ3J22w84mG04VIUIobmE/jfeu4XK7HDYN5KLIpiJX3N4pQteJXN9FKD5obfKvwZaE3yER1sF+MjvzbvFL6A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39830400003)(376002)(346002)(396003)(136003)(76116006)(26005)(53546011)(52536014)(66476007)(7696005)(71200400001)(66556008)(5660300002)(6506007)(66446008)(66946007)(64756008)(478600001)(83380400001)(6916009)(86362001)(4326008)(186003)(54906003)(33656002)(2906002)(9686003)(8936002)(8676002)(55016002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Xs3/aFtJfFnWU+3Kxed3cA+EqyWMTG9EHmuZ4stUdxdX215ywJt81SjNriuHlgVNGws+KR+ZzH9+CYMQz8cG8JsKWzMlGEy/Nxh85k/soTjmF/8JkWqezwudXKoYAAG69hRoDU6wthkNitxFLiBLLvceWZ5LdQaSt2EDQ92S31KP8L97Dq8wZ24vzef3XN4SenoBLTAXyt9GpyJDBrgoz2pUGITMvxere2yyOQ/anLpiIjxGq58XhcRIrVm8HIn1tq3r/B7Tumt6w45GA2t+XaCmTb+aA1Qc4sUhxQNQNNKvQXZqAUUepgYcC7yd+Y3IpA3zz4WGR5uNOpbgag7MS8o0oGixnt04H9z8kGja812TCwEm0k9Cz3HfSZZbQrbdo3Zz0iaGBDT0loaNFRmNTEc96i+1s09MuQzYt4G2Y9u6DfYQoYY8QHr8yFcP7qvmrTkDKemsxV8Jc0r+dc30oKqUZ3AcHkoStoseeraLasg=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25da06b-71ab-4c94-5e79-08d8228de6e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 15:53:33.0464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4N+JzFzhQSN1EUSm2eFQuj1Z7vSNyhggL+VpY0kRavJexTCEBuToXiQMTHNo+s3FHVZcru565JpaSnLUKx3y1PqlQblB09/r+MXKtWXSxZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6849
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_115338_096606_356A44FE 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/7/20 01:47, Christoph Hellwig wrote:
> On Mon, Jul 06, 2020 at 03:53:05PM -0700, Chaitanya Kulkarni wrote:
>> >From the initial implementation of NVMe SGL kernel support
>> commit a7a7cbe353a5 ("nvme-pci: add SGL support") with addition of the
>> commit 943e942e6266 ("nvme-pci: limit max IO size and segments to avoid
>> high order allocations") now there is only caller left for
>> nvme_pci_iod_alloc_size() which statically passes true for last
>> parameter that calculates allocation size based on SGL since we need
>> size of biggest command supported for mempool allocation.
>>
>> This patch removes the helper functions nvme_pci_iod_alloc_size() and
>> nvme_npages() used for allocation size calculation and open codes it
>> into nvme_probe().
> This is an obviously correct transformation, but I think the existing
> code is a land mine.  I think we should change it to use the maximum
> of either the PRP or SGL case to gurantee that we are on the safe
> side.  Can you do that instead?
> 

Okay let me see I'll send out a patch with your suggestion.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
