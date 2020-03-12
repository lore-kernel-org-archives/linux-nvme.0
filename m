Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EFFC10DCE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 23:42:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95178206B1
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 23:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VDqlEpkx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Td808AQd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xkbOWRTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95178206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=SGdPEM51y8Stg2AudGDuzGLYvn5sz5466+mpQz7OpJk=; b=VDqlEpkxzdhj7X
	CUeumVX7pu6e0UbJp624aKBdRpaHh4i6rOjL8XUCd4DjAVHZUqtlH86f/TzM+REElbhiSj7c6sZI7
	YL1e8PzfiKTfX7yxntLw0V92U8CMb9wGYb3upahhaF9meiWVr9HnxDT9/3wADq05HgE9ldunnu96/
	HUzEk22IK+sUuFKsPn7w+qTeo2hTUqVW8o2rQ7yfahiGf9v+UhbdlfhBTyk0OfFyqYg48xVLAhheJ
	Efz/0jnWK9tJT0X2m/Agwyu5iHLWTX6UUuW3GugCkCiuWDzT1uV5lWTu+0a9/rlKhDnYFZAddbCIf
	GnubEdYfHbt/OHgaFHIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCXSg-0001rn-NS; Thu, 12 Mar 2020 23:41:58 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCXSd-0001rD-Du
 for linux-nvme@lists.infradead.org; Thu, 12 Mar 2020 23:41:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584056515; x=1615592515;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=d+SOrOVMQX512RoFWFdr2NdUduFnc2vU5wypbCElj+c=;
 b=Td808AQd6Ulaj30/DDboMtbqaXEZ7mlRx7waSnRxv58Coa7DOaUYJTuR
 ZiSSf7mFnwYFllse1c/BoaJQBXzKmeCJ33XqtDSVoaLYOHPdj/usdeZnL
 /dr9UluD5z2o5cL5Ys7QOOmdI5KDqsFePBUvB0gLXcz3rucJO6kR3Ow34
 JgfpUiKv2vYG7QLfW23om7gWxbcPdVCSUWm0B0UNw7Shj0yxNn7d5oO8b
 byJSttGxNK5Hin7/EBcT1mjLXrAdUAg34dqfK6mcGchoUxEF4q0otmQOf
 QNDWjvOmexnWw7q4kexiQjt8nxYGuipDevc+Zsr0BNbISTq4n0Socox72 Q==;
IronPort-SDR: 6zKjlrzB8+Fb4owEKRcK+PARr9sYfBiyNnySsOJEKrUu3W4kPoYVff2N/wknNL4hbG5yJdBQ4K
 xhtrImWuZ5rkyBRy7cBm8JTxWSsoc19eBLIr2T9V0jr/TKBnKM/kdF54EidXqObGOCiGfce3Qe
 1PWbWUDCKFlDX+Ng5hoyxWk6fBfP1RycFEP8xLjeVPvXQuRKN9Er/a0KPuoYgOr9cIPqK1EEby
 t6ri/kryJhBm4hKML3neXV+CbaFKhAATFfuwyUgxziITXpBA3lIbBTLzChHZq3M3TFOPLswlHj
 xOc=
X-IronPort-AV: E=Sophos;i="5.70,546,1574092800"; d="scan'208";a="132337744"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
 by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2020 07:41:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOD6oQ6qTlqVmU+rBxnA9jdbPt1iuRWWic3Z+PG3kY2VSqAtBr26B/cC56gVJnkl+sp+OEh6flK2bb/G4Un+C8lQPHHuv+3+0D/AtcVGfklOABk6vSFc1pNyAMDlSuRbieEe+5UQnSNSBEkv1Wb6xxxjH5w50EkEHDPi4i/RrDQI2wWUHKC+VrYDdulLHw7OnkfuM+oJKX4OsxZ4Jbvj00+drLhUNBXJ6Q/5SAMrpWdTetAIEFzRhGSiu5YqMmNxdM7JiJevQrPKAJ346xsLZrrhEDQxVBfxDh3a6WdOtWf49Yjse6z1ymxabfxYvjaWaGEL19hnP1iVq3zUtAy3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOJfI5VY6uEaCsvJxUXVaOsQhuKr7VY5PhCU7eIPeSk=;
 b=bNL5cZRIAcpbBRcpUrx+n0nyJ1+92mDawkSqehzTr8o50WoLnbK5CupujclKqNNxpdlIf8IMskOYMXtiqluVgLtJNdvIxgo3es8QR268rIJmSi9C+yGIqOgp+SfsxMF5GJRorMkW3HRPE+6XjKdR9N1ktuj5e6BOksPzCvnjYqDm0yZ2j2nWQgzG+arlFCRaAtohXBbgqzxPDngx0btz19QAI9pEsoIyJwQn3+zk+U1hHImRI7IL/TGIh0agy8/XIA8oVkqvYA9t6wiscNMipCrn9mYjoJp1H/DAqyVjZr2pVecwU8eSoKdqieX0Z/ww3eeEw2eJgtrm9uPArk2CDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOJfI5VY6uEaCsvJxUXVaOsQhuKr7VY5PhCU7eIPeSk=;
 b=xkbOWRTUBLFjmgMEy7u7UobjOJo8nHN//PtgyDKvU3DnQMlLA33wv/dBq1eyHxDWrdX39zduDu2WIHP705TMwpU+Qb5qVabftvo7WHRdNbWR1TcZAss9HVCYzHCTi5hSr9AjqqNpbEsYuyJNuwYhT0I69BanNKPHTaDQQ2iCXf4=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5448.namprd04.prod.outlook.com (2603:10b6:a03:ce::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 23:41:50 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 23:41:50 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH RESEND 0/2] nvmetcli: make model and ctrl-id configurable
