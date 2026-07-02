Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59D2C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 06:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gXNwz3VhL6jsE20q/4md6gkPJPwSYXH0rOR0TX6wCZk=; b=Zi2v7T4uOm13Jsw9BaJll0FWAA
	p6YBUY9NDGN109hjSxQp5Kbkrezm5YAWxzBBepMp2LVJNASoh9XioPs7uskmAKAxl4gqlEO2twwCi
	h4bD//wAJ6hcsJz+oEWhiBFeTgfcE9Guat2UNvj4bkR+dRaaDoVUPPYSocJ/EulvPM2kPW4FIKYM4
	/MP310u1DF1qnUPhlkETRpli3UZ/kdbs8mZCEbTRTkN2YDHQ32tomQXUlBmULEFdUEZe+jJ+shQWc
	Lw7xZi3rsTlR61k7TxaVHsEhcpLj7jEKaHcH6tsE934SjO+n+j0XyNF7ASf/iHEqZt6xpy+P43KlQ
	YiF/BowA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfAxf-00000003eOC-3e5p;
	Thu, 02 Jul 2026 06:31:47 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfAxd-00000003eNq-0o2e
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 06:31:47 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9639758AA;
	Thu,  2 Jul 2026 06:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782973902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXNwz3VhL6jsE20q/4md6gkPJPwSYXH0rOR0TX6wCZk=;
	b=F35HCFjMGgCJiGexKVD0AkzXyB+w+FmYsI7TQGTro8z2hrQxSquqga5eLbHgZMnhN2WO5p
	HbvJgbPFP9uOnxed2iKNWDll2Wv6WKmiHihGSsYRO3x6QKUIqH2VwbTc27FSzAP9Y4EvFk
	5Quyq8OB4Kp05e6BzDHL56f29zbs/Yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782973902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXNwz3VhL6jsE20q/4md6gkPJPwSYXH0rOR0TX6wCZk=;
	b=HLbOgRs0Ok+wqDYZfGuhSdEYRwHrVccipDs5KuxzWfNIlN6Plvjqyg3LggBro11lP03BDL
	H1ObnMCdyUxhfmBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782973902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXNwz3VhL6jsE20q/4md6gkPJPwSYXH0rOR0TX6wCZk=;
	b=F35HCFjMGgCJiGexKVD0AkzXyB+w+FmYsI7TQGTro8z2hrQxSquqga5eLbHgZMnhN2WO5p
	HbvJgbPFP9uOnxed2iKNWDll2Wv6WKmiHihGSsYRO3x6QKUIqH2VwbTc27FSzAP9Y4EvFk
	5Quyq8OB4Kp05e6BzDHL56f29zbs/Yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782973902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXNwz3VhL6jsE20q/4md6gkPJPwSYXH0rOR0TX6wCZk=;
	b=HLbOgRs0Ok+wqDYZfGuhSdEYRwHrVccipDs5KuxzWfNIlN6Plvjqyg3LggBro11lP03BDL
	H1ObnMCdyUxhfmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45210779AA;
	Thu,  2 Jul 2026 06:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kvQGDs4FRmp5SAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 02 Jul 2026 06:31:42 +0000
Message-ID: <cd292576-e7f4-4ac3-8964-edb1bef05e78@suse.de>
Date: Thu, 2 Jul 2026 08:31:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme: add ABI documentation for host sysfs interfaces
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 John Garry <john.g.garry@oracle.com>, Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260702034845.3066876-1-kanie@linux.alibaba.com>
 <20260702034845.3066876-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260702034845.3066876-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,infradead.org:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_233145_573676_63132357 
X-CRM114-Status: GOOD (  28.32  )
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

