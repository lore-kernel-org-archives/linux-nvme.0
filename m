Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E059F436B4
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 15:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xFLTiMMKAFunIyu7ceKg8SWDzKCETKZieFq4JIwHgN4=; b=JklibkMmTVoK0Q+EG1VuKI43D2
	FcT04Dd9ez0JwPgb1lOwg1IgydgynmwKGOc+bsIigmOjQjprBSL9DK4hATHOHCoBLUxEeVgSVdqdO
	5ysZUgtzuDgX8rNP4AXO7AWrT2Swp931l6pdZgTPoYkCe20LD/9PBkR8FnAVwgbPt82lHIM2f1p+8
	w80FMwhMlufsZC/C75FBPbpTQst/CU3k4YxmOQQpHrBxqKXRcwWYM6C9KCYdzQXFFAtp3RF9BYjZS
	0u0UYo+muAKLTe1xiBWI8T4QX92AkNgmJUZuRc7OvgikjsQTBI0d7wOq9qj+pfhePahr4lWN/9WCu
	ajA95u7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDkqK-00000004BWY-0d4c;
	Fri, 17 Apr 2026 15:10:52 +0000
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDkqH-00000004BW5-29CK
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 15:10:51 +0000
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-40947c81b31so101658fac.1
        for <linux-nvme@lists.infradead.org>; Fri, 17 Apr 2026 08:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776438648; cv=none;
        d=google.com; s=arc-20240605;
        b=L/SlbJ89XeyKaS5U98Ha+yUig4cpwWQ3SOMFFtIfDibGqhndo29juUfezZo4IfFlC8
         qH3KW2E+32ncfspLk1OtRwja7qOC1EUpAzi+oVKLP/fvgOBdYdtAZfc1m3T2RA83fKYk
         OtqUpRVStMtjmd0c0MdoudhQJVnsUZo11z48L/KuGmu+YK4WXmWQhETcJ0bCuOg/taf0
         tekAPo+4Rku4JZv8gH3UJBFSQa+ETbNzn+AT+Z7BzfA+6DhBcHCyrmC9W5qDbQUjoBtA
         T5qMbislrLv55v5amr/Q+HVlFx3B5mN9X9jwxzgawlqNLzWOe4rQo566FPO0TH/CFu5h
         w3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xFLTiMMKAFunIyu7ceKg8SWDzKCETKZieFq4JIwHgN4=;
        fh=qSjku+Q93V4gr0zdW+yo7IQZji7qOyNJ4S64ssOUehI=;
        b=X97Bj03nQKSNeN2p4Gt/o8NehHGKwSv1A2T3LqVcknJZtXEDscMWnFKqxj3UFKTW7d
         7Kfc8rVX4KQZICJ+Rkqg9kYGa6najAasc/uG1keoY8U4wBJ7WEn0w/Fu8EG1i/jJJmW2
         nR97EjW982OPpYuarnm9z0oUcThtiOJpFpftihYfDo2H2Rw7T2Cjb0TMv1R0A2lBxjbn
         HsdIbzMWXK274KV8H5i/JmAts5WUtD+Rgku5CKrG9/GijRN4jqfrgEr2Q6uiq7bQliJh
         ci3SB5nWJ4e8sr6WNYcrOtk4nTe5Iq2CFW9V8Sr7XNbtRtcm/s4S+L5vJOBLC48zAZqY
         4xlA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776438648; x=1777043448; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFLTiMMKAFunIyu7ceKg8SWDzKCETKZieFq4JIwHgN4=;
        b=VFQvYEaTyoxx5BeC6tzvdnK1vvtB4Gx9bneDccNGSFFqWFuBW6NfhEDdV/26BGqNiq
         /wD1xBohiuvXlx6VJVS3qvZHXwE2zr77m4kv3zToyqVdoRAIPPclBzV9/DFdf2WtduZR
         au6C2uiOB7wsSK4P9YcMKtF/63QXylIodf93rMl13hO825czaW3kZkkUJe9XRneigw9B
         yQPTjMeRwFIzsftuYBMv3cP7VxVjZo7SoFIb2tZIo+/UXaezEB51kRF3+WjRqtn9C1b5
         riykAM1YXI944BJTpr5QY9c3qvFaHE/BFZHM2l4T6itwyXzLAFvjO66xVAvhDxMwnd0A
         T1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438648; x=1777043448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xFLTiMMKAFunIyu7ceKg8SWDzKCETKZieFq4JIwHgN4=;
        b=QesXcVOowQDFOa0aJoh+nJ9KQh1oVr32HvdrDr6PGHfGjWVxZLkrzfw5xHYYzmccIX
         cAHIleFGxtqsLnfXu0hCsBT7oEq/6OsTAoWzfZQ6VjtcjOZQj7gcLagkDvHIiS+5mQo0
         Bkm3fVgWWZNB7DjhJVM8jZnK31e1NzkmOwg/6nyqCmzwtr2XQdLJ/IMrM3h1c3bB+O+X
         ZIY1QGjRX50/6pWES39sYteEbFRghbAQRKCUWRGF9p9DLEEzhVbWMfrckj8dqFB3FhXE
         jduypb+Zt7gIjMySyypZKX+OilGjwv/zukwk+PRDAGuo8UrRdrqAbOcjDY8zC1wO20Gt
         ngTg==
