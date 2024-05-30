Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC94C27C43
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8LjktfkSojzHlVV+cN/LfzKEvgw75PDXePaqim/1vS4=; b=M/cFRumFy4lPl7zljLAuZg0Baa
	JCeRT/X04q3Or6iUzqj8ge5Yi3G05MNPyGK70uPWno+RFdzmw/ylIBDYKzScWLFOo5ZMOEaFpi01f
	D93SwbxdvpdNOdU4SF5KM2ssGbqLtE6ebYwyG1TbOQYCbzI6STi88Q4S4+ryI/pnKumpMzrjeaKLK
	BBU90dZkg0tkl0tVQvIdsEpsjAGHRguGbfbYJRNlU0/2HcDdjFudejodDp9YIkw46PwM2Vs+ahTUp
	W6WSxzDyEhXvrvSnrRT5NCNpE9qImBu4BNFctwMm/uNyvgLhN+ZuWBbVMjlzECTVVChUUIfIu6Q4r
	0yqDBW4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCfo2-00000007MHu-23Fw;
	Thu, 30 May 2024 13:26:58 +0000
Received: from mail-he1eur04on2071c.outbound.protection.outlook.com ([2a01:111:f403:260f::71c] helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCfnz-00000007MFK-2qTk
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 13:26:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6fzBMc9EasrK0hc+JYeHHd+aLX5sl1S3t5D2BjcmjUVeelauu9B7HTZHvSVepccPuffC2v+bJuKLHLN+lknfSy8Dvyub9Hu+/GkL4/A0wij/+LKdF6G69UIBcsH2aI4Mw6ULDRn7t72LZsGxQjonUNzacJHwEgCkUPL2dfMQ+nhQrtfI+NaBJiyY6LvDQHSKyIY1SlSQ2VguNneHRj7+8qpnArMHCHVCK4sdEg18duEWznkvwOhS5zNNJo8OuxnwYz6r+l1TjqMxbOP9jABojkknI+6gbN+UiYTT54xjRKJaovLv9++LYUkEx++kPSuhmOeq3fmaer0Vo2v9cKndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LjktfkSojzHlVV+cN/LfzKEvgw75PDXePaqim/1vS4=;
 b=OE6YLfWlkWdpYDpFQcooIHtEX6NKLh/E0TC2LVLGgAOsSNTds5s+DLB4GMPpF8dU2tX4na5+8B6RSLWrckPvAbHzRSC6jmNuQodnBWLnNiuomBhq82P8I3w+q09gpvo03O866CrzEc9JSbTwwuhU8xRD4BX6cCKWGMm2ejHlARI3H6UX2Q7tfeSQa+LCoNNdsfTujyf2vQ7BfMJEG8BGWsxOfCanP0wUTOn9j6eAsATiFJWDjfN7+hKENTpl6dHp+Y5jdTqqIKYWQpO9BwKcFHA6snpoUHgsEX4iFxSP5bOik11c/6ay3/KJhfR509/tYawnf7bZewQT/ncck21pqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LjktfkSojzHlVV+cN/LfzKEvgw75PDXePaqim/1vS4=;
 b=FF5BD8mzADiSra2OYQiZH+1UD3p1fVV3Guz8MDBVzWDAbi64aufLnlZVNZxh3GC1ZDR7h80x4VlfFtzMYEsX7HNEC3Z8hnCUDte7nmKq3thHpVGb+uVN/0BfYaVpbBAOb//r6/2TVIHZBwo1oWf/hh9tDb9E6OZ9I7Y6kaOFb4o4CfVR8YQxnjbNGo6zI1mOxEhMMoTQmtQPkX0YPANSoZGdczdPQmWiDQCijfVNlenujbURfgNVJjdlcN+rycJNrKrip/CLtTa2q4djaIKaS9actFdTILfPIbELECrSTMMEWCA0oRgxkEFrWOEf9hJCsDFMiNHzk3oTOhS/i0oxJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 13:26:45 +0000
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb]) by AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb%3]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 13:26:45 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: davem@davemloft.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com,
	edumazet@google.com,
	pabeni@redhat.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	idryomov@gmail.com,
	xiubli@redhat.com
