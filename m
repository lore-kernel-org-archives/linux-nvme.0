Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0FAC36014
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 20:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LQcVKfiIFULXbLkd+VFU+UAozRqGezbeMoofU8lB634=; b=M0P3T2rw1FiZjGwY/+VftxMyj5
	Ff1+mE7AMt1/CzKmCjXvtmnIWF6oHpt9oA2a6JUv+A+kdFXU/flRHLblvqxfRUlC5gR9Achuy/Xm0
	onslGVfVRRfND5dXlFOBXIUsgZYSv8Qdx4xs4thQIIf0lfAy/nwjIOffmTQJKBe9pkJlLbDp1g2ns
	C5FLGywi9rWKgAUTLQmcUyTjeVGVC6cYmdz9OJa/bVMayZRTalRjondE7HyXeNkBmHpS+ex7hTC/Q
	wY32XXOInUmbcm8gpLqWtzzo1pPXxTga82X8oh/ogQtqB7Z2YjkEwU3RdFdwssuc84AnDIPjpcXWR
	qVoRhrUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzLtK-00000001KxN-1PTi;
	Mon, 31 Mar 2025 20:37:54 +0000
Received: from mail-co1nam11on20605.outbound.protection.outlook.com ([2a01:111:f403:2416::605] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzLtH-00000001Kwv-28dM
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 20:37:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Soj0uBAk7vOy605PBtSIG+ShTGgxFsJGxGAHSfCFuRXXSYOGfdaas7k7E3/Jj9uI+wXJqdngoM6XZ4EfR6nIZ6iBpOzG7jbWc65XGzIRcrI/abF9pMMvBIUYA22HJobaaWB7L9IIWMj1/fgOjmYIzPgrXrFDPtAWbFlFLAbLWZr9DbDewuWcKTw9hbAWfJIbjIWiwG8nIq+aL7Tmo6Yg2FR8I+EynemDXBjuyUwj5GO/mCwdVn4DPwO+IKVzs3FhU9JSKtSts9F5KVdDFJeHGqnre9sIEsGALyW3fkS82XkCETBhE/evBMar3BaSff0l3/LjriAh3RymZK/3rp7/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQcVKfiIFULXbLkd+VFU+UAozRqGezbeMoofU8lB634=;
 b=yHD7JLKQyXDBmoNlZL49LpjjEH1u4binFZ+tNjq5Un+0Hk1+3QtGp+30jT02eN6lVaJc7UQielZ6S7K9rNiLNqQwBMS2gP5Lf8P0/9kpKfu1O0WKbhDZa+KFccNGxstNdrBxD97WiIb/lmxYSLCmH5Iq909F5PkzFSY3C1o5MsogOj7FSSkVynihaz6bNUVn8Ny5ZJ83ghTSfXQjgXBZDE1LbQxEGdTiMFAmDDItpW84kpaPOu+L5DteEK7I4cjx5E9AM7Qy9VFT8rHo+S3Rz1rETXAQvCaEomD8cZNzo14JyrMQ6dlu5dKsPJ6RhanWdzTNMnzuplxnnMSFxkJT+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQcVKfiIFULXbLkd+VFU+UAozRqGezbeMoofU8lB634=;
 b=p9OWlV4j+fyDE8pvuwNRwo3pGE/skQfSdF8l7o4A+NkG6s/DGjaI8wj2L0DKIfJGotTmjkUHaYYkpSNNw09XiDvCsZCzryR1QczjOMIoOAoruCchna9Pkw6tVhO+WuF7PY18jAFwCR64av0k9Mk3T8aDHNpA6e6bhAymmlbxegc7FlrxqOrA4XUtVleuws6olGCYD+PKPlt0b56hQGf4vMC7THpGgG1IfmNh+kUepsBwZ0kEp4vzrLl+T2NwCho4zlwIfjkkhvgkg2lu7SUcDvkNsqzvjm4X6hCfwhFT3Dxj2nhGdcTtsu9aawUOF6bnmi+yHp7y85DbDiEy97ZLaA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 20:37:32 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8534.048; Mon, 31 Mar 2025
 20:37:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "wagi@kernel.org" <wagi@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "dwagner@suse.de" <dwagner@suse.de>, Keith
 Busch <kbusch@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH] nvme-cli: attach ns to local controller if none specified