On 7/2/26 5:48 AM, Guixin Liu wrote:
> Add Documentation/ABI/testing/sysfs-nvme documenting all NVMe host
> sysfs attributes, covering controller attributes under
> /sys/class/nvme/nvmeX/, namespace attributes under
> /sys/block/nvmeXnY/, and subsystem attributes under
> /sys/class/nvme-subsystem/nvme-subsysX/.
> 
> Each entry has been traced to its original introducing commit to
> provide accurate Date, KernelVersion, and Contact information.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   Documentation/ABI/testing/sysfs-nvme | 444 ++++++++++++++++++++++++++-
>   1 file changed, 434 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-nvme b/Documentation/ABI/testing/sysfs-nvme
> index 499d5f843cd4..079561601acd 100644
> --- a/Documentation/ABI/testing/sysfs-nvme
> +++ b/Documentation/ABI/testing/sysfs-nvme
> @@ -1,13 +1,437 @@
> -What:		/sys/devices/virtual/nvme-fabrics/ctl/.../tls_configured_key
> +What:		/sys/class/nvme/nvmeX/model
> +What:		/sys/class/nvme/nvmeX/serial
> +What:		/sys/class/nvme/nvmeX/firmware_rev
> +Date:		January 2016
> +KernelVersion:	4.5
> +Contact:	Keith Busch <kbusch@kernel.org>
> +Description:
> +		Shows the model, serial number, or firmware revision string
> +		of the NVMe controller, as reported in the Identify
> +		Controller data structure.
> +
> +What:		/sys/class/nvme/nvmeX/reset_controller
> +Date:		November 2015
> +KernelVersion:	4.5
> +Contact:	Christoph Hellwig <hch@lst.de>
> +Description:
> +		Write-only. Writing any value triggers a synchronous
> +		controller reset.
> +
> +What:		/sys/block/nvmeXnY/uuid
> +What:		/sys/block/nvmeXnY/eui
> +What:		/sys/block/nvmeXnY/nsid
> +Date:		December 2015
> +KernelVersion:	4.5
> +Contact:	Keith Busch <kbusch@kernel.org>
> +Description:
> +		Namespace identification attributes.
> +
> +		uuid: Shows the UUID for this namespace. Falls back to
> +		showing the NGUID for backward compatibility. Hidden if
> +		both are all zeros.
> +
> +		eui: Shows the IEEE Extended Unique Identifier (EUI-64).
> +		Hidden if all zeros.
> +
> +		nsid: Shows the namespace identifier (NSID).
> +
> +What:		/sys/class/nvme/nvmeX/cntlid
> +Date:		February 2016
> +KernelVersion:	4.6
> +Contact:	Ming Lin <ming.l@ssi.samsung.com>
> +Description:
> +		Shows the controller identifier assigned by the NVMe
> +		subsystem.
> +
> +What:		/sys/block/nvmeXnY/wwid
> +Date:		February 2016
> +KernelVersion:	4.6
> +Contact:	Keith Busch <kbusch@kernel.org>
> +Description:
> +		Shows the World Wide Identifier for this namespace. The
> +		format depends on available identifiers (in priority
> +		order): "uuid.{UUID}", "eui.{NGUID}", "eui.{EUI64}", or
> +		"nvme.{VID}-{SERIAL}-{MODEL}-{NSID}".
> +
> +What:		/sys/class/nvme/nvmeX/rescan_controller
> +Date:		April 2016
> +KernelVersion:	4.7
> +Contact:	Keith Busch <kbusch@kernel.org>
> +Description:
> +		Write-only. Writing any value triggers a namespace rescan
> +		on this controller.
> +
> +What:		/sys/class/nvme/nvmeX/transport
> +What:		/sys/class/nvme/nvmeX/subsysnqn
> +What:		/sys/class/nvme/nvmeX/address
> +What:		/sys/class/nvme/nvmeX/delete_controller
> +What:		/sys/class/nvme/nvmeX/reconnect_delay
> +What:		/sys/class/nvme/nvmeX/ctrl_loss_tmo
> +Date:		June 2016
> +KernelVersion:	4.8
> +Contact:	Ming Lin <ming.l@ssi.samsung.com>
> +Description:
> +		Fabrics controller attributes added with NVMe-oF support.
> +
> +		transport: Shows the transport type string. Possible values:
> +		"pcie", "tcp", "rdma", "fc", "loop".
> +
> +		subsysnqn: Shows the NVMe Qualified Name (NQN) of the
> +		subsystem this controller belongs to.
> +
> +		address: Shows the transport-specific address string. Only
> +		available for fabrics controllers.
> +
> +		delete_controller: Write-only. Triggers deletion of this
> +		fabrics controller.
> +
> +		reconnect_delay: Shows or sets the reconnect delay in
> +		seconds. Reading returns the delay value, or "off" if
> +		disabled.
> +
> +		ctrl_loss_tmo: Shows or sets the controller loss timeout in
> +		seconds. Reading returns the timeout value, or "off" if
> +		infinite reconnects are allowed. Writing a negative value
> +		disables the timeout.
> +
> +What:		/sys/class/nvme/nvmeX/cmb
> +Date:		October 2016
> +KernelVersion:	4.9
> +Contact:	Stephen Bates <sbates@raithlin.com>
> +Description:
> +		Shows the Controller Memory Buffer (CMB) register values
> +		in format "cmbloc : 0x%08x\ncmbsz  : 0x%08x\n". Only
> +		visible when the controller has a CMB (cmbsz != 0).
> +		PCI transport only.
> +
> +What:		/sys/class/nvme/nvmeX/state
> +Date:		November 2016
> +KernelVersion:	4.11
> +Contact:	Sagi Grimberg <sagi@grimberg.me>
> +Description:
> +		Shows the current state of the controller. Possible values:
> +		"new", "live", "resetting", "connecting", "deleting",
> +		"deleting (no IO)", "dead".
> +
> +What:		/sys/block/nvmeXnY/nguid
> +Date:		June 2017
> +KernelVersion:	4.13
> +Contact:	Johannes Thumshirn <jthumshirn@suse.de>
> +Description:
> +		Shows the Namespace Globally Unique Identifier (NGUID).
> +		Hidden if the NGUID is all zeros.
> +
> +What:		/sys/class/nvme-subsystem/nvme-subsysX/model
> +What:		/sys/class/nvme-subsystem/nvme-subsysX/serial
> +What:		/sys/class/nvme-subsystem/nvme-subsysX/firmware_rev
> +What:		/sys/class/nvme-subsystem/nvme-subsysX/subsysnqn
> +Date:		November 2017
> +KernelVersion:	4.15
> +Contact:	Hannes Reinecke <hare@suse.de>
> +Description:
> +		Shows the model, serial number, firmware revision, or NQN
> +		of the NVMe subsystem.
> +
> +What:		/sys/block/nvmeXnY/ana_grpid
> +What:		/sys/block/nvmeXnY/ana_state
> +Date:		May 2018
> +KernelVersion:	4.19
> +Contact:	Christoph Hellwig <hch@lst.de>
> +Description:
> +		ana_grpid: Shows the ANA Group ID for this per-path
> +		namespace device.
> +
> +		ana_state: Shows the ANA state. Possible values:
> +		"optimized", "non-optimized", "inaccessible",
> +		"persistent-loss", "change".
> +
> +		Only visible on per-path devices (not multipath head) when
> +		the controller supports ANA. Requires CONFIG_NVME_MULTIPATH.
> +
> +What:		/sys/class/nvme/nvmeX/numa_node
> +Date:		November 2018
> +KernelVersion:	5.0
> +Contact:	Hannes Reinecke <hare@suse.de>
> +Description:
> +		Shows the NUMA node the controller is attached to.
> +
> +What:		/sys/class/nvme-subsystem/nvme-subsysX/iopolicy
> +Date:		February 2019
> +KernelVersion:	5.1
> +Contact:	Hannes Reinecke <hare@suse.de>
> +Description:
> +		Shows or sets the multipath I/O path selection policy for
> +		this subsystem. Accepted values: "numa", "round-robin",
> +		"queue-depth". Changing the policy clears all current path
> +		selections. Only available when CONFIG_NVME_MULTIPATH is
> +		enabled.
> +
> +What:		/sys/class/nvme/nvmeX/queue_count
> +What:		/sys/class/nvme/nvmeX/sqsize
> +Date:		September 2019
> +KernelVersion:	5.4
> +Contact:	James Smart <jsmart2021@gmail.com>
> +Description:
> +		queue_count: Shows the total number of queues (admin + I/O)
> +		for this controller.
> +
> +		sqsize: Shows the submission queue size for this controller.
> +
> +What:		/sys/class/nvme/nvmeX/hostnqn
> +What:		/sys/class/nvme/nvmeX/hostid
> +Date:		February 2020
> +KernelVersion:	5.7
> +Contact:	Sagi Grimberg <sagi@grimberg.me>
> +Description:
> +		hostnqn: Shows the host NQN used by this fabrics controller.
> +
> +		hostid: Shows the host identifier (UUID format) used by this
> +		fabrics controller.
> +
> +		Only available for fabrics controllers.
> +
> +What:		/sys/class/nvme/nvmeX/fast_io_fail_tmo
> +Date:		November 2020
> +KernelVersion:	5.11
> +Contact:	Victor Gladkov <Victor.Gladkov@kioxia.com>
> +Description:
> +		Shows or sets the fast I/O fail timeout in seconds. Reading
> +		returns the timeout value, or "off" if disabled. Writing a
> +		negative value disables the fast I/O fail. Only available
> +		for fabrics controllers.
> +
> +What:		/sys/class/nvme/nvmeX/kato
> +Date:		April 2021
> +KernelVersion:	5.13
> +Contact:	Hannes Reinecke <hare@suse.de>
> +Description:
> +		Shows the Keep Alive Timeout value in milliseconds for
> +		this controller.
> +
> +What:		/sys/class/nvme/nvmeX/cmbloc
> +What:		/sys/class/nvme/nvmeX/cmbsz
> +What:		/sys/class/nvme/nvmeX/hmb
> +Date:		July 2021
> +KernelVersion:	5.15
> +Contact:	Keith Busch <kbusch@kernel.org>
> +Description:
> +		cmbloc: Shows the CMBLOC register value.
> +
> +		cmbsz: Shows the CMBSZ register value.
> +
> +		cmbloc and cmbsz are only visible when the controller has
> +		a CMB. PCI transport only.
> +
> +		hmb: Shows or sets whether the Host Memory Buffer (HMB) is
> +		enabled. Reading returns 1 (enabled) or 0 (disabled).
> +		Writing 1 enables HMB; writing 0 disables it. Only
> +		visible when the controller supports HMB (hmpre != 0).
> +		PCI transport only.
> +
> +What:		/sys/class/nvme-subsystem/nvme-subsysX/subsystype
> +Date:		September 2021
> +KernelVersion:	5.16
> +Contact:	Hannes Reinecke <hare@suse.de>
> +Description:
> +		Shows the subsystem type. Possible values: "discovery",
> +		"nvm", "reserved".
> +
> +What:		/sys/class/nvme/nvmeX/cntrltype
> +What:		/sys/class/nvme/nvmeX/dctype
> +Date:		February 2022
> +KernelVersion:	5.18
> +Contact:	Martin Belanger <martin.belanger@dell.com>
> +Description:
> +		cntrltype: Shows the controller type. Possible values: "io",
> +		"discovery", "admin", "reserved".
> +
> +		dctype: Shows the discovery controller type. Possible values:
> +		"none", "ddc", "cdc", "reserved".
> +
> +What:		/sys/class/nvme/nvmeX/dhchap_secret
> +What:		/sys/class/nvme/nvmeX/dhchap_ctrl_secret
> +Date:		June 2022
> +KernelVersion:	6.0
> +Contact:	Hannes Reinecke <hare@suse.de>
> +Description:
> +		dhchap_secret: Shows or sets the host DH-HMAC-CHAP secret
> +		for this controller. Reading returns "none" if not set.
> +		Writing must use the "DHHC-1:" key format and triggers
> +		re-authentication.
> +
> +		dhchap_ctrl_secret: Shows or sets the controller
> +		DH-HMAC-CHAP secret for bidirectional authentication.
> +		Same format as dhchap_secret.
> +
> +		Only available when CONFIG_NVME_HOST_AUTH is enabled and
> +		for fabrics controllers.
> +
> +What:		/sys/class/nvme/nvmeX/tls_key
> +Date:		August 2023
> +KernelVersion:	6.7
> +Contact:	Hannes Reinecke <hare@suse.de>
> +Description:
> +		Shows the serial of the currently active TLS PSK as hex.
> +		Returns empty if no TLS key is active. Only available for
> +		TCP controllers with TLS or secure concatenation enabled
> +		(CONFIG_NVME_TCP_TLS).
> +

