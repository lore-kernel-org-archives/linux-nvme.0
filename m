Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107EE606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Gbz7xk47;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jQgitzgM;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2NOZfo8Y;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jQgitzgM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2NOZfo8Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=STsVHxEZaptO1jscQEzN2V9Mzy64mxExYfclXf2X+U0=; b=Gbz7xk47Kys7bJ
	LLz4j7l60zy4JKYM89nck6/Lwwpt54onpHXRXnKdn7KcY4QZAKQD+jOuc9Sw//5X1YPIi6pgVr8pY
	IIDnwNsXDbSlkCqy0w8eu/MjW2wd55Racri+otmBqjV6GQPWfhLw80tAavddJPscdcyGsdRrJhw73
	9HIH+Xn+ayRFl7G3rBuXoDZRPll9H9sm7aqL7NkBrRtReAM5I0ELOhtulAto9tB6NyHQrQutcDi4E
	2ydUtLcnx4jhGp3jwj+5KwwTcJ8Bhx4KW8Du/9P7B6B0JbswFEplIROZatBnzK/ePxvAsg3xsaCoi
	06xTvpmS32ZMJE5Khs2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVkY1-00000005hsS-3t68;
	Tue, 24 Nov 2026 07:02:37 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVkXz-00000005hro-1iC3
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 07:02:36 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F2DF1F74D;
	Tue, 24 Nov 2026 07:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795503753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STsVHxEZaptO1jscQEzN2V9Mzy64mxExYfclXf2X+U0=;
	b=jQgitzgMLmXph1U7lmk5Rp/HURjgjLVRqajRdx0Amf5jpCFvppQ92saqw1jSKeGT7mJ04E
	jLOWLG5GemkPXUilpULlYjy7Zc5ggTGRAYoKdgjG2TfKf1oCz1uc+qH0ZfdNTmBkf+2AaQ
	VHNpzUjbC3j+uZix5eNe3G2F4Yh4Zv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795503753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STsVHxEZaptO1jscQEzN2V9Mzy64mxExYfclXf2X+U0=;
	b=2NOZfo8YIxws9suZHcdl1kBNnokr/gqM4hZyNiS2E7P/0VKr+rVMCUPKWd2ZiikEPUwaKL
	BkYvMjZufPMqDSAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795503753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STsVHxEZaptO1jscQEzN2V9Mzy64mxExYfclXf2X+U0=;
	b=jQgitzgMLmXph1U7lmk5Rp/HURjgjLVRqajRdx0Amf5jpCFvppQ92saqw1jSKeGT7mJ04E
	jLOWLG5GemkPXUilpULlYjy7Zc5ggTGRAYoKdgjG2TfKf1oCz1uc+qH0ZfdNTmBkf+2AaQ
	VHNpzUjbC3j+uZix5eNe3G2F4Yh4Zv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795503753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STsVHxEZaptO1jscQEzN2V9Mzy64mxExYfclXf2X+U0=;
	b=2NOZfo8YIxws9suZHcdl1kBNnokr/gqM4hZyNiS2E7P/0VKr+rVMCUPKWd2ZiikEPUwaKL
	BkYvMjZufPMqDSAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC9BD13505;
	Tue, 24 Nov 2026 07:02:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2k4MIIg2BWvbNAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 24 Nov 2026 07:02:32 +0000
Message-ID: <9affc195-9715-45b5-8daf-f778ccb90f39@suse.de>
Date: Tue, 24 Nov 2026 08:02:32 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] nvme-tcp: expose per-queue socket addresses via
 sysfs
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, dwagner@suse.de,
 hch@lst.de, sagi@grimberg.me, chaitanyak@nvidia.com, gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org
References: <20261123173727.2022020-1-nilay@linux.ibm.com>
 <20261123173727.2022020-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261123173727.2022020-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:email];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_230235_610371_DE2CDA84 
