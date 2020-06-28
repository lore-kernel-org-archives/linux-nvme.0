Return-Path: <SRS0=+Irc=AJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B5CC433E2
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jun 2020 23:02:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B1B2076E
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jun 2020 23:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="judAwJo6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rbPz+Pq2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XMUtjM7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B1B2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+Pl4TGiMyNOUvh0n+aOqKZiAArZOWUWoilXtP9sV1aA=; b=judAwJo6d/tIV+ZWqLpalgFGj
	WzQ5jDarb7NgSZGrrKttvK40+/y+GBhBGXqoKH9oLP5urxJUOLjaNEYgTZV7dP1eUxV/21JkajMxS
	gaFWUjPN6NfFgQ8DIRcRluJ4HxiYiapzaKiAFLh1er8kHS6EeAo6Fv+UoO8IkUnpjvubzpQNzT4Hs
	7Khoem0MKCqdKIm4BzQsutcsnfxsE4btbFoQMpmxVVoa1H7ca8ZXwHuWDQmV9EGdu0sAsyCoNcZJH
	SFGRl+XE2dHacApmRYtArWc0UtU/wgCQSQFi24GHYlzkABQTKI6tnrBhN9+1pVNpi0VzkVkW23E3E
	kgD/D9ulg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpgJI-0008GY-Cl; Sun, 28 Jun 2020 23:02:04 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpgJF-0008Fe-J5
 for linux-nvme@lists.infradead.org; Sun, 28 Jun 2020 23:02:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593385322; x=1624921322;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=6R5hRxO5pHES573y78eR2zYl2qx0XNUrhAS2zORDx8o=;
 b=rbPz+Pq2JkJkhsrhKDL2gpwSIHw4lMyZu+FBN2U1sX40KNXdcbDgoLk/
 PNGgY33rIGfR+pF0ofApAzA5TM8Krsq1XidTQLJYidKDWl//HNbJ1NIXw
 putghLfmzzWd0R5VzRZISRoGAoyViT+vBHeRYk8syyT1aQA2DN7AHTYnU
 lpUmhPYztuOaqUf3q72Ama3W02DHpOPdfeD9x9WjjKXwttDIoZiKANpXY
 OoxyJ7gJR9KqVvwFhQ5X8Fj5TkTS6Snyt31hpg48GJ0gvjPHyULIKUDuD
 GgLdeRkK5EL90CxSZYMZOGcOobJgxGUTa/+MEPargwt65wlf9S/p/XqOf g==;
IronPort-SDR: n3BgWbi+MfLUbXDsk7UJZxHPzc4T6hBtmEgPiMQDmiEMdQefie9cYV4jNz2KIM8JYGdw/LliqR
 RsDGoCOIrhDkwb7dmZ73CB6Vrww+DkFbw4yskECAJP05Zdfrd8gvyUJ3nQC38mDIzT/2ZhCAII
 Pzu1yJDOWSdDkAbGI733KUEWZcc+jUPXhIKpKkidIB9GKGLNaEhC5b90xHp0/Wgmtf2CkhmZhj
 0NXmgmzhmq3A+jO2tw0kKRJ/leYwKfHmcmjDNKvdQE5H2QD04ETe7cvRUXpBKXpePR29nCrpyw
 njM=
