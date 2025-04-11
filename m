Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EE5C36010
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Apr 2025 13:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zGn+Q7g0ubcRnAbt0qkfF4+w3AMJLrYKL5kVOTnsu9Q=; b=SkJI6HnYufiOQU9+eUZE7EaaBD
	1EPKmDdJMbJ3bMIG1RSqk/jxVJnvXXmsYFg6vk2se7zqJD2u3zVkqeespjzMJJ0yGf1Ne87nqa6hz
	hqbxRu3VtV+heDvej3FAPYlkfFlc/QpnxwZDlmZgTaUFfnb/JE4mZTdFri9sqBiILExG3OBCokjS9
	VUVUJbs4Yeugi0pE/VTb/+5XxCgZDk9OE5W0OKKZtjklNTl92HqOBlb/al0NF8b40+OwSH8QOKj9q
	uVO6eyv/DacIzh/pyywIXf/lVEq7e87qrHD28/SxkszDAx7KU1oAJld0oulbk/3B3uq7TqQHnTFmZ
	kutJdtng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3Ea7-0000000DxE8-2O8A;
	Fri, 11 Apr 2025 13:38:07 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3ETC-0000000Dvuf-26gP
	for linux-nvme@lists.infradead.org;
	Fri, 11 Apr 2025 13:30:59 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 832C61F456
	for <linux-nvme@lists.infradead.org>; Fri, 11 Apr 2025 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744378255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=zGn+Q7g0ubcRnAbt0qkfF4+w3AMJLrYKL5kVOTnsu9Q=;
	b=1ibs1mtlY0SESlmlDLY/daAfvRzVD1i1KTzI0EwsrSPRPedzHidojX66R+dTnwRbbF5P2K
	5o91WtVYTkm/c8JJXz+ryfLGLvAK7miHtx06Wq2dpLQFeGeokbMU5WZsI0+suYibdiD7bT
	Q5rR4hdw+0SQwvQLK6Ovax5EnGO4KfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744378255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=zGn+Q7g0ubcRnAbt0qkfF4+w3AMJLrYKL5kVOTnsu9Q=;
	b=GWn/MTEg2awFyAJ7sxzzOpsq4OeEMzZWegSrYggWnV+Crr8oTrn2mxKMxLRipy/SOZ4Qsx
	a5XArFA+PQ7HugDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744378255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=zGn+Q7g0ubcRnAbt0qkfF4+w3AMJLrYKL5kVOTnsu9Q=;
	b=1ibs1mtlY0SESlmlDLY/daAfvRzVD1i1KTzI0EwsrSPRPedzHidojX66R+dTnwRbbF5P2K
	5o91WtVYTkm/c8JJXz+ryfLGLvAK7miHtx06Wq2dpLQFeGeokbMU5WZsI0+suYibdiD7bT
	Q5rR4hdw+0SQwvQLK6Ovax5EnGO4KfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744378255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=zGn+Q7g0ubcRnAbt0qkfF4+w3AMJLrYKL5kVOTnsu9Q=;
	b=GWn/MTEg2awFyAJ7sxzzOpsq4OeEMzZWegSrYggWnV+Crr8oTrn2mxKMxLRipy/SOZ4Qsx
	a5XArFA+PQ7HugDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6002313886
	for <linux-nvme@lists.infradead.org>; Fri, 11 Apr 2025 13:30:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4UcLFY8Z+WcadwAAD6G6ig
	(envelope-from <dwagner@suse.de>)
	for <linux-nvme@lists.infradead.org>; Fri, 11 Apr 2025 13:30:55 +0000
Date: Fri, 11 Apr 2025 15:30:54 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [ANNOUNCEMENT] nvme-cli v2.13 and libnvme v1.13 release
Message-ID: <7873189f-2bb6-49b0-8766-9e1350fcda6e@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-4.17 / 50.00];
	BAYES_HAM(-2.87)[99.45%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	MIME_TRACE(0.00)[0:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250411_063058_696935_9F4ACFFF 
X-CRM114-Status: UNSURE (   4.59  )
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

Hi,

There were some rather annoying regressions in v2.12/v1.12 thus a bug fix
release. Thus the usual ca 3 month release interval is cut short.

Thanks,
Daniel