X-CRM114-Status: GOOD (  24.01  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 6:37 PM, Nilay Shroff wrote:
> Add a read-only per-queue sysfs attribute named "address" to expose
> the socket addresses associated with each NVMe/TCP I/O queue.
> 
> The attribute reports the socket's peer and local endpoint information
> using the following fields:
> 
> - traddr: Peer transport address
> - trsvcid: Peer transport service identifier
> - host_traddr: Host transport address
> - host_trsvcid: Host transport service identifier
> 
> The attribute is available at:
>      /sys/class/nvme/nvmeX/queues/&lt;qid&gt;/address
> 
> Together with the existing per-queue "io_cpu" attribute, this
> information helps correlate NVMe/TCP I/O queues with network stack
> components and tune their interaction, including IRQ affinity,
> RPS/RFS, XPS and NIC flow steering (ntuple).
> 
> No changes to I/O behavior are expected.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/tcp.c | 50 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index f1d29d9f75cc..c7e736df71d2 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2123,14 +2123,64 @@ static ssize_t managed_show(struct kobject *kobj, struct kobj_attribute *attr,
>   			  !test_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags));
>   }
>   
> +static ssize_t address_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			    char *buf)
> +{
> +	struct nvme_tcp_queue *queue = nvme_queue_info_data(kobj);
> +	struct sockaddr_storage src, dst;
> +	int ret = 0;
> +
> +	mutex_lock(&queue->queue_lock);
> +
> +	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
> +		goto out;
> +
> +	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src);
> +	if (ret <= 0)
> +		goto out;
> +
> +	ret = kernel_getpeername(queue->sock, (struct sockaddr *)&dst);
> +	if (ret <= 0)
> +		goto out;
> +
> +	if (src.ss_family != dst.ss_family) {
> +		ret = -EAFNOSUPPORT;
> +		goto out;
> +	}
> +
> +	if (src.ss_family == AF_INET) {
> +		struct sockaddr_in *sip = (struct sockaddr_in *)&src;
> +		struct sockaddr_in *dip = (struct sockaddr_in *)&dst;
> +
> +		ret = sysfs_emit(buf, "traddr=%pI4,trsvcid=%hu,host_traddr=%pI4,host_trsvcid=%hu\n",
> +				&dip->sin_addr.s_addr, ntohs(dip->sin_port),
> +				&sip->sin_addr.s_addr, ntohs(sip->sin_port));
> +	} else if (src.ss_family == AF_INET6) {
> +		struct sockaddr_in6 *sip6 = (struct sockaddr_in6 *)&src;
> +		struct sockaddr_in6 *dip6 = (struct sockaddr_in6 *)&dst;
> +
> +		ret = sysfs_emit(buf, "traddr=%pI6c,trsvcid=%hu,host_traddr=%pI6c,host_trsvcid=%hu\n",
> +				&dip6->sin6_addr, ntohs(dip6->sin6_port),
> +				&sip6->sin6_addr, ntohs(sip6->sin6_port));
> +	} else {
> +		ret = -EAFNOSUPPORT;
> +	}
> +out:
> +	mutex_unlock(&queue->queue_lock);
> +	return ret;
> +}
> +

Hmm. This is stretching the definition of 'traddr' and 'host_traddr'
a bit, as normally these are controller settings, not queue settings.
I do see the logic, but I'm not quite happy with it.

>   static struct kobj_attribute nvme_tcp_io_cpu_attr =
>   	__ATTR(io_cpu, 0644, io_cpu_show, io_cpu_store);
>   static struct kobj_attribute nvme_tcp_managed_attr =
>   	__ATTR_RO(managed);
> +static struct kobj_attribute nvme_tcp_address_attr =
> +	__ATTR_RO(address);
>   
>   static struct attribute *nvme_tcp_queue_attrs[] = {
>   	&nvme_tcp_io_cpu_attr.attr,
>   	&nvme_tcp_managed_attr.attr,
> +	&nvme_tcp_address_attr.attr,
>   	NULL,
>   };
>   ATTRIBUTE_GROUPS(nvme_tcp_queue);

But in general it's a good idea.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

