Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AEEC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LHbbNDmRKazqa1zjRpa/O5CaKKEHaOYwXsanu/i4sQA=; b=2+ZmFsjYqGF0iTCO7vVZrmmFNn
	AhpZYg+QF9dpvNabQF26LgxHTOGp09W0lukqq2jRE78pqs39c6fnXYMVhC+0TSao24l7E+JGJkNx2
	Gm5Fc+BCVf9iLOZDA0uDgxT2Hjxwf1tv7zxEPcNG99mGBDqnV0sje/RHt8+75VcnBaSwR2EVhzfRS
	NT4yrevDCr0eA7v70XQJQodIByw35ESVULLen0+BPGOH64VKqM776E76NArNHPGEGzdch8o11CFji
	4hKCioKwi2pdlZ9ooueqa/Lk8W7jZxHX+BI1pp3VqaX74Jtvs+gLnOyDskIOdj8urcz3lr/LF4upB
	3zdyCpdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncrT7-000W8c-JU; Fri, 08 Apr 2022 16:28:17 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncrPj-000Ubm-JG
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 16:24:49 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238F4o2F004957; 
 Fri, 8 Apr 2022 16:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LHbbNDmRKazqa1zjRpa/O5CaKKEHaOYwXsanu/i4sQA=;
 b=kXWwey3qMVQJ2iq1/dQmtlf3V1utWw914RHB6nNoCmYhSKWg0AGxC2jyjZxeHIJj/sRo
 1GBn5FG+TWP0gOd9JNWIAqryukahmetKP1KxryiBX6xB5KkbwFvJcbCGw7UrrMjFMNgT
 V3zOy2PGCW+X5WBjz1C703uv5dy7+RwNpovUYxAKED2lGjMgPrZZv68m0a+1T12RERSu
 8JDbLPh+BoPZRF2oTgPzwm7mwzi+NYI5Aj4l5sZJUMFt9+G9dxACwrJB9lH7jaXnr5eH
 bxpg8DZZMnBbG3xkoRMYEX1t4ujbhQtUpzsnhkgjiLUaMMuTpdxhXhCkflkfQfCsRkps MA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com with ESMTP id 3f6d937m58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Apr 2022 16:24:29 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 238GArSl014791; Fri, 8 Apr 2022 16:24:28 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3f97y91hdy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Apr 2022 16:24:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+7W+1fiSA120xhgiEU2u8TdYW0uEiHG6qtIxm4tqdn2fajsnBwe5PY+jHTXtGDCZYEaihiIMSc9l3S+zAV438rlyFh4s5F0ve4sfWlW6el0amOLXR8/I5MPUBDqmOI07GN7E6T4MaMoioVHPQ/zZGtB3rm+KfQKHiBWIKfOPnluJwpUhAq8Qya+obkagZBO+uQUHcmadptdjczHaPB+/Is6YkcJymiX7ElXjEhYfjMRPH/dQj2g94lqaOhDEc2mRIBw/JG+PxTkSEYHSNsE40HFZqlhlIvZPdxKo8ZmKvFhNdsX03zKeyLf5892BWBqOgXj74tK+r0HU9i6drLgjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHbbNDmRKazqa1zjRpa/O5CaKKEHaOYwXsanu/i4sQA=;
 b=mFeOCAOfuw+NNhnjaXArCLsxpzHxrI1lZKWUElOVCnNvzOfWYck+tw3ru0bAGKNx8spSdoN2XnLHWBI5lNzYbmTizd9SeCFm3ou1lK1bq2vJV2j0J+k1i3VvNHF45RBRs3XQ/aBNRvtZ+nPpNOYVcS21LwS8kUkEfiydE9dOds3as8Dt5lWGss44gIkEqz7neDNO0aM2bYhF9x91y1mbvqUDeoA1UMH0lqFsKiOxyXGIN3jbr8/ZcBB3rUn2FDgJm+E2b+DxAjJTIdkZ/G5FZyoC2YvSbBRFEbfMne7OSHRS6apcG5sR6ynUdV7FqRhAF832MfQrH3mzZqvp8716Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHbbNDmRKazqa1zjRpa/O5CaKKEHaOYwXsanu/i4sQA=;
 b=qk2pb/+a8FZ07xyaWCPe2tLAHI+Vv1UDWwplJ6ZLVCZ2jorfA4K04QMpMOILoCXJoIHT+D5J7Lg9o1vLDn0ADLqk/S1SGG5CxLgiKUGbfQudUSFuE6Tk/nvsJ3beRg0atmnomGjRfE0yqIaHZu7yJkDpQMFAWWWf1fxluE/nJH4=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CH0PR10MB5129.namprd10.prod.outlook.com (2603:10b6:610:d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.27; Fri, 8 Apr
 2022 16:24:26 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff%8]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 16:24:26 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Topic: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Index: AQHYSdUqFpKGiT1CSkmELkSF7x4OoazjGb6AgAAClgCAAAWlAIAAT2KAgAC0P4CAADK+AIAAiyIAgAAGzACAAAbzAIAAA96AgABTmgCAAO3dgA==
