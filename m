Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080AEC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 17:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hycWvr2J9p0VNrUXxHKWzRWpJvB0N97WmHmSvNP+S6c=; b=1fxW1tiM1y2F+9Dhi3bLqmeOFe
	zBysasZvKx1lDS68F6RNZKsKveCXqiAuH3J8yN5Q4n813ltGtQ0FDQZ3YwgzceP9Z2uEsLNEWzMz1
	fwLU39dXX30Npg7R/4grCRDUwLzrkharILetNj48RKZ8ExWwvq388KKgniTkmjvGR2Lu208IyUONH
	09TqW7/tcip2OzunVXtoU3q1zB+vJp/iGWITl/+KTfAB2EdPrSKEpz+PixDVhQiyWnUmrvf5H84Ku
	26ehNS+Bb40s+/z81++7KvJBpL14HnS3AJfgawmEtSAjX13YzbMM/EIQbEdTjVfYmhTDE/Uhts+n8
	BjSSvdAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouzR9-00DN38-8N; Tue, 15 Nov 2022 17:09:27 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouzR6-00DMVl-1G
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 17:09:25 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFG055q008979;
	Tue, 15 Nov 2022 17:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hycWvr2J9p0VNrUXxHKWzRWpJvB0N97WmHmSvNP+S6c=;
 b=ftsmr/18ZWK/7W//uUmRrgWDABdo93E1fVZm5pZ5pjHI9BOb+1kc7z9X7ZDbcupC4eE1
 SA0nH99ahTIflm7CnKYpSHC7cTSK4qAYz/ypgn+BRAmf1WbrhlpokUDEnUa0tnK7eXJ/
 iWiF03kG0jX7bsTvzCUvrZZiT4woToih19wya6Q/K43BJ3uxZjpeNL5vcEKdNmv5BluQ
 xOqYUkJs5Zv+r6+T+fRnhQAW+3eVpbXw87oeLZAXFjXIpkH6sVZ7qvnLuY4SKel0nE1Z
 jtYqXf16sR8YiLkEyVua8NGPJZUG9Z/V68Cb8SRlTmWKDRvaE347KU0966yL4T8TlVvR Kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3jsj3jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Nov 2022 17:07:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFGUhYq004843;
	Tue, 15 Nov 2022 17:07:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3k6ux6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Nov 2022 17:07:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHv5jSCulWAzRWORW44qNbFO38DUw3Yzg5WR9Nn6y+PbV0IuhoW8l+y3bVRWZ4kuuM6wRA+lucQ+ozQ/Sr6qmR/5SOENq4OvYUSTlDsK/D85LSOGEUq+QdvTeydpMs9DpooEBab423LAsc83XpkgcLoBVlH81k9sgVCD6/G7XDprQhWdsszvcGLFKqO2d3BJGKws/0ktiC7mKy+L1CkUjh+dHtFEE7Roi8Jfg+fu/nkZkiAaQeA4w9ku3b30lvmVSli5ygLEqqyNQYB2GjkppfVoLly/TU92A3owBWSsxincDYrPh17iGJSujgHLf/50OWqtG5gpI2OfDuFLEEHuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hycWvr2J9p0VNrUXxHKWzRWpJvB0N97WmHmSvNP+S6c=;
 b=BF3raYhKLIPBLMMqO/wpagOpJjzC/fLl6T3LG5HntpYPwJATX6S7gtq2d7I81Z61fNb+zpgznr2YYbYw9+GUQ8jZyfLU7mHhsi3w7jeXOKA+ghcjv07R5mWFh5vocW+xCUqExQN4XfHPeUTgMtuFUv03xO0cpmmy3LjMfIlD3Ss4Wp8v7Tki/WI3V3h0AEJ/pF3560ZL04DikQhpHod7uYV2srOqkbXjVbcWbwxNoXrrL2aVcOVKGAbg9oBPC9J/w40HOooS+eJPY6n0aqjiHjlDAPphFiGeAWWdBXxkDlcRbXlibafNfjl1kpXLUUyWaMVFPxQmA/oqBuPsIR/AqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hycWvr2J9p0VNrUXxHKWzRWpJvB0N97WmHmSvNP+S6c=;
 b=Z2oWKbDWwel4r9n/RrKdYC3DkZ2pnFa9DPv32eBseuJaHZK+Mz/onMiMYpaka++Xqujy3s7Lw8EKNOkDbdeIZk66+zItpGR/9+YJ86Iwc1wqdD4emn1dMvSnXHH/37nxC/nzUCxB16oztKdHWui8o0L7hH/1U6+HNqifB469CkU=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DM4PR10MB6813.namprd10.prod.outlook.com (2603:10b6:8:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 17:07:40 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::7f62:c8b3:46e4:ed1d]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::7f62:c8b3:46e4:ed1d%9]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 17:07:40 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: blktests nvme/039 failure with kernel v6.1-rc5