Can you keep the TLS attributes together?
That way it's easier to figure out which attributes one need to look at
when checking the TLS status.

> +What:		/sys/class/nvme/nvmeX/passthru_err_log_enabled
> +What:		/sys/block/nvmeXnY/passthru_err_log_enabled
> +Date:		January 2024
> +KernelVersion:	6.8
> +Contact:	Alan Adamson <alan.adamson@oracle.com>
> +Description:
> +		Shows or sets whether passthrough error logging is enabled.
> +		Reading returns "on" or "off". Writing accepts a boolean
> +		value. The controller-level attribute controls admin
> +		passthrough logging; the namespace-level attribute controls
> +		I/O passthrough logging.
> +
> +What:		/sys/block/nvmeXnY/csi
> +What:		/sys/block/nvmeXnY/metadata_bytes
> +What:		/sys/block/nvmeXnY/nuse
> +Date:		December 2023
> +KernelVersion:	6.8
> +Contact:	Daniel Wagner <dwagner@suse.de>
> +Description:
> +		csi: Shows the Command Set Identifier for this namespace.
> +
> +		metadata_bytes: Shows the metadata size in bytes.
> +
> +		nuse: Shows the Namespace Utilization (NUSE) value. Reading
> +		triggers an Identify Namespace command to refresh the
> +		value (rate-limited to avoid excessive commands).
> +
> +What:		/sys/block/nvmeXnY/queue_depth
> +Date:		June 2024
> +KernelVersion:	6.11
> +Contact:	Thomas Song <tsong@purestorage.com>
> +Description:
> +		Shows the current active I/O count on this path's
> +		controller. Returns empty if iopolicy is not "queue-depth".
> +		Only visible on per-path devices.
> +		Requires CONFIG_NVME_MULTIPATH.
> +
> +What:		/sys/class/nvme/nvmeX/tls_configured_key
> +Date:		July 2024
> +KernelVersion:	6.12
> +Contact:	Hannes Reinecke <hare@kernel.org>
> +Description:
> +		Shows the serial of the configured TLS key. Writing 0
> +		triggers a PSK reauthentication (REPLACETLSPSK) with
> +		the target. After reauthentication the returned serial
> +		will be the new key. Only available for TCP controllers
> +		with secure concatenation enabled (CONFIG_NVME_TCP_TLS).
> +
> +What:		/sys/class/nvme/nvmeX/tls_keyring
> +Date:		July 2024
> +KernelVersion:	6.12
> +Contact:	Hannes Reinecke <hare@kernel.org>
> +Description:
> +		Shows the TLS keyring description. Only available for TCP
> +		controllers with a keyring configured (CONFIG_NVME_TCP_TLS).
> +
> +What:		/sys/block/nvmeXnY/numa_nodes
> +Date:		January 2025
> +KernelVersion:	6.15
> +Contact:	Nilay Shroff <nilay@linux.ibm.com>
> +Description:
> +		Shows the NUMA node mask for which this path is the
> +		currently selected path. Returns empty if iopolicy is not
> +		"numa". Only visible on per-path devices.
> +		Requires CONFIG_NVME_MULTIPATH.
> +
> +What:		/sys/block/nvmeXnY/delayed_removal_secs
> +Date:		May 2025
> +KernelVersion:	6.16
> +Contact:	Nilay Shroff <nilay@linux.ibm.com>
> +Description:
> +		Shows or sets the delayed removal timeout in seconds for
> +		the multipath head device. When nonzero, I/O is queued
> +		instead of failed when all paths are gone, and head removal
> +		is deferred. Only visible on multipath head devices.
> +		Requires CONFIG_NVME_MULTIPATH.
> +
> +What:		/sys/class/nvme/nvmeX/quirks
>   Date:		November 2025
> -KernelVersion:	6.19
> -Contact:	Linux NVMe mailing list <linux-nvme@lists.infradead.org>
> +KernelVersion:	7.0
> +Contact:	Maurizio Lombardi <mlombard@redhat.com>
>   Description:
> -		The file is avaliable when using a secure concatanation
> -		connection to a NVMe target. Reading the file will return
> -		the serial of the currently negotiated key.
> +		Shows the active quirk names for this controller, one per
> +		line. Shows "none" if no quirks are active.
> +
> +What:		/sys/class/nvme/nvmeX/tls_mode
> +Date:		April 2026
> +KernelVersion:	7.1
> +Contact:	Daniel Wagner <wagi@kernel.org>
> +Description:
> +		Shows the TLS mode: "tls" for direct TLS or "concat" for
> +		secure concatenation. Only available for TCP controllers
> +		with TLS or secure concatenation enabled
> +		(CONFIG_NVME_TCP_TLS).
> +
> +What:		/sys/class/nvme/nvmeX/admin_timeout
> +What:		/sys/class/nvme/nvmeX/io_timeout
> +Date:		May 2026
> +KernelVersion:	7.2
> +Contact:	Maurizio Lombardi <mlombard@redhat.com>
> +Description:
> +		admin_timeout: Shows or sets the admin command timeout in
> +		milliseconds.
> +
> +		io_timeout: Shows or sets the I/O command timeout in
> +		milliseconds. Changes are propagated to all namespace
> +		request queues.
> +
> +		The value must be nonzero. Only writable after the
> +		controller has been started at least once.
> +
> +What:		/sys/class/nvme/nvmeX/diag/command_error_count
> +What:		/sys/class/nvme/nvmeX/diag/reset_count
> +What:		/sys/class/nvme/nvmeX/diag/reconnect_count
> +Date:		May 2026
> +KernelVersion:	7.2
> +Contact:	Nilay Shroff <nilay@linux.ibm.com>
> +Description:
> +		Controller diagnostic counters.
> +
> +		command_error_count: Admin command error counter.
> +
> +		reset_count: Controller reset counter.
> +
> +		reconnect_count: Accumulated reconnect counter. Only
> +		available for fabrics controllers.
> +
> +		All counters can be reset by writing a value.
> +
> +What:		/sys/block/nvmeXnY/diag/command_retries_count
> +What:		/sys/block/nvmeXnY/diag/command_error_count
> +What:		/sys/block/nvmeXnY/diag/multipath_failover_count
> +What:		/sys/block/nvmeXnY/diag/io_requeue_no_usable_path_count
> +What:		/sys/block/nvmeXnY/diag/io_fail_no_available_path_count
> +Date:		May 2026
> +KernelVersion:	7.2
> +Contact:	Nilay Shroff <nilay@linux.ibm.com>
> +Description:
> +		Namespace diagnostic counters.
> +
> +		command_retries_count: I/O command retry counter. Only
> +		visible on per-path devices.
> +
> +		command_error_count: I/O command error counter. Only
> +		visible on per-path devices.
> +
> +		multipath_failover_count: Multipath failover counter.
> +		Only visible on per-path devices. Requires
> +		CONFIG_NVME_MULTIPATH.
> +
> +		io_requeue_no_usable_path_count: Counter of I/Os requeued
> +		because no usable path was available. Only visible on
> +		multipath head devices. Requires CONFIG_NVME_MULTIPATH.
> +
> +		io_fail_no_available_path_count: Counter of I/Os failed
> +		because no available path existed. Only visible on
> +		multipath head devices. Requires CONFIG_NVME_MULTIPATH.
>   
> -		Writing 0 to the file will trigger a PSK reauthentication
> -		(REPLACETLSPSK) with the target. After a reauthentication
> -		the value returned by tls_configured_key will be the new
> -		serial.
> +		All counters can be reset by writing a value.

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

