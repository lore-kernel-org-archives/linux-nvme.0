Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB45CD4F3C
	for <linux-nvme@archiver.kernel.org>; Sun, 17 May 2026 03:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7RMMlpFqVvmvtzBmpLVq7DRJ/Q6MC30z0aqZkBqE7po=; b=NkjI2oBz/M9fXkj7rROOnxSj1k
	th94pRVPdi82YO9/NxbELFGLwB5/UX84Ppfk3C0t9FZA+dUcVBkTLXcU6Wne3yhsxXbyMh+G8fQNF
	5JZuiPOiTj2PgKSV0ayL8Wod47UVpgG1V8TdqLBYJarqY1aGBUWmo0FDw0aJiTvhRjtw5lzmxN12Z
	wAwjpvmh4f88WiYzOHL0SwMtCAkFyhJZ4fbDwWRsxrHh5+z9Vb4BQJVKHyUmMh7z2OzjOlJgfTB7K
	qWciktR54cHnj2P2G4txljJE04b6lYdiEgjnJnlGfHYhUDZ1m07rveQ+fQ04pl/miaYNovwmc7xha
	EMP01Mtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOSZv-0000000C1vI-2GW9;
	Sun, 17 May 2026 03:54:11 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOSZs-0000000C1uw-40gs
	for linux-nvme@lists.infradead.org;
	Sun, 17 May 2026 03:54:10 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-bd2087858c4so319415566b.0
        for <linux-nvme@lists.infradead.org>; Sat, 16 May 2026 20:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778990046; cv=none;
        d=google.com; s=arc-20240605;
        b=NK6q0zFrU86gTgrl6uQoo0i9MxsOHmZsCaOoqoX7kfoJ03ZWBJLywvp0y1eMuYQ9rf
         Y+UlQaqqLI4gCr+pAXQLIA+Y2tO9amSKysXSxvkF6VmWI/uLEseHNKM07uYXjV3ptKTi
         9Aju0THQTI8ooo4dXxBoAB89FyEnsS0FH6tGpmtry5xaiVPNzMW75qBlpnAMbHIBEADf
         dJbsd962OgciG929NEKiM43ITpJ0/A6cBhgONp7Cx1In+SvSH4WoSCeip0sB2/S5KcoG
         wY8YbMP+HZPJ2MBfEF9DWXSjP6ym4QgZkYlbLjGsTA3Nlb05aG1+jY0z4+7nVQYY/hOk
         QD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7RMMlpFqVvmvtzBmpLVq7DRJ/Q6MC30z0aqZkBqE7po=;
        fh=OvqjbeEWoAiYvq4gTDVxacVev+ajdsCdL2TSvfcd0as=;
        b=S4AWAW1wbqlcJBMnbgldqNAWO5QVmEFR8WHfOYN57M70Y3rPjE9VAYigrrqCrgzCEp
         aDof72XMAJovD9MdUh2rR0eyjEBASONZz+sAbsfL8dI1VUe3mL71uMROrM3tvw6EavTk
         nKiG6myYYbpgKiPsCyothfRZM9erMvDPaQKmLO/+qg963qy9+97GNarGRJNEWXCzMlJ8
         B9ZU5Tqcn0SnWl4FrXVgNLzb81Mhpf93ex4fM5rz0KBEFtsPHYmJoPKsQmxUqJzSkyJ7
         VokXPTuqi00XwhuA27YokeM8Ba4yOf8JykUwj1Td94R2NMJ9SHR8FIUadscswTXs5TlF
         Rujw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778990046; x=1779594846; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RMMlpFqVvmvtzBmpLVq7DRJ/Q6MC30z0aqZkBqE7po=;
        b=PxaL7Wi8HATWgUxgRbxNs0EnXVArwoPwK9gJre2LI99EnRDJ/0DNvRImWk02SULWgS
         PRKzqemeNAb2HdULyZ0fiTDpQy9hmMKozqAcmTjBi7yFsibTGToje+1JMKBCF5JRvXO7
         NK0cOixQr22REQJQ83NHZvHaPS53hhzYgkL38Q3MszaJLCqpSs7XrHRvn3M5a9SQeHNV
         zb5s923zrhRaO0hnbJCyEX2y3VybzPsH9Tg52Ov9QweqQYXfN5NFrmrkpL4JjGPyNGzV
         YcknJzp18/hFPRz4koH9l64pQHGLQXb+Fmd9KBWB30/wXtOkhQRUaZcvPjfGDt1HCcG9
         aEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778990046; x=1779594846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7RMMlpFqVvmvtzBmpLVq7DRJ/Q6MC30z0aqZkBqE7po=;
        b=dlu/kvko2t7Osz1MYgZVif601KxC/ie97IsEMcHBhSIpqT00S+jIdBN20lr++zCwKw
         GrBlKedxDHs+x0gwJEGO7F3qRqRUEP/PdUDVdCGRrcpTK4BNFYuCkDwSuxFV1nLJTP9c
         aLj4PJGHsymwBFqXxr+zh2zUNln69bwxiVpNnwaInEUFQXEJYqNklAHDleeBA/pewZQw
         LhinA7AdD8eidqgcBGksTxNcLCwd7Hyra8flhWanolGg84du0yZ2yoX/iKj/RpjZw9vs
         vDNeyNrY/X+dMdqFojaLiYaTdJ3KhDe4HC+R3/S1CswQiPDXr2VBpqevb7SOZUemw3UW
         LLFw==