Thread-Topic: [PATCH RESEND 0/2] nvmetcli: make model and ctrl-id configurable
Thread-Index: AQHVxqpUXzd8VxYIIEalrO1b4yEvMg==
Date: Thu, 12 Mar 2020 23:41:50 +0000
Message-ID: <BYAPR04MB5749FA0670B7E51FF14FC54686FD0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200109050448.5758-1-chaitanya.kulkarni@wdc.com>
 <DM6PR04MB57540A44AA6DC1E2DC67180686350@DM6PR04MB5754.namprd04.prod.outlook.com>
 <BYAPR04MB5749D99EE2CD10AFB322988486030@BYAPR04MB5749.namprd04.prod.outlook.com>
 <BYAPR04MB5749A8956067EBBA427672B986E60@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c21ce7d6-4bf8-45d8-a218-08d7c6deefcd
x-ms-traffictypediagnostic: BYAPR04MB5448:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB54484638E9779FEAEF16E74286FD0@BYAPR04MB5448.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(199004)(7696005)(52536014)(6916009)(8936002)(81156014)(81166006)(8676002)(4326008)(186003)(71200400001)(33656002)(86362001)(4744005)(316002)(66446008)(66556008)(64756008)(53546011)(2906002)(478600001)(66476007)(55016002)(9686003)(6506007)(26005)(76116006)(5660300002)(66946007)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5448;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KPdNXfSFk/84mGI1o1uToz8ixokTWF2RG32s4k5rUha590J5d2YNmHJ+lTFqRoE0pygLuG2fkEKpGxcsuJDaDH2vcZuDmNDjWNmlfs+rnonfZtZ4/cSu8rIYXYkUWX0U1PjRnhvhdCQoFF5Ou29HPDvAw0/doTDCCef/o/0AYZxCjqw05pkDh77ciKNOkFhySFpO4QP5wMyaYjtXwyeZzLl6oj2B4YPQ6GaRpJwmlarB/RTOGNqPtF3nL13yMDPjBtD4MY7+jsn8vkpgTbrfJi6Qv8jxwN+jWT/MCvX5A4VTmKY8yCOJ47SbuXrtmyFro3hlr2SUBMLPhVIg6HD1X40517AyeNavIasL0tax09QnnnhPQaq8Su9bJv7MBQEFUxWVhrDQ9gqLGJsAhiXZ+Ls1LFwCiGhgdDVPJRA2Sqmw1+nklU/PKcluDZNyAqbK
x-ms-exchange-antispam-messagedata: ckmbrcB2VPsZ/TdXmuQc1F1WMkd3bOc2EYGWFluOBkDHJM10XX0tEs7hy7JBRWuvBQeQea9yrIVyqdzK5fNpmq6KN+5k/FHJvBsU/VOpt/D9w/ocdrn0lu/bRkfdoc0rCM3wUdjDyapU4/rFjXgRGQ==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21ce7d6-4bf8-45d8-a218-08d7c6deefcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 23:41:50.3535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nj+K0BhE4J6KkBWIC7oYXGwiojz0qDvy4WbzYtl9jCaH5WOOYruQzn8xxcLvW5V5euKC/aHVl7PDyffv5rh7qUuEGsqyxfIwPTSSL76AaxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5448
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200312_164155_841955_CEC0D695 
X-CRM114-Status: UNSURE (   9.23  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks Sagi for reviewing these patches.

Christoph, can you please pick up these patches ?

On 02/29/2020 11:43 PM, Chaitanya Kulkarni wrote:
> Ping ?
> On 02/03/2020 07:27 PM, Chaitanya Kulkarni wrote:
>> Ping ?
>>
>> On 01/13/2020 03:53 PM, Chaitanya Kulkarni wrote:
>>> Ping?
>>>
>>> On 01/08/2020 09:04 PM, Chaitanya Kulkarni wrote:
>>>> Hi,
>>>>
>>>> This patch series allows users to set the subsys model and ctrl-id
>>>> fields.
>>>>
>>>> Chaitanya Kulkarni (2):
>>>>       nvmetcli: allow setting of the cntlid[min|max]
>>>>       nvmetcli: allow setting of the subsystem model
>>>>
>>>>      nvmetcli | 25 +++++++++++++++++++++++++
>>>>      1 file changed, 25 insertions(+)
>>>>
>>>
>>>
>>
>>
>
>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
