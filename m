Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB67C7EE24
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 17:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fHwd4xj0DNhVRRocAAv9zxeTNWtRFM6WDQM6iXc8IWg=; b=PHUjc4wVojRa9IeQDHg/OROZyd
	G0/ZPZd0Ix4vPGNScFHns0GM09/OJcPne/q61NtXXNQrPPpORbgmzUlpBNR0R+6uMu6pvVPfxh33h
	cTcHNnZ/vjK4ROW0uZmWeXaxIz+UjH/f2tcKFm52AVN0jCEo7GmHSqkNShS10SZ3lGs99lG51S3Yp
	gK2BGpKCEzPLajpdIxd1P4MHvt6I5Wx66oiuHzHIclzgVTaReakRaEhN8gLLU4z7adZgTDKYKb/9e
	VjLcxvF4j74FVWfyxrQrhS1TR9/o93DpMdl9GflCDWxGDmThSdrbJes2g8v6OCrrR4D0D0zBc8FbQ
	J4hvyvcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6akY-002da2-1G;
	Tue, 06 Jun 2023 17:45:42 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6akV-002dZA-0b
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 17:45:40 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f9baa69682so14851cf.3
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jun 2023 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686073536; x=1688665536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHwd4xj0DNhVRRocAAv9zxeTNWtRFM6WDQM6iXc8IWg=;
        b=eam6jhbQpY2JX8xLLkhv0yaMSMoLq31rBUfLkoZslsOiJRJkYcnUnvE95zvRBgiLS+
         7yyAitFM+fBVRJRMSziVoj+YSRV7nL9KfAb4jv4askxWgGt/54svqVeb1esLiHnL6nW9
         OGQ+JnnhznHN9rLPs9omFQ1pI+eUDZEZKQONbYUKhrZPD+9F3ZpvQsW2qxD3IYLdOgvD
         3E+JUVU2eMrcF0z6QmfuwC82NsXNcUC1DChPuQfVaEBaA7EiX+wuT+zJtewD4guLv+Xa
         2yk7nxZHgx/VKXUQ4MoGcyijrEUIwPvdNE2cohCzJD952ODv/I1RGLQAKX0y01xxsFlk
         m8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686073536; x=1688665536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHwd4xj0DNhVRRocAAv9zxeTNWtRFM6WDQM6iXc8IWg=;
        b=MnfOyz+GyJ1pUtzkENkzPlMm3+0IWR7/D+IE4XTTo4lsxzv27XMoEybloBT6wn/dP0
         3MwTzzHOscgmoUQOMfqrNS9gL5DrDDtJNKLdjGHsc/ieVou8FRthlzHpLkA9X1OAK+8G
         z8FInTz7wR085dTTlj5SIqTvXbx6PKn7D6QbHp/xvSdrzx7fi6ZRhMlwtfG/j2hzalJN
         Rgs8VLSuxjJI0JMAiEC6MEtjcCYmkOI1TeiBt1VBs4PEP6UdtRBGpt+kTRKal5KNeJa1
         Qz0DTZB1oEZMYFS78OcqllvwG35A9xMWGp6AU+98Fd8Zbr+T7C8f8fBPvl6ERvy8srXE
         oMkg==
X-Gm-Message-State: AC+VfDw/f3jQruu0d6vuwFpdRpjVB/qK3CL9D83cdvXjVQBGYCgeQIVj
	aMag2EXT5HlU7Ns1N0xBkRz3ow==
X-Google-Smtp-Source: ACHHUZ4l8qvSLj+eigvYITUt4VH//gpwEqDw4vbb6W9i1DMdlyt2QosDSesRuk9286OHGFRVOruivQ==
X-Received: by 2002:a05:622a:1a1f:b0:3f6:6aae:a0a2 with SMTP id f31-20020a05622a1a1f00b003f66aaea0a2mr321894qtb.55.1686073536576;
        Tue, 06 Jun 2023 10:45:36 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id u3-20020a05622a17c300b003f9a77d1ba9sm1884198qtk.43.2023.06.06.10.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 10:45:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1q6akR-00306g-2b;
	Tue, 06 Jun 2023 14:45:35 -0300
Date: Tue, 6 Jun 2023 14:45:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-nvme@lists.infradead.org, parav@mellanox.com
Subject: Re: [PATCH] Revert "IB/core: Fix use workqueue without
 WQ_MEM_RECLAIM"
Message-ID: <ZH9wv6UNZtxhxrfw@ziepe.ca>
References: <20230523155408.48594-1-mlombard@redhat.com>
 <20230523182815.GA2384059@unreal>
 <CAFL455m3T4qrk0Uf5qK7-57Oh6L6AKionfs0mF-imUMYpbqBOg@mail.gmail.com>
 <ZHebeWlpn68Xa1Hd@ziepe.ca>
 <09504ea7-186d-9ede-e01f-87849673b9b2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09504ea7-186d-9ede-e01f-87849673b9b2@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_104539_430348_5E9948BF 
X-CRM114-Status: GOOD (  17.48  )
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

On Tue, Jun 06, 2023 at 02:01:04AM +0300, Sagi Grimberg wrote:
> 
> > > > > workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work
> > > > > [nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]
> > > > 
> > > > And why does nvme-wq need WQ_MEM_RECLAIM flag? I wonder if it is really
> > > > needed.
> > > 
> > > Adding Sagi Grimberg to cc, he probably knows and can explain it better than me.
> > 
> > We already allocate so much memory on these paths it is pretty
> > nonsense to claim they are a reclaim context. One allocation on the WQ
> > is not going to be the problem.
> > 
> > Probably this nvme stuff should not be re-using a reclaim marke dWQ
> > for memory allocating work like this, it is kind of nonsensical.
> 
> A controller reset runs on this workqueue, which should succeed to allow
> for pages to be flushed to the nvme disk. So I'd say its kind of
> essential that this sequence has a rescuer thread.

So don't run the CM stuff on the same WQ, go to another one without
the reclaim mark?

Jason

