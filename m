Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AF3C5AD46
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y9eb+2i/y/0rmFF/uI6d9CeWg5pAv5OelEQTpGFPeJM=; b=1AcbYUdlKiBpf713B7/c0YOy5n
	qIOKtgaaVjdrrSiatH09OVl2GeFQE/MdCAOAdozlF76SPfxPQcFXYv/lTuIve3IQJKWhWjinePx+p
	pb/pnMKjPa/UFzFGmzw76WroKuGDfwisUmOs5M2tIig0KQ0QMHxaBNsTnkGLTMuQ4/eDto8EUq91r
	Nh9cOmLRSJ6JDVI7DqI00xhYGmjlic1xNCBdH+zbPwKhxUXFgUKtsFrNJMpr9tuerCU7AUcA3lMHO
	cLo/I4UB1XWIkkrT15UgKpyFPI1BmPhdUJa90fQ+NRmMfc+K/s9Y6OulbK0McH8FLteiGw8ThopQK
	tHLgw1QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUba-0000000FOaQ-0VxO;
	Fri, 20 Feb 2026 17:47:54 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUbX-0000000FOZy-23P7
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 17:47:53 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-65b9db5e4c1so315868a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 09:47:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771609669; cv=none;
        d=google.com; s=arc-20240605;
        b=j924JxHymCR4obrB6EFJ5iVWhT39Vu91HjkWF7kPoRDg9xwSpX0H5m6C63sUa/Ff3X
         pfEieHR/PcIp24nN5eQMEqfdjwd3uqZ1nZYTFU281hucGWzQ0khEWLojjoMh9XMp9SKv
         Gk2KAnY/rxjwMKMHz3KOmlqwc2cYL62MM0lNAf9cGeDg3diFkX/pj5l+8rpWgU7V1q12
         oECimn+zwQ5K1zMMJQX1nbAnw/xLIg0XGPf7dHOg4J/UKeK4H1dJ6NiqGXcNsi+v7xjs
         yEWz3MgWh1/pduAckoDoJKnzlPta4NOr5LL9PfdMqDFl1j3aW1mRdH0jBUqo95fyQbyf
         i1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y9eb+2i/y/0rmFF/uI6d9CeWg5pAv5OelEQTpGFPeJM=;
        fh=mFeVExl3Ioeqf5dM3RHEAY43qqXd3ZUdiAlF9nF6reM=;
        b=EgqL6QzPPBBkdYcQOlTda+n5IVIxEat6Lj9eHxrp6TGzsORLnXkwIBAxiAIw1SEmDP
         cNYRoBLWXwgsXtMIaMd0b3xgg0UCxp4dO9tWsAAuGuJMQPaDaajN3X8WnK4tAdLIBs+O
         x8zOPsDyUFDL2nZvwgQSdOnidM4Bm1hR1jmDaSWptCS+NvwVC04quuoz/DohGgJqaO7D
         GPKpscJusFaFE4/rEwaerNnJfqfapNZ0/NqTYYaywQRp6uCnPYOMupy9eKmuIQ+kiEKR
         Z4aidAaH3j7wRCL27tm8zhA8BI5eoULByZy8e6ZQkpBMa2e2auptb+1hmtc5W3YGVcdt
         38cQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771609669; x=1772214469; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9eb+2i/y/0rmFF/uI6d9CeWg5pAv5OelEQTpGFPeJM=;
        b=FID7QgRTbR+O4bFVTD+ySZDrLtevhdnPQiSGcoq3Cs+9+jk6AYtS2Hv2YH3nzTWF1h
         j5xQQ/erzBaYivVnuogvMTLVUwd8Mmc83lbpXslKT0JiO7dJFOXDUazdSbPLLQVgZL5p
         AI2dV/k6dzzrNSi5atPIKAAz+fEHzutmbFsLhc6uyyKVrX32bqdJA+LTSq4xf3wE+HWD
         ZsKsdFiTTaRrwmEDW9JnVRWDkWMdiIU6JMoKpCHFmdQYgdGBzHe4F6na6nNK7qZKzJNL
         QhW0wifuJxOElzdz26mC56JQ/tx1SmcMbIG5uGzCSkEzVqucUnawCajuj0MYpmJyIevT
         qVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771609669; x=1772214469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y9eb+2i/y/0rmFF/uI6d9CeWg5pAv5OelEQTpGFPeJM=;
        b=hBlUK1JMFYJZhGgXqzcv0b2YDb3MgjwWpmXtSNgaL5v7EFGD/aG+PTJLGDpkqgfIJt
         giUwqZeIvuVqaOk7jP6PL9NDYxEeaIoOmvW3M0J/lTN0RjOAOSwQSINcEIRRz1jL7JKW
         zn3BdhL87BOydaSmTb4/zBYIcTgFG2qDbi4gv51fGlVfkzmo+XMNsjTgHgu+gsMfDS/x
         /7J8JKqVEVSYW8jyOhxdKlPgkMEhxzZrdbb2f9QEr06gWL3wXtrwxskuxTJLgKVkz/Pe
         JhggaqxvlMPaEw7g9ryZYwbUR2GhZ2090QnF3peEE/w/bvaSB1d/KcSz79scJTqdWXrV
         Gt7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVkezRg4HkLSDv3zgo2Lf1d+/no2R5V2O9QHwnbQMesLKiDhDG1eYjmqEOz5IVsCr764pW7D1W0nsw@lists.infradead.org
