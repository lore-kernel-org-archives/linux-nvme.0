Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D53C46CCD
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 11:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GlCCfHdUF8E59zVa06E6NUBcKS5WmlSLYddFv13EMtg=; b=BkRpz1mC000fjz4iPCDlrEYrvO
	0we4dHRxXAs8R+2raPD2OpOCJMkc2iVYrA/XMPStMKGnlixLE7hFjxyaCeGCYj+wbZ96o0GYI1SfD
	521CDXobj5+Q0Lw+V4oQ0k7DA+MpLzsO7kStwrkSzH/zYt5QUeXvf7VVzEI1HPe3Crx6WmCzdRrRo
	tY47lUTlZGAkDmGmyTru+GGbAl56CidhyIEXjPeLia3eSHzUX0ETWXTQW3xL5hm7jjnOnfq6blfln
	Z3EHkhYUmF7eugld4EunjKQ43UFbb6Mvywp7qNvaa+C4LBc8BxhtEGCdFLhprgGseYFqbbipf1C55
	i5rzwKqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYQc-00DpxL-0h;
	Tue, 19 Dec 2023 11:38:26 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYQa-00Dptp-05
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 11:38:25 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EF09220EA;
	Tue, 19 Dec 2023 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702985900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GlCCfHdUF8E59zVa06E6NUBcKS5WmlSLYddFv13EMtg=;
	b=MhBLKJ1gUpS3nbAKExf8T7817nxvJxnyDDq2JnihCsAprWCJ9eJp1aKyf4thjNPeudqdjc
	NF4wMdfHOnfrkz+QZ3Tk+bRqkCn0BS80ibfykJRdOjdBbdoo9htRhcrfUtz5tCte7PFYBb
	hL1yAZL3MP4AFOcw7lGi5vDCH5gfG00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702985900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GlCCfHdUF8E59zVa06E6NUBcKS5WmlSLYddFv13EMtg=;
	b=ALIu4m60oCV5YLeYV3Y79RDXz9JsSAFVY7RiDVQLnAGnKkvOcL/3ucxR6/oGMn+fy6XE1T
	hE7rBS1o6PoygyCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702985900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GlCCfHdUF8E59zVa06E6NUBcKS5WmlSLYddFv13EMtg=;
	b=MhBLKJ1gUpS3nbAKExf8T7817nxvJxnyDDq2JnihCsAprWCJ9eJp1aKyf4thjNPeudqdjc
	NF4wMdfHOnfrkz+QZ3Tk+bRqkCn0BS80ibfykJRdOjdBbdoo9htRhcrfUtz5tCte7PFYBb
	hL1yAZL3MP4AFOcw7lGi5vDCH5gfG00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702985900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GlCCfHdUF8E59zVa06E6NUBcKS5WmlSLYddFv13EMtg=;
	b=ALIu4m60oCV5YLeYV3Y79RDXz9JsSAFVY7RiDVQLnAGnKkvOcL/3ucxR6/oGMn+fy6XE1T
	hE7rBS1o6PoygyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B31F71375D;
	Tue, 19 Dec 2023 11:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +bcVJ6uAgWWGNQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:38:19 +0000
Message-ID: <824b9386-7c95-49d4-995a-d94c35855287@suse.de>
Date: Tue, 19 Dec 2023 12:38:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/16] nvmet-fc: do not tack refs on tgtports from
 assoc
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-13-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-13-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.02 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.73)[83.85%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_033824_215851_CF3B692F 
X-CRM114-Status: GOOD (  15.32  )
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

On 12/18/23 16:31, Daniel Wagner wrote:
> The association life time is tight to the life time of the target port.
                                tied

> That means we do not take extra a refcount when creating a association.
                 should not

> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index c243085d6f42..47cecc8c72b2 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1109,12 +1109,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   	if (idx < 0)
>   		goto out_free_assoc;
>   
> -	if (!nvmet_fc_tgtport_get(tgtport))
> -		goto out_ida;
> -
>   	assoc->hostport = nvmet_fc_alloc_hostport(tgtport, hosthandle);
>   	if (IS_ERR(assoc->hostport))
> -		goto out_put;
> +		goto out_ida;
>   
>   	assoc->tgtport = tgtport;
>   	assoc->a_id = idx;
> @@ -1144,8 +1141,6 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   
>   	return assoc;
>   
> -out_put:
> -	nvmet_fc_tgtport_put(tgtport);
>   out_ida:
>   	ida_free(&tgtport->assoc_cnt, idx);
>   out_free_assoc:
> @@ -1182,7 +1177,6 @@ nvmet_fc_target_assoc_free(struct kref *ref)
>   	dev_info(tgtport->dev,
>   		"{%d:%d} Association freed\n",
>   		tgtport->fc_target_port.port_num, assoc->a_id);
> -	nvmet_fc_tgtport_put(tgtport);
>   	kfree(assoc);
>   }
>   
Otherwise:
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


