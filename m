Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0199BC4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 11:28:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948952064C
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 11:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aGCaelsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948952064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v3N+Hw0WtsgeO2qj7+AF24Ac8mlbv0WyRFv0l232y+Q=; b=aGCaelsbRjPmbwjIS/22S20bS
	FADW+tVn1mLLt8RrNetW1qZienE+2wnMUrNKrf5Ztz31L/m2WsDVC/Q32UEeEerNmdPQgBZuD8raB
	9pgzc3f5KME9hN4YSVhk0kRvh/ixoxBzR3j0jJ7pV2jGuDbby3x7fMwQL0fEPmGUrzpqlBTPfHFmM
	ScW8ue0RjoBstgruF8i7wBMvCR8yEAcDW0sbY6zrKtRFHmtfnBGT5LuZKEaB7i03Grl9ZXHV2ihh+
	wYAWt7isk36kCrcx+u610uYuAVXK8wH0ZdvtuOyYWsQVS2y5k4TqQT3cnHrrd5HRvy/5iiQ1Gr1s6
	+kNUniOrQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPOeu-0007fD-GA; Mon, 05 Oct 2020 11:28:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPOer-0007d3-0D
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 11:27:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1AD4E67373; Mon,  5 Oct 2020 13:27:54 +0200 (CEST)
Date: Mon, 5 Oct 2020 13:27:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/3] nvme-mpath: delete disk after last connection
Message-ID: <20201005112753.GA26872@lst.de>
References: <20201005094256.49358-1-hare@suse.de>
 <20201005094256.49358-2-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201005094256.49358-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_072757_168573_84426C99 
X-CRM114-Status: GOOD (  13.24  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 05, 2020 at 11:42:54AM +0200, Hannes Reinecke wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 385b10317873..af950d58c562 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -474,7 +474,8 @@ static void nvme_free_ns_head(struct kref *ref)
>  	struct nvme_ns_head *head =
>  		container_of(ref, struct nvme_ns_head, ref);
>  
> -	nvme_mpath_remove_disk(head);
> +	if (head->disk)
> +		put_disk(head->disk);

This wasn't compile for the !CONFIG_NVME_MULTIPATH case.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
