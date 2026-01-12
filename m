Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6C9CF45DA
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 23:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QeLZj+EqPpCZ31f2kwVZsXLse/fosIgeLuD0nLB0yRQ=; b=BdqOgwAZUzTN0k7guudPAPqMO+
	IKK88qZJG8Doe8JSlA7ZcFYNBhfSHZFBXPQM8nQ8jjp1L41WdvfSNsElrECmyhqjHlxtLQC/UeLhf
	v0bgh5022e2vLcT0EG2sF4ImS0WvPlecCg9VA7JfdysfC0GVwrB0TiTLV5A3HbaCt3KugSB9DKT87
	7XC/4sQrLq/4GhF4ofSmGyPzB2oIefSJqVk9OXl9J62zSTTy4XkhHOVSak71b0167xkKAT4rmNkXf
	euC1riIxmzElvsXSJiWqUusi7L8o2Ngd1QATqfstpkGyHotU/kwJzpi2H3pjOIs8l7UdmNX+mVbtY
	D2lpyH2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfRdX-00000006K3h-3pv7;
	Mon, 12 Jan 2026 23:47:51 +0000
Received: from mail-centralusazon11010054.outbound.protection.outlook.com ([52.101.61.54] helo=DM1PR04CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfRdV-00000006K34-3Kq5
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 23:47:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPaxcyLFA9tuPaIE7RUwDfiY0ARqzqMCGCGapO1u3QkXisl6SHfx+C97bzDOr3hSaZ+eu3eAnfCzZRrvr7Zz1dRMgpkqyDyGc4M89xBnGxZGQ++8hlwYQXdMaWuERk9tfe5kccKi1fluUaS8M343OK2ah09y5NtgoG/LXNfSkgkkqojvhgS5GRidyVwPmAOuNxSqYxqnAioTwpB4zKxKeVl75xdSKdCyKHx6e3Gfzg1eyhDK4spjVXgRuT5AJD2KD9pNQ3GcF4HZqCgoEIW3cjpld/oQuLHi/IuMl/22A1kG6DRfgmP9XbnT5QlR/xz/P0zHHcHcWprkY6gqBPiniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeLZj+EqPpCZ31f2kwVZsXLse/fosIgeLuD0nLB0yRQ=;
 b=lUX3VmC3DWA/8dAT3Fmb+/chaZ67719AoxDKe0RbBVmVea8SI0EFjpGDldm6DY5z+3VsSOUC9jbkY8Tn43Y0sTGl/oN3iuTmuELL+LpqSTsW7UKpG1+QwG1eoKMEntcgr5t1c0hxrEqxc9uPiUhwESqXtBo1kWQWw6xV+kwlFVR8AVthCvNB6g+e/SqsqzWEYjHTMxPybZD66Skv3vsWeN/03b+0wINgg/hTPO4YrXw7dfYXlt/hpg4SezqJTV6ZxuQb0zHKENM9CgbdqEz3NIxOHHq3Tp7yWu+6c8rolfgTVWaojW486YN53/mhr1s6QN3OGNsrTgo842PxyiCwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeLZj+EqPpCZ31f2kwVZsXLse/fosIgeLuD0nLB0yRQ=;
 b=pyvCFoIia+TVuMPAOw9CYF/MAbDsRQDnyPyLDt2CJIp/wFKWiBxi3Ry8U2khQjxef34UkBQrK36GxYtwkqfrTgGpLdxA6S9u/+V0RDJ3l78AaTdYypOojpwQEeujT/UBgZOddpBIDziTf+Z8rYZlLgY7ScX/SpGvJBx7VEOi2wWXwK4K7s6oVpuFCJNmo+HKGqNXRNdgz+C1C3B/ZybsyMS+JxJHSo4atpOYSpkOoRaAeQTCMagn1l+UiIR+RGjMsV1H+7vucM4GRwM+AlVbzPQFUhhIxk6QgzuNefOrdBYDrDIldFJZPRoxULN0XXWqlhnOkb17gKvZ1KhoRDrTUw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 23:47:44 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 23:47:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "wagi@kernel.org" <wagi@kernel.org>, "martinus.gpy@gmail.com"
	<martinus.gpy@gmail.com>
Subject: Re: [PATCH 2/2] nvme: add iopolicy field in JSON output
Thread-Topic: [PATCH 2/2] nvme: add iopolicy field in JSON output
Thread-Index: AQHcg7UrnhVvv9sqrUiTsPuSrHH0T7VPNEaA
Date: Mon, 12 Jan 2026 23:47:44 +0000
Message-ID: <176ebd48-3630-4adb-aaf9-dded3085bf29@nvidia.com>
References: <20260112111731.1631091-1-nilay@linux.ibm.com>
 <20260112111731.1631091-3-nilay@linux.ibm.com>
In-Reply-To: <20260112111731.1631091-3-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7467:EE_
x-ms-office365-filtering-correlation-id: fd6ae380-dcca-4e2f-6886-08de5234fb62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YmZPY3dxZDlmY3RhUHY5c1JMYjlkR1VOb3pTNno0OHZHeTB3aThuT0tIQm8x?=
 =?utf-8?B?b1BqSmt1RUZPR2V4VkVHbTdEOGRDV0F6ME1jSE1FaUdIdjc3eWw0dUZRM09h?=
 =?utf-8?B?UzV2eVY2SUVyM3ZVSEM4Z2dWcTRhckVadEwxb1EvUk14cXNMcWhTd29EVFhB?=
 =?utf-8?B?b2dLQzB1YVJVcEtsTERsVWMrNGc0MGF5cUt2MDJ1NzlpQnB6WVVIY2cwSUJ2?=
 =?utf-8?B?QUpZQVVUREUxVVdIUmNnZ0Z5dWVONmtDOVNBblZnNStPSmtxbjlnbTJDb0NT?=
 =?utf-8?B?QzFTcmVuV0FZb0ZabHJkQjJLZzVuWWE1dXRMMGFKSHFrVUJzSnA0Q2hzLzhh?=
 =?utf-8?B?R3Q1TGdoZlllOHl1QzVIVUhjdFRQOVRsK3V2UHBIOEI3N3FEanVhRlhRRm5D?=
 =?utf-8?B?N1pjU2QwaFE2WlFNZzdjZDNOaHJTNnNUSWpPWUpwK3REelhrdGJlQ3F6bVlu?=
 =?utf-8?B?enVoVCs4bGFwbHNGYnFFSHNVWlI4elk3UkxxTkFaUGYxLzl6TUMyWE9ld21l?=
 =?utf-8?B?Szc0OCt3eWxLS2ZPUGYvdkpxeXE0UGVpWkcyeWRvOGNLWGdWZU4vNDhFdjh2?=
 =?utf-8?B?Q3RualRORk1CQTJzWXFha0E0SUpuREJkNWhQTWY1Qm1UeUQzSVdmNWZDNldV?=
 =?utf-8?B?d3k3L2Y5cUIvQWtSWnZrdGlXVkNsUjZUZVNUVWg2UUhRYVRraEZBUzRoalUv?=
 =?utf-8?B?Y3p4ckszWmYrQ1BMTUdqV3lRUlphTnJGWjB1dURoZmlJdHFLTVNGaHF0MVNo?=
 =?utf-8?B?VFEwVkJnRndlRzQ5K0YyQWtjcHJKRE4vQ3g3dDdGTGxrRFVEUENHamtLOFFN?=
 =?utf-8?B?Y2NtMkVIWjFBYUtRNWg5bjJuRGs0SFlPb3FOb1ZYOUNNamxmOURnRytYeHVO?=
 =?utf-8?B?RDJlZEFBenFPTUV0UWZFeFJ5bW40OFhkWDFzV1FNVTNacm9rMWZPUGdtME95?=
 =?utf-8?B?WVVuU1IvMjF5VG9LSEJqT0tuRW53S3o5WExscVhndGNaNW1sVVozZVRZVGxO?=
 =?utf-8?B?MGhuTTB3VDBZamc1NzZ1bS81ZjRGSFR2Ry9kMzlhTzN0UHNJV3BIUFRFSU1H?=
 =?utf-8?B?UGdjZ0RqV0xMenBHRzV1VVRRVTZRY2x1Z29KVEFIWisyUHBwcnZmTU5ZRnlO?=
 =?utf-8?B?SHBsdFQwYmVhQUtpbmVKN0MrS2svT01teFFHWFFCaGE4aHNTVWM4dCtGWkdm?=
 =?utf-8?B?dk5kQk1Cc21MSVpIa0lmNGJDYXhuSmN2U2RwTmlBVVhVUkJETEZveTEydGl5?=
 =?utf-8?B?UkxoVTlsaXgvUUhJdDRjRXlGZS92d0UzRHBmdGZhQTZySVdtd0NRWTRGTGhv?=
 =?utf-8?B?ZUN4UnFpVmk0bXowdGh5TEpiSDdkZ2hGN3BmQ3FKY29zYkhxMTAwSWNEdXhH?=
 =?utf-8?B?VTJXVlNmVy8vZllJVlc5ZDRLV3llR2ZVMjlyK3diRzdML251d3IzQTI0enN5?=
 =?utf-8?B?WFpoM040cXZCS1JnMzJnZWM5ZlQ3NlNncFRjVHB6MzV5cERnNG5DRjVuSHdE?=
 =?utf-8?B?VzhiR09oL2lqbm9tV21idFA2VDcwbjR6d28zY2dZZDZmM2xDY0lMWU11WTU3?=
 =?utf-8?B?Nyt6bXlpWmh3YTVHb2hLdkh4M29taktxZ1ZzODJEVFNFK0JNVEVtR0V6ZXFm?=
 =?utf-8?B?S2ZSUFBCSmhrcUlXcjZZYzVzekFWUngzNXUwaGRQNnlOK3FYQ0dueGtodUxX?=
 =?utf-8?B?WkFVTWY0RmhBUFFWdGZ5V20yQmdkeTNIWFRhdVpLNkJHNjhBTklVa2RsRXBh?=
 =?utf-8?B?dlFwZHZwNUFQTFFJdW9xNzNUR1Z6Yk1zamtucmFtSUcrOXdnTHNaOTR6MWl5?=
 =?utf-8?B?T0tqVU40S2tGTEFia1EzL1A5ZDVqdjJISDM2RzRZZnpIbG9vTXp4all4TStX?=
 =?utf-8?B?YTlZNzVETDZFZ3M0dXRkL2Z1MjF1RDNGcDkrVTRkNUhaY1lqWjhRR21XSzZZ?=
 =?utf-8?B?RHNvelhPL0JMVFNPdjcrZlJEY1BqV21VejBIeEl6aGZUV29GYnIrMWQyRnht?=
 =?utf-8?B?WDRuNHptRlJoNkxXc1p0b3hvMHEyZUcvQ0N6QU9RV09QUXIzaGR6aVpNb1FH?=
 =?utf-8?Q?bkjxJR?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzZXQTBHdkVOTEpCOWVFQnh3TEZDRmVlN0lGYng4cEViUkhRNENtMVl6V3ZP?=
 =?utf-8?B?eFFFMXhDUUpRQkp3SFlLaXN6ZFZSZ1B6TUxhcHRkd0sxVEZlMlg3Z2V2YWx1?=
 =?utf-8?B?VHZaMnJyRnBFRktocVZxZEJ4UjFwa3Bud0lFY0lQTk1NYkhRT21yLytENmN6?=
 =?utf-8?B?U1E2MWVueDVucng2WUN5VkxGQzZ5SzBTSjN5SFpMNmpkOFlFenkycmFTeitl?=
 =?utf-8?B?QkEvTDQrbkYxaklGTTVva2hEZ1ZLSFZ1QVh3VThSYXBBM0cwblA3S2RPMk16?=
 =?utf-8?B?Tk45bSt1MERmN0d1YzFxOXBxMWVRcm9YZ1hoVEZjMyt2YmtQYkhvR0YzbUhO?=
 =?utf-8?B?OWFOYzVyM3RuV1JrUlhGcEJKMitHak1qM1lvZ0UyNkdEQXhPaDdZLzBGOVBT?=
 =?utf-8?B?QWZEcGEzME9xOU83b2IyOFU1VE9qSjVQUDd0a3YxT0VpejVxaGUvRE16VTkr?=
 =?utf-8?B?TjFiZVM0TzFNQnUwRXExUnA3NERFSU5GZ0IyMVhmalFQaWRQU2NldFRtdyto?=
 =?utf-8?B?ZjQrcnY0cDlWcmI2aUtKQWp0SVRqdXI5Ym95eVNiYWhWOTdtSWRBTHpmTmlM?=
 =?utf-8?B?NW1BYlZSTkpuOVZQd0E2bUZ1bFk2cHdIR3pEYTlScDBYcVJIN2k1NmYrRWpr?=
 =?utf-8?B?S1JWQlQxUy9MNHBrQVg5c1JuL1NGV0xkZDdFNHVyUTVEYm8vVW0zYzhGUHZa?=
 =?utf-8?B?L2x3N1NIREVsYW1BcFpHdmdESVZqVHpzTkFRLzM3SmdUcWR6bUwybmFjaXdE?=
 =?utf-8?B?a1ROamdpNFpsWG1NWUNraDIrOW54U2QyQzBMR2FaUEhKNHlVbHF0anZZL3Z5?=
 =?utf-8?B?RjVLTlNjMTh0Z2dGNEJEaGtLRXllcmsyaEtqVmRCWmdoM0RnWVlhejE5SDhh?=
 =?utf-8?B?aWkzLzNxQ2ltU0V1REVHWnVZazZDdko0ajY1Y1E2Q3Z1UVdWblZ1RU1wZGNw?=
 =?utf-8?B?ZFFYTFlaMzRYcGIwZDBPZmxZSDdMblNOcit2dXlOZzhpaVhoQUpKRGx5Q3lw?=
 =?utf-8?B?UHoxVEZpNG1ZOVRybXlrSEhMNkh5ODcydHBuOFl6V0RZSDdWcVRUZllESVQ3?=
 =?utf-8?B?WDhieHZINmVod3krVVBFQU5QRXhOOHB1b3dOUnhuTjlDSVVEZ1RVQ3lWc21u?=
 =?utf-8?B?ckRUV2tsWWtROGpOa2NUMGEwY3N1QVhQb2ZhRllQZUdGOGJERmNscUZtTVVw?=
 =?utf-8?B?MmFaZE4wVVltbFZobWdCc05IYXg5TENlRXZwUmpMYXlxakRqMVBIN3BjUFY1?=
 =?utf-8?B?OEFtWlZ0VUI0ZXl5S1BDMk1qNDRZQUJMWkpIcVd6SnRHUGZFblU2REhta3BW?=
 =?utf-8?B?aE5oeC8wV0o4cXVUOUpONnlyN0sxVkU2V011Z1M4NWhsWFZSWEk4MWpwV3JJ?=
 =?utf-8?B?SG9ac2l2OC96UGxXNE5OcWl3QmVzT29hVGt2YURZMk5vNk9leXhhN3VzSnIy?=
 =?utf-8?B?eERmYmdkSStWUVpKNlQ1c0xsK2UvQ3lhKzc5TEwvWEhEMXpPZm53K2RSTkcx?=
 =?utf-8?B?VldBTTJDaVAwOU1neURGZmx6SFR6R3hNYmlqZ0pzZGd0NTVETjhGazB6cGN6?=
 =?utf-8?B?S080eEpUemdBTWtMc2NkbmRyK3Q1U09uUTJ0NXl1T3ZuZ25vK1pVdklvN1RN?=
 =?utf-8?B?cXVhbWxxLzZHOGJuSjF4clJ0bitaeWprTDdIZ3dmVmVFK2JPcGkrMGpnYU1I?=
 =?utf-8?B?cVJObVdaa2dJbERPODk3T1YrZTh0bnZyWFVrTXNnWnBValdKYUVIVlhTOHRk?=
 =?utf-8?B?eDZ0ZG5sazlmUmNwR05qY3B0Qm83aDg4REN3WDJJOS9JYzU2YnJsNWd6WTlJ?=
 =?utf-8?B?OHJHcHdGZElYUVFYblIrekQ1aWMxMUR1LzdXRmJNU0p0aFNCTi9xaFdwVVZR?=
 =?utf-8?B?QTM1bGZMVFFnQ2xGdlN5bnZYVkhYZFpqY0Q3dzQ1MkRONFhmblpCampMOG9N?=
 =?utf-8?B?YWVkMjRKK1VLYUMzSGRDNGl0MW9NKy9IWWVIYU5hczJ4WmZ0Z0dsc2xZWVdN?=
 =?utf-8?B?L3h3RUpodmJ0ZzhFOUVSR0Zzcy9tREhIc09SVFhnUXFCaExRWThWdHgybVR3?=
 =?utf-8?B?WFpLa2paWVpjWGJwWUplOG9MMFZDZjdoZHZIOC9yb0RxWjRoQkh4K1JXZUs1?=
 =?utf-8?B?NjF6blZtVS8wMUd0M21BQUd3UnBUd3dhUlpYQUFkeE13MnNuOXBPUXB1SHJm?=
 =?utf-8?B?UnN1SzVvdWRrTENUaHNLRkZLY3lXbFJrME80cDlyajF6S0E2RzlYVVduc0hn?=
 =?utf-8?B?SWRza1lwbU80K2ZIODBMZ0o2TjI2d2xuQlRUci9XYnRDREtocXlQM25rb0py?=
 =?utf-8?B?YXZrSnJDVEV1emc4eU5zUTErMWRsYWpDdFIyQWRsTnNMUjhSWG0zVjk0bzBI?=
 =?utf-8?Q?OH8XAs55xqUq6T6o5klLG7E6l50VhgjNKP6l/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECC0B2AB8601644F87A27D391E09E59C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6ae380-dcca-4e2f-6886-08de5234fb62
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 23:47:44.2389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: biqL91AI1NxA0YHpa69AR6KCPfBVWWefowkHeZdnZVj2k79fmLVTrpjsLElBk94nvUO3EddKHrAKUMORNHjpPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_154749_839210_FC95AB40 
X-CRM114-Status: GOOD (  13.02  )
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

T24gMS8xMi8yNiAwMzoxNiwgTmlsYXkgU2hyb2ZmIHdyb3RlOg0KPiBDb21taXQgZDBiNGM2Y2Yw
MDA2ICjigJxudm1lOiBleHRlbmQgc2hvdy10b3BvbG9neSBjb21tYW5kIHRvIGFkZA0KPiBzdXBw
b3J0IGZvciBtdWx0aXBhdGjigJ0pIGV4dGVuZGVkIHRoZSBzaG93LXRvcG9sb2d5IGNvbW1hbmQg
b3V0cHV0DQo+IGFuZCBhZGRlZCB0aGUgaW9wb2xpY3kgZmllbGQgdG8gdGhlIHN1YnN5c3RlbSBo
ZWFkZXIgaW4gdGhlIHRleHQNCj4gb3V0cHV0IGV2ZW4gd2hlbiBzaG93LXRvcG9sb2d5IGNvbW1h
bmQgaXMgZXhlY3V0ZWQgaW4gbm9uLXZlcmJvc2UNCj4gbW9kZS4NCj4NCj4gSG93ZXZlciwgdGhl
IGlvcG9saWN5IGZpZWxkIHdhcyBub3QgaW5jbHVkZWQgaW4gdGhlIEpTT04gb3V0cHV0LA0KPiAo
Zm9yIG5vbi12ZXJib3NlIG91dHB1dCkgcmVzdWx0aW5nIGluIGFuIGluY29uc2lzdGVuY3kgYmV0
d2VlbiB0aGUNCj4gdGV4dCBhbmQgSlNPTiBmb3JtYXRzLiBUaGlzIGNoYW5nZSBmaXhlcyB0aGF0
IGJ5IGFkZGluZyB0aGUgaW9wb2xpY3kNCj4gZmllbGQgdG8gdGhlIEpTT04gb3V0cHV0IHdoZW4g
dGhlIHNob3ctdG9wb2xvZ3kgY29tbWFuZCBpcyBleGVjdXRlZA0KPiB3aXRoIHRoZSBKU09OIG91
dHB1dCBmb3JtYXQuDQo+DQo+IEZpeGVzOiBkMGI0YzZjZjAwMDYgKCJudm1lOiBleHRlbmQgc2hv
dy10b3BvbG9neSBjb21tYW5kIHRvIGFkZCBzdXBwb3J0IGZvciBtdWx0aXBhdGgiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBOaWxheSBTaHJvZmY8bmlsYXlAbGludXguaWJtLmNvbT4NCg0KTG9va3MgZ29v
ZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoN
Ci1jaw0KDQo=

