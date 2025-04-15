Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEA1C369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 22:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3If7k3RyO/I6fUflyAfIyqgexoXUQ5iUnIIFxgXyydo=; b=2zjjpR6vg30qaVUO+cCGUGImwB
	OXpleh9hhS2CNewTfdfoRSMn5RL5AnAQT7U+oOc2NwaWgleKlTw3wKPsOCUqwrNMGxiHRkJZsMP67
	oDfjVTb5fzPtcgpO8OwgbkBcTOWmdoWiVj1PeImCm6h+wQoJw7FOp76W8MfMcR+NkjCZ6dfgAFElp
	GUrZUDfCB1s6Oo4QUljAnjK0HstzuLcLGuGLE3zlBUoQROBTKEdaW22N1EGGaHiKK1kAND1c3BDD2
	BNzIRgxCWSoGqx9d7MMEo7wnIKxqtFcukXrqXAoajtXvUR4msorhC6kwP9+hSTEQOQE8IMrOIkfXE
	6ng2Ij3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4pCf-00000007O5d-3l7d;
	Tue, 15 Apr 2025 22:56:29 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4pCd-00000007O55-3dkG
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 22:56:29 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-399749152b4so3571500f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 15:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744757786; x=1745362586; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3If7k3RyO/I6fUflyAfIyqgexoXUQ5iUnIIFxgXyydo=;
        b=fvmWN8HaBT3gf2ExJQEQSsACgEstG1Uvx07+6DUWAC/7yRezYeveoJS29bxZAZqJWI
         T9JZDT8+FT2QqSMOFu5IbKtJCKMAVZlXE4Da0s0SRMuKmfCLDNm/2nUZHv7VXH0iMj4u
         AXaCbhdnuGVjPv9rO+1NxHAmVB2sNV1aPRWYP6iDZ6wJbFBskVMgfNntg56w4GFVAqcw
         4l99naMmhJ0FCYSdTdJXOt5f/fJRSOjPg8nL5myBXWby7wWFMMmwSI8CdmTwBvLFb4sT
         xth9eh8M1GIPDgNnh9jOX5+7iAL4i1gN59AePdMk8TX1vrEA+uSsFKhmXqSkL/vUNmmn
         n5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757786; x=1745362586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3If7k3RyO/I6fUflyAfIyqgexoXUQ5iUnIIFxgXyydo=;
        b=MGkUGh6cEVF/3I26yrIgAIryWS3BEzZ8s1BvIZLOYNjSZv2WFciuW+txzHUvdIgx+n
         VIj7KsdkkZTaWsjIbTG7lzwWzyoN2rGtVKIjqkQQJQQI3In06xTuYfkuGFbBTXgWBxQQ
         DrdRQHfisEWh8R4SjMEIdZk+CSNg9jZkdT5igmrqWg/OdBZ1fLrkOkSFAxsgCmmRf2T9
         nId+Z2Mgnq+VPfub02q09sokIvezbUMx2hn/VoH7qXBh07NGAbjoZcQedQ297reNWhgd
         QI6vkupBm366N3ysoP0SKjBwHVeBZALr95Hyr6qmfBE45XP2FFo+UDROuiZqjHMbtIay
         5v3g==
X-Forwarded-Encrypted: i=1; AJvYcCWbzsyOmKdIrqpMIzWYtUAlSd+xtxNt4Bd7mZcTj6AHfwdCqBhhV6r+rJZh1yH8kkO9N3X7R12WahLw@lists.infradead.org
X-Gm-Message-State: AOJu0YwdU9AH5kI9YJi+2Iv43QkbDWfw6ThYw6fiRCFtvzqhqNtNJCiI
	DhuPCORMOVcXJOjZi52nGsEdS+T1jl9djKZy5NbOAcvLRCXnBNFFuhKqVdyBVgmX69gyrmePsIc
	i5qmUxjPJeDXUp/ifyJpdnlXcWisv3cUUsYjVzw==
