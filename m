Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952A3C43600
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 17:06:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CB661410
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 17:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CB661410
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PS7FG8uAp/TQv3Nu9mANFvv3H7Q+TTRHsR55gcT4W9c=; b=kdwRx3iS74+G7KBFxhzOpJ58sl
	GGC1Pxd42k0rYGwIFXwzeFz7uIz5LYu1PCEPGosU/nqn1iuBKYVcDYw84iVSR4UXB0iA+FwPn7iZz
	zjnjBOKplGfT7SrtKKUgOMTpDSPW/Cz7UIBliNBK/W6ut+caub7Um6hYxqhkqV+tfXnHK9qWCiJFz
	tDWGgJgMG6ZyfcSiAw9R82z2CeH2al92Wc4Bh3/MM5n4zJtMe2OY9p3AjXpo/LPrtyq4rnmbF4L7i
	8AGFR1iNeuFJ/R9ZHR8Vs9/8ecxRU6XiW9OJRB22fHsKiVL1OeukkDgGqfpoPrEY5TYTey7k8un/V
	tAZ1l7/w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leKyQ-001rAR-Gs; Wed, 05 May 2021 17:06:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leKvz-001qIC-6F
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 17:03:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=DGc3q0RZh3/htxLzBxJE0TpPCfXUI//95sF3ospuoCY=; b=ZrLiB16h/N712quzmdGvdZqp2K
 cdqfefDDWMEsacBsr5I+2c8OTewX4H00q4KGZb8qAzHXGiQhxwo5DUpOhbQ4pCm5GQKq8o/cldKSO
 1W8lBnOMDANllXpw/mQJUHeC70EM4HfC5/FOuntjY8crOQ0nOfYfmFM0+MD0RBZeAFuwxYuH+7nKB
 b9E4w2GOFTXx2quzlaG+onV/XYkMHz28BvT7aLU1vVGF2l8M15zTiIvmXyCmJWpaa0PD6lHPd/bGp
 Q6uTKPctZWM+THXbZSGZeoe2Y82v/yPwm8LlDehB00yV/q6sdpxGqtiUKzfUZ8dz94r+AbWW9Ukt5
 /cuUchAQ==;
Received: from mail-oln040092005097.outbound.protection.outlook.com
 ([40.92.5.97] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leKvt-0051gG-KV
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 17:03:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKTJ/EHbqbnco0Z6kTokG3wx4M4FNfmdaF4RewMcG0SoOFLBbdATh2gVNF8hJFmO/zZ8RdrExLpzAGggfXxOjGQDYTB5aQT9TfhgzxCpqQA+YDd6hoos9qDv1qwgVltha10dzliAcwyaLJP1aJ7PhW3B1uG2qbNL+I/3M667t+HmrxkvUDKvtTDC4U1IXhIzf7LTQ/vocjvbDKzucjoKRwCE7qhc/ZuxQbCpNjZYZaPMV5lb4QbDImN69Bsw13umt1HRvgspdLxjuXf1/A48ucjSn76XPt6J1Hsi9DzUXR6qk5Dy0pZygZaT96FY+x5eWwyhWMUncMVrgl7TbNI5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGc3q0RZh3/htxLzBxJE0TpPCfXUI//95sF3ospuoCY=;
 b=Y1pKnupLVwAf9tSL3YCjB0rXRNbmMvWbEnxjOIzRlOZj8wCguvbszeD6qvna/Zgt6Xsj71kcBzjMcyKr+hqqQkIBmJRe/Sb9WrTKPesuFk+QHKmGYq7/ytINXlsK7+Yvicx+jz/iTu4snHtgucPwsKGjPEGDD3QNdBHI7A8MiTn+lLWLZ2NGAM8IPTQji4n/2A7YM1y/NVH2iuYilLmrfDA//tUDfYoBxaAhQnUIkQ3YzdJDAMAk1iu4IkTLFGiPirz6zi05bjItGgL+LaNuRuSyl8/jIXlaLuGoo8D34A1+SbwXh54aGSrPpyPFGU05VE9u2rQ0120Z0e0I6W+Zsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGc3q0RZh3/htxLzBxJE0TpPCfXUI//95sF3ospuoCY=;
 b=u8Q49hAtizLuZZYDudJqEE4q66npzIh9hHgx3g0xRuFbRo1F85gYo2G6bW3yXbiHhqqbFKb/1k+dUXb4l/4cLStZCdzmYGoXip90sK9zgRsee53GoF+VL0M7aaFPId6gkgbxLJXUrYgniyWQBEOxmQXZTWTf6d++0jFs8EIy6DT2tgJw2STXG6ixRqKNfVApPf2TkjVinl28il19lYm7sonRJOIgB+MjHN87hpn5drxgL+e8xvy7CO9ZLPhahw1efVh0KYMpP7xdCk3BztVpjxEvWCiqC9/PjH1a68QDoRP/bAodlsx/7IcKEW1AuXrb1Xnuv7EEDGxa5fYSvfHODw==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB2925.namprd13.prod.outlook.com (2603:10b6:208:13c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.14; Wed, 5 May
 2021 17:03:30 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::558e:d92d:d944:473b]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::558e:d92d:d944:473b%5]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 17:03:30 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCHv3 1/1] nvme-tcp: Add option to set the physical interface to
 be used when connecting over TCP sockets.
