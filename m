Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3630DC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 13:53:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FDD61004
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 13:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FDD61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QibExjRIQ29XfpIcQ+DYkm1fMV6PqZQjxPKoCYlW+qc=; b=B9JHM5o98+uTyH19TyHzN0o15
	E/+PX1gSPbW+TR7qxMdTnqDCsSCPWIE7l7sK4SUWWADAbqit2A0LTduw10w0SRA0s9C9dRWOWubsO
	lmGGOInHQesa9upkgHKBMJFVmhC2DnJj5m/iuIJIMVjz9LIgbgpEddadokNU3TbnfISsQDEMgQ12p
	yPeclVtbLw0fVJWrmpNhJvAR3VDrH/PSS6MnBZpq+mWEocphmwL1V0VlFl3Km19wC5hnZeWN7ejC+
	AimB5Fg0eK8sGZUJJwhD4dqdbpLumpbqAtLHxGTgWVJ76RmhXOFdi6pmNgyKQ7tJwQPCBzVQa0hal
	+5xflNrvg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgSoe-000I0M-8A; Tue, 11 May 2021 13:52:52 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgSe0-000D4P-Lg
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 13:41:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=CBca9TPA8sL637LpoAxsKf+dRlXjTxwFVtGHAKhVaBo=; b=tbpWxKqIf8knaUz2SidGrjdWT1
 0Kk3SJ+2/lZs/iuY+F7n9HdDeOD5jONaweqEq194NTqkiHjRhi8kFHaDOsvpiLdYhgzcTF2Tx2VO5
 c/UimGt5DDRfrCiA8Qebc/r+gdBbUS3vAazRNOP92Jrq9Wx/isVJ9Pw9ySHSwTQOem5AYfXJjDXO0
 r7VCplMEMj+dy2JHSXtN6Sbrm5dPmdnLS91x4f5XNpSkv1PL9SJXDW0mQaQ2cnRbmbzwaTRx3lRse
 ZFiGo3qTfDmEWWn0sBVFeTJDLIRXcRrqfwR5A6OOANW/zuAEGh1RKav0nseF8IvtUANY5qQub3nws
 KNcVw7Ww==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgSdt-009dIc-35
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 13:41:50 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14BDbP5n030533; Tue, 11 May 2021 09:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=CBca9TPA8sL637LpoAxsKf+dRlXjTxwFVtGHAKhVaBo=;
 b=aoOwRaA5ITAmY/CT7VFyN+6S0/WomrUre4UkP0Ptu3k3aKKtIChBdzGCk8GZFTu8SyUE
 CF++c7XCn27PmnROEnhVaeyggC+DH/PW3+yOyrg0RkwkYfYhb2OKKGhrHqiSx5lj7jmr
 v/VHvKfPnSpCOYdGXLBoz/3dK7ExGO4bm5M+Q9RiUcITC//8MgSjgstKiiqiev9cAsh8
 I3lSeFfPr3F6anRAiGmA3bcb+9Yba0Z4E/gWScpdABktgAoG6fjilC4vF8xWcLi/H0hA
 7MHYZ8tkjjVmEhmRZJ1TxS3T3AqOXUaGd1Y2sVqgmz92Ki6vpIDdKOHl0D8q7Nia4GQe OA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 38f423w3bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 May 2021 09:41:35 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14BDac0F016507; Tue, 11 May 2021 09:41:35 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0a-00154901.pphosted.com with ESMTP id 38fg4710gt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 May 2021 09:41:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtXuUGZvUrJD5usWVXxcPfTLSUDS+6d5ez+jXpIa5tR/ggGpn7tahIpEjQL4TJpXopmL4+TuedHGGIyFMfhAilTkp2zyPtBuleZxVxkb/sF7Bi4040+ov8pQ/cyt3G7V8yGj4k/BWP9Uo4erYW5oKNH4JTnZAROFheYJGoRoeyjeea0ts4bZq4jNaaKFdvRjvBAU6tatRbIODOI40gKqxwma2y9XWenRs3F+24nb0i2q5sJ6iEySzV2sEP9K7VINgNasNZJ4bp+uOJdkJa9YAhvLXIttWdWk3ck1spQZoUvdAsHXY7L6L54FnNHEdph2hc8SjsNacONM9gxVbKsb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBca9TPA8sL637LpoAxsKf+dRlXjTxwFVtGHAKhVaBo=;
 b=lhn9//bxFj58jrJsiru0717/CkJp/ObVuIHUUGSMI99yp9AP0v++8C5qz3A1LMR6Lt86314iHMXw7LOOhjFN4vHREiTs2JNlzHBGg4S4Gxg80AhBL4qpX57ZLsGlxF8On+DohJaNFqqw0PC0r5EQW3HrMDLB+65EOuqELfLYe6tQCadydvdGXFu3dqvviQMs+e91igJ5Z5j3DtuXAtffvVuegaH8JdPR8WQ6G4gDmo3yiQPxUXG5E8tFotBHxtpmTpp38sswOPcPhIvABaKs43CQQgQdI6P7VkQezGArOKOlIY+AiMG3oUojwByH6qk9G9tsRVbl+W35rlh8E55+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BY3PR19MB5188.namprd19.prod.outlook.com (2603:10b6:a03:368::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 13:41:33 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6%2]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 13:41:32 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Martin
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
Thread-Index: AQHXMi3Bh57r8OJ1AEy+hCu2vgTdtarT2uOAgADXPwCAAE3cYIABF0YAgAAPVACAAIYM0IABylGAgARURLCAAGDOAIAACimggABeeICAAMzOYA==
Date: Tue, 11 May 2021 13:41:32 +0000
Message-ID: <SJ0PR19MB45449B142BE6DC506FBABA72F2539@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
 <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <b47456a5-69ae-1f33-30f0-aa25906668f2@grimberg.me>
 <27a0071d-7c7b-ee5b-41a2-d5eb8de12928@suse.de>
 <SJ0PR19MB45446577ACEA270069ADB738F2599@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <dbb70739-e636-7f4c-7332-1fbc07332444@suse.de>
 <07fa3404-ed37-052a-c2d7-0e21c119f5c5@suse.de>
 <SJ0PR19MB4544F01520BE86D205B41B23F2589@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <b511b6a0-392f-9845-8097-1f2173085ce0@grimberg.me>
 <SJ0PR19MB4544420019D202816F4392DFF2549@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <7b0d0915-961a-0af2-7ea3-77f59cd98ef1@grimberg.me>
 <SJ0PR19MB45449EA9215D3EB116E1325CF2549@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <60aa6be0-ca88-bab8-c893-4c2b1d3f8baf@grimberg.me>
