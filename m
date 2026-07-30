Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3C3C5516E
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 19:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t6BYf/vhUmmfT2XVF/nKwUPMf142vX+Enh9mieavPbw=; b=nbFneXmAIvjetL2Hbrl2OAuhan
	EZuVoxsav8XpR0cA+KEooBwyKUJFqHFIXmzhJd7oFtdtFTMffuFRL4wIywWngLwKLBa33KHS6lWzt
	M3A4NM6CfFIAA+nJ6grCIdmA2uwDjxwTajUcOKpR23tahYVnrAXR2FBrPuWvfvCBf3oZPelmXnNMA
	AVUhQwYAIZW7INR0+gqyWMusBxVqtePDsOivnQ+ExrNs+O7pP2IFOt85ZfJ9tITB9ZZzJG92gHobW
	bXQ68o80vuTU3SpqkoV+QVkQitfrVk7sgoNOc0oL9sMsGSgSnIbjrJyLitTJHwZ5jqLjdOg8Hm4wQ
	VvWVMEVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpWes-0000000BGFd-2nfe;
	Thu, 30 Jul 2026 19:43:10 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpWeq-0000000BGFD-3Ahp
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 19:43:09 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-69f2c67650aso294074a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 30 Jul 2026 12:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785440586; cv=none;
        d=google.com; s=arc-20260327;
        b=IFgoRhcglIoOxviIq09p6uAsH8TX221DFTWO4GnpldThYImiA6jNh01VDimQZo0r3X
         IPQ5Vjecn7/EEoee6p6/jQny53y2XufMOx8+5CV6ItpGgp6MKwtitOGT1JwEaJm3GLc2
         J577QB1+jHc8EjI97qMUJSJGy962c6mMFGzoocUt5LT3VFnPSFN27sdGUEx55wpunSrD
         n8s51TmO8X3XwdrqmwQHAuDUZFeIriMsSPkcoNFB3bRrwsm1HwKXV5zEupydY4jmYieb
         zsXUgbq6N9fOaQ0peuGev+WXS/R+Y/lCTO+thPCy+Q38ahlaW17rQ1joVlU/I8Ma2Ssc
         La1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t6BYf/vhUmmfT2XVF/nKwUPMf142vX+Enh9mieavPbw=;
        fh=McR2eZtss3LfRpxA1X32XZ+ubbkkREnE8bbOAmUPVrA=;
        b=K1HlJ5pUTP8LkSAmy2OIDEPxc2FhDT0NVI/xBdzzvxJgl6fUsS6lZIsY3u5EwQZU50
         oTb7fLrDgPqRuaKt8n73P9gHLGlep4f1RxCrkXzFnRxaL9ek9PyK3lRSkWPtaU7r+Rhs
         aAx+7v+8KDilnN0mZhikJYfht/w1UdtGaLNzSqZLx9mmIYBK354kUPq6dU40lXEKbhy9
         CqefFXDxnWBrEfjvwgQ2l6MYhhgPsywFyMxEjUH6Ntc3gK/iCXdzoI+fVzm4AXm5sXSb
         wjvqdGnqWweOWmudNOdxY6nvbTm2s7AT2ZihOK5An4PppH8Pu3UqIMFYaGMQnDXhVeQ0
         P7IA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785440586; x=1786045386; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t6BYf/vhUmmfT2XVF/nKwUPMf142vX+Enh9mieavPbw=;
        b=AiWSt4xyaS+YnpiogSbOeby46UHlNGQVzFtVJl/7EYkBneXqQqe4ElAExoHzEQmYpX
         Wz2v1N+TkvqFcQAYY+MalV2Ttx5WDev/u4fNEi+AIbjN+ATqJJ+BR2wiXWSNVQ18uoJ8
         QwTzk66hIDl0A6u2bs7FBzDHPp+j1rR7NHYNkwNyYBroXcZyVZl9wVyWqPnA5V4YkNAp
         Xo1VxBVr5CwLpw14FGDHHFcz7IdznwI1JN7/A4TIoygW8Ww39ID/5O2jHGwAty1SDukh
         fSjdVSNXFAMhO6EBH3XtDm6YsFESd+JX8AQyU/nl/UGhUO0DTsNvJoUGWqoXvDz2ihdm
         dnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785440586; x=1786045386;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6BYf/vhUmmfT2XVF/nKwUPMf142vX+Enh9mieavPbw=;
        b=DMhfEkc1BzipfoEjh+WEWYlfb638cIzR4poNAfQ04zbbeyjV8tdv3voSTjX9lNfwGV
         xafFToz+iuWiCpMo6J2+U6vQVtTp5zh8pEPj4z5HGiiQ5pV41+mzmVZZJyFyMJ7xYJD+
         +4go2mjSahz5i1h6reCJtLNtNiCJAAuoINBlNxR/qVjg+vC0izSYdJb/6jvt/lk7JsgA
         PoGTSNdvboK8YjoxV75yh6vhiD8D8J+POqYk/xB0e45Bekl8g/vKzpIbCJsLcd/0o1Vu
         /S0YpI6/l1RzVu9xWfvDjUtLGeOHAWiddJOEoeFZVwFnhPBlUvIBFMLi3ACpcoMkzbCY
         xzMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLvTYd5c8u91OsEpdq0e3+0mPih7yxO8DJEwA7SrsiNxuzpuj9lB/IGD2KO82CchPWYb1ZzgoyecoA@lists.infradead.org
