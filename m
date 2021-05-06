Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AE9C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 16:03:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD1F61078
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 16:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD1F61078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mjq1c3iwsF7gECje/h3qvCUwG1H44o9a5SkABj2GNJw=; b=Hz4TtOyM6ElhiPp0f9UnItTv1
	w52f7qESWdDL93TCKaH9L9mILNXu8dZU2cOHoWsk0VcMI6tYRXVZfYYPohFLcdL60SxZhNy1CCphj
	1PTk7y9lDOlU8a9Mcx4AuDnQRmITTL+W0Afa3vXMRvP8KM6hPHeXPqi8DibWiskZ6Cn/n1VXk64P4
	zNvUwwayqTCT3SjlIRGbGVV1UJUA1mNWfgmnvZel9v8qTh58JuwQ+5t4Q19gS+jGajYUjtRPxaARL
	vjn/saH72ICbSVDyMy00jJQsssxSQO1FvPk8E4N/41oz8BwdF/mnVXq+ZluWT8TEUfgJGKfbZXw5R
	kc43WAaPQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1legRP-004jb4-U6; Thu, 06 May 2021 16:01:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1legCz-004ecs-F3
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 15:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=ZoLAU/gS5GGhBwea/GGOMZPuIw4AQHx+zmtWb0oqic0=; b=3YchqiCCvhw2Bl57aImc5hBNNx
 dSfVDc3v+rcsxLlwRfVjpw74437JHmdi/NKpdQ03N73rj4GFj7rM4nhjkqMpVhRMs94io0TMWl+fa
 2yMflBF79Q805GgA4Txr4LShYxcKr6blb487VZJKTmGwOWemaclrDn4TTUYk0bm9IVl5GEDbBlUae
 vHalJCvSWIEMyb7ZLssWIGZ88Ur6kWOHP1m33YcBwWot55whlhz+O/uWVZWqKDd+Gq4sjl1Tu3aHv
 I+og6/9aJpCSwd8yinXV2/DeXjygGd5eirCLQlxQUqXesR8F99D37AJM04FTIMYGPw0QHKlJIza4n
 MUZRiVZA==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1legCv-006B0u-1N
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 15:46:35 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 146FgwnG014056; Thu, 6 May 2021 11:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ZoLAU/gS5GGhBwea/GGOMZPuIw4AQHx+zmtWb0oqic0=;
 b=eE3CBSnvW7SkA7Uz8SQ0uewVTj6HeQrgSc2fJME8CC7xu2O39d/k8erDGLmy6UZZKw86
 33fO0BQCPte0CbDXqRSQSUOh/7lnrhoZSF5zbqlDS9E4XD2g+1+OfOPSUbMviT4NdoJF
 Nnu4+kDXK+qtJsRtygMXPu6H85iwbRrgibGCzEZ4p5NLLSsVYT99s5bosicDeEBuZtQE
 yDhvQK/yWzD+rmobAAacgnn5ULF4o0n9t8aj2yUOL/7y3ovMFO7qwAq0moz+10mvWE4l
 tDqCTQl/FH7I7EBksjHuw7WnfF+hj2TnG9EOdmwXyLGQzT+TGYvkJBDDWJwpWZHVaabw MA== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 38bebn040h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 May 2021 11:46:11 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 146FjH7P156879; Thu, 6 May 2021 11:46:10 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
 by mx0b-00154901.pphosted.com with ESMTP id 38cfduc8fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 May 2021 11:46:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDo/oHWNoUWjcNZrtxKzAM6QFivN5IA/3NC3y+LKvLb1nqGkP//w9VJPsqQeyhPLLKQHKvu1j4NrpZa1IbOTdrf+4E0mO04h0CgjQjUeDAFmoCOi2U1RzmjsVQ0CY35Ttygrrt+O8MOR75aL+AzGg9V41VxeqYg7ccAZSTwehFD7UX+EUDiy3JrHxgz7g/H6WNfHRC3nTgW6J5WqoxaVzlfBnXxOe8w5l5g/lk1N3zJ8FzYd4801gO/3y+kXlcokNadA3l0nbMoaDWZn5EMrjdSpr+EwBYIqn5+QxKfgqESejsCE4jufsK4QEDvvFLPhG2yT89ZtilHeRGesciU0TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoLAU/gS5GGhBwea/GGOMZPuIw4AQHx+zmtWb0oqic0=;
 b=JnCEpRaxLe4dqEobjbVKc726ImerqZfs6AiVKvXzODUyVL6lLafaxa/ivs7/CS45xS7dtMFCgystZLScCWXUh5QvpnHllYrT5PXj2x8J4e8IF43egUWJSt5hl9tgP5MJwYcEZGAmYs2DgCHvxhZcVHjiUddPJbJJV7tp43ANL4CjxCHxarL6mnDXSO9KkYbgj49OyEycanYiyhAWAVHfVsyGaFjHpozqboyuTSBBI/8mvNgBphDs2LCbnKLzJkilqZTX5VXRxcqOJc1arf/0vTUAc19T1+vOgmT8Zfhwcyis4R0EQFR78ZfUemiKLLXKQ8nOLt0KMMDyMyOyTHJssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BY3PR19MB5156.namprd19.prod.outlook.com (2603:10b6:a03:36f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Thu, 6 May
 2021 15:46:07 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6%2]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 15:46:07 +0000
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
Thread-Index: AQHXMi3Bh57r8OJ1AEy+hCu2vgTdtarT2uOAgADXPwCAAE3cYIABF0YAgAAPVACAAIYM0A==
Date: Thu, 6 May 2021 15:46:07 +0000
Message-ID: <SJ0PR19MB4544F01520BE86D205B41B23F2589@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
 <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <b47456a5-69ae-1f33-30f0-aa25906668f2@grimberg.me>
 <27a0071d-7c7b-ee5b-41a2-d5eb8de12928@suse.de>
 <SJ0PR19MB45446577ACEA270069ADB738F2599@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <dbb70739-e636-7f4c-7332-1fbc07332444@suse.de>
 <07fa3404-ed37-052a-c2d7-0e21c119f5c5@suse.de>