X-Gm-Message-State: AOJu0YwdGdXRFj829Bn9kbdXCZeoIp0C5TdF/ZxNOH/JzV6MK4aluSzD
	uDP0Pt2LwY/5RlpSDvWJSfzP+ONWCIKI6WxqVaFclqujrQNIrx1vvkN2t9lOEwQU435mj30DN/z
	RZMLMBVkzNc5knTeRZaJdsddHzoQTweZCX3QnPfM3MQ==
X-Gm-Gg: AZuq6aLLi9jaaRVFPHctEhPM3uP7Y23/nHkfWn0+TmwUkofHPRkDfVYznCsO3LxpDTm
	Ox/Gz0+1MTt0PHeZy06zcMNDXrmIq9vRU3DcSOewf6jpeT6v7vnfFNFYeE8MZ+8elBdZzi5Warv
	0/ha571KFWadHhnjWNLjuL5w0crV5txPPNkYpoQm7BUn++IG/KiSg82/JQ5YM34i+t2rbBGnkgt
	sVmMFgmX9HeQ8+bhrrWqgUM56qqg9HKJo6B+W0GYmnqVNHup8AM+MdOv9LBQveDwLBhvTCr1mSA
	iMjE7gZyqTSR/Mfe94I=
X-Received: by 2002:a05:6402:518b:b0:659:7edb:17b4 with SMTP id
 4fb4d7f45d1cf-65ea4f288eamr132202a12.5.1771609669372; Fri, 20 Feb 2026
 09:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20260219172228.429479-1-csander@purestorage.com>
 <aZhuwOku9lFe33UM@fedora> <CADUfDZr3ksmd=ZZOhU4RJsqEzbxBHnDPCtOQXJ5ft=X7irWvPQ@mail.gmail.com>
 <aZiHlp8nOPgQFGMq@fedora> <CADUfDZoxW0m4nptfNYqmqFCdTj6zSaYOk1vYSKU5JztkjEjD=g@mail.gmail.com>
 <aZiMS9EZrOqEBhQL@fedora>
In-Reply-To: <aZiMS9EZrOqEBhQL@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 20 Feb 2026 09:47:38 -0800
X-Gm-Features: AaiRm53s86E4gHXC0k34rdUE13VMMBnLURvZ1nvvNYQnBupQcBAWT-zzyK13aNY
Message-ID: <CADUfDZoRFRzXd4c=qu+7i5nTqFi1BfC4DvaDXA1neov591ps3w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Anuj gupta <anuj1072538@gmail.com>, 
	Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_094751_593709_EE6B8E9F 
X-CRM114-Status: GOOD (  30.74  )
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

On Fri, Feb 20, 2026 at 8:31=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Fri, Feb 20, 2026 at 08:22:29AM -0800, Caleb Sander Mateos wrote:
> > On Fri, Feb 20, 2026 at 8:11=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Fri, Feb 20, 2026 at 07:55:33AM -0800, Caleb Sander Mateos wrote:
> > > > On Fri, Feb 20, 2026 at 6:25=E2=80=AFAM Ming Lei <ming.lei@redhat.c=
om> wrote:
> > > > >
> > > > > On Thu, Feb 19, 2026 at 10:22:23AM -0700, Caleb Sander Mateos wro=
te:
> > > > > > Currently, creating an io_uring with IORING_SETUP_IOPOLL requir=
es all
> > > > > > requests issued to it to support iopoll. This prevents, for exa=
mple,
> > > > > > using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
> > > > > > zero-copy buffer registrations are performed using a uring_cmd.=
 There's
> > > > > > no technical reason why these non-iopoll uring_cmds can't be su=
pported.
> > > > > > They will either complete synchronously or via an external mech=
anism
> > > > > > that calls io_uring_cmd_done(), so they don't need to be polled=
.
> > > > >
> > > > > For sync uring command, it is fine to support for IOPOLL.
> > > > >
> > > > > However, there are async uring command, which may be completed in=
 irq
> > > > > context, or in multishot way, at least the later isn't supported =
in
> > > > > io_do_iopoll() yet.
> > > >
> > > > Can you describe the issues you envision in more detail?
> > >
> > > Basically IOPOLL doesn't support multishot request yet.
> > >
> > > For example, when io_uring_mshot_cmd_post_cqe() is called and new cqe=
 is
> > > queued, it can't be found from io_iopoll_check()<-io_uring_enter(IORI=
NG_ENTER_GETEVENTS).
> >
> > I don't think that's a new issue, though. You're right that
> > io_uring_mshot_cmd_post_cqe() assumes a non-REQ_F_IOPOLL request, so
> > it's up to the ->uring_cmd() implementation to ensure that (which ublk
> > already does). Since ublk's struct file_operations don't provide
> > ->uring_cmd_iopoll(), any ublk uring_cmds issued to an
> > IORING_SETUP_IOPOLL io_uring won't have REQ_F_IOPOLL set, so
> > io_uring_mshot_cmd_post_cqe() should work just fine.
>
> Please look in the following way:
>
> 1) without patch of `io_uring/uring_cmd: allow non-iopoll cmds with IORIN=
G_SETUP_IOPOLL`,
> multishot command submission can't succeed
>
> 2) with patch of "io_uring/uring_cmd: allow non-iopoll cmds with IORING_S=
ETUP_IOPOLL", people
> may see hang forever in io_uring_enter() if multishot command is submitte=
d
> in context IORING_SETUP_IOPOLL.

Okay, I see what you mean. If ctx->iopoll_list is nonempty and a
non-REQ_F_IOPOLL request posts a completion without going through task
work, io_iopoll_check() won't check for CQEs already posted outside of
iopoll. I think it should be simple enough to check for CQEs
unconditionally in the io_iopoll_check() loop.

Thanks,
Caleb

