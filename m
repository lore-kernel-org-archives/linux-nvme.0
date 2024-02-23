Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9CBC54798
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Feb 2024 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fqf5LsADRHXxXKfmIl35CcLoeH12CyZugLleg6TXNrY=; b=hkO7Z8ghKa+scZZOEFkjelgV9l
	7ScbSbxBMYkY9MpHDFy/zNaciCBZ8wWhicsNVimmdr4vRxw9FIAFqKdrjJrsKFRYb03hi0wQ+WCG9
	iAu6DFPogsijF7dTSuuegMR6LQbudEmw7lFUgYXE1oem04l5+fJ7X3OUCkAW5kZRvXOc29D9OJdRX
	bM//oU2t3HkPQvblS4lhGVDxQxBEI63FQC67aHl+9jwqgAdjc5CbAfONSTBF5Y9Z0ySaiulgnJavD
	AH8WZtSQV00IarPWJqUmlrTghOGz38kCxzVrNWKFBcwsGa/ugmXoeO2qRQBz/A7SVi8ejxLILngFu
	0rEtNFYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdWiP-00000009nBB-3Idb;
	Fri, 23 Feb 2024 14:39:53 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdWhw-00000009myl-1SPu
	for linux-nvme@lists.infradead.org;
	Fri, 23 Feb 2024 14:39:46 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 580221FBFB;
	Fri, 23 Feb 2024 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708699158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fqf5LsADRHXxXKfmIl35CcLoeH12CyZugLleg6TXNrY=;
	b=M77T8CVaaok7Ksa6dDWEBj2+oVk8RNAuZsLBZq3tx1Ebxd3CrthEj51bRAyltQjCde5VlS
	EarpIvPTprZKQoJ3ItuAuIEqFr9xW2VXAq4rtSnD7E1AEVD+bvbq826r67yzlKXfIiRoub
	uV0QqtTRTp5gDqfgLShRxuiqj4Onq3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708699158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fqf5LsADRHXxXKfmIl35CcLoeH12CyZugLleg6TXNrY=;
	b=DmLVAV+pTHZyj7ceUEfw9I/f4gw9NAVj+lvBjPULLyTvPmljskCjPcMtLWoVK2xMKWxUVT
	8qaAia+VJbF78JAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708699158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fqf5LsADRHXxXKfmIl35CcLoeH12CyZugLleg6TXNrY=;
	b=M77T8CVaaok7Ksa6dDWEBj2+oVk8RNAuZsLBZq3tx1Ebxd3CrthEj51bRAyltQjCde5VlS
	EarpIvPTprZKQoJ3ItuAuIEqFr9xW2VXAq4rtSnD7E1AEVD+bvbq826r67yzlKXfIiRoub
	uV0QqtTRTp5gDqfgLShRxuiqj4Onq3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708699158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fqf5LsADRHXxXKfmIl35CcLoeH12CyZugLleg6TXNrY=;
	b=DmLVAV+pTHZyj7ceUEfw9I/f4gw9NAVj+lvBjPULLyTvPmljskCjPcMtLWoVK2xMKWxUVT
	8qaAia+VJbF78JAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3827013419;
	Fri, 23 Feb 2024 14:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id brFPDRau2GU6CAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 23 Feb 2024 14:39:18 +0000
Date: Fri, 23 Feb 2024 15:38:39 +0100
From: David Sterba <dsterba@suse.cz>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, josef@toxicpanda.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
Message-ID: <20240223143839.GP355@twin.jikos.cz>
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
 <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M77T8CVa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DmLVAV+p
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.13%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 580221FBFB
X-Spamd-Bar: /
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_063924_717849_C2343B15 
X-CRM114-Status: GOOD (  15.73  )
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
Reply-To: dsterba@suse.cz
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 23, 2024 at 01:03:01AM +0530, Kanchan Joshi wrote:
> - Is there interest in filesystem leveraging the integrity capabilities 
> that almost every enterprise SSD has.
> Filesystems lacking checksumming abilities can still ask the SSD to do
> it and be more robust.
> And for BTRFS - there may be value in offloading the checksum to SSD.
> Either to save the host CPU or to get more usable space (by not
> writing the checksum tree). The mount option 'nodatasum' can turn off
> the data checksumming, but more needs to be done to make the offload
> work.

What would be the interface for offloading? E.g. the SSD capability is
provided by the async hash in linux crypto API.

As you say using the nodatasum option for the whole filesystem would
achieve the offloading and not storing the checksums. But other ways
would need an interface how to communicate the checksum values back to
the filesystem.

Dealing with the ahash as interface is not straightforward, may need
additional memory for requests and set up of the pages to pass the
memory. All that and the latency caused by issuing the request and
waiting could be slower than calculating the checksum on CPU.

Also the ahash interface is getting less popular, fsverity removed the
support not so long ago [1].

[1] https://lore.kernel.org/linux-crypto/20230406003714.94580-1-ebiggers@kernel.org/

