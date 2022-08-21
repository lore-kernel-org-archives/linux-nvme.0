Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637B1C00140
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Aug 2022 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZaWtw9Zg1nD5CoL5cE2PY2gb33V2/yQXN/4KLffNp9M=; b=FvOOT5DAtvqHfdCs24dKDHdRyo
	7xLwY08x7Ousr6RVW4GN9TewbRG9bTW4KrtrHuOZEiaJWToAKCOZfnrimOE6xkEpJwFvQeZtFAE+q
	YjU9wSsvwY/WDKkWqRzdgZPgZ8FSsyk/FTG/DFtfFG76sLzckf+elFvu6tjtfaGtQmCYMFUa+gyAa
	ItDMGW1Z1GDtj5I/NI/ZHnk9quZc4pmQkpSSlc6a41YFDQWwSY90KhNR9xxKEGhkwAtaHjDK42sex
	UXNLhZXByAjnefvQArBZ/Zor72zwoBuG4r3bzToiZD9AImUEAo1nJH9bB0QEIIhBSbsdaXQ+amYAz
	ed3hi7cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPmcV-00Bgie-DM; Sun, 21 Aug 2022 15:12:11 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPmcS-00Bggj-Cc
	for linux-nvme@lists.infradead.org; Sun, 21 Aug 2022 15:12:09 +0000
Received: by mail-ej1-x62c.google.com with SMTP id ce26so1204646ejb.11
        for <linux-nvme@lists.infradead.org>; Sun, 21 Aug 2022 08:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZaWtw9Zg1nD5CoL5cE2PY2gb33V2/yQXN/4KLffNp9M=;
        b=e2DTWR3YpfOjEHiMva39dkePzbaqOOjoCOG4mZEeHn5GGuOwWvgxfgeqwo7RP5BrmM
         YTRwjNG4MLbmPQKeiXLh/KoS1wrGEeAPv9xqDGuufErHU5+YEe3LsRGCbqNibKxcI9WI
         Mfc/TDTI2DsLAJWIFmDYZiZ3HApIDBauVWgnX5zotQPg/OfZjNNJm6+IZTRJs7jSAtlO
         t39gM2a6NlA/9GUNgxE6WBKmiRhIbVFzyEesoZ/1+19cDT5gSGN4SgVO+q18uCYIG67+
         qeFYod72WbkE0k8TJjryAuiTQhEgniImrKh5GyeSoFBo3YkYqza9mq6AZkItTTXrQVkI
         v4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZaWtw9Zg1nD5CoL5cE2PY2gb33V2/yQXN/4KLffNp9M=;
        b=obFDqq9MF+gMk94X1Qb40L6nxx6SRWK+oC3j+9xQ5Ck/LBgitmTd9wRrjuRB7rfYae
         1oK9xQVnUAQZUOPEvWpBWwCbod4awLeGw14oUgEH4IVUqgrAh5VWMCIb59UPQ/kFTYRs
         NEuUjjykb8oDpzAUXOSdQzwgsoZQv4BFvw64bk5+CAjBKetnWOUJfyNd1BUyUUnHfV8l
         JLsuw9KNJj4vueAXHP9YRgjWIR5ex+uBJBO2GPFkym2J1EqtH1bSEaJMPaIufHtH7TRD
         +ZvN/c9+iCl/Fv9w7h/k+1mxqYK2i8WCJA3PVtI/MLC/cOACUtAE/nWqJh37Zjz0wg6q
         SXKA==
X-Gm-Message-State: ACgBeo0VRcbifm8v2SU7zb36fVzgBH6leYTyXsEIymz0fxFDG63KSE3R
	BQGvoG5u5CRi+6lHFYRcWZSiarvS9nA=
X-Google-Smtp-Source: AA6agR68YNxfCRPYknc8+Ny6gQI1mqxcOIR7ZNTAXkL+VYPiJcMo2uyQ2HewLVkw0Q9bUKOXtYQTgA==
X-Received: by 2002:a17:907:7256:b0:730:f074:963c with SMTP id ds22-20020a170907725600b00730f074963cmr10782622ejc.201.1661094724854;
        Sun, 21 Aug 2022 08:12:04 -0700 (PDT)
Received: from opensuse.localnet (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id bm16-20020a170906c05000b00730a1c73288sm4962663ejb.49.2022.08.21.08.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 08:12:03 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date: Sun, 21 Aug 2022 17:12:00 +0200
Message-ID: <2113668.irdbgypaU6@opensuse>
In-Reply-To: <8f3e0127-91d4-af1f-ba41-951e2c5050f9@nvidia.com>
References: <20220817184519.25141-1-fmdefrancesco@gmail.com> <8f3e0127-91d4-af1f-ba41-951e2c5050f9@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220821_081208_482302_8EC8E66F 
X-CRM114-Status: GOOD (  10.17  )
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

On gioved=C3=AC 18 agosto 2022 17:48:04 CEST Chaitanya Kulkarni wrote:
> > -	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
> > -		cmd->nr_mapped, cmd->pdu_len);
> > +	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov, nr_mapped,
> > cmd->pdu_len);
>=20
> >   }
> >  =20
>=20
>=20
> overly long lines above ? we are keeping lines < 80 for consistency, can
> be done at the time of applying patch.
>=20
> -ck
>=20

I'm sorry for this.
I changed my post commit hook and forgot to make it executable :-(
I just wrote to Sagi and said that I'm going to send a new version with the=
=20
results of blktests. In the meantime I'll shorten those long lines below th=
e=20
80 characters threshold.

Thanks,

=46abio=20



