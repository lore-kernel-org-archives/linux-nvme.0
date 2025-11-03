Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1026CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 20:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=znFDSUYIojXsL1uxr8JpJdqtVP7oyOkFKvGpbehpso8=; b=Y2mDqh/Spgmh1DP5E37BrTTz8A
	1gSTNL9olTBlBl4wOTTORsYZNyNYXxYnmUhDGdlPovr0Po1KknweC5YBJCCXG1i7pteo7Yg0pWo+A
	/9QUDIVb5di0MVl3rIh6HGyV1VPI6YdWmdrxZ24jvfzkunsMEgyyJCTJdTsVvknGNhCCc7+o5JOoF
	+2YwdWNr/W5tYOF2aXa576l09XySuzVolaTWETj0u1B7kC1V8SWZu/tc7vuW0UoczUH57zc6jFXKk
	xxzIF6mH5P8Z1M5v1Z1LTyn0uVQ2AaTI9Yvmtd4P7RddZn+9kygU6C/LcS0uRd3hDM223d9vlxLlS
	opLBYM6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG1AP-0000000AbEQ-4A5l;
	Mon, 03 Nov 2025 20:28:41 +0000
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG1AO-0000000AbE0-0xgP
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 20:28:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUR8tmOmw37rYbWp5G4i6glXqK5nmAYHfH1ls9mVn1uR+Knxz1Z8lAfNVKVaU1QCityqT3tC6ZISvX1qUfiOncjyjADvATire+aqctq2tUqzCxa9AhD/rncc+edolIGN/TZzsPy4XAe6nPbqvpGglqrUrdF3wY3fpRYW1Lo5cvJHwO1qGHzNntuHBvy5gmoyA2o9S9pq61UhzwlljwlHGtl+lqkYAW42ySW56y4Bm5WVdbn3WxTVkZ3L0acn1KnAs/rHeHfQJxdXMLF5SZd3NXchtK8BKbH570qhZ+HWgfevtz2CeUjc1InyfpZo9B9/aqQFpybA2IB8Ly0XtSh5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znFDSUYIojXsL1uxr8JpJdqtVP7oyOkFKvGpbehpso8=;
 b=MBQpv53Nc4RBr45Fca1ifIi8g9at5uyCw8xr9dkKp/BFLTXGsJLFg3Qrng78lsxJyraR0bWVG0jx0STLR6fb3ZG82YQmePIV3hVcTTsjvOFSTBzG8JtsWne0tvgidR77x58YPAzHvzyfdTfSwWU7sZ+aRoBaj5J3AHMVBWpgfsh2iZMgLSc0f2rp69O0BjAHLUruS6jS+1lPRWidgjkrDFVy+JJdnkrdFCkf15N5ii0etRX5SbC9m/epRqqAXxwXd96kgGNN7OOrOI0pOEzUaHZN0KUHhMSc2Wcz+nMLr90NY/ffd2/vP6uNwXZdzKAESprOrvvIEx+oeFqf8kk41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znFDSUYIojXsL1uxr8JpJdqtVP7oyOkFKvGpbehpso8=;
 b=uK1NrPstrP5MErYNVCDgG6M+d93dLm0Pv3vsfFFg1K5Iz/p7Ihua7da6JeeiDYcmDUT948NRENwRkJeT8aBXQybdlEWoYkK06wI8hemIC2y9r4P980o2wloKEsEEGWcDa8KRqNRRw7kWzj787sXaQKjYOKcpWoP0ANsRewSyIIT//rRIR7n5Vc7auxGGmdSW6xB5CIHaLysnGCOlw2ei7AzJKCcge9zBmYyGhVetn6THTHxQc7ZfqA50AXbUt5ESeexxef0T+l3P6z1yZGy5qoJbDCz1OI5Gzuz/J0fVc50wUA4LQ3R5z3yWeTp27R2JvdhfjSHjQMZlSo1PvPxI3g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS4PR12MB9705.namprd12.prod.outlook.com (2603:10b6:8:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 20:28:35 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 20:28:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>, "hare@suse.de" <hare@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-auth: use IS_REACHABLE for nvme_auth_extract_key()
 declaration
