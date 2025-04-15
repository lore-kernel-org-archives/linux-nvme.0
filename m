Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329AEC369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 23:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J/qDwZEzKD3yGMGg8Li/ADCxpZW4mGQ7aCfoPmv5avU=; b=ef/ezwBuEwPyJfqcr7REHPeizV
	39X57dhcNBfrPK4y2TG1stV1vM2FkMrUZ3BYJjtXASTUHfhAc2Y3/9VH53ep0nd8f9eA4dJxt/8Xh
	n9sO+nRHwdneipnHmMgNfcqD4Y3dijxNfuYo+Ovqvjd8lSlW87SVophBLRjubD7IbrM8nSMgdCULZ
	UAkCEu4zkB5vMBhAJ1WLAPmNMAWgV1aW/ge3tgwMAPWFwUxSfUy8OT9jIVp4Ak3YtWD5XRkYY/knR
	0D8pocza7Cf8276hbb1nLeX6SjydfvFoKW3SdtpRq6FMbjhCZq02sooX6T4zsokQ26yNQNlLghWTP
	Om7s6BTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4pLS-00000007PnD-3Zr5;
	Tue, 15 Apr 2025 23:05:34 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4pJ6-00000007PHe-3Wru
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 23:03:10 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so56654625e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 16:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744758187; x=1745362987; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/qDwZEzKD3yGMGg8Li/ADCxpZW4mGQ7aCfoPmv5avU=;
        b=TQA+PoctkGdE9MYqT1EEZuLQVea8AHz0S/AmBMd4q0nhNeNoT4pirnUlU5Zo2kxvaA
         UFBdKk//VRP7MHVEoVUqENppmS6PETEXZXqr+mqaZI5FTfT3rSCDkjdqsGgyeTf/cMij
         Ek8plv9QGXL6XQQT3hIePoh/VJ1prb8F4FesnXPEkf74i2KNeG+rGWeZueJpuzJPAkLi
         ooLj7Ucw7FWpioWiujZul3lYQCv3l1cc+a4tl3Lv5rckCCqCw7mDNeqOBqrxbSobXF0J
         3ZEMM/4y21ThnP2l665JLwOtqhIOZ0TUy4kPI0zC5VcCWHN6rb4lFHi5iCkbraDcJOp5
         mevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744758187; x=1745362987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/qDwZEzKD3yGMGg8Li/ADCxpZW4mGQ7aCfoPmv5avU=;
        b=mXyZuuxw2a/XXzVsyQ6KCIPB3WyW6jKa3fMu8/vxakjBV46gi+eBc1nKOm+idm0JDF
         xSbsS6w5obeZ916a32p8E46i9WMwJslN5S7BUFy1VjNG40bttlYcVcN3Hq/qMesOQuQs
         S/ieoGjRtZgZMSwXWJbCb3aXq/UUmWUYrxxDDNxpBTwiCdmNXe6PtSVOzvlGlS/DAS/g
         Lm+bCuQbHJurGBAeGvJ/kXp3ylCA62oMRMnRvKydgBlY9Rqt+oi28bEHNaAU83wQlpje
         E799VhkhEdHWilV7ZtdF4xP5LLuTlRiPAVpES0sDzXKyVj3UqU9LgVih254QEwF5I+ew
         GodQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxr5W97PQhOB/NgaTbd82vf8cAORU6EBbIf+OokTnCpIQOt8Lu2MbhRmn7v3ZEpR+0klRcPtT2ss6J@lists.infradead.org
X-Gm-Message-State: AOJu0YwO/2VTnd0h+HyBva+qm5QnVmx8LERz9W3phDQKDIoxygX7k+4J
	ine+A85ElTOuBxnHJpfzx1+uqAsT07PzBq9stoGtiU62a94Yl8Ze2cI3IykZv8TxpE3mr3zFq77
	iKZ0c+av8JYXq+LfRmDMg8xfEM64zvwLd7ZuBAg==
