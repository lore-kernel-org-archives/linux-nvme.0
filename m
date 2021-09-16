Return-Path: <SRS0=Ydhk=OG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07035C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 16:59:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE86E60238
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 16:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE86E60238
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7AZR3/19aWzKCzmW+R8iAjby3Vx0pJ9ux0875OxexVo=; b=eqRKAzgdR3cud8
	riGcxH7Jesd4pmHbjD+5AUiK6dV5K9G8ytsrQbwY7L6R0tVrQl2geOw3rwMgDyA2cifRDR8M0lEBp
	oTF32j6VHw9/xJ4EMXX5sxwTdGM74XDKSmyHgWsHMnp10mEzM0NVZiHM900J+h/Y2DsQFD3rNts+x
	La/yjAGaI0EVcE4CVpXck0/5eAFPi1HOnnYsFL2A+0Hd2INqlGhHNF34rIR/F3ncm4PkLA3VqRiMH
	Zeu2Br+i9dbGJUN2SABA5yCZMBynVzj0Y1rG1Un873Qkuo6pHF+5aJ0UgiAFMdetUwiln3Iv0XIPr
	EtFw/61SjBREvO48rPRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQuiy-00BnYR-OA; Thu, 16 Sep 2021 16:59:00 +0000
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com
 ([40.107.94.44] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQuiq-00BnXZ-Id
 for linux-nvme@lists.infradead.org; Thu, 16 Sep 2021 16:58:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgG6iYsLkJBH49au5ac6h9VCBoBBwinfyx55jKtMmMHcKs4/S5gf/h+1c16TjsvuIlKwJkUqJ3Z5t8diM1ft7mQ38A5XeGJeoG3Hzie7Q4/0THI1L0iNfNlZHMIaOmPeYlBUmKoXOO1Cq+38CR3wa7qRIwW3wMWy3gucDMb87hPm2xKtGAUHRHD3YQ84kHXID8ArM57vJ880GzO8WiImvV014KBZlsZE7UE3BdMOnG4gn0OQEpEVYpLh09I8fGdYqmLYh2betb0woQidmd27GNOF7/llVXvHZSLPKNMAtJUeFedmbDNv/7PbA8/w1zNh5T/0qNVWW2KtqrSGltCFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=DY/8LW/SPs/1uV7s3YZ9ayB8Q6w8UakwmZSeYJdNO/A=;
 b=Vg95MWObdKV100QS92qnDVK0ZJw6N5JbHfm34NsEpZ8QkblyYWs1wh4O3oY2CoIrzgC7AWgphYX9UW7Nw7PjuvAWjyE0aSEk+jBLT9SIGa8B/6zE0JgH5OcaV3AiLYPqJC4IFkTATpYNMKnf+OKJ5gGtlXvIgEfmXR16Vw7GmF8s093fw+n49XQiJZ4D3QoRMeTPJ/tv1K0zo8y71Za74MYLII9MHX5lOeoCNaHHchIbTmnqVwD2SFJiLhB1Yt/JsKCp8ft9QY3zynB3gY0LkOF8W1VrDymQ5Iv9iBZlA1Rd2AlIElbUS7+PnoH2twc0eF6JAjBV4XUnLXYC7GlKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DY/8LW/SPs/1uV7s3YZ9ayB8Q6w8UakwmZSeYJdNO/A=;
 b=TDCqSmSbbcGtikMRd8pMrFPrlUsUPur70iGViTc0PaEIZ4xi18amFTEwfFg0PHaMu/jRq12cAJyqgCq5fPv0AnrpMR6ox11tKevZ9XwbBBj45rg0Xc7wF3ELcIfg8npxJ1Fnj1Z1+U3RVSXmxFYHbuMVddVrxuUQmL5SjaeEJbwTbRj1cdAiIuFQcXpWj+06uaD4KYC6sUU07xl6yBYcVJ4EwL6GEvnJMkOHkf7X/IgzKswAuk35FSqGAr5UoA1ZTNL6qN7WiXmF08HlHqCEulDi1DRVtFB3yXEnJNb4DSOcwzvcmIeKprmtH7VZBeV5tn5uRlH2epdaZv47TqJy4g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0158.namprd12.prod.outlook.com (2603:10b6:301:56::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 16:58:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 16:58:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH nvme-cli 0/2] add "State" field in command "nvme list"
Thread-Topic: [PATCH nvme-cli 0/2] add "State" field in command "nvme list"
Thread-Index: AQHXqjX1YCvXcp6mE0C49tTKN4Y7J6um49IA
Date: Thu, 16 Sep 2021 16:58:50 +0000
Message-ID: <e40fa754-60ae-ab6f-bd2e-27b8ed7251a1@nvidia.com>
References: <20210915132912.3004-1-chengjike.cheng@huawei.com>
In-Reply-To: <20210915132912.3004-1-chengjike.cheng@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab5b5510-bba2-4dd2-d9bf-08d9793341ee
x-ms-traffictypediagnostic: MWHPR1201MB0158:
x-microsoft-antispam-prvs: <MWHPR1201MB015882A670CD3B1D6BDBDEB0A3DC9@MWHPR1201MB0158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ji+XQ7tSYjwrlH/wggW/fiOsBjyoEXBeKVIBbCAtvtRvSS6HkYhH4akseznPep4n8yZqWXiBa7oP2Z8r8k1fqVDs8WSlLOJb7kkxr8Y59+4A5v6+XjYSqO1b7r/Q3+6MPZn1kQlrtcGdfKj0BR7b1yuaJcfMrIlW4RQpRQzOAHS+6RlWIsuu5SSj6kayub4sNpfWFG3OaL5Za8WpVMrCikE4FsxKjk7Il0rI2iGFt3xjt5LJ5WbG6jDjUbWeVJ8fhTJJD+P/0XVMZ/D620YVyvBdTwGhSbIiyqIbLsiuypksm/V9VyhZVmOubJBGbTimXUhd/B1hnqlFhUCh+QDpK3HiB1pJjNbgSWL73lKhaR0chcOSa5SITDxfjNDJwxCNu8+G40s2/pLn/gCG7ERpTHYW+K3QWqlLK4/5oFh8wY/rPj2pI8Te585xgBLhz+K5jRGsOAOVEjBTNrGQdPpAReSQGAAKyWrP7LIBOCiglaMR2oMSvSK51cqgcNhyV6gBfnNPp4qL7q8hd4r2GWl32mO6RHoIy6U6f6RrJV+6lbaGf5zOx+SgGN3Al8MliPRac6nvgRDyhctlFhKVsAsvPTZRz2k9Ng2O33IZRSU0HdXVQhbZVXRybmeq/77zRVQFNkFnbfbMKMMHmHzayOgwfTEHpfFgywh6ceAcfK5mjuSyq0BAFnW36xuJaHwUAJWdo/zIASBUlz42FNZRV+vCew5PGSbWgmnBAfZ4OSOf8YZDN09pV6z1TGlZjyMwP7jwiPWdQK09YaRh+aHpsPE9mA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(71200400001)(8936002)(6512007)(8676002)(478600001)(38070700005)(6486002)(2906002)(76116006)(31686004)(66946007)(64756008)(66476007)(186003)(6506007)(5660300002)(53546011)(83380400001)(2616005)(66446008)(316002)(4744005)(38100700002)(66556008)(6916009)(122000001)(36756003)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXBIaVJVYWNjSkUwUGN5U1BycmcvbVVIZW9pSFJlbjI3blk4NktLS2ZNaVVm?=
 =?utf-8?B?Yi91OVBiMHUyM1BTa2lONzRYWkhFZXJLNTFyZlZPeHY1VE0wRGZLZmJKVGdX?=
 =?utf-8?B?aU5Ua3Q3UFhiOFpzcnViV2RCNzVKVk9zYlN6d0dXWWRTWG4zd1lEbXBvekN6?=
 =?utf-8?B?RlpxbSt1QTc5dHdmeWF2MFo2OCtieHdxOFF3MlVPaGxwNUhwK1hTR3lKaGhI?=
 =?utf-8?B?dFB0MjFSSmFEd2Y1eitjaUNxZW5SZzdTckZIOUg2aHgxUUlINmtueHRrbGsr?=
 =?utf-8?B?WnlJSmRLY0JMOUlsU211SjJ3elVmaktqc3J5ZkFpcmsvcHBmM0ZQYmUra2hQ?=
 =?utf-8?B?cStUZStac2l0aXcwQ2N3SHFadUF5VkNVMDBZOVozUlpnK3NDZnEyaEhzeHE0?=
 =?utf-8?B?SlBGNDRCRDk2VFJDTzZURCtMQ2lWQUI5V1FOd3pFZ3J0ZlViUE1EVDNsMDdG?=
 =?utf-8?B?dkVCRDJRSUxqVjJyQlhEUUVoZU0vUkNLYzdESXhVZy93M3JNZVMweVcyZHNG?=
 =?utf-8?B?Ym5pYXQvbXY4RFNMZmNVWVJwVTNYYnFPRkIraFNkV1dkNFREUXAxaVFabWxM?=
 =?utf-8?B?SFg1eFBNdmVRSVVuMzRSeVorcVRzUndBTDF2L0duQVRtcXF6S2cxUUJRNHI1?=
 =?utf-8?B?dHN3clQrLzAzRitleThkZlZDbFk4bENuMTFCaVBqTVFFeGRRa2ovempIZjJu?=
 =?utf-8?B?OEE0UXZTcmJFNmg0MHFEYlN1K0tKd2pCYjNsZktqalU1RXB4VUs2YmU5T1k5?=
 =?utf-8?B?SWQzOE9mNzVBY2tLQ1B2cHAwNElYaEdUdkRwQWwySk5PaDRIY3VYVXNERzYx?=
 =?utf-8?B?TTIrMCs1N1NIejdLM2VQRi8yVEJXLzRlaUVkckFZdklVYUI2QVZ5VzRBU1B3?=
 =?utf-8?B?eTFQSm80SnR6SjFqLzZoWjRsVnp4Yjh3Q0JFVGhUaUVVRGU3cGtGMUhQcisr?=
 =?utf-8?B?aVlJOE5tQ3dUNStpK0s1QVJKRWNvV2ppSUVVTkFnVVZyZytSRDRDYlVZQkhO?=
 =?utf-8?B?QUNBUmVWTzgySDRtQXVOSUpEcXNRN2l4UWJvOGdRTVUrWHpOaDFmT0VWUDhY?=
 =?utf-8?B?RE5GVnlWMmZsRTY2VG5VWFVvMjYxRDdnc2tDYVZWdUZzcEIwU0xxNmphcHdV?=
 =?utf-8?B?TndPdTFORGlGL3BQMU9NZUhQWVdFRzZJR3FNYlFFWmtpazhEVnlBQ1poNThy?=
 =?utf-8?B?Sm4rVzhOeWpHK2ltWnNYRnErckFWRDMrMC9wc3FTVFpHMnlDNHJ5WmtOb3RQ?=
 =?utf-8?B?TS9GVVRXUURuQUlVNHg4YkVIMGQ1ZUV1MnRuYWs3WFFEZjJDTXJPUTR1RFhV?=
 =?utf-8?B?d3hoNWFXeDNRaHJyUmpVRGYreVRKY0FBZEhWOUlxNXRPMEV5OVZNejlGV2wv?=
 =?utf-8?B?NWxCK2JyWmMwc1R4QTJYL0hCWXNQMy9VS1BrWFRFUnVFclhzNEs4RUpXd0pu?=
 =?utf-8?B?NFRXYXRMWHBlZmNiNHNFeW1hMERDRjQ0aEo1VnY1UnJRT3Y4SFMrMEx4THl5?=
 =?utf-8?B?bXNSNnlLQTJOR2hUeXVGR1FtNWluMWt0aEc5R2pGOFVlaGdHbG1KRlFXMkFo?=
 =?utf-8?B?S0lIYUl3THVOU2wrdHVpdnBlSTUrZkFFSHRmNmpwOFVTWjVqRW5Fa2hIK25r?=
 =?utf-8?B?Ty9YRU5Nb0ZOTTlFN1FuNFNMb1RiNzRLN0UyRUE3RFNhVVVjQUdma3QvWEtW?=
 =?utf-8?B?TFRDZHhwczdEcVFnQ0ZmL1lrQ25kVGxBWUp5akN0ZzBsSkllcFJVdksxcllD?=
 =?utf-8?B?MzJESzU3NkR3ZGVPVUJlOXMwQ0pBS0xzN2NYMmRXWFY2UlNSdWF2dE8yeEE4?=
 =?utf-8?B?MEZVWUt5OXlGdGdVUGRtUlZBSlZBTTBnWFhhV2QrVDFOeGJ5WFBCaUlxNHZi?=
 =?utf-8?Q?XLTAodFJc3cOX?=
x-ms-exchange-transport-forked: True
Content-ID: <A2C185DC96559649BA2F16AB192F3ADF@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5b5510-bba2-4dd2-d9bf-08d9793341ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:58:50.5061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fho28k0q8NfIsGKbYiF29pcXc8lbAbKCqt1B4kWGsf/o+bqTOItUw2zFTR0y7V4Zefk9lWvY18ReQZIsZaghvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0158
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210916_095852_689118_4715AA61 
X-CRM114-Status: GOOD (  14.63  )
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

On 9/15/21 6:29 AM, chengjike wrote:
> When NVMe Subsystem is connected with one or more controllers via fabric, such as NVMe-oF over RDMA,
> if some links are down, some nvme disks on the host are faulty and they won't be deleted immediately.
> But the "nvme list" command does not show these faulty disks.
> So add "State" field  in command "nvme list", and display the status of each disk for users.
> For example:
> [root@localhost nvme-cli]# nvme list
> Node        SN                   Model         Namespace Usage                    Format           FW Rev   Status
> ----------- -------------------- ------------- --------- ------------------------ ---------------- -------- --------
> nvme0n2     25658552656655456265 Huawei-XSG1   2         2.83  GB /  10.74  GB    512   B +  0 B   1000001  live
> nvme0n1     25658552656655456265 Huawei-XSG1   1         2.78  GB /  10.74  GB    512   B +  0 B   1000001  faulty
> 

what if namespace is non NVMeOF ? also you need to make the printing
status optional.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
