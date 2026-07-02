Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7010C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/0mxVW9yat7WmdMHYFUZfDyJbvbY00GmMJehpQpVy08=; b=E+Qyg/RgJBKYyzAAgyn2Duquvg
	kaoIHv5sZx3hmD+kJpWpEj8DMt9diEHWahg1MYT23wsVrB7vgJZUEcKxA/nuBfLnJip8RgIGSn7jn
	3F1/Hs4K3hPNuiZMsEW0EmskPEAZnwXArCVkpCZ75AIbVckgHe9RA2f8q+lD3ty8C7UXCDrg0O0+p
	6Bcodzk22PW4x+NyIgzerH5Knx85+pAO9Pvag7dmjdrP6dN/un12rZ3TsnooVrtuXoOfOHCFhAX9m
	hEkWCyxmxcoWj8f9kFr25QwapNxhCcZIIEG6VXrzbtnpBlsOg9fxW+IA61td3fZK7jcFHRMGYLaqS
	umDXNfYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfCai-00000003pHM-3ENy;
	Thu, 02 Jul 2026 08:16:12 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfCac-00000003pGN-3qNX
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 08:16:08 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6622OEvp3049039;
	Thu, 2 Jul 2026 08:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/0mxVW9yat7WmdMHYFUZfDyJbvbY00GmMJehpQpVy08=; b=
	Z+lIeAK7CqzyhV+7ouxAw13rYrEvJRUMX2YaL9BlmpybhSIVGZOUbYdi07T0aWBO
	A6hCl2WkitzaPwcja2N1TKh0xd2ukTMME2fIM2Q0AbW8oa+DgE9SwueFLoauitY0
	rSq/8QZGuSgCj6vrBJPgkjHPgyp8M/voe0DOTF9GEoFnZTjPLqei9vBEapGMz8Px
	lELY0cHXCeMwqeKg+P+SU1prabsSSrKv24Xuxbf9OPeoEkabhvvd1FKJ8A0A1RJ5
	yqmEg+FczxMrKOIQJI7Oil0zRpLjo5Ki/4/2Q8jNL/zEaDHWjx5JEWowhan7wX3q
	JlwYKO3HnzhjJ4YVlqYoLA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26p8qyq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 08:15:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6628DXPM039624;
	Thu, 2 Jul 2026 08:15:49 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f3u1y1qn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 08:15:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rh96YX9LBKCnF7sR7CKjTAlReQD6g/9GvaexSXOt5ul8EOIBY+QgUhEeTMYPpt02qQFCmwcZGh0NzFxGlvHGb1oqYPaA1Ij2+gmhoeLL06Af47XZRw6oylkAhbtYx2z0ahB96MBJZ2EhobaPIs+bptDpcwx1gj9u1GG1r/PyDX52PlrN3rUUawJLG70nVW6vRrG0qDyU5BKVJjEagxS5KHW+Ml72r1fBagLWS08nQZsjfpdaEujxAA1UHUhc5Fr9tcJ3gGPf04tUGcNodHZTghq+EMm3UL3cgHggnJn+48iNh8pmIgrXppHQFGbogLXGB1xcOfGkoSK8FYk5VLv8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0mxVW9yat7WmdMHYFUZfDyJbvbY00GmMJehpQpVy08=;
 b=M427CtuFTFwFbZsms9jQV+PnYVWJrr1byF8e1KJ50r0jO9GU9YoX7AieMld5p3T2+LJRQO8vxzsaes6BX54UrPP+SnlXSsJ3pTndexeZlFXcewv03MMImsgjWsj4WryR+MWfl7DVMK2XUcLMpvpb8sRIFLr2tOqC8kCQ0t1bY1QikMEXxfJMFis1nC/3DOn4mXCfRae7YBMRzcrq/V1pfEDPQx6PucthOoGU/PnymJ1hl70G89OMQtU0d4CgZdjGMnc82pC7gggyl/qUy1Xr7PaV6BduOrP7vF8i/g6k4ABMXMvZYZXafeUTkvG3MPH0PNO++Jt/y5pgaUpNbdEQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0mxVW9yat7WmdMHYFUZfDyJbvbY00GmMJehpQpVy08=;
 b=QmYTDBUQnJQIGAf8ni3NdpnaWsBIeD098yYg4PQpL9tfW3sBkwqqAzLKkC2sFf2yzhls9ZNfVCrNbRKlJRK3teFRCKd6IU36TKmhZ8zlNn65bDyJ9DhnoZlUJDmhymHA5jY1yIdHtJaZ5HFSHLnZgQO5WDZ+re4Ymmfn5+TMwCc=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH7PR10MB6178.namprd10.prod.outlook.com (2603:10b6:510:1f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 08:15:44 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 08:15:44 +0000
Message-ID: <3bfd53f3-16b7-4585-b528-6745ee64e980@oracle.com>
Date: Thu, 2 Jul 2026 09:15:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 6/8] nvme: export I/O failure count when no path is
 available via sysfs
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        venkat88@linux.ibm.com, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
References: <20260516183709.269937-1-nilay@linux.ibm.com>
 <20260516183709.269937-7-nilay@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260516183709.269937-7-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH7PR10MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: a932e54a-daff-4854-e981-08ded8121ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: sSvEwKezCTMPv5BJudWnuwYkfhet9xtm86mj4apSIkjuKCfMdkpoAwCfzlgGlCDw+oC2goEAtpLHI6KBnxPq9lVFrWbVEQEXSnglPf86haWW/YZyMNB/4L5BqF8JN6eE0ZmvKBGTQredVILjFgY0GaPAFLuMRGl2MCNN9QlJvJ9FX2CqGAYytulXOegaMQFi/jUiMCBTX6BQI5vdyT4/xoiCxLUU7LuDDdLzvygFY3XOd2hfs72efm0KQdayoJ37fEtEKEtBjf/JaFPWD09zFk4Ac7+3P0ifTlKIsPNVnijoTpwh21W116SRscIK2KY5Cz9cPW4o0sJYdLk5PGxdTzN+ydClQQSeMwOWRnz9CpsVSF94W809isDi7QcS69oLFfsKVMp0FRJvZKU5lwjNBx+XezzZK3z6f3HTTxW1pYzPlU5MDpdUhz3zmlhPGNX3Ruko3BTqm5dKWJv5iXM0hQG6L7j96MU2k26hM3n9qVFNjYsvAMl2qL2flpj/rADGXQ5AZ6YabGMQr1p0gnfMELX3xddPr7XLzOdtSSKjgZTLjnesIwClT2BthO2xaOwgzRQbEJIk02LP81Kusp63SCpBHClNSZGZmwCTzjSyWVgroayz2QVVY9e8uJnywLihS0I82z1XfFfySKR11wgxO1h4PYZBNfosho+Et02X71E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFpkeldJdG1ZcGZKdWhTN1NUdHIzSC93NzZKNWl3QnFyTEdyejRNZmdSckQ4?=
 =?utf-8?B?YVlGcDl5aU5wZU81c05lYTNxMTk5YmMvMnAydEJHTmdURGpud2JMWjg3dHoz?=
 =?utf-8?B?Q3VmcnBFMVJMcnNTYittMlpvZXZnV2h6STVmUWNiWHIzWjFwZ1pBS2dUWTZF?=
 =?utf-8?B?WEFOTnQyaERyeFFBdUlUdk9maEkrcmNPRE4za1lCRXgrajNiY29relBvNzFn?=
 =?utf-8?B?cENpbHQxSU1pejRGdFlqNG9KeHM5WEpDTVlvcTNLZDZTT3RHT1JnekxqMkdW?=
 =?utf-8?B?akFaeEFMcXdFdkdaZDhicCt5dkozOFZmb3lqQ0JCSTh5c3BLeThvNkJxMnp2?=
 =?utf-8?B?THpYcFEyS21vc1E1TUpCR0dKZHA0ZjFFWitHaHVBam9xL3FCN05qeVFib0dJ?=
 =?utf-8?B?ZFRtUGtsU1UyY0VJYVFGa3NtajVUbG1teWhpWE5tczg4RnZGbThzYkEyTVlM?=
 =?utf-8?B?YWRZUVYrUHJnd3NLcHUwbklwalRGQjJOWExnTUd5ZzdsKzlFV3RPMUg3SU1V?=
 =?utf-8?B?aHZNeUNZcm9DbmhKMmppUmZlSDhKaTJJMWpxNG1yNGlMNEtqQzZEOEtTbjUr?=
 =?utf-8?B?eW1MVG9OZ3EySGRybUtHdGhJekx0dUgwMndhb2Nha2FXWUdmUmNQSnA5N3dL?=
 =?utf-8?B?Nk5wZ200MHgxb1l2ZytvSEtKTTVhNm1SRmJ4VC92VDVKZ1FORjBSbkVOS3B0?=
 =?utf-8?B?eTd3YmU3MDRpdXlhMHlFYUNUOVBxWm1sREZBeXdwbm5tWmxVM3ZjWnlwQzFq?=
 =?utf-8?B?aUdFZmVLRzJQanJsUTgrcng5NUdyMW5CbWFlQTh3aHdZRTN6YUlONFdkUmw1?=
 =?utf-8?B?QWVvaXM3UDd2KzhrN3Y4U0F3UVNITHg2dU5jQkJKL2ZyYWplRCtnUDk2cXkv?=
 =?utf-8?B?QzdHUjFkZmFiNU1PTUdEVlZOU0tQUUJ2SHB3SmtwYm9XdzgvcThoUjU2bWJP?=
 =?utf-8?B?cTFQcFFPTW0vN2NjUU45S1E1V2I2dVZMTW16RGQyRGVxbjk5bXo1dEZBQVJm?=
 =?utf-8?B?R1dpZkRBU1hFS0l6djdBTWQyN3V1clZlc2VpdDUrTXRHTWJiYzNkUVM4U3Ir?=
 =?utf-8?B?VC9XVUhJNXRxVUpXeFVkRHFONGgyREFhVVRqSUhaSmxwcUhhT0Z5cWRKSnhn?=
 =?utf-8?B?UGgxdkxVeDRqTlJJeFByRThJUU5KU1RqMFFsSzZpTzNvOVIweXd0d0oyYlBV?=
 =?utf-8?B?TmFZWXlWV3lBelRvOEhPd1I3eWVIUldVYVM1TTBSM29iM2krbTBDYUdWcUl0?=
 =?utf-8?B?TFdod1h5RjFSRjU1NUJsRGFkd1FHbWIzaXZWeWJ1VHArYnNyRkM2WFF4SW1V?=
 =?utf-8?B?TmdKRWNEUUJDbVhnZkk2RTFhSmpWUlJkQ0RKSzZ4anRTTzA5VUVZZmtQejdh?=
 =?utf-8?B?bmVjTlZlRHg4VG1mTU5OZ0RhOFlHajhiMXdBeG5Velk2OFE3TmJOTnVpbjJ3?=
 =?utf-8?B?QWR6NkZzcnd0a0NaTkhhZzN5eFNoVFlBKzdJMjBNN1lKQVR3bHRocWZIb3Rx?=
 =?utf-8?B?RDVJeGJ0TlR6V0NTTkt5T2UxdU1EdHFobXd1Q3JwYlkvbDk3eWNzWWlRek4x?=
 =?utf-8?B?Wi9kQXBkNU8vTFVVaVRTeEV0QjVBV0xtY3JpaHVVRXBqT21rTUVXTDJCQjdS?=
 =?utf-8?B?WmxkeEptM0hZZTYybE9BTmdYNU1lR3Yxb2J4QUtDS3Npclpua0FVOWd2N1RY?=
 =?utf-8?B?NjZOS1dHWmF5dTVReVdlYU9mUWNIM3E1MVdnZ1RSNUttM2VEZEwwNVFOL1Fu?=
 =?utf-8?B?WllDZ3o0Zi82TmRJN1JQUFR2OUtXY3lWT1FpYWxLdkF3MjBKOXRWUXR4K0Zv?=
 =?utf-8?B?aUp6TzRCdXRvVHhROXJyWmlBRzlQZGozMDQ4b3RNcEFkcjlSU1pGOFl2YTBF?=
 =?utf-8?B?OXFYcXJkZ2d1OURNK3FkUGk2dHNSYlJEeHlLQnFRODdyWW5JMXZuSDkrU3NO?=
 =?utf-8?B?VWVBcGcvL0dVUHFhVHJ5cXQwT0Fack5uUzJ2dE5nQkxoUUIzbmFUU3JZSDhK?=
 =?utf-8?B?RHlnVjRVcWZnL00xUVphaEtib3phRVU2T2FDNkc2YVNjZVdCNFdEdGJ1Und5?=
 =?utf-8?B?WmN4ak01cjlWWnJhNkdCTWtzVzBqV2tkOUtHQW5UYmxIQXl2QU45ekdtTjNG?=
 =?utf-8?B?THczNXhncDUvUERCY1NlVmxPRUU5VWRYQlJkbS82MXhqMXdtSFBTS1NZNmNM?=
 =?utf-8?B?aWM5K0N6cnpPUnRHekw3dmtIc3QxeXJQN3RQQkV5TnMwRFRuOEZUdzkyNWhi?=
 =?utf-8?B?OVJKbUtYU25hNGxBeUhJeTdBdldweW5LR3VVa1Bmd3Qzb29tMUh1NVFjZlRH?=
 =?utf-8?B?TWZaa29YdGFjUkc2UThJcUJtOVZpNFp3OFk3WHpGdnprMkpaUXh5dz09?=