Thread-Topic: [PATCH] nvme-cli: attach ns to local controller if none
 specified
Thread-Index: AQHbonI1MZWmeNQX40W9q2pTBv84TbONtI0A
Date: Mon, 31 Mar 2025 20:37:31 +0000
Message-ID: <f6567009-341e-44d4-94fd-feb92526d80d@nvidia.com>
References: <20250331190843.2431830-1-kbusch@meta.com>
In-Reply-To: <20250331190843.2431830-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB6158:EE_
x-ms-office365-filtering-correlation-id: 804616de-ae35-43e8-f326-08dd7093dc7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WnpDWlZNZGtXU2JTYlE4cTBxb1NPcnZMak5IdFA4d2NvdERITnRZMUFZQm5P?=
 =?utf-8?B?NFRtVTJvTHV3TlU5U2hYdVREdDZOMUZwTUF0bTFKUHphN3FpMU9FTWdTamNy?=
 =?utf-8?B?a0tkS1dzcml5d1ExMlBqd01xNm9nVmJpelNRR0VzNHorM0xGcnNLZHg1bVFE?=
 =?utf-8?B?elpCb3lLa1NKSnV4UXVCc0lUdHNYTW9OanVXMERvbHgzWTE5T1RtQnpPc2tx?=
 =?utf-8?B?RVJDa2ovUjF1ZXJ4R29QY0lzeDVMVGc5QjFLMUl5SytubzMwQUEzam1nUnJE?=
 =?utf-8?B?ZHZ1VE1nMnpTMTh3ZTdiOEQxWFcxOUR0U2I5b05aK1B6b1F5OVpqK3pRekZT?=
 =?utf-8?B?Yk0xQ003VWxxZjUyUkwyL1Q1WTJWelBPSVR4K2JyZDNHU2Q4eExjU0h1T2xT?=
 =?utf-8?B?MG5qT0ZUSENrS2htZmR0eHVNYjFuNzJ0aUFHK0UycTRMSjZTNnRWZFVsTkYz?=
 =?utf-8?B?RUkydlNYQU9OOGJjSkxSWXdkYjlrMS9IcEduUUFNSzl5MmVMTUp6dVNhWnRl?=
 =?utf-8?B?SWxMQmhFWnpoRkdrRTZReUdvTEs0eWI0QXlJeDZNS0hEaXlTdnVnMjZJZVZU?=
 =?utf-8?B?ZnBBS1BScDVJUDRDOHBHd292RlhlSXVGZUdZU3ZUTUZlKzcvRTVZVlF5WllK?=
 =?utf-8?B?MGRYOGhEVzV4eEh0SEQrekxlYWpjazhwWVVyKzk5NWlad01xSFpiK0dTL1Fj?=
 =?utf-8?B?S3VQRGJqUkxHOEZqOUd5YWdhUks1WXpudG9QMGg2bHE3dG9MNWIwdVNIMVhm?=
 =?utf-8?B?ZXpCaVFaSnM3RzQvd2VrR1JLK2owMFk0aFhUUmdjekZybkE0SUpDWG5vMjVO?=
 =?utf-8?B?UVpFNnkydWdINUJnT2RITGNPV3Y2R2V1RXEvOU1Wb2lxQUJpamdwdUpISTE5?=
 =?utf-8?B?OTIySEk1S2N3Y0VGOFlCa29FMUFwTVo3VzZjd2ovUUZ1aTdsamJCcEJyYVBw?=
 =?utf-8?B?Y0pOKzlkajBlWldEU0Y2dHRuM3c0M0pWMlJMbGhvSDF3bk5XcmtkZFkranZz?=
 =?utf-8?B?TWNiNmFISlNYQ25tMVd1K1pKWWZnZExMbXFONlN3QlZ4a0RiTlY1bGFrT0Jr?=
 =?utf-8?B?eDVtVHlJSThHYitOVG9oNW9nWXNzYmIrNGRNeDI3cTgyT2t2WnBpTHFqNEZ1?=
 =?utf-8?B?RmNJdjJNbWNMY2pRL1VOeXNFRllwWFBHNm1Vc3RSL08vdjJ1Z0pVMFI3QTYw?=
 =?utf-8?B?U2dzcng4ZVFWVWNUU0RmeENra0VJTkcyeUpRdFFTV1NuUkRkYjZKQXBpdE45?=
 =?utf-8?B?cWtocTJNRERHczl1eHBxMUwzU1dPT0ZtYWkxcEorb1J0VGJWeXJBcmhjcHV1?=
 =?utf-8?B?ZDVEaTlDR2pheGUrTUpHS2t3N3I5eUNiUGVzMHNXZk5DVXZ3MHJORHRhNWg1?=
 =?utf-8?B?WTV2MWRIZDB2VVdweGxqeE8wdjhBejhoUWQvMDdJcE8vL1UzSHBDL2xYRFhw?=
 =?utf-8?B?WjBHSXRneEdNMThSZXFsQjNGRGdDamRiUXQranM4SzZ3dCtGZUMvdWd4WjY4?=
 =?utf-8?B?dCsvZXJzZFk1bVkrcDRJSnNRZlJmME9vMVZmYi80WnFGMUZyQWJIcnYrSUU5?=
 =?utf-8?B?ZkpQakN4d0ZxMDN0THk3NGdnTGFGZHNBMXBTZzh1a292ek9oOTRaQ3VvZlAr?=
 =?utf-8?B?YWV6QUFPVXd5YUtCOFFKcmFNWlphK0NLY2p6UVBoSDM5WlRLei9VOHlSQmRQ?=
 =?utf-8?B?bzBrY3RadUl4MFpLb2kxK1ZwSU1NaTZueEFOTlVKSW1pTnZYR2pwYzBQdmZ4?=
 =?utf-8?B?WDd5MTR5WUZsdVNqb2VkMFZFT1JrQ21sQVRHQ1NqUmgvQzRaSk9PcVdDRmVp?=
 =?utf-8?B?c2NHS0ZPVDVIV3pOOFRDS1l0MHNUZ0xUSjh3eEtQR0pDY1cwa1p0NHhRcnZi?=
 =?utf-8?B?RmN2WFM5YW5YcWZwZnNNVldlTXhTamRocmtQbU5NRFdPMXJQUVZqMFl1WGlO?=
 =?utf-8?Q?B4+x41nkYKlqR+9I3EbJv7j9QfVCiXp4?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnhoeFVWVHJldjB6azNzS3pFaXUrUEdoVExUd3NjTUYyRWZXUDlMRll2dVZK?=
 =?utf-8?B?TXBXYjVvV3V6TStFNGt6OXorS0RqZ1JqNEZqWS8vVzBtR3NseWphbjd6S3Vr?=
 =?utf-8?B?SmlRc3F4dmczWlFhcGI5U2xsTWNhMzdVNXZKdjdQUTcrNWQ0ZnBkKzMzbnIx?=
 =?utf-8?B?dU1qN2hiSXE1TGJNc3JXYStKU3UyMklReVJQODdOV3JSUkZNUmswcnU2WmtS?=
 =?utf-8?B?MVYxS0Z3T0lpeW5Od2xUVDVxZ0pTdzRLaEUwOWVFbW92QjBLZ2lGeFJUbW1G?=
 =?utf-8?B?bHBqUmZNLzA3aUN3aG5EWVRoNXdTR0RJNlBFbzBXbHJXUmxyYVRHU1h4Zy8v?=
 =?utf-8?B?a0Vkak1yYmVkQmt0cjBTM0pPWjhtN2JtQ3ZwS1lUT0YvdHNKQWZ3bFNOaHFM?=
 =?utf-8?B?NFVXUER0d1BFY1BFZkJtWnNEZC9uWFBKNU9DWTQ4UStWSWQyUTRHaXM0eER4?=
 =?utf-8?B?RVVuUHIzTnU5a3NoZHQyekVjWitKRkRxMU9oN3pJNjNCbTVOYjY3OTNWcWVX?=
 =?utf-8?B?NmlvZzRHd29zL3NENnlYeWZlWjBRdlhraW8rZWtZU0tkMXZRckw3RHNUb1VR?=
 =?utf-8?B?UEFrSlBsaTFoa0JOcmM0eUE4Z3VpNmlpK1RKTllDUzJHY3pzcEZmQTF2TEtL?=
 =?utf-8?B?c2VmNU1lTUowRTFwMlR1VUc3RlNMTW45WXFRWXBqN2NsblJJZDRHODdUNTlz?=
 =?utf-8?B?dm05TTF1Q0dpTG1vL28yYlI2L1kxeWZseGZGRGVzbS91RkxWT3FhTXlITlJs?=
 =?utf-8?B?WkZjOGVFc2VDejM4WS9Ldjd6Vm53bUh0aW1WcjVpUWdndll2MDlIUS9Lc3hN?=
 =?utf-8?B?eSt4OU5aYU5IbndyODZyanF3NHJLQzdoUzF3dG80dDluaFRqWVptTlQwa1dN?=
 =?utf-8?B?Z3k0SHovSE0vZ29EVmoySVp2UzVuUUZUT0JLakliZHNSeWtQMFdkWUtPdDZM?=
 =?utf-8?B?M0pOdmwvbC9ueVR6YjlCL2pnZWdiK3FHUzNOOVlGR1dDZEluaFhscGJKV1ow?=
 =?utf-8?B?dXp0U3JZVmtBOWNZRDlzTkRSbzBzK2I2cmhoU3UxSWtrT3l1cm9pdmZlcCtn?=
 =?utf-8?B?S3hqSXB4aDE0NDVGNm5qVjZ1MDV6YUx0VE5PYUpRWHM2WTUyQU92S0ZGL3hh?=
 =?utf-8?B?TEphREZ0UjZBMkNQb1E5d3YvL0JKaUhmN3ZSZWdNVHZKLytQUEx3Yy8ycjll?=
 =?utf-8?B?c0paN0czR1ZDM3dJREcwMnBGeXJTVHpTRUVSck5mOG1pblFxNmhiR3c0ZDFC?=
 =?utf-8?B?SnVkeHc5MUlNMS9jWUN1VlBHYzdBSkF5TTB3SmNzRCt0a0lhV3BGaytETVBv?=
 =?utf-8?B?aHk0MEk4TzFQNUovKytqSXE4TVdIS2RFc3pFTUp2MCtkZ29GOGV1eEJvdi81?=
 =?utf-8?B?SVJ0Nk9UYW8zeEluR1lObjV3dkZDRktpSzVDWkpvMC9XVk9ycXl1TGJjSUE0?=
 =?utf-8?B?c3lYcCs2NnNKRngrV2M0RXpGY05RaG5WK1NXNTNpYlY2OHBQMHRiU0hWOTZp?=
 =?utf-8?B?d3QvS3RKdE1WQkVCOXdBdW1nMG1semVJQnlHN0dKS1ljSDdFZjgyQVBPQlFR?=
 =?utf-8?B?MmR6cmhnbTEzZm1tSnVSNE1vZG9pbDhPUGo2akpMd2w0dWNpZmlUS2t1Rkxv?=
 =?utf-8?B?SmlmRUtvM3NDdFYrek5raDFDcERadmJNNU43dlpVdzRLK3B3WnpwMVpqVGhC?=
 =?utf-8?B?bjFrS01ub0RZN09uSTY5MGh5OFU5V1MxZ0o1QkFaQzNpN0xrbG8zNGJXenBy?=
 =?utf-8?B?aXBka2tCS3lpMmlmZThsUEdVUllCZmNVQkI1emtCWkcyNEQ4VEVpQ1dPZ1lK?=
 =?utf-8?B?QlZrWDVRc3FjNXI5TWJSQXBOcXRTc2NqaXlmZFFXZkRQK1ltRzhaUnJ6R3c5?=
 =?utf-8?B?enlrYTNOWlBDRHA3L1BYSkkyczArSEhJamtGZ1gvM3VxdVBuYW9zQjA2TERX?=
 =?utf-8?B?V3l6VFJaRVI1ZWgwR2J1R25jN1dSdnUyUmxreDdwNTFMUWpmV3ZJbEtwcm56?=
 =?utf-8?B?UE9tL0kyN2R5MUhvNWNERTlDQmo4VVk4MTFGWUFzTTJUcjY4UTdLT1lWZFFS?=
 =?utf-8?B?bFNJbmp3M09tbVFZdHdhUjg2THAyMTJtMnFpZGtKRUVZVUNxOWwyeWRYcW52?=
 =?utf-8?B?cmlVNENBRW5PUFhxbStkRUtHU25VWjhpNGFudnE2NWo2Y3pBVU91VjI3M1NU?=
 =?utf-8?Q?nmvY/lQQvcHDH4wVCXq7kEyG0MjHTlT2UJ6Tnvmex9km?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2EBD863594CBD48959D869D5576D82A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804616de-ae35-43e8-f326-08dd7093dc7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 20:37:31.7859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DdekIVvNONmKJqEmKM/fAzjakPduy445hiMFjDgnXPY9XwU5y1+xbYcYsR0LQ6AJB1SQYxRUIRvBD3p+rEoGHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_133751_566125_0090154E 
