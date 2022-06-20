Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D248CCA480
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 09:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nB/yp3HEkDLSR53YvvZ+cc5b/XzsxSbMJCE0yslr6zc=; b=slaXL/E/AJvdqoF1WohVw0MaZ9
	7oWuGbejYo+cRBATCI6AUma7WzQ/TzbWOWuMOMaD0yRYGBuisjOHtJVCalhUD8NUvGTGAFQwG5lNd
	0iuEc3exJDMjFliOEtOZ1U5YUqzJ1qCpMVgr9wmPB7+46b0VkBVCGQyMrRd7BTD0gY1tAZgB0qjkV
	VEtYmkukB3OQkRx0xZgKjc6GwBeNdy7071/XFYdkq9mVyqOFxnEBmY2emBJWjMzfa8iyXDl8ZV5ye
	jgKjdO9IoUx5amYWOExJhcvzq+1enSmxJewSWfM3K5I353RftIUBrjXUDaZDGhMp3CEBMmo2KLqGO
	eEm4usXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3DV0-00H5HM-B9; Mon, 20 Jun 2022 09:15:10 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3DUx-00H5Gc-Sa
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 09:15:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 963E121BCC;
	Mon, 20 Jun 2022 09:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655716506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nB/yp3HEkDLSR53YvvZ+cc5b/XzsxSbMJCE0yslr6zc=;
	b=NbhPF3eiBjOwpBjTxTBUKGLcxsUpBieYpaa2bJ0nJbYXBQ1DPLTOv6PAryYp6pYuLkGJMp
	3tgfG0fa6fCminQ1DLzfMd+WjxmVl6rS3eV3Ue98Pv9uCHk+cY4HYM23Vh4hlY/v6JSEwM
	aDLxRMGXFqqMCswLEfi5wCfSCrf/UVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655716506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nB/yp3HEkDLSR53YvvZ+cc5b/XzsxSbMJCE0yslr6zc=;
	b=VbVTFwKgG2nIUv1fgI3haPjroW7GO/BMDsd2lrneNkiRPCEGxdO4NFMQyrPoSvjY0kdG6w
	7BnNKKpZ/4fiogDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 779E5134CA;
	Mon, 20 Jun 2022 09:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id rzLrHJo6sGK+PQAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 20 Jun 2022 09:15:06 +0000
Message-ID: <34c6fd01-fcb7-b618-959f-331b65cc8739@suse.de>
Date: Mon, 20 Jun 2022 11:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/5] blk-mq: Add a flag for reserved requests
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, axboe@kernel.dk,
 damien.lemoal@opensource.wdc.com, bvanassche@acm.org, hch@lst.de,
 jejb@linux.ibm.com, martin.petersen@oracle.com, satishkh@cisco.com,
 sebaddel@cisco.com, kartilak@cisco.com
Cc: linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 nbd@other.debian.org
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
 <1655463320-241202-3-git-send-email-john.garry@huawei.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1655463320-241202-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_021508_106165_9A063926 
X-CRM114-Status: GOOD (  10.44  )
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

On 6/17/22 12:55, John Garry wrote:
> Add a flag for reserved requests so that drivers may know this for any
> special handling.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq.c         | 6 ++++++
>   include/linux/blk-mq.h | 6 ++++++
>   2 files changed, 12 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

