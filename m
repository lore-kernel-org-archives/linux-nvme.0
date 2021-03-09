Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199C2C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 21:03:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1CAA65243
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 21:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CAA65243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=VidVcudl0oyRpCScf92IC1olH8lAhghSt8CuypFaQIg=; b=etA52Lzo5gBYchHioj04ZXYfr
	NC/DtiEA/ewwDpAgp+QbUCy7SykMfQQieKsWqTN+U0E5Gns2y7g55/mh14oaITx4P1ygLAmKH42W9
	mpxczC1lOEsYh0UuRrL2bkGzVqz1k4Lqpuf7E/9FRH2rCDrYnRVSzzrGsHBKHXvvIo7Auk2BGT/15
	kRSl0RemHAGGYQ7Pv2e/dVKvslnxZ3MDUmUOdaQ+Nw4O/alvfxMBPh3mTTdvXCWOyCeip+SirxiKf
	OYvN0EtO1cahCgP5J0/HXWysjg8ZditObyY2qU7HXrAv+IM6nOP71vXidpgdRGSsZvETuwiDhBSn8
	1hPO8lLUg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJjVw-005PKS-JD; Tue, 09 Mar 2021 21:03:36 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJjVs-005PJt-LZ
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 21:03:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615323812; x=1646859812;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=4nmiXkCtaRVYYhe0zZAXYDFSZJgokCEEnHtMeCInwNs=;
 b=p+xCbyJHfuVw9IBXC5T0nzGaDvo9BFw5XaUJVq8Vw4xBFFQ2AUFUI2xB
 5m9KjeeTF/kHeDWxIAAbaN2YKOM5QNlO0Jm3cQrEgjkx9tT2kqvcDTDLp
 Tc5Isj0qU6QxLfQRZZXMLZ+UlSxbnr9pbkO1ZG95q2UULCFB8OjgB9XWb
 fyd4konMRqCV5M06PfbZh+xDCwZcuC00vGh8z0v0XAiFZIXpewjiaYHYN
 FHD94xUwrhjAer3J9OdY+D6ryuEiw/OIYkfWaUfk9VqsHPTyHyATqKOAA
 UFt4Uuotc++T7IpFQrt0DorowWT4uNhEiWuxY+wNWq89jK3btoqLYrlke w==;
IronPort-SDR: lAOndvQSGjUSWt5cbk4vYJAU0BKOVJC75pGfjpR8ueFW/HTxGSVj9F1mKtwFHnb8x9OuLXfnvO
 tugNJyqUPfFta9L6YcQsIT6MuoKYdlISr722g8Ll8D2VUCEj8z9I1ip3Ej9M+qSdjwp01TykMw
 KRYUz9ECCJpu8DgZv6wYvfnv9QUxMLEcTORk//dyj4MACqLAC37kl9Soea+Et9LeDBvX5n4Pb2
 MfH4QfJRfEtAqlf8BOWmH/kdJN+Xk3AcSDPQcgD86tdpyqV5BiT1PlckB4k7bJmCQMJzTG2SkD
 GOM=
X-IronPort-AV: E=Sophos;i="5.81,236,1610380800"; d="scan'208";a="161747818"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
 by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 05:03:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn9FXWf/Kou18tNHdSVsnCzdmPXQuwWNKPNDQ+OZCc+Du30RuEU99xq0UQkLNHXgX2x190F9PNOI25R4g2YJ35snBVyNTIPPyszvuQCyTYgyFXAAvRhLf+N1AWhk+P+LGojH5dP2PzFQivZdKcxmYHHKkwyxJUcOs34c0gZCuer9epjXeCppR73ktxj1tVyv2/eQVZ8vmwan6m1X2cRSb4d/AieRPBcp5KhtOZs15BGKYpH4wCMcliFQXGcypCTHyDiQjB+Lh8Zlj/0J4V4kuaQ/jKoLF1NgyV5exiqygn/0oE+bDL4IVaOhHNJLhcX64bcacB8AKityUioCfWjTSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+3PtPUONy+MIOg4EQWWDy9w1kBAFJXE7bLhrNKWHcY=;
 b=eLB75XANmmMGQxJeV3fc2EH/sBwQjAr5O2MKrKOndrb/ZM5EiUrvXrGWy96nApUlgwZTROlEY/GYH6XwqdOQGII4cY8QYkgyXw+CXjNTnDh/qULUc+qkFonEkDU57uZ6AByLbZrXw43ToVk2YsKIrfmKj0rqUjdEVJIaIqjgAmrkxnctLzulI8pNuTuHhXZgaqORy9KcuH8LneuIacpn3Ewc69IE06+ygAlLfrsFkY11Q5Cv2nmuKmtXQX2lHgFnnG+FNFIbnpmbPwbLQw1v7to+YM/1ira+sDEFF8V2yRqL6boDEHdmosZLEO3uVFDhOeGI47Yr2z/0xIsTVyMoSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+3PtPUONy+MIOg4EQWWDy9w1kBAFJXE7bLhrNKWHcY=;
 b=AgnpangZRFBBoao0N3prWXel+dylTVgT1QJSWkSxu3zogFr5i5bRAzDXQDefLXZKS7uNeBPedMHeKbclkD82oUUkwC4KCIjIAhReZQ9l6/PT7wGyRwMTa0E4t4R1/OYin0QWmNmDoqvk/pT5r3E/kMpjEmf5b0WxM6KR46d1gfc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4872.namprd04.prod.outlook.com (2603:10b6:a03:42::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 21:03:26 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 21:03:26 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V10 1/8] nvmet: trim args for nvmet_copy_ns_identifier()