X-Gm-Message-State: AOJu0YwNMGkblNKiH2mLbStEmMjZkoJoPAu9U3BUk1fKuV3fH6aqg9kZ
	7yjCrp4KSHf+Gtk2cS2vSihJnVqODIDbqkCVOaCESdlsQtmx9y/z93fRtKnlxQBMD3sTCmtCO19
	fiL2oR/dgrEYqocxXTaXdvrTp54fEcJ8=
X-Gm-Gg: AR+sD11MH5U6BifPyCmB25GMEVOxjilzjw/8dFksYlgt9HSDfrxuUuqWhkOJqyuuDBX
	51wMCAw3OGTKfKZXQms1B55TFgU6/+jrArRU2G7GBbkO3B5BG81tLZc+J65JIalwLRoWMnDRiao
	KIIk66dUUOrJtbm7HFpGvUWgtD1LY18Rnoa6LseCPIqxf48u/X8gcR9QfNV35gq1I1Fx/a1/sz+
	5Echo3B3bqhSPJtLWcaL8oH0QNECQSHGolYwhK5ApgbZ6dLxk+nLVihCjIrhojHH9WtNG+YIBTY
	xPfuac9HRU25VVEjzgsQji+rDmrSJvx1KHp4LERcxZDSzK2aImouYS2K
X-Received: by 2002:a05:6402:5191:b0:69c:794d:4862 with SMTP id
 4fb4d7f45d1cf-6a07b7c2ed2mr1788382a12.7.1785440585803; Thu, 30 Jul 2026
 12:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260727201257.211635-1-coshi036@gmail.com> <178532422849.2568853.3142469605707392497.b4-ty@b4>
In-Reply-To: <178532422849.2568853.3142469605707392497.b4-ty@b4>
From: Chris S <coshi036@gmail.com>
Date: Thu, 30 Jul 2026 15:42:53 -0400
X-Gm-Features: AUfX_mxV3jqmHc6ady8mMlUy2DEKG0LSXNTFo-1cI8WmoWvjWUgkBWPSF8mq708
Message-ID: <CACd_6n0PY0RYtrWb_FdC572J6Gh6t8GvaJhUHi6P3yA5_wmyRQ@mail.gmail.com>
Subject: Re: [PATCH] block: stop the timeout timer when releasing a never
 added disk
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Weidong Zhu <weizhu@fiu.edu>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_124308_826104_9DE3DC2C 
X-CRM114-Status: GOOD (  23.99  )
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

