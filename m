Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAD8EFCE5A
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2026 03:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XRivzZvEcyrlujJpro/GMhtctD0Eq+hqjRWt/aUTF8g=; b=mmznh+hVcrj1j1iwtuTOO6s2dx
	DyWecTya2ctTYNQH+Ap7G8lsb6c+X2PKdWpCtcu8vmFk6WP6/1n8u8ynFOugt0v/I5z7qaGbSSRNu
	eOYSaYWxtfJIfzWiMup9x+/UEqCoiFhOEGDB/sn41ZQhZYDzXWgL1gqwfktqL7i2OpI/QysLoQF4u
	Je4z5fRL3YMciFUJWE0s4XCzyi0Djn63Z3nddZyjSUrnrIT2naC+A8b2BLe/gnP6DT53w/JAJLa5i
	XGmaI34W4m4r4r/KigO/BAdfK4oiOAeFjnFbxR0QbxcR2zsiUa7YSj6x9HfgSE+3/ljq/uUunt3mR
	xF2qsbYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxyyJ-00000000ocM-2Jeg;
	Thu, 05 Mar 2026 03:01:55 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxyyG-00000000obx-2r0t
	for linux-nvme@lists.infradead.org;
	Thu, 05 Mar 2026 03:01:53 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so2922524a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Mar 2026 19:01:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772679711; cv=none;
        d=google.com; s=arc-20240605;
        b=IFlnOt0+R8qFNxNOpZolpCOZd3oeCk2BoIJkVJEmbNHKPlNs+TwDAuOqVd1gUbroN0
         Q8BOrZBx7ZrEl4gOMGmuEqtAVHgR7SF90vI0UYhCT6Quuo6ZhtKlClcwqHlGqgJI8v87
         OfQcgLe2/IRaf2JaD5TWOJCDmeIGT/308/nnMEy8At67B4WNTMjgxcbYejfx3i1pbPU/
         7NScGCmfnLoL3IhZlB0ZJGTqmr8Wweu4RKEZQlSZ3qW6o732ORL6kS5tg+6h3N+4wx/7
         32mYFYJO4fo+zK1UyUeIKfh6ZGGOLHSO3jS/BeKP9X8xMt+MPqQlhLqVSIz7dn34AH9z
         zCMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XRivzZvEcyrlujJpro/GMhtctD0Eq+hqjRWt/aUTF8g=;
        fh=C/+p4ZsH01uWTPvjdiucNNjOd9Nhr3SjA9dDiMQKiOA=;
        b=jq8jaooMlgdvhH+XQVDbavgipKRItTDUDQ8eyn+fFqjC0btlB97Ag/T6J6WcgIRXBC
         yWar+FMRuW/WcM1+cVtnWQykF8CGFtib7m8pgUNL2CDGXWb4GyU1EClK++yE2OuB5Pg2
         BkaKvKIgnLcAC2hgMVt8kmuwNihIazFYzwbgnvboG8nDgbsI5Po5rLZOYW/9L6nsxc/q
         km3XH8joRoDco9Q//zw+XdkfM39WwMC9Yg4SkjQTra6UJ+2QHyGwOtKpvC9LJ/+RrGNi
         D1zUuFz7u+anB1Na2Bkp0jaPtWrxgiioFhzAfC6jBG/GrXxa7f5Q3iqG2hLBgxDc7jvH
         thMw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772679711; x=1773284511; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRivzZvEcyrlujJpro/GMhtctD0Eq+hqjRWt/aUTF8g=;
        b=iq3vFwdbdmb+I3LS1ouMoN3VnRJjsIbqd0nuLrQnKYT4bHujwOKZL5OZFpN/B1E/lF
         1Nv6B439BaczuZKZY1vYDYTJZZIw+7YN5IevwG56ln4iZTTvSqBmAkJU3dWc174a0/yA
         9UUcb6UY+h8LTippPFuhYGQHI+GIMruUTjwsRLldp9T9ZhyAHMeim+NwGYxcmEa3bbTs
         6gGXvBgS+L9DWV/jI/l3TjTMKEM6ZJNeykKCKD/wQ7RkyvXj3zwGSMtac5WKFBnW/F5W
         kT8Fyq5pNCSplQBygvVFX9GTjrq8RF86qyqHQYtUrIdp5KKbN36djlifj1lrTj34FzCI
         r7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772679711; x=1773284511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XRivzZvEcyrlujJpro/GMhtctD0Eq+hqjRWt/aUTF8g=;
        b=kzAz3YON/yFx0KX3I/QcFhsYAF/GkK6Z68cklfnjFVE9tW8avs3mqame7359vEG8gL
         BDByCm3krruqF5sS2OFzT2M9K7e3CMRKN1sr/ZjnfvyjBWYtfrqI6bXx4egVO4IBcVeI
         RfBJgNeJWHiNdmxTKjJJDdVvKdgpAb3ygVci+Gv/qI7tjRpOps2GR1tk8c8Ni+HqL8AW
         nyrsSGKqkVnlt7qvXlV6bAMUDrSltu0Z/V/TdMaHPOglHBfq4P8JgXMENmMQXlgizkqz
         cpQB8qFPMK2rm97h5h/0GhYLP2LYtN0+A7wmDXyQQYI5/afCO0A0l4B7kV63WkCK3bDD
         eF6A==
