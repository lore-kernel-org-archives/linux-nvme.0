Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCAEC35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D6+BdsPcjPu0AJt/m/Revvb4dsRx5LixCpZ+hNDafqQ=; b=a9HGG4IL/OKBHyuee2/ESwyW9O
	Dl1c6P/i+vHxPvkuNi6dnpkigmmi6lwwcXkt/JqqShouAKekO5Rl9VK5/AuPMAYXzV5FUk3DF/TUn
	0GE1JXydhpRHCmP6kaH6hBaI7llo0BCRFkGuf6X5UG6u/oMKG+hk1+MjsGPqCIuXtNBIQoJ0s69oY
	SOdLiaWD5u2aYu9zDralvbXYTLwDumM1RfzPjQVHBiixlXUUZ0NT/D6WO1NKuUpfLNOJ3sY9+gkt0
	1VAlPd/sEWvy0aXfzhkT8+vnrEZRhKt9Wzu2qClXUQyb5m0ZOyuHhFvTUnULwprb8p1Do1gnBBAWU
	C9V+EX4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMhg-003caZ-30;
	Thu, 21 Dec 2023 17:19:24 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMhe-003cZK-2j
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 17:19:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 59531CE20A6;
	Thu, 21 Dec 2023 17:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141F6C433C7;
	Thu, 21 Dec 2023 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703179159;
	bh=baSf0K4AkkJsUjW7EiL7QrwAKj6f6UaivcUDoX239jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwMPTolVrjPPGDQZPKWceXu2VhNb5P/Lfdp1tDNFqW2+Tw03f+ImCtRI3p5k7G1HD
	 d13zUxTZwrxmDYLVfzwXRo/mmgf+gP9DFO6HD6GuzKv/WQNtDLWac5GypINJYKcnLa
	 alEPNnp4v7aftyaTGyMw8DttNUTrPA0Xp0o88hTlbN5cFCJWvgYn+VXRH0u4qMWWer
	 6WoTI/OigkWC2thQiGhU6T/W2W06jr3Yse5cQTN2f0sbiRk69bLzJFu0zEeog1uAIO
	 Zl5KKt/65WPlgxfVIu1PQNzXV+qooME1Ul+m9+SasreiucLLWbyMQxi6/IP1y3ReqI
	 g7pYqypjnE8pQ==
Date: Thu, 21 Dec 2023 10:19:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander <csander@purestorage.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	dwagner@suse.de, hch@lst.de, linux-nvme@lists.infradead.org,
	oren@nvdia.com
Subject: Re: [PATCH 1/1] nvme-fabrics: don't check ioccsz/iorcsz for discovery
Message-ID: <ZYRzlB1fc-N8Rs1x@kbusch-mbp>
References: <20231220092745.35325-1-mgurtovoy@nvidia.com>
 <573c2ad1-8407-4c8d-b31d-b89b16f0fea0@grimberg.me>
 <CADUfDZrhPONOEK6xhbn3Uig4UZ+nwg0hDCRUziW8NA_g01raHQ@mail.gmail.com>
 <5694a097-eec9-45af-8bf5-2e5d3963a03f@grimberg.me>
 <CADUfDZo5zxgidqjt-OmQVzGXdoONvX=LV0dpm0rCsjjXPhnBpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZo5zxgidqjt-OmQVzGXdoONvX=LV0dpm0rCsjjXPhnBpg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_091923_052671_072B0BAD 
X-CRM114-Status: GOOD (  13.50  )
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

On Thu, Dec 21, 2023 at 08:45:05AM -0500, Caleb Sander wrote:
> On Thu, Dec 21, 2023 at 4:02 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > > Why? As Max points out, the base NVMe spec says those fields are
> > > reserved for discovery controllers.
> >
> > Oh, didn't understand that it was already the case, I thought
> > that the intention was to made it as such. Can you point us
> > to this part in the spec?
> 
> https://nvmexpress.org/wp-content/uploads/NVM-Express-Base-Specification-2.0c-2022.10.04-Ratified.pdf
> Figure 275: Identify – Identify Controller Data Structure, I/O Command
> Set Independent
> Both fields IOCCSZ and IORCSZ have "R" in the "Disc" column,
> indicating that they are reserved for discovery controllers.

Sounds good to me. I've applied for nvme-6.8.

