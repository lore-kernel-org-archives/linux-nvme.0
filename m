Return-Path: <SRS0=YdFy=DT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2064C43457
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 15:49:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F232076E
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 15:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hh785O92";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="WJCsVIir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F232076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wH92NZwFOxZjQSUcyHCceBeb5Y+v5Lr59k3NrM/ScU8=; b=Hh785O92s88AFY
	jLElIzG+6Bta+2A4h2dT6hLcUlSoJ35eamoiQfphDqXzX8YJ7jXoMJ4leenK2BhjuZxCTH3M1nnwA
	NJu6er0qR7SFhLwfenJrfCAbNe9gDQ9j2KAePiKlRU1y8Ccbbv1urFbWnBRNH82KswnUqQ2hwVD7Z
	Z1KfIFEeUde/UZoWAWyq94NBaPfdt6i3lNgwk0MuEvlxAxCC9RpeFVmqN/Wr6HVN74AkMpAUZNI7l
	mKhNgUaXKP9cyBENKQag3KmbEgE4oY8pZ5GBPlKQWQLOwgHmx49l5ZZpBZorQL1wt7dlepnqAaJ/l
	lq0RwKbGowelkiSQXSwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kS055-0004ZH-2n; Mon, 12 Oct 2020 15:49:47 +0000
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com
 ([40.107.243.73] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kS052-0004Xc-82
 for linux-nvme@lists.infradead.org; Mon, 12 Oct 2020 15:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWA751/uxsojpbbUMXe8O0NKqrsWOqrZqGt0vH7p2W0s4nPkxO2FdcyUXx6OB9Of34lEutt3ASCBP5Fy/gzkzGTwoRJX5O3HSCTIzlKn7P79KLO6uYz/XWw62BEgkwOQnBjbgBhjq6e7uaDYJZY/vIwQL0cj8eWQYBCiaFuqj58DhmGBP5RMAJqBbzQkOgbHaKg1vvVd0XZkGMjWRbpilcWRDpP5Q3j8AzAt+g9eDujiXvZP0P5/D8D6r3qDFIcSkQSk3IYGgRV+KFPkgEYFrTrJRT2GSeUs96Z1VH9HqovVBeGDfd0/1UWA2oYZm8/RfrS5atJoMgc0uK5AEFvsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRYo9U49dD6N7Yx/E8wsboFANiOg9CnLZ8sScXjfzO8=;
 b=jh+vAJATX7E2E3ta++IsF1+ftHYSIhyzHJCJD6qtma5hshoE6RKFv48/x+UeJ2+XPa4GzY9eECgSvolHNAfbfpAudgEIKl9iUNAy1RcV4jS3rhwoRgqtd0aABeJRnKXYizTf/6CKtrKjU6JHepy0zaPCR+BKtvvl4U4p+QZlqKGKkQhR0Sa6qKARfbvTIhbVLLk657QbCJFN2TFJfGjQV3rXnLikvwjDyk1/m8HD/b04oLztBQdrdJm8gseG2vrpbtIFSMGAKcjBqTdhcdJcpw9Ar/KfIzYL43BONPCMAbppHGrn+Nf6oS3Wdxql0i8nyW8KSYFp+Qe4xGWoiHzYsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRYo9U49dD6N7Yx/E8wsboFANiOg9CnLZ8sScXjfzO8=;
 b=WJCsVIir5p2agWTt/FvtNiEQjXVG/4bhCE6hrRK6kb9hKQ7+VQqpnj25HKQ4dL/vV3DyVzGQMxGSSeN5YEbSZ1IbxF7rtnna4f7AfWRnddpG6YUuTO9k26Op8yalHFJt6hKy6Au1u+v90mTlJu7V2zjziFWSwSoe/oF8lohQEqA=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB3367.namprd11.prod.outlook.com (2603:10b6:a03:79::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 15:49:40 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 15:49:40 +0000
To: linux-nvme@lists.infradead.org
From: Chris Friesen <chris.friesen@windriver.com>
Subject: NVME, isolcpus, and irq affinity
Message-ID: <2a4a5174-d1b9-86b7-f3c8-03b041fa093e@windriver.com>
Date: Mon, 12 Oct 2020 09:49:38 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
Content-Language: en-US
X-Originating-IP: [70.64.84.123]
X-ClientProxiedBy: BY5PR17CA0046.namprd17.prod.outlook.com
 (2603:10b6:a03:167::23) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.5] (70.64.84.123) by
 BY5PR17CA0046.namprd17.prod.outlook.com (2603:10b6:a03:167::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Mon, 12 Oct 2020 15:49:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03b21d45-61d9-4e70-df83-08d86ec66e4d
X-MS-TrafficTypeDiagnostic: BYAPR11MB3367:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3367B9E98419F896BE5125E0F6070@BYAPR11MB3367.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4nPn3U1hFCTDfkvawMNIkvJb2bJ3jzK+h0xhWE55xuu5r3lmhTgXEG0ZaSqI1Has5QtwfUpjpQUhnb35KtYaOXKA41Zk4LRhV+Ic9IxY3XEbQlbD7fJTh8dU5DWcw8WEp0++F7SC1Suc4uRCaD+zqvU8EhLyrWP/0W+dm4rT8ONOwRRjcLc78M0D0XxTYGfMJJx/nUOR8JbeujT8tz4/ff9GMniuI5j4Epn05ZO+WKY6o3bapvb54DmATc2ayFnwtClprNBEhJULcWhwOQ0oSTuRucq8V/AasT13rplQSK3aBPVbi4T39SLIvo5xPt0RGxCQ4xc3LSRrW8X2nGoy9xFXjSyhAXiw1xP4QzM5kP7aSL1qcc6yQ3l2hXrrdTOEKc7apAxYeTc+2xH0+/aFQ3ebaD9NsyYwcOlOgkhxQlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5120.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39850400004)(366004)(136003)(16526019)(5660300002)(478600001)(186003)(966005)(36756003)(66946007)(2616005)(52116002)(66556008)(66476007)(16576012)(956004)(316002)(6486002)(86362001)(44832011)(6916009)(31696002)(8676002)(26005)(83380400001)(8936002)(2906002)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TZE+9UE2hvtRyATfrepdB0bebk9mcZ3vzp6RsGkkDClWPhoaxsFXo1byZ4ZJq4goawx+1y08I92Zb7XO7bj7uZmIvvJooL4ZejdlHWPO4+kTpiiJu/naG+elkKPqCrVFFiJ2DEpn590MXmaBZ57o+oeaZVvPI9gZsOG3x2IR24sEINDEQuwlRHqZNgXcYttIofqYSHzwgaKgfsv1skNhdtgyxqASx+0114XJb6ff8vw6BTBIsV37nP3Xm8SLEhqz3QN+2A1zy8cmzeVQ/CJUg4tVYOcP+w8lq/oDn8ZkEqWG0HQaz1HO93nvMQNIEWdMHMYdiklhJjIj3Up4b90BKyA+6j0KmtP7UZWQbBUo5QLLMWTLYTapVoC57SCvTnJpljPRRH2M5i948hf0/8/rOWExskpLppQ/PGXMOk9WSWWb0fQB46OnuHGbXcT3QqRa1h3xvdRM5Z2gSor5DL2f7DWL921RUrlS7yuWtrEteiHkdUi+9lGOSVU99wXVskKcTWuYHM7aJxPMoY9A68hmefRD+n+D6XvRCS5Izluue67kO+kHG3V0VPQlVmyeVtY0VdJgMGd5lsEiVVtAjDOiTMEIMQR3QbgQHIYxMvl961yuAC53yTBMOgZBczpb/BO/fMZlkOn0BKICcSx+rYGEFg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b21d45-61d9-4e70-df83-08d86ec66e4d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 15:49:40.7386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXXtQtvXeuDrmER/7raEegs4ALQj892/gUPmNLLARShQralH0KavlgZ8jsU7ygZD8YhdwbVQ8AvQ01HZ9mTSoDTo7nkEB4P1mJMUnhFMj54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3367
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201012_114944_300274_BCFB564D 
X-CRM114-Status: GOOD (  12.52  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGksCgpJJ20gbm90IHN1YnNjcmliZWQgdG8gdGhlIGxpc3Qgc28gcGxlYXNlIENDIG1lIG9uIHJl
cGxpZXMuCgpJJ3ZlIGdvdCBhIGxpbnV4IHN5c3RlbSBydW5uaW5nIHRoZSBSVCBrZXJuZWwgd2l0
aCB0aHJlYWRlZCBpcnFzLsKgIE9uIApzdGFydHVwIHdlIGFmZmluZSB0aGUgdmFyaW91cyBpcnEg
dGhyZWFkcyB0byB0aGUgaG91c2VrZWVwaW5nIENQVXMsIGJ1dCAKSSByZWNlbnRseSBoaXQgYSBz
Y2VuYXJpbyB3aGVyZSBhZnRlciBzb21lIGRheXMgb2YgdXB0aW1lIHdlIGVuZGVkIHVwIAp3aXRo
IGEgbnVtYmVyIG9mIE5WTUUgaXJxIHRocmVhZHMgYWZmaW5lZCB0byBhcHBsaWNhdGlvbiBjb3Jl
cyBpbnN0ZWFkIAoobm90IGdvb2Qgd2hlbiB3ZSdyZSB0cnlpbmcgdG8gcnVuIGxvdy1sYXRlbmN5
IGFwcGxpY2F0aW9ucykuCgpMb29raW5nIGF0IHRoZSBjb2RlLCBpdCBhcHBlYXJzIHRoYXQgdGhl
IE5WTUUgZHJpdmVyIGNhbiBpbiBzb21lIApzY2VuYXJpb3MgY2FsbCBudm1lX3NldHVwX2lvX3F1
ZXVlcygpIGFmdGVyIHRoZSBpbml0aWFsIHNldHVwIGFuZCB0aHVzIAphbGxvY2F0ZSBuZXcgSVJR
IHRocmVhZHMgYXQgcnVudGltZS7CoCBJdCBhcHBlYXJzIHRoYXQgdGhpcyB3aWxsIHRoZW4gCmNh
bGwgcGNpX2FsbG9jX2lycV92ZWN0b3JzX2FmZmluaXR5KCksIHdoaWNoIHNlZW1zIHRvIGRldGVy
bWluZSBhZmZpbml0eSAKd2l0aG91dCBhbnkgcmVnYXJkIGZvciB0aGluZ3MgbGlrZSAiaXNvbGNw
dXMiIG9yICJjc2V0IHNoaWVsZCIuCgpUaGVyZSBzZWVtIHRvIGJlIG90aGVyIHJlcG9ydHMgb2Yg
c2ltaWxhciBpc3N1ZXM6CgpodHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC91YnVudHUvK3NvdXJj
ZS9saW51eC8rYnVnLzE4MzE1NjYKCkFtIEkgd29ycmllZCBhYm91dCBub3RoaW5nLCBvciBpcyB0
aGVyZSBhIHJpc2sgdGhhdCB0aG9zZSBpcnEgdGhyZWFkcyAKd291bGQgYWN0dWFsbHkgbmVlZCB0
byBkbyByZWFsIHdvcmsgKHdoaWNoIHdvdWxkIGNhdXNlIHVuYWNjZXB0YWJsZSAKaml0dGVyIGlu
IG15IGFwcGxpY2F0aW9uKT8KCkFzc3VtaW5nIEknbSByZWFkaW5nIHRoZSBjb2RlIGNvcnJlY3Rs
eSwgaG93IGRvZXMgaXQgbWFrZSBzZW5zZSBmb3IgdGhlIApOVk1FIGRyaXZlciB0byBhZmZpbmUg
aW50ZXJydXB0cyB0byBDUFVzIHdoaWNoIGhhdmUgZXhwbGljaXRseSBiZWVuIApkZXNpZ25hdGVk
IGFzICJpc29sYXRlZCI/CgpUaGFua3MsCgpDaHJpcwoKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