X-Forwarded-Encrypted: i=1; AJvYcCVuEhHKirvUkV7EHaXzDZeEa85yrA4s1QZj1P5GCf1SJnwL+upe7i+/qG0wPaHibXCRsHdkpKDO+/6d@lists.infradead.org
X-Gm-Message-State: AOJu0Yza+mRTQa7W2WhfWWygKwB516/LbMPWrt8vIKaK+S5qmBkIF9Rr
	8yCFIwite+qxebRrlGhoWDtTuH22XnXZuGw5UoFyCrjQ1WvtmONEaC8icPTObovPtVEqczS4F1g
	B6NHY+K5mZxxyApaPlsETGgRLgIqvCUI=
X-Gm-Gg: ATEYQzx/9V6Dsn22bQS1M2gl87RuOFGGoXX89IZ1dnDtbDqnBEoMfZpp+tEpUn9gDj9
	q6sDsHxcX51ONZxFj2X9sjAVUTH9qJK98o6TJ5C7U7Qh0O7cARkkRxFLI53/EQqCZ33m7JJEojh
	H1bHD8BRrsM+EI0JKhORZRRO1NTOQosmufbvIFQ6Qt5elF1/k7o4kySsr0161Mubf60uofW2u0k
	NqPQ0yTIFEyMcwJ8WnkcLQ0mlhj0/rEDM7pOWV+qfIqo/XwXDKXhcuTNf00A/uXb/TPqufCvgvJ
	TCLHIngxmQ==
X-Received: by 2002:a17:902:e752:b0:2ae:4d44:c647 with SMTP id
 d9443c01a7336-2ae6ab0ee50mr40601445ad.37.1772679711272; Wed, 04 Mar 2026
 19:01:51 -0800 (PST)
MIME-Version: 1.0
References: <678f42fb-521e-4b5e-b662-331e424ca003@grimberg.me>
 <20260128004136.946596-1-ioerts@kookmin.ac.kr> <1bceff87-87ab-4ac7-9a1f-76c990171247@roeck-us.net>
 <DGT3F4OEHJB9.218JVJM25CWAV@arkamax.eu> <DGT52MZM4MVD.1NEXLSLRA3871@arkamax.eu>
In-Reply-To: <DGT52MZM4MVD.1NEXLSLRA3871@arkamax.eu>
From: yunje shin <yjshin0438@gmail.com>
Date: Thu, 5 Mar 2026 12:01:40 +0900
X-Gm-Features: AaiRm50mZaFs0lSkfjTo16eOClvN5aJgeTNmZhK2zbw6mcCGueCyIZDt7IDS1Bg
Message-ID: <CAMX6_QFn1-Pe7gen7JkbpzXeq41gA9z=U8d6=NE4-o_vg43hBw@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec
To: Maurizio Lombardi <mlombard@arkamax.eu>, Guenter Roeck <linux@roeck-us.net>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, 
	gregkh@linuxfoundation.org, Christoph Hellwig <hch@lst.de>, security@kernel.org, 
	sagi@grimberg.me, YunJe Shin <ioerts@kookmin.ac.kr>, joonkyoj@yonsei.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_190152_721005_20289B54 
X-CRM114-Status: GOOD (  23.37  )
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

Hi,

When I wrote the patch, I followed the existing convention of calling
nvmet_tcp_fatal_error() directly. But since the function returns void,
having reviewed the AI agent's analysis, the concern seems to have
some merit - the caller could overwrite rcv_state with
NVMET_TCP_RECV_DATA after the failure, causing the state machine to
proceed with an uninitialized cmd->recv_msg.msg_iter.

Maurizio's approach of changing the return type to int and letting
callers propagate the error makes sense. This also aligns with his
earlier patch [1] to remove redundant nvmet_tcp_fatal_error() calls
from lower-level functions.

To confirm this, would the following sequence trigger the issue?

1. Send a crafted H2C Data PDU with an invalid data_offset or length
   that causes sg_idx >=3D sg_cnt in nvmet_tcp_build_pdu_iovec()
2. The bounds check triggers -> nvmet_tcp_fatal_error() sets
   rcv_state =3D NVMET_TCP_RECV_ERR -> early return (void)
3. Back in nvmet_tcp_handle_h2c_data_pdu(), the caller overwrites
   rcv_state with NVMET_TCP_RECV_DATA (ignoring the failure)
4. The state machine proceeds to nvmet_tcp_try_recv_data(),
   which calls recvmsg() using the uninitialized cmd->recv_msg.msg_iter

[1] https://lore.kernel.org/linux-nvme/20250305132642.1271523-1-mlombard@re=
dhat.com/

Thanks,
Yunje

On Tue, Mar 3, 2026 at 9:17=E2=80=AFPM Maurizio Lombardi <mlombard@arkamax.=
eu> wrote:
>
> On Tue Mar 3, 2026 at 11:59 AM CET, Maurizio Lombardi wrote:
> >
> > In my opinion this is a valid concern.
> > I suspect that it's really possible to create a malicious sequence
> > that would make the target crash.
> >
> > I would change nvmet_tcp_build_pdu_iovec() to return an error
> > code and its caller so they propagate it up to nvmet_tcp_done_recv_pdu(=
)
>
> Additionally, the current design leaves it somewhat ambiguous as to
> which function should be responsible for calling nvmet_tcp_fatal_error().
> In my opinion, this should be handled by the upper-layer function
> nvmet_tcp_try_recv(), allowing the lower-level functions to simply
> return an error code.
>
> I submitted a patch to clean this up exactly one year ago,
> but it has been forgotten and I only just remembered it.
>
> https://lore.kernel.org/linux-nvme/20250305132642.1271523-1-mlombard@redh=
at.com/
>
> I could prepare a patchset to fix all this stuff
>
> Maurizio

