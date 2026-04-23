Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71DBFDEE2F
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c1lJLEbyeroH+TWcwZkpKsknFGLHTffQF4tuZQJcp3k=; b=kPU3Gex4efDwIzBrOH2MsPRtbp
	iq1q/5y1jURYP+jsBdTngIWureRqQMLS37SX3kJLxZ2xCMU8RpAqx2rnqEErkeXOy6F54cSxau/62
	lowvgl3k89T/b8TYCELwoMOrvIYyMVPl+u513oPnPnpwk8+/KsTcCzqV7DsWX6xkjNh80D0QZYmby
	xNXLnLcJzghmztBT6kW+3ejgUvalMuxkvyMdb1UW9/oe18nkT3VRuOGpNYgvJg52g6DZ1VjrZ3Nyw
	+7FVDSnS0JXnDyVJiSVzjVeXBl09xl6EBqDntYja9X5z3tvJAc1v6oxSAQnT1lm2s91d4dRVq0o5U
	prav3FdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFyOM-0000000C6Gv-3J94;
	Thu, 23 Apr 2026 18:03:10 +0000
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFyOF-0000000C6Fx-1Z9N
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 18:03:10 +0000
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-69490c91241so217593eaf.3
        for <linux-nvme@lists.infradead.org>; Thu, 23 Apr 2026 11:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776967381; cv=none;
        d=google.com; s=arc-20240605;
        b=OLfo7CS3HZ+yZt3WslPi79hHtz/kPPCZdzSPSC1+sMrBkI852EXnO7wJn/v/LwmFCu
         5QaUvssEhMNYL+8tntAEMHdEcCVgC+KXXdZ9IclmSa6+PFgOxEtYVbrf6DJP0xuDGzB1
         iq2m+9tHfw461ufotB3htE6OIyggpQZjzDpX0hr53GaE3SvfIcIDssy20ENUs06sWPoJ
         SPiG5R63M7lgzV9V+SktaAdcOoM/IqL5Hj2mOQBF/SIcrzFrSd6sM9cONjt3pbKXUIR+
         ncd+gyzVlk5rYt6Xda0El3gLamUX/A+7VH9m5fzvCoPFoZLvgRYY9dL7VVocK1RvwBzF
         dqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c1lJLEbyeroH+TWcwZkpKsknFGLHTffQF4tuZQJcp3k=;
        fh=Etrp1soOVuC8vzERiuw8ZGzxNNrJ+zsHwd8uwb/oAw4=;
        b=gAWmv92P9mMaqrgOsIHJh1j7CItL0pWjWinEg9CogH1klLxGJbCyhUDI3O4Vbq5442
         q6VnaGNbfR6FWVHTsFj+nRb8/I6tRR1gk5yvttVh/lkyaZslg1OBWIcVgNjCpcI5ZMTr
         yhPF+5l6+lqQ8hp9FWclHEQK84oKIvYviCqBjNFabGOcSWz7z7WHOlW8u28mN809ofAA
         Hz13Y9NNMi9UuX/NLgX007wChNlfxBrgMGom2PVjZs0B0LwGluLmpM8HxwddiWtaWXEH
         8sS5t9BtnlUNKzixUx+jg6bYxPG2dXEchkssj3TUqYtNvTf8amWI/YtjXVXUyye13HFv
         KmfA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776967381; x=1777572181; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1lJLEbyeroH+TWcwZkpKsknFGLHTffQF4tuZQJcp3k=;
        b=Jr2RR+rDkrQ5xFZ27ADgPAIRO+WPbvl9DWYZIAWeZwl4qrDwdUnqHoXHtbc+0sCh+f
         KH7ZqRvNDFiHhVT3DbEz4bCkFpHe3ek/MEXVogTL89WWUWX49G6QiUkgkOYTdJUDJ6J5
         0BGZNF/7lTIO12XWh+OU5c5/65pBx+EGsfXMZSuLasG+gPV785fE22nQ8Nop+alspG7f
         C99ZrsueokWAI4W1MQa6tMTX94eSWMuDHL++sKA5pvlkGpvX8booqgswkjPu3wrBkvBx
         Z5SGONZMyNKaLdqYTg5Ffdtx5jdTXnPsG8VmrE6XZ5dKgCmc7NzRLs031N9WwQ2z9EE1
         Os4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776967381; x=1777572181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1lJLEbyeroH+TWcwZkpKsknFGLHTffQF4tuZQJcp3k=;
        b=p4zFSF0+FWG0EUSfjO25cBE5O3BW6tJutgsdXcRF8/7zJePMAMAVF3Bm8eNwuD6cZz
         0AVjaizKokbhx1/yO99xc2IpULxRP29kwuXU2Cs6fql88sWGKfoOCMurf2bAaFQGefUu
         nvl5MfUZRHxNBucMGiVfYNrMfj/SZX5sDCMDffkU5bCt3o+XQ7cCnXDTo2rCCBSrbkMd
         ealyahFGIVGP/A1rYDBSQHeil6irWjTvaIl1HzE/iNzFDeSzgBjhIzE2urcXEkOpgOh6
         eouk1cMAhjlzCWuVqQQOU2IQ5bgEbDGW2+mZt93h+ClBhtWq1yZSs6ReTa6hROnxdy8k
         75ag==
