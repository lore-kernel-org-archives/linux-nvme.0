Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFC9C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 11:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X6VnUPdRS6TIN2dqipVcMmUPRqSTj/GA47cqhqYJDZ0=; b=Fj9p7o9mbxEhre/urIansNz0kc
	l6fU3REDq09bveQH2Mq3QLtZf9pMBh7X7AngU/DlzgQrip7m14hTIq1/hd0kE4OW8OyGuaGQJX7Q8
	3XWxn9ClKhFLVZPyeLLAcw0q/7jIklZQwsL9K0MYzdbRpMTNONOYuSu/lyq351c8cAn65vx0lAgsU
	okJGWyY1mqjGa5tgx6hQAMDQn2/rBxoPnkZaCN4OS9YptY0PCVRVoU9ak3TCbpAtOUu2k3XX4myTE
	6v4BWiVSOpa7SB82MNo5POi9kkkiov1FDgyp8chTkshNDourI3m8KVA52F6NSnj2jizxtokTcw+XW
	4LUKyXQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYhu-00DvHA-3C;
	Tue, 19 Dec 2023 11:56:19 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYhs-00DvGR-0x
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 11:56:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B866220F3;
	Tue, 19 Dec 2023 11:56:14 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C65071375D;
	Tue, 19 Dec 2023 11:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gVhCLd2EgWV1OgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:56:13 +0000
Message-ID: <a503fe42-fd78-40d8-8cac-3c5ec088aefa@suse.de>
Date: Tue, 19 Dec 2023 12:56:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] nvme: move ns id info to struct nvme_ns_head
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Max Gurtovoy <mgurtovoy@nvidia.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20231218165954.29652-1-dwagner@suse.de>
 <20231218165954.29652-2-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218165954.29652-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Queue-Id: 9B866220F3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_035616_494372_FD423E3F 
X-CRM114-Status: GOOD (  14.01  )
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

On 12/18/23 17:59, Daniel Wagner wrote:
> Move the namesapce info to struct nvme_ns_head, because it's the same
> for all associated namespaces.
> 
> Note: with multipathing enabled the PI information is shared between all
> paths. If a path is using a different PI configuration it will overwrite
> the previous settings. This is obviously not correct and such
> configuration will be rejected in future. For the time being we expect
> a correctly configured storage.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/core.c  | 80 ++++++++++++++++++++-------------------
>   drivers/nvme/host/ioctl.c |  8 ++--
>   drivers/nvme/host/nvme.h  | 28 +++++++-------
>   drivers/nvme/host/rdma.c  |  2 +-
>   drivers/nvme/host/zns.c   | 17 +++++----
>   5 files changed, 69 insertions(+), 66 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


