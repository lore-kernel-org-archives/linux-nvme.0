Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF9AFD5F81
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 06:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bMIm9Q9ofJ9GhhEsS805lfRCjnN8ijsCSBGBh4tMwq4=; b=X4R75c3+48ieBDZstxfd+Ulzsh
	5Y79AxtqlDobLDOBvtemtJLrZK8Yy519PCT8aSmDk3ZNeQTbQZOE9TVASO67+5Nc/u93POfBCxpWu
	Oh4hacz//36VovG39AMUvfvrvrhrq61F9UEl8g8QfBmOe82KUwszi6X1QiRCG+efEchQCn8/Kdhe1
	TVKoOJELKgxfFwxY/yWghVoBCsp8MXMAZbpgPxJDj4T4+ycTTKbvWSgdKdDB6kEyh/MffJze+sdFr
	DQJn/Eck5lolsj/IbbE2AyGiHtFim4/wEhkSKm+LmPdvnnfNR2Uib21ZZW0G9WJYTrcv3aa5CpH3h
	MdMNPbLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAMQe-00000008LUg-0Ywy;
	Wed, 08 Apr 2026 06:30:20 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAMQa-00000008LTc-3TV9
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 06:30:18 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 34a83921 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Apr 2026 08:30:12 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 08:30:12 +0200
Message-Id: <DHNK8IM7F6PF.1LX1Z2KTRK5JO@arkamax.eu>
Cc: "Maurizio Lombardi" <mlombard@arkamax.eu>, <gregkh@linuxfoundation.org>,
 <security@kernel.org>, <sagi@grimberg.me>, <kch@nvidia.com>,
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet-tcp: bound sgl->length check in
 nvmet_tcp_map_data()
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Christoph Hellwig" <hch@lst.de>, "Shivam Kumar"
 <kumar.shivam43666@gmail.com>
X-Mailer: aerc 0.21.0
References: <2026031805-stretch-skid-ae5b@gregkh>
 <20260319012630.1802025-1-kumar.shivam43666@gmail.com>
 <DH6LLP692EBM.4N82LTNB60WV@arkamax.eu>
 <CA+ysrSLau_52n+4JMvQ=EtqY-cyWhhZ_pLOyeNL=mwkjkNvoUw@mail.gmail.com>
 <20260320074825.GB14485@lst.de>
 <CA+ysrS+9bWdF1LvxoZaZW_JLZ97H-RXM548Cm8ZW5KQAD+NCLw@mail.gmail.com>
 <20260407063000.GA6992@lst.de>
In-Reply-To: <20260407063000.GA6992@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_233017_197582_A935110E 
X-CRM114-Status: GOOD (  14.37  )
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

On Tue Apr 7, 2026 at 8:30 AM CEST, Christoph Hellwig wrote:
> On Sun, Apr 05, 2026 at 03:46:12PM -0400, Shivam Kumar wrote:
>> Hi Christoph, Maurizio
>>=20
>> Just following up on this thread.
>> Would you like me to send a v2 patch that sets a sane default MDTS for
>> the TCP transport?
>
> Yes, that would be great!
>
>> If so, is there a preferred value I should use, or
>> should I follow what the other transports do?
>
> I'm honestly not sure.  Maurizio/Sagi: any good idea what a TCP default
> max MDTS might be?

I'm not sure there is a "correct" value here. It seems to mostly come
down to balancing performance vs memory usage, rather than anything
TCP-specific.

For reference, pci-epf allows a max MDTS of 2 MiB[1], while RDMA uses 1 MiB=
.

Personally, I would pick a default of 2 MiB, it should be large
enough to avoid excessive splitting while still being reasonable from a
memory perspective.

Sagi? Any thought on that?

I have seen a patch on this mailing list that makes mdts configurable
via configfs, so in case of need a user could still change it
to his preferred value.

Maurizio

[1] https://docs.kernel.org/nvme/nvme-pci-endpoint-target.html

