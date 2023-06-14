Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0CFEB64DB
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jun 2023 11:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CPmywtVfCaP5g//aLurOUr0aMUZKEepqKZINmxw4yWU=; b=XVuXYdKbxHpwCEO2HXPrWS8ApM
	OQANjcMCG83YMqeXzQLg7oVEq5j8ittpBddCjNZ/5VmIvQSkek2d2Uo6IpC6/35L41SPvyAMpAaQ2
	wBRz5Yd2+lRpErTA0Y7RQostyilx1KQlw2KZnKTn2x9uqVm4bdlQqurYvcZY/H1hLBgyiJd/AEXNK
	qNOpOGqRcWZBVfS6avBa0JMplRGugU9wgMQGcpLSzJJRPdj+fSX58y75drv4tboVW7nWA+g0r2A+2
	W6T4UpH/oBsDhwSn+jK9OXIbdvmGqjkfGhCnRoOdyq8A52eOendjG5clsiEEZR7fW3YXZtDYU1vAa
	Wg3tKpFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Oyg-00BX7e-3C;
	Wed, 14 Jun 2023 11:47:54 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Oyd-00BX77-2q
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jun 2023 11:47:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A56E91FDE9;
	Wed, 14 Jun 2023 11:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686743270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CPmywtVfCaP5g//aLurOUr0aMUZKEepqKZINmxw4yWU=;
	b=gJCgcYRCsbYLOOCss2DXkxx43B72JjsrQqUS/URMVbP6P9wdfTz3BV/3C/aEj4EeCAd1/2
	6Me/fIV7MKZcUOJu1a4R6Y1vpByaChL6AZ7vr3KbpIR+Wo1ZjdgjHqpdxckY5aD58b5T18
	fYqQ1AEgaNCs70hRYWoI9hpKrOyftok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686743270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CPmywtVfCaP5g//aLurOUr0aMUZKEepqKZINmxw4yWU=;
	b=5jr93SbhLCCdJysZmq3QHaa6qUlfX0i32CRUkycu5aiQTkGoRUYBE/NY7a/WQRx9LHiI1B
	RTsP9atBn53Z1WBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 919901391E;
	Wed, 14 Jun 2023 11:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id rtIlI+aoiWQsJQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 14 Jun 2023 11:47:50 +0000
Date: Wed, 14 Jun 2023 13:47:49 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, 
	Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCH nvme-cli] nvme-print: fix wrong list-subsys output when
 ns are attached to different ctrls
Message-ID: <y2ld73bmdla7xfkllfv76oeuivo7kl2hg2cv2z3ikf2tyouhzh@airejsqrcrvj>
References: <20230612153406.663147-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612153406.663147-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_044752_091437_3889B64F 
X-CRM114-Status: GOOD (  13.57  )
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

On Mon, Jun 12, 2023 at 06:34:06PM +0300, Sagi Grimberg wrote:
> If we list subsystem controllers not for a specific ns (user did not pass
> a namespace device node), we cannot look at the first ns in the subsystem
> to list because it may not be attached to all subsystem controllers.
> 
> We incorrectly assumes that subsystem namespaces (or at least the first of
> them) are attached to all subsystem controllers.
> 
> Fix that by showing the multipath subsystem-list flavor only when the user
> passed a specific namespace, and fallback to a simple controller list otherwise.
> 
> Fixes: cdeaab8fca6e ("nvme-print: Show ANA state only for one namespace")
> Fixes: 7435ed9ae6a6 ("nvme-print: Show paths from the first namespace only")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Patch applied. Thanks!
Daniel

