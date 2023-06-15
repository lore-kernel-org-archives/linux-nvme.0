Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF70EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:To:From:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uue+SgqYVus9DF9GwJeGAtfjtlTTGIKVhL831/yoD4k=; b=OOg9yGoPQ51W7PuIWs/dFJkT/G
	85OZ+mRIc3tJxZIr1cLFQkyzV0tD2wxWlK25+SLiq/FconM1X67880Of8nUH9gvAnYzf2BtJERaPb
	LFQp5WRTFt6FkFKJ+kFMBzAJCPagv/csWNAaSQwJlQORmtoQNu2NL2+TyRVxv+ylLuTpJu2ngqHY2
	4P5xl/rI6vBQR4oaKQ17Jk9ZrXH4tDenREmVVnuWWV7CDmGKAWJuiHlr02RCjbQoL2ZQY6N84GKWI
	eiDxJmIl+wf2Mnb5EIqZmv+ZP1rda6txYeSkZDw2mwpvGSNUyOSZIu5otA33118myrCXJareyhtph
	xzYdlCTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9q9l-00FU4O-0S;
	Thu, 15 Jun 2023 16:49:09 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9q9i-00FU3m-21
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 16:49:08 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJhZP021039;
	Thu, 15 Jun 2023 16:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Uue+SgqYVus9DF9GwJeGAtfjtlTTGIKVhL831/yoD4k=;
 b=ags4m/B5OC+Daf9/75E4ZM/0Y1b/ufytQEkg0Jhh5LcG+92fpWaKi1/YqddZb/4xuKRc
 SaOT46DMIdDohBZ+EcowZx5qohh/TYQrcAWL5WVtBqu0CujKtwRTi3wbSYe7fMfsC1xZ
 XpJ+n6P3Df9ChRqim0TczC64nrOYKAAGsh39lYdpZOAyi8I0b/AcxV1baS3PLHv2JVef
 OAtJUUOOX/QBYQ+JVAbCdIQQnfHadfATkwkYfawnNiHKCDAnXqQlmOmZmZdXDJ766SrC
 e/1P3Msc1smh3Mkk3Db2FdNVIzmBsHaV/B+Biu1dTBic+EWSPZrGOgPzJOnudf6/cDa4 eQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hquthg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jun 2023 16:49:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGVli6038988;
	Thu, 15 Jun 2023 16:48:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6ww8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jun 2023 16:48:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDM9eQIkQbknxzoVfiozjjru2B4Bgdi0Rt6djkEu8x4UalF+roVQsKdAz9V0hQmtkq+UDp7x2aKJBb1pni8LlgPw2yVgSlue/K9G/lturHGZW4Cx6QEP8ECof+APh2ezMCRVsMJTbyiqNWwJG4vigGBXGZ0+35uRE8MWyhqIjuP7XDSCUw2TuDUvhdSJAFe6jGdCQe1Y3alDksnvHB6bPnSKRy19crOQwEX9pVkXrv3DULVQ+TST5IdeewlKYCIN6Wc4g0Lv9wdjCJeyeyFUt82Ao5R4tlzbdX5vsKfiHxPgHGVvnqdyAWmt6ZZUdDvsVAFqwc1624F4vGr5DnVeEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uue+SgqYVus9DF9GwJeGAtfjtlTTGIKVhL831/yoD4k=;
 b=mJUIfS6ZbL2UHIT/TLhy6wVgVn3nAfgtkRHRWiribp37Bt/HCwrpVOq8hC24qjWbGKrzkI2Kne/0ffcMqNzCfe59OqeEiKkOKB+/MTIkbuNhzguucj58JUw7hL90Dd0Rlr3BH3d+Nbdxuy6mCX/sn5LSPi3icTj5+mL/GWWqeA6+1HI7xkMB7YbgtmgNXn6c6/4QBVwI5YoCyg/D+iU0gfMbvC56ZMDggZ33X8GRQMSOd5iFr6jNBRwUDPlhJEkYSMC3szbx07c+2c8DsIv1t33mlb+P/zi26ePiYqZONjEtnmIrhFuh1Lr3VheduQNbJUZ7IckrJ8I1Z47NnzykOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uue+SgqYVus9DF9GwJeGAtfjtlTTGIKVhL831/yoD4k=;
 b=puOtPvV1QeVIdpxFBRpjjgdmPx7vLnRLNMLVMIZ42AzBSBgcx3TTuFuTsTPTOogEB8ow10slDh0q2ugnmTIWcOph/KTfyhYC86773hKuMPOHIYOqCfjHarVVGMN91YfVDl1DJqwJIhoXUqDxAPX4lYft1mwTbxz0WYWNqYvRwRI=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SA1PR10MB6614.namprd10.prod.outlook.com (2603:10b6:806:2b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 16:48:57 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::be4a:517e:48e7:e46f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::be4a:517e:48e7:e46f%2]) with mapi id 15.20.6477.028; Thu, 15 Jun 2023
 16:48:56 +0000