X-Forwarded-Encrypted: i=1; AFNElJ9PhU9mLuA7zIpQvFq02R+ZOZshN23wPw0GyD21fEePHJVeoQpGiDBghvXmHDpi5/uhFVnZHVfGs60P@lists.infradead.org
X-Gm-Message-State: AOJu0YyGu9Yu41XvxzQpJLppDlUAyCNc91Ul+vGQH86Oj3yLzJQwYps5
	EAcz18+vTR2qlVA9HasDaXjKkxx4Neb/kIrjCrII4I1HfUKuTjdp2cEyeHSMxwt/Kh6osxmHrLL
	E9fulpRJBYywNZYrdKsZSsbCaadXtRfHww6Yj0kXy0A==
X-Gm-Gg: AeBDiet/kf1f/HLQTIVIy0YwRIpsYhhocm8geSe9hSDiV/U/fz+7/1lE6OkI1EWTfY5
	MCnscS8nLFUd5RTdHDnDQhOWEXv0zyLsOIvvuL3oAkp3JPJIE2Daqtv4cz/QLtpH+BrdtOC705h
	/m+v5X11dATmoFNubDF/4+Tiwlx3bHsIGNLGHoPHh9Abyv52Kdj4mFeg6dklWhddFdO5g2Gl8WG
	HU2NX5zfOtPfCLe7mhY0XOtqy/NroO6x7fJRCSArKlhwNjk9+8U/E7XCMNogxwe/4x0AL9yCCwt
	viLuNW3Jfgc87P7DKbo=
X-Received: by 2002:a05:6870:16f5:b0:42c:1e12:6bac with SMTP id
 586e51a60fabf-42c1e13c7b0mr5869827fac.5.1776967381259; Thu, 23 Apr 2026
 11:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260417015732.2692434-1-csander@purestorage.com>
 <yq18qams3re.fsf@ca-mkp.ca.oracle.com> <CADUfDZrwzUTi2TOj6M-+FtBK6u5evMsWSBqRDwJsLb8yLbOGvw@mail.gmail.com>
 <yq15x5lqfdx.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq15x5lqfdx.fsf@ca-mkp.ca.oracle.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 23 Apr 2026 11:02:50 -0700
X-Gm-Features: AQROBzCpAwBKjPdeKRy_iDk99MgWov4WGujklh5E85jOlbENhysKrBryAPvMMQQ
Message-ID: <CADUfDZqkT4g3T6uE=hxt9J6JDMXbJt49rM7_Vgs3EBPdFeuuLw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] block: fix integrity offset/length conversions
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_110303_448530_31980B99 
X-CRM114-Status: GOOD (  38.81  )
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