Date: Wed,  5 May 2021 13:03:17 -0400
Message-ID: <BL0PR13MB42915D5FB2BB825054129F029C599@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
X-TMN: [UdWYUWGXDxAgcsa7h9a+GYqlhWsI92Fq]
X-ClientProxiedBy: MN2PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:208:238::9) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20210505170317.33684-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (174.19.123.177) by
 MN2PR22CA0004.namprd22.prod.outlook.com (2603:10b6:208:238::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24 via Frontend Transport; Wed, 5 May 2021 17:03:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c1c8ce7-ce25-4386-f1f6-08d90fe7b500
X-MS-TrafficTypeDiagnostic: MN2PR13MB2925:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZSb6SWal00UxaP0uF2MwzGJayBeZhLQuLosMYKh7UFOZfpnr3Xv+2iekvYHId7QSzNqvbMLNwnismWrADROKbXzcUuShIVqO2XfC775a0/jXiubN1JraApkaob60ujpXwecKNV7LdrHR8z5MP59g4kncN81YI5GAOXBj5qOdTibsGXYmtgDWspKu15JvVPLPRI4+YLTajjIPTD3Jt+FoXyQViu574MhnSC0QqNAT3kD66xNn7GCbEwhvh51d0z4KXwhKtyh5MZrFQTrjhrtqoJrynRzM09KNqaw2aIk4NANNt23gkeF/4y5tgd8i5w560nXHUV2FkTTd55NGT6NvjtwFMOGQNCwhn1fYWp08XSx4dwuT3PFzxA0tDghYduQqszKp/+TL3KJ+vlZ8dTCP7hgc9KXFYztbp3TECxHVRM=
X-MS-Exchange-AntiSpam-MessageData: Els1QmzOyuwiIdd1Sx84svaQkimvepOceClSCXhIP2mLzeuLE/R6Wtkk+qfxEuc4GU7DwMnmk8d4GvGIIc0wVr2pizFgwjPbWUgQqRRphChzBXx+nmF6rzeTBRLtNkRNXQao1gSj1y7CTU9LCSjtuw==
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1c8ce7-ce25-4386-f1f6-08d90fe7b500
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 17:03:30.6031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2925
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_100333_818780_B8FC4BAB 
X-CRM114-Status: GOOD (  31.79  )
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

RESUBMIT: Resubmitting because previous patch (PATCHv2) had a corrupt
          line.

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


Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/core.c    |  7 ++++++-
 drivers/nvme/host/fabrics.c | 14 ++++++++++++++
 drivers/nvme/host/fabrics.h |  6 +++++-
 drivers/nvme/host/tcp.c     | 34 +++++++++++++++++++++++++++++++---
 4 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 522c9b229f80..78665cf463de 100644
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
index a2bb7fc63a73..7f3b924a5611 100644
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
index 0222e23f5936..e0a35956a16d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1454,6 +1454,20 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
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
@@ -2467,6 +2481,7 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
 static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
+	char addr[256];
 	struct nvme_tcp_ctrl *ctrl;
 	int ret;

@@ -2514,6 +2529,18 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		}
 	}

+	if (opts->mask & NVMF_OPT_HOST_IFACE) {
+		struct net_device *ndev;
+
+		ndev = dev_get_by_name(&init_net, opts->host_iface);
+		if (!ndev) {
+			pr_err("invalid interface passed: %s\n",
+			       opts->host_iface);
+			ret = -ENODEV;
+			goto out_free_ctrl;
+		}
+	}
+
 	if (!opts->duplicate_connect && nvme_tcp_existing_controller(opts)) {
 		ret = -EALREADY;
 		goto out_free_ctrl;
@@ -2540,8 +2567,9 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	if (ret)
 		goto out_uninit_ctrl;

-	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp\n",
-		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
+	nvmf_get_address(&ctrl->ctrl, addr, sizeof(addr)-1);
+	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %s\n",
+		 ctrl->ctrl.opts->subsysnqn, addr);

 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_tcp_ctrl_list);
@@ -2570,7 +2598,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
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
