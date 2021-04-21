Return-Path: <SRS0=D0Wy=JS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A348C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 08:42:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599F661426
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 08:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599F661426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GoQncYAaDcq/PTthoPANbMoo6DCkBIMJDdKRovi20U8=; b=IDOZtpA1QZsS4PqBVb0IZSMAd
	ovJAqwokVC8RIouGWZKervoly+WoKYEXOjnKwi1LCESv+m6QwWBjzdn/+XcHbzftSXyvmUB/I01mK
	54WmodPhW4QRXORLDZtWFnjc0Qig5keSXYJ/4f8JtR9XRuZhuUuHh+Jpi/8wzrTPTFwc4W8XmgaZP
	tBUuTaEGfF4308shmSP1aIc52+MH/zUkZO+UMlXNNn/3c4Or9w1jNGYg5Y3eIxk54vA9m/bDi8Mnx
	2otEBsv3SIL4VX/S1JSExzPmZNGXzxDnPtM18zUwXA65fVdIXqTTlp3/BupyiQ+8LvXuqU9jLvEt2
	haCJPULPA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZ8R0-00Dzbc-Ga; Wed, 21 Apr 2021 08:42:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZ8Qw-00DzbI-Ut
 for linux-nvme@desiato.infradead.org; Wed, 21 Apr 2021 08:42:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=PNIjrAVRpAS221dOLF7allosl2P9LZQsinGmP2SVsWk=; b=26m7Zuth9ijt7qQSCwshsxIHrC
 hOVSHxD2nBhcDbkiwQxqMN3A5qB1AJh6QBrYidQLFPygYUK/bmIJQ6Ke7oLLUKSs4PbV4mvfdfXOO
 k72AgGORxnV4KDqLeIeXAi2cCIj4Wn46tQJbYqlq92GQqcSKcqJ+5e7gfW4nofhzCIwamnfl6Ogyg
 CEX8Ud7NBsCNBhFwe9KP62VCYRTNZhk81TUqXPwTwEDMXP93FtYYgJ51iVFATLhTc/7MntvJ8tqUF
 Oq14YiMWRQFVWu6MEqyq6uylmbMqptTNYwo5CAJAseJibpfXBuVCqWRJwY3liSA/vvP5i/UbRSV+c
 R7ZxJKdQ==;
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com
 ([40.107.236.45] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZ8Qr-00CiTW-Qc
 for linux-nvme@lists.infradead.org; Wed, 21 Apr 2021 08:42:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTwIFXbXXV45FYK1rIbrnEvCclKzU+b5qhjs1rukYab5BdLAGIVZbeMX4ayJROsQvHWlx+CZeyBredO6Of1o98BxUWQQ5s6X7KeZ4oC980g8rpnFXybR9jy+08KkichKvZZKe7xFC0OrbQp45g37QzduI9q+oKkaRoW6wX0fl1Tt3/Vk3OW1FfcLkl6uiGqqX10N7qEtnk+O8pkLVo59KGuclop9Kq0gqNhuDe7m6f7RRY1BwfAJLP6N53mKqzKnvpfLHJCVVo9FZk9/GkEwWmV6z87z8vCzGxt8u5dZu6G/dPTldPRMqvI+ZCYn62hLbt2kDj3etcuke9OJWd/yew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNIjrAVRpAS221dOLF7allosl2P9LZQsinGmP2SVsWk=;
 b=XlxkokDSUMwxwyUSWA4UNOwFviTmi31XOUpAjGggJV57MHLhqiie4CIZwMp2nWfnV1ZCI+7gD5cQAzbUZabt3Kb67jlmqcPhAtWDDccWUZorkjB5RCI3rncEIUd61J1DsNDVRFQh8El5GX+/fMZT3w2GXHvNedR8hWq93xwKvSC0/uw1pCk5tVAsb47vmkbxF0gLWFh0WGhzHGTGk0xOHwa3J/PmdZePmGIJfQNWpZihFYyJfqaKwlNAmOM1DHp5Tyxz/jHJdcdXYCOw7jmzuF/LopzbJk8aoKynsGylQN8MzV94NwqhF4pprMBV7C7TZ9uDBpkCYljzi6cM8vWqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNIjrAVRpAS221dOLF7allosl2P9LZQsinGmP2SVsWk=;
 b=iSWq/ZaS8po2l8TP8mLmb7jfKgx7ym5880AwBixCLovxnmOZfEBcmDeVgtT+gV+0psw1SxHbmU1GMNp1V58HEQNAyNZv9xdr3XTkO6UeWkT+Hg0b9oqjkGObYE4Pxgi7zWdwC72M1SvSa+bjxCprQdnyM40X3b3B4Tkw/qG9aTk=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB3889.namprd12.prod.outlook.com (2603:10b6:a03:1ad::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Wed, 21 Apr
 2021 08:41:56 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 08:41:56 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg
 <sagi@grimberg.me>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "S-k,
 Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "open list:NVM EXPRESS DRIVER"
 <linux-nvme@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] nvme: Favor D3cold for suspend if NVMe device supports
 it
Thread-Topic: [PATCH v2] nvme: Favor D3cold for suspend if NVMe device
 supports it
Thread-Index: AQHXMqDWkjT1OiNuwUOu5byZz3VDGKq7a02AgAACCwCAA0B58A==
Date: Wed, 21 Apr 2021 08:41:55 +0000
Message-ID: <BYAPR12MB3238A5758B18B061204F264EFB479@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20210416091344.1210803-1-kai.heng.feng@canonical.com>
 <20210419065027.GA19201@lst.de>
 <CAAd53p4r45fZ4ewCko_Q-mO92omBZkEiPpyyc2SYRXH+6WpEKg@mail.gmail.com>
In-Reply-To: <CAAd53p4r45fZ4ewCko_Q-mO92omBZkEiPpyyc2SYRXH+6WpEKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2bdaf791-bf2e-465a-9cae-b1c29fa4bcb9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-21T08:37:26Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.227.235.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15f35c04-8cbc-48da-c193-08d904a1520e
x-ms-traffictypediagnostic: BY5PR12MB3889:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3889E8DD79064B0DA85F1E53FB479@BY5PR12MB3889.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9CeLc32QXZGnmposZXUw3hclYt6JVzYA4w96fogTRKfd0/6ICnXQYaAHaZeEJPWdcqV5XDBR0n9z1Q2F3uNtsKmkg8vctALkoF2hgeMIqf6TlMwLlFz2kyvbUaNk1QEXHYnQS17hZLVG0CYECrHUGzutxTtj+2PzFx85x4y9zbnKH3ZdTehKuIwd9l12HUfXdMcjyznOlHfWdNh8QFB3rc4CkunsaWNqGTDu9mV3vgP0wwTZeWOiUzPo+m61xFVITq4c0RrJVOlYn1QgqiDNOLv4Bgnxi54Auh7cLBjyUXyKr7Wej5sn5Pj/xQoR0insyd15BzJz1Pt2YTFbhbQs0Je/GshxNEONxHB8T15/SPV/TbJqZcLb1osl6ShaLsO1pzkLs8wIAkb73YuoMm57ItoRsQcgJNfNfkE6n04Y6iBC3I9bDsyAgqSowhmmaFCe7vmwHmVL5lfy6bYgznTmB+R+aCFCdi2XolgBe68caIWmuI4Bf3ETNON8pwvOKysLaJH0hOYuTvywtxcOczsoWoNzn0e3xc+0UR7wEem3v0WwCzpiWgwJnF+Z5fwVKnYucmZ3FQQUgmXwMVBuSnQNZeov/04O4XA2qiyBPl3xDOL05C2BiB3Fr3+3dcUZ+3ihouiiPZCNNF3J5lyLKnaBcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(54906003)(53546011)(6506007)(66556008)(8936002)(15650500001)(110136005)(316002)(66946007)(7696005)(2906002)(9686003)(38100700002)(66446008)(86362001)(4326008)(66476007)(55016002)(52536014)(122000001)(76116006)(186003)(33656002)(5660300002)(26005)(478600001)(83380400001)(64756008)(8676002)(71200400001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?dFdrM2NkRnpDNytxRGpPWDNhYTIvUFgyLzJVVCtCYm1tMnZUNndUNmQrYU1U?=
 =?utf-8?B?R1V1UzFTbUpTbnJZaFhYQWgxaWdzR0F3YjhQVXpHcFFZall2U0hiQ2gwdXlU?=
 =?utf-8?B?R2RiTG0rRElRL2lqRTdncHRLUCtpQlhtOXkzNnVodnpCREdrUFNCWlZ4LzRI?=
 =?utf-8?B?czU5SkZLamdjcjIwNEpXYktzRzRHRFlzb1o3OEJjaWhOWGh0NmtFeENHYUFl?=
 =?utf-8?B?NDVmbDFOUlhZRjFvRmtxeEZ1czEvVVdJYU4rM3g5RHlkWWpOZUhqZU8wUHR4?=
 =?utf-8?B?c2NHQ1RJdndWWkR1UldxY2hSSDJwTXB3T01SbXk0WDBackozeHJlR3VnSWRq?=
 =?utf-8?B?VTk2MVB1cEhFNmtqQXNGcDZ6Q0JEYWZ1aU9MSG1SY3dxWjJiUm8yWnloa0xV?=
 =?utf-8?B?RTlsbkFpK2J5MERrb01TbmhGekFqQnFhMUlaNDVhTVYxZGdhK1MwSnR2YkRw?=
 =?utf-8?B?T0JGaDl2bDFpeUt1azNsNjNESW1RUHJaNmtNRmtFb2JaRm12NFgyNnpSUHNo?=
 =?utf-8?B?VEpaVUV0SHNpQzQrZlBCWU43ZXgvZkozY3dpVWU2aVNNRms2YnUyTkpwNmU3?=
 =?utf-8?B?d1lhYjAwamJQZ1E2dzJJVHd1aldKRzJkSEV5VXI1cWxjaExMTVU0TkhoMm5u?=
 =?utf-8?B?V3FNQ1ppS2pLRnVLUHhKOVJhRjMyWWRKN0oxOGNGeWZWcHpXeFdxcDE3NnlT?=
 =?utf-8?B?TUxlbXRZc2xvZlRKekVQU2FQRUcrMXZ5OWRlTUkyUUpYZFJXRmlCS1ZVNU5C?=
 =?utf-8?B?a3hKMFIwU3NGZCtWUkd5T1pRMFF4MmFJK29RekZlY0NPbEZKazhucHBBOG4r?=
 =?utf-8?B?NGFranpIQmxOSjRSdXRWcENjYjBXNjFibXFpUzVLTExPV29Qa3J3bnlsci9u?=
 =?utf-8?B?WXhEVzZVMkdObEpjcVI5T01CREpObEZsTXp0TkZCc0JQZlhEM3Jqcy9Cb2U5?=
 =?utf-8?B?UXVQMnV1djZsWlMxTktIUXF1ekJjaUFRM05ENE1jZE81a0l4UWNqVlBncUVW?=
 =?utf-8?B?MDN5MWVab1VMdkVRWGRyZ21leVN4WWxYNGtiVFZlZ3VqeGdUa1NISy9kVHlD?=
 =?utf-8?B?YisrNVIvbUJBWVpwRHlNSXprb1B1Q2E3bEF0K3pORHJKcmNySWpaRXZ5bi9J?=
 =?utf-8?B?cHUxajAxS0laejZhMWpqdklHTVpqRS9qcnE1Lzl2TUJKeWpsMmJzV3ZLZWY3?=
 =?utf-8?B?K3ZWUUlCNHpaZ1k5K055NXNSVVdJemhVZWtPaWd1SEIxekVMZVh0OHkwbklv?=
 =?utf-8?B?SnhtSXV3L0RQTjJwTFBuTm4xR1pMV1dzcWltZFRMbm9JdVFXQjNOeXpSN3NP?=
 =?utf-8?B?U0VtN0h5R0JZeEpqaGRuY3RlZi9rUDhicTVWM3VrcDhOYVZOYll2M1g5Y2pO?=
 =?utf-8?B?SjlNQ1lLZGVQVUNHRHFhNEU0QUlZV3AxTU03cDBQb1V6akpMWUJqSS9DYTVG?=
 =?utf-8?B?STRWT2x5NXlGZFlJSnpES2hTajdUN1c3R1Y1SkY5OVNNdHpXUGxVTWo0dmRJ?=
 =?utf-8?B?QkFZQzJUbzJwRHZHU1BoVnJwSWthanQ2SE1QR3BQWjFrVHY2b3FXNzNsVytM?=
 =?utf-8?B?YmNMWGw4WXJjQktqZXhnUk4rS2pDOTAwbTdjMjVxQ2NmRjh5VExxOFZMZXZm?=
 =?utf-8?B?TkMvcFM1dnNwaVE3ektpU0Y1NDQ3TTMwbHpRTmxDRUNXT2ZPaG1oYlV5Z1I1?=
 =?utf-8?B?MXloVmZJMGhWQ0psRkFiRE9YNEJKcTMvNW8rd3lSNzVZQlVGU1I2eW5LZE93?=
 =?utf-8?Q?mxx31LdIXckfK8WRzmqT3ujp5iisJgwyaHRMyXf?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f35c04-8cbc-48da-c193-08d904a1520e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 08:41:55.9951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QG7750jNe4JIFTKcy7t8MdB00da+2uIBeW4mkMhBQudYEzuRulwP6upLnirrldO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3889
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210421_014202_034073_3C4B7639 
X-CRM114-Status: GOOD (  19.27  )
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

[AMD Public Use]

According to BIOS guys the _PR3 should be always implemented for NVMe device on the onwards ASIC. This solution seems more simple and looks good to me.

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Thanks,
Prike
> -----Original Message-----
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Monday, April 19, 2021 2:58 PM
> To: Christoph Hellwig <hch@lst.de>
> Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>; Sagi
> Grimberg <sagi@grimberg.me>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Liang, Prike <Prike.Liang@amd.com>; S-k,
> Shyam-sundar <Shyam-sundar.S-k@amd.com>; open list:NVM EXPRESS
> DRIVER <linux-nvme@lists.infradead.org>; open list <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH v2] nvme: Favor D3cold for suspend if NVMe device
> supports it
>
> On Mon, Apr 19, 2021 at 2:50 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Fri, Apr 16, 2021 at 05:13:44PM +0800, Kai-Heng Feng wrote:
> > > On AMD platforms that use s2idle, NVMe timeouts on s2idle resume,
> > > because their SMU FW may cut off NVMe power during sleep.
> >
> > We're already have a discussion on a proper quirk for thse broken
> > platforms on the linux-nvme list, please take part in that discussion.
>
> Thanks. I didn't notice v5 was sent the to mailing list.
> As of now, AMD folks are also reviewing this, and I believe this approach is
> less quirky.
>
> Kai-Heng
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
