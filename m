Return-Path: <SRS0=qGt+=JO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E652CC433B4
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Apr 2021 10:40:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE1C610E6
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Apr 2021 10:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE1C610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gQ/O5nEsM943n6GGPmAwMQcmYXtt6bGIHMQuu9Uk9Xc=; b=WRgp5ta5rKbQ3oZf32Rli/8Z/
	tsOqiGkBo3a9leaOSmGmy0hFBufifdCVnxKCNNH3i5wXqpiW3QhDuVOpjEyrx7YZNYDHyV4Hhleoc
	tBEvqmjKlQb0x9S2LnTe0JyBkeDqDRREfQ2ZbQtJm2WqRvRBIgMB2/n2Gcn+Q/LSnoT8s0lAaZKOU
	x57XlzAK+3ZWESxxUqfTirt8h5ZZJsF/DNt7XFkRrZ+HfjcxDYx46tX1Bw2REgByAcRpFsLxLUI9x
	e94RYQlRJYC1ygmvKaW01WiV8tD4I67TI22kmRbJXQGVw+eGpdtDfeFcqxr7emw9rgno398GoguOZ
	OKHcxj7Sw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXiMu-005232-PS; Sat, 17 Apr 2021 10:40:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXiMf-00520y-I8
 for linux-nvme@desiato.infradead.org; Sat, 17 Apr 2021 10:39:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=; b=fUSkevgLbm+1xeBos4QWPVrfUo
 joHRGbUSIwV6Uei/SsTlvRNFBlZn4SLKVsHNpUoFylhm7WGD3tMXGU3DP0nmIKMvIIV0IBC5aNLm7
 GB1/Zl/Og2K3yZQdpmsbGL+drOq0QsjXze1KrzLnsIKG+jWlnh4oFiNhTncWcKdzzfstYkXZs8Yzm
 nE8YHvKwlvHtEWvOKyuyhtvYM/a4oQ/HD5SlY3Q0OJJm05OWTbiWr5lLgvUS7FSNBTx41xboXWwAE
 T/GQrEm0BqmTFOnj96+4wYae6qk1oHcxplDF0ZMQmB2Iod9P29Uei5Z3EIWvjjf3U2d1ULRG2IRYV
 N1eIONQQ==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXiMa-009z6F-D0
 for linux-nvme@lists.infradead.org; Sat, 17 Apr 2021 10:39:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618655984; x=1650191984;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jo5HYG9j0drXcc6KGKroV1ddJheOs2XjxGCf+2O925LKJpeI6DBXxSZW
 zsLAAZhyFv+vv3guy5bGnrsChCCsgrUqSlmtBvAx5pIk6jd40bDunYfKu
 kLEGE/EdpYPRoehbJk/A7wsjQJClQceHeXRD3VqO+trZG1V1CIkkUvKV2
 5+17ZzfVyLjI1NSAFpdwn9WbcRBxLeo7sdNlk9aklj59hST7Oa8zZNHqV
 qPpVZi/VqpWCbUQ6lbKwTdOAfTnW9mTCaVcIiAx17Xb6WqxyObnoSbi3Q
 yrtj92qPzZkymvoUCLPpifXAVmI9DZFcwe7Oa+xXLfyGUeKLl4ScAq/Se w==;
IronPort-SDR: wfWiJcAUiI5ekMHeGwTMIGtZE4gAELrZqcXrFvHrkgwrd4L8pigGdWpIaJxb3x3XlPewXJqBFA
 Fg5cPNDkXNl4v2o5fTT5297XO2LePf4+Tt49Y1ojY/NOxWwuuLy8kAKFxmOVpok0I26zCGus4j
 j5HnDtFIwH4A0nWPUtuBqqITfwZ5NHft/oTCs/UCQkbHsyKKoyMkbj6TCS9iCLhejrfOUvHwtw
 GQcCUDgCYk4O1qoc8J9bo8r5Z/5nbQapaCMhvSV5A4T5CVmLb3pEN8asd27JOm2wmq3M14QG4H
 eEo=