X-Gm-Message-State: AOJu0YzwEqwRh8yk6EiQLRo66I6zmQDrPY429tQzaFrME9SxYxeUmETU
	bxsgf/H0UgQOJMTC6/eFz32kjL/P42rqzxDi8vvokEHOoxiALRbbZEdLkn9MbecmwsDsT/9WN3M
	tuMRMtvaD9pm5UBTODQYuduvvWX1HgGs=
X-Gm-Gg: Acq92OFuulEG3lbdtYUGb4j+EXFhqQ5SOGqitJiU24NaAev3mW6uXqAckoy3YMqHP8X
	MoA3lIXKgdzLR+ggLpYK85yZIy7pYTFYCSVGCnnbwh6nxxuQBiUNOkQRQ3L4pPM1kBLHy5vHldI
	3QZjt7s8umftYhMC5fs6LqH4/0DlB7mBs/gDE720y93ilyWdZjwUxvCTbNOYys1WEvFfcwfQ3E+
	u8NcwVYmVd6m0XkP/xMFkZ29VIeMWBFddnGXDhiXfuIv1Z2oQtVDqUkHTSvEpDM3YzCPON/tPQb
	yBx+t+06
X-Received: by 2002:a17:907:c986:b0:bd4:4593:33b9 with SMTP id
 a640c23a62f3a-bd517906724mr423581766b.29.1778990046237; Sat, 16 May 2026
 20:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260427003457.1264511-1-coshi036@gmail.com> <afzWCpJSqvjnTgpF@kbusch-mbp>
In-Reply-To: <afzWCpJSqvjnTgpF@kbusch-mbp>
From: Chao S <coshi036@gmail.com>
Date: Sat, 16 May 2026 23:53:54 -0400
X-Gm-Features: AVHnY4L4Duvx-nXwPTEWE0E2GcE0_-GkwRySgFerna8-h2xgKx1Do0-p3kYWJr4
Message-ID: <CACd_6n29MeACfWpqK5jaSPOVK+q5yop+eeuO_Wk0M0E5Wr7ujw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to pr_debug
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de, 
	sagi@grimberg.me, axboe@kernel.dk, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_205409_017154_CDE83E76 
X-CRM114-Status: GOOD (  18.10  )
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

On Thu, May 07, 2026 at 07:12:26PM +0100, Keith Busch wrote:
> [...] how that was defeated [...]

Hi Keith,

Not the freeze.  The WARN does not depend on q->limits, but on
ns->head->ms (read live at dispatch, set inside the freeze window) and
on REQ_INTEGRITY, never set for EXT_LBAS-non-PI.  capacity=3D=3D0 only
gates submission (bio_check_eod()), not dispatch: a writeback bio that
passed bio_check_eod() under the old capacity sits on the task plug
holding no q_usage_counter ref, so it does not block the freeze;
blk_finish_plug() flushes it after the update committed head->ms !=3D 0
(dmesg: the capacity-change line prints before the WARN).

So it is reachable -- the host-unaware geometry change you described,
unrelated to your block fix.  The deeper fencing gap is the separate
TP-level issue; v2 does not attempt it, it only stops a
device-reachable, already-safely-rejected dispatch from being a WARN
(a panic under panic_on_warn).

Thanks,
Chao

On Thu, May 7, 2026 at 2:12=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Sun, Apr 26, 2026 at 08:34:56PM -0400, Chao Shi wrote:
> > In both cases the bio was submitted without REQ_INTEGRITY (because
> > blk_get_integrity() returned NULL at dispatch time, so
> > bio_integrity_action() returned 0 and bio_integrity_prep() was not
> > called), and it reaches nvme_setup_rw() for a namespace where
> > head->ms !=3D 0.  The existing BLK_STS_NOTSUPP return correctly handles
> > this dispatch; the WARN_ON_ONCE is a false positive.
>
> This is what I'm not really following. The cached request holds a
> reference on the queue that prevents the queue freeze from proceeding.
> This driver freezes the queue along with the queue limits update. As I
> mentioned in the other patch, that was supposed to ensure the block
> layer had the updated limits before it could allocate a request, so I
> think we need to understand how that was defeated to get to a real
> solution.

