Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D67C54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 21:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XTzrQ1fhjqraOMLELG86k5W5GHdTTS02OemLkx1e6Ds=; b=ib+/fiXpyGeAoiNRdUG+r4Xo/n
	uWwR1iSZXIAREDuOJFZAZeSb8zB9IZb3SsAJ/863G3ZDcoar++cBToa9maz2h3tB5LBrQPhZbNxA4
	Ub/EePJVdSEQdtnXCleOpfBqdGMy/m28axVLLv/3p04L5mRA9zs9zh9LItdhCxhO17I1v4lb/dYtJ
	DwU3Yj8ODJgl2O7JLq9JryV7vLVv8BOzPN81ylONHX2LjPKcgbFEu05IxdlEwNjGcFlb1oeX1JyAs
	PGxAzwxY8uFs7YbYEvDYx/Fxbl7DoxIeg0Kx2/rXpAtCJ4sI9tDhd1QwOwyWcfYRJMgr6Ai4nQVzz
	fHjpfy1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkA3f-00000007gBq-1OlK;
	Tue, 12 Mar 2024 21:53:15 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkA3b-00000007gAt-2pwo
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 21:53:13 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e12bcf6adso1875383f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 Mar 2024 14:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280390; x=1710885190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTzrQ1fhjqraOMLELG86k5W5GHdTTS02OemLkx1e6Ds=;
        b=Y8LYMAoRHLthavpU9r+g1PVzdqH+/3owylgdK0TghcAMf6L16llmKLAF/0p5Sq2HnL
         4vXUx9r6xIWoIMlC3K3X2/vZ1Q0po30ILJbzdLZCiDqPkLXe0bbrr08oripXxnC7N3RZ
         nUcimoba+uQRSZqdM1bWZmSBbiBKh+SLzMJGAg2mcnmkcqGAL9GThYn9fTySQoWy77Kt
         0CxnaR8FgdQCqvQsiT82iyHexvKvjiXe4DNY6yM4KAmAEi52DeghoH6G9mjaHjcJnW9q
         ldCaN1/7xlWDvZXLS+R4X5tF3CURGobepWCBQGhS2tBQwdo4hhQArlSWp+NQMFW1nbZ1
         Vvpw==
X-Forwarded-Encrypted: i=1; AJvYcCUFCcZiVcDTr4FY0zI5DUmCQI5qDB8/Gow+VnokRYFzjyO877cHjCbNlFW+Bi+CfunqZ28PoRIMspX0cm/7RajAdW9s7oYO6rjB2PtVAL0=
X-Gm-Message-State: AOJu0YxRp03+yQi4TedlgLLCh96Du/zSVb04IKv8zN2ZtOrK3yYx4WB+
	cufYlvbTB6R10CBYHKq2/Iqbwr0OVhzoBzeX7SQ3Tsqz/IP3v6cy
X-Google-Smtp-Source: AGHT+IGDUvVxycHekJvrlqUm/N5yn87mCMsk7lz2xo7k9wowj16/sxnnGmK/miJhfLRzopKMYwWn7A==
X-Received: by 2002:a5d:5486:0:b0:33d:32f7:c85 with SMTP id h6-20020a5d5486000000b0033d32f70c85mr2225129wrv.0.1710280389445;
        Tue, 12 Mar 2024 14:53:09 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id u1-20020a05600c138100b00412e5f32591sm189489wmf.28.2024.03.12.14.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 14:53:09 -0700 (PDT)
Message-ID: <55d01b15-c391-4652-a708-b4082bbdd14d@grimberg.me>
Date: Tue, 12 Mar 2024 23:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvmet: View subsystem connections on nvmeof target
Content-Language: he-IL, en-US
To: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>,
 linux-nvme@lists.infradead.org
Cc: kch@nvidia.com, hch@lst.de, antoine.damhet@shadow.tech,
 valentin.brice@shadow.tech, pierre.marsais@shadow.tech
