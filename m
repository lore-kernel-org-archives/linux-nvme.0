Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42133D41C27
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 09:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ElIsBM/8y9WJvsjd8VnyWPvVkquaQSaEO0rKfXW157Y=; b=kj4aSHNZFa2gHc1IcbYwZn3rxT
	GH1cMICuCb0xlYBoA3Pw1kckysnkKIkrhyGcEvrqTeENsVV+upImNqBlW5QUCfZihT5vlJWMh9GSH
	qWXwAXc/WiYnKw2eTRi5vMTgz67PnPqvQ2Ow6pGAieCbcH4B4/KbWcMMjmNV45EYq0RVIn1MbCXaI
	p/Q34e3fnn3Sb+Qo9zHTxE8Z1vyymPXg4hfy+zfheEVF4B8UemciQXNGM79MHxMwYvdPif1RMO357
	Q7k/ds8BjbAg5omX4IDnoX5tnweZScy7IPX/AjSebJBNmYjQq0YHBw+j0EdqqU45LvvHt9/wnS+Yd
	gUUwP6oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBA9O-00000006Lbn-3UkV;
	Wed, 13 Nov 2024 09:59:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBA1w-00000006IxC-2ju9
	for linux-nvme@bombadil.infradead.org;
	Wed, 13 Nov 2024 09:51:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ElIsBM/8y9WJvsjd8VnyWPvVkquaQSaEO0rKfXW157Y=; b=oeTAANhQGRACB3+cN/MJK1SIC0
	3wVXV81zYrPe5YptUzeLdHfnLRLL5dKJfjXulWVg/z9XdZd7iEnOvvOTz8v3/6bZhtJlX4QvRHMYu
	rwzO9cUNhWaMKFITbuDIFwRRgIDT+bsA5qbGpPMseXwC655wKEjiZUiXT5wQPkZSQWwf5mpVFRJYD
	qfAUZHKLMiSpcbeXPHgxaA4OdH663/eqGWV4GNHmqGQr5jOLFweuYQijhztCZHwG7ZxxnRFQnkPqm
	dTFN948FppU7gD6s1N+eEDFaVDmLUG+gzSLKmqKjzKujs0cJZ38oRWuW81F7w63Se0k0XSC3NgShP
	Y/0Y/Osg==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBA1t-0000000DEAQ-1t8G
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 09:51:19 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66B8D211D6;
	Wed, 13 Nov 2024 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElIsBM/8y9WJvsjd8VnyWPvVkquaQSaEO0rKfXW157Y=;
	b=N3OSex4ukMwPySSMIaZpjAi4UXTEa1L6666sipx85E4IJvHBNfoFo1QYy3213BBz7tfUo4
	AW3LD8TOzt0Mpt+ujL8Nc0BEf8rW5iZVjN/pj+BgiKf14vxw5+T1AbnBYZso7CT1bcXCzV
	/hFZrF584Tabgv4RedrT7CKGnLSdB+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElIsBM/8y9WJvsjd8VnyWPvVkquaQSaEO0rKfXW157Y=;
	b=PlRTtVCyhXsKAEZdRDsZq3h8itQ1nkOZ9lTvhsrWLPUvNWd5dYKUAeqhfpU93SAKSYH2yQ
	QZjuZroTsaHD+WBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=N3OSex4u;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PlRTtVCy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElIsBM/8y9WJvsjd8VnyWPvVkquaQSaEO0rKfXW157Y=;
	b=N3OSex4ukMwPySSMIaZpjAi4UXTEa1L6666sipx85E4IJvHBNfoFo1QYy3213BBz7tfUo4
	AW3LD8TOzt0Mpt+ujL8Nc0BEf8rW5iZVjN/pj+BgiKf14vxw5+T1AbnBYZso7CT1bcXCzV
	/hFZrF584Tabgv4RedrT7CKGnLSdB+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElIsBM/8y9WJvsjd8VnyWPvVkquaQSaEO0rKfXW157Y=;
	b=PlRTtVCyhXsKAEZdRDsZq3h8itQ1nkOZ9lTvhsrWLPUvNWd5dYKUAeqhfpU93SAKSYH2yQ
	QZjuZroTsaHD+WBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29DCE13A6E;
	Wed, 13 Nov 2024 09:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id If6bCZJ2NGcGFgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:51:14 +0000
Message-ID: <0aab195d-e342-459c-89ad-3809f1c3891f@suse.de>
Date: Wed, 13 Nov 2024 10:51:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] virtio: blk/scsi: replace blk_mq_virtio_map_queues
 with blk_mq_hctx_map_queues
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
 storagedev@microchip.com, linux-nvme@lists.infradead.org
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-7-573bfca0cbd8@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-7-573bfca0cbd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66B8D211D6
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_095117_722016_03D03988 
X-CRM114-Status: GOOD (  10.89  )
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

On 11/12/24 14:26, Daniel Wagner wrote:
> Replace all users of blk_mq_virtio_map_queues with the more generic
> blk_mq_hctx_map_queues. This in preparation to retire
> blk_mq_virtio_map_queues.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/block/virtio_blk.c | 4 ++--
>   drivers/scsi/virtio_scsi.c | 3 +--
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

