Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCB6EB594A
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 01:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BsFAJDWQs7KVk5paL+b3YCMV0mtgfDfTcBAluT+KQoE=; b=YvLF2NzDj1pl0q/fo/AvB5LUgW
	V6UsAlz3W+sMeQ71/OHZOQdcdctRQTHCuZdVv2yVd0lRKZ4jJcMSFJWDLVVWYbY/vsLfSlElnMMuk
	njkRimlo+dLfAZlv3gm94ml0QFd8VsLOi1JktzI/OIdqAUBSJe/JgXkiscNWSRw9Iir+Jk8EMcnxM
	1KmCJZ2aMvB0TCv9WIqISwVHq4dHfjYJUAavuN4ZECYDPVPAnG1tekdSD5WG1Hkn6v9+09y17bK1P
	UEnTZnWxsZx/29mfy0Q5lutoYqQwNlBaAPRonYBiWepUqatCOUPWHc8Z4EMR1eTzFzd+g3AFTxhdH
	VJHtkpWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpz7d-000000005fo-1lOI;
	Wed, 11 Feb 2026 01:34:29 +0000
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpz7b-000000005fT-14Gt
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 01:34:28 +0000
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-948bf40406bso1171986241.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 17:34:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770773666; cv=none;
        d=google.com; s=arc-20240605;
        b=kZrNWb4Kn3BVkoLNZshRWEXTA3qupltNrjc3VkAy2Ub/FZbz1nXscc9KUYn+EtcPL7
         O5AbA9UqqA1Dbei+s4j6gizc9qssVYb451plsOf+Q7xDPb2vnvttSIzxg0Pd3rSnB/t9
         aAV0LFuu/CWRWUt9a+J4kZn5TdhCo76x+BgRxqTihjx6shLXk6Nsl2o33rPcRRmhoR0A
         PYIiS0ajvnSnJXQSN/DlmTSOljDlJljG6qO1vxJoK62VbcXvksm03VqHma9qYDy7qbXJ
         vNEW2jOdp/gsG9LFi+VUrsTK3aW8UEVSw7Gs8RkQfQwGlE3VE9tGaFWJspbPO5Pjgv9v
         N5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BsFAJDWQs7KVk5paL+b3YCMV0mtgfDfTcBAluT+KQoE=;
        fh=HEUrUi3f2FEPys6zn7eRktfzk9jX/Tp7Zw3Du9jqABg=;
        b=AD7Eo3fDatu531qs/zt5T6IEjsloWJN03UmpJrz1/YuopQfCibh3G1gbx+HG+bXTu/
         2GrM6GdAm3pVvqYcpuUptebfEsDtCJMDjY7DsBiSyrQfy5cCSpSeU5Y01rBTmm3Pylw1
         mWIdk+/tU8oX9zFt6srYmbxJLcw4djOINN/ZAAYHT4JPJzWsE78cRWljslVlUcjplFEX
         XZG2opw6tk5F9HAgMxMNjF9GLaDQsO8uRuoYamQ0WpWdGEO2WPWSpQNKQ8VEm6iTgpC/
         O0yuYf7sZjlbe7uOrW8ctuRECjIQt1/cj9cqrLdkD07HEwmC7aLGAbCuiTPuf2+h9MSw
         5MmA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770773666; x=1771378466; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsFAJDWQs7KVk5paL+b3YCMV0mtgfDfTcBAluT+KQoE=;
        b=b5uONOgiRF+qdKX8X7nVxw4JRccNabjQDgf3/o25/Vp88Iu2z3R5EBCQzVOUXiYEuy
         hAktDYiBEVQh4kMhbAg8Fi5kZAysW60NstgmPDV7W5ESWaxugHSKHYa8Xwctw1ONCIAx
         x+vZN5x4Ct6OHoy8oLIyzhbVz4CQO+44SQb3VYSk15/H8vrGiWc/xOhRb3weHnkC5MCj
         tx+K7EsYK3/pQM7GZzajIEp9n7S38QuqS+t+J20R5uz5zAgMx9WVkFz4O91VbEvsL86m
         aPlOvziWoNDjFKNg+ZVRB4fwJKG6fDl3fLBWK9G71FbTJ8A3YA4VaBhUaUIsWpcKvM2q
         Q83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770773666; x=1771378466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BsFAJDWQs7KVk5paL+b3YCMV0mtgfDfTcBAluT+KQoE=;
        b=WiVsvfaou/48H2zjaK+G9tdbEziUJovhld5Qk+4YeEzEUvriXtosYIP5wwxoR0ISUf
         L9b68I7ENyf0mjoKFwY9VjGovvOFdPrsr5VfWcDQINPrBu2DrVnN3hO1zJfCSVXp76Hs
         89iOskjzNfCRMnlrqBh8uAdWvL3W4DigO/QUvqRDn5abXyrcbGCtVG/9BkWS3eSqlM1a
         Wg2OHC/SNGBmg2ovQsKzc7wIoIkhAjmfFqycrhMy6B7Y1+AXMY7a0JBIq9UZ0mLFGweC
         lAaxxulv8igoIOcdtsHRjXPQbi4KMz/nv4KSvO5jJ7GfnrbYqtY0nQA4iOLzylO4TYiA
         1IPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHWa7ofMml0m3yR3O+9ozfNrsX+d+yH0Xs0zhm06+gVDGsBh//NBYJvljtfdU2RDP7Gv9usbJEG0Yi@lists.infradead.org
