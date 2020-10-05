Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B8FC4363D
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 11:31:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F07F2064C
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 11:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EiOPPGYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F07F2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PFC+bjlXZz6Ts6q5wjw34TJELx/icOUmctS1/Iu7Ipo=; b=EiOPPGYe0dIZfthOk0F60I1tO
	f6paGI10pN27kbDflvwGnk+evIG55tsQ3v/yGMnXj5zaYKKAxsyM0n1EwTBdouVSuI1pW0kHxzf50
	hKVOeV7QO/og0vJWvyUuJXT7B5U2l/UcAHczHx0aHCGWJyRHiHZ7A9hVkTrpu4Ov9sh1HAz564dnC
	2voyuCidsLNx/ZkEWfAba9LImW+0XRV2uithOvSOnJRkrGyTgrgB5Hwp++euYer57Hm2T7c5pnbDK
	qRyq/4AXPRnX1pdgarJHzPe2RuC+s/5SkAqRWODoCSBq4K15z174YLKBYzar93wj5gsE42lHr2jm4
	/3Gatrmww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPOiF-0000Ls-Ax; Mon, 05 Oct 2020 11:31:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPOiC-0000K7-7p
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 11:31:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1460B67373; Mon,  5 Oct 2020 13:31:22 +0200 (CEST)
Date: Mon, 5 Oct 2020 13:31:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/3] nvme: add 'queue_if_no_path' sysfs attribute
Message-ID: <20201005113121.GC26872@lst.de>
References: <20201005094256.49358-1-hare@suse.de>
 <20201005094256.49358-4-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201005094256.49358-4-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_073124_423434_CCFD2320 
X-CRM114-Status: GOOD (  17.22  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 05, 2020 at 11:42:56AM +0200, Hannes Reinecke wrote:
> Add a sysfs attribute 'queue_if_no_path' to allow the admin to
> view and modify the 'queue_if_no_path' flag.

ok, here it gets added.  I think this needs to be folded into the
previous patch.

> +{
> +	struct nvme_ns_head *head = dev_to_ns_head(dev);
> +	int queue_if_no_path, err;
> +
> +	err = kstrtoint(buf, 10, &queue_if_no_path);
> +	if (err)
> +		return -EINVAL;
> +
> +	else if (queue_if_no_path <= 0)

I think this needs to use kstrtobool..

>  #ifdef CONFIG_NVME_MULTIPATH
>  	&dev_attr_ana_grpid.attr,
>  	&dev_attr_ana_state.attr,
> @@ -3381,6 +3411,10 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
>  		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
>  			return 0;
>  	}
> +	if (a == &dev_attr_queue_if_no_path.attr) {
> +		if (dev_to_disk(dev)->fops == &nvme_fops)
> +			return 0;
> +	}
>  #ifdef CONFIG_NVME_MULTIPATH

The attribute only makes sense for the multipathing code, so it should
be under CONFIG_NVME_MULTIPATH.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