X-Gm-Gg: ASbGncsAnSdNZNnH/iCOM2zs8Fs/8ORr+G5z3+svn2RLzdTwyMsgYJkDbBikAcWa32Q
	G1NulzJwLCUkjCFt5pPyFnBXrzw9BirtlPi6/bxUu3tneNv2G9gONFtvOEon0ElRXBLy3/Srp9v
	Ha2ZH0atNwjgBswa/CoJa8gGU=
X-Google-Smtp-Source: AGHT+IGgTI0wLb4VWFIwFuesPYi0ujonBvBDjospI/0Zw+dekcu6dX8nRTileKCKtfQjeN8bQFkbj2voYAnHIZ/dDds=
X-Received: by 2002:a05:600c:a378:b0:43c:fc0c:7f33 with SMTP id
 5b1f17b1804b1-4405a000eb5mr6479155e9.2.1744758187186; Tue, 15 Apr 2025
 16:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org> <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com> <738a41ca-3e4a-48df-9424-2950e6efc082@grimberg.me>
 <4cd2cbb4-95ff-4f3b-b33b-9c066147d12b@flourine.local> <4c334216-74d7-4a30-add1-67b6e023d8d2@grimberg.me>
In-Reply-To: <4c334216-74d7-4a30-add1-67b6e023d8d2@grimberg.me>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 15 Apr 2025 16:02:54 -0700
X-Gm-Features: ATxdqUGMQRaR1PEqG2V00cjTZyyCExDD4ZQRBFB78xZj2EdjEnB5NJFcPmkTAVY
Message-ID: <CAPpK+O0tmewK7pH458TOxjtimjO9on=4YDRFbS=FPTgM+KFTzQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>, Mohamed Khalfella <mkhalfella@purestorage.com>, 
	Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_160308_882049_3D4CCD53 
X-CRM114-Status: GOOD (  27.13  )
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

On Tue, Apr 15, 2025 at 2:07=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
> On 15/04/2025 15:11, Daniel Wagner wrote:
> > On Tue, Apr 15, 2025 at 01:28:15AM +0300, Sagi Grimberg wrote:
> >>>> +void nvme_schedule_failover(struct nvme_ctrl *ctrl)
> >>>> +{
> >>>> +  unsigned long delay;
> >>>> +
> >>>> +  if (ctrl->cqt)
> >>>> +          delay =3D msecs_to_jiffies(ctrl->cqt);
> >>>> +  else
> >>>> +          delay =3D ctrl->kato * HZ;
> >>> I thought that delay =3D m * ctrl->kato + ctrl->cqt
> >>> where m =3D ctrl->ctratt & NVME_CTRL_ATTR_TBKAS ? 3 : 2
> >>> no?
> >> This was said before, but if we are going to always start waiting for =
kato
> >> for failover purposes,
> >> we first need a patch that prevent kato from being arbitrarily long.
> > That should be addressed with the cross controller reset (CCR).
>
> CCR is a better solution as it is explicit, and faster.
>
> >   The KATO*n
> > + CQT is the upper limit for the target recovery. As soon we have CCR,
> > the recovery delay is reduced to the time the CCR exchange takes.
>
> What I meant was that the user can no longer set kato to be arbitrarily
> long when we
> now introduce failover dependency on it.
>
> We need to set a sane maximum value that will failover in a reasonable
> timeframe.
> In other words, kato cannot be allowed to be set by the user to 60
> minutes. While we didn't
> care about it before, now it means that failover may take 60+ minutes.
>
> Hence, my request to set kato to a max absolute value of seconds. My
> vote was 10 (2x of the default),
> but we can also go with 30.
Adding a maximum value for KATO makes a lot of sense to me.  This will
help keep us away from a hung task timeout when the full delay is
taken into account.  30 makes sense to me from the perspective that
the maximum should be long enough to handle non-ideal situations
functionally, but not a value that you expect people to use regularly.

I think CQT should have a maximum allowed value for similar reasons.
If we do clamp down on the CQT, we could be opening ourselves to the
target not completely cleaning up, but it keeps us from a hung task
timeout, and _any_ delay will help most of the time.

CCR will not address arbitrarily long times for either because:
1. It is optional.
2. It may fail.
3. We still need a ceiling on the recovery time we can handle.

Sincerely,
Randy Jennings

