Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D92CCD193
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 06:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p0JKnFlzd8UXhp4Y2ahcvueD8mr9lOiIzHpyyABEsqo=; b=K5f2Ma+xL9+Dyicvj7emOEk3dj
	mza9hvmNctwFDWhrRV9BnK291M/vjm0uUG2hPGB0kt6CjLiMXhQukMHc25TqqFfYB+1GeA9tEF/3O
	1dh7Y1QCN0gRzztoPtcv8YpOnIHK4j+DaPDb+NJLHtoNoECBmWUmy0aqBzIhrv7sblPoLvF9Yu1Ov
	GP5cW4UIUica1Q56rDmSlrv/0FHHcMjZbc3sUwZ0hvqZTHyDJeVkpW/WlDJvrfTzmobPOTNp3D+7K
	xLwZX5ELA0HzLbBH5qb2pgRBzYBJhuHEIBkS7B06yeQHOOVUHRMRJLtBvu819uK3bg0D3m/oZqFoX
	lLCvzcMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAjSE-0000000C3d9-2769;
	Mon, 20 Oct 2025 06:33:14 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAjSC-0000000C3c5-2FSn
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 06:33:13 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 253CB21193;
	Mon, 20 Oct 2025 06:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760941986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0JKnFlzd8UXhp4Y2ahcvueD8mr9lOiIzHpyyABEsqo=;
	b=iS3pzhTrUiYImuqKrSXLLUgPgcR53nvtlNUyX/6oF6NTbyv0nDmguIYJkh19VjO7XdXgoY
	OU8Dv/jWtnXfig7pUeuRbGS0eXjsAHQ9h8SSGpwG5wk+uhADbLprwNTA6fgeWL5raFudH8
	2XrwIlswRmdlMy4peWFsAZaT/vO+4dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760941986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0JKnFlzd8UXhp4Y2ahcvueD8mr9lOiIzHpyyABEsqo=;
	b=oWP6UlMhOLLTbXktLmPNEErrzaNa+ZmUxZvEEa9MuRXt7tqvf3aaeSy8kdqvC082HqphkR
	svj25b6JCgk/21BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760941982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0JKnFlzd8UXhp4Y2ahcvueD8mr9lOiIzHpyyABEsqo=;
	b=j5uPdZ5dR99iR8SZ2KHDneArjSvOf/3m1kNRCdC3xRJbRXkyzcrPmba2bnVMbIstLyFRYx
	cTrZH58MfyazQ2KZS91WLpqlvLb8FeNqASy09USTbuCoWF2rqRI+gic2GrZs2xw8MmNIK6
	0DCUImX9QMkEjoKYJRV0c5c/GL9qAGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760941982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0JKnFlzd8UXhp4Y2ahcvueD8mr9lOiIzHpyyABEsqo=;
	b=1l9JSvhuWBF4M6RNyqjohjr8IWZJ4MnU/PoweesWkkhqvQcnrRBy2t370oq1MQGT+7+4D7
	yJq/E4t1p6tpp7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9193B13A8E;
	Mon, 20 Oct 2025 06:33:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jp9EIZ3X9WgJXgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 20 Oct 2025 06:33:01 +0000
Message-ID: <8d6d76b4-6361-4392-9351-bd9d59c96ba0@suse.de>
Date: Mon, 20 Oct 2025 08:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] nvme-tcp: Allow userspace to trigger a KeyUpdate
 with debugfs
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-7-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251017042312.1271322-7-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251019_233312_743041_CA07D1D7 
X-CRM114-Status: GOOD (  20.75  )
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

On 10/17/25 06:23, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to trigger a KeyUpdate via debugfs. This patch exposes a
> key_update file that can be written to with the queue number to trigger
> a KeyUpdate on that queue.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v4:
>   - No change
> v3:
>   - New patch
> 
>   drivers/nvme/host/tcp.c | 72 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 791e0cc91ad8..f5c7b646d002 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -11,6 +11,7 @@
>   #include <linux/crc32.h>
>   #include <linux/nvme-tcp.h>
>   #include <linux/nvme-keyring.h>
> +#include <linux/debugfs.h>
>   #include <net/sock.h>
>   #include <net/tcp.h>
>   #include <net/tls.h>
> @@ -1429,6 +1430,75 @@ static void update_tls_keys(struct nvme_tcp_queue *queue)
>   	}
>   }
>   
> +#ifdef CONFIG_NVME_TCP_TLS
> +#define NVME_DEBUGFS_RW_ATTR(field) \
> +	static int field##_open(struct inode *inode, struct file *file) \
> +	{ return single_open(file, field##_show, inode->i_private); } \
> +	\
> +	static const struct file_operations field##_fops = { \
> +		.open = field##_open, \
> +		.read = seq_read, \
> +		.write = field##_write, \
> +		.release = single_release, \
> +	}
> +
> +static int nvme_ctrl_key_update_show(struct seq_file *m, void *p)
> +{
> +	seq_printf(m, "0\n");
> +
> +	return 0;
> +}
> +
> +static ssize_t nvme_ctrl_key_update_write(struct file *file, const char __user *buf,
> +					  size_t count, loff_t *ppos)
> +{
> +	struct seq_file *m = file->private_data;
> +	struct nvme_ctrl *nctrl = m->private;
> +	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> +	char kbuf[16] = {0};
> +	int queue_nr, rc;
> +	struct nvme_tcp_queue *queue;
> +
> +	if (count > sizeof(kbuf) - 1)
> +		return -EINVAL;
> +	if (copy_from_user(kbuf, buf, count))
> +		return -EFAULT;
> +	kbuf[count] = 0;
> +
> +	rc = kstrtouint(kbuf, 10, &queue_nr);
> +	if (rc)
> +		return rc;
> +
> +	if (queue_nr >= nctrl->queue_count)
> +		return -EINVAL;
> +
> +	queue = &ctrl->queues[queue_nr];
> +
> +	update_tls_keys(queue);

Are you sure this is correct?

'update_tls_keys' is issuing a handshake request
with 'HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED'.

And the patch introducing it states:
At this time we don't support initiating a KeyUpdate.

So please move this to the patchset implementing support
for initiating KeyUpdates.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