Subject: [PATCH 0/4] bugfix: Introduce sendpages_ok() to check sendpage_ok() on contiguous pages
Date: Thu, 30 May 2024 16:26:22 +0300
Message-ID: <20240530132629.4180932-1-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.45.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To AM0PR04MB5107.eurprd04.prod.outlook.com
 (2603:10a6:208:cb::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5107:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: a523813c-b37c-469d-4f78-08dc80ac26fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5K6LXFgqrWvufaEfgeHLMz00z0KC6Nd1JQ2FQXC2C8mhMZsQbSE5MCtAMlv2?=
 =?us-ascii?Q?LTKaQvkv4xdqFKX5iw6lzF8QlN5Y3u+oT6i0CwfsMIPadrvDKYzThwpGCmar?=
 =?us-ascii?Q?a2Hfa+aX9nhPHtaHAAWdoPf/yAbtJCqCeMBZoNK+Ci0ZAscZ6by/Ak5Vywwl?=
 =?us-ascii?Q?ycbAb4kTrjd6fJSmHE36kJZpA+a7wCSNLEiVOJpAoI/8B3+qGYozmnxNQqmV?=
 =?us-ascii?Q?vEDAUJ/GlUSFEhZrEP1fKBlfy8siEU2PHUeLljmVNfYT0QFY6P09+83vaTJj?=
 =?us-ascii?Q?LJvRIlXP6iHaGozQhggpfmsWJx4DBH/sCqzhBZXHL5wWIoGuwkiXTzOcfHS2?=
 =?us-ascii?Q?Rw4dmFFRMvACOCxyrAQIbs2rKzPq77d9xgUh26Wqh1F4XVOgBFWiJoPYUhWo?=
 =?us-ascii?Q?uAykZxt9Pk0lw5ap28fj8oGexiwHElsdnXV6ErUZx1y03WXw4mex7Bl6pT+e?=
 =?us-ascii?Q?pDaIyoNxxtMSfWwJQlIkYW6vioabu/doTOGAT0kkZpxTW2Ls/sn9eXQJlxNa?=
 =?us-ascii?Q?0G85hNoPcnCak8njkER4/2PaC/O3Y0PsaaYZ8DmdaKYfSKRsplIRAHfjC5CN?=
 =?us-ascii?Q?zG2UyZNZ4G4Nug5QIlISAaD6WnBwJjgjnRuNbG4FaRKvQhSu3Wb3dh2nFArj?=
 =?us-ascii?Q?aZO7Jy4W8xXvOfiM5Hv7tWhu1INylZW1PAMM+6OwupcBK3rXgztO38Owj/zZ?=
 =?us-ascii?Q?ivaJZLNoeLxITv57GZdrhQi7PgHKM2GuE+0kkaRR3Qp7CkaxyozBOXnAZb1l?=
 =?us-ascii?Q?1Z9TZMf2QnB5V4YMU+VNnMdmqmghIZB30uyaAIqWQd0BwsOywFM08Bm+lbE7?=
 =?us-ascii?Q?u4HLebabEMRfG3DO3ps9AYFPHeUd82VLrYGx81B1gyR3szZtVhRXT6O3aYFb?=
 =?us-ascii?Q?WefgQQkx47E0ylHNvkTF5cvYsubbKkG4J140t29mz+5sfqIPGXZsXOYCxcbx?=
 =?us-ascii?Q?DDfQx7KNO/8BvZwWN/UaWbx5ODmtsqs5/T+exT8Pa3U/aJI5g3ThpcvRnEjn?=
 =?us-ascii?Q?2JK4bw3XgKdA/XyytCQ2tewNxSB2K+EJnHsN0NySdBGoU16yOG7Uh4zCnlhP?=
 =?us-ascii?Q?YbrvLJ9GPaC6iEr4OdcgHN7RmOENZOlmoE7P78CmDUAq0/spHRdiBM8v9VhA?=
 =?us-ascii?Q?Cql0DGQSSY+MTgF41TNpSduzjrfxNgXFYWdv0QwHQD/ubupxGjK/h1yTSjMD?=
 =?us-ascii?Q?7bH21vuSuomjt3cLI27JrG+POeHkMM9HesQlsnkEDXDh43+2iluxemyh3DiC?=
 =?us-ascii?Q?CqPxWTCMrvFlM033hGQKPwSW8mV7b2E04JhWK9ys64Ryf5TKLXZ5SO7GUEuc?=
 =?us-ascii?Q?7Q5SRlNRK2eCbr2dIZz4DfIX+I+y+IOCgS0Su6+R9JrBQg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FxylndTLLIT5mi3T1QBvtfSkQsPkA/D/mz3+VU5/6oGrklnPt6TZxhAcwr4b?=
 =?us-ascii?Q?YjsVXln+/QO/Xlf537gf/b9P2xhdmGfwS9AGCzk7TyygUMmT4mrkLR34RXys?=
 =?us-ascii?Q?UrIXkYI0h3yRMKUiagNSld2dDYuxfuYselXj8cvNEFTt8TOPnKmdX0QCmeSk?=
 =?us-ascii?Q?vzAcqI14LaxfCDVne/nVatDnmoCaIvCeAXvzaenR2DnIrTUhg9CUvCOdkqjl?=
 =?us-ascii?Q?0ysdkNGoj7hOXMLdZDVRvZMAWgoNBLQ/I2Fm/7Ajvq4nFqhxyJ/wschAFzij?=
 =?us-ascii?Q?BW2iR34NKRLMXkNMhD+eiNcO4gpFSljqzfVjWBUKSw1zqhGolqQE/xtH2kyh?=
 =?us-ascii?Q?WaO2cnUEq8V113MGMzGvKYSbIRWbM6ZAgzAj4bedbKAFLCXl1lj0oRB0e8T3?=
 =?us-ascii?Q?f7p04oODve2tN0h9hbZOk1CkYcv2/sm7+tK0+H20dvSuBlFo43is3RRXa5Ng?=
 =?us-ascii?Q?l66LSDN3ZMLudFuBWsLD2e3FCsZIV9BVWTm69vVTBRk1dZTiG7rH4PGAUArN?=
 =?us-ascii?Q?6hm+NU1GEvDgdnJYN/cs26/CyqUOTS7Kww9Edy02BxazWSiZLOCf0l4iAMac?=
 =?us-ascii?Q?/AGPJWq0TaEFuBlhapVqsx4yx43OOse/GBgarByLzLd1GNPCUZsh60hTk63g?=
 =?us-ascii?Q?vEvVbxWDjil3xGFKtEJi7xFhZsBG8ZGar+7TbF0Fmkuf4rYHKzw4oa7PsGL0?=
 =?us-ascii?Q?Gc4GD+/3YViitvn4giM3LEuxuGuIpcTKdULIGOaYytYhxXeedo1nUK5TSX/o?=
 =?us-ascii?Q?e2UQZ11nWN6ExU5eQX2jon5GoCrMZXEyP7qVIvEKQFjC1osANhMlHNZYdJnc?=
 =?us-ascii?Q?RI2L4YGtnsBk25S3np3INekoSzLoP8+4D+S9QODCAPVA5QqatqMs1AdiK8Yr?=
 =?us-ascii?Q?hvuzSLRRTS9DMVwrNhX9iz8zjguf+i4GsddSPboTQ0yL63rvRfHbOZlzh4UB?=
 =?us-ascii?Q?xOr24wjzP+lwjfQjLlUmZkMOFF2srXhahZEMXJppGmTpbEmd9MXMUc/1iPgY?=
 =?us-ascii?Q?eA1GtNsRyS8nZfuxlbFFh2v6YnB4HA0wDhtPmv5RFIwfGBQha2cCp+QN7ysv?=
 =?us-ascii?Q?0ep0OAyNWWogiDT3g0NK4xwojPEFj8cKwzVIkzIpsRlzyDjoJzlfGs3m8+u3?=
 =?us-ascii?Q?9mYV6cEnIWPzot8TX3x0LXUdA2MwB5HUyVm+ORBCkXb+6/2VvEQCXK1hhzo2?=
 =?us-ascii?Q?thnFcheulDMIbisP6xrmNc6AaGutTe1OLRHl8XW9RW6Wu0vmNyBJLeE9rJ+G?=
 =?us-ascii?Q?bDRZ4iNQ+S11QGJg2RCHPoXCDNQl2M9mMC43cpzz51onV76cTLCF8X7+gxHe?=
 =?us-ascii?Q?C64D458kF6JuxuaF4GNyezLWdXFiBlX0nXJg3S4Y1tiuPXgYu6vvAQvVFaeV?=
 =?us-ascii?Q?JbWca41yNHJ9cjIL4hejGJPFBy02tz2eZdXa+hpjgscAd+bY6i3dWX3+DNvd?=
 =?us-ascii?Q?KxB3NU9oqqlC8868xPJ4azlqK9ysMsg5gnhKEdchnR4koPXGN/xvrcSfyIN9?=
 =?us-ascii?Q?StsC9MTjhGD4weOibRF242Y92t6p7A9tzGODp1wgTdxaP2ItR8+SJPFjivmd?=
 =?us-ascii?Q?6QW+st+JbUlk1fPXpi2ZS4N9xo7ROthEp+h+1YOY?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a523813c-b37c-469d-4f78-08dc80ac26fa
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 13:26:45.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/pKJKpIxV1BIax2S9jvVxMhQhmv24+Qt0QRDV6dh1D423I+4Jv7J1YLchX3v7QVhEUeCMWIff82YPLm+jTIDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_062655_917057_BE57407A 
X-CRM114-Status: GOOD (  22.07  )
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

skb_splice_from_iter() warns on !sendpage_ok() which results in nvme-tcp
data transfer failure. This warning leads to hanging IO.

nvme-tcp using sendpage_ok() to check the first page of an iterator in
order to disable MSG_SPLICE_PAGES. The iterator can represent a list of
contiguous pages.

When MSG_SPLICE_PAGES is enabled skb_splice_from_iter() is being used,
it requires all pages in the iterator to be sendable.
skb_splice_from_iter() checks each page with sendpage_ok().

nvme_tcp_try_send_data() might allow MSG_SPLICE_PAGES when the first
page is sendable, but the next one are not. skb_splice_from_iter() will
attempt to send all the pages in the iterator. When reaching an
unsendable page the IO will hang.

The patch introduces a helper sendpages_ok(), it returns true if all the
continuous pages are sendable.

Drivers who want to send contiguous pages with MSG_SPLICE_PAGES may use
this helper to check whether the page list is OK. If the helper does not
return true, the driver should remove MSG_SPLICE_PAGES flag.


The bug is reproducible, in order to reproduce we need nvme-over-tcp
controllers with optimal IO size bigger than PAGE_SIZE. Creating a raid
with bitmap over those devices reproduces the bug.

In order to simulate large optimal IO size you can use dm-stripe with a
single device.
Script to reproduce the issue on top of brd devices using dm-stripe is
attached below.


I have added 3 prints to test my theory. One in nvme_tcp_try_send_data()
and two others in skb_splice_from_iter() the first before sendpage_ok()
and the second on !sendpage_ok(), after the warning.
...
nvme_tcp: sendpage_ok, page: 0x654eccd7 (pfn: 120755), len: 262144, offset: 0
skbuff: before sendpage_ok - i: 0. page: 0x654eccd7 (pfn: 120755)
skbuff: before sendpage_ok - i: 1. page: 0x1666a4da (pfn: 120756)
skbuff: before sendpage_ok - i: 2. page: 0x54f9f140 (pfn: 120757)
WARNING: at net/core/skbuff.c:6848 skb_splice_from_iter+0x142/0x450
skbuff: !sendpage_ok - page: 0x54f9f140 (pfn: 120757). is_slab: 1, page_count: 1
...


stack trace:
...
WARNING: at net/core/skbuff.c:6848 skb_splice_from_iter+0x141/0x450
Workqueue: nvme_tcp_wq nvme_tcp_io_work
Call Trace:
 ? show_regs+0x6a/0x80
 ? skb_splice_from_iter+0x141/0x450
 ? __warn+0x8d/0x130
 ? skb_splice_from_iter+0x141/0x450
 ? report_bug+0x18c/0x1a0
 ? handle_bug+0x40/0x70
 ? exc_invalid_op+0x19/0x70
 ? asm_exc_invalid_op+0x1b/0x20
 ? skb_splice_from_iter+0x141/0x450
 tcp_sendmsg_locked+0x39e/0xee0
 ? _prb_read_valid+0x216/0x290
 tcp_sendmsg+0x2d/0x50
 inet_sendmsg+0x43/0x80
 sock_sendmsg+0x102/0x130
 ? vprintk_default+0x1d/0x30
 ? vprintk+0x3c/0x70
 ? _printk+0x58/0x80
 nvme_tcp_try_send_data+0x17d/0x530
 nvme_tcp_try_send+0x1b7/0x300
 nvme_tcp_io_work+0x3c/0xc0
 process_one_work+0x22e/0x420
 worker_thread+0x50/0x3f0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xd6/0x100
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
...

Ofir Gal (4):
  net: introduce helper sendpages_ok()
  nvme-tcp: use sendpages_ok() instead of sendpage_ok()
  drbd: use sendpages_ok() to instead of sendpage_ok()
  libceph: use sendpages_ok() to instead of sendpage_ok()

 drivers/block/drbd/drbd_main.c |  2 +-
 drivers/nvme/host/tcp.c        |  2 +-
 include/linux/net.h            | 20 ++++++++++++++++++++
 net/ceph/messenger_v1.c        |  2 +-
 net/ceph/messenger_v2.c        |  2 +-
 5 files changed, 24 insertions(+), 4 deletions(-)

---
 reproduce.sh | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100755 reproduce.sh

diff --git a/reproduce.sh b/reproduce.sh
new file mode 100755
index 000000000..8ae226b18
--- /dev/null
+++ b/reproduce.sh
@@ -0,0 +1,114 @@
+#!/usr/bin/env sh
+# SPDX-License-Identifier: MIT
+
+set -e
+
+load_modules() {
+    modprobe nvme
+    modprobe nvme-tcp
+    modprobe nvmet
+    modprobe nvmet-tcp
+}
+
+setup_ns() {
+    local dev=$1
+    local num=$2
+    local port=$3
+    ls $dev > /dev/null
+
+    mkdir -p /sys/kernel/config/nvmet/subsystems/$num
+    cd /sys/kernel/config/nvmet/subsystems/$num
+    echo 1 > attr_allow_any_host
+
+    mkdir -p namespaces/$num
+    cd namespaces/$num/
+    echo $dev > device_path
+    echo 1 > enable
+
+    ln -s /sys/kernel/config/nvmet/subsystems/$num \
+        /sys/kernel/config/nvmet/ports/$port/subsystems/
+}
+
+setup_port() {
+    local num=$1
+
+    mkdir -p /sys/kernel/config/nvmet/ports/$num
+    cd /sys/kernel/config/nvmet/ports/$num
+    echo "127.0.0.1" > addr_traddr
+    echo tcp > addr_trtype
+    echo 8009 > addr_trsvcid
+    echo ipv4 > addr_adrfam
+}
+
+setup_big_opt_io() {
+    local dev=$1
+    local name=$2
+
+    # Change optimal IO size by creating dm stripe
+    dmsetup create $name --table \
+        "0 `blockdev --getsz $dev` striped 1 512 $dev 0"
+}
+
+setup_targets() {
+    # Setup ram devices instead of using real nvme devices
+    modprobe brd rd_size=1048576 rd_nr=2 # 1GiB
+
+    setup_big_opt_io /dev/ram0 ram0_big_opt_io
+    setup_big_opt_io /dev/ram1 ram1_big_opt_io
+
+    setup_port 1
+    setup_ns /dev/mapper/ram0_big_opt_io 1 1
+    setup_ns /dev/mapper/ram1_big_opt_io 2 1
+}
+
+setup_initiators() {
+    nvme connect -t tcp -n 1 -a 127.0.0.1 -s 8009
+    nvme connect -t tcp -n 2 -a 127.0.0.1 -s 8009
+}
+
+reproduce_warn() {
+    local devs=$@
+
+    # Hangs here
+    mdadm --create /dev/md/test_md --level=1 --bitmap=internal \
+        --bitmap-chunk=1024K --assume-clean --run --raid-devices=2 $devs
+}
+
+echo "###################################
+
+The script creates 2 nvme initiators in order to reproduce the bug.
+The script doesn't know which controllers it created, choose the new nvme
+controllers when asked.
+
+###################################
+
+Press enter to continue.
+"
+
+read tmp
+
+echo "# Creating 2 nvme controllers for the reproduction. current nvme devices:"
+lsblk -s | grep nvme || true
+echo "---------------------------------
+"
+
+load_modules
+setup_targets
+setup_initiators
+
+sleep 0.1 # Wait for the new nvme ctrls to show up
+
+echo "# Created 2 nvme devices. nvme devices list:"
+
+lsblk -s | grep nvme
+echo "---------------------------------
+"
+
+echo "# Insert the new nvme devices as separated lines. both should be with size of 1G"
+read dev1
+read dev2
+
+ls /dev/$dev1 > /dev/null
+ls /dev/$dev2 > /dev/null
+
+reproduce_warn /dev/$dev1 /dev/$dev2
-- 
2.34.1

