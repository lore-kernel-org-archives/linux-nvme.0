Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9458FC43602
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 06:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S8Xo43076kMZsW09J5W0IGBb+4nOB9Df7aTl4rMD+M0=; b=lk78EnNicK7bxAYwShyjhy9z8A
	gSXdmOmXg62j0894IUqWetxy9GAHC7yMdQjUVACoxKLGrhMDKU3uUzfxJU30eeEvWP0hSZko1O89f
	PgoT6qlbJ1ymwu4mimINTFigBJSNlmulprNwTnz47d1rcdHlkNom/8cyt4dlyXNzM046QeBszjfjY
	8LVNq7/QzZHvAdmbPDO6W6KtIvj8LonC4j0VKjKWru4G36QSElm3lXVatlSNf7gIxvVB3X7abz+J3
	v4yTfihF+MR+pfV06SilhU4GqA/BkddsIi2gKRKSm9VY1OGeJxClImdAgXqp+38IrPVZgp0X+IlFb
	BWVXvEMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfB1W-00000003f1B-1EJZ;
	Thu, 02 Jul 2026 06:35:46 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfB1T-00000003ezE-3391
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 06:35:45 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC86372B3D;
	Thu,  2 Jul 2026 06:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782974141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8Xo43076kMZsW09J5W0IGBb+4nOB9Df7aTl4rMD+M0=;
	b=0iG0w/AS8j2561sJgXqnMZrf75JW7tnbLu/EeBliT1hURy2UiyZQtbR/WrYK5MT8SKkCuE
	yE0WRG2Gys5Pa4B+/8T9+0ybdx1R8VATXPnM4/0E6FBvrfoOY3ANka5HqtRgpaacZJhlJl
	D1bRqP5zM7ojda3mJKQmZ1K4q3Df7so=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782974141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8Xo43076kMZsW09J5W0IGBb+4nOB9Df7aTl4rMD+M0=;
	b=2u1kW7I0jsmmF0G7rz5l3ZMsWp/6Jsx4y57xwH7QTO8c/CwNkwtxDTFwZvcKN1usx693NH
	K2QZaORV9FZ+1dBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782974140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8Xo43076kMZsW09J5W0IGBb+4nOB9Df7aTl4rMD+M0=;
	b=xCDUdTyfvqv93rg9kLxQLshQcbuh/gOiOvZMOZLKnSVLcSx5nbubrKZhffD4dEEPEwaU30
	ww0T2xk9a6CM4lyJT0LQXa5PsmNERTj+XekJ5/zT+Yc/qVBp10OUdOxsiKj/Nn7+mAxBXZ
	Cqo7u39rDMEkEv5xahY18xC19YL6EUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782974140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8Xo43076kMZsW09J5W0IGBb+4nOB9Df7aTl4rMD+M0=;
	b=ZcHwSDDbD/t4bQrzvOSF6N+eKLa0JFEp1naMNBhjQMveqfakw1JQExMQZprIY9zehmDFjF
	EU0AjkwoAvPEJIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B687779AA;
	Thu,  2 Jul 2026 06:35:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AUSGHLwGRmoaTAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 02 Jul 2026 06:35:40 +0000
Message-ID: <8c320767-8d3d-418a-80fc-55e5d342b6e5@suse.de>
Date: Thu, 2 Jul 2026 08:35:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvmet: add ABI documentation for target configfs
 interfaces
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 John Garry <john.g.garry@oracle.com>, Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260702034845.3066876-1-kanie@linux.alibaba.com>
 <20260702034845.3066876-3-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260702034845.3066876-3-kanie@linux.alibaba.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,alibaba.com:email,oracle.com:email,nvidia.com:email,lst.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_233544_070535_A8F28F68 