References: <20240312154846.45099-1-redouane.boufenghour@shadow.tech>
 <20240312154846.45099-2-redouane.boufenghour@shadow.tech>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240312154846.45099-2-redouane.boufenghour@shadow.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_145311_772426_5F588CFB 
X-CRM114-Status: GOOD (  40.16  )
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



On 12/03/2024 17:48, Redouane BOUFENGHOUR wrote:
> From: Redouane Boufengour <redouane.boufenghour@shadow.tech>
>
> We add a new entry in the tcp and rdma factories to retrieve the peer
> address of a ctrl.
>
> The functions nvmet_rdma_disc_peer_addr and nvmet_tcp_disc_peer_addr return
> a snprintf of size NVMF_TRADDR_SIZE with the address connected to the ctlrs
>
> which is then displayed in debugfs on /sys/kernel/debug/nvmet/ctrls/ctrl_*/
>
> Co-developed-by: Pierre Marsais <pierre.marsais@shadow.tech>
> Signed-off-by: Pierre Marsais <pierre.marsais@shadow.tech>
> Signed-off-by: Redouane Boufengour <redouane.boufenghour@shadow.tech>
> ---
>   drivers/nvme/target/Kconfig       |   9 +++
>   drivers/nvme/target/Makefile      |   1 +
>   drivers/nvme/target/core.c        |  18 ++++-
>   drivers/nvme/target/debugfs.c     | 118 ++++++++++++++++++++++++++++++
>   drivers/nvme/target/debugfs.h     |  41 +++++++++++
>   drivers/nvme/target/fabrics-cmd.c |   2 +
>   drivers/nvme/target/nvmet.h       |   4 +
>   drivers/nvme/target/rdma.c        |  11 +++
>   drivers/nvme/target/tcp.c         |  13 ++++
>   9 files changed, 216 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/nvme/target/debugfs.c
>   create mode 100644 drivers/nvme/target/debugfs.h
>
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
> index 872dd1a0acd8..ec1a8d29ea8d 100644
> --- a/drivers/nvme/target/Kconfig
> +++ b/drivers/nvme/target/Kconfig
> @@ -107,3 +107,12 @@ config NVME_TARGET_AUTH
>   	  target side.
>   
>   	  If unsure, say N.
> +
> +config NVME_TARGET_DEBUGFS
> +	bool "NVMe over Fabrics debugfs support"
> +	depends on NVME_TARGET
> +	help
> +	  This enables the debugfs support to view who is connected to the
> +	  target.
> +
> +	  If unsure, say N.
> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
> index c66820102493..bc58d82af74d 100644
> --- a/drivers/nvme/target/Makefile
> +++ b/drivers/nvme/target/Makefile
> @@ -20,3 +20,4 @@ nvmet-fc-y	+= fc.o
>   nvme-fcloop-y	+= fcloop.o
>   nvmet-tcp-y	+= tcp.o
>   nvmet-$(CONFIG_TRACING)	+= trace.o
> +nvmet-$(CONFIG_NVME_TARGET_DEBUGFS)	+= debugfs.o
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 8658e9c08534..e1fe169b38f2 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -15,6 +15,7 @@
>   #define CREATE_TRACE_POINTS
>   #include "trace.h"
>   
> +#include "debugfs.h"
>   #include "nvmet.h"
>   
>   struct kmem_cache *nvmet_bvec_cache;
> @@ -1474,6 +1475,7 @@ static void nvmet_ctrl_free(struct kref *ref)
>   	struct nvmet_ctrl *ctrl = container_of(ref, struct nvmet_ctrl, ref);
>   	struct nvmet_subsys *subsys = ctrl->subsys;
>   
> +	nvmet_debugfs_connected_ctrl_delete(ctrl);

nvmet_ctrl_debugfs_remove()

>   	mutex_lock(&subsys->lock);
>   	nvmet_release_p2p_ns_map(ctrl);
>   	list_del(&ctrl->subsys_entry);
> @@ -1636,6 +1638,13 @@ void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys)
>   	mutex_unlock(&subsys->lock);
>   }
>   
> +int get_peer_traddr(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, char *dstaddr)

