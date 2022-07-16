Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33E7C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Jul 2022 03:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vYR3WbTFw4TG1sTb7Tx0DmmRBxroaabfz9k7MAvXkH8=; b=MeqFsWY6ljxF+r3M2E0pyxqUcx
	IqqY7Jsef8fM7aVI8dKLIA3nxCZGiUIlGqHIg61XJJWBE5xRoNmDPTlvjDP2i6YWxViHOu9vseQ3e
	ASNPKFnEoWl9Y16SjpKEIn5YW070EupVp0a/AOwpTSMjOqhV2COM9T5vIPJjVEmR6pz/mLSCwYAna
	TsAquAWSNVnzqN50TlC8D8MCx8cYvnTqT+fI/UaOu+egNidpNnk+Td7SSEbTLZQt2Cwo4naOF/KoU
	N+kgktlFKABhdznv0bmU/REvb0ehZZKuo6NOBKXav3sf7IDKzagMtMCxDK22kNfCWHPi7XbKVN6Ne
	FOtiAxlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCYYZ-00CiMJ-R8; Sat, 16 Jul 2022 03:33:27 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCYYW-00CiLR-P6
	for linux-nvme@lists.infradead.org; Sat, 16 Jul 2022 03:33:26 +0000
Received: by mail-wr1-x433.google.com with SMTP id a5so9143906wrx.12
        for <linux-nvme@lists.infradead.org>; Fri, 15 Jul 2022 20:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYR3WbTFw4TG1sTb7Tx0DmmRBxroaabfz9k7MAvXkH8=;
        b=k7qQPhMi60UEu2t7Hy049XBotEoKQQS4zKTvIZbjutCVW3oOPDzfx/tdLWSNpBnAuk
         Qr/jpVC/tkzaqBgeT7DhsxNRpddneFPr3lGnPMdRZ/fGzqTxOFFowlSmNl0f0yiNCaQ7
         KZJdZiyJvNaLfDBguZfb3B7tsLe1EfdJeZfL4jgVhJEKCKAhUFGFj/sqH9QC8ChW0wyx
         7WALWpRiTCSmJ+8hllhUoERb9LdVasszLNciNqU1jLpTCCcbZ4lJkMXJRTIyFs9jgJPO
         od5s4hxPHJN/vuFDpKdYJFXkhyMsKp53LyJ41wKjw3fRXmiA/Q6pISDX8GV1EJSRthLX
         ETrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYR3WbTFw4TG1sTb7Tx0DmmRBxroaabfz9k7MAvXkH8=;
        b=zc7998wDCgRNMlFt49ztpd3AhIu/Sm3zZuvb2ibJrUPCGocVAn6Mee/BuHM0lnXqnL
         qVngY6P/fY6tQhNeOSpqmOyHtWIzyFmxgJhkhyWukYNYnj8ZgWAnQOH7Ck0JgRKrqxuG
         sk+av1J8SN2zdBjtLMHt2Hi2W4hd8txp8gIOS76MVN+UxpweDqHMNaHxfRQmJRlXbK1z
         J77YTrHXedr+oxIXGdwQP6nq3zGeKsqtv2A20SFpVLQoNioJuGejhtD/a/ss/qbvjVRx
         79RjSlm8NP8cx7l3Zu2/+U5kfdByyx5pgxEfpo5sHbz8RNkrlq7sLxGABf+8BQe9AYLl
         FGVw==
X-Gm-Message-State: AJIora/e4AfgpaBmSNHOUaNsyhzCnDsn+HhlUTRKJlTuGkl7BkxxiXtJ
	sWaFg5JXepG2+oy1t7nlTpkP2mYESIC9Xzdv13lq
X-Google-Smtp-Source: AGRyM1tBYotr89sxZgUpj7Rz0paH0nzxUS6pduI0qUwqAk5vOCrzC6ovujPmRSHKTDcGuNMqQfswDSvUMwdMgE31v98=
X-Received: by 2002:adf:d22f:0:b0:21d:6b26:8c6f with SMTP id
 k15-20020adfd22f000000b0021d6b268c6fmr15647822wrh.70.1657942400130; Fri, 15
 Jul 2022 20:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220715191622.2310436-1-mcgrof@kernel.org> <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
 <CAHC9VhRzm=1mh9bZKEdLSG0vet=amQDVpuZk+1shMuXYLV_qoQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRzm=1mh9bZKEdLSG0vet=amQDVpuZk+1shMuXYLV_qoQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 15 Jul 2022 23:33:08 -0400
Message-ID: <CAHC9VhQm3CBUkVz2OHBmuRi1VDNxvfWs-tFT2UO9LKMbO7YJMg@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,io_uring: add LSM hooks for the new uring_cmd file op
To: Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>
Cc: casey@schaufler-ca.com, joshi.k@samsung.com, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_203325_059938_753D6A8C 
X-CRM114-Status: GOOD (  19.74  )
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

On Fri, Jul 15, 2022 at 3:52 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jul 15, 2022 at 3:28 PM Jens Axboe <axboe@kernel.dk> wrote:
> > On 7/15/22 1:16 PM, Luis Chamberlain wrote:
> > > io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> > > add infrastructure for uring-cmd"), this extended the struct
> > > file_operations to allow a new command which each subsystem can use
> > > to enable command passthrough. Add an LSM specific for the command
> > > passthrough which enables LSMs to inspect the command details.
> > >
> > > This was discussed long ago without no clear pointer for something
> > > conclusive, so this enables LSMs to at least reject this new file
> > > operation.
> >
> > From an io_uring perspective, this looks fine to me. It may be easier if
> > I take this through my tree due to the moving of the files, or the
> > security side can do it but it'd have to then wait for merge window (and
> > post io_uring branch merge) to do so. Just let me know. If done outside
> > of my tree, feel free to add:

I forgot to add this earlier ... let's see how the timing goes, I
don't expect the LSM/Smack/SELinux bits to be ready and tested before
the merge window opens so I'm guessing this will not be an issue in
practice, but thanks for the heads-up.

-- 
paul-moore.com

