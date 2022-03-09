Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7835C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 05:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=voXsD6sLo7uFYzzzqPscFOCVoAipSBVviJvgsg+kqBk=; b=X+zBR0699DwVjEPG4qP/rHWJ4j
	OhYApeBII/np8CBULUBNQrGOVGAzeyx3oK0TSB6UoLZuYkuk/6APM14dH5/RTlD2mYkob/PO3mWrA
	8iMPhzO16pzfqdPeV9ENZXD+oWwX/w7iYOVUVdaqI15vKK1mk6WUWZpM1nPTC3TFkkTEvm3gYL9LU
	aAPL15v16Zvks839mtd3E23soYQxTiNasd87R9JIcgAY/gbwegjmSxakknd+XPBaUUSP3XexsU9an
	VVehUMx2DqvLr9y7n7xKX1Q3Uua985BBBdAHiC3SG5fy1a1wSMJvXnRnKLJkplr9WMycr7jYpaByJ
	JYDctjrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRp0p-007MlY-HQ; Wed, 09 Mar 2022 05:37:27 +0000
Received: from smtprz15.163.net ([106.3.154.248] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRp0k-007Mko-G6
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 05:37:25 +0000
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
 by freemail02.tom.com (Postfix) with ESMTP id 86A32B00D55
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 13:37:19 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
 by my-app02 (TOM SMTP Server) with SMTP ID -1729338319
 for <linux-nvme@lists.infradead.org>;
 Wed, 09 Mar 2022 13:37:19 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
 by freemail02.tom.com (Postfix) with ESMTP id 80DFAB00D46
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 13:37:18 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
 t=1646804239; bh=MUh5KVNE2W4JLszfknRl0oZMTR+2Hb8TA8gRL7Ml8FY=;
 h=From:To:Cc:Subject:Date:From;
 b=a/Sal2mscheixNLtQBZDjR6x0RkkaLrX1cN95Fw+CWNP5k4HjrtE34WAfityXsRGt
 98dfesZtarGmH8PXW8TunhxvJLLY97pMaZVoH90xDT3ZXoSC35MEUM9EXpK7/VNkd/
 Q/fuUVHwcrUiR1B5ERj/uxwAbz4ddnhsH/iwNzpM=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
 by antispam1.tom.com (Postfix) with ESMTP id DFB32D415B7
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 13:37:17 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
 by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jipBtQ79mkqJ for <linux-nvme@lists.infradead.org>;
 Wed,  9 Mar 2022 13:37:16 +0800 (CST)
Received: from localhost.localdomain (unknown [101.93.196.13])
 by antispam1.tom.com (Postfix) with ESMTPA id 5CB87D4155F;
 Wed,  9 Mar 2022 13:37:15 +0800 (CST)
From: Mingbao Sun <sunmingbao@tom.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: sunmingbao@tom.com, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: [PATCH v2 1/2] nvmet-tcp: support specifying the congestion-control
Date: Wed,  9 Mar 2022 13:37:11 +0800
Message-Id: <20220309053711.2561-1-sunmingbao@tom.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_213723_076723_BEC83828 
X-CRM114-Status: GOOD (  17.83  )
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
 drivers/nvme/target/configfs.c | 37 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/tcp.c      | 27 +++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 091a0ca16361..644e89bb0ee9 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -222,6 +222,41 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 
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
@@ -1597,6 +1632,7 @@ static void nvmet_port_release(struct config_item *item)
 	list_del(&port->global_entry);
 
 	kfree(port->ana_state);
+	kfree(port->tcp_congestion);
 	kfree(port);
 }
 
@@ -1605,6 +1641,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
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
index 83ca577f72be..3b72e782c901 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1657,8 +1657,10 @@ static void nvmet_tcp_accept_work(struct work_struct *w)
 	struct nvmet_tcp_port *port =
 		container_of(w, struct nvmet_tcp_port, accept_work);
 	struct socket *newsock;
+	struct inet_connection_sock *icsk, *icsk_new;
 	int ret;
 
+	icsk = inet_csk(port->sock->sk);
 	while (true) {
 		ret = kernel_accept(port->sock, &newsock, O_NONBLOCK);
 		if (ret < 0) {
@@ -1666,6 +1668,16 @@ static void nvmet_tcp_accept_work(struct work_struct *w)
 				pr_warn("failed to accept err=%d\n", ret);
 			return;
 		}
+
+		if (port->nport->tcp_congestion) {
+			icsk_new = inet_csk(newsock->sk);
+			if (icsk_new->icsk_ca_ops != icsk->icsk_ca_ops) {
+				pr_warn("congestion abnormal: expected %s, actual %s.\n",
+					icsk->icsk_ca_ops->name,
+					icsk_new->icsk_ca_ops->name);
+			}
+		}
+
 		ret = nvmet_tcp_alloc_queue(port, newsock);
 		if (ret) {
 			pr_err("failed to allocate queue\n");
@@ -1693,6 +1705,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	struct nvmet_tcp_port *port;
 	__kernel_sa_family_t af;
+	char ca_name[TCP_CA_NAME_MAX];
+	sockptr_t optval;
 	int ret;
 
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
@@ -1741,6 +1755,19 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	if (so_priority > 0)
 		sock_set_priority(port->sock->sk, so_priority);
 
+	if (nport->tcp_congestion) {
+		strncpy(ca_name, nport->tcp_congestion, TCP_CA_NAME_MAX-1);
+		optval = KERNEL_SOCKPTR(ca_name);
+		ret = sock_common_setsockopt(port->sock, IPPROTO_TCP,
+					     TCP_CONGESTION, optval,
+					     strlen(ca_name));
+		if (ret) {
+			pr_err("failed to set port socket's congestion to %s: %d\n",
+			       ca_name, ret);
+			goto err_sock;
+		}
+	}
+
 	ret = kernel_bind(port->sock, (struct sockaddr *)&port->addr,
 			sizeof(port->addr));
 	if (ret) {
-- 
2.26.2


