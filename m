Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F164EC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 19:18:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C7461492
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 19:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C7461492
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EBe2Uj1lWwH0am7nIa1lWPEBNnV0zjKpTZNPGz/+Uo4=; b=JeVjjeRrJQWXOxBmrtXa1eg0w
	D1C1UkXgwLUuqKQzjqP5u07BXjFlnJVO6unoGjBk3B4QcyjA11SHObij+uFsFwhad8EBhMlFVGQlz
	yjrA7oSBgxhB7xcqXtiD2mpfhAeYh/Wxe9b+p8NKsAiYM+qceWCQlESYS/VWmq+Oxr6uqnvyPGQj2
	2wu+32f922nOtdFRMPJGt3VZexHBw902JAWq6xq1FnLSmsW1uhYRVrHJPtKC4I+omfpwnFskj+fY0
	O4ovHMqpQS7niQZBz/YCNzcIQzXLx8S+MRr5VOFDwFjGRQgNPcyzq5vbi0QopL+slTM1cfkvHdPMk
	SDl0sCygw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgBQJ-00FWzR-GZ; Mon, 10 May 2021 19:18:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgBQF-00FWyd-CD
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 19:18:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=b/69OQQH5qwjdB0hIxSwpSjOiNu/P7GWvg07ZtGsRxs=; b=AdqFjdi5cuUelMhamaQaXuWAoL
 OfKUX56CWi6WAjRgNKCXbjI5AtcKkh94/bHlsKj7Dj+bg25PJAuk+UgSGYKdD5uKH//smgl/dclgO
 QJLtoawiaafXj64BbJnhNQtENq0eqtQFjZt2T2RZcKxjPucA+8P1xn76Jf1dN22E3+NeCCiK5/kE1
 4AAyeouHzlEWqFb1jMC1zjW+eqG19wls++4+Wa0MvA4ABhdWQ/1ozMQB+PNMopc1xprK9Tj5Gfu3B
 b4GM/h9Kpc2RvIwZRKPbqpgGRNWO9LFvpfy5bzWrufdEm5dJcRZ/tCTNkzkKwA7GDOscD+rESu7rb
 exxQoXvQ==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgBQA-00943A-FR
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 19:18:29 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14AJHtdC027448; Mon, 10 May 2021 15:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=b/69OQQH5qwjdB0hIxSwpSjOiNu/P7GWvg07ZtGsRxs=;
 b=kCFnZNy9cgHvSHSmrcUCWsdEzTAZZbIG/p27xj5onteuQQHN3BunlsvAfB4v57mk/wwt
 6gJMysWDseXWtaIPx+IY9o+VHAZfTFQvnzOMN0oHl00WLhS/vk6RDyIo5yexcLliXOf5
 SFk0G+XpHJeQX/U32r9PbTnFaZCVRnkgDK982zFBa5BQYTZtL/xGptF7SWwjRM9ie+LJ
 PXpGMkR4cIL1k3jl8Ttj5YDcIYIcJlnaZ/DCjejwsS1bAaDF5Udv/6yUXA55c+E6VAV6
 ZZZX0GCa9fpo7rC9k6/Qv6JNQcKyGSmgMndjjEx44uyDCrwOoBEAg5s2WKGWF6alR2Zz 8g== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 38f5udhdts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 May 2021 15:18:15 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14AJF0oJ103409; Mon, 10 May 2021 15:18:14 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
 by mx0b-00154901.pphosted.com with ESMTP id 38fabbree3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 May 2021 15:18:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NetE23HVt/F6qdNomCU+KSZsn+h6o2mLbKKG6heetabHHkaZDyNefu2G0NXu0OpvV8rRQgt0lNh6feCRMxq3IGq2CoQEZRnt7FVmLS6AJm922HK9gmd2U/2+P3hP8xJhy20kY+YcMx1idVpKePvBqBTQ5rq+rSxRB9rj4YYjVOxpJ/OwBXwwptmDUqsAgik8XsM1K64RtnsA0seRmFMOM6i+pThMbDIa355i0mszPQf5/gqBe26Chc24bwKUV66d0HgTKt7AbKY6Ic1JPCTSFshQb6RuwwfT2krucOjULOxRhzyhEOVwpkjB/ZaeigEB3wC9CwHcrSXA8U9sw8vI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/69OQQH5qwjdB0hIxSwpSjOiNu/P7GWvg07ZtGsRxs=;
 b=Zhvj1xYbhs2xvmXcURaSBrPmPcAdbpjUwq7g/O9D+T/0ObqnDpkziIvfbT1LWcRdG0Fx5QOasmsH/jWmTpuKx1xra4e5Il4gfNyt5C3Q9wTDh0rPKusgmpds2Ps/Inol/dJCSAMUTdFYz4hIEr1TEN+AI0PG2maMeldxy5jAkPAglIE7cNsXgE7hMUynJ1PN/9Q5uxCv9r80Q33k1PinjytsNXv0Xbts0/IgL3Zj+9wYfTYOLDbptm/D2WKCe2VfsJYs2CY61fVCknvy814VEloaSZV32ftxYrf7X/7igLaG1gq+0iTinEHvONEhmApNhI9zWqhGC4rreB1t3uzSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BY3PR19MB4930.namprd19.prod.outlook.com (2603:10b6:a03:365::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Mon, 10 May
 2021 19:18:12 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6%2]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 19:18:12 +0000
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
Thread-Index: AQHXMi3Bh57r8OJ1AEy+hCu2vgTdtarT2uOAgADXPwCAAE3cYIABF0YAgAAPVACAAIYM0IABylGAgARURLCAAGDOAIAACimg
Date: Mon, 10 May 2021 19:18:12 +0000
Message-ID: <SJ0PR19MB45449EA9215D3EB116E1325CF2549@SJ0PR19MB4544.namprd19.prod.outlook.com>
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
In-Reply-To: <7b0d0915-961a-0af2-7ea3-77f59cd98ef1@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Martin_Belanger@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-05-10T19:18:09.0444135Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=184235ad-13c4-4a1d-9291-01aaca3f2ebb;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12235565-b971-4cb9-22f4-08d913e85afc
x-ms-traffictypediagnostic: BY3PR19MB4930:
x-microsoft-antispam-prvs: <BY3PR19MB4930F3B452AA0A4F1BB7F1BBF2549@BY3PR19MB4930.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mOrm/BNV2AqHy5ihoiUxwGHuipx2GZvLIJx3wu0O/24byrA5gnHlAb2HZvggPQ/8+E1tjjDcq0nVHMGUgPROI2T3Cm1qoYqRyQGuXmBqWy3pE3eLjVt6LhDPBoHnLSpIDrPM4/zkqykDVh9Awu9Bw1BdCgZkfJ5eOAnHAhQpG45xPFq/frb3cipIaAzSNfbqhNFslevERnNwVHN6Efc5K0EkFKzzM9/t8vuakmgdJWDUXl9pDF4FFGX2v7YTKzr4fssF0ZGauPwCL4Oux6fi/nvDBhSuDrtZjFTTif2+AXiE5Yqg/zIRxFop0nKtr6po18f2CEI6iaYpgYjQcPnsjyWDaW75Tv+Y1fcIFHMLhRxsFQ38YmB/HMM4//G95WoXNFYGE6biWwx+YjrMjdgvC9L6jqNVgSU4/rkNLabwpOtXFvaFMUydFPqRt32Yh8Gs4KwEge/VjKHEox4SP2b9f5NT1Uxl2VNSi2XGGDFDLLXE9jBqyW0g/6N8s6V9TI/aWjID3x04Euy9H2ag08mnjDBDgO4U8vAwIvIXaW8j8lMheRvDTuW9lKrujYmGonZnEZIGAErd2a6dZfuxXFB8RBFHNMrlxILPC7ka9iX5Etw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(110136005)(6506007)(7696005)(71200400001)(8676002)(54906003)(478600001)(55016002)(9686003)(5660300002)(4326008)(86362001)(52536014)(8936002)(33656002)(316002)(122000001)(186003)(38100700002)(66446008)(66946007)(66476007)(64756008)(76116006)(66556008)(2906002)(26005)(83380400001)(786003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?VU9lWXJJcGp1QnhNcXFKNUVJZXIzWVJZanUwdGFOWmlMVnJEY25QUW1ZeU5E?=
 =?utf-8?B?cmdPVzd6dUxlMy9lMFFBQkNiSnZkV0ZFU2xQMldlSlRFMDc2WU4zQlRsMmNi?=
 =?utf-8?B?Q2daNHgyVm1NUlJhMSt2dTNzWEVTdlBJV3l2T0RRVHViaklVSktVS2krdHor?=
 =?utf-8?B?d0dIbjZYZHdTTjlVMVRtdWNvN1lLYmlaYkZiWWl2OEl3RytaSVlyNDJRcDMx?=
 =?utf-8?B?a2VISExyaUJzcmNCTk82dEFWcmY0N0Q0VTVGWlAxSGFVRU0ybkNIYlI1M01a?=
 =?utf-8?B?TlY4bmtqdjFZTE9iNC9nTjlJSGFaWFo0cEJUSHN2TjdyYndEYXhabnVXRVk2?=
 =?utf-8?B?aVUxTTlUQWF2NEliRXorZDNXNmkvd2k3aTBYT0ZONFBvWjJoeCtQelg0cTlP?=
 =?utf-8?B?Y3RPbHpBaVJPczZHeHkxaEN3NTNIc3hkSkFhTUliNEZkYk54QmJnbktQTkdB?=
 =?utf-8?B?T0RpSFZSUFN1QWtYcVF4OVVHUDJwd00xcEJnelUxazRvc3dHU0lGSitaUzhK?=
 =?utf-8?B?VzRHNGFKSnBqTGZENXMzUTlYcXI5T2tMaTNWaHJWckkvaEIyeXM5cTRFMkJD?=
 =?utf-8?B?dXZyZFk1N3lNTC9EVWxPSS9RTjJrSDBTNWtRRWNnKzBVSXRyUnQxQXByRXJE?=
 =?utf-8?B?ak9ibS9vcXdnTW42Ump4bWVTTzJaZ1dUdVBXcm5EZWVxd1BQS2xXeng5cmVo?=
 =?utf-8?B?K25XM3hhY3g3Zy9FMkNNRVlob1EvTU01eHBERnZOa2N6WWE1QXRmQm40Uld1?=
 =?utf-8?B?bmwvVmVlVjk0THRoRVdzYUFwNDJjdWZLbUtXVUJMT3dzQ2p1VklXU2hjNnFK?=
 =?utf-8?B?NEphRm1jVEJlOExCYXR0NUZ1cG93Z2o2TmhDZHdzVURCQlFnZm1PMVVKZEV1?=
 =?utf-8?B?U2piVjhIanh0R3Z6YWo1eWpFL1ZsYXIvU1o1MzZWbG5XYzJBWFYzdHIvcG5S?=
 =?utf-8?B?dUc2VTJsTi9OK3oxazZNWWkvNFVYTjdvc2xkdmdlVGM1YjkyRmVMdHQ5K3JX?=
 =?utf-8?B?MUlKV1VrMTFyYkFRU2NveHBlWGxLVEIrUXlQdHRZbGlZYmFobldPTGJPSmdY?=
 =?utf-8?B?OXE2RGY3YlJQV3lvUnhrQTVWUnlRb05OVHhGNUhTMFdtR3k4bVBVbUVEZjR4?=
 =?utf-8?B?dWIyMjdJZU1odEpCNU5tdWZmNVFMUDNsQmJ2M0J3ZGxFVVVCY0trTC9ET0dU?=
 =?utf-8?B?aGcxVUh4azBSeDZEM096Q0E1UytabUFVR1d6UGQ1dEhFUnBuS2owa2FaWExF?=
 =?utf-8?B?Ty9IczRPR3Zhb1BvSVJFcGp6WGJEeHpkK25DNE5kbHNQSnBSUCtRU1c2UlhC?=
 =?utf-8?B?b1VPOW1GYVNCUnNHM1BmdGJlekRZZFFGejNFdTdwUmFtMlJvVDNIYkxOWURt?=
 =?utf-8?B?UVEyV2J0RFlzRGFoalhoYUhPeDB5OHhlUWxkSytDaDd6MldHY0hDc2RKSG05?=
 =?utf-8?B?U1pQZGZicVdtMlloRHE2TmdGdWVMb2hveTJvTTEzZURlVVJaTmY4V2RDdUQx?=
 =?utf-8?B?bk9KeldJVEwxNC9MTks3VUlmYm9Gem5oY0VvSDVKTkNscUoyZnl2cXRIcEFS?=
 =?utf-8?B?OVhMSjh0Vi9QSDk4WWs1eTVhT3orQXBzek8xc2UwNkJCeUFCNEtGVGpXRGNq?=
 =?utf-8?B?SmYyTnl3NkJNSlhENmdoT29zN0R2WVpDMHZKdXlzZXp5RS9SbzhER2Q2Z1Uw?=
 =?utf-8?B?RXdOblY5YUxPaUpTaG5uMDBCbUFuOHEvTkFxaFRiSVFteE9UaFFkVGhXR1o3?=
 =?utf-8?Q?z2ZQ5a5bg2SkHVi8AKUqaQfiknZ3ifp9m4yN3yP?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12235565-b971-4cb9-22f4-08d913e85afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 19:18:12.7946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpReoWSEFZSOKsky6pom+xh4sj9sXrJ1ZK7gOwiaoHc6BFM3QkEa++XH9KF7f/glw5jW+qJW6jfum1vWUI6ePCN7yA2dye59EvB7CTNW+EY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB4930
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-10_11:2021-05-10,
 2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=849
 mlxscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100129
