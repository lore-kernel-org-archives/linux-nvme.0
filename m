Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E837CD6E57
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 23:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FLiqv+GgfquR7RgyoEqeguOSd3S26xqJMhq51O+GIMw=; b=PhGygEf6I5BBernxUJawfdj/ye
	XXqyLVtOMnADKCvfudIO0brHTRXy3KW5C8YFospndMCIcA6IqP1GCVlYSToq4drMfDy0+Odz5drsG
	y9HU/tZv62eyLejIh5FfG4eVuZLGgkuM5btfaYyjBFAq+xMh3K8jeR0UQ/IXHbNHlF5PIckdkS05Q
	EbeQkZZ8uvJ3EcS9lKd6vtqbuvFOutqF46lHS37lq3yXF9YSqFB2En2pkR7I79OYtjjo8Df94a136
	ONIQl+3vPECn6TKRoB0dnO9ajRGwU1fC+VPPMkx594OWsC76iZwrOz43EJz3nQEA4OuMwJ2WwcuvU
	k8FHh8AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUvCY-0000000FweS-2vUC;
	Wed, 03 Jun 2026 23:40:46 +0000
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUvCW-0000000Fwe6-1Qh2
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 23:40:45 +0000
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-51780bbc560so7348611cf.0
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jun 2026 16:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530043; x=1781134843; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLiqv+GgfquR7RgyoEqeguOSd3S26xqJMhq51O+GIMw=;
        b=PQnHjPcYxEHsggU7wLVdBJ4kAeKP+XkV0qil9WpK6u3oq24DhV6jq10Cbw5uBqlfG1
         t1Jbvke+gyz31SQgenmytPK1yh5mSVogCKg5YmMv0uqq+7ez0c03oRVVFJDhbrHPXykr
         Q8ZivrpIj5bYLZhsUgWE0voh8VLteVTizrus1jqRgBZqSKV5Ln+iShP6+iYtLAXFvpIC
         f9onSclgvdxn/fQcNobzjRVbrOzGzyxIccxGppXfQS41vDRkAR4l0Do//aHkiFByEZZ9
         Pn5aLCQMIVhWeef4YkDepgNdUXMULIc56WsehzeBweNyBnCMYs1FlgYi+NTLzVF8MmWx
         D11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530043; x=1781134843;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLiqv+GgfquR7RgyoEqeguOSd3S26xqJMhq51O+GIMw=;
        b=MKMLjwz1i29knBz3hFHQnxR/mqoNRoMkb27g02ZGJ5RO2kR9FwNxI25iih1wN0P1c3
         66nPaK3pAEihhei3UVmlhHB2vsNBIm5OvjulWakgjKRSNH1f6aRBiRW5k+lUpbJJPSJM
         0evXpo2resrcifcRHZJ631q6JdpDG1aEtCgd/UtmLcf8PbI6N6P0LQ6PnuZdBJVkzlvo
         m+DKAjo7WXNUjASsP1LJofbrNwGldeubY5kRYdWVwOYXXEpo5GDWtdBVZwyZxrXHjtjw
         cO9yZvV9jnBX5y9gnbx4S/ckSjCJs0NM1nXOGiHeto1l41kRJOg3WRvzfRLKICBiNHg3
         E5Qg==
X-Gm-Message-State: AOJu0Yyr0h58ofoo7408vVU3EoeVsUWykANtqo/WuHxf+TvlPKiIKoON
	vJSoyXmq9xWFpeoiSC7CbuGHRR9xHG/jNpdZ1Lz16aeBIfh0w5BL39wgvzuJJW+E
X-Gm-Gg: Acq92OFUTxOOlPoPpktTz9xxToXJotnXvtvkjrpfM7mZJzTgdcgH4Vmlv/mOk7EiKLA
	KILWt0aplohzRHf3M+gU8/XeZJzUPEK854jiH87GECS743oDTQ0Alj1FtbxdsQDuEDrnwJrKpfy
	uhdFdYx5UaD4u6cW+aE9MsAv46ww2kO5498ZP0t6Tv3/sf6p0rPpeY0ZmF71ODffA7dbbtUtLje
	oF1eYafjqB+3f30kcqNbXOTmBvW7J2tk653MbqmWJAzwYIO6llQPgB656dZN6UxXxAQ5lAjeT/Y
	FLsWYdt06tbMVqhaFAVSNHF3uwyGFrL4qyb46WoYcbqRLfjM9z6crfIcFbOrutB7R8hWTB1vs44
	FjGZjEQ0eYs0JpsRsiUK1UPN2c9SPbdwQKsufoEWZNdNDL5gXb8g96h9gsCCfWIKdbuKAsI0mD0
	5t9Xh7s8DQC8J8qxHGIspXVYk4zKUdERttUGxLDzQeduS1eQF4Oj/Tz/ujXD2zCtNdAhWSBrQdu
	Oo=
X-Received: by 2002:ac8:5a0c:0:b0:50d:af03:c9ca with SMTP id d75a77b69052e-517872069b7mr22849631cf.38.1780530042773;
        Wed, 03 Jun 2026 16:40:42 -0700 (PDT)
Received: from smtpclient.apple ([2601:985:4601:5df0:9da7:8e77:672c:99c8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccda0611sm36246816d6.1.2026.06.03.16.40.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2026 16:40:42 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [BUG] KASAN: slab-use-after-free in nvmet_fc_tgt_q_put
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <56c826df-efe7-4c48-9142-c32c8e3415a8@gmail.com>
Date: Wed, 3 Jun 2026 19:40:11 -0400
Cc: linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 justin.tee@broadcom.com,
 nareshgottumukkala83@gmail.com,
 paul.ely@broadcom.com,
 hch@lst.de,
 sagi@grimberg.me,
 kch@nvidia.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FEE8C73-4DB5-429B-90F5-40F1017B8C24@gmail.com>
References: <F54D7903-EA2A-4DF8-92BD-839877786139@gmail.com>
 <56c826df-efe7-4c48-9142-c32c8e3415a8@gmail.com>
To: Justin Tee <justintee8345@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_164044_385574_56DE2ADA 
X-CRM114-Status: GOOD (  12.06  )
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

Hi Justin,

Thanks for taking a look.

Just to clarify, the commit e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7
is only the upstream kernel revision that I tested on. I did not mean to =
suggest
that this commit introduced the bug, or that it is an NVMe-specific =
commit.

Regarding fcloop, thanks for pointing that out. I understand that =
nvme-fcloop
is a loopback transport and may not directly represent a deployment with
physical Fibre Channel hardware. I used it because it provides an =
in-tree way
to trigger the nvmet-fc target path from userspace without requiring =
hardware.

Best,
Shuangpeng

> On Jun 3, 2026, at 19:22, Justin Tee <justintee8345@gmail.com> wrote:
>=20
> Hi Shuangpeng,
>=20
> I will look into this and get back to you, but typically the nvme =
target fcloop module does not indicate a real life issue when utilizing =
the nvmet-fc stack on actual fibre channel hardware.
>=20
> > on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
> Was wondering what this means?  Because it doesn=E2=80=99t look like =
that is an nvme commit.
>=20
> Regards,
> Justin


