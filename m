Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BD7C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 07:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tMT+YS9mDjL8T0hbC/qvd2GBIGdL8zbdaDRRZSuJmHM=; b=oSFwBSeDcdgR6l5YhKDXBbX0jZ
	S7rSbeiSWx7hHVSBB7RCAfSjlo3G5X1ef6P2SprwkLA9KEg+YyVKa/meNAQtIJgbWvvC5GQhjDAmi
	5BVP4Ckfsx1T/FEe5jxilsSf2i9CLXxtGz83SdLy2uuudLnmRDkC0BVfehEyixmDuIKRLcnrYB5cc
	9zxAWCgXj5Yot4rzyMknajDZUEx5ac5CwPJ1p84ahaeqK0gQi52HS1bV8reqTYGRwxf4pbIjVW7h2
	tKiJbvDcbEkkme2uFCFqtQj18A6QsF2JYVK/loREoi0RtuiiuD48zSE+LFLDu3qd8FFTSRH907+9U
	P8ZZ8Bwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUMEQ-0000000BdHf-2aSH;
	Mon, 29 Jan 2024 07:39:02 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUMEM-0000000BdGi-1B9s
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 07:39:00 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 568571F7D8;
	Mon, 29 Jan 2024 07:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706513930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tMT+YS9mDjL8T0hbC/qvd2GBIGdL8zbdaDRRZSuJmHM=;
	b=w2RKjVi8wNAYLilxYD//HU0O3qXngN24o5P5glX+31748LokkIHN0tRADC5gGTjKnJctJZ
	a/m4wtzUUopEcHoBCZ8E2F25uxMZBCCkhwSCXudaue0weNILLqnolYfgBkCEnag5H+HJrb
	kS4krS8xRxo6ZdJU/0JSkg4AEucz6/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706513930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tMT+YS9mDjL8T0hbC/qvd2GBIGdL8zbdaDRRZSuJmHM=;
	b=2O6P2BgndtA2rC1Li23abpjZPLLVeAjoR4SmIsiWSKzyOVr3/4dO1YebQGyppAKPKQYGao
	umbFxaol6Wmjl5Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706513930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tMT+YS9mDjL8T0hbC/qvd2GBIGdL8zbdaDRRZSuJmHM=;
	b=w2RKjVi8wNAYLilxYD//HU0O3qXngN24o5P5glX+31748LokkIHN0tRADC5gGTjKnJctJZ
	a/m4wtzUUopEcHoBCZ8E2F25uxMZBCCkhwSCXudaue0weNILLqnolYfgBkCEnag5H+HJrb
	kS4krS8xRxo6ZdJU/0JSkg4AEucz6/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706513930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tMT+YS9mDjL8T0hbC/qvd2GBIGdL8zbdaDRRZSuJmHM=;
	b=2O6P2BgndtA2rC1Li23abpjZPLLVeAjoR4SmIsiWSKzyOVr3/4dO1YebQGyppAKPKQYGao
	umbFxaol6Wmjl5Bw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4011913911;
	Mon, 29 Jan 2024 07:38:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id O8FMDwpWt2VQKgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 29 Jan 2024 07:38:50 +0000
Date: Mon, 29 Jan 2024 08:38:49 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Re: nvme-tcp: question on poll return value
Message-ID: <apgvoq6etzjocnkqq7p3z665ex5k7o6ynep3fjlwgriizdv2ob@pnm6gs7kt5bf>
References: <gcy35jsyvwmw37tlqpanvavqpxqmt3qylam7mtbkefolj737ef@vfswvevmfxku>
 <e05c2ce0-d884-47d3-8b1b-b7b6b0e96192@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e05c2ce0-d884-47d3-8b1b-b7b6b0e96192@grimberg.me>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.87 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.07)[62.43%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_233858_516827_B8327D98 
X-CRM114-Status: GOOD (  18.63  )
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

On Sun, Jan 28, 2024 at 01:05:10PM +0200, Sagi Grimberg wrote:
> > Does this make any sense?
> 
> Not sure I understand your logic. nr_cqe is cleared when try_recv starts and
> incremented
> in every completion, and nvme_tcp_poll is returning this value as these are
> the number
> of cqes collected during the try_recv triggered by nvme_tcp_poll.
> 
> It is true that if between try_recv triggered by nvme_tcp_poll and another
> try_recv called
> from the RX io_work path, nr_cqe may be cleared again. That is something we
> can address
> by passing nr_cqe by reference as an in+out parameter to try_recv. But I
> don't see how
> nr_cqe is going to always be 0.

I was a bit confused when a looked at the code and didn't realize that
after setting nr_cqe to 0, that nvme_tcp_recv_data will be executed via
the read_sock callback. It's obvious now. Thanks for explaining.

Thanks,
Daniel

