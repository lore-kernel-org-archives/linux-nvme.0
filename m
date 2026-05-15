Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084ABCD343F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 09:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TWOzdUAeRWtq58tMEL9icI37zOL9fyu1rObjxkRwApo=; b=Atjj8rpMx0+xuxZew+JQZOCjDR
	ip+SpDe1LAfUbHkulF+GgePAs58IxOnYyofGCxUQ5hkTW5/pPwjIhPBqeKSqQG5eb3XPtUCv3Ah0Z
	OX5qYHXkCsYgVSaa7ODHW8KcG47cpekQc6ALaR9VTiwfIhYfRZbRGFwGSgx7o6gNKyXkPrLA0nA9a
	U4uc+5nw84cYpWVG0EZ+zO6AnX/OkXMsQZzTf/HIGBlPUrBdeQoNBZ3+sSaHPSJRsnz65bpSoOhdB
	V6/CasIfd67wqCqihikUfus/18KXSmc9hSfTqDGMpKjHZDNUEgmFJDDxB5N0xAMuBiOkpd8X59ITq
	rQE4KqRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNown-00000007ul3-0vG0;
	Fri, 15 May 2026 09:35:09 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNowk-00000007ukP-4BLB
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 09:35:08 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso10328280a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 15 May 2026 02:35:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778837705; cv=none;
        d=google.com; s=arc-20240605;
        b=NwHh1opuQpuAHhm+PVz4YwcpjN07MPeMkVQiA0JYQVDmcMIL/Ki26PZKXW456ih9Ye
         f/DXDj21Tt7cXwmbfYBQYUc9Yj8sJPFwZSCog12Eu0yKvjRJGImqe66JaTJVitilu3a0
         rBZsuicCznmGkjNRPzldj4D0kcbeu4mvvgV1Btq+DXDPvYbCue3f1wc3cUutGjRQHG9+
         UPYhfUzPJV2VjXxpEuxEZ2Y4duTOkL7IQqrMxFAxLbk8ZDSxDBiCeJd3LBCqfEn0+5Hb
         1shjWtinzyo01NhEBxWhBKS13wmypFjGuS3y8TFAAKIzQHkhQyPGTaFFl5ZKTY7/R979
         zJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TWOzdUAeRWtq58tMEL9icI37zOL9fyu1rObjxkRwApo=;
        fh=QJyUtNMT2F7yolYcUsLmPic4+ZiPhCBl7i0ZQZYIsvU=;
        b=BTh0MHbfG93652S6HMSNY7XhICglrdvHWlrffeWWOwItDFZ5xUNOVr8XIHv8XSgpDO
         IgnTWZw3FZ+CbhjSJIg1aLLOvmBczcHLmsxamgm2yyoLcip3zrx/fCbI0XtIsrBtcXOE
         /9AluhySXbbfq+L9G3re2y/qURZHuZvWqwMC1GFOCGvbs5hEZHc55EmnHuO/aVLAOiwh
         mTSfWSC9Oc6I6qtMX7JlQSPxbNa7YFK8l4cgwxMZkz8OycN+2sBodWUFw5t/DEchGT34
         JSyM1ihTUKi69RVQzzGg98VvZ/k0DV+q69Z+BTll/szurUURU0MqToqmJt2OrL1wsRN9
         hoSw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778837705; x=1779442505; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWOzdUAeRWtq58tMEL9icI37zOL9fyu1rObjxkRwApo=;
        b=UF2Px/VX96z2UdcGJhbqd9XnCAmiy0kao6wivkCMi4t9hZYziAmz+rLxcifW4jRiOn
         Kz5Jv1NaQNO7EcWh1ESOCNJTB7jA/AdLzzxQiu00f9m5gH+AJehOomgKzx/tjZCoGMk/
         Xa3i92eBpkaKtisjczmGMmLuRI1+sn3xE8hpO7yVNVZYE4X+oEYfGxrlZ9wct0HlGrbn
         duFY9y3Mx4INodJTfYt1GX595b9JpY/WDzOCd41G4IRAB7SynjePko9qKX8OrUXgH+/v
         yl7ENawDwcLFlJtQ0fLPUoFWg1jzhhKC+stfI0oYFUoSs/yBWwQ4uts3YOu9ProxnopM
         uHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837705; x=1779442505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWOzdUAeRWtq58tMEL9icI37zOL9fyu1rObjxkRwApo=;
        b=IA+EzmK4LR9vX9ZF/ehj7ODe2h4YA1JpDBwqUSuPVn4gsUr03lhrws4O1Q7Xnz0lxL
         opnaj8lkUNszOSvd5D0bFdVjN7uc9Or+66Qw2LQnmGFTXLiNUZoiG8vbYjs65bVw+RK7
         89zYpTZeRhapmsrW1Ee53Xma8dDseYSZYVtHwO9YpMtHnD3J83ck33Vn6wBFgtmdIncT
         3KHEyJQeqHACDsT9bN8v/gB1BiL8Zz4wnScg23lD7B0qwTtQyM4wY68fylryTyKGaWCx
         qjuV3OlpHdKTIjL80ZnM3mMCDbR7oDBUnUDVWiMH4K1kGSGKgEVYPK36SgOWQ5sHyxwE
         RUYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8EgdedQoRqqSC/QzchvNVRkl4YR4GA44HhJQfJVRdhUzTsfRthKG8JQouosSxmmHfqy1h9jV+51Gxh@lists.infradead.org
