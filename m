Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F89C67861
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 00:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HRowwdvCFSS7/XAkHJPkGeIBjcCHi7mwjwFc3hZp0FQ=; b=s2+G7YFWc63X4HJu1ztImijScw
	dTgdQhEI0LH36nSFyQCV/nwBtTxM8TH75q6mdbsxRqRwZxA4hvKRMFDduu+oGx+re6vKcoHWqZRBR
	kJysAlu592qi8SOdlQmEYT8P0DX60NBaIydNXVjolTsmUNj3oOgo6/Y9c82Fc7mxIxCC1iaffNDA0
	SrFh6qsf+FOdIXWIstL3pjH4HEiqYy7lxnTpt11SBGzPbQ+kdONsxqYV1Y289KnAjyMnn4lXg/o0u
	Tkk5g81rz14DttepxE0DhAxsdfpht+bPw2U0+PneqeqkPznkLZzrO4Acd0UhdVsyxRfZpNC+NGHmb
	7lQLOZ5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruMJ0-00000004Vgw-2REY;
	Wed, 10 Apr 2024 00:59:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruMIp-00000004VeW-3Xvs
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 00:59:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712710738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HRowwdvCFSS7/XAkHJPkGeIBjcCHi7mwjwFc3hZp0FQ=;
	b=ABitDZs/eJh72YXTRYie8Gp5Wt6hDFCjEnENHnbjQUvee0fDpG45og2RPkKvS/YV80zfwf
	NomefXlOl2palhEaHcaTNpCHlvyNxtB3ZmzipNA45NQzvLnenqu9hpLnUXck8PaZI5fVxT
	jvR0PaOgiEcz/wuvyoWOaxfgl+MOwOY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-yRORyvFJO9WlKX63RYP0EA-1; Tue, 09 Apr 2024 20:58:56 -0400
X-MC-Unique: yRORyvFJO9WlKX63RYP0EA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a2fdf6eb3bso4868888a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 Apr 2024 17:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712710735; x=1713315535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRowwdvCFSS7/XAkHJPkGeIBjcCHi7mwjwFc3hZp0FQ=;
        b=gx/u4ev+Uov1ekQdPNUgju6hr7+lM89IbMvUMizzD2H6HvPyo0mG395mlhzha7/RKa
         rN2rjcfPhcBSVDoK1+ps5Iz3APMTH5mJk4mCeZP2DIqPFBI6qKgrDkWw+j9HeN0RFpup
         eDUwQJGeHBZmy6u/Nt/CJOaoxo6MpTcj1qMDUw9jb5/RoIzwlsI2+eV59uRfc7gUSWhB
         llykXjbfam2u6UOu9Y1UiDdMAweTWNa6/mS5jtGD8Ys/fi1zllb+Y/PSsa77cXIIDNX3
         EMTODSY52PQ1sYIKCi7segjlw1y8F71ukaXLEItdkpgz+9UdOc8scjTqj0WIa5ZUDXBp
         bUjQ==
X-Gm-Message-State: AOJu0YwH0s13ofV973E/FD8g8Am6gtOBL5mWS4hA+3AMUbKbzytHQAy6
	yK1nESAQ+JjDR+WMwD/GgllGOo0CVw3KHTjwxcH+YNJzcBKGoaA5bGn0eCHwu+Y1IOzeam9xrXE
	w1cimrYrOem6iaSX59NmFwGUnorh5RaskWGwrX396ytQ7n5HUTvZmm9riHOaQ1IpEM4PswFvnv/
	L7cEKp4KlnMCoYQGWBEXKcgeGHHO1EpU1siZx7o6E=
X-Received: by 2002:a17:90a:fd09:b0:2a4:9c64:2a50 with SMTP id cv9-20020a17090afd0900b002a49c642a50mr1083003pjb.45.1712710735402;
        Tue, 09 Apr 2024 17:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHufHD5vdJec1/JA02XQJCv3wFhX8hcW3CAkalsKLqc0Eo6KVg+fO9shOPYw5R9OQ5e+XPkMoftrFE2CHv2Kc4=
X-Received: by 2002:a17:90a:fd09:b0:2a4:9c64:2a50 with SMTP id
 cv9-20020a17090afd0900b002a49c642a50mr1082998pjb.45.1712710735079; Tue, 09
 Apr 2024 17:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240408061809.4010087-1-yi.zhang@redhat.com> <20240409135502.GA20490@lst.de>
In-Reply-To: <20240409135502.GA20490@lst.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 10 Apr 2024 08:58:43 +0800
Message-ID: <CAHj4cs_FsCY4ZL8KJ2oDogjo4kyzMpnzbUD8+HckYvfQXfG_Kg@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix warn output about shared namespaces without CONFIG_NVME_MULTIPATH
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_175908_392879_8B522CDE 
X-CRM114-Status: GOOD (  11.47  )
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

On Tue, Apr 9, 2024 at 9:55=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> The commit log is a bit weird.  What this does is to remove the stray
> dot after the newline, right?  Maybe state that, and whie you're at
> it cut the commit log line to 73 characters and make sure it ends with
> a dot.
Thanks, will update it at v2.

>
> The change itself looks good to me, thanks!
>


--=20
Best Regards,
  Yi Zhang


