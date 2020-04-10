Return-Path: <SRS0=viL0=52=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A26C2BA19
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 02:34:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117AC2051A
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 02:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GH2mNi2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117AC2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=SksF0BqfSvqD/A1E3LvmUYMj/+g3McH4Kqkt+DW/Y5Q=; b=GH2mNi2U4XNIfkYj+gp7gZ4caS
	xXQXJ65HmbdZJlvvAQNfO/tdh5+yklJFc6MdeHD3kHZVmF8CIwlMD2PKn9QTyrOKzFP0jrjZGslZe
	6zdYLE/ZSvo7nPlLIjpWu+k+sRWHTGGbTHp3EavcTx1pBDZfAlnbsoguWnvQ+AIDA74nmOdHCI6Ec
	RVOrHz6R8ROeLsEaEIwOVrdJtvifF2Sr0Df4muG50xeZtwCEtQZp9IMdu/P+qKuohC41ndLyAu7Lz
	PEA4CHIXm8Dm0PkuFiiCnw56H/Xw8r0+e0RHElSvvD9lOJ0xdEaFvAXyvzPpGTYCGGU9AZSd032LP
	d8X6A/eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMjUk-00081d-Fr; Fri, 10 Apr 2020 02:34:14 +0000
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMjUi-00081G-Ab
 for linux-nvme@lists.infradead.org; Fri, 10 Apr 2020 02:34:13 +0000
Received: by mail-pl1-f172.google.com with SMTP id x2so205765plv.13
 for <linux-nvme@lists.infradead.org>; Thu, 09 Apr 2020 19:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kzzA048HbuXUZ5HM2Cqnu7MIzdCoY7QXpmNm/9gpeSc=;
 b=P3GrK2QyHCMzHGnI9VdNCK3KB6sgtSJe1F58PwvB84Ys4rt4+vmvrWxDBlUnfr5Mfc
 CX5lB6dKggp0/KVkNgD4cBuCLuZCgFjlsYAN5SQVi/rGhMnfJxg2P4ujJ+YOhtQwYlm0
 Ct/wtsOwvHwz+Sr3QtzNRQGZAq/sovfhgh9YznwDoXlhX7kuM+EQzqC9C8vwkKiJ03w3
 nZp/1WO/pUtAXvluovxMyWAD7l5UctoQ37HDcrcjaX+pAFLyoNC9c6R72Vvbqi8G/TCi
 CwxJEu35BoEYU/XYN33Sc03kRpF4h3Lihi2OHMAuBiksNSWcVuCRQcBuDW9JYFuI/b3a
 TowA==
X-Gm-Message-State: AGi0PuZDUzUu/38XmgIffGfki8aPKIR7IUtTXTdEAoqRD8ogWpvt9Rpr
 +zRTfpw0lzjL421bulIq7e0=
X-Google-Smtp-Source: APiQypKSIfNeHQg0kN1C8Gy24SsU2ZOKzvxwIssVrTlaPtnXtGf529GQ0CzLvnvOPzV0nmZfrtAuEw==
X-Received: by 2002:a17:90a:c790:: with SMTP id
 gn16mr2845876pjb.146.1586486049745; 
 Thu, 09 Apr 2020 19:34:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:ed4e:1b14:7fc4:cd73?
 ([2601:647:4000:d7:ed4e:1b14:7fc4:cd73])
 by smtp.gmail.com with ESMTPSA id i187sm431579pfg.33.2020.04.09.19.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2020 19:34:08 -0700 (PDT)
Subject: Re: [PATCHv2] nvme: define constants for identification values
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
References: <20200403175346.1571822-1-kbusch@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <bdb66a0e-bceb-51f4-c86f-d6861562bf6a@acm.org>
Date: Thu, 9 Apr 2020 19:34:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403175346.1571822-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200409_193412_366134_039B9B18 
X-CRM114-Status: GOOD (  10.03  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-04-03 10:53, Keith Busch wrote:
> -		if ((id->cmic & (1 << 1)) ||
> +		if ((id->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
>  		    (ctrl->opts && ctrl->opts->discovery_nqn))
>  			continue;

If this patch is reposted, please remove the parentheses that are
superfluous from the above expression. Anyway:

Reviewed-by: Bart van Assche <bvanassche@acm.org>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
