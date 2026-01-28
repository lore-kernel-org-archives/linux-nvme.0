Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401BBD2F00C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 00:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NT3MHDpvH4wglTt+PJSDN4fNGC0w7hDHURkalPPiEWI=; b=TDYfyMHcZALCoq/DRJxK2eEvGX
	Y1TgO1NnmcndZtvcBK+BYeyyQSDBZX9yFClAXBpYcWoo7veHSaJ7aDoaqJPDrpCJKpO5MBSMvoWYN
	++4MY9EYYLrEKH9tCLo92eP97WulmVLN/l+kqixPJGQxG/ZwoCTP6LYMPsv8//arqNEBdK7EVOmfB
	jLAxb+AJG9okkP8o14BSiafHYj01k0Ve6C9gDohLAf7u1owGumCZBcqxJhqJz9h0ft5UzSZM3hwxU
	Ta17dhrvSXNrsbUCDJfEih5TAkwy1dvYwUoItzboOhMT+sHlgO2u6ZKTB1X3LyzRSwalJoli+9k3j
	K63LU3QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vktgw-0000000FE4r-3kW4;
	Wed, 28 Jan 2026 00:45:54 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vktgt-0000000FE4U-3mxd
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 00:45:53 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-35305538592so5555871a91.0
        for <linux-nvme@lists.infradead.org>; Tue, 27 Jan 2026 16:45:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769561151; cv=none;
        d=google.com; s=arc-20240605;
        b=E2YXykmlSEC4rT3hA3VaDscpBiYSXyAwclT7OZSKNurHz3yi8MBOSXHTB2/5pJX+sh
         wiDlqvt8oxKjzPIYgz01mp2oipYndaV0QQKlp5UuTdb6PPF0iJM2UNQfsKpDF76cAxGY
         P03PXlYG70eC9waBzjUCPn534fpCIR/kT+4fqhFRr5p4qM9cZ28s+yJ373mbc3PKt4bG
         vdsesTrBmS0L7FZeBKhQ4dHYX4zL6wdwc6mEg08sNR3P1HgZG8hiNQXb+NQfeIdcUBC4
         QMXhD+2IBC6UTubKs5C8eDef13Xf7KN3/cSExUQaEtKGZsLGfvGJaJ972iGnex3GWpeS
         76DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NT3MHDpvH4wglTt+PJSDN4fNGC0w7hDHURkalPPiEWI=;
        fh=ulVWor+SCOhbm/xQZfoqElSmZk9RR+A3clQ/FA0yws0=;
        b=OE3/UBeeO0zfpWt8WbN4C+CZVPGzaD6LKKGVmFnptDmRT35ttdXgvsBj+eiwL3poNq
         HCiHTUq+vTWueKeEP+oO9UthDTogsgEnmU8zjG4q23XYmJQOAJz1vof4ZKE6NJt0UCUD
         k7orBGLl3/F6gUidOzuIL8ct75ypg6Fiq84kF6BuS7aREhiRL5ZJUphF+4xD+DDXF0kB
         vP6/Il4uhJ/UmjUJjcz3ci3QNrA3XBlsrVyywGYR+eyF3CpHz0fjrAoi4XJbnsyaAs1e
         iJiixoUm8wYmlgs4xs94XsodQne/WuOFSoPyqHMMrs+od0OziS8yfHQNocJnFiGqtlFG
         1JiQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769561151; x=1770165951; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NT3MHDpvH4wglTt+PJSDN4fNGC0w7hDHURkalPPiEWI=;
        b=ZTbqAixtYYOci5tXZXgFxEhEz8ifTd2RL/tdNImoWBPY0FgEgbmgBPlVbdpu1nqpVl
         6KO5F00Rs9pnRIPvDXipCc6c1At3zqp+sv4JyxfdIxIRJVTmh9zfz6wjBv9wFzk5mr6i
         lX5j7O3c66wjbNLpp3kgp+K7gnff2owgCmWl9/q6xioy6MOZmAC+n7SPcreRX1yTm8nF
         gj8S+L3PsMrs1dSDuGfjarrO3Bnaf7k2k7HMdBobIX51qc9bVszl2vmGoANpnU4AR5s1
         0dPIpCvX7Dc0zE5N/DHdQ2lL/veqecuhqPXdTIrkNwM937URBPJYjhGjdvAfIUei3KW/
         D21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769561151; x=1770165951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NT3MHDpvH4wglTt+PJSDN4fNGC0w7hDHURkalPPiEWI=;
        b=aO4ZakDP+qjADPB+KEbl0urIkqllD+5WSGwP49HeOJdURy+FfDS/NLoA4qEEbXlRLn
         Men2vVTUHteK1uR17XGHXdMQDBTqTpPbD0iZqEcLugtvMJmE2qcx39TgZ6txHV5Nozi2
         CqJlggdwuNecO4sPbd6EdOIWluqU4z2Zu9zUjnUHTGfeITA+KW7Ovs61wOI3Q0Jv6uoY
         q28P6OP4zZ90mut8uNQiT8VmH1vlCoX8N8IX5XGDT7vcl6cRY0w4w/nUdCjvVHIM0VwE
         jSmXXn2qVHUCW9LoTIiCYormVspAADzxXJGgHBlrLb+sxkzixXABSKjwccHmBXWjpcES
         ILww==
