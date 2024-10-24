Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6848AD0BB6F
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 08:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SSSVJ0mii9c5/eieY6PsE1Q0JszssUHh+DCBkD3DV+w=; b=sCEDvl1/28v6xOZ3bybzgUtf+S
	opG98y9qKbQPDsnSv0HLXPqeRitp36An7xJCfWhwZHGnHuK8rwiM9qaXxowsq1xP/1Dv/NrrVxbUq
	5n6t6VDumHc1B5abDtUYQ8cK+3uTYUUZjelDg6K8sbKULkdUb4JQCCHiRW2GsbpzCD3Wtc11bA0tl
	cRM4wZpr8YN8SVGAo70oqw005jFKBwT78duUcxZw3/pfuToOSFN1va+P+5hb2ts3hCxo/bD5sMSfr
	kmqLxPfNMNo8dxLnChUMQt5SOC5KITYj0BLNCBU58JwjN4X+Wlx4caVBFeVfrAPz5zBnJ2Z/pBfO6
	L3VwdTBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3t4o-0000000HGhS-3Ouu;
	Thu, 24 Oct 2024 08:20:14 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3t4j-0000000HGcf-1Xv6
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 08:20:13 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC4AF1F79E;
	Thu, 24 Oct 2024 08:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729758006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SSSVJ0mii9c5/eieY6PsE1Q0JszssUHh+DCBkD3DV+w=;
	b=LNUmt7D7goguwvc7+o7vU/1B/Ocdqg1tBiK4iawG96oHLBHHc1JkRlno1hJLaSZgarShlA
	a9wnbVeiTBlsR9dUdE4rAYnRxfmvEPNjSwDXm8vNpAO9R9cKXCumllH5/SNXlvXU+9XFq5
	5fLp6cJJhGNCiXeUaz7vgkyyELC5T/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729758006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SSSVJ0mii9c5/eieY6PsE1Q0JszssUHh+DCBkD3DV+w=;
	b=ddIpR8yDi3+yDzGi8aXxe9uRlSgWFLZJtj/j9xtnp3x06Pn8o0D0SA7zRUBESkKDJ+2wGv
	YI9s/8j6Gb4fIuCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729758005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SSSVJ0mii9c5/eieY6PsE1Q0JszssUHh+DCBkD3DV+w=;
	b=LhxxLrvIQRHkRceUR160hPTMZkJ4sCKMPM+Ea2GPrKpBKBeRHlKxfE6ExHn4KOJkQp2nta
	0BdlA6X8YxSQmfMMVrrrnmArEmOeXFx4a6vQPM6g8GVwUjRPR0Z3O+q2GAP6MqJXPWjvOT
	vvWF5dEg0aFTN6hhTnn5j4BxUWHJoas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729758005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SSSVJ0mii9c5/eieY6PsE1Q0JszssUHh+DCBkD3DV+w=;
	b=1MQU+NVScgFI82PiLAPEMPF69TrbNScjfN9QwILB0mcUPKXNRRaUCwInHniVkQrvOGyzpA
	SEnh6Fk/H6bC7yBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D147D136F5;
	Thu, 24 Oct 2024 08:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vZe6MDUDGmfzMwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 24 Oct 2024 08:20:05 +0000
Date: Thu, 24 Oct 2024 10:20:05 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: tls key lookup matches too eagerly?
Message-ID: <065b92b0-e854-42f4-8f98-9ad89bf47295@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-3.27 / 50.00];
	BAYES_HAM(-2.98)[99.89%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_012009_588267_072F56FF 
X-CRM114-Status: UNSURE (   7.82  )
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

Hi Hannes,

While testing my TLS handling changes in nvme-cli/libnvme, I found out
that it is possible to insert a key with a identity of "NVMe1R01" only
and the kernel was happy to use this key.

nvme_tls_psk_lookup
  keyring_search
  	struct keyring_search_context ctx = {
		.index_key.description	= description,
		.index_key.desc_len	= strlen(description),
        	.match_data.cmp		= key_default_cmp,
                [...]
        }

/*
 * By default, we keys found by getting an exact match on their descriptions.
 */
bool key_default_cmp(const struct key *key,
		     const struct key_match_data *match_data)
{
	return strcmp(key->description, match_data->raw_data) == 0;
}

I think we should at least enforce that the identity set by user space
fullfills the required format. Does this make sense?

Daniel

