Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1053C4345F
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Apr 2024 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s9uyMrI2kBzD/jir8Kf5BQ4KLVX7ZmHiKzONe0aRyLQ=; b=X9FjpXS44c472qZATG4HilM/lQ
	cZEeg6WsNzjzWJFqa6xTbxMGKAaaNhtLtXNDRwmuLpmLHFZrTPQs601QHvHY20eaZhS9BWnSBw1YI
	Q+GfzdYAblYXQx1g8fh+rTSNVGWQRtncVcrlbDnNNymmFM6naGoVYQyb0sep9CEdg5TKwCs9m1ZQH
	a7apHau0bU0Fu+TV+0Gdg458+dvBOvp8CR2QPUJJ+bvektKXajqGwvz5kFytbUv1FOwvCJe/h3g48
	6Gv+qS01jg4HvCZdJuWvQ0BEm8R+L0QoGQc9sQQVgT5FmvOPGEm34Dh0wVoP33wQ7Rn5p+2I41ocO
	MxlHka5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvgny-00000003bM4-1dNk;
	Sat, 13 Apr 2024 17:04:42 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvLdf-00000000rhY-0qAo;
	Fri, 12 Apr 2024 18:28:39 +0000
Date: Fri, 12 Apr 2024 11:28:39 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>,
	Dan Helmick <dan.helmick@samsung.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH v6 00/10] block atomic writes
Message-ID: <Zhl9VxTVxIEYc4cF@bombadil.infradead.org>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <ZgOXb_oZjsUU12YL@casper.infradead.org>
 <c4c0dad5-41a4-44b4-8f40-2a250571180b@oracle.com>
 <Zg7Z4aJtn3SxY5w1@casper.infradead.org>
 <f3c1d321-0dfc-466f-9f6a-fe2f0513d944@oracle.com>
 <ZhQud1NbO4aMt0MH@bombadil.infradead.org>
 <b0789a97-7dcf-48aa-9980-8525942dabfa@oracle.com>
 <Zhg0_Pvlh9zy4zzG@bombadil.infradead.org>
 <6d8e98bb-24d1-49be-8965-b6afa97dfdaa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d8e98bb-24d1-49be-8965-b6afa97dfdaa@oracle.com>
X-Mailman-Approved-At: Sat, 13 Apr 2024 10:04:41 -0700
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

+ Dan,

On Fri, Apr 12, 2024 at 09:15:57AM +0100, John Garry wrote:
> On 11/04/2024 20:07, Luis Chamberlain wrote:
> > > So if you
> > > have a 4K PBS and 512B LBS, then WRITE_ATOMIC_16 would be required to write
> > > 16KB atomically.
> > Ugh. Why does SCSI requires a special command for this?
> 
> The actual question from others is why does NVMe not have a dedicated
> command for this, like:
> https://lore.kernel.org/linux-nvme/20240129062035.GB19796@lst.de/

Because we don't really need it for the hardware that supports it if the
host does the respective topology checks. For instance the respective
checks for NVMe are that atomics respect AWUN as the cap as the drive
already can go up to AWUN, and the limit for power-fail is implicit by
checking for AWUPF / NAWUPF. The alignment constraints can be dealt with
by the host software.

> It's a data integrity feature, and we want to know if it works properly.

For drives which already support this integrity is ensured already for
you. An NVMe specific atomic write command could be useful for for
existing drives for other reasons or future uses but its not a requirement
with the existing use cases if the NVMe alignment / atomic are respected by
the host.

> > Now we know what would be needed to bump the physical block size, it is
> > certainly a different feature, however I think it would be good to
> > evaluate that world too. For NVMe we don't have such special write
> > requirements.
> > 
> > I put together this kludge with the last patches series of LBS + the
> > bdev cache aops stuff (which as I said before needs an alternative
> > solution) and just the scsi atomics topology + physical block size
> > change to easily experiment to see what would break:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20240408-lbs-scsi-kludge
> > 
> > Using a larger sector size works but it does not use the special scsi
> > atomic write.
> 
> If you are using scsi_debug driver, then you can just pass the desired
> physblk_exp and sector_size args - they both default to 512B. Then you don't
> need bother with sd.c atomic stuff, which I think is what you want.
> 
> > 
> > > > > To me, O_ATOMIC would be required for buffered atomic writes IO, as we want
> > > > > a fixed-sized IO, so that would mean no mixing of atomic and non-atomic IO.
> > > > Would using the same min and max order for the inode work instead?
> > > Maybe, I would need to check further.
> > I'd be happy to help review too.
> 
> Yeah, I'm starting to think that min and max inode would make life easier,
> as we don't need to deal with the scenario of an atomic write to a folio >
> atomic write size.

And aligments constraints could be dealt with as well.

  Luis