Message-ID: <0b5a3179-e553-633d-6edc-bdda9963a976@oracle.com>
Date: Thu, 15 Jun 2023 09:48:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH V5 1/1] nvme: allow passthru cmd error logging
From: alan.adamson@oracle.com
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20230409212538.18647-1-kch@nvidia.com>
 <20230409212538.18647-2-kch@nvidia.com>
 <e35b59a8-73bd-46de-0c99-7f6b6db1294d@oracle.com>
Content-Language: en-US
In-Reply-To: <e35b59a8-73bd-46de-0c99-7f6b6db1294d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:a03:255::11) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|SA1PR10MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: e483694b-2662-4f2a-7263-08db6dc068e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dd/aTv7nsD51NzB7Lx9SOi3LGuxjaoIUMtMenMfvhTHUwUnlLAMruS4huvZgvfDGA/cbczl+BqjhFZSZVYLqR3rWCMGwB308355YQhE/k4XCroqm22sx6AcGLwSo3b8j8fTrJbYNxU0D1ofVpae6H0DQZwdMOEsP03mb7o5KYpJ7D2LK63pXm9a8klS9BW2nxKmxFE9OyWzImYaXtJW9ozGW7mTxbQ5+hbdf3PWzZ3/Z54S7WbY7OCu79qH6JvBAKPzNNfLQV+EiUT6qO0ky/eopgN10whyrjSapZ7RwRWJKKEO3/Dgkp2wFpzvvvzdu5hctwogmbwK/nt28dMr93WZ39i7XIgyWCvgfc3yJzTUE5gB0Voqq/7j3LWjV/o0Sk5h8yJrIzmYtq6oQQhy8MqmuDM9bLuvGraZeCyz5aSF0nouGGJDDOGEG8H6DuM5V4eBSh8kBTt2xfjKtXb53hJvxjcPXjFGdQEK4QKtydPQ77+ATZIGZFEPlpZEbWt8adtAXxJcwKKWNmTA6LFy1pKtWaSyNM21MMBrCD4zWx3VYhiY+QNq1GNZUNBnMjqixViIJfgFek3y1SyACJBk7LB2oBF48mweLNDeryg7yA1JLbUoyjGRT1K69gu3qT+VA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(478600001)(2906002)(36756003)(110136005)(8936002)(6666004)(8676002)(5660300002)(38100700002)(66946007)(66476007)(66556008)(316002)(41300700001)(31696002)(53546011)(6506007)(26005)(6512007)(9686003)(86362001)(186003)(2616005)(31686004)(83380400001)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEx1K3VKd1pUQkZtdUo0U0J0eVBIcjd1RzVKeitPWityeENEakNJeGYvalNP?=
 =?utf-8?B?QW1pMnJScVFmcnIyZkVzUDdMbWN2dVdRc1ovM0NRVVo3TkpPT0VZcE92WkNR?=
 =?utf-8?B?cUhxSEptVEVuL1VubmxLYlNwOG5rT0ZsbWM0UENBREIzY3U2clN5UlY3Y2Nk?=
 =?utf-8?B?TkxMbFNmR2NjR29YbWJxUWp5ZEptK3Q2T21kTEY2aGJNcUR2YXdtbE02L2lN?=
 =?utf-8?B?WDhFL0s0c1NJL1JndmdlNGM1bERPcU1zbkNwNk4yRWFoV3NRbU9jQUxvTGdi?=
 =?utf-8?B?TktyM1o4YUptOWFOVWJYNW0rd01acS9pM2NleVoxSitkTHNMV1Z2UFRIWVpC?=
 =?utf-8?B?WXZPN2xSNGV1L05mcGljcitlTHMxekpYR1BwM3VBNERtV2pYVTZnMDhBSUNj?=
 =?utf-8?B?QytCTFZuRUcrNTFmNE0vYkFwUnFhSGQ4eXlETjN0ZEdsY1pLbTdjSkdEaWVl?=
 =?utf-8?B?aGxpQ205M2xOdE9CaytmbTFoKyt1YUd5cS9Bd0d5cEhlQnVIS2Z6VFY3MjVE?=
 =?utf-8?B?Z2JnN2xQVytVYmhRN1VMTmV2dVNlblp4UTJWalY0RHdXSW1CcWRxQzBMTFhj?=
 =?utf-8?B?TkxGdWZTMldoRUFWbUxzUjhObzdzMENaTWtWekNuWTVtRHZmV3BHYzMrNmtF?=
 =?utf-8?B?ckFhdlpWdjFtU21lNmNNd21PKzZkWCtOVHQzOVV3Q1djMWtaV29VWUZWTm9R?=
 =?utf-8?B?MXZldnBDcVArWHYvdWhFZFFJNnh3ejJTdDRRQTJzUUUwZ2FTb2dIV0Z1SVF3?=
 =?utf-8?B?bTRCWGR5eFV5My9MdmdRKzQrMTZjS2l6b0tybDh2bi9scmk0bVJPVlp5YVFB?=
 =?utf-8?B?cEVRWURqSUw0QjJYVmR4SjFTdTc1RnBzeUlUSkh1Q2dYNDVMWjQ5amZZaDdP?=
 =?utf-8?B?RVhwTHBzT2VvZHoxR2V6U2hFREEyTkd0L2ltYm1HUmJScXJoQmNNejNlMmU5?=
 =?utf-8?B?UWpQdElIMXF3QkQ0VHovRWQ0YVFvU3ErZ0hWSGRlbmVySlhIaHZ2SGxXS3pP?=
 =?utf-8?B?NmZ5b0QyUlVTa3R0czVIalNaMC9lY3B1Z2FnYy9QVUVFSitNTURkUU1tTVRL?=
 =?utf-8?B?YVJCSkxkQWgvRXdXVktxV0NTVExEQ1R0ZENVMTc4UG5mZDFJYm5IRGJ3ZHdv?=
 =?utf-8?B?dWhhTEIzdUZyWUx4NmFjcS9EL2RUWVE0TGhpYzhZTHkydmVQNitJVUlYL29w?=
 =?utf-8?B?R0c4SDFUVFdpQkhIR09TNGJEeFRCakE0N1FQVGcwdXNyb0VvNk5iVnMvcWw0?=
 =?utf-8?B?N0xYaG9icEE4Q2tHVmtuQ0Zua0QyK0RhRVVvdEtRUzVaVC92WE5UVGkycjNw?=
 =?utf-8?B?RGpSTHRHU1BsMkxleVpKV25UekFQbTlRdHh6Q3JCU0RCKyt3UXhqQmtlaHhQ?=
 =?utf-8?B?a3lhbDJCclA0bU5sem5IcGw0S054ZEhqcHdjOHh1UWE3Y1djTFp1VGttU05B?=
 =?utf-8?B?MTAyYTVHdDNvdGEzRENEZXpuMlZxWE5WWDJqUTZxTnJ0MU1ZNGpOY29IcC9C?=
 =?utf-8?B?N05adTFjMUhvVFVKRjFlNy8yRk5UdlpaUW9kL2JkL21DQlNSQ2NRWEdJWVd2?=
 =?utf-8?B?UHRVUjlyNGEybDI5Sm1IMWVWT3pKeTdnZENWRGdycmdHS2xGaFNQdndvSVZZ?=
 =?utf-8?B?c1N1eTFPSjE4U2JONGtqNDBBRmsreVlhMHJYWmxmOGtwTkMwMjZpNEM0QllI?=
 =?utf-8?B?MjVYUzA0a002c0hNbS9kZk1KZ0lWYlpCclV1QmdQVXYzZGJydk1USHIyc1VW?=
 =?utf-8?B?czIzUms0QnVNWHRvNTFZS1JUeUh0MEl0WUNEWlFWREw1SlE5N2ovZnlvS2ty?=
 =?utf-8?B?NmFUR0JhQUNsMzJrcVV5d2I1Tk9FdFFXdW1IMm1ETm5TRFcxMlc4UW82Njly?=
 =?utf-8?B?NVNHWEZYOUVBNlRJVFM2Q3VuclhCY05FM3VGSUZiNVU1MlZNWDdCYlRtL0E4?=
 =?utf-8?B?YSs5b29SMWRqYXZoc2ltSWZqQXdGZEhjdnlnbW1Eb1p1SFRrR3h4SFJ2eXVs?=
 =?utf-8?B?dmRVOTQySmxYZm9xdWZLWFVWVVFnbW5USjRGTThCLzdRcmYxeEN3WjhyUkY0?=
 =?utf-8?B?SUNHTUFyUXI0ZjN4UXFxTnZVRU54L0JDSW1SYUxrYkVQbm1YNDEzM2JmWlcr?=
 =?utf-8?Q?ButocSwSFT9OAZ4eNeyfkXsJS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5itscOnnzViBwErRrSkB629K/SRCeLPzj8sb/HYgSuQC4cXMr6F81Mx0ZWQ18eBhbBIuDBmwtEAcJ5IjR/hqsv7c70Af2xZ0+GMty4Ij74v4VWh+DEPz8V3ERMr43pYzNsuSB3wWHCaQSxAzX75dKvv/hA7Cw21qt4/RJFp9piDf4FC85zBII74ZowbWFVPf3RxVC2USFL/TLXiKIkSyPlqT1Y5L+XQw0V/I3z9NK0LEcFv3owXV8jsgJBfWHla7fwhOAVbI+vfzTMz55paIWASsGVb8hgvXWJOwwjAsHaqiJBbbm/wtuU//FVeKlxA8eCD89ufptVHKdL4xQVjqdseC2WcC8SEn71LIVGiAVZBHz1zSfeiFFaU2zEGR2kEctGrJth0l+TPH0HXOh/nl6gR80xoIIsBhTKJQ/TCIunTvh09bmYwoOsZfbhM7Y0oWlxfKjlKGKZEOmQk13idH5MA8BDsvstHbD3XDZlNqHifgygWvKQ3Jd/YwC+5UPy0S2VwRDYyEn2YctapOhHNT+pvWFEcNFWuYzUiif85CKPA9D9wFJIJFExeMcxC2Pl8DcpactXcD4Fj/nFgK6ukTesJ1k2Mrcd0T9LZu1vlCE6VC/Ru/2QKYEat7JUQJVVPuDn1ob551aSeiorbzr9nWXskTLCEJaWxqNn50xIpaMTgvAS1P00z9zqDVtrOPm6frcRtQSP3OSw+sjXE5OLRk2VzDlsCBLR2/ILno7fHQbJvHRto2ZlWme1HolegtGVsV8LpwrVMI8SxpyElzDexZJGUqx+LzdTblDbBrDA4YNIX8eG/VMvYXFmM/zEGOdBqJWRYqH3F/zpbqHqeQ6OAjAfrccX0kPITleRRwDea5Mow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e483694b-2662-4f2a-7263-08db6dc068e2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:48:56.5659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4r92SjPdCdb2w8HWcw4zGb6fPJ24jvZjbcnW6P0c0bvnuryVdOC1DNjCje4EV1Nax6V84VIPLfag7cBm917xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_13,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150147
