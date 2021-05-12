Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC7EC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 12:13:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4996D61370
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 12:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4996D61370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JkReC0/3gS8lCqikwwwcL14hqivZ3nGd7jWZrDohIkI=; b=jePd2dfn0VGRpiSCPyOAu1M2C
	uthTO3xfRT8ikMYoQ/aXV04S1zFVOAzEqQg9+rL6cTr9kigcrU17F4f81mXmIIypVaGOXbPE8xEFE
	E6lwVusrIIY5vx8XwayFippjOU+aeemam08f6cWxNVKT6Wl/a3ZnGnBREt/nKL6N4XJQqsHQnS7LG
	gc1wf3oQJoph5tfX+b73xkMNA/FF6Ht/9SjhyMjSCq0v/4GGHe2DCnYM2o1XbQVTVdjaWdBStXyWV
	xasC0C6i5+I4UHTEkRdOxosZO1Pssz1M3SXaSRspxbrpPF7lZr1LLcuRWHnUrsKD6j8nyOidWgfWK
	ICz8ErYjQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgnjM-002h8z-TU; Wed, 12 May 2021 12:12:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgnjJ-002h8O-EN
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 12:12:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=x3z1WJnFqtBCclYBnnty0uIe4ylqURsytwycjhD86b0=; b=ObZQ8B8II6/PX8zL5AoJkXutvP
 vNXEWeBrMdqOBJekYWN+vZQomM0Z+pFQmfwTGLZj44nlxnLGHFpEG3M+49RSyrwHMjZL28EWF1Bhv
 bmoZowvnicAaGH2ZnpkXl3zmSsSyBDTR8XsT33+XzZyuHGa22G4bAlF5AK5LeKcR9bnoPmzeHTl9g
 C9NAjPh9+eXTKmcv7axART6qPFfZeJveoEMeaN7bMQvigl+VTTeC/WzmIkG2q/QrDmTm0tio5hI+s
 zfFFgDKwlTYB6x3F/fJhv+obrxxOxtUpKiByil8AoWB3ZYhchAVTFldCOA2IFFvMxVk4+HjWGwSVe
 HV/EhqNQ==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgnjG-00AKeO-1r
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 12:12:43 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14CC2Y9I002388; Wed, 12 May 2021 08:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=x3z1WJnFqtBCclYBnnty0uIe4ylqURsytwycjhD86b0=;
 b=IwrFwwkJUC9kdsOld5OVAN2wl835178CStQbe2Zuenf+fyfBSEDNNM/k8tfYU9b6SCn6
 8MJw/ulSZF8BIF6S2iryCSwKkd4RD/1EoeoW2j0I3choJq0Qkosw859h+BsvwD8EmoW+
 4rZaMYZ4Kze9k9upgrPKY7+PfHGFJLpZN9YEC4p51ebPSviMe0/9nJl9aHTN9FH4dnrh
 qYpa8heR20bH25bVvoivxzXavAz1gk/VS3rLj3Q3JupmHgkTSib2enVRbEdiOHR9yoiv
 R+82F1jz7zhVcHdaMu7odW5z6+Gzmi/FCky9U9afmv2l9Gn09HvvTTLXppu+jNNgbNT8 gQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 38f5g5rwsa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 May 2021 08:12:33 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14CBxYmJ155590; Wed, 12 May 2021 08:12:33 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
 by mx0a-00154901.pphosted.com with ESMTP id 38e87n9pf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 May 2021 08:12:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fzjx1RAgR6I5tjmz06IC43iII3SqRHwLHqSEWTDZFlbPLlyXm65xmix5WZFjHNSensCV0CaQ0kQ9bxWRNRT5qIS8p1SMhjtVMWg3s3OMoPJr20hT1eIf6W2DgqjrnANTdWB8yzVzcz3aU0b93WT0HWtok1oHq7zNC1t0FFgyK8QfzwXpEgHtnJkZVnlKzJJtmjKMb2/8GPsdYku64/SDdhUor+1il/3YYPY16ImlPrLt8XbiR40xE9pE2kDrzXgBIsr8Ceu5yIlPc7pxnC2DFCSaryEKZ8tJwAf7yf3X8CdxAmkOF79MLflp3Gbwho/4Rl4nEU05hhSRS0KX20bSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3z1WJnFqtBCclYBnnty0uIe4ylqURsytwycjhD86b0=;
 b=eHiSZRfYlpQ03aCP4+wiIHkFQVNGbVp5FZTCxTjwgdqZYLIA4MMWa4N/9yNtJQfegKThoJIZgTywSaf7dYjGAjoDWIapQCX33DsdVJYEd8qPn8/+QoQBssLHmuicmM1jyAGpvS3QF1YyTIf9HZWLIRKT53ZsnfW9+M0gC9Ty5LejnlQnu8Ho3hM7ssm8nezj0rQMKqQdqV9LeivSXIiHtwmSd5cQNf/tQXkHdUW28K2A3UckVa4WnXNZKgiKz2N6wuoFEMLNyKLV3/NGGRxNo+k+9ZXvEGpYsRKSOjvbs+eYWav0KbfStYIYnvDR1O555IMnGgAR5Z+TAIXgmBTN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BYAPR19MB2695.namprd19.prod.outlook.com (2603:10b6:a03:f5::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 12:12:30 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6%2]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 12:12:30 +0000
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
Thread-Index: AQHXMi3Bh57r8OJ1AEy+hCu2vgTdtarT2uOAgADXPwCAAE3cYIABF0YAgAAPVACAAIYM0IABylGAgARURLCAAGDOAIAACimggABeeICAAMzOYIAAS/mAgADY8gCAAGRbkA==
Date: Wed, 12 May 2021 12:12:30 +0000
Message-ID: <SJ0PR19MB454488E95A2A00E5ABC757DBF2529@SJ0PR19MB4544.namprd19.prod.outlook.com>
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
 <SJ0PR19MB45449B142BE6DC506FBABA72F2539@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <9c7d43e1-e13e-43a9-8212-ff48467d3a49@grimberg.me>
 <2d747a9f-d29d-de1c-7bdc-69e11bf5d9da@suse.de>
