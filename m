Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABF8C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 18:37:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A2561423
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 18:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A2561423
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=S+6PUMUkdzLXfiWe/NdfVpcy+KXnRUPbDYcHBHdruxw=; b=LXQa/gWf14t3O4XQqAiYTX0wU
	uy4XwBmrcYHfajOxcZpmblHbHmlAACTmNt7QmNd6qdCjSRzi1FaWUxG6HHDeOm2vkwL//QNsFEAwC
	dFCSGpxWvR2nT6CkTTG6NW1Hvg8fgx8kj7jmx/v2xk0QQVRQwT/DyGDkYl58b7WPiQeX/cF75AXdG
	lUaXEfdBJQZmpUbgY2RIRemkpUxk/1JOPgq8LHsmDmG+H+UfrpnhVEqHm8roY1Zt4Ghsc8nnyNN5K
	gpG1jttP8Pv1AWAxYzz9+npq8JcyjpuTgpLvZoL6kBFnttqrwoBY6dZqXTd8GmYwuzA3NVcYGPvN7
	QSeLNXdCA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbp3v-00456F-JU; Wed, 28 Apr 2021 18:37:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbp3s-004567-Tj
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 18:37:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=MZuvZ7sXLfNnrrr76uVNwldIlG9GzZxFvbs8JFved2Y=; b=sJloVOejwRECjPis9gfhbnZ/XH
 JOYU9TAeMqt6wB8lIQKTPJEnB4C/MA0wIELIuD4R2yZTPtCrHdGxFkYqJLYzW4Dgg5szHk5ppzlKl
 8gEZS/TCSd/SU/FkdysH8GjwGf0XpYv3zAVUVop5GbmEk6TJ7nYVBZS3tAWIznocXUCJ1yXC4NYDx
 pkRhssUQITYbymKrxc2kpHbQ1vGLBit/IeYZCWlSysa0qR1RZ8Or9qCe3z0pmG9gRJsl9qZnoB9rX
 bPpMFkhqbIejWO9mP1HEnPvZ1q7MXgHq7vmhvLMTKZyBkHVSA+ugivUYSVv5fE4dIsMOjY/fPtPBL
 suxNZLug==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbp3q-0007EZ-5Q
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 18:37:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619635040; x=1651171040;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=MZuvZ7sXLfNnrrr76uVNwldIlG9GzZxFvbs8JFved2Y=;
 b=e0skHK9ssiJOLBaouMs3zskHrqvK7emm8QOxpN1G1mOWvdY1a1LBWUO3
 Jez/X+rA6TxTF/NesDlXYMR94+YYwvpoykZdmKH2uaeTkZhTTwQPunc7V
 kkSByWBc+esncSZl/M0ENOeo0jGH6AxR/nWknmQhydT4msFUY94vO6txY
 buP3TeNVEzfIyN+mvcNBMuZ95BxHSgGc1RmnuYFUnYWgnDduwgQvGR0vZ
 tmDyhlc7GrhJGRiSDiWl0pA/PeLGIjDfIwW+HN28mEb+N5GJGE7D9NXnI
 8N75k71HlfojXu/88anip0ogqg/wlDn4VQeLvfGZsjgULWFbDAnbqMYY9 w==;
