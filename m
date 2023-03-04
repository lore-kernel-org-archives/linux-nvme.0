Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7926C678D5
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Mar 2023 08:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7y6sL+0koV15HCEsLXsyTvxPxnQPCO+SWdqKpKczNZY=; b=u0RhUASPpVmxR8FDDrXRYXVx1u
	DuVYAabLBvlcfkaWw7THbPm/zrFUnj+Uzb4NUbAZP7dkJ1kv5vBP7rEDSQSz5Mp1T/6RKNfrkatl/
	j6PSrJYEx7n5RJBMu6Vb5f2NjjTd9dNouLkbInWEzJ6/YXA1vXCpp0DC7pchKd/cMJPJB1yjUFnr9
	hqmirqzFW4g96ZetbU/PaXHjWnY3aZOw2f1RaY3YnPNXQzDPgUNPfuxeaP24ugIWBR+3lg9LnP+V7
	Qdxe574uumVio62kREAgdOOMg8v9ofKhOWDVYh3QJygyYh1VeMOGSJFgPelacvS6kOcO6CoV2J4rn
	zPl/mASA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYMom-008Xw9-If; Sat, 04 Mar 2023 08:00:36 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYMoi-008Xut-MN
	for linux-nvme@lists.infradead.org; Sat, 04 Mar 2023 08:00:35 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F173B21FF0;
	Sat,  4 Mar 2023 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1677916830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7y6sL+0koV15HCEsLXsyTvxPxnQPCO+SWdqKpKczNZY=;
	b=GI8WRT5xK1by6ci2E2LlZkfedzk488NHl8RJLM+cQ8iOyrWdPS4tG/fLILYxXUx4YgUtzI
	UpNA9vt+0GTX+FQurQOcq9IQgr61Rf1jnpn/2/LlCzKPDB5ZfZ0/hl3E9Oi9crYE1VsA2Q
	1RJ3fec9bIOIBSBS02j1DTCPIy8sHJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1677916830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7y6sL+0koV15HCEsLXsyTvxPxnQPCO+SWdqKpKczNZY=;
	b=fUSHaDJfVOfVbeq5EAuWPRMWYMPOSjCWx12f/TOBjjD5sa7D9TtuKBoVnFylKP0DWQpXhK
	YkummfEZogyYmvDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C08A13901;
	Sat,  4 Mar 2023 08:00:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EJ2KFp76AmTdFgAAMHmgww
	(envelope-from <hare@suse.de>); Sat, 04 Mar 2023 08:00:30 +0000
Message-ID: <80db29ee-70c7-5dad-cd5e-d2348d6d789d@suse.de>
Date: Sat, 4 Mar 2023 09:00:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] nvme: fix handling single range discard request
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org
References: <20230303231345.119652-1-ming.lei@redhat.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230303231345.119652-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230304_000032_925403_C10CBC5A 
X-CRM114-Status: GOOD (  20.88  )
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

On 3/4/23 00:13, Ming Lei wrote:
> When investigating one customer report on warning in nvme_setup_discard,
> we observed the controller(nvme/tcp) actually exposes
> queue_max_discard_segments(req->q) == 1.
> 
> Obviously the current code can't handle this situation, since contiguity
> merge like normal RW request is taken.
> 
> Fix the issue by building range from request sector/nr_sectors directly.
> 
> Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c2730b116dc6..d4be525f8100 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>   		range = page_address(ns->ctrl->discard_page);
>   	}
>   
> -	__rq_for_each_bio(bio, req) {
> -		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> -		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> -
> -		if (n < segments) {
> -			range[n].cattr = cpu_to_le32(0);
> -			range[n].nlb = cpu_to_le32(nlb);
> -			range[n].slba = cpu_to_le64(slba);
> +	if (queue_max_discard_segments(req->q) == 1) {
> +		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
> +		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
> +
> +		range[0].cattr = cpu_to_le32(0);
> +		range[0].nlb = cpu_to_le32(nlb);
> +		range[0].slba = cpu_to_le64(slba);
> +		n = 1;
> +	} else { > +		__rq_for_each_bio(bio, req) {
> +			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> +			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> +
> +			if (n < segments) {
> +				range[n].cattr = cpu_to_le32(0);
> +				range[n].nlb = cpu_to_le32(nlb);
> +				range[n].slba = cpu_to_le64(slba);
> +			}
> +			n++;
>   		}
> -		n++;
>   	}
>   
>   	if (WARN_ON_ONCE(n != segments)) {
Now _that_ is odd.
Looks like 'req' is not formatted according to the 'max_discard_sectors' 
setting.
But if that's the case, then this 'fix' would fail whenever 
'max_discard_sectors' < 'max_hw_sectors', right?
Shouldn't we rather modify the merge algorithm to check for 
max_discard_sectors for DISCARD requests, such that we never _have_
mis-matched requests and this patch would be pointless?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


