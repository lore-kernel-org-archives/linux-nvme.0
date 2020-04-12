Return-Path: <SRS0=UuiE=54=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5D4C2BA2B
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Apr 2020 12:38:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDC4206E9
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Apr 2020 12:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qgcuj+G/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="t7gp7g4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDC4206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rAeQiAaAWPN45sLd4I3A0jnU8D0pMYabsKr8KDXuZxs=; b=qgcuj+G/DG8RmtiIKTZpkdOmX
	S5mkT+NU4VCGkSRKGUcje2dwKdpygRYyqOAObKiRxvOqjuIlZqvyEU5GQGifka5MZ9zd5HvQAigr7
	jDDGvi4BnOg7tbt57rgYoem4A7ZiwbONWsp0yK6tdgvokWLA1QKz+wTkU3b0RJLJXuHIB8+rTszs1
	b6DuuMcoG6KWYvU1lQx6UeQjQAzN16MuBXl8ESsFyfjIn55FuUQhZeK/PoVSWsauPBdcnq7hPBbgm
	Ih2QminVpHJnDJ9J0GnZ3BpvH5/olAhw2tEPF8PGTty1bVpMKEDXk/GLAhwMSDpCXnyrTqiIfHaAf
	GO5S5TeNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jNbsh-0006RW-1s; Sun, 12 Apr 2020 12:38:35 +0000
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jNbsc-0006Qy-Kd
 for linux-nvme@lists.infradead.org; Sun, 12 Apr 2020 12:38:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ck9i8id1HPewcqdiGcy0BQha7TctvJKmCjfKu2XvnIJ2+TBquwWzmFZqeUeLBHmSUvdFvU51iaEu5qPVqdtMJr0Xpaxi8b3Rv80umQiIDtvB2KS6cvi/RGcZ2sRGTT6DnRMb5P4VLMAi9GDnWkMmVj8ox/O3ZKua4FeBYkxOcgzxw4JRl0v5LpI8IBgVdfto0krbBPayzU8nMhL27iyVorIn7j1MMixOZzuXB3jY5ZawVf/nVZ/iZ5SLV/la7A1KigVe/TbhOJMvtELVSxJgB9flGIXzPmlFqeFS9HcVyVcfg7boIshnQvNycPI8h11IBqHEU/ncNkijZ/KJtWiprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmkVjsR+BiPmwRJMZ1vn/afFkzu5g4oNE/fou2hpr8k=;
 b=DGZm/XinODKON4wYspN7kVOMAE6J/0tzTHXCAdvFimASDb/ScSu1YDoY/7dXQcQ3e6ZYsJQsUdoSG2zH7IG9r0PwinGBGlm+jUCAGeA3GG2KUa7X/a/8XTgng/roJUIuqiadvyQF/a2xaShXUMW5xj5N58ZUFpCwaBeI/rpQndR1n54qFmEfTB3kbojBwMY3sxn/3vVBjC3P+SFRzFmp/7IsCPgjAWTy6j0LSnVMjr9dCC5ThO14SakKfvENZAA0lKrWNkTTQ4D7RNUWslhA8HPFLd3GKDIn18znBXRXD2yLieATTQUwaFNI6CD+WLS75x7pQtkx7DHPkn5LS57lmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmkVjsR+BiPmwRJMZ1vn/afFkzu5g4oNE/fou2hpr8k=;
 b=t7gp7g4AE9dvXNDpAE7rueJDzFxA6isaoFVEWFdVBqzrIB8sovgypvXjBq+P43/t/rQZF6kU9isfrI9eG7lLDTuu2RD2IWQLqq1fwayyL/urBfdX57ykb/v2zo8OOZI+R141LybcwUffJ35ztSDsq2DsatL9/sxAYWthSBD9oz0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6452.eurprd05.prod.outlook.com (2603:10a6:208:141::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Sun, 12 Apr
 2020 12:38:22 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2900.026; Sun, 12 Apr 2020
 12:38:22 +0000
Subject: Re: [PATCH] nvme: align io queue count with allocted nvme_queue in
 nvme_probe
To: Weiping Zhang <zhangweiping@didiglobal.com>, hch@infradead.org,
 axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me
References: <20200410095719.GA4393@192.168.3.9>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <188ad279-9211-9dca-3e6c-b5718ae6fc80@mellanox.com>
Date: Sun, 12 Apr 2020 15:38:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200410095719.GA4393@192.168.3.9>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0202CA0013.eurprd02.prod.outlook.com
 (2603:10a6:200:89::23) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by
 AM4PR0202CA0013.eurprd02.prod.outlook.com (2603:10a6:200:89::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Sun, 12 Apr 2020 12:38:21 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f21deb0e-801c-4c50-4be2-08d7dede6331
X-MS-TrafficTypeDiagnostic: AM0PR05MB6452:
X-Microsoft-Antispam-PRVS: <AM0PR05MB645271DB7449A0FCF80D605FB6DC0@AM0PR05MB6452.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 0371762FE7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(36756003)(8936002)(66946007)(6486002)(2906002)(16576012)(316002)(8676002)(81156014)(2616005)(956004)(6666004)(5660300002)(4326008)(31696002)(31686004)(26005)(478600001)(86362001)(53546011)(52116002)(66476007)(66556008)(16526019)(186003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vu8m2sPUfAoO9SI02VADn5OTDBeKj33vdcMQwglqrP85MWvVpG/ootG68WiHs765g4CE2TucwvipYPSF38vuAZQZR1r4dU/aAqwW7V8t9gRhbcMIGioS97Whr1GbjEMmgO74EeJmaWUM1TcTpdXdgv5bTTZCI9hgA22DfyS9TnqR3OHJkxcKF4PRTlnC6LlyaWA1GYqZkiMrtaOcRvezaAmVT5tM+tSjgXbMRkjpNNhbDn3eAODsrLBzSGahAhTVhybpk3xzWCsSaP7RPYAiC3Intkfc0qcuQW6FzwA/q1JM3DSHOQo8iOHfuGWQWxB2B1ZE8Jb0IjduLPyP60kXWZbJce0WrZuRwOVnWTARo9fgq5GcPTcV4Jrene572682FFqbX0Y6p7FoIxpnj1DAZfTp87p1J/roe5vSpIdH/i99KK3F6HDpUlg1hQzF0hP4
X-MS-Exchange-AntiSpam-MessageData: qf8kg7tAk0UVlkq3ejnrWI4BoXmet07eLxfe0ep/9be/XNAmXwmdDqT6r7p7I3/QEL8m1dLNfeTA8wVTu7/+WZHCHadNakXgEnqbEQKa79bVkDwvPtxtgarWhv/1yg56lXcfLfds9ShmbnwjfWvEGw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21deb0e-801c-4c50-4be2-08d7dede6331
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2020 12:38:22.7283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKzlzQPwXeslyQuTVXz0Bot4SlM0nw579JyM+yQAdLrr4YyBiuGl88Y4t2l/FCz0+vsRSgULjgVIRlfOC9gO6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6452
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200412_053830_770672_D451D826 
X-CRM114-Status: GOOD (  18.94  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

aGksCgpob3cgYWJvdXQgdGhlIGZvbGxvd2luZyBtaW5vciB1cGRhdGU6CgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYwppbmRleCA0
ZTc5ZTQxLi40NmFiMjhiIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYworKysg
Yi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYwpAQCAtODksNiArODksNyBAQAogwqAgKi8KIMKgc3Ry
dWN0IG52bWVfZGV2IHsKIMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX3F1ZXVlICpxdWV1ZXM7
CivCoMKgwqDCoMKgwqAgaW50IG5yX2FsbG9jYXRlZF9xdWV1ZTsKIMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCBibGtfbXFfdGFnX3NldCB0YWdzZXQ7CiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYmxrX21x
X3RhZ19zZXQgYWRtaW5fdGFnc2V0OwogwqDCoMKgwqDCoMKgwqAgdTMyIF9faW9tZW0gKmRiczsK
QEAgLTIwOSwxNSArMjEwLDE1IEBAIHN0cnVjdCBudm1lX2lvZCB7CiDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnOwogwqB9OwoKLXN0YXRpYyB1bnNpZ25lZCBpbnQgbWF4X2lv
X3F1ZXVlcyh2b2lkKQorc3RhdGljIHVuc2lnbmVkIGludCBucl9kZXZfaW9fcXVldWVzKHN0cnVj
dCBudm1lX2RldiAqZGV2KQogwqB7Ci3CoMKgwqDCoMKgwqAgcmV0dXJuIG51bV9wb3NzaWJsZV9j
cHVzKCkgKyB3cml0ZV9xdWV1ZXMgKyBwb2xsX3F1ZXVlczsKK8KgwqDCoMKgwqDCoCByZXR1cm4g
ZGV2LT5ucl9hbGxvY2F0ZWRfcXVldWUgLSAxOwogwqB9CgogwqBzdGF0aWMgdW5zaWduZWQgaW50
IG1heF9xdWV1ZV9jb3VudCh2b2lkKQogwqB7CiDCoMKgwqDCoMKgwqDCoCAvKiBJTyBxdWV1ZXMg
KyBhZG1pbiBxdWV1ZSAqLwotwqDCoMKgwqDCoMKgIHJldHVybiAxICsgbWF4X2lvX3F1ZXVlcygp
OworwqDCoMKgwqDCoMKgIHJldHVybiAxICsgbnVtX3Bvc3NpYmxlX2NwdXMoKSArIHdyaXRlX3F1
ZXVlcyArIHBvbGxfcXVldWVzOwogwqB9CgogwqBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBu
dm1lX2RiYnVmX3NpemUodTMyIHN0cmlkZSkKQEAgLTIwNzMsNyArMjA3NCw3IEBAIHN0YXRpYyBp
bnQgbnZtZV9zZXR1cF9pb19xdWV1ZXMoc3RydWN0IG52bWVfZGV2ICpkZXYpCiDCoMKgwqDCoMKg
wqDCoCBpbnQgcmVzdWx0LCBucl9pb19xdWV1ZXM7CiDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBs
b25nIHNpemU7CgotwqDCoMKgwqDCoMKgIG5yX2lvX3F1ZXVlcyA9IG1heF9pb19xdWV1ZXMoKTsK
K8KgwqDCoMKgwqDCoCBucl9pb19xdWV1ZXMgPSBucl9kZXZfaW9fcXVldWVzKGRldik7CgogwqDC
oMKgwqDCoMKgwqAgLyoKIMKgwqDCoMKgwqDCoMKgwqAgKiBJZiB0YWdzIGFyZSBzaGFyZWQgd2l0
aCBhZG1pbiBxdWV1ZSAoQXBwbGUgYnVnKSwgdGhlbgpAQCAtMjc0Miw3ICsyNzQzLDcgQEAgc3Rh
dGljIHZvaWQgbnZtZV9hc3luY19wcm9iZSh2b2lkICpkYXRhLCAKYXN5bmNfY29va2llX3QgY29v
a2llKQoKIMKgc3RhdGljIGludCBudm1lX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25z
dCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAKKmlkKQogwqB7Ci3CoMKgwqDCoMKgwqAgaW50IG5vZGUs
IHJlc3VsdCA9IC1FTk9NRU07CivCoMKgwqDCoMKgwqAgaW50IG5vZGUsIG5yX3F1ZXVlcywgcmVz
dWx0ID0gLUVOT01FTTsKIMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX2RldiAqZGV2OwogwqDC
oMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBxdWlya3MgPSBpZC0+ZHJpdmVyX2RhdGE7CiDCoMKg
wqDCoMKgwqDCoCBzaXplX3QgYWxsb2Nfc2l6ZTsKQEAgLTI3NTUsMTEgKzI3NTYsMTQgQEAgc3Rh
dGljIGludCBudm1lX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCAKY29uc3Qgc3RydWN0IHBj
aV9kZXZpY2VfaWQgKmlkKQogwqDCoMKgwqDCoMKgwqAgaWYgKCFkZXYpCiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07CgotwqDCoMKgwqDCoMKgIGRldi0+cXVl
dWVzID0ga2NhbGxvY19ub2RlKG1heF9xdWV1ZV9jb3VudCgpLCBzaXplb2Yoc3RydWN0IApudm1l
X3F1ZXVlKSwKLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0ZQX0tFUk5FTCwgbm9kZSk7CivCoMKgwqDC
oMKgwqAgbnJfcXVldWVzID3CoCBtYXhfcXVldWVfY291bnQoKTsKK8KgwqDCoMKgwqDCoCBkZXYt
PnF1ZXVlcyA9IGtjYWxsb2Nfbm9kZShucl9xdWV1ZXMsIHNpemVvZihzdHJ1Y3QgbnZtZV9xdWV1
ZSksCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgR0ZQX0tFUk5FTCwgbm9kZSk7CiDCoMKgwqDCoMKgwqDCoCBpZiAoIWRl
di0+cXVldWVzKQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZnJlZTsKCivC
oMKgwqDCoMKgwqAgZGV2LT5ucl9hbGxvY2F0ZWRfcXVldWUgPSBucl9xdWV1ZXM7CisKIMKgwqDC
oMKgwqDCoMKgIGRldi0+ZGV2ID0gZ2V0X2RldmljZSgmcGRldi0+ZGV2KTsKIMKgwqDCoMKgwqDC
oMKgIHBjaV9zZXRfZHJ2ZGF0YShwZGV2LCBkZXYpOwoKCi1NYXgKCk9uIDQvMTAvMjAyMCAxMjo1
NyBQTSwgV2VpcGluZyBaaGFuZyB3cm90ZToKPiBTaW5jZSB0aGUgY29tbWl0IDE0N2IyN2U0YmQw
ICJudm1lLXBjaTogYWxsb2NhdGUgZGV2aWNlIHF1ZXVlcyBzdG9yYWdlIHNwYWNlIGF0IHByb2Jl
Igo+IG52bWVfYWxsb2NfcXVldWUgd2lsbCBub3QgYWxsb2Mgc3RydWN0IG52bWVfcXVldWUgYW55
IG1vcmUuCj4gSWYgdXNlciBjaGFuZ2Ugd3JpdGUvcG9sbF9xdWV1ZXMgdG8gbGFyZ2VyIHRoYW4g
dGhlIG51bWJlciBvZgo+IGFsbG9jYXRlZCBxdWV1ZSBpbiBudm1lX3Byb2JlLCBudm1lX2FsbG9j
X3F1ZXVlIHdpbGwgdG91Y2gKPiB0aGUgbWVtb3J5IG91dCBvZiBib3VuZGFyeS4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFdlaXBpbmcgWmhhbmcgPHpoYW5nd2VpcGluZ0BkaWRpZ2xvYmFsLmNvbT4KPiAt
LS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIHwgMTAgKysrKysrKystLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCj4gaW5k
ZXggNGU3OWU0MTJiMjc2Li5jYzEwMjU4ZTU3OGUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1l
L2hvc3QvcGNpLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYwo+IEBAIC04OSw2ICs4
OSw3IEBAIHN0YXRpYyBib29sIF9fbnZtZV9kaXNhYmxlX2lvX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9k
ZXYgKmRldiwgdTggb3Bjb2RlKTsKPiAgICAqLwo+ICAgc3RydWN0IG52bWVfZGV2IHsKPiAgIAlz
dHJ1Y3QgbnZtZV9xdWV1ZSAqcXVldWVzOwo+ICsJaW50IG5yX2FsbG9jYXRlZF9xdWV1ZTsKPiAg
IAlzdHJ1Y3QgYmxrX21xX3RhZ19zZXQgdGFnc2V0Owo+ICAgCXN0cnVjdCBibGtfbXFfdGFnX3Nl
dCBhZG1pbl90YWdzZXQ7Cj4gICAJdTMyIF9faW9tZW0gKmRiczsKPiBAQCAtMjA3NCw2ICsyMDc1
LDggQEAgc3RhdGljIGludCBudm1lX3NldHVwX2lvX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9kZXYgKmRl
dikKPiAgIAl1bnNpZ25lZCBsb25nIHNpemU7Cj4gICAKPiAgIAlucl9pb19xdWV1ZXMgPSBtYXhf
aW9fcXVldWVzKCk7Cj4gKwlpZiAobnJfaW9fcXVldWVzID4gZGV2LT5ucl9hbGxvY2F0ZWRfcXVl
dWUgLSAxKQo+ICsJCW5yX2lvX3F1ZXVlcyA9IGRldi0+bnJfYWxsb2NhdGVkX3F1ZXVlIC0gMTsK
PiAgIAo+ICAgCS8qCj4gICAJICogSWYgdGFncyBhcmUgc2hhcmVkIHdpdGggYWRtaW4gcXVldWUg
KEFwcGxlIGJ1ZyksIHRoZW4KPiBAQCAtMjc0Miw3ICsyNzQ1LDcgQEAgc3RhdGljIHZvaWQgbnZt
ZV9hc3luY19wcm9iZSh2b2lkICpkYXRhLCBhc3luY19jb29raWVfdCBjb29raWUpCj4gICAKPiAg
IHN0YXRpYyBpbnQgbnZtZV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qgc3RydWN0
IHBjaV9kZXZpY2VfaWQgKmlkKQo+ICAgewo+IC0JaW50IG5vZGUsIHJlc3VsdCA9IC1FTk9NRU07
Cj4gKwlpbnQgbm9kZSwgbnJfcXVldWUsIHJlc3VsdCA9IC1FTk9NRU07Cj4gICAJc3RydWN0IG52
bWVfZGV2ICpkZXY7Cj4gICAJdW5zaWduZWQgbG9uZyBxdWlya3MgPSBpZC0+ZHJpdmVyX2RhdGE7
Cj4gICAJc2l6ZV90IGFsbG9jX3NpemU7Cj4gQEAgLTI3NTUsMTEgKzI3NTgsMTQgQEAgc3RhdGlj
IGludCBudm1lX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2Rl
dmljZV9pZCAqaWQpCj4gICAJaWYgKCFkZXYpCj4gICAJCXJldHVybiAtRU5PTUVNOwo+ICAgCj4g
LQlkZXYtPnF1ZXVlcyA9IGtjYWxsb2Nfbm9kZShtYXhfcXVldWVfY291bnQoKSwgc2l6ZW9mKHN0
cnVjdCBudm1lX3F1ZXVlKSwKPiArCW5yX3F1ZXVlID0gbWF4X3F1ZXVlX2NvdW50KCk7Cj4gKwlk
ZXYtPnF1ZXVlcyA9IGtjYWxsb2Nfbm9kZShucl9xdWV1ZSwgc2l6ZW9mKHN0cnVjdCBudm1lX3F1
ZXVlKSwKPiAgIAkJCQkJR0ZQX0tFUk5FTCwgbm9kZSk7Cj4gICAJaWYgKCFkZXYtPnF1ZXVlcykK
PiAgIAkJZ290byBmcmVlOwo+ICAgCj4gKwlkZXYtPm5yX2FsbG9jYXRlZF9xdWV1ZSA9IG5yX3F1
ZXVlOwo+ICsKPiAgIAlkZXYtPmRldiA9IGdldF9kZXZpY2UoJnBkZXYtPmRldik7Cj4gICAJcGNp
X3NldF9kcnZkYXRhKHBkZXYsIGRldik7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
