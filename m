Return-Path: <SRS0=vQ/w=LH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AC2C48BDF
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Jun 2021 20:06:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FAE611C0
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Jun 2021 20:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FAE611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=hGmasPP2XSRD2MjdQWdQWulLXywkKWzmBCeh+CF5bAk=; b=XYXp8Zs7tU3AQL
	BW5JEQAR9/2s4OaKMm4XEJmWYgMIZhaAiAyGdC2I10RoBKyzwImCjKjUAljmgq4K+W2eqJBmoD/Qa
	dooiIbReEIBCqKqe+OPxE30Mcr7tvZRJtdwhvZbzoS8aBfJcMQP1KU6Z7a0iKuc++jowKNBjlKi3V
	KJgd4t/DDrkDo8KystCXMj0yEkosz6PuMgI5VjXGfpJSVjQz4SHHn8bLi6IretYS6Jj+O63asHIY9
	TFDdX/0jlKvjWVMIA74PpUp3nhHy8+XUcjc4dvi/EPM9NCkCogU1C2oDMqa7rmC3z4SJweAv2/9IV
	6mazbO7gGB6AzIMkAE8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsWN1-00B7K2-FQ; Sun, 13 Jun 2021 20:06:11 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsWMv-00B7Ib-E2
 for linux-nvme@lists.infradead.org; Sun, 13 Jun 2021 20:06:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623614765; x=1655150765;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=GiNI50q9O7l6VuGk0ECU8dUr6ZocBLiaXx0G/59qonQ=;
 b=WefMlldMq0tuYdtzPzPWUh0xAJDrIoxKPfcXpVOM60NyVEsxLOK9sEVf
 imu00o8exj+54OhaK0Wr2srrwL3VWrqNNilNRxSUlLb2BqIJwJK/ysoBf
 jD1BUU+Dl1zhskKtFsZEVjKTEf1SXd5l/yPqfMlWK6JTvPxfbstUz6BG9
 cGZMnsU3FP2JBZ9OTcBuDXudc4ryYcMG1soqRKg3H9zvy7g9EnUryfW7g
 pH5jnvzQxnGd/A2VfetQWOpOK0CjvkF5xkqehPYkoWz7WK3ut4yg18D+1
 XTf6+upaK76Vm3XeXNq4XkUs3D07cnHLRaTFrIcrh8NM+DFSwX92TqHfa g==;
IronPort-SDR: TKKn7+GRfvq7chDRnFvKmD9gdInMxGXbF666Qzs0cGWYQ7nmOhLV4pu8OLDhXkAbnduO5WlXDT
 hVrmOT3OImaeYWwBY27qQNmXcSVO2Zruata3YgJw0TxxWnApnW9Rj2B74DdoccKuRqre6PWjub
 Rg051q87ReL3FiehUlGJoLQN690N8BjP8N9kIst6/5KTCnMZ8scDSS999Cirvu6HYDj4wwI+K9
 mym3KHA7yQO0V/Bh9iu8Zlv7Cye4la9IEItHPSIkDEyFuafiebaKygTBRtdE8vnykpPFQSuu1v
 l3M=
