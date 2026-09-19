Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC29C982CC
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Sep 2026 07:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fqh+Vg/0RXujtW+aoNMagRfaguimc3bCi6A3l9CfVBE=; b=I44U1J2POXD9ODZFW0O6A+PRf/
	PRhmCgbRaEI6ns2xF+Rbg6lHcytdx0wOd0kUSkqWXqmQtUSNzEhF76L2L+a9nQpSE1XAmZxBpXSMY
	Jnr9dkCg05RjCtQyfEW/LOvNTEIU9Izo/JXUmUTi9Mw2GzHrHFyx9BbY28zcHhNo84SPVT6HHk2/Z
	IT8LOvdAt/Wmppg9P8g1DBRIXvA4lvPwntQv/gaYWJL0dz2EIjK3wZ5gtHnhzyCGyXFwpswvFUlNM
	3MJiw+Pbe+/HhyMKYQmxZ3az4edDlbFNZuMFgJhV1iKFSd6NMOS+19Fz+b35AHkvGZQyvluOMISn9
	7I5hlimg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7ptF-0000000G5Ec-2UdK;
	Sat, 19 Sep 2026 07:53:41 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7ptC-0000000G5Dv-2SCo
	for linux-nvme@lists.infradead.org;
	Sat, 19 Sep 2026 07:53:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=fqh+Vg/0RXujtW
	+aoNMagRfaguimc3bCi6A3l9CfVBE=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=oYPKntqDrXHD4vrhb1NxQYqcKg5g+cHppazfm
	JJb7qm8jOA85IV06MQmajHC6vMRv2FvLVx5JMKqj5KdOGOuZ3uubDcf5VF775Pvc9ox+0S
	nUS5PVkQr2/gazHsoBbFMKUawFyQK1IBqirpx5pCByzci0sYFd6mhbtOaXLF2P00Dv8yen
	Y24hEIDhCiq8YbpYE+JlC4M/K0e8paT3aVlpAjzGs4davnABUy4G8Q6ac8Y7mRskwYaKtS
	6UKd0b6Xzb2Lr2gNqDzIO8B6hH9MgDjGVd5SuT1BR/5LpE+SuUYUtQxaLtqgmtFTDVsbFG
	hoHK3bQOAtybTJBGH1JEbsJQA==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id b609f343 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 19 Sep 2026 09:53:33 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 09:53:33 +0200
Message-Id: <DLJ4POIDTYXQ.2AOJP9BJAWEOX@arkamax.eu>
Cc: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] nvmet-tcp: report a bounded MDTS instead of "no
 limit"
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Ing. Alfonso Kuen Arroyo" <gerencia@idkmanager.com>, "Maurizio
 Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.22.0
References: <DL41D2NGEUHW.2UUHTZ6LLM9X7@arkamax.eu>
 <178978683646.43804.6940923486189370705@idkmanager.com>
In-Reply-To: <178978683646.43804.6940923486189370705@idkmanager.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260919_005339_269739_C8F2A5E9 
X-CRM114-Status: GOOD (  17.77  )
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

On Sat Sep 19, 2026 at 5:00 AM CEST, Ing. Alfonso Kuen Arroyo wrote:
> On Tue Sep 01, 2026, Maurizio Lombardi wrote:
>> #define NVMET_TCP_MAXH2CDATA 0x400000 /* 16M arbitrary limit */
>>
>> So the comment should be fixed, it says NVMET_TCP_MAXH2CDATA is 16M.
>
> Agreed - the value is 4 MiB and the comment is stale; it predates this
> patch. I'll send a separate one-line patch for the comment rather than
> fold an unrelated change into this one.
>
>> Also, it's not entirely clear to me how the target enforces this. Suppos=
e
>> an host sends a 2 MiB command, violating the MDTS setting, what happens?
>
> It doesn't enforce it, and this patch doesn't add enforcement. MDTS is a
> limit the host is required to honour (the base spec says the host shall
> not submit a command exceeding it), and nvmet has no per-command check
> against it, neither in the core nor in the transports.

And indeed this is what's missing, because the specification explicitely
says that "if a command is submitted that exceeds [MDTS], then the
command is aborted with a status code of Invalid Field in Command."
(Identify =E2=80=93 Identify Controller Data Structure, I/O Command Set
Independent)

Maybe it can be added separatedly with a dedicated patch.

>
> What the target does have is the hard limit in nvmet_tcp_map_data():
> since 4a3f00262a04 a data length above NVMET_TCP_MAXH2CDATA fails with
> NVME_SC_SGL_INVALID_DATA | DNR before any buffer is allocated. So today
> there are two numbers: the one the target will actually accept (4 MiB)
> and the one it advertises (none). The patch makes them the same number,
> so a compliant host never builds the command that the second check would
> reject. With MDTS =3D 4 MiB, a 2 MiB command is within the limit and is
> served normally;

Yes, but your patch sets NVMET_RDMA_MAX_MDTS to 8, which means 1MiB, not
4MiB, so a 2MiB command should be rejected, even if it's under the MAXH2CDA=
TA
limit of 4MiB; or am I missing something?

Maurizio

