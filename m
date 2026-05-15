Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23334CD4851
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 22:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ivzkihjD4cM0lKPZnqJwRXsxU60S/SuNrDKjKXTZHU=; b=E5VGAteiObTuo6TYYgdsXh5gnU
	/OpmbSFnd6NIOxA8pdJKU6pbJls9/idDiMAOJTDII51nu1Wh0F41Ow4s3RV2HB+21tZfzWTZHGdpF
	vjIHDv7lLrWzgRLbQ/2/6DFQFzbvnOkTx+KknI0b0bWuY2gpyWoPdMeSnnrpHStXuiknAScq3uAwE
	lmYyKuCd/XKJ0F/kW0sQpePgtRdz2UpbVdBtlUV5VxaWCyS65nnnp2KcePmR/ffqPoZDqOrnA2Tb2
	M08GVypTlRsBV8ZOaBLuktc526DpPxeVVy/K0xo5zdQDNwXn9aQTUCZrd/d0yUL9d+fCqxzdxmtqR
	KjxSHf/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO1SZ-00000009fyu-2TFr;
	Fri, 15 May 2026 22:56:47 +0000
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO1SW-00000009fyL-2Cqb
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 22:56:45 +0000
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-63127c440ccso248692137.3
        for <linux-nvme@lists.infradead.org>; Fri, 15 May 2026 15:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778885803; cv=none;
        d=google.com; s=arc-20240605;
        b=c8g6nE2GzKxOdiI5rGGOOQ27pS1wEvRadExC+5gWfElU0ehOZEddybYV93d61oM8mR
         tUbfRNpwqS2IQQnhUPnnUYCZDibzk513mnrSL/KZjIe1lNY9VQiuYbOFvUYLK2on2O0C
         mzvmKr48Mdp9GD/0g89EzAwhSKXUesTTdTH0EssrY4tXUg1atXY17oRK0ZrQbflQ4kHy
         nohel6abCbYUSwAk7M9hJ06BwPdYzMuX6xppdBmijo8HCHXMojiV1xaRTVnq6zcC9FhA
         qZ23HX3gqfFJCkncLm/kjE9mK5Hcu8jOaGt9PE1Tf9oW14YgEcv6WhmVijPqpBn6gdnS
         3b9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ivzkihjD4cM0lKPZnqJwRXsxU60S/SuNrDKjKXTZHU=;
        fh=7ADWPbbggbc2XtfublYqtkcVLHciLON0I+kbVm3OilM=;
        b=lntKObanvu1gL9RdlIlOIgvTLcpmYHU97tsE7IEXo5mhL0pvNwVrlHJlEf0NoXdT/3
         iry9FmWSvGkO9PoYTN087/k7fqb/2bYDxjyxOWGPQcTxAeTzIpd9yh4cuWE0XOjbibC6
         2ZZqTO+fXi5Qf1mBgnRCfefqZ9hQDPkA8ZD7M/EW/2zE0rHcHDIhBtoRzS6RFCdziP2p
         j/WMNxorO+s0vFkXwE65qca6x3pSGjerlw4Z68ctwR3eVU4mJA0VGXC4k3RODNH5z/9E
         v9TVimpPTBSn/3VIxpzlu+Eux/WKeo8bfG3+RiU2V24nFdOy+T685nhKIZHQnxpXhPpz
         OaSw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778885803; x=1779490603; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ivzkihjD4cM0lKPZnqJwRXsxU60S/SuNrDKjKXTZHU=;
        b=DJKR3QyQkBqgNHlvlZFu7XwVCJssUK5wYRPMom1JeViB0jmhvcO1PangozLnaeEVYh
         GdRRivf5TKBS9BdkQaL9pNT7qilB8ffcmO9TPoaxs1RhMRnLxhffavAHuMKkRfBHdANt
         PGpU06exzjtDLxQTg33CK8a1/+XgpmGQ7WfictMKBYbWh+mUbetfULu16/g458jzngkq
         ZrYdFLkH7K07m29GDc6WLjmWcirucEr/VKgDU+GmLqYKfktMeJmTACONMn1YV22thai0
         c/XHyczVO5/GpZ8FU6n0ZVJxqjeg/10a2KN3VYQ0ANbdwuNDRyVQjqBi0817OeWv/8oV
         S42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778885803; x=1779490603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ivzkihjD4cM0lKPZnqJwRXsxU60S/SuNrDKjKXTZHU=;
        b=XKgabhNzyN5r0EQMaluxT99PHVzc51fEEtIHmNbd/HnW4+mUUNSbc+8HMShenz6xAn
         xh6lkPP7g8ihNFsOHTFkII2kbSsR+l+fyuYnkwXD+DSpGrx547WGFbD56KD7/Cgl/B9d
         G7FZtAztzr1VRe5zP07J4y+vIhRGC72jjGXBMls6sIy7T5PobD5Wq6S8093qqujEq/8C
         3zYNxVcWNb8ZNyb+pTI2X4NGjDvdr0l2Dj4kmdqtoAJdftBDZZLO+g1NoZbgUna+odJD
         LX6CzhPx0EZRAL+Qx7L49CQLMD9sccKAOHNrtxr/ycisTWAji/Ytg4k+EQke56GTy5DU
         6BNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WnpJOIY4mVxhxqFdcteRTHpgHt58em5Z8Snpr0Xlx4A19SXGcCQ/o8WclyQfwssPDyL2/e6xzKwDC@lists.infradead.org
