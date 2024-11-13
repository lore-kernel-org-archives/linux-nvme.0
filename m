Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF30D41C2B
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 09:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zPXzZydT6qO4UokPRFwEZNudeu1M8HPAtnVVbwn0LLU=; b=ju5/9H4m/LpazjB7UOpXABRJxi
	69irWpsc8FV/EvF3CDuBP8BDvfm5VBwvaTScMKYJPCDmi7phfPzH2YYSsJ2FdMvCtNghzxEk38ra9
	dw4r+bMCOAAxlYp0R+Z8cOqHX/PIzCBShu3l7PkIdbuf/vlVYCICThc5ZcnFhVbRr+pha4xTfgX6s
	pBFUtS4uvMJMKEk0Uv0tCx2le+Z8qfic64h150ML8yFlCWjZQbvzuIPi/mViTm+TTkV2qQs2+KlPL
	Zm8cZpuYTA0IzNEJuPPmUjmoKAJ/JMg/8ZwaD22wKhx8+Ikc5S83HKNSO3TxRXb/i88XX43Hx/vAq
	2JhCYMhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBA8x-00000006LGd-16Kb;
	Wed, 13 Nov 2024 09:58:35 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBA0M-00000006IWD-2542
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 09:49:45 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AEA61F443;
	Wed, 13 Nov 2024 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPXzZydT6qO4UokPRFwEZNudeu1M8HPAtnVVbwn0LLU=;
	b=T1tNyApXhsadqKPRBvkhvdE8do15PWzdoweDb8GvAFmf9B1uLU9OAv8vdap6A2hQ8ovFXu
	rSxhO8LwoGOMxCSxIf8lZF52Ib0q6s5lWkhnrNh/9MycebbAw5W/6JwprrdrVCJY0zVGKq
	05nqTU6gi+HiXoL1OwhujElZlAk5/qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPXzZydT6qO4UokPRFwEZNudeu1M8HPAtnVVbwn0LLU=;
	b=q4bCy2+zJivHKa4X75WD4y0ZoZ8jKUIeO6gj7fHPeEkQePXM6bjVnGaph/rKq7Cdy2BMla
	g/rALeTsKGsHrpAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPXzZydT6qO4UokPRFwEZNudeu1M8HPAtnVVbwn0LLU=;
	b=T1tNyApXhsadqKPRBvkhvdE8do15PWzdoweDb8GvAFmf9B1uLU9OAv8vdap6A2hQ8ovFXu
	rSxhO8LwoGOMxCSxIf8lZF52Ib0q6s5lWkhnrNh/9MycebbAw5W/6JwprrdrVCJY0zVGKq
	05nqTU6gi+HiXoL1OwhujElZlAk5/qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPXzZydT6qO4UokPRFwEZNudeu1M8HPAtnVVbwn0LLU=;
	b=q4bCy2+zJivHKa4X75WD4y0ZoZ8jKUIeO6gj7fHPeEkQePXM6bjVnGaph/rKq7Cdy2BMla
	g/rALeTsKGsHrpAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D733D13A6E;
	Wed, 13 Nov 2024 09:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W9MbNDR2NGd2FQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:49:40 +0000
Message-ID: <4c4415c0-8ad9-4783-86d9-383676116e65@suse.de>
Date: Wed, 13 Nov 2024 10:49:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] scsi: replace blk_mq_pci_map_queues with
 blk_mq_hctx_map_queues
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
 storagedev@microchip.com, linux-nvme@lists.infradead.org
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-5-573bfca0cbd8@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-5-573bfca0cbd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_014942_714601_03FC7F6A 
X-CRM114-Status: GOOD (  11.05  )
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

On 11/12/24 14:26, Daniel Wagner wrote:
> Replace all users of blk_mq_pci_map_queues with the more generic
> blk_mq_hctx_map_queues. This in preparation to retire
> blk_mq_pci_map_queues.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/scsi/fnic/fnic_main.c             | 3 +--
>   drivers/scsi/hisi_sas/hisi_sas.h          | 1 -
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    | 4 ++--
>   drivers/scsi/megaraid/megaraid_sas_base.c | 3 +--
>   drivers/scsi/mpi3mr/mpi3mr.h              | 1 -
>   drivers/scsi/mpi3mr/mpi3mr_os.c           | 2 +-
>   drivers/scsi/mpt3sas/mpt3sas_scsih.c      | 3 +--
>   drivers/scsi/pm8001/pm8001_init.c         | 2 +-
>   drivers/scsi/pm8001/pm8001_sas.h          | 1 -
>   drivers/scsi/qla2xxx/qla_nvme.c           | 3 +--
>   drivers/scsi/qla2xxx/qla_os.c             | 4 ++--
>   drivers/scsi/smartpqi/smartpqi_init.c     | 7 +++----
>   12 files changed, 13 insertions(+), 21 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

