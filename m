Return-Path: <SRS0=OxAA=5E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A261BC4332D
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 04:05:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D092072C
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 04:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ho0mk1vY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D092072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EFHQOoKgpJjnLe9JlKNXhhrRdJSixL43oAe7cFTGlck=; b=ho0mk1vY7h1txu
	ctpsZ1wvaMSbu1h8DdwhxEu6GTKee8Jo+3gcdAtfTUSlqTabktOYFPMm07a7Ce5AjY1StOfSL3rAv
	YQ0wnkrb9DzrWUS9tFTx4yc8sq8X8zd27w/tMYtClxjdbDLGbvzdrvUPVdi6pg8t2NUl0m83xczV7
	FKL5cidWwueSg6CIGHiNnavC1hz8aptz/Icl5agFp04WcPhuIsDi1DHl7wSn+r4vRjwFckpPUNrvB
	PGRvw+amEpA+xfwcspQaO1EnRdIKYh66T+lLoy6t0Ejyex9Aga9507ihk3S6pKls8i+JtDFDBtMAs
	Z/J9wj64Y+z/im5hfe2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEmR9-00057T-Nx; Thu, 19 Mar 2020 04:05:39 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEmR7-000573-8i
 for linux-nvme@lists.infradead.org; Thu, 19 Mar 2020 04:05:38 +0000
Received: by mail-pj1-f66.google.com with SMTP id hg10so420804pjb.1
 for <linux-nvme@lists.infradead.org>; Wed, 18 Mar 2020 21:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=wr6kC4JScFrW2hgAcl7y9c5/eIVPDlJgXz+wP6QicTw=;
 b=AWYJPT0nQgRXIL0Atbuc3FwPccwvEw5Eapar+G/KtQoAeGjqw8F65mgkqKo3wnG7Jc
 sNHUAz9/r8AHhVElSR2pJlc3DKj2Ty7vt21mX8hTK7WKARAMRduNDiiJh6n8IIju7Slb
 IULnzhmiF2pHCsbrErvMe4cWG6zdjmffB25rM+QSHMqlb+w021uXr8ldumuN6e0mIp5A
 ss91fGhR9LFAHSVVp+hTwScnJT0SkbGYfOAF02TEr+TNG+vltCddabobPfzsoRoF5sco
 9/ZGyqxY4/UuoH4ebiNu7/KqQyhgcDFkO5D72A+MLOzOYzpMFVgLac91rgSvjPQsEiPJ
 Mqeg==
X-Gm-Message-State: ANhLgQ3aML42L9al6IFolvy0lVEHiQPVtfmIx5+R0UlAdPfP9o0iG3Fn
 0fpl7kbsrisWwWiHho2YfX4=
X-Google-Smtp-Source: ADFU+vsVGW/k6e5yMCEGH5+krNUDm2bXxjXi2jwCUkuv2I42Bt5pF7ZuCSWbZdqVkbnQ3MDEhqRp0Q==
X-Received: by 2002:a17:90a:8c0f:: with SMTP id
 a15mr1660754pjo.156.1584590736459; 
 Wed, 18 Mar 2020 21:05:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:84b7:c685:175f:6f9b?
 ([2601:647:4000:d7:84b7:c685:175f:6f9b])
 by smtp.gmail.com with ESMTPSA id y131sm498309pfb.78.2020.03.18.21.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 21:05:35 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] nvmet-rdma: add srq pointer to rdma_cmd
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, hch@lst.de, loberman@redhat.com, linux-rdma@vger.kernel.org
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-3-maxg@mellanox.com>
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
Message-ID: <46185d3b-6b17-753d-b3c3-be223ee281a9@acm.org>
Date: Wed, 18 Mar 2020 21:05:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318150257.198402-3-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200318_210537_309572_90EF95F0 
X-CRM114-Status: UNSURE (   9.14  )
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
Cc: rgirase@redhat.com, vladimirk@mellanox.com, leonro@mellanox.com,
 shlomin@mellanox.com, dledford@redhat.com, jgg@mellanox.com, oren@mellanox.com,
 kbusch@kernel.org, idanb@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-03-18 08:02, Max Gurtovoy wrote:
> This is a preparetion patch for the SRQ per completion vector feature.
            ^^^^^^^^^^^
            preparation?

Thanks,

Bart.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
