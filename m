Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21362C3ABB2
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2024 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Subject:From:To:Date:Message-ID:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=m1kgZBIOu0oFX/eMmqYxDasoDDfIirLicba86uIqqFU=; b=noxnbxIe8t4jSX
	5pmZeEG1eF6PQY7Pxph0EwuSr9Olvl+ox/BCIvPf+AJhYpI46qoPnN5axU1v96iAHflSjaFo5Vt/z
	0XuARnG6aW3+1UTp1tsEpuPf+TE8oCgqMGWS4xfub9Fo34J61ovfJk5q7vIOl9INLKXrZcJr5dnc+
	O6GA64/uEsQnJnP0RqUUICS7eoCvYvo+d/Cwxi+R2TbSndHjBzjtDXnviSIqwYlKvZjMWB8zyjCzP
	x+Ky75aXDCVNZa1HRsV0YnG4qQkCX+1wDWkXpUV3os9LMIddnq3xe8fjQhlRmzmESaIGmWlrCrO+D
	lJCUW1giuG6Hc54GRhtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqCq2-00000004EMw-1NQr;
	Mon, 16 Sep 2024 14:36:26 +0000
Received: from mail-am6eur05olkn20815.outbound.protection.outlook.com ([2a01:111:f403:2e12::815] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqCpK-00000004EJe-3irT
	for linux-nvme@lists.infradead.org;
	Mon, 16 Sep 2024 14:35:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0oe8oHJi95VQk9UqSgxQi3B1ZYjNFuKRZi8kuNbG5WVO5N0s0GD6k/KREGg6IuXSiQNRL6YkGA8lhCjoBLPrqiJqr477LMNcgAO0h7LM34DjmOXVqSPHAA8I3zdy9aMeFnCdjKZw4hmiM159E4eJfW9CxP83A3VAEIrBljgQ+jWU+/Nk+xgxjhbbPjLcLqJ7ZJZ2z+A2Mvu+6QRqTZMqV57IngaobhocxAY1mt5SrVwdKnPUX0OcAj00Rgtg1dXDfdMR/w7QRdxefFUI5L3QOy7WSmRC/5rOB4j8dexs2SElhs0sYJVFr3O0az+vE+COJLFaFgA9UPm46KxtU/6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1kgZBIOu0oFX/eMmqYxDasoDDfIirLicba86uIqqFU=;
 b=XKhcVeCEqzQtGee8uIwcPz2LSry8qnH4A4qjVFyQX+rVsOxfRhtKU0+D469EOQ5Ak9VrsM1/llpX5QSkQmsgddDvkTpv0ds5hMKdX0o9BbVAlEM8kAEiPmhBaqpKLB8n/w+jF1QVutga3GXjRMDSJg+NKgyo4jAInCrD3ZLsJPTDSB9khg27JnovDHzjdqYs0ALyCf3RjCYKD5tuv73/8Mu8xNdHoYbGendZSqIhmJ6Ir7wpENESd4vygXTPnrbo2KjxXZQEIFlxDOvEZVrQof3r49I6MCmkgusg87/0dJ9ygZZZWKPQSS591Gc9hmcORCF69Qaz7twMWMj1BF1EGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1kgZBIOu0oFX/eMmqYxDasoDDfIirLicba86uIqqFU=;
 b=Q5qMWMmmKNUKlookG2nO70doGyrsaZJBLBFFXb2+mGv3KSG/oPLx9KsdIaIaK5rnPmulg6waxzjn4EcaS2RWPvCNGa5rMvPfjv/5SETQBrjK6Hc96eIxhMBU5Ti+fyk4PxpK5w/XNismPuvRG8GQVY2CRCnjunViayTsZ7bRhb0V8OZtcAlIbRCJIt8Q9g7jdGo1b2IzXEPGBbeEsO2xwKY2TnTR002jUcuiruWddbHpqeOY/qW/th3Nj4xRLaWqn3BJ+nFfEYuDdf8dijSknxNM8nEKJcsyAgWZmnS2xg1O/5wEvhivikrbV/DzMhLEJqiIClCvhLVh26TuYp+7Mw==
Received: from GV1P195MB2055.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:a1::5) by
 DB8P195MB0472.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:15b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.25; Mon, 16 Sep 2024 14:35:37 +0000
