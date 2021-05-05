Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3C1C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 14:32:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DA5613BE
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 14:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DA5613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NwfZHYEPt4/uwHt51s+If26H/q1U2NqZRbxaBZdIjk8=; b=MXq1fHuj9R0gB1HD5NA5CldJc
	3nPgXMOmnZPRg5/jRp0zAUrMdc3Pew3ew8EFhpod66ngMUWZtOFZgum3ZAMscBzw/C58iQ2qI9Ibn
	Et+wsyMUWj3cIlrxAxCkcus9hmo37X7RNqTSBOea+nkJEe1hMN7zoQrrcRWIdw+yH5d7gr6ftw3R/
	rS9EVSi4sVOPmWHKL8sV6VvxhaNDic23V0uSXG/0zn32vofmFi8N95Hvn1pXVpmH1MrH55bS3icpb
	2LnyCj/bd/Sg4KLtr8fIhLedUX2DZnrthO43dXfcdYyCXJZx/fKaB5KAbXcqUNv4VkeIPuKGUU2gN
	eNq+zKhTw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leIZA-001RKH-6g; Wed, 05 May 2021 14:31:56 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leIZ6-001RJd-6k
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 14:31:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=yzbLz1J7Nqdm+c1dIBAoHRlLVCGaCRS2wKGMi+BXdeE=; b=Zq2V/xJVuo25e3tCPI0Rw8i4ty
 oOoCWJAxHr+BiTQfJpGOGcfQteDsQJT8eTNHy08D34btd3wBlQCMr8PC0jQm6q1/vU0SSdr6ej6be
 ycl5jquLuf+wns54TXzdO7H3gjXeUxUuoogYav4exIl+rLGqDioTaCJC28kE7p3FZc0kVzKNbbsK0
 e9I/+4psKWx1N685WAO8XeSdRWfTD823i1gf96c35FC4/nQ8vp6jcx/mMrzF0pw+sUEssAcbdc2Sl
 WaJdo/w2twYiCsoMb6ncUjxj2gRpAcYDLQboXUU9LovOKl7V+rJjyXzlupx7Iy149T2TQcDNcyqJi
 K4tb2FXQ==;
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leIZ2-004pPX-9g
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 14:31:50 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 145ES9Fr002262; Wed, 5 May 2021 10:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=yzbLz1J7Nqdm+c1dIBAoHRlLVCGaCRS2wKGMi+BXdeE=;
 b=hFGmfyyqA0s7vivP0gSjYHte39SCY87MTjVO2rXMPMuyr7RMkSYQUA+hi95/XqrrAsm8
 R0JfrOIFSwbucvkMArKVIgW/tiVvoLvkLaKt8k5J4GtSUYmbAbC3U2PL2Lxl+d/Tji/7
 rRMs6WyjL5PMzUTZSvH0ltN1QrW2RvPPwWRM+OyYsBcjyxdjxZvkmp/TTg0EddICHU2W
 DtwDG4vYKQ/3lKXEqqitQA9c0sxJ2M5YBNIb99fmvfNYTRv8Sj/nkyhik8jCCTxhr+Vp
 1yHTmgx+VHSmmoDWqvVkKEFsK7Ted09WiLFkkD+LqKQmtq+MfzlQalFD6knj8kUG1KpF xQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 38becc2y7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 May 2021 10:31:35 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 145EOkX6143309; Wed, 5 May 2021 10:31:35 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by mx0b-00154901.pphosted.com with ESMTP id 38beauu2vm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 May 2021 10:31:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGG98a9b9GaLqI51OhsZngftW+fUbfp40QJ4SmSx0HmUwBjLfkNive7TLG646fkRGwsWcRr4PQloaHcCofdPghBZq2WafF1N2zIMsGI1GqshT3jMTb1OMpl9QiI4Vc1G9vMzruW2T0nm2GjWVe5cxBFJv5O3mzqryyi3tGL0F7h3hY+aSVdhEYxveEFJyHAlVzwyBph//FZMkV52vGGvf0Upjb2wCZDyM3FCD6Zq+f7NJy8/tLQI1V2pelra+p1QwtPsd3N9iBdpTe3Ru8jNLz8z3HysQeowFT0sOOrSYmCrbNySvLI3b5i6c9SlaEsPBb1nPSCnm56zqa1pf5SLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzbLz1J7Nqdm+c1dIBAoHRlLVCGaCRS2wKGMi+BXdeE=;
 b=YGaaX4k1GDDnLq3tWW9t69kX/DGq9wSJ+E3SinlEfhoTsZrw+GbJ+ars7tMGB9k6XPhZxkKjzmxQqQO14H9zqmfcBttTdI51gBQeWkZOCxievWngT0LGNEBZlLDEE2Or+/ZRJBUB6v9LOSq6dWQCopmBRor9J61n6GBpx9VZyLSEozPKOhFuVWUphk2kZA7tP3VMxSG/2glaxI0X/0O2SZ+uJaHnNl0/NsvFrEveA+SVPrcVPCihdh/hhbbV2w7sh78gZwiMthdIIJ6m/CzyGU1aSnfz3CzzTdH6Xl9MagaHevpfVl+dobWj2lCpVFkiT01zkD6/hNvlQzDLYYo33Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BYAPR19MB2264.namprd19.prod.outlook.com (2603:10b6:a02:bd::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Wed, 5 May
 2021 14:31:32 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6%2]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 14:31:32 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Martin
 Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection. The
 driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
