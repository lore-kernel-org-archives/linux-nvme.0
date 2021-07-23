Return-Path: <SRS0=kg3i=MP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD3BC4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 20:03:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FCD960ED7
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 20:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FCD960ED7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vlnb.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:Cc:To:From:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=R9+jowwD+UX55w+oaKjH1wku6Owtd0Ss6u3oZLE8ZFo=; b=OkTkLCUvjMkeUzxU9xwt1nns51
	nYFK/wmOiJWm29rPJUla2rSd7z0EFmw9fwO74TEpWtVDYtDXRNuSIFJrkFlfuiXCdGT1hGFVHfrM2
	nHII3pbn0nJK2g+aZwR+HVfBvNr+LjZeelCcNmFD0ztM3C8yDY0jLJVsHEF3kCLFXls5gRMDBlBpt
	GwlRQ1zTF8THJvAt1+pGADw/yAMoIzBiixTTo+RN4TZ1IgO+lHbgQjZr/M48bYu7MiqYtznh0A8aJ
	aT33QWTnepAyuYBNXM0QBR0ff1OmuM2/93kg87cCEJS09WOVcg/bjpCVFrh8oz778SpugwHh/Amx/
	G5JP+QuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m71Oc-005on8-VE; Fri, 23 Jul 2021 20:03:46 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m71OZ-005om7-K6
 for linux-nvme@lists.infradead.org; Fri, 23 Jul 2021 20:03:45 +0000
Received: from [192.168.0.113] ([178.252.67.224]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.179]) with ESMTPSA (Nemesis) id
 1N0WPK-1lD9WG2tro-00wRmx; Fri, 23 Jul 2021 22:03:20 +0200
Subject: Re: [RFC PATCH 00/11] nvme: In-band authentication support
From: Vladislav Bolkhovitin <vst@vlnb.net>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <66b3b869-02bd-9dee-fadc-8538c6aad57a@vlnb.net>
 <e339e6e7-fc32-2480-ca99-516547105776@suse.de>
 <833cfd62-1e1f-1dca-2e38-ff07b3a5e8fb@vlnb.net>
Message-ID: <2f241490-3bfd-2151-9d76-970e0d6bfd68@vlnb.net>
Date: Fri, 23 Jul 2021 23:02:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <833cfd62-1e1f-1dca-2e38-ff07b3a5e8fb@vlnb.net>
Content-Language: en-US
X-Provags-ID: V03:K1:RYCcHwZV9sA2oxeVhxRvbvDhd5IuKxNV2ReWMKOc/9Q4bIvmbX6
 h6RYWbMIsCKj8sHaD3mCj85uPWkaioVc64b2poXjAqL6ZAVFX6/lCeuHYGRPiUYMPFRMZs3
 gf2eSyAVZuQ+32sCM3KWsLbiP1O8r0GfyqR+AyID0fXyWBhKRqOj/KeB1ybFHHXSzJzLJnO
 sv95hCpvxxzYV0jPlRAaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6o1bz3z+h+o=:SSV8EKT7vAJ43Nb0alAscD
 WQ5KoUhkGSrAz1FPXExqq06cM24bCc/R8cx3lRx312zN0WUMBmjArC8aoyEgonkERZpBO7EHL
 nPqIWj/miPP7TUgT3z9YDabBVEfAloiyX6Z0Q2Z7yf7zp2csLN2Ng62VDQ6QNsDQ6Isa8PSCj
 u8sgpPcK3ph3T8NutzUtlHlqBNRAKGxtGclidm/sFotHeO7fkOBHLQTqnDkQq2Ss86GnZyCBd
 x9m+AdLw5cy7h6IUgz3yKXD9FPjgCgGUmirSjKpbktYIEUEnBI2z0NXfK3DBOg14ogE0oE4cQ
 XaAOPG9Z60UYHlc4PyuaXCaH6TxX5oscN1Lc8DqwO95IiVolS85Zwk8kKZ9dbyG20+YJHnw7U
 T6jiTx8JRh+uUvsMZXa/7duyTXQrj0lb76rCt+hysevM3jFn43rKlHcjiGVDfTarCbBAUuYpw
 +Mdj1f1/ertRxzEoIijr72VDJyCAjnRTUR46HFNUNSmfNbr6ZqTj7UvoZvraeuJOtz+Ss0E+v
 JlKKbeCnWr4I+VsWLBoMfCRuYRWNDmbfD2XyGacbSU8MEOqsM87bEy4jAY2tk4CSjEiVFZter
 YuA3rpf1Hs4771+zTvNZlh/SlglwEJhXbFrZ0wJ19RQdWiy68glZSGK7nfTJhYQis8QXHlA0h
 r9PFe3w9zG+JElZDK8q6nOEWuH3gkOPBHZg6J/8z9Q5EcZQiR4IF2zYbfAMObcz8RCE3o+OPr
 QpRdbWOyIaZTAO5KDZsrg6QgDK/9tebFmXYBq+F5CPxSuDrJgJ5z/73WH3JrVBW4qGCAo35Ix
 RyO4Ue1rGj3yo9QbTr1pgdk5glUYLtW+0ShtPopYY9U0jKqbzVpNHNehDHhkVXl39iTNyON
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210723_130344_099681_C05C5440 
X-CRM114-Status: UNSURE (   9.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Another comment is that better to perform CRC check of dhchap_secret and
generation of dhchap_key right where the secret was specified (e.g.,
nvmet_auth_set_host_key() on the target side).

No need to do it every time for every connection and by that increase
authentication latency. As I wrote in the other comment, it might be 128
or more connections established during connecting to a single NVMe-oF
device.

Vlad

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