Received: from GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
 ([fe80::d7e4:bae0:94b0:378f]) by GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
 ([fe80::d7e4:bae0:94b0:378f%2]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 14:35:37 +0000
Message-ID: <GV1P195MB2055D4A0347DFA6537512A9BEE602@GV1P195MB2055.EURP195.PROD.OUTLOOK.COM>
Date: Mon, 16 Sep 2024 16:35:31 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nvme@lists.infradead.org
From: Jigao Luo <jigao.luo@outlook.com>
Subject: [nvme(t)-rdma Question] Understanding nvmet_port's max_queue_size
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::7) To GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:a1::5)
X-Microsoft-Original-Message-ID: <a7449c58-9889-42d6-94e4-6ba4ee35e495@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P195MB2055:EE_|DB8P195MB0472:EE_
X-MS-Office365-Filtering-Correlation-Id: 25818c53-c2f2-4f65-b174-08dcd65cd448
X-Microsoft-Antispam: BCL:0;ARA:14566002|5072599009|8060799006|15080799006|19110799003|7092599003|6090799003|461199028|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info: DqjrzBSkbSZX4xnPxM6RQrg5cl4ZO2vJv3oittvcENFDChjFu7dCXCECE1amf01VT0qbKsDB4sooOuUO/nOLbZvleq/wtEE/X6BU3I+KjyN1/l7dKp6NlVjRI5bfyb2aX6+arkuCLHSyAONiK+PGBXxfg80viI/6pAPj5dvNJcYY3SOzI9TJl/pHdpy8UdaXE8/iDTp4WWRIZEEivHz1pRDVzXs5ytouGjGN0LeBbRPWuu+pKM7lgi9uSzgkNpan01vuxfTTVlboL07i3PTgQL+1oX+SUGYc28sU5eDMTgUs8/M8Glx/RqWBJw6nvPQ7vLfP7gR22SBbjc6m8vpEoboxw3RvaGd5lXFRZQnpfKcZz5KXlLECTOkJj+yW/DlRUcHNdoD1WeTRyYtEYs+zTytrtqe9xoEIe8H/xDsZ+ardsjQ1r9e7OXBNzJDzINfFcS8W9z3X1hNO+vztkBTepaC0ECcgu3MxOtANPk+Cig+MxnS55zBtOkAk29a5H5rkaNry/MQiDl51V7KqTJD/fdXwDzXSOmdg7TDiWcpTKQvb+L+RzOpIR1myZHhe03O4AhrZl4KUGRYSQShL4jm77JoRtS+FEIj2ak7MEMq3kvLSyi+dMWgH7bkZ171cGAguxDth3bEbt8tqn8k6jQrFqS78VGk8kVfSM7WcEwiqVazhOESCAeDLZ9NxNJCwFtQPJnA0Qr2G01Z9hRrM5Qbd7PkwRRYEH5IldQnTV0Qnlp+sNtAIU3tIs6/AlS3gQ3nrBjtZGKwzby7oOLpzBCC0yqByyGxuCvc88uum0mSLJdyOQA9fBzv8kS79cEDvJvGAZ50dW5Pn0ZLdPJPtPKQyvW7fQSe4j1NzTGuzUhFO8LUbieCpZc76xSFWDECj8nUJ/ZQPQARTc1cjXgQUvmy7xV4z+qG9iG8eUJyB0sjdgq8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTVRSWJpdUVmdjRvWFFkMWpKYm1PK3IxeG84dzc2ZTRyNWwxa0ZyMllWWmVp?=
 =?utf-8?B?R0JCRXE1UXRzbXVYeWZDMW9ueldjOXUyaFBhSDd5VFdvUjh6QU13TVdja1Fh?=
 =?utf-8?B?SW0zOTdJbXRsZUlZcVVnNTNZU05XalBpS2YxZThIaDlYMTBtbGwrVjk0UGMx?=
 =?utf-8?B?MXFxeEJLb000NndnZzg5b0hKallsYXdZYTJadjhOb1BrdTgrNGc4YUdraUta?=
 =?utf-8?B?NHNlWE9UL1Q0cUlvS0VuQmZMQ2ZMUjEyVWZrQ0NGaU9LM2lyYm1QR1JiUDla?=
 =?utf-8?B?SnFQc2IvVjZSVlNwbG40RzlSeHc1V2FlV2tBS1M3YkRKMEtqWHNJZFVlZStS?=
 =?utf-8?B?ZUNTZjc1WWh6NEVEUWNUalJ4QUFrVkFoc21WcGJkRjVvTXhqUVJMc0NPRm0w?=
 =?utf-8?B?OUtkZ0dxelFyMHc1aDY3V24yc2JvVUVXOVU5bDg2bjc0bUF0YkVST05wemxi?=
 =?utf-8?B?RDg2Zmt5VFA3cFNvaUdic3BUeE8waU9XYXF4SEMxM0tFTHhDSHRiRDQ1cS9H?=
 =?utf-8?B?YS8xQXUvdkFjYnNEVG9oSHBSV2V6MWtwTUdHWmNQdHQ2Unh5TmM3NEhveHZM?=
 =?utf-8?B?SmUzTWFyQTFpSVI1Ulo3dkdaVUEzRk5lMlhZTFkra3dBWkZWTE14cER4QVpI?=
 =?utf-8?B?aUJWeFhlR3RXUnBudm9zUEY4WkxvZnZWdjBYbzB3cHpXSE9MeWJBZXJGUWZW?=
 =?utf-8?B?VWVlQ01ob3ZWS1NWejc1TURud1A3WXFqVnVCZ3kvR1lGRTNQKzVRYzF5S0kr?=
 =?utf-8?B?US9PeVE2WFNVT0VxWWJvTTluOGJwZUVocGpobEF5TkpkbktQRW1QYUw0TmdI?=
 =?utf-8?B?Ui9HVUV5S3Y4T3lGVFlqQ015cGhvQ0JWK1hrRFR4c243V3Zva1FEZStGNUJh?=
 =?utf-8?B?ZkdKd2EwMmF0SnkvZFViU3ZVRDcxWWRlczRqSmJWejhmNCtHU3FQR0Q1Y0hB?=
 =?utf-8?B?aHRhWFFGbkczclY4Qml4cXlVS3JkVldVTmZjV3orVWNJbnlqMWlTZ3ZmN2xp?=
 =?utf-8?B?NXFaSmhQUmQ3dTJncmhxaFR4Q1NicmlLQkxsR1NIRUFJcUdkTHRmbUd5OTQy?=
 =?utf-8?B?dnJNaHJKZmthTTZqNnhEeXpDdEFHb25WMUU3YkdIb2QxMzhORG9EcHF5d25J?=
 =?utf-8?B?aXFEZko1RXlPRVo2dXoxcU1YZTY1Q25TblFvQ0pFbVozdmZ5dFhQamROL0M4?=
 =?utf-8?B?RjN5L2tZYVQ0QTRaQW8xUi85cTBQZkdyc1MveWRmeERuTnVCOWVpZ3IyazN3?=
 =?utf-8?B?MDdCbXlUSUdJRXoyc3FrbFNLbzNVY3F1bTBqMDBaMndUWGUxUjBsMlE2SFcx?=
 =?utf-8?B?ODUvSmNxWFpkZFMxemVoMks5V3AxaGlJZzVGdVlrN3NRSU45NVlRMkdCNWlt?=
 =?utf-8?B?NmkxclVjVDlJOERQMkpMTWtrWFNQT0ErNHFwamIvYUhkbTRkWmRmcHJYckda?=
 =?utf-8?B?Z1c2djRDcGQ2MnYzUW9WRDNFay96aktiaEV3M2dWa05pQk5IMjdPYm0rcGxB?=
 =?utf-8?B?dGZzeGFoa3lUbTNuemNramhiRW4zcmdULytFSUpIeEQ3UVhqMkxkVjdPVzJw?=
 =?utf-8?B?Q3BKcGtid2JSeVU0S2xCaFdyeC85cmdTTStxeEdMTGhCMHVJeVpkM3ZvZ3VC?=
 =?utf-8?Q?RqX3sf5OgWGb+nnoc8DQ3TQqkNu8x0TZUqOMSr4dptao=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25818c53-c2f2-4f65-b174-08dcd65cd448
