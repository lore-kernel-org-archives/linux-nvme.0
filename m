Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B288DC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 28 May 2022 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9YYk895qsJh9ZTw+9hvRhS39eRmVTMfNXTkFkwXs5G0=; b=pcfeKgrehhFcqLFqnz6DYWSVjP
	ZZ9oQhtFHjERAhTTj77tJM8j/QlfkD79O9VKk8OIeCQ4EEYOXoudcxboQ05giVtDSUBpzDaxt/Xrw
	AEQdXEEVItTo1zxGyD/vOgWEWuvQEIMMK2EiQWhtS+lzzef9MuvXktPQZkvIJ1B00cdHE06EfDMA3
	DDJ8mW28VV9YWsAlP/w4Ol0wlEa0jE604hsq72kGFSMf8msECLalFmOv0d4IG7j/mHt4di+9lS8RJ
	d6E6/cWEvO9scm3R2HWhS4xXATpUy3ZUqvwhhSc1pv54CSgEzflks6bHr+HYqEbJsIq6ChCR3QMCX
	Se+Ht+Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuvMg-0027ij-6D; Sat, 28 May 2022 12:16:18 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuvMd-0027iD-1H
	for linux-nvme@lists.infradead.org; Sat, 28 May 2022 12:16:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CEA81F937;
	Sat, 28 May 2022 12:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1653740166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YYk895qsJh9ZTw+9hvRhS39eRmVTMfNXTkFkwXs5G0=;
	b=e1tp5T0Bb3i1HHdyBTOaErFqosHDFftuXOY3TfqsIqaI9ooq3ujP1lGEBYZxM67lj+PpL2
	0o1H/Q61Z0Rf5QQSsWC58aXaMuMTF4CZFx+KBtJvpQvT/071VORC4AnSgZfXPqhggT2RG/
	1JmEg4FcdS4c0LeiDUQW/lG8fpjN6HE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1653740166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YYk895qsJh9ZTw+9hvRhS39eRmVTMfNXTkFkwXs5G0=;
	b=EyFb/+BWTLhPXzmy+T21VTumSkZT4pbCXEF3bUHi9HWmZX6cINuc0TxThIQmJUJ1tm9i8A
	igY5v4ccAhncd0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E487134B3;
	Sat, 28 May 2022 12:16:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XCD6EYYSkmKoHQAAMHmgww
	(envelope-from <hare@suse.de>); Sat, 28 May 2022 12:16:06 +0000
Message-ID: <04624b93-e03c-4fd4-8201-031b1c6bb04e@suse.de>
Date: Sat, 28 May 2022 14:16:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/1] nvme-multipath: show wrong nvme ns after dlpar a nvme
 device
Content-Language: en-US
To: wenxiong@linux.ibm.com, hch@lst.de
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, wenxiong@us.ibm.com
References: <1653666577-3733-1-git-send-email-wenxiong@linux.ibm.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1653666577-3733-1-git-send-email-wenxiong@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220528_051615_421338_F077E0ED 
X-CRM114-Status: GOOD (  24.25  )
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

On 5/27/22 17:49, wenxiong@linux.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.ibm.com>
> 
> If we have an active partition/namespace on nvme device, nvme device driver
> won’t release these controller IDs/Namespaces IDs when dlpar remove.
> So we got the wrong nvme devices names if nvme device driver still use old
> subsystem id as controller id when dlpar add it back. We expect to see new
> nvme devices with new controller IDs/Namespace IDs.
> 
> For example, we have a nvme U2 device with 4 namespaces in linux,
> 
> After system boots up,
> Controller id:  0
> Subsystem id:   0
> namespaces ids: 1, 2, 3 and 4
> nvme devices  : nvme0n1, nvme0n2, nvme0n3 and nvme0n4
> 
> Dlpar remove with active partitions on nvme0n1,
> Controller id :   ID=0 still hold reference, ID=0 won’t be removed,  but /dev/nvme0 not exists anymore
> Subsystem id :    0(nvme-subsys0 still exist in nvme list-subsys)
> Namespace ids:    ID=1 still hold reference, ID=1 won’t be removed, but /dev/nvme0n1 not exists anymore
> Nvme devices:  all nvme devices are gone in /dev
> 
> Dlpar Add back
> Controller id:  1
> Subsystem id :  0 still use old controller id=0
> namespaces ids: 2, 3, 4 and 5
> nvme devices:   We saw "nvme0n2, nvme0n3, nvme0n4, nvme0n5" in /dev
>                  /dev/nvme0 not exist anymore,
>                  We expect to see: nvme1n2, nvme1n3, nvme1n4 and nvme1n5
> 
> The patch fixes the issue.
> 
> Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
> ---
>   drivers/nvme/host/multipath.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index d464fdf978fb..945974ceef3c 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -495,7 +495,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   	head->disk->fops = &nvme_ns_head_ops;
>   	head->disk->private_data = head;
>   	sprintf(head->disk->disk_name, "nvme%dn%d",
> -			ctrl->subsys->instance, head->instance);
> +			ctrl->instance, head->instance);
>   
>   	blk_queue_flag_set(QUEUE_FLAG_NONROT, head->disk->queue);
>   	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, head->disk->queue);

No, this is wrong.
The nvme subsystem is an internal construct within the linux subsystem, 
and the lifetime of that is determined by the lifetime of the associated 
controllers and namespaces.
So as long as a controller object (!) or namespace object exists which 
refer to the subsystem NQN, that subsystem object will exist.
When a controller is removed/detached by the dlpar the device nodes will 
be removed from the system, and the controller object itself will be 
freed/removed after the last reference drops. And only then will the 
reference to the subsystem be dropped, causing the subsystem object to 
be removed.
So if a new controller referring to the same subsystem NQN is connected 
while the subsystem object is still present it will naturally select 
that subsystem.

Everything is working as designed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