X-IronPort-AV: E=Sophos;i="5.75,293,1589212800"; d="scan'208";a="145457404"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 07:01:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvDWMqcG1qBMHEhLRzXZgdDSPEjIzkTEAHwSxXBGz8bUAmoDoN7L2DN6/xQVylejw3Lv3GhNRfmvoq5iolCA0bSqkne2WsM9bz3tbtkqVihChCIaE/2ARDvty+Zu1oHPOKv0hleZD6nRxMyL+1Y5Eh5T/IgM4PWiDKAh5JNhabyAIid86Tr+NnIjt2JAvpoA8iMSdNSv7I109+ktgwCUymGWdf7HBlo3eB4sEWgYQ71OuU63o8oqJaQUugraq4oPGqmBf/hs7b5NAaar4zbuw0BQAhXHjTBcMGVdPPQM622LnW2/F5kwhhncB/5UgqglWiFCeW6jCmRZbrh4RHC02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7+JJRNW97go7vUzT8jmHwdxEl3RqQU3vUt2BlPb8sk=;
 b=Ot9tkSa6cbex4DBafwebF6F+3l/3pebqgwL5xa1C1FzvWS8kMSD4U1WebJ1/9x5Ke75YRKfve3BWkB+loDUeM8Nhk+fLsilSxZf8sukrkaeWAV3JoGycw01Oy/pGQw9xwZNU8QOPWIzShg8PEK7tP2dbRGsrtf8vtB6c66/l+Fo72h3hMquhe5rKE7eHQgJelspyabATTdxqXM2Zy5mv8+jeI75faGposM2SHb1xWop3WQfNxg45n/2ub8Fxar46sR7dUR/GFPq7wLvSqs3qgVrSLwdeGmQ+znl91k5zy0PEDqDK/ZAGV1QUcU9mL70yDg3ZN1AlpEVVdtsq58VraQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7+JJRNW97go7vUzT8jmHwdxEl3RqQU3vUt2BlPb8sk=;
 b=XMUtjM7OdVyggSF+PMyY9Km5BASJFNReSGlavsiKhFRu2oEq1gjfEiE7pHKmIxY4cTqH2d1d+v7DJQzMaUAIREi1B1uYq989j65sZIRpQRK7gU/x9tX8F0zJcHdibZCIaZ7qYN0nXTj6VnjWutkptwuCIuI/G93MxO05Byh+rqU=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
