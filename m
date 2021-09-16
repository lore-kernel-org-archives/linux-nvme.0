Return-Path: <SRS0=Ydhk=OG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7884C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 23:02:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A2A960E90
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 23:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A2A960E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o5NTJR5t91km/Uuux+G/dARatQBubvM/GmsET0tV1lI=; b=Q0IyL3VpalXi4J
	/qgnNMNgYSMGhCxZnRCWGg3Nr4IsxVF+FrzlY2cHxmLWKgutfDZ+UsUMBWKAWCUIK/EliyIF8thoY
	RhE3QoeBc5j6UseDl03GnL5pr8OTkMPRLBeeHJliiwmy6JgCkDPaj5WvjfMczZW25qV3EPxEYw3nf
	E1jsgX8DS7qpk40BWfrvXHGH+RfrWlbDajNEU5NF9d/13yqVgnjVa3NWfYUSHuHQSyyDcw1E+dkx7
	FvLAWgZpbODxjzRh5tr8sU3ZQaxfCg4lGJ01WUcvh1ESVAVSp4L0TbQ5IHsf/Lo4dG10nhqdtCn4Q
	yMlsb37xN37nptsNxONg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mR0OY-00CZDB-3q; Thu, 16 Sep 2021 23:02:18 +0000
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com
 ([40.107.93.40] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mR0OK-00CZCp-UV
 for linux-nvme@lists.infradead.org; Thu, 16 Sep 2021 23:02:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7SoFDGH6ryjkNYcuU1mpIB4ghGVrObw0MMFG68mJ/O/MEoHqi5Nwcua/UmbkW816Hl2bX5A0T0iAvYtdo4IrVMEoDsHsBKvCEqVAeiQOVrVLdmFHZ/N5tgWvLAiqkX4bDpEryOuxn0klRx2ptiJldas8J15gU1RU60V+WT9oSHxqxQUNqUs+D8d6zUYDuja/eJrg2U7sjgBcZ2QeVh/9usuNKNJk2WUZ4/OydztbVPlCdBxOp9HYVOyYRKdlFZlF2jcU4E7dpUUELDQrd3g9kdNuEX3h09NJciwDvzK0NZsKm0AJhuz431cB0eXXsV+atbClZgVrh9s3f2Oo0BW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=F/rXAiXc4nTtqVfTvBbPOeiE3NMbwkA4BYjAQfSrf4U=;
 b=FY/71foArteBE7gbwv98sioS11M2p6Ke94Hw7ZAtOsLpppneLbLKE+nwzchmRRU6pRqV0agt65K5tcc1tk2SI47IPksMH+hcqOncIS1l5GfccjAf0VEhZdfBsb7Oc4apuVwSSlxafkZqyoydZhGLbSlgA1Yswu3l59tkzhFkFzIeCVoSFls51x6y1rq6Fba9QIWXLOJQih081qT/E5hQzfI5SnUPTrjWNU6LpyMYQ8zs8J2kyOlFALw5L5ILAQL3aniHAWfatAmYxLeWx5jH45J4I2wwm5cq34VOOsw2lNiJYOwY6QPGGcXoC8Rv1AHdleZJjH/zGxcM2aAkCyBj3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/rXAiXc4nTtqVfTvBbPOeiE3NMbwkA4BYjAQfSrf4U=;
 b=OsMrAgjbuqKMhPozNcoZw4vTp1iptp7c3WTmOfyV36uGUgKQYSNkM3tp9ME016Zfr6TLE7hft+LIvaoAUu5BoPxTjm7yZkKF91Qwrz49jLgQGvffxaTKT04WTa/0o8ma9I9WCz84lPfZ7zWt1ohh27xPb7L1Y5RfGvA0ZawgOzvbmbeJ+T9Hv0eFJU3y+CUtqaTQEWoNzqRtQgItje4sBdxsm9+poT7DPk+hcJyZvDNmVXu7JeLTxI00s52WHPKgEdvEOFqBEXqLA1F3d/7Nvg9br107kDoDA1r1s060fcjAqhYv1aaqCqVCn617dEAE0NXN1TN+WewVc/DW/dmHyA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 23:01:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 23:01:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH nvme-cli 1/2] add "State" entry