X-Gm-Message-State: AOJu0Ywdrc1yY4bSsDcb6xbnO1YxA2ZLT3FFm0NzdxYUbwmf92VGAn8G
	JxwCTz2arQJRGHp7otiJyWkyGkR+nQRgZMWBeZUIqxHpP7rsne5EblCd8sWvj6Y+xn1LYYC4x3r
	GiZ66PFNpWI2UKL/aovtgjw8J9iz3pvYXXjfVLkZ2+NNv
X-Gm-Gg: Acq92OH4DOJLUHgQ2MItakxlqFBPsokj87prtHb+hKaDZ7b+fzkdG1wu2rsewMgPp+D
	OmEg1GYSMpyQePRv0JQZSRQOIVzpIpnNGkV4Re1qFYbMbvL0u1IoyPbPNISsk3fie5IXmwWZGYp
	12yxbiFKQjUifOulVPVbzogyyg3Vw4/xGLotdNNrtOZDBdYmUMh132bvjFqmfGbNFaMBD+teLSW
	8/o5xbCpwNYfzqu8KfFMIhqD0NX/J9xSbNS7SA+nNbrizbgzjehUtwx/FesU0z2igzB8N6Sbkgi
	YWYPWpuzv0CzdA4biSA=
X-Received: by 2002:a17:907:702:b0:bcb:2893:f703 with SMTP id
 a640c23a62f3a-bd5178976a2mr163971066b.21.1778837704946; Fri, 15 May 2026
 02:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260418042835.420281-1-coshi036@gmail.com> <20260420231116.748204-1-coshi036@gmail.com>
 <aebD3CqLTrD7T1JH@kbusch-mbp>
In-Reply-To: <aebD3CqLTrD7T1JH@kbusch-mbp>
From: Chao S <coshi036@gmail.com>
Date: Fri, 15 May 2026 05:34:51 -0400
X-Gm-Features: AVHnY4Kftgp96eYIZxCCd0JslYg30sDv17ZG5g5k9pScX4y1X7vgSddDfPnN-Ho
Message-ID: <CACd_6n3Grc6TqOzG+6SDcEuD9m7ikXB9V+KvNZD8QHyei0mfYA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] nvme: core: reject invalid LBA data size from
 Identify Namespace
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>, 
	Maurizio Lombardi <mlombardi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_023507_059601_C877F5F0 
X-CRM114-Status: GOOD (  16.88  )
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

Hi Keith,

Thanks for the follow-up =E2=80=94 I misread your v1 comment.

> Not quite what I suggested. Instead, if you move up the validation
> checks, you don't have any cleanup in the error case to do.

Understood now.  In v3 the validation is hoisted above
queue_limits_start_update() and blk_mq_freeze_queue(), so the
error path is a plain `goto out` with no cancel_update / unfreeze
needed. (Please let me know if I things on the right track)

> And don't bother splitting the error cases.  The message about the
> "0" LBADS is in reference to the broadcast identification.  It's
> never valid for a controller to return an unusable flbas index
> value for an attached namespace.

Collapsed into a single check in v3.

Sending v3 shortly.

Thanks,
Chao

On Mon, Apr 20, 2026 at 8:25=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Mon, Apr 20, 2026 at 07:11:13PM -0400, Chao Shi wrote:
> > On Mon, Apr 20, 2026 at 02:51:00PM -0700, Keith Busch wrote:
> >
> > Fixed in v2.
> >
> > > you're missing the corresponding queue_limits_cancel_update() for thi=
s
> > > error case.
> >
> > Added in both error paths in v2.
>
> Not quite what I suggested. Instead, if you move up the validation
> checks, you don't have any cleanup in the error case to do.
>
> And don't bother splitting the error cases. The message about the "0"
> LBADS is in reference to the the broadcast identification. It's never
> valid for a controller to return an unusable flbas index value for an
> attached namespace.