IronPort-SDR: 7O2l3ij4wovKKPSGK7oi1TUssNdOuOoU0hXiHsp27apLPAc0RhFr0+pRPwf/7BmhmeWpUEbLKZ
 xUHDoCgDNPnoGrGJA0Dd3XKugnzrzh6bpcm3FQd9gHn8cj++b7FNvbTknPsSlrXwwtydNOnuHf
 RnThKi8Y6LeRLWO7a4FeAlEXHEFw9k6qLOqXlOUvo+kgN+zpzN3FPBkwQF0+DWzJRD0glNlTZc
 eHFa8Hs5L/UV/WfyUJiuWt9flLlF5YpH9YoQQBxj6IBljfN0QY9Cvva2SGa0AegdAMCy15IuhV
 Ys4=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; d="scan'208";a="171106237"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
 by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 02:37:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbfb1xX1R0ejqYBpm0Ois+WVwe9U/R1tPHjER53i1ekjKP6DSlmBdMKgo36HjRtfrrsTyeoBJUXw/a5ymFNHwY1iy0npXE3EeuV5LWebpq8iePRcVp1HfE9ZuoQcYPRA7mPc7lEXEhJDm8RZ8mDxwt0BYA3TdgAck8J0+N2z0ngZE1L4/uXRONiMJxXUA+TPtTO+3IEN031IetisymfAkufCnkyCXVXWE5Wx1vcKz7583iraiC2j0XQRXEKGpVkaJgGfVa2UkxHnBxEYM278k+hdEsGWEeDk0uCX5Wf9TaG5kjRxILK/1IjShSNozXfkqgF4mJ4HG89DqZbwS2P1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZuvZ7sXLfNnrrr76uVNwldIlG9GzZxFvbs8JFved2Y=;
 b=T1YXLEOM34vbFCVMm30EVCsmCy4j+6DCITopRiImVlC3pxTDiKx8XT0FrBPGFlIlHH6MdAnEoF/kRcy1tTGxuLrodC7H0UAY/e3/I7v5yPMP90WvzlPk2tIW5eHV5JnF8X1sNQckm/sYrag0ChUyPlBtXLJd7vXgh/B7St+KqwQ4fmye3HIRfVlGe1eFzUTyhnoi/OsE4FA04yP7BNr/1XyzhKu7Hq8BLzNdJBAg606Vg2MjDFGFYKW6xJlRRnyS7fRqpI/eKPhEe+CNp8FtveL3ZGE97Esc4KT8dQEzsl0EYYLM7po+rcOO9HQABwPY5RPKdV0WnBuk3Dr5WYdvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZuvZ7sXLfNnrrr76uVNwldIlG9GzZxFvbs8JFved2Y=;
 b=gRKV0myrrq00qctZa72Vox5FF0oxYQ++LxJXrVOe4wM5L4CS13k9CO/ku4AqbboEvXZRtHB/PCVq6lVNpY0x88syL80KUgKiT+YU+0bdR9LsOzDAA7CVaYxWNcPWv6hCUZtFHFRi8XoCNrJcrnQJ58sHdkzwzahhwHcdisp3Xzo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3783.namprd04.prod.outlook.com (2603:10b6:a02:ae::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 18:37:18 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Wed, 28 Apr 2021
 18:37:18 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "wenxiong@linux.vnet.ibm.com" <wenxiong@linux.vnet.ibm.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "keith.busch@intel.com" <keith.busch@intel.com>, "wenxiong@us.ibm.com"
 <wenxiong@us.ibm.com>, Wen Xiong <root@ltczz405-lp1.aus.stglabs.ibm.com>
Subject: Re: [PATCH 2/3] nvme: Add set-feature(0xb) in persistent event log
Thread-Topic: [PATCH 2/3] nvme: Add set-feature(0xb) in persistent event log
Thread-Index: AQHXPF2EUPOtGwKfLEuO+8/5n9kB0Q==
Date: Wed, 28 Apr 2021 18:37:18 +0000
Message-ID: <BYAPR04MB49650C1E74A8311D06BEADE286409@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1619459538-3998-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <1619459538-3998-3-git-send-email-wenxiong@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none; linux.vnet.ibm.com; dmarc=none action=none header.from=wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fbc5c97-fcf5-4ae8-e670-08d90a74a6e2
x-ms-traffictypediagnostic: BYAPR04MB3783:
x-microsoft-antispam-prvs: <BYAPR04MB37830D59F8DFA146DA7DA33286409@BYAPR04MB3783.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fYuIld5oxRRL3oKZAwIcTTz/kJE7PFRbozM14GIexXuOv0lFEis2vX99WJQch+0sDQx5GsoYnZFzJfy6rHd5nnghEMBiSmArbFyArHEpIFE5ZBHR0SP6tmk5OLuub1P4/NS1RPxbUi8NTp7Dpmo9FYy6GZkr1HRgQJ3Ik99R6vWU4RhUmUlVGPIrJR96npiK74ltfIIHm7rW3p3eqyN0DFKtC1xy4lAuG8j75mMLRkEu+aLPEErSmb/Nu65GDNpnlIzvBjwO9B5fd3bwpGb52T4ezEHHv7MQgTFB4UC5QSfWlx3bU30VvS1t6nkIBp4/Nwh2QkR/KSyPB9rxcJKQDvD94RyFfSCpdEBNeb9IVL2Pndb/jZ25E0bczl9eBAE0gs+OF4AsQLB7MWxgHm/lM+GJtXvt/TLw/ih80lwGQnFfM3cqAIN+KZng4P5v3bfE0mSzhOqMVWK2uyM3TjoEbCpUqz1XAuGZy/2lkaROLvsg7IIOcxW2qL4B+druj27lIkHjg5fAQdQHff/zPyIK5Evx27HhmQnkYwnK/uCHvtqZDjrjV67o7GtOtfEniYueyO/e3qhSdsli7k2pGz07tIWzCuHYlHBmXWK7wgJK3RM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(54906003)(8936002)(71200400001)(2906002)(4326008)(52536014)(55016002)(5660300002)(122000001)(558084003)(38100700002)(9686003)(478600001)(53546011)(26005)(7696005)(33656002)(8676002)(6506007)(86362001)(66946007)(76116006)(316002)(66446008)(186003)(64756008)(66476007)(66556008)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nYuI68hyOXhEGXa160vPpM59rAODAjizxnwI5dEtrGyiiuWQws7TTL/gBOIL?=
 =?us-ascii?Q?a6uo5UbLbDmdkbL5HP9j5zjYcwVGbOmOEzPx2egSeBZhvRFzmm1IHmX0dMXf?=
 =?us-ascii?Q?xk2N26U1IsxlaR0uzv274K/HGDO51WtkD50Fmf/O+NAYu9omeHzSY49t+epo?=
 =?us-ascii?Q?6nXmgGt5ZiS5LpMSAj6yQ6HVHfHWdrHzZTz0kL3ufu/+ZrF1wyqfYAsPvOoN?=
 =?us-ascii?Q?FhlYNr/BzoH/pAIhZzGkFrR+ZRwtS4lDmmeqHCYxZxmwCPQyoFVEqory277K?=
 =?us-ascii?Q?PIhz77MASh+6H1UUTgTinfZuohyEroXHZ605FYKnRJYmAQe130CYWJr9fiwm?=
 =?us-ascii?Q?GaxpWYiDIWpa7UeNQX/7fkze6chIJOCH1eL3ivttW1BmRwEGZ4NbMXUILyUx?=
 =?us-ascii?Q?uiTsxyR58l4SPORjCrEY85okqS53ZV+bN3jAUzPaoufmHc4des2SId3EXrXz?=
 =?us-ascii?Q?we+5Sr7dfzQaSeV7pcP+oaK6QjKuejGmfq4lsZ94QHGx5xuU5tp6g8mozB+X?=
 =?us-ascii?Q?K5i8QfwSoU6jlx2D1ecJMofAc45x+y5lrITmuE2rnp3PoYLvtCUGYHLNdem5?=
 =?us-ascii?Q?hs+dhsl38oOWoAGiPYFlsPQYizQwMjxO7OwEMtvCtS4DrN7X6P0fqyLHvEnI?=
 =?us-ascii?Q?rHCjtwL7/ThsbWISAoKUdXIG+Qkgc2Bauxlyfs1weduBXoX3iaZPj5foycz4?=
 =?us-ascii?Q?PtdOeWkJRykhaMq7RIFrx8dn+v1+PDjNZAkeQN1MghLN6tgBMJ1LLfc7SjsV?=
 =?us-ascii?Q?61lAzZ5bVuFHn+/Vz81vn+TUgKUfRPaOMx1oX9XUBpdQZL4mIf3Z2mWs4wS9?=
 =?us-ascii?Q?wZnxOvA0LdXR/8WC6Z0NacCc1utgpySWZ6Bc64C6RYRpPNZMuWBoHejGMpKa?=
 =?us-ascii?Q?QuogzEnDDQshs0zWdr9n7kewdvYKaaA3vcGHkLoNNEkF+K2aB4jRVF/rE7/s?=
 =?us-ascii?Q?ZmUcgW+ayuvTqAixWELNU4fsloK5vGHVbpfgHkGnVonGAJJ4X/d5cUxRLnpK?=
 =?us-ascii?Q?Ludt+VSN37T2oeKmfBNypea9u+1LyOixoaEh2DxfKdgKLZub31VOiwTiG02e?=
 =?us-ascii?Q?loLXdAaJQigOsr3nvWt+Cvpa1nYqKZ6rsGK81lFMdn8lP9RsM6pWyxWcXV02?=
 =?us-ascii?Q?p8N/mUrlZeHl9YqM32KJNF1mPd76DNzXn5VfAnQTe8WOKn7137rvW38ANFQh?=
 =?us-ascii?Q?anGS6+FbMWA3A+D/gexmLn7+SDDunGnJHcyZw8zzWT4YTYTO3Y5ZKHrcSIQ9?=
 =?us-ascii?Q?zpsBQbM0WC/a1edkRKDNXF4jvDCF1NkV0QZtOFeT0wh6wIq2WHI9e3giQ9ej?=
 =?us-ascii?Q?XsQrsYlF7x8H+xbVc5fR/fwg?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbc5c97-fcf5-4ae8-e670-08d90a74a6e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 18:37:18.0818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A5yWb/pFhW/hQDkAtk4NTSTa3t5DpjirY9UVmjB5cdezGqC6f/Rus/j8L46iIiZHCAb9/VtyhpS4Z8iYkK4rTAkYeSzJgk1rKUdrWJ1U880=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3783
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_113722_234905_1B9A81DC 
X-CRM114-Status: UNSURE (   8.47  )
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

On 4/26/21 12:25, wenxiong@linux.vnet.ibm.com wrote:
> ./nmve persistent-event-log -a 0x0 -t 0xb /dev/nvme0

This should be nvme and not nmve.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