X-Forwarded-Encrypted: i=1; AFNElJ9WABhnPI+LAMxm3jNyMk/uEQdN7D5HIvG4Y4pmgFMiq3kVam18XrNMDMVHyySzmUgLAZevqJPGJ+0u@lists.infradead.org
X-Gm-Message-State: AOJu0YzRYhf0V86bCYFIggogw7yd/yo7tUb+NVMRfeiuffgts/xKG63+
	2D8aPANIuc3XZCGhqsNIX89kN1L7nScunPNrWdGbitC7EHnOPs2sfoBGSTrseVs20BHQ76Y6hPB
	op4xmCt7CKc3Z8ZAEs2j/HWEqQG1D+5XWyf+830+B3A==
X-Gm-Gg: AeBDieuokLjnty9gnkh7oEx7At2IrlkNqrZ7RQQJ20oG+t6HuOOAM8rQcFphN9wdAZ7
	zLYkKEKK6Ru/QOaLGGxcB47avoLl+ALbDkVZxiDvnjfzbrJvKB+qlv1WwX3euPqFg4AwBUpa9Fl
	M9o8YJJaWmIa/B+h5h72XrTo0fu5W1vBYH/j132OlIU9z4KRDsmTQDS2lRZY/7XH55pSSb5cInG
	0h4kLjAmu/Wn0HHPiQ3sMceKEa8jQHAGVjMOC+JkkncRzZN/bxcXaC3zH/DTYF9Qw8s64d49dZq
	OcgNbqDY4REqd9U4PjXpp8yaqDC/Fw==
X-Received: by 2002:a05:6870:8888:b0:417:a04:483 with SMTP id
 586e51a60fabf-42abf22006cmr1173721fac.1.1776438647695; Fri, 17 Apr 2026
 08:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260417015732.2692434-1-csander@purestorage.com> <yq18qams3re.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq18qams3re.fsf@ca-mkp.ca.oracle.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 17 Apr 2026 08:10:35 -0700
X-Gm-Features: AQROBzAgZnPY6pX5OSwcczY9YUvRnJkbRQ4Ptv6iv7u-Y7bsDv654h6ccq-SxOo
Message-ID: <CADUfDZrwzUTi2TOj6M-+FtBK6u5evMsWSBqRDwJsLb8yLbOGvw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] block: fix integrity offset/length conversions
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_081049_712211_876BEB8D 
X-CRM114-Status: GOOD (  41.90  )
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

On Thu, Apr 16, 2026 at 8:26=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Hi Caleb!
>
> > The block layer's integrity code currently sets the seed (initial
> > reference tag) in units of 512-byte sectors but increments it in units
> > of integrity intervals
>
> I don't necessarily agree with the premise that the seed needs to be
> expressed in any particular unit. The seed is a start value, nothing
> more.

NVM Command Set specification 1.1 section 5.3.3 requires the reference
tag to increment by 1 per logical block, so that seems to determine
the increment unit:

> If the Reference Tag Check bit of the PRCHK field is set to =E2=80=981=E2=
=80=99 and the namespace is
> formatted for Type 1 or Type 2 protection, then the controller compares t=
he Logical Block
> Reference Tag to the computed reference tag. The computed reference tag d=
epends on
> the Protection Type:
> =E2=96=AA If the namespace is formatted for Type 1 protection, the value =
of the computed
> reference tag for the first logical block of the command is the value con=
tained in
> the Initial Logical Block Reference Tag (ILBRT) or Expected Initial Logic=
al Block
> Reference Tag (EILBRT) field in the command, and the computed reference t=
ag is
> incremented for each subsequent logical block. The controller shall compl=
ete the
> command with a status of Invalid Protection Information if the ILBRT fiel=
d or the
> EILBRT field does not match the value of the least significant bits of th=
e SLBA field
> sized to the number of bits in the Logical Block Reference Tag (refer to =
section
> 5.3.1.4).
> Note: Unlike SCSI Protection Information Type 1 protection which implicit=
ly uses
> the least significant four bytes of the LBA, the controller always uses t=
he ILBRT or
> EILBRT field and requires the host to initialize the ILBRT or EILBRT fiel=
d to the
> least significant bits of the LBA sized to the number of bits in the Logi=
cal Block
> Reference Tag when Type 1 protection is used.
> =E2=96=AA If the namespace is formatted for Type 2 protection, the value =
of the computed
> reference tag for the first logical block of the command is the value con=
tained in
> the Initial Logical Block Reference Tag (ILBRT) or Expected Initial Logic=
al Block
> Reference Tag (EILBRT) field in the command, and the computed reference t=
ag is
> incremented for each subsequent logical block.

The ref tag used for a particular block needs to be consistent. And
since reftag(block N) can be computed as the reftag(M) + N - M if
block N is accessed as part of an I/O that begins at block M, the
function must be of the form reftag(block N) =3D N + c for some constant
c. Thus, the ref tag seed needs to be computed in units of logical
blocks (integrity intervals); no other unit (e.g. 512-byte sectors)
works.
To see the issue with the current approach, consider an example
accessing LBA 1 on a device with a 4 KB block size. If the block is
written as part of a write that begins at LBA 0, its ref tag in the
generated PI will be 1 (sector 0 + 1 integrity interval). If it's
later read by a read starting at LBA 1, its expected ref tag will be 8
(sector 8 + 0 integrity intervals), and the auto-integrity code will
fail the read due to a reftag mismatch. This seems completely
unworkable for a block storage device.

>
> We happen to set it to the block number in the block layer since we need
> to be able to know what to compare against on completion (for Type 1 +
> the restrictive Linux implementation of Type 2). But that does not imply
> that the seed needs to be specified in any particular unit. Submitters
> set the seed to whichever value makes sense to them (i.e. it could be
> the offset within a file as opposed to the eventual LBA on the backend

I agree, the seed doesn't need to match the final LBA, but it does
need to be in *units* of logical blocks, plus some constant offset.

> device). And then that seed is incremented by 1 for each integrity
> interval of data in the PI sent to/received from the device. The
> conversion between the submitter's view of what the first ref tag should
> be (i.e. seed) and what is required by the hardware (for instance lower
> 32 bits of device LBA) is the reason we perform remapping. The seed is
> intentionally different in the submitter's protection envelope compared
> to the device's protection envelope.
>
> Using the block layer block number as seed was just a convenience since
> that provided a predictable value for any I/O that had its PI
> autogenerated. I never intended for the actual LBA to be used as seed
> value on a 4Kn device. Initially we just used 0 as the seed. Leveraging
> the block number just added a bit of additional protection.
>
> I confess I haven't tested 4Kn in a while since things sort of converged
> on 512e. But I used to run nightly tests on a SCSI storage with 4Kn
> blocks just fine.
>
> > This looks to be a longstanding bug affecting block devices that
> > support integrity with block sizes > 512 bytes; I'm surprised it
> > wasn't noticed before.
>
> Are you seeing this with NVMe or SCSI?

With a ublk device. It should affect any block device that supports
integrity and has a logical block size > 512.

Best,
Caleb