Thread-Topic: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection.
 The driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
Thread-Index: AQHXMi3Bh57r8OJ1AEy+hCu2vgTdtarT2uOAgADXPwCAAE3cYA==
Date: Wed, 5 May 2021 14:31:32 +0000
Message-ID: <SJ0PR19MB45446577ACEA270069ADB738F2599@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
 <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <b47456a5-69ae-1f33-30f0-aa25906668f2@grimberg.me>
 <27a0071d-7c7b-ee5b-41a2-d5eb8de12928@suse.de>
In-Reply-To: <27a0071d-7c7b-ee5b-41a2-d5eb8de12928@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Martin_Belanger@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-05-05T14:31:29.3749960Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=9872fa08-d9c8-45db-88e8-6182443ece1a;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40e29056-19e3-4222-d02c-08d90fd27a96
x-ms-traffictypediagnostic: BYAPR19MB2264:
x-microsoft-antispam-prvs: <BYAPR19MB2264B6DA920C8C0BB24D3DE8F2599@BYAPR19MB2264.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lwn1UY91/+HInkOAgV4wOC1pViSiRj++GWDTLkbpBwREwqxV5+CuWkThLwXPxlYU0TuH2mg6es68aFPcKpM58qHW/mm8MjHAMyQgQiXskm7hB6supdUi1pKt6/OkG79SkDlNMEdGKpRlX7UE5bCTE/WjyIDetPH04aMtztPXjI1wOLFn2mRXEKhfbTe6X21c1nMazkVONxwzX2SQ7Ek0aZk+bJYJOs0YGw7LXl0Cc5l30v3KlsjaPmmH1VklL8icHpM2uk4EMD9Fit+52Oxb5fQZ0bSOWf3NNZDXx2+tjvPX3qGkH9xC7es80MG0WQ3ZCBXn582o08SH9KyTi6bS/xh1PE2Q+EYLNc+rdktuqldMmdn956F+d5j77QyVPenwYTVGhs7P6cwxyIYYyACP8VS9iFCMZELjT7qg/irqZWD+t8fkq7Zsrogeeu99vV2mTMDE7bn90gVyhjk1NA3KRt/8boLR8qKp3RNWxBlUnQkMUKeIWsyb4cRh3ouCA7R5hdBYDznjO44TL/Cq5JFcPJylYPtf5PQgWP/LuZK/L4C84SyEnDbaHfMo0h7/Y3s7RTXsmw6054IVIkoTskBsLiXusMnnPv8pnRHo4J8LMTHmIAjBu6TSYoGTW1pZsXyeVlfITAwbRKLPKV2hIQ4v7ehwTh8CF22SrfD3xYBHM+3HN2S0DLdYTQKwiIR8Xk8m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(316002)(33656002)(786003)(4326008)(71200400001)(110136005)(54906003)(86362001)(66446008)(66476007)(76116006)(64756008)(478600001)(26005)(38100700002)(55016002)(2906002)(186003)(53546011)(6506007)(966005)(122000001)(66574015)(8676002)(52536014)(66946007)(7696005)(83380400001)(5660300002)(66556008)(9686003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?eG1zLzM0RytXWXZwQ2RyK3UwNlV4K0pjTW1Yb1NNVGIwd01DVGtGcTltbE1D?=
 =?utf-8?B?QWVFb0lESldUdnJSRkN4emRHazN6eWMrVXNGTmExT25mRVVHL1I4MXJQRTBS?=
 =?utf-8?B?YUp0WThSK1ErVTVDYWJ4YzNxQTRwTDRiZ3EyMW9yOFRuRHVvSnZYK2s3K216?=
 =?utf-8?B?YXN0UVR2Mzk4Q2N1aG1vSkZtYWg0MHhsSzdUN25qYnZGNlhRU3lMV3IyRDZY?=
 =?utf-8?B?SkhicnV0UUdud00vQTZPRW5EUG41TFZzVGpPanIycFVrUlB1R1B1bHdOeXIr?=
 =?utf-8?B?LzBqQlhMbDA3Q1laWUx5YXdpb2dtWERCNVhmeGQrSVJDUERsYktDL01pYWRE?=
 =?utf-8?B?NzFVcSt6SzI5WW1xVkM4Nk01QkdUdGxSV01sZ09VbGtaNkVhYmhqY3pHSHFN?=
 =?utf-8?B?cTZWS1BZMWo1VkpVQXIweVFkL2JnSHFJaWhpb2hqK2l6QVN2SnlxanNSWGdD?=
 =?utf-8?B?VWhsSzFiQ3ZwUE56UFd4cEkzZW5xUmpza2NFTHVPWHNkRUI0N1gwQkRydHBj?=
 =?utf-8?B?d2EzTjAvS3hHeXRpeVVBS0R5eFZ6K2FZUWduRmFuMEFvT1VsWjJHVDFVZ3hX?=
 =?utf-8?B?Y2p3d1BhZGVJQnpJTnFFWGt4WEhuS1VOTWw3UGJoSUtUamxnOFBmMkFwdFI3?=
 =?utf-8?B?YU5QU1NoYXRkUTlUV3JRQ1dtTEZNNTlvRlVDY29kOWI1ME4zMFFxc01pd3hQ?=
 =?utf-8?B?MHNqL3NaSS9tWEhuMFpNK29tWlR4WjZWTFV2emU0SVlaZ2VzYmgwa3FjQldn?=
 =?utf-8?B?a2xPNGhnQ0VsQWdVVnRJUnZFd0JaTlExZGpOVDVXRkVhZmFHUHZrY3lIZXNv?=
 =?utf-8?B?dFFxN3JpU1dhSHkvTlJnbUJHalNvbjRZbzRZc0NMT1ZsM0VscXYxdEcwTXpn?=
 =?utf-8?B?QkxuU00wV0dpNjlHeEpQQU5CRm4waW9XOFJpdUVKVnF4ZG1XYmd5ckdXS3Ar?=
 =?utf-8?B?VEdKeXYwdUt1WlA1eFVyblZsNVVGZkNkVzRTcnYwYW5wb2pmaGZKVUdYWUdK?=
 =?utf-8?B?SGJjeTdFcWczUVQrU0FrZmJpOHZVUlZWQkl4VWNJRm9qMFJNU0dwcVdwYy9S?=
 =?utf-8?B?aklvT3B3MXk3eEp5L0hxRVNMV2tEN1Z3TzFINVRDSVp6Y3FidEJQVWU0T2hC?=
 =?utf-8?B?aG9TRjd0b25hM3RqU095SmhZTEZ2RXE1bi9jMlk3djhnT09IZU1BMHpFdnM1?=
 =?utf-8?B?aHZ2M0JmQkdEN21Kc2NHNkdORzhKYkFFeitRTWIrRDArY25Zb3BqclNHeGhZ?=
 =?utf-8?B?U2I0cXdsMG0vUllOWkJLYVBMbnlodzhDZDR2WWZrM3ZzWmluc3Nab25XNjRP?=
 =?utf-8?B?WTU2aTRnbk1kRTNVdzJSMGY4Qll5KzUxeUErc0wrbmw4Z3pjT2NuZm85MFgz?=
 =?utf-8?B?dFlOZVF2Qk9OR1VIaDhTL0cxT0dFR3cvUXNpejljaCt0S1RkcTdoVzAwd1du?=
 =?utf-8?B?dVVlaWcwQ2xEVkMyNVhGNVVBcDNSUHVyamc0L1pnZDRvUXN0SVdYYWRMUVVZ?=
 =?utf-8?B?b3dWbTRTR0xLZlNZNGprejIwdGNtY2g5UC9wT0kvdzYzQ2xycTJkQnEzbDNL?=
 =?utf-8?B?NVU1T29EbWdmdjlUMXVXMnlnZi9DZS9QMnZzRXEyQ2ZIU095c2tLRUJxUEZX?=
 =?utf-8?B?MEticVlEYktXSmxaNTVuSHpFekpKREZoenMxRWU5NjRLMzhaMWw2b2VabXF2?=
 =?utf-8?B?bnQ5UnFJdHJ6U3ZYTUpaV01pYVZqTzJhOUlDWmJxZVgvSDdBRmN2b05GZmNS?=
 =?utf-8?Q?7JjQCENqNP02XOmbh/fgUNbXRKkHmTKK+d8Gecz?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e29056-19e3-4222-d02c-08d90fd27a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 14:31:32.2474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i8YngOscSCUGZvU24H0eNlJ3NXKR2F84By71D2Af0YuOM6SlW0WAkW7YVZamghM1vL8YvCYJ5xBS1w1Lb5ixKUbL6uPCJeQq3Vm8U31rDSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB2264
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-05_09:2021-05-05,
 2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050105
X-Proofpoint-GUID: StbIJ2b-M1xqoigT14M9AviWKjk1fi6w
X-Proofpoint-ORIG-GUID: StbIJ2b-M1xqoigT14M9AviWKjk1fi6w
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105050105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_073148_422568_8978E33D 
X-CRM114-Status: GOOD (  36.81  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5uZXMgUmVpbmVja2UgPGhh
cmVAc3VzZS5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgNSwgMjAyMSA0OjQ3IEFNDQo+IFRv
OiBTYWdpIEdyaW1iZXJnOyBNYXJ0aW4gQmVsYW5nZXI7IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KPiBDYzoga2J1c2NoQGtlcm5lbC5vcmc7IGF4Ym9lQGZiLmNvbTsgaGNoQGxzdC5k
ZTsgQmVsYW5nZXIsIE1hcnRpbg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gQWRkICdUcmFu
c3BvcnQgSW50ZXJmYWNlJyAodHJpZmFjZSkgb3B0aW9uLiBUaGlzIGNhbg0KPiBiZSB1c2VkIHRv
IHNwZWNpZnkgdGhlIElQIGludGVyZmFjZSB0byB1c2UgZm9yIHRoZSBjb25uZWN0aW9uLiBUaGUg
ZHJpdmVyIHVzZXMNCj4gdGhhdCB0byBzZXQgU09fQklORFRPREVWSUNFIG9uIHRoZSBzb2NrZXQg
YmVmb3JlIGNvbm5lY3RpbmcuDQo+IA0KPiANCj4gW0VYVEVSTkFMIEVNQUlMXQ0KPiANCj4gT24g
NS80LzIxIDk6NTYgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+ID4NCj4gPj4gRnJvbTogTWFy
dGluIEJlbGFuZ2VyIDxtYXJ0aW4uYmVsYW5nZXJAZGVsbC5jb20+DQo+ID4NCj4gPiBDaGFuZ2Ug
bG9nIGlzIG1pc3NpbmcuLi4NCj4gPg0KPiA+Pg0KPiA+PiAtLS0NCj4gPj4gwqAgZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jwqDCoMKgIHzCoCA1ICsrKysrDQo+ID4+IMKgIGRyaXZlcnMvbnZtZS9o
b3N0L2ZhYnJpY3MuYyB8IDE0ICsrKysrKysrKysrKysNCj4gPj4gwqAgZHJpdmVycy9udm1lL2hv
c3QvZmFicmljcy5oIHzCoCA2ICsrKysrLQ0KPiA+PiDCoCBkcml2ZXJzL252bWUvaG9zdC90Y3Au
Y8KgwqDCoMKgIHwgNDENCj4gPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LQ0KPiA+PiDCoCA0IGZpbGVzIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gPj4gaW5kZXggMjg4YWM0N2ZmNWI0Li45MWFlMTFh
MWFlMjYgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiA+PiAr
KysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gPj4gQEAgLTM5NjEsNiArMzk2MSwxMSBA
QCBzdGF0aWMgaW50IG52bWVfY2xhc3NfdWV2ZW50KHN0cnVjdCBkZXZpY2UNCj4gPj4gKmRldiwg
c3RydWN0IGtvYmpfdWV2ZW50X2VudiAqZW52KQ0KPiA+PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0ID0gYWRkX3VldmVudF92YXIoZW52LCAiTlZNRV9IT1NUX1RSQUREUj0lcyIsDQo+ID4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3B0cy0+aG9zdF90cmFkZHIgPzogIm5v
bmUiKTsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyZXQpDQo+ID4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiByZXQ7DQo+ID4+ICsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9
IGFkZF91ZXZlbnRfdmFyKGVudiwgIk5WTUVfSE9TVF9UUklGQUNFPSVzIiwNCj4gPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvcHRzLT5ob3N0X3RyaWZhY2UgPzogIm5vbmUiKTsN
Cj4gPg0KPiA+IEdpdmVuIHRoYXQgdGhpcyB3YXMgdGhlIG9yaWdpbmFsIGludGVudCBmb3IgaG9z
dF90cmFkZHIsIHdoeSBub3QgaGF2ZQ0KPiA+IGhvc3RfdHJhZGRyIHJlc29sdmUgdGhlIGlmYWNl
IGZyb20gdGhlIGFkZHJlc3MgYW5kIHNldCBzb2Nrb3B0DQo+ID4gU09fQklORFRPREVWSUNFIG9u
IGl0Pw0KPiA+DQo+IFRoYXQgd2FzIG15IHF1ZXN0aW9uLCB0b28uDQo+IA0KPiBJIHdvdWxkIHZh
c3RseSBwcmVmZXIgdG8gbm90IGhhdmUgYW5vdGhlciBvcHRpb24gdG8gZGVhbCB3aXRoIChhcyBp
dCByYWlzZXMgdGhlDQo+IHF1ZXN0aW9uIHdoZXRoZXIgdG8gYWRkIGl0IGVnIGR1cmluZyAnbnZt
ZSBjb25uZWN0LWFsbCcpIEFuZCBvbmUgY291bGQNCj4gYXJndWUgdGhhdCB0aGlzIHdhcyB0aGUg
aW50ZW50aW9uIG9mIF9oYXZpbmdfIHRoZSBob3N0X3RyYWRkciBhcmd1bWVudCBpbg0KPiB0aGUg
Zmlyc3QgcGxhY2UgLi4uDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBIYW5uZXMNCj4gLS0NCj4gRHIu
IEhhbm5lcyBSZWluZWNrZQkJICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QNCj4gaGFy
ZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgNCj4gU1VTRSBTb2Z0
d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCA5MDQwOSBOw7xybmJlcmcNCj4gR0Y6IEYuIElt
ZW5kw7ZyZmZlciwgSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpDQoNCkhpIFNhZ2kgYW5kIEhhbm5l
cywNCg0KQ29ycmVjdCBtZSBpZiBJJ20gd3JvbmcsIGJ1dCBpdCBzb3VuZHMgbGlrZSBob3N0X3Ry
YWRkciB3YXMgcHJpbWFyaWx5IGFkZGVkIGZvciBGQyAoYXQgbGVhc3QgaXQgd2Fzbid0IHRlc3Rl
ZCBmb3IgVENQIHNpbmNlIGl0IGRvZXMgbm90IHdvcmsgaW4gaXRzIGN1cnJlbnQgc3RhdGUpLiBJ
J20gbm90IGFuIGV4cGVydCBvbiBGQyBhbmQgbWF5YmUgc3BlY2lmeWluZyBhbiBhZGRyZXNzIGlz
IHRoZSByaWdodCAoYW5kIG9ubHkpIHdheSB0byBzcGVjaWZ5IGFuZCBpbnRlcmZhY2UgZm9yIEZD
LiBGb3IgVENQLCBob3dldmVyLCBpdCdzIG5vdCBhZHZpc2FibGUuIFNwZWNpZnlpbmcgYW4gaW50
ZXJmYWNlIGJ5IGl0cyBhc3NvY2lhdGVkIElQIGFkZHJlc3MgaXMgbGVzcyBpbnR1aXRpdmUgdGhh
biBzcGVjaWZ5aW5nIHRoZSBhY3R1YWwgaW50ZXJmYWNlIG5hbWUgYW5kLCBpbiBzb21lIGNhc2Vz
LCBpdCBzaW1wbHkgd29uJ3Qgd29yay4gVGhhdCdzIGJlY2F1c2UgdGhlIGFzc29jaWF0aW9uIGJl
dHdlZW4gaW50ZXJmYWNlcyBhbmQgSVAgYWRkcmVzc2VzIGlzIG5vdCBwcmVkaWN0YWJsZS4gSVAg
YWRkcmVzc2VzIGNhbiBiZSBjaGFuZ2VkIG9yIGNhbiBjaGFuZ2UgYnkgdGhlbXNlbHZlcyBvdmVy
IHRpbWUgKGUuZy4gREhDUCkuIEludGVyZmFjZSBuYW1lcyBhcmUgcHJlZGljdGFibGUgWzFdIGFu
ZCB3aWxsIHBlcnNpc3Qgb3ZlciB0aW1lLiBDb25zaWRlciB0aGUgZm9sbG93aW5nIGNvbmZpZ3Vy
YXRpb24uIA0KDQoxOiBsbzogPExPT1BCQUNLLFVQLExPV0VSX1VQPiBtdHUgNjU1MzYgcWRpc2Mg
bm9xdWV1ZSBzdGF0ZSBVTktOT1dOIGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwDQogICAgbGluay9s
b29wYmFjayAwMDowMDowMDowMDowMDowMCBicmQgMDA6MDA6MDA6MDA6MDA6MDANCiAgICBpbmV0
IDEwMC4wLjAuMTAwLzI0IHNjb3BlIGdsb2JhbCBsbw0KICAgICAgIHZhbGlkX2xmdCBmb3JldmVy
IHByZWZlcnJlZF9sZnQgZm9yZXZlciAgICANCjI6IGVucDBzMzogPEJST0FEQ0FTVCxNVUxUSUNB
U1QsVVAsTE9XRVJfVVA+IG10dSAxNTAwIHFkaXNjIGZxX2NvZGVsIHN0YXRlIFVQIGdyb3VwIGRl
ZmF1bHQgcWxlbiAxMDAwDQogICAgbGluay9ldGhlciAwODowMDoyNzoyMTo2NTplYyBicmQgZmY6
ZmY6ZmY6ZmY6ZmY6ZmYNCiAgICBpbmV0IDEwMC4wLjAuMTAwLzI0IHNjb3BlIGdsb2JhbCBlbnAw
czMNCiAgICAgICB2YWxpZF9sZnQgZm9yZXZlciBwcmVmZXJyZWRfbGZ0IGZvcmV2ZXINCjM6IGVu
cDBzODogPEJST0FEQ0FTVCxNVUxUSUNBU1QsVVAsTE9XRVJfVVA+IG10dSAxNTAwIHFkaXNjIGZx
X2NvZGVsIHN0YXRlIFVQIGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwDQogICAgbGluay9ldGhlciAw
ODowMDoyNzo0Zjo5NTo1YyBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmYNCiAgICBpbmV0IDEwMC4wLjAu
MTAwLzI0IHNjb3BlIGdsb2JhbCBlbnAwczgNCiAgICAgICB2YWxpZF9sZnQgZm9yZXZlciBwcmVm
ZXJyZWRfbGZ0IGZvcmV2ZXINCg0KVGhlIGFib3ZlIGlzIGEgVk0gdGhhdCBJIGNvbmZpZ3VyZWQg
d2l0aCB0aGUgc2FtZSBJUCBhZGRyZXNzICgxMDAuMC4wLjEwMCkgb24gYWxsIGludGVyZmFjZXMu
IERvaW5nIGEgcmV2ZXJzZSBsb29rdXAgdG8gaWRlbnRpZnkgdGhlIHVuaXF1ZSBpbnRlcmZhY2Ug
YXNzb2NpYXRlZCB3aXRoIDEwMC4wLjAuMTAwIHdvdWxkIHNpbXBseSBub3Qgd29yayBoZXJlLiBB
bmQgdGhpcyBpcyB3aHkgdGhlIG9wdGlvbiBob3N0X2lmYWNlIGlzIHJlcXVpcmVkLiBJIHVuZGVy
c3RhbmQgdGhhdCB0aGUgYWJvdmUgY29uZmlnIGRvZXMgbm90IHJlcHJlc2VudCBhIHN0YW5kYXJk
IGhvc3Qgc3lzdGVtLCBidXQgSSdtIHVzaW5nIHRoaXMgdG8gcHJvdmUgYSBwb2ludDogIndlIGNh
biBuZXZlciBrbm93IGhvdyBhIHVzZXIgd2lsbCBjb25maWd1cmUgdGhlaXIgc3lzdGVtIGFuZCB0
aGUgYWJvdmUgY29uZmlndXJhdGlvbiBpcyBwZXJmZWN0bHkgZmluZSBieSBMaW51eCIuDQoNClRo
ZSBjdXJyZW50IFRDUCBpbXBsZW1lbnRhdGlvbiBmb3IgaG9zdF90cmFkZHIgdXNlcyBiaW5kKCkt
YmVmb3JlLWNvbm5lY3QoKS4gVGhpcyBpcyBhIGNvbW1vbiBjb25zdHJ1Y3QgdG8gc2V0IHRoZSBz
b3VyY2UgSVAgYWRkcmVzcyBvbiB0aGUgc29ja2V0IGJlZm9yZSBjb25uZWN0aW5nLiBUaGlzIGhh
cyBubyBlZmZlY3Qgb24gaG93IExpbnV4IHdpbGwgc2VsZWN0IHRoZSBpbnRlcmZhY2UgZm9yIHRo
ZSBjb25uZWN0aW9uLiBUaGF0J3MgYmVjYXVzZSBMaW51eCB1c2VzIHRoZSBXZWFrIEVuZCBTeXN0
ZW0gbW9kZWwgYXMgZGVzY3JpYmVkIGluIFJGQzExMjIgWzJdLiBTZXR0aW5nIHRoZSBzb3VyY2Ug
YWRkcmVzcyBvbiBhIGNvbm5lY3Rpb24gaXMgYSBjb21tb24gcmVxdWlyZW1lbnQgdGhhdCBsaW51
eC1udm1lIG5lZWRzIHRvIHN1cHBvcnQuIEluIGZhY3QsIHNwZWNpZnlpbmcgdGhlIFNvdXJjZSBJ
UCBhZGRyZXNzIGlzIGEgbWFuZGF0b3J5IEZlZEdvdiByZXF1aXJlbWVudCAoZS5nLiBjb25uZWN0
aW9uIHRvIGEgUkFESVVTL1RBQ0FDUysgc2VydmVyKS4gQ29uc2lkZXIgdGhlIGZvbGxvd2luZyBj
b25maWd1cmF0aW9uLg0KDQokIGlwIGFkZHIgbGlzdCBkZXYgZW5wMHM4DQozOiBlbnAwczg6IDxC
Uk9BRENBU1QsTVVMVElDQVNULFVQLExPV0VSX1VQPiBtdHUgMTUwMCBxZGlzYyBmcV9jb2RlbCBz
dGF0ZSBVUCBncm91cCBkZWZhdWx0IHFsZW4gMTAwMA0KICAgIGxpbmsvZXRoZXIgMDg6MDA6Mjc6
NGY6OTU6NWMgYnJkIGZmOmZmOmZmOmZmOmZmOmZmDQogICAgaW5ldCAxOTIuMTY4LjU2LjEwMS8y
NCBicmQgMTkyLjE2OC41Ni4yNTUgc2NvcGUgZ2xvYmFsIGR5bmFtaWMgbm9wcmVmaXhyb3V0ZSBl
bnAwczgNCiAgICAgICB2YWxpZF9sZnQgNDI2c2VjIHByZWZlcnJlZF9sZnQgNDI2c2VjDQogICAg
aW5ldCAxOTIuMTY4LjU2LjEwMi8yNCBzY29wZSBnbG9iYWwgc2Vjb25kYXJ5IGVucDBzOA0KICAg
ICAgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZlcg0KICAgIGluZXQgMTky
LjE2OC41Ni4xMDMvMjQgc2NvcGUgZ2xvYmFsIHNlY29uZGFyeSBlbnAwczgNCiAgICAgICB2YWxp
ZF9sZnQgZm9yZXZlciBwcmVmZXJyZWRfbGZ0IGZvcmV2ZXINCiAgICBpbmV0IDE5Mi4xNjguNTYu
MTA0LzI0IHNjb3BlIGdsb2JhbCBzZWNvbmRhcnkgZW5wMHM4DQogICAgICAgdmFsaWRfbGZ0IGZv
cmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyDQoNCkhlcmUgd2UgY2FuIHNlZSB0aGF0IHNldmVy
YWwgYWRkcmVzc2VzIGFyZSBhc3NvY2lhdGVkIHdpdGggaW50ZXJmYWNlIGVucDBzOC4gQnkgZGVm
YXVsdCwgTGludXggd2lsbCBzZWxlY3QgdGhlIGRlZmF1bHQgSVAgYWRkcmVzcywgMTkyLjE2OC41
Ni4xMDEsIGFzIHRoZSBzb3VyY2UgYWRkcmVzcyB3aGVuIGNvbm5lY3Rpbmcgb3ZlciBpbnRlcmZh
Y2UgZW5wMHM4LiBTb21lIHVzZXJzLCBob3dldmVyLCB3YW50IHRoZSBhYmlsaXR5IHRvIHNwZWNp
ZnkgYSBkaWZmZXJlbnQgYWRkcmVzcyAoZS5nLiwgMTkyLjE2OC41Ni4xMDMpIHRvIGJlIHVzZWQg
YXMgdGhlIHNvdXJjZSBhZGRyZXNzLiBUaGUgb3B0aW9uIGhvc3RfdHJhZGRyIGNhbiBiZSB1c2Vk
IGFzLWlzIHRvIHBlcmZvcm0gdGhpcyBmdW5jdGlvbiAoSSB0ZXN0ZWQgaXQpLg0KDQpJbiBjb25j
bHVzaW9uLCBJIGJlbGlldmUgdGhhdCBmb3IgVENQIHdlIG5lZWQgMiBvcHRpb25zLiBPbmUgdGhh
dCBjYW4gYmUgdXNlZCB0byBzcGVjaWZ5IGFuIGludGVyZmFjZS4gQW5kIG9uZSB0aGF0IGNhbiBi
ZSB1c2VkIHRvIHNldCB0aGUgc291cmNlIGFkZHJlc3MuIEFuZCB1c2VycyBzaG91bGQgYmUgYWxs
b3dlZCB0byB1c2Ugb25lIG9yIHRoZSBvdGhlciwgb3IgYm90aCwgb3Igbm9uZS4gT2YgY291cnNl
LCB0aGUgZG9jdW1lbnRhdGlvbiBmb3IgaG9zdF90cmFkZHIgd2lsbCBuZWVkIHNvbWUgY2xhcmlm
aWNhdGlvbi4gSXQgc2hvdWxkIHN0YXRlIHRoYXQgd2hlbiB1c2VkIGZvciBUQ1AgY29ubmVjdGlv
biwgdGhpcyBvcHRpb24gb25seSBzZXRzIHRoZSBzb3VyY2UgYWRkcmVzcy4gQW5kIHRoZSBkb2N1
bWVudGF0aW9uIGZvciBob3N0X2lmYWNlIHNob3VsZCBzYXkgdGhhdCB0aGlzIG9wdGlvbiBvbmx5
IGFwcGxpZXMgdG8gVENQIGNvbm5lY3Rpb25zLg0KDQpSZWZlcmVuY2VzOg0KWzFdIGh0dHBzOi8v
d3d3LmZyZWVkZXNrdG9wLm9yZy93aWtpL1NvZnR3YXJlL3N5c3RlbWQvUHJlZGljdGFibGVOZXR3
b3JrSW50ZXJmYWNlTmFtZXMvDQpbMl0gaHR0cHM6Ly90b29scy5pZXRmLm9yZy9odG1sL3JmYzEx
MjINCg0KUmVnYXJkcywNCg0KTWFydGluIEJlbGFuZ2VyDQpEZWxsIEluYy4NCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
