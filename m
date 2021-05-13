Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A25C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 19:20:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC280613C4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 19:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC280613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4FtLC++IN+cmQutvg8jbUvhGnQpbFcwWkiJ8cw4q6pw=; b=FNRFy5X43Jg7duBk5mBNa2PoG0
	+oFRrw1P+9Ba6SkYUU19IdcSxv2bQZhqluAXMhZAZJdJIYp1+AEbrMGUjzSLsHqQcb/D+muaUDnOY
	6csnAVf05iWch+8RkuMp+uKrVOlT9KFGqdqPv9IOM5OqBN9It6hdzooKQg6WYYOMzo43We2Jsx+uL
	Mu/vGUV58JzBrdo/N8rXVoPyPsk+YZhFQjQsnjkgDBgwSj2Nqz5rUQpoEYCl03qC4ERnuAVPTrzFj
	TzT8efbwQALDOwCDromK9mCHbUAc0tSpOiCDEetA5sXlfyPJJp3jlbdJha/rBWaw7raPxvLFJ1a58
	tHAhX/DQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhGrp-006FsM-Fg; Thu, 13 May 2021 19:19:30 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhGrm-006Frz-LA
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 19:19:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=dQtV8JAZa1u8ofyNQAw5Q7nFyZpiiS2hRomckqBrOm8=; b=vxChXMNOCWD42CwZul+YX8X71+
 08blKKoWnM0sAhfveGFpjcO14wdiOJNu6xDD6xH8D5o90QbIjsbD33fsJFNQS9H7eFWyWMUvCwsZm
 JmuK2JcC8w88Koeb8v7RubW5WmnVWds8NXAzMGh/q3lIAsYAEmM6RmiDmZdJDATdsVYkP1kF9SzIP
 kN7AMFZhNFysygMM1WQ4aIlQupoLVoxclzdT0yuTTZnm04wAC101uaUWXT4MSUN8OWwSn+a9YMl06
 uVF3WGQuKqJsOSMCeYG5LUePL/UtlslA4JmhPsczLrXdchPtTinJsd+LUqz0khqenULPUS0/TijZl
 JlJmMXvg==;
Received: from mail-co1nam11olkn2076.outbound.protection.outlook.com
 ([40.92.18.76] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhGri-00BTMF-Tp
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 19:19:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYUwIhJws7S2kFR5wu1rlIjHpQhndzOIo6dGosPIFmQIvjt3+wMDlzujokJbJDWGV8Gc24l0vBK1xP/reWXIdZ10r6yAiYMJMoE9SUmtp55NQYZNnm3Cgxo+cvUf0gu+U7AnJHdj+GjSIcWkUcKVUO0G+iB2qNG8HPjoIZT9pZ9hfBT3Yo+AMpvkeyeSsb+c1Uea92LLrfbRei8Vc0J17+e0RkG3+OQkP7qQZgx243CgoZtoqfGz6iOKh3bTI1jRDed5Jv8JROnCKTxScIpCfJNXsFxw6m8gf2Tp63ifvRSJL4CNEQ9YqtDI8LA3ur8bBS+EoDeDPginyD0a5RbNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQtV8JAZa1u8ofyNQAw5Q7nFyZpiiS2hRomckqBrOm8=;
 b=m7oxrkbPXUHVF1Qw2mPuxsDOiomYdCm2zDTrRhhsT3vxskSzOUhc9nRK8Vt9LR+2vSviUxQqSDyAsIOjUnbdXZU3kqDhu2MBos5MI2zQ9IcGSFV9GSLO/izMUCWEDXkuDgeDb5AYXw4bYSxO7giJMO4ZpV9BSSG7ckDmqDMcPxHLSabknFB1MPBOAImCUKt4DOlYnsBynXFZgXxeY4id9stY/YO4NEsyMCDBySv+ZIqhad36gQp+9gOOm790scBOehgn3MskDXFOYvod8CKolgHZwsFok+ZGQk69QzN3cpvjeS1IxbMS9nnlEyNP+mGg0CwMta+1MsRHzUhh+jJ6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQtV8JAZa1u8ofyNQAw5Q7nFyZpiiS2hRomckqBrOm8=;
 b=IVxOaomoHSBFwu2Hk3SwJynqc6wlSwuO0M40dg1PnAX+KZgOIsXst2RBJmJeTAchqIFfD73LBsZsat5LzdSq1pbXHcfbKvMmrsHnUNwFnLFiCNVRQK4EvIQVHvYNc4sEQAzXyzZIUbeZllmIbGhd7heZSXIZ5I2tB7ttB2687SVqSR3XSb5GESRdb8dZBKgWtezy9BI9u158TqoN6roZTiPCq5ED2QhawrAkKAkk6GEfo4h0x2Gd8brg2hMOf6ouS2qBC0pxNsnl8Zlu69xP8TZ+ps08wX4lJlxzX+qagXDP3sCstDz68DIYigy1Og0zLDFGb81pBbXyow94yggldA==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by BL0PR13MB4307.namprd13.prod.outlook.com (2603:10b6:208:8e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.13; Thu, 13 May
 2021 19:19:17 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::558e:d92d:d944:473b]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::558e:d92d:d944:473b%5]) with mapi id 15.20.4150.012; Thu, 13 May 2021
 19:19:17 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCHv4 1/1] nvme-tcp: Add option to set the physical interface to
 be used when connecting over TCP sockets.