X-CRM114-Status: GOOD (  10.19  )
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

T24gMy8zMS8yNSAxMjowOCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBBc3N1bWUgdGhlIHVzZXIgbWVhbnQgdG8gYXR0YWNo
IHRoZSBuYW1lc3BhY2UgdG8gdGhlIGNvbnRyb2xsZXIgdGhlDQo+IGNvbW1hbmQgd2FzIHNlbnQg
dG8gaWYgdGhlIHVzZXIgZGlkbid0IHByb3ZpZGUgYSBjb250cm9sbGVyIGlkIGxpc3QuDQo+DQo+
IFN1Z2dlc3RlZC1ieTogTmlsYXkgU2hyb2ZmPG5pbGF5QGxpbnV4LmlibS5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IEtlaXRoIEJ1c2NoPGtidXNjaEBrZXJuZWwub3JnPg0KDQp0aGlzIHdpbGwgbm90
IGJlIGJhY2t3YXJkIGNvbXBhdGlibGUgaGVuY2UgYWxsIHRoZSBleGlzdGluZyBkZXBsb3ltZW50
cw0KdGhhdCBhcmUgcmVzdWx0aW5nIGluIGVycm9yIFsxXSB3aWxsIG5vdyBhdHRhY2ggdGhlIGRl
ZmF1bHQgY29udHJvbGxlciwNCkkgYmVsaWV2ZSB0aGF0IGlzIHdoYXQgaXMgZXhwZWN0ZWQgPw0K
DQppZiBub3QgdGhlbiBkbyB3ZSBuZWVkIGFkZCBhIHZlcnNpb24gY2hlY2sgc28gaXQgd2lsbCBz
dGF5IGFzIGJhY2t3YXJkDQpjb21wYXRpYmxlID8NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQpbMV0NCi0J
CWZwcmludGYoc3RkZXJyLCAid2FybmluZzogZW1wdHkgY29udHJvbGxlci1pZCBsaXN0IHdpbGwg
cmVzdWx0IGluIG5vIGFjdHVhbCBjaGFuZ2UgaW4gbmFtZXNwYWNlIGF0dGFjaG1lbnRcbiIpOw0K
DQo=