X-Forwarded-Encrypted: i=1; AJvYcCXizfC15zAbksYg+xwZ2mPA1Dt7C3askfBJzhzkZxOT9ZEOjS1uR1RRQZNm+Msp8/w12ife9npnHlBO@lists.infradead.org
X-Gm-Message-State: AOJu0Yw4voPGMQZRq9lsH+muzbjo4yVLi8trADLhH/qTI0iDQGWA9tdg
	4p0pfawLwLbZGrwZMVE5COhBMEtWCK+EHajV1PjHWgnebfo6wWnJboSp2u74z/iilt8zRGajELH
	shrve+Z5ZqiqcDNZT0EctdT0vz7vl8AY=
X-Gm-Gg: AZuq6aLeO68OUjuYlYofw4qHUy5ZIzQn7BHfbWApdJUsfLenaBibxzUTw2SiXH1LgTa
	Mn6hjHVXs4rUxpeYF6EZuFRVjSkuSH2nycFzm/7jAgnH0PYCchlrMUgokzlA7iCjzrBweju4Tpq
	dArETkbTw2W3rbKMTjmvnU/mmeQ8k+ALVHBuao76L49pWZ7SHcKtfRwCum0W6Y1YGcKCE/OixjG
	GfGehUHKanwEKpHfANEfRGYeObik6/LpRLe/MYB53LZ85Z4Vl4uqiqTmYdARbvDY/9YcqORQw==
X-Received: by 2002:a17:90b:4a88:b0:353:2e1:9605 with SMTP id
 98e67ed59e1d1-353fecba4efmr3218487a91.6.1769561150815; Tue, 27 Jan 2026
 16:45:50 -0800 (PST)
MIME-Version: 1.0
References: <1a3d4d2d-db0c-4358-8229-c7d6f5e83bbe@grimberg.me>
 <20260126064248.591202-1-ioerts@kookmin.ac.kr> <DFZFBKPGNCD4.3EKJ4G1H2GBDC@bsdbackstore.eu>
 <DFZG4OIFIHO8.313E3KOTXSDL5@bsdbackstore.eu> <DFZGZT9C3D6B.346BT9Y4IGVFB@bsdbackstore.eu>
In-Reply-To: <DFZGZT9C3D6B.346BT9Y4IGVFB@bsdbackstore.eu>
From: yunje shin <yjshin0438@gmail.com>
Date: Wed, 28 Jan 2026 09:45:39 +0900
X-Gm-Features: AZwV_Qi0PX9ZSjxNNewqAgK_qBP77Q2Ge6f3BiXJSJivK9fRkCz-GOKmprGBEJE
Message-ID: <CAMX6_QHuFJQXd=nSaAk6OxEvwfw8Q1SC3G8Cv4_Sfp8KmcYDNA@mail.gmail.com>
Subject: Re: [PATCH v3] nvmet-tcp: reject H2CData before ICReq
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, 
	sagi@grimberg.me, gregkh@linuxfoundation.org, security@kernel.org, 
	YunJe Shin <ioerts@kookmin.ac.kr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_164551_968684_52F511AE 
X-CRM114-Status: GOOD (  13.96  )
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

Thanks for letting me know. I'll check it.

YunJe


On Wed, Jan 28, 2026 at 12:17=E2=80=AFAM Maurizio Lombardi
<mlombard@bsdbackstore.eu> wrote:
>
> On Tue Jan 27, 2026 at 3:37 PM CET, Maurizio Lombardi wrote:
> >
> > Nevermind, now I get what you mean: you can hit the bug if you send
> > H2CData after ICReq but before the execution
> > of the connect command.
>
> I was able to reproduce the crash:
>
> [25362.399746] BUG: kernel NULL pointer dereference, address: 00000000000=
0000c
> [25362.403368] #PF: supervisor read access in kernel mode
> [25362.405451] #PF: error_code(0x0000) - not-present page
>
> [...]
>
> [25362.430592] Call Trace:
> [25362.430945]  <TASK>
> [25362.431250]  ? show_trace_log_lvl+0x1b0/0x2f0
> [25362.431910]  ? show_trace_log_lvl+0x1b0/0x2f0
> [25362.432507]  ? nvmet_tcp_done_recv_pdu+0x299/0x2f0 [nvmet_tcp]
> [25362.433285]  ? __die_body.cold+0x8/0x12
> [25362.433810]  ? page_fault_oops+0x148/0x160
> [25362.434388]  ? exc_page_fault+0x73/0x160
> [25362.434953]  ? asm_exc_page_fault+0x26/0x30
> [25362.435573]  ? nvmet_tcp_build_pdu_iovec+0x4c/0xc0 [nvmet_tcp]
> [25362.436357]  nvmet_tcp_done_recv_pdu+0x299/0x2f0 [nvmet_tcp]
> [25362.437113]  nvmet_tcp_try_recv_pdu+0x1ef/0x2d0 [nvmet_tcp]
> [25362.437856]  ? sched_balance_update_blocked_averages+0xdd/0x1a0
> [25362.438672]  nvmet_tcp_io_work+0x70/0x8c0 [nvmet_tcp]
>
> But it appears to have been already been fixed by commit 32b63acd78f577b3=
32d976aa06b56e70d054cbba
> (nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_build_pdu_iovec)
>
> dmesg output target-side:
>
> [   54.436869] nvmet_tcp: queue 0: H2CData PDU received for invalid comma=
nd state (ttag 43981)
>
>
> Maurizio

