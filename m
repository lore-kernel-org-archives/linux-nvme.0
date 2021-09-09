Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E7DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 16:25:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25B0611CE
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 16:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B25B0611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ai9F4g9foO7jYhw19zsfzlqqVKudMzrIr4A4mgxfzjQ=; b=HyJG6SiRcVLLjl
	HWLPBQ7NWewxe8Pd5219yUZ0I8lCl3x9JQonZxoqGuwktdxrDrFAcXM6qYkCV6z6A3s3/F3zWydnm
	wPnsrs0itC0OcRGPEvnsKfJjmWR22Zo9HLFUq03iuXVcuVJCFBKaqG6pRJVgYITRzff6FBLV2N1FI
	saYc27P8r3iMGiJdWjhG0TyF1Zu5Pd3K8GrOSfRWPvdKONqWEJKUsYnW0wjWkmaSTgTJPDef8CtbY
	uJJQnbhFaOJ6VrH08p9WxxruakoKDBVQuEtA9PUEmKL+OBGmRrYECsx8iZFPG3HbRd0tB9QYfzd8M
	qcR9Ha2G6PHE09O3bjng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOMra-00ALbl-6o; Thu, 09 Sep 2021 16:25:22 +0000
Received: from mail-co1nam11on2081.outbound.protection.outlook.com
 ([40.107.220.81] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOMrX-00ALbI-CX
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 16:25:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAauHXvw7nH+tJjWx1UjcMa1hJftoRDUugHLBcSwAdCogvdjRIkA6yVQatn2/SOdyNOX+h2lIIEMe6IhQTRNU2yVI+zYefk5NRDbRpzH+vfjRjw1RJN3FukMRhAkcDzEVjd6TCMpKM8e0OZlsQ9SWi8RXoVtH/a22uDPKq7/Wo+8jfuqEX2DT6OERD5+jywvqXr6274DwlfoNqU/pc+ToJKZQJDjkP84Bru9P+wZdOIhunD/QibvDc85lmNAPonC59DWBmhJ1DaOFWwUj3gtU+l8iu4aUUNxGe+xJlkDCWXRqKPeqmq2EACr/HlYKMiLtLmRuUXMYaKah5p08yVM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=efqNb3EK/7uAhZjw6N+TDZKzUVBB+trgj1KJPiuYqKQ=;
 b=bOLdqh/+WU5UqVBxtZv5TlbicAPR0lLjdTOll2pzxHKImyNNrDV0tztsjIJdDCmfaHJty1TwSrvzHVA7r3IE/4Lp10v3WOUpXSU0SUDjggYj39KvG1ZdTLBQCSpTl7JlfvJJRKiXylc1QLbHEcejYKQg3LV8EM8xxLJf3owZifpwo0yxiRusCiV9ppx2vnRPaOOD5MQYUyMH/p3rpvXUamLQCoQB3706AxLlhW1EDjCk9NSHzGQZ6FWN64WTQ+exA4u/QBmZtZttiDeFPfBRmbm3CIfpKHZr/+hbXrNKoMU5iw4RElOgbpYk2dziqItXdnoRaMoV03c4tkEGsEMyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efqNb3EK/7uAhZjw6N+TDZKzUVBB+trgj1KJPiuYqKQ=;
 b=SlHdkQnTVw0fITdpXq3Gt7IIh3EEfyiHsJT5/a9lyIE4HyR7nQWBlJOCUJLwIXeWLyo3Sy9zT9J/OqHSqaw/dzh96dBGTblgE89dvmCU1emknChBnkqUofGARTPXJAcl5iH7+ApMZZGZDSJ1rSZ0qlGRPEXsZqdix4Svkz+gKZQr4keHhi5tHzMoH5/tySyrYnou0oC10drwbqO4AZN81rnrrQPGI9+aeo0PHEuA8Tv+SybXRZ9OH1CLMcqr2SIbke0LG3WPtVuocnxO+zvIl9nNXpMk87qcXRWZztu1/kvJuQ9Nog+P/PgWhDyzhhzxxu7uh95UN+1uNnlTFngiew==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0016.namprd12.prod.outlook.com (2603:10b6:300:e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Thu, 9 Sep
 2021 16:25:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 16:25:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: Fix missing error code in
 nvme_configure_directives()
Thread-Topic: [PATCH] nvme: Fix missing error code in
 nvme_configure_directives()
Thread-Index: AQHXpWBtEI9mBZbqwE6oYo/8r/sBM6ubyISAgAAAyICAABp+AA==
Date: Thu, 9 Sep 2021 16:25:17 +0000
Message-ID: <f3a18366-bf1e-67d2-afae-87031906a556@nvidia.com>
References: <1631181021-108687-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <20210909144739.GA2464330@dhcp-10-100-145-180.wdc.com>
 <20210909145027.GA32109@lst.de>
In-Reply-To: <20210909145027.GA32109@lst.de>
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
x-ms-office365-filtering-correlation-id: d0c75eeb-ed30-4d81-886a-08d973ae6906
x-ms-traffictypediagnostic: MWHPR1201MB0016:
x-microsoft-antispam-prvs: <MWHPR1201MB0016C4D43FE3819A8B064DAEA3D59@MWHPR1201MB0016.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m4p265HN2i6O+/cU55OhqD2VsUHOe2rqnm9yq8lP0opk+pSge4FtAkc05o4R9fT6OZU1nIA0qo9fVLJ6x6Xp6uzd4QIgizz6n7ORWxkYcvtNC2gbQREterVrJqt/i04YW55Ay3UgRQwvNhR1NvUf1HW6fxRFpn3l9uY/BwT5ZOV37/bQmjrSGWmLBqiftOkUjPwQZZMrf6539vS7rjMMA+MjkIurRq0b0id3wOsmV6r0UX9UvXDYkusCrrrfF1mtRBlg4oWGCC+TAfKD0KGv22DtdRBS6jJF1cwI0TTFwi9CQBuiHuQ8C03g92Tncrysr7T8wC/pqwCdk3ACyJkn7z5VfBE5HIwwHSmKUudnwqk1DCO9JWFO1bMTCzG1IPPpPYsJcj761AvzgJlcAdBbGFuhSgv2auNvKRgrNeoQD1PmP1OT8RB50pHHB1iFsX5KRBcwHYBMu3Msc5g9sRxHTSBZllzCbglXsWzrv/vVSHLVYXYB/kz5Kbiy6BVgnCRa7B+JIIt953B4RmDxEZJinQ/3eNtWQkxntwOgYwNjaP/f7oqk1FxG/0iGU1OcUbjHgQ6nSHdokbDFd9/qI2cuHMCgnsCAOkGINsY8PrrTyBscSTRIyID9a5i+HV8cwdPEirvI5XNK1PZFzC1irdUCp45c21g/8w7q1tnBGIIbFlzEbVFjJb18t1rIE1IG+sSznFhyPuAYDirXU1ixAY1YXdjdaLVfMz4+LspFllwBTIdrAyEpp42NTek9dyvwDU33Z8s8O6v0Zgn9m7yXzVRnig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(2616005)(31696002)(38070700005)(36756003)(316002)(86362001)(6512007)(66556008)(66446008)(6486002)(66476007)(64756008)(31686004)(478600001)(66946007)(8936002)(71200400001)(4744005)(2906002)(122000001)(38100700002)(76116006)(8676002)(91956017)(53546011)(83380400001)(186003)(6506007)(5660300002)(6916009)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWY4UTZUMGErOFk3ODhJVnJRR0ZDeUMrcnk2ckR5L2NxaitnaURxN3dOa0hS?=
 =?utf-8?B?dnlpdFhkd3VIVDc5U2NWeVByalFLWWwwNDRkQUNENngyUVFONk9PQ0YwSnAw?=
 =?utf-8?B?WlNJMU9DallZM21iMXZwYzF3SkZ1V0NLOUpBamRNeHRUMmVWc0UwZzlJUkR2?=
 =?utf-8?B?U1RtdmcwM1JOZHVPallhZFNJNnQxQ1FlNU1WWTRQaEJGaDZDM2RPY3BvQkU2?=
 =?utf-8?B?RDJFQWZzazJUanhxUWRqZDlXRks3bmkrK0RmNmxGclNLZVhST25XTm9mNFFN?=
 =?utf-8?B?QllNbW02WHlha2JIWHpwbHdFOGJoV2ovakEydi91WkRSUHJpNEZPRzBsVE53?=
 =?utf-8?B?MEh4ZGhiZ09wY0FiTjd2RElpL1FqQkxqUE9qclRYME5KR1dZT3FjbGNVeGVR?=
 =?utf-8?B?cjM4NXIrdVE2VWFzdkNJclhpdDNhT0plMlB2bTBTQTVpTHZybTlzRUNVR3NU?=
 =?utf-8?B?Szk0RHcyaE95WW5TcjBrWWlrODd2dnBoQVR0bHZxQVd1NlBaN084ZXFQaWxZ?=
 =?utf-8?B?Qklnc3p4OHVna2VUYUJ1RXhUUG5icW5pR29SMDdWTnFzL2xpWnQzRVNEendl?=
 =?utf-8?B?RjN6ZnR2K0lua0o3Yk5SSiszRWtoOGEzaTdCRFpjSEtTVnMwZkJvSXEvL2Fn?=
 =?utf-8?B?SlNMYzBrUmQwQi81U2tVZjMwaC9NeFgrUXYyVWxFdEdEYkppU3ZnY2hCTnlI?=
 =?utf-8?B?THVvQWlEOGNDSVV0MUdzbnc0Zm5jM0UvSjZ0KzdvQktJakR2cm9adUU4RkUr?=
 =?utf-8?B?dU1uWW9uY1dDQVYzd3NYcXFqWmEyallvVTJLUHI0cGdlZmtmTVpVMkZIQzQ4?=
 =?utf-8?B?VEYyUlhLeHc2RjRpMnFsWWVxeGF6eHZDZlBpbVR6dW90SnlvY1AvVUR2QUpx?=
 =?utf-8?B?VHZwVXdIUFBYeE5VK0pPbTNQZm5HOVIyVEZ2NnNzeFp2ZTg3bit4TFpnMGo4?=
 =?utf-8?B?YW1QNTJENmtTa0F3T2VWaG1KT3dPOTMreEU2aWU0c0NCdkNyZWJXSmxzQlJy?=
 =?utf-8?B?bytaUG9qVWFheGVyN21MSXUyYmxDbEFCMnRWYUUzeFY5dHVjekRhMnV6eFow?=
 =?utf-8?B?VXBKaSs3TzFKWjhpOGgxYVlrQmEzMmYramZISGpXa1J5QkZKMHlxMlZWTjdk?=
 =?utf-8?B?SHdLeFhYK1VaQjRuWUpJd1ErQ3NOWUE2aFgvSU11anpER2NlQm5VMlNuTCt0?=
 =?utf-8?B?Sk82Sjc5bkdFd050cFNwRXUxbEJrN1NLOE1mOXFGd1VPM2JWcUhXWE12OC85?=
 =?utf-8?B?V0NVRlViTnRsdmd2cGQ3Tlc3R1R5N2VFWEE4cFNhQmFnajA0Z0R2WEYveE8x?=
 =?utf-8?B?NmxTdEJtam9YTWpNOEgwZE5mS2lEVmpLSGhyQkYvY3NoNm16T3FZWWRha3hJ?=
 =?utf-8?B?cHVXSmM1OFhnZ3dRSVEzQ2JNNTl6MXdzVVg2UHJ3amZYQ05MWFMrVmU5TGlK?=
 =?utf-8?B?Qkt1YWdiTlVsQ1g0U0VFcmRqcHFWQTVIaUhWT21DWnA0S3dTVC9wQ1dacngw?=
 =?utf-8?B?dEhsbWVDOVVYQkJqeW9hSzlOZWRid2pZODVVS3FyUW15M3lBK2FLM0h2Yzlr?=
 =?utf-8?B?WVp2Wi82QkRUQU9yWE81Ui9JMzZWLzd1dVM1NHdOTXZIcUxGRHBPTzVacjRH?=
 =?utf-8?B?S0VLWTdrdlRLdStiMXdYQUY2M05DM2FveEtzbnVSZkJmSVdzODhWckpCSWhk?=
 =?utf-8?B?d1hKZmFrRWhidFdGUFVRQ3RZMitLTnhhYjhxQW82Vnpna0dSK0F0VVorZGdB?=
 =?utf-8?B?UDBER0NrRkJxa3RxbDMzenhaejBhRENjNGVDVUdYR1h4ejhYZ0hEaGlzUG9Z?=
 =?utf-8?Q?hxpys4vFMu4DGCeCggV3XUe+ummKMRuMfK41I=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <5DB36C4A7AFE044FB5A2F8DB4953E7E9@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c75eeb-ed30-4d81-886a-08d973ae6906
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 16:25:17.2345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXooTtRodGv9GRsqL/WFlS8jGRqSu6LCDYDX5LkLpCxfg0x9TYhgxA9XeGc+nHj5r+YpjV/ZUTkj0x6Jpuy2ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0016
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_092519_478689_06B28D91 
X-CRM114-Status: GOOD (  16.60  )
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

On 9/9/21 7:50 AM, Christoph Hellwig wrote:
> On Thu, Sep 09, 2021 at 07:47:39AM -0700, Keith Busch wrote:
>> On Thu, Sep 09, 2021 at 05:50:21PM +0800, Jiapeng Chong wrote:
>>> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
>>>
>>> The error code is missing in this code scenario, add the error code
>>> '-EINVAL' to the return value 'ret'.
>>>
>>> Eliminate the follow smatch warning:
>>>
>>> drivers/nvme/host/core.c:786 nvme_configure_directives() warn: missing
>>> error code 'ret'.
>>
>> Nak, the code is correct as-is. Returning a negative error for this
>> harmless condition will result in disabling the controller when we can
>> proceed just fine without directives.
> 
> Oh, indeed.  We should probably throw a comment in to make this more
> clear.
> 
> 

hmm, please ignore my reviewed-by tag, I was under the impression that
it was a block layer mandate and it needs BLK_MAX_WRITE_HINTS hints in 
order to use the controller..

Comment is required for sure.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
