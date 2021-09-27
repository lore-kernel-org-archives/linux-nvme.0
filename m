Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58867C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 19:24:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C50960F4F
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 19:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C50960F4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+Dz6L5z6Zgy24WSJZn7SMjv/WW7Gy9BXiahSBF46mRA=; b=HAphII7T7c+LIZ
	M+nTp7cJtfcQQAC63mr86S7JmKU8F24iCFxysG4a3IeyG5EKKUbDTbYZ1QrGGAWp9F0R0oBQfB4M+
	E39IlR2NkWOclsoCxI/aY/LP3k3mKukDwbcht7VWHI4s8TpEYnUD4jDbFmcQd9kPS17OoGWb9a9Sv
	3yBh2Edwt7htwoydRg6JPGdsDBwqOAzC/SycrTX3DSAsiSgUsJavvA0iG0EIYuS9VmG4UkzyWov0o
	rbgc+zh0Ee3kHsCqk1Sftu7shIm0OEMbR7RP/7JdAZnEP8CrH3N3FQ//lb2J+mExbEYmYQcXYC1+s
	bFKBGX7yLso76fhyAmyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUwEM-003z1b-IW; Mon, 27 Sep 2021 19:24:02 +0000
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com
 ([40.107.94.52] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUwEJ-003z0k-HO
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 19:24:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oH+RCkP5IVIbuvYrrJDTwL++V0ZKdbPXKUhxEyqv2d0BoRgycIfkwVtsrLavW9W3lxfx2w8TfHxrJmQYpWaFGs7KbWwOEdh/rGMs//OPe4kNIxoJHbbkWwffuMGx6RcXq+iDT+km662hvyRzvZbuG6LLCNlMSntHs+0X840mZm7jRVLgYQ0Ea4GZQafmMKg5LgNZ+pLL7O4BcYtup3T5I+GLUCYRH5F/BxkHXYOHCwaxuXbjtl5KI5tesieqxLud/DNOY75++KmVyoLK1vAcuEnqJYG8OeDD3C+NDwgy5xIpoib7LdFRGLvIriKPXajS7RdafArsvwho9ewfBhq78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2XWDDuYRdMwRkwD9tyZXajYngUos0dZRokWG2b8F4Do=;
 b=kltSdusoeHoAiZxgp+iJhrp5z+tBPmBvIC4Pyh1DI7+qHtkOSWzNi6+LYpfCIOqytUir4ZoQ2HhAi+Jfv6fNJ8cMXv6Cgr+pVfFqBNXq3DA8Qt9U1DdzXsX3BL/IRSYaSOOiQkB5LS/fJFR7PCAi7ST1j+Mb3u4d6XKRDJrHvdEQUGR9IG/cmk4u+/hdQT0HGTjTwTn6HOVi47aw/rGpxYWDge6A10jDBr80674+J3061TqAig55k3XYgta9CxH5EoVqzefZFboUwu9g3q7gmzP9xTndm5DHG/+opza3uHS7vc073thX1FaukDk8ujwJZ7bOze0/TvSvKo6lOICSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XWDDuYRdMwRkwD9tyZXajYngUos0dZRokWG2b8F4Do=;
 b=ojyVMsyKRNac3uNzFnFCZF8WNuT/SslcrJuiZEpKWVonQtrSlKf8N/aHv3opYUMlbuKe2zsf3K3BxtJpCQoLVWwKE/4bRLyVtIpWeb6wowS92q+mljRWi7G60zhzfM30t3tQfTuZxQfOn2gJtsPUOwMreoAT6EFP3oqX+S0HJu76V2R6ioCKxj1lUbdu+RakjetzpXTs/eO0Hy5PYabbJhLmqWsya6PBGuGBAr2M2Nb9ChIA35Utrgde3QcoBFB6OV/RmIfWH0za4Bo+AwH8gqFq+MipSrL9HVfl5CwuF84PZGGlDUVMN3AS7vkYwBlwN94Q3NVD5ddFLZkJBBCdVw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1581.namprd12.prod.outlook.com (2603:10b6:301:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Mon, 27 Sep
 2021 19:23:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 19:23:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme.h: expend lbaf on nvme_id_ns, lbafe on nvme_zns_id_ns
Thread-Topic: [PATCH] nvme.h: expend lbaf on nvme_id_ns, lbafe on
 nvme_zns_id_ns
Thread-Index: AQHXspANfjL+/pB7bUiUDJhl2MyIsKu4RUgA
Date: Mon, 27 Sep 2021 19:23:52 +0000
Message-ID: <3c21e079-45fe-b09a-b250-7f4f1e18db04@nvidia.com>
References: <CAGrZSEyrdJaZkHX9fPse0bv3d1x-HU7vvPQeg5JyR++_hOs8bQ@mail.gmail.com>
In-Reply-To: <CAGrZSEyrdJaZkHX9fPse0bv3d1x-HU7vvPQeg5JyR++_hOs8bQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06f2a3ea-7203-4b04-e3d4-08d981ec576d
x-ms-traffictypediagnostic: MWHPR12MB1581:
x-microsoft-antispam-prvs: <MWHPR12MB1581B2E6780DCF3C49A0E742A3A79@MWHPR12MB1581.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:454;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sg0f5EqBdXHvJKj5gdN19enNL7a//zx4NywFZazhUNWl6OKXcPjIVvgUHOveEfih+HomBkMFqvc2Hy/HdtF+bfbOSV1Zg4Ceiy382PvixvAKy7FBm2MqiLt9GqsktofdUESaQsn/vgFR/+1RnkGZ/U4vZLi0wRDmHLlTGOxpOmxPLbyeUC81U6Ht7Qdgzbb4f6q+haf93cMRJTgHz35d7dIW+vfKhFK6qKLKWXHxSEzddh5Qmk7KEp2az8LXDi7jTOPOKWVe79oCD9IxLugkNTl2BkxKfR6chiG8TmiKldqj1Z9jVzAKCoaJ1bdeH6dFoUiOMon8jWLvNTlXlW+hC+47e+ft5ZqEvMNmY0+Yh4imdx9zmL9U2ENW/sdCywBUryZYYijcPce4mjE2GK1oloLJ14yEOcIpf2uaGSkQk/99T+RhJpLQUsZpxLSXIKPu/iQy5J+0ntqnXnySpNjho2vQF3jkkjcCRhjdGzoNdFazU5Npz843+dTdDV1ZeFeJIKUX9MH3AmHatGoW8siVd/iBJJw2GDoj8Dimx/SneNZGLcqKn4kzOT0yAFTqJNngFgO4DTRRYIF0gSSzyeeZfyAB8psumjIhubdg4grmSIZgG/1EqdVFB+3BhPA++YNA6F4e59zWiF5MVcuaNYGLBGNwLkOVMinaqEj5wCebtjALTHHqOPWbRKdJnKkEV6JKey5Zz1LoDUViB0hjU8AvnR5nD5uXNAnveznhJT7/zwKJpbzW58aHveXbHxpttHqkBN5Lgad9Y7m+ts2CO0CSig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(508600001)(31696002)(558084003)(31686004)(6486002)(91956017)(66946007)(53546011)(64756008)(122000001)(66446008)(8676002)(38100700002)(5660300002)(66556008)(76116006)(6506007)(66476007)(316002)(2906002)(2616005)(86362001)(8936002)(38070700005)(71200400001)(6512007)(186003)(36756003)(6916009)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFpHdkxBOGpaUWk5L0Z4T1ZHdHZqNTJYUk9BeGdrWE5kd0lvU0hNN3UvTEJ1?=
 =?utf-8?B?V1RHL3dUalBZZUQzdkNTK3NuYTNMcUJIRGVrVEVRcEFpVHV6QWNsakhkOGZw?=
 =?utf-8?B?RzhtVHl1cEVZMXMxVEhvTzVrZnh6ajdkNnFjTm1qMWJ3eVF5SFEwUHp1bUFx?=
 =?utf-8?B?dmJXd0tkMWIzQm5aekdlL1M4Z2JJL1JQWW1mMTlhUkpXeG5YaCtzUWRKTkZL?=
 =?utf-8?B?OW41MUc5OG1SbTRVTFg3azNOQktMamlhQmlqM1VPRVhUSVhYbXRCQTNnZmNj?=
 =?utf-8?B?N0VSa0dzT0NocG1aUm1naW1XVnRmWmRoQlpiVkp2cG5oamd6aS9KNk56VFhp?=
 =?utf-8?B?VUI4aDZncVRjQkUwSjdNdkJ2dytJVjdXOTNrdmcxRXplbWFhSHNYTlMrOVNa?=
 =?utf-8?B?R2VWc0lTRTlUV0N0VU9EUmRKOHpEOTdSM1FZeWlyMDZGOUtDaVUwbFZTQ2M3?=
 =?utf-8?B?SjRVb1N0YmV1NlBJOXFKa0tqb25vR0tBNkc0MHhseVFSM21FTW9NZ0RnSDNt?=
 =?utf-8?B?RkF5TzljbTBHVnhXcG1kTUQ2V25BKy83YWpEb3BoNS9vRDBNWDBJUlZRTTNp?=
 =?utf-8?B?NGd6aXE0bERNT0t2Wi8xSDNQTkhvSnBvV21ZREhsR3VIRFNlSjZoc2pwSk9I?=
 =?utf-8?B?M0FHTkZtU2xubTVxakpuWTRrT3dhTFlpY0tUdG1GblJjblFhSkdNYWt0VjRr?=
 =?utf-8?B?c09oRmdDaXIweFROallwWnJOQTluZ0lxZ0hnaXRmWlJiMVdqUk9jV2RsUVRm?=
 =?utf-8?B?ajJQTkZXUzRDWTA5WnZnVGNCQ3YxaFp6YngvUGY0WW80aTRwaTVkK2kzMEFi?=
 =?utf-8?B?MGdPRHRXaEl3UmdSZm9WSXRkK1hZTFdtVTN0UndoYllaVDNRUWZsSEVjUjV4?=
 =?utf-8?B?WGhqZFpHdHNqZlZWRDdXWldUdmJ5cXhaSFdSN0NYNlVicG5tZGdldHp4WEFj?=
 =?utf-8?B?eGIzdTBBTlgvUTJKWWdvR1kwL2t2YVI4RFFvTDRnME5vVzZYU3NOUCs1elRN?=
 =?utf-8?B?aldXanZGNHpJWkFwZzdndjhkb1dTUCtiL2xtd2ttQXJYUnYydmtwUEI3cHRF?=
 =?utf-8?B?c3BPUFNoaHp5RmJmY214WE9pdndPR0ZOcTdEb3ZPVkZwbm1aTmVIL21saXA0?=
 =?utf-8?B?OEVQampnZzd3LzQ0OUdMTDgzNk9SdlQ2K3h0MlhKUUhiQ1dPTE9JQk1zdEZ0?=
 =?utf-8?B?aExwRTlMMGJOZkU0ZTdOVXhzdDZQZXZnMFUzcWErNDdmWG52MGx6cC9rVE0x?=
 =?utf-8?B?NUR5TUpjTFM2NXlGeHkwdDRXVkY2K010SVkwWEZiVWdWREFVZTN4dVV5Unhi?=
 =?utf-8?B?ZU1hTnEzRGFMWDV5RzJkQ0RLRXVsdE9DMDZnVEMrZzI2aXQ2djVPRWJubXJC?=
 =?utf-8?B?Z1VLb3VEZ3dvSlRiK3pjVTd6N3hQQnc2NlU5M3ZuWUdFV2N1Z0tFWHQxK3Nl?=
 =?utf-8?B?akNBdjRoTlRYRjVtMDNwSDVpdkg0emQ2MzF6U0c4dzhvbkdNcDB3ZWVpUFIz?=
 =?utf-8?B?QWFUVTJhcDFlT1U5bTQ4THNnN2lJbTNRQ0pzRGxCb0FHZmlBUit5bXA1REJ1?=
 =?utf-8?B?WkhKUVNYa3E3d250d011VVJqeTU5SG9udmZtVHloZUYvQzhDWHI4UXk3cDM3?=
 =?utf-8?B?M3R0OEFVaU45TklTWW9Tb0h0MmJ2NDVuOWZZVWx2OU1MMm1LQzBvdzM4dGdN?=
 =?utf-8?B?SHFOYTg1L1UySkx6b1d3KzhxZVJFTFFtWW1PdFlXVEUvZS9URVFOVjlGaThE?=
 =?utf-8?Q?dXs+vQxH7e1g/ionoRZURr4kxyp+4sPIJsObSec?=
x-ms-exchange-transport-forked: True
Content-ID: <6714E83E42CDCA458B32341AAFBDBE7A@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f2a3ea-7203-4b04-e3d4-08d981ec576d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 19:23:52.7600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jw9D9pVQhiiUTZR3QOWYUBqbrgOrktEOnLwZVujMXElMCmM3Xo4Hp9kE1F2RUQNTqPQojS4R+PdVkPE1/9bQ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1581
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_122359_603710_B19BAFD9 
X-CRM114-Status: UNSURE (   8.57  )
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

On 9/25/21 9:34 PM, Steven Seungcheol Lee wrote:
> lbaf, lbafe used on nvme driver
> Base spec:
>      NVMe-NVM-Command-Set-Specification-1.0a-2021.07.26-Ratified
>      NVMe-Zoned-Namespace-Command-Set-Specification-1.1a-2021.07.26-Ratified
> 
> Signed-off-by: Steven Seungcheol Lee <sc108.lee@@gmail.com>


In its current state Nackd.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
