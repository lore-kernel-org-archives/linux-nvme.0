Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F778C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 03:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9JN0fB16G2C30bXw00o2rKWge5ToDKtDbnbvpwNdZkI=; b=X1YpKJG67U+7Y2PNcg/p/EkMjb
	fS5AbEwZKLYD/5O1hoKx+lXTjSZTf5nYFyBJPkEmXSjwhznCqPZT4Rdigz2km83P/0MjkMd2AKp3+
	Uu+LjN6oyksYBqTs+YF6SVjNqODPFfzs10AL5qZGtpVCqrLkXw3I2v0SpS9NqgQ/E1fgtdabS7EwB
	AbFiBd+J1RhZHdwyLGYpEoXhmBBpDCZBOoGuPgeQec/bwW+j/ovjga4ChU84uvm9X2fvYGPZOv5cG
	4rC9IzNnPl6kNYpAGZGQrBz8NLtoX12JzX7TdZmuT4KV0ZxmclP5K01+Tk0q+u5IOPig5jNiVZYqa
	PKAnSjXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrWaz-004o99-4M; Thu, 19 May 2022 03:13:01 +0000
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrWaq-004nwq-R5
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 03:12:59 +0000
Received: by mail-pg1-f182.google.com with SMTP id z3so2372618pgn.4
 for <linux-nvme@lists.infradead.org>; Wed, 18 May 2022 20:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9JN0fB16G2C30bXw00o2rKWge5ToDKtDbnbvpwNdZkI=;
 b=lOacunpB8noq0VDa+Ipr33ZlJKPlV6aCTNPzzTNci9GNCrub6tbTWc5T7uNqrsI3TB
 ApntyIdNoHyMJu54X8LUjmuglYs2DoTyltMgzXIrpOF4jOmtR5gwLUwxcnJ6ggz3+VzI
 yicKh6BJbCFvTZRLlaa0lUrxeR9AGcCMPBW4VbCU28+VVI0qk1iJQoTdS1PEePsjHRmW
 1kJFsBn4HGoxhdbc2MAUDoX4YD6cq1LKXWyY7LVX2qEiqwPoztcLbH/q6hogXR6sGhQ8
 WA4Xufg5CumcwnUF6cqy2v/1TQgXpSos5EgI5HsW92PYLtucxU9XZWMJWynrAbrXXaW2
 jd/w==
X-Gm-Message-State: AOAM530m6XRNBfDwdqgKaQyWYv6IUnnmUS0WOj9VPs57Im3xLBiQdp1a
 humEN+/8e7MQ6OuTqYIkVno=
X-Google-Smtp-Source: ABdhPJyrgMJtrLlwQnNIwf+NjlQjBMAO/19qfMKeveD8EoHEa/Q7M6uMkO2ILqaysBSDyiNbhhYuDQ==
X-Received: by 2002:a63:1050:0:b0:3c2:2f7c:cc78 with SMTP id
 16-20020a631050000000b003c22f7ccc78mr2222093pgq.238.1652929960314; 
 Wed, 18 May 2022 20:12:40 -0700 (PDT)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a654048000000b003f26c2f583asm2231364pgp.61.2022.05.18.20.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 May 2022 20:12:39 -0700 (PDT)
Date: Wed, 18 May 2022 20:12:37 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
 Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
 pankydev8@gmail.com, gost.dev@samsung.com,
 jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
 dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Message-ID: <20220519031237.sw45lvzrydrm7fpb@garbanzo>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
 <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_201252_900625_4C045CDC 
X-CRM114-Status: GOOD (  15.83  )
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

On Thu, May 19, 2022 at 12:08:26PM +0900, Damien Le Moal wrote:
> On 5/18/22 00:34, Theodore Ts'o wrote:
> > On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
> >> I'm a little surprised about all this activity.
> >>
> >> I though the conclusion at LSF/MM was that for Linux itself there
> >> is very little benefit in supporting this scheme.  It will massively
> >> fragment the supported based of devices and applications, while only
> >> having the benefit of supporting some Samsung legacy devices.
> > 
> > FWIW,
> > 
> > That wasn't my impression from that LSF/MM session, but once the
> > videos become available, folks can decide for themselves.
> 
> There was no real discussion about zone size constraint on the zone
> storage BoF. Many discussions happened in the hallway track though.

Right so no direct clear blockers mentioned at all during the BoF.

  Luis

