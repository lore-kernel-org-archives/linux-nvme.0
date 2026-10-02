Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD1ECA5FFD
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2026 09:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=; b=toOBM6xTjtnFiJu5lzp/m1nsj6
	KrPfjbfq6vaS0SVhx+3R1xiWwXve/2pEc7h71PsGFSRuk32CvFBncLwFeY1tpfQKnovvEF97Nmy/f
	1jdxfx4fEm+aFVzQ/N9k0U1thL+G7i8PfomQSHVYO7oSTzUqWn/f/BivnU+r90ftAsXh9PalBmM4r
	z/Fixbfvbt6f5G/PPbNL1io8urL+ipVAY9w6EGqXz3GcDERf6QgImtU7SqJZLe+Q3c74QKqK6d4I7
	R7WZC1b6U00QgOxPgC/qOyU9b7r3FAQR3NXMjNBXBWVeCpcnw84Vhkv1VzBzkyIQ27Yw+qRv8Zq43
	akW9f/yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDeoi-0000000Fz6v-1BQn;
	Mon, 05 Oct 2026 09:17:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCdwd-0000000BkXm-2KfU
	for linux-nvme@lists.infradead.org;
	Fri, 02 Oct 2026 14:09:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790950141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
	b=B8m5PwSN9FAtEk7Nuyq461iaYiKKiVpCW9E3mHLGCHh57zqwUPnGtVYfKr0iFOF2w4RHbI
	jOFQLCrWTrX+g3YxaO0RoOVq0HxGd+bYaPt3vU6fRzpJapVKAJOCC3EptN78zCSlYqc+IY
	bVi78v9bJmcbDX05pzgay66MdiTt3u4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-vpFKD182PsqyrVEqgbQDLg-1; Fri, 02 Oct 2026 10:07:15 -0400
X-MC-Unique: vpFKD182PsqyrVEqgbQDLg-1
X-Mimecast-MFC-AGG-ID: vpFKD182PsqyrVEqgbQDLg_1790950034
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-39b1a8b8bb1so693661fa.2
        for <linux-nvme@lists.infradead.org>; Fri, 02 Oct 2026 07:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950034; x=1791554834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDp0RcD7HYWUzlsOLtsxZUXX4GvVdXcns7B6N4dcr9I=;
        b=t7S6n3wewxjnq5EYdT+L+V7DekYMxoJSUkv4MrGVb+8zwsfzCZ9kBwK4mQmvKRGknU
         Arl3TTxyasi30/00HVhfDU7sBEEemRRl6DkGP+VKV5idSnBJkbQz9DpBr2OOSHARJYXo
         9D/Jz8J7ioep8o6/7pGQvFBtMW4m0d+sPYMHzgk7hdF/KlVOIMYe48yASPSVbVq6MChm
         iz3BE9ZuSmVbNykSRwhcrjgkrL2CtUd07L4eRwMlbKkisep5ppOVXXEFOiS8IlNEP2Pk
         g3v91AOJsFvy8w3lTsuxak4NbFjrwIYappIc5bx/qcuT/djtHm+5pi7bF+ifJWqaDlCm
         fXVg==
X-Forwarded-Encrypted: i=1; AKwUvBx7iGSrY7BhZ7b64LU2x5UT20ojvvwCdewxUiHGcoZHdtRZ7G4+qWyILDhDBP+2kg2yciTd/RRc63fX@lists.infradead.org
X-Gm-Message-State: AFq9FYL791BXnw6gHdJqp2BQimZLKq/yRoCjsDTPaOdE3kvS4YT8RuHG
	OSgcVBIKTPy0TtAHXZ+qYE7SFIDs3E8f6wFu3aZc5yLvvT15lczA082+Gr669TSEWaYyzYKB99u
	GJhICgYXNYIeLVW8mRwm9lkWPgJlhRWmKit47T/we5WOmVc7hkSvJWy6o8rKL7u3U8Q7et44NEK
	7clos5U3xKOe5rmoZ041O2Zd4tbUrgrjltKBMalZLlwdk=
X-Gm-Gg: AYBFou2GS/OpBmMx58batSHajTaQPLJaScxgKQJGQLGmCJKpBpMg2ajiWkU837OisHC
	y2NklxCo/n+GvBujHMlcttNOBwTb86lbGsBjvKkAIV5jRVPXZRPXm1aQ1INnlVs7LKfc69nwEP4
	08y2EA/lJtjXC7GyJG3HA6Yf582qh3fVmBH6Tl89sU+bHQf8a+CVyjnJSR
X-Received: by 2002:a2e:bc24:0:b0:3a6:95a:52a6 with SMTP id 38308e7fff4ca-3a8877b72d8mr7514451fa.20.1790950033923;
        Fri, 02 Oct 2026 07:07:13 -0700 (PDT)
X-Received: by 2002:a2e:bc24:0:b0:3a6:95a:52a6 with SMTP id
 38308e7fff4ca-3a8877b72d8mr7514081fa.20.1790950033516; Fri, 02 Oct 2026
 07:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260929071743.23624-2-edumazet@kernel.org> <179090395863.434549.3668493667259120759@kernel.org>
 <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
In-Reply-To: <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 2 Oct 2026 10:07:01 -0400
X-Gm-Features: AclHuK_sfowi4LPKpSWl8IXP3uRNzWbqORQfvYROS9BqQto16BFcN8kPZWF14yQ
Message-ID: <CAK-6q+ga-MNEXgENToB2hLB9jzpsGMrz-1sOo7WQP5M-scnAxg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/9] dlm: fix send buffer backpressure handling
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@google.com, 
	edumazet@google.com, netdev@vger.kernel.org, teigland@redhat.com, 
	gfs2@lists.linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com, 
	sd@queasysnail.net, jiayuan.chen@linux.dev, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, mptcp@lists.linux.dev, 
	guwen@linux.alibaba.com, dust.li@linux.alibaba.com, alibuda@linux.alibaba.com, 
	cel@kernel.org, jlayton@kernel.org, neil@brown.name, okorniev@redhat.com, 
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org, 
	linux-nfs@vger.kernel.org, achender@kernel.org, rds-devel@oss.oracle.com, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, axboe@kernel.dk, drbd-dev@lists.linux.dev, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, ceph-devel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ybk6SqQPNUbJ-bZULwb0BnikHufsV5C-W_xVRzfzu0I_1790950034
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261002_070904_180785_41E4C849 
X-CRM114-Status: GOOD (  15.24  )
X-Mailman-Approved-At: Mon, 05 Oct 2026 02:16:59 -0700
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

On Fri, Oct 2, 2026 at 4:33=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> On Fri, Oct 2, 2026 at 3:19=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [High] A TCP reset or TCP timeout while the connection is waiting for
> >   send space can stall the dlm connection permanently.
>
> I dunno if I want to spend time fixing all dlm bugs.
>
> It seems TCP changes are now stuck because ood pre-existing bugs in
> in-kernel-users.
>
> Sad.

I will take a look into it and cc netdev people.

Thanks.

- Alex


