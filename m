Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EECC5DF81
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tcz2+ERoxx+kYTtW51wId71vpMRHIJ9V7FlPA1/aeWY=; b=ZKv0dnrhBjLyrMCK8Q/WPCJtQZ
	KMmofrr8SOGieVzpu7TJPbdZF2Lt3J1nnbjPskGE//7+oXtFV+QsijFshI1qHY2xCmTgWL0VOOGbA
	2Y4j9MsfeJ7e5POOWkVeJVlvHW14rxq3Y9zIKS5LxCKJzI7ADDrm1O6prE4ryIwTRObgZEjCrch/8
	4sIjhNbV/CNPXiuHUCFH8ZYOxGbwRpYtxeyl+hvMPGI2ioUV8k/iGxvVNBrc/+SVl0nYdr+h555Zz
	GIqTAA1ZRbBnrfSR7DGRhKeNzSPV1fYdbSH3K0sI5WS8eD/V8aysiHJSUzSwxqxGLPDV0z8PDgqgE
	3XlTtGAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwjcj-0000000AEfB-2JpR;
	Wed, 19 Aug 2026 16:58:45 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwjch-0000000AEeh-0nhx
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 16:58:44 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-495590dde14so15402775e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2026 09:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787158721; cv=none;
        d=google.com; s=arc-20260327;
        b=i56mnTjmlF1WlUZsbGZoDi/NLo3845XnRm1L8yEl/ogu/am8Iov7XqMLa2kbGnHJ1c
         7iqmy/gBsJLB+BDDIoF46NwVzTTf9cpMuJUiVyzGh9mYEePuRw17aDs0lnofk2vC3SRA
         PhceZRRGSS4W58LlU242/X8y6cE6yURYr20JlGYvmAqxRGtv176rmTkgfCyDJ6o1nH5z
         F1sRO+wFwoGnRssgKYSHJIePt+oxL2lhtBmmuxNeyeZRLJqBBwdRY5XLvToDJeDrOa0x
         J6FNXy5JhsgaGbBU23hYR2lWDGJZ7X6xkBzDzqMi/QM32LrMfrzpbOm8s8GJ+2K1Wyb/
         CSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tcz2+ERoxx+kYTtW51wId71vpMRHIJ9V7FlPA1/aeWY=;
        fh=i0hV4ZFe0wLbIlwnyE2fgvJUEroLEeJ73lne4i0tI9Y=;
        b=V714+VKOLA/pBw2Ic45ZZH9BqkZxstd5bV2YQNYW8NJ5uXVis265hMGI5Epvj77bBG
         Mvvmr50dBOekyhfkhOPE1M/f0lgekTnIfFDrG24A7NfRaueeSN6e1EvJ9YlbjdEwf01O
         IJWsiEt+epJFkmT+AcuL+GZsYp8oBDYk3HbEyuPlVAPQAv0m+jWLlZ8VuPbfUlSBf3eq
         fLUdeDE+Tvgf6eMk2/xB6mfrM4b1bsJeZVMGasqiv+I0tX+2B6tnspIFtmSMCZIpiiRm
         VBU8gv1FP2e+vb3HrnhoJfuO+RcnBf9+BpzatPA9Vz2uty8PqORao2oraZ3JxhJEltXm
         Ocyw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787158721; x=1787763521; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tcz2+ERoxx+kYTtW51wId71vpMRHIJ9V7FlPA1/aeWY=;
        b=pp37MxHua87E53yRaANb3pf03v+KYcA+RKV0OJGip4OcpHpPUtEOMvTCz9dWc7SBCi
         oAPGUKChgB+q1ybR0GFa2+mP9+CBHFiKTyU3JijH7q9tdr592GOKH0uAQE0l1n1xsluc
         wlT+/N3wpLzaOnZ4A+5DY5Io3Gu7++0XuLu7RX0kY4QFKbV8C6tVGjNlIS62r49g/L9V
         EBjYXaf/eFF1kFc4iLt9hhibQQpfo2KeikLupjhzy3VVE+cS50XuS/LcvYrkRnhRoRgq
         +n6NiD3zOezpHqSIqk0AipRCcxC7fNF5FP7lszLY3jsVfwV6td6AAeGnDGctOmYEVg/g
         Rrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787158721; x=1787763521;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tcz2+ERoxx+kYTtW51wId71vpMRHIJ9V7FlPA1/aeWY=;
        b=X9Mtk01+BFsuMXq3IKAc0PfS1q5NkoNVDKmjiOBWZQpwwt5V+3bslD8niGwaE+qE8R
         ACS6RkXf2nsrFEi9+IeMOv9uwrO0ciU36Kyr9ISZrMUy56Lnph0t6RWSOAZHiiAotAvO
         ikAolNPdwY7W+Kvo6+MOPWQreUK8IxXqiNMgJqhVUgGPk3ml40GFRkXh/2eVjsxQkMGX
         N49INUAiIJNKpRBmTibZxYc92/Fw08JixoHmVRs3+ReckAPtYq6KvGHpj6bn03eUY5Oh
         ePg1T0jVyw+Z+wbsYJIlAR9GeFm8tsZCSZXy0O3DV9ykgVucp+cIxc2FjOWtOS/xeGvD
         +6QA==