Thread-Topic: [PATCH V10 1/8] nvmet: trim args for nvmet_copy_ns_identifier()
Thread-Index: AQHXFKDd0Blfx0b+CUmfKhVWopYbEg==
Date: Tue, 9 Mar 2021 21:03:26 +0000
Message-ID: <BYAPR04MB49654C66E5F4BC09418DC61C86929@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
 <20210309045823.18545-2-chaitanya.kulkarni@wdc.com>
 <20210309113434.GA9520@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 534ad3a1-7c9e-4b75-3a50-08d8e33ec88c
x-ms-traffictypediagnostic: BYAPR04MB4872:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB487268B1232D1592377A54FF86929@BYAPR04MB4872.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T4cnCrGHN/8riP9eXrMHy3dh+Jbqfy44J2Y6ElNA/v8m1RMfR3VpLY3TmWWLjWq9lAtDiv1ibAhtPcwSZJ1tHa9aoKgCKo6pA4VYzjH9VlYl/pUHvP+qJV/3yL8bWHMn6on0QIU6qMyykcaOymLCZMm/28gjWbEW+7TRzWtBCrpUkNnSKPaBTqmxnLUNDsz6uwLPoDlmi4FIr/JsmsA0kbQUuQyrBmuw8kGUuFGRyee2a2ZmK16rhG8WIlWrYP05GWWrhclGjLSWMZoAoDcbrGYNPdadyrTnaehP5C6CHayQ5+oxCeBJ+A+Tpo92UnkHpgRPE9SZ9AR4gsdw+8ryQZYjSaj8FAwtZJfpXUhfXi0UnnM7CodPSQkL+FXw6Ij6UqydfuEnUssonR7r2317nThxWhkf14NYS3w4+bIkt3Y3v4uXD0fMkVjmvJ4l/UcuC4NR1pjLIlC8xY/3gZD372L7l62vXabinXRb9I3+PWj+79GOh0TM4q37q2EVx/m/Gy/E61Hzzqdud/RsVnhCUg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(54906003)(33656002)(26005)(478600001)(8676002)(316002)(8936002)(71200400001)(7696005)(86362001)(52536014)(4326008)(64756008)(66556008)(66446008)(66946007)(6506007)(53546011)(5660300002)(186003)(6916009)(2906002)(55016002)(9686003)(66476007)(4744005)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3g2NRcx/Sze55GK9iASXNpHQMSCtpjGhj7mWQqtb9/4hzXFmWF7Y+rXmUIuf?=
 =?us-ascii?Q?3bsPq/Y8nsiGZPX+LH9aFb7ZRVHNFh3b52A4J/z9/HOyuaKETPKSCh6Vvyzo?=
 =?us-ascii?Q?D2pb8T2AuQnRg824m0Gu0oHbFJoDCi7QBZNVjkJ4iN+oVbr38j1sMVVlgYND?=
 =?us-ascii?Q?dynYWBaTafRga5He1SD/P+0CUO7gqtjIgX4/qeVc77xGCjNpPsZ3yPKTxrcX?=
 =?us-ascii?Q?qzpv8gnU2tAG+rtDH5Vswe9E0AvoaM7C5bcPE5mYlM6YE4mwQ3DNhsqMDMJe?=
 =?us-ascii?Q?BSL0kPbCYMg5elZS8kE1pEI9/Y7EtQ4Y0gd4qH9robvdtDKiDYj/nMA6Eaop?=
 =?us-ascii?Q?q5Qe18kI0Js2A6JAI0MwDqFALWJ4r7pJWc3sdN2eOH/MxZl4brMf8ZWvfDRs?=
 =?us-ascii?Q?+gpISaq2AlbcgyUB3Fu5dK5DwSbive711v3ZOKhsxYj7locPAmnwA27kEjL6?=
 =?us-ascii?Q?BkGzDkfuz/Kutk0mpELlucNq18jy8w5xzh10XTtDljqVrMXWTZQqcmNcQasm?=
 =?us-ascii?Q?rCKmcIdL54Q30bG3FGQn2AHPfte6L9s3IdiBc6C4lfCaSaOxiCHj60hAnP1a?=
 =?us-ascii?Q?Sa8iRTnVyW9UaKnxxEJ8yZUYexqgsW2LkPG9/Yy1RmoinB7n4mVezoktA03v?=
 =?us-ascii?Q?ViRVnr93/dS3K0wEGS5bPDOG/QkhBwaB7XNm4aLLu/LNz8NfgmToUKsHbaMD?=
 =?us-ascii?Q?hskD6pBnhvqNUKl53X3tjByJycd07BNiU2lr8wyyJpZF/0Qa4jSyoI9r+sOB?=
 =?us-ascii?Q?0fF9aflmpoTBbhQsAY8om2MMizIy/vPhfct3sWcFSmV+gQ5r/OmOBfi5VIqm?=
 =?us-ascii?Q?WqHYgD+2rvayeCd1C8wqkOwc5o57R58IGEBc0gGHEsiy88qNmJnpPyoIX/wM?=
 =?us-ascii?Q?xnZnFgXxHNDFgyZfaFPKkuyAZm1uLaCiE3OP3Re+4tocahOMXs2AnGK2U1wH?=
 =?us-ascii?Q?59iqGXeQVg7JZ3qlsDLvs5lb6C3HIHQVrRhG2KlJWerNX6/G9W8alxrEaDoo?=
 =?us-ascii?Q?hi9mqcUOJuBnderbpzqdPKshFyqDVsjudmE9pBWs2kr4+EE+ajpSSZ/iKZgE?=
 =?us-ascii?Q?zV6QQIzpYv3lbeq6Jz0QBSEQtZJeR0StqZAnr/RF76s7eJ3n+TQ2wUwZ4HuZ?=
 =?us-ascii?Q?AEk/4iOyJ0CG7DTQqVJJ4rOgCif/VScTqQjpDdT41NdiqjZvhBopKkhr6wTs?=
 =?us-ascii?Q?4q59iM6buRCsPEdw622if5OTn9j+nmwwVpsfZDbYIQZrQu+4v+6SCzbdkz0T?=
 =?us-ascii?Q?kOvx61KpT+zYN/kZpsPMGn5K39U+91EYxiFSzOhw9wRu4CcHI6wyJcvaP9xj?=
 =?us-ascii?Q?Le2Rv+cnwiX1+uYfL974BKz6?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534ad3a1-7c9e-4b75-3a50-08d8e33ec88c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 21:03:26.3766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YG7nbBjp64z6Ei4C2IpnEUxQ9JQWPsNKAHBW/ABjLGLLntiLx961918Gf8oANUhGFiiEyeXX0LzcNYXvaOYis9odedGI8PzbOfi1OwoOE8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4872
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_210333_060796_4BB7BF92 
X-CRM114-Status: GOOD (  13.06  )
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

On 3/9/21 03:34, Christoph Hellwig wrote:
> This looks really strange to me.  The copy function should just do
> the grunt work, while the policy should stay in the callers.
>

Looking at the code again, this is not a generic copy function but this
is a designated function for the identifier copy, and for each
identifier we have a length parameter that has 1:1 mapping [1], so why
pass that values for each call ?

Anyways if it is going to make code hard to read or maintain I'll drop.

Please let me know.

[1] Identifier to len 1:1 mapping from include/linux/nvme.h :-

#define NVME_NIDT_EUI64_LEN     8
#define NVME_NIDT_NGUID_LEN     16
#define NVME_NIDT_UUID_LEN      16
#define NVME_NIDT_CSI_LEN       1

enum
{                                                                                                

        NVME_NIDT_EUI64         = 0x01,
        NVME_NIDT_NGUID         = 0x02,
        NVME_NIDT_UUID          = 0x03,
        NVME_NIDT_CSI           = 0x04,
};



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