X-Gm-Gg: ASbGncsTCzGdufb1/bQk9GDtcYw1c4+OLt+p7DJxxy4r2YsvakFuAxRAc9xbozKUAXd
	zzPheobhEk17tK2URQ4yzpcUfQAsEAzC2BlLZYOqJsFhpFUtcTR05/g2v7ZOowJz8L1+FOb1wv6
	BCzBwxV4KdtqGzVk/wCy8gsfk=
X-Google-Smtp-Source: AGHT+IFcNDsrcNCH8Q24yY3mTpK4pth7d9TvsL/u1zESgnK/ipjfg+Ehr9cGOY5H3d0S1WGllQ5zEyr+jMS27JqPzKk=
X-Received: by 2002:a5d:5985:0:b0:391:3988:1c97 with SMTP id
 ffacd0b85a97d-39ee2735d90mr864563f8f.17.1744757785711; Tue, 15 Apr 2025
 15:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org> <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com> <6f0d50b2-7a16-4298-8129-c3a0b1426d26@flourine.local>
In-Reply-To: <6f0d50b2-7a16-4298-8129-c3a0b1426d26@flourine.local>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 15 Apr 2025 15:56:13 -0700
X-Gm-Features: ATxdqUGuHiF5Y1y-MoFercqMi-QmRef-lccw-wWNHKmkyEwcQpl5D1wFsIX8bvU
Message-ID: <CAPpK+O3QXTEe0BV5M+P644Xs-0rFvxg8w2MR51kwG7_7374Emw@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
To: Daniel Wagner <dwagner@suse.de>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, Daniel Wagner <wagi@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_155628_045121_FCA82F8A 
X-CRM114-Status: GOOD (  24.59  )
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

On Tue, Apr 15, 2025 at 5:17=E2=80=AFAM Daniel Wagner <dwagner@suse.de> wro=
te:
> On Thu, Apr 10, 2025 at 01:51:37AM -0700, Mohamed Khalfella wrote:
> > > +void nvme_schedule_failover(struct nvme_ctrl *ctrl)
> > > +   if (ctrl->cqt)
> > > +           delay =3D msecs_to_jiffies(ctrl->cqt);
> > > +   else
> > > +           delay =3D ctrl->kato * HZ;
> >
> > I thought that delay =3D m * ctrl->kato + ctrl->cqt
> > where m =3D ctrl->ctratt & NVME_CTRL_ATTR_TBKAS ? 3 : 2
> > no?
>
> The failover schedule delay is the additional amount of time we have to
> wait for the target to cleanup (CQT). If the CTQ is not valid I thought
> the spec said to wait for a KATO. Possible I got that wrong.
This is correct (according to the spec, if CQT is 0, wait for KATO
instead of 0).  I would treat that as a suggestion, though.

> The factor 3 or 2 is relavant for the timeout value for the KATO command
> we schedule. The failover schedule timeout is ontop of the command
> timeout value.
3 or 2 is not related to the timeout value of the KATO command.  The
timeout value of the KATO command is whatever the host wants it to be
(with some values being more productive than others).  The target is
supposed to respond to the KATO command as soon as the target receives
it (roughly).  The host timeout value should account for network
delays and getting-around-to-it delays on the target.

2*/3*KATO is from when the host has detected a loss of communication
to when the host knows (given some assumptions) that the target has
detected a loss of communication.  A command timeout on the host is a
fine time for the host to decide that it has lost communication with
the target, but there are other events.  At the time the host has
detected a loss of communication, it needs to tear down the
association (which includes stopping KATO & starting disconnect on
_all_ the connections in the association).  CQT does not start until
the host knows that the target has detected a loss of communication.
So, Mohamed's delay is correct.

> > - What about requests that do not go through nvme_failover_req(), like
> >   passthrough requests, do we not want to hold these requests until it
> >   is safe for them to be retried?
>
> Pasthrough commands should fail immediately. Userland is in charge here,
> not the kernel. At least this what should happen here.
This is not correct according to the spec, and, I believe, not a good
implementation choice.  The driver (in the spec) is instructed _not_
to return an error for any request until it knows (given some
assumptions) that the target is no longer processing the request (or
that processing does not matter; as in the case of a READ).

Sincerely,
Randy Jennings