X-Exchange-RoutingPolicyChecked: CDhYtGjIY3xxwn4USYBlrsODcbvmTJ9OvtCMx/qtXDwO+eCvWcl6nLDpegACKpw18m+Gm1BR2UzlQ0Me+/6X2zPGuDL+gRebUgrTZOsY8G7+cH1rR5l3JFxoeZ9PF85BT/z6efzgA1cKAaq65IL58IJO9aaCucHDQlYbXImHkf7d4lkKvxBilD7a/9wv8Ji7Zj5USD5xDxTeskO3ZusonxFcUQsPeO6uLpXB1UP5LHB0btgA8HCaumqw+l70aZVx/qBzBeFFoaBaunzZ0spaCfyRjSVt0BR0Un4t1Rsm1l7MAAl3l+zUFw/NI9ENUUS+Ur+c3/2NgNVdcgzfKTzrRA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 83mxMUGkP9Ml9uOSFQrTz30Hp0G32C4GsEqrsdRiDkPd2ThNJHi2A7AlB78YfvRF67Z84+9ipenC6zPyP88n2mXAtDOaaDw7QGbnhjPBnbOu08LcH3RaFpy+KkZOyeb9OW2ynwWbqRXZfMTMrM0Airnwk5+gtPNPbnbTDphnNoryGVD5pH2NiC+qQsPkksBcj8kqhoPmRmfWp7npADG9MbQf9HJHK+5IwhancHuUS+YLrxtSkjh+CAQ/VHrgXU2hneg02utiGnrwyaQ80azkgawKu6abgIH8iUu5JOUgZHvtNa1Zn1iIJaXxoOz94T2odt2kmgYPXPiBx3uyn7j6I81Qs7pR0bwZOgseGLAGppzySTWKVAsu/EP11wDTw3H/SqUnfBOTtPDx/ySSi3JtcFMJRCvvghZ/tC7x3uoG/hgykKDumnXwBq/TnrhsKfTZxxstPv+6FN/zE7DpxE14JbPI+oruEjOk8Z7JDNHZwnvZPGztwWWTlGgEEXHKCBuMZwkiqB5i0euB/cU7kW45VDIQqThhuPaKLnV2rbErDDomIX/lxDn1SOwJlYQ/7jMr2tODL9JDh1A03hzUE61Jo8GpXcWtZ5pt68PjDpA2p7M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a932e54a-daff-4854-e981-08ded8121ca5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:15:44.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzDYKX+jw+6T3rvEWzcJIha10E5WvweXJWifOluN9o6d0KjEDfd8Rsh7cjZqbNaMEcJMwmTYdJnEtrVG4qJeqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607020084
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA4NCBTYWx0ZWRfX4KDfQhFozLq7
 fPdxsaMoyH2gWY2xvSb+VaitR1xhM6ZLVOnechBaGLYcxvjXW3cuzm669q9/+kT6XoTLx9Nngpo
 NPVCHMJXpRISQm2k1pmgvrs/blddTmoQHJnGxwcL5YIWGD43Gte3
