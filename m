Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A59D21272
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g97o32b/FNwCn9FQ9B2l+F/O2zeH1MIe4G9hnAUFPus=; b=3bDxbfrIYWQrMnK26GZRKy1CEJ
	W/zAeIsrW4Z61I4MK+fQCkDKXW4k8H7c5rEaL0fx247K166/uf3O8CA5Ck9Vv4u8f7dgxhHdA+BXs
	szFT70u10eP8YbfhuCA6OFxfefdUHRV8eg8jBVgSzFAWGWucR0RSHsALVo9yRVVd9lFkX49ksBrOH
	JidzzxfS+WPTkDHh+Ca+F935is1u65jmqIQkF5bFlFndlo6sDaGg9Bz/vKUMPW9Ueuferj8AVzJTZ
	Aw/52OiznoqSLGEze8ubjSpr0JcBxmiDVKf/XTo2+BSEiqRaXXxpJr9SJi9adv25ufPAloTiPp4r6
	6jjA3npg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1OGI-0000000EZpf-2noo;
	Thu, 17 Oct 2024 11:01:46 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1O9I-0000000EYUs-3pSO
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 10:54:41 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D957821E6A;
	Thu, 17 Oct 2024 10:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729162469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=g97o32b/FNwCn9FQ9B2l+F/O2zeH1MIe4G9hnAUFPus=;
	b=dGwDVJlM8cpTvBHyfc/pEP3FqxkWQ2GGNOUy+LBqGTh15Sy5Q9G/gcXk0RHILpvHSaJJ0W
	h2qbmef05H3AfIL5E9w2ucThy/SfilGkOhJH1mprDIDuBGHB+N0WryABSZ93+KyL2ljSX+
	J7OKmzPg714EgTVYT57fK+XLXyGxRBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729162469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=g97o32b/FNwCn9FQ9B2l+F/O2zeH1MIe4G9hnAUFPus=;
	b=1jz+Y4rNyA+vR5tYSkg5AQjSpf9AE3RyHQRrkl8+V4BbegJHdu3LBK9hs5aQh3u1Ku9cRK
	6W5QwfsS/2yETLDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729162469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=g97o32b/FNwCn9FQ9B2l+F/O2zeH1MIe4G9hnAUFPus=;
	b=dGwDVJlM8cpTvBHyfc/pEP3FqxkWQ2GGNOUy+LBqGTh15Sy5Q9G/gcXk0RHILpvHSaJJ0W
	h2qbmef05H3AfIL5E9w2ucThy/SfilGkOhJH1mprDIDuBGHB+N0WryABSZ93+KyL2ljSX+
	J7OKmzPg714EgTVYT57fK+XLXyGxRBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729162469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=g97o32b/FNwCn9FQ9B2l+F/O2zeH1MIe4G9hnAUFPus=;
	b=1jz+Y4rNyA+vR5tYSkg5AQjSpf9AE3RyHQRrkl8+V4BbegJHdu3LBK9hs5aQh3u1Ku9cRK
	6W5QwfsS/2yETLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B532C13A42;
	Thu, 17 Oct 2024 10:54:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CGDXKeXsEGezYwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 17 Oct 2024 10:54:29 +0000
Date: Thu, 17 Oct 2024 12:54:29 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: sysfs tls_configured_key naming?
Message-ID: <d3466e4f-23dc-4a07-a2c3-98bcbf6c7960@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
X-CRM114-CacheID: sfid-20241017_035433_162836_8BB30D63 
X-CRM114-Status: GOOD (  10.87  )
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

f5eb7397471b ("nvme-sysfs: add 'tls_configured_key' sysfs attribute")
claims that the --tls_key is expecting a 'Configured PSK'. That is not
correct. It expects a 'Derive TLS PSK'. That means user space has to do
the whole key transormation as described in Figure 21: {TLS PSK, TLS
Identity, Hash} Tuple Derivation in TCP Transport Specification,
Revision 1.1.

From a quick look at the concantiantion patches and based on the spec,
tls_configured_key will never hold the 'Configured PSK'. I think we
should use a better name for this sysfs attribute. I suppose it should
be named 'tls_generated_psk'?

BTW, that means also for the second tuple derivation flow (where we
start with the 'Configured PSK'), the keystore doesn't contain a
'Retained PSK'. I think I need to do some more reviewing and cleanups in
libnvme to get it matching with the naming sceme of the spec in line.

