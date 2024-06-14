Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEBBC27C6E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 09:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sw2fNRP/DccR3qQpYgM3stbZif9fd5Iy9BM1VEtS8Vg=; b=Mhi/yokwP2TqWHqqVDhQc7E4vs
	zFKyldHTZjpW5vSZS1uy9SCXgNUkbRJvCuTrxFoR9GBiOMOxnfVyQtxxSTNToBjF+MCF+gXhf1bz4
	kv6V6BvmH+4sdDDiy5A8niKRVths4/RLjLjuEXeKlr5kud9JioPCVSILrp5LZvjJ5jTdv4kgg6Ecl
	WmSsVHgnCheOLWrvjMeFQJZU8QIjnot2593v5DIBzqw3hlsFixbkHKaTM7Kszmg2T05aeLFFiInA0
	qECtH66mpfXA4zfh4piqdFlKLv6eRruBI4fIyy5QuzvJWjPIJ2UJz9xTxVHN6clcrHyilGa887ChL
	wKS/z66w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI3ad-00000002Hm4-2cmi;
	Fri, 14 Jun 2024 09:51:23 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI3aX-00000002Hkp-0L9D
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 09:51:20 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34C18202D9;
	Fri, 14 Jun 2024 09:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718358675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sw2fNRP/DccR3qQpYgM3stbZif9fd5Iy9BM1VEtS8Vg=;
	b=st5mclWGOXphBlHXup425JkYIN3wGQEwqCIotbJB6mJVKMt7bPKn7q3FSO3M//AwfAfxCK
	m2pF5u5zbjVQSHZv/PmbVPMfwM95fPVJfzC64DPVwcESP4gB2wiARP+0kw4JAc7V7ZVcQ0
	dpyjK4ielmavfXjz/JcA+MsdRun2QiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718358675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sw2fNRP/DccR3qQpYgM3stbZif9fd5Iy9BM1VEtS8Vg=;
	b=pdW87n/4hh/3Oq5pQ9MDVUoL4hDsRDUeswup8+7MBnSBKrbo4mbZ7eVNjyBQVSdZYhDWc6
	kvRSS/SfKO1XNFAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718358675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sw2fNRP/DccR3qQpYgM3stbZif9fd5Iy9BM1VEtS8Vg=;
	b=st5mclWGOXphBlHXup425JkYIN3wGQEwqCIotbJB6mJVKMt7bPKn7q3FSO3M//AwfAfxCK
	m2pF5u5zbjVQSHZv/PmbVPMfwM95fPVJfzC64DPVwcESP4gB2wiARP+0kw4JAc7V7ZVcQ0
	dpyjK4ielmavfXjz/JcA+MsdRun2QiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718358675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sw2fNRP/DccR3qQpYgM3stbZif9fd5Iy9BM1VEtS8Vg=;
	b=pdW87n/4hh/3Oq5pQ9MDVUoL4hDsRDUeswup8+7MBnSBKrbo4mbZ7eVNjyBQVSdZYhDWc6
	kvRSS/SfKO1XNFAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1CEA13AB1;
	Fri, 14 Jun 2024 09:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u32WNZISbGZwewAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 14 Jun 2024 09:51:14 +0000
Message-ID: <72d9ab72-8b19-455e-a1db-d2bca9754bbf@suse.de>
Date: Fri, 14 Jun 2024 11:51:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme-pci : Fix EEH failure on ppc after subsystem
 reset
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 gjoyce@linux.ibm.com, axboe@fb.com
References: <20240604091523.1422027-1-nilay@linux.ibm.com>
 <20240604091523.1422027-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240604091523.1422027-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_025117_298729_8B8BCD31 
X-CRM114-Status: GOOD (  18.33  )
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

On 6/4/24 11:10, Nilay Shroff wrote:
> The NVMe subsystem reset command when executed may cause the loss of
> the NVMe adapter communication with kernel. And the only way today
> to recover the adapter is to either re-enumerate the pci bus or
> hotplug NVMe disk or reboot OS.
> 
> The PPC architecture supports mechanism called EEH (enhanced error
> handling) which allows pci bus errors to be cleared and a pci card to
> be rebooted, without having to physically hotplug NVMe disk or reboot
> the OS.
> 
> In the current implementation when user executes the nvme subsystem
> reset command and if kernel loses the communication with NVMe adapter
> then subsequent read/write to the PCIe config space of the device
> would fail. Failing to read/write to PCI config space makes NVMe
> driver assume the permanent loss of communication with the device and
> so driver marks the NVMe controller dead and frees all resources
> associate to that controller. As the NVMe controller goes dead, the
> EEH recovery can't succeed.
> 
> This patch helps fix this issue so that after user executes subsystem
> reset command if the communication with the NVMe adapter is lost and
> EEH recovery is initiated then we allow the EEH recovery to forward
> progress and gives the EEH thread a fair chance to recover the
> adapter. If in case, the EEH thread couldn't recover the adapter
> communication then it sets the pci channel state of the erring
> adapter to "permanent failure" and removes the device.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c |  1 +
>   drivers/nvme/host/pci.c  | 21 ++++++++++++++++++---
>   2 files changed, 19 insertions(+), 3 deletions(-)
> 
Looks odd, but I cannot see a better way out here.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


