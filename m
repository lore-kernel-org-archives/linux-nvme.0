Return-Path: <SRS0=jgW7=LZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE3EC11F64
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 13:49:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE1461420
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 13:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE1461420
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BD2CM7plIZi9w91HZV8ykBFSYkrBpiznhekjGrD6dDk=; b=nk6A1hINrf8kIU
	p5VWRijWeewFNccu0Otf0nn5Y863cKs1UWpMSdIm1f4a4HJ0iJccO4ii/TSqymVWZHO0HoKosXV7h
	kcNjf4h7uQHxUV7qzuZ1ci6ube1HAquEUiPxqdFFPM5yr/c6qdDxpJhJrNCxwRlI7lTbINTsxbKvs
	FlMRjI5GXXoGKcuKStNgliwY8GUQbkL/XXPoeOB3HWis9f01qsAxgq9EdkfLghjotfiQjDWT4Rz4E
	EsnjpdBAs6A36ShTQwSMjtObWNMOaB31oUgt0sbSP9SLRwKoWazr4zXiMjndvWPTJM/SI82cwhqkU
	tbgvEjsdYYDuhFLdzAsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyx3q-00HXo9-9o; Thu, 01 Jul 2021 13:48:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyx3m-00HXmv-SL
 for linux-nvme@lists.infradead.org; Thu, 01 Jul 2021 13:48:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 10D1768AFE; Thu,  1 Jul 2021 15:48:51 +0200 (CEST)
Date: Thu, 1 Jul 2021 15:48:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, davem@davemloft.net,
 kuba@kernel.org, smalin@marvell.com, aelior@marvell.com,
 mkalderon@marvell.com, okulkarni@marvell.com,
 prabhakar.pkin@gmail.com, malin1024@gmail.com,
 Dean Balandin <dbalandin@marvell.com>
Subject: Re: [PATCH v4 10/20] qedn: Add qedn probe
Message-ID: <20210701134850.GA20739@lst.de>
References: <20210629124743.6898-1-pkushwaha@marvell.com>
 <20210629124743.6898-11-pkushwaha@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210629124743.6898-11-pkushwaha@marvell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210701_064855_293030_464C2B4A 
X-CRM114-Status: GOOD (  22.66  )
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

On Tue, Jun 29, 2021 at 03:47:33PM +0300, Prabhakar Kushwaha wrote:
> From: Shai Malin <smalin@marvell.com>
> 
> This patch introduces the functionality of loading and unloading
> physical function.
> qedn_probe() loads the offload device PF(physical function), and
> initialize the HW and the FW with the PF parameters using the
> HW ops->qed_nvmetcp_ops, which are similar to other "qed_*_ops" which
> are used by the qede, qedr, qedf and qedi device drivers.
> qedn_remove() unloads the offload device PF, re-initialize the HW and
> the FW with the PF parameters.
> 
> The struct qedn_ctx is per PF container for PF-specific attributes and
> resources.
> 
> Acked-by: Igor Russkikh <irusskikh@marvell.com>
> Signed-off-by: Dean Balandin <dbalandin@marvell.com>
> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Shai Malin <smalin@marvell.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/hw/Kconfig          |   1 +
>  drivers/nvme/hw/qedn/qedn.h      |  26 ++++++
>  drivers/nvme/hw/qedn/qedn_main.c | 155 ++++++++++++++++++++++++++++++-
>  3 files changed, 177 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/hw/Kconfig b/drivers/nvme/hw/Kconfig
> index 374f1f9dbd3d..91b1bd6f07d8 100644
> --- a/drivers/nvme/hw/Kconfig
> +++ b/drivers/nvme/hw/Kconfig
> @@ -2,6 +2,7 @@
>  config NVME_QEDN
>  	tristate "Marvell NVM Express over Fabrics TCP offload"
>  	depends on NVME_TCP_OFFLOAD
> +	select QED_NVMETCP

This makes kconfig unhappy:

WARNING: unmet direct dependencies detected for QED_NVMETCP
  Depends on [n]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_QLOGIC [=n]
  Selected by [y]:
  - NVME_QEDN [=y] && NVME_TCP_OFFLOAD [=y]