Hi Jan, I'm currently working on the changes we discussed.  Based on
vfs.all now.  Four things came out of writing it that I would rather
resolve before posting.

1. mark_buffer_write_io_error() is not safe for jbd2's buffers yet.  It
dereferences bh->b_folio->mapping directly (fs/buffer.c:1057), and
jbd2_journal_write_metadata_buffer() points the temporary bh at
virt_to_folio(jh->b_frozen_data), which is slab-backed.
buffer_set_crypto_ctx() right next to it already uses folio_mapping() for
exactly this reason.  So I would send a prerequisite converting
mark_buffer_write_io_error() to folio_mapping() before the jbd2 change.
Also worth noting the consequence of A2: in ordered mode the temp bh
inherits the source folio, so the error lands on the bdev mapping and
mapping_set_error() errseq_set()s s_wb_err - a later syncfs() on an
unrelated fd of the same fs can then return EIO.

2. gfs2 already has what we are building: gfs2_end_log_write_bh()
(fs/gfs2/lops.c:171) calls mark_buffer_write_io_error() and does not clear
uptodate.  Which means fs/gfs2/log.c:110 and :324 are blind to log write
errors today, and converting them is not behaviour-preserving - it makes
them start catching those.  I think that is right, but say if you would
rather it were separate.

3. On the sticky BH_Write_EIO: I am adding it to BUFFER_FLAGS_DISCARD as
you suggested.  That covers discard_buffer(), but there are four other
clear_buffer_req() sites (fs/buffer.c:1687, fs/gfs2/aops.c:600,
fs/jbd2/commit.c:1035, fs/jbd2/transaction.c:2462).  Three of them also
clear_buffer_mapped() and NULL b_bdev, so __bh_submit()'s
BUG_ON(!buffer_mapped(bh)) makes them unreachable.  Only
clean_bdev_aliases() leaves the buffer writable, and I could not construct
a workload that reaches it.  So I am not sending the ungating patch.  The
one place it would matter is ocfs2: fs/ocfs2/journal.c:691 is nested
inside an if (!buffer_uptodate(bh)) at :675 that goes dead once the clear
is gone, so :691 has to be hoisted out, and it then becomes a pre-use
check on a sticky flag rather than a post-write one. I will Cc ocfs2-devel
on that patch.

4. fs/jbd2/transaction.c:923, J_EXPECT_JH(jh, buffer_uptodate(bh)) in
jbd2_freeze_jh_data(): after the series a failed write leaves the buffer
uptodate, so this stops firing for write errors.  Arguably correct - the
in-memory copy being frozen is still valid - but it is your assert.  Leave
it, or convert it?  I instrumented it and ran ext4 with data=3Djournal unde=
r
injected write errors, forcing copy-out; it never saw a non-uptodate
buffer, so I have no evidence either way.

One thing I did settle by testing.  fs/ext4/ext4_jbd2.c:416 open-codes
buffer_req(bh) && !buffer_uptodate(bh) after sync_dirty_buffer(), which
already returns -EIO.  On an instrumented kernel (ext4 without a journal,
-o sync, injected write errors) the two agreed on all 40 occurrences and
never diverged, with BH_Write_EIO set every time.  So that site just
consumes the return value and the buffer_req() question goes away.

Best,
Chao

On Wed, Jul 29, 2026 at 7:23=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
>
> On Mon, 27 Jul 2026 16:12:57 -0400, Chao Shi wrote:
> > disk_release() undoes blk_mq_init_allocated_queue() for a disk whose
> > probe failed before add_disk(), but it only calls blk_mq_exit_queue().
> > Nothing there stops q->timeout, and that timer rolls forward: it stays
> > pending until it next expires, not until the last request completes.
> > So if the driver issued any I/O before adding the disk, the
> > request_queue is freed while still linked into a timer wheel bucket.
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] block: stop the timeout timer when releasing a never added disk
>       commit: 26cb8ebbfaf713c82e142d08828d4d765057633b
>
> Best regards,
> --
> Jens Axboe
>
>
>

