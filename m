Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BA5C0219D
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 10:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UMfGIo8Hx3XPcUh5K+C4E4GY+fN1YGWXfx3Y0oTD7XY=; b=lOrMPENGSh1A07kmTc9AN0tHrQ
	X/s6aAxzZnnoTKAlgjKDQoCH9sSycGp07Dl8ADqoIdt5LFcIjJrYalhxcBVvHMwgkQ6Wsfj5+5Aql
	uSC5+X/O10KEVrXTnSDmjw9+tjBk/x7qcNiE5eGfH3Rwz7+jPDp6DAgdNnbtAaFN1gSfsTA6Wq+w4
	buLjfxZ+ZxAbXpGRZnTPmybFizwguyiQ6BpSukaUgk8DpFtvebsRg/SVtyJVIygnKp2xSiYd4mggd
	okNCLwB+JmHfPk1BN4u+uxIFxMaJbO14bjItvdWNVwK7nDqz7O6Ds4dnbsRDSRrmE2li/9s/xoOE4
	lQpo7tnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiW8J-0000000AafO-3NF4;
	Thu, 13 Feb 2025 10:07:47 +0000
Received: from mail-sg2apc01on20705.outbound.protection.outlook.com ([2a01:111:f403:200f::705] helo=APC01-SG2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiW7s-0000000AaU0-4A1l
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 10:07:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/W8s29g77j0NIXCXZRYf5Bis69Bsw3zsmFSAhmDiZNNOoVS+nKIJOMOoYSIq6dil39dvAONmIkXKWh8oBnY6UnQV8V32mmblE+7BIK2Xdg13y1LvB34+KA8cqPq80x7QPMD9RBJ4MVi/5do+qy94XC5sCL7r81pb89BWbFK/YmIQ5y1Qmxtci1YsQEUnp/anV8OE5ETN1sBpvLBz2jHTQDOe07H17Ckc/P6oy3Irsu6PBad66vhiAVhudOf8Ck8FeiQlSlF5plalD5yIlnEKldJX/Lcb9M8c9wxqtZqZWh4YVM264TjRGUQ+ePOP1BolHiw9kE6DBrIkbdUd6n0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMfGIo8Hx3XPcUh5K+C4E4GY+fN1YGWXfx3Y0oTD7XY=;
 b=yaxZ6+yoN24fGPJDXdvEdnXB8W6irFqqVqQDXzle6KZxDv0CAZqRvWp2AKkEdnPVR8aNS3t/71gqMB5asau5IErKL2FhQjOzbsaHKxhXN5AvCm3tkhDAkgM3KzF+qL4Q92zPcrHb7LEvxNxt5Jeq5CDPA7arFjri+M44EUCa8ouynzoZDnEk7UjGJM0aBrLSMKzN1CBD/5/+3hiFzXuWDQVd1YX7P0oC79BmYsB6VhlaGg5zsSSeEv4Kgr+63EVXMKkmJb//qL9fB5QfWYyhlPdcKGIcjm2tCl44sGv7a6Kjd85n478hRgmkm2ViNzHryXKDu936Nq6Yf/1Zasttag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMfGIo8Hx3XPcUh5K+C4E4GY+fN1YGWXfx3Y0oTD7XY=;
 b=TUT5AsoVXlqjMN7qnnpZg6VvZRyeTshx7AGTawwEecYVcjR3OI+Qv62XpHQhxeF38i9hIbFP/e3anLVUfo1lFHOahM7pbSP1JEQbsyfGfMWE3tDoxpNcJIppx6gGooYgBZX4CaNfirlkwJl/spYFZfGSkDzt4y1Dzo4EpSJpMmEy7KaksErVeLQvoOXgnwn63KXyLfRjzcoJRK+JIu1wk0JPObvCFAjHK1fK4UNTxcIvEYyglkXf6drD3FHYKQAU9+I/sDAgypAGQyzB3hVgHZWI9/1WyoaameBXUNw5EBp7lTNgC8E7TaWE/ZsY0re+2RWpSMmIDQAw7Za/raKi3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR06MB6257.apcprd06.prod.outlook.com (2603:1096:820:d1::11)
 by SEYPR06MB6156.apcprd06.prod.outlook.com (2603:1096:101:de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.7; Thu, 13 Feb
 2025 10:07:09 +0000
Received: from KL1PR06MB6257.apcprd06.prod.outlook.com
 ([fe80::ea4e:11dc:3350:b520]) by KL1PR06MB6257.apcprd06.prod.outlook.com
 ([fe80::ea4e:11dc:3350:b520%5]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 10:07:09 +0000
From: Ruozhu Li <david.li@jaguarmicro.com>
To: hch@lst.de
Cc: david.li@jaguarmicro.com,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: RE: [PATCH] nvmet-rdma: recheck queue state is LIVE in state lock in recv done
Date: Thu, 13 Feb 2025 18:06:48 +0800
Message-ID: <20250213100648.577-1-david.li@jaguarmicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213062048.GD19608@lst.de>
References: <20250213062048.GD19608@lst.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To KL1PR06MB6257.apcprd06.prod.outlook.com
 (2603:1096:820:d1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6257:EE_|SEYPR06MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: e16d8eb9-4197-41bc-441c-08dd4c162dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aA5xmDQ33GyiBO02DYIXvk2P9f7g3l9i2dDvADxlv7TLpf5N8nMAPw7CaAIB?=
 =?us-ascii?Q?Txub3Bv2sb9Yl8MkroDrLKInhgFdwLsYXulKnDfwyCLgrvBdtWWL1I//hjS/?=
 =?us-ascii?Q?vBq8d1/ON3x1eh6cXgxTAhU4tfV5Q16WYlXYQ2nxItioaqMT0ZAn8om9ku8H?=
 =?us-ascii?Q?0wV/yr/rhQhoG2eVgbZ/aCcqm2iEVIcqhwpLUH2hYoHRToIswt/dtRBcoakQ?=
 =?us-ascii?Q?ADnNxIH9ZdzLnk4ZUJAfghk8mUqn+aj4NsJZzg0dmWZSBluMcOUEeIodLCjE?=
 =?us-ascii?Q?l+R422lmWBxiBkrwZmhMf2RH2Lo4RANwc+B5S2KSATztKLZcr+++v2swrSON?=
 =?us-ascii?Q?evqsAM/QYJkqN/TgMnyzKrc9pNTAhRCd97wCWvtqYxmZy0YZyRavyCj+08GZ?=
 =?us-ascii?Q?hdRKZ4bZmm0OmokGh259c+oyIAarE8jC/VeQhRZp6+iFNsKdUwl+hVZz7R93?=
 =?us-ascii?Q?fMkGNhIs+XWr3gtBTipAfzWfAEBqWUV7Uo3hYu4XX4++BAzxT+NUvl03j7wA?=
 =?us-ascii?Q?tnbHep4CCKa2dsvQLpfbzYJmk9s9ENo8SW3WlDkQEYtqZuD0x6+zh4RD4kVH?=
 =?us-ascii?Q?LWhgWuFKpK6bROQeP9fc0M2VV6WCQ6S16OZ296nGAeIVr9qi/OjVzPaXIzhA?=
 =?us-ascii?Q?Vghebr5DLcUoF8cnTkA9GSBqorkHTmbjGF/peF3q97AisryEOdqxb+2ZWthJ?=
 =?us-ascii?Q?GjDqK7/UWMmNDCrBaiJ8QqImKkKgray17ToTs+HsPocLnAtXL8LbPvME0u/L?=
 =?us-ascii?Q?27F6z/lRQpac09/CfEUeGIG7OmnbzM7iYMj9wADGo/ckPpto3P87NQeaLHpn?=
 =?us-ascii?Q?bbN0XfDqBchPyRH77DOWnz4y7MSDKUuD5BDsigCt32Oeo+Of8s0ke2x15PtK?=
 =?us-ascii?Q?u3mZjqEBUg4EOtqBCnTI9QlN5tlCKURnCxpKYxpfs1+asSYFCoU4bulHTNwd?=
 =?us-ascii?Q?S5fb6NGq3igJTJnx9wcMYzBnwE87SQo1IkI7s5Zgj5OtZbNnb/Z28H+pABOE?=
 =?us-ascii?Q?Nz3KOV7BiA3vvU9/bZwYF3Hpjt6267Ta7TO18U+tt1nd9a3MazjVN5d1C7s0?=
 =?us-ascii?Q?14u/5hLIuxiu9rfDjb4WCzNN49dvF9JNmBAwbqN0OuHlUozrPcm8P4tArvxA?=
 =?us-ascii?Q?CIWYKFL8EFUGjchd21MwCVMShGnGQUkc1dAxyblXXAS5j6b5BlaWXxnSKCjg?=
 =?us-ascii?Q?URd74EEjpplJWk6os103kLqjblndfa4u68m3IRvBc2t7KPpMTdKq1ezUjkSO?=
 =?us-ascii?Q?W3mq6biqzh78eYP6SFCsPcgnpKPU3lZ2GzXnzXnX6QPenl2UXi4HnFULnRh3?=
 =?us-ascii?Q?mtjBaezAcHTWSbQYJu7JENGERF1OPsr/0rz3NahrGSx6VMjasFBE83cA9oQr?=
 =?us-ascii?Q?aaKCyIKNcl5GIJ+z55ioo6dCUz/+b4HBrhuCmTdZVWhvv+hDVg2ivCrM5oVh?=
 =?us-ascii?Q?NHlLN7hCYNb8w624EI4wVp5co5KwUu+r?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6257.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JlL1+txNj0nlfyebCwh7tf3JukOqhZi2gmqNmXkjf3G4PLFHkAXUm7U7ppAX?=
 =?us-ascii?Q?Rn4T/jjAVpuHfRnNxoQhjEjZQgVKg54WbWKFv9qoka8wzCg/Zq9H8Lafn7Cw?=
 =?us-ascii?Q?1w9g5dqTAjdOW/43S1PB+2+8MoGKRaeZwcSDi69GG4jAH3CL1xTY9FLZOMD6?=
 =?us-ascii?Q?zds014k0U+63/WeiluZWua72A+i4DfhguUM2i+X28C053lJ3XGr605ERsvVp?=
 =?us-ascii?Q?EDDLVdBBQD1vudXSrhhquFHHKsFq2ZrSNzZwxo0hl1ti0MgNZpo8oXGh2f+o?=
 =?us-ascii?Q?kEzFll/kHGQCoZAtHwDAuaQGsYfmEuMUNE4OjIhK6oLz1dn+VhVh1AltPegE?=
 =?us-ascii?Q?GYfjUQI8b8rAtjzdC+1gHl/Gt3XyrE8ZzGV67jIKes5FaMM903xAnzCw1Xds?=
 =?us-ascii?Q?3Ekh+VuYEIa3Ni/wVIHWZm52ijND7ZjaY6YQ/0MuFL8LT/o7zD/YHH3GE+PK?=
 =?us-ascii?Q?9F/KdF2GScBmB1784vogq1uExQobfEJ8/MjloMwKtDKducEGBqtyk7JaLMJ5?=
 =?us-ascii?Q?H0RSk3fzZEm8Go1Bx9YWkWs16auk3Ec6ouyvHWUHUlpJoL6ojfzS9gUSwzdg?=
 =?us-ascii?Q?b4XvBDujEKXIVjFArE0knsKfoZfFWVZ/ysIC1wAT/Iw8FNQVgi5aiXh/ERp8?=
 =?us-ascii?Q?4KPBnldFMxN/w2CW6Z+3FkFaeVZCtsqkpNlxkhiYUqT7Uc6DKkpwn/exvDtr?=
 =?us-ascii?Q?goETImeGrKWVYQI9qKZ/Q5VEGbkrKvO1kn+sP7KYKIPTeWTh8V3AxSB2e184?=
 =?us-ascii?Q?fy0zIIi9HsMJa5VMZZUqGhwPQXm6ShGtcOf8t56Veb0TVuuCsalaKAB0VvCX?=
 =?us-ascii?Q?FyMbd0VU41xDw/xLuYToAJzI5R0U9C8KVjs9kBM2AxtKBwYkCoDxhokKY2Dd?=
 =?us-ascii?Q?QD2WDx7AQVsUCK87WMumHeX1MOKveT56VJNgJQQuDRZE81F8VBWlsMTmo4Z4?=
 =?us-ascii?Q?qvDteA0tgevsZW2OQT1EMTbUSY/LQJsoSHgJ0kiDR5G5l/8wAIXZVWRSI5lI?=
 =?us-ascii?Q?lfxbUIcXUl8hTA9eVC2zZDXlYy3MwydjNp8ysj6RuZx6AH4+MKzVGFp/GJXR?=
 =?us-ascii?Q?+tn+jTNzQ8wjsDK6FQpC2c5aj0wj4UCGzzT53vyRJ3d843QNLdbf/9vf9xjv?=
 =?us-ascii?Q?X/JzxoZ/bspmp5fBFSK2inwo1RaXqz1TJ6thWeEffw9rmLxRUOrWfZS8whEZ?=
 =?us-ascii?Q?GD55DSjgQwEyNmojxLdYhFDljWytvZo/Te4t0qoaeFXalOms4KmxrG93xY0p?=
 =?us-ascii?Q?H+txYkc99bfUyiAMjtWF34p16ERcSIY1uNkUFo2r0Y2fu3SqC1F/EF2/GRG2?=
 =?us-ascii?Q?99fK3u5Ob0fYiIwPCQBRtVS7nXfvb4xzl6RcnHDbgrdqfzQWXdL7JWbUr0Uh?=
 =?us-ascii?Q?jyDZ2m34ech1KIKmVM0rVEqHYqg3ePxjfllQYBp5Ym2I9YsTzRjtcrho/RC6?=
 =?us-ascii?Q?jVFg/RBOe5An7tFAPweNsKOxrQGHmu6O0XT4P8+ka4Z51WPcV07xhJW8JXu9?=
 =?us-ascii?Q?htEuYBrqzGukOfamOac8zW87kjD4k1UBjcB+UCh8k+5B7BlqEok1sNsFY0K8?=
 =?us-ascii?Q?2pbynyv35l64c5BNPWW1YuxnIi7PAowbuR65VcELyTr5b8OVGfrT2IuI9mVT?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16d8eb9-4197-41bc-441c-08dd4c162dae
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6257.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 10:07:09.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXUCRYTW0tcFOCsSWLccafP8sMbCt4//AknV+ZKH7BCG3h2EtkI6RxrnSYV7xUvIfK6ftv/wHnE2HGUll5GF8Eznc5ZcJzpdwPi2DeT4asI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6156
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_020721_360931_B3A0A8E8 
X-CRM114-Status: UNSURE (   9.95  )
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

On 2025/02/13 6:20 UTC, Christoph Hellwig wrote:
> > +++ b/drivers/nvme/target/rdma.c
> > @@ -1042,12 +1042,16 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
> >               unsigned long flags;
> >
> >               spin_lock_irqsave(&queue->state_lock, flags);
> > -             if (queue->state == NVMET_RDMA_Q_CONNECTING)
> > -                     list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
> > -             else
> > -                     nvmet_rdma_put_rsp(rsp);
> > +             if (queue->state != NVMET_RDMA_Q_LIVE) {
>
> You'll want a comment based on the commit message that the first live check is racy.
Okay, I will add a comment in next version.
>
> > +                     if (queue->state == NVMET_RDMA_Q_CONNECTING)
> > +                             list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
> > +                     else
> > +                             nvmet_rdma_put_rsp(rsp);
> > +
> > +                     spin_unlock_irqrestore(&queue->state_lock, flags);
> > +                     return;
>
> This gets a bit messy now.  What about a struture like this instead?
Looks good to me, I will retest it and send another version soon.

Thanks.

