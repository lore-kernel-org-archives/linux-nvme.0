Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207D5C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 18:10:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B670164F96
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 18:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B670164F96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qbyxWZ7iZCDagTJH3hRBxi8AtoiA6zKQ5MR9OK8GjqI=; b=vMz/6kgcu/q2ycCzEy3YPRhiD
	4goiD88BR7o5nyA269zMT6NRhlWQH6j1Cs7Exkti2s+jXlcrrntBaOq7qANFiDIR77W2uEZZMVr7N
	bEQLPuBDuIY6DFQqxl70wA+BTbKj4JOfIeN4tqWYOKJYs1GK6DxayOdLdpDP0lqP6wwUOxqmYstQ7
	2AXRZUZPzRzIMNdhC/gWxCpIJNsUZ8etc/iqeTi6YxemZcAH9gk3G+nvXrnT4yYG53gJ067C8Y0nG
	GUpYaOq8dP39O3fWRG+c04Z7DpWisEj61HuN648e/16eylxm3wx2qu0BFsgrmPrPtfgpli71Ev/RU
	izpje7A1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l707q-0003K0-D0; Tue, 02 Feb 2021 18:10:06 +0000
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l707n-0003J5-Si
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 18:10:04 +0000
Received: by mail-yb1-xb34.google.com with SMTP id i6so14949775ybq.5
 for <linux-nvme@lists.infradead.org>; Tue, 02 Feb 2021 10:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wWQWMpQ1iUqXAuM6iMemQjw0YP2w3Y/0NiHfP2vB73w=;
 b=iJ/dTbF2EfUN5aP/5P9akEpw53P46bf+KKTWPVYy3Cjx87R0uaTD2eMXEi+riPIbRy
 rt5CBWMMe+b8G3QNw8G3mtVBLcXUyw+qZDni7MQqBqJJAZyatmg+W2ATO32+AB/z7RJs
 znFup8ui+7FrskxnUgTRLTE4Q47ZI2fQXHN0hY3qtZ05X/pT5gPr8ZcHpuZQGnz/XK96
 aQBW9y2aSAG6j+yy4YpPI7wMbEJS3S1NIOmiX3oehp5GKfIcIvRlxu0TPROj2xPTQjtO
 Z5xQXz/S9KjOVxHkzDYLnx+AdHHgkaxIH4FalcfwF/v9zcLl7rsyYkhwnd9UtljoGdsk
 OC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wWQWMpQ1iUqXAuM6iMemQjw0YP2w3Y/0NiHfP2vB73w=;
 b=OKfE/lT/X0R3x8ZoSSEC2ZK6BxTjXSDVU8zEVraGJ/wR/K2t2Jqat/EmXtVNk8S8wc
 8BFhgvXtfmOtdkxDT2AlMYrobcGPt7MlbnWZql1NQOihfi14DLZ8Cg3cnMZDYFTo3/pf
 akCkky2QHCiV1OIwZxNc7kuY9zxALCGgUjSn/mclU3+2+rVBPbkfr+gVLaTMzOZGhgIi
 HX/fPMqfOnHjI4Aep8PrDVOri5r1Xo5Xk8xVrxOoeRThCQ99XlWAjDTPAyW0UBIguDwG
 iqbtpkfm7rchaQ5zbC7xJpoduyKwz9NVcDlTtHdHRwppoKPi+mlcZTdOPoJockHcwICb
 6Dxg==
X-Gm-Message-State: AOAM530hGce0NEqlCtLc8G8/DpdsqY1vAeejTMPxrPAfwXtKP9havwjj
 /3cBj8Zgg/cp/ni9cHso+gIAk7NQxSMve9gbBNU=
X-Google-Smtp-Source: ABdhPJzcYBuKOmQdKrYJHwMIJBFsgUdt4Xgpb2L7VEOt4yzfgzVPHSpPjSNyPDdHccYL8mGIYqRfgijbhNb66bBEq6c=
X-Received: by 2002:a25:858e:: with SMTP id x14mr34144460ybk.257.1612289401908; 
 Tue, 02 Feb 2021 10:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-7-borisp@mellanox.com>
 <20210201173719.GB12960@lst.de>
In-Reply-To: <20210201173719.GB12960@lst.de>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Tue, 2 Feb 2021 20:09:50 +0200
Message-ID: <CAJ3xEMgnWKFkN3EOksLeqRMS+Ku-8oxOqwt1COkYwq5i1UYyJg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 06/21] nvme-tcp: Add DDP offload control path
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_131003_999012_2915328B 
X-CRM114-Status: UNSURE (   9.51  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: smalin@marvell.com, David Ahern <dsahern@gmail.com>,
 Boris Pismenny <borisp@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>, linux-nvme@lists.infradead.org, axboe@fb.com,
 Eric Dumazet <edumazet@google.com>, Or Gerlitz <ogerlitz@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 benishay@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
 David Miller <davem@davemloft.net>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 1, 2021 at 7:39 PM Christoph Hellwig <hch@lst.de> wrote:
>> +static
>> +int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>
> Please use the same coding style as the rest of the file, and not some
> weirdo version.

ack

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