Date: Thu, 13 May 2021 15:18:45 -0400
Message-ID: <BL0PR13MB429158048F32C299692755469C519@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
X-TMN: [64tAv0n/DpE2C1aphG4u3YCAC1XPlSdl]
X-ClientProxiedBy: SN4PR0401CA0037.namprd04.prod.outlook.com
 (2603:10b6:803:2a::23) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20210513191845.109580-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from conundrum.delllabs.net (174.19.123.177) by
 SN4PR0401CA0037.namprd04.prod.outlook.com (2603:10b6:803:2a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Thu, 13 May 2021 19:19:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19619540-45b6-4e58-99b3-08d91643ff9b
X-MS-TrafficTypeDiagnostic: BL0PR13MB4307:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NvouKKtqFavtkWurXd33jTrjTJwEBjvvCbNCm2HzuodpkLXq9xqse0GYMKwTUQfL4HxyYB1IrvGbWmDD+7J9XTlDw8fY3w4R3AAtfCl0+RIIvtI8dcBpy5+kIFtUsnEpn4bdarrA6V5Gza1M9YuGhnZd8spphDE2xg9vTAy5OdbR6Oesxg5cx4a8d7CHhS3VN7CvBpcI7ajjQ7pngOcKYl9qzOPNqWyVkl8OxZ5XisBDe0rxQHG95y2Ol6sDl0yhBfeLDXzUH6H+l+dbzzu1HsCsXhs5EXbg2Pfw6Wb3Xlhm3sD/rtkwdSpSLooSs4h3VzlGaWFchutOh2Cz3mlJtu6KStkCVWNsMf667bL+gSjLLWn/E8HUA8g+s5ZG7gNVQPHZubQACBhp9Y8kZM9ckkPeVFovGiCkQ3FheO/U4qysryDlxCHZ2hKEHcO8d+lR8g9XJEC3JhZ0dGg0/VZH/Q==
X-MS-Exchange-AntiSpam-MessageData: QCgcwGGo14g4I8LD31ti9KumkpKj5SRp+A2t8n7vhmzNyldKh2QQ6Qp/l5zYo2uiClBsDk/fReILwBU5XLcWAxkKYR3Zpa5BiRbJ4OsjU715vrOWuTLjVdKq2ZAzaciP1gWxr4fwxRbW9mVp+mgqyw==
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 19619540-45b6-4e58-99b3-08d91643ff9b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 19:19:17.2474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4307
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_121923_175746_E08CADB4 
X-CRM114-Status: GOOD (  32.90  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Belanger <martin.belanger@dell.com>

In our application, we need a way to force TCP connections to go out a
specific IP interface instead of letting Linux select the interface
based on the routing tables. This patch adds the option 'host-iface'
to allow specifying the interface to use. Note that corresponding
changes to the nvme-cli utility will follow.

When the option host-iface is specified, the driver uses the specified
interface to set the option SO_BINDTODEVICE on the TCP socket before
connecting.

This new option is needed in addtion to the existing host-traddr for
the following reasons:

Specifying an IP interface by its associated IP address is less
intuitive than specifying the actual interface name and, in some cases,
simply doesn't work. That's because the association between interfaces
and IP addresses is not predictable. IP addresses can be changed or can
change by themselves over time (e.g. DHCP). Interface names are
predictable [1] and will persist over time. Consider the following
configuration.

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state ...
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 100.0.0.100/24 scope global lo
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
    link/ether 08:00:27:21:65:ec brd ff:ff:ff:ff:ff:ff
    inet 100.0.0.100/24 scope global enp0s3
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
    link/ether 08:00:27:4f:95:5c brd ff:ff:ff:ff:ff:ff
    inet 100.0.0.100/24 scope global enp0s8
       valid_lft forever preferred_lft forever

The above is a VM that I configured with the same IP address
(100.0.0.100) on all interfaces. Doing a reverse lookup to identify the
unique interface associated with 100.0.0.100 does not work here. And
this is why the option host_iface is required. I understand that the
above config does not represent a standard host system, but I'm using
this to prove a point: "We can never know how users will configure
their systems". By te way, The above configuration is perfectly fine
by Linux.

The current TCP implementation for host_traddr performs a
bind()-before-connect(). This is a common construct to set the source
IP address on a TCP socket before connecting. This has no effect on how
Linux selects the interface for the connection. That's because Linux
uses the Weak End System model as described in RFC1122 [2]. On the other
hand, setting the Source IP Address has benefits and should be supported
by linux-nvme. In fact, setting the Source IP Address is a mandatory
FedGov requirement (e.g. connection to a RADIUS/TACACS+ server).
Consider the following configuration.

$ ip addr list dev enp0s8
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
    link/ether 08:00:27:4f:95:5c brd ff:ff:ff:ff:ff:ff
    inet 192.168.56.101/24 brd 192.168.56.255 scope global enp0s8
       valid_lft 426sec preferred_lft 426sec
    inet 192.168.56.102/24 scope global secondary enp0s8
       valid_lft forever preferred_lft forever
    inet 192.168.56.103/24 scope global secondary enp0s8
       valid_lft forever preferred_lft forever
    inet 192.168.56.104/24 scope global secondary enp0s8
       valid_lft forever preferred_lft forever

Here we can see that several addresses are associated with interface
enp0s8. By default, Linux always selects the default IP address,
192.168.56.101, as the source address when connecting over interface
enp0s8. Some users, however, want the ability to specify a different
source address (e.g., 192.168.56.102, 192.168.56.103, ...). The option
host_traddr can be used as-is to perform this function.

In conclusion, I believe that we need 2 options for TCP connections.
One that can be used to specify an interface (host-iface). And one that
can be used to set the source address (host-traddr). Users should be
allowed to use one or the other, or both, or none. Of course, the
documentation for host_traddr will need some clarification. It should
state that when used for TCP connection, this option only sets the
source address. And the documentation for host_iface should say that
this option is only available for TCP connections.

References:
[1] https://www.freedesktop.org/wiki/Software/systemd/\
PredictableNetworkInterfaceNames/
[2] https://tools.ietf.org/html/rfc1122

Tested both IPv4 and IPv6 connections.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/core.c    |  5 ++++
 drivers/nvme/host/fabrics.c | 14 ++++++++++
 drivers/nvme/host/fabrics.h |  6 ++++-
 drivers/nvme/host/tcp.c     | 54 ++++++++++++++++++++++++++++++++++---
 4 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 762125f2905f..f98255eb7deb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4067,6 +4067,11 @@ static int nvme_class_uevent(struct device *dev, struct kobj_uevent_env *env)

 		ret = add_uevent_var(env, "NVME_HOST_TRADDR=%s",
 				opts->host_traddr ?: "none");
+		if (ret)
+			return ret;
+
+		ret = add_uevent_var(env, "NVME_HOST_IFACE=%s",
+				opts->host_iface ?: "none");
 	}
 	return ret;
 }
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index a2bb7fc63a73..76dc3eaf46f3 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -112,6 +112,9 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR)
 		len += scnprintf(buf + len, size - len, "%shost_traddr=%s",
 				(len) ? "," : "", ctrl->opts->host_traddr);
