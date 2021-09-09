Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99FFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 16:19:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2CA6113E
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 16:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F2CA6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yL4GPU9+NTXILZcQ9NmXunJquA3SfPceECifkjz74eI=; b=EF7V6s2RqQa05p
	JJUPhi/YQJ6tLhDp3NKbFm0/Mv8mfBAKW7M0KNWGZZBeOvqSRN2lBUyFHlMaLUogq2lVaUuT2slvp
	r/Nmlhw/WTWg4YqjcL+QSaizqmBnv+vbOZW1xJlQzJFtH9Bde4J4KZtI5ZaphU9oFr88Z48c4tsHr
	FTY4BgRNLLSaubqtNdGJ1yoo55Lf/C/A75fVmKGOkDuqUTaSMEpQ+wUryT9SNpRILyIfjh6OWvU1I
	C4ONzLf3Z1yYpVYrEOgIPSjId4iF+SCFfXr4XUyXNWXW1T64cH3G7BG99cB3unlPAMthTmDN6uHBS
	V5gMtp5SfKUaAfi9Xtwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOMlc-00AKqs-5A; Thu, 09 Sep 2021 16:19:12 +0000
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com
 ([40.107.237.62] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOMlZ-00AKqR-6X
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 16:19:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqVqTGr7Wcvdd2P3K4ExaBVNgPmhJUTmjq0fl+nbQVPvYRA1Y27m4j8cnIt93EsvJjVdiC3a0jPpug9AoPi3mxWoWfMma8tBEZdnw0MlylkuWQ9NFw9u4c003Zbqs9QxyyaFkB0Q2bmzBt1j5978OuyZj/Lao3zURBWQbk5lw28r4hRNvb3Hqh6sZ/lgsFCl44exkN/gO1oYQX0WErnvK9nJE7i0V9cE27gaBodL3FV8WHUkFTNsZZeo7f9LWx8nXWCaR/RQXqk5RwamXrwEtOT40vFF0VoVIv8TiGuKqrwuib2WVwGFBTPgt4ExQdy21fbpQ6ykcmZoJ+5tEj/7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=LUcEYJODJDwOT4QNcRt2orZo3Nk7C1Y0GEj8BC736cA=;
 b=YEuFW4gmDktPyn6t+EVoMrOBPtPNGxCraxivyF5aUixcKGng5l8cPBAxUcwKkYcQoGHNQU7AZ5CbuZvrE63g0hB4fohedfdh1eBaO5+bUmKukuPPlM2UPkxVR68prTHa733Y//bmqjY/ozEtKrW5i2PSmWLaXv6cDEgWQ4/rlKgBgmccAS/m6m5+C8luHGQrJa2PdyG6eVBNCVU+QzY9dGnkjPfFhk+XoaWHxvXEoPM7Nb8Hk/nA3szpHWxikXLaqDA1Bsk9VeXyREdq9fuAGOAGWlSaKsAxLvuHM51fva5ycEbYr+u8eJRnJFwrmWWeTf5dlngTOv85je5tLv56EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUcEYJODJDwOT4QNcRt2orZo3Nk7C1Y0GEj8BC736cA=;
 b=b1gi0rWBfRVzT7NWaKkxLu+XXHkzb2SoPpd3RZpXhpc1gUP4FYP8HTSq4iIOfre+kkWK4ARnAC6WXaRwEm2Bjk0ukRjKSJQtZW9syieUjNNEOD96sVBqKSzT4KmWvYpom4OhuS42GtmIFUSJE7p0vYOprxen5ni2gpIJywkkQUVHb0QpjaiGBYA3CPPl2A/8j6ojeGTUFS7gxzcat5kXAnhPgudYcRQEsgVInyG/Fx8Zl3Xdsucmdn8JPXjZs5hTh1HYGa8oc2/8u24Wc57tRaStlnRlTe3OzJ25VooMazuQ5iwLGCWo7wsKdhKFMpVNcWfu26hqgOO1vHOP+DX4Rg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2378.namprd12.prod.outlook.com (2603:10b6:907:f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Thu, 9 Sep
 2021 16:19:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 16:19:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH nvme-cli] fix path->nentry bugs
Thread-Topic: [PATCH nvme-cli] fix path->nentry bugs
Thread-Index: AQHXpYs38HDl5EoRNUOU5T8fgjFATKub4bqA
Date: Thu, 9 Sep 2021 16:19:05 +0000
Message-ID: <1d6664de-7559-b828-e251-3c1e831f9446@nvidia.com>
References: <20210909145709.2079-1-chengjike.cheng@huawei.com>
In-Reply-To: <20210909145709.2079-1-chengjike.cheng@huawei.com>
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
x-ms-office365-filtering-correlation-id: 669b34ac-fc91-4804-4f9b-08d973ad8ba0
x-ms-traffictypediagnostic: MW2PR12MB2378:
x-microsoft-antispam-prvs: <MW2PR12MB23784BE96B1386CBAFB14ADEA3D59@MW2PR12MB2378.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:41;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a/LPUExiZyRbOblCEVunKoXDrxwD8HEA+nDiRpx0RVjJu0mwf79AbfyWEhJzzPRstjSWg7y69NtCTKX/62MJGfoap3MEtItPLYZ1eIWS4lBBw2BbTMk/ainW4KwBejn8SI+nyrPff7ca2MndHe4AP0ix6XswbYNVNGO+U8S52zVTBK6StwtJusK8u3+Ilz2kN1SjnFszYzbejnJClOeATF5nDrUREU0b2HbV72cA/o9Qn7Oo73mu+8hQ6ILClR4r1BcEOzKGq9VZH66kznAIaLuBsiBdXkXTnK4yqV/VntoTT4fj62ZP2E1UVMa8erBzTBc8kFa7jhjTj6o1Sr5NRg/l9q7wYPKWu1NTQVK+Wf8XHslLy+oEzyOvngLnu0XpCyakhMII2WNgMJ49OSXrh9gih0yDayYpqlIoQneOI1voTwLgQtZlqlIW9RLL4ItKySDAHfpdfwTOuvwzSkdOUy3wV+MI+gL1Hp+IaNBBwDlWEBqYhZ4yZmTJwetHJNUIVj9OEMNW1rW8ZMjMjSOO/5qVUS8VsTs9VJnhN/qIkcnQ5G1YVJIAKxIeeDuAHxyLmf87oTiszcGXTgiU/RYGfMZS37DRKagwXto5ODd2mdA1J0qb+4Ld+OAoqDqm9Ch6apNKbwSs0fS+G9+RFBMYw2V55dhd7D/Dbh01bgC8G3cPJxgBC+Ze+S1qzpJV5yNUahaUyTB415abaUfuADr7Po4XscAOMgd1wlBJKpdui6xB9j07J7TN/PjMdj0LYmVcQwMDzAR6xo/CuKw4WTJWSQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(31686004)(36756003)(71200400001)(316002)(6486002)(186003)(86362001)(31696002)(64756008)(6916009)(53546011)(6512007)(6506007)(38100700002)(91956017)(66556008)(66946007)(66476007)(66446008)(8936002)(76116006)(2616005)(38070700005)(122000001)(5660300002)(478600001)(83380400001)(8676002)(2906002)(4744005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blAwblpqb2dZT2kzY3JqMGxONStYQy9rZnlZdXQ0Yi8wUW9PSlNsWDgzbE1t?=
 =?utf-8?B?eWdpbGZiZUtlQTNzUG9oTEZLNTlHNTZML0FUWUl0WmtpeXJHRjg2SjBUVUxV?=
 =?utf-8?B?WUZIK1VFS2NSeFAvbDFnV2dQclJ0U2NIU1dkMktPbmJlR25wVmZIZzdGZGlR?=
 =?utf-8?B?TTZ4Y3pwTG9tUjhOYWtJWXpuRkoxQUt3MFM2ck1xejFkQ3Y2TFEwV3hYY1dj?=
 =?utf-8?B?T3RVSGJGZGllOFRzRkVEQ3Q5WDAyUW94cFNRLzBNbGp3QWZFejduWFU5ekQ4?=
 =?utf-8?B?L3haR2FoT0doNGhIdnI2eGplT3MxZTJldmZSMEgxOFd1N1FwbEhVQ01ySlBr?=
 =?utf-8?B?NklNWTFQOTh6OTNLTTFPUVAyK2ZoNk5rMzgwMjFibkhaZWNlc2FrdjgzSWtV?=
 =?utf-8?B?NEFxbXJ3eVZBeVdyVlBJZkNHWDZadW9yTWpqd1o3Kys3R0lDcWJUK2hUZjFF?=
 =?utf-8?B?VEliR1dCaFUrTFIvZVM2bTNzV2tFdkJ0NEhnMXV2K1FtODJwYmhBeE1OckFQ?=
 =?utf-8?B?M1FiZWdveDM0cjdZMXJTN2NOYUY2RVRqU2Z5VlpLUXNpNVNNSWdlVjdoVEk4?=
 =?utf-8?B?b1lOOUVPQVZVRlpLVU1PdWFyOEUyVDVuVkNsU1BwSUR2a1FhRmZES2cvcGlN?=
 =?utf-8?B?TXJMMWdkL3M1Z0JZVWNEaU1KSHBqRVd5TlZVUFhwc2h5YWlUWUxEancrMTJk?=
 =?utf-8?B?M01xdDN6cXVnQWhyZUJCQWJxY0p3NC9UWFcxNXB4SFF0NWdFcm9nV2YzTmQv?=
 =?utf-8?B?dnN4TEVjT3BnYU4vdHBFQkRCWG42WUpEMVlYVlZLNTJrbndWWVBrVWpydzVO?=
 =?utf-8?B?Rkx4OUp5Q3ZvbnFCa0x5cERWaW1WOFhGRGpCSmZRR3NjS1JwYnlqbTBkeXE1?=
 =?utf-8?B?bGV4RUtQQUNNeUlQTSs2amNYTTQ0YnJZU0UxRklzNFNVdjdLVFhFbkxCTXhT?=
 =?utf-8?B?SlpVU1RIcnA2N2dlVkVVY1VsZXNyRE0rT2loMjJEay9XMkdTSjFHWGJaaTg4?=
 =?utf-8?B?ZmpRenphbmt2clZqRXhMT0VTUzBPandjcUh6aUpVVG5Xb3JlWEM2WlVaU2Z6?=
 =?utf-8?B?M3FybWthU3liZkxDcWdOSFpmWGxHWDZud2dJc0RxWEg5aC9rZGN2VXlRRVlx?=
 =?utf-8?B?ektwYVN1MUJDdHEybE9IcmhlUTJaSXcya3pDNjZCN2Q4Qjc5cDJSc09PbmhC?=
 =?utf-8?B?VjlDdi85U2QxTEUrZEk1L2xoTC9BeUcrenJBamNvVVU4b1VoOEJab0N4bm1k?=
 =?utf-8?B?c1BDOTdsbUhTMEJKOWc3WDBocXUzMGtVeEUyZFdrVUdTbyt4U1g1ZDg4eXds?=
 =?utf-8?B?dmtUdEFzWURHVjVxSlBBcWJmQzU4NWxEcVNYZHRENDRtVEtyc1BJNmZ5Q0l5?=
 =?utf-8?B?bmJZS3dxRGw5b2xqcjdOV1plS0dVbG1WaGVTM05CUzI1Z0ZRSnZlMGovUDNx?=
 =?utf-8?B?MVAyem84SDZGMFlmNDFRL2xQUDlzS29UaXpMa1F5K0N4cFVOQ1RRRUlWOGpx?=
 =?utf-8?B?anJHS3lhUnlSMEY1bUJuWU10Nlp6NzZkSUozc2E1UEtUVElvckIyNmlrN0Js?=
 =?utf-8?B?c0taWGduWStSYWZ3OTVTREdmaHVJdGpPMUd0aFFvZHVNbllMcGpZQXcvdEJi?=
 =?utf-8?B?eFNZUlEvZjFuK0N0ekRBZnVyRkJ6RVFENFgwZjAvTnI2clpNYkNVRE91Mlk5?=
 =?utf-8?B?eWNQNGpBOWh6MHBvcVVQem9RZmFVbVBoT1lzeGZDYmdFdmxCQ29FbWpDUVZI?=
 =?utf-8?B?cXo1L2NYOFRIOW5iWlFwMTNnZW8xRXZKQ0tZaksxeW43Tnh0N3RvdzduWVRv?=
 =?utf-8?Q?AdbnlD7xOPhwD5VIOXMUeAdKtXLXuUnh8Hb7I=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <3F42C0A5455C174B9BF494BAEB8FB238@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669b34ac-fc91-4804-4f9b-08d973ad8ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 16:19:05.4493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CP9S0UuFkHDtKF8hPhPgaHOFmGp6SKdRPVyPGo9kjt3Knqlll+Py0MqTr9Pceb3oxYoF/jHsLFoVEtu+zOIHpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_091909_286461_BFC30B84 
X-CRM114-Status: GOOD (  17.08  )
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

On 9/9/21 7:57 AM, chengjike wrote:
> The "path->nentry" is initialized after it is added to the list in "nvme_subsystem_set_path_ns" function.
> 

Overally long commit message, plz send.

> Signed-off-by: chengjike <chengjike.cheng@huawei.com>
> ---
>   src/nvme/tree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/nvme/tree.c b/src/nvme/tree.c
> index 49815db..293b0c0 100644
> --- a/src/nvme/tree.c
> +++ b/src/nvme/tree.c
> @@ -534,7 +534,6 @@ static int nvme_ctrl_scan_path(struct nvme_ctrl *c, char *name)
>   	p->name = strdup(name);
>   	p->sysfs_dir = path;
>   	p->ana_state = nvme_get_path_attr(p, "ana_state");
> -	nvme_subsystem_set_path_ns(c->s, p);
>   
>   	grpid = nvme_get_path_attr(p, "ana_grpid");
>   	if (grpid) {
> @@ -543,6 +542,7 @@ static int nvme_ctrl_scan_path(struct nvme_ctrl *c, char *name)
>   	}
>   
>   	list_node_init(&p->nentry);
> +	nvme_subsystem_set_path_ns(c->s, p);
>   	list_node_init(&p->entry);
>   	list_add(&c->paths, &p->entry);
>   	return 0;
> 
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
