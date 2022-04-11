Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43EAC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 21:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F7miayKm/x6Rw8uaXFeqcC0ze7WCDU9CkMLqYOif6gQ=; b=CSTeXOToF8ET6KIVcNKDtn0SRw
	Dj5GIlQsXNgT44mI/AI7GXpyujwhEbb67HbQC4q3CgrSAJZBxNVGOPhBt8lsS34FMXJpklzUXlwRV
	Vv+O6l2bDykmnKknk2W5TXtf3fQ+SIU6cuw/F7xQcYUwM8DzB1I47LB2F7YRS/3Iy0iZ6lChZsJIB
	QPX9O+7t6hE7FLSK+PIOeVS95uRcmcP08PYraw24TUVoVzV5MucHY5CWpBukF9YGS+oOFp2DrRPev
	amr67tiRm42U9XzT0m0+38NNkktTXsOd0x8oie7k/z0qfA81Rfz5zYOtKLFpG44hj0oBXXg217u//
	eT0REfiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ne1ku-00AZ1v-6A; Mon, 11 Apr 2022 21:39:28 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne1kq-00AZ1K-Jd
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 21:39:26 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BK14pO018804; 
 Mon, 11 Apr 2022 21:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=F7miayKm/x6Rw8uaXFeqcC0ze7WCDU9CkMLqYOif6gQ=;
 b=lTpS3rcq3fxfDtKaLX5dt6uI4NtoSRuJjObbcRrL3x7drQ3dI/5vHzJm3IaeaJk6vaUG
 7dJgDszbFj/1+t40rgk4kiNg+0TbMMgqmqsLK8e0SJR9fLo0iG3LbSdx8vUlyrhK0zif
 RawS14uW2T/BsyEBYoQCaeyuvWxg2YcxdB0CMqCVhthj2TFf1MNWcVONBAl93d9Ep7Vo
 9ulHna1z6qzoUmpPQeY8PWNEuxlTBtkJWIO0kTfX7VbpR50JLleA6pBj7SMEG2U5Nwn3
 Urw1OUq7CLBk3v8hqMC22p+iSFt5+iOk60VZEcrOEXBHx+oC4p1/DJtrvjFAkPV3XDxA vA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1d36n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Apr 2022 21:39:15 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 23BLbMKX010041; Mon, 11 Apr 2022 21:39:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3fb0k24d70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Apr 2022 21:39:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEWcvMv8Fc5ywbuq+BQ65lmtMjYEMmIp3KCYnTYMIy2cfPcgB3ZAXX2O7hCvAmsfBuZyIRWAxw1XKUgvYSSDsZChAcmym2Ev5ocBW03UhRsMAZlfTzS+3+QYoEdd9YxM02KOU7RoYkL3tePe+0CgN9iUlyOUwqwtCxUWKmP8CmYxXOW38pmEK9EhVzShgfDdhfaJodR32XPiKuKpnmv7p4IhSmUxf/RklSPBAnH5fl2ITBwCJiUnuyvyEZvmJp6pb7ueGcAWzG6Ccqr39hG7i/LZFG8hm1U/nRY/X2dOeLSAFW9Rh8CV5TPUQ1SedPrTCygmFL4sEP+9VAO1z7lX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7miayKm/x6Rw8uaXFeqcC0ze7WCDU9CkMLqYOif6gQ=;
 b=jx3XvIeDo/k11sGptZ818YuipVPQtxuaKdtnPb6cngQon9kKVVj6sZwZoPf2O/IdEPPZMMHwRw4oqSI8WGEk82guxg9V7xKcMPrO1ZnFhyn32fIZ93SXYbk2kgU5Qk6l2VDpzXP1UjiOOhrJYLMA+bfx4lOlHXMD9OTxnHaLqNoXf7c6cDZytmDnoROXaJ9Wc+uiP+a7WBzib4PZ+RReQz4FSCrTo+ayGW2ce6Xt3mCq2bZS38lGvERao51+CUyOSwZQQnZM+TQ1G5wzyDToVM3O6vajrRxBQdDQMP+DlSsAGfPSsjNzgRG4Y4Gcm4NpJVM4Z50/1s93TE6z4xRmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7miayKm/x6Rw8uaXFeqcC0ze7WCDU9CkMLqYOif6gQ=;
 b=Mp5DqSCQFacYEhTakrtzWgJ5q3eGp1gxer7R3B2Otj/Wodte3/BtMPqF5aqBz2o2UFJsCn+kJsJKjVAaWmUdWei3vRcymD0jqfLDLyJHViuLPqaLOd6iH2K21FBLJWwdYaWm0nm0cQg0oNvnGLRQ8EaAqwRIm88T5cs3Zn4EpyY=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DS7PR10MB5343.namprd10.prod.outlook.com (2603:10b6:5:3b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 21:39:09 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff%8]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 21:39:09 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Topic: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Index: AQHYSdUqFpKGiT1CSkmELkSF7x4OoazjGb6AgAAClgCAAAWlAIAAT2KAgAC0P4CAADK+AIAAiyIAgAAGzACAAAbzAIAAA96AgABTmgCAAO3dgIAAghoAgARYgwCAABa2gIAAHZoA
