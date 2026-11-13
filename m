Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F48060A261C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qhr47rIe;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R2YlWx8x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=oIdNU+YTvpaI3LmefHUJ7igvr6HXe1LnOHaj9fZpjyY=; b=qhr47rIeZsUFjn
	he36RyFSQu86StVgqnERxdvnXTFSHqs0uG8VYYaSxjvXDyejESATEOkwQwdMovBE/JqWKw06xX7Vm
	J8o+nBbg8AXiWQ6ariFe8XRS+ScX9n/68G86/2kvvPook7s+6CVdMHkckfyoAPzgjZw/+ofyof61N
	C9YIaLkbJN25Kd5WWTJGm5yXVGGKUEEW2+DUTR2bmbPID6Pya4h7BYB2xtf18IEqxy5lah4l0P+CJ
	enD1gmyQVINceXdCjy8GnNAKg+j+ryQCa1dR0KXyO9Cjr8KujxtiVrxdiXhJZpkcuq1g/yOrQ/pV2
	BsdKFxeBiTjL0I/Kfn8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRpXq-0000000CY4Q-0Bwx;
	Fri, 13 Nov 2026 11:34:14 +0000
Received: from mail-yx2-x06.google.com ([2607:f8b0:4864:41::6])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRpXm-0000000CY2T-3k1T
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 11:34:12 +0000
Received: by mail-yx2-x06.google.com with SMTP id 00721157ae682-8b3b57f3634so3786567b3.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 03:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794569649; x=1795174449; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oIdNU+YTvpaI3LmefHUJ7igvr6HXe1LnOHaj9fZpjyY=;
        b=R2YlWx8xZeUmXp8WTQ8vvD3jZtJ7xK1Q5K+nXmNqQ7x/wFgRbpRTs858/rgOuQIlAM
         8bIZ2fsJQW3M6RE4B097XheNSy7XVdQwgGZyt1JDwsXKonDpx8uDrT/ppVPqC4LGiWy0
         qAdzV2otDv+s6PvGtZc+60c7VwA88AV+Icor4uWBStPxi8aAF9c2Gp9d/rjs46PRzhQX
         Byr0XHP6ulHdqWWxwoMkgg/eGWscinnUxisr2pQTY2ezgJikfJFLMRhdacOiBYt2ykLs
         ODEU21kmRJxibdsl606IFWq56Pdn/nRUDDv9lrBaQ7ORa6duhJGpI16BbAL+mDfflh/+
         MIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794569649; x=1795174449;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oIdNU+YTvpaI3LmefHUJ7igvr6HXe1LnOHaj9fZpjyY=;
        b=mqpymWWWuKhRavv3uvaB6f36Z9hZKKvVBfxY3V5w8KpuCbR+2tmwAPGGVuddutPZem
         cWwnlh/UfPQYqJr/KjLIl7Lsz39sUo0oN8cmiR/SzbXsJmjsuPPqs+kxBseBy7NKq9Ke
         kvJapNy0RlnPDgOs/gJMmeQ3yZrlMxEb1MWH7aSZrEY1Wl9O/wwqbfs1UTHEI/w76ixD
         3hgMgv/hIiCLjqRE1x68AbcTpdtcD/OVfTl/GUuC/s9BDYEAaFdn+6XOtcZTEPs2hmho
         EbQM7jLKKc9rgENgkn7HttsSGNDHHrb4cVJNegzXqoce8RAK7WvsNK18sPEF9fJS537O
         fFcg==
X-Forwarded-Encrypted: i=1; AL+hErFrNsoZOVU3NzOpQqn4Bd0oZfd/FjRTjeA9zh1Ky65EJuBHBnyhpxGcFUeHSlkeMujWPBMlTjRK1KBc@lists.infradead.org
X-Gm-Message-State: APuU4Z8sJEToiVE59e0pADpPdPJbCpoNiibI3+rQFZw6L6zCA78eXu0V
	dJevY0x0NZ2SyMF6mBsqrTXL4sm5+guqXbbebMWp7yOgKOY7VI74JJh+EMARVjGP
