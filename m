Return-Path: <SRS0=DmOJ=7U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FB5C433DF
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Jun 2020 08:36:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319BD20663
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Jun 2020 08:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JUCexx8S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="n8bV+bRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319BD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PvM0RCZgsFHPMKbAoX10joHQvILP7k1MmqP6tvITxtc=; b=JUCexx8ST785v3S+FDXP1yqQr
	4pln4pQodPzN6y9b7F3PmjKbYYlkq7K6MSvhaE+gR3R0u7rOBBVUclAVzlK2CLb5bMtoVqAdbUecO
	kqATivAMTxHioPkazzS73c/OEzPL99MVQ+9e9QMgdKIou+hPzrfhJwIcb6h3i8Z7D4R2R5WnVjSCi
	IGLl/aGgDm/KZwWW919zWlO8+JIHhSWH6d+lZBvyh+Il6kMwQfCAqme0RvAzNGJ8V3t7cBjCWusqo
	8GFszy/rwjGLnhK043lde5cNS9RRyuyfGDfHWJfDejeFcnt8beR/Kaz9JKqwZWZS76gpWS2jc1CfO
	rOQ5tFcpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jhqnK-0008H5-Mf; Sun, 07 Jun 2020 08:36:42 +0000
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jhqnG-0008Gj-VI
 for linux-nvme@lists.infradead.org; Sun, 07 Jun 2020 08:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m80/kFDO+Rrtai+yxsLmetmmZRq9UXInJRYfVLObvN7Sujjujzi2jJpjgngbMNYRfsvnpK3GrZzrrJMllDzmWo5jA7rHWCs+DF231DHCxRcEqblhOuxMNQID7AMJyc7XmkSVN14zSbsSVivUZZ9eFxywAkOYkO11YvO33H6ApOJMbbvVvuO/MBGgJ7Zi+wtNjTKDF4Coz7/w9B56GqMcb1em6sU8rg12+tDlt7QrawMEyLJecoyuUfV1iXMxdZ5zwBdY6AxZXGldBmfRccMjN8EJUnl48ujjJP3DlZYFBT8G4jh9D7sBO1HIBQXHZBvnBkb6vRudrqGHYgq7SzOYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SO822xrSDOb1xMh/gmsAUo6FvPDLyiw9oTOAGsdppDA=;
 b=f134B15JcJrHXs8V0PEZdioFFvwyCTQtuBgEo86rtoZ9UDvqFpD/zaeFSzAI/MycKuLjp9dXcNVvUykhXvcMVfJNuY9+asM+lCnW9XXrj1Vz4aFFwHV2dOk0Z/sKrh0mc8pTlWxAmDC/IMxCTlDPdBRGnGcyQf1MkOvW7R441H5H0lbBGZjCGFo8cAQi4TYOORxroOdyUySi1Ppk/mRGbILIrqWwLnr6QJTovNDgjPwiJF+/NKIn0vOy3IsvAR4kzi6Bl9KaSIwqWe4v9UbQy3Mov0K07hj2kya55XHbll3wKVyBUMBYT0K+dTGYeQCRpkQBST9FPDWJKpb8NToqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SO822xrSDOb1xMh/gmsAUo6FvPDLyiw9oTOAGsdppDA=;
 b=n8bV+bRlTl2AFdW3pxS7dH0qTK6AjhiAV+uvD1eeGDplvFH4Lpx/UJnmZ0hrOd52JB/8FtvufqdNh/Ztu7f5wn7QMZIKACjiYU5hJspQojqmVVrf9RGvupwdldYCzrb3ghF8q21xVEGsuxVDLQdleZYkDX9Zr4mQeGI/N6vs1Mk=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6019.eurprd05.prod.outlook.com (2603:10a6:208:130::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Sun, 7 Jun
 2020 08:36:34 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3066.023; Sun, 7 Jun 2020
 08:36:34 +0000
Subject: Re: [PATCH 3/5] nvme: replace transport name with trtype enum for ops
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, james.smart@broadcom.com,
 chaitanya.kulkarni@wdc.com
References: <20200602131546.51903-1-maxg@mellanox.com>
 <20200602131546.51903-4-maxg@mellanox.com>
 <95ef47bc-bd1b-1935-fd03-9470e033f265@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <0ecc4a81-e682-d5ad-96e0-559560c4efc9@mellanox.com>
Date: Sun, 7 Jun 2020 11:36:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <95ef47bc-bd1b-1935-fd03-9470e033f265@grimberg.me>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0122.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::27) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM0PR01CA0122.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Sun, 7 Jun 2020 08:36:33 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34cc7d86-d886-4dc4-35e6-08d80abde2f0
X-MS-TrafficTypeDiagnostic: AM0PR05MB6019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB6019C9E75AB31C80B6B61902B6840@AM0PR05MB6019.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04270EF89C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ak9RlQyRi/mrfGALhjxZp8uvc85hkeVoIomlsl3N4DplThHAuS/T8c/PdBrNqfJVrLxZvnHRp40RBz8A1H+7Sq7d9uflLmg/V/m1hYNbgzERJjaIic08y0hwELdcbCBMm02ljRoTkGAOY388rygnX2I4n1sNgkNvcwyRnJs31MlF8cAbAl8KKSjqCR3hvZKQWZ6dNZh+vW7qsZCN25JtgbDW8sQoVHHOmXX37kFsdPj1C9QQ3gscHinHy0nSpRluJf4aBjvzOjPNqK8dKPEYO5OJ1Lxf8vVrC4Vbx4IByhrYvrgjn4IMrFXwvb5S+OgQTQ6E0XhP2e9UPXVDyqENvlB08mDmTBSPrxfJFMRAlR9QOTAF5pbTSOgFoW4x5gW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(2906002)(86362001)(5660300002)(31686004)(4326008)(53546011)(36756003)(16526019)(8676002)(8936002)(66476007)(4744005)(26005)(66556008)(66946007)(186003)(107886003)(956004)(52116002)(31696002)(2616005)(6486002)(478600001)(16576012)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: M1OmMl5YI3Pk7mh9OuTMpP/DPtuNBPm8Ai8rj3hbI29dANSbPiRHoVbcXfKzTdEommPfmPSvl2+Izkre3PgcqSNCebPpLwXk/oQB9ZEoVDglNdJGDc6l0BwUFKpczqo1wkpmQxtJp4Q1fKrFfepuxJy1oPzAhTUzjHT7ElC6cgWT9LXwyUc/DKsPlCKnIvFjGxv3sHGg+WJmgL/SnauUXPbA5uGgfA41beFBhdB5xXk0iv3EJoRihtf1WF3v5LCFDDX6wy7QQF1OfLr3sXNxbQhAiud+GhONkDQ/ImsV1jN0bQZiMmb9ZFNQcSLYpStRVRk98jqiSbQrfJxjLTH/J8IcAuEkQVe34rHfOkAtw1J1qvXZp4zESbN61B5KhBn1u6Jeq5y6A32AYG6O8pOtLUpS/LOuCvum6w1UMlcOKgPEgNGdS4bvPEpvNjj8K/umUiHzLajylt1lmIIC5O6FXD5jMsz+cLf38EiTmZbxcTE=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cc7d86-d886-4dc4-35e6-08d80abde2f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2020 08:36:34.7613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 428SyOxOl1C2BFU3BiGOV/5NBV0MwWJUkQJIfW0RaGMDgXBg2Lfvl93h7NGPZxjFwZyvJu/Q0umFIy7zIBlKmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6019
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200607_013639_078611_614A86E1 
X-CRM114-Status: UNSURE (   8.81  )
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
Cc: israelr@mellanox.com, nitzanc@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 6/5/2020 7:49 PM, Sagi Grimberg wrote:
>
>> Use common code to map transport type to transport name instead of
>> duplicating logic.
>
> I'd prefer to keep the driver ops name and not rely on the trtype,
> userspace passes a name so I'd rather keep the transport registered with
> a name.

Userspace can continue passing names, but why not using common code ? as 
we do in the target side..


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
