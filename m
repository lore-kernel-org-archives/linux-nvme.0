Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1042FC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 23:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NdVG0vi3Qj6omTeqtLaaPLiBrtOvklGsD8Km49rA/Yg=; b=EpcNDc2hFcyaISNhISqVE+ovEm
	Xe743zMpAuWhFQlQBB+owDFY7OsIGSxEJdY/k36+KWw9tzUUXpt7o/MEd369pu+gO1P4xxrjoaUnR
	WHRAHN7xCTmCYKu+B314QcTteHTt1AA+Em7TUtRTooJ5qriTzMnYoQvp4P/TvcnHsdxDu/dEovMRE
	ez4tiz2stG7q36dAVhxuluUhULCuBfX4D5Q8BTxpeYuLf3hYCJfSSYs09nA9fypxpPHYBqQHUy+cU
	bHQYGbbRPIMEXFGBLhpME/feQdhPSQPP5sFb+MtLtyn4Kf6nwWynh1kbdPOxwfZ7p42fynpVIuIRB
	soi77mgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncF5g-008F0I-P2; Wed, 06 Apr 2022 23:29:32 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncF5d-008Ez4-6N
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 23:29:31 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236KGj3m012451; 
 Wed, 6 Apr 2022 23:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NdVG0vi3Qj6omTeqtLaaPLiBrtOvklGsD8Km49rA/Yg=;
 b=t91IKsKe6WS7bdHWngaAHk+M8nX4ouLlrycnhcqM3hsRLXypfNlf54LV/z8SG6g73umL
 l2cVvJ4YDzhM/XEuSg+oacUfxWPWC21nth4iVxSoSeaDXKEykFP+9jgoiwNOky6eINaU
 wy5yBQ6yY4p6JzFO6cPotHpEs8FusFiStQjZlA8REqXqLfPk1Fom8pJYsPxxaIFu0ptU
 +ZH+8z2Lbdkmwbf3eDkyd8J2877nNpW1ev+Diof0YpSQHZfwTuuthgTKqhGUMVSS9pQI
 IDOteI7fH8irpveesXQATyFtoYJSjKBYnX4KpzTxS7cGZ6GMaoKdJBCrVQoUl8DcQaB/ UA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcj31u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Apr 2022 23:29:21 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 236NBZFN040434; Wed, 6 Apr 2022 23:29:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3f97tsq4b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Apr 2022 23:29:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HE147rlfAeooopq4/fn5eJeOyqgkTk8fvegmpwDc/p4P9cEys7sfWJaM05g0xdydNT7NncDS9NmHRSsZf57vrv2TwJjS3nZ1opSkNmuRlLVszsWWJOxxARzg8Ad5bVtj/uyE9RZWpGsUd/u3OE3yFPwQpOXl6dh1siY4JTI/8Xax/YTCvklo1dnZzCQqlWUTkxkaJNC6stKtorrWWclPugrxObFY4S5Nnd8APefgMTaJF8+dBXolWULoKTlBLRBKMF5X8Sk5WQ5TA4/wH5BGqwU2th6EeGjNZMMlqdGg+l4Gw4oBN88qtbISx6pZGtlNvBMjibhpgrgFPD/5Bmhp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdVG0vi3Qj6omTeqtLaaPLiBrtOvklGsD8Km49rA/Yg=;
 b=QJnvBow9Jadg6RDBJmfffkvXzkh6n5TVhvnRANjsJwoccp+PX/3HLXr7KTJGFpjBDj+ORh98O5x8iEcwCJ4BY6/02kRzgqvGjDj5YezP4kMa+USxDT3CJaZAO20VHDMPdXGp10lGl+M/lC7zOK72ONwkbRErnJsvV5gLBK5HY+rBW7xTdRnZMN7mzrT28yFIUVyXKjC+OdZwxJqF2hXtZbrSwMUyrfBw9oPekr8ssw5lSyD2csHG9QbCYlQQ2wMyEH+BvOykbkPFWj9dGKtJPXh4TkDPipKk5aASrO4H9XaUkZvKN8OYJ49DZwJM/BxoAe3jcmGIpuOGNMGaFGKTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdVG0vi3Qj6omTeqtLaaPLiBrtOvklGsD8Km49rA/Yg=;
 b=Ht9UVsnXClJf3RskWyHktrAuE6JYNYLPRpeMBOSpttTtbwAd9OmnIrXpG/lc7kyci9YWS1iMZgSufzdZ1LPUt5JfHJIu3rm2ctd6YGrt27v4E+iKsOHt9jF2ageuFDbXiU5s6u7gpp4yGi6FCA7PFW6RWy/lQELZCmfEG4NjUCU=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH0PR10MB5402.namprd10.prod.outlook.com (2603:10b6:510:e2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 23:29:18 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff%8]) with mapi id 15.20.5144.021; Wed, 6 Apr 2022
 23:29:18 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Hannes
 Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Topic: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Index: AQHYSdUqFpKGiT1CSkmELkSF7x4OoazjGb6AgAAClgCAAAWlAIAAT2KAgAAC9ACAABRKgA==