X-Gm-Message-State: AOJu0YwY8U76Ft9ksSlH4idYXefU80KWeMgoAEMZsw5PiQBnc0Jb415r
	JJc8bbASpKnRz4bsC8epN4/bKucwvKC0r9E+Qjlvj8YoQPeuq8hU4sVk05S3RMcYDQ9BYUly1SR
	m9scKtU4yDvaxPvmiQ7iWT0QSHdssu9U/3y7k+Nkptw==
X-Gm-Gg: AZuq6aJUrfqKdBGm7khO7ItZQshjy86ZD/mPUgJT5FPcy+lO63W8LzTnzPXZtJBzyu8
	2vjChp8GM6GKhlrFHUo+c3VBTQ6UwT+eYdXjaLten/gUv/JKw1zhQBhKr1W8Uw/LtUHryucN7L3
	7F2Ku2VToArqBj2Nn582Nhk/6Vk53uA2eO9tE+EuOGOrlvsVUsHsjtGLuAS+V/9QDxv2grnL5t1
	iCVJlQbKa6qd1M7uav28XIq5UX3kzNYUHcoyYRmcYWMN2uvR40xnZ/k/f4XQWz/4S05wSgrsdxe
	hb76WHM=
X-Received: by 2002:a05:6102:c4f:b0:5f0:2451:5f5 with SMTP id
 ada2fe7eead31-5fde4173e33mr267279137.7.1770773665493; Tue, 10 Feb 2026
 17:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-4-mkhalfella@purestorage.com> <77a00fa1-5707-4859-8a7a-e823ca18c9fe@suse.de>
 <20260203184039.GB3729-mkhalfella@purestorage.com> <21be273b-b1b2-4813-8178-e01cb0aa6301@suse.de>
 <20260204004417.GK3729-mkhalfella@purestorage.com> <d53ac6e1-af6a-46ce-9b91-946a26ee1043@suse.de>
 <20260204175250.GL3729-mkhalfella@purestorage.com> <a2b46f72-857d-4145-ba87-c36c88710f18@grimberg.me>
 <20260208231034.GD2392949-mkhalfella@purestorage.com> <20260209192706.GN3729-mkhalfella@purestorage.com>
In-Reply-To: <20260209192706.GN3729-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 10 Feb 2026 17:34:13 -0800
X-Gm-Features: AZwV_QgSR5DkCDzzk4quJYBzra8i7hXOFwC_zwb2fZIM03GRj9px79g-W7CqhX0
Message-ID: <CAPpK+O0nSganNX_41knB_7AUjweB8exMzK_XZkqsvByyHh3P2Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] nvmet: Implement CCR nvme command
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_173427_316669_D01BABC5 
X-CRM114-Status: GOOD (  40.83  )
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

