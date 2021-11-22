Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3AEC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 09:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nbvOvnFnDV4WF1ejf2PQnGG6K+OhC43w0EqaZiX2IM0=; b=DF0Qu7rth8pglRegitxr7JL9G1
	3sV1CgE5PB7S/mgSNrf/yQozUO8/swKpx/maAWmbUABT/7iRJbztcD58XgmnjtoGDEN8I0A8QUj2x
	cJtDnIsuTFUKx5z3PRV0DpdLYneGWTERQUDZwqwgcdWc4kgC2gxhB3qwq42J9t8Kh0tQxuCFzwil7
	ueaIqlMgs6QgVh5FB5WIsSpU2VuK2jr1Y0ck1g2oLG9aQR9zmO6jiEvDDc9150aG7Z73BuOj1uuFz
	XNANr0n8haBwPsjEUBC4lVIy1NSsscCvsXIyntZO8MsIBnn4uuun07Nnu9P3mCpCPiR3qDotThCOy
	p1IjnfMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp5mq-00FdhZ-Cd; Mon, 22 Nov 2021 09:38:56 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp4Rw-00FEb4-Cw
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 08:13:17 +0000
Received: by mail-wr1-f48.google.com with SMTP id a9so31056881wrr.8
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 00:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nbvOvnFnDV4WF1ejf2PQnGG6K+OhC43w0EqaZiX2IM0=;
 b=DU5jd28zQsPntrQYT13kY0hlsRQx3SDQ1PPCoi1lDhFpQ147pCZvIhjoDawVUrcQB0
 mSfBbbFTSxw3hY+fYvM2eX3hmhUkuAhu1k9C/3ENGfC49Gva5U9TwlKGFXhump2tZUfW
 biTvkzmGN9C1uQ0J4e+vBsLTxNCtr+lBDrInEkqKCmhpkfyRrvldBlwt1wkeGjZLpkc3
 AXvnSMdnUt8VuFOJaiQ0q6F2VtEIbH1JNQO7i+cGVrOpd46zG6TaNqLgplbvlIqIq2CQ
 ItX8xVu+RPQg6mjjuFfhCbNRGBEV/cHTg9Ec6HntSnIKS6H2Qojej3KDovxBY24+YgAv
 P05g==
X-Gm-Message-State: AOAM532OVts/UCQU21h/m8buCU2uhyyapbSW9zLgbNV7ypEVCW/TjBvq
 3YeDtZOD2Lw+z0kG9QV4kjI=
X-Google-Smtp-Source: ABdhPJyr2rExqqT2Q0nefuJdurYFQc3A+0MO3/25NtEKDqhABcpH82RTboem7iGolwHuUZMLqjgtzA==
X-Received: by 2002:a5d:648e:: with SMTP id o14mr36795793wri.69.1637568795064; 
 Mon, 22 Nov 2021 00:13:15 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id j17sm11078397wmq.41.2021.11.22.00.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 00:13:14 -0800 (PST)
Subject: Re: [PATCHv6 00/12] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herberg@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org
References: <20211122074727.25988-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <14b025bc-746f-ea73-a325-7805c4b46c28@grimberg.me>
Date: Mon, 22 Nov 2021 10:13:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122074727.25988-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_001316_530474_16980E82 
X-CRM114-Status: GOOD (  23.45  )
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



On 11/22/21 9:47 AM, Hannes Reinecke wrote:
> Hi all,
> 
> recent updates to the NVMe spec have added definitions for in-band
> authentication, and seeing that it provides some real benefit
> especially for NVMe-TCP here's an attempt to implement it.
> 
> Tricky bit here is that the specification orients itself on TLS 1.3,
> but supports only the FFDHE groups. Which of course the kernel doesn't
> support. I've been able to come up with a patch for this, but as this
> is my first attempt to fix anything in the crypto area I would invite
> people more familiar with these matters to have a look.
> 
> Also note that this is just for in-band authentication. Secure
> concatenation (ie starting TLS with the negotiated parameters) is not
> implemented; one would need to update the kernel TLS implementation
> for this, which at this time is beyond scope.
> 
> As usual, comments and reviews are welcome.
> 
> Changes to v5:
> - Unify nvme_auth_generate_key()
> - Unify nvme_auth_extract_key()

You mean nvme_auth_extract_secret() ?

> - Include reviews from Sagi

What about the bug fix folded in?

