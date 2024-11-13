Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4D9D41C2E
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 09:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eWkg1hOqi+ycsd64ANkNglK3giwDFCmogHKWtrMRowk=; b=4ciFM7DZKTwrgApHPbzI/fuQwC
	aE5DUe8R5XPzX481rDv9nlV0c1uSn+xOaH/3oumWnb9u9yboOSaoS0GkJskbDTax89x7qySPHLZWw
	5zdQtS8o+lJMmTFhEhem8pKWeUaWS430sXEH6iw11JHUeEBGe2So+xux2ZXVyU3GMjtGMsm1PLRMF
	Mf0J5r2CDz76yvjWl0KRPpKm0YQzt3BzrbeEMErQ32RBwjcWUZZ4zfWXkMAswpX+nI2K7LQrzFl8O
	nGqkfyzMcNiHDoEJYnHweqZv3vgLa1HKZR9iGJa4pHbp/AkMrGnRqPyyiVoCIE+QT2YqcFCzoQ5jD
	slFeoWQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBA4W-00000006Je1-2KTl;
	Wed, 13 Nov 2024 09:54:00 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tB9xk-00000006HUF-2iVp
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 09:47:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40C641F37C;
	Wed, 13 Nov 2024 09:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWkg1hOqi+ycsd64ANkNglK3giwDFCmogHKWtrMRowk=;
	b=buhMb819wZHU/8iqf/q4eAXXZ66+XnK0O9RtpFEbzsRnuZKFR/vQ9XNEHpi4PQ+SDjQYxh
	3omCBb0a5uhojNHRXGnAinSk560ZVg7A4pxDGXEPRUpkJxU3iirp+4ZByUaCA3ofpYFVNs
	+MFT4aXkNxijSPRa/QI2UwbMQBQAABk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWkg1hOqi+ycsd64ANkNglK3giwDFCmogHKWtrMRowk=;
	b=yDbbnAlyF2GKghvTsSyOgC73RfRuK0CmRznxsYAEyAh7MPWFuUpakA1CP7JMuTqVqtx8tI
	o3BlYDuKhMn48kDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWkg1hOqi+ycsd64ANkNglK3giwDFCmogHKWtrMRowk=;
	b=buhMb819wZHU/8iqf/q4eAXXZ66+XnK0O9RtpFEbzsRnuZKFR/vQ9XNEHpi4PQ+SDjQYxh
	3omCBb0a5uhojNHRXGnAinSk560ZVg7A4pxDGXEPRUpkJxU3iirp+4ZByUaCA3ofpYFVNs
	+MFT4aXkNxijSPRa/QI2UwbMQBQAABk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWkg1hOqi+ycsd64ANkNglK3giwDFCmogHKWtrMRowk=;
	b=yDbbnAlyF2GKghvTsSyOgC73RfRuK0CmRznxsYAEyAh7MPWFuUpakA1CP7JMuTqVqtx8tI
	o3BlYDuKhMn48kDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AE5C13A6E;
	Wed, 13 Nov 2024 09:46:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wZs+ApF1NGcpFAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:46:57 +0000
Message-ID: <d73f8c20-27c1-4c13-9be3-7f127f9f093d@suse.de>
Date: Wed, 13 Nov 2024 10:46:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] driver core: bus: add irq_get_affinity callback to
 bus_type
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
 <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
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
X-CRM114-CacheID: sfid-20241113_014700_858498_FBFA655F 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
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
> Introducing a callback in struct bus_type so that a subsystem
> can hook up the getters directly. This approach avoids exposing
> random getters in any subsystems APIs.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   include/linux/device/bus.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Han nes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

