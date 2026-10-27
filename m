Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B58D60A2618
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SnTvrPYE;
	dkim=pass (2048-bit key, unprotected) header.d=arkamax.eu header.i=@arkamax.eu header.a=rsa-sha256 header.s=mail1 header.b=CifpoE6L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=aeISGMF7jo9ZmnnYzu9dhnDsLHoHiUMKZzLNzlMaEfw=; b=SnTvrPYE6NI3gh
	sKLPtcmPC34VrFS3M45dugCwo7QuW5UobtOoPT4DYJx61o+GpnV1+iauK7iu6z7k7/0vM3nK9F5OO
	Z3j2XJ+y5YVuPDayje8z/EZ/DSQKg/z1mlKG5fuG1Zg2xh7Isa4wTjKlkbA1YD69pLRyOLFN0wIUK
	us+aHssmPJF7cnWGqIRd2EkLGdMmW51WXaQczIu2l0ytHs62qj8VZ574BiiP2oS5hovG9XpJMdGWw
	LwMvt0tmMvJ/EEuL5ha8ZAdXqIIRx/34Oob5jD4Hf1zVAWC/oz/J/aiVjIiPBeYhDuDvNzGArN/l0
	uXsJjQm5fXyMZE2E6Vtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLid4-000000055h6-0b5q;
	Tue, 27 Oct 2026 14:58:22 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLid1-000000055gC-1lDC
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 14:58:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=vcL4CwE+6VhO2v
	sCn7jTRwjlRR9TRbNKFbpG7UoqFVU=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=CifpoE6L8xS0T53UnwHyO+KDD4oCWlMQWfQZE
	L84vyp01h4x1ScFl5eT4l56GeY2Nc08TM6kvs6foCa95zkwwMmveCU8xPYdld82+i2tW9L
	9+EuOKz7KF4H4yVS6Jm8xS1riYwM0vDzOlRNR2tAK+mSA70wTY13/spUSZsE/+12LfNPDp
	Xxa05SIJpPWsM/Be5sEuu1PpUD9tiexmixIG305of3PjPqhdAU5MsXLWcIY2CZ1xE5SYvb
	VWPucZuAjvQq+jbofGLRIExLeEWyadv1VnUCprlacKcHh9dyqhNttHLCeOhkoFQdsj9O/9
	QsuxMtcVzbnV3JncMxhnI0iHQ==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id eef2211e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 15:58:14 +0100 (CET)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 15:58:13 +0100
Message-Id: <DMFPJJEAQDER.1LTPXDFP8FYUG@arkamax.eu>
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
 <paul.ely@broadcom.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <kch@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <syzbot+df0058a8d0bdce7c4059@syzkaller.appspotmail.com>, "Paritosh
 Potukuchi" <paritosh.potukuchi@amd.com>, "Ravi Kumar" <ravi.kumar3@amd.com>
Subject: Re: [PATCH] nvmet-fc: extend critical section in
 nvmet_fc_remove_port()
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: <paritoshpotukuchi@gmail.com>, <linux-nvme@lists.infradead.org>
X-Mailer: aerc 0.22.0
References: <20261027144304.1177203-1-paritoshpotukuchi@gmail.com>
In-Reply-To: <20261027144304.1177203-1-paritoshpotukuchi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_075820_119870_50ED2A68 
X-CRM114-Status: UNSURE (   5.55  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.1 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 27, 2026 at 3:43 PM CET, paritoshpotukuchi wrote:
> @@ -2932,6 +2927,8 @@ nvmet_fc_remove_port(struct nvmet_port *port)
>  		nvmet_fc_tgtport_put(tgtport);
>  	}
> =20
> +	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
> +
>  	kfree(pe);
>  }
>

I don't think this safe.
nvmet_fc_tgtport_put() can end up calling fcloop_targetport_delete()
which calls flush_work(), therefore you call a blocking function while
in atomic context

Maurizio


