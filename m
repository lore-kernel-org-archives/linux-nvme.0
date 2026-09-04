Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D778EC79F80
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2026 16:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3vcqoHjxbkKU29odZ/MlbhZ2L7DAS/GwMPMBrrZSUiY=; b=lvbkC5ZsCWxn0+OQ/j4jA90wBp
	7zZhUWX6JTr+6oW/ahlczUKU2MOsg58MmLK9iW/K8FtA8gIX2eXRSZs58Mjy6zDViya4a/Gown5jY
	TTip2IXT+ZYDI6BW/v6pqslWYGkmA4nrhSHHu1A+F3fANI2PlMmwoGr10QPkb75fhoVk+K4YHxjyT
	Xby3+VkvbB3/8BuDq77FdwkJeI4WMOr/bnbXpZVVr6unc00XGS53I9k1h1tICFIUFpWXWwyXCP2aT
	tPBuZIeidZzWpm8q8cDk2a8XUtfCP3h2/v5EvN830ilXU3Zu+zrx74sf3765ZnafqUok6oRtRES6G
	71kGhclA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2WPf-00000002fkd-3Zpa;
	Fri, 04 Sep 2026 16:05:11 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2WPd-00000002fjP-20oN
	for linux-nvme@lists.infradead.org;
	Fri, 04 Sep 2026 16:05:11 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-517dc520840so14894521cf.3
        for <linux-nvme@lists.infradead.org>; Fri, 04 Sep 2026 09:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788537907; cv=none;
        d=google.com; s=arc-20260327;
        b=ik4Fovel+qnUP79ebo5O2DvF7XAr5Fklc9fizhsJlJ3DfFG3LW9jvZBX8iuoiSZKAk
         z3038CJsu2oSxX9vbEZ7OrmB532qsUot2ZDEOf2a1QU1tv121t7tKNOZFnT5jiDaDAp4
         m8ZLN4+DGewtsJaCVA+16mgQyAT5PQbHUbvb61ix9cCvIRvwViyL8PnQHa+zfyB6niPf
         wSW7p/qhg57T4BBLnyEiISwiSRmATVaKQurcu9fP++aQn7xblPR6FFmjKRHSW0hEZtbY
         H181vmkWO/EpC9xmuMPAqY+UCP7LS4dzFfTxoVMOk92Q1+c5VXirMNZl94LyAvIXaFWm
         d7lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3vcqoHjxbkKU29odZ/MlbhZ2L7DAS/GwMPMBrrZSUiY=;
        fh=CYenh+SXh4HYcalqn40NWyT/xEOI14lW7hvU1KOVHNE=;
        b=FhqaLQHY9+10YLjpezBUvZeW6GozZjbrrP7eKOR4IsBt1GESffvbi/ehBUaoLSCdXR
         n5/MqTZdUtM2TYMDV2KtMrjVm52rebB3VjnA4QyOoEV9bU/GgdpInttYztLDwKiJ1E7o
         Ra4mwIdum1NKJnu1g3j/+GG6Y1NZlKoCgTXMHPqtVJGUpUEHiJJTDn0mUNnFWf3u1MNE
         SJArQZTiIBSiWzMiQIJIbqNZXXEniQpHa6lyRONezRZRBXPVqnzwq12HqOlUeZ2anwDS
         wUMRaEe5LngXnu05u1L49diB5NY38xAjNdj2qYLJu5SYOj4YawQ4Ub8CdF0HRs2RDMgA
         3xog==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788537907; x=1789142707; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3vcqoHjxbkKU29odZ/MlbhZ2L7DAS/GwMPMBrrZSUiY=;
        b=TX5bCh+VpBP6+YEdlOFrWqRKip47Vpm98mpOmT0ibF72P0Q9Z/Su9YAJrGm6bWTHh5
         5eYKBCsBQPyCutiUEbEBggiHkiozdQJi1EJ/d25y/C+1iDsHtgf5+svdzhfm1r+H96Mq
         BMKuPUVonxH5A8BR6ti6MXfv4BqQSepZMBvmEJMEZsn9359YYZMnUC5vZK6dSGSq866I
         RTQWSh+/3YKhfLTVpUItoHLfdfVnENmNSflI6uhdkoJSIQoEe3y7pk4bie9+ddjS5fwf
         F4tFsxjqsoTapKyWdKN0CRwbQ1zwkCBpJNlwMqf43CHljJs3EgDhvbJzU6wGlML7JbJV
         ehfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788537907; x=1789142707;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3vcqoHjxbkKU29odZ/MlbhZ2L7DAS/GwMPMBrrZSUiY=;
        b=YIM+BxjZyc+ci2SvgdZEhxLiAAQLFCund4kDVeC/uzzS/JxFQ89ZlrqmfpcREkPQIM
         TCtat/UX/7ED1pVwkasjYqpIk7qQ47ZJS4n72KJORckoYj9jb620fGfptfrDQ9jNEuIw
         OvINfBISy2DIg0Xgup9hSUkOu/Y4yMY8kAzMbvWtFGrbdhjFampZv9yssLOn6MBBv2f5
         BZGMmMjRX+Xa2hOvBUgkKHvpWHUY4V0FvS+5bKm/5ppySbne1qFfmYrsteAZaw8S9fQs
         Jlc5jRZYszLwROhBatVczWCS4uJi178ziUT22hXR7jASqApoFovOKpgW4XCfUqKvhRdM
         0ZSg==