X-Proofpoint-GUID: w6I47aI-WO2SfOspT7qpnNKrAD3y3yIv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA4NCBTYWx0ZWRfXxdUP48HMAd5i
 3gdmlbPQL2ynEGVngWpXY1ao34Y3zXzFx1LgyyGxjauKwhvuaEM6M/VzB7fNY5FO17z9llmLSXp
 /xrr2UF7b2xPnkGAaZsc/NHXx2VuKQf2kPO0+NpyZDZYjUrWEuYOgnZQtUA4yeKr3PPdbfWIcNC
 awIDDHJ5hqnBOa3pBQdbwJMGpXF9ohuapvz4t0eaF67e7y0BVaX/SeEm7GvxS0D5m+OmKj6KHC0
 s1ImY5SGILbNXPvIliVXtFPpLEWgXgADoye+5Ksji9t9b0gIblLG45IefBIS8k+s9SAYs8Sy/ZX
 4kY6lr6SPCjvgdwReQtiA/9nfr6EAnrTTclkYU/J6yZJBQhze9JCPmLZe54IV8TFz1Jh+cFNttj
 CxDNPMpmL3Db0f2guU+NMYDHEtwbT3iS5dNu1DEebpEC6W3ou64aRKzjdztYBD6/Er5fR8G/OLd
 M2aBUvjvrBxIXUaaf/cWNQNPg/2LSlAS0+ztl81Q=
X-Proofpoint-ORIG-GUID: w6I47aI-WO2SfOspT7qpnNKrAD3y3yIv
X-Authority-Analysis: v=2.4 cv=D5N37PRj c=1 sm=1 tr=0 ts=6a461e36 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22
 a=k4PiV01lm-VTXVMWJ08A:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_011607_293853_C48D6187 
X-CRM114-Status: GOOD (  12.39  )
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

On 16/05/2026 19:36, Nilay Shroff wrote:
> +

I'm just looking at this now for the scsi multipath/libmultipath work.

> +static ssize_t io_fail_no_available_path_count_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int err;
> +	unsigned long fail_cnt;
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct nvme_ns_head *head = disk->private_data;
> +
> +	err = kstrtoul(buf, 0, &fail_cnt);

is fail_cnt ever going to be non-zero? I assume that we allow the value 
to be stored to just reset the counter (to zero).

> +	if (err)
> +		return -EINVAL;
> +
> +	atomic_long_set(&head->io_fail_no_available_path_count, fail_cnt);
> +
> +	return count;
> +}
> +
> +DEVICE_ATTR_RW(io_fail_no_available_path_count);

Thanks,
John


