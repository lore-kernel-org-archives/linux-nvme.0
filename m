Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011BEC02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 08:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DbFNnnjMu0a76Rzhj10JbBbSCXjigoflT9doRb1z57w=; b=zf09RpHbFOLk9k972djfz2TCDt
	3bhHl8Ss0S4yOHwylprLtRysw3YgJl6WrFDo+aCx4a4LEW8KnZQT+CdjKm+D0pjgN7aEroTPJHSwG
	yUrlQwQjvlCNgB+wcup3pLT3Akn/pyws1LTPqp0OdGoshsDIHPD9572dZtnVetA+JFDgC4U1jpCM9
	658f0sd6ak9RVP5e/NVWFR6mLqYdJ1rFu6LkKDK9KVa0MApxDQFz+lvAjIwYdW/8o+Q3qs5OAShWr
	yq/3ZniPRZg/i6RmH1a+6lrhRsXRJub9ubNL9dqFf3u4MIHX3MSjFwV63yhzf1Fhd8PLQtEdodh4v
	50eweVeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbEnm-0000000ECdZ-0Bcr;
	Fri, 24 Jan 2025 08:12:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbEnj-0000000ECcm-1Ypr
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 08:12:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737706346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbFNnnjMu0a76Rzhj10JbBbSCXjigoflT9doRb1z57w=;
	b=Qi+FgqLKRKICPw9eMWCzX/m4gK8rya23FOpgyOK8HiN98ZwbWed+dpotpGkn7HnBCApAGO
	BshgK5yCV96wJVmF9M6fS0DiN8sTmuEagddsEc3S8uxsAdU50GVzQ+CiZM2mpsKTCx9tsJ
	moVwwW9uH9CzAa8Fdd8SQ0Ru/M+7dW4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-eiTqdwY9ME69Dv_qjOi2kg-1; Fri, 24 Jan 2025 03:12:24 -0500
X-MC-Unique: eiTqdwY9ME69Dv_qjOi2kg-1
X-Mimecast-MFC-AGG-ID: eiTqdwY9ME69Dv_qjOi2kg
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6df9ac8dcbeso54538906d6.3
        for <linux-nvme@lists.infradead.org>; Fri, 24 Jan 2025 00:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737706344; x=1738311144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbFNnnjMu0a76Rzhj10JbBbSCXjigoflT9doRb1z57w=;
        b=s+YIfP6YZNHR7TDMXqqP7IBgPbUS3Em/xK1k1xdR3Xhg/Bo5Ljq1qoKGS0ciKXeRKb
         nRMGudM9dOkKQIQo6H3a3sd35Byw1LpjmyrsaeG+Gssm6bcGUl6G5Vb/3Di9dWfdeEMd
         EW+9D1wbffXtGy36aI+4nnEk82VQjUodT4C41kOoBHOYnO9UXkih3T83GoZ49MXWW5Ht
         1kDe92n55aepKdqVevsQ+ew9Cgvu7yLjQ4go75TzVgltvbkPwYBwUMHZ+d5KvRxF63e2
         pmIDTsUIfKWzIriPp+4oFACW/7borRfiXHWbZVUrIB+ttwGZYMNrlIzGEzr1/zItO2Pi
         Ojng==
X-Forwarded-Encrypted: i=1; AJvYcCV4rcdIiXyIu6AiTcryWMftTsklR92ZAZX8VSVBCLSBeAzbimRRJxHGnqsvr7WG6AKovNRNLtLmv7qL@lists.infradead.org
X-Gm-Message-State: AOJu0Yw3KE6R9SL5FXQWrzfPW+qN8x92NZgPI22d9PGqDfgT9nc+19H7
	hM89MvUDBAGEc40K5meGt5HBRpRGyXrSgAeoagNAadnuqk/FcrKhk9EWB2kYzqZUWzDraPlsGev
	Q9M/BTQUojfXb0LxFwjeQb9XEz/XuGnYraSfn5NXBPs6sh7JPr7Fc82Wij2NopIn0oMfOdb9cs3
	94EN9lcU1h7mcgPnhE2+ZBY4QTP77ANp4G/aD0rkI=
X-Gm-Gg: ASbGnctLJnCxMvkBlt1s4OgwzPbysOmcwYoNFZ7VrTlG+FA1his6DDaFL4AlAP7uMR+
	3wwWobDMAA6BreqGxiebt2zfVac7XSCOQIjUyCa9+JfJqmlH9iELi8w==
X-Received: by 2002:a05:6214:3007:b0:6d8:9062:6616 with SMTP id 6a1803df08f44-6e1b216ef7dmr476176756d6.7.1737706344486;
        Fri, 24 Jan 2025 00:12:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgeQII13nJr8+NJnUdNhmH/TPyj/gOeh4yd2OpnfJP/UyrgTBwO51nY8Wc7FtiuB/s2LonOhxM/xPjBFsO6Hc=
X-Received: by 2002:a05:6214:3007:b0:6d8:9062:6616 with SMTP id
 6a1803df08f44-6e1b216ef7dmr476176536d6.7.1737706344272; Fri, 24 Jan 2025
 00:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20250123224941.1359950-1-csander@purestorage.com> <CAFL455=TMmKVZPtnX_CBF34+EtfMbq37OxQAFGJuW_u1VjEQsA@mail.gmail.com>
In-Reply-To: <CAFL455=TMmKVZPtnX_CBF34+EtfMbq37OxQAFGJuW_u1VjEQsA@mail.gmail.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Fri, 24 Jan 2025 09:12:13 +0100
X-Gm-Features: AWEUYZmxCUBsP6oN6hnn5VVjaBuIKeAyz_kb_vQQqnB46RFLtVi6_QJP-psvyOg
Message-ID: <CAFL455kLsUfvnMZKSsU0rGyCiT5+GHNr=1bEjFz0L1kfYn9NqQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dwS1bUFaO5j8UazijhyJ7oPDUPgyMKylQ0uKdbut_FI_1737706344
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_001227_492397_0412526F 
X-CRM114-Status: UNSURE (   7.27  )
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

p=C3=A1 24. 1. 2025 v 9:08 odes=C3=ADlatel Maurizio Lombardi <mlombard@redh=
at.com> napsal:
> I think that if ret > 0 you should set it to -EINVAL.

Small correction: if ret >=3D 0 set it to -EINVAL.

Maurizio


