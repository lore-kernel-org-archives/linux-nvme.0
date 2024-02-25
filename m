Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21E6C47DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Feb 2024 23:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l7a9pYx80wW5C+0OOLf7V/OKZTSHuwOcmWS8SrHVorg=; b=Koyp5a9Of96uZQ0iAA2bswzvur
	oVdnE5dFW3CbyJOoRPcjuzZmOIEE6aWJT+LHkJ98NCiL0Ou5LK5bWU3bo/TGDsGC4wEH+Kum9ROAj
	d2OTunSDPXzpO+F+0awruWEAdCNvdlliTSFkwvw5ga7Y8vPXCVZDEW0wESd3yAgk1HHNz2xXtH5pY
	i1yh4B2eeYzm0JI7SKftNzfIBaYc2WDCmepENWk81nKZh+R+M+GAKgzDXAjQQ7eSBMvVT2jPFQPw+
	2UhXCdajxZyLRZ+na24xcucfeCiJyO6sBMIr9CKrRls4EvfLaYXAtWCMG5d4r3FM65sujOLjDAhDI
	kCWI+eVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reNcW-0000000FuYR-24QC;
	Sun, 25 Feb 2024 23:09:20 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reNcQ-0000000FuXJ-47KG
	for linux-nvme@lists.infradead.org;
	Sun, 25 Feb 2024 23:09:16 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2275080a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 25 Feb 2024 15:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708902552; x=1709507352; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l7a9pYx80wW5C+0OOLf7V/OKZTSHuwOcmWS8SrHVorg=;
        b=b+6Skt5M0aoHcBo5UyrWyt5Se/qH/6jvx6POJgBrVAKmeDXo9TlNrSG+Nq2G6SPwNP
         zTh8Kc17XN9mrsNtpWRpEYYRJdoriyFOvA79SxXFCmSj4AwWETi1VpVSiYWbCI7wAJFB
         PR1cV3O0KzMRLxj57i2ylgv7jQowkkbfHeDmfyoywLR/2Aqd/NZRdXd+FJvfkqIJMeBS
         cvdrgI2glq2gsorK0MoHBJFdiBRoYGOgCPvEmUUsa6dxy9FiVNk21oaeUYgZRuiAWy0C
         +G891uKl2dX7RavTgMO7VcpM+dvfh0mrejgreufpGVazNJ/xLoqwTPdLpknYXYMEqHRH
         daSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708902552; x=1709507352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7a9pYx80wW5C+0OOLf7V/OKZTSHuwOcmWS8SrHVorg=;
        b=rQdnsopo1Z7BHeXiGacIjgKv6NR5ZHcfoJfDbjbNY+bQ0jJ4Ai42YifIIa0E2Rv8KB
         oP9THdL8hjmNJaCBQSXrHAe2+AtCccpRJzq5I/rjP8bNOInRBzr9kKRAdHlc9bGmCaj2
         pqxODOAUIJsuvdrtVNrR70rN2zFohkmlgvNoIxGJDKED5QDcYBXetUkbzNa6j1zpFJVJ
         MjYeybVhDXXCWWRV6zNad5/2U5Yb59dqMUzyG1XXviaMrq2JrZecBFIQrlnFlpIaIPe4
         2t4qPSlcwz3Upnd5J5sE+8nTG7EhqP70k8YIF+Z1D7ox1opq5x/ix0/pcv9tC1pFsRBW
         z2og==
X-Forwarded-Encrypted: i=1; AJvYcCVK2a7HEXzeneBQhdNJb4dgmmtoK+fqsD4TGIBbT+kMF7fluQ8OtNKAB/m5zCg9IP3PZW2dVxYm4rvIlCPFGApk0ab6iz/r4t5NEHYDPwk=
X-Gm-Message-State: AOJu0YxKJrPqrHd4Tvuh3hjA3q71h+2cORR7+R9I1KgoMzWihQAtzGW9
	K7AHFTQCC0U5vYETzHjODGuEhs7kkz284McxQCZzR4IYDlQHgzhYZMf/GM48i60=
X-Google-Smtp-Source: AGHT+IF7Q1OsYYh07q3WF9Mui45ZkhG22+fhtpowOBILiP+qRKRpg66hFJe8Zc3/frwdBVhcPIiQGA==
X-Received: by 2002:a17:902:dac9:b0:1dc:623d:1c3f with SMTP id q9-20020a170902dac900b001dc623d1c3fmr8618092plx.6.1708902552513;
        Sun, 25 Feb 2024 15:09:12 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id jj5-20020a170903048500b001dca9316374sm26662plb.147.2024.02.25.15.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 15:09:11 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1reNcK-00BVIu-0x;
	Mon, 26 Feb 2024 10:09:08 +1100
Date: Mon, 26 Feb 2024 10:09:08 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jan Kara <jack@suse.cz>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>,
	Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linuxfoundation.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Message-ID: <ZdvIlLbhtb7+1CTx@dread.disaster.area>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
 <ZYUbB3brQ0K3rP97@casper.infradead.org>
 <ZYUgo0a51nCgjLNZ@infradead.org>
 <9b46c48f-d7c4-4ed3-a644-fba90850eab8@acm.org>
 <ZZxOdWoHrKH4ImL7@casper.infradead.org>
 <ZdeWRaGQo1IX18pL@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdeWRaGQo1IX18pL@bombadil.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240225_150915_282963_7342E87C 
