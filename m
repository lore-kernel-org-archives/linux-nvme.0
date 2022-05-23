Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62902C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Y/b7qQz1Z8wX0+XT2uJT5XcPJkZwCeLkZyeDlo3vOo=; b=Ws3Bt8v+DDdp3+laiNSLztiim6
	ULu1HL0jNIgHX+J+I0JXmRPFojPWoSc+sjCh7xXOHSS5XAHSQ4SU8o+Mvkw/ATxOoMQ46nFmrMQZW
	1Z6I5lia/xeCBzATxJSjLRTMxBmaVMnPBNH8NfD41gdDxmtNOubtH98cbrqRQuojkq3DKnSIcf76x
	/mu2QljaJkXi7YjJ7K6XNF+u67BoztjISRI9I5MkxYLDLAeWrhmf7d/DPpZM2CFZ6P9P5AVgmWOcT
	nYIgjODAefBgWXEnW5R268hOp0qzaP7GsqkP49BvhO3oPFOi0VDjX5N38bNrNE5gjPEaa7emvdDHM
	m+pGvHAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntAlN-005CP5-0D; Mon, 23 May 2022 16:18:33 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntAjq-005Bfx-Sh
 for linux-nvme@lists.infradead.org; Mon, 23 May 2022 16:17:00 +0000
Received: by mail-yb1-xb36.google.com with SMTP id x2so25958595ybi.8
 for <linux-nvme@lists.infradead.org>; Mon, 23 May 2022 09:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockbridge.com; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=0Y/b7qQz1Z8wX0+XT2uJT5XcPJkZwCeLkZyeDlo3vOo=;
 b=VzTjI0XB19D3VvojfjGskYDWgPyCZhSKk/obdDJuN9y7qikz85YtbnSs7W44m8d0kW
 VBvnNlMMM7fg30G+n1N/sHZKkQ/GYyF8e0QAdzQH6K4/2X8SJMMNITwPyl/fjd3Rubch
 pGdXsYuwPIAY4qkUVUsOyx8g0+wCanL5zozGu1Ghu7A3cXb+B0X62o729diygXAArIJ4
 xZEVDT6It+fIgP2t781qJocUtve/SbkSxKzRzFL30DrqVTKeBCafp+Cwomy/W4LF9GlX
 DqtrWvGvd8pyQegXLgDDUqkNy/6ljn1SPBddK3S7p1S9PhGLIuptPl38JcmPt8AndCWd
 m8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=0Y/b7qQz1Z8wX0+XT2uJT5XcPJkZwCeLkZyeDlo3vOo=;
 b=tHM50zGVE2vgRkh1zamaW23pxdSLlro/mSO1uUcQ4B59nnUizvWx7mvlNQ/fycLhgu
 KkxSnTNqr/PzI6/lUQIfHW4hcecwax7OO1vCkLID83wKMOPojRysBz5gmxHVFqePNxaz
 JlaCa54rxQ6P4iHRs+pPYalLVpuuvXMKpXPF5h10uUaXaeREsWzN8w+fmG1a6pEKtmYO
 3o7Qcux1MmpCK9jBjEFmHr2gIgKscFuz7Unk31d5ZF4fUgkpsYdoJECol87Ft5mfa0IL
 M0V83X4ukgp01IRpkX1F8zLSoLRiS1aOL5pCEJmCyFYEixJOWOFUoJEs86UGclDEUeGJ
 f/aQ==
X-Gm-Message-State: AOAM531LwbbhLUexoS5jkF/aeee3afVFBY3ukesusgCWHoak/up3M0x5
 OInUu3cyctULmiqjO0iYS7uvqsiCdCQAzNBOc50Jnbq8rz1povDa
X-Google-Smtp-Source: ABdhPJzkDS9QRp2SghgMqG/sFI64NWCpZA/CuLkxsri8zu95fdzgVOgBQ+k0fQ+Lt+OOf10u1bjfEdBoysI/LXIkxAg=
X-Received: by 2002:a05:6902:282:b0:64d:e139:c9b8 with SMTP id
 v2-20020a056902028200b0064de139c9b8mr23566791ybh.6.1653322615686; Mon, 23 May
 2022 09:16:55 -0700 (PDT)
MIME-Version: 1.0
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Mon, 23 May 2022 12:16:20 -0400
Message-ID: <CAHex0cqo3ChdXgaXRAeqZaVWSZBDaedCd9+M7Krdw=St6q6cyw@mail.gmail.com>
Subject: nvme: split bios issued in reverse order
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_091658_992493_47FD2FEA 
X-CRM114-Status: UNSURE (   8.89  )
X-CRM114-Notice: Please train this message.
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

There seems to be an inconsistency in the order of writes that are
issued after splitting a bio. Ordering depends on how the application
write is submitted and the number of I/O queues configured.

In our testing nvme/tcp, a 128K write issued with fio/pvsync is split
into four 32K I/Os (the target maximum data transfer size is set to
32K, and max_sectors_kb is therefore 32K). As expected, the four write
I/Os are issued to the target in sequential order. However, if the
128K write is issued using fio/libaio, the four 32K writes are issued
in reverse order:

fio-8098 [001] ..... 254009.711080: nvme_setup_cmd: nvme1:
disk=nvme1c1n1, qid=2, cmdid=16468, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=192, len=63, ctrl=0x0, dsmgmt=0, reftag=0)

fio-8098 [001] ..... 254009.711083: nvme_setup_cmd: nvme1:
disk=nvme1c1n1, qid=2, cmdid=16467, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=128, len=63, ctrl=0x0, dsmgmt=0, reftag=0)

fio-8098 [001] ..... 254009.711084: nvme_setup_cmd: nvme1:
disk=nvme1c1n1, qid=2, cmdid=16466, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=64, len=63, ctrl=0x0, dsmgmt=0, reftag=0)

fio-8098 [001] ..... 254009.711085: nvme_setup_cmd: nvme1:
disk=nvme1c1n1, qid=2, cmdid=16465, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=0, len=63, ctrl=0x0, dsmgmt=0, reftag=0)

Further investigation found that if the number of I/Os queues is
limited to 1 at connect time, the issue order is sequential for both
pwritev and libaio.

I've spent some time tracing through the bio/blk_mq code and
can't seem to find what might be causing the difference in
behavior. Can anyone confirm that this is expected or desired
behavior?

Thanks,
-Jonathan

