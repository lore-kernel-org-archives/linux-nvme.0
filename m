Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044D7C5478A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 15:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6c+PIWb1/kLk20NMKkb+j7MqFsNYlIIxImscXImM/9c=; b=gLA9OxC7gMgxN7lJ+Gmh9Np7nQ
	gvrrG8ZqjXWbX2lUrCJfNhi8TLNJIk0mbfGedgIJUgM1xtbUjrNiH9HqG5tG/5rluyJiOhayCShN2
	5x3fU/8aT59NCbkJl9riUoH06gJVruvbJBjiQxuWBrTbvKlAR6uHi1czBdjP8dN/EvJ0YQBd2pPjm
	MrNNuiz37Y2MHrBg/MKnNE/OJZ/P9GPFJC4wui0Xtoshr2h6oo+A7mqxrFMWb+Q27AnHdrRtM628w
	D4tk+KpAECaHrjrPZR0/Awe1RdjojZUygeD7Gua76yPpQVWdH6vhTbPoHDlUpFbU8f0Q3gnA4RA8D
	MHBzCJ+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcow4-00000001aM8-0rd7;
	Wed, 21 Feb 2024 15:55:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcovw-00000001aEy-2Wvg
	for linux-nvme@bombadil.infradead.org;
	Wed, 21 Feb 2024 15:54:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=6c+PIWb1/kLk20NMKkb+j7MqFsNYlIIxImscXImM/9c=; b=AYwqT+yDGXOV5Z3j51+9tLAodw
	LyIjCB+Fju6hZG9lUg0edK50h11f7m2oDaxRKuEFQ3PbqSUgs74Zc7zeltpVivq6ROtvw13H15s18
	x+XgG4Y1MDV17NNM/8FhskBDfFKlZsV2pbiR0N4hm/kZoAI8cBb6mYhiB+f9jG2xxmttAt4JRYeve
	9K+qdD2oNRielkiAApceY4bGLfe4SbC3O3Zj3alvsZwEffmj7oOqxXLsxHBVuYktM1Bc4lK/tCe2y
	ecuFNIIAYYpHOo1lIMpXgD+gtjCn//yvoEPX0WE5XX5vQ4mxeBe24p66c1R+0e4X9ebFP4GzT7Ku1
	zbpHfvwg==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcovt-00000002Cs4-1DpT
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 15:54:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A9F51FB66;
	Wed, 21 Feb 2024 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708530890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6c+PIWb1/kLk20NMKkb+j7MqFsNYlIIxImscXImM/9c=;
	b=XNtWvL40Iu08zXUOV+Sd+vmATzuaOVs9doAzk7GuDloLhRKMTXXVsR+xJSnBSWwUdPijyF
	Sng8zA0PuuVIBPF+5NvGOD+wqwOtw7P7Zi6vFLGToL9uYW3SGnE/8dlIOIFRbDBnk0IG6k
	pJ4ZIuSJ1yOR+ct+92djhpBiTJQHTrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708530890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6c+PIWb1/kLk20NMKkb+j7MqFsNYlIIxImscXImM/9c=;
	b=NhHE5x0CR69m3vLr7eJZgwAjcfuq2WnLoyfrltcZ1b07lYud/ZPEmbGXG3wSk71QLEMX2w
	kYtQulQM/YzpNfBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708530890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6c+PIWb1/kLk20NMKkb+j7MqFsNYlIIxImscXImM/9c=;
	b=XNtWvL40Iu08zXUOV+Sd+vmATzuaOVs9doAzk7GuDloLhRKMTXXVsR+xJSnBSWwUdPijyF
	Sng8zA0PuuVIBPF+5NvGOD+wqwOtw7P7Zi6vFLGToL9uYW3SGnE/8dlIOIFRbDBnk0IG6k
	pJ4ZIuSJ1yOR+ct+92djhpBiTJQHTrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708530890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6c+PIWb1/kLk20NMKkb+j7MqFsNYlIIxImscXImM/9c=;
	b=NhHE5x0CR69m3vLr7eJZgwAjcfuq2WnLoyfrltcZ1b07lYud/ZPEmbGXG3wSk71QLEMX2w
	kYtQulQM/YzpNfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CA2E13A69;
	Wed, 21 Feb 2024 15:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YByTCcgc1mWjFgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 Feb 2024 15:54:48 +0000
Message-ID: <95116d62-b254-4973-ad0e-01dc4dae7359@suse.de>
Date: Wed, 21 Feb 2024 16:54:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] nvme-fabrics: introduce ref counting for
 nvmf_ctrl_options
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-4-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240221132404.6311-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XNtWvL40;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NhHE5x0C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 4A9F51FB66
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_155453_426583_F069324A 
X-CRM114-Status: GOOD (  13.42  )
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

On 2/21/24 14:24, Daniel Wagner wrote:
> The FC transport is offloading the connect attempt to a workqueue. When
> the attempt fails the transport is starting to cleanup resources. It is
> possible for user space to trigger a crash because nvmf_ctrl_options are
> exposed to sysfs.
> 
> This crash wasn't observed with blktests nvme/041 until now because the
> retry loop was usually trying for several times (e.g. with defaults
> 600s) and the test would trigger the cleanup itself. Though we the
> recent change not retrying to use invalid credentials the crash can be
> easily triggered.
> 
> The simplest way to control the life time of nvmf_ctrl_options is by
> using ref counting.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fabrics.c | 22 +++++++++++++++++++---
>   drivers/nvme/host/fabrics.h |  6 +++++-
>   drivers/nvme/host/fc.c      | 14 +++++++++-----
>   drivers/nvme/host/rdma.c    | 18 +++++++++++++-----
>   drivers/nvme/host/tcp.c     | 21 ++++++++++++++-------
>   drivers/nvme/target/loop.c  | 19 +++++++++++++------
>   6 files changed, 73 insertions(+), 27 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


