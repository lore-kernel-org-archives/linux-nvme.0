Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9228C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 10:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hlbrc+gNGeA7NIsFF6fh3b/M6dpxEz8OPM14i7pFNzw=; b=Y42UfiuXMD8SlfbLQ2S+pJ8f8+
	BaBq+u1inERwDEvtgia9HqVI7Pva8X5TkiHTNg1Nqq46BbeavF+NbaxnSnVGdGnVoINL3EXP1kZ1D
	ZrlPX4bNo79K8ragDCaVWL98aTS1IL9t9ENb7rh/wSRhDHevihUxR0PCNybW6YiWtt2yh63MaZp31
	taFO5peC9iD9ui19107a0zYhTdC7lkuRACGVLnmV77ahpspkXhWbj2zIwEryRJh49BTE8wGTqQHQ3
	W2DyW5yVB+w3YaBSaXD4Trzt7/IGdLzPyrhkQVl610mBAP3gCar2xaid4eliaOxxGbeHu873E7gUZ
	wFnBIJKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSccu-00G1z9-Jc; Fri, 11 Mar 2022 10:36:04 +0000
Received: from smtprz01.163.net ([106.3.154.234] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSccY-00G1mo-Rl
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 10:35:44 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id 28896440192
 for <linux-nvme@lists.infradead.org>; Fri, 11 Mar 2022 18:35:42 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646994942; bh=F3vKEGSv90LjLhaBsvzJwFCV62L0vSG/lnPB+DbenZY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JN3viEXGYMdqsBb7GCEVZYHXnACBZGp2PWwLLDXY9ftDkuByr+gFlTrQQsF9vzNqf
 p4iQv680G/+03MkmldVcFeRf6SkYM95cRXGkBiXHRbeo65yPBZmpqxMiL6HVfDF0Qn
 mmrpDYYtB5ADBJ6teGmrE6XevGgqoEh9vTOiJCsE=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID 544870773
 for <linux-nvme@lists.infradead.org>;
 Fri, 11 Mar 2022 18:35:42 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646994942; bh=F3vKEGSv90LjLhaBsvzJwFCV62L0vSG/lnPB+DbenZY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JN3viEXGYMdqsBb7GCEVZYHXnACBZGp2PWwLLDXY9ftDkuByr+gFlTrQQsF9vzNqf
 p4iQv680G/+03MkmldVcFeRf6SkYM95cRXGkBiXHRbeo65yPBZmpqxMiL6HVfDF0Qn
 mmrpDYYtB5ADBJ6teGmrE6XevGgqoEh9vTOiJCsE=
Received: from localhost.localdomain (unknown [101.93.196.13])
 by antispamvip.163.net (Postfix) with ESMTPA id EDA1C1541564;
 Fri, 11 Mar 2022 18:35:37 +0800 (CST)
From: Mingbao Sun <sunmingbao@tom.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: sunmingbao@tom.com, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: [PATCH v2 3/3] nvmet-tcp: support specifying the congestion-control
Date: Fri, 11 Mar 2022 18:34:14 +0800
Message-Id: <20220311103414.8255-3-sunmingbao@tom.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220311103414.8255-1-sunmingbao@tom.com>
References: <20220311103414.8255-1-sunmingbao@tom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220311_023543_144355_FA3257C9 
X-CRM114-Status: GOOD (  18.02  )
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

From: Mingbao Sun <tyler.sun@dell.com>

congestion-control could have a noticeable impaction on the
performance of TCP-based communications. This is of course true
to NVMe_over_TCP.

Different congestion-controls (e.g., cubic, dctcp) are suitable for
different scenarios. Proper adoption of congestion control would benefit
the performance. On the contrary, the performance could be destroyed.

Though we can specify the congestion-control of NVMe_over_TCP via
writing '/proc/sys/net/ipv4/tcp_congestion_control', but this also
changes the congestion-control of all the future TCP sockets that
have not been explicitly assigned the congestion-control, thus bringing
potential impaction on their performance.

So it makes sense to make NVMe_over_TCP support specifying the
congestion-control. And this commit addresses the target side.

Implementation approach:
the following new file entry was created for user to specify the
congestion-control of each nvmet port.
'/sys/kernel/config/nvmet/ports/X/tcp_congestion'
Then later in nvmet_tcp_add_port, the specified congestion-control
would be applied to the listening socket of the nvmet port.

Signed-off-by: Mingbao Sun <tyler.sun@dell.com>
---
 drivers/nvme/target/configfs.c | 42 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/tcp.c      | 13 +++++++++++
 3 files changed, 56 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 091a0ca16361..7b7d95f6f582 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -11,6 +11,7 @@
 #include <linux/ctype.h>
 #include <linux/pci.h>
 #include <linux/pci-p2pdma.h>
+#include <net/tcp.h>
 
 #include "nvmet.h"
 
@@ -222,6 +223,45 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_, addr_trsvcid);
 
+static ssize_t nvmet_tcp_congestion_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return snprintf(page, PAGE_SIZE, "%s\n",
+			port->tcp_congestion ? port->tcp_congestion : "");
+}
+
+static ssize_t nvmet_tcp_congestion_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	int len;
+	char *buf;
+
+	len = strcspn(page, "\n");
+	if (!len)
+		return -EINVAL;
+
+	if (nvmet_is_port_enabled(port, __func__))
+		return -EACCES;
+
+	buf = kmemdup_nul(page, len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	if (strlen(buf) >= TCP_CA_NAME_MAX) {
+		kfree(buf);
+		return -EINVAL;
+	}
+
+	kfree(port->tcp_congestion);
+	port->tcp_congestion = buf;
+
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, tcp_congestion);
+
 static ssize_t nvmet_param_inline_data_size_show(struct config_item *item,
 		char *page)
 {
@@ -1597,6 +1637,7 @@ static void nvmet_port_release(struct config_item *item)
 	list_del(&port->global_entry);
 
 	kfree(port->ana_state);
+	kfree(port->tcp_congestion);
 	kfree(port);
 }
 
@@ -1605,6 +1646,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_treq,
 	&nvmet_attr_addr_traddr,
 	&nvmet_attr_addr_trsvcid,
+	&nvmet_attr_tcp_congestion,
 	&nvmet_attr_addr_trtype,
 	&nvmet_attr_param_inline_data_size,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 69637bf8f8e1..76a57c4c3456 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -145,6 +145,7 @@ struct nvmet_port {
 	struct config_group		ana_groups_group;
 	struct nvmet_ana_group		ana_default_group;
 	enum nvme_ana_state		*ana_state;
+	const char			*tcp_congestion;
 	void				*priv;
 	bool				enabled;
 	int				inline_data_size;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 83ca577f72be..311383c6d7da 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1741,6 +1741,19 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	if (so_priority > 0)
 		sock_set_priority(port->sock->sk, so_priority);
 
+	if (nport->tcp_congestion) {
+		lock_sock(port->sock->sk);
+		ret = tcp_set_congestion_control(port->sock->sk,
+						 nport->tcp_congestion,
+						 true, true);
+		release_sock(port->sock->sk);
+		if (ret) {
+			pr_err("failed to set port socket's congestion to %s: %d\n",
+			       nport->tcp_congestion, ret);
+			goto err_sock;
+		}
+	}
+
 	ret = kernel_bind(port->sock, (struct sockaddr *)&port->addr,
 			sizeof(port->addr));
 	if (ret) {
-- 
2.26.2