Thread-Topic: [PATCH] nvme-auth: use IS_REACHABLE for nvme_auth_extract_key()
 declaration
Thread-Index: AQHcS6dOT3rhmsQbb0GfUm6eWoYK8LTg16OAgAA0sQCAAFFbgIAACGUAgAADdwA=
Date: Mon, 3 Nov 2025 20:28:35 +0000
Message-ID: <ade91e2e-be74-4070-9226-a750e3eba32b@nvidia.com>
References: <20251102031742.69984-1-ckulkarnilinux@gmail.com>
 <20251103114621.GB15280@lst.de> <aQjCQKiN5mzw2oY3@kbusch-mbp>
 <3bfea609-ad1b-422a-b070-9e9604777a8b@nvidia.com>
 <aQkNims4uAaUKcyJ@kbusch-mbp>
In-Reply-To: <aQkNims4uAaUKcyJ@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS4PR12MB9705:EE_
x-ms-office365-filtering-correlation-id: 17b9e9f2-109a-4e6b-3ab9-08de1b179047
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OExvbjJUai9GbGJQbVNheTQ3SXYvZlFlSnlYbGtLaXc0U2ZXUlpabHVDSjFa?=
 =?utf-8?B?SzNzd0F1NVVJRXZXazVSbkVhN2FxUFpCcnJBN2tBREV2TWs4RWgreFFPY2FX?=
 =?utf-8?B?SEpiWXhncE5ZR2p6a1M3K3h2bUZOSTJBVjZHcDRTQVY2NVZnZUgzWlBrTnJ3?=
 =?utf-8?B?bDJCNURlaXVqY0FRMldKYW42ZU5WTkJBTDllQ3RoZi9zcWxOZWhONTVjRy9T?=
 =?utf-8?B?cC9ISkJlK0djY3NnOEY4WW9oaEw2eTFvUjRvOUMrRjFJSS8rYkRzNGFLaXlI?=
 =?utf-8?B?azhIN0NBei96Y3dEVzNHRzE1ZWs2b0FCUUF4cUtNdldDcVlmL2ltdW5OQTlu?=
 =?utf-8?B?K05jR09HS1haL2JOeTQybkpENVhiWmpPTWNEbjJiakJxaUp4aFo0TXhsTWtR?=
 =?utf-8?B?eW0rOEtOTzZUQ1M0Um8zbEptNmJrcU5oV1pBbVZOVkJMUFMrUzhYWUNick92?=
 =?utf-8?B?ZjlwbE9PM0dLQ24xSlZFb1JZSTQzR3lTZWpPTkFqSmhyQjBGTHVJZnlVR3Vz?=
 =?utf-8?B?SzJLck9vSGxYYmFFQkFNRUZlVGdDMlp6T3ArdnJ0Q21tRGhTT3lZR0VlbkU2?=
 =?utf-8?B?NTlpei9JVmMvdmV2aU9zd3dlbktxWUgrVFRHOTFSSk9VdDRxWEZkRWVEQTRy?=
 =?utf-8?B?NGFIc1lHTURiSVN5QjBNREhRZWVKNlNHSjMyeUtjWTdWRWhkMWhXeGxDT04x?=
 =?utf-8?B?MVkrWnd0enBrcnFva3M4dzVna0piT2JpQStWR0N1MUxXRGdjbEw2Uno3TlVK?=
 =?utf-8?B?RytldnhQM1NVRE1PYkhXV2plYXZKVVVSUmg3cE04b3ZzVDJwZEo5aGY2ZEZF?=
 =?utf-8?B?TDUvUjg3c2xFWnV1S2F3QklSRG90WGd3dEZFSWVGOGdIdFBzTTZjYmZrMjdn?=
 =?utf-8?B?dE41c2dheThRUTdSL2pVQlIwL3B1WnBsY1VkeEFHWlpPQU9iMGZZbm9waU4r?=
 =?utf-8?B?d1dsV2tSYnFCYWhpZ1FnSlVtSzVPNUF3QnlDdlVsS002dlR4T1ovOTYzcWZO?=
 =?utf-8?B?cUR4dTh0UmtPR3owaFRORHFxbmlrYmQ0Y0J5cE40aXllK2tiSzgvRnByU3Vl?=
 =?utf-8?B?RjQ5Ymd0azVpV1R5UHZMWkgzZ1dURHdRMGVhS3RIcHVGdDhoS0FrRzU5Ykw4?=
 =?utf-8?B?VGV2V2NxeXlzT3FvRXQvWmNnN2N0aWtPcksyYXNtclJCbk8xWWttVm9YUlp1?=
 =?utf-8?B?OEtJZnpFM0UycUxXV2ZsWUtodUFUenlHOENib3Bwc3FvUGdyWVAvSVZFU0g3?=
 =?utf-8?B?SVlKajZ1ekRqOFpkcVVmZFQxZjBpakZVRitKNStuN2NDSzdES3hxZnd0eEtU?=
 =?utf-8?B?dlBwK1liNTNLMzJtRXFjZmZwSFJyQVI1cmd2VmxDTHRma29nVVpZa0JFcUQr?=
 =?utf-8?B?V3NuUGtVME9PS1dPdkwvN1JXK1VlZTJFdDF5cHpOVUdvTy9mc0I4dlorSEU3?=
 =?utf-8?B?SzBJaGR2WHpKRVFDQkc1QXBsbTVCQnFsQkhkWlBlS2w5ckdHZkpsdDVtWG5r?=
 =?utf-8?B?VzBFOXl3emp3YU9wZDJ6K0Iwc2s5alMvSzFlV0grQjF5S08vdjNlMm54bG5B?=
 =?utf-8?B?RysvSU1RWjh5UmNYRE12bm1zaUhoRjN5V25wN1ZucGVUbHpRMkJRUGxnTEEr?=
 =?utf-8?B?NlpLZzJSR2hOWCtEbWtZVWFpcjdCQ0JBYUdsWHA4d3hwT0huRzFidDgzMUJ0?=
 =?utf-8?B?UHNFcGd1QUxqKzBWUUhqaEZCOVgzSURwNTQ2Z3ZqL2ltZ0Z1aTVTL0haMDRE?=
 =?utf-8?B?QkpOV1Y5K0EvenljQzlQb0U0RC9wTGlNeHVmNkx6UCsvZGlaMVJUOUttaTJI?=
 =?utf-8?B?aDIrcFczbDN2NityUHpZSmtJU0VDdVhSa3BjYWdrQ0piMG5DYng0L01sdkFz?=
 =?utf-8?B?eS9KSWFaWk5janFMTUJSN0puTWIyUHRIdi9oYktESUlIUGpOQ0M1RWNhUWFm?=
 =?utf-8?B?WWN1b3VoYVVhMENBODZwMlQxOUxSTW8wNVFxeDBPNGE0dmhoUXIwL2V0M2xP?=
 =?utf-8?B?aHFoNXdzT290bWtId1ZVdURRaU1odUwzakdnOENGU0dMS1FKdFNaKzh5ZGY3?=
 =?utf-8?Q?q0pXOs?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rlh2bEJkN1pObHQ1UmxQdy9UallaV09Uc0g5Y2FSWTR0Y1BmTWhKekFmV0JL?=
 =?utf-8?B?N2hJRUhzRnFDa280cWxXcXdPRm1uekllN05JbFE1YWNWZDFsWjN6V3BNOEx4?=
 =?utf-8?B?WFNGaU9XUDUzRUs3ZEJDV3d4bVdhWThFMlBwMFkzSUNPMnAwakxCdUtHNWRk?=
 =?utf-8?B?ZzNmTWRqYkxVZTBLL0pwWmpNT2pGd0ZiOFdyR2VIangzOTdFTmgyRk1wbHpp?=
 =?utf-8?B?S0JsQmpjVFJqZFJockl4NTlQT1dkQ2lxWHBadElQN2tlUDIwL2NqL21DclJS?=
 =?utf-8?B?M0Y1MGMzTzNYUHpVY1JNVmNIRDZieVpKcDFXTTV6SFpuL2plSkpQK2dQbXdi?=
 =?utf-8?B?OWR5OFYyMXNJYjc5V0pMdnZ2Mko0cDlDZUR2Y0RvNktSanQ1MWtNTGEweXg2?=
 =?utf-8?B?bytrL3NoTENvY3RSeTFMOFROTEtRaUlNcHJNZmFsNCt1KzJUai9KcVh6a0li?=
 =?utf-8?B?YXNJSWEydFdxNU1VMjBTTUtTVVU5aWRmVUVWLzFKTzlIUXAybzdBUjh0alA3?=
 =?utf-8?B?N1BGQ3JlQVZBT1VRa2VJT1ozaURkZlkxa3dwSE5iWEd6ZzRrb21UaGhLd05E?=
 =?utf-8?B?bUtyMlVoaTZ2V0U1dCt5NTkxZFVLd2JnYjFHVjJLdzlGSVpoN2t1OXVsOUJU?=
 =?utf-8?B?QVJJc0g2VzlDSmVkbDZ4QzZiNFd3WmFrdy9lLzVnY2g3b0J4SGRyMVhicnhv?=
 =?utf-8?B?MVM3ekpTdXRkcVRZUy9IZnM1b2JvUW00dW94Q3doNEZqRHpZaVU3OXI0QXNW?=
 =?utf-8?B?cjVmc1VFNC84Q3JXcmhsaUUvV0NDa1hiVWJvQjBSSDhXRGFwSjNnMXFucDNl?=
 =?utf-8?B?T29iVnJGcSt1UEVHbDBNdGZJdFo2aTZHN3lHK2k2SjNtMndXeDV0UE4yTHZ1?=
 =?utf-8?B?NCtkaVNPdnhLNmdRcWpEQzBzMytpc2JPdlN3aC9SZzlHOC9LODFpNHNwWjN3?=
 =?utf-8?B?UkUxZDEvM3BCYmQrbXkyV29kY1VTTjBZd282MHE3cVFNOFpJeEZaSmlmL3hn?=
 =?utf-8?B?S1RabG1rZjBTc09mTmRlSTVDcTRpa3FlMGxWNGoyanE4a1ozM3ZnU2xVQ2lm?=
 =?utf-8?B?T01EMmFGNWlTa25XWDZRRHVPRlFoZG1XN1JEa0cvRGdUYVJoTkpsWUVCNnJ2?=
 =?utf-8?B?dW11WHJMdHNYSWFSdmx3RGFFanRUeDE1RkNrZkV5dWFwc253MnBzSEFNZzlP?=
 =?utf-8?B?b1hmTTdIclhwVCtCMzFhbjBPY1R6RU9zbWFVT0VaNDh1OGhtTDZ5ZjkzU05F?=
 =?utf-8?B?Y1BuZmFHV3B4bDY3KzNmSkJxNnhXK21KZTdHaysxQ2U5cTJMYkcwN1g4b3Rn?=
 =?utf-8?B?amxHYjNFenZaVytKRnVHK1JkQ3VYbTlSYXExVUZMVnNGRE41dnFVUDc5aE9D?=
 =?utf-8?B?eHlSSXFmVG9iSkpEV3p3a2VVclp0cTFPZVFwZlJlaHMxUlJjako4LzJ4Q2Mx?=
 =?utf-8?B?SFhHcDl1MS8venBKOFBsejNiTnhDbXVvbmd5c3NPMWpOaW5TNytseWNmMElK?=
 =?utf-8?B?NlQzQVYybVhVcFVEYWJ2cGlLS1krdmZxNkdKRkxQbEtmSTIxbWhMMEZuREw5?=
 =?utf-8?B?a20wV1FPZG1pK0VmVUhtanZ6SlltRGgvN2pZbk5QT1pMWGZjTGlWR1FxVzdh?=
 =?utf-8?B?aG1GMXk3WTJGdFF1dXhGaUNRUFhIa2I4KzJwNGJFV2JTbWlwYXhwZmkwK0hP?=
 =?utf-8?B?UGZGQWxyeDk1NEFHQjVpZHFZSVVCQTRrMXNwamQxWnUxTGNldGhiQko1am8z?=
 =?utf-8?B?NWdoN25TdnZoeEk2WDJUOGZIR2JWVXZaLysrL0VPMWpaekxHSVdTU0hQcTFt?=
 =?utf-8?B?S2FBQSt3dGUyTWFULzFQOVUraFpHRG1LTGNEY2lWdTlnNmx1QlJic0R4SzdQ?=
 =?utf-8?B?WEpuUTRzMGoyNGtHcVp1U2pkbmFRRG14RmFLTWU5Z3NKQlNTOFpBY0d2ZWdy?=
 =?utf-8?B?S1NSMHhCZjM5dUMyQ3hFSVV2MHdncGRDb2RMUEtBaUFaYWVTMHVRZWVRYWtK?=
 =?utf-8?B?NEZ3VWF2QzJmM2JJM1hzUHBCWTBhQWQ3NmRxaExJdFRTZ0Y3ZUVPdXlmSjVM?=
 =?utf-8?B?SUlDUjB6SWY0ZnNYTkF1c05NK0U5YjZUUm55eERRVXZvTmZpMWc2dEdMa0xv?=
 =?utf-8?B?eTV4WktENjVuS3BhQWNSQURFbjVOWU1aTDREZUlzL3Z5elREY3hJb01HOVMv?=
 =?utf-8?Q?lHSEadUv3UVaVTHryWU7n3Xk5yXii62u+Vy31E8ksvI8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDB9E53CE6B9C14EA8071B8A7AB1F7DE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b9e9f2-109a-4e6b-3ab9-08de1b179047
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 20:28:35.1551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aImTSquyv/uQTmc1NokPdIl2zr+KuS3VCVQEzsHgaobm0g2GJlOZ8pxUJ5PiEWMbm/GiAT+f6BuEph+IrTMlqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9705
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_122840_272638_2673D3EC 
X-CRM114-Status: GOOD (  11.52  )
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

