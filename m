Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83828C87FCF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Aug 2025 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3p1HCVod384QdIiPBvO1TB467772w88lAmtyYH6LtzI=; b=bw0v2OfL5GUR8lakoQmLCCGmqh
	ghPAzyid3B5SJ8j4GPWkrE+Mz/w3sKqqfZjjAxCWx99cAqycHvfvFvMvpanrCB5ro1lWz36i23X4t
	yFikH3HTsyATLYdemImRn0sKX6Wc4TSZ81XKzV263czTZy/Mc95b5KRC8VhcO+/k0jpCEjQYeei1J
	xztW+UzEKfYMNRkqK2v9dlG6QK9Jae14Hr0+KGdZp4tEdbndjvLCo0Iq0ZXiUsR1TXqHp8f4FHcPW
	l8UYsZo0B1u8XFbkN67PZnSJWAA2D275jxXaJSRtFAnwxw3CWYu4utS3U4mRM774G/K2HaHIIcyXe
	EU6Lp9NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uixX8-0000000AtzA-40M2;
	Mon, 04 Aug 2025 15:55:30 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uix3s-0000000AmkB-12zp
	for linux-nvme@lists.infradead.org;
	Mon, 04 Aug 2025 15:25:17 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 501881F7D9;
	Mon,  4 Aug 2025 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754321113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3p1HCVod384QdIiPBvO1TB467772w88lAmtyYH6LtzI=;
	b=w0Ie1OrtmR7YJFg9/1qJxDvrzKBEbfyqZrUpdzNI3Xbjb8B5iuVmpp6SZ+s2q442hHyHZ/
	vXrJqPZiJ6sHACg6xT9AKLWHR3vm8t/rPWvLeCv8EnV80o/Nwcn71Sy/LsA+Htl6vhSsUy
	U7AnewrvVZOxfC94fIAk7CByCCogb5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754321113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3p1HCVod384QdIiPBvO1TB467772w88lAmtyYH6LtzI=;
	b=5JcjJEVXx7gcUloZQxWzdrQ1IhqaPy96JWM7PBIfg17Wgr/vDA4ymNiA8eLq4/ylhpmAkL
	D7FL0lfeA7tSoRCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754321113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3p1HCVod384QdIiPBvO1TB467772w88lAmtyYH6LtzI=;
	b=w0Ie1OrtmR7YJFg9/1qJxDvrzKBEbfyqZrUpdzNI3Xbjb8B5iuVmpp6SZ+s2q442hHyHZ/
	vXrJqPZiJ6sHACg6xT9AKLWHR3vm8t/rPWvLeCv8EnV80o/Nwcn71Sy/LsA+Htl6vhSsUy
	U7AnewrvVZOxfC94fIAk7CByCCogb5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754321113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3p1HCVod384QdIiPBvO1TB467772w88lAmtyYH6LtzI=;
	b=5JcjJEVXx7gcUloZQxWzdrQ1IhqaPy96JWM7PBIfg17Wgr/vDA4ymNiA8eLq4/ylhpmAkL
	D7FL0lfeA7tSoRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42BC513695;
	Mon,  4 Aug 2025 15:25:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DlNYD9nQkGgzdQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 04 Aug 2025 15:25:13 +0000
Date: Mon, 4 Aug 2025 17:25:12 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, msmurthy@imap.linux.ibm.com, 
	gjoyce@ibm.com
Subject: Re: [PATCH] nvme-list: fix verbose JSON output for 'nvme list'
 command
Message-ID: <cc396386-3924-4198-bc05-e1a3137d59b7@flourine.local>
References: <20250721102946.1003295-1-nilay@linux.ibm.com>
 <175336669186.426033.4256373145639280312.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175336669186.426033.4256373145639280312.b4-ty@kernel.org>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250804_082516_450567_8C49ABB9 
X-CRM114-Status: GOOD (  12.22  )
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

On Thu, Jul 24, 2025 at 04:18:16PM +0200, Daniel Wagner wrote:
> 
> On Mon, 21 Jul 2025 15:59:11 +0530, Nilay Shroff wrote:
> > The verbose JSON output of the nvme list command is currently incorrect in
> > both multipath and non-multipath configurations. Specifically, it prints
> > empty Namespaces[] and Paths[] arrays in the wrong places, leading to
> > confusion and invalid output. For example, on a system with single NVMe
> > disk, signle controller and one namepsace created, 'nvme list --verbose
> > --output json' prints the following output:
> > 
> > [...]

FYI, this patch is causing a regression:

https://github.com/linux-nvme/nvme-cli/issues/2886