Date: Mon, 11 Apr 2022 21:39:09 +0000
Message-ID: <C73046B2-A353-4C3F-9145-3D964CD2E9E9@oracle.com>
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
 <884816D4-96AC-4489-859E-2C52972D7FBE@oracle.com>
 <8b21d015-73ea-6b47-d54d-7fdeaa12bc60@nvidia.com>
 <E3D31C43-E685-4FD0-9750-167B67C5F72A@oracle.com>
 <b704f75b-31ea-a699-8d7c-458113e6585e@nvidia.com>
In-Reply-To: <b704f75b-31ea-a699-8d7c-458113e6585e@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ebfda82-9735-4fca-83a4-08da1c03b65d
x-ms-traffictypediagnostic: DS7PR10MB5343:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5343672A79A5E0A370963445F4EA9@DS7PR10MB5343.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q1o3l7blEAil43uxVkPt/AAWUcw6IxtLRr9RY2sdwfcKiOC/a1R+89Dihv3ly0QUmR02WGRYfIItgpQEsW6dgBMNoKzRP57QFkvcX6hgd8Vw2UoNnKwbCRkeRwXpJd7IelKRzkKY4uDYmX+tPGvH3d9TPzSc+8gsezmOrgzomJbsFZjvmnj4f9dAkHQxYDii9JvZDxJ0tfWTRAeSKPU2c4U4Xm5UF6Gljh/KfjUAnAuohxx4P5QuCi0fmUJCXmvJBJNJW9FJsYoOVZLWetkN2aTOR0A+tv+JMOqo7R/gX155A9zaCbcnxFht019Zy4W7wBjF64lqvTEn3MXjV3awnQ4o3ABBbxawElOhHfvjS/v6G+gwYSJq2ncZLcVcZHpsENfIBdACQ9YWILukreq0rj7IGWsP4LKCrgu7iCujFd9aCo7Mthft46Jso3TcBn4PTXjxBPsKjwlOLNXdt8/r3nQz/hsFALW9gQCi9MvLG8SvErSJAWtlD4x4DjHDKoTxPKM1T8DBwsly2x6HUiJ/xQ8xboOBv4OIMvHIoNL1CkXnTr0RkorQCGL4u/X4KsupQg03g75QEY4hg9GkeCmWEWsKOm3RzxF7y/aGG57NVJoOQ0BlbU2mnZE3p69+RqRxLkggeaAjvRfwDHYId5jpFHzE8bpwO2NK8hGSHTE+jLWQCCs7PA11vXZyOI9RTxiMDZAbdPat8jgjitJzP5zWw5S7UzJgiUH7dRGT512eIVSQ4vD/fFhbfDZJwOT2HgsX7CABckR8HgvfaZBEUhwC08hnhliuh34pfmjSuEatx7Mn5VGzeKQ6hgKaBYKmuBVFhHqtjnOlBOaUI/cbpbz2Og==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(508600001)(71200400001)(36756003)(44832011)(186003)(966005)(6486002)(2616005)(4744005)(83380400001)(66946007)(4326008)(64756008)(8676002)(66446008)(91956017)(66556008)(76116006)(54906003)(38100700002)(6916009)(33656002)(8936002)(86362001)(5660300002)(66476007)(38070700005)(316002)(6512007)(53546011)(6506007)(2906002)(122000001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkxiaGUwZ0xOSEJZdXIvdDlDWFRrQ1E3UzkySEE2QS9mUUliYnE0b1gvVTBY?=
 =?utf-8?B?RHY1a0wybk5XTlFWRHVjeFQvV3FVcnZYVDUxVHc4NWlsdVhyb1BVZmRhbWxN?=
 =?utf-8?B?YS96SWJBeXZvTHFMdGFPaTVuWHZmWWVHR1YyY3lhbE1ZNmZESnh0b0xRUDRX?=
 =?utf-8?B?OEQwdFFxZWdNU0NMb3VUSm5lNTNBcjRwRTdZald5bll2ZWhhK1RCSEJNbWhF?=
 =?utf-8?B?S1c0MjdYUjd0aW1DRmFnN2lqMkhLN01DT0tqb2R4VE9mZGo5QVYzM3RnbnN3?=
 =?utf-8?B?MkJHcUNQOXUyK3E5MGtRaXJNczExWjQ0TGhxSkJLc0ozTUl0VXk4N0I1bzdr?=
 =?utf-8?B?d05iT0NtRFBTNXpqMXRYZ1NDWDVjbXNPaTZBaTJCb3BFWW1xTTdUZW96Q2NR?=
 =?utf-8?B?VCtCWUUxRWtKZnVDVmVqMFVDNTJjR3Fjbis3RmZ4cXcvZ1BVWTh2QWRJSnBy?=
 =?utf-8?B?ZzlqMXBBc3N5WEZqSGxxMXpmdXNpYlZsV1pGYTFRb3Jxd05mT2hwMGxQa1VU?=
 =?utf-8?B?TjdUdUYrdkkrdkM1TEhyNElTTklHbjNDVmh5UGZPVmYyUlNaNUY5bzhBZEpS?=
 =?utf-8?B?SVBuaGpFOVZkYXR0TENyWVNpdllNakRaUERtaTQrNUF1MzNPcjdqR0NRYlBU?=
 =?utf-8?B?N0lCOFN0VTJaVDgwOHlWZEVuYkZFamFmbjIramI1LzFHLzFVa1M3dzB4Zjky?=
 =?utf-8?B?dkNoYzhDbnVmbktReUd3ak1IT29CdHhiL1IyZmxJa28zeVB4SUsrUWlaWndQ?=
 =?utf-8?B?eTBkcEVQcGQxTmVpanBnOEZ0R3F6ZnFRK2E4TlI0ZTdNRDVidUczVzdIVy9l?=
 =?utf-8?B?VGowUFpoTUJkKzVyQnkwQTlQVDlUS3pwallFRVg3NUJ0YXlQVGR4MlFIV1Av?=
 =?utf-8?B?ejB2V3BpNk5OSGVkSlhFbW83QXBoamRyVGdwUU1PTjZJcnp5d1oybnZEODRF?=
 =?utf-8?B?K1NmbUFIS0U5azAyR2tlcWQwcHNFdzk4eTNFUXpCTFMzQ1JEMnN3TUdCd29w?=
 =?utf-8?B?alRGRlJYWXU3OVY4WCtLQzdyTVNuWmJZR0QydEpqZjB0cG9md2xFU2prMzl2?=
 =?utf-8?B?Z0F5cE9SZFJTbVVYWnd0VlhtdkFSWjYrNENhUGVrZ2VVVkFvQ21rVkt5QVVJ?=
 =?utf-8?B?SEdIanJtd3psVmx5RklGS0NMblpmN0w0MTJEM3Z5QjFCQ3FGU04wZlFYMDFz?=
 =?utf-8?B?b0Y1alZTV2NtU2FiS01kZWdOVEh2TGZTc0FmRUI1MWVIcVVUYVU4azF3VVBw?=
 =?utf-8?B?Z3JZS1lHNkpndEtSQi9rOUF1TXVsbkNtKzYxdFdXY01XTXZkaG9tRk1yK0RF?=
 =?utf-8?B?ZGRtdko0aWlvcW5kTEVhMUJnU2JmY0ZkYUdzemVMbUZOTXljUTdJa0FvaS8z?=
 =?utf-8?B?RFdueTBCRk4ydXVleE54ampVV2FUQXF6MnBqdmQrSFk5bUNxWjdTY1g2WHF6?=
 =?utf-8?B?S1V0ZURuNmpqblhXc3J0SlNRZnZNWEl3VnJhL05CRTRONDczM3MyQWNXVFV1?=
 =?utf-8?B?U3hzRkFzUitoODdPNTArWHJPL3FORlRkZWgvVm9QUFNpd2pRZlQrVCtCSmla?=
 =?utf-8?B?eVhqbTA0dC81V1AvaGRvVWI4b1RDL081WXRzWXdiYkxrRVMzRXV6RlEzOVk5?=
 =?utf-8?B?T1NTK0xEa2VFeWtyQmcrVjRBWEcremJiQldGVTJXL21wWG5Ra2hVQTJWMzRr?=
 =?utf-8?B?RHN0RFAzNHdyZGYrUG5hcDVWZzVaWm5qcnhpTUd3ODRVZTF5T3ZLa3dvZUFK?=
 =?utf-8?B?SElYcmF3M2FST2lZQmRpRUJVRm00a21pTkkvNnZ5NHRJbXFYQUxyUnZKaUs4?=
 =?utf-8?B?VW1rVjUvTHZCVTZGQlRaaGtyd0xTZytjN3Y5VVltWDVGOXEzVnFMN1RLVk5p?=
 =?utf-8?B?ZXlCZU5MUXBzaFlSNzdENEpUTWJaZUd0cjk4d2ZPTTY5ZjF3ZG4ycU5HMDhD?=
 =?utf-8?B?S05OZVJtOEROR0FhajNiNE9NS2YzWERhUmJCa05yc3AwV3JxYlZDYVkyallq?=
 =?utf-8?B?bDBYTWtmbnR6SlJNSG42TUVoVVNZYy9Eb0dVODBLTkdaTWlPcU5mdCtiNFFK?=
 =?utf-8?B?aVdsSzNiMTFlRHVmUisrZldJUjZsVkE4NmZBWjJNR25NNGJsRHMyNlNLelB4?=
 =?utf-8?B?cUI3Yys4ZUdiUG9hTGIwYmxRcEJTRkRpbHdqWlZvWEVhM0Rac3hFdDRzTFRW?=
 =?utf-8?B?QzVxcVN4OFRpUytiWmUrR05VWEx5bXZFM0lIa2ZaQUdIZStZOG1xb3hJTGJW?=
 =?utf-8?B?K0FyUUw0bm1vMmlJM2N4MjRJeVdJbDQ5UFFNZDFkUUhlZVhJdXZtWWlJaGlC?=
 =?utf-8?B?QUh5cCs0OFZBVlZCTnhIemRoTWI0SnZSMCt4NHlCZURhZ1NPaDFOWWh5RDlq?=
 =?utf-8?Q?IblsHnd4mdIZv6zg2QIH9zID+i3gxd7YSYuaZnH4esmlj?=
x-ms-exchange-antispam-messagedata-1: h7BbSgl3s4XuzQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AFD146FD0E5F340B226667755D2C120@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebfda82-9735-4fca-83a4-08da1c03b65d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 21:39:09.5314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJ65NYQCmGn3if7KAH7FnfdC46wM4T4mww8qXdSJJEWyAH/sbqEv0SsYJB6wk/+nL1NDnnCafqb+KYkBUU31Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5343
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.858
 definitions=2022-04-11_09:2022-04-11,
 2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110117
X-Proofpoint-GUID: ctiuWHMAsWGeX2o6491LpncTdoLQCh0V
X-Proofpoint-ORIG-GUID: ctiuWHMAsWGeX2o6491LpncTdoLQCh0V
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_143924_973670_4BF4BB71 
X-CRM114-Status: GOOD (  21.49  )
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

LSBWZXJpZmllZCB0aGUgZXJyb3IgbG9nIGlzIG5vIGxvbmdlciBiZWluZyBzZWVuIGF0IGJvb3Qg
dXAuDQotIFZlcmlmaWVkIGVycm9ycyBjYW4gc3RpbGwgYmUgbG9nZ2VkIHdoaWxlIHVzaW5nICdu
dm1lIGFkbWluLXBhc3N0aHJ14oCZLg0KDQpUZXN0ZWQtYnk6IEFsYW4gQWRhbXNvbiA8YWxhbi5h
ZGFtc29uQG9yYWNsZS5jb20+DQoNCj4gT24gQXByIDExLCAyMDIyLCBhdCAxMjo1MyBQTSwgQ2hh
aXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWFrQG52aWRpYS5jb20+IHdyb3RlOg0KPiANCj4gDQo+
Pj4gSSB3YXMgYWJsZSB0byBwcm9kdWNlIHNhbWUgYWRtaW4tcGFzc3RocnUgZXJyb3IgbWVzc2Fn
ZXMgd2l0aCBteSBwYXRjaC4NCj4+PiBTZWUgYmVsb3cgZGV0YWlsZWQgZXhlY3V0aW9uIHdpdGgg
dGhlIHNjcmlwdCBhbmQgdGhlIGxvZywgY2FuIHlvdSBwbGVhc2UNCj4+PiB0ZWxsIG1lIHdoYXQg
aXMgbWlzc2luZyA/DQo+PiANCj4+IEkgcmVhcHBsaWVkIHlvdXIgcGF0Y2ggYW5kIHJlcmFuIG15
IHRlc3QgYW5kIGFsbCBsb29rcyBnb29kLiAgSSBtdXN0IG9mIGFwcGxpZWQgdGhlDQo+PiBpbmNv
cnJlY3QgcGF0Y2ggbGFzdCB3ZWVrLg0KPj4gDQo+IA0KPiBUaGF0J3Mgd2hhdCBJIHRob3VnaHQs
IGl0IHdpbGwgYmUgZ3JlYXQgaWYgeW91IGNhbiBzZW5kIHRlc3RlZCBieSB0YWcNCj4gdGhpcyBz
byB3ZSBjYW4gc2VuZCBvdXQgbGF0ZXIgdGhpcyB3ZWVrIDotDQo+IA0KPiBodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbnZtZS8yMDIyLUFwcmlsLzAzMTM0OS5odG1s
DQo+IA0KPiANCj4+IEFsYW4NCj4+IA0KPj4gDQo+IA0KDQo=

