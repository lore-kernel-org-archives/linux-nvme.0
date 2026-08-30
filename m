Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DD3C61DE8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 21:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tMYlAlO9oI3tMcI/rKIDs9rqZu40VTOxuXGX+UjB6hg=; b=MFygSeUU0mcAXQ8sf2Vko5yXoi
	nZFlvn76za7OvBxB9UEDk72iW5Dli2vmwL4vzoXTlWto12SsXZkhiCbYpwzO4D5rdR/LzAtfpFB20
	1gh56NHRxrvRRQjF+Lw9aPaoKdwkXusXH5lVelful7V0288paTqyWZRpEbaggR1mBY7rVj5+7FrEi
	9OnZ8BfR1pOi2Afhs7w0vb9bVfM6ZeLlJucQSJNCGB6eHggVDWOMJtfwurqfoM81knisd9gdT8rU4
	sjfkWnQYhsNo71UbqsalEHxmhilIGinqs8+JuOZqV0/PMmBpmAq0CrW46hKZoA9MSw0C00el30DTo
	/a/p3dyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0nJ3-000000088hv-3HaS;
	Sun, 30 Aug 2026 21:43:13 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0nJ1-000000088hY-0ubx
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 21:43:12 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso23577375e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 14:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788126189; x=1788730989;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tMYlAlO9oI3tMcI/rKIDs9rqZu40VTOxuXGX+UjB6hg=;
        b=SqBcHPGBNtBPo7r3hwz0oMVYFRaF0NKKelsCCFH2CkgirHGwqd2jd3fz0zNw4q/o9Y
         aioydxVV1OveUepo26uLFIuhm8VAW+VxQEUtNgFivF7xynWodMXcDXfW3jivAs+G3rbm
         wOx/FXpUyR7kFDRPCfz6v+Luc0KLqE+9oo5Ux1EP4PqJeJEjFNOW3Ep2TrqbEbgeBmij
         Gvv/+WpcA/y1bNetLvpXezeA5tN1PLJDUDY3X+94nq8qc7/DOV1ssWDLj9ZPyfM2XMVU
         71cPmj5dnKKz3HTBj5JWui1Gu9TsAj9t1KxxB8Gx6LXrVdK08lzKeTTgdpq1I5VX3XhJ
         MGDg==
X-Forwarded-Encrypted: i=1; AHgh+RqeEdmFHMwufNBBL9Rzr8PWDTGke5GZ0QYP1754QQlQtsQmZBKE0ffrrCTsKjzPPxh7AeXIODZQBd83@lists.infradead.org
X-Gm-Message-State: AFuF++lG7qSN9fGsCqn4m6DGxJiFUDQg8uDstEkf+zoA5nerP3h60TpZ
	XiRdCLgM2ils+d3nBzU+I35BxbdXQnYmnm67cffmc1tWeYMpDWUUNbR6
X-Gm-Gg: AR+sD10ZaaU/hL7N6T0zwFffMtptIUFiPLY0Gd+6K7epTwJer0N9zM2gaMY1SGUbD60
	rgawxFE7ggK20IMFnt2pG4FqRpo0+rUp5/jio2oF1BSlmACGU7PLUCpCvLS1R92tmF+6/oK0sVG
	vNaIhJxfB6OJ0S6ZXL8t87719LgGFi7T2Jh4YckSygftahv+5b0lYCpSnB7fWJ26Rw8Zrb/gADE
	yMNm87D3frX7d3g/Xk7DOwgFJ53Box+X8na8JhcuGN3wUxoLvXieeXkV286MLMo0o8nQgQh5Sv8
	UqfcuVxKn5w2dpzMx/womlozaYtvI4KyW3SMqjtGIg51bHT54VqvuIOV2glXC7tdCbdYcDXgA5n
	RgNZ5aiC/nL1FhneyxGuw3vyRRKl/ozQJmYBCdICgcRbFCSBgVxqKXGU2fPBoIWpTT0xyy6AK7U
	+aaonXfSblFUzJ78GnwVIPdrDqbP3TYqHCZcATNwT2Xfyq0HFCkLyBPw4RGnnt0/EoIcDDgwH10
	BWTjYMfnunB04PRfVCqNg==
X-Received: by 2002:a05:600c:5491:b0:49b:4eb6:6ffd with SMTP id 5b1f17b1804b1-49cd53987cfmr56996385e9.5.1788126189256;
        Sun, 30 Aug 2026 14:43:09 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9500c80asm273192935e9.9.2026.08.30.14.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 14:43:07 -0700 (PDT)
Message-ID: <9ded840a-d7c0-408d-a3a4-2729e26e15e9@grimberg.me>
Date: Mon, 31 Aug 2026 00:43:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvme-tcp: fix wrong status on deferred digest
 error
To: Xixin Liu <liuxixin@kylinos.cn>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, hare@suse.de,
 dwagner@suse.de, linux-kernel@vger.kernel.org
References: <cover.nvme-tcp-req-status.v1.git.liuxixin@kylinos.cn>
 <cover.nvme-tcp-req-status.v2.git.liuxixin@kylinos.cn>
 <1.nvme-tcp-req-status.v2.git.liuxixin@kylinos.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1.nvme-tcp-req-status.v2.git.liuxixin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_144311_263484_DD7EDF40 
X-CRM114-Status: UNSURE (   7.07  )
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



On 27/08/2026 4:05, Xixin Liu wrote:
> A C2HData digest error stores a host status code in req->status. Without
> DATA_SUCCESS completion goes through the rsp path, which passed that host
> value straight into complete as CQE Status wire encoding.
>
> On the rsp path, shift left when a deferred host error is stored,
> otherwise use cqe->status.

Why not just assign with a shifted status?
We already do this in nvme_tcp_end_request()