While we're at unhappy:  without pinpointing it to the pointlessly
split patches, this series generates tons of sparse warnings:


drivers/nvme/hw/qedn/qedn_main.c:17:30: warning: symbol 'qed_ops' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_main.c:38:24: warning: symbol 'qedn_add_llh_filter' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_main.c:90:6: warning: symbol 'qedn_dec_llh_filter' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_main.c:493:6: warning: symbol 'qedn_fw_cq_fp_handler' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_main.c:813:58: warning: incorrect type in assignment (different base types)
drivers/nvme/hw/qedn/qedn_main.c:813:58:    expected restricted __le32 [usertype] hi
drivers/nvme/hw/qedn/qedn_main.c:813:58:    got unsigned int [usertype]
drivers/nvme/hw/qedn/qedn_main.c:814:58: warning: incorrect type in assignment (different base types)
drivers/nvme/hw/qedn/qedn_main.c:814:58:    expected restricted __le32 [usertype] lo
drivers/nvme/hw/qedn/qedn_main.c:814:58:    got unsigned int [usertype]
drivers/nvme/hw/qedn/qedn_task.c:358:6: warning: symbol 'qedn_return_task_to_pool' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_task.c:422:5: warning: symbol 'qedn_send_read_cmd' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_task.c:502:32: warning: incorrect type in assignment (different base types)
drivers/nvme/hw/qedn/qedn_task.c:502:32:    expected unsigned short [usertype] host_cccid
drivers/nvme/hw/qedn/qedn_task.c:502:32:    got restricted __le16 [usertype]
drivers/nvme/hw/qedn/qedn_task.c:471:5: warning: symbol 'qedn_send_write_cmd' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_task.c:553:24: warning: incorrect type in return expression (different base types)
drivers/nvme/hw/qedn/qedn_task.c:553:24:    expected int
drivers/nvme/hw/qedn/qedn_task.c:553:24:    got restricted blk_status_t [usertype]
drivers/nvme/hw/qedn/qedn_task.c:576:24: warning: incorrect type in return expression (different base types)
drivers/nvme/hw/qedn/qedn_task.c:576:24:    expected int
drivers/nvme/hw/qedn/qedn_task.c:576:24:    got restricted blk_status_t [usertype]
drivers/nvme/hw/qedn/qedn_task.c:586:22: warning: symbol 'qedn_cqe_get_active_task' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_task.c:629:5: warning: symbol 'qedn_process_nvme_cqe' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_task.c:646:5: warning: symbol 'qedn_complete_c2h' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_task.c: note: in included file (through drivers/nvme/hw/qedn/qedn.h):
drivers/nvme/hw/qedn/../../host/tcp-offload.h:207:45: error: marked inline, but without a definition
drivers/nvme/hw/qedn/qedn_conn.c:107:22: warning: incorrect type in assignment (different base types)
drivers/nvme/hw/qedn/qedn_conn.c:107:22:    expected unsigned short [usertype] src_port
drivers/nvme/hw/qedn/qedn_conn.c:107:22:    got restricted __be16 [usertype] sin_port
drivers/nvme/hw/qedn/qedn_conn.c:98:5: warning: symbol 'qedn_fill_ep_addr4' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_conn.c:126:22: warning: incorrect type in assignment (different base types)
drivers/nvme/hw/qedn/qedn_conn.c:126:22:    expected unsigned short [usertype] src_port
drivers/nvme/hw/qedn/qedn_conn.c:126:22:    got restricted __be16 [usertype] sin6_port
drivers/nvme/hw/qedn/qedn_conn.c:116:5: warning: symbol 'qedn_fill_ep_addr6' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_conn.c:557:23: warning: cast from restricted __le16
drivers/nvme/hw/qedn/qedn_conn.c:560:27: warning: cast from restricted __le32
drivers/nvme/hw/qedn/qedn_conn.c:629:6: warning: symbol 'qedn_error_recovery' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_conn.c:727:6: warning: symbol 'qedn_prep_db_data' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_conn.c:933:6: warning: symbol 'qedn_cleanup_all_fw_tasks' was not declared. Should it be static?
drivers/nvme/hw/qedn/qedn_conn.c:976:6: warning: symbol 'qedn_destroy_connection' was not declared. Should it be static?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
