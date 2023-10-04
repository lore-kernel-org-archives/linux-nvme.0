Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C346E936EB
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Oct 2023 22:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8zIzwqHlLY+Qfqxn8xlWssJN81SYfup2U1XurU6Xi68=; b=Dpcue11p4KPD6hxyO6b9nz0L8v
	nEy9M1iQlbqs7POkBlVbH16eJSrENhJ0vSCcbtD41k1393i2Nl5hToefn1OO0LtmbKTeQrrvfFbYl
	0C3PC4TEcF/d9inJuuk6XEUtFDMlG+JhEy5h4wZZVyoTJiQnysmqpnW+73VQ+L3razuj7hOuTae1A
	A8nPlYHRgFCzw9DfiQm1ntb/KMCNm/+HB5xjVL8ymiwXKMpg9NppMdSEIQZZb99B0e9am/8MKYuzI
	KP5UouLWwwfQK1uwvyDd69DESxfJPYz8lHKYlxIecAaUaCrl9k5A0zzlEkwMpYE2hLuB0t7jMbo+f
	/wMLI2xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo9uY-000xfa-1J;
	Wed, 04 Oct 2023 22:00:06 +0000
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qo9uU-000xdN-1d
	for linux-nvme@lists.infradead.org;
	Wed, 04 Oct 2023 22:00:04 +0000
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3ae214a077cso241718b6e.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Oct 2023 15:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696456800; x=1697061600; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8zIzwqHlLY+Qfqxn8xlWssJN81SYfup2U1XurU6Xi68=;
        b=tFuK+Z3pR/JjTYhQL6Que5kZ8EImDKlxdrZl4A7KqyibWCueBD70NRu/OInVaf/+KM
         WHO5MslkIeIebFGLS7S9jvu6CLA3aSqwO1taaHMYHOPpOEVImSK8JdWbTk5uls2gsFBW
         71DVZKUkoqfRA5IMkFa+jqpc1enViKUHnob+kfkQ4nNVCK00uixcfA1Ce/EhliX7u9Uh
         enAZO4UJzbkP4cMHq3TCG+VaTFa+HwoVTphKT74hsTQuy81fygd2bmsRfRE6QtYykNWy
         Emjc11C8spMqTHT2G8tZIGV6IWXve4QohZn9M4aMU/ELvEmTWr5Z8l64iwE2N3Qu8SS5
         UKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696456800; x=1697061600;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zIzwqHlLY+Qfqxn8xlWssJN81SYfup2U1XurU6Xi68=;
        b=CkFgWU+JetpF1+q25Tp9k/SCKkd5Msgjp1rjNisYzA7VrrI3pXaNIxzwyLJZXhLqKy
         DEuZNBK4I+NL/byfR+zk1g5DTUBnMbnElfjoWI1rHWMVE1z2f5ZU2ta2r7tZiHZnhGMC
         94eV9X8sIuPGuI5q5soqSZtVbqQ9ajyY+8JpaH2+X3nzMzv1m2oZVn2Mit8RaIqhinvk
         NXBRRtCwMB2m9dJEUGp2TfWNIyH9JwH6HWEoXm5jnAf99SSbHY4Kji2NkB054q70ttda
         zd8VWXWli6b0fVMxLrUDvoYG7895ayPmKtfkivA9KW8Ko0b2ZTb8xwtBLOzYdxY0yWF9
         n2Vg==
X-Gm-Message-State: AOJu0YzSHea1M3Py02fbUMy5zEtHtFHltNnJOLaURzxFJgnq9Zbsb1l/
	+3+JInP0OTuObL97DNv37Yw4Bg==
X-Google-Smtp-Source: AGHT+IH/h109J3vK2RjmtyBZliPuvZyDqqzD7Zzri4BtaZwGs/8k8SoTtzUNYozX75NqP2QFf8pgiw==
X-Received: by 2002:a05:6358:8a2:b0:14b:86a3:b3f0 with SMTP id m34-20020a05635808a200b0014b86a3b3f0mr3841093rwj.5.1696456800389;
        Wed, 04 Oct 2023 15:00:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a018900b00274a43c3414sm2236230pjc.47.2023.10.04.14.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 14:59:59 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qo9uO-009W7k-1F;
	Thu, 05 Oct 2023 08:59:56 +1100