In-Reply-To: <07fa3404-ed37-052a-c2d7-0e21c119f5c5@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Martin_Belanger@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-05-06T15:46:04.6917702Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=0f648966-afd4-44da-afcd-f5ce14c15b0f;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72949cf0-d0f8-46db-f57c-08d910a61085
x-ms-traffictypediagnostic: BY3PR19MB5156:
x-microsoft-antispam-prvs: <BY3PR19MB515615AD1F5AA9C930D4A8A7F2589@BY3PR19MB5156.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fcUiKpmp+FXhPWLYV97a+lKvKvNB4fjdgFD/lfRBWvelHj+WgJUbvEaJNXwSQ8et8yR7/HZzINVg7uDVgjlrAIwx8s6mFcg4RNsfYqdsTRYpsHC2zGJ2bQn5Uhx1e8cFWaj3+eS9USMJU0Qoqu4Y/OF7fsJMYWrM29Db7WHtYmC1+haDGNzGHj5SJIh2ScnQxthBYSU++zv038kFwqwC9fiGkU3R7ZCMlVo1T7BNT0bz/3ytbTT6qAN+02mU08kygiOVxqLXXwlTnAA0djDAak/Weo7pZ15mCcw29mPYYOcg3KD7M6koq18aAfdD+uYkqatgKKfylFp21J7dzbiKfQgdk+Ln+6heUWjBVUSsstx13DICYQxHC/f4jtOtmYSqbZ9C9rI9EVLaps5vsJKiBDxpbkWegtsyoBLox5cvKTjpcj+tEcoiszRzarfmxYYp3kpTJBZkhzwwOg7A6xi+jLXV6dSD3p2GQMMjM7LNKRWiIIU6B2AqN2rXdgHag5HpDHpkbxgOLJ7HCgXZVQ29pgtDw4Woa4UWwk7OvOeGalikkUN/w4Gp6FKI/IQn7hnLLXghUzRvCSYlxyn9o5DAn+VCRkUUZpJby7mYoK0e+dvzrKDqIWkzZfi1ZlTq1+d9RHCGgxQS2h1RJ+5RhAoShDYclRcf8e6JwUeDVvxh0ga4k+SFwxMZXJPNh6SL6qjJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(122000001)(66574015)(66476007)(478600001)(71200400001)(7696005)(64756008)(83380400001)(86362001)(186003)(55016002)(66946007)(38100700002)(26005)(316002)(2906002)(8936002)(6506007)(4326008)(33656002)(66556008)(110136005)(9686003)(786003)(66446008)(52536014)(54906003)(53546011)(76116006)(966005)(8676002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZWVrRDdqV3U2Y0VDQldQLy8yUXlnNCt5aExZYkNCZGE3ODViSld1RUZGUDJi?=
 =?utf-8?B?VmhFTVlJenNoTGFXdk1pYTFaOW5pdU56TjV1TCtvT0RNNkxMY3JtRjA0cllR?=
 =?utf-8?B?WE9PZHNWSC9wSkxBVWFrMVZjbGp4akxJdWQvRDEwZFpEWkx4cndCNkNCenJo?=
 =?utf-8?B?NW5mUWlHRjZYVUpaakVUV1NST3BXNUNmQVp4V1E1RkNWZXFlYlBVN3JOYis0?=
 =?utf-8?B?TjRqVncraGNVZ0lzSGU0emltYjJoRTEzWVYrVjdUbWxmOGtRTlkwRXJsM2Fn?=
 =?utf-8?B?M2tjWEZ6dnhiUVl4bkh0RG4zZXBEemZVQmZoYUEwclpOOWJ5aUd2TUkrcHZD?=
 =?utf-8?B?ejA4OERRZmJ4TjBHbWRlYVl1L2haRkg3T0J6b01ZejRDcW9OeTlQZnFFWnBl?=
 =?utf-8?B?Y2dSUDJrOEdHWExCZHdqMXB0bC9tRFJRZEVmdHM4bCt6b1ovVjV0Vmc1MytM?=
 =?utf-8?B?NllhdndERjlnVEhlYUE4QStlOGNQWU1SNkliZHpmcVIvNlR4K3BWaTdFelFu?=
 =?utf-8?B?dFN4Z2RzK3d0aTl4d25mZGNtZ0JXcDA4cDZlS05UQlRIOU9iUnRqSzZhQVN6?=
 =?utf-8?B?UFBMRnBCNExuclEydlpnRzdJVXpTTDNXL2hCSThmMTZKYjVrbzVGT2F3bWJx?=
 =?utf-8?B?akZkMm5BMHUzNGpMS2pHT1ZRZmZkSXJzSXZpVGZ1S1l5VmpVanNiLys1UlNB?=
 =?utf-8?B?R2xjbis4bXRmdEpaS2dOdEY3N2JpYnhZTGlLd0JMUSt1SUdXMTIwSGh6RGFF?=
 =?utf-8?B?VDJ6MEZXSUgwRi9rRzZOeWxCSlJaWHNLM1pOaWpyblpoVHJFMlJpa2lma2ov?=
 =?utf-8?B?azFxL1pQd3BRNDN4YmFWcmp6KzlUdklWWG9BY3M0SjFGc004QVVyQm1GMWt1?=
 =?utf-8?B?cEVEN1pVVEp1OTJ6Yk5xUWJyY3JmRVZhdkdWVVNpVVNycVc5WFRJcHVlNmJ1?=
 =?utf-8?B?OEUyNE83QmhndUFEOEVKcGsvUjkvVDcreWc1NTVkYm50ei9ZdWgwOE9BSFla?=
 =?utf-8?B?NXdJdTVuREdRdzBxQzB4dDlWOFNHV1YydnB1VGRab0NVOVNSKzhUVmFHcVZJ?=
 =?utf-8?B?ai9sak43U1VEcTJORVpCZ0xkQlg1TkZBRmNJY1Q1WmxldndZSU5iTkVLR2d5?=
 =?utf-8?B?cUZVYWREK0t1V2tpbTBJNkVCeWtmbnFCdGZVKy81K1Q2K0RlUzA4b0srRWVZ?=
 =?utf-8?B?SGx3S0xobDYyUUtBMVNIOGhYb1ZmUzhnSjNjZ1NlL00yRk1FS2NRWHREd0dz?=
 =?utf-8?B?b3Bvb0tKa0M4NUZYcGw2a0MxS0FheWh2M3hPcTlCS3duZjgrb3BrdHZYdkVR?=
 =?utf-8?B?M3hxS0doNjNDMVNkR1FqSGdMTkRWQ0RMZE1ianNhby9HbklFcmp6bXA5a0J2?=
 =?utf-8?B?SDB6eXYxa2t0d2NFb3hYUW56bW9UTzhoZWhqRnNrS3FUR3JkOFE3UXpQUGd6?=
 =?utf-8?B?cys2THFFU0hjNmxEem1iMU5jNGc3OEpFK1hVZ1UwK1dVd0RMbjNyMTB4R3JP?=
 =?utf-8?B?WXc5aHZTNDdMRDJBMisvUE9EZy9Fb3RWdFNmN2JjS2Q4ZmlGd3cxOGtOc1NW?=
 =?utf-8?B?enhCNk9ydlJ2TlZlWDMrYzMrdEdXY2Y3Wi81Y3BrdzlNNXhNQlpaR01sbjUz?=
 =?utf-8?B?Z1dSdW1Hd05nbkZ5dkhiaXVvbUN3Ujc5T1R0UGhYMlNray8vT1lreGN0Sm9B?=
 =?utf-8?B?UUlkWE5KL1Arb3ZSOXJsOHVCREZ0K3lzdWVGSEhGdU1FOXNWZkpxbk8zWHVq?=
 =?utf-8?Q?hdMU84Gu+txPBu9LLUBcwS2o6+sYXjw7dgy4bBH?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72949cf0-d0f8-46db-f57c-08d910a61085
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 15:46:07.6072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mHyZgATHIluTEyge5Tc2Ny8Howp/4nltPvX9XdzkBkd9pVRzMIhvMIE35s0AE+VX5mT9EVAPbONYVFXeZE1naG0gt3rnkzQ4LsZQIf/jIjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5156
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-06_10:2021-05-06,
 2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060110
X-Proofpoint-GUID: eybUaAlw3M6pW2lxPp7XOSYiqYAzt6sj
X-Proofpoint-ORIG-GUID: eybUaAlw3M6pW2lxPp7XOSYiqYAzt6sj
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_084633_334049_C9FB9A9C 
X-CRM114-Status: GOOD (  34.06  )
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

PiBPbiA1LzYvMjEgODowNSBBTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPiA+IE9uIDUvNS8y
MSA0OjMxIFBNLCBCZWxhbmdlciwgTWFydGluIHdyb3RlOg0KPiBbIC4uIF0NCj4gPj4gMTogbG86
IDxMT09QQkFDSyxVUCxMT1dFUl9VUD4gbXR1IDY1NTM2IHFkaXNjIG5vcXVldWUgc3RhdGUNCj4g
VU5LTk9XTg0KPiA+PiBncm91cCBkZWZhdWx0IHFsZW4gMTAwMA0KPiA+PiDCoMKgwqDCoCBsaW5r
L2xvb3BiYWNrIDAwOjAwOjAwOjAwOjAwOjAwIGJyZCAwMDowMDowMDowMDowMDowMA0KPiA+PiDC
oMKgwqDCoCBpbmV0IDEwMC4wLjAuMTAwLzI0IHNjb3BlIGdsb2JhbCBsbw0KPiA+PiDCoMKgwqDC
oMKgwqDCoCB2YWxpZF9sZnQgZm9yZXZlciBwcmVmZXJyZWRfbGZ0IGZvcmV2ZXINCj4gPj4gMjog
ZW5wMHMzOiA8QlJPQURDQVNULE1VTFRJQ0FTVCxVUCxMT1dFUl9VUD4gbXR1IDE1MDAgcWRpc2MN
Cj4gZnFfY29kZWwNCj4gPj4gc3RhdGUgVVAgZ3JvdXAgZGVmYXVsdCBxbGVuIDEwMDANCj4gPj4g
wqDCoMKgwqAgbGluay9ldGhlciAwODowMDoyNzoyMTo2NTplYyBicmQgZmY6ZmY6ZmY6ZmY6ZmY6
ZmYNCj4gPj4gwqDCoMKgwqAgaW5ldCAxMDAuMC4wLjEwMC8yNCBzY29wZSBnbG9iYWwgZW5wMHMz
DQo+ID4+IMKgwqDCoMKgwqDCoMKgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9y
ZXZlcg0KPiA+PiAzOiBlbnAwczg6IDxCUk9BRENBU1QsTVVMVElDQVNULFVQLExPV0VSX1VQPiBt
dHUgMTUwMCBxZGlzYw0KPiBmcV9jb2RlbA0KPiA+PiBzdGF0ZSBVUCBncm91cCBkZWZhdWx0IHFs
ZW4gMTAwMA0KPiA+PiDCoMKgwqDCoCBsaW5rL2V0aGVyIDA4OjAwOjI3OjRmOjk1OjVjIGJyZCBm
ZjpmZjpmZjpmZjpmZjpmZg0KPiA+PiDCoMKgwqDCoCBpbmV0IDEwMC4wLjAuMTAwLzI0IHNjb3Bl
IGdsb2JhbCBlbnAwczgNCj4gPj4gwqDCoMKgwqDCoMKgwqAgdmFsaWRfbGZ0IGZvcmV2ZXIgcHJl
ZmVycmVkX2xmdCBmb3JldmVyDQo+ID4+DQo+ID4+IFRoZSBhYm92ZSBpcyBhIFZNIHRoYXQgSSBj
b25maWd1cmVkIHdpdGggdGhlIHNhbWUgSVAgYWRkcmVzcw0KPiA+PiAoMTAwLjAuMC4xMDApIG9u
IGFsbCBpbnRlcmZhY2VzLiBEb2luZyBhIHJldmVyc2UgbG9va3VwIHRvIGlkZW50aWZ5DQo+ID4+
IHRoZSB1bmlxdWUgaW50ZXJmYWNlIGFzc29jaWF0ZWQgd2l0aCAxMDAuMC4wLjEwMCB3b3VsZCBz
aW1wbHkgbm90DQo+ID4+IHdvcmsgaGVyZS4gQW5kIHRoaXMgaXMgd2h5IHRoZSBvcHRpb24gaG9z
dF9pZmFjZSBpcyByZXF1aXJlZC4gSQ0KPiA+PiB1bmRlcnN0YW5kIHRoYXQgdGhlIGFib3ZlIGNv
bmZpZyBkb2VzIG5vdCByZXByZXNlbnQgYSBzdGFuZGFyZCBob3N0DQo+ID4+IHN5c3RlbSwgYnV0
IEknbSB1c2luZyB0aGlzIHRvIHByb3ZlIGEgcG9pbnQ6ICJ3ZSBjYW4gbmV2ZXIga25vdyBob3cg
YQ0KPiA+PiB1c2VyIHdpbGwgY29uZmlndXJlIHRoZWlyIHN5c3RlbSBhbmQgdGhlIGFib3ZlIGNv
bmZpZ3VyYXRpb24gaXMNCj4gPj4gcGVyZmVjdGx5IGZpbmUgYnkgTGludXgiLg0KPiA+Pg0KPiA+
DQo+ID4gLi4uIGFuZCBtZXNzaW5nIHVwIGFueSBzd2l0Y2ggTUFDIGFkZHJlc3MgY2FjaGluZyB3
aGVuIGRvaW5nIHNvLiBJDQo+ID4gZ3Vlc3MgdGhlIG5ldHdvcmsgYWRtaW4gd2lsbCBjb21lIGRv
d24gaGFyZCBvbiB5b3UgaWYgeW91IHRyeSB0aGF0IG9uDQo+ID4gYSBwcm9kdWN0aW9uIHN5c3Rl
bS4NCj4gPiBBbmQgSSBzaW5jZXJlbHkgcXVlc3Rpb24gd2hldGhlciB0aGlzIGlzIGEgdmFsaWQg
dXNlLWNhc2U7IEknbSBhbHJlYWR5DQo+ID4gZ2V0dGluZyBncmllZiBmcm9tIG91ciBuZXR3b3Jr
IGFkbWlucyBpZiBJIGRhcmUgdG8gcHV0IHR3byBuZXR3b3JrDQo+ID4gaW50ZXJmYWNlcyBmcm9t
IHRoZSBzYW1lIG1hY2hpbmUgaW4gdGhlIHNhbWUgbmV0d29yay4NCj4gPg0KPiA+PiBUaGUgY3Vy
cmVudCBUQ1AgaW1wbGVtZW50YXRpb24gZm9yIGhvc3RfdHJhZGRyIHVzZXMNCj4gPj4gYmluZCgp
LWJlZm9yZS1jb25uZWN0KCkuIFRoaXMgaXMgYSBjb21tb24gY29uc3RydWN0IHRvIHNldCB0aGUg
c291cmNlDQo+ID4+IElQIGFkZHJlc3Mgb24gdGhlIHNvY2tldCBiZWZvcmUgY29ubmVjdGluZy4g
VGhpcyBoYXMgbm8gZWZmZWN0IG9uIGhvdw0KPiA+PiBMaW51eCB3aWxsIHNlbGVjdCB0aGUgaW50
ZXJmYWNlIGZvciB0aGUgY29ubmVjdGlvbi4gVGhhdCdzIGJlY2F1c2UNCj4gPj4gTGludXggdXNl
cyB0aGUgV2VhayBFbmQgU3lzdGVtIG1vZGVsIGFzIGRlc2NyaWJlZCBpbiBSRkMxMTIyIFsyXS4N
Cj4gPj4gU2V0dGluZyB0aGUgc291cmNlIGFkZHJlc3Mgb24gYSBjb25uZWN0aW9uIGlzIGEgY29t
bW9uIHJlcXVpcmVtZW50DQo+ID4+IHRoYXQgbGludXgtbnZtZSBuZWVkcyB0byBzdXBwb3J0LiBJ
biBmYWN0LCBzcGVjaWZ5aW5nIHRoZSBTb3VyY2UgSVANCj4gPj4gYWRkcmVzcyBpcyBhIG1hbmRh
dG9yeSBGZWRHb3YgcmVxdWlyZW1lbnQgKGUuZy4gY29ubmVjdGlvbiB0byBhDQo+ID4+IFJBRElV
Uy9UQUNBQ1MrIHNlcnZlcikuIENvbnNpZGVyIHRoZSBmb2xsb3dpbmcgY29uZmlndXJhdGlvbi4N
Cj4gPj4NCj4gPj4gJCBpcCBhZGRyIGxpc3QgZGV2IGVucDBzOA0KPiA+PiAzOiBlbnAwczg6IDxC
Uk9BRENBU1QsTVVMVElDQVNULFVQLExPV0VSX1VQPiBtdHUgMTUwMCBxZGlzYw0KPiBmcV9jb2Rl
bA0KPiA+PiBzdGF0ZSBVUCBncm91cCBkZWZhdWx0IHFsZW4gMTAwMA0KPiA+PiDCoMKgwqDCoCBs
aW5rL2V0aGVyIDA4OjAwOjI3OjRmOjk1OjVjIGJyZCBmZjpmZjpmZjpmZjpmZjpmZg0KPiA+PiDC
oMKgwqDCoCBpbmV0IDE5Mi4xNjguNTYuMTAxLzI0IGJyZCAxOTIuMTY4LjU2LjI1NSBzY29wZSBn
bG9iYWwgZHluYW1pYw0KPiA+PiBub3ByZWZpeHJvdXRlIGVucDBzOA0KPiA+PiDCoMKgwqDCoMKg
wqDCoCB2YWxpZF9sZnQgNDI2c2VjIHByZWZlcnJlZF9sZnQgNDI2c2VjDQo+ID4+IMKgwqDCoMKg
IGluZXQgMTkyLjE2OC41Ni4xMDIvMjQgc2NvcGUgZ2xvYmFsIHNlY29uZGFyeSBlbnAwczgNCj4g
Pj4gwqDCoMKgwqDCoMKgwqAgdmFsaWRfbGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVy
DQo+ID4+IMKgwqDCoMKgIGluZXQgMTkyLjE2OC41Ni4xMDMvMjQgc2NvcGUgZ2xvYmFsIHNlY29u
ZGFyeSBlbnAwczgNCj4gPj4gwqDCoMKgwqDCoMKgwqAgdmFsaWRfbGZ0IGZvcmV2ZXIgcHJlZmVy
cmVkX2xmdCBmb3JldmVyDQo+ID4+IMKgwqDCoMKgIGluZXQgMTkyLjE2OC41Ni4xMDQvMjQgc2Nv
cGUgZ2xvYmFsIHNlY29uZGFyeSBlbnAwczgNCj4gPj4gwqDCoMKgwqDCoMKgwqAgdmFsaWRfbGZ0
IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyDQo+ID4+DQo+ID4+IEhlcmUgd2UgY2FuIHNl
ZSB0aGF0IHNldmVyYWwgYWRkcmVzc2VzIGFyZSBhc3NvY2lhdGVkIHdpdGggaW50ZXJmYWNlDQo+
ID4+IGVucDBzOC4gQnkgZGVmYXVsdCwgTGludXggd2lsbCBzZWxlY3QgdGhlIGRlZmF1bHQgSVAg
YWRkcmVzcywNCj4gPj4gMTkyLjE2OC41Ni4xMDEsIGFzIHRoZSBzb3VyY2UgYWRkcmVzcyB3aGVu
IGNvbm5lY3Rpbmcgb3ZlciBpbnRlcmZhY2UNCj4gPj4gZW5wMHM4LiBTb21lIHVzZXJzLCBob3dl
dmVyLCB3YW50IHRoZSBhYmlsaXR5IHRvIHNwZWNpZnkgYSBkaWZmZXJlbnQNCj4gPj4gYWRkcmVz
cyAoZS5nLiwNCj4gPj4gMTkyLjE2OC41Ni4xMDMpIHRvIGJlIHVzZWQgYXMgdGhlIHNvdXJjZSBh
ZGRyZXNzLg0KPiA+PiBUaGUgb3B0aW9uIGhvc3RfdHJhZGRyIGNhbiBiZSB1c2VkIGFzLWlzIHRv
IHBlcmZvcm0gdGhpcyBmdW5jdGlvbiAoSQ0KPiA+PiB0ZXN0ZWQgaXQpLg0KPiA+Pg0KPiA+DQo+
ID4gTm8gZGlzYWdyZWVtZW50IGhlcmUuDQo+ID4NCj4gPj4gSW4gY29uY2x1c2lvbiwgSSBiZWxp
ZXZlIHRoYXQgZm9yIFRDUCB3ZSBuZWVkIDIgb3B0aW9ucy4gT25lIHRoYXQgY2FuDQo+ID4+IGJl
IHVzZWQgdG8gc3BlY2lmeSBhbiBpbnRlcmZhY2UuIEFuZCBvbmUgdGhhdCBjYW4gYmUgdXNlZCB0
byBzZXQgdGhlDQo+ID4+IHNvdXJjZSBhZGRyZXNzLiBBbmQgdXNlcnMgc2hvdWxkIGJlIGFsbG93
ZWQgdG8gdXNlIG9uZSBvciB0aGUgb3RoZXIsDQo+ID4+IG9yIGJvdGgsIG9yIG5vbmUuDQo+ID4+
IE9mIGNvdXJzZSwgdGhlIGRvY3VtZW50YXRpb24gZm9yIGhvc3RfdHJhZGRyIHdpbGwgbmVlZCBz
b21lDQo+ID4+IGNsYXJpZmljYXRpb24uIEl0IHNob3VsZCBzdGF0ZSB0aGF0IHdoZW4gdXNlZCBm
b3IgVENQIGNvbm5lY3Rpb24sDQo+ID4+IHRoaXMgb3B0aW9uIG9ubHkgc2V0cyB0aGUgc291cmNl
IGFkZHJlc3MuIEFuZCB0aGUgZG9jdW1lbnRhdGlvbiBmb3INCj4gPj4gaG9zdF9pZmFjZSBzaG91
bGQgc2F5IHRoYXQgdGhpcyBvcHRpb24gb25seSBhcHBsaWVzIHRvIFRDUA0KPiA+PiBjb25uZWN0
aW9ucy4NCj4gPj4NCj4gPg0KPiA+IEknbSB3aXRoIEphbWVzIFNtYXJ0IGhlcmUuIEkgZG8gZmFp
bCB0byBzZWUgdGhlIG5lZWQgZm9yICdob3N0X2lmYWNlJw0KPiA+IF93aXRob3V0XyAnaG9zdF90
cmFkZHInOyBlc3BlY2lhbGx5IGZvciBJUHY2IHdoZXJlIHNldmVyYWwgYWRkcmVzc2VzDQo+ID4g
YXJlIHN0YW5kYXJkIGp1c3Qgc3BlY2lmeWluZyAnaG9zdF9pZmFjZScgc2ltcGx5IGlzIG5vdCBl
bm91Z2gsIGFuZA0KPiA+IG9uZSBoYXMgdG8gc3BlY2lmeSAnaG9zdF90cmFkZHInIGFkZGl0aW9u
YWxseS4NCj4gPg0KPiA+IFNvICdob3N0X2lmYWNlJyBzaG91bGQgYmUgY29udGluZ2VudCBvbiAn
aG9zdF90cmFkZHInLCBtZWFuaW5nIHdlIGNhbg0KPiA+IGp1c3QgZXhwYW5kIHRoZSBzeW50YXgg
b2YgJ2hvc3RfdHJhZGRyJy4NCj4gPiBPbmUgZWFzeSBwb3NzaWJpbGl0eSB3b3VsZCBiZSB0byBh
ZGQgJyxub2JpbmQnIHRvIHRoZSBob3N0X3RyYWRkcg0KPiA+IHN5bnRheCB3aGljaCB3b3VsZCBp
bmRpY2F0ZSB0aGF0IHdlIHNob3VsZCBfbm90XyBiaW5kIHRvIHRoZQ0KPiA+IHVuZGVybHlpbmcg
aW50ZXJmYWNlOyBJIGRvIHRoaW5rIHRoYXQgYmluZGluZyB0byB0aGUgcmVzcGVjdGl2ZQ0KPiA+
IGludGVyZmFjZSBzaG91bGQgYmUgdGhlIGRlZmF1bHQuDQo+ID4NCj4gQS1oYS4gSnVzdCBzcG9r
ZSB0byBvdXIgbmV0d29yayBmb2xrcywgYW5kIHRoZXkgY2xhcmlmaWVkIHRoZSB1c2FnZSBvZiBi
aW5kaW5nDQo+IHRvIGFuIElQIGFkZHJlc3MgdnMgYmluZGluZyB0byBhIG5ldHdvcmsgaW50ZXJm
YWNlLg0KPiBBcHBhcmVudGx5LCBiaW5kaW5nIHRvIGEgc291cmNlIElQIGFkZHJlc3MgZG9lcyBq
dXN0IHRoYXQsIHNldHRpbmcgdGhlIHNvdXJjZQ0KPiBJUCBhZGRyZXNzIG9mIHRoZSBvdXRnb2lu
ZyBwYWNrZXQuIFRoYXQgcGFja2V0IHdpbGwgX3N0aWxsXyBiZSBzdWJqZWN0ZWQgdG8gdGhlDQo+
IG5vcm1hbCByb3V0aW5nIHRhYmxlLCBhcyB0aGUgcm91dGluZyB0YWJsZSBpcyBqdXN0IGluZmx1
ZW5jZWQgYnkgdGhlDQo+IF9kZXN0aW5hdGlvbl8gSVAgYWRkcmVzcy4NCj4gU28gaWYgd2Ugd2Fu
dCB0byBoYXZlIGl0IHJvdXRlZCB2aWEgYSBzcGVjaWZpYyBpbnRlcmZhY2UgKGFuZCB0aGVyZWJ5
DQo+IGluZmx1ZW5jaW5nIHRoZSByb3V0aW5nIHRhYmxlKSB3ZSBuZWVkIHRvIGJpbmQgaXQgdG8g
dGhhdCBpbnRlcmZhY2UuDQo+IA0KPiBUaGUgb25seSB2YWxpZCBzY2VuYXJpbyBvdXIgbmV0d29y
ayBmb2xrcyBjb3VsZCBjb21lIHVwIHdpdGggd2hlcmUgd2UgZG8NCj4gX25vdF8gd2FudCB0byBi
aW5kIHRvIGFuIGludGVyZmFjZSBpcyBmb3IgYXN5bW1ldHJpYyBmbG93cywgaWUgaW4gY2FzZXMg
d2hlcmUNCj4gdGhlIG91dGdvaW5nIGZsb3cgaXMgcm91dGVkIHRvIG9uZSBpbnRlcmZhY2UgYW5k
IHRoZSBpbmNvbWluZyBmbG93IGlzIGFycml2aW5nDQo+IG9uIGFub3RoZXIgaW50ZXJmYWNlLiBC
dXQgZXZlbiB0aGV5IGFkbWl0dGVkIHRoYXQgaXQncyBub3QgYSBjb21tb24NCj4gc2NlbmFyaW8s
IGFuZCBwcm9iYWJseSB3aWxsIGJlIGtpbGxlZCBieSBhbnRpLXNwb29maW5nIHNvZnR3YXJlIHJ1
bm5pbmcgb24NCj4gdGhlIGNvcmUgc3dpdGNoZXMgLi4uDQo+IA0KPiBCdXQgaWYgd2Ugd2FudCB0
byBzdXBwb3J0IF90aGF0XyB0aGVuIGNsZWFybHkgYmluZGluZyB0byBhIHNwZWNpZmljIGludGVy
ZmFjZQ0KPiBkb2Vzbid0IHdvcmsuDQo+IA0KPiBTbyBJIHdvdWxkIHZvdGUgZm9yIG1ha2luZyBi
aW5kaW5nIHRvIHRoZSBuZXR3b3JrIGludGVyZmFjZSBob2xkaW5nIHRoZSBJUA0KPiBhZGRyZXNz
IHRoZSBkZWZhdWx0LCBhbmQgYWRkIGFuIG9wdGlvbiAnLG5vYmluZCcgdG8gaG9zdF90cmFkZHIg
dG8gc2tpcCBpdC4NCj4gDQo+IENoZWVycywNCj4gDQo+IEhhbm5lcw0KPiAtLQ0KPiBEci4gSGFu
bmVzIFJlaW5lY2tlCQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdA0KPiBoYXJlQHN1
c2UuZGUJCQkgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OA0KPiBTVVNFIFNvZnR3YXJl
IFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZw0KPiBHRjogRi4gSW1lbmTD
tnJmZmVyLCBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZykNCg0KSGkgSGFubmVzLA0KDQpJZiB0aGUg
b25seSBjb25jZXJuIGhlcmUgaXMgdGhlIGFkZGl0aW9uIG9mIHlldCBhbm90aGVyIG9wdGlvbiAo
LS1ob3N0LWlmYWNlKSwgdGhlbiBtYXkgSSBzdWdnZXN0IGEgc2ltcGxlciBhcHByb2FjaC4gV2hh
dCBJJ20gcHJvcG9zaW5nIGFkaGVyZXMgdG8gUkZDNDAwNyBbMV0sIHdoaWNoIGRlZmluZXMgYSB3
YXkgdG8gc3BlY2lmeSBhbiBpbnRlcmZhY2UgYnkgdXNpbmcgdGhlICclJyBkZWxpbWl0ZXIgYmV0
d2VlbiB0aGUgRGVzdGluYXRpb24gSVAgYWRkcmVzcyBhbmQgdGhlIEludGVyZmFjZS4gSW4gZmFj
dCwgInBpbmciIHVzZXMgdGhpcyBhcHByb2FjaCBbMl0uIFdpdGggcGluZywgb25lIGNhbiBmb3Jj
ZSB0aGUgY29ubmVjdGlvbiB0byBnbyBhIHNwZWNpZmljIGludGVyZmFjZSBsaWtlIHRoaXM6DQoN
CnBpbmcgPGRlc3QtaXAtYWRkcj4lPGludGVyZmFjZT4NCg0KRXh0ZW5kaW5nIHRoaXMgYXBwcm9h
Y2ggdG8gbnZtZS1jbGkgd2UgYXJyaXZlIHRvIHNvbWV0aGluZyBsaWtlIHRoaXM6DQoNCm52bWUg
ZGlzY292ZXIgLS10cmFkZHIgMTAwLjY0LjI5LjIlZW5wMHM4IC0taG9zdC10cmFkZHIgMTkyLjE2
OC41Ni4xMDIgLi4uLg0KDQpUaGlzIHRlbGxzIG52bWUgdG8gY29ubmVjdCB0byAxMDAuNjQuMjku
MiBvbiBpbnRlcmZhY2UgZW5wMHM4LiBXZSBtYWtlIG5vIGNoYW5nZSB0byB0aGUgLS1ob3N0LXRy
YWRkciBvcHRpb24uIEl0IGNvbnRpbnVlcyB0byBiZSB1c2VkIHRvIHNwZWNpZnkgdGhlIFNvdXJj
ZSBJUCBhZGRyZXNzIG9ubHkgKGZvciB0aGUgcmFyZSBjYXNlcyB3aGVyZSB1c2VycyB3YW50IHRv
IHNwZWNpZnkgYSBTb3VyY2UgQWRkcmVzcyBvdGhlciB0aGFuIHRoZSBkZWZhdWx0KS4gV2l0aCB0
aGlzLCB0aGUgaW50ZXJmYWNlIGlzIHNwZWNpZmllZCBieSBuYW1lIGFuZCBub3QgYnkgaXRzIGFz
c29jaWF0ZWQgYWRkcmVzcy4gVGhpcyBpcyBub3Qgb25seSBtb3JlIGludHVpdGl2ZSwgYnV0LCBh
cyBJIHN0YXRlZCBiZWZvcmUsIGVsaW1pbmF0ZXMgdGhlIHByb2JsZW0gY2F1c2VkIGJ5IG1hcHBp
bmcgdGhlIHNhbWUgSVAgYWRkcmVzcyB0byBtdWx0aXBsZSBpbnRlcmZhY2VzIChub3QgdG8gbWVu
dGlvbiB0aGF0IGRvaW5nIGEgcmV2ZXJzZSBsb29rdXAgb24gYW4gSVAgYWRkcmVzcyB0byBmaW5k
IHRoZSBpbnRlcmZhY2UgaXMgZXh0cmEgd29yayB0aGF0IHdlIGRvbuKAmXQgbmVlZCB0byBkbyBp
biBrZXJuZWwgc3BhY2UpLg0KDQpUaGlzIGdpdmVzIHVzIGZ1bGwgY29udHJvbC4gSXQgYWxsb3dz
IHVzIHRvIHNldCB0aGUgImludGVyZmFjZSIgYW5kIHRoZSAic291cmNlIGFkZHJlc3MiLiBXZSBj
YW4gc2V0IGJvdGgsIG9yIG9ubHkgb25lIG9mIHRoZSB0d28sIG9yIG5vbmUuIEl0IGZvbGxvd3Mg
c3RhbmRhcmRzIGFuZCB0aGVyZSBpcyBhIHByZWNlZGVudCB3aXRoICJwaW5nIi4NCg0KTk9URTog
UkZDNDAwNyBzcGVjaWZpY2FsbHkgZGlzY3Vzc2VzIHNwZWNpZnlpbmcgYW4gSW50ZXJmYWNlIGZv
ciBJUHY2LCBidXQgSSBkb27igJl0IHNlZSBhbnkgaXNzdWUgZXh0ZW5kaW5nIHRoZSB1c2Ugb2Yg
dGhlICclJyBkZWxpbWl0ZXIgdG8gSVB2NCBhcyB3ZWxsLg0KDQpSZWY6DQpbMV0gaHR0cHM6Ly90
b29scy5pZXRmLm9yZy9odG1sL3JmYzQwMDcNClsyXSBodHRwczovL21hbjcub3JnL2xpbnV4L21h
bi1wYWdlcy9tYW44L3BpbmcuOC5odG1sDQoNClJlZ2FyZHMsDQoNCk1hcnRpbiBCZWxhbmdlcg0K
RGVsbCBFTUMNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