X-Proofpoint-ORIG-GUID: --Ba0YhwOqA7vXi9i9Bno_mLBCzSItft
X-Proofpoint-GUID: --Ba0YhwOqA7vXi9i9Bno_mLBCzSItft
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=953
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_121826_768163_E38F8213 
X-CRM114-Status: GOOD (  29.67  )
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

PiA+Pj4gcGluZyA8ZGVzdC1pcC1hZGRyPiU8aW50ZXJmYWNlPg0KPiA+Pg0KPiA+PiBQaW5nIG9u
bHkgc3VwcG9ydHMgdGhpcyBzeW50YXggZm9yIElQdjYgbm8/DQo+ID4+DQo+ID4+PiBFeHRlbmRp
bmcgdGhpcyBhcHByb2FjaCB0byBudm1lLWNsaSB3ZSBhcnJpdmUgdG8gc29tZXRoaW5nIGxpa2Ug
dGhpczoNCj4gPj4+DQo+ID4+PiBudm1lIGRpc2NvdmVyIC0tdHJhZGRyIDEwMC42NC4yOS4yJWVu
cDBzOCAtLWhvc3QtdHJhZGRyDQo+ID4+PiAxOTIuMTY4LjU2LjEwMg0KPiA+PiAuLi4uDQo+ID4+
DQo+ID4+IFdlIGFscmVhZHkgc3VwcG9ydCB0aGlzIGZvciBJUHY2LCB3ZSBjYW4gZG8gdGhhdCBh
bHNvIGZvciBJUHY0LCBidXQNCj4gPj4gdGhpcyBzeW50YXggbWF5IG5vdCBiZSB0cml2aWFsbHkg
ZXhwZWN0ZWQgZm9yIGlwdjQ/DQo+ID4NCj4gPiBJIHRyaWVkIHRoaXMgZm9yIElQdjYgYW5kIGl0
IGRvZXNuJ3Qgd29yay4gSGVyZSdzIHdoYXQgSSBnZXQ6DQo+ID4gJCBzdWRvIG52bWUgZGlzY292
ZXIgLWcgLUcgLXQgdGNwIC1zIDgwMDkgLWEgZmU4MDo6ODAwOjI3ZmY6ZmUwMDowDQo+ID4gRmFp
bGVkIHRvIHdyaXRlIHRvIC9kZXYvbnZtZS1mYWJyaWNzOiBJbnZhbGlkIGFyZ3VtZW50ICQgc3Vk
byBudm1lDQo+ID4gZGlzY292ZXIgLWcgLUcgLXQgdGNwIC1zIDgwMDkgLWEgZmU4MDo6ODAwOjI3
ZmY6ZmUwMDowJWVucDBzOCBGYWlsZWQNCj4gPiB0byB3cml0ZSB0byAvZGV2L252bWUtZmFicmlj
czogSW52YWxpZCBhcmd1bWVudCAkIHN1ZG8gbnZtZSBkaXNjb3Zlcg0KPiA+IC1nIC1HIC10IHRj
cCAtcyA4MDA5IC1hIFtmZTgwOjo4MDA6MjdmZjpmZTAwOjBdIGZhaWxlZCB0byByZXNvbHZlIGhv
c3QNCj4gPiBbZmU4MDo6ODAwOjI3ZmY6ZmUwMDowXSBpbmZvICQgc3VkbyBudm1lIGRpc2NvdmVy
IC1nIC1HIC10IHRjcCAtcyA4MDA5DQo+ID4gLWEgW2ZlODA6OjgwMDoyN2ZmOmZlMDA6MCVlbnAw
czhdIGZhaWxlZCB0byByZXNvbHZlIGhvc3QNCj4gPiBbZmU4MDo6ODAwOjI3ZmY6ZmUwMDowJWVu
cDBzOF0gaW5mbw0KPiANCj4gIyBudm1lIGRpc2NvdmVyIC10IHRjcCAtYSBmZTgwOjo1MDU0OmZm
OmZlZjE6OWYzYiAtdw0KPiBmZTgwOjo1MDU0OmZmOmZlMjg6NWVkYiVlbnA2czANCg0KVGhhbmtz
IGZvciBjbGFyaWZ5aW5nIHRoZSBzeW50YXguIEhvd2V2ZXIsIHRoYXQgZG9lc24ndCB3b3JrIGZv
ciBtZS4gDQoNCiMgbnZtZSBkaXNjb3ZlciAtdCB0Y3AgLWEgZmU4MDo6ODAwOjI3ZmY6ZmUwMDow
IC13IGZlODA6OjkyNjY6NDg1NTo2Y2YyOmY3ZTklZW5wMHM4DQpGYWlsZWQgdG8gd3JpdGUgdG8g
L2Rldi9udm1lLWZhYnJpY3M6IENvbm5lY3Rpb24gcmVmdXNlZA0KDQpOb3RlIHRoYXQgdGhlIGFi
b3ZlIHN5bnRheCBkb2VzIG5vdCBjb21wbHkgd2l0aCBSRkM0MDA3LiBUaGUgJyUnIGRlbGltaXRl
ciBpcyBzdXBwb3NlZCB0byBiZSBhcHBlbmRlZCB0byB0aGUgRGVzdGluYXRpb24gSVAgYWRkcmVz
cyBhbmQgbm90IHRoZSBTb3VyY2UgQWRkcmVzcy4gSW4gb3RoZXIgd29yZHMsIHRvIGJlIFJGQzQw
MDctY29tcGxpYW50LCB0aGUgc3ludGF4IHNob3VsZCBiZSAodXNpbmcgeW91ciBleGFtcGxlKToN
Cg0KIyBudm1lIGRpc2NvdmVyIC10IHRjcCAtYSBmZTgwOjo1MDU0OmZmOmZlZjE6OWYzYiVlbnA2
czAgLXcgZmU4MDo6NTA1NDpmZjpmZTI4OjVlZGINCg0KVGhpcyB0ZWxscyBudm1lLWNsaSB0byBj
b25uZWN0IHRvIGEgY29udHJvbGxlciBhdCBhZGRyZXNzIGZlODA6OjUwNTQ6ZmY6ZmVmMTo5ZjNi
IHVzaW5nIGludGVyZmFjZSBlbnA2czAgZm9yIHRoZSBjb25uZWN0aW9uLiBBbmQgc2V0IHRoZSBT
b3VyY2UgYWRkcmVzcyB0byBmZTgwOjo1MDU0OmZmOmZlMjg6NWVkYi4NCg0KPiANCj4gRGlzY292
ZXJ5IExvZyBOdW1iZXIgb2YgUmVjb3JkcyAxLCBHZW5lcmF0aW9uIGNvdW50ZXIgNSA9PT09PURp
c2NvdmVyeQ0KPiBMb2cgRW50cnkgMD09PT09PQ0KPiB0cnR5cGU6ICB0Y3ANCj4gYWRyZmFtOiAg
aXB2Ng0KPiBzdWJ0eXBlOiBudm1lIHN1YnN5c3RlbQ0KPiB0cmVxOiAgICBub3Qgc3BlY2lmaWVk
LCBzcSBmbG93IGNvbnRyb2wgZGlzYWJsZSBzdXBwb3J0ZWQNCj4gcG9ydGlkOiAgMw0KPiB0cnN2
Y2lkOiA4MDA5DQo+IHN1Ym5xbjogIHRlc3RucW4xDQo+IHRyYWRkcjogIGZlODA6OjUwNTQ6ZmY6
ZmVmMTo5ZjNiJWVucDZzMA0KPiBzZWN0eXBlOiBub25lDQo+IA0KPiA+DQo+ID4+DQo+ID4+PiBU
aGlzIHRlbGxzIG52bWUgdG8gY29ubmVjdCB0byAxMDAuNjQuMjkuMiBvbiBpbnRlcmZhY2UgZW5w
MHM4LiBXZQ0KPiA+Pj4gbWFrZSBubw0KPiA+PiBjaGFuZ2UgdG8gdGhlIC0taG9zdC10cmFkZHIg
b3B0aW9uLiBJdCBjb250aW51ZXMgdG8gYmUgdXNlZCB0bw0KPiA+PiBzcGVjaWZ5IHRoZSBTb3Vy
Y2UgSVAgYWRkcmVzcyBvbmx5IChmb3IgdGhlIHJhcmUgY2FzZXMgd2hlcmUgdXNlcnMNCj4gPj4g
d2FudCB0byBzcGVjaWZ5IGEgU291cmNlIEFkZHJlc3Mgb3RoZXIgdGhhbiB0aGUgZGVmYXVsdCku
IFdpdGggdGhpcywNCj4gPj4gdGhlIGludGVyZmFjZSBpcyBzcGVjaWZpZWQgYnkgbmFtZSBhbmQg
bm90IGJ5IGl0cyBhc3NvY2lhdGVkIGFkZHJlc3MuDQo+ID4+IFRoaXMgaXMgbm90IG9ubHkgbW9y
ZSBpbnR1aXRpdmUsIGJ1dCwgYXMgSSBzdGF0ZWQgYmVmb3JlLCBlbGltaW5hdGVzDQo+ID4+IHRo
ZSBwcm9ibGVtIGNhdXNlZCBieSBtYXBwaW5nIHRoZSBzYW1lIElQIGFkZHJlc3MgdG8gbXVsdGlw
bGUNCj4gPj4gaW50ZXJmYWNlcyAobm90IHRvIG1lbnRpb24gdGhhdCBkb2luZyBhIHJldmVyc2Ug
bG9va3VwIG9uIGFuIElQDQo+ID4+IGFkZHJlc3MgdG8gZmluZCB0aGUgaW50ZXJmYWNlIGlzIGV4
dHJhIHdvcmsgdGhhdCB3ZSBkb27igJl0IG5lZWQgdG8gZG8gaW4NCj4ga2VybmVsIHNwYWNlKS4N
Cj4gPj4NCj4gPj4gTWF5YmUgd2UgZG8gc29tZXRoaW5nIGxpa2UgcGluZyAtSSBmb3IgaG9zdF90
cmFkZHIsIGZyb20gcGluZyBtYW4NCj4gcGFnZXM6DQo+ID4+DQo+ID4+IC1JIGludGVyZmFjZQ0K
PiA+PiAgICAgICAgICAgICAgaW50ZXJmYWNlIGlzIGVpdGhlciBhbiBhZGRyZXNzLCBhbiBpbnRl
cmZhY2UgbmFtZSBvciBhDQo+ID4+IFZSRiBuYW1lLiBJZiBpbnRlcmZhY2UgaXMgYW4gYWRkcmVz
cywgaXQgc2V0cyBzb3VyY2UgYWRkcmVzcyB0byBzcGVjaWZpZWQNCj4gaW50ZXJmYWNlIGFkZHJl
c3MuDQo+ID4+IElmIGludGVyZmFjZSBpcyBhbg0KPiA+PiAgICAgICAgICAgICAgaW50ZXJmYWNl
IG5hbWUsIGl0IHNldHMgc291cmNlIGludGVyZmFjZSB0byBzcGVjaWZpZWQNCj4gPj4gaW50ZXJm
YWNlLiBJZiBpbnRlcmZhY2UgaXMgYSBWUkYgbmFtZSwgZWFjaCBwYWNrZXQgaXMgcm91dGVkIHVz
aW5nDQo+ID4+IHRoZSBjb3JyZXNwb25kaW5nIHJvdXRpbmcgdGFibGU7IGluIHRoaXMgY2FzZSwg
dGhlIC1JDQo+ID4+ICAgICAgICAgICAgICBvcHRpb24gY2FuIGJlIHJlcGVhdGVkIHRvIHNwZWNp
ZnkgYSBzb3VyY2UgYWRkcmVzcy4gTk9URToNCj4gPj4gRm9yIElQdjYsIHdoZW4gZG9pbmcgcGlu
ZyB0byBhIGxpbmstbG9jYWwgc2NvcGUgYWRkcmVzcywgbGluaw0KPiA+PiBzcGVjaWZpY2F0aW9u
IChieSB0aGUgJyUnLW5vdGF0aW9uIGluIGRlc3RpbmF0aW9uLCBvcg0KPiA+PiAgICAgICAgICAg
ICAgYnkgdGhpcyBvcHRpb24pIGNhbiBiZSB1c2VkIGJ1dCBpdCBpcyBubyBsb25nZXIgcmVxdWly
ZWQuDQo+ID4+DQo+ID4+DQo+ID4+IFdpdGhvdXQgdGhlIHJlcGV0aXRpb24gdGhvdWdoLCB1bmxl
c3Mgd2UgbmVlZCB0byBzdXBwb3J0IHR3bw0KPiA+PiBpbnRlcmZhY2VzIHRoYXQgc2hhcmUgdGhl
IHNhbWUgbXVsdGlwbGUgYWRkcmVzc2VzIGluIHRoZSBzYW1lIHN1Ym5ldCwNCj4gPj4gd2hpY2gg
c291bmRzIGNvbXBsZXRlbHkgY3JhenkgdG8gbWUuLi4NCj4gPg0KPiA+IEhpIFNhZ2ksDQo+ID4N
Cj4gPiBJZiB3ZSB3YW50IHRvIGZvbGxvdyBwaW5nIGFzIGFuIGV4YW1wbGUsIHRoZSByZXBldGl0
aW9uIGlzIG5lZWRlZCBub3QgdG8NCj4gc3BlY2lmeSB0d28gaW50ZXJmYWNlcywgYnV0IHRvIHNw
ZWNpZnkgYW4gaW50ZXJmYWNlIGFuZCB0aGUgc291cmNlIGFkZHJlc3MuIEluDQo+IGEgcHJldmlv
dXMgZXhhbXBsZSAocmVwcm9kdWNlZCBiZWxvdyksIEkgZGVzY3JpYmVkIGEgY29uZmlndXJhdGlv
biB3aGVyZQ0KPiBhbiBpbnRlcmZhY2UgaGFkIHNldmVyYWwgYWRkcmVzc2VzIGFzc2lnbmVkIHRv
IGl0LiBCeSBkZWZhdWx0LCBMaW51eCBhbHdheXMNCj4gcGlja3MgdGhlIHNhbWUgU291cmNlIGFk
ZHJlc3MgKGkuZS4gMTkyLjE2OC41Ni4xMDEgaW4gdGhpcyBleGFtcGxlKSB3aGVuDQo+IGNvbm5l
Y3RpbmcuIElmIGEgdXNlciB3YW50cyBhIGRpZmZlcmVudCBzb3VyY2UgYWRkcmVzcyB0aGV5IG5l
ZWQgYSB3YXkgdG8NCj4gc3BlY2lmeSBpdCAoY3VycmVudGx5IHdpdGggLS1ob3N0LXRyYWRkciku
IFVzZXJzIGFsc28gbmVlZCBhIHdheSB0byBzcGVjaWZ5IGFuDQo+IGludGVyZmFjZSBzZXBhcmF0
ZWx5IGZyb20gdGhlIHNvdXJjZSBhZGRyZXNzIChlaXRoZXIgd2l0aCBhIG5ldyBvcHRpb24gbGlr
ZSAtLQ0KPiBob3N0LWlmYWNlIG9yIGJ5IHJlcGVhdGluZyAtLWhvc3QtdHJhZGRyKS4gV2l0aCB0
aGUgZXhhbXBsZSBiZWxvdywgaWYgd2UNCj4gd2FudGVkIHRvIGZvcmNlIHBpbmcgdG8gdXNlIGlu
dGVyZmFjZSBlbnAwczggYW5kIHNvdXJjZSBhZGRyZXNzDQo+IDE5Mi4xNjguNTYuMTAzLCB3ZSB3
b3VsZCByZXBlYXQgdGhlIC1JIG9wdGlvbiwgZm9yIGV4YW1wbGUgInBpbmcgLUkgZW5wMHM4IC1J
DQo+IDE5Mi4xNjguNTYuMTAzIi4gV2UgbmVlZCBhIHdheSB0byBkbyB0aGUgc2FtZSB3aXRoIG52
bWUtY2xpLg0KPiA+DQo+ID4gSSB0aG91Z2h0IHRoYXQgaW50cm9kdWNpbmcgYSBuZXcgb3B0aW9u
LCAiLS1ob3N0LWlmYWNlIiwgaGFkIHRoZSBzbWFsbGVzdA0KPiBpbXBhY3Qgc2luY2UgaXQgcmVx
dWlyZXMgbGVzcyBjb2RlIGNoYW5nZXMsIGJ1dCB0aGF0IHdhcyB0dXJuZWQgZG93biAobm90DQo+
IHN1cmUgZXhhY3RseSB3aHkpLiBJIHRoZW4gc3VnZ2VzdGVkIHRoYXQgd2UgdXNlIHRoZSAnJScg
ZGVsaW1pdGVyIGZvciBJUHY0IGFuZA0KPiBJUHY2LiBJIGFncmVlIHRoYXQgaXQgaXMgbm90IDEw
MCUgdGhlIHNhbWUgYXMgcGluZyBzaW5jZSBwaW5nIG9ubHkgYWxsb3dzIHRoZQ0KPiAnJScgZGVs
aW1pdGVyIGZvciBJUHY2IGFkZHJlc3NlcyAoYXMgcGVyIFJGQzQwMDcpLiBBcyB5b3Ugc3VnZ2Vz
dGVkLCB3ZSBjb3VsZA0KPiByZXBlYXQgdGhlIC0taG9zdC10cmFkZHIgb3B0aW9uIChlLmcuIC0t
aG9zdC10cmFkZHIgZW5wMHM4IC0taG9zdC10cmFkZHINCj4gMTkyLjE2OC41Ni4xMDMpLCBidXQg
dGhpcyBpcyBtb3JlIGltcGFjdGZ1bCB0byB0aGUgY29kZSB0aGFuIGFkZGluZyBhDQo+IHNlcGFy
YXRlIC0taG9zdC1pZmFjZSBvcHRpb24uDQo+IA0KPiBJdCdzIGxlc3MgYWJvdXQgY29kZS1jaGFu
Z2VzIGFuZCBtb3JlIG9uIGFkZGluZyBhIG5ldyB1c2VyIEFCSSwgdGhhdCBpcyB0aGUNCj4gcmVh
c29uIHdoeSAoYXQgbGVhc3QgSSdtIGZ1bGx5IG9uIGJvYXJkIGp1c3QgeWV0KS4NCj4gDQo+ID4g
RVhBTVBMRTogSW50ZXJmYWNlIHdpdGggc2V2ZXJhbCBhZGRyZXNzZXMgYXNzaWduZWQ6DQo+ID4g
JCBpcCBhZGRyIGxpc3QgZGV2IGVucDBzOA0KPiA+IDM6IGVucDBzODogPEJST0FEQ0FTVCxNVUxU
SUNBU1QsVVAsTE9XRVJfVVA+IG10dSAxNTAwIC4uLg0KPiA+ICAgICAgICBsaW5rL2V0aGVyIDA4
OjAwOjI3OjRmOjk1OjVjIGJyZCBmZjpmZjpmZjpmZjpmZjpmZg0KPiA+ICAgICAgICBpbmV0IDE5
Mi4xNjguNTYuMTAxLzI0IGJyZCAxOTIuMTY4LjU2LjI1NSBzY29wZSAuLi4NCj4gPiAgICAgICAg
ICAgdmFsaWRfbGZ0IDQyNnNlYyBwcmVmZXJyZWRfbGZ0IDQyNnNlYw0KPiA+ICAgICAgICBpbmV0
IDE5Mi4xNjguNTYuMTAyLzI0IHNjb3BlIGdsb2JhbCBzZWNvbmRhcnkgZW5wMHM4DQo+ID4gICAg
ICAgICAgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZlcg0KPiA+ICAgICAg
ICBpbmV0IDE5Mi4xNjguNTYuMTAzLzI0IHNjb3BlIGdsb2JhbCBzZWNvbmRhcnkgZW5wMHM4DQo+
ID4gICAgICAgICAgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZlcg0KPiA+
ICAgICAgICBpbmV0IDE5Mi4xNjguNTYuMTA0LzI0IHNjb3BlIGdsb2JhbCBzZWNvbmRhcnkgZW5w
MHM4DQo+ID4gICAgICAgICAgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZl
cg0KPiA+DQo+ID4gSW4gdGhlIGVuZCwgaXQgZG9lc24ndCByZWFsbHkgbWF0dGVyICh0byBtZSkg
aG93IGl0IGlzIGltcGxlbWVudGVkLg0KPiBIb3dldmVyLCBhIHNvbHV0aW9uIHRoYXQgaGF2ZSBs
aXR0bGUgdG8gbm8gaW1wYWN0IG9uIGV4aXN0aW5nIGNvZGUgd291bGQgYmUNCj4gbmljZS4gSnVz
dCBsaWtlIHBpbmcsIHdlIG5lZWQgYSB3YXkgdG8gc3BlY2lmeSBhbiBpbnRlcmZhY2UgYnkgaXRz
ICoqaW50ZXJmYWNlDQo+IG5hbWUqKiAoYW5kIG5vdCBieSBpdHMgYXNzb2NpYXRlZCBJUCBhZGRy
ZXNzKSwgYW5kIHdlIG5lZWQgdG8gYWxsb3cgdXNlcnMgdG8NCj4gc2VsZWN0IHdoaWNoIFNvdXJj
ZSBJUCBhZGRyZXNzIHRvIHVzZSB3aGVuIHRoZXJlIGFyZSBtdWx0aXBsZSBhZGRyZXNzZXMNCj4g
YXNzb2NpYXRlZCB3aXRoIGFuIGludGVyZmFjZS4NCj4gDQo+IFRoZSAnJScgbWF5IGJlIGNvbmZ1
c2luZyB3aGVuIGl0IGNvbWVzIHRvIG90aGVyIHRyYW5zcG9ydHMgYXMgd2VsbCAoZS5nLg0KPiBy
ZG1hL2ZjIHdvdWxkIGhhdmUgdG8gZWl0aGVyIHJlamVjdCBvciBpZ25vcmUgaXQsIGJ1dCByZWdh
cmRsZXNzIG9mIGhvdyB3ZQ0KPiBhZGQgaXQgdGhhdCB3b3VsZCBiZSB0aGUgY2FzZSkuIEhhdmlu
ZyBob3N0LXRyYWRkciBhY2NlcHQgZWl0aGVyIGlwIG9yDQo+IGludGVyZmFjZSBzZWVtcyB0aGUg
bW9zdCBkZXNpcmFibGUsIGhvd2V2ZXIgdGhhdCB3b24ndCB3b3JrIGlmIHRoZXJlIGFyZSAyDQo+
IGludGVyZmFjZXMgdGhhdCBzaGFyZSBtdWx0aXBsZSBpcCBhZGRyZXNzZXMuIFNvIGlmIHRoaXMg
aXMgYSByZXF1aXJlbWVudCB3ZSdsbA0KPiBwcm9iYWJseSBuZWVkIHRvIGFkZCAtLWhvc3QtaWZh
Y2UgYXMgYW5vdGhlciBvcHRpb24uLi4NCg0KSSBkb27igJl0IGdyb2sgd2hhdCB5b3UgbWVhbiBi
eSAidGhhdCB3b24ndCB3b3JrIGlmIHRoZXJlIGFyZSAyIGludGVyZmFjZXMgdGhhdCBzaGFyZSBt
dWx0aXBsZSBpcCBhZGRyZXNzZXMiLiBXaHkgbm90PyBJZiBvbmUgc3BlY2lmaWVzIHRoZSBpbnRl
cmZhY2UgYnkgaXRzIG5hbWUgKGUuZy4gZW5wMHM4KSwgdGhlcmUgaXMgbm8gcG9zc2libGUgY29u
ZnVzaW9uIGV2ZW4gaWYgbXVsdGlwbGUgaW50ZXJmYWNlcyBzaGFyZSB0aGUgc2FtZSBJUCBhZGRy
ZXNzZXMuIA0KDQpUaGUgZm9sbG93aW5nIGFyZSBzb21lIGV4YW1wbGVzIG9mIGhvdyBudm1lLWNs
aSBzaG91bGQgd29yayB0byBjb21wbHkgd2l0aCBSRkM0MDA3IGFuZCBiZSBjb25zaXN0ZW50IHRv
IHRoZSB3YXkgcGluZyBvcGVyYXRlcy4NCkV4YW1wbGUgMSAtIElQdjQsIFNwZWNpZnkgSW50ZXJm
YWNlIHdpdGggLXcgYW5kIGxldCBMaW51eCBzZWxlY3QgU291cmNlIGFkZHJlc3M6IA0KbnZtZSBk
aXNjb3ZlciAtdCB0Y3AgLWEgMTkyLjE2OC4xLjkgLXcgZW5wMHM4DQoNCkV4YW1wbGUgMiAtIElQ
djQsIFNwZWNpZnkgSW50ZXJmYWNlIGFuZCBTb3VyY2UgYWRkcmVzcyB3aXRoIHJlcGVhdGVkIC13
OiAgDQpudm1lIGRpc2NvdmVyIC10IHRjcCAtYSAxOTIuMTY4LjEuOSAtdyBlbnAwczggLXcgMTky
LjE2OC41Ni4xMDMNCg0KRXhhbXBsZSAzIC0gSVB2NiwgU3BlY2lmeSBJbnRlcmZhY2Ugd2l0aCcl
JyBkZWxpbWl0ZXIgYW5kIGxldCBMaW51eCBzZWxlY3QgU291cmNlIGFkZHJlc3M6DQpudm1lIGRp
c2NvdmVyIC10IHRjcCAtYSBmZTgwOjo4MDA6MjdmZjpmZTAwOjAlZW5wMHM4DQoNCkV4YW1wbGUg
NCAtIElQdjYsIFNwZWNpZnkgSW50ZXJmYWNlIHdpdGggLXcgYW5kIGxldCBMaW51eCBzZWxlY3Qg
U291cmNlIGFkZHJlc3M6DQpudm1lIGRpc2NvdmVyIC10IHRjcCAtYSBmZTgwOjo4MDA6MjdmZjpm
ZTAwOjAgLXcgZW5wMHM4DQoNCkV4YW1wbGUgNSAtIElQdjYsIFNwZWNpZnkgSW50ZXJmYWNlIHdp
dGgnJScgZGVsaW1pdGVyIGFuZCBTb3VyY2UgYWRkcmVzcyB3aXRoIC13OiANCm52bWUgZGlzY292
ZXIgLXQgdGNwIC1hIGZlODA6OjgwMDoyN2ZmOmZlMDA6MCVlbnAwczggLXcgZmU4MDo6OTI2Njo0
ODU1OjZjZjI6ZjdlOQ0KDQpFeGFtcGxlIDYgLSBJUHY2LCBTcGVjaWZ5IEludGVyZmFjZSBhbmQg
U291cmNlIGFkZHJlc3Mgd2l0aCByZXBlYXRlZCAtdzogDQpudm1lIGRpc2NvdmVyIC10IHRjcCAt
YSBmZTgwOjo4MDA6MjdmZjpmZTAwOjAgLXcgZW5wMHM4IC13IGZlODA6OjkyNjY6NDg1NTo2Y2Yy
OmY3ZTkNCg0KTWFydGluDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
