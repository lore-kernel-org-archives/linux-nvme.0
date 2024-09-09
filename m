Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556F3ECE579
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F8+7GNX2LKXsFVTyn74g7I/4kFH6XT/5vPutVj/v8nA=; b=Kp9l039xGQQDcC10qJSY670UUc
	x38o3GfT6zRvgzhEXy/cU8cnM1ncVGFa1cYQNszMxEg4XpdpkkHfk9RXw+IAkgU0XWM18g3i3jYWe
	6tbPxgdXt3E01EWLLi8RA3YHszQV+u95yX8t2qydBnq4X5UalyeomAWjakKhs7GdIb3P9yqqynvIS
	iZI0t8zQJmQLgPgdFl3hzuF/qnBvteaLfLUuz/oUnK8fKTq9Rt5DfJuLz8oTBCXg2pHTsphI/bgeq
	gDUA+F4VBuVUtBHBhmPW59MpvCtsfmeBQWoqsoico8JiQh68+ZSbWRwcE3h9pmtPAKvUiGkfC+h5d
	04hWAgWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sndhM-00000001rx5-02yx;
	Mon, 09 Sep 2024 12:40:52 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sndhH-00000001rvy-23EF
	for linux-nvme@lists.infradead.org;
	Mon, 09 Sep 2024 12:40:50 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B8A321BD8;
	Mon,  9 Sep 2024 12:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725885645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8+7GNX2LKXsFVTyn74g7I/4kFH6XT/5vPutVj/v8nA=;
	b=hcjiO5UomAGAsQihT5yO44iZ7EcvWo5MSikDmOyNVCIYPCfj2ybp0/XoOxQSb+1rm5Hewm
	E7dKXGz+AgZbtzvTp6lWSllqVhCUTm1hrwJ2fWvvdxFXqARUMepgOCU9gcUsTg0b4eVi6J
	wcnuwQjdREd9/w7WtbdGez7DlVUlghM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725885645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8+7GNX2LKXsFVTyn74g7I/4kFH6XT/5vPutVj/v8nA=;
	b=DB94aq/OHKk9yYlE8PpQiGoty92AjkkvwL8La+CV5dgXiGk78MC8qqWyfVwbzpsklbo+NM
	QHbeaBGrLlNpztAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725885645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8+7GNX2LKXsFVTyn74g7I/4kFH6XT/5vPutVj/v8nA=;
	b=hcjiO5UomAGAsQihT5yO44iZ7EcvWo5MSikDmOyNVCIYPCfj2ybp0/XoOxQSb+1rm5Hewm
	E7dKXGz+AgZbtzvTp6lWSllqVhCUTm1hrwJ2fWvvdxFXqARUMepgOCU9gcUsTg0b4eVi6J
	wcnuwQjdREd9/w7WtbdGez7DlVUlghM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725885645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8+7GNX2LKXsFVTyn74g7I/4kFH6XT/5vPutVj/v8nA=;
	b=DB94aq/OHKk9yYlE8PpQiGoty92AjkkvwL8La+CV5dgXiGk78MC8qqWyfVwbzpsklbo+NM
	QHbeaBGrLlNpztAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 813B413A3A;
	Mon,  9 Sep 2024 12:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0xsiHc3s3mbmUAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 09 Sep 2024 12:40:45 +0000
Date: Mon, 9 Sep 2024 14:40:44 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, 
	sagi@grimberg.me, axboe@fb.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv3 RFC 1/1] nvme-multipath: Add sysfs attributes for
 showing multipath info
Message-ID: <e9f36c3a-e2c6-4d95-89c8-40e8b9b3594c@flourine.local>
References: <20240903135228.283820-1-nilay@linux.ibm.com>
 <20240903135228.283820-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903135228.283820-2-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_054047_700894_E26E8F55 
X-CRM114-Status: GOOD (  16.82  )
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

On Tue, Sep 03, 2024 at 07:22:19PM GMT, Nilay Shroff wrote:
> NVMe native multipath supports different IO policies for selecting I/O
> path, however we don't have any visibility about which path is being
> selected by multipath code for forwarding I/O.
> This patch helps add that visibility by adding new sysfs attribute files
> named "numa_nodes" and "queue_depth" under each namespace block device
> path /sys/block/nvmeXcYnZ/. We also create a "multipath" sysfs directory
> under head disk node and then from this directory add a link to each
> namespace path device this head disk node points to.
> 
> For instance, /sys/block/nvmeXnY/multipath/ would create a soft link to
> each path the head disk node <nvmeXnY> points to:
> 
> $ ls -1 /sys/block/nvme1n1/
> nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
> nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
> 
> For round-robin I/O policy, we could easily infer from the above output
> that I/O workload targeted to nvme3n1 would toggle across paths nvme1c1n1
> and nvme1c3n1.
> 
> For numa I/O policy, the "numa_nodes" attribute file shows the numa nodes
> being preferred by the respective block device path. The numa nodes value
> is comma delimited list of nodes or A-B range of nodes.
> 
> For queue-depth I/O policy, the "queue_depth" attribute file shows the
> number of active/in-flight I/O requests currently queued for each path.

As far I can tell, this looks good to me.

> +static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	int node;
> +	nodemask_t numa_nodes;
> +	struct nvme_ns *current_ns;
> +	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
> +	struct nvme_ns_head *head = ns->head;
> +
> +	nodes_clear(numa_nodes);
> +
> +	for_each_node(node) {
> +		current_ns = srcu_dereference(head->current_path[node],
> +				&head->srcu);

Don't you need to use srcu_read_lock() first?

> +		if (ns == current_ns)
> +			node_set(node, numa_nodes);

And if ns matches current_ns can't you break the loop?

Thanks,
Daniel