On Mon, Apr 20, 2026 at 7:09=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Hi Caleb!
>
> > NVM Command Set specification 1.1 section 5.3.3 requires the reference
> > tag to increment by 1 per logical block, so that seems to determine
> > the increment unit:
>
> SCSI allows PI to be interleaved at intervals smaller than the logical
> block size. This was done for PI compatibility in mixed environments
> with both 512[en] and 4Kn disks. Interleaving allows 8 bytes of PI per
> 512 bytes of data on devices using 4 KB logical blocks. That is the
> reason why we use the term "integrity interval" instead of assuming
> logical block size.

Thanks for the explanation, I'm not too familiar with SCSI. I meant to
refer to integrity intervals in my explanation if they differ from the
logical block size.

>
> > The ref tag used for a particular block needs to be consistent. And
> > since reftag(block N) can be computed as the reftag(M) + N - M if
> > block N is accessed as part of an I/O that begins at block M, the
> > function must be of the form reftag(block N) =3D N + c for some constan=
t
> > c. Thus, the ref tag seed needs to be computed in units of logical
> > blocks (integrity intervals); no other unit (e.g. 512-byte sectors)
> > works.
>
> Whoever attaches the PI decides on the seed value. In the case of the
> block layer it made sense to use block layer sector number since that
> value is inevitably going to be the same for a future read.

I'm not following "going to be the same for a future read". The block
can be read back by an I/O with a different starting
offset/sector/seed, as my example illustrates. When the integrity
interval size differs from the sector size (512 bytes), mixing the two
units results in a different ref tag seed for the block depending on
the starting offset of the I/O.

>
> Note that with MD, DM, and partitioning in the mix, the sector number
> seen by whoever submits the I/O is going to be different from the LBAs
> on the target devices which eventually receive the I/O. Nobody says
> there is a computable constant offset. Think scattered LVM extent
> allocations. Or RAID stripes placed at mismatched LBA offsets.

The constant offset relationship still needs to hold over any
contiguous range of a backing block device that can be accessed by a
single I/O. For example, with partitions, it's not possible for a
single I/O to cross a partition boundary, so each partition can have a
different constant offset between the ref tags and absolute integrity
interval numbers. With RAID, each shard can have a different constant
offset. etc.

>
> > To see the issue with the current approach, consider an example
> > accessing LBA 1 on a device with a 4 KB block size. If the block is
> > written as part of a write that begins at LBA 0, its ref tag in the
> > generated PI will be 1 (sector 0 + 1 integrity interval). If it's
> > later read by a read starting at LBA 1, its expected ref tag will be 8
> > (sector 8 + 0 integrity intervals), and the auto-integrity code will
> > fail the read due to a reftag mismatch.
>
> Something is broken, then. Because the ref tag in the received PI should
> have been remapped to start at 8 in that case.

Ah, I missed the remapping piece. Thanks for pointing that out. I
guess I was testing with a ublk device that doesn't advertise
BLK_INTEGRITY_REF_TAG. Since commit 203247c5cb97 ("blk-integrity:
support arbitrary buffer alignment"), the ref tag is unconditionally
set in the PI from the (sector) seed, but the remapping is conditional
on BLK_INTEGRITY_REF_TAG. That explains why I was seeing ref tags in
the PI that didn't match the integrity interval numbers.

So seems like patch 1 ("block: use integrity interval instead of
sector as seed") doesn't need a Fixes tag. Still, I'm confused why the
auto-integrity code bothers setting the seed to the sector number in
the first place if it's going to be remapped later. Why not just leave
the seed zeroed?

Best,
Caleb

>
> > I agree, the seed doesn't need to match the final LBA, but it does
> > need to be in *units* of logical blocks, plus some constant offset.
>
> Your concept of "unit" still sends the wrong message. The seed is an
> integer value used to initialize a counter or hardware register. The
> seed only has meaning to whichever entity submits the I/O. To everything
> else it is a value used for remapping ref tags from the I/O submitter's
> point of view to whichever interpretation is mandated by the storage
> hardware's PI format.
>
> > With a ublk device. It should affect any block device that supports
> > integrity and has a logical block size > 512.
>
> It sounds like the seed value is set incorrectly for reads in your
> configuration.
>
> --
> Martin K. Petersen