nvmet_get_host_traddr

> +{
> +	if (ctrl->ops->disc_peertraddr == NULL)
> +		return -EOPNOTSUPP;
> +	return ctrl->ops->disc_peertraddr(sq, ctrl->port, dstaddr);

ctrl->ops->host_traddr() and no need to pass the sq.

> +}
> +
>   void nvmet_subsys_put(struct nvmet_subsys *subsys)
>   {
>   	kref_put(&subsys->ref, nvmet_subsys_free);
> @@ -1670,11 +1679,17 @@ static int __init nvmet_init(void)
>   	if (error)
>   		goto out_free_nvmet_work_queue;
>   
> -	error = nvmet_init_configfs();
> +	error = nvmet_init_debugfs();

why not add it after configfs? just because the change looks weird.

>   	if (error)
>   		goto out_exit_discovery;
> +
> +	error = nvmet_init_configfs();
> +	if (error)
> +		goto out_exit_debugfs;
>   	return 0;
>   
> +out_exit_debugfs:
> +	nvmet_exit_debugfs();
>   out_exit_discovery:
>   	nvmet_exit_discovery();
>   out_free_nvmet_work_queue:
> @@ -1690,6 +1705,7 @@ static int __init nvmet_init(void)
>   
>   static void __exit nvmet_exit(void)
>   {
> +	nvmet_exit_debugfs();
>   	nvmet_exit_configfs();
>   	nvmet_exit_discovery();
>   	ida_destroy(&cntlid_ida);
> diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
> new file mode 100644
> index 000000000000..f1c8d489bdb8
> --- /dev/null
> +++ b/drivers/nvme/target/debugfs.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DebugFS interface for the NVMe target.
> + * Copyright (c) 2022-2024 Shadow
> + */
> +#include <linux/debugfs.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +
> +#include "debugfs.h"
> +#include "nvmet.h"
> +
> +#define CTRL_MAX_LEN 11 /* sizeof("ctrl_65536") */
> +
> +static struct dentry *nvmet_debugfs_root;
> +static struct dentry *nvmet_ctrls_dir;
> +
> +static ssize_t hostnqn_debug_read(struct file *filep, char __user *ubuf,
> +				  size_t count, loff_t *ppos)

nvmet_debug_ctrl_hostnqn_show ?

> +{
> +	ssize_t ret;
> +	char hostnqn[NVMF_NQN_FIELD_LEN + 1];
> +	struct nvmet_ctrl *ctrl = filep->private_data;
s/filep/file
> +
> +	ret = snprintf(hostnqn, sizeof(hostnqn), "%s\n", ctrl->hostnqn);
> +	if (ret < 0)
> +		return ret;
> +
> +	return simple_read_from_buffer(ubuf, count, ppos, hostnqn, ret);
> +}
> +
> +static const struct file_operations hostnqn_debug_fops = {
> +	.read = hostnqn_debug_read,
> +	.open = simple_open,
> +	.llseek = default_llseek,
> +};
> +
> +static ssize_t host_traddr_debug_read(struct file *filep, char __user *ubuf,
> +				      size_t count, loff_t *ppos)

nvmet_debug_ctrl_host_traddr_show() ?

> +{
> +	ssize_t size;
> +	char buf[NVMF_TRADDR_SIZE + 1];
> +	struct nvmet_ctrl *ctrl = filep->private_data;
> +
> +	size = get_peer_traddr(ctrl, ctrl->sqs[0], buf);
> +	if (size < 0)
> +		size = strscpy(buf, "unknown", sizeof(buf));
> +
> +	buf[size] = '\n';
> +	size++;

Is the \n assignment be avoided? Why not use sprintf?

> +
> +	return simple_read_from_buffer(ubuf, count, ppos, buf, size);
> +}
> +
> +static const struct file_operations host_traddr_debug_fops = {
> +	.read = host_traddr_debug_read,
> +	.open = simple_open,
> +	.llseek = default_llseek,
> +};
> +
> +void nvmet_debugfs_connected_ctrl_delete(struct nvmet_ctrl *ctrl)
nvmet_ctrl_debugfs_unregister() ?
> +{
> +	struct dentry *controller_dir_parent;
> +	char folder_id[CTRL_MAX_LEN];
> +
> +	snprintf(folder_id, sizeof(folder_id), "ctrl_%u", ctrl->cntlid);
> +	controller_dir_parent = debugfs_lookup(folder_id, nvmet_ctrls_dir);
> +	if (!controller_dir_parent)
> +		return;

Why is this needed? Why not simply have remove_recursive?

> +
> +	debugfs_remove_recursive(controller_dir_parent);
> +}
> +
> +ssize_t nvmet_debugfs_connected_ctrl_write(struct nvmet_ctrl *ctrl)

nvmet_ctrl_debugfs_register() ?

> +{
> +	struct dentry *controller_dir_parent;
> +	char folder_id[CTRL_MAX_LEN];
> +
> +	snprintf(folder_id, sizeof(folder_id), "ctrl_%u", ctrl->cntlid);
> +
> +	controller_dir_parent = debugfs_lookup(folder_id, nvmet_ctrls_dir);
> +	if (!controller_dir_parent) {
> +		controller_dir_parent =
> +			debugfs_create_dir(folder_id, nvmet_ctrls_dir);
> +		if (!controller_dir_parent)
> +			return -ENODEV;
> +	}
> +
> +	debugfs_create_str("subsystem", 0400, controller_dir_parent,
> +			   &ctrl->subsys->subsysnqn);
> +	debugfs_create_file("host_traddr", 0400, controller_dir_parent, ctrl,
> +			    &host_traddr_debug_fops);
> +	debugfs_create_file("hostnqn", 0400, controller_dir_parent, ctrl,
> +			    &hostnqn_debug_fops);

What I think you need to do is have each nvmet subsys create a debugfs 
dir, and
have it be the parent of the controllers. Note that I don't think you 
need a dedicated
function here, just call debugfs_create_dir when creating the subsys 
(and remove_recursive
when freeing it).

> +
> +	return 0;
> +}
> +
> +int __init nvmet_init_debugfs(void)
> +{
> +	nvmet_debugfs_root = debugfs_create_dir("nvmet", NULL);
> +	if (!nvmet_debugfs_root)
> +		return -ENODEV;
> +
> +	nvmet_ctrls_dir = debugfs_create_dir("ctrls", nvmet_debugfs_root);
> +	if (!nvmet_ctrls_dir) {
> +		debugfs_remove_recursive(nvmet_debugfs_root);
> +		return -ENODEV;
> +	}

I think it'd be better to have the structure 
nvmet/<subsys>/<cntlid>/<ctrl_attr>

if we may want to see debug stuff on the subsys, we can adjust it to be:
nvmet/<subsys>/ctrls/<cntlid>/<attr>

> +
> +	return 0;
> +}
> +
> +void nvmet_exit_debugfs(void)
> +{
> +	debugfs_remove_recursive(nvmet_debugfs_root);
> +}
> diff --git a/drivers/nvme/target/debugfs.h b/drivers/nvme/target/debugfs.h
> new file mode 100644
> index 000000000000..7104a98903a5
> --- /dev/null
> +++ b/drivers/nvme/target/debugfs.h

No need for a dedicated header I think, just add these to nvmet.h

> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * DebugFS interface for the NVMe target.
> + * Copyright (c) 2022-2024 Shadow
> + */
> +#ifndef NVMET_DEBUGFS_H
> +#define NVMET_DEBUGFS_H
> +
> +#include <linux/types.h>
> +
> +#include "nvmet.h"
> +
> +#ifdef CONFIG_NVME_TARGET_DEBUGFS
> +
> +void nvmet_debugfs_connected_ctrl_delete(struct nvmet_ctrl *ctrl);
> +ssize_t nvmet_debugfs_connected_ctrl_write(struct nvmet_ctrl *ctrl);
> +
> +int __init nvmet_init_debugfs(void);
> +void nvmet_exit_debugfs(void);
> +
> +#else
> +
> +static inline void nvmet_debugfs_connected_ctrl_delete(struct nvmet_ctrl *){};
> +
> +static inline ssize_t nvmet_debugfs_connected_ctrl_write(struct nvmet_ctrl *)
> +{
> +	return 0;
> +};
> +
> +static inline int __init nvmet_init_debugfs(void)
> +{
> +	return 0;
> +}
> +
> +static inline void nvmet_exit_debugfs(void)
> +{
> +}
> +
> +#endif
> +
> +#endif // NVMET_DEBUGFS_H
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index 9964ffe347d2..86b819afbc29 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -6,6 +6,7 @@
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   #include <linux/blkdev.h>
>   #include "nvmet.h"
> +#include "debugfs.h"
>   
>   static void nvmet_execute_prop_set(struct nvmet_req *req)
>   {
> @@ -278,6 +279,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
>   		ctrl->pi_support ? " T10-PI is enabled" : "",
>   		nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
>   	req->cqe->result.u32 = cpu_to_le32(nvmet_connect_result(ctrl));
> +	nvmet_debugfs_connected_ctrl_write(ctrl);
>   out:
>   	kfree(d);
>   complete:
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 6c8acebe1a1a..7055991b8410 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -353,6 +353,8 @@ struct nvmet_fabrics_ops {
>   	void (*discovery_chg)(struct nvmet_port *port);
>   	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
>   	u16 (*get_max_queue_size)(const struct nvmet_ctrl *ctrl);
> +	int (*disc_peertraddr)(struct nvmet_sq *nvme_sq,
> +			struct nvmet_port *port, char *dstaddr);
>   };
>   
>   #define NVMET_MAX_INLINE_BIOVEC	8
> @@ -750,4 +752,6 @@ static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
>   static inline const char *nvmet_dhchap_dhgroup_name(u8 dhgid) { return NULL; }
>   #endif
>   
> +int get_peer_traddr(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
> +		    char *dstaddr);
>   #endif /* _NVMET_H */
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 3a0f2c170f4c..63faaa2b56b7 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -2006,6 +2006,16 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
>   	}
>   }
>   
> +static int nvmet_rdma_disc_peer_addr(struct nvmet_sq *nvme_sq,
> +		struct nvmet_port *nport, char *dstaddr)
> +{
> +	struct nvmet_rdma_queue *queue =
> +		container_of(nvme_sq, struct nvmet_rdma_queue, nvme_sq);
> +
> +	return snprintf(dstaddr, NVMF_TRADDR_SIZE, "%pISc",
> +			(struct sockaddr *)&queue->cm_id->route.addr.dst_addr);
> +}
> +

I'd split out tcp and rdma to follow on patches.

>   static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
>   {
>   	if (ctrl->pi_support)
> @@ -2028,6 +2038,7 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
>   	.queue_response		= nvmet_rdma_queue_response,
>   	.delete_ctrl		= nvmet_rdma_delete_ctrl,
>   	.disc_traddr		= nvmet_rdma_disc_port_addr,
> +	.disc_peertraddr        = nvmet_rdma_disc_peer_addr,
>   	.get_mdts		= nvmet_rdma_get_mdts,
>   	.get_max_queue_size	= nvmet_rdma_get_max_queue_size,
>   };
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index c8655fc5aa5b..4a7c78235d96 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -2171,6 +2171,18 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
>   	}
>   }
>   
> +static int nvmet_tcp_disc_peer_addr(struct nvmet_sq *sq,
> +		struct nvmet_port *nport, char *dstaddr)
> +{
> +	struct nvmet_tcp_queue *queue =
> +		container_of(sq, struct nvmet_tcp_queue, nvme_sq);
> +
> +	if (queue->sockaddr_peer.ss_family == AF_UNSPEC)
> +		return -EINVAL;

Can this even happen?

