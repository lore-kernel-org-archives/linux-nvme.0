Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA24C44507
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 00:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uRlSmswpTKm9vOewmN7TREL9i55TAqjX5Y8eHfCdkts=; b=nnKxILtISe6zmOOz2BczOLFRKs
	wOZS7h0Cm1I0aIjHOQWDP17lzDEBJf4LiDvApW8iycIHC33sSGVVCRhffbYEUXAfFDyJiPhLVrMh8
	Hk5b7XNhobh2oDfZHfgyC5kD0/9ZeRkJHst4FQz2AurwMheMH5G+5Ml6o0Kl6dyNDYI0O9g/fTltw
	Zezxsx8lWlLwVqZQ60DxhA7entvr2ZBKVzyFWYtB9yxWj7T0KJgFBsliaRR0iO/btTMaJds8fsA3h
	Gf7ebBYTFe2rGNnNfEapZt2wlidtcjFY5gp9ivv/gRBe8q5FGDzwoRtVthaiYeOuphrqkUcDEMfpX
	qmL/DJ5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn6O-0000000DTYq-3vJq;
	Wed, 15 Jul 2026 00:03:52 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn6L-0000000DTYR-3q2s
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 00:03:51 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-69c19a37eeaso9670766a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 14 Jul 2026 17:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784073827; cv=none;
        d=google.com; s=arc-20260327;
        b=NEmWlNP/mSgsOP56S4MfD6etGePXFnELJSI+VgpZGF0SKvjCBrPytyfOEBgh8l6XQd
         dLesFFQBo2I2muGC2djQVRlbq0bc0Cx4m+Cry0VMC6F6VNjf5JwQxxAhLx0MWC9ID2DJ
         WhVkUINaqDnoInCGTAiXxK3UbhB5JzJZfc35vsqcZzE5QKFCvT2qnIVqId8nWSxteGKK
         qPCE1iwWuEz+EjTkwy2j1ApAjBV6X3S0vcyqicmDPzvzqx/07phwYHR0sm8NLzOxWGWi
         8soEju+xYArMfi890nn2EeNzurIfKDH7rSHRfWwqi2sq4Gyk9gfHMwjwjdyZu61FkmJ9
         uwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uRlSmswpTKm9vOewmN7TREL9i55TAqjX5Y8eHfCdkts=;
        fh=81FN079y58IIOdV/kVZOsUN2xJ5JiuR77KQUcnwpJWM=;
        b=X8EH/UBXyStLRmf+tnidDGS2CdHp6egKJXYqAY1B5DreDt/sEoVn8HKpweftaPcdX1
         8ge3qr2e84XMJqxX0apn1Wp/YSk+3ERL4ReAxp/8/d5eKS8t7QVY54hGYveuSWCwr4Pl
         or33gDCiz0KMGPizRhZB+oh3bgm542mEGcGXFpgoIeE9nYrysZpVHIHkJ5qlWBCg1PFV
         TV/3iPmfDuJX4WuRBziF3yBS/VVf5IS/c406agoB8K67hXoApMZwgJsf4QdYw+OS2Z1n
         jWDj/crFYTymbu1+7wV1fQKJxLQl/CL+adPWMRTDlXYgKN+qoGv7+eEDijW4AbbN0qP0
         +EaA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784073827; x=1784678627; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uRlSmswpTKm9vOewmN7TREL9i55TAqjX5Y8eHfCdkts=;
        b=rd/T9cU/iHrRR0u+9lHWtlw4eIugh7GMJ1meIVAbeaG1m2e1c0MUiBpYeLxVT7Y8hY
         cfDWNkyB9qM5inIURN4pLjtPWsJMmjlnntkXQoIFy2TVpwN32MDY+/BKJVOrRJ6fMoSW
         dodO7KGfNwyyj64tWgOtoBMiB5DmodyDXwBhJQ2a7z5HfPQyP16XdCkKMDD4L6LN1Kmm
         mD3AhbEt1MEvkW0oLnxjdbPvPP4ATjV1jaKsYBlHarfwbH37qb4NSQJ+eG+dA6cC2Xxe
         aMREKv+vC/Sn8MW3guJr6qi4EqsO4nwjYXOPfj7yDOYuwhYwpXZXmeAUQG5kDMpIYnwb
         gNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784073827; x=1784678627;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uRlSmswpTKm9vOewmN7TREL9i55TAqjX5Y8eHfCdkts=;
        b=RnFmXIZWZX01f53I6LVd7hm7Kk1xTo0gvceHJeuqQYpM5rgNh1U53TgMl3wQDDNLfE
         HDsmQP5Vxv8OX2A/cC4sv+erczCPTwF6lbU+S+23l+fm3o/lahRnkQnvx/vB9HXKA4m/
         XZFIuwc2wZkXrjUoDHnwr+IwMDfx4DPtLj9PpirWpvON4PLQ6R1TSp3yhNQUlxbBjtJk
         CLpzahip9a8cKG3tvlkwjnb53DXBf2oVsg4fQLtr/NnQS3xIHWr2AyRKI14P8AsYrLJx
         tHkNByUJrTcs9IubYDLvNmunww4riSGLh+YTIqady4RIdxVK1/0oymj6NmKoEGNq4MBc
         0zmw==
