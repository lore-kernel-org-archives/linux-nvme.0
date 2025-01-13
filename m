Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E443E7719E
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 10:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hWdtXmbwVfV2kb6VrDbGmTOkrpVmZGKTqIltoahzmdA=; b=WaRAevNlnKYMBrV7ChpVLdWerG
	kObdPjhLkergOc9vmBNz4I+BCMsGE+Hqx4kfPy9AJPlnRUZJsBGnb32VTKkVmitymterLz4gSyqI1
	jpkPJhNM0eNnqhY7VEGmqtCSJB4RYAyCse+rHx/rMTor5y5Xr8lkUpv8B2UQC1uc5wMbBdcDrCu1N
	nXa0seEvAg8Cj1Anx8mtKet9yv84MVQxQF96pZVPEeXH7+8v+UfoBaB9GZ4vln+szoHD8AZUVFubA
	gJP8PRZRq9zvlwUzhIB6cbHeKh2K8S54yvsD+KM+6ieZU7nmjYPEGnj5FvsENgwFSi4Cvo1LEwxqn
	m+JmxV0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXHmn-00000004nug-2BeP;
	Mon, 13 Jan 2025 10:35:09 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXHmk-00000004ntE-2nd3
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 10:35:08 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 248C921172;
	Mon, 13 Jan 2025 10:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736764505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWdtXmbwVfV2kb6VrDbGmTOkrpVmZGKTqIltoahzmdA=;
	b=ZYY7P/cBkURpRgrcH43a9Vg4DPhUhiaEtNGy/HOgedC53rqBFs1YY7UbbKoJ9v33Ul87QF
	PAU8J6ddH1DEo2Nz1cLtnFXwoX/tFsMlsriwKCzOZBTN3x3i0jCJBhVG7aAQYs+ZNUXQaG
	IwnQVGwr0GVSHgd4mnEVWInxYerO6Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736764505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWdtXmbwVfV2kb6VrDbGmTOkrpVmZGKTqIltoahzmdA=;
	b=ov5iMqkfQTW068eSWj1pJbhpKd1/DxL2ZhgEMoT76eVrstcX/KbrxBpIMaLv50rupfeNjg
	SJneLfPSu/venJBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736764505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWdtXmbwVfV2kb6VrDbGmTOkrpVmZGKTqIltoahzmdA=;
	b=ZYY7P/cBkURpRgrcH43a9Vg4DPhUhiaEtNGy/HOgedC53rqBFs1YY7UbbKoJ9v33Ul87QF
	PAU8J6ddH1DEo2Nz1cLtnFXwoX/tFsMlsriwKCzOZBTN3x3i0jCJBhVG7aAQYs+ZNUXQaG
	IwnQVGwr0GVSHgd4mnEVWInxYerO6Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736764505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWdtXmbwVfV2kb6VrDbGmTOkrpVmZGKTqIltoahzmdA=;
	b=ov5iMqkfQTW068eSWj1pJbhpKd1/DxL2ZhgEMoT76eVrstcX/KbrxBpIMaLv50rupfeNjg
	SJneLfPSu/venJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 001D813876;
	Mon, 13 Jan 2025 10:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TjobO1jshGdXbAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jan 2025 10:35:04 +0000
Message-ID: <3e54afa9-24fd-4712-bc5b-0c6f6f9ef11a@suse.de>
Date: Mon, 13 Jan 2025 11:35:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 RFC 2/3] nvme-multipath: Add visibility for numa
 io-policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, dwagner@suse.de,
 chaitanyak@nvidia.com, axboe@fb.com, gjoyce@linux.ibm.com
References: <20250112124154.60690-1-nilay@linux.ibm.com>
 <20250112124154.60690-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250112124154.60690-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_023506_847349_D1E44D99 
X-CRM114-Status: GOOD (  15.62  )
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

On 1/12/25 13:41, Nilay Shroff wrote:
> This patch helps add nvme native multipath visibility for numa io-policy.
> It adds a new attribute file named "numa_nodes" under namespace gendisk
> device path node which prints the list of numa nodes preferred by the
> given namespace path. The numa nodes value is comma delimited list of
> nodes or A-B range of nodes.
> 
> For instance, if we have a shared namespace accessible from two different
> controllers/paths then accessing head node of the shared namespace would
> show the following output:
> 
> $ ls -l /sys/block/nvme1n1/multipath/
> nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
> nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
> 
> In the above example, nvme1n1 is head gendisk node created for a shared
> namespace and this namespace is accessible from nvme1c1n1 and nvme1c3n1
> paths. For numa io-policy we can then refer the "numa_nodes" attribute
> file created under each namespace path:
> 
> $ cat /sys/block/nvme1n1/multipath/nvme1c1n1/numa_nodes
> 0-1
> 
> $ cat /sys/block/nvme1n1/multipath/nvme1c3n1/numa_nodes
> 2-3
> 
>>From the above output, we infer that I/O workload targeted at nvme1n1
> and running on numa nodes 0 and 1 would prefer using path nvme1c1n1.
> Similarly, I/O workload running on numa nodes 2 and 3 would prefer
> using path nvme1c3n1. Reading "numa_nodes" file when configured
> io-policy is anything but numa would show no output.
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/multipath.c | 27 +++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      |  1 +
>   drivers/nvme/host/sysfs.c     |  5 +++++
>   3 files changed, 33 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

