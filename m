Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864E4C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 07:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nZkyNsXHdr4aOnSuf8AuFMNumXjRVj+fueK77OqUVok=; b=yEGmYE8Q0jogKtbDCPPR3ytBYG
	QwMLAT3bCjeEjNaMMEhQJtvEcBiemaLPKy05HIg30c4x4PP0iCmhLUsg4epHpHTwthomp170NSaRc
	detFDVYj2lORYB/q/1W4wnlorXsVvlltvWsuAoSwzCxP6CR1ZbR7R/oZ2v8DBVdlInToOiRGxlL3J
	mZuHY2M9agLUDhmsOjXdvB/25W5jJHY0wnKxBbk/+fnpBjUh1WAht75hWvwP0ecrjjWBXjMLWG2g0
	p6GH6QmjNX/DSsGniAIUQaucZ/gjwuP77RQvb9YT5/bjghHn1asXB0dzZdlS4X4qmV5Tima0Ztzw1
	PNOvdpww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUTt-00D4oo-1g;
	Tue, 19 Dec 2023 07:25:33 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUTq-00D4mC-18
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 07:25:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F1A0220C5;
	Tue, 19 Dec 2023 07:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702970726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZkyNsXHdr4aOnSuf8AuFMNumXjRVj+fueK77OqUVok=;
	b=yOE3WJRXoMIkEDKlh89pa0Nu+oenGbV4KFYZWzWmmiCAqmgniJbasmaZA8pKt2WmjdUlJG
	9/83WQ8mbRu1fqmDaTBHG2LoNYzxOFEIAQI9/9VZazAP0fsEMNL3I281l7F/qGO8mbjior
	LrY0ZI3trrLWss3T+B1Rp+7a5u+TMQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702970726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZkyNsXHdr4aOnSuf8AuFMNumXjRVj+fueK77OqUVok=;
	b=/mqU1Nj/yOhpZP3MdBaGc/dkFPs5xseMvqCuhJGZU6ECq44/ksutqUyt5y7zCxyC3I1TlA
	A+kXxJfv69Jr6GDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702970726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZkyNsXHdr4aOnSuf8AuFMNumXjRVj+fueK77OqUVok=;
	b=yOE3WJRXoMIkEDKlh89pa0Nu+oenGbV4KFYZWzWmmiCAqmgniJbasmaZA8pKt2WmjdUlJG
	9/83WQ8mbRu1fqmDaTBHG2LoNYzxOFEIAQI9/9VZazAP0fsEMNL3I281l7F/qGO8mbjior
	LrY0ZI3trrLWss3T+B1Rp+7a5u+TMQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702970726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZkyNsXHdr4aOnSuf8AuFMNumXjRVj+fueK77OqUVok=;
	b=/mqU1Nj/yOhpZP3MdBaGc/dkFPs5xseMvqCuhJGZU6ECq44/ksutqUyt5y7zCxyC3I1TlA
	A+kXxJfv69Jr6GDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFC98136A5;
	Tue, 19 Dec 2023 07:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6Dt9NmVFgWVmcgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 07:25:25 +0000
Message-ID: <e47cf4c5-0b6c-443a-bfb9-c7bdb649816c@suse.de>
Date: Tue, 19 Dec 2023 08:25:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/16] nvmet-fc: remove unnecessary bracket
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-3-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.95 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.86)[94.18%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_232530_550130_2F741F71 
X-CRM114-Status: GOOD (  14.79  )
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

On 12/18/23 16:30, Daniel Wagner wrote:
> There is no need for the bracket around the identifier. Remove it.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index bd59990b5250..bda7a3009e85 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1031,7 +1031,7 @@ nvmet_fc_match_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   	list_for_each_entry(host, &tgtport->host_list, host_list) {
>   		if (host->hosthandle == hosthandle && !host->invalid) {
>   			if (nvmet_fc_hostport_get(host))
> -				return (host);
> +				return host;
>   		}
>   	}
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