X-Gm-Message-State: AOJu0Yw2ATzKAEoGlXx3gdLRKxmY5+3T8gnwscJ0RKSkUXF9CLqLo75j
	7k0vVsZJdylBzT4dh+5j2miMpoN5w2179p8dUX4Xz8VRy/PMrneTI/BjciFum8Mg6CiAJhHfM73
	tmkG2n0HpaMMzv8MR2Bpd8l8jfz2/QIkXAyBG7kV2Bg==
X-Gm-Gg: Acq92OHsLzVooPLe/uH5It00n4IPSIUJhHYx7wclD+HwuOpB+jbDuRxK4T+dCxB4TGb
	ah4t+nRyvgAW8Xi3cWVnPdOlPTDIu1s0Sok0k/3q3jdhV13BhrhhSKyFvdUWC40mUNgtx7ui40n
	0y2Lqbhoy0bB0Lx61tpBAIb/11z0XSKJRpIaUAZ12kh9rpPZxd5m4+HQnIQvdmavMZNMvxVsebw
	U1VzexJg4uoRewNg2EgAWewwuPaaVOfgPRL64gvFzuAQUuXQSHFsUvAR4EwKB7Ti/3AAp44xUiR
	YTRNohHRmqcpxYM9whWHyGGIbOdB2ISPsLjG2/n0gWV9AbpM+XHJbA5C/x9nzTF7N99puji9xX0
	RChs=
X-Received: by 2002:a05:6102:598d:b0:602:9977:a4fe with SMTP id
 ada2fe7eead31-63a3ec80d97mr4103450137.19.1778885803056; Fri, 15 May 2026
 15:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-11-mkhalfella@purestorage.com> <37c751e9-f842-4532-b4fd-919fae7295b4@suse.de>
In-Reply-To: <37c751e9-f842-4532-b4fd-919fae7295b4@suse.de>
From: Randy Jennings <randyj@purestorage.com>
Date: Fri, 15 May 2026 15:56:30 -0700
X-Gm-Features: AVHnY4IBRukB5gd8wVCUw8lTjOnDaDunxYTMd7nDPsGSiZ4aKb4CtjwllYwyPOw
Message-ID: <CAPpK+O3C=ScXhnxMhpQFkNBr1JRMXGOD7VkeJaFSFvyROKmXrA@mail.gmail.com>
Subject: Re: [PATCH v4 10/15] nvme-tcp: Use CCR to recover controller that
 hits an error
To: Hannes Reinecke <hare@suse.de>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>, 
	Aaron Dailey <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_155644_575661_66785F0F 
X-CRM114-Status: GOOD (  18.12  )
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

On Mon, Mar 30, 2026 at 4:00=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
> On 3/28/26 01:43, Mohamed Khalfella wrote:
> > An alive nvme controller that hits an error now will move to FENCING
> > state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> > terminate inflight IOs. Regardless of the success or failure of CCR
> > operation the controller is transitioned to RESETTING state to continue
> > error recovery process.
> >
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

> > @@ -2644,13 +2669,15 @@ static enum blk_eh_timer_return nvme_tcp_timeou=
t(struct request *rq)
> >       struct nvme_tcp_cmd_pdu *pdu =3D nvme_tcp_req_cmd_pdu(req);
> >       struct nvme_command *cmd =3D &pdu->cmd;
> >       int qid =3D nvme_tcp_queue_id(req->queue);
> > +     enum nvme_ctrl_state state;
> >
> >       dev_warn(ctrl->device,
> >                "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeou=
t\n",
> >                rq->tag, nvme_cid(rq), pdu->hdr.type, cmd->common.opcode=
,
> >                nvme_fabrics_opcode_str(qid, cmd), qid);
> >
> > -     if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE) {
> > +     state =3D nvme_ctrl_state(ctrl);
> > +     if (state !=3D NVME_CTRL_LIVE && state !=3D NVME_CTRL_FENCING) {
> >               /*
> >                * If we are resetting, connecting or deleting we should
> >                * complete immediately because we may block controller
>
> Do we need to call nvme_tcp_error_recovery() even if the controller is
> in 'FENCING'?
> Don't we just need to return BLK_EH_RESET_TIMER when in 'FENCING' ?

While I see that the call to nvme_tcp_error_recovery() works
when in the FENCING state, having to remind myself of that is
cognative load I'd rather not have.  That, and there is currently
a race condition on whether a warning is printed.

So, I agree with Hannes that it would be simpler to understand
if we just return BLK_EH_RESET_TIMER if in the FENCING state.

Sincerely,
Randy Jennings