Received: from MN2PR04MB6223.namprd04.prod.outlook.com (2603:10b6:208:db::14)
 by MN2PR04MB5965.namprd04.prod.outlook.com (2603:10b6:208:d9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Sun, 28 Jun
 2020 23:01:55 +0000
Received: from MN2PR04MB6223.namprd04.prod.outlook.com
 ([fe80::899f:1d14:ad80:400e]) by MN2PR04MB6223.namprd04.prod.outlook.com
 ([fe80::899f:1d14:ad80:400e%4]) with mapi id 15.20.3131.026; Sun, 28 Jun 2020
 23:01:55 +0000
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 martin.petersen@oracle.com, damien.lemoal@wdc.com, niklas.cassel@wdc.com,
 hans.holmberg@wdc.com
Subject: [PATCH 1/2] block: add zone_desc_ext_bytes to sysfs
Date: Sun, 28 Jun 2020 23:01:01 +0000
Message-Id: <20200628230102.26990-2-matias.bjorling@wdc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200628230102.26990-1-matias.bjorling@wdc.com>
References: <20200628230102.26990-1-matias.bjorling@wdc.com>
X-ClientProxiedBy: AM5PR0202CA0018.eurprd02.prod.outlook.com
 (2603:10a6:203:69::28) To MN2PR04MB6223.namprd04.prod.outlook.com
 (2603:10b6:208:db::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ninja.localdomain (87.116.37.42) by
 AM5PR0202CA0018.eurprd02.prod.outlook.com (2603:10a6:203:69::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Sun, 28 Jun 2020 23:01:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [87.116.37.42]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f585e8f-cffd-45e5-c3e0-08d81bb74050
X-MS-TrafficTypeDiagnostic: MN2PR04MB5965:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB596579903861205923225480F1910@MN2PR04MB5965.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0448A97BF2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKR43QHdEXIfKFk0m9qyfVh4SIOxveSCSc4IvOkBJ8hDuSmFKHxJ5zs+v7RTYAU1JzyZheuuP7i3Pi3YHfB8zb0wR4Cu7GIkQplIlZZqfvll4OLoTBQwg/v6QC8ox2AAx9CdeuD0Ti5kHS+05G/MWB0Ooysb0mgZzVjtnPzT8rKkZ72m4pDgmO9oa76BuNXILlC2sTuprv2z7YwC6lxw8ybEhIsGLXBHKudEaigLQEVLSmuizO7aMiRICmzWUdYzvA+pEY/8ZJ0kXPCVC1ZJdnyB6HiyLK1+zjnwpEyEgVYIFoBDIcMDg/iqOy/cHthTe2QJK8FNwn6d5ONWjY0htg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6223.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(366004)(396003)(39850400004)(376002)(6486002)(4326008)(2616005)(956004)(1076003)(86362001)(6636002)(66946007)(316002)(66556008)(66476007)(186003)(6512007)(26005)(6666004)(66574015)(6506007)(8936002)(2906002)(83380400001)(36756003)(5660300002)(52116002)(16526019)(478600001)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JZ8omU0OPk9LQ2SfWDhc0EKtpJ+iY+8yohEIv98iq9WMWU2I9JNzTidvOtvcQb7tWVqDXf6nrihheZhUBSDt9DAGWFnD5tUh/v9ioJTP2s2NBGsCBn58YGiD/9H4Kqt5sh/ezo/HNckCkO/PXFSXnL4rBnQ6+LdQLG4J8Sbgj+xe0Sy+KZDZqoFi/nAIZNu4+KpT7M8bJCvrvrXgDyW9FkJFhGHjw939Ue4hnSo6nz64geKj7N7eVJ0yTYMBBeCTZFWMF/RYlausYV2RLxN8b6sINnz/f04dE2YrdIpohBM3yAeLaD33Qz6wsjJL+8IFE/HkvWRQu45VBzJqjrmqANaFpT5vgT/wxKYT+VkUr7oBMZcv3cfAaRnAATmDdQZjJXWdERNs8qA5px5Xl4qZ4h+n0+/fXQCJqYQ2HOSNcVyzfxx1QYWQDKsuQKdfBl/1KA44ntTsunfzctlAmUuMsjyYXw3hx6G34qISFJ65P54=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f585e8f-cffd-45e5-c3e0-08d81bb74050
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6223.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2020 23:01:55.0382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4d1o6t8W+53hbqD+qznTL+L53KPlmx9pyQJomi2rZRUKGR/l8flWaJiZaSpSoqC/pdlvAuSxAI1tdBjLzUuKrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5965
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
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhlIE5WTWUgWm9uZWQgTmFtZXNwYWNlIENvbW1hbmQgU2V0IGFkZHMgc3VwcG9ydCBmb3IgYXNz
b2NpYXRpbmcKZGF0YSB0byBhIHpvbmUgdGhyb3VnaCB0aGUgWm9uZSBEZXNjcmlwdG9yIEV4dGVu
c2lvbiBmZWF0dXJlLgoKVGhlIFpvbmUgRGVzY3JpcHRvciBFeHRlbnNpb24gc2l6ZSBpcyBmaXhl
ZCB0byBhIG11bHRpcGxlIG9mIDY0CmJ5dGVzLiBBIHZhbHVlIG9mIHplcm8gY29tbXVuaWNhdGVz
IHRoZSBmZWF0dXJlIGlzIG5vdCBhdmFpbGFibGUuCkEgdmFsdWUgbGFyZ2VyIHRoYW4gemVybyBj
b21tdW5pdGVzIHRoZSBmZWF0dXJlIGlzIGF2YWlsYWJsZSwgYW5kCnRoZSBzcGVjaWZpZWQgWm9u
ZSBEZXNjcmlwdG9yIEV4dGVuc2lvbiBzaXplIGluIGJ5dGVzLgoKVGhlIFpvbmUgRGVzY3JpcHRv
ciBFeHRlbnNpb24gZmVhdHVyZSBpcyBvbmx5IGF2YWlsYWJsZSBpbiB0aGUKTlZNZSBab25lZCBO
YW1lc3BhY2VzIENvbW1hbmQgU2V0LiBEZXZpY2VzIHRoYXQgc3VwcG9ydHMgWkFDL1pCQwp0aGVy
ZWZvcmUgcmVwb3J0cyB0aGlzIHZhbHVlIGFzIHplcm8sIHdoZXJlIGFzIHRoZSBOVk1lIGRldmlj
ZQpkcml2ZXIgcmVwb3J0cyB0aGUgWm9uZSBEZXNjcmlwdG9yIEV4dGVuc2lvbiBzaXplIGZyb20g
dGhlCnNwZWNpZmljIGRldmljZS4KClNpZ25lZC1vZmYtYnk6IE1hdGlhcyBCasO4cmxpbmcgPG1h
dGlhcy5iam9ybGluZ0B3ZGMuY29tPgotLS0KIERvY3VtZW50YXRpb24vYmxvY2svcXVldWUtc3lz
ZnMucnN0IHwgIDYgKysrKysrCiBibG9jay9ibGstc3lzZnMuYyAgICAgICAgICAgICAgICAgICB8
IDE1ICsrKysrKysrKysrKysrLQogZHJpdmVycy9udm1lL2hvc3Qvem5zLmMgICAgICAgICAgICAg
fCAgMSArCiBkcml2ZXJzL3Njc2kvc2RfemJjLmMgICAgICAgICAgICAgICB8ICAxICsKIGluY2x1
ZGUvbGludXgvYmxrZGV2LmggICAgICAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysr
KwogNSBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9ibG9jay9xdWV1ZS1zeXNmcy5yc3QgYi9Eb2N1bWVudGF0
aW9uL2Jsb2NrL3F1ZXVlLXN5c2ZzLnJzdAppbmRleCBmMjYxYTVjODQxNzAuLmM0ZmExOTVjODdi
NCAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9ibG9jay9xdWV1ZS1zeXNmcy5yc3QKKysrIGIv
RG9jdW1lbnRhdGlvbi9ibG9jay9xdWV1ZS1zeXNmcy5yc3QKQEAgLTI2NSw0ICsyNjUsMTAgQEAg
ZGV2aWNlcyBhcmUgZGVzY3JpYmVkIGluIHRoZSBaQkMgKFpvbmVkIEJsb2NrIENvbW1hbmRzKSBh
bmQgWkFDCiBkbyBub3Qgc3VwcG9ydCB6b25lIGNvbW1hbmRzLCB0aGV5IHdpbGwgYmUgdHJlYXRl
ZCBhcyByZWd1bGFyIGJsb2NrIGRldmljZXMKIGFuZCB6b25lZCB3aWxsIHJlcG9ydCAibm9uZSIu
CiAKK3pvbmVfZGVzY19leHRfYnl0ZXMgKFJPKQorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQor
VGhpcyBpbmRpY2F0ZXMgdGhlIHpvbmUgZGVzY3JpcHRpb24gZXh0ZW5zaW9uIChaREUpIHNpemUs
IGluIGJ5dGVzLCBvZiBhIHpvbmVkCitibG9jayBkZXZpY2UuIEEgdmFsdWUgb2YgJzAnIG1lYW5z
IHRoYXQgem9uZSBkZXNjcmlwdGlvbiBleHRlbnNpb24gaXMgbm90CitzdXBwb3J0ZWQuCisKIEpl
bnMgQXhib2UgPGplbnMuYXhib2VAb3JhY2xlLmNvbT4sIEZlYnJ1YXJ5IDIwMDkKZGlmZiAtLWdp
dCBhL2Jsb2NrL2Jsay1zeXNmcy5jIGIvYmxvY2svYmxrLXN5c2ZzLmMKaW5kZXggNjI0YmI0ZDg1
ZmM3Li4wYzk5NDU0ODIzYjcgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2Jsay1zeXNmcy5jCisrKyBiL2Js
b2NrL2Jsay1zeXNmcy5jCkBAIC0zMTUsNiArMzE1LDEyIEBAIHN0YXRpYyBzc2l6ZV90IHF1ZXVl
X21heF9hY3RpdmVfem9uZXNfc2hvdyhzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwgY2hhciAqcGFn
ZSkKIAlyZXR1cm4gcXVldWVfdmFyX3Nob3cocXVldWVfbWF4X2FjdGl2ZV96b25lcyhxKSwgcGFn
ZSk7CiB9CiAKK3N0YXRpYyBzc2l6ZV90IHF1ZXVlX3pvbmVfZGVzY19leHRfYnl0ZXNfc2hvdyhz
dHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwKKwkJY2hhciAqcGFnZSkKK3sKKwlyZXR1cm4gcXVldWVf
dmFyX3Nob3cocXVldWVfem9uZV9kZXNjX2V4dF9ieXRlcyhxKSwgcGFnZSk7Cit9CisKIHN0YXRp
YyBzc2l6ZV90IHF1ZXVlX25vbWVyZ2VzX3Nob3coc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsIGNo
YXIgKnBhZ2UpCiB7CiAJcmV0dXJuIHF1ZXVlX3Zhcl9zaG93KChibGtfcXVldWVfbm9tZXJnZXMo
cSkgPDwgMSkgfApAQCAtNjg3LDYgKzY5MywxMSBAQCBzdGF0aWMgc3RydWN0IHF1ZXVlX3N5c2Zz
X2VudHJ5IHF1ZXVlX21heF9hY3RpdmVfem9uZXNfZW50cnkgPSB7CiAJLnNob3cgPSBxdWV1ZV9t
YXhfYWN0aXZlX3pvbmVzX3Nob3csCiB9OwogCitzdGF0aWMgc3RydWN0IHF1ZXVlX3N5c2ZzX2Vu
dHJ5IHF1ZXVlX3pvbmVfZGVzY19leHRfYnl0ZXNfZW50cnkgPSB7CisJLmF0dHIgPSB7Lm5hbWUg
PSAiem9uZV9kZXNjX2V4dF9ieXRlcyIsIC5tb2RlID0gMDQ0NCB9LAorCS5zaG93ID0gcXVldWVf
em9uZV9kZXNjX2V4dF9ieXRlc19zaG93LAorfTsKKwogc3RhdGljIHN0cnVjdCBxdWV1ZV9zeXNm
c19lbnRyeSBxdWV1ZV9ub21lcmdlc19lbnRyeSA9IHsKIAkuYXR0ciA9IHsubmFtZSA9ICJub21l
cmdlcyIsIC5tb2RlID0gMDY0NCB9LAogCS5zaG93ID0gcXVldWVfbm9tZXJnZXNfc2hvdywKQEAg
LTc4Nyw2ICs3OTgsNyBAQCBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqcXVldWVfYXR0cnNbXSA9
IHsKIAkmcXVldWVfbnJfem9uZXNfZW50cnkuYXR0ciwKIAkmcXVldWVfbWF4X29wZW5fem9uZXNf
ZW50cnkuYXR0ciwKIAkmcXVldWVfbWF4X2FjdGl2ZV96b25lc19lbnRyeS5hdHRyLAorCSZxdWV1
ZV96b25lX2Rlc2NfZXh0X2J5dGVzX2VudHJ5LmF0dHIsCiAJJnF1ZXVlX25vbWVyZ2VzX2VudHJ5
LmF0dHIsCiAJJnF1ZXVlX3JxX2FmZmluaXR5X2VudHJ5LmF0dHIsCiAJJnF1ZXVlX2lvc3RhdHNf
ZW50cnkuYXR0ciwKQEAgLTgxNSw3ICs4MjcsOCBAQCBzdGF0aWMgdW1vZGVfdCBxdWV1ZV9hdHRy
X3Zpc2libGUoc3RydWN0IGtvYmplY3QgKmtvYmosIHN0cnVjdCBhdHRyaWJ1dGUgKmF0dHIsCiAJ
CQlyZXR1cm4gMDsKIAogCWlmICgoYXR0ciA9PSAmcXVldWVfbWF4X29wZW5fem9uZXNfZW50cnku
YXR0ciB8fAotCSAgICAgYXR0ciA9PSAmcXVldWVfbWF4X2FjdGl2ZV96b25lc19lbnRyeS5hdHRy
KSAmJgorCSAgICAgYXR0ciA9PSAmcXVldWVfbWF4X2FjdGl2ZV96b25lc19lbnRyeS5hdHRyIHx8
CisJICAgICBhdHRyID09ICZxdWV1ZV96b25lX2Rlc2NfZXh0X2J5dGVzX2VudHJ5LmF0dHIpICYm
CiAJICAgICFibGtfcXVldWVfaXNfem9uZWQocSkpCiAJCXJldHVybiAwOwogCmRpZmYgLS1naXQg
YS9kcml2ZXJzL252bWUvaG9zdC96bnMuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCmluZGV4
IDUwMjA3MDc2MzI2Ni4uNTc5MmQ5NTNhOGYzIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9z
dC96bnMuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC96bnMuYwpAQCAtODQsNiArODQsNyBAQCBp
bnQgbnZtZV91cGRhdGVfem9uZV9pbmZvKHN0cnVjdCBnZW5kaXNrICpkaXNrLCBzdHJ1Y3QgbnZt
ZV9ucyAqbnMsCiAJYmxrX3F1ZXVlX2ZsYWdfc2V0KFFVRVVFX0ZMQUdfWk9ORV9SRVNFVEFMTCwg
cSk7CiAJYmxrX3F1ZXVlX21heF9vcGVuX3pvbmVzKHEsIGxlMzJfdG9fY3B1KGlkLT5tb3IpICsg
MSk7CiAJYmxrX3F1ZXVlX21heF9hY3RpdmVfem9uZXMocSwgbGUzMl90b19jcHUoaWQtPm1hcikg
KyAxKTsKKwlibGtfcXVldWVfem9uZV9kZXNjX2V4dF9ieXRlcyhxLCBpZC0+bGJhZmVbbGJhZl0u
emRlcyA8PCA2KTsKIGZyZWVfZGF0YToKIAlrZnJlZShpZCk7CiAJcmV0dXJuIHN0YXR1czsKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zZF96YmMuYyBiL2RyaXZlcnMvc2NzaS9zZF96YmMuYwpp
bmRleCBkOGIyYzQ5ZDY0NWIuLmE0YjZkNmNmNTQ1NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9zY3Np
L3NkX3piYy5jCisrKyBiL2RyaXZlcnMvc2NzaS9zZF96YmMuYwpAQCAtNzIyLDYgKzcyMiw3IEBA
IGludCBzZF96YmNfcmVhZF96b25lcyhzdHJ1Y3Qgc2NzaV9kaXNrICpzZGtwLCB1bnNpZ25lZCBj
aGFyICpidWYpCiAJZWxzZQogCQlibGtfcXVldWVfbWF4X29wZW5fem9uZXMocSwgc2RrcC0+em9u
ZXNfbWF4X29wZW4pOwogCWJsa19xdWV1ZV9tYXhfYWN0aXZlX3pvbmVzKHEsIDApOworCWJsa19x
dWV1ZV96b25lX2Rlc2NfZXh0X2J5dGVzKHEsIDApOwogCW5yX3pvbmVzID0gcm91bmRfdXAoc2Rr
cC0+Y2FwYWNpdHksIHpvbmVfYmxvY2tzKSA+PiBpbG9nMih6b25lX2Jsb2Nrcyk7CiAKIAkvKiBS
RUFEMTYvV1JJVEUxNiBpcyBtYW5kYXRvcnkgZm9yIFpCQyBkaXNrcyAqLwpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9ibGtkZXYuaCBiL2luY2x1ZGUvbGludXgvYmxrZGV2LmgKaW5kZXggMzc3
NjE0MGY4ZjIwLi4yZWQ1NTA1NWY2OGQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvYmxrZGV2
LmgKKysrIGIvaW5jbHVkZS9saW51eC9ibGtkZXYuaApAQCAtNTIyLDYgKzUyMiw3IEBAIHN0cnVj
dCByZXF1ZXN0X3F1ZXVlIHsKIAl1bnNpZ25lZCBsb25nCQkqc2VxX3pvbmVzX3dsb2NrOwogCXVu
c2lnbmVkIGludAkJbWF4X29wZW5fem9uZXM7CiAJdW5zaWduZWQgaW50CQltYXhfYWN0aXZlX3pv
bmVzOworCXVuc2lnbmVkIGludAkJem9uZV9kZXNjX2V4dF9ieXRlczsKICNlbmRpZiAvKiBDT05G
SUdfQkxLX0RFVl9aT05FRCAqLwogCiAJLyoKQEAgLTc1Myw2ICs3NTQsMTggQEAgc3RhdGljIGlu
bGluZSB1bnNpZ25lZCBpbnQgcXVldWVfbWF4X2FjdGl2ZV96b25lcyhjb25zdCBzdHJ1Y3QgcmVx
dWVzdF9xdWV1ZSAqcSkKIHsKIAlyZXR1cm4gcS0+bWF4X2FjdGl2ZV96b25lczsKIH0KKworc3Rh
dGljIGlubGluZSB2b2lkIGJsa19xdWV1ZV96b25lX2Rlc2NfZXh0X2J5dGVzKHN0cnVjdCByZXF1
ZXN0X3F1ZXVlICpxLAorCQl1bnNpZ25lZCBpbnQgem9uZV9kZXNjX2V4dF9ieXRlcykKK3sKKwlx
LT56b25lX2Rlc2NfZXh0X2J5dGVzID0gem9uZV9kZXNjX2V4dF9ieXRlczsKK30KKworc3RhdGlj
IGlubGluZSB1bnNpZ25lZCBpbnQgcXVldWVfem9uZV9kZXNjX2V4dF9ieXRlcygKKwkJY29uc3Qg
c3RydWN0IHJlcXVlc3RfcXVldWUgKnEpCit7CisJcmV0dXJuIHEtPnpvbmVfZGVzY19leHRfYnl0
ZXM7Cit9CiAjZWxzZSAvKiBDT05GSUdfQkxLX0RFVl9aT05FRCAqLwogc3RhdGljIGlubGluZSB1
bnNpZ25lZCBpbnQgYmxrX3F1ZXVlX25yX3pvbmVzKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQog
ewpAQCAtNzg0LDYgKzc5NywxNSBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBxdWV1ZV9t
YXhfYWN0aXZlX3pvbmVzKGNvbnN0IHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQogewogCXJldHVy
biAwOwogfQorc3RhdGljIGlubGluZSB2b2lkIGJsa19xdWV1ZV96b25lX2Rlc2NfZXh0X2J5dGVz
KHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLAorCQl1bnNpZ25lZCBpbnQgem9uZV9kZXNjX2V4dF9i
eXRlcykKK3sKK30KK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHF1ZXVlX3pvbmVfZGVzY19l
eHRfYnl0ZXMoCisJCWNvbnN0IHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQoreworCXJldHVybiAw
OworfQogI2VuZGlmIC8qIENPTkZJR19CTEtfREVWX1pPTkVEICovCiAKIHN0YXRpYyBpbmxpbmUg
Ym9vbCBycV9pc19zeW5jKHN0cnVjdCByZXF1ZXN0ICpycSkKLS0gCjIuMTcuMQoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
