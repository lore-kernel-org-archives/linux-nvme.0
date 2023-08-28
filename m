Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473A1C71153
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Aug 2023 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fKxbHovoW9XOUx8UBnrQ59wSczavgRhLVHzRx9n7a+w=; b=yPVK6DdmlHlkdV0UmDvp2Xj+E+
	tMhf9FFwPHZHRE4SNL6Skdoo8XMYSg7+uK9PbxqjNdfx8uh0tzuLhXTpUumq/hDYBdHeo4ggLQW0h
	k21TXhMvX9t97ZtU72A7pYJ5bkOmaq1LnkMRPuyhXZOr6fC45CD9MV/l68QMY2zIksHd7uzpphLOc
	831sTjKExptGckeq8CWE+hvXY9E70bHaHZg834ZNZGBKww0/nWPFJs6llOZ1LQM25zUQsXekIPl9b
	ARtK7vAwQMnlHzUx6IQh46Fdvp/YaOJrQKtGDRWHlylHOP5Xa3h7CswCrQktXpVtyHBs8Aogwn8Hn
	i1hJNnIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qafdn-009xWH-1O;
	Mon, 28 Aug 2023 17:03:03 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qafdk-009xVt-2n
	for linux-nvme@lists.infradead.org;
	Mon, 28 Aug 2023 17:03:02 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5728D1F893;
	Mon, 28 Aug 2023 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693242179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fKxbHovoW9XOUx8UBnrQ59wSczavgRhLVHzRx9n7a+w=;
	b=VirYMM3rl+Mg0M8e2Vr9grkGN6ys+JjWzk1rIJgcaxd6VV416mfMsJeZNn2BWcBsObrfuJ
	u0BS3ALDU//eg0fHWtGuoTnvW4g4ggiaK2vLyMwpH1YLiLdlca1PuhLERFN7Vtp0YOR508
	rzubehfeg95Jwvb6r3suFQIkDpov3i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693242179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fKxbHovoW9XOUx8UBnrQ59wSczavgRhLVHzRx9n7a+w=;
	b=ddl3c+iOwY/c+T3tQvOOpFihSYHD/CAbsfzAgiDVUJh+BEN2QtQ1mKhS9aow+epTg3cjs1
	uIyDh/nmqOw+YICA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49048139CC;
	Mon, 28 Aug 2023 17:02:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xR6jEUPT7GTHMgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 28 Aug 2023 17:02:59 +0000
Date: Mon, 28 Aug 2023 19:03:18 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Message-ID: <3mp746jccer7dbn4ra4h5ag66d7dn7gqebriwliicdgzevrmgn@lir2lwtnlbhz>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <8e407992-d6da-46e2-a006-ad3b3cdfb101@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e407992-d6da-46e2-a006-ad3b3cdfb101@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_100301_075031_E6163394 
X-CRM114-Status: GOOD (  10.52  )
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

On Mon, Aug 28, 2023 at 08:14:09AM -0700, Bart Van Assche wrote:
> On 8/22/23 01:38, Daniel Wagner wrote:
> > +	while [[ $# -gt 0 ]]; do
> > +		case $1 in
> > +			--blkdev)
> > +				blkdev_type="$2"
> > +				shift 2
> > +				;;
> > +			--ctrlkey)
> > +				ctrlkey="$2"
> > +				shift 2
> > +				;;
> > +			--hostkey)
> > +				hostkey="$2"
> > +				shift 2
> > +				;;
> > +			*)
> > +				shift
> > +				;;
> > +		esac
> > +	done
> 
> So all arguments that are not recognized are ignored? That will
> make debugging typo's harder than necessary. Shouldn't this function
> complain if an unrecognized argument is encountered?

Sure, I'll add a warning.