In-Reply-To: <2d747a9f-d29d-de1c-7bdc-69e11bf5d9da@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Martin_Belanger@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-05-12T12:12:30.2949626Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=5d779990-95e9-43d4-aa10-86eaa08dd8eb;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5959f8e1-a803-48f8-90c7-08d9153f375e
x-ms-traffictypediagnostic: BYAPR19MB2695:
x-microsoft-antispam-prvs: <BYAPR19MB2695811A49582E9880403207F2529@BYAPR19MB2695.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h/ScbLC6l9wG6kSBYFTFgW9CfZSgrRMrao2OW5upBeLxzmzJ9TioYxkAL3MRK3pGYAzaCCQfO5YNdRDbsiN8ESlpHAoY+SXQhQqi+e2pXrRNDNF8NWQmZY8Lcrrfk7QpVusYOA5iJYrc3RpyZXU382aU4CHCodcqP7smw0w8izkZway8PBl8mMOcqee0cMZgL4vKWd3gFr3VCa/6T+UBAZ3dJhqLHeQZAnI+hcJeopY/nGAZAAX2jSfKDudibb+fkRC1KbX3M8s9M1vr9yWlTk7SJOnla3RGcFICZgl1ME8DurOQZakCNwvQJ416JLPUr+YdTLSqP+sIsGFM+J1L2Sbd1eokuN0DdUai0mmjiJPkp5jTdhGrVmjQzvOe70mqF4kl7qdYnDqSRWz2VhfOk8iEk4OYpeldVMPBXM5qEzdaeFPfN321Bpg/QkpiOnWo8gur3Fp8Mlx1K0qmHXuRouf9zwixWhE1tijbhLt3EV7KtoZ+G10hX79fB7F4fv+cqYX/3ZvMRdvZV/lsnYMXL9v6Cjn8cPpUsSEYZRphoat7HYZ8GwFcow7R56a9tpEaF0hwdajWkn00Sz3zBqo9mgbPGg1q3zu+ycx9e0Gbdik=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(76116006)(478600001)(71200400001)(8936002)(26005)(6506007)(64756008)(66556008)(66446008)(7696005)(83380400001)(66476007)(66574015)(53546011)(66946007)(8676002)(33656002)(316002)(786003)(52536014)(110136005)(5660300002)(54906003)(122000001)(2906002)(55016002)(9686003)(4326008)(38100700002)(86362001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?UW1VUGx6eEZ1L0F6VFdjT1J5RmFlNUZSYlZSeHBna2YzbWtOMjNYMmViZGJP?=
 =?utf-8?B?WWFxbVd4YXI2RmJ0WC9MWUNVcGhPMVFuSndGU1hxK1ZuVk8rV1NSY2d3VXUy?=
 =?utf-8?B?Q29NL3VRVlVEVHVEWTFrb25QYkVabjU1RGdjWE5JSFU1bjlZdVFXMVMzTWhq?=
 =?utf-8?B?M3MwZzZ5YUdjeENobERFalRKZG1mZkZUYXBFN0tnb2MzQmJyczJhd1p0aTVL?=
 =?utf-8?B?OExQYTVyZXY2TSszelMzREVCd3RGbk1WQVY0NmM3RDloa0ExSGV1dkw2OWVQ?=
 =?utf-8?B?YlV3RzV4MG11ZC9OeUluSmFZQWJOaWVJYmQ5Z3hMZkNxYzBuQnhlSW1LZTA0?=
 =?utf-8?B?dUxkNGxWb0RFcWxnSmdDOXE1ODcvSERmZzNpRXRPUUNOc3VxY0dSdUs2TzlF?=
 =?utf-8?B?dktLRmw2bWo4ejZJZ1NHbm5WY3BkQzNzUlNPRzQrc2VjUjBFT2JHMWRzSGM5?=
 =?utf-8?B?MURpTk5ldFQxcGd2MHcvWU1YcVpNLzhFV1VNd0RYTXYyUThFM0o5aWNEcXlK?=
 =?utf-8?B?bXNtM2FwUzVDWTFlRy9MbmZYRHlYV0F6QllwQzkrTTAwazA1TitPSjZHdmRP?=
 =?utf-8?B?Q2Q0QWJrYVhVTm50d0lEMTV3blNnbGNDZjRQNGJuRzRHQWgvMFY2emhSaEZF?=
 =?utf-8?B?QjlON2R0TDE5QytOeXdWYk9yWG9ON0piOURwNnBRWWRxTlZEM0M1Yis2TlNj?=
 =?utf-8?B?K3JoNWVDS2l0WXVKZlNSVW5ZOWx2SVMyUDRhQUIrQjJ3cTMzVmVNVCsvNGVz?=
 =?utf-8?B?VnUrMDlpVUJ2UzRVMXFjWmZUbnQxQ1EwWnVDTVFNbVRwTGhKRjM5Yjc5VXpm?=
 =?utf-8?B?TjVnbk5NK1dZUXROZ2xQd0xJUnZwY1BKUkhnNXo2Ui91K2tpTFIvQlVjUTJ4?=
 =?utf-8?B?QTNGc1pKdWdYY2Q0Y1lOSmhaUitSVXZSVkRYelREakluVjFmQS9ESFU3aXl4?=
 =?utf-8?B?K21ld04zckU3cmRiUVdBK2c0S05UTmFFUDA3L3pVZFozZ2xHTUN6aDFzaDJh?=
 =?utf-8?B?NkllbmluUmcvZkhJQzNTTUtIZHh2ZDU4MGxnblo3V0dsU1BYWFZzZUJMTktl?=
 =?utf-8?B?czRRdnRUWlhMZDc4OXBQUERQMjhBYWRHbnd0VTdRbTJUYnFVem9Kb1g0blcz?=
 =?utf-8?B?dFlOT2w1bXBNSWRnMWRHaExYK3lIdlpIVmVvRnJyZUFtdDNTeUwvWkpzbldl?=
 =?utf-8?B?M2NFVTQ4U0JqRzV1YlJNcVkzOUtmeGJRcDdEWFo4UHlCR2tScWRzQ1RsTVpB?=
 =?utf-8?B?RmU2OVArYWVrYXEyMElmYmR4UnVLOFhTT1kxOVN2YTAxUC9uTUxUckhmc29i?=
 =?utf-8?B?WmlubTlVUzdrQWdQbFpjMTBIM1FjaDZSREFMdEZDd0pQY0NpTjRBSks5TjNG?=
 =?utf-8?B?Q2pJUVJiZHBnaDVocm9RdFg4VkFGYlU0elZuaVlMUjhPY1RESG5ENWNuVWtt?=
 =?utf-8?B?N09lL1hMaFZCRzZrVFlzU3pWcmNNd2svNDY5eDViWGxob1NzbVo3WXltNTZw?=
 =?utf-8?B?bWptQ1ZJSENDTUJxdjQzSTA1S0FlL2VNTzJnNmJQS3BRSHdocGVYaW12NXhS?=
 =?utf-8?B?bGVjUnJCL1lzeDJvSFovaXZnZmJFZTR1Z25pbHJMRTFkbWFvL0xSZ0M1eDds?=
 =?utf-8?B?TE85ak5kVzJJSEpKTFVRcW12ai96SG9YQ3JTMmJXQlZ3UnFDa0J5R1RsUDkr?=
 =?utf-8?B?cXJBSjVxdVJYTzNnZ1p3QnFIZkJoQXdSMHBLcEVHTGpEOHVFRFNJN3M0cXdD?=
 =?utf-8?Q?bp0gGXoo7xoaR2hR0bniPl0YuVH7WehSsRNS2td?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5959f8e1-a803-48f8-90c7-08d9153f375e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 12:12:30.4289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTMY9KSdG6gQWdhHdgWk3tOR08w6xFMSKwJShnu/L0U63juW7o14aR963ZHTO64u4ndhYrfLnXg2PFfy0u/yjYjKwivxAQ3YjzptmWwUTPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB2695
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-12_06:2021-05-12,
 2021-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 mlxlogscore=895 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105120087
X-Proofpoint-GUID: _hmoCh_yeqEy5yNsL5g7oZbQdvC4a6pD
X-Proofpoint-ORIG-GUID: _hmoCh_yeqEy5yNsL5g7oZbQdvC4a6pD
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105120087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_051242_284392_0405A0E1 
X-CRM114-Status: GOOD (  38.30  )
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

PiBPbiA1LzExLzIxIDc6MTMgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+ID4NCj4gPj4gSSd2
ZSBiZWVuIHRoaW5raW5nIGFib3V0IHdoYXQgeW91IHNhaWQgcmVnYXJkaW5nIHRoZSBuZWVkIHRv
IHJlcGVhdA0KPiA+PiB0aGUgLXcgb3B0aW9uIHdoZW4gdHdvIGludGVyZmFjZXMgc2hhcmUgdGhl
IHNhbWUgSVAgYWRkcmVzcy4gSSB0aGluaw0KPiA+PiB3ZSdyZSBsb29raW5nIGF0IHRoZSBwcm9i
bGVtIGZyb20gYSBkaWZmZXJlbnQgcG9pbnQgb2Ygdmlldy4gVGhlDQo+ID4+IGN1cnJlbnQgaW1w
bGVtZW50YXRpb24gdXNlcyBhbiBJUCBhZGRyZXNzIHRvIGlkZW50aWZ5IGFuIGludGVyZmFjZS4N
Cj4gPj4gSSwgb24gdGhlIG90aGVyIGhhbmQsIGJlbGlldmUgdGhhdCB0aGUgYmVzdCB3YXkgdG8g
aWRlbnRpZnkgYW4NCj4gPj4gaW50ZXJmYWNlIGlzIGJ5IGl0cyAiaW50ZXJmYWNlIG5hbWUgb3Ig
aW5kZXgiLiBJbiBwcmV2aW91cyBlbWFpbHMsIEkNCj4gPj4gcHJvdmlkZWQgZXhhbXBsZXMgb2Yg
dGhlIHByb2JsZW1zIHRoYXQgbWF5IG9jY3VyIHdoZW4gdXNpbmcgYW4gSVANCj4gPj4gYWRkcmVz
cyB0byBpZGVudGlmeSBhbiBpbnRlcmZhY2UuIEZvciBleGFtcGxlLCBvbmUgY2FuIGFzc2lnbiB0
aGUNCj4gPj4gc2FtZSBJUCBhZGRyZXNzIHRvIGRpZmZlcmVudCBpbnRlcmZhY2VzIG1ha2luZyBp
dCBpbXBvc3NpYmxlIHRvDQo+ID4+IGRpc3Rpbmd1aXNoIGludGVyZmFjZXMgYnkgdGhlaXIgSVAg
YWRkcmVzcyBhbG9uZS4gQW5vdGhlciBleGFtcGxlIGlzDQo+ID4+IHRoYXQgdGhlIGxvdyBsZXZl
bCBBUElzIChlLmcuIHNldHNvY2tvcHQoU09fQklORFRPREVWSUNFKSBkb27igJl0IGV2ZW4NCj4g
Pj4gcmVxdWlyZSB0aGUgc291cmNlIElQIGFkZHJlc3MuIFRoZXkgb25seSBuZWVkIHRoZSBpbnRl
cmZhY2UNCj4gPj4gbmFtZS9pbmRleC4gU28sIHdoeSBnbyB0aHJvdWdoIHRoZSB0cm91YmxlIG9m
IHBlcmZvcm1pbmcgYSByZXZlcnNlDQo+ID4+IGFkZHJlc3MgbG9va3VwIHRvIHJldHJpZXZlIHRo
ZSBpbnRlcmZhY2UgbmFtZS9pbmRleCB3aGVuIHRoZSBhZGRyZXNzIGlzDQo+IG5vdCB1c2VkIGF0
IGFsbD8NCj4gPj4NCj4gPj4gQnkgdGhlIHdheSwgaWYgbnZtZS1jbGkvbGludXgtbnZtZSBhbGxv
d2VkIHNwZWNpZnlpbmcgaW50ZXJmYWNlcyBieQ0KPiA+PiBuYW1lL2luZGV4LCB0aGVuIHdlIHdv
dWxkIG5vdCByZWFsbHkgbmVlZCB0byByZXBlYXQgdGhlIC13IG9wdGlvbg0KPiA+PiB1bmxlc3Mg
d2UgYWxzbyB3YW50ZWQgdG8gc2V0IHRoZSBzb3VyY2UgYWRkcmVzcyBhdCB0aGUgc2FtZSB0aW1l
Lg0KPiA+PiBTZXR0aW5nIHRoZSBzb3VyY2UgYWRkcmVzcyBpcyBhIGNvbXBsZXRlbHkgZGlmZmVy
ZW50IHRoaW5nIGZyb20NCj4gPj4gc2V0dGluZyB0aGUgaW50ZXJmYWNlLiBPbmUgc2hvdWxkIGJl
IGFsbG93ZWQgdG8gc2V0IG9uZSBpbmRlcGVuZGVudGx5DQo+ID4+IGZyb20gdGhlIG90aGVyLCBv
ciBib3RoLCBvciBub25lLg0KPiA+Pg0KPiA+PiBJZiB5b3UgbG9vayBhdCBob3cgcGluZyBpcyBp
bXBsZW1lbnRlZCwgdGhleSBkbyBub3QgaW5mZXIgdGhlDQo+ID4+IGludGVyZmFjZSBmcm9tIHRo
ZSBJUCBhZGRyZXNzLiBJZiBvbmUgd2FudHMgdG8gZm9yY2UgcGluZyB0byBnbyBvdmVyDQo+ID4+
IGFuIGludGVyZmFjZSwgdGhlbiBvbmUgbXVzdCBwcm92aWRlIHRoZSBpbnRlcmZhY2UgYnkgbmFt
ZS9pbmRleCB1c2luZw0KPiA+PiB0aGUgLUkgb3B0aW9uLiBJZiBvbmUgd2FudHMgdG8gY2hhbmdl
IHRoZSBzb3VyY2UgSVAgYWRkcmVzcyAod2l0aG91dA0KPiA+PiBmb3JjaW5nIGEgc3BlY2lmaWMg
aW50ZXJmYWNlKSwgdGhlbiBvbmUgcHJvdmlkZXMgdGhlIElQIGFkZHJlc3MgdG8NCj4gPj4gdGhl
IC1JIG9wdGlvbi4gSXQncyBzaW1wbGUgYW5kIGludHVpdGl2ZS4gQW5kIHBpbmcgYWxzbyBzdXBw
b3J0cw0KPiA+PiBhcHBlbmRpbmcgdGhlIGludGVyZmFjZSB0byB0aGUgRGVzdGluYXRpb24gSVAg
dXNpbmcgdGhlICclJyBkZWxpbWl0ZXINCj4gPj4gZm9yIElQdjYtb25seSBhcyBwZXIgUkZDNDAw
Ny4NCj4gPj4NCj4gPj4gSSB0aGluayB0aGF0IG52bWUtY2xpL2xpbnV4LW52bWUgc2hvdWxkIGZv
bGxvdyB0aGUgcGluZyBhcHByb2FjaC4NCj4gPj4gSW50ZXJmYWNlcyBzaG91bGQgbmV2ZXIgYmUg
aW5mZXJyZWQgZnJvbSBzb3VyY2UgSVAgYWRkcmVzc2VzLCBidXQNCj4gPj4gaW5zdGVhZCBiZSBj
bGVhcmx5IGlkZW50aWZpZWQgYnkgdGhlaXIgbmFtZSBvciBpbmRleC4gQW5kIHNldHRpbmcgdGhl
DQo+ID4+IHNvdXJjZSBhZGRyZXNzIHNob3VsZCBiZSBpbmRlcGVuZGVudCBmcm9tIHNldHRpbmcg
dGhlIGludGVyZmFjZS4NCj4gPg0KPiA+IEknbSBzdGFydGluZyB0byB0aGluayB0aGF0IHdlIGFy
ZSBnb2luZyBpbiBjaXJjbGVzLCBJJ20gZ2V0dGluZyB0byB0aGUNCj4gPiBwb2ludCB0aGF0IGhh
dmluZyBob3N0X2lmYWNlIGlzIHRoZSByaWdodCB3YXkgdG8gZ28uDQo+ID4NCj4gPiBXZSBjYW4g
aGF2ZSBudm1lLWNsaSBjb252ZXJ0IDxhZGRyPiVpZmFjZSBub3RhdGlvbiB0bw0KPiA+ICIuLixo
b3N0X3RyYWRkcj08YWRkcj4saG9zdF9pZmFjZT08aWZhY2U+LC4uIiB3aGVuIGNyZWF0aW5nIHRo
ZQ0KPiA+IGNvbnRyb2xsZXIgc3RyaW5nLi4uDQo+IA0KPiBUaGF0IHdhcyBteSB0aGlua2luZywg
dG9vOyB0aGUgb25seSBfb3RoZXJfIHdheSB3b3VsZCBiZSB0byBoYXZlIGENCj4gaG9zdF90cmFk
ZHIgX2ltcGx5XyBhIGJpbmRpbmcgdG8gdGhlIHVuZGVybHlpbmcgaW50ZXJmYWNlLg0KPiBXZSBj
b3VsZCBkZWZpbmUgdGhhdCwgYnV0IGhhdmluZyBhIHNpbmdsZSBvcHRpb24gZG9pbmcgX3R3b18g
ZGlmZmVyZW50DQo+IHRoaW5ncyBpcyBub3QgZ29vZCBzb2Z0d2FyZSBkZXNpZ24uDQo+IFNvIGxl
dCdzIGRvIHRoZSAnaG9zdF9pZmFjZScgdGhpbmdpZS4NCj4gDQo+IENoZWVycywNCj4gDQo+IEhh
bm5lcw0KPiAtLQ0KPiBEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBT
dG9yYWdlIEFyY2hpdGVjdA0KPiBoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICArNDkgOTExIDc0MDUzIDY4OA0KPiBTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcgSFJCIDM2ODA5DQo+IChBRyBOw7xybmJlcmcp
LCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyDQoNClRoYW5rcyBIYW5uZXMg
YW5kIFNhZ2kuIEkgd2lsbCByZXN1Ym1pdCB0aGUgJ2hvc3RfaWZhY2UnIHBhdGNoIGFmdGVyIHJ1
bm5pbmcgbW9yZSBJUHY2IHRlc3RzLiBTYWdpIG1hZGUgbWUgcmVhbGl6ZSB0aGF0IElQdjYgaGFz
IGEgZmV3IHN1YnRsZSBkaWZmZXJlbmNlcyBhbmQgSSBuZWVkIHRvIGRvdWJsZSBjaGVjayB0aGF0
IHRoZSBjdXJyZW50IGhvc3RfaWZhY2UgaW1wbGVtZW50YXRpb24gd29ya3MgYXMgd2VsbCBmb3Ig
SVB2NiBhcyBpdCBkb2VzIGZvciBJUHY0Lg0KTWFydGluDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