X-IronPort-AV: E=Sophos;i="5.82,229,1613404800"; d="scan'208";a="165238389"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
 by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2021 18:39:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WB6yELMSAjoIi9mNuhvBBJVxUOpp3X2ibvqdGxizj/uJ7siU4IN0Ho9NA030/CmwyweDoPCH1uMvKqmwoAYw8SogEdbOCN7/FAMVF4cNl1CleRVz5MQnsamdpBGHB/zB3R3RNBBunVbfNLs7EUbFFoaZeWH2WuknFJ02H7oS11EOqcB4Yb9Q9f9VXbRMb1brVJjTADrLno/EmZc4xoSlRut76hL+Kos+8bOOjo3k/AYJRmLutAC/LYbn6vJoaul3TIf/aUNFluWu77wc1/9zgNtHsuKAwVN3Qpx7QmEWFo3vBT+MGC7xuFPKdOY7wFXJ1jlMmN4CuzFaDKiU2pcdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=SroFVueQxeb4m206krQMdu2lBQLXHMI7fFbgRLpeyTphfmVB6FhaqOL+oECYMbE6rok79bYDQvwGgSDmTY++yGNOaPKSRHb8UApMPwMtNL8nhHB+rylIVIeDnBJaicAO2wCo0pXAyQy3AwFmPVeH29GJOJQXJU5lvyOH5ONXYrzEZrnzhFIO4CwNvSvSf8gM1Dzs9pYruVz2ucyCMrChZsSfWAiw8LTWQzJq40XPVfoKeqAFSvXjkcfH87ApPvTNGNbQmtDf8yGNinXJ3ew+bBYq+3N1ncmz3NcV+eXPIKMMrOCEU3tQCWe9ZAJXa7VivcH8IfQYEM1jmw5SrUaZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=zKTHq6OB7tgrKXYpHvu9Q7/xPZGZSlYUDQfUtmeNJ9Gp9sGUB4/aZZ8A3qwXGSJ7b5qnRaE32FdjiNxfKEbuNsz3f8uA5TgHImBaEs3xvzSPpHj+6wh+7qMc3QKOpjSttLLKNx+/TQcyIAtL13UmBmP5DOYxs+IjP3qKFguk9lA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7192.namprd04.prod.outlook.com (2603:10b6:510:1d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Sat, 17 Apr
 2021 10:39:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.021; Sat, 17 Apr 2021
 10:39:38 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "dm-devel@redhat.com"
 <dm-devel@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
 <axboe@kernel.dk>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2 2/3] dm crypt: Fix zoned block device support
Thread-Topic: [PATCH v2 2/3] dm crypt: Fix zoned block device support
Thread-Index: AQHXMzIRa8gn9aDid0SQEsDAmMromA==
Date: Sat, 17 Apr 2021 10:39:37 +0000
Message-ID: <PH0PR04MB7416A8D3A8A8BC87EF790B579B4B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
 <20210417023323.852530-3-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15ab:1:4419:a77b:dc28:73ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31aad4e9-b7ab-4ec6-480a-08d9018d1989
