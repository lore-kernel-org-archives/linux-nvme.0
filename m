Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECF2C369C1
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hDqFbC/+DHifhMPOWuzdQFWUFUZEjqCmc22JqhhJigA=; b=2cAaMC8/aOmZdMmhayCADyCR3W
	dOQrimJoXUE6Rj4BVw1ngOCH5XGzl0v3a8kBKJn668pPnvdxikYJWCh8AVXsC/vNhtdfIJLy5MCfL
	KbaFLC/Wh16LN3LHZ9clljvmfq0HI3EtrV9BJGvFtFkM74nE3acF4VkxHce2li/6ccyj2q1Futprl
	J6x8qqcqFtATZb+Mc9cTjve+jLPQ5xI7d6yQtLPypCNWtBjgwwEd2K7ObXVT7cQd/HZwJC1mLpIrR
	ITVo+OC5VmlkVmzw3gW9RBzscYYk4wiV9NbiNkWg4/LwilsjWgYxs34sNYvT8wLIY4VErbLlwjEnX
	nvS7MI/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nom-00000007BL9-2oKg;
	Tue, 15 Apr 2025 21:27:44 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nnw-00000007BEi-2wy6
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 21:26:54 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-22792ef6215so8333145ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 14:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744752412; x=1745357212; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDqFbC/+DHifhMPOWuzdQFWUFUZEjqCmc22JqhhJigA=;
        b=bI4wYsFbemwU6dE6Tfchc+tO/wvLHxjs/t15vdPsVz8f60SeRhydBK4vI9Jv2ekFdt
         OWJpu6pqZqdUUb0sUJXcz9JuLki1lOd8dnOpmc0Yq5zyWYlSDVidlCgwgFpI8/9rRi88
         KbgUEHxXb/UQ/fDQ1r4cQShicMGk/Qo7OPqknvu003csBPxLh3rHF/uOVoqBH4jJ1VwI
         DmmXZK4nG0cCT2aP3Q5NdvgQ1Grufw0FKYIP0TY04dDaA7GfPvP1al3HMjqBPC8H7RVk
         F2VhBdlLU5OFx/yDD0x4LuH3ioZfnwqwayDFknj1oUH8OAHonYtdxm1/UOEKXqB/1Pgl
         0DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744752412; x=1745357212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDqFbC/+DHifhMPOWuzdQFWUFUZEjqCmc22JqhhJigA=;
        b=ZdVe09KmmA+pBIwBhfqSIKbifc5J3LD1oDo6u/rhch7djoa8QL5UCzUEH1qC4oBWOX
         wGy8Sza2GQmkVeL3kYWcZiiDgAknPSzGaeTVFZmJkq42qGAMaVja+Sc7ecWjMqKAnbOS
         oSrrspuFdiQQnkomeMa6xtkIe/ic6B/wu4yCgIksc5vvY/aKIhWI7wd+x1ay4GKvZzEz
         1Nq0a2DvSBifHqTM7epZz/K9zegU1sSHILXQyz+wfTB50N8++j+VVm3Cve9xpgLSmdf2
         k8GjPJxZhfq+Xf1nC0eYtZunlxB5OvdqDbyevklhWioElZWhssCl7QsEnrBXchZ/uMbP
         sD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqA0NUV+SmxBA06xIe3yzuHeu34VHwLOZvvq0LZfQYRffvzjvABLS7yKe+P6odsRzCrsnI9IllwRwI@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3L/QPcXh0fS4DqM6vu/voWqsdm3y7LsMVruRDLjVtseUwO4pP
	h1mF/HRy1Mvb6EGN8XiVVkzOvKGLfUt6D/R4KxE58rsuST/AgyVSjgAXaOv8D5W//WincYwXnz6
	D8ue2PT/a1/w7ByATHtSddFF2icBD2sTxZwStoA==
X-Gm-Gg: ASbGnct4Wuyjjetf0P1fFCPsRx0T9pFQoioEuMFn1D+LbJR1lRqQy8iN4pOvTMQ8QbK
	GeGlM/XcmArZAR8WMLPr6pMTCparAFnIGkdrmGVbj2Un5vqcAok8DPBBia5FPtHgFHh0ZRN5OwB
	xGicHL7mo/C/TvqhuVymuV
X-Google-Smtp-Source: AGHT+IGLyByo3zlO4bBk10B8WvhvefHa79nHwJKE+Mow9N82fvs2xT5ebxfbnVkkBtodgTETJX65zKFepK3M2BTH//c=
X-Received: by 2002:a17:903:320d:b0:224:1579:b347 with SMTP id
 d9443c01a7336-22c31a7d22dmr3767065ad.7.1744752411754; Tue, 15 Apr 2025
 14:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
 <6b081163-2b00-4de9-85c1-7bc72909f90c@grimberg.me> <066cb0d9-95b1-49ac-92b4-43a212d0a7fa@flourine.local>
 <076c96a5-f399-457f-9ef1-491d81e0d8fb@grimberg.me>
In-Reply-To: <076c96a5-f399-457f-9ef1-491d81e0d8fb@grimberg.me>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 15 Apr 2025 14:26:40 -0700
X-Gm-Features: ATxdqUE8TVWLTXqGHf9kg75Ab1zxzSuFqJyLCDFxw6roIGsApUncsLtl8UUS1yg
Message-ID: <CADUfDZo8mRaaT3RhXXGJiXmkkgUmY6+=O8cEPp2rE-U-LMupKg@mail.gmail.com>
Subject: Re: nvme-cli connect regression
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, bluca@debian.org, 
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_142652_786711_FBE679E5 
X-CRM114-Status: GOOD (  18.11  )
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

On Tue, Apr 15, 2025 at 2:14=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
> On 15/04/2025 12:01, Daniel Wagner wrote:
> > On Mon, Apr 14, 2025 at 01:29:42AM +0300, Sagi Grimberg wrote:
> >> Was this resolved?
> > I've added a retry loop in libnvme when the write to /dev/nvme-fabrics
> > returns EINTR. It takes a few days until the newly version hits the tes=
t
> > frameworks and we know for sure that is handled.
> >
> >> Couldn't follow where the issue was - kernel/userspace?
> >    [ 10.397892] nvme_tcp: queue 0: failed to receive icresp, error -4
> >
> > Stable kernels started to return EINTR and one change which touches
> > this area is:
> >
> >    578539e09690 ("nvme-tcp: fix connect failure on receiving partial IC=
Resp PDU")
> >
> > Unfortunately, it's not easy for Luca to build a test kernel. If we
> > provide one for his distro, he would be willing to tests.
>
> Its not great that we now get sporadic EINTR errors. I am wandering what
> is triggering this?
>
> Caleb, did you see this?

Yes, I did see it. I don't understand where EINTR could come from
aside from the userspace process receiving a signal while waiting for
the ICResp (or hitting the 10 second timeout waiting to receive the
PDU). I don't understand how the switch to MSG_WAITALL would affect
this. A tcpdump might be helpful to understand whether the controller
is actually sending the full ICResp timely.

Best,
Caleb