On Mon, Feb 9, 2026 at 11:27=E2=80=AFAM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On Sun 2026-02-08 15:10:36 -0800, Mohamed Khalfella wrote:
> > On Sat 2026-02-07 15:58:49 +0200, Sagi Grimberg wrote:
> > >
> > >
> > > On 04/02/2026 19:52, Mohamed Khalfella wrote:
> > > > On Wed 2026-02-04 01:55:18 +0100, Hannes Reinecke wrote:
> > > >> On 2/4/26 01:44, Mohamed Khalfella wrote:
> > > >>> On Wed 2026-02-04 01:38:44 +0100, Hannes Reinecke wrote:
> > > >>>> On 2/3/26 19:40, Mohamed Khalfella wrote:
> > > >>>>> On Tue 2026-02-03 04:19:50 +0100, Hannes Reinecke wrote:
> > > >>>>>> On 1/30/26 23:34, Mohamed Khalfella wrote:
> > > >>>>>>> @@ -1501,6 +1516,38 @@ struct nvmet_ctrl *nvmet_ctrl_find_get=
(const char *subsysnqn,
> > > >>>>>>>             return ctrl;
> > > >>>>>>>      }
> > > >>>>>>>
> > > >>>>>>> +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subs=
ys *subsys,
> > > >>>>>>> +                                      const char *hostnqn, u=
8 ciu,
> > > >>>>>>> +                                      u16 cntlid, u64 cirn)
> > > >>>>>>> +{
> > > >>>>>>> +   struct nvmet_ctrl *ctrl;
> > > >>>>>>> +   bool found =3D false;
> > > >>>>>>> +
> > > >>>>>>> +   mutex_lock(&subsys->lock);
> > > >>>>>>> +   list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> > > >>>>>>> +           if (ctrl->cntlid !=3D cntlid)
> > > >>>>>>> +                   continue;
> > > >>>>>>> +           if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE=
))
> > > >>>>>>> +                   continue;
> > > >>>>>>> +
> > > >>>>>> Why do we compare the hostnqn here, too? To my understanding t=
he host
> > > >>>>>> NQN is tied to the controller, so the controller ID should be =
sufficient
> > > >>>>>> here.
> > > >>>>> We got cntlid from CCR nvme command and we do not trust the val=
ue sent by
> > > >>>>> the host. We check hostnqn to confirm that host is actually con=
nected to
> > > >>>>> the impacted controller. A host should not be allowed to reset =
a
> > > >>>>> controller connected to another host.
> > > >>>>>
> > > >>>> Errm. So we're starting to not trust values in NVMe commands?
> > > >>>> That is a very slippery road.
> > > >>>> Ultimately it would require us to validate the cntlid on each
> > > >>>> admin command. Which we don't.
> > > >>>> And really there is no difference between CCR and any other
> > > >>>> admin command; you get even worse effects if you would assume
> > > >>>> a misdirected 'FORMAT' command.
> > > >>>>
> > > >>>> Please don't. Security is _not_ a concern here.
> > > >>> I do not think the check hurts. If you say it is wrong I will del=
ete it.
> > > >>>
> > > >> It's not 'wrong', It's inconsistent. The argument that the content=
s of
> > > >> an admin command may be wrong applies to _every_ admin command.
> > > >> Yet we never check on any of those commands.
> > > >> So I fail to see why this command requires special treatment.
> > > > Okay, I will delete this check.
Security is a concern.  But not to validate the ctrlId per se.

CCR is a different type of command from other NVMe commands
because it affects a different controller, one that could be connected
to a different host.

The Host NQN check was put in specifically to prevent one host from
aborting connections on another host.  One host terminating the
association with another host is definitely an attack vector, and it was
considered when the command was designed.

Authentication in NVMe is tied around the NQN.  Yes, another host
could fake its NQN, and authentication is supposed to catch that.  Of
course you have to implement authentication and have it turned on.

Hannas, why do you think security is not a concern?  Because
authentication is not implemented?  I can buy that; a comment
that says "Not verifying host nqn because authentication is not
implemented either." would work.

> > >
> > > It is a very different command than other commands that nvmet serves.=
 Format
> > > is different because it is an attached namespace, hence the host shou=
ld
> > > be able
> > > to format it. If it would have been possible to access a namespace th=
at
> > > is not mapped
> > > to a controller, then this check would have been warranted I think.
> > >
> > > There have been some issues lately opened on nvme-tcp that expose
> > > attacks that can
> > > crash the kernel with some hand-crafted commands, I'd say that this i=
s a
> > > potential attack vector.
The two NQNs being compared comes from the ctrl structures, which have
already had their NQNs logged on connect.  What attack vector are you
seeing here with the NQNs?

> >
> > For an attacker to exploit CCR command they will have to guess both CUI
> > (8bit) and CIRN(64bit) random values correctly. I do not see how an
> > attacker can find these values without being connected to the impacted
> > controller.
>
> I changed ciu and cirn sysfs controller attributes on the host from S_IRU=
GO
> to S_IRUSR. This should mitigate an attack by unprivileged process
> running on host. On the target side debugfs files already have S_IRUSR
> so no change is needed.
>

Sincerely,
Randy Jennings