Date: Wed, 6 Apr 2022 23:29:18 +0000
Message-ID: <34DD0B6B-F7F1-4BEC-B039-1B0DA9D36676@oracle.com>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
 <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
 <feec0fdf-2790-1f48-9a95-88bf208784ab@nvidia.com>
In-Reply-To: <feec0fdf-2790-1f48-9a95-88bf208784ab@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 353d8df6-ebf5-4cd4-4da3-08da182545a0
x-ms-traffictypediagnostic: PH0PR10MB5402:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5402D32339CA6507CD9F0E75F4E79@PH0PR10MB5402.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ASPN32NIs97FxKmsz8AqeFR/KHqPe5A1f9D55T/wg5JFq4kMvZB/nPyrPf6isn3yzRrfaa20yWB7wPrKFu9+BtL8Dw3CvuWFKft3gxvBBzO7e7ivZkHWJMimhUmOZk0A+lmdfbxgw1wO/r2hTwu0MKXSnnR9FmIrbMToSDae2eoAc4naNJp7jDQwXZ7EtiGPgGdP8Yf3Au/mcdZS546lWHo79AZcMbdhBPXe8Kh1IXHQjgRc3O6dKO2gcosIaAKWOoDNUcBv0hwiyaS0OarJYPrP8AL+ZTdnfNOAbryOrmQPatNecbmQblpQ1Z7uQsO43shkcI7ugjeeYKrsTu2WYmc7uNEwqK57QJTyarEOnkCMfyxdQcx5LFBgeUNYldI70OlqbV9TjkANMnbKiAq3NjaCqticPLMSEm5tqY4Op9O3zCanejPQc9Lkfc3pPGQNftDBr/ijzSF7bTU/ObtNy0VEjm1q6xwNfmTKzRhlM3abbZlnehqx26+tmx0WSHf+0atmSqVH7oPyrWGncDyF0kbZxpeOR31SUYUVDYOW0MCdxZYCeU6f56p+nZE8MHyLDTrYKnTXc6q6/Z2enos9W/1aW/IdZVStq70GFZab86kmpaXdxDWPtmGeCX5oTIw/F/CToJN+hFhCFi8EBelnYywbBvHTZjltN+VjABDFOPEdFf8lEDMRq0xy5VxeTExAVN/heg48Is6rck3MevjboshhVc9cTbwgprJn5bykSrHjVoTKPzPKZYvGPn0XQAE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(71200400001)(2906002)(83380400001)(5660300002)(33656002)(508600001)(86362001)(91956017)(54906003)(66556008)(76116006)(6486002)(6916009)(66946007)(66476007)(66446008)(4326008)(8676002)(64756008)(44832011)(2616005)(6512007)(36756003)(8936002)(122000001)(316002)(38100700002)(6506007)(186003)(53546011)(26005)(38070700005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekI5ZTJHQ3hQZk5zbkpXUFRUTWZwWDhOYXJZYi9jTGFuS1U1dU1zTjRtUS91?=
 =?utf-8?B?aG5GOXZVcWowOFA2T0dscG5XOGtiOFI4QUk1UWR2R25WeThBWnVKS2w3aEQ0?=
 =?utf-8?B?TWVNTnYzUnU5T3gyRk1kOEQrcnNqWEdwS0hWcStlYTZISE1nMU5maDRmZEdu?=
 =?utf-8?B?WUlSei9HanRnTmUwSEZveTRJOUxRanFDOVRVNDR1TnVBZ1FFSDY3aE5QTDlY?=
 =?utf-8?B?UUVLM1JzQ3pBZ2J4QTlOci9CL0QwcjdYQUgxMVdGdFNhbldWWG84K1RxSlRx?=
 =?utf-8?B?Z1M0UStXam1XaTFGTzhHSmtMMDNUSytxZE9rU1N5d3pTaTV4K2l6MjhucUFa?=
 =?utf-8?B?ZUpvQlc5eFFtTTBjS3dwVjQ4Yk5OVGlyTkh5aW5DYWRXcnVYQ0txTWVkaXRN?=
 =?utf-8?B?dHQ5eURsVUhEZUFGUmQ1OTBjWERWSitHVUFIL2d2WkhvaEYxb0FCM00vNElV?=
 =?utf-8?B?L20wc3dHa2dnK0E1aDlTc3BacExHNHpBS2NEb3hXWm1vMy8va0VTaXR1SVRP?=
 =?utf-8?B?eVF3c3VCSUUrd05PQ0U5TDRlRlZFQ29MODNjUkJnc29aL2lpazVNYlA1NTlE?=
 =?utf-8?B?ZFo4cml5bGFXM0taRHZDTU9KbGEzZlQ3SmtXZGdTK2NheDJOb2xpcFhreFZJ?=
 =?utf-8?B?SjByZW5QdUpqdktrazhMWFltK2toWjY5STRFMlIwcmVBT3YxU0d2WEI2aCtk?=
 =?utf-8?B?U1I0N1V1cUc1UHIrbDFEKzVxYnJvNmZjcjhWaTkzT281d0lQbWY3QndXZ1RE?=
 =?utf-8?B?UFNQazkrNFdxRmNyNXFkQk9SWjdTK2toS3lTZVRoT212MGpiWUkwNWMzWCs1?=
 =?utf-8?B?OWNLczZjbzJMQ2tkMEVQVzVZOHZyU0dPSXUyNjFyb2ZPV08xdm0wdW5TZ3hX?=
 =?utf-8?B?VHlGYUdZcm81RlhuZzU5VTdaSkVab1lZdCtiREJzeTVROXcyN1Zqc3lNU2g5?=
 =?utf-8?B?c1R2ZGdnaFVrbU1FbnpvbXFDcmFuNnlHcDNIeHBROWpGRWRwVjNJSEFmSGls?=
 =?utf-8?B?VEM2YVJscVRTLzQ2akdrR3lwdE1OdFo5TWZra1l2SDRjVHFxallqazlTSVNP?=
 =?utf-8?B?bkdkS1NIZXZrMGhpRTZOZUVGVU9PcHNGMGlZUkNPL1MxSWNxVG1MbDdtSHA5?=
 =?utf-8?B?UXU3WnFmQ2JCVklQdGo3eFFKZm4xSndmaWxxcEwwV1l3M3pBQWVuejFvaXBt?=
 =?utf-8?B?SEEzM21NNzVKcTF3VzN0TlFZZmNVTlV2dkVQdllzQ1dPOWd5RGJVaWhJWFVZ?=
 =?utf-8?B?QzJvYVlPNThQcHdGTHZLRjd5QlM3cHJFTFVoY25qb0p3bVJHUG1ncFhnU2Ra?=
 =?utf-8?B?QkVGMnhYMnhLUDNiRnVVc3BBZEoxK0tFeEpLN280SlZYVVVFMkpGS080SXlV?=
 =?utf-8?B?SG9XS0NqMU5YWFlTRXN2SXozelFBY0dGekpjZWxraSs4SDM2V0FnSnZrSlhV?=
 =?utf-8?B?dVllNFRqR29hTmZ6VzF2eGNxWThxSnVzd3JmTHM0cDFzR3N3YjR6ZVZibmgw?=
 =?utf-8?B?Y3hPaGZ0M3JXeVVva0JaTHhIMWRSOVRFc3ZHVExmR3VNYUd5SVpGV0liSGNC?=
 =?utf-8?B?N1BuR2NhMjFnQjZLUkdFM0JyUkw4bVRPZm9wVXFkVVF2OGxIMnd4d3hNTXlz?=
 =?utf-8?B?S0o1K3RvRnhIYkpJaWh5VE5XK2QrbGF4UE5idDN2emRUNGViaDdQdmRsdzlr?=
 =?utf-8?B?NjBPa0hzUGhGN1Frdy9lNGYvejlGcWZLZGxOT0tBWEFSZFFhN3F0c1Fuek9R?=
 =?utf-8?B?SFlNUm1XZENWQmhDNW9QV0RIbHM2a0pWOWdyakxGeEUxZ0R0MUtQaENYc1Nk?=
 =?utf-8?B?TlRYell6TkhxTWt6MkxxSithamRGdGJEUVZEcVBBM3BsOWFDS1B1TW01aHBI?=
 =?utf-8?B?aUduSWxSaU9KMmNxclc0b21DMVd6WUE3VzAyOGdMQkJxWVdRN010U1A3d3Nx?=
 =?utf-8?B?azhNcEpoc0ZSTW5GOUhHdldnYTV4VisrV3pJTnZHbU4ySzlIdDBSYXZWN29X?=
 =?utf-8?B?UzRVUExLVTd5cDE2VXlTMjQ5NEt2Uko2VTdHMktPRlFWdFVPMzc1aGFqcEVB?=
 =?utf-8?B?TThuWDE2a2VoRzdsYjJtYm5xdHhoMEplK2ZCUEVLMEtwYSthTHgxUHphejhy?=
 =?utf-8?B?WldxTjFPKys2WU1XdmtoakRVZlUrRHFHMlNNdy9PNzlXRE9ERWFwcDdqTGt5?=
 =?utf-8?B?L0ZDT2pJcEZRM3ZrdmFsc2o3bTZlcG1IK3gvT0VXNU1JcG14V1hFRDVmY2lz?=
 =?utf-8?B?ZFpiTjdFdmtTZ2lrTGRaMDdvd3p6aXNkVHdNVlRkRkxnWVowdElwU0lyTVJy?=
 =?utf-8?B?ZDZUZFVFRkFTMmU0ZjhHZWFrNHIwdzVYUmJjNTFYaysvWjBwQjF4YVdGZVUv?=
 =?utf-8?Q?yEglVbLzRFMR9t3I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <888C7593E50FC14C932BABD83D3C316A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353d8df6-ebf5-4cd4-4da3-08da182545a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 23:29:18.6399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Tlxy//6fKPtY0h4DDSvaFicFRL7iTiMxAz6LNQn5i6/DJO7nAoomP8PVZT7q/WHn+NxWwKHAbaNEsO6tJZP2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5402
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.850
 definitions=2022-04-06_13:2022-04-06,
 2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060114
X-Proofpoint-ORIG-GUID: Scw4nrfzZxNIM4gBNx6l1L30q626sEI_
X-Proofpoint-GUID: Scw4nrfzZxNIM4gBNx6l1L30q626sEI_
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_162929_536662_0E546997 
X-CRM114-Status: GOOD (  21.80  )
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

SSB0cmllZCB0aGUgcGF0Y2ggd2l0aCBteSB0ZXN0cy4gIEl0IHJlc29sdmVzIHRoZSBlcnJvciBs
b2dnaW5nIHdpdGggbnZtZS8wMTIuICBNeSB2ZXJib3NlIGVycm9ycyB0ZXN0cyAobnZtZS8wMzkp
IG5vdyBwYXNzZXMsDQpidXQgd2Ugc3RpbGwgc2VlIHRoZSBlcnJvciB3aGVuIHRoZSBzeXN0ZW0g
Ym9vdHMuDQoNCg0Kcm9vdEBsb2NhbGhvc3QgYmxrdGVzdHNdIyAuL2NoZWNrIG52bWUvMDEyDQpu
dm1lLzAxMiAocnVuIG1rZnMgYW5kIGRhdGEgdmVyaWZpY2F0aW9uIGZpbyBqb2Igb24gTlZNZU9G
IGJsb2NrIGRldmljZS1iYWNrZWQgbnMpIFtwYXNzZWRdDQogICAgcnVudGltZSAgMzkuMTgwcyAg
Li4uICA0MS40MzJzDQpbcm9vdEBsb2NhbGhvc3QgYmxrdGVzdHNdIw0KDQoNClsgICA3Ny45NDY1
MDVdIHJ1biBibGt0ZXN0cyBudm1lLzAxMiBhdCAyMDIyLTA0LTA2IDE5OjIyOjIzDQpbICAgNzgu
MDEzMDkyXSBsb29wOiBtb2R1bGUgbG9hZGVkDQpbICAgNzguMDE0MzQ0XSBsb29wMDogZGV0ZWN0
ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20gMCB0byAyMDk3MTUyDQpbICAgNzguMDI0ODc1XSBudm1l
dDogYWRkaW5nIG5zaWQgMSB0byBzdWJzeXN0ZW0gYmxrdGVzdHMtc3Vic3lzdGVtLTENClsgICA3
OC4wNTI4NzRdIG52bWV0OiBjcmVhdGluZyBudm0gY29udHJvbGxlciAxIGZvciBzdWJzeXN0ZW0g
YmxrdGVzdHMtc3Vic3lzdGVtLTEgZm9yIE5RTiBucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzczp1
dWlkOjAwMDAwMDAwLTAwMDAtMDAwMC0wMDAwLTAwMDAwMDAwMDAwMC4NClsgICA3OC4wNTMxMDdd
IG52bWUgbnZtZTE6IGNyZWF0aW5nIDEgSS9PIHF1ZXVlcy4NClsgICA3OC4wNTMxODJdIG52bWUg
bnZtZTE6IG5ldyBjdHJsOiAiYmxrdGVzdHMtc3Vic3lzdGVtLTEiDQpbICAgNzkuMTI1OTI5XSBY
RlMgKG52bWUxbjEpOiBNb3VudGluZyBWNSBGaWxlc3lzdGVtDQpbICAgNzkuMTI4MzIxXSBYRlMg
KG52bWUxbjEpOiBFbmRpbmcgY2xlYW4gbW91bnQNClsgICA3OS4xMjg0ODBdIHhmcyBmaWxlc3lz
dGVtIGJlaW5nIG1vdW50ZWQgYXQgL21udC9ibGt0ZXN0cyBzdXBwb3J0cyB0aW1lc3RhbXBzIHVu
dGlsIDIwMzggKDB4N2ZmZmZmZmYpDQpbICAxMTkuMjUzMjQ2XSBYRlMgKG52bWUxbjEpOiBVbm1v
dW50aW5nIEZpbGVzeXN0ZW0NClsgIDExOS4yNjQwMDVdIG52bWUgbnZtZTE6IFJlbW92aW5nIGN0
cmw6IE5RTiAiYmxrdGVzdHMtc3Vic3lzdGVtLTEiDQoNCg0KVmVyYm9zZSBFcnJvcnMgYmxrdGVz
dHMNCj09PT09PT09PT09PT09PT09PT09PT09DQpbcm9vdEBsb2NhbGhvc3QgYmxrdGVzdHNdIyAu
L2NoZWNrIG52bWUvMDM5DQpudm1lLzAzOSA9PiBudm1lMG4xICh0ZXN0IGVycm9yIGxvZ2dpbmcp
ICAgICAgICAgICAgICAgICAgICAgW3Bhc3NlZF0NCiAgICBydW50aW1lICAwLjA2MHMgIC4uLiAg
MC4wNThzDQpbcm9vdEBsb2NhbGhvc3QgYmxrdGVzdHNdIw0KDQpCb290DQo9PT09DQpbICAgIDMu
MjQ0MDU2XSBudm1lMDogSWRlbnRpZnkoMHg2KSwgSW52YWxpZCBGaWVsZCBpbiBDb21tYW5kIChz
Y3QgMHgwIC8gc2MgMHgyKSBETlINCg0KDQpBbGFuDQoNCg0KDQp+ICAgICAgICAgICAgICAgICAN
Cg0KPiBPbiBBcHIgNiwgMjAyMiwgYXQgMzoxNiBQTSwgQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFp
dGFueWFrQG52aWRpYS5jb20+IHdyb3RlOg0KPiANCj4gT24gNC82LzIyIDE1OjA2LCBBbGFuIEFk
YW1zb24gd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEFwciA2LCAyMDIyLCBhdCAxMDoyMSBBTSwg
S2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4+PiBPbiBXZWQs
IEFwciAwNiwgMjAyMiBhdCAwNTowMTo0NlBNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3Jv
dGU6DQo+Pj4+IE9uIDQvNi8yMiAwOTo1MiwgS2VpdGggQnVzY2ggd3JvdGU6DQo+Pj4+PiBPbiBX
ZWQsIEFwciAwNiwgMjAyMiBhdCAwOTo0MTowOUFNIC0wNzAwLCBDaGFpdGFueWEgS3Vsa2Fybmkg
d3JvdGU6DQo+Pj4+Pj4gQEAgLTM3MCw3ICszNzAsOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbnZt
ZV9lbmRfcmVxKHN0cnVjdCByZXF1ZXN0ICpyZXEpDQo+Pj4+Pj4gIHsNCj4+Pj4+PiAgCWJsa19z
dGF0dXNfdCBzdGF0dXMgPSBudm1lX2Vycm9yX3N0YXR1cyhudm1lX3JlcShyZXEpLT5zdGF0dXMp
Ow0KPj4+Pj4+IA0KPj4+Pj4+IC0JaWYgKHVubGlrZWx5KG52bWVfcmVxKHJlcSktPnN0YXR1cyAh
PSBOVk1FX1NDX1NVQ0NFU1MpKQ0KPj4+Pj4+ICsJaWYgKHVubGlrZWx5KG52bWVfcmVxKHJlcSkt
PnN0YXR1cyAhPSBOVk1FX1NDX1NVQ0NFU1MgJiYNCj4+Pj4+PiArCQkgICAgIShyZXEtPnJxX2Zs
YWdzICYgUlFGX1FVSUVUKSkpDQo+Pj4+Pj4gIAkJbnZtZV9sb2dfZXJyb3IocmVxKTsNCj4+Pj4+
PiAgCW52bWVfZW5kX3JlcV96b25lZChyZXEpOw0KPj4+Pj4+ICAJbnZtZV90cmFjZV9iaW9fY29t
cGxldGUocmVxKTsNCj4+Pj4+PiBAQCAtNjUxLDYgKzY1Miw3IEBAIHZvaWQgbnZtZV9pbml0X3Jl
cXVlc3Qoc3RydWN0IHJlcXVlc3QgKnJlcSwgc3RydWN0IG52bWVfY29tbWFuZCAqY21kKQ0KPj4+
Pj4+ICAJY21kLT5jb21tb24uZmxhZ3MgJj0gfk5WTUVfQ01EX1NHTF9BTEw7DQo+Pj4+Pj4gDQo+
Pj4+Pj4gIAlyZXEtPmNtZF9mbGFncyB8PSBSRVFfRkFJTEZBU1RfRFJJVkVSOw0KPj4+Pj4+ICsJ
cmVxLT5ycV9mbGFncyB8PSBSUUZfUVVJRVQ7DQo+Pj4+PiANCj4+Pj4+IFRoaXMgZGVmZWF0cyB0
aGUgYWRtaW4gZXJyb3IgbG9nZ2luZyBsb2dpYyBzaW5jZSBldmVyeSBhZG1pbiBjb21tYW5kIGNv
bWVzDQo+Pj4+PiB0aHJvdWdoIGhlcmUuIElmIHlvdSdyZSBzdXJlIHdlIHNob3VsZCBkbyB0aGlz
LCB0aGVuIEkgc3VwcG9zZSB5b3UgY2FuIHJlbW92ZQ0KPj4+Pj4gdGhhdCB1bnJlYWNoYWJsZSBj
b2RlLg0KPj4+PiANCj4+Pj4gSWYgeW91IHBvaW50IG91dCB0aGUgdW5yZWFjaGFibGUgY29kZSB0
aGF0IHdpbGwgYmUgZ3JlYXQsDQo+Pj4+IEknbGwga2VlcCBsb29raW5nIG1lYW53aGlsZS4uLg0K
Pj4+IA0KPj4+IFRoZSBzZWNvbmQgaGFsZiBvZiBudm1lX2xvZ19lcnJvcigpLCBwbHVzIG52bWVf
Z2V0X2FkbWluX29wY29kZV9zdHIoKSBhbmQgdGhlDQo+Pj4gYXJyYXkgaXQgZGVmaW5lcyBhcmUg
dW5yZWFjaGFibGUgc2luY2UgYWxsIGFkbWluIGNvbW1hbmRzIGRvbid0IGxvZyBlcnJvcnMgd2l0
aA0KPj4+IHRoaXMgY2hhbmdlLg0KPj4+IA0KPj4+IFlvdSBjb3VsZCBza2lwIHRoZSBSUUZfUVVJ
RVQgc2V0dGluZyBhbmQgY2hlY2sgYmxrX3JxX2lzX3Bhc3N0aHJvdWdoKCkgaW5zdGVhZC4NCj4+
IA0KPj4gVXNpbmcgUlFGX1FVSUVUIG9yIGJsa19ycV9pc19wYXNzcmhyb3VnaCgpIHdpbGwgbWVh
biBubyBudm1lIGFkbWluLXBhc3N0aHJ1IGNvbW1hbmQgd2lsbCBsb2cgYW4gZXJyb3IuDQo+PiBJ
IHJhbiBpbnRvIHRoaXMgdXNpbmcgdGhlIGJsa3Rlc3RzIEnigJltIGNvZGluZyB1cCBmb3IgdmVy
Ym9zZSBlcnJvcnMuICBJcyB0aGlzIHRoZSBiZWhhdmlvciB3ZSB3YW50Pw0KPj4gDQo+PiBBbGFu
DQo+PiANCj4gDQo+IFNhZ2kvQ2hyaXN0b3BoL0hhbm5lcy9LZWl0aCwNCj4gDQo+IEFmdGVyIGRl
YnVnZ2luZyB0aGUgaXNzdWUgZm9sbG93aW5nIHBhdGNoIFsxXSBtYWtlcyBlcnJvcnMgZGlzYXBw
ZWFyLg0KPiANCj4gQnV0IEknbSBub3Qgc3VyZSBpZiB0aGlzIGJlaGF2aW9yIGFsaWducyB3aXRo
IHByb3RvY29sIG9yIG5vdC4NCj4gDQo+IEknbGwga2VlcCBkaWdnaW5nLCBtZWFud2hpbGUgaWYg
YW55b25lIGhhcyBhbiBpZGVhIHBsZWFzZSBwcm92aWRlIGEgDQo+IHJldmlldyBvbiBwYXRjaCBp
biBbMV0gaWYgbWFrZSBzZW5zZSBvciBub3QuDQo+IA0KPiAtY2sNCj4gDQo+IFsxXSBtYXNrIGlu
dmFsaWQgTlZNRV9JRF9DTlNfQ1NfQ1RSTCBlcnJvcnMuDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYyANCj4gYi9kcml2ZXJzL252bWUvdGFyZ2V0L2Fk
bWluLWNtZC5jDQo+IGluZGV4IDM5N2RhYWY1MWYxYi4uZTVlZWEyZjBhYzljIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jDQo+ICsrKyBiL2RyaXZlcnMvbnZt
ZS90YXJnZXQvYWRtaW4tY21kLmMNCj4gQEAgLTcxOCw5ICs3MTgsMTYgQEAgc3RhdGljIHZvaWQg
bnZtZXRfZXhlY3V0ZV9pZGVudGlmeShzdHJ1Y3QgbnZtZXRfcmVxIA0KPiAqcmVxKQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICBzd2l0Y2ggKHJlcS0+Y21kLT5pZGVudGlmeS5jc2kpIHsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgY2FzZSBOVk1FX0NTSV9aTlM6DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIA0KPiBudm1ldF9leGVjdXRlX2lkZW50aWZ5X2Nu
c19jc19jdHJsKHJlcSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNhc2UgTlZNRV9DU0lf
TlZNOg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBudm1ldF9leGVj
dXRlX2lkZW50aWZ5X2N0cmwocmVxKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZGVmYXVs
dDoNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgc3dpdGNoIChyZXEtPmNtZC0+aWRlbnRpZnkuY3NpKSB7DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGNhc2UgTlZNRV9DU0lfTlZNOg0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiBudm1ldF9leGVjdXRlX2lkZW50aWZ5X2N0cmwocmVxKTsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgfQ0KPiAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgY2FzZSBOVk1FX0lEX0NOU19OU19BQ1RJVkVf
TElTVDoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvZGlzY292ZXJ5LmMgDQo+
IGIvZHJpdmVycy9udm1lL3RhcmdldC9kaXNjb3ZlcnkuYw0KPiBpbmRleCBjMjE2MmVlZjhjZTEu
LjM0YzdlZDA1NTY3NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9kaXNjb3Zl
cnkuYw0KPiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2Rpc2NvdmVyeS5jDQo+IEBAIC0yNTQs
NyArMjU0LDExIEBAIHN0YXRpYyB2b2lkIG52bWV0X2V4ZWN1dGVfZGlzY19pZGVudGlmeShzdHJ1
Y3QgDQo+IG52bWV0X3JlcSAqcmVxKQ0KPiAgICAgICAgIGlmICghbnZtZXRfY2hlY2tfdHJhbnNm
ZXJfbGVuKHJlcSwgTlZNRV9JREVOVElGWV9EQVRBX1NJWkUpKQ0KPiAgICAgICAgICAgICAgICAg
cmV0dXJuOw0KPiANCj4gLSAgICAgICBpZiAocmVxLT5jbWQtPmlkZW50aWZ5LmNucyAhPSBOVk1F
X0lEX0NOU19DVFJMKSB7DQo+ICsgICAgICAgc3dpdGNoIChyZXEtPmNtZC0+aWRlbnRpZnkuY25z
KSB7DQo+ICsgICAgICAgY2FzZSBOVk1FX0lEX0NOU19DVFJMOg0KPiArICAgICAgIGNhc2UgTlZN
RV9JRF9DTlNfQ1NfQ1RSTDoNCj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgIGRl
ZmF1bHQ6DQo+ICAgICAgICAgICAgICAgICByZXEtPmVycm9yX2xvYyA9IG9mZnNldG9mKHN0cnVj
dCBudm1lX2lkZW50aWZ5LCBjbnMpOw0KPiAgICAgICAgICAgICAgICAgc3RhdHVzID0gTlZNRV9T
Q19JTlZBTElEX0ZJRUxEIHwgTlZNRV9TQ19ETlI7DQo+ICAgICAgICAgICAgICAgICBnb3RvIG91
dDsNCj4gDQoNCg==