X-Forwarded-Encrypted: i=1; AHgh+RqfCGxzAkwswE6ervtUlpS03ZTJdnJiRFk9AZQP7+r9Y3LhY8amdnMWH/IDJSIZb115iS/r6sMGyYCn@lists.infradead.org
X-Gm-Message-State: AOJu0YyNUiFPlVPUdREz3KXOrnWz4W65B2OZdbYr1BYwHUv6dhsFTIFL
	rwxmPcwLqhb1gRFwrI7BmbzGH3MKHEXR1wv3KPs2b5aMSR8lFQdZc7vnpFNGX2tXXKVoltQVDXb
	gE2/a15HzHI2GKEAaQY3sOp+b3jU/kg8=
X-Gm-Gg: AfdE7cn2feykdTbv7UyolDgm7s9Vc8iZUXpn1O6/jKO5IIHpUEksIsuf+HN1XI5V6IV
	DLzrpo200XHgK4sFa33JK5XjyrZ3YO+robmrMcuqQcTAnY4gdhV6dY9rcfB2f+V72M0otkqW5tV
	MijetF7QFpJUSxW8Ics5zWtpB1PaYbCXCFuiQylMyMgMEAw5i14aeHgyn+FdffJsSrkIE/EC/Ys
	j3Qh01+f4bdN7Y1VpuyaAZ1J39xWfElwJ941hprWoEZ6lMxCQYzl/avsocwm0bP+UBfg01Jgg==
X-Received: by 2002:a05:6402:e02:b0:698:ac8a:9a21 with SMTP id
 4fb4d7f45d1cf-69cd29f3996mr3573496a12.8.1784073827320; Tue, 14 Jul 2026
 17:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260522153034.2168862-1-coshi036@gmail.com> <20260527141909.GA13578@lst.de>
 <19251352-237e-4aaf-93ff-86b3e43bed8c@kernel.dk>
In-Reply-To: <19251352-237e-4aaf-93ff-86b3e43bed8c@kernel.dk>
From: Chao S <coshi036@gmail.com>
Date: Tue, 14 Jul 2026 20:03:35 -0400
X-Gm-Features: AUfX_mzL1O20CkIv4QgJrm-acXdQ2flH-ankpb8YlUplytWoM6GPQMdR5j9WtCA
Message-ID: <CACd_6n07C3FxR9QMRqBOb+8xUpi0WLndb7OFZw4N36_ovjDTGA@mail.gmail.com>
Subject: Re: [PATCH] nvme: reject completions for requests that are not in flight
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_170349_984740_FF2A9450 
X-CRM114-Status: GOOD (  31.32  )
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

Hi Keith, Christoph, Jens,

Apologies for the slow reply. I've had several patches and crash analyses
from the same fuzzing effort in flight at once, along with writing the
work up against a paper deadline, and this thread slipped. That's on me;
I'll be prompt on follow-ups from here.

On the framing -- you're right, and I'll drop the "malicious device"
wording. e7006de6c238 was written for a malfunctioning controller; I've
reworded it to match, with no threat-model claim.

On whether this belongs in blk-mq rather than nvme -- I've kept the check
in nvme_find_rq() for now, since that is where a device-supplied command
id becomes a request. It isn't unique to nvme, though; if you'd rather the
check live in the blk-mq completion path, I'm happy to write it there.

Sending v2 with the reworded message shortly.

Thanks for the reviews,
Chao

On Wed, May 27, 2026 at 11:02=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 5/27/26 8:19 AM, Christoph Hellwig wrote:
> > On Fri, May 22, 2026 at 11:30:34AM -0400, Chao Shi wrote:
> >> nvme_find_rq() resolves a device-supplied command id to a request with
> >> blk_mq_tag_to_rq(), which returns whatever request last used that tag =
-
> >> possibly one that is no longer in flight (freed, or never dispatched a=
nd
> >> thus with a NULL rq->mq_hctx).  Commit e7006de6c238 ("nvme: code
> >> command_id with a genctr for use-after-free validation") guards agains=
t
> >> this, but its generation counter is only 4 bits wide and can be matche=
d
> >> by a malfunctioning or malicious device replaying command ids.  The
> >> driver then completes a request that is not outstanding, dereferencing=
 a
> >> NULL rq->mq_hctx or double-completing a command:
> >
> > I don't think an intentionally malicious device is part of the threat
> > model here.  This was added to protect against buggy devices.
>
> Malicious devices are explicitly NOT part of the linux threat model. If
> this is a real device, I'd say go talk to whomever made it and get the
> firmware fixed. If this is a "hardening" effort to protect against the
> threat of malicious devices, then I don't think we should bother.
>
> >> +     * blk_mq_tag_to_rq() returns whatever request last used this tag=
, which
> >> +     * may no longer be in flight if the device reports a bogus comma=
nd id.
> >> +     * Completing it would deref a NULL rq->mq_hctx or double-complet=
e a
> >> +     * command; the 4-bit genctr below only narrows the window.
> >> +     */
> >> +    if (unlikely(blk_mq_rq_state(rq) !=3D MQ_RQ_IN_FLIGHT)) {
> >> +            dev_err(nvme_req(rq)->ctrl->device,
> >> +                    "completion for request %#x not in flight\n", tag=
);
> >> +            return NULL;
> >> +    }
> >
> > Although this check looks cheap enough that it should not hurt to add
> > it.  So I think this should be ok, but maybe respin with your planned
> > commit message update.
>
> Only for the right reasons, imho.
>
> --
> Jens Axboe