X-Proofpoint-ORIG-GUID: bwxaaPnVCLap20hmXLB4HN4p92SIs-bV
X-Proofpoint-GUID: bwxaaPnVCLap20hmXLB4HN4p92SIs-bV
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_094906_678195_AA4FC93E 
X-CRM114-Status: GOOD (  21.63  )
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


On 5/22/23 3:58 PM, alan.adamson@oracle.com wrote:
>
> On 4/9/23 2:25 PM, Chaitanya Kulkarni wrote:
>> From: Alan Adamson <alan.adamson@oracle.com>
>>
>> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors")
>> disabled error logging for user passthrough commands.  This commit
>> adds the ability to opt-in to passthrough admin error logging. IO
>> commands initiated as passthrough will always be logged.
>>
>> The logging output for passthrough commands (Admin and IO) has been
>> changed to include CDWXX fields.
>>
>> nvme0n1: Read(0x2), LBA Out of Range (sct 0x0 / sc 0x80) DNR 
>> cdw10=0x0 cdw11=0x1
>>          cdw12=0x70000 cdw13=0x0 cdw14=0x0 cdw15=0x0
>>
>> Add a helper function nvme_log_err_passthru() which allows us to log
>> error for passthru commands by decoding cdw10-cdw15 values of nvme
>> command.
>>
>> Add a new sysfs attr passthru_err_log that allows user to conditionally
>> enable passthru command logging, by default it is disabled.
>>
>> To enable passthrough admin error logging:
>>          echo 1 > /sys/class/nvme/nvme0/passthru_err_log
>>
>> To disable passthrough admin error logging:
>>          echo 0 > /sys/class/nvme/nvme0/passthru_err_log
>>
>> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
>> [kch] fix sevaral nits and trim down code, details in cover-letter.
>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>> ---
>>   drivers/nvme/host/core.c | 83 +++++++++++++++++++++++++++++++++++++---
>>   drivers/nvme/host/nvme.h |  1 +
>>   2 files changed, 79 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 954641a45e55..e32265adc034 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -337,6 +337,30 @@ static void nvme_log_error(struct request *req)
>>                  nr->status & NVME_SC_DNR  ? "DNR "  : "");
>>   }
>>   +static void nvme_log_err_passthru(struct request *req)
>> +{
>> +    struct nvme_ns *ns = req->q->queuedata;
>> +    struct nvme_request *nr = nvme_req(req);
>> +
>> +    pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s"
>> +        "cdw10=0x%x cdw11=0x%x cdw12=0x%x cdw13=0x%x cdw14=0x%x 
>> cdw15=0x%x\n",
>> +        ns ? ns->disk->disk_name : dev_name(nr->ctrl->device),
>> +        ns ? nvme_get_opcode_str(nr->cmd->common.opcode) :
>> + nvme_get_admin_opcode_str(nr->cmd->common.opcode),
>> +        nr->cmd->common.opcode,
>> +        nvme_get_error_status_str(nr->status),
>> +        nr->status >> 8 & 7,    /* Status Code Type */
>> +        nr->status & 0xff,    /* Status Code */
>> +        nr->status & NVME_SC_MORE ? "MORE " : "",
>> +        nr->status & NVME_SC_DNR  ? "DNR "  : "",
>> +        nr->cmd->common.cdw10,
>> +        nr->cmd->common.cdw11,
>> +        nr->cmd->common.cdw12,
>> +        nr->cmd->common.cdw13,
>> +        nr->cmd->common.cdw14,
>> +        nr->cmd->common.cdw14);
>> +}
>> +
>>   enum nvme_disposition {
>>       COMPLETE,
>>       RETRY,
>> @@ -381,8 +405,12 @@ static inline void nvme_end_req(struct request 
>> *req)
>>   {
>>       blk_status_t status = nvme_error_status(nvme_req(req)->status);
>>   -    if (unlikely(nvme_req(req)->status && !(req->rq_flags & 
>> RQF_QUIET)))
>> -        nvme_log_error(req);
>> +    if (unlikely(nvme_req(req)->status && !(req->rq_flags & 
>> RQF_QUIET))) {
>> +        if (blk_rq_is_passthrough(req))
>> +            nvme_log_err_passthru(req);
>> +        else
>> +            nvme_log_error(req);
>> +    }
>>       nvme_end_req_zoned(req);
>>       nvme_trace_bio_complete(req);
>>       if (req->cmd_flags & REQ_NVME_MPATH)
>> @@ -666,10 +694,15 @@ static inline void 
>> nvme_clear_nvme_request(struct request *req)
>>   /* initialize a passthrough request */
>>   void nvme_init_request(struct request *req, struct nvme_command *cmd)
>>   {
>> +    struct nvme_request *nr = nvme_req(req);
>> +
>>       if (req->q->queuedata)
>>           req->timeout = NVME_IO_TIMEOUT;
>> -    else /* no queuedata implies admin queue */
>> +    else { /* no queuedata implies admin queue */
>>           req->timeout = NVME_ADMIN_TIMEOUT;
>> +        if (!nr->ctrl->passthru_log_err)
>> +            req->rq_flags |= RQF_QUIET;
>> +    }
>>         /* passthru commands should let the driver set the SGL flags */
>>       cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>> @@ -678,8 +711,8 @@ void nvme_init_request(struct request *req, 
>> struct nvme_command *cmd)
>>       if (req->mq_hctx->type == HCTX_TYPE_POLL)
>>           req->cmd_flags |= REQ_POLLED;
>>       nvme_clear_nvme_request(req);
>> -    req->rq_flags |= RQF_QUIET;
>> -    memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
>> +
>> +    memcpy(nr->cmd, cmd, sizeof(*cmd));
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_init_request);
>>   @@ -3417,6 +3450,44 @@ static ssize_t nvme_sysfs_rescan(struct 
>> device *dev,
>>   }
>>   static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, 
>> nvme_sysfs_rescan);
>>   +static ssize_t nvme_passthru_err_log_show(struct device *dev,
>> +        struct device_attribute *attr, char *buf)
>> +{
>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> +
>> +    if (ctrl->passthru_log_err)
>> +        return sysfs_emit(buf, "on\n");
>> +
>> +    return sysfs_emit(buf, "off\n");
>> +}
>> +
>> +static ssize_t nvme_passthru_err_log_store(struct device *dev,
>> +        struct device_attribute *attr, const char *buf, size_t count)
>> +{
>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> +    int passthru_enable, err;
>> +
>> +    err = kstrtoint(buf, 10, &passthru_enable);
>> +    if (err)
>> +        return -EINVAL;
>> +
>> +    switch (passthru_enable) {
>> +    case true:
>> +    case false:
>> +        ctrl->passthru_log_err = passthru_enable;
>> +        break;
>> +    default:
>> +        pr_err("invlid value %d for admin error logging [on:1 
>> off:0]\n",
>> +            passthru_enable);
>> +        break;
>> +    }
>> +    return count;
>> +}
>> +
>> +static DEVICE_ATTR(passthru_err_log, S_IRUGO | S_IWUSR,
>> +    nvme_passthru_err_log_show,
>> +    nvme_passthru_err_log_store);
>> +
>>   static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
>>   {
>>       struct gendisk *disk = dev_to_disk(dev);
>> @@ -3925,6 +3996,7 @@ static struct attribute *nvme_dev_attrs[] = {
>>       &dev_attr_dhchap_secret.attr,
>>       &dev_attr_dhchap_ctrl_secret.attr,
>>   #endif
>> +    &dev_attr_passthru_err_log.attr,
>>       NULL
>>   };
>>   @@ -5124,6 +5196,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, 
>> struct device *dev,
>>       int ret;
>>         ctrl->state = NVME_CTRL_NEW;
>> +    ctrl->passthru_log_err = false;
>>       clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>>       spin_lock_init(&ctrl->lock);
>>       mutex_init(&ctrl->scan_lock);
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index bf46f122e9e1..f5721ad8264c 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -248,6 +248,7 @@ struct nvme_ctrl {
>>       bool comp_seen;
>>       enum nvme_ctrl_state state;
>>       bool identified;
>> +    bool passthru_log_err;
>>       spinlock_t lock;
>>       struct mutex scan_lock;
>>       const struct nvme_ctrl_ops *ops;
>
> This v5 version of the patch has been tested with the latest 
> upstream.  Any objections?
>
> Alan
>
>
Any objections to this change?


Alan Adamson



