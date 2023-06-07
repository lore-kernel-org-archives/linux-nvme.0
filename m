Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3ADC7EE23
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 03:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zV58o3Z2gLClGPdK/i2p9PnYsgO/UqpcJ94wOE3qA2c=; b=GDaixkDZrvFrsEqUjikZGklW+9
	Yfhu1PJkIBtRRpz3Cu9KFCVbXQsnyYFeIAsBaCRuAixkDXIIKDPfhDsMpwd3meJkx6IPgueqhMb2Y
	zzcVZomsTGXnrldLqJRngEHLBnBFqOL+AJ6mzimQVUpYpfr3ARNAKhAFiYzkyrBPn7HMaGIv79XGb
	akjqX7pytbEsx83wv+X1ZfddtzMQVVxGZVBtEkOQPGlCop0lsODrou+bVsFRKyMK+gFYjkZxtXFF8
	1GzUQmu4q5EEP2xj7SyWz5uV1End622TKu8MaOwWpnAB2NGXu7hdD0z1FrrfyQX23u0XwcxSxHfFp
	hajHOwNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6k5m-004CTh-0p;
	Wed, 07 Jun 2023 03:44:14 +0000
Received: from mail-dm6nam10on20603.outbound.protection.outlook.com ([2a01:111:f400:7e88::603] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6k5j-004CSn-0d
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 03:44:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfoQglWtTFfWKkGzjbc7qaIA1lM/fS4thFzm2MfhcFRoPtoT9KUJqYyJdO447VkDPzIrBp9dk/m6tmst4isxVqS8o41JKUCAQbV1354peVFoB0qQKZ0ZOiDeGkQYM4qNJry+JVNLEzVizPYed8bbQMoAEO12BVlyaFeVLimmWiLXWgrLayFPEVHlGHSbJEQtjL8+nzjxggHStRPO4uHu+x7qDPT96dZSlbZBR89xtIUfm6OyeL0UCT/OStS9BwPT5KT/F/ArHf/h+aYHPwqR9cO2bUExEizoRSartJLJc546j1s0H8tzlD7ftLfjso2Z0b+/5LXaPA9RMvivl/PdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zV58o3Z2gLClGPdK/i2p9PnYsgO/UqpcJ94wOE3qA2c=;
 b=F1LzlstHTt7Kx/RiGGEYyq88lDcKRsdItzQenQcKPhokc0nbKVQ4GEMt8gJohKLMkT30QCdTx2vganpW+5e1DhYIBScAXOi8D1cEVS8rcDr+sC4NX6FOrS0fMXXzpBxScUXJx5TaOSwxVEcKuEQUGfHROB4UbSPDcQVBKxrnGPufHZgZlUqc/SHqX++2gAUTqoLatL8QRWQBtVsWs+fRAqaFw9OMzUZr12PqLUcmUCuzMrd3Tq3wA2U7P/dRZ7048/7tWFQOYaogDA7Ny16XvYmpzX10Ahw2xQJGyyKV/FtGQ99OaLzk/Qwg0ulzVFr6DN70gKrshzDVN8Fl46pfOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zV58o3Z2gLClGPdK/i2p9PnYsgO/UqpcJ94wOE3qA2c=;
 b=dAC9S79JnMPE4/MBBZiEVmUfp3blrfu/I8YXamnGbza7t0FOl+cNLn1mB9zwJmszhHmmytqqqRDJAPhAJ1VRNk7JOHT6ErwyjqguzgZWPH/ZmZNw0iM4VJ6lYy0UzYMIdssWTbcZst5OLb1poQmFqnjlCMeNT24KKSOk8NSBUSmUA4PPajLNdR+abDA6Bw+U/lULaxrCLR0EQc+ECjZC8Bj2cQ+K7z1jVLT1BJu66EViUj0yXw0WYr9j07YmR8y9S/XfbNi+oGP6pbvneSlAkEb0MAWDN+b2qIYyvJjJaHVbyzwq4pojezHvajIU1mc1lTF4FR0LNNzXdckbQ9+uFQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 03:44:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 03:44:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 1/2] nvme: add generic helper to store secret
