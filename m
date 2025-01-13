Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66927C02180
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=91kDelur4WqGfot8h8Bb/yfsWEL+BEZol58zLd4Y/Ik=; b=kG3Y6lvE8hWQ6m7u0b5H5MOu+r
	8+O7hhbE4yGXE8lZFNtaDGfpppJF/WqKYXaMHi3W6xFqnWKVxzKkh294w/qxklzdPSCzeRItfp22X
	1XsY/hnSgGb/vdUTvZNSQ3/pO52HV6FgMBiTGpJZAZgLJUGU8Sx0GxURXXlWWWzO3VQQauBvviV4L
	JgFcL+rvMlsrmzG4V9MYD7UDwfEq5hl8Qvfi/KpQ++j5gjWU6DrxL7Vy14yPL20NCHlleczOUVQpI
	KPWiLCf4HBUDKXrNSQb6RZfiLTWV0m8dDE/LEWDpniatpqoS88aX7ATiCH3ykNAoIE3q2snX1daCx
	w/DS16SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXHmM-00000004nmL-18UV;
	Mon, 13 Jan 2025 10:34:42 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXHmJ-00000004nky-3w8T
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 10:34:41 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2EA351F381;
	Mon, 13 Jan 2025 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736764478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91kDelur4WqGfot8h8Bb/yfsWEL+BEZol58zLd4Y/Ik=;
	b=J7AAUE2WxYM/XNvsI2gI+gJaZpaRDLWIeYgVG98iUiPYzIQjP7CjMrxJoO6u4OIi8pdDpS
	iIz2td9NVrTAiqT0Nquzd1h59mjHGhnykqKE4mN+hID4QxYdbETPEA97uKFXCJkBG+m5Ts
	shZU0Gnq4NaK/Z2I/F1bamB2brk6uCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736764478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91kDelur4WqGfot8h8Bb/yfsWEL+BEZol58zLd4Y/Ik=;
	b=2BQC3pwUjfuOnZ0UW4wMytNR+0ixjkyuE7cDhesrgstafC19IYOlb81WWHv59p6e5H9EOW
	jSEZ3XL1uITJERDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736764478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91kDelur4WqGfot8h8Bb/yfsWEL+BEZol58zLd4Y/Ik=;
	b=J7AAUE2WxYM/XNvsI2gI+gJaZpaRDLWIeYgVG98iUiPYzIQjP7CjMrxJoO6u4OIi8pdDpS
	iIz2td9NVrTAiqT0Nquzd1h59mjHGhnykqKE4mN+hID4QxYdbETPEA97uKFXCJkBG+m5Ts
	shZU0Gnq4NaK/Z2I/F1bamB2brk6uCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736764478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91kDelur4WqGfot8h8Bb/yfsWEL+BEZol58zLd4Y/Ik=;
	b=2BQC3pwUjfuOnZ0UW4wMytNR+0ixjkyuE7cDhesrgstafC19IYOlb81WWHv59p6e5H9EOW
	jSEZ3XL1uITJERDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13D7F13876;
	Mon, 13 Jan 2025 10:34:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WR40BD7shGc6bAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jan 2025 10:34:38 +0000
Message-ID: <8b203c3d-4c44-48dd-92cf-84e36d6d3502@suse.de>
Date: Mon, 13 Jan 2025 11:34:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 RFC 1/3] nvme-multipath: Add visibility for round-robin
 io-policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, dwagner@suse.de,
 chaitanyak@nvidia.com, axboe@fb.com, gjoyce@linux.ibm.com
References: <20250112124154.60690-1-nilay@linux.ibm.com>
 <20250112124154.60690-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250112124154.60690-2-nilay@linux.ibm.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_023440_121818_1290A14C 
X-CRM114-Status: GOOD (  13.11  )
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
> This patch helps add nvme native multipath visibility for round-robin
> io-policy. It creates a "multipath" sysfs directory under head gendisk
> device node directory and then from "multipath" directory it adds a link
> to each namespace path device the head node refers.
> 
> For instance, if we have a shared namespace accessible from two different
> controllers/paths then we create a soft link to each path device from head
> disk node as shown below:
> 
> $ ls -l /sys/block/nvme1n1/multipath/
> nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
> nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
> 
> In the above example, nvme1n1 is head gendisk node created for a shared
> namespace and the namespace is accessible from nvme1c1n1 and nvme1c3n1
> paths.
> 
> For round-robin I/O policy, we could easily infer from the above output
> that I/O workload targeted to nvme1n1 would toggle across paths nvme1c1n1
> and nvme1c3n1.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      |  3 ++
>   drivers/nvme/host/multipath.c | 99 +++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      | 18 +++++--
>   drivers/nvme/host/sysfs.c     | 14 +++++
>   4 files changed, 130 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