Thread-Topic: blktests nvme/039 failure with kernel v6.1-rc5
Thread-Index: AQHY+Joo+0qmAtlReEOjnYEBNEp0Tq5AOFIA
Date: Tue, 15 Nov 2022 17:07:40 +0000
Message-ID: <3F179083-A3B2-47C4-A1BC-5880237F1CE5@oracle.com>
References: <20221115022958.ycu7i46vler2n6xc@shindev>
In-Reply-To: <20221115022958.ycu7i46vler2n6xc@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB5550:EE_|DM4PR10MB6813:EE_
x-ms-office365-filtering-correlation-id: ac805c29-2aca-4606-eeac-08dac72be720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  NOJ2Mfpzatfd6ArZ2Qtl3IuX2AsnXqJzspuEUWrNEWvC3zW836aVcNrmUfwoCH5rIGcLfeJ5H4C5JsI5Wpbq4+oEMRWRn/Mht7yaEP0zl9tlR0BADWUFPhdI2SjqUwOy/PdfVR93ywS9ukcXK4FWEYrLTcdGFss7lzmwCu+XzsgRl4hz+pUA2BLvnoofGkmdXT4zSMnkajguv7Xr1cqe8Dz0gRrZoJYI1xivkdIZeSL97qheC9j2mO0eKJQ2949U84hFcgfsoweQaKlxYcV2VLtxo4iTgxKvBIauxl8FDUTkJvSTqkfg6q6jJnXHwlyDKYkTD63tBEG+UNYGqlUYBLLvBdStnqGf8dCwpptStCbcWzx2GeoJ0kdIa4Kwg7MJ5C/bB9hSejnclk1JIobO4uixm+r1zKPFHu1cMLjkMXxvqErbmypoeTqeMyhH15YwbVlY5AQAAmIgrQqkQcNWxe/rFGCfuXDxkThx5YTltmbKJ6fQWiEASrDQEqT8BLcgHZEq0BvvXBx90j8K801QJJHnTcIwlH5SX4CBGbd7LRpsboQvmRtaMnDgTwC0Qe5cjEyI+pVSXWhtKhKWhljh8ZR8mSVbWiUTNlq2rUnCDtF3r1FLcXBxbv15na1yjKErsKOPbDfBHOCxZcZTP/ouxfP6tFBfpwtf3nQF4lRBGlFYhaZCv3iSAF8JdD7RpCNwkl83XCE2uhbiXXY9J7QgFINLiQZWvC1/m6vIXQmAqGfNOokX2yuBEadwrVNFLOSpbC+REv8qB5xv7CEe0uSAZTO7y1hKz79L42nuZ1d1RCs=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199015)(36756003)(83380400001)(71200400001)(54906003)(6506007)(6916009)(316002)(478600001)(53546011)(38070700005)(6512007)(66946007)(66476007)(76116006)(66556008)(64756008)(66446008)(4326008)(8676002)(33656002)(122000001)(91956017)(38100700002)(86362001)(4001150100001)(2906002)(41300700001)(2616005)(8936002)(6486002)(186003)(5660300002)(44832011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?amZzVWFGVE9VYUQvbGUxMk5oSHhvUmZyWVJmZitrcGZNczAyeFI2UnREMjRV?=
 =?utf-8?B?UWZMODF1ODh6M3hIeEdyU3M4RDhqQnppQm9UU0U5YjIvTmRTaC9YZ1F2a0Q0?=
 =?utf-8?B?ODA4Qk1GZkVpRjFZb21WeTQ4UUV4cEEzMEFLMDBGcUVnTUkwNkl3L202Z1ly?=
 =?utf-8?B?bklZVk1vMmtpMXd0UjVFSEVIZVc4TTZ5Tyt5bktjRGd0V2psY3A1eGF0TGZI?=
 =?utf-8?B?WTFneXNJK2g2S1JjL1N6WUZWME52SW1UZm45U3E3cURVYXVKc1l4ODBJZXpi?=
 =?utf-8?B?bDlyVS9sVFZ3dkh1N1FTRHdUTllWMVozR1hDN2ZScDdUbGZnYi9PL2NjQldK?=
 =?utf-8?B?NWYyL1BnaCtiVzhyeklzVU1XOHdzeGR4TEFCaG5MczZMNE0wOTlIaWFGbW1Q?=
 =?utf-8?B?RDFBTnZzeGcxeCtFOFJyTi9iUlMvcFJkNi9ta2VRRkZiR3JoUDkzdkpINStv?=
 =?utf-8?B?UVZLSE9rSDBPVnRsVGlNOXJkbHJBSjlHLzJ2bDJhU3BwVGdVYlVjUmkvTDdY?=
 =?utf-8?B?K1ZIdHowbm5icHV4Yk9pYmlIcWdwNFNqS2ZPNFdOZzF3ZzNxRHAzWEpZVEht?=
 =?utf-8?B?d0hOZzdlN0RHZ29USWRzb0JLRTVDaE53eWJDWTVHY1Z3Q1BIVW1Gb3VZb0xp?=
 =?utf-8?B?bW02SHpJa1lWYjZhTnFQMTlCVjVQeTJXcCsxOVZNRnBNNHdmbHVWK0ptWG1W?=
 =?utf-8?B?WTU2VXYyMzZxelVuOFo0akM3SkQ4ZEx2WFBHaVVlWVFOaHlXZ2xOaU1NTmtP?=
 =?utf-8?B?TnJERXZlUEF2aHY5ZFlaWDVITWdDRm9wQlRYaWwxT2FZeXNWUkgzV1ZxcUcr?=
 =?utf-8?B?dE1adGp2UmRwMExSekppa3Y5d1hLRlI0S3hPUE1xN3hMbzZQeGtERExxNGhM?=
 =?utf-8?B?cG5weDJhZ2RWc0hYdnk5ZEhzNWh3dDVpYlptaVNMY3BkREJwa3pFMkxBeVVJ?=
 =?utf-8?B?LzJsZjF4QUpVa2dDT0k3TzRDWjRydk1pVU5KNVRnL1pVM0Z0QzdVS1dzTGwr?=
 =?utf-8?B?ZnEzWU5XU1htb0JLdVgydm94TlgvZ3hEZ2h3UEVadVFVMlF4U3AxTmozMnBx?=
 =?utf-8?B?Yjl0MWxlUlRiaEphNE0zcmo3MnlXK2FXUTdHSzhNSEtYM3RmcDlmZGhmQ2tP?=
 =?utf-8?B?ZUx6M1ZscWE2STd6MUJvK2QzZmpPWEh1YU11NmFiSmxHRXptd3BBeHJ3Szd1?=
 =?utf-8?B?V2Q3ZGRKTlVZcXBHN2lyWDlRWjE4Zkc2VGJrSlBQV1N1TE1zYS9nby9QZklC?=
 =?utf-8?B?dW9RL05wRDkwK0pYdVRTM2xuNFlFSFF3Si92eWpYUFNYcm8yTGc5RzYrcGE0?=
 =?utf-8?B?R3VDL29CbHdHaWJES01OMEY1RkgwRndMNUZpK2xkOU9yV2hSS0xiUFhZWjJt?=
 =?utf-8?B?VElKWHRnWkt2YWI4dDQ5U0FwczdPeGxCL1BEWkIrbHhla2J3dFFmYnh3N0l3?=
 =?utf-8?B?ZkVxenJNWDNCU3JQcFdmMnl5OWxqdHRwTWdDNzlublpIc1BEem5UWnB2OVVj?=
 =?utf-8?B?eXgxOFJxbHpyT3lKVVpHUS9nTVptTWlmZ21jNmNzaUplRUFIcFdzdHJLRDdC?=
 =?utf-8?B?TlpwcWJScU56TlRXZ0xyaWMzTmVwS2orY2x1S3Bmc3NBV3JBTzNCSHdoeitX?=
 =?utf-8?B?L25xN2szLzNOaU5OZ1dyNnBGMGczTFpuVnBZUDBkNkZZcTVnZ0E0dDN1YWgy?=
 =?utf-8?B?aXZjclRRRnM3NEludFVMZ3pNRVRFTGk3eDZlT1ZBVzBidGFQcm9kRmlzR1pu?=
 =?utf-8?B?ZVNTaG9iZzUrSW9rVUtpc2tUQ1AwQVQzNUx5NFZoQndhVmhHUEthTW9UVERM?=
 =?utf-8?B?djRiK0p4WUQ5VWkxYXl5OFFkK2I5OVkxcy9oODM2bGUzbUsxN2dHcDJGU0Mv?=
 =?utf-8?B?eTR4dE5jNmxBZkxYS2QzWDZTOU83SmVmd1ArbCtzaUtYdHhzM1hCNDIvZFNi?=
 =?utf-8?B?N2RIcXhZRHl3YmliZ0NHTXZ0b0Jvek15TlpaWW9jUC9SNVRXQWxUUUx1Y2Nl?=
 =?utf-8?B?RG5aUDM5SHdCOVN2TlY4UUlYakt5Y241amxQelVSVlN2TjRGbDBkLzFVNEtR?=
 =?utf-8?B?SnlZeklxbFN3Z1dYUmp4Y2pXQ1FGbHN3cUdJNXczeTRhaUo4Q2l0VEpvaUQ0?=
 =?utf-8?B?RHBQZUZMQ3hvVytxUkZPRmhRcnpaRkt3MzFnSnM3b1IzdzBKanNTMUx5MERX?=
 =?utf-8?Q?zAjR6Ufsmp58KthzA+52Ie6RfLJLbHo88yayObnW6LvS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D65AC52054BE842B779C75AAC91889D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	pp8N3isfLVgAMRTdPqq3ddYwe/Q/dX5GbknPu7goGkSspkvyPBOSFfmRvIPnbmCIX0kRrTxTFk1EqbUqB8tsDyrFQKiTg2Q7lmCzgYRY5m0NoUgr6t6S3wrRvyDodrT2vI8RZ9UoWTB+8XJDihelDUWY7dzhwY3N8B49vJguFxmjkmr47LrUGf7AytfwS1OfZaqwnIw/70KmWoznhA4HxPy8Ysd+9b+wZbssnV/v3hxOF7XpCSralkS/+tJ5e9IlAKE2ZgoVDGpfc/e73VohZ3G+773Yp4mVPQO4SuWfHGEI+JcDMZQo8LJQfju48hFjOWhtjErb0x3P3UBn0Gw3TzEotWRUIadnaPxAETT5w1ImfHwuptkT0EB7FeAG0s88hj9jEMKRk15hj9hitTnVniH+Ytin+LLC0ZdZsEkHpzrgjnk/kd0+GSyz12auwqH8iOcMgcrwaYtGT9rgE9aERkUzaCsheqJqTL1CxtDj6MXNnhTHr0Fvc2aS/PQaNyH22leELe6QMRZMAbap1CGMDgq1IW4FgNLVgbF9xSi8dN1z9aPvAP9dxKm98RrLvv6EDPu0qQ4zhB1/6ondoc09cMAiKvAclJJ0TeRYIvciDybzV6fVE1/wTX2SsqRPO//+SJGhe9wCiVHNtuNEOvLwViZpkjS+kvGVmaCFC6nVsLXJydjT9tjM2sDqqIbRPAJU+VIOI/i/l4lWrgSzcVaC9DqYVFsFT4rvRPdyRD3y3oaSm2YMcfNBlYVR9eDNnREvTTY6XhhFLE3aJsE6U94miYmeoRPFbsloGXJrd+gfKE80JixBcKOH9ejbYegYRbnnObpT2xygTBifZ29cbY1MjA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac805c29-2aca-4606-eeac-08dac72be720
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 17:07:40.1250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ziI3jU4q1LKTdddV7DODJzag59uhAJjrEwcJ873rpDjGtA4XB+/NWijr+kQl+eRThD2lP0QEQKYuDC+aeje4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211150115
X-Proofpoint-ORIG-GUID: N0kYvtfFq7TNuzzbREgJ2jjM5DLKX4tC
X-Proofpoint-GUID: N0kYvtfFq7TNuzzbREgJ2jjM5DLKX4tC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_090924_104262_0A00E801 
X-CRM114-Status: GOOD (  21.54  )
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

DQoNCj4gT24gTm92IDE0LCAyMDIyLCBhdCA2OjI5IFBNLCBTaGluaWNoaXJvIEthd2FzYWtpIDxz
aGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+IHdyb3RlOg0KPiANCj4gSSBmb3VuZCB0aGF0IHRo
ZSB0ZXN0IGNhc2UgbnZtZS8wMzkgZmFpbHMgd2l0aCB0aGUga2VybmVsIHY2LjEtcmM1LiBUaGUg
dGVzdA0KPiBjYXNlIHRlc3RzICJudm1lIGVycm9yIGxvZ2dpbmcgYnkgaW5qZWN0aW5nIGVycm9y
cyIuIFRoZSBmYWlsdXJlIG1lc3NhZ2Ugd2FzIGFzDQo+IGZvbGxvd3M6DQo+IA0KPiANCj4gbnZt
ZS8wMzkgPT4gbnZtZTVuMSAodGVzdCBlcnJvciBsb2dnaW5nKSAgICAgICAgICAgICAgICAgICAg
IFtmYWlsZWRdDQo+ICAgIHJ1bnRpbWUgICAgLi4uICAwLjQwMnMNCj4gICAgLS0tIHRlc3RzL252
bWUvMDM5Lm91dCAgICAgIDIwMjItMTEtMTQgMTY6NDA6NDguNTk4NDk1NzA5ICswOTAwDQo+ICAg
ICsrKyAvaG9tZS9zaGluL2t0cy9rZXJuZWwtdGVzdC1zdWl0ZS9zZXRzL2Jsa3Rlc3RzL2xvZy9y
dW5sb2cvbnZtZTVuMS9udm1lLzAzOS5vdXQuYmFkICAgICAgMjAyMi0xMS0xNCAxNzoxNDowNS4z
ODc2MjgyMTYgKzA5MDANCj4gICAgQEAgLTIsNiArMiw0IEBADQo+ICAgICAgUmVhZCgweDIpIEAg
TEJBIDAsIDEgYmxvY2tzLCBVbnJlY292ZXJlZCBSZWFkIEVycm9yIChzY3QgMHgyIC8gc2MgMHg4
MSkgRE5SDQo+ICAgICAgUmVhZCgweDIpIEAgTEJBIDAsIDEgYmxvY2tzLCBVbmtub3duIChzY3Qg
MHgzIC8gc2MgMHg3NSkgRE5SDQo+ICAgICAgV3JpdGUoMHgxKSBAIExCQSAwLCAxIGJsb2Nrcywg
V3JpdGUgRmF1bHQgKHNjdCAweDIgLyBzYyAweDgwKSBETlINCj4gICAgLSBJZGVudGlmeSgweDYp
LCBBY2Nlc3MgRGVuaWVkIChzY3QgMHgyIC8gc2MgMHg4NikgRE5SDQo+ICAgIC0gVW5rbm93bigw
eDk2KSwgSW52YWxpZCBDb21tYW5kIE9wY29kZSAoc2N0IDB4MCAvIHNjIDB4MSkgRE5SDQo+ICAg
ICBUZXN0IGNvbXBsZXRlDQo+IA0KPiANCj4gSSBjaGVja2VkIGNoYW5nZXMgaW4gcmM1IGFuZCBm
b3VuZCB0aGF0IHRoZSBjb21taXQgZDdhYzhkY2E5MzhjICgibnZtZTogcXVpZXQNCj4gdXNlciBw
YXNzdGhyb3VnaCBjb21tYW5kIGVycm9ycyIpIHRyaWdnZXJzIHRoZSBmYWlsdXJlLiBCeSByZXZl
cnRpbmcgdGhlIGNvbW1pdCwNCj4gdGhlIGZhaWx1cmUgZGlzYXBwZWFyZWQuIEkgZ3Vlc3MgdGhl
IHRlc3QgY2FzZSBuZWVkcyBtb2RpZmljYXRpb24gdG8gbWF0Y2ggd2l0aA0KPiB0aGUgdHJpZ2dl
ciBjb21taXQuDQo+IA0KPiBBbGFuLCBLZWl0aCwgY291bGQgeW91IHRha2UgYSBsb29rIGluIHRo
aXM/DQoNCg0KVGhlIHBhdGNoIHRoYXQgcXVpZXRzIGxvZ2dpbmcgZm9yIHBhc3N0aHJvdWdoIGNv
bW1hbmRzIGNhdXNlZCB0aGlzLiAgV2UganVzdCBuZWVkIHRvIHJlbW92ZSB0aGUgbGFzdCAzIG91
dHB1dCBsaW5lcyBmcm9tIDAzOS5vdXQgYW5kIHRoYXQgd2lsbCByZXNvbHZlIGl0IHVudGlsIHdl
IGFkZCBhIGxvZ2dpbmcgb3B0LWluIGZlYXR1cmUgZm9yIHVzZXJsYW5kL3Bhc3N0aHJvdWdoIGNv
bW1hbmRzLg0KDQpDYW4gY2FuIHN1Ym1pdCBhIHBhdGNoIHRvIGNoYW5nZSAwMzkub3V0Lg0KDQpJ
4oCZbSBhbHNvIHdvcmtpbmcgb24gYSBvcHQtaW4gZmVhdHVyZS4NCg0KQWxhbg==

