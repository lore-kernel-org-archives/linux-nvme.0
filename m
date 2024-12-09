Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8120E7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 21:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kSZS3HoO2Nx7R9glNVThIsY1mP4kZ+3kbmYfabJHp8M=; b=xQh2uCNNXiX/h283wYN8v00gxx
	ahadMpjv1LYn9B6pnQ7xt9OQw7PkaNmrIQ4sVuIQ+kiJfAais0Ol9jvmTkj9A/ZUpWgwP9mbZPvd0
	Iwu2QphAWDLNd8UiUwtYVfc5ZGIAb0PBY6BfLWqdtrel8izTLToaNOfWzSS6y06//3TrFVsv5ndb2
	UoKqPE2meqp4X+O1gyMu2ENXZLJJ1TLVltclTTq2Qfr8oCwxubef8enQTouIMSNfW5qstDymRNFha
	EjxurzuFfsO/YB5vXrwwltp4P4hH1s1pMNp4UJ4QUAipfecCvCOaIu5SPh4z0morr8ZhTkECp6sk/
	Jh6x0t9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKlTt-00000009KKE-2q2W;
	Mon, 09 Dec 2024 21:39:53 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKlTq-00000009KJG-2Btk
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 21:39:51 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2161eb95317so29685415ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 09 Dec 2024 13:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kookmin.ac.kr; s=google; t=1733780388; x=1734385188; darn=lists.infradead.org;
        h=content-transfer-encoding:content-disposition:in-reply-to
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kSZS3HoO2Nx7R9glNVThIsY1mP4kZ+3kbmYfabJHp8M=;
        b=LdZhQfvKuvxHgwMxWxEeymG3rgzxx9trT8HjnoSrEVUVQiCavbdgJUM0hBv81MNzt8
         YCbHMIfU+A2K6RlEhOQ7CaB42kCrcFJlPmnQjput8gXKZxnE6WzumeFCUL/zcZKHH8lC
         sFBYqJNIiHRQ2zxr7wrUxfOz7UI3QytpI3188=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733780388; x=1734385188;
        h=content-transfer-encoding:content-disposition:in-reply-to
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSZS3HoO2Nx7R9glNVThIsY1mP4kZ+3kbmYfabJHp8M=;
        b=gZkPNioEhPQvTir8uoJCMq4GXXEQANI+8TQ2LAT0pYIkx4tsk811IntqnhbUZuwYrq
         5WYCDq16PVYok/ZryHZcmxRffO6LZctpbQnD7kzTJJqb5AmKPaXIIfzauQN3BoRJXlvp
         lY2NCNu6Ury/zUp+idoeohq5fZHLJIIDfdybpbH4DgN20WsnFKZD3cfhyDCQ67H7JboN
         oK64AeqpCZjf1vAJAbWuYgO6lbWQPp63zd12mLbNqWAsO8KQUUGIP6ikkDU/bbwW5XOi
         lW792xqg5UDHcagpNrghRKIicmHk2+L+khq70WPc7iQPRbt4b+ECp/gsB860tFacHr3S
         W/QA==
X-Forwarded-Encrypted: i=1; AJvYcCXQG61R91TSH894bjV6j+CE/J7N+OtpQyabN9qS0AKlWno4nRRn9pCm19P+hwQ3T8E7M+c2hiDsOWz1@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1GKowGnfQzE2q5hQMo5V+daZXa+0aGerqwzx1XnqY6466qXBf
	WM0O19N9TlXkAOBnxTqA82hyykM28YMoI4MOa/F+4J5MCoWoKaywFtJaRBgXZJRxBLuM3FCD1mx
	H1ZtIoCFYFE/6aT1CZgTMqMasdF6HQ0Th/7Ki7VMuC8N4e6ppPU1KfvlhBp91Kp9yqGGsZK8=
X-Gm-Gg: ASbGncu+rIJU6tPFsYg8xKx3R9l1QcStB+VYdummMQXNuI3Lwf5d02yaXQH2fkkREoy
	kdWq8hbd9XVmD2LPXFmUauYN/RDGihofhs2euYuLipPvE1MFqVEyOFOlf7KY5NW2/Mmdzelsxjk
	JZli3LVY52kIwVma2K3JWB0aJB1LHIqvn1J28rg8LnrpnBegQTHOqtgvxhGRT0xfElln3HRdcIl
	CuHa+Xygu2DuP9U4Od/DwATeyJwDfHiOXjriZrJajARJ3o=
X-Google-Smtp-Source: AGHT+IHhTwKUqnMArrQKFug6o+M+JPC4Nb0STbWzhlgEDjdamkCXvykt/TK2ufxcBuncXqk1AdoNiQ==
X-Received: by 2002:a17:902:d185:b0:216:5294:619b with SMTP id d9443c01a7336-2166a0646cfmr26028035ad.47.1733780388174;
        Mon, 09 Dec 2024 13:39:48 -0800 (PST)
Received: from ubuntu ([210.123.42.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216669077f7sm11166365ad.161.2024.12.09.13.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 13:39:47 -0800 (PST)
Date: Mon, 9 Dec 2024 21:39:42 +0000
From: Yongsoo Joo <ysjoo@kookmin.ac.kr>
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: change the return type of nvme_poll()
Message-ID: <Z1djnrzTvra6wyMn@ubuntu>
References: <20241209133343.125885-1-ysjoo@kookmin.ac.kr>
 <Z1cQXGWGRZ5dcWOW@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <Z1cQXGWGRZ5dcWOW@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_133950_562126_5A5AC66A 
X-CRM114-Status: GOOD (  14.00  )
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

On Mon, Dec 09, 2024 at 08:44:28AM -0700, Keith Busch wrote:
> On Mon, Dec 09, 2024 at 01:33:44PM +0000, Yongsoo Joo wrote:
> > -static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch =
*iob)
> > +static bool nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch=
 *iob)
> >  {
> >  	struct nvme_queue *nvmeq =3D hctx->driver_data;
> >  	bool found;
> > --=20
>=20
> This function is registered with blk_mq_ops, so you would have to change
> the prototype there too, and every other driver that also registers a
> poll op. Honestly, it may not be worth the effort.
Oh, I overlooked the issue you pointed out, which brings me back to my init=
ial=20
suggestion. The function nvme_poll_cq() returns the number of found CQEs, b=
ut=20
nvme_poll() seems to unnecessarily reduce this information to a boolean.
A minimal change from =E2=80=9Cbool found=E2=80=9D to =E2=80=9Cint found=E2=
=80=9D in nvme_poll() would=20
preserve this information, allowing any interested researcher to make use o=
f=20
it. Also, the description of poll in blk_mq_ops can be expanded as follows:
	/**
	 * @poll: Called to poll for completion of a specific tag.
         * Returns the number of CQEs found.
	 */
Thank you for your time, and I look forward to hearing your opinion.

--=20