X-MS-Exchange-CrossTenant-AuthSource: GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:35:36.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0472
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240916_073542_965246_877E3BBE 
X-CRM114-Status: UNSURE (   8.65  )
X-CRM114-Notice: Please train this message.
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

Hi nvme-rdma experts,

I’m trying to understand the queue size (max_queue_size) for NVMe-oF 
over RDMA. I came across the max_queue_size field in the struct 
nvmet_port, which appears to be capped at the max value: 
NVME_RDMA_MAX_QUEUE_SIZE.

First Question:
I would like to confirm my understanding of this setting: The 
max_queue_size is configured on the NVMe-oF target when setting up ports 
for NVMe subsystems. Once set, if an NVMe-oF host connects and runs FIO 
on the nvmeof device, my assumption is that an iodepth specified in FIO 
that is larger than the target’s max_queue_size will not be fully 
utilized. Is this assumption correct? Alternatively, could having an FIO 
iodepth larger than the target’s max_queue_size negatively impact 
performance due to this mismatch in queue depths?

Second Question:
I noticed that this patch set enables max_queue_size in the 
configuration entry and increases the max value from 128 to 256: 
https://lists.infradead.org/pipermail/linux-nvme/2024-January/044145.html
My current kernel and driver versions are earlier than this patch (mine 
is Linux 6.6.1). Is there any way for old kernel to view the current 
max_queue_size value? I’ve checked via dmesg and 
/sys/kernel/config/nvmet/ports/, but I don’t see any reference to 
max_queue_size.


Thank you for your assistance and insights!

Best regards,
Jigao



