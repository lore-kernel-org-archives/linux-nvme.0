Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6156FC3DA4A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=STZQ8x0gSAX9WjIt5SVFokSpCJQ8PbOmFgE/9PLLIhE=; b=sIBdfTxD25f0hfbmPFKaisYeBa
	ECvCJ4hKNX3ThfXZ9vRmzczZi1gw3AWQDo1wgD9ZJGlu7TAlCCZsu1iF/JB54ynOzqkmKu87OzJdK
	r8aVFFyM/jA5Dl1Jo2Oakp9EGeWqDQ1XU9or4//6/J9grIq/IyRfBIXlZkxja19j2Jy4qnx4tKH7+
	E05cM4YIeMvbQ/CX2VdVFFEOhgotcBpfIxKf1OA6Z2SIV8+n8Rj6NcMQbTvwEEdTXeyXQ845zpgjY
	COv97uJZzEUb0KhNoRBDIWz0QANmvcASW2hb7VVMvLLyKyz8RECXhvWs8i49qANuiEwvBvFBujnh+
	2lVLf6ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFGBm-0000000FuIl-4ATi;
	Wed, 14 May 2025 17:46:43 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFEiK-0000000Fho8-2MFH
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 16:12:13 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 32D5A1F385;
	Wed, 14 May 2025 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747239129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=STZQ8x0gSAX9WjIt5SVFokSpCJQ8PbOmFgE/9PLLIhE=;
	b=EJmOGm9PKixSH0pBR91qRqXYKq8qKdFnS6nqlcRpChmGnbpdfRKJgQdCHpXH9MTlBc9Vjn
	GOfCAMklY65GzKhDbBpgJwKm/30lDEGJQ4j8j/e7pH5Zq4y5Wjy8NSad4HsAFEpfcOBdEv
	ySZwBtHVBedzbw31oMKEZ6nZ8UZo130=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747239129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=STZQ8x0gSAX9WjIt5SVFokSpCJQ8PbOmFgE/9PLLIhE=;
	b=lZHtHWmK8s/xncFAvTbbHnL0HfsbqcJjLsrOs2UFu20Hk0aX881NBzWxAesZ590ueFCLn5
	3CoWIMsnzTcSf2BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747239129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=STZQ8x0gSAX9WjIt5SVFokSpCJQ8PbOmFgE/9PLLIhE=;
	b=EJmOGm9PKixSH0pBR91qRqXYKq8qKdFnS6nqlcRpChmGnbpdfRKJgQdCHpXH9MTlBc9Vjn
	GOfCAMklY65GzKhDbBpgJwKm/30lDEGJQ4j8j/e7pH5Zq4y5Wjy8NSad4HsAFEpfcOBdEv
	ySZwBtHVBedzbw31oMKEZ6nZ8UZo130=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747239129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=STZQ8x0gSAX9WjIt5SVFokSpCJQ8PbOmFgE/9PLLIhE=;
	b=lZHtHWmK8s/xncFAvTbbHnL0HfsbqcJjLsrOs2UFu20Hk0aX881NBzWxAesZ590ueFCLn5
	3CoWIMsnzTcSf2BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BC6F13306;
	Wed, 14 May 2025 16:12:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g0F1AtnAJGhgNwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 May 2025 16:12:09 +0000
Date: Wed, 14 May 2025 18:12:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Costa Shulyupin <costa.shul@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Waiman Long <llong@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	storagedev@microchip.com, virtualization@lists.linux.dev, 
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v6 3/9] nvme-pci: use block layer helpers to calculate
 num of queues
Message-ID: <66cd13b0-3339-4495-8d1a-fae3211f92b9@flourine.local>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
 <20250424-isolcpus-io-queues-v6-3-9a53a870ca1f@kernel.org>
 <aB1eswAv6Tz2WDpc@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB1eswAv6Tz2WDpc@fedora>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
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
X-CRM114-CacheID: sfid-20250514_091212_747946_81823446 
X-CRM114-Status: GOOD (  18.23  )
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

On Fri, May 09, 2025 at 09:47:31AM +0800, Ming Lei wrote:
> On Thu, Apr 24, 2025 at 08:19:42PM +0200, Daniel Wagner wrote:
> > Multiqueue devices should only allocate queues for the housekeeping CPUs
> > when isolcpus=io_queue is set. This avoids that the isolated CPUs get
> > disturbed with OS workload.
> 
> The commit log needs to be updated:
> 
> - io_queue isn't introduced yet
> 
> - this patch can only reduce nr_hw_queues, and queue mapping isn't changed
> yet, so nothing to do with
> 
>  "This avoids that the isolated CPUs get disturbed with OS workload"

What about:

  The calculation of the upper limit for queues does not depend solely on
  the number of possible CPUs; for example, the isolcpus kernel
  command-line option must also be considered.

  To account for this, the block layer provides a helper function to
  retrieve the maximum number of queues. Use it to set an appropriate
  upper queue number limit.

I would use this version for the other patches as well,
s/possible/online/ where necessary.

