Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840F1C77B78
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 06:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HxUKKIOGPl7o2Ksj+0VHAq6dun13rkhfrfvtHYNmQtc=; b=wmxpfPY/9sH9PuCTpuqgmtyyPb
	jc1+xT32UZNnB84S/tOqm4x2a8o5FX9ym9LXuAIyF7fsQ/zKn6Ow55M/0EboyaRVekwHpSYR72RUx
	qRfQu8FmjBVPqDKdYRY6tchOf8SwhFeLYMvRvoskPNpeVis6L+I6pOaZsLNFzafwbWBBsJnyR19dx
	RCBmVuuHE/LUxVh+e8lnbm5gTtPNsh+F4zqLfWr1cCtx1WgsNb6JWUKY0c2PDDS6IuuCxdbYyy1Ny
	3ePE5JM9RzbAVOIWe2pfVaSwbzZ6HVR9jwkwKb2mnkfb8eUn+YsZhQInaVCUu7qLtZp0RJnSvNOIu
	RxT8LXqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkiK-009tbV-1M;
	Fri, 21 Apr 2023 06:57:48 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkiH-009tZV-2W
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 06:57:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1688C1FDDC;
	Fri, 21 Apr 2023 06:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682060264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HxUKKIOGPl7o2Ksj+0VHAq6dun13rkhfrfvtHYNmQtc=;
	b=v6mz9MMie9djBV+bbusRwLIygoiB9KDAuM6Vr21UKpDrD+UMRSU9YcU/dNv52ZH0SrYG8c
	l/9n/KW6Z2al/j4HSxnhWAJ12bE3JGnpT4riMxBha/J4axcz1S0AlBzsyduM5pyhuuWuJp
	C/S5pQaDH7nbVzL+A0bdZHEfu9xVX+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682060264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HxUKKIOGPl7o2Ksj+0VHAq6dun13rkhfrfvtHYNmQtc=;
	b=MqlTArYI6WN3lWuaDC+wZK1XuorzAqvJEvg0cUbM/MXxH3KZBbZ1N7iFzRacJMg2thU/LM
	6OleX8aXj2mjU8DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0792313456;
	Fri, 21 Apr 2023 06:57:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 5v3lAegzQmQTfgAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 21 Apr 2023 06:57:44 +0000
Date: Fri, 21 Apr 2023 08:57:43 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 4/9] nvme: Use runtime fio background
 jobs
Message-ID: <4ckg7ymu73lfs7zlsby3com6k24qgovkaqky5jmgeoubs7azhh@jtvovyjluekv>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-5-dwagner@suse.de>
 <72ecc5fc-0ff4-5592-3293-f4204633fc8e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72ecc5fc-0ff4-5592-3293-f4204633fc8e@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_235745_966892_3F1C00A9 
X-CRM114-Status: UNSURE (   9.93  )
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

On Fri, Apr 21, 2023 at 08:29:22AM +0200, Hannes Reinecke wrote:
 > --- a/tests/nvme/040
> > +++ b/tests/nvme/040
> > @@ -38,7 +38,8 @@ test() {
> >   	# start fio job
> >   	echo "starting background fio"
> >   	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size=1g \
> > -		--group_reporting --ramp_time=5  &> /dev/null &
> > +		--group_reporting --ramp_time=5 \
> > +		--time_based --runtime=1m &> /dev/null &
> >   	sleep 5
> >   	# do reset/remove operation
> 
> Wouldn't it be better to let _run_fio_rand_io pick the correct size?

Yes, makes sense.