X-Gm-Gg: AYBFou0ewzv0+0/68fqbInWF8UAShDp0SMCzphw0P+9VoGLh52nZwzm/ZBL1kpBiX2b
	tym+BoqCdrxTA6//fiVXMjQZONNCqi4IhOO8xJURrSWtvBR+vcv9ERb5+aP13vpDby1RnJVJRok
	R+0n2J4RmybQ1ETKCUQ66WvIp3k7r8d+93bIRHAcd+i4Dhx77kmXyXIXoovs6tVa/TpxveUEC3N
	WQ+edMTWyfqP8jMhCIUZWjuApOF2/x/+mhJwD3YZj9TmcOOg/8k9FgcfRLup9MNd1ukHYNvYYCU
	Vaaozah8WxzzBXKGJ7LOb2iAY8tNsJHj9oGSPcxEe3H1cgjr7YUaFrdZOsZyARDAohiS9g0PhVd
	RKM8dz/oh42o7nEo0pclBtRSxXwZzQ9kqxjX9PUC2ZFPzdgzkdrsSrcgXATqnYDnASGWZkdq8LV
	/0vnvUW0B7H9Vwo/pd10IQpVasv6x+pG86ep5HlbaoVKyl6PeWR24q9nd82cBM3wp8hreSh7AHM
	nN/ErUYDld/gyFirOXVOEtmKp2sBl7zByUaNdM6n1BQttRJ6+CvIHDcIBA0xgbiFLdVCejChz8L
	bjGBT3qHESMPW75TRGApy/ZG1YyBH92bbX2N
X-Received: by 2002:a05:690c:e215:20b0:8b3:7782:675f with SMTP id 00721157ae682-8b4aa2a239emr7986187b3.66.1794569649432;
        Fri, 13 Nov 2026 03:34:09 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa9a7db2sm17420907b3.30.2026.11.13.03.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 03:34:08 -0800 (PST)
Message-ID: <bc96a186-5a19-4896-8465-ccd1df5a33bf@gmail.com>
Date: Fri, 13 Nov 2026 06:34:06 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] nvme-tcp: use an aligned buffer for the TLS record
 type
To: David Laight <david.laight.linux@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Martin Belanger <martin.belanger@dell.com>,
 stable@vger.kernel.org
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
 <20261111-nvme-tcp-live-ctrlrec-v2-1-6295202b84de@gmail.com>
 <20261112223707.3bf1e1a6@pumpkin>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <20261112223707.3bf1e1a6@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_033410_970917_06EC39B6 
X-CRM114-Status: GOOD (  17.17  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/12/26 17:37, David Laight wrote:
> Is that right?
> You are changing something that was CMSG_LEN(1) to one of CMSG_SPACE(1).
>
> I've a feeling it would be right if it was a struct, not a union.

I think the union is right. buf[] covers the whole control message:
the header, the data and the padding. CMSG_SPACE(1) already includes
sizeof(struct cmsghdr). The cmsghdr member only gives the buffer its
alignment. With a struct, the header would be counted twice.

On x86_64, CMSG_LEN(1) is 17 and CMSG_SPACE(1) is 24. The union is 24
bytes with 8-byte alignment. put_cmsg() writes CMSG_LEN(1) bytes and
sets cmsg_len to 17, as before. It then advances msg_control by
min(CMSG_SPACE(1), msg_controllen), so CMSG_SPACE() is the size it
expects.

This is the form that cmsg(3) documents, and the kernel already uses
it:

- net/sunrpc/svcsock.c, svc_tcp_recv_cmsg(), and
  net/sunrpc/xprtsock.c, xs_sock_recv_cmsg(): the same union, for
  the same TLS record type
- arch/um/os-Linux/file.c, arch/um/os-Linux/skas/process.c and
  arch/um/kernel/skas/stub.c: the same union for SCM_RIGHTS

The commit message of 1/3 names xs_tls_read_record(). The function
is xs_sock_recv_cmsg(). I will fix it in the next version, if there
is one.

> Did you test it?
> Or even compile it and compare the two object files.

Yes. I tested v2 and v3 with TLS records that carry no application
data, before the ICResp and on a live queue. These records go through
this buffer.

I also compared tcp.o before and after 1/3 (x86_64, gcc 15.2). Before,
cbuf is at %rsp+0x77 in nvme_tcp_recv_icresp() and at %rsp+0x7f in
nvme_tcp_skip_tls_record(). The stack pointer is only 8-byte aligned,
so the struct cmsghdr is not aligned, and put_cmsg() writes cmsg_len
to an unaligned address. After, the buffer is at %rsp+0x80 and the
stack is aligned to 16 bytes. msg_controllen changes from 17 to 24.
The other differences are register allocation and stack layout.

v3 has the same change in 1/3.

Martin

