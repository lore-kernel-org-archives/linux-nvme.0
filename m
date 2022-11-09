Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AFEC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 06:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hd0uuIpbXpsJ6eRYImuDBkSgxMZwKQNOHugu8ksIqp4=; b=qZ2oSph4GZTenitEFIsyF7bmdB
	BcJ/EDiTR61r+o5Dmy/VReTCP8H+DnC3N86Bao3mfVlCM2hTwO1h2f6DDhaoeghCAMRSq9FB8Gaou
	R4uk4n0HXioj6mCFA6TtWdjI6nE4e4qxpJCcjHxjEMwjiXFvube9nKSlyP32WTeiE4thM1njGUVIf
	obRQjxAnuXfkqVD36OW1S2HijlmxQM6MwiWNnx8pDPRgvT83f/WBTdcpE8eJoT6wPN1XBiUrz741E
	52/Qdt9+K4BrbaukxbumnYGbkurNmfzKbDbU+GUMN7lEZqUxOQ/OHFeJI35jexrQK83fNU0jJLLyB
	dJVMNtVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osetW-00BMCp-GQ; Wed, 09 Nov 2022 06:49:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osetP-00BMC3-GZ
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 06:49:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 68F8B68BEB; Wed,  9 Nov 2022 07:48:55 +0100 (CET)
Date: Wed, 9 Nov 2022 07:48:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 12/16] nvme-auth: convert dhchap_auth_list to an array
Message-ID: <20221109064855.GC10893@lst.de>
References: <20221109034420.1000086-1-sagi@grimberg.me> <20221109034420.1000086-13-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109034420.1000086-13-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_224859_713607_EA200389 
X-CRM114-Status: GOOD (  20.47  )
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

> Make dhchap_auth_mutex protect only the ctrl host_key and ctrl_key
> in a fine-graned lock such that there is no long lasting acuisition
> of the lock.

Can you split that part into a separate patch?  Right now the patch
is a bit confusing because it does multiple things.


> +#define nvme_auth_chap_from_qid(ctrl, qid) \
> +	&((struct nvme_dhchap_queue_context*)(ctrl)->dhchap_ctxs)[qid]

Please properly type dhchap_ctxs instead of the ugly cast here.  That
also removed the need for the macro.
functions instead of macros.

> +#define ctrl_max_dhchaps(ctrl) \
> +	(ctrl)->opts->nr_io_queues + (ctrl)->opts->nr_write_queues + \
> +			(ctrl)->opts->nr_poll_queues + 1

This overallocates in case the controller supports less queues than
requested, but I guess that's not a big problem in practice.

Also please make this an inline function to add type safety and to make
it more readable.

> +#define nvme_foreach_dhchap(i, chap, ctrl) \
> +	for (i = 0, chap = (ctrl)->dhchap_ctxs; \
> +	     i < ctrl_max_dhchaps(ctrl) && chap != NULL; i++, chap++)

I find this macro a bit obsfucating.  There's only three callers anyway,
and they only use chap 1, 2 or three times respectively.

So I'd just loop:

	for (i = 0, i < ctrl_max_dhchaps(ctrl); i++)

and then do the dereference of >dhchap_ctxs in the loop.

>  			    void *data, size_t data_len, bool auth_send)
> @@ -330,7 +338,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
>  	struct nvmf_auth_dhchap_success1_data *data = chap->buf;
>  	size_t size = sizeof(*data);
>  
> -	if (ctrl->ctrl_key)
> +	if (chap->ctrl_key)

How is this related to the rest of the patch?

> +		INIT_WORK(&chap->auth_work, __nvme_auth_work);

Btw, this really should lose the __ prefix in another prep patch.

> +	}
> +
> +out:
>  	return ret;

We can just drop the out label and return directly.

