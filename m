Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71157ED7BBA
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2026 10:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:From:
	To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eKAsRUzGdOfbVQMW0R45M9LFPAYPnmxNwyuNOHqbTY0=; b=tiMUb4b5rYKw+SaOKdhVK/5+Mu
	65/rMWVbLYo3xcX8c3367TonLDEv1EQBZd9hSvnXdE9sUVYLS800+hLzf9n8kul0Ve1q8sTJHszZB
	KD8ZHU4FzLHn9lM5jQk5IjupR/xhR/fdxlDGpU4QHVvkCSRATROXvlWFz1Ylg0Y6O9MHWHaRk0nFh
	hB9EC84q6LovVOBxdH9JOyY1twL4ZG0V4HnD7CF8eGC2FWwTOkMwsAW4k+ykaJSLZwAjd4j/71K3v
	gH8JJ0uB/wb8zT6mVM5ZXLN9mgtbMmHn0dycIeCay1oIPyGW971IUh42SSG5PtdLWmRtjQCVwLNn9
	cek7TYvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCbII-0000000HAxf-0vRe;
	Tue, 14 Apr 2026 10:46:58 +0000
Received: from mail-4399.protonmail.ch ([185.70.43.99])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCbIE-0000000HAxI-3xsM
	for linux-nvme@lists.infradead.org;
	Tue, 14 Apr 2026 10:46:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1776163608; x=1776422808;
	bh=eKAsRUzGdOfbVQMW0R45M9LFPAYPnmxNwyuNOHqbTY0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DgmcU4gGNW9uFb+QeMNrCNeS/Wujzf4RIkpauuo0/OAEkgsFXKfmVuGX8EsZWka4G
	 91SvKslR6WIeR2ohnVjcXQqOAdFQKzvV7I94dQShgmDethyGlc7Hns1acw/5KPmhbW
	 ZIXaROAFuu5WV/WqpmOvobLnlaFC+TeLxbXDwt5bCvVsDzdoHawbERx8stv9beWVk1
	 5wjoC9HgbcyUuPJiMBACs7UEUbXg6cOuRAVrOYpwT0ylDPVBe35Rj/D6+delut2Nhp
	 jjF5KQjPEI4KeiGhJISn3zeuG1XN1z0UB0v/EKG4OL1MsXSIrzwoIFxVDauWubpwoQ
	 mTyGEUmhqVvYA==
Date: Tue, 14 Apr 2026 10:46:44 +0000
To: Hannes Reinecke <hare@suse.de>
From: Paul Moses <p@1g4.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "okorniev@redhat.com" <okorniev@redhat.com>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme: fix handling of tls alerts
Message-ID: <KRsrO7YRfuOCHwlfhASNG5rNuh2v9MGuWP8Hnir4GFkXG6aZzHH3Tn2P4lXd0oeTd1ogyTED_v0VS2ROjf6bux0KLK6nQjWMNKvtz0Xzruk=@1g4.org>
In-Reply-To: <d60274f1-b9bf-4378-b59f-c0e92dbca274@suse.de>
References: <Ozwl9wDbyugg3Ytnr80omDUS6JPqCHgq_k8gkqtMIP2KbHBMt6CYRRMk6LKGOTNPwtj_wNimbH0mZiAe8-9zcRmS_UgArtcI6poZ1PZjMoU=@1g4.org> <2026041239-engross-edition-66eb@gregkh> <N8h5xrK8_cznpQNTzRIDl6Ofz_nN1Hvl1DVSXnL9rSR6zHyQGIPDKEDURE7uf2PgGOCe2jTRcEiamFmAzw-xhQPCBdbPoUu_BelZ8Mrzmg0=@1g4.org> <84c3b656-9406-4869-9214-aff1ee0f1607@nvidia.com> <207e1c3e-2a99-4085-81c0-7853f3d09f78@suse.de> <cegmtu5F2Mmye7nAykxzPw4Bh8EZZCCx79IUFf4RN5vEZcAbq4-mTr5H7LycgByHGg4EzrAW4TkYkWhkCPTXtsz1dF6iOBwB672-wE15iUY=@1g4.org> <d60274f1-b9bf-4378-b59f-c0e92dbca274@suse.de>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 9771a751c9e60be545c3a243f56e34bb76c9a219
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_034655_644687_2E141DAB 
X-CRM114-Status: GOOD (  12.38  )
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

> Not sure about a reproducer, but we certainly need to handle TLS
> messages (including TLS Alerts) correctly. There is a patchset
> to implement REPLACETLSPSK which basically requires us to handle
> TLS messages.
>=20

I don't think so, they were porting the fix from sunrpc. What I=20
removed is what does not apply here.

From: https://lore.kernel.org/stable/CACSpFtDo+Bo0Dre-c9yxf7OEJNUUDesk-Lf+6=
sCdmMBQH=3D_JvQ@mail.gmail.com/

This is where my patch deviates from original:

> Yes we certainly can do something like what you had previously
> if (len =3D=3D 0 || len =3D=3D -EIO) {
>   pr_err("queue %d: unhandled control message\n", queue->idx);
>   return -EAGAIN;
> }

> But not that in that case TLS alert bytes would still be unconsumed
> staying in the socket. If what follows is a prompt closing of the
> connection, then who cares. What has been worrying me (even in the
> NFS) code is what happens when TLS alert (though we do consume it)
> isn't followed by the connection closing.

> Now let me know if you want me to re-do this patch based on what you
> suggested and ignore when len=3D-EIO. And then I can redo the patch#4
> based on that.

This only matters if we intend to continue on that socket after the=20
control record, nvmet does not. Any negative recv tears the queue down=20
immediately. For nvmet, detecting MSG_CTRUNC and aborting is best choice.

Thanks,
Paul

