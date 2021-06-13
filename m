Return-Path: <SRS0=vQ/w=LH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D82C48BCF
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Jun 2021 08:36:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F946108E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Jun 2021 08:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F946108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jBVxRjr0EhSbjAj2kDeHI3LNwiN367LgEynV1HBktts=; b=Mhozju+OQmp7Iq
	u9tXtpPFivvtV35azxIHLnKF/018y6VFEiwR6TYopZSKCKG4D3xNjlGVbaFVsFdMOQxPxgjL9tD6k
	uamVQ+dr10WWKKYzKKLO5rddr5zcmM0Bqc2AtWvSwF3W81VI6ISBQJFHNsNIruKLFHOhpacYkLyY0
	oTnxl0nn1v0f8VUXtVNC2lWD6D5aBm67WcfoZ0EmoKa7PbwEN9RLNVC48vfZtQUlTf7VBxJgfmQCv
	kCOe1RwhM5Z5NhW8m+IgM0PJ3cL+tZ93TGWM4lvMpRj9wEHHnnh177Ib4l/n6+8aWEpbC3lfDqBL+
	SwMHdFKZGXtkopnKQ1hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsLbC-009zBi-Ij; Sun, 13 Jun 2021 08:36:06 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsLb9-009zAn-SG
 for linux-nvme@lists.infradead.org; Sun, 13 Jun 2021 08:36:05 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15D8Qm1v032604; Sun, 13 Jun 2021 04:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=jgKN/TCroU+lRVa2wIa9D18NbYvVLdQOXiaVSqxQsEA=;
 b=Wwy27tL8fiUENK2wrdUDhkgaM9kh0Q9n58fuyqMNEaxyHfNBnvHrgPiL/+3TArRJcWoF
 jevurUuXSDo8U/cOOrkioEFUaU2mK0OB9VDjpOolHs1UQVITazSHGxprNIsKtsdyqrmS
 9gfQosw58CzKwQkXPwzmL5JM03QncJ2Ri4C1864ZwSNECdPVgbobU6nethJmQ2fn1R0d
 wDHAkz0MiUInyQSEsWnjlavPl1vDKgo9IXr/0A/WMijNtSisjljALnKND7663oxoL7ab
 iUguns206NmKinJux1ZjUn/WIiwROpXzkmGerAP+J6Ffr4k3I0PjJaq4DUOga6YrYshc pA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 394p0w46k7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 13 Jun 2021 04:35:58 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15D8Yrop051452; Sun, 13 Jun 2021 04:35:58 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0b-00154901.pphosted.com with ESMTP id 395a5fa9r5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 13 Jun 2021 04:35:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYhEntmNnQdSArQy5T900MTg6jq/DLTgkd07E6We9AQobC3D8vFgC923J+Svn/Ll1g9sr92sWBmmb2UpgeiL3OTYojRB1GzlB9tbHEFhXdmgYURfX9nXlM9n2rnerJSCHChZ0NqBvMkmO42k/JVcqlRoRUTXeRNhIJQQHt5BE3FqwQs+OHICtp/cqWlODdeohq6qRKNs+Is1ZSomVANrtebgjqOQ0xxfwXAVrJWqstkDpeGTQQzxIEaWKHsUfpeCPo8G9u5WYGqNMfWpCB8RhzpeVgB9lkwdf+dGjTQSGM0Ox/f5ymXtWM0OvH0TA79M5w7KGEZ6N6FQPxpd0wDxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgKN/TCroU+lRVa2wIa9D18NbYvVLdQOXiaVSqxQsEA=;
 b=MbUGTF2809lOOBnD4Qpo6YVqKchJwdFoMGrpEEYONG97+TCwzN9UBEzty3WYuVfVdiqYnGzkBpn0T0evZj0C67qVdbs6hN+lw3Ejy15BflRd2U/pdieAmiMJYBhzAKIbqlWrwYHOOPO8IHDO67MOmrYthYtrtr02ZxB00eUzrYy33hA7WlYXCmYZ8NgejzHfup+l3QztwkTJ2PstXxPOK2GsPox8O/w6mGwolIbB6TvbaMPVbbdxI8nu8GQpee3gFtYAhnr4+hMjOsajmKLRTtFwwebVqJqP0uhyEjKnf4iCXl2OS4QXCpIDDDnccLc7vpiuhH1bengt8mgK5qSs6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MWHPR19MB1101.namprd19.prod.outlook.com (2603:10b6:300:a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Sun, 13 Jun
 2021 08:35:56 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::e5c6:c126:4c34:9f69]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::e5c6:c126:4c34:9f69%5]) with mapi id 15.20.4219.024; Sun, 13 Jun 2021
 08:35:56 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "Anner, Ran" <Ran.Anner@dell.com>, "Grupi, Elad" <Elad.Grupi@dell.com>