X-CRM114-Status: GOOD (  50.85  )
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

On Thu, Feb 22, 2024 at 10:45:25AM -0800, Luis Chamberlain wrote:
> On Mon, Jan 08, 2024 at 07:35:17PM +0000, Matthew Wilcox wrote:
> > On Mon, Jan 08, 2024 at 11:30:10AM -0800, Bart Van Assche wrote:
> > > On 12/21/23 21:37, Christoph Hellwig wrote:
> > > > On Fri, Dec 22, 2023 at 05:13:43AM +0000, Matthew Wilcox wrote:
> > > > > It clearly solves a problem (and the one I think it's solving is the
> > > > > size of the FTL map).  But I can't see why we should stop working on it,
> > > > > just because not all drive manufacturers want to support it.
> > > > 
> > > > I don't think it is drive vendors.  It is is the SSD divisions which
> > > > all pretty much love it (for certain use cases) vs the UFS/eMMC
> > > > divisions which tends to often be fearful and less knowledgeable (to
> > > > say it nicely) no matter what vendor you're talking to.
> > > 
> > > Hi Christoph,
> > > 
> > > If there is a significant number of 4 KiB writes in a workload (e.g.
> > > filesystem metadata writes), and the logical block size is increased from
> > > 4 KiB to 16 KiB, this will increase write amplification no matter how the
> > > SSD storage controller has been designed, isn't it? Is there perhaps
> > > something that I'm misunderstanding?
> > 
> > You're misunderstanding that it's the _drive_ which gets to decide the
> > logical block size. Filesystems literally can't do 4kB writes to these
> > drives; you can't do a write smaller than a block.  If your clients
> > don't think it's a good tradeoff for them, they won't tell Linux that
> > the minimum IO size is 16kB.
> 
> Yes, but its perhaps good to review how flexible this might be or not.
> I can at least mention what I know of for NVMe. Getting a lay of the
> land of this for other storage media would be good.
> 
> Some of the large capacity NVMe drives have NPWG as 16k, that just means
> the Indirection Unit is 16k, the mapping table, so the drive is hinting
> *we prefer 16k* but you can still do 4k writes, it just means for all
> these drives that a 4k write will be a RMW.

That's just a 4kb logical sector, 16kB physical sector block device,
yes?

Maybe I'm missing something, but we already handle cases like that
just fine thanks to all the work that went into supporting 512e
devices...

> Users who *want* to help avoid RMWs on these drives and want to increase the
> writes to be at least 16k can enable a 16k or larger block size so to
> align the writes. The experimentation we have done using Daniel Gomez's
> eBPF blkalgn tool [0] reveal (as discussed at last year's Plumbers) that
> there were still some 4k writes, this was in turn determined to be due
> to XFS's buffer cache usage for metadata.

As I've explained several times, XFS AG headers are sector sized
metadata. If you are exposing a 4kB logical sector size on a 16kB
physical sector device, this is what you'll get. It's been that way
with 512e devices for a long time, yes?

Also, direct IO will allow sector sized user data IOs, too, so it's
not just XFS metadata that will be issuing 4kB IO in this case...

> Dave recently posted patches to allow
> to use large folios on the xfs buffer cache [1],

This has nothing to do with supporting large block sizes - it's
purely an internal optimisation to reduce the amount of vmap
(vmalloc) work we have to do for buffers that are larger than
PAGE_SIZE on 4kB block size filesystems.

> For large capacity NVMe drives with large atomics (NAUWPF), the
> nvme block driver will allow for the physical block size to be 16k too,
> thus allowing the sector size to be set to 16k when creating the
> filesystem, that would *optionally* allow for users to force the
> filesystem to not allow *any* writes to the device to be 4k.

Just present it as a 16kB logical/physical sector block device. Then
userspace and the filesystem will magically just do the right thing.

We've already solved these problems, yes?

> Note
> then that there are two ways to be able to use a sector size of 16k
> for NVMe today then, one is if your drive supported 16 LBA format and
> another is with these two parameters set to 16k. The later allows you
> to stick with 512 byte or 4k LBA format and still use a 16k sector size.
> That allows you to remain backward compatible.

Yes, that's an emulated small logical sector size block device.
We've been supporting this for years - how are these NVMe drives in
any way different? Configure the drive this way, it presents as a
512e or 4096e device, not a 16kB sector size device, yes?

> Jan Kara's patches "block: Add config option to not allow writing to
> mounted devices" [2] should allow us to remove the set_blocksize() call
> in xfs_setsize_buftarg() since XFS does not use the block device cache
> at all, and his pathces ensure once a filesystem is mounted userspace
> won't muck with the block device directly.

That patch is completely irrelevant to how the block device presents
sector sizes to userspace and the filesystem. It's also completely
irrelevant to large block size support in filesystems. Why do you
think it is relevant at all?

<snip irrelevant WAF stuff that we already know all about>

I'm not sure exactly what is being argued about here, but if the
large sector size support requires filesystem utilities to treat
4096e NVMe devices differently to existing 512e devices then the
large sector size support stuff has gone completely off the rails.

We already have all the mechanisms needed for optimising layouts for
large physical sector sizes w/ small emulated sector sizes and we
have widespread userspace support for that. If this new large block
device sector stuff doesn't work the same way, then you need to go
back to the drawing board and make it work transparently with all
the existing userspace infrastructure....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