X-CRM114-Status: GOOD (  30.30  )
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
> Add Documentation/ABI/testing/configfs-nvmet documenting all NVMe
> target configfs attributes, covering port attributes, subsystem
> attributes, namespace attributes, host authentication, passthrough
> mode, and ANA configuration.
> 
> Each entry has been traced to its original introducing commit to
> provide accurate Date, KernelVersion, and Contact information.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   Documentation/ABI/testing/configfs-nvmet | 347 +++++++++++++++++++++++
>   1 file changed, 347 insertions(+)
>   create mode 100644 Documentation/ABI/testing/configfs-nvmet
> 
> diff --git a/Documentation/ABI/testing/configfs-nvmet b/Documentation/ABI/testing/configfs-nvmet
> new file mode 100644
> index 000000000000..728c905310c5
> --- /dev/null
> +++ b/Documentation/ABI/testing/configfs-nvmet
> @@ -0,0 +1,347 @@
> +What:		/config/nvmet/ports/N/addr_adrfam
> +What:		/config/nvmet/ports/N/addr_portid
> +What:		/config/nvmet/ports/N/addr_traddr
> +What:		/config/nvmet/ports/N/addr_trsvcid
> +What:		/config/nvmet/ports/N/addr_trtype
> +What:		/config/nvmet/ports/N/addr_treq
> +Date:		June 2016
> +KernelVersion:	4.8
> +Contact:	Christoph Hellwig <hch@lst.de>
> +Description:
> +		Address attributes for an NVMe-oF target port.
> +
> +		addr_adrfam: Shows or sets the address family. Accepted
> +		values: "pcie", "ipv4", "ipv6", "ib", "fc", "pci", "loop".
> +
> +		addr_portid: Shows or sets the port identifier (u16).
> +
> +		addr_traddr: Shows or sets the transport address string.
> +
> +		addr_trsvcid: Shows or sets the transport service identifier.
> +
> +		addr_trtype: Shows or sets the transport type. Accepted
> +		values: "rdma", "fc", "tcp", "pci", "loop". Also
> +		initializes default TSAS values.
> +
> +		addr_treq: Shows or sets the transport security requirements.
> +		Accepted values: "not specified", "required",
> +		"not required". For TCP with TLS1.3, "not specified" is
> +		rejected.
> +
> +		All attributes require the port to be disabled before
> +		modification.
> +
> +What:		/config/nvmet/ports/N/referrals/NAME/addr_adrfam
> +What:		/config/nvmet/ports/N/referrals/NAME/addr_portid
> +What:		/config/nvmet/ports/N/referrals/NAME/addr_traddr
> +What:		/config/nvmet/ports/N/referrals/NAME/addr_trsvcid
> +What:		/config/nvmet/ports/N/referrals/NAME/addr_trtype
> +What:		/config/nvmet/ports/N/referrals/NAME/addr_treq
> +What:		/config/nvmet/ports/N/referrals/NAME/enable
> +Date:		June 2016
> +KernelVersion:	4.8
> +Contact:	Christoph Hellwig <hch@lst.de>
> +Description:
> +		Address attributes and enable control for a referral entry
> +		under a port. The addr_* attributes have the same semantics
> +		as the corresponding port-level attributes. The enable
> +		attribute shows or sets whether this referral is enabled
> +		(boolean).
> +
> +What:		/config/nvmet/subsystems/NAME/attr_allow_any_host
> +Date:		June 2016
> +KernelVersion:	4.8
> +Contact:	Christoph Hellwig <hch@lst.de>
> +Description:
> +		Shows or sets whether any host is allowed to connect.
> +		Accepts boolean value. Cannot be set to 1 if explicit
> +		hosts are linked in the allowed_hosts/ directory.
> +
> +What:		/config/nvmet/subsystems/NAME/namespaces/NSID/device_path
> +What:		/config/nvmet/subsystems/NAME/namespaces/NSID/device_nguid
> +What:		/config/nvmet/subsystems/NAME/namespaces/NSID/enable
> +Date:		June 2016
> +KernelVersion:	4.8
> +Contact:	Christoph Hellwig <hch@lst.de>
> +Description:
> +		Namespace attributes added with the initial NVMe target.
> +
> +		device_path: Shows or sets the backend block device path.
> +		The namespace must be disabled before modification.
> +
> +		device_nguid: Shows or sets the NGUID (128-bit identifier).
> +		Accepts 32 hex digits with optional "-" or ":" separators.
> +		The namespace must be disabled before modification.
> +
> +		enable: Shows or sets whether this namespace is enabled
> +		(boolean).
> +
> +What:		/config/nvmet/subsystems/NAME/namespaces/NSID/device_uuid
> +Date:		June 2017
> +KernelVersion:	4.13
> +Contact:	Johannes Thumshirn <jthumshirn@suse.de>
> +Description:
> +		Shows or sets the UUID for this namespace. The namespace
> +		must be disabled before modification.
> +
> +What:		/config/nvmet/subsystems/NAME/attr_version
> +What:		/config/nvmet/subsystems/NAME/attr_serial
> +Date:		July 2017
> +KernelVersion:	4.13
> +Contact:	Johannes Thumshirn <jthumshirn@suse.de>
> +Description:
> +		attr_version: Shows or sets the NVMe version reported by
> +		this subsystem. Format: "major.minor" or
> +		"major.minor.tertiary". Cannot be changed after the
> +		subsystem has been discovered.
> +
> +		attr_serial: Shows or sets the serial number. Must be a
> +		1-20 byte ASCII string (characters 0x20-0x7e). Cannot be
> +		changed after the subsystem has been discovered.
> +
> +What:		/config/nvmet/ports/N/ana_groups/ID/ana_state
> +What:		/config/nvmet/subsystems/NAME/namespaces/NSID/ana_grpid
> +Date:		June 2018
> +KernelVersion:	4.19
> +Contact:	Christoph Hellwig <hch@lst.de>
> +Description:
> +		ANA (Asymmetric Namespace Access) attributes.
> +
> +		ana_state: Shows or sets the ANA state for this group on
> +		this port. Accepted values: "optimized", "non-optimized",
> +		"inaccessible", "persistent-loss", "change". Changes
> +		trigger an ANA change event.
> +
> +		ana_grpid: Shows or sets the ANA Group ID for this
> +		namespace. Must be between 1 and 128. Changing triggers
> +		an ANA event notification.
> +
> +What:		/config/nvmet/ports/N/param_inline_data_size
> +Date:		June 2018
> +KernelVersion:	4.19
> +Contact:	Steve Wise <swise@opengridcomputing.com>
> +Description:
> +		Shows or sets the inline data size for this port. Default
> +		is -1 which lets the transport choose. The port must be
> +		disabled before modification.
> +
> +What:		/config/nvmet/subsystems/NAME/namespaces/NSID/buffered_io
> +Date:		June 2018
> +KernelVersion:	4.19
> +Contact:	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> +Description:
> +		Shows or sets whether buffered I/O is used for this
> +		namespace. Accepts boolean value. The namespace must be
> +		disabled before modification.
> +
> +What:		/config/nvmet/subsystems/NAME/namespaces/NSID/p2pmem
> +Date:		October 2018
> +KernelVersion:	4.20
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:
> +		Shows or sets the P2P DMA memory device for this namespace.
> +		Accepts a PCI device BDF, "auto", or "none". The namespace
> +		must be disabled before modification. Only available when
> +		CONFIG_PCI_P2PDMA is enabled.
> +
> +What:		/config/nvmet/subsystems/NAME/attr_cntlid_min
> +What:		/config/nvmet/subsystems/NAME/attr_cntlid_max
> +Date:		January 2020
> +KernelVersion:	5.7
> +Contact:	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> +Description:
> +		attr_cntlid_min: Shows or sets the minimum controller ID
> +		(u16). Must be nonzero and not greater than attr_cntlid_max.
> +
> +		attr_cntlid_max: Shows or sets the maximum controller ID
> +		(u16). Must be nonzero and not less than attr_cntlid_min.
> +
> +What:		/config/nvmet/subsystems/NAME/attr_model
> +Date:		January 2020
> +KernelVersion:	5.7
> +Contact:	Mark Ruijter <MRuijter@onestopsystems.com>
> +Description:
> +		Shows or sets the model number for this subsystem. Must
> +		be a 1-40 byte ASCII string (characters 0x20-0x7e).
> +		Cannot be changed after the subsystem has been discovered.
> +
> +What:		/config/nvmet/subsystems/NAME/attr_pi_enable
> +What:		/config/nvmet/ports/N/param_pi_enable
> +Date:		May 2020
> +KernelVersion:	5.8
> +Contact:	Israel Rukshin <israelr@mellanox.com>
> +Description:
> +		Shows or sets whether protection information (PI) is
> +		enabled/supported. Accepts boolean value. Only available
> +		when CONFIG_BLK_DEV_INTEGRITY is enabled. The port-level
> +		attribute requires the port to be disabled before
> +		modification.
> +
> +What:		/config/nvmet/subsystems/NAME/namespaces/NSID/revalidate_size
> +Date:		May 2020
> +KernelVersion:	5.8
> +Contact:	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> +Description:
> +		Write-only. Writing 1 triggers namespace size revalidation.
> +		If the size has changed, a namespace changed AEN is sent.
> +		The namespace must be enabled.
> +
> +What:		/config/nvmet/subsystems/NAME/passthru/device_path
> +What:		/config/nvmet/subsystems/NAME/passthru/enable
> +Date:		July 2020
> +KernelVersion:	5.9
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:
> +		Passthrough mode attributes.
> +
> +		device_path: Shows or sets the NVMe controller character
> +		device path (e.g., /dev/nvme0). Cannot be changed while
> +		the passthrough controller is active.
> +
> +		enable: Shows or sets whether passthrough mode is enabled
> +		(boolean).
> +
> +		Only available when CONFIG_NVME_TARGET_PASSTHRU is enabled.
> +
> +What:		/config/nvmet/subsystems/NAME/passthru/admin_timeout
> +What:		/config/nvmet/subsystems/NAME/passthru/io_timeout
> +Date:		November 2020
> +KernelVersion:	5.11
> +Contact:	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> +Description:
> +		admin_timeout: Shows or sets the admin command timeout for
> +		passthrough mode, in jiffies.
> +
> +		io_timeout: Shows or sets the I/O command timeout for
> +		passthrough mode, in jiffies.
> +
> +		Only available when CONFIG_NVME_TARGET_PASSTHRU is enabled.
> +
> +What:		/config/nvmet/subsystems/NAME/passthru/clear_ids
> +Date:		June 2022
> +KernelVersion:	5.19
> +Contact:	Alan Adamson <alan.adamson@oracle.com>
> +Description:
> +		Shows or sets whether to clear identify data IDs in
> +		passthrough mode. Only available when
> +		CONFIG_NVME_TARGET_PASSTHRU is enabled.
> +
> +What:		/config/nvmet/hosts/HOSTNQN/dhchap_key
> +What:		/config/nvmet/hosts/HOSTNQN/dhchap_ctrl_key
> +What:		/config/nvmet/hosts/HOSTNQN/dhchap_hash
> +Date:		June 2022
> +KernelVersion:	6.0
> +Contact:	Hannes Reinecke <hare@suse.de>
> +Description:
> +		DH-HMAC-CHAP authentication attributes.
> +
> +		dhchap_key: Shows or sets the host secret key. Accepts a
> +		key string in "DHHC-1:" format.
> +
> +		dhchap_ctrl_key: Shows or sets the controller secret key
> +		for bidirectional authentication. Same format as dhchap_key.
> +
> +		dhchap_hash: Shows or sets the HMAC hash algorithm.
> +		Accepted values: "hmac(sha256)", "hmac(sha384)",
> +		"hmac(sha512)".
> +
> +		Only available when CONFIG_NVME_TARGET_AUTH is enabled.
> +
> +What:		/config/nvmet/hosts/HOSTNQN/dhchap_dhgroup
> +Date:		June 2022
> +KernelVersion:	6.0
> +Contact:	Hannes Reinecke <hare@suse.de>
> +Description:
> +		Shows or sets the Diffie-Hellman group for DH-HMAC-CHAP
> +		key exchange. Accepted values: "null", "ffdhe2048",
> +		"ffdhe3072", "ffdhe4096", "ffdhe6144". Non-null groups
> +		require the corresponding KPP crypto algorithm to be
> +		available. Only available when CONFIG_NVME_TARGET_AUTH
> +		is enabled.
> +