Subject: RE: nvme_tcp BUG: unable to handle kernel NULL pointer dereference at
 0000000000000230
Thread-Topic: nvme_tcp BUG: unable to handle kernel NULL pointer dereference
 at 0000000000000230
Thread-Index: AddXDsk20ALf75QRScyvzkSG+0qIDgAm6yOgAUVC6IAAEPeXkAAAsPoAAAD2GkAAAVmfgAABR48gAEfHfIAAe/CR0A==
Date: Sun, 13 Jun 2021 08:35:56 +0000
Message-ID: <CO1PR19MB4885C0354F0EF57BB14057A0EE329@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <CO1PR19MB48850A829FEF374C7FC156EFEE3E9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <CO1PR19MB4885314DCBFEB376C7305C98EE3D9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <e40414a9-41ef-f82c-7d1c-2583d8251c26@grimberg.me>
 <CO1PR19MB48850B44ED23C179A4E4F541EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
 <b9c7e6cc-fea5-b8ce-af07-7d004116e3e3@grimberg.me>
 <CO1PR19MB48859C3254E4F3EA3282EDC9EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
 <a76ecf8e-15d0-1ebc-aaf2-c93fee591602@grimberg.me>
 <CO1PR19MB48859E1CCD596402D4007458EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
 <172e3128-d1dc-ca9a-c679-752b621e956f@grimberg.me>
