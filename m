Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1200ECA5FBE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 06:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+tOBR8m32zYZZOoraKtqO3ebIcizY6A4dWIJE00zfvo=; b=OzzBhfudZNauHZKb3W9tcK3hSb
	FXSiI74H+9Zs71/8DYCOtZ7RpSo0lbgyJ3R64wAGnnxf7eZhQB9aMry0ubsVslIznU4KUVAJPRmH4
	uVwUBHr5T/WWTLieAtMO/V75T27op0GsPzV6nmQf8mM+eu/oIT9sCAmG9rA3bx4hoLVhFt4OFKqaa
	PhcYrUG9g9sq4Oy76/JN2BaGVPCA9nhBbecu1EDU2e2+43pCNJOo8jFs2KoFAS7XvVfut8H9yE5BJ
	YGSHBzxMRomC4x/875GWBGw9cl/9BMpSK9Kj+P7K41huhd3C4z1X3w1HuD7DIY5vSNS4I+m/E91IY
	XCiL7cVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBnQp-000000055rd-3QvS;
	Wed, 30 Sep 2026 06:04:43 +0000
Received: from mail-ed2-x0f.google.com ([2a00:1450:4864:33::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBY0B-00000003gd4-3iTX
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 13:36:13 +0000
Received: by mail-ed2-x0f.google.com with SMTP id 4fb4d7f45d1cf-6aa1d00daaaso7426892a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2026 06:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790688969; x=1791293769; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+tOBR8m32zYZZOoraKtqO3ebIcizY6A4dWIJE00zfvo=;
        b=KmqR9FB1qmiEsbNaKmpbh+dS524ilwd4o7TUNGzVU+A9CaY2rsw7l05/TetLQ+pB2V
         AdU+QaEK4OXhXM2ktVEXLXNO8nzX0XaeSzvXE4evuB/7wz8HGDaqWf6KXKR5H2ZLUEiU
         7Mts36rYteexg6oCq3nzMKgWLzlsq8/x9aVwUpmt03WhOkf7lx8Jwflh9Gi8z9q966RB
         sAskqeOaMhsFScz1jywh3SE3AD1j7Bwh/2TKfRPK2PEyrigQQhgElzw0rBlEkumrm/D7
         fNxPEHSrcPysFXFa9xMlaJR5veGGrcFrJQQsgCKHT3grzcODRGXNNCE/LWkwJUWhNFrk
         xRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688969; x=1791293769;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+tOBR8m32zYZZOoraKtqO3ebIcizY6A4dWIJE00zfvo=;
        b=Kbefr1gwpKpX3B8r2axY1yiUlSUeMQjvoUPl80A6jWxEIC3rxKmZbEW3BEsinCOLGS
         eq6b9q2BSOdJOSzo3bIn6vdhHWl171PDDPXIcRYC/bi3egxplX9iCEpYc3Owa5gdxN/n
         8ov8j08nstIOMx+zO9qjRmCQXNdslj6OjUdxeYOay03qN2pF9XGHct5nsMHXyGS15keQ
         K49r2vfcLK0uKfxomq9Qc7p4BWAWAafQbnZirJOmzW6Ly9mmxKzGLrbVTWACLVZ61yon
         +8ke+lV6O+I0zd58m2QM2onbth3KwOm3HTme+CcQVVCKxEKVMStC3URnYSeHcfY4OTPR
         1X/A==
X-Forwarded-Encrypted: i=1; AKwUvBxyEwKmwSoOgxFJczb+pgM7GyXra3PLIpivOXWZZ00vk9DpwUng4HoCv5B3vLGeYkQX8Q+5iXL/mjIi@lists.infradead.org
X-Gm-Message-State: AFuF++lUuL97bAnPz2XoOh9dF/3jj5zvqAW/q2QKGQ5mmmlWU44myxOg
	J4b+Dhfx6AyWPBNMajS9oz76GAYOUTy6aBj4Ml1zRiN7TAMvli8KpOG8lx6xy9EINgU=
X-Gm-Gg: AYBFou1y+uA6JUdtF+jhAIgU98j066G+OulU0JDRh/LzH6nKJGUSZQf4eZxV8uLGiKA
	H0rUNGKm81zeTNWMWV3X5KkT1ZRLzaxZwRxVyclGndZb0yWgkoqws/o20eVbCe+P/YWt41CfcuF
	fb2cGKlygB40vKggwhZiCbss0RvPhl01Jmpl8j4ku1a0nA0fEtXFM0rqbXdwL+NvxANdd+gZuhx
	fxYE6HaKcHjA9mGnX+pHy4aQ1JBVO0oPzXQiqmoV+v1tWnNNNDMMLALtHak2hW0qe2RbpYUneUv
	00722jeWoJXzRB5uSnT+TtFG9haXE8w3qIYBQhjQccwNWseYxEVEOW5tiz9qgeTxKPiwHVWoOiO
	7ZjIoMQvDN7lcpkk0HbrDozZ3rCYjnoLq8TQzRJsuMT+0Y/WKebirRO8GG4nbnJ9LBvXMqhSkKj
	U3mBh+g8IJK107shEadtgNmSnEe7Z/GQJXae+yU7yWB2THfmpTFWAr9P5HfpelyIOwaigE537/p
	GgE3dlJsaX6oP2sx/WfsWOhtxczdOJwWkTCOHSLL+Yo8VfbkabfBvREJTWlvT3CjK72Q72HZA==
X-Received: by 2002:a17:906:6a14:b0:c2d:ca78:ea83 with SMTP id a640c23a62f3a-c2dca78ed66mr642618166b.38.1790688968778;
        Tue, 29 Sep 2026 06:36:08 -0700 (PDT)
Received: from [192.168.40.198] (093111099180.atmpu0044.highway.a1.net. [93.111.99.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2df76fad17sm107201466b.60.2026.09.29.06.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 06:36:08 -0700 (PDT)
Message-ID: <3c683f06-4214-4e0c-b568-a2458fba0cd3@linbit.com>
Date: Tue, 29 Sep 2026 15:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 6/9] drbd: use sk_set_nospace()
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, edumazet@google.com,
 netdev@vger.kernel.org, Alexander Aring <aahringo@redhat.com>,
 David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 mptcp@lists.linux.dev, Wen Gu <guwen@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, Allison Henderson <achender@kernel.org>,
 rds-devel@oss.oracle.com, Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
 drbd-dev@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
References: <20260929071743.23624-1-edumazet@kernel.org>
 <20260929071743.23624-7-edumazet@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260929071743.23624-7-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_063611_945016_4504CA99 
X-CRM114-Status: GOOD (  11.03  )
X-Mailman-Approved-At: Tue, 29 Sep 2026 23:04:42 -0700
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

On 9/29/26 09:17, Eric Dumazet wrote:
> Use the new helpers instead of open coding the SOCK_NOSPACE
> manipulation, so that TCP can later maintain a cheaper private
> copy of this bit.
> 
> No functional change intended.
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>   drivers/block/drbd/drbd_worker.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

