Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D24C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 11:47:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C43661454
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 11:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C43661454
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4pwpwZ+a9x/v4HnUnkqaCJZ763wJexcheg27B7/BWjI=; b=Kbp6EOEqxZVqIY4SzxFb4EUs0n
	DKEK3JQhlvNwWTmL3ItzgRmtb59WRP+ISof8tk3trSknarGtKR0CiXjF7szphQL4fi5P3wTCPOP4x
	LdjGqjiTNe+SvLKkcT9NaACuibo+o+ROPnClzwEBJgdThExL9CyDUFzdPa/1EPLtC4eYAbq/2kRaJ
	eM063cCdRareo/DPqOZDE+rT3zB6bbW1koA/7IKdIEv+ZqM3DliTl5UJjTKsQshFF49gJeGuFuiKE
	Xrvr37UNphOTSmlRkpoFUFEznxE9WXFQQILlia0AW0DGMn7jQKjOy00zrUcUC9g14caph3s9eC/D9
	prk+WsUQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhWHa-007xp4-Tk; Fri, 14 May 2021 11:47:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhWHZ-007xos-7d
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 11:47:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=HPb3i2uS9isNKVTJLR5s8cy3TQcSeyeb3NI4EBJhHQA=; b=orS/u71Ib2ZVJqGyuiWoRHfVX4
 vn9PE9OpLlSMC2VRLFiFZKonnvmMGNDYE225teK6n3x1erdZLnp8vl3bWojXqFMm4CbNFWKAB6Lhx
 FLiCylOr1zrDV5O9WadQa2d5DS5CT/ZQAHpJcUMGkr2Dbe15rJJQD2BwHiqwnTZKjs5p4ksCLKtWs
 DN911S6YxmjSepB2ryEYCoypOpkWrV3J2kdWEP1wy67fO9YmX3o2JjDeuUi7r2eCTP60/+w3BZw4c
 PcitQYzLBVUM10A5EaYKnl9a65tPOso+OcuIt1aAFA3eHUd4/Rsz2jaVJsUNXYbbnJ+Ip72tA3PdS
 crv5SA0w==;
Received: from mail-dm6nam08olkn2061.outbound.protection.outlook.com
 ([40.92.45.61] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhWHV-00BwpB-4H
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 11:47:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeQhV5b/yq/ZpsSixY0qWcx6izFeCmdQ8eyJHDgC76HPK+KuxQOlBnRG4Tk89DA3t78yGQA+6q9j+rMMeB91SOZViLRvab5+O5/yW0HnFBdfp9Hl6ZeQzupSbqPYCSur5hj3t7lVTbbW9vc6+7UoLofdazBnnT3CSLbHEt+vIVA2H5p57GJSn5FwRSsOSYY22dbMmArj2RJpqCjiMYv5pLiLbIq8c/0V78Sc2JLjoV+eL3zZsBqnfujxMjmBP+xJ0Hs8pWEssvWHw17eXPEPITuHu4eXsw4oj5ZsKTTcl8N+2yPTZVJGt3Tp5YjBGhLbBtyZ2XLKjyl8iZFksFkMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPb3i2uS9isNKVTJLR5s8cy3TQcSeyeb3NI4EBJhHQA=;
 b=KydVyhxHbZ0VTMKl+Llgb5suQIh6BbWH6IsTakWFvB+NWyJ1epEu/8WMfbTAhyS5XnTdkLJc61nt9jjP62neAaurHBnPQIyT8C7bAzc5tJysT9uHMW9VPmmlsFv3vPv5NkPhqkGb6Yll0HfVsQrXyYPheRtsNPCnw4SWobU5JyJ1IoWKU4D2f76hWQ64hwcVqtFEuu5nv1aN5RUrkRN6e7UQatKSU73bRKPTF8EMZIxl2VMrjoCME+R8KrM78o9DQVT0R50UxK+tiKORFQI44IbOjqdCqtP9V98M4AdnySlqL9eb6dXXGTVFtMlJEngFBP2GIfAwun+zMrGO0PhiUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPb3i2uS9isNKVTJLR5s8cy3TQcSeyeb3NI4EBJhHQA=;
 b=ss38EK8QuZHThiPzAbOlIZssRW9lgjM5qioOIXETwlMzsu4YH2ZmN4bMRBOG0JnBM9yRQWjPorMqlZvzLFJVGnG9autWSiO/uU9+AVAXKZeRdIDLzExzzyETEV+u+7dRLg1UBdnEmWBWpHgpu+Y2VfJth7Y0CcJp6C3a2Oh7A895cAgGTDl2yhVwEsqVm2INcPGtem2XvkeHPgUAj49pGqze0DY49w2K47wbdWEjJqp488C1kVuBW3D/0HQ9cA53eGPu4USlXrO83L8rCxpE6xnsiNRCIBWekmwRQlWxdUIRh6AGtwM0dL4O8xqg5hej8S6hrCzQzJA0P16s7lZMrw==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB4152.namprd13.prod.outlook.com (2603:10b6:208:26c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.12; Fri, 14 May
 2021 11:46:58 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::558e:d92d:d944:473b]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::558e:d92d:d944:473b%5]) with mapi id 15.20.4150.012; Fri, 14 May 2021
 11:46:58 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCHv5 1/1] nvme-tcp: Add option to set the physical interface to
 be used when connecting over TCP sockets.