In-Reply-To: <60aa6be0-ca88-bab8-c893-4c2b1d3f8baf@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Martin_Belanger@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-05-11T13:41:29.6109184Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=bb61cf48-70d5-49df-bc8d-49c5717c8081;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5a2a426-e12f-4c51-64f1-08d914827d49
x-ms-traffictypediagnostic: BY3PR19MB5188:
x-microsoft-antispam-prvs: <BY3PR19MB5188FE76A18C08A6A41D05C5F2539@BY3PR19MB5188.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bbLbYJYsYFw6kENnyZXqGiLK9OQi0s3SZ54sgPJsIoUMbypFdA+sLN7WH2b2bBtT+087xq8rTvJZ5JYYfm4bDaC9JHZYKIQznUO0sdsYgkQtZ8aUT1+sOyIPSvtflaVGbEmolob8gb3euXgiazV+KhhURAEc7osp7JefK+ZOiXSRIPSHmjdvgRLFp19uVbf62Fu3tkTonlxr0vJnfGPUkTNc0gO6g2vcSAglnbx/9PE4S2oKe6HyNqxdPRKmgITFcqvCRQ7+V4QUwYPYo+2ntbxoZupGmv2d8Aw9uZVtFl9lQ6rVb2BomgM0GOMV6t1qmbT4bpHJwk1ylR/Pl5rlk6a2m8iRXszlFMD6ixQqHG0Xy1VmpyszXsiLV8hf3g39b+UkK8WENxoX3G4QLn2vAueJlWNyNDKuVsFGLKEU/PQUINQxp99M2jHbXnJhUpsw+t3vBRn6oiSuyLVnP/sgjrJagHoRJNmuenfJfnW1Ws6ZjcDcVQRuatILfIbLW5ddFtgY0/21GVy+4FA6yf/WTL9QrKNJO72GDVKpyz4l9UVkVSn3Y9mJd1Vb/MKfheDex/8CA7XP5GOO2dTDwDk0HtWHI8kUKwBaDbIbNXb8kFw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(66556008)(4326008)(8936002)(66476007)(66446008)(76116006)(66946007)(5660300002)(64756008)(33656002)(38100700002)(122000001)(6506007)(786003)(26005)(316002)(9686003)(55016002)(7696005)(54906003)(2906002)(8676002)(478600001)(83380400001)(110136005)(52536014)(186003)(86362001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RkdDc0dRWVJETUVMTGRpY3J2L2ovajMwVTBGNjdPRXk1dGJ2czRMcEtHQ1FV?=
 =?utf-8?B?QnZUeFJjcWxVK05zZ09RazJMTWtHL3VIdlB2MjJPMnp3em9lWC9XcXk5WXcy?=
 =?utf-8?B?ZmdCWVVSSUlZaWhUNjdFeGFWeEdoL0RCWWl1QTR1em5qTjdEdkZwRnNTVGpB?=
 =?utf-8?B?M29xenZYQTZyOCs0SDNjRjBqb0NoRzZUMzBFQjJYd2ZoZ1BhbTZscjloa3E4?=
 =?utf-8?B?d2ZIblFwcFBNNDNRMnBaaTc1MUZrL25FaWNsQnVjNkdWUDREK1k1U2NjT1hV?=
 =?utf-8?B?OE8vbFc5QkpScjlTV21yaForT3lLS1lxaUJibG9mYjBFTUFQczR1TTdZZ1RT?=
 =?utf-8?B?QVdLcVRBaXRYMzhCNEhFMkN6K1ZZWGRNYzUxd2Jha0hmc3hlVVZBcU9TQ1Bl?=
 =?utf-8?B?L3FRNDdtNklUUW9ralVPWXFORVg0S05pVkFxcytWTEhtUTIwTnBDY1FnSkJ1?=
 =?utf-8?B?d1VLUFIyTWo4K3lpbTRmdFJsSVo2QXpuV21xVCtGSDRVR1hQUkYwVENoZGQr?=
 =?utf-8?B?bThlQnZCZ3hWWWw4RFFNMzJMRWtjU2htVEhuamQ2T2RSZ1U3d1Bwc01mV0cw?=
 =?utf-8?B?RFZPeHV4OGlGMlV3YmNOd3pYL3NSdlJaY3hkbXB3N1pSaEMyT2hXSGhQSGNY?=
 =?utf-8?B?YXcxREJ0anJQMFdYQUtXWjdQc0FPTmNOdmlDa0RlR0o5OUJ6VWY5dzByLzNX?=
 =?utf-8?B?QXVDYUtncHVzM2o5Zm5CTHFUUUViM0ZhSFNiRk1yMHB2VUltcU1zV3JIeGpR?=
 =?utf-8?B?YkYzWXBIU3J2QXdIOFJ0ZE1JUjFNOTFqbWZWR1BNRzRYR0hYTzBKWm5PV2Vt?=
 =?utf-8?B?KzBmdkNpbFJrUzJDZmFlWnFmOFRob2VkR2t3VjVad2daZk42OURBRm8zdEVP?=
 =?utf-8?B?b0RBcml1cXg1YXlNcFdzZldFa2c0NU1qNis0NEIrVm5LbWxBdUEyWlQ2SEF3?=
 =?utf-8?B?a2twZS82K0c0bjIrMlFXN213eDZvQmp4M1c4YlRHL2I1cFJ5MUo1NUhicjVH?=
 =?utf-8?B?cmhWY1d3cVFLSjR6SDBZMUNXVGg1OVJDT3BxYndYSUQyVWZ1dksydkp4bHF3?=
 =?utf-8?B?Y3Y3UXhqZDdIdC9nNlkyM0FxSUYyTmZlbnNkd0hSSWdwWGhiWlZsSC9CdXh0?=
 =?utf-8?B?NFI4b2Rma1NORDVIK1oxcURIS0tkQkduZHF6V0FIY05OWDVUblhYZTA3alVz?=
 =?utf-8?B?bTVRWXE2V3RTbnp5L1N1VW5EZDVCaWhpV1A1a1F5Vy9ibGtkRXUxVE1lYXJ1?=
 =?utf-8?B?bkUrTjNNbWVhbG1hOURPN3laYUkyNndmRzd2YW4rcUJ5VXNzL1BzVXQzeERl?=
 =?utf-8?B?ekRUV1ozejNFSlRKQ2l4OE51QlBFZzRSSDRUd2lEV0tmRWVZaUhTbFRrR2Zi?=
 =?utf-8?B?Z2RzQ2J1ckk0bmlzM0ZSVmc2RHBuZWFsdk9xM2pQT0p2SjJFdE1ENXAzT25W?=
 =?utf-8?B?NWRyaWwrWGx4MkJvRk1GZmFNV0R5RVhDTHBVUG4zQXNIYzVGS2VXTUREc29D?=
 =?utf-8?B?d1BJZ1IzUGc1ZjdUVFB3WTEwak9jY3BhV0dTYWtMdGRkWFZqYzUrT0FlcHFs?=
 =?utf-8?B?UEdJWnlDbUw3K3VXdkxKQ212NVJtRE1qck0rTkNqdmpOb1hscFhXNk5ubDBH?=
 =?utf-8?B?bDBkYnM4TkNmejlpL295ZmhwUUVBN3VUdmZqeTZkcStZSjkvbUh6Q2RzeG04?=
 =?utf-8?B?eTV4UW1vRk1ad3JoL25KblNzOEF5UFVwZUdnczJtbVRQNVhwTmlQMVlLenVV?=
 =?utf-8?Q?1zuV8Xr7L1OdIUhdZJKEfQWLC+UvBlKVKhkg4Dg?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a2a426-e12f-4c51-64f1-08d914827d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 13:41:32.8657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3grO4vXHMFknt/7xD4o3GkF0aM9FVhU2NG84NJP84XDqSnV7LdaevUlvpvyXIm/AH4YEGmbsBeVGnnMWk0NZdjUiELlMAPxOQHmZsfARoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5188
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-11_02:2021-05-11,
 2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110105
X-Proofpoint-ORIG-GUID: vJRY8SYfA1gZngv4j1Kv1hEb7_jVOjZt
X-Proofpoint-GUID: vJRY8SYfA1gZngv4j1Kv1hEb7_jVOjZt
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_064145_380889_29EBC0B0 
X-CRM114-Status: GOOD (  30.07  )
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

PiA+Pj4+IFdlIGFscmVhZHkgc3VwcG9ydCB0aGlzIGZvciBJUHY2LCB3ZSBjYW4gZG8gdGhhdCBh
bHNvIGZvciBJUHY0LCBidXQNCj4gPj4+PiB0aGlzIHN5bnRheCBtYXkgbm90IGJlIHRyaXZpYWxs
eSBleHBlY3RlZCBmb3IgaXB2ND8NCj4gPj4+DQo+ID4+PiBJIHRyaWVkIHRoaXMgZm9yIElQdjYg
YW5kIGl0IGRvZXNuJ3Qgd29yay4gSGVyZSdzIHdoYXQgSSBnZXQ6DQo+ID4+PiAkIHN1ZG8gbnZt
ZSBkaXNjb3ZlciAtZyAtRyAtdCB0Y3AgLXMgODAwOSAtYSBmZTgwOjo4MDA6MjdmZjpmZTAwOjAN
Cj4gPj4+IEZhaWxlZCB0byB3cml0ZSB0byAvZGV2L252bWUtZmFicmljczogSW52YWxpZCBhcmd1
bWVudCAkIHN1ZG8gbnZtZQ0KPiA+Pj4gZGlzY292ZXIgLWcgLUcgLXQgdGNwIC1zIDgwMDkgLWEg
ZmU4MDo6ODAwOjI3ZmY6ZmUwMDowJWVucDBzOCBGYWlsZWQNCj4gPj4+IHRvIHdyaXRlIHRvIC9k
ZXYvbnZtZS1mYWJyaWNzOiBJbnZhbGlkIGFyZ3VtZW50ICQgc3VkbyBudm1lIGRpc2NvdmVyDQo+
ID4+PiAtZyAtRyAtdCB0Y3AgLXMgODAwOSAtYSBbZmU4MDo6ODAwOjI3ZmY6ZmUwMDowXSBmYWls
ZWQgdG8gcmVzb2x2ZQ0KPiA+Pj4gaG9zdCBbZmU4MDo6ODAwOjI3ZmY6ZmUwMDowXSBpbmZvICQg
c3VkbyBudm1lIGRpc2NvdmVyIC1nIC1HIC10IHRjcA0KPiA+Pj4gLXMgODAwOSAtYSBbZmU4MDo6
ODAwOjI3ZmY6ZmUwMDowJWVucDBzOF0gZmFpbGVkIHRvIHJlc29sdmUgaG9zdA0KPiA+Pj4gW2Zl
ODA6OjgwMDoyN2ZmOmZlMDA6MCVlbnAwczhdIGluZm8NCj4gPj4NCj4gPj4gIyBudm1lIGRpc2Nv
dmVyIC10IHRjcCAtYSBmZTgwOjo1MDU0OmZmOmZlZjE6OWYzYiAtdw0KPiA+PiBmZTgwOjo1MDU0
OmZmOmZlMjg6NWVkYiVlbnA2czANCj4gPg0KPiA+IFRoYW5rcyBmb3IgY2xhcmlmeWluZyB0aGUg
c3ludGF4LiBIb3dldmVyLCB0aGF0IGRvZXNuJ3Qgd29yayBmb3IgbWUuDQo+ID4NCj4gPiAjIG52
bWUgZGlzY292ZXIgLXQgdGNwIC1hIGZlODA6OjgwMDoyN2ZmOmZlMDA6MCAtdw0KPiA+IGZlODA6
OjkyNjY6NDg1NTo2Y2YyOmY3ZTklZW5wMHM4IEZhaWxlZCB0byB3cml0ZSB0byAvZGV2L252bWUt
ZmFicmljczoNCj4gPiBDb25uZWN0aW9uIHJlZnVzZWQNCj4gDQo+IEFyZSB5b3UgdXNpbmcgdGhl
IGxpbnV4IHRhcmdldD8gY29ubmVjdGlvbiByZWZ1c2VkIG1lYW5zIHRoYXQgeW91IGRvbid0DQo+
IGhhdmUgYSBsaXN0ZW5lciBvbiBpdCwgaXQncyBub3QgYSByZXNvbHV0aW9uIGVycm9yLg0KPiAN
Cj4gZGlkIHlvdSBoYXZlIHRoZSB0YXJnZXQgbGlzdGVuIG9uIGZlODA6OjgwMDoyN2ZmOmZlMDA6
MCU8aW50Zj4gPw0KDQpEb2ghIFlvdSBhcmUgY29ycmVjdC4gSW4gbXkgc2V0dXAsIEkgcnVuIHRo
ZSBudm1lLWNsaSBjbGllbnQgb24gYSBWTSBhbmQgSSBydW4gdGhlIHRhcmdldCAobnZtZXQpIG9u
IHRoZSBob3N0IGNvbXB1dGVyLiBJIGhhZCBudm1ldCBjb25maWd1cmVkIGZvciAiMC4wLjAuMCIg
aW5zdGVhZCBvZiAiOjoiIChpLmUuIGxpc3RlbiBvbiBhbGwgaW50ZXJmYWNlcykuIA0KDQpBZnRl
ciBjaGFuZ2luZyBudm1ldCdzIGNvbmZpZ3VyYXRpb24sIEkgd2FzIGFibGUgdG8gcXVlcnkgdGhl
IGRpc2NvdmVyeSBsb2cgcGFnZXMsIHVzaW5nIHRoaXMgc3ludGF4Og0KbnZtZSBkaXNjb3ZlciAt
dCB0Y3AgLWEgZmU4MDo6ODAwOjI3ZmY6ZmUwMDowIC13IGZlODA6OjkyNjY6NDg1NTo2Y2YyOmY3
ZWElZW5wMHM4DQoNCk5vdGUgdGhhdCBpdCBkb2Vzbid0IHdvcmsgd2hlbiBJIGFwcGVuZCB0aGUg
aW50ZXJmYWNlIHRvIHRoZSBEZXN0aW5hdGlvbiBJUCBhZGRyZXNzIGFzIHBlciBSRkM0MDA3IChs
aWtlIHBpbmcpIGFzIGZvbGxvd3MuDQpudm1lIGRpc2NvdmVyIC10IHRjcCAtYSBmZTgwOjo4MDA6
MjdmZjpmZTAwOjAlZW5wMHM4IC13IGZlODA6OjkyNjY6NDg1NTo2Y2YyOmY3ZWENCg0KPiANCj4g
Pg0KPiA+IE5vdGUgdGhhdCB0aGUgYWJvdmUgc3ludGF4IGRvZXMgbm90IGNvbXBseSB3aXRoIFJG
QzQwMDcuIFRoZSAnJScNCj4gZGVsaW1pdGVyIGlzIHN1cHBvc2VkIHRvIGJlIGFwcGVuZGVkIHRv
IHRoZSBEZXN0aW5hdGlvbiBJUCBhZGRyZXNzIGFuZCBub3QNCj4gdGhlIFNvdXJjZSBBZGRyZXNz
LiBJbiBvdGhlciB3b3JkcywgdG8gYmUgUkZDNDAwNy1jb21wbGlhbnQsIHRoZSBzeW50YXgNCj4g
c2hvdWxkIGJlICh1c2luZyB5b3VyIGV4YW1wbGUpOg0KPiA+DQo+ID4gIyBudm1lIGRpc2NvdmVy
IC10IHRjcCAtYSBmZTgwOjo1MDU0OmZmOmZlZjE6OWYzYiVlbnA2czAgLXcNCj4gPiBmZTgwOjo1
MDU0OmZmOmZlMjg6NWVkYg0KPiA+DQo+ID4gVGhpcyB0ZWxscyBudm1lLWNsaSB0byBjb25uZWN0
IHRvIGEgY29udHJvbGxlciBhdCBhZGRyZXNzDQo+IGZlODA6OjUwNTQ6ZmY6ZmVmMTo5ZjNiIHVz
aW5nIGludGVyZmFjZSBlbnA2czAgZm9yIHRoZSBjb25uZWN0aW9uLiBBbmQgc2V0IHRoZQ0KPiBT
b3VyY2UgYWRkcmVzcyB0byBmZTgwOjo1MDU0OmZmOmZlMjg6NWVkYi4NCj4gDQo+IFRoaXMgYWxz
byBzZWVtcyB0byB3b3JrLCBub3Qgc3VyZSB0aGF0IGl0IGRvZXMgd2hhdCB3ZSB3YW50IHRob3Vn
aC4uLg0KPiBudm1lIGRpc2NvdmVyIC10IHRjcCAtYSBmZTgwOjo1MDU0OmZmOmZlZjE6OWYzYiVl
bnA2czAgLXcNCj4gZmU4MDo6NTA1NDpmZjpmZTI4OjVlZGIlZW5wNnMwDQo+IA0KPiBEaXNjb3Zl
cnkgTG9nIE51bWJlciBvZiBSZWNvcmRzIDEsIEdlbmVyYXRpb24gY291bnRlciA1ID09PT09RGlz
Y292ZXJ5DQo+IExvZyBFbnRyeSAwPT09PT09DQo+IHRydHlwZTogIHRjcA0KPiBhZHJmYW06ICBp
cHY2DQo+IHN1YnR5cGU6IG52bWUgc3Vic3lzdGVtDQo+IHRyZXE6ICAgIG5vdCBzcGVjaWZpZWQs
IHNxIGZsb3cgY29udHJvbCBkaXNhYmxlIHN1cHBvcnRlZA0KPiBwb3J0aWQ6ICAzDQo+IHRyc3Zj
aWQ6IDgwMDkNCj4gc3VibnFuOiAgdGVzdG5xbjENCj4gdHJhZGRyOiAgZmU4MDo6NTA1NDpmZjpm
ZWYxOjlmM2IlZW5wNnMwDQo+IHNlY3R5cGU6IG5vbmUNCj4gDQo+IA0KPiA+PiBUaGUgJyUnIG1h
eSBiZSBjb25mdXNpbmcgd2hlbiBpdCBjb21lcyB0byBvdGhlciB0cmFuc3BvcnRzIGFzIHdlbGwg
KGUuZy4NCj4gPj4gcmRtYS9mYyB3b3VsZCBoYXZlIHRvIGVpdGhlciByZWplY3Qgb3IgaWdub3Jl
IGl0LCBidXQgcmVnYXJkbGVzcyBvZg0KPiA+PiBob3cgd2UgYWRkIGl0IHRoYXQgd291bGQgYmUg
dGhlIGNhc2UpLiBIYXZpbmcgaG9zdC10cmFkZHIgYWNjZXB0DQo+ID4+IGVpdGhlciBpcCBvciBp
bnRlcmZhY2Ugc2VlbXMgdGhlIG1vc3QgZGVzaXJhYmxlLCBob3dldmVyIHRoYXQgd29uJ3QNCj4g
Pj4gd29yayBpZiB0aGVyZSBhcmUgMiBpbnRlcmZhY2VzIHRoYXQgc2hhcmUgbXVsdGlwbGUgaXAg
YWRkcmVzc2VzLiBTbw0KPiA+PiBpZiB0aGlzIGlzIGEgcmVxdWlyZW1lbnQgd2UnbGwgcHJvYmFi
bHkgbmVlZCB0byBhZGQgLS1ob3N0LWlmYWNlIGFzIGFub3RoZXINCj4gb3B0aW9uLi4uDQo+ID4N
Cj4gPiBJIGRvbuKAmXQgZ3JvayB3aGF0IHlvdSBtZWFuIGJ5ICJ0aGF0IHdvbid0IHdvcmsgaWYg
dGhlcmUgYXJlIDIgaW50ZXJmYWNlcw0KPiB0aGF0IHNoYXJlIG11bHRpcGxlIGlwIGFkZHJlc3Nl
cyIuIFdoeSBub3Q/IElmIG9uZSBzcGVjaWZpZXMgdGhlIGludGVyZmFjZSBieQ0KPiBpdHMgbmFt
ZSAoZS5nLiBlbnAwczgpLCB0aGVyZSBpcyBubyBwb3NzaWJsZSBjb25mdXNpb24gZXZlbiBpZiBt
dWx0aXBsZQ0KPiBpbnRlcmZhY2VzIHNoYXJlIHRoZSBzYW1lIElQIGFkZHJlc3Nlcy4NCj4gPg0K
PiA+IFRoZSBmb2xsb3dpbmcgYXJlIHNvbWUgZXhhbXBsZXMgb2YgaG93IG52bWUtY2xpIHNob3Vs
ZCB3b3JrIHRvIGNvbXBseQ0KPiB3aXRoIFJGQzQwMDcgYW5kIGJlIGNvbnNpc3RlbnQgdG8gdGhl
IHdheSBwaW5nIG9wZXJhdGVzLg0KPiA+IEV4YW1wbGUgMSAtIElQdjQsIFNwZWNpZnkgSW50ZXJm
YWNlIHdpdGggLXcgYW5kIGxldCBMaW51eCBzZWxlY3QgU291cmNlDQo+IGFkZHJlc3M6DQo+ID4g
bnZtZSBkaXNjb3ZlciAtdCB0Y3AgLWEgMTkyLjE2OC4xLjkgLXcgZW5wMHM4DQo+ID4NCj4gPiBF
eGFtcGxlIDIgLSBJUHY0LCBTcGVjaWZ5IEludGVyZmFjZSBhbmQgU291cmNlIGFkZHJlc3Mgd2l0
aCByZXBlYXRlZCAtdzoNCj4gPiBudm1lIGRpc2NvdmVyIC10IHRjcCAtYSAxOTIuMTY4LjEuOSAt
dyBlbnAwczggLXcgMTkyLjE2OC41Ni4xMDMNCj4gDQo+IEkgbWVhbnQgd2l0aG91dCB0aGUgcmVw
ZXRpdGlvbnMsIHdoaWNoIHlvdSBvbmx5IG5lZWQgaWYgeW91IGhhdmUgMiBkZXZpY2VzDQo+IHRo
YXQgc2hhcmUgbW9yZSB0aGFuIG9uZSBhZGRyZXNzLCB3aGljaCBhZ2FpbiwgaXMgbm90IGEgY2xl
YXIgdXNlLWNhc2UgdG8NCj4gbWUsIGJ1dCB3aXRob3V0IHJlcGV0aXRpb25zIHdlIHdvbid0IHN1
cHBvcnQgdGhhdC4NCg0KSSd2ZSBiZWVuIHRoaW5raW5nIGFib3V0IHdoYXQgeW91IHNhaWQgcmVn
YXJkaW5nIHRoZSBuZWVkIHRvIHJlcGVhdCB0aGUgLXcgb3B0aW9uIHdoZW4gdHdvIGludGVyZmFj
ZXMgc2hhcmUgdGhlIHNhbWUgSVAgYWRkcmVzcy4gSSB0aGluayB3ZSdyZSBsb29raW5nIGF0IHRo
ZSBwcm9ibGVtIGZyb20gYSBkaWZmZXJlbnQgcG9pbnQgb2Ygdmlldy4gVGhlIGN1cnJlbnQgaW1w
bGVtZW50YXRpb24gdXNlcyBhbiBJUCBhZGRyZXNzIHRvIGlkZW50aWZ5IGFuIGludGVyZmFjZS4g
SSwgb24gdGhlIG90aGVyIGhhbmQsIGJlbGlldmUgdGhhdCB0aGUgYmVzdCB3YXkgdG8gaWRlbnRp
ZnkgYW4gaW50ZXJmYWNlIGlzIGJ5IGl0cyAiaW50ZXJmYWNlIG5hbWUgb3IgaW5kZXgiLiBJbiBw
cmV2aW91cyBlbWFpbHMsIEkgcHJvdmlkZWQgZXhhbXBsZXMgb2YgdGhlIHByb2JsZW1zIHRoYXQg
bWF5IG9jY3VyIHdoZW4gdXNpbmcgYW4gSVAgYWRkcmVzcyB0byBpZGVudGlmeSBhbiBpbnRlcmZh
Y2UuIEZvciBleGFtcGxlLCBvbmUgY2FuIGFzc2lnbiB0aGUgc2FtZSBJUCBhZGRyZXNzIHRvIGRp
ZmZlcmVudCBpbnRlcmZhY2VzIG1ha2luZyBpdCBpbXBvc3NpYmxlIHRvIGRpc3Rpbmd1aXNoIGlu
dGVyZmFjZXMgYnkgdGhlaXIgSVAgYWRkcmVzcyBhbG9uZS4gQW5vdGhlciBleGFtcGxlIGlzIHRo
YXQgdGhlIGxvdyBsZXZlbCBBUElzIChlLmcuIHNldHNvY2tvcHQoU09fQklORFRPREVWSUNFKSBk
b27igJl0IGV2ZW4gcmVxdWlyZSB0aGUgc291cmNlIElQIGFkZHJlc3MuIFRoZXkgb25seSBuZWVk
IHRoZSBpbnRlcmZhY2UgbmFtZS9pbmRleC4gU28sIHdoeSBnbyB0aHJvdWdoIHRoZSB0cm91Ymxl
IG9mIHBlcmZvcm1pbmcgYSByZXZlcnNlIGFkZHJlc3MgbG9va3VwIHRvIHJldHJpZXZlIHRoZSBp
bnRlcmZhY2UgbmFtZS9pbmRleCB3aGVuIHRoZSBhZGRyZXNzIGlzIG5vdCB1c2VkIGF0IGFsbD8g
DQoNCkJ5IHRoZSB3YXksIGlmIG52bWUtY2xpL2xpbnV4LW52bWUgYWxsb3dlZCBzcGVjaWZ5aW5n
IGludGVyZmFjZXMgYnkgbmFtZS9pbmRleCwgdGhlbiB3ZSB3b3VsZCBub3QgcmVhbGx5IG5lZWQg
dG8gcmVwZWF0IHRoZSAtdyBvcHRpb24gdW5sZXNzIHdlIGFsc28gd2FudGVkIHRvIHNldCB0aGUg
c291cmNlIGFkZHJlc3MgYXQgdGhlIHNhbWUgdGltZS4gU2V0dGluZyB0aGUgc291cmNlIGFkZHJl
c3MgaXMgYSBjb21wbGV0ZWx5IGRpZmZlcmVudCB0aGluZyBmcm9tIHNldHRpbmcgdGhlIGludGVy
ZmFjZS4gT25lIHNob3VsZCBiZSBhbGxvd2VkIHRvIHNldCBvbmUgaW5kZXBlbmRlbnRseSBmcm9t
IHRoZSBvdGhlciwgb3IgYm90aCwgb3Igbm9uZS4NCg0KSWYgeW91IGxvb2sgYXQgaG93IHBpbmcg
aXMgaW1wbGVtZW50ZWQsIHRoZXkgZG8gbm90IGluZmVyIHRoZSBpbnRlcmZhY2UgZnJvbSB0aGUg
SVAgYWRkcmVzcy4gSWYgb25lIHdhbnRzIHRvIGZvcmNlIHBpbmcgdG8gZ28gb3ZlciBhbiBpbnRl
cmZhY2UsIHRoZW4gb25lIG11c3QgcHJvdmlkZSB0aGUgaW50ZXJmYWNlIGJ5IG5hbWUvaW5kZXgg
dXNpbmcgdGhlIC1JIG9wdGlvbi4gSWYgb25lIHdhbnRzIHRvIGNoYW5nZSB0aGUgc291cmNlIElQ
IGFkZHJlc3MgKHdpdGhvdXQgZm9yY2luZyBhIHNwZWNpZmljIGludGVyZmFjZSksIHRoZW4gb25l
IHByb3ZpZGVzIHRoZSBJUCBhZGRyZXNzIHRvIHRoZSAtSSBvcHRpb24uIEl0J3Mgc2ltcGxlIGFu
ZCBpbnR1aXRpdmUuIEFuZCBwaW5nIGFsc28gc3VwcG9ydHMgYXBwZW5kaW5nIHRoZSBpbnRlcmZh
Y2UgdG8gdGhlIERlc3RpbmF0aW9uIElQIHVzaW5nIHRoZSAnJScgZGVsaW1pdGVyIGZvciBJUHY2
LW9ubHkgYXMgcGVyIFJGQzQwMDcuDQoNCkkgdGhpbmsgdGhhdCBudm1lLWNsaS9saW51eC1udm1l
IHNob3VsZCBmb2xsb3cgdGhlIHBpbmcgYXBwcm9hY2guIEludGVyZmFjZXMgc2hvdWxkIG5ldmVy
IGJlIGluZmVycmVkIGZyb20gc291cmNlIElQIGFkZHJlc3NlcywgYnV0IGluc3RlYWQgYmUgY2xl
YXJseSBpZGVudGlmaWVkIGJ5IHRoZWlyIG5hbWUgb3IgaW5kZXguIEFuZCBzZXR0aW5nIHRoZSBz
b3VyY2UgYWRkcmVzcyBzaG91bGQgYmUgaW5kZXBlbmRlbnQgZnJvbSBzZXR0aW5nIHRoZSBpbnRl
cmZhY2UuDQoNClJlZ2FyZHMsDQpNYXJ0aW4NCg0KPiANCj4gPiBFeGFtcGxlIDMgLSBJUHY2LCBT
cGVjaWZ5IEludGVyZmFjZSB3aXRoJyUnIGRlbGltaXRlciBhbmQgbGV0IExpbnV4IHNlbGVjdA0K
PiBTb3VyY2UgYWRkcmVzczoNCj4gPiBudm1lIGRpc2NvdmVyIC10IHRjcCAtYSBmZTgwOjo4MDA6
MjdmZjpmZTAwOjAlZW5wMHM4DQo+ID4NCj4gPiBFeGFtcGxlIDQgLSBJUHY2LCBTcGVjaWZ5IElu
dGVyZmFjZSB3aXRoIC13IGFuZCBsZXQgTGludXggc2VsZWN0IFNvdXJjZQ0KPiBhZGRyZXNzOg0K
PiA+IG52bWUgZGlzY292ZXIgLXQgdGNwIC1hIGZlODA6OjgwMDoyN2ZmOmZlMDA6MCAtdyBlbnAw
czgNCj4gPg0KPiA+IEV4YW1wbGUgNSAtIElQdjYsIFNwZWNpZnkgSW50ZXJmYWNlIHdpdGgnJScg
ZGVsaW1pdGVyIGFuZCBTb3VyY2UgYWRkcmVzcw0KPiB3aXRoIC13Og0KPiA+IG52bWUgZGlzY292
ZXIgLXQgdGNwIC1hIGZlODA6OjgwMDoyN2ZmOmZlMDA6MCVlbnAwczggLXcNCj4gPiBmZTgwOjo5
MjY2OjQ4NTU6NmNmMjpmN2U5DQo+ID4NCj4gPiBFeGFtcGxlIDYgLSBJUHY2LCBTcGVjaWZ5IElu
dGVyZmFjZSBhbmQgU291cmNlIGFkZHJlc3Mgd2l0aCByZXBlYXRlZCAtdzoNCj4gPiBudm1lIGRp
c2NvdmVyIC10IHRjcCAtYSBmZTgwOjo4MDA6MjdmZjpmZTAwOjAgLXcgZW5wMHM4IC13DQo+ID4g
ZmU4MDo6OTI2Njo0ODU1OjZjZjI6ZjdlOQ0KPiA+DQo+ID4gTWFydGluDQo+ID4NCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