X-Forwarded-Encrypted: i=1; AKwUvByTisSpSlajMwm0IMvQDMT2EY6KZrxljBoW2JMhXCJpYhdeJcGINRmTMTg4U/5KcdUTAZ1OodOshzqY@lists.infradead.org
X-Gm-Message-State: AFuF++nXPkJzymaB71Rst1/3wrh61nQHc99iwdwMqhY4klEKuaSFerCf
	N7LNL5VoGfU2JB4b2AtUSjHlMj2bmMDpIJI+or5QZTdjKgqftUUbx/sThGUxPwa94P++wN/LcJe
	5jdWHVyUIBVxI+9cT6eSJU+/HGBl0FhyqVO9FZrPaZQ==
X-Gm-Gg: AYBFou02WSMvBBwnYDsiT1WA5eI8bj4XHjXKLttULN4op0RgH8Us2mcqvzhJo17uiMj
	8LY+EFLBny3/fK99FBzFlrktjWQIDX7i75E6ePGHuvrZCktx1JI8bHLg5YP63s7Yk5vnK9xB4iF
	N8Y4H+jtAPiZzL8BkJq3obzPhpdx7DBLFWznEloZhRT4NEBVKXv1NZET8ovWhf8MkKJyzJdmj9b
	U07V46Ej417F0aEzTTpMJAIOS4p+dzgmXqwWSgrMi42Mdf7sgCsV0vxzguUJroOplAeAosFsFGh
	pTf4ovl7URFmoQWpWxY/Pz6IsSuBNpzGgDiIkYxxmqkK
X-Received: by 2002:a05:622a:4c14:b0:530:3855:e8cf with SMTP id
 d75a77b69052e-53054674fccmr81819351cf.1.1788537907041; Fri, 04 Sep 2026
 09:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260824225648.316962-1-sgogte@purestorage.com>
 <20260824225648.316962-3-sgogte@purestorage.com> <c98fe50c-172a-4e53-a30c-5416c40cb23f@grimberg.me>
 <20260830222558.GB1842415-mkhalfella@purestorage.com> <4f2d2b60-56f9-4ae3-b38f-bba9754011df@grimberg.me>
 <20260830225939.GC1842415-mkhalfella@purestorage.com>
In-Reply-To: <20260830225939.GC1842415-mkhalfella@purestorage.com>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Fri, 4 Sep 2026 09:04:30 -0700
X-Gm-Features: AcwNN1Ww7ukPMIsSf3t5NTJ9ZuKHOtbeoPChRBk62ipDmvtM36xAVG2ICigmM2A
Message-ID: <CAMof9cW8JFu3XG+BZc-ejG-fvsodQ9ygYbV_ttgvX=Kc_JjXJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nvme-tcp: parallelize I/O queue allocation and startup
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	randyj@purestorage.com, adailey@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_090509_692125_65F7CE16 
X-CRM114-Status: GOOD (  18.16  )
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

On Sun, Aug 30, 2026 at 3:59=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On Mon 2026-08-31 01:44:32 +0300, Sagi Grimberg wrote:
> >
> >
> > On 31/08/2026 1:25, Mohamed Khalfella wrote:
> > > On Mon 2026-08-31 01:00:52 +0300, Sagi Grimberg wrote:
> > >>
> > >> On 25/08/2026 1:56, Surabhi Gogte wrote:
> > >>> - ret =3D sock_create_kern(current->nsproxy->net_ns,
> > >>> + ret =3D sock_create_kern(&init_net,
> > >> I don't think we can just change this...
> > > Why we can not change it? Today the error recovery code running in
> > > worker thread will be using init_net anyway, no?
> > See commit: 1be52169c3488ef98582ed553ab35cefa3978817
>
> Thanks for the pointer. I was not aware of that. What about error
> recovery case? I _think_ it will be using init_net, no?
>

From what I gathered, reconnect and error recovery run on kworkers,
so those paths were already resolving to init_net even before this change.
If we pin the caller's netns to the ctrl, we can keep netns consistent
throughout,
if that is desired.

> Also, Will the change to sock_create_kern(&init_net) break the fix in
> commit 1be52169c348 ("nvme-tcp: fix selinux denied when calling
> sock_sendmsg")?

