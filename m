Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C00C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 09:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SSWdIHLeK6c5qkRxJRQIzSFopdFgLqZQ5bZ8370mvc4=; b=xGJP2KnvEK9ooVNkrwTOil00Ih
	EExeIuz6QwI7RU2+MKWr+YOdH3/qBzVoytfEAMbeWBEIro9IFDRWhhWidrIC7vwJRtCStkpnrW7vh
	+Iukt8/g3iACvdQYPF93ey38HqvIlLezw5RfxunL6nzCOG4MKVJbtQ/Rty5Z8FN6mgpt/Dc0ziLDo
	blBqB7xeAyRev5FB2YJXrMSoh9w0AEhudQkdx+ZcXsnIdooovmANnwoqxgrRMT/gMdB7jyE0Lpjb1
	bc5whsLjlJoYSrRDpLqKTlrZz1EFKGIbbUonSAWKKDyA1wr8IgUJh45/H3KOqSveW1vfnPin41oN/
	TteivLmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGxg8-00000008GnC-1fdN;
	Tue, 11 Jun 2024 09:20:32 +0000
Received: from mout.web.de ([212.227.15.14])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGxg4-00000008Glh-1bbX
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 09:20:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718097309; x=1718702109; i=markus.elfring@web.de;
	bh=SSWdIHLeK6c5qkRxJRQIzSFopdFgLqZQ5bZ8370mvc4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FftRtfIlHxGUAI3vCcm4yTpn/7z8WsjG+Em5dB5ND9N5eedR+QTMfkd+w7F2Zs2i
	 WI1Yj0slkHGiDMKMlDkpOiP/MjEK/B6R2dAiV03zMK6+t4kT7xBeCDDQ888uoe/W3
	 HMJ+HG6g52cDLWKEcQbr6xXdD9cRTtNwHwz+bFZPPzkQ7TcZrvW0MggwyEXpoOwch
	 F1SP/+OJXN2UQv0MqjXDYRgbkFIKPiQyMGI39/lLF6bCcLm4PLaCKaVl0+whiFMsB
	 SB0PgbV6ShDjyXNFTfm7jH/gkRm4xnMBSXmDKl3ZdmJohCKk1XemhGUQoO6np/E5N
	 r5idNtThZcYbX7sxNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSqTK-1rq7cJ2zhW-00J0sU; Tue, 11
 Jun 2024 11:15:09 +0200
Message-ID: <0e1ac9ca-c241-4b48-a219-d1aaef2a752a@web.de>
Date: Tue, 11 Jun 2024 11:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ye Bin <yebin10@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig
 <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240606062655.2185006-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GHmc89SQ4Td/zPwUg//USd5islR+tdgleigB+jmBeZEuq6FZ7Dy
 fkE7CjeiMfQNvzY0YK08nYlilwmnduxqbtLEXlZPIHy8TtJwqsAsxfDMtv1kVgp7vN7HY3T
 IALqM09md0BMzdXXkahjw/wqc3/g/o4um3hx2fvO5m4g3LdePf+xlz9QuKO0YSskYbKSlDW
 ouYkrcSzcG4LaTCOdkrZg==
UI-OutboundReport: notjunk:1;M01:P0:w3g6y7385Ok=;4OLDESrn0lp0xrLZI+q1mYjtpDC
 9L4XwYlMGBU/2knpMHxRGtTguQQPeZkUn9hbbhdJEbPFwKVuasnXIFwsFPPZMJWGF9Gyi5AdU
 p2/eh5PYU7JjePGFXBpZuGx5XzQAULZfIJqL3J5wx0xVh8v4k18N+f/UiMmgqVRhUdafKaK5A
 Vjuvpu5YRwyP4ZaoiHmzSaLZxFMm8rAaGBoCp24NpeW8eOYXiBufOe+roIN7J+3U0i1RO20M5
 ibiygZB/TDIGdrs9L4FzHsK0UZvGL93mO/3aLCDIdHIZtml9pvBSI9vMWtqOaQ1lZwN9GWrnn
 XVz0VFlULaG85q/vFA2450eAeTuFWrQ+f0wPCIZ54LPwyy/bGCMqhtVdjGFY+/LHyZeMD3R6a
 dqQytdUotZXhiS5/f3pfvC3DcWQZFmjSAJed9btt0ovvy25dK/EJiQMLyGp7ZS/w4i7TfZ5Sf
 RpsDfzZ65tCEBD+iWOM2HkNTcH91z5c7FAQeclUgQeN/Fen8vAr2eZ5OMj7hPPJHya9BbL6rQ
 JoiO5Gu3MYgjmhHYVNqdPaLjh1TLMVOvgth8ETDFRpS4sBh2VWPFhatcBaZYvOdP8eXxM8sjK
 ftgSY1q05gPDkmgL3kVTG+xpDRT5wG/zQgS/gOcuzl5Bq6iGmjmXjyXVuqsQ2iYEhAOmZpXue
 gCx8qIA+QByymh0Zwrxr4B+hHfguxyA3d1JmrVMKmS9XzrIsEbSBj0Uer8v/MBbU9k7tNblRI
 FX09N3GphcrQdp2SBs4/aZi6w0LFVeRdWqpYu9CJhwdHpyxPlLEDJ9wjmNcyq9xiRm199crh4
 h2dGqmiwCRC1yvvmWZpUy52+P348tLJ7LBdy0p3mQiSDo=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_022029_024194_41F76CE8 
X-CRM114-Status: UNSURE (   6.93  )
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

=E2=80=A6
> The root cause of this issue is the concurrency between the write proces=
s
> and the block size update process. However, this concurrency does not ex=
ist
> in actual production environments. To solve above issue, Verify if the
> segments of BIO are aligned with integrity intervals.

* Please improve the change description with an imperative wording.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc2#n94

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?

* How do you think about to use the summary phrase =E2=80=9CAvoid null poi=
nter dereference
  in bio_integrity_free()=E2=80=9D?


Regards,
Markus