T24gMTEvMy8yNSAxMjoxNiwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIE1vbiwgTm92IDAzLCAy
MDI1IGF0IDA3OjQ2OjA3UE0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IHVu
bGVzcyB0aGVyZSBpcyBhIHNwZWNpZmljIG5lZWQgdG8gcmVwbGFjZSBJU19SRUFDSEFCTEUoKSBi
eQ0KPj4gQ09ORklHX05WTUVfQVVUSF9TVEFURSwgY2FuIEkgcGxlYXNlIGdldCBSZXZpZXdlZC1i
eSBvbiB0aGlzIHBhdGNoID8NCj4gSSBqdXN0IGZvbGRlZCBpdCBpbiB3aGVuIHRoZSBidWlsZCBi
b3QgcmVwb3J0ZWQgdGhlIGVycm9yLiBUaGlzIG9uZSB3YXMNCj4gcHJldHR5IHRyaXZpYWwgYW5k
IHRvcCBvZiB0aGUgc3RhY2sgYWxyZWFkeS4NCg0KDQpvaGhoIGRpZG4ndCBrbm93IHRoYXQgd2hl
biBJIHNlbnQgdGhpcyBwYXRjaCBlcnJvciB3YXMgdGhlcmUgLi4uDQoNCi1jaw0KDQo=