+	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
+		len += scnprintf(buf + len, size - len, "%shost_iface=%s",
+				(len) ? "," : "", ctrl->opts->host_iface);
 	len += scnprintf(buf + len, size - len, "\n");

 	return len;
@@ -545,6 +548,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_KATO,		"keep_alive_tmo=%d"	},
 	{ NVMF_OPT_HOSTNQN,		"hostnqn=%s"		},
 	{ NVMF_OPT_HOST_TRADDR,		"host_traddr=%s"	},
+	{ NVMF_OPT_HOST_IFACE,		"host_iface=%s"		},
 	{ NVMF_OPT_HOST_ID,		"hostid=%s"		},
 	{ NVMF_OPT_DUP_CONNECT,		"duplicate_connect"	},
 	{ NVMF_OPT_DISABLE_SQFLOW,	"disable_sqflow"	},
@@ -754,6 +758,15 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			kfree(opts->host_traddr);
 			opts->host_traddr = p;
 			break;
+		case NVMF_OPT_HOST_IFACE:
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			kfree(opts->host_iface);
+			opts->host_iface = p;
+			break;
 		case NVMF_OPT_HOST_ID:
 			p = match_strdup(args);
 			if (!p) {
@@ -938,6 +951,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	kfree(opts->trsvcid);
 	kfree(opts->subsysnqn);
 	kfree(opts->host_traddr);
+	kfree(opts->host_iface);
 	kfree(opts);
 }
 EXPORT_SYMBOL_GPL(nvmf_free_options);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index d7f7974dc208..c31dad69a773 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -66,6 +66,7 @@ enum {
 	NVMF_OPT_NR_POLL_QUEUES = 1 << 18,
 	NVMF_OPT_TOS		= 1 << 19,
 	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
+	NVMF_OPT_HOST_IFACE	= 1 << 21,
 };

 /**
@@ -83,7 +84,9 @@ enum {
  * @trsvcid:	The transport-specific TRSVCID field for a port on the
  *              subsystem which is adding a controller.
  * @host_traddr: A transport-specific field identifying the NVME host port
- *              to use for the connection to the controller.
+ *     to use for the connection to the controller.
+ * @host_iface: A transport-specific field identifying the NVME host
+ *     interface to use for the connection to the controller.
  * @queue_size: Number of IO queue elements.
  * @nr_io_queues: Number of controller IO queues that will be established.
  * @reconnect_delay: Time between two consecutive reconnect attempts.
@@ -108,6 +111,7 @@ struct nvmf_ctrl_options {
 	char			*traddr;
 	char			*trsvcid;
 	char			*host_traddr;
+	char			*host_iface;
 	size_t			queue_size;
 	unsigned int		nr_io_queues;
 	unsigned int		reconnect_delay;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0222e23f5936..3e91bd13d385 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -123,6 +123,7 @@ struct nvme_tcp_ctrl {
 	struct blk_mq_tag_set	admin_tag_set;
 	struct sockaddr_storage addr;
 	struct sockaddr_storage src_addr;
+	struct net_device	*ndev;
 	struct nvme_ctrl	ctrl;

 	struct work_struct	err_work;
@@ -1454,6 +1455,20 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 		}
 	}

+	if (nctrl->opts->mask & NVMF_OPT_HOST_IFACE) {
+		char *iface = nctrl->opts->host_iface;
+		sockptr_t optval = KERNEL_SOCKPTR(iface);
+
+		ret = sock_setsockopt(queue->sock, SOL_SOCKET, SO_BINDTODEVICE,
+				      optval, strlen(iface));
+		if (ret) {
+			dev_err(nctrl->device,
+			  "failed to bind to interface %s queue %d err %d\n",
+			  iface, qid, ret);
+			goto err_sock;
+		}
+	}
+
 	queue->hdr_digest = nctrl->opts->hdr_digest;
 	queue->data_digest = nctrl->opts->data_digest;
 	if (queue->hdr_digest || queue->data_digest) {
@@ -2467,6 +2482,7 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
 static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
+	char addr[256];
 	struct nvme_tcp_ctrl *ctrl;
 	int ret;

@@ -2514,6 +2530,37 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		}
 	}

+	if (opts->mask & NVMF_OPT_HOST_IFACE) {
+		ctrl->ndev = dev_get_by_name(&init_net, opts->host_iface);
+		if (!ctrl->ndev) {
+			pr_err("invalid interface passed: %s\n",
+			       opts->host_iface);
+			ret = -ENODEV;
+			goto out_free_ctrl;
+		}
+	}
+
+	/* For IPv6 HOST_TRADDR, check if scope ID is specified. If not, set
+	 * HOST_TRADDR's scope ID to the scope ID of HOST_IFACE or the scope
+	 * ID of TRADDR
+	 */
+	if ((opts->mask & NVMF_OPT_HOST_TRADDR) &&
+	    (ctrl->src_addr.ss_family == AF_INET6)) {
+		struct sockaddr_in6 *src_addr6 =
+			(struct sockaddr_in6 *)&ctrl->src_addr;
+
+		if (src_addr6->sin6_scope_id == 0) {
+			if (ctrl->ndev && (ctrl->ndev->ifindex != 0)) {
+				src_addr6->sin6_scope_id = ctrl->ndev->ifindex;
+			} else {
+				struct sockaddr_in6 *addr6 =
+					(struct sockaddr_in6 *)&ctrl->addr;
+
+				src_addr6->sin6_scope_id = addr6->sin6_scope_id;
+			}
+		}
+	}
+
 	if (!opts->duplicate_connect && nvme_tcp_existing_controller(opts)) {
 		ret = -EALREADY;
 		goto out_free_ctrl;
@@ -2540,8 +2587,9 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	if (ret)
 		goto out_uninit_ctrl;

-	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp\n",
-		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
+	nvmf_get_address(&ctrl->ctrl, addr, sizeof(addr)-1);
+	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %s\n",
+		 ctrl->ctrl.opts->subsysnqn, addr);

 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_tcp_ctrl_list);
@@ -2570,7 +2618,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS,
+			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };

--
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
