Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F0CC4361B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 03:39:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9B52184D
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 03:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9B52184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XCl/sxUJfstSELgkBUSkqKnIpmFKRVjeM57/UwuC024=; b=TP4qWfz715ZyN/1FE16kAwD63
	106KXyjXDFq3M6kXzdAZsT2A5X4FnPiR35PU2UZGR0jPdgcupOvFNtiXgGj/Hr1kabfhw47CPyqZg
	pskxnTLXf4HZMsR/x6PPJCOP1+0VsepwG0XeboYiNpUAIrmrCFmEi/Cgx5+Uhbnw6He+OkvfjKwXC
	ItnLVkkPp/e10o6g8pLoCY5bN0dYTRijVy/T+1fNppa1Q7oI2lxb1As3pfElXPj0w8hBQpRpiLO5N
	Fn9v0tRZaUH2+wTJLYRTAyUa2L4Ad4+ZvDB1SB8107BL4osfWXyFyBy2n5J9V8tECabooEvNdNV2N
	Q7PfCIvHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knCnq-0004SH-Vi; Thu, 10 Dec 2020 03:39:39 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knCno-0004RZ-9o
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 03:39:37 +0000
Received: by mail-ot1-x342.google.com with SMTP id d8so3632879otq.6
 for <linux-nvme@lists.infradead.org>; Wed, 09 Dec 2020 19:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lQ9NU7IKIzuslZygyQniKWMKQh+unhXV+76k9m1SeJg=;
 b=n7pOezeuq9Qs+2j2lF1yQhEHTyxFKC6JZxAlMWKE9GJiXSrQZo2cIvwTo4a+pR6Pvv
 tvw2S3Uq+fA1BBX0NI590Y6PGcBZoFSZOHbeb1NweEQ4iJKuLbubH+srXuFSueHXTvn4
 F+yv+3eMd5tF4+PiwDNhM5A2MHKJ5NHTVGhPPqBL39PVW2LXrnG5jW459yclzKatycZM
 8xt1G/YMeB40dJqNOWHp1IByYL0B8v/5M+vDqeUMyf1ZnytHbk5qVrddEvc/tuYzcqHC
 hS01avdLWqTg0ME44437duJbjasmLGdhehjCo/DEugsKbzg3fDiIJ/g+0tJ8iGyBsoo+
 UcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lQ9NU7IKIzuslZygyQniKWMKQh+unhXV+76k9m1SeJg=;
 b=gUx3A24p6jIUdiHcnKGX/ow2JNp88Mciw+ZqjtcbDW2s1HMd2D4JJK9MMpEYNcKq+3
 9S9hmYXuWj1LUt1u5UBYzCvt1ay+bH4hHnd9pP0MyNshb4iWshdBDQlnvWw8Fdr6qKqC
 IWYDuJ3cd9yj9fMIQLCsoqK0de5ECbmzxlZRM3cUCd4AAW/SYVso18pnZbYasM7DCqsc
 GWidEBVe3df59VjeHm6t5bsdWTW8goY/F7AmUKEjPUwK1SD76cYGhCBmBWXDfomrrFLI
 S9FaAOr/suJWezpcQZGeZwruH82sbU1q3EhxfvZa2h/uBb9+vLT4/E65hf+Nji50RJP5
 LREA==
X-Gm-Message-State: AOAM533BytukJbN1GmPQ7aQPlHuIjwItdPV+fWFVkrQ8ojcEVo3FaSAk
 ACwTh7mEKAR4XrVT6SrtVVo=
X-Google-Smtp-Source: ABdhPJxebimeQo9FIKsTb4/qoxFN/i7Q4yZjabT4k1BX6P5eTHFd8QrtNe7n+CXj7RGo9rIE4LfWDQ==
X-Received: by 2002:a9d:6199:: with SMTP id g25mr4422363otk.17.1607571573088; 
 Wed, 09 Dec 2020 19:39:33 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.51])
 by smtp.googlemail.com with ESMTPSA id p28sm589649ota.14.2020.12.09.19.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Dec 2020 19:39:30 -0800 (PST)
Subject: Re: [PATCH v1 net-next 04/15] net/tls: expose get_netdev_for_sock
To: Boris Pismenny <borispismenny@gmail.com>,
 Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org, davem@davemloft.net,
 saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-5-borisp@mellanox.com>
 <f38e30af-f4c0-9adc-259a-5e54214e16b1@gmail.com>
 <104d25c4-d0d3-234d-4d15-8e5d6ef1ce28@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <ae89bba7-2541-e994-41da-fb791ced7aa7@gmail.com>
Date: Wed, 9 Dec 2020 20:39:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <104d25c4-d0d3-234d-4d15-8e5d6ef1ce28@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_223936_473043_079D5AEB 
X-CRM114-Status: GOOD (  12.60  )
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
Cc: yorayz@nvidia.com, boris.pismenny@gmail.com, benishay@nvidia.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/9/20 12:41 AM, Boris Pismenny wrote:
> 
> You are correct, and bond support is currently under review for TLS,
> i.e., search for "TLS TX HW offload for Bond". The same approach that

ok, missed that.

> is applied there is relevant here. More generally, this offload is
> very similar in concept to TLS offload (tls_device).
> 

I disagree with the TLS comparison. As an example, AIUI the TLS offload
works with userspace sockets, and it is a protocol offload.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