x-ms-traffictypediagnostic: PH0PR04MB7192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7192B82EC4E8F818607E0E069B4B9@PH0PR04MB7192.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kS+RuRx4BjooxoHQSS+CLjWpUsv87N72gRBWeaC1M8ORapu8isHOFY9tGuRLz/LO9K7InojTlO920l6VL1SLlxJMd63Rqh5C3dwL4m3mqIXFJD94UurS/PJyzlszof7gOqrITWUHiKZ9cTzSe79YeR3cvar4nefyhb8augySbl2uqW3XqU3Yhd3Y6b5ZiQF7zCp9juUG81Q15P9TLssitlxww0quhAfRWIef08MmL7m4uj4694RrEno0rHfQF1ba6SuohAN86wUE11zfcswTvy9teuXA3rmUuHvySkWaC1BEsnEH8WUrtKmKG6JIlfXHkgHrcEFqPcrSFbJomabvEp4zwwUmmCHb/uHeo4B36yMPCU09IxNjVuyQiagG49MEEorjtpp0zmZ+htL5991hKMXVGmInYARBKA/vn9lqAiZ/e7W/GYepw3MZf3czPlNQQIczIwBDDIMPh2dh8cJU+vM6wC5kE5qsGIkAjN87DNUkHtdHLnGjhxPkli9rg5+TBKFHR0O1Fu2WO6rxNK/0skTqm576LCk2eQHYPyJDyu9MSQtdJ4rznrYkWPbHwR2HQH028BC70H9Wo+45U9B4oUC20w+/qN9cT7y0bCrU+K39E0D2FA2CRcgKbaGftmpiKVn6thqP+zfwXZtHK6CO+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7416.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(71200400001)(186003)(2906002)(122000001)(316002)(55016002)(86362001)(478600001)(4270600006)(110136005)(19618925003)(5660300002)(33656002)(52536014)(38100700002)(8676002)(66946007)(66556008)(558084003)(66476007)(66446008)(7696005)(76116006)(4326008)(921005)(91956017)(9686003)(6506007)(64756008)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uwFyg0DE7Ef4J5NDnJD0/2tNciDu1zqFowlGRXi/BwC95Vi4wPVCayAUfjDA?=
 =?us-ascii?Q?jH4+pFXoQ45ar6Lp4265ermEgX52fZ/qEadcf+RqncAA6sUEceQ/MITFAkqv?=
 =?us-ascii?Q?8Jfo034yRgY2Y02Q7yl38qvO85vPMfmn23PFHwyejOGcCS6Y6TX+qwY10bhF?=
 =?us-ascii?Q?FCtyrgS09RIhenQ5b15IuvjvwM7gOHtp8SBFTzFIByfS87mgcoY6o1v3gmri?=
 =?us-ascii?Q?u3Tjvv7wAfPa6t43vUIAZrfRpTiMv7o/urLKb9+/+lpXToyF5EyR3cukKhVa?=
 =?us-ascii?Q?GWuE7ADF/QiAdM4+X6fzHHQsgm/mbEhXKJ22R9V0axWpYI+NrCRHvaFSQgsX?=
 =?us-ascii?Q?/0x5WpJmmFA0+XKK7ThKiV+ZhZj0bkPtFjuBldD8plThSMroGoZ+WgmgnIfJ?=
 =?us-ascii?Q?9j8Phdo9PrP2nt/8arhDQkEybyNeuPdNAwGRQ/pyrLos2sqwnJ2zFRgXxYrI?=
 =?us-ascii?Q?CNwDOjLgVg5gt+u/0UCWFB56aWoCCFTfoAjk/hu0MlodjH/H91VuVF4fE+n6?=
 =?us-ascii?Q?+PtXsC5I4s7IEd7TUhKTzJhmeEmwBhyo9Zdj8tWvoBfSM1lNs5v1RD5EH/xH?=
 =?us-ascii?Q?ZOWD6bpk8TNvpskVM41yZluba+dqLZGXvDU+es8rhf6NS7wl2++6LP1DfBLR?=
 =?us-ascii?Q?TolgtBX1r8qEDIPan7ARv1lp6Gdln4uQVvTTvRBYp1pknwzneYF+zarC3oU4?=
 =?us-ascii?Q?79Un0zGKCojwXycLK7JV0RkR03KM2IRHLsklqudiHDqP2qi6KTFDlEK3yhi9?=
 =?us-ascii?Q?h0m4uLZoI933acXFMOLqUZie3le2USVfmTI5RLqqVpM8MGSCdidSFOAfImsM?=
 =?us-ascii?Q?zCT4CcVsw9lshgWsrB+D3LBhdflZJfCjoz+WyCe7rlKpo3YBjPF8jTJn4g1I?=
 =?us-ascii?Q?XJKoNsi+hVGIj9tWrB66t/9NbagLYlaUsMNUffraSmUMojeGzZTb9VaTuqV9?=
 =?us-ascii?Q?lvTdIXhQLYQ4qeckueR4gGZC3ThhWmY3g7N8kRrotByxowzhJzxySyk1FJAo?=
 =?us-ascii?Q?vDKXv3CPGPeGQCkmr4Gn4anQQZRghhCdn4AOZsDFPE1cRCu3Xjxt9CwSgaNR?=
 =?us-ascii?Q?fcqBfWIIzV/U6Jv3ZBkL93mQHzzV+dlEYI/eNL7+m3tCtVr3dW6Rrq2+xeSp?=
 =?us-ascii?Q?iTaX7OTFZKYWr5aH7dRdpnAc+ZI7q9Q04JkGEA+mdBA0OjR0p/1v/h0kiIE/?=
 =?us-ascii?Q?faPpYCMxaY+dhfAKdB25p1mWLnTqP8H8bWjRZUMW/Z/S3GyXARvVb7QWhx/v?=
 =?us-ascii?Q?iAbLQix5MkkR8Qs+UncXQk9O0FYys5aVw8z1WhAt9Wiv9eDay1K4BFOSkO9T?=
 =?us-ascii?Q?aygbCOmlkcsRWx48YJLMNu56janYFlFbGYmxtvLqqHtjlboW82h7aAkWCBuw?=
 =?us-ascii?Q?ybjBxazxXlUZXPvfAltkN4z00DOs?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31aad4e9-b7ab-4ec6-480a-08d9018d1989
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2021 10:39:37.9123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZHY+K+S4DC9jLzj42Phy6ZWBExplPEzV74U/nwBgeSybmWC1Dl7HSE6cjiC+NTjXhR5Egv9hR9JbRpfxHffo1zePabfBzk2WqWyjwpTUeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7192
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210417_033944_558292_FF0EECBB 
X-CRM114-Status: UNSURE (   7.72  )
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

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