Date: Fri, 8 Apr 2022 16:24:26 +0000
Message-ID: <884816D4-96AC-4489-859E-2C52972D7FBE@oracle.com>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
 <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
 <20220407085113.GB19062@lst.de>
 <64ff1e92-6c6c-da38-8753-0e6098394622@grimberg.me>
 <4386789d-6722-add8-5b42-f605e48e894b@nvidia.com>
 <650E6456-BCAC-47DA-B50E-4321E98AC9AC@oracle.com>
 <b793928e-f127-8155-b124-642614afbb85@nvidia.com>
 <C8570F84-276F-42D0-9914-4440FAF64B5C@oracle.com>
 <752d1875-1680-8f8d-7330-d5e8771c7e7a@nvidia.com>
In-Reply-To: <752d1875-1680-8f8d-7330-d5e8771c7e7a@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3945c751-987b-43ec-6c3d-08da197c3fe1
x-ms-traffictypediagnostic: CH0PR10MB5129:EE_
x-microsoft-antispam-prvs: <CH0PR10MB512943E98C59B6AF7E3DD010F4E99@CH0PR10MB5129.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EE5CzlzloyhO8tuQERR+NVhQtFqEWVVxKaW2EbZE5fY7ccOoUnEU+yeGXR3/IbnDubwd3hK2HNT5LV15eMk54BVNKSYFGh5rd6TLZHDGd2SjpCYCWcV8wXLfQHOvJlo+ie4NhshOcHik0mkt/Nh+wIBztnz+0fzWohKUCBTT5Gfq7tUUUDBwG7wRpjNi+DmtNXrWiJlDsOaw0/D8lV3w7VORTtTzLBi6Z8Skw2sox4NiqW6IXkvmVJE56QmcKlQSc3fV6quv+sDQ79hjby7mTDdesFTsO3IFLCJBbIFE4RNDC/NV/G2Eh4ax0qNsKK455vqwbCwKMHEtBRfjIrpx2NE/NlZpAqYDJnu8R5HwWyTDWJc9YAYhu6nMtQ/e3OmmqNcTvs2bvhUgwSzPYsyDRISN/Cc5i+y+f4SrGGz50n9AvS2P7HxLqVSuo2uG8rzFbvT2TwV1QjBw9XhYBjj5NdFrkpwjjCRT440JgQxv++L8rR8vzxgbxCF8MQiKK4WAtjykF7yyJ016jChO4tRbQeKUnlj8bLRfzbey9GjSVwyR21I/HVcC33HDMEYZQz8nwkt+aHZNnL3PkXnRQGL4lpXDQ9FuLmdxjq9v9qz3TW/WcSH8fkxuvZjDgQ53aZ66wOU9Zeg0h/e93nQIx75990NdywUtVbnnz6/QRMNeAJtUtTqlyiQW2jkcZc4W+Yhb4b/P6gxz0o6KJ9aoC61D7gn6R0jLQshfyfCBHrURJVFg4zOLYXEs7wr9yRsqiMzS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(83380400001)(8676002)(316002)(44832011)(4326008)(64756008)(53546011)(6506007)(36756003)(76116006)(66476007)(66556008)(66946007)(66446008)(2906002)(33656002)(86362001)(38100700002)(38070700005)(8936002)(122000001)(5660300002)(6486002)(508600001)(54906003)(6512007)(71200400001)(6916009)(2616005)(186003)(26005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czZvU1hwb0xqQlhST3NveHA2UnhNc0p2OVl6REhQREU1MGFoMEhUbzdiUzVq?=
 =?utf-8?B?MTU3RlFrektQMVo5NzJSVUR1dHI0dmluaFB1cUpqQm9XeUpYMVQ3ellSQmU4?=
 =?utf-8?B?N1ZvYTE5ZFc2MjltQkJsYjhRRWFmeHhTQWcrU3V4M0paZ2JXdWJGdmhjaGFr?=
 =?utf-8?B?Ky8yQklReEcreWowalNMemNiYXdOejFnb0JzYnZ2QWQ2ZXhzVjlaQitGWHdL?=
 =?utf-8?B?K0pjM0NOS3NLMEhXT1ppdmlzQWVyYTdGL2o3TzJzME5qSDdLQmpuVGx4WndW?=
 =?utf-8?B?YjZ3ejVJWVBuMHRUZlh1bFQ2bDdSd3BtUjBxSVZ0eDJmMjNCdXRPc0o2blNO?=
 =?utf-8?B?LzNzWEVSRnpNY0h5aldhWUx3alg2VENVcWpFNGRnYnQwUnJzOHJrQXVmd044?=
 =?utf-8?B?eTZndFhHbEhOZ2diTWNhUVdvNy9LMDBTUE11UnMwMXQwRit2SWNaT1ZYTGgr?=
 =?utf-8?B?aU9iOGdUQjNJTFlsb1ZQSzJQd0U4TTZXVXY3bnVzcU9ZcG04NkxGNkFubkRG?=
 =?utf-8?B?bVBGdG9nbEYvWGIzVCt0clRrb3dLN0sybENRdkpSYnh6SXlRcEJtQjV6Y0Rn?=
 =?utf-8?B?cFZSSHNURWZhaFBIbVRHVE5VYi84M2p2NzM4M1ZxNDA3YUFRQWYrTlNKeXJi?=
 =?utf-8?B?Vzh1dWtHY2l1Kyt6OG9DbmVwUkFvK0lwUEN5bjNGWEFMRVZvYVpaZHQzU01P?=
 =?utf-8?B?c29zakRrS3pteHhRKzVjY29OOXJSTytyV3hwTHlHMHMzOS8rN2lDbzU3blIv?=
 =?utf-8?B?VnZnWXB4dG8vK28vLy9SdkhCTzNZM3N1SlAzbVZqeG5aQUxFbkc5cXJ3T1hT?=
 =?utf-8?B?U1NITFFXcmpIUmRFUFMvL0ZodzNEN09WQTZUTFVNUit1V0NMQTA0cGJ6Zm1u?=
 =?utf-8?B?cmw0WnlzMHZveXpsVjZmYW5uSEF5ZGJiRkFyZ1BSVG8zTm5mZVE4RlZQY0FE?=
 =?utf-8?B?ZEVjY2daUUcweDNTWE12RDFIcU9teHhTTlhTR3Z2U2ZaejQxWEwvSWhZQ0Uv?=
 =?utf-8?B?UzVCTTliNlZtTFdGdDdrcHQ4c2w5TXhZNHdDWU5xaEhJV0t0RHpqdHNxL1h1?=
 =?utf-8?B?UHk4K3pYZ3p5aUQ3MUIvQU8wblNxN0kyQnZCSnp0clNyQWZldVdMTCs1QjRU?=
 =?utf-8?B?eGdPc29pQW5yWHkxNCtzQXZrRnVlcERFOGFTbjRVQzN3ZWlnVk1nNkt5NkxT?=
 =?utf-8?B?RXlHV0FzNUI1RnlFVWVDNzBkbkcwTGIvN3FEODZPcTB5WkVKNFFuZ1NDSDRW?=
 =?utf-8?B?OGxsaGUrRitZNVpOL2NjRUZHOG5qTnNSRGo2bHJHdEMvTlcrN0hwUzVMS0hD?=
 =?utf-8?B?cXo5bjFRc2pZYzNaT3hGSk9VUWtMU05hVlU2WCtzam5FdDZmckJLMGVJNGo0?=
 =?utf-8?B?dysyVzY2VU5mQ0V3RUVTQVl1emlQMEN5WHFyRjZ3blQ1SDRQeDdiVTBlblhq?=
 =?utf-8?B?RnNGN2hNNXYrSFQ5dGdmejNCTis1aE1Xb0R0ZUZJTW9GejhEZnE3QkhBeHly?=
 =?utf-8?B?Nk9Fay9GRVV1MUFVcVBZaUJaUWpKODhENTRWdXpjZ3FZQTgvdXkxNkZpaytl?=
 =?utf-8?B?cmNEMW9KR1JTMlJwb01rRDBDQnFCQ0hlVncwTmNtcEtUMkxDcGVMY2VmZlFm?=
 =?utf-8?B?QURQNUhWc1E0dlV0bmhzNFpseG42ZENOc1ZNVE9TejBJcDNmK1k4b2J5RjBq?=
 =?utf-8?B?aGRUUTVnSXhHKzhUOUFONHFVVmczUjJ1RWF0SncrRzhyK3VEcUdjek5Zbkpk?=
 =?utf-8?B?aFFWRUF0NnpGOVM1Qmd6NG5FMlBVZjJPTmZYMjBHaUJzcUhta0R2SWFFQ2RP?=
 =?utf-8?B?ZUF2R3BuZTVObzRrSDROVm45YWhtRWw0QUdjYW4weXYvME5Gd0kvNjVKREsx?=
 =?utf-8?B?M21haU1zWks2eHFGeG5lR2ZsQ3FWSkFZYlVsNGs4b2h5VGpmL29mcVZBd3h1?=
 =?utf-8?B?ZkFpdlRoVGMxS1RsSkpvdFNmQmF3ZUNIbmIwYjdTcC9pdjhXOUtKMkpyekFw?=
 =?utf-8?B?OXFad2dINDhGbDBFbVR2aWdHZ1B4UWlFR0k3VCtUZCsreVkvNGhLYy91VXhO?=
 =?utf-8?B?QUIwUnpmcVFkSWl0ajU4STk1SmE3ZzlKOEJoYWRkY3FiMWw2bU9mK2FnMXJZ?=
 =?utf-8?B?TjhGVXZxUFJIMktlTmhIMXBhcjdRQ3d4TStwQzdOZis2Qi8xQnN6VlpHWSs1?=
 =?utf-8?B?dEJPZWkzc2tPdVJScnRUWTA4WEFCNE1Vb0w4b3F5eTJtc013YmtvSWJld21B?=
 =?utf-8?B?Z1dzUStPN25LWVJ2Sy8vY1E3V2RIc0lmajhHVmliRnBjbzA3eENlUGJTdW9Z?=
 =?utf-8?B?dnJycU1PMVhBVk1IVmhNNm9QQXlRSDlXaUZnQ1VBMnMxMEppdEFidFdsUlhI?=
 =?utf-8?Q?DcaS/MDqxotMapgg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F804DB670F2A584C9FE502C8A9F3E86F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3945c751-987b-43ec-6c3d-08da197c3fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 16:24:26.4098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2V4DQezERPdfIQoF9zXZbnjPDXSDCcqo6OOEVXU+z60EgmY62vO10OO+90f+ctGLJvn3i/6gZB/ZXwAlHkjsnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5129
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.858
 definitions=2022-04-08_05:2022-04-08,
 2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204080082
X-Proofpoint-ORIG-GUID: 0_BZ6eqhQXaBEhvCg_6O4ObCbbqpEBrg
X-Proofpoint-GUID: 0_BZ6eqhQXaBEhvCg_6O4ObCbbqpEBrg
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220408_092447_785562_A4D4C88D 
X-CRM114-Status: GOOD (  20.22  )
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

DQoNCj4gT24gQXByIDcsIDIwMjIsIGF0IDc6MTMgUE0sIENoYWl0YW55YSBLdWxrYXJuaSA8Y2hh
aXRhbnlha0BudmlkaWEuY29tPiB3cm90ZToNCj4gDQo+IA0KPj4+IG52bWUgKG52bWUtNS4xOCkg
IyBnaXQgZGlmZg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+PiBpbmRleCBmMjA0YzZmNzhiNWIuLmExZWEyZjcz
NmQ0MiAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+PiArKysg
Yi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+PiBAQCAtMzcwLDcgKzM3MCw3IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBudm1lX2VuZF9yZXEoc3RydWN0IHJlcXVlc3QgKnJlcSkNCj4+PiAgew0K
Pj4+ICAgICAgICAgYmxrX3N0YXR1c190IHN0YXR1cyA9IG52bWVfZXJyb3Jfc3RhdHVzKG52bWVf
cmVxKHJlcSktPnN0YXR1cyk7DQo+Pj4gDQo+Pj4gLSAgICAgICBpZiAodW5saWtlbHkobnZtZV9y
ZXEocmVxKS0+c3RhdHVzICE9IE5WTUVfU0NfU1VDQ0VTUykpDQo+Pj4gKyAgICAgICBpZiAodW5s
aWtlbHkobnZtZV9yZXEocmVxKS0+c3RhdHVzICYmICEocmVxLT5ycV9mbGFncyAmIFJRRl9RVUlF
VCkpKQ0KPj4+ICAgICAgICAgICAgICAgICBudm1lX2xvZ19lcnJvcihyZXEpOw0KPj4+ICAgICAg
ICAgbnZtZV9lbmRfcmVxX3pvbmVkKHJlcSk7DQo+Pj4gICAgICAgICBudm1lX3RyYWNlX2Jpb19j
b21wbGV0ZShyZXEpOw0KPj4+IEBAIC0xMDg2LDkgKzEwODYsMTEgQEAgaW50IF9fbnZtZV9zdWJt
aXRfc3luY19jbWQoc3RydWN0IHJlcXVlc3RfcXVldWUNCj4+PiAqcSwgc3RydWN0IG52bWVfY29t
bWFuZCAqY21kLA0KPj4+ICAgICAgICAgZWxzZQ0KPj4+ICAgICAgICAgICAgICAgICByZXEgPSBi
bGtfbXFfYWxsb2NfcmVxdWVzdF9oY3R4KHEsIG52bWVfcmVxX29wKGNtZCksIGZsYWdzLA0KPj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFpZCA/IHFp
ZCAtIDEgOiAwKTsNCj4+PiAtDQo+Pj4gICAgICAgICBpZiAoSVNfRVJSKHJlcSkpDQo+Pj4gICAg
ICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHJlcSk7DQo+Pj4gKw0KPj4+ICsgICAgICAgcmVx
LT5ycV9mbGFncyB8PSBSUUZfUVVJRVQ7DQo+Pj4gKw0KPj4+ICAgICAgICAgbnZtZV9pbml0X3Jl
cXVlc3QocmVxLCBjbWQpOw0KPj4+IA0KPj4+ICAgICAgICAgaWYgKHRpbWVvdXQpDQo+Pj4gDQo+
Pj4gDQo+Pj4gaWYgbm90IHRoZW4gSSdsbCBrZWVwIGRpZ2dpbmcuLg0KPj4+IA0KPj4+IC1jaw0K
Pj4gDQo+PiBJIGp1c3QgdHJpZWQgdGhlIHBhdGNoIG9uIG15IGNvbmZpZywgaXQgcHJvcGVybHkg
c3VwcHJlc3NlcyB0aGUgYm9vdHVwIG1lc3NhZ2UsIGJ1dCBpdCBhbHNvIHN1cHJlc3NlcyBtZXNz
YWdlcyBmcm9tICJudm1lIGFkbWluLXBhc3N0aHJ14oCdLg0KPj4gDQo+PiBBbGFuDQo+PiANCj4g
DQo+IENhbiB5b3UgcGxlYXNlIHNoYXJlIGEgY29tbWFuZCBsaW5lIGZvciAibnZtZSBhZG1pbi1w
YXNzdGhydSINCj4gd2hlcmUgdGhpcyBwYXRjaCBzdXByZXNzZXMgbWVzc2FnZXMgPw0KDQpJIGhh
dmUgdGhlIE5WTUUgRmF1bHQgSW5qZWN0b3IgY29uZmlndXJlZDoNCg0KZWNobyAweDI4NiA+IC9z
eXMva2VybmVsL2RlYnVnLyR7Y3RybF9kZXZ9L2ZhdWx0X2luamVjdC9zdGF0dXMNCmVjaG8gMTAw
MCA+IC9zeXMva2VybmVsL2RlYnVnLyR7Y3RybF9kZXZ9L2ZhdWx0X2luamVjdC90aW1lcw0KZWNo
byAxMDAgPiAvc3lzL2tlcm5lbC9kZWJ1Zy8ke2N0cmxfZGV2fS9mYXVsdF9pbmplY3QvcHJvYmFi
aWxpdHkNCg0KbnZtZSBhZG1pbi1wYXNzdGhydSAvZGV2LyR7Y3RybF9kZXZ9IC0tb3Bjb2RlPTA2
IC0tZGF0YS1sZW49NDA5NiAtLWNkdzEwPTEgLXINCg0KZWNobyAwID4gIC9zeXMva2VybmVsL2Rl
YnVnLyR7Y3RybF9kZXZ9L2ZhdWx0X2luamVjdC9wcm9iYWJpbGl0eQ0KDQo+IA0KPiAtY2sNCj4g
DQo+IA0KDQo=