X-Forwarded-Encrypted: i=1; AHgh+RozVDqPPtUJTHqJlW22NigvYv8BmGX8QBZgW9RNqcjhSm3WvtU0havkM6VhfpwZ7ljGkN/409BD/JGj@lists.infradead.org
X-Gm-Message-State: AOJu0Yztw+A4q+5H3wOR4kvzfF6HJhGA572kk2VBqeF4Py969qHqD7y/
	0diqQkB+6zkk7L/O2SHPEuBq2JMiRoqRuQotawLMGXTEcqQHd0BN5+z+0x71hxgztLbCvm5jJae
	9UlOFWvixmrOMOFsOSZ0ar2R/i1lHTTJyn7Rb
X-Gm-Gg: AR+sD1103Hmo3B1COVYPO0hhnnRCGZ+PC/MP3Csil1Hx4oBGIMJGYEK0auSQudH5mKk
	6TzSkJ9dnePL8RL/sAH2PgVkAm3l6F12PHq10FheJveJ+GDMoWtVWh6cd+VKrFoaDThFucWc1Bb
	Wgh/RkO0sdZe1hzFqEz66FCvCe8ET3EGEbEO38KaSqVX9hDi0ZBZX4o20vTHwSKwzRZHA5qMprO
	aNt5Ekj2PxobUFGbTBOL961LdkNLzMQlZSu9O3sy39ifbcXoMv87B3SJ6OwbtbiOPBnRlyDc8I1
	pOb52jqtU3lLEYZRAkiQY2S4suYlZ+jtBzfc7nVtwb8GfA==
X-Received: by 2002:a05:600c:3487:b0:499:53c4:1daa with SMTP id
 5b1f17b1804b1-499aa1c2764mr129950665e9.15.1787158720615; Wed, 19 Aug 2026
 09:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <2026081459-handoff-wildly-eeb5@gregkh> <20260814194811.1581041-1-kumar.shivam43666@gmail.com>
In-Reply-To: <20260814194811.1581041-1-kumar.shivam43666@gmail.com>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Wed, 19 Aug 2026 12:58:29 -0400
X-Gm-Features: AcwNN1U52Hw-7ZSDDUeVbroHjiKw7peKR6l4dffU8RrMLUnsjU8oPSXsNB4pcaA
Message-ID: <CA+ysrSLfVBBKF-aEVW0tzWO1CKOxJjY8CoPOK1+xpEbdB=HyAg@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: fix out-of-bounds write when receiving an
 over-long PDU
To: Greg KH <greg@kroah.com>
Cc: security@kernel.org, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_095843_248739_23F516DB 
X-CRM114-Status: GOOD (  22.49  )
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

On Fri, Aug 14, 2026 at 3:48=E2=80=AFPM Shivam Kumar
<kumar.shivam43666@gmail.com> wrote:
>
> nvmet_tcp_try_recv_pdu() reads a PDU header into the fixed 128-byte
> queue->pdu union, then computes the remaining payload length as
>
>         queue->left =3D hdr->hlen - queue->offset + hdgst;
>
> and reads that many more bytes into &queue->pdu + queue->offset, without
> ever bounding the result against sizeof(queue->pdu).
>
> A struct nvme_tcp_icreq_pdu is itself 128 bytes, exactly the size of the
> union. Once a header digest has been negotiated (hdgst =3D 4), a second
> ICReq passes the hlen =3D=3D nvmet_tcp_pdu_size() check but yields
> queue->left =3D 128 - 8 + 4 =3D 124, so bytes 8..132 are written into the
> 128-byte buffer -- 4 bytes past its end, over queue->hdr_digest and
> queue->data_digest. Those bytes are attacker-controlled (an ICReq
> carries no digest), and the duplicate ICReq is only rejected later,
> after the overflow. A remote unauthenticated host can thus corrupt
> kernel memory adjacent to the receive buffer.
>
> Reject any PDU whose declared length would read past the end of
> queue->pdu before the second recv.
>
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/nvme/target/tcp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 75a276d73be3..c9c98b8eb149 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1229,6 +1229,8 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_=
queue *queue)
>                 }
>
>                 queue->left =3D hdr->hlen - queue->offset + hdgst;
> +               if (queue->left > sizeof(queue->pdu) - queue->offset)
> +                       return -EPROTO;
>                 goto recv;
>         }
>
> --
> 2.53.0
>
Gentle ping on this one.