Date: Thu, 5 Oct 2023 08:59:56 +1100
From: Dave Chinner <david@fromorbit.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Message-ID: <ZR3gXHfIpn3eybh0@dread.disaster.area>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <1adeff8e-e2fe-7dc3-283e-4979f9bd6adc@oracle.com>
 <8e2f4aeb-e00e-453a-9658-b1c4ae352084@acm.org>
 <d981dea1-9851-6511-d101-22ea8d7fd31e@oracle.com>
 <e6c7b33c-38ba-402b-abdc-b783d4402402@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6c7b33c-38ba-402b-abdc-b783d4402402@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_150002_770074_05767398 
X-CRM114-Status: GOOD (  31.50  )
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

On Wed, Oct 04, 2023 at 10:34:13AM -0700, Bart Van Assche wrote:
> On 10/4/23 02:14, John Garry wrote:
> > On 03/10/2023 17:45, Bart Van Assche wrote:
> > > On 10/3/23 01:37, John Garry wrote:
> > > > I don't think that is_power_of_2(write length) is specific to XFS.
> > > 
> > > I think this is specific to XFS. Can you show me the F2FS code that
> > > restricts the length of an atomic write to a power of two? I haven't
> > > found it. The only power-of-two check that I found in F2FS is the
> > > following (maybe I overlooked something):
> > > 
> > > $ git grep -nH is_power fs/f2fs
> > > fs/f2fs/super.c:3914:    if (!is_power_of_2(zone_sectors)) {
> > 
> > Any usecases which we know of requires a power-of-2 block size.
> > 
> > Do you know of a requirement for other sizes? Or are you concerned that
> > it is unnecessarily restrictive?
> > 
> > We have to deal with HW features like atomic write boundary and FS
> > restrictions like extent and stripe alignment transparent, which are
> > almost always powers-of-2, so naturally we would want to work with
> > powers-of-2 for atomic write sizes.
> > 
> > The power-of-2 stuff could be dropped if that is what people want.
> > However we still want to provide a set of rules to the user to make
> > those HW and FS features mentioned transparent to the user.
> 
> Hi John,
> 
> My concern is that the power-of-2 requirements are only needed for
> traditional filesystems and not for log-structured filesystems (BTRFS,
> F2FS, BCACHEFS).

Filesystems that support copy-on-write data (needed for arbitrary
filesystem block aligned RWF_ATOMIC support) are not necessarily log
structured. For example: XFS.

All three of the filesystems you list above still use power-of-2
block sizes for most of their metadata structures and for large data
extents. Hence once you go above a certain file size they are going
to be doing full power-of-2 block size aligned IO anyway. hence the
constraint of atomic writes needing to be power-of-2 block size
aligned to avoid RMW cycles doesn't really change for these
filesystems.

In which case, they can just set their minimum atomic IO size to be
the same as their block size (e.g. 4kB) and set the maximum to
something they can guarantee gets COW'd in a single atomic
transaction. What the hardware can do with REQ_ATOMIC IO is
completely irrelevant at this point....

> What I'd like to see is that each filesystem declares its atomic write
> requirements (in struct address_space_operations?) and that
> blkdev_atomic_write_valid() checks the filesystem-specific atomic write
> requirements.

That seems unworkable to me - IO constraints propagate from the
bottom up, not from the top down.

Consider multi-device filesystems (btrfs and XFS), where different
devices might have different atomic write parameters.  Which
set of bdev parameters does the filesystem report to the querying
bdev?  (And doesn't that question just sound completely wrong?)

It also doesn't work for filesystems that can configure extent
allocation alignment at an individual inode level (like XFS) - what
does the filesystem report to the device when it doesn't know what
alignment constraints individual on-disk inodes might be using?

That's why statx() vectors through filesystems to all them to set
their own parameters based on the inode statx() is being called on.
If the filesystem has a native RWF_ATOMIC implementation, it can put
it's own parameters in the statx min/max atomic write size fields.
If the fs doesn't have it's own native support, but can do physical
file offset/LBA alignment, then it publishes the block device atomic
support parameters or overrides them with it's internal allocation
alignment constraints. If the bdev doesn't support REQ_ATOMIC, the
filesystem says "atomic writes are not supported".

-Dave.
-- 
Dave Chinner
david@fromorbit.com

