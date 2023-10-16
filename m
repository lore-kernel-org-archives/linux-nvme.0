Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1DBCDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 06:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9LK4rJbU2sRpSzkFBs5KSyUob3gL/Eekqel0Vhlu8CQ=; b=TnKNZV1dPmXaNYsyhTOwwrtQFi
	QCp8E4SuFg4sv82s6RQysPolvgFzlbA73yc2APJtXzpV36sPjSU5TqcH4AdFIecB8XXyKuSRvUhfy
	f39N15Gjs+fiqmcj1JYdGhLwVfaBKe+PWrCR6omvrCjI/1gyJd+Fj12NiB0WXSqfObZLRfE7gOLkp
	zWIMSxjzuNYvgBZBffMkG4+scdpjnd8DFB7aC+y59Fr1R82c1zXD7N5mTvy8tzOSYlQn6zfmUKXWj
	RPYcGL6mzj70v8IddWY3sIWQDUb5JJ9NpXzCqU8FlI1Z8xU+Rg9UNF8wllVBgrWi+NUpDNWmlq6xv
	m91AlBOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsHGb-008YHX-2B;
	Mon, 16 Oct 2023 06:39:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsHGZ-008YHD-04
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 06:39:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697438390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9LK4rJbU2sRpSzkFBs5KSyUob3gL/Eekqel0Vhlu8CQ=;
	b=DPJlX/a9F0xwVECi8QfN+HcuNsftLCXSxFjBDyYb0Q9/HixsaPmBoA0OETpbZ0h751H0wY
	Lea9Wbi11DtiTRnD79MeGqmNWC+/JX2b6/rDGyzPo9Sti4Qn3ao371OWffTgoQYtHYUI/x
	DEgl2y/NqEmkYh6OS6nmUOrb406cOlM=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-16aljFiXMjW-aB_FLUYbAA-1; Mon, 16 Oct 2023 02:39:38 -0400
X-MC-Unique: 16aljFiXMjW-aB_FLUYbAA-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7abaae41e6dso1187754241.1
        for <linux-nvme@lists.infradead.org>; Sun, 15 Oct 2023 23:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697438378; x=1698043178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LK4rJbU2sRpSzkFBs5KSyUob3gL/Eekqel0Vhlu8CQ=;
        b=lUJkEWs93xGEiIOqhABm11q++x6QyiKl3VbBR1m2oKzIX98H8C8jEI5sR1StSnH8xp
         /hN5ZFYovptKh8JU9hT6QvVdoexmVbQRLSieyhOfOIk9jNJooVTdT4KkogAgWAH1f3uc
         QsMu80/u4/6LQ0IAIfdNpx9PQNt4VjvGnmh3ifoe13ayetsmWh6XVBGy471lGPWQaLlo
         rcHiNjCaUjyIB2QX299tXUWzOrGVCG782zkwGyNrfzIYhMrwdbOqPd4GijPWHfGtrVOW
         dIMMlSMsJXrQ1EWrbd16ptP09pYalzx2zxOSv1qmJfgk25bvkAt8vJvpAUxo1tItI0YQ
         LMWw==
X-Gm-Message-State: AOJu0YyyX7EFQRAqZlxCiclzLHsPm6pq31JABuVDoBJh64t0Wp9ppbJA
	1ssPPKYmbLhZXrtBBQbIBNyKqmF20S/Hx76mWcLmEy4/4hdmiq1+f9snh/Ohg3tfK6QpnbX3rsm
	vzX4wuyjN2kazEvzULYpIlbAWuDjaY4nK0EFtVN+Xngs=
X-Received: by 2002:a67:cc09:0:b0:458:1b5:11f8 with SMTP id q9-20020a67cc09000000b0045801b511f8mr501585vsl.21.1697438378365;
        Sun, 15 Oct 2023 23:39:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeG2lq50C61t9unv+qxOmSpZnP8Id7datbsKYe9qidv0kVss05IMSxvGYvuD32Ht4czO1e6DWR3GYzS7Iu9jU=
X-Received: by 2002:a67:cc09:0:b0:458:1b5:11f8 with SMTP id
 q9-20020a67cc09000000b0045801b511f8mr501572vsl.21.1697438378113; Sun, 15 Oct
 2023 23:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231013094239.332235-1-mlombard@redhat.com> <ZSzQmlEBkcJQ0P24@infradead.org>
In-Reply-To: <ZSzQmlEBkcJQ0P24@infradead.org>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Mon, 16 Oct 2023 08:39:26 +0200
Message-ID: <CAFL455k2N1SQgzae0UBhY0daxyd+iJ34XjcZyAPL4=vpheXjdw@mail.gmail.com>
Subject: Re: [PATCH] nvmet-auth: complete a request only after freeing the
 dhchap pointers
To: Christoph Hellwig <hch@infradead.org>
Cc: hare@suse.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231015_233951_151536_E7088654 
X-CRM114-Status: GOOD (  16.00  )
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

po 16. 10. 2023 v 7:57 odes=C3=ADlatel Christoph Hellwig <hch@infradead.org=
> napsal:
>
> On Fri, Oct 13, 2023 at 11:42:39AM +0200, Maurizio Lombardi wrote:
> > -     nvmet_req_complete(req, status);
> >       if (req->sq->dhchap_step !=3D NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2 &=
&
> >           req->sq->dhchap_step !=3D NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) =
{
> >               unsigned long auth_expire_secs =3D ctrl->kato ? ctrl->kat=
o : 120;
> >
> >               mod_delayed_work(system_wq, &req->sq->auth_expired_work,
> >                                auth_expire_secs * HZ);
> > +
> > +             nvmet_req_complete(req, status);
> >               return;
> >       }
> >       /* Final states, clear up variables */
> >       nvmet_auth_sq_free(req->sq);
> >       if (req->sq->dhchap_step =3D=3D NVME_AUTH_DHCHAP_MESSAGE_FAILURE2=
)
> >               nvmet_ctrl_fatal_error(ctrl);
> > +     nvmet_req_complete(req, status);
>
> I'd be tempted to use a goto here to have a single completion path.

Ok I will modify it.

>
> >  }
> >
> >  static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al=
)
> > @@ -514,11 +516,14 @@ void nvmet_execute_auth_receive(struct nvmet_req =
*req)
> >       kfree(d);
> >  done:
> >       req->cqe->result.u64 =3D 0;
> > -     nvmet_req_complete(req, status);
> > +
> >       if (req->sq->dhchap_step =3D=3D NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2=
)
> >               nvmet_auth_sq_free(req->sq);
> >       else if (req->sq->dhchap_step =3D=3D NVME_AUTH_DHCHAP_MESSAGE_FAI=
LURE1) {
> >               nvmet_auth_sq_free(req->sq);
> >               nvmet_ctrl_fatal_error(ctrl);
> > +             nvmet_req_complete(req, status);
> > +             return;
> >       }
> > +     nvmet_req_complete(req, status);
>
> And this looks really odd to me.  Why do a manual complete and return
> in the branch just to skip the complete right after it?
>

You are right, it's a leftover of previous experiments and I didn't
realize I could
simply remove this redundant code.
will submit a V2.

thanks,
Maurizio