Thread-Topic: [PATCH nvme-cli 1/2] add "State" entry
Thread-Index: AQHXqjX+qLkOu6lJ9kOR5FhfD1ibv6um45CAgAAn/oCAAD24gA==
Date: Thu, 16 Sep 2021 23:01:57 +0000
Message-ID: <69217011-5a8f-8149-e8dd-0535358fa930@nvidia.com>
References: <20210915132912.3004-1-chengjike.cheng@huawei.com>
 <20210915132912.3004-2-chengjike.cheng@huawei.com>
 <74cf36c7-9e18-2b81-08ba-cc4223f3b133@nvidia.com>
 <20210916192103.GC3908552@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210916192103.GC3908552@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50b4336e-54c1-455e-3d1e-08d97965fbfe
x-ms-traffictypediagnostic: MW3PR12MB4409:
x-microsoft-antispam-prvs: <MW3PR12MB4409407D9DFABA62F431F80BA3DC9@MW3PR12MB4409.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2odw/aIednF4Ed1SRrl+Q7nRBFdUD9uzeNImM51ExX+206XdH2cDgtoQu/0Cy560kEb2UL5zdftXAngloByjF0juOysNIL2TAj6pz2Iv/0JqCnZMkU8uuwdr7XAb75+o1eKtuOk3WQBP7CqB/ewKutKUaXpjRXgqwMNqO4ZqE0dxofZ9aPIuM4fbSHPBfuyGiL3Y6R4Dlh4QPogxy4eJp01pJd/z5HrCDHqUP/Bk6pv7vSx3myYmEUTIdmMy2424nJjwfsnhf0s12SmhKUYhSOFtF1O5eSLffI0pgNOE/casUGbQRTyvTCilwEuG3jdEWTjCifdo87nwwlHFW9RL7cgwJnThyA8aKdZLzA+ji0hfRumknAdTN18esIpNpv7SMkNzwONO5ArCmth2ViSvzNO88/Xajs4nN4YS4iCkxnSVzUSqbYHrKKRf27Nc3kymx8mY2q0tmnU7maFz0mAr25ldH7Imu4oke6sEIMoD6e5uWu9tjnMB6+vz3TDa/MEStLgQpvLeLiu2DuX8EiBkgDcTEaQtr8/LMdgXJhRQ2H5eTCgDw43uEvVz/KOaaYc/k+rHdVMvVulD08qWX8oHHOldtaJ2P2BiqlIQJFg2dNEJcPi2b38m3qdQLJt0PhmuKQWh7ROPcNfDJaHeP15ZxEzogMvDKCWibs4d3XYULv6c9EESAmij9BY0yYGEL1aSSEYLAxnflstXa8GgY5cVXW05t06d+GqW7OZrd5zM0C+41V7mo0fd/Vl2YTeGqpdE/3HgI8cG/izasxjzibYPaw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(64756008)(66476007)(66446008)(6916009)(4326008)(66946007)(6506007)(66556008)(76116006)(478600001)(316002)(6512007)(8936002)(2906002)(558084003)(71200400001)(8676002)(38100700002)(5660300002)(122000001)(36756003)(83380400001)(6486002)(86362001)(31696002)(31686004)(38070700005)(186003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejNCeWp5eDNvc2p0TlVoL1B0bFNyY25nMWNUY2RKdDRiYUovaXRVQVhmbkd6?=
 =?utf-8?B?MzJzVEhSeTNucG9EMitBWXVJTHh1emtIbmVBa01qL0pFdW44aTVZQ0dlTG5S?=
 =?utf-8?B?QUU0MFRwTVF5ang5WGpzNHJMSER2K3VyMDEveUNSSHRQRE5JY3loeE9LSnpK?=
 =?utf-8?B?S0Y0VjVXRG9SVzJIdVFZTk0zMGVHRWVQVWJWOWdBSEx2ekRmZzFrYkNSN0c4?=
 =?utf-8?B?MkFSbHN6dWdOdzRBTnpjbGhVRTNUNjh1MmtUS2piYzNudVFLMUR5amNSR3RB?=
 =?utf-8?B?a2NaYzhsR2ZtRGtabUl1b2RyWlcyS3BVbzAzblRGWjNNUkZtK3A4dmJseVRI?=
 =?utf-8?B?dXZjQ2dOQTdSRktJM3d0NFhVdVNEd0FGVUJHM0hWa1NMbUNxSWZicCt5N0ZM?=
 =?utf-8?B?OGZOck41Mi9zQUh1OHBTVlJod0x4ajVidjNVZHV4aVFNL1UrczV5OGpjSzNs?=
 =?utf-8?B?RmhvTFpPSHUrTC9XNVp5dHdFYmxmMmUrUzlZYTlnM1FaUjEzcmpOd09mZE9Z?=
 =?utf-8?B?Zy9ZdFBGd01FQ1BXV09LVkw3MXZmSkhKT2JFZk05NEIrdlAzVXEvVzhtcmNG?=
 =?utf-8?B?eUM5SGVCSFc2aFpBMGZlS05KeXNLKzBHcVFNbVIxVXYrRWNFNXhIdXRzWVVC?=
 =?utf-8?B?MGJXSWo4ZExrcWxJTTNKdC9LYjJmTTZVcEpFeVE0UFVtQ0JudlRrUUI3Mno2?=
 =?utf-8?B?WVUxaGFGYTE1anVqK291QVpvcHRwOUtTU3NTWCtYbTRoNnNxZWw2Y0YvUldB?=
 =?utf-8?B?WEpZMGlSTHA0aU9DSHpOOG1xU2dzM3RSYlBuU3M4cEV6TUVKaTl1NDk1dDRs?=
 =?utf-8?B?K2daMlhyVGJGcGQ0ZXpKSFFGd0Y1N09BZzdvWVhQeHAvS1dZU1U2eWtXL1RZ?=
 =?utf-8?B?VlZQa2s0bklhNFNCM01BU2p4a3h5RFRZK1hTalppUGNLNEZsbE0yeVhxUVcy?=
 =?utf-8?B?VDg5SVVxYU5VVk1zOUh0UThtZjB5V21RY0M2MHk3YkJWdVlWUW9Ca1dVa3dq?=
 =?utf-8?B?QmtqRVBSb2pRZnNTZjhsdFBwN2VoSU45a2lJUVFybVp5U0lTckJIZTkrQW1p?=
 =?utf-8?B?QlFwNG5iMk9GQkQ1VHlWV24rOTc3QnNwY3FnMFd4NGFCaDgxWktCNVpHSWdr?=
 =?utf-8?B?U0RmaWViTHBTdXAvekVFMTRjZ05OYmd6bGZWY1YyaDIzZDNmYTVYMmdONEVI?=
 =?utf-8?B?Nm5NcHdQVGl3YWlHbnVjcHZoTVY2RXdXbUtzaXBOa0tVNk9VamFSSDhGRGNk?=
 =?utf-8?B?Z0U4SjAxVTlkRzFIcEl6UjZpWS92UVRlelFrZkc4YjlMU1l6ZEsyRWlBQ25X?=
 =?utf-8?B?UndDb2Y4K1RCQzQrem1sMUZlRDlicSt2K2Vmb1A1Y1FSOHIxUGhWMFdveWxG?=
 =?utf-8?B?TzRaY3Z6dENsdzQxQmVCQU0yK2w0SHRiMFBDcW9qQWVsV3Y4UEJZQnRVZFhQ?=
 =?utf-8?B?eFRpRmd2dEg0RExvTS83MUhXT1IzemhVbjNIblc1UEU0WDN4Z3oxeWdXRTFY?=
 =?utf-8?B?K1prZXJUWHNQeGo5ZHMzUGMrSTVHWG82K01IOEFGSldpTE4xMnRCV3ozZEpI?=
 =?utf-8?B?b2NYcWZkSndYeHFQS1p5ZnY5QzZTNHloQmwwOTMva2hYN084bzJ3Y1c0bnF5?=
 =?utf-8?B?aUlNOTJmNGd1d0kyRm5jMEpTSTJoZ3RPZHhiSFRoSy92RWdCWnRmNXBUNG5U?=
 =?utf-8?B?TVVjUWt3TGtkN1lOekxicFVEUkRuMVJaUmJYRnp5Rk9ZSDBiRWhVdzdJME5k?=
 =?utf-8?B?SUlhTFhLWmxqN2NoVTVwTkpkcElvM0lQbm41RGoyalRIUWtlT0lpN2U5UFRi?=
 =?utf-8?Q?VqnNuWNMH4zQm9PG1uR++hfO3bKzR+OVm5/r8=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <49084480B4A9FA4383967A57B4420C17@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b4336e-54c1-455e-3d1e-08d97965fbfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 23:01:57.5397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRmkurcKCjsIfYQMaKQULj/wdUmkCtuW/AqAS8yRN7gKiZlC5/HqcDn81Ilpq6KFHfIpoIzrarJCK5km8ifatA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210916_160205_038651_803B60D2 
X-CRM114-Status: GOOD (  12.32  )
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

>>>
>>
>>
>> Where is the definition of the nvme_ns_get_state() ? I didn't find in
>> this patch, and your commit log is not helpful at all for the reviewers.
> 
> It looks like patch 1 and 2 are reversed.
> 

Maybe resend with the right order with proper commit description ?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