Date: Fri, 14 May 2021 07:46:43 -0400
Message-ID: <BL0PR13MB4291BFA1BAFE07D706D486A29C509@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
X-TMN: [fWZ8BAY2GC/NvfPFBmSj6VXo+ZZwC7Bt]
X-ClientProxiedBy: BL1PR13CA0256.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::21) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20210514114643.16702-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (174.19.123.177) by
 BL1PR13CA0256.namprd13.prod.outlook.com (2603:10b6:208:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Fri, 14 May 2021 11:46:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2372fbc0-65bd-49a5-c6e4-08d916cdfa91
X-MS-TrafficTypeDiagnostic: MN2PR13MB4152:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56gALUWsfNg9epMi3NiMSvlYdzcqdhd85GXy+VFa5FbMZbhcauonRKWcNEtu1w7qd2P2SzTIAr7S7N8RON2Dm1Rv8Rd3MKllu7698xBx2Z6+srY2gOJRPeR0JXnlSLbl+h7lCx/Xbq2qnRXjIUv3QSGsT1q45YHTzycjt1rKY+PEO0mAJQLt2rGWI9Yjc/n3H72gANtY64JeJ5Soq1j/3mHKxD7PL6uvn75bW5c9b8tE6wC1V1RdjKavpOuiCAXzhrtCTryqG6TL1zgqriOXbFXgbd+OWfLZlFIP7nLXU/gwRt6dgWPiaVzxy3ffCrUNRwhooM9LzEswXMfg1WnoY7dvN20CDAGr+RFnypyBIAxDTvP14+R+t0A0mCrXvij5MbkLF988Yvzm+QIxB02+J0hHJ+xAjPW1fuJBjcOOQvzi8/Ta2yBLgDQ7zje7wvD9VR9noTye1tEU6tfwTi6YaA==
X-MS-Exchange-AntiSpam-MessageData: CRTO782ia7CTXFoX4zU4/NCO4BfgJoLfFH7WUaaU6tg8ELWD+mgUNePSBq6DB72m54MydAxAJN4rjw+bzIPTUjRI+qJ9lbNiHs4emaEOGq24qJWN3C6Y1e1Uy2QaJe3gyCrM0Z5923nSVRsejL9Mqw==
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2372fbc0-65bd-49a5-c6e4-08d916cdfa91
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 11:46:58.5825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4152
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_044701_441348_93043178 
X-CRM114-Status: GOOD (  34.01  )
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

Addressed reviews from PATCHv4.

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
 drivers/nvme/host/fabrics.c | 14 +++++++++++
 drivers/nvme/host/fabrics.h |  6 ++++-
 drivers/nvme/host/tcp.c     | 48 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 71 insertions(+), 2 deletions(-)

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
index 0222e23f5936..32e44527afaa 100644
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
@@ -2514,6 +2529,37 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
@@ -2570,7 +2616,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
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