X-IronPort-AV: E=Sophos;i="5.83,271,1616428800"; d="scan'208";a="172326181"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 04:06:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpBEc1+Z2J/oXjj1SgPvYW1zPOEo0ss4SiWDfAdFNNs5lZJCbcjfoXJlUZ/gseC/WAuRw6AyhtbFerHYNCqbTyuoYnkyVS4jIuFAG/ulLcdPVP9KUaiKvJ5Ypt7lkMO5qOxfMCh/GPxwJKF8/AsOaTrz+2z2BKV4KylYq0r/kPg2sNcfGmPmtuiXJ5Sd0oxJ4WhK0LRKyUeXqJpKKRNaUXxwCSa0MxpuHHMkAYoiWzXpIvLuz1vSTfdjg5Dn3mU/yKNfISFt3alk9Fzyrpt1VWqybgfLHTMNUKdzU/4j1BTTZnAXQa3Eeo6kHwDFl0bIc4KB76KZ/0Q9hsn1QJmd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p65zkVMFcFNUTqaKbeMvwuHTwzy7TV7dVEGfzKoOD0E=;
 b=h9IEJUo6qM6nuj51B5USe453ZwGp4FW6DQJkB7UmR5OOQpEivuUB5LwibReOIWyrf1ZJbsS+R69OlRvGXfyQQZGwcjt23a2/do2BSLsSLNrgGlKxrGOsJjHUVdzwo5rBiYxeQyfjjsi9xZBnjfyIgyx/LzD+qEshxyCycu6DHMt+I+pyjcQ1URzBVAiyaGoafzAagC7eDP/9Do2+cFAGecwUhHnapnNFD0ZC/vbsjDsgAUf3zylMtE1s3+Z2JMBs+vzSJnzOs/lvbt9+hlCDhW6qiOVVCMxjPEmb/pZJuu0sFslNiOlA+fQ6W3JzK42QghRAfWBRvZLZjUNy9Pga8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p65zkVMFcFNUTqaKbeMvwuHTwzy7TV7dVEGfzKoOD0E=;
 b=eGjFsx/N91L/CSPM0Cas0ieryLcmuspNL0i7xf62qnGIIRZm7M7l1CDxASeSadknKlVcB/bCaEQ+oyTWTzjIHK7fq4KSQa78gtp7+uM6I4FOcLP55okmfU/GsIWYNMxa0/wUfTVBbbg6stiMtZ3SavUnc2E2XuOlJ9zsFvV3PfU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6279.namprd04.prod.outlook.com (2603:10b6:a03:1f2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Sun, 13 Jun
 2021 20:06:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.025; Sun, 13 Jun 2021
 20:06:02 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Thread-Topic: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Thread-Index: AQHXXaK3o1g8yliZMUm7tWfZRJ//BA==
Date: Sun, 13 Jun 2021 20:06:02 +0000
Message-ID: <BYAPR04MB496510FC8546E5DBE51D765F86329@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210610024539.28875-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB49655A9B821FEE29D7A89E3986359@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210610074546.jyqjalpldii6reg6@beryllium.lan>
 <BYAPR04MB4965AE59EF50A714B12DF42886359@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210611091742.6iefvwlxjlm6oiae@beryllium.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc94f777-e293-4908-b6c5-08d92ea6ab9a
x-ms-traffictypediagnostic: BY5PR04MB6279:
x-microsoft-antispam-prvs: <BY5PR04MB6279232D2FFE22EF0E6F4F5386329@BY5PR04MB6279.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7tAaM3yWKUAnErz6erhXPhoxm27ZCGcqRLdjyjNGex8VfafmTkkTqzVDClXZ25lCx+KN24xDdvQ1dDCdWoaxqQ79s1eZRoxgk6DBejLrG6hUnfMNecw/YWSAm0xlf15Dss1x+Om3uu9Yho+7eT5OXTDUGkTwPQP1L35jyezz8tOWBuSITsKXjKLwDBzx9aENuQTQtQ0EqeW2Zp/I/1B8PdSZ6d5i0DxXMADNOoq0jYuKP0Z5igcbjTCvSlRhsEwZiRgv6RzSwRSFW8C4IHJHgi77oEhfu9Bp9cAJmSMQgnP1eFAvZBC0ELmfS3g3pKSBXXBOUFpY1LtpruhbBFOZR0Ls3A4+f2iYdkaBAHvlKhGHR68pQ/5ecHDGtlCm3a11deaLM7hJ6A8bO9eQCDAMkm7rN1pY8XWEvvDZBJDcdKBg+YPA+t3wsGmPH06fPNCQFU8d4YxSPbFrXio0qVM91KsXsNBjo+nZvZ+W6ivReHNOg3uZGLlFpaV7wBitpsT8zm9hsBHq3WSaxQzJgG3OKlBHVLW7UaS+932bhj42IpqnjkTkWebhFcLrhq9vAWhl0UML0pmW7y7MFwr4xccS/gelEVO6gWJscMK7LNO1qkY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(316002)(9686003)(122000001)(2906002)(83380400001)(26005)(4326008)(38100700002)(6916009)(55016002)(33656002)(478600001)(86362001)(5660300002)(66556008)(6506007)(66476007)(7696005)(66446008)(76116006)(8676002)(52536014)(8936002)(53546011)(66946007)(186003)(64756008)(15650500001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FO9Szgc+CQEXe0J2/8odvQ8rFRWgnXZGDhFYdCMthgMer/QMjbjdH9Qp1sya?=
 =?us-ascii?Q?KhlhAAKHC0ecOcrBJLfGZP7hBFqHsdKFF2l26UTZ08jtX8DQBbe4svLUK/jX?=
 =?us-ascii?Q?cX51oKuowXA88xYNoJx30yZKh40dP7ONL5Vy3UtsigOXDk/MCjAuWSAte24s?=
 =?us-ascii?Q?x73B019yAaq00NReMTb7NzjK4JWfAqCPJuiJhyW33sUofrqY24xUzBBIUx7U?=
 =?us-ascii?Q?UwxyL+VGK5NgZzajwChyOZ/YqnLT2DZkg1Q82CiKmKIR7J3Sld/AdApe9KEx?=
 =?us-ascii?Q?/qp4p9tIXQHoq5WhwtcR/VZD72qNWRc8W6xa8nCsGW3El+kge2rXk1R3xyuq?=
 =?us-ascii?Q?bdZTS2B8IczPs1ROt5h4/JTTQLJuK45FUJA8s2rosLqgvnXygmCPdMoYMDAd?=
 =?us-ascii?Q?9n7ipFpcNiCEdWZIX3tRM/Xf48jrISL3FbSEiO/b6eA1pIDXi6+JV/rOmswB?=
 =?us-ascii?Q?cxFwDp2naWlUhyTOq0Gtx8rbmuIC2bI3mzycvFlIfniIgz7klmJjEGQUv6Ki?=
 =?us-ascii?Q?Tp5N1rUfsDR0V1802riqAH5EsPcjQqdzHzVU0YiylYaLEHbQh/P8f1aOhU5r?=
 =?us-ascii?Q?AvAha8/k7YrPs7Ldfrs5DIll/3bMgyRePQMpV0nvyrjEdJDhSmX8IiEsySX1?=
 =?us-ascii?Q?oEjw8bAMNpZtGRoTwREK469Pw284OZP+c3cljlW3t+gB5FrnzTGt9JzyXOU+?=
 =?us-ascii?Q?CF5PIFCNO7ZJ9bQu5bTDlmHUMs3xhhh4blOv5l19e5cHMTn4ETRm9MRtNggE?=
 =?us-ascii?Q?szlzyMyk1qHUKZ3t/P7OvmlUPCF3wljSgDLmVaGh3Pq0/UwnFhBEJUMMXtGO?=
 =?us-ascii?Q?PDOE/ysDadGcDay+4WC7LVU7ZbbXYoBOR3oMvz5O/Tphj7YwcJgPkqE6QsSl?=
 =?us-ascii?Q?QZfFWbbjsZ3zq1ElRDZ5MndX0SWzUgjZb/F+FSFYtOj43siaapL9cjUn4Swv?=
 =?us-ascii?Q?hfO+XMm2wWeJEMIsImmzox6lR1zAXrVI7N7z2hYtpgd31uqdjph9NuykZbOi?=
 =?us-ascii?Q?MqYXKhbGHPYscc/K14D7ZpD+KMU6U6cetExMko3dx3C5x2vAw2U+SyxZDO9c?=
 =?us-ascii?Q?u128ykx0zoCKU6HAYaRyyYV9neiuXagm/c1lNrjcaP7VFHZUuCLdjTF+aQB8?=
 =?us-ascii?Q?4wN6jdbaN1lOLTGbT6zC8e/S1LULr4K9AW8vPbcnZR6Z53ccpBLebLy+Z+s7?=
 =?us-ascii?Q?gH5zxvQm/7UDLfAw9x0dfoLKlX2udnuNHdDh4yD6oaUOuHS3Lx7r+TJitrhQ?=
 =?us-ascii?Q?BQkRX+s/dgbRVyFT+1Id7ZXDR2nMjp/E/KfshKNlCOZeKGGWTvmNvRm3B8CA?=
 =?us-ascii?Q?3nBWdSlMEegscF0ehx1GsTFY?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc94f777-e293-4908-b6c5-08d92ea6ab9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2021 20:06:02.6519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FjZHAax0WuSXVUG/kkyGcUWezzNNy/0jT3CJ5TIlx1Eo/3Wk09y1tHIhm/o2L/JCDWxxp628tdkLigcDyX4oyOqlEHCwkd1+x78ddsItAvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6279
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_130605_617808_42377CEC 
X-CRM114-Status: GOOD (  18.70  )
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

On 6/11/21 02:17, Daniel Wagner wrote:
> On Thu, Jun 10, 2021 at 09:01:14PM +0000, Chaitanya Kulkarni wrote:
>> commit 1368a1a5e7566d726bf74234d05895c3f0d54690
>> Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> Date:   Wed Jun 9 20:07:00 2021 -0700
>>
>>     nvme: fix the comparison in the mnan check
>>    
>>     The existing check for the valid mnan value will result in the error
>>     when ctrl->max_namespaces are set to the 1024 from NVMeOF target since
>>     !1024 == 0 so it will lead to next comparison 1024 > is->nn which will
>>     be always true untill target has 1024 namespaces.
> The commit message doesn't make sense to me. NSID is not limited to
> 1024.
>
> From the discussion in the other mail, I though the argument is, if
> there are no namespaces on the target the MNAN is allowed to be
> zero. The original check assumed there are always namespaces. The
> proposed fix drops the first half of the specs statement:
>
>   ... then this field shall be set to a non-zero value that is less than
>   or equal to the NN value.
>
>


I think we can keep the code as it is on the host side and fix the
target side.

I've sent out a small series to fix that, see if that makes sense.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
