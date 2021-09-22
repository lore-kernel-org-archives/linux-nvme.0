Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D83C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 07:07:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A57611C9
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 07:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 23A57611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sa/PxeeADKMzrqVDaPLSssqfAWJsm5ehfmkFZOzRv+Q=; b=rT6gt2klfeNxwq
	Lslbx4Wvy2ffFesuI9PE95C8/8sjoSfFjSIWBHvBbW9b0H4dEydrFY4Je3rR5fIbXYdBsm1l+Ysiu
	ArY1gJLVA539hqcI1845+TpJ54qFiEO9+vOduJmO1l0QrPniUD2LpFxPsJPLzYEdzrvMRJXDxAEns
	nlR/kHSPiiae2TYGc3jaXFqtLJLnbnlZXl+Nq6j/4KgjFdiFfMNECDJVdAEfCUk4xFRW8ZDJ4t7eX
	IruVOTrJ8eGMdaq3/TPfexuW9uIH6cQO3YNghmbFjvP13PtMkx6tMOge4tXq/KyBLOwJL1XdSvhN0
	5zXTte8ca00NYqI3kl0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSwL6-007ElH-VZ; Wed, 22 Sep 2021 07:06:45 +0000
Received: from mail-dm3nam07on2088.outbound.protection.outlook.com
 ([40.107.95.88] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSwKy-007Eiy-LH
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 07:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7cP1XVYZpYEtgfys+jvUBqBVvxr/sv0V9wXpnhXg6f1+WhmJnZrbS8SVVFNzvWecTrA2Q9xvIA+mRNWvo2YtOpsCijaZENKO8fwTXq/exle772AXEm95IkR4Dg5YE8Tf/2F2R0ssoU1GgpYW8kiYgAsefHjL9vh0bpphH+s7nBBh6KaA9D+h8cA0B44Ff1JKcg8GjgPnANrgaKIcm+h0l+W1ky4qMYO1iD6mwgz0+UttFAktv785DyCM0gMy9DbHhB+jJozlk72JAjoyDsovtOP6kSdWrm3o2emWzsLy3Re54+WHBRRM9oORZ5rV6/tLIOxR8kvOl7yS08rHLANXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=diyhBF+Rp3Ljmn0cOESNtOTbifLzVtHWIB8752cGF9Q=;
 b=mScQhyZkxwZn/JT/qaayVlWHRjfI1WewAM2nzmLUgR0S9IO1LR8QsZgVLHMFJgdV1QzUJJv8Ph8nH5PvWPGLNhD+oqnWUrAx4U6+sg1Y3E705HjFjSJ1YsHQd1W7y5Ctqp1D7K2RA66b/5dRbTazDg9ANf9jhBisFGfh66dsxVWn3IEr4smaAaNm2qm2GD0m4kPo9Mk4WTSNeD0wB7CHvCnqZ3BP73qmsbAyR3gZHHcNV8IBV5WGgRMTtZ6m7ZtfLfOgmj3AY0Jltg6n4Jrnb0sqatx87gxPGRKHA1G6xG5DFrqTtsO2PsaGLsYK1H5bzGsUGURFFGuwGL6WiEdmcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diyhBF+Rp3Ljmn0cOESNtOTbifLzVtHWIB8752cGF9Q=;
 b=Rv2IcZK7FrsUsUd0WPMueexsNvq29/dcMzhRLgVZkkqggH/AkS8o62tvZAQCcgtB0DRr6L7Fwqm8SRa0rlldzk+EdQT/EUXVz1u9cJEbO2Cl0smaXj6JSfvanpW6GIhiwheVfyJ0B/Wdter2zbMMSsDC7EXf8AC11/BrvMerSGK57qMemLi6G5T7EEzJKBcPjJ8L4bZrXf/IlhpgSNZrYYdiDRCGS076Lx2MI/E3IW9sG2ECXbrzMuNl+fpXeUH7EnPkkEUaewdDRXmQ761zfofcUy88BT0h9EgB3Tps3AA9Clv6SB91VGXym6tafaS6aNStMFjY5O2QmU0gc+xVSQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1822.namprd12.prod.outlook.com (2603:10b6:300:114::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 07:06:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 07:06:34 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/7] nvmet: add nvmet_is_disc_subsys() helper
Thread-Topic: [PATCH 3/7] nvmet: add nvmet_is_disc_subsys() helper
Thread-Index: AQHXr3wJH+u5Y85lOkKTiLTgQmSMkquvoceA
Date: Wed, 22 Sep 2021 07:06:33 +0000
Message-ID: <04eec569-ea07-1a40-9e24-483229e840c3@nvidia.com>
References: <20210922063525.143045-1-hare@suse.de>
 <20210922063525.143045-4-hare@suse.de>
In-Reply-To: <20210922063525.143045-4-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9eddca0-8fa7-4af2-d0e6-08d97d9782ff
x-ms-traffictypediagnostic: MWHPR12MB1822:
x-microsoft-antispam-prvs: <MWHPR12MB182277E086D56123AF80FC27A3A29@MWHPR12MB1822.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vlF38bVS/476Vt157cONI2FIGw+ME6FesUAnvAV/QNUl3oEUfJWIRTyAbFpC2uMjfAsJpN87NHe8KDrbdhkCefTNzUG5vZuwEmsk7BAanuKa0sdN0K/Tjw8PTYXnr1/xzdMlhKXim9zZ16TgBxXFPq0CWwR3tkblRq0bPm4WuwajqLupgQMDN+b4dfABgBD2UHGgfKKbm/+1IW86OaOjNbXr6yCW6vWo/cRKJTAguIfjQXEb6Zcv4I0wWBew2uCyEu9dcswEL1dRXlG4cV1kWGk1raDbMEjMJycNkiq8/DJcoSbTOGxEtoTUMmICKTHj1UYRjryYlK1MkyAb504J0HbKD53AsfniC7KwcvTH7AS5yufFH6uZkXr791hE/PzKAI9s+9rz9jHSh6R+58Ta5EKUIJC3URe1P3zDtvf9jKNv3JEkENG2wgOwXtgil+oyOzGKxOSGhkK+wLnrD8qdZ8AHiRMIj3KgWOqZsUKnoH34WT1s7LgCd61C+cFi/dRu+qd9aq1bo/bMdLKPanIef4dcuMfqy9cyaX3LvOeANLpcjiUZHQmCjEHZirDwSbe1GBnDA6nnOF98Uzcg4RpF+KiETgyBa2pGjUGcqlx6k97zUdGX9qHRNlfu/DINHRdeAJaSdGv69K6SovOF1XEFyREQPq0GEIOWmp2ZCOt1Elx8msgHVTpqtcqle4oR8pdFJgZT1gufEEPdOJeTeMvOgCHHZ2YYeWEutZurKzg+1UFDEHGnzaY1Iv5lI6UCrzNheb8/JhbG0T2Ao5oEhCrPyA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(6916009)(558084003)(91956017)(66446008)(53546011)(38070700005)(6486002)(122000001)(316002)(66946007)(8936002)(186003)(38100700002)(64756008)(6506007)(86362001)(31686004)(5660300002)(31696002)(54906003)(66556008)(36756003)(66476007)(6512007)(2906002)(4326008)(8676002)(71200400001)(76116006)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejhtUTVkSXZMWEQrbk84U0Y2ZUtyUjFLZFpCQ0p1M2pPekppRjQ2cTZpbXpE?=
 =?utf-8?B?WjMweDltQWJnWHd2TzFGdmpSSlNVaU0vRVM2b2JQcnZUS1FCd2pVbW04Y3RS?=
 =?utf-8?B?WDFRNGlTRVl1azRlYVJZOEJpS0NxeDd2ZkNQOFR3MGZXR0hQYlBVM0djb3JJ?=
 =?utf-8?B?TGNrOG5VUTNvaDVhY2oyNUxmQ29NTis0Y2RpdXJXNGNsTEFDaDhIcnZyUCt6?=
 =?utf-8?B?citTZGtCRHJkVGtTTUtQTkZWSFJPdEI2N0dVS3BBb2dlaUlvbjR0My9uUDVV?=
 =?utf-8?B?UTd5ZFROSVRCMmdDck5ra1hTVnJXdENrSVluaGpGUGNmUGhpMFFLMlJXREpv?=
 =?utf-8?B?VWRLcVpxL2ppSytWbUM3bEprMGhPYm9oUUttM05tNTBtZThCVjNHWGNPMnl3?=
 =?utf-8?B?RW1YUzQ0YUlSRkVMM2tlWjM5M1Nlakw0bm9yakZON0ppVmhocnQyUVJQT2pE?=
 =?utf-8?B?aGI1cnM4emt4UHN3SkNSeEdvTGVUOElFNTgvN1VLRFBDWGpCYTBNcHhUR0NX?=
 =?utf-8?B?QlNyelIvNDQvR0tvYlRybHhkbVVFSWhVWjBRZTR3UkpZRGFxVmFGWFh0TkpZ?=
 =?utf-8?B?YlJhcVJhdUw0V2FzTkVjdnE5TmN5QXNIZCtRZWYvTjBEeFBuclQwdjlYMlpo?=
 =?utf-8?B?WndaNUNqM3dBTktBbGxaQWFBeExubVNuTmViZkxnb0FKeG1pRjBTM0dVQWUv?=
 =?utf-8?B?eWJXaGg3bllzRHhPR0tVeXdXM21NUHhoUlpuV2w5Rm9PaVBPY1lXQ3czQlB4?=
 =?utf-8?B?UnBydkNtM2dNZWRLRTQ2S1pwdXpjOFlMSy81RUFKZEN1d1FnNGxDR2gwak5U?=
 =?utf-8?B?d3JPMHlSZVFvYnkvSTJsbDRQb2ViTVRpQjFYNll1UmdsdVhLQzJmVE5HU01z?=
 =?utf-8?B?MWhwaDNKRGN5WGhhRnJWc2hFcy81K2VhS2hOSUFDeHRXNmtmYjUxRkw5K1VR?=
 =?utf-8?B?NEZZWG43NjZwQTVmaW5BRXFuVmpHVmtTZTVrUmFyQms3YmR6RWVsa2dVckRM?=
 =?utf-8?B?VjR0K2pKRXRJTHlKR3l4cXJaazczcHNJN3g3Ky9RWnNsVXJKcWZ4U3pIVzg2?=
 =?utf-8?B?cEdFcGhVQWVPM2tsSDRrd1VGL1lsYVdNenFKa296cEpMSi9rVHlmQXZXaFZS?=
 =?utf-8?B?eTNtUEhjOHFUWHpZWGlQaHI4R2hLU2wyYkExU3RXWUdWazhCVGc2SHh1S01w?=
 =?utf-8?B?amxQZWt1cU1peEd6emNHcFBZM0NTV2h2TndBL3pYd3cyM25hWGNBMmNGTXdG?=
 =?utf-8?B?VU1FamJMbXF2S1hpQm51WThvbnEwUVd4Nk0veHNLQkx3REY1L3VqYnhycU5r?=
 =?utf-8?B?dWVHRGZFMERORUFoZXkvQnowTGIzZWtoUTZSVFVXVDErWkowakd3LzhITUtT?=
 =?utf-8?B?cTkwTjA5MUpRb1lmT3V2VWJ5RmNiUzduRloyaHVjZEQ2ZldNQTN2L1lpOVBY?=
 =?utf-8?B?UDM2dU4vN08zZHE1R3FEMDZ1RXBUSk52SlFwL016VldhYUlWb3ZpTzFZSXdQ?=
 =?utf-8?B?cVNnY0lzNitZRlJQTzBETm5OeXl6UEFKK0R1UGhJRWRoSzByQTl2NG1xL3RV?=
 =?utf-8?B?N2lRU2dZbktuYk9zL29uY0NGL2c5TjZhOXNHcUx2anhQeGtHc1VyOXNYMjZu?=
 =?utf-8?B?UWVwaE9kTC9xNDJSU2JvNHNvZ3JtbTRlaHRlcWhDRlZpRm5MTWhZSlVRQnlE?=
 =?utf-8?B?V3lEOERyY0hJemszK0czZHR3ZmhlUFNhMkhZYks4WmVIL3grN3lwNWFUTm0r?=
 =?utf-8?B?N0pwQjhXMkp2U3MrZVdFYW9IeWNkNGZJbVFTUjNnSEZsMFBXMEsxS2R6cWN0?=
 =?utf-8?B?K2oyemlnNEduWW5jSWdpZz09?=
x-ms-exchange-transport-forked: True
Content-ID: <0C28C9812A24A74A872D231E54933360@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9eddca0-8fa7-4af2-d0e6-08d97d9782ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 07:06:33.9053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mgdz9z+Lc5++7D3iLhz1ysBIRK5hbF2s2hbtSGV7HpmoYT7pBjFFGUYLVzucgpPy4X8Igp7j9TLZzUvshnjIEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1822
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_000636_766307_350CE413 
X-CRM114-Status: GOOD (  11.30  )
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

On 9/21/21 23:35, Hannes Reinecke wrote:

> 
> 
> Add a helper function to determine if a given subsystem is a discovery
> subsystem.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
