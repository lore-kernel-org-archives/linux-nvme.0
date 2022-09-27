Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1CDC6FA95
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NYKscZbzFmdJ4EjlnIFF8qmZjht/VwDgYaXsXtwi3dM=; b=wgx1+fGZT1xtO7gzJxNgpAI1qt
	LolFERnwAHGmPs9Q18HSLRK9fsgy2Cgjv39uvGR2RDQWc1OiLt4NJaEJxAg0Bwqykd2kUGPwQMxPN
	gkQW5Zr5nUzisC/USSn3wrahE0XM7R3U269v+SFvI+tycm92rah3P3hhc9fUr8st9bNKuxtRvFcJQ
	xop3QwKae/KoAfnQbwA+ce/+hXHcoyvtGmahwlCg15T7p+F2IAwFKDz7MYWD5J29So/SYYfQs0fkh
	OYTxexsvaZxuip0HjFlsc9jzBSXdL7FzDsl9Tut8B/ipV9pjmzzxy0YMSZj/n+krXACpJK3P+fU+w
	V4yAiggg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od8gk-00ACTe-Hq; Tue, 27 Sep 2022 11:23:46 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od8fy-00ABuW-QW
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 11:23:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A53E71FD0C;
	Tue, 27 Sep 2022 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664277774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NYKscZbzFmdJ4EjlnIFF8qmZjht/VwDgYaXsXtwi3dM=;
	b=q8vdqUShU4q/1szZUkWxzfaxRH10m0nV8SkWmb7vSxqyvkcxrmG3AMubZQ/qkUQbI9l17i
	ai5dBoKVsZTquZY3WQzC43BoeAG+rTnv7eku4gyBEcY+WMxUdn1dRPi9CnEURdfZeV8uOO
	L81wiPq4c+iuE8T69/mXthW0UT1Vk+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664277774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NYKscZbzFmdJ4EjlnIFF8qmZjht/VwDgYaXsXtwi3dM=;
	b=1QYuwPly1G71hI6AaCU/8YldRPE7m4Fru6/QzvuEUCTGhV+9z8b/M7Cjhwqw9tXD5QGT2o
	J3XW/HWjQioz/BDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95A3D139BE;
	Tue, 27 Sep 2022 11:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id GFO2Iw7dMmNhaAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 27 Sep 2022 11:22:54 +0000
Date: Tue, 27 Sep 2022 13:22:54 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <james.smart@broadcom.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 3/2 nvme-cli] fabrics: re-read the discovery log page
 when a discovery controller reconnected
Message-ID: <20220927112254.ajch75fqqmbx63no@carbon.lan>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220922081538.13364-4-sagi@grimberg.me>
 <20220927075213.6idrtq4sbiobtr3m@carbon.lan>
 <SJ0PR19MB45442FA5051872B841C308ABF2559@SJ0PR19MB4544.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR19MB45442FA5051872B841C308ABF2559@SJ0PR19MB4544.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_042259_049368_BD01E7BF 
X-CRM114-Status: GOOD (  10.62  )
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

On Tue, Sep 27, 2022 at 10:50:08AM +0000, Belanger, Martin wrote:
> > I wonder to we need to it to append the --host_iface argument as well.
> Yes, the --host-iface should be added for this case too. 

Okay, I'll add them.