In-Reply-To: <172e3128-d1dc-ca9a-c679-752b621e956f@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-06-13T08:35:52.9912840Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=87da1bc4-0d86-4066-921a-fc6801902083;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [188.120.129.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25d62a3d-1566-4e18-7aee-08d92e46439c
x-ms-traffictypediagnostic: MWHPR19MB1101:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR19MB1101251000D12F94706D7416EE329@MWHPR19MB1101.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4k8cS6e4D+0mSTRe6j8dgLQLntBvQv+dXMb5+JuRy0bZbe2LvVgg4lDML+rcCRH2ZhBMqOOEd0+R5LNHmfL6a/mLOUb/u07zICsUGqSKMbIYmfqEvqO+vglgFMnfnMLI+0k/GuChg92Y/+roWua11K4nbLIiNW9JUEpLBAN4sGu4qwo4QW3+lnRkQYAh8daiC5c6CBx0d/E8c4hxw9iB3fq2cy4oPZtpz1oq6IqfpVdxk6OPjgPJUo/uubZ48Zv/iTEb4y6bS/XYsN6rC+sc34XBisGDKwnPopPWtyHRkT2Tj3HO4Ua2m+zdNytqnIldXF17USoyMes/ufEItREAYp/Na7snNr/WMEBVcvMFzsqUCJflhB+yI9jcZ0EO52qr0FH8YcwX52Q4ag/emU4FS3Xd76pYoFZv1r5Q5Bz1L/Ra/1ZwLGHAPIx497Cdccr2Ao+UQ05nPDp5BzyjTNVuhfPXzIdaljNMw25JM1E/RVY7VMKWIDPxEehWuryKhhGX4IJUnzIoQFwar4KUo2viZOU+Ya4UefYOD7GJdj6yhS6DwUoeGsEIQitsICYAnsUGQ5BPpDxNL9asu2JP9sAy74Lj74W67vTp4AHvbsWLmWg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR19MB4885.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(71200400001)(83380400001)(8676002)(54906003)(186003)(38100700002)(5660300002)(33656002)(122000001)(4326008)(8936002)(107886003)(6506007)(66946007)(53546011)(76116006)(86362001)(26005)(55016002)(478600001)(786003)(316002)(7696005)(52536014)(9686003)(66446008)(66476007)(66556008)(110136005)(64756008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzBPYUlvN0tiYXZ5OWhDOHRRYjFnNlRUcHMzQkkxODZmdktXTHYyNHpjZVAy?=
 =?utf-8?B?K3N2ZG5XdDJzTmpSSGNIOTNPUEtDdmFTcFhZbFh4SFRBTk12S01GN2prZVox?=
 =?utf-8?B?aXdXSFRkR3E1R2lsYm9VWlNPZklNVkFHcUtKRFRzc1FSS3JGQlNXQ3I2K1Vv?=
 =?utf-8?B?U2Z4R1hwNTJMOVhiWnp2dEhEZEFwMjlSWDhJNXFrVTRlanY2MjVyU0gwdW9o?=
 =?utf-8?B?WW9qcWluT3ZQME5RdXhEaE5BZVhXYWYzTUQxVUs1TmhxdSsxNG10a09CQkdl?=
 =?utf-8?B?Z3d4elM2eFJ3TWRrYTJoSTErQ00vMGxGTEFTb1F5K0c5VkdHZmRmSy9iU1E2?=
 =?utf-8?B?RnBoQUowdWl5UmtqMkNPdll5ZlF3dVhRTkwwaG5uTWh6bk1FMnJwTEZVOWdP?=
 =?utf-8?B?bGZZZ2NwNHBESmZWSkh5NFRhcGJYMnVZVmJBWE0xcFhkcE5NM014VUJDT0to?=
 =?utf-8?B?Y2FoT1lCcEFjdVRLUFZrdlozeGIrbHhqWmYxWlNlSWdLa1J5M2pSM2lHNWo4?=
 =?utf-8?B?VHJqMWh2ajM2R0ZSSlNjSmpNcmJGZXpoaW16WjVjNUdOVGFhdDI2emNLZkp2?=
 =?utf-8?B?Y2c4S2NQQXhQMlB6TWxEc2tqREVMdWJ6VW9pd2FBblVJNjVOVmRTdEdWbXAx?=
 =?utf-8?B?ZGtmT0xRdWhaK2EwbE44Y2gwbXZBaTc5RHhLSlZWMkRpQ2Y3WUJuZG9NbmNy?=
 =?utf-8?B?RDB3dmhaQWk4RTUrUU1IVWRISUR3c0FaaCtNSElZeDdkS1IrcUpucm1KUDk3?=
 =?utf-8?B?TG9KVVQ3ZDVJQ1BuRjJBajBZTGRXR25zNXBXeDgrczR4RWFDcmlESGVzZWJy?=
 =?utf-8?B?eUZzb1VKUnY5NG9Rd0t3WDdsNjJNSWtUR2d4dFZwRU5nNzVYaWtHMENpWXc2?=
 =?utf-8?B?TzJLcnU5U1pqRjgrL2V4bjJsVjRsV0pFOTdscTlUVUl0OGREd3N2SDBJd2tY?=
 =?utf-8?B?MGZiVmI1RzR4dXViWVpZUTIydllINFNiTzF4WnJqWk9ua01sQk55MXo5WTRP?=
 =?utf-8?B?VzdEQm5pT2RveTB4c2pua2MzUHF5UGkwNFBRTjJuSUFvNW5wVklvSFJnTFl1?=
 =?utf-8?B?R1ZBd3M3ei9yRzcvRW15U0J5UHUvdGhWWnFDeU10MGVpWFliT1VZQkpVaFM3?=
 =?utf-8?B?Q3BjaUJTU1dvSWlLUGN1a0xRRzNjZWdCSm05Y0lHUmxHcmNsamk4MVhrRWpS?=
 =?utf-8?B?UHp3TzFOSG9NRkJiNHFvTlNhOW5XUjk3aFZtczhDNDg5NGRuc2RIcWVkKytt?=
 =?utf-8?B?RWdremNHL0NERms2dHRrd3NOZmFtODZBYkFic0lRSWgvTEF1TG1Zc1Z0SUlS?=
 =?utf-8?B?d0huaDVKb05kUGUrZUl1SHQwRXppVmdoMWkrQzBRRzFzNVJleGR3L1ZmcFBO?=
 =?utf-8?B?V3ZITkJKZGtnalEwS0FPNktkUm9OTk4yd2c1UGIwSlFVOHhTSEtoV01QSm1t?=
 =?utf-8?B?TjZ0ZnhYTGt6Mkk0ZlpqOGY4aFNQMmdiTVUrUlE0N3pqN2RCdjNiZGthVEhS?=
 =?utf-8?B?SGtSU3Y5WWlSMGQ3d2pUR3JCbDI4MDJ1TXJSS2FaN2hkbGZDNzc3SWJBL0J4?=
 =?utf-8?B?WlFFamxsUGVkQ3VHNzQwZHpVSUl3MVNILzdQN3FFclR1Q3A3ZThwOWd3N2I4?=
 =?utf-8?B?THI5SVFjbjgvNFl3d1ZVTHJzaTBGbFNxNGl5UkxxTlFUZENXMlcyRUJvcm9O?=
 =?utf-8?B?TE16Ni8yVTlqY3FZZTRKZmc3dlFmUWJramxQNHMyTmpjY2tMVEFydUFiRFlB?=
 =?utf-8?Q?T6L4kDfIAH6FaNcREQKEXhKnfr1zcHdcRLOHiL4?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d62a3d-1566-4e18-7aee-08d92e46439c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2021 08:35:56.6074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLuZGAsEK0SVdDLtiMncYubEnT0Rz1t51oE9FJTqKrkDmAqZKMyKh+du2KOAZj9IJnAURscEZV9ZUoVeEUljxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB1101
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-13_02:2021-06-11,
 2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106130063
X-Proofpoint-GUID: t-1Jxo2mkpWE2Maddo3P-RtFJuewKebU
X-Proofpoint-ORIG-GUID: t-1Jxo2mkpWE2Maddo3P-RtFJuewKebU
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106130062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_013604_101731_0451B92A 
X-CRM114-Status: GOOD (  20.14  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgU2FnaSwgYWZ0ZXIgcmV2aXNpdCB0aGUgdXBzdHJlYW0gY29kZSwgSSBhZ3JlZSB3aXRoIHlv
dXIgYW5hbHlzaXMuDQpXZSBhcmUgdHJ5aW5nIG5vdyB0byBydW4gcmhlbDguMyBudm1lIGhvc3Qg
d2l0aCB0aGUgbWlzc2luZyBtdXRleF9sb2NrIGNvbW1pdC4NCg0KQW55d2F5LCBJIGFwcGxpZWQg
YSBwYXRjaCB0aGF0IHVzZXMgdGhlIHNhbWUgbXV0ZXhfbG9jayBhbHNvIGZvciBzdGFydF9xdWV1
ZSBmYWlsdXJlIGNhc2UuDQoNCkluIHRoaXMgY2FzZSwgbnZtZV90Y3Bfc3RhcnRfcXVldWUgY2Fs
bHMgX19udm1lX3RjcF9zdG9wX3F1ZXVlIHRoYXQgc2hvdWxkIGJlIHByb3RlY3RlZCBieSB0aGUg
c2FtZSBtdXRleF9sb2NrLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgaGVscA0KQW1pdA0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVy
Zy5tZT4gDQpTZW50OiBUaHVyc2RheSwgSnVuZSAxMCwgMjAyMSAxMTowMyBQTQ0KVG86IEVuZ2Vs
LCBBbWl0OyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcNCkNjOiBBbm5lciwgUmFuOyBH
cnVwaSwgRWxhZA0KU3ViamVjdDogUmU6IG52bWVfdGNwIEJVRzogdW5hYmxlIHRvIGhhbmRsZSBr
ZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IDAwMDAwMDAwMDAwMDAyMzANCg0KDQpb
RVhURVJOQUwgRU1BSUxdIA0KDQoNCj4gQ29ycmVjdCwgZnJlZV9xdWV1ZSBpcyBiZWluZyBjYWxs
ZWQgKHNvY2stPnNrIGJlY29tZXMgTlVMTCkgYmVmb3JlIA0KPiByZXN0b3JlX3NvY2tfY2FsbHMN
Cj4gDQo+IFdoZW4gcmVzdG9yZV9zb2NrX2NhbGxzIGlzIGNhbGxlZCwgd2UgZmFpbCBvbiAnd3Jp
dGVfbG9ja19iaCgmc29jay0+c2stPnNrX2NhbGxiYWNrX2xvY2spJw0KPiANCj4gTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlIGF0IDB4MjMwIOKGkiA1NjAgZGVjaW1hbA0KPiBjcmFzaD4gc3RydWN0
IHNvY2sgLW8NCj4gc3RydWN0IHNvY2sgew0KPiAgICAgWzBdIHN0cnVjdCBzb2NrX2NvbW1vbiBf
X3NrX2NvbW1vbjsNCj4gICAgIOKApg0KPiAgICAgLi4uDQo+ICAgICDigKYNCj4gICAgIFs1NjBd
IHJ3bG9ja190IHNrX2NhbGxiYWNrX2xvY2s7DQo+IA0KPiBzdG9wIHF1ZXVlIGluIGN0eDIgZG9l
cyBub3QgcmVhbGx5IGRvIGFueXRoaW5nIHNpbmNlICdOVk1FX1RDUF9RX0xJVkUnIGJpdCBpcyBh
bHJlYWR5IGNsZWFyZWQgKGJ5IGN0eDEpLg0KPiBjYW4geW91IHBsZWFzZSBleHBsYWluIGhvdyBz
dG9wIHRoZSBxdWV1ZSBiZWZvcmUgZnJlZSBoZWxwcyB0byBzZXJpYWxpemUgY3R4MSA/DQoNCldo
YXQgSSB1bmRlcnN0b29kIGZyb20geW91ciBkZXNjcmlwdGlvbiBpczoNCjEuIGN0eDEgY2FsbHMg
c3RvcF9xdWV1ZSAtIGNhbGxzIGtlcm5lbF9zb2NrX3NodXRkb3duIDIuIGN0eDEgZ2V0cyB0byBy
ZXN0b3JlX3NvY2tfY2FsbHMgKGp1c3QgYmVmb3JlKSAzLiBjdHgyIGlzIHRyaWdnZXJlZCBmcm9t
IHN0YXRlX2NoYW5nZSAtIHNjaGVkdWxpbmcgZXJyX3dvcmsgNC4gY3R4MiBkb2VzIHN0b3BfcXVl
dWVzIDUuIGN0eDIgY2FsbHMgZGVzdHJveV9xdWV1ZXMgLT4gdGhlcmUgZG9lcyBzb2NrX3JlbGVh
c2UgNi4gY3R4MSBkb2VzIGZyd2QgcHJvZ3Jlc3MgYW5kIGFjY2VzcyBhbiBhbHJlYWR5IGZyZWVk
IHNrDQoNCkhlbmNlIHdpdGggdGhlIG11dGV4IHByb3RlY3Rpb24sIGN0eDIgd2lsbCBiZSBzZXJp
YWxpemVkIG9uIHN0ZXAgKDQpIHVudGlsIGN0eDIgcmVsZWFzZXMgdGhlIG11dGV4IGFuZCBoZW5j
ZSBjYW5ub3QgZ2V0IHRvIHN0ZXAgKDUpIGJ1dCBvbmx5IGFmdGVyIGN0eDEgcmVsZWFzZXMgdGhl
IG11dGV4LCBpbiBzdGVwICg2KS4NCg0KQnV0IG1heWJlIEknbSBub3QgaW50ZXJwcmV0aW5nIHRo
aXMgY29ycmVjdGx5Pw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