Why is this a separate entry, and not grouped with the other dhchap
entries?

And these are 'host' settings. Please keep settings for 'host', 
'subsystem', and 'ports' together.

> +What:		/config/nvmet/subsystems/NAME/attr_qid_max
> +Date:		August 2022
> +KernelVersion:	6.1
> +Contact:	Daniel Wagner <dwagner@suse.de>
> +Description:
> +		Shows or sets the maximum queue ID (number of I/O queues,
> +		u16). Must be between 1 and 128. Changing this value
> +		forces reconnection of all connected controllers.
> +
> +What:		/config/nvmet/subsystems/NAME/attr_ieee_oui
> +Date:		November 2022
> +KernelVersion:	6.2
> +Contact:	Aleksandr Miloserdov <a.miloserdov@yadro.com>
> +Description:
> +		Shows or sets the IEEE OUI for this subsystem. Displayed
> +		in "0x%06x" format. Must be a 24-bit value. Cannot be
> +		changed after the subsystem has been discovered.
> +
> +What:		/config/nvmet/subsystems/NAME/attr_firmware
> +Date:		November 2022
> +KernelVersion:	6.2
> +Contact:	Aleksandr Miloserdov <a.miloserdov@yadro.com>
> +Description:
> +		Shows or sets the firmware revision string for this
> +		subsystem. Must be a 1-8 byte ASCII string (characters
> +		0x20-0x7e). Cannot be changed after the subsystem has
> +		been discovered.
> +
> +What:		/config/nvmet/ports/N/addr_tsas
> +Date:		August 2023
> +KernelVersion:	6.7
> +Contact:	Hannes Reinecke <hare@suse.de>
> +Description:
> +		Shows or sets the transport-specific address subtype. For
> +		TCP transport, accepted values: "none", "tls1.3" (requires
> +		CONFIG_NVME_TARGET_TCP_TLS). For RDMA transport, shows the
> +		QP type: "connected" or "datagram". The port must be
> +		disabled before modification.
> +
> +What:		/config/nvmet/ports/N/param_max_queue_size
> +Date:		January 2024
> +KernelVersion:	6.9
> +Contact:	Max Gurtovoy <mgurtovoy@nvidia.com>
> +Description:
> +		Shows or sets the maximum queue size for this port. Default
> +		is -1 which lets the transport choose. The port must be
> +		disabled before modification.
> +
> +What:		/config/nvmet/discovery_nqn
> +Date:		April 2024
> +KernelVersion:	6.9
> +Contact:	Hannes Reinecke <hare@kernel.org>
> +Description:
> +		Shows or sets the NQN of the discovery subsystem. The
> +		value must be unique and not duplicate any existing
> +		subsystem name.
> +
> +What:		/config/nvmet/subsystems/NAME/namespaces/NSID/resv_enable
> +Date:		November 2024
> +KernelVersion:	6.13
> +Contact:	Guixin Liu <kanie@linux.alibaba.com>
> +Description:
> +		Shows or sets whether persistent reservation support is
> +		enabled for this namespace. Accepts boolean value. The
> +		namespace must be disabled before modification.
> +
> +What:		/config/nvmet/subsystems/NAME/attr_vendor_id
> +What:		/config/nvmet/subsystems/NAME/attr_subsys_vendor_id
> +Date:		January 2025
> +KernelVersion:	6.14
> +Contact:	Damien Le Moal <dlemoal@kernel.org>
> +Description:
> +		attr_vendor_id: Shows or sets the PCI vendor ID reported
> +		by this subsystem. Displayed in "0x%x" format.
> +
> +		attr_subsys_vendor_id: Shows or sets the PCI subsystem
> +		vendor ID. Displayed in "0x%x" format.
> +
> +What:		/config/nvmet/ports/N/param_mdts
> +Date:		April 2026
> +KernelVersion:	7.1
> +Contact:	Aurelien Aptel <aaptel@nvidia.com>
> +Description:
> +		Shows or sets the maximum data transfer size for this port.
> +		Default is -1 which lets the transport choose. The port
> +		must be disabled before modification.

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

