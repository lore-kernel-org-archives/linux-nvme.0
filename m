Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E444C77B72
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 08:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QiP5e/+4S7KnMOT6XDJPynS4EU6xSJzZUOwhN1ceQZ4=; b=ommWK+/Gho7xNpEQdf061ifpmZ
	XUZ4GCnraIHBpvyq2NUufAZB1XLE3hr+OBe43UoTtrM1tQfVRg4bd3yYzz8xIM+l/Nc8RLTs1kprf
	f1eTyOUoSEMUpa3Lzrcy5Xb5IeU79mSwFKj6V28YAiinAUzeH97fU1rM6Vi0a7B/EcsVWs4Uhqqv7
	xhfFR87xTnLrRWfhYyC/7vqQhA5wvqCqTN2HKbUJ+Xxl3+K4xpEhKjhDtjixuLmIn9RTVW7EbrkQk
	ZUw1/g92TCp5iaeFlxuXcQMpnTwqsPCxgV9qWRQUTjnekbzw7QHgEimevWtNYmrSLTyjScxiyU3O0
	oC6/+rqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppPad-007OVl-0a;
	Thu, 20 Apr 2023 08:24:27 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppPaY-007OTa-05
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 08:24:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8DA1218E9;
	Thu, 20 Apr 2023 08:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681979055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QiP5e/+4S7KnMOT6XDJPynS4EU6xSJzZUOwhN1ceQZ4=;
	b=Ka0LrcOK1yn6kwCoYM3XsQIK3ZxWeM/e5JNhtgI0SFtoekmncvrSclbNcgq/12E5RNfh1B
	tKSbwcPVGtT2/YC5w4McbNVc7dh9FfvwOH8tot50WNK+ZaF895gnFjMRlXXnj5hsiArUo6
	6uoNtinW8lqu1FVp2C/SaiZWbIwF/AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681979055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QiP5e/+4S7KnMOT6XDJPynS4EU6xSJzZUOwhN1ceQZ4=;
	b=6zrfcF8lR9nuEfShfTTEJY9Eum3YmV16Vcd4njIN65Y9hLrVFotV6yrzuvZesxoabLhKWx
	vYy9P6qmJcw26SBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99D2F1333C;
	Thu, 20 Apr 2023 08:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xKWCJa/2QGSZbAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 20 Apr 2023 08:24:15 +0000
Date: Thu, 20 Apr 2023 10:24:15 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [RFC v1 0/1] nvme testsuite runtime optimization
Message-ID: <qflkb4gu5lz5wx2oka5ceclj7ez5ic5oyofd3tzyjapjyrorlk@e7kkpa6bxwun>
References: <20230419085643.25714-1-dwagner@suse.de>
 <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
 <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
 <27235520-2e63-2891-fd0a-ff758f18032e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27235520-2e63-2891-fd0a-ff758f18032e@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_012422_283850_40418133 
X-CRM114-Status: GOOD (  16.86  )
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

On Wed, Apr 19, 2023 at 09:11:33PM +0000, Chaitanya Kulkarni wrote:
> >> Those jobs are meant to be run for at least 1G to establish
> >> confidence on the data set and the system under test since SSDs
> >> are in TBs nowadays and we don't even get anywhere close to that,
> >> with your suggestion we are going even lower ...
> >
> > Where does the 1G boundary coming from?
> >
>
> I wrote these testcases 3 times, initially they were the part of
> nvme-cli tests7-8 years ago, then nvmftests 7-6 years ago, then they
> moved to blktests.
> 
> In that time some of the testcases would not fail on with small size
> such as less than 512MB especially with verification but they were
> in the errors with 1G Hence I kept to be 1G.
> 
> Now I don't remember why I didn't use bigger size than 1G
> should have documented that somewhere ...

Can you remember why you chosed to set the image size to 1G and the io size for
fio to 950m in nvme/012 and nvme/013?

I am testing various image sizes and found that small images e.g in the range of
[4..64]m are passing fine but larger ones like [512-...]M do not (no space
left). Note I've added a calc function which does image size - 1M to leave some
room left.