Thread-Topic: [PATCH V2 1/2] nvme: add generic helper to store secret
Thread-Index: AQHZl3o4u/p44zHH/kCtzfYYlr2fna98y6uAgABSD4CAADepAIABYEWA
Date: Wed, 7 Jun 2023 03:44:05 +0000
Message-ID: <01629a7f-6632-193f-65af-ee51eff72273@nvidia.com>
References: <20230605065125.47563-1-kch@nvidia.com>
 <20230605065125.47563-2-kch@nvidia.com>
 <ef1a8621-ae27-1b06-fbc2-b3cb1e137b1e@grimberg.me>
 <478ca846-cf68-c8db-d4e5-f862775d16c2@nvidia.com>
 <2ce728ac-54b7-f59d-a0c0-b585767a9428@grimberg.me>
In-Reply-To: <2ce728ac-54b7-f59d-a0c0-b585767a9428@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4091:EE_
x-ms-office365-filtering-correlation-id: 2c8a4f10-6281-40dc-1b72-08db67097151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3Zt3cFdtr2f38HMjEoPtCRItNY5oQg25LBjULrtgVCMj6ossKcQYI7kIPlPpXQUx738TOD4crzqX7vUwEa34MTygq+88nRb83LIdH8CghnFjOrP+rdJ7ZXJeIFkUfhyuxR2KTzWtm3NgEMOpkIYmbPA90CP3m7/xmkdT96WfKocWjOTJ/c+sUK9XU02k0ez8nEICzEq1WopnpLgzVg1diQMSK2fbnd6TWggEXo4Bcz7JuTANBHkbOWoPWKtNcrazSEJYwC1xahhXahsYMSP1lv9d79VQAthd5qUgw2mIYeep40ENFLgBnDYRQrK3aWUq6hM78AnxvjplFOMcUb78iPXOY32Lfm2VU3jLp93QoW3WxQq2pkFNAcHbaELsYNYt1ulSQPrjZzDIfDrJ1S/XyuL/CIRYmU4FWn0XJUfZz144u07KmUpyxGeDx1K+pddzFJKBc/8IKvGacFYWeBfM5zT2FuRjuqLd2y0IqURvtJW0g+Vu8k8VwT8gf7HoJrHweZZbp4rmkd7OWAe7JyVylZUg20i01aZRVMa4q3bA8QtnhBIIXx3ne5jb2uYY+r5cv2iwJwRelwEquXet6yLmsKuNK4UeF+zW+Mlca6UlfB22FjwMj1WShgtKxxvEJspzq3fdPCvhoEu4hrbb0dYFCE2BVn2hbBw2EXsv1eDwrpBz5Ro0NqVmmImN4hRgyZgkv1pGTs1y52/80R3FvUMFH+6RbNXXPB0tGI+7Nf9oqw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(8676002)(31696002)(478600001)(110136005)(54906003)(2616005)(6512007)(6506007)(53546011)(71200400001)(83380400001)(186003)(6486002)(36756003)(2906002)(122000001)(38100700002)(4326008)(66476007)(64756008)(66946007)(66446008)(8936002)(91956017)(76116006)(86362001)(5660300002)(66556008)(38070700005)(41300700001)(316002)(31686004)(41533002)(219293001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVlwNTJKRHhUeXZKdk1qUlo4OFdHa1NXWDA5aDJRUnhaTFd5ZlpJSjVMdDA1?=
 =?utf-8?B?MkRiM3FLcm5seWVEeC9BNVo2WDgrdDhBc09ad0dBcHVPNzVMQjgwcG9FOVBD?=
 =?utf-8?B?ZFlEcXA0aVZ1b0FkMWlGLzdBaGZBMGhwc21jdUlXbUpMQVBsVFJFNS9QOW5G?=
 =?utf-8?B?ZG9SaHJXVjZDYnQ0NTNKRXlrbVJpbmpVWUJyK0R1OXB2d1RNanRycS9zZTRr?=
 =?utf-8?B?bVBkcmh4a0FQbG5QZFU0ZGVvVDJwSndJVlN3RFNRR3cyaGo2MXRPSXFINVgr?=
 =?utf-8?B?ZmdGeXBDV1FBcEh0TzFERGVpUU1GVWVoZUU4UlhiWDF2OC9HM3JybFdJanVo?=
 =?utf-8?B?blhsWGk0U2g1ZFhoVkxWeDNzb1IraDVYZ3p0QkFoeHdPUVZPekxlaHdNUmRR?=
 =?utf-8?B?L05tbHVCWVBscW9yN2F4OUkvQVYzM1ZoVi9aUHlwbUJURGZPRHBFRDd6OEox?=
 =?utf-8?B?VnVmODA4T2RSQ29DQVBUSHdMNG8wQlFXc2drRGlaaHNrdDZkV0U1Q25CRnNK?=
 =?utf-8?B?Q2hndzZtbnozYXdPWXNLQ2Z0U1Q2T3BXNGd4ejNBNEVJaXhJZlRDdTNVa2V5?=
 =?utf-8?B?a01vV3lSanZ0N0xVYWFxMkRWeTJMRW5ja0l1VlljeUh5VW8rdVdldkZJNE1y?=
 =?utf-8?B?SG9LTm9JVVNEZ3lWV2d6UCtvSEU5YzVYOTZZeC85dGV3OU5Za3U4VWc4MEoy?=
 =?utf-8?B?MkNtMXNYRGU5NUd2eldCdC9WYy9TWVNCbWtnSDM1NkIwUDQrTWRCU3RaS3dP?=
 =?utf-8?B?Z0JTa0gya2c4MGtkM09HM1dkeE42aUNOVFZId3ArdTBZMFNiNk1kd2RWbjlz?=
 =?utf-8?B?cmtZQ1crTmEzUFViQjI5NjhPRjluTWlGMWpjRGNaVVlXTllIUVNHNFE5UWhi?=
 =?utf-8?B?ZzJFa1RlaGxLSGNRUG0vOEZaSzkvSXFBckFEcVZ5R3l2OXlJVXlWclFaRHh1?=
 =?utf-8?B?UG5QSWloZHpJSVltSWZ6eEZ4VHZRbG5QbTZjM3d4OTlock9NcFg0R0psTDR2?=
 =?utf-8?B?dDFTWGk4VEdWd1RvbjBBdEJldStlTFNBYXFuZlpHTkl4UThoaSsza1BsWjI4?=
 =?utf-8?B?SE1KRGhDeC9LZlF1clM2UU1zdktrSlZSRUdZYlRJQzhUQ0Q1ZDhVYkJxOXJn?=
 =?utf-8?B?U0RhbEVlWWl5b0EwalRLWkg1cllvU2VuYjllUy9Gc0RJWG14Rlpld3JRVVU3?=
 =?utf-8?B?ZU9ad3ZJNHROZEVZU0tuSlE1Mng1RUowWEU5UXkvT2FPU2IrMnNWN3Z3VFlY?=
 =?utf-8?B?WlFIbEw4YVZybTZTQ2tXRm9DMTAvcEIzelJRWlpQa3lHZGJBQWp3dVVDQnlp?=
 =?utf-8?B?blFqR1hyakpqSUZNTGJ3T0pSR2hmRWFBWjJuNHVtMndyeDVSVXZYalZ3Ymt6?=
 =?utf-8?B?bzl0bUdoa3l5cEk0SEEya09pNmQ0Sy83eWhTbWhoTFp3UU9pWStpS3VORWRC?=
 =?utf-8?B?ak1JMHBESk9LbEpDSWlKYzlhVVZCU2k2MXBES05ZWlVaS21QUGJJR0hxVm5E?=
 =?utf-8?B?cXRtYUdMYm14TmRxdW8xQVlvTEdDSlNid2YxcUFCQnYvbUZ5OERiRVF4RHlk?=
 =?utf-8?B?TEtCaHptTXJMQ3dQQnR5TUo1UVdLdjhOWGY2TkpCL2E3MVdVSW5KWTVkeWds?=
 =?utf-8?B?cEFXbXhLRXZEb2h5RFR6U1lxOUZzMXVlazJWaGkrb25zTkR5WVA1QUVEYlVr?=
 =?utf-8?B?M29Qc1dpMmFUR3ZsK0FEZEtvbi9iRmI4ajZVQUVJVi9uY2lkbW1nK3BBd3l2?=
 =?utf-8?B?eFZuQUd0dGppaHB0QUtRcEd4NFI0Z0QydnFHa2NiTEdvRnRicWlFZG4xTGRn?=
 =?utf-8?B?TjhxcGVvTHRlbjl6enMvQ2sxcVpZQS9qWWx4Sk8zd2dpN3ZOOFQ0MUliWE13?=
 =?utf-8?B?VWk1ZlNQTXhmRy9ySHpqTzF0YUc3TlFaMnYwdHcvU3BlQS9ORHNVczJVNkNL?=
 =?utf-8?B?K2lWa1dsNXlES01Ia3E0dlhCVjh0Mks1NkF2dzVmemVxalVOcFk5ZURVdUM1?=
 =?utf-8?B?MnRCKzl6MTRYN3hwNHlCVjV6Tlh1UzhJSlRLVjFMM0ltTy81Z3FkM2h1LzV3?=
 =?utf-8?B?MnpTWWRjMS93T1piTjcvQzVjcEJlRm1kclROMFI1LzNIdFlXNHNhdXdWRkN2?=
 =?utf-8?B?SWwrRzNJL2FGR0Q4aWpFOVhYcHRadTNZZzdHMzdveVVNRFNCb09xU0FzajJX?=
 =?utf-8?Q?rlv9gLjIlnLWiSFoy/rUKk6HZIAoaqLax+6kEhYD6xGS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53E652A50C3B6F41A2F60DA84B5D9D92@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8a4f10-6281-40dc-1b72-08db67097151
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 03:44:05.6226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGrgr8T3IbQJeW45l1f0kSStEoBt8mjuQj2BItMA2fkSKNUU0tVzt7xl7Igel/F9o2ftklJ2z2sWSplbATLH8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_204411_294460_7AB5B4ED 
X-CRM114-Status: GOOD (  24.47  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi81LzIwMjMgMTE6NDMgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IA0KPj4gwqAgwqDC
oMKgIGtmcmVlKGRoY2hhcF9zZWNyZXQpOw0KPj4+PiAtwqDCoMKgIC8qIFN0YXJ0IHJlLWF1dGhl
bnRpY2F0aW9uICovDQo+Pj4+IC3CoMKgwqAgZGV2X2luZm8oY3RybC0+ZGV2aWNlLCAicmUtYXV0
aGVudGljYXRpbmcgY29udHJvbGxlclxuIik7DQo+Pj4+IC3CoMKgwqAgcXVldWVfd29yayhudm1l
X3dxLCAmY3RybC0+ZGhjaGFwX2F1dGhfd29yayk7DQo+Pj4+IC0NCj4+Pj4gLcKgwqDCoCByZXR1
cm4gY291bnQ7DQo+Pj4+ICvCoMKgwqAgcmV0dXJuIG52bWVfZGhjaGFwX3NlY3JldF9zdG9yZV9j
b21tb24oY3RybCwgYnVmLCBjb3VudCwgZmFsc2UpOw0KPj4+DQo+Pj4gQm90aCBjYWxsIHdpdGgg
Y3RybF9zZWNyZXQ9ZmFsc2U/DQo+Pj4NCj4+DQo+PiB0aGlzIGlzIHdyb25nIC4uDQo+Pg0KPj4g
VGhpcyBpcyBteSBtaXN0YWtlIGxldCBtZSBmaXggdGhpcyBhbmQgc2VuZCBWNC4NCj4+DQo+Pj4g
SSB0aGluayBpdCBjb252ZXlzIHRoZSBwb2ludCB0aGF0IHRoaXMgaXMgY29uZnVzaW5nLi4uDQo+
Pg0KPj4gVGhlIHJlYXNvbiBJIGRpZCB0aGlzIGJlY2F1c2Ugb3JpZ2luYWwgY29kZSBoYWQga2Zy
ZWUoKSBidWcgYW5kIHRoYXQgYnVnDQo+PiB3YXMgcmVwbGljYXRlZCBpbiBib3RoIHRoZSBmdW5j
dGlvbnMsIHdpdGggZml4aW5nIHRoZSBtaXN0YWtlLCBJIGJlbGlldmUNCj4+IHdlIGNhbiBhdm9p
ZCBzdWNoIHJlcGxpY2F0aW9uIG9mIGNvZGUgYW5kIHBvdGVudGlhbCBidWdzLg0KPiANCj4gSSB1
bmRlcnN0YW5kLCBidXQgYXQgYSBwb2ludCB3aGVyZSB0aGUgY29tbW9uYWxpdHkgYmVjb21lcyBj
b25mdXNpbmcNCj4gaXQgY2FuIGdldCBjb3VudGVyIHByb2R1Y3RpdmUuDQo+IA0KPiBCVFcgd2hp
bGUgd2UncmUgYXQgaXQsIEkgdGhpbmsgdGhhdCB0aGUgZXh0cmEgY2hlY2sgdGhhdCB0aGUgbmV3
DQo+IHNlY3JldCBtYXRjaGVzIHRoZSBvbGQgc2VjcmV0IGlzIHJlZHVuZGFudCwgd2UgYWxyZWFk
eSBhbGxvY2F0ZWQNCj4gdGhlIG5ldyBzZWNyZXQsIHdlIGNhbiBzaW1wbHkgc3dhcCB0aGVtIChv
ciBjb21wYXJlIGJlZm9yZSB3ZSBhbGxvY2F0ZQ0KPiBhbnl0aGluZykuIFBlcmhhcHMgd2UgYXJl
IGJldHRlciBvZmYgdG8gZml4aW5nIHRoZSByZWFzb24gd2UgaGFkIGEgbGVhaw0KPiBpbiB0aGUg
Zmlyc3QgcGxhY2UgKGNvbnZvbHV0ZWQgb3JkZXJpbmcpLg0KPiANCj4gTGV0cyBkbyBzb21ldGhp
bmcgbGlrZToNCj4gLS0gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9zeXNmcy5j
IGIvZHJpdmVycy9udm1lL2hvc3Qvc3lzZnMuYw0KPiBpbmRleCA3OTZlMWQzNzNiN2MuLjUxZDk4
MGNkYmI4MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qvc3lzZnMuYw0KPiArKysg
Yi9kcml2ZXJzL252bWUvaG9zdC9zeXNmcy5jDQo+IEBAIC00MjMsNyArNDIzLDkgQEAgc3RhdGlj
IHNzaXplX3QgbnZtZV9jdHJsX2RoY2hhcF9zZWNyZXRfc3RvcmUoc3RydWN0IA0KPiBkZXZpY2Ug
KmRldiwNCj4gIMKgew0KPiAgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWVfY3RybCAqY3RybCA9
IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWZfY3Ry
bF9vcHRpb25zICpvcHRzID0gY3RybC0+b3B0czsNCj4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZt
ZV9kaGNoYXBfa2V5ICprZXksICpob3N0X2tleTsNCj4gIMKgwqDCoMKgwqDCoMKgIGNoYXIgKmRo
Y2hhcF9zZWNyZXQ7DQo+ICvCoMKgwqDCoMKgwqAgaW50IHJldDsNCj4gDQo+ICDCoMKgwqDCoMKg
wqDCoCBpZiAoIWN0cmwtPm9wdHMtPmRoY2hhcF9zZWNyZXQpDQo+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+IEBAIC00MzEsMzUgKzQzMywzNSBAQCBz
dGF0aWMgc3NpemVfdCANCj4gbnZtZV9jdHJsX2RoY2hhcF9zZWNyZXRfc3RvcmUoc3RydWN0IGRl
dmljZSAqZGV2LA0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlO
VkFMOw0KPiAgwqDCoMKgwqDCoMKgwqAgaWYgKG1lbWNtcChidWYsICJESEhDLTE6IiwgNykpDQo+
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+ICvCoMKg
wqDCoMKgwqAgaWYgKCFtZW1jbXAoYnVmLCBvcHRzLT5kaGNoYXBfc2VjcmV0LCBjb3VudCkpDQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiANCj4gLcKgwqDCoMKg
wqDCoCBkaGNoYXBfc2VjcmV0ID0ga3phbGxvYyhjb3VudCArIDEsIEdGUF9LRVJORUwpOw0KPiAr
wqDCoMKgwqDCoMKgIGRoY2hhcF9zZWNyZXQgPSBrc3RyZHVwKGJ1ZiwgR0ZQX0tFUk5FTCk7DQo+
ICDCoMKgwqDCoMKgwqDCoCBpZiAoIWRoY2hhcF9zZWNyZXQpDQo+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07DQo+IC3CoMKgwqDCoMKgwqAgbWVtY3B5KGRo
Y2hhcF9zZWNyZXQsIGJ1ZiwgY291bnQpOw0KPiArDQo+ICvCoMKgwqDCoMKgwqAgcmV0ID0gbnZt
ZV9hdXRoX2dlbmVyYXRlX2tleShkaGNoYXBfc2VjcmV0LCAma2V5KTsNCj4gK8KgwqDCoMKgwqDC
oCBpZiAocmV0KQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9rZXk7
DQo+ICsNCj4gIMKgwqDCoMKgwqDCoMKgIG52bWVfYXV0aF9zdG9wKGN0cmwpOw0KPiAtwqDCoMKg
wqDCoMKgIGlmIChzdHJjbXAoZGhjaGFwX3NlY3JldCwgb3B0cy0+ZGhjaGFwX3NlY3JldCkpIHsN
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWVfZGhjaGFwX2tleSAq
a2V5LCAqaG9zdF9rZXk7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCByZXQ7
DQo+IA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBudm1lX2F1dGhfZ2Vu
ZXJhdGVfa2V5KGRoY2hhcF9zZWNyZXQsICZrZXkpOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAocmV0KSB7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBrZnJlZShkaGNoYXBfc2VjcmV0KTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIH0NCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2ZyZWUob3B0
cy0+ZGhjaGFwX3NlY3JldCk7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9wdHMt
PmRoY2hhcF9zZWNyZXQgPSBkaGNoYXBfc2VjcmV0Ow0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBob3N0X2tleSA9IGN0cmwtPmhvc3Rfa2V5Ow0KPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBtdXRleF9sb2NrKCZjdHJsLT5kaGNoYXBfYXV0aF9tdXRleCk7DQo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN0cmwtPmhvc3Rfa2V5ID0ga2V5Ow0KPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdXRleF91bmxvY2soJmN0cmwtPmRoY2hhcF9hdXRoX211
dGV4KTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9hdXRoX2ZyZWVfa2V5
KGhvc3Rfa2V5KTsNCj4gLcKgwqDCoMKgwqDCoCB9IGVsc2UNCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAga2ZyZWUoZGhjaGFwX3NlY3JldCk7DQo+ICvCoMKgwqDCoMKgwqAga2ZyZWUo
b3B0cy0+ZGhjaGFwX3NlY3JldCk7DQo+ICvCoMKgwqDCoMKgwqAgb3B0cy0+ZGhjaGFwX3NlY3Jl
dCA9IGRoY2hhcF9zZWNyZXQ7DQo+ICvCoMKgwqDCoMKgwqAgaG9zdF9rZXkgPSBjdHJsLT5ob3N0
X2tleTsNCj4gK8KgwqDCoMKgwqDCoCBtdXRleF9sb2NrKCZjdHJsLT5kaGNoYXBfYXV0aF9tdXRl
eCk7DQo+ICvCoMKgwqDCoMKgwqAgY3RybC0+aG9zdF9rZXkgPSBrZXk7DQo+ICvCoMKgwqDCoMKg
wqAgbXV0ZXhfdW5sb2NrKCZjdHJsLT5kaGNoYXBfYXV0aF9tdXRleCk7DQo+ICvCoMKgwqDCoMKg
wqAgbnZtZV9hdXRoX2ZyZWVfa2V5KGhvc3Rfa2V5KTsNCj4gKw0KPiAgwqDCoMKgwqDCoMKgwqAg
LyogU3RhcnQgcmUtYXV0aGVudGljYXRpb24gKi8NCj4gIMKgwqDCoMKgwqDCoMKgIGRldl9pbmZv
KGN0cmwtPmRldmljZSwgInJlLWF1dGhlbnRpY2F0aW5nIGNvbnRyb2xsZXJcbiIpOw0KPiAgwqDC
oMKgwqDCoMKgwqAgcXVldWVfd29yayhudm1lX3dxLCAmY3RybC0+ZGhjaGFwX2F1dGhfd29yayk7
DQo+IA0KPiAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGNvdW50Ow0KPiArZXJyX2tleToNCj4gK8Kg
wqDCoMKgwqDCoCBrZnJlZShkaGNoYXBfc2VjcmV0KTsNCj4gK8KgwqDCoMKgwqDCoCByZXR1cm4g
cmV0Ow0KPiAgwqB9DQo+IA0KPiAgwqBzdGF0aWMgREVWSUNFX0FUVFIoZGhjaGFwX3NlY3JldCwg
U19JUlVHTyB8IFNfSVdVU1IsDQo+IC0tIA0KDQpzb3VuZHMgZ29vZCwgSGFubmVzIGFyZSB5b3Ug
b2theSB3aXRoIHRoaXMgPw0KDQotY2sNCg0KDQo=

