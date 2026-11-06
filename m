Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A4606D801
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PIJR/v2A;
	dkim=pass (2048-bit key, unprotected) header.d=stellman-greene-com.20260707.gappssmtp.com header.i=@stellman-greene-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ea/ElQIn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8jqpwl4T8NAec+YKpbFVjez9aIN63QELEDMAzpK5tE4=; b=PIJR/v2ArScwd6
	wTFZYVaYmAc3O0jccpU42YPK4MlUEzVw0kAS9dsKNLuV5T97BUx95Cv+qn6ta5jwFUEY8RWW9B1oD
	tqMCLlFdryfhtTSnqEYERXMS9zsKYyg0O04BHV+RR2EZNMkWEFavYGvvwyHg3pGHrRLP9jzaOj6TO
	OSzbxUDc4Zj4kMQY1NiVAW/eZbhvE0WMZDuE8CUk1DCPcTmwNRhn2vIAmwbH4za332+zuLJVKDkGn
	uPCL4DOjOmo9ybcRhfQiX9iFPTR+9TbnF+AqF6KJWeQF6G/A/B9cevcQEQJzY1VZhE9zbvZKgCco0
	N0OTwWhenq1YWP1L+W/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKIb-0000000CTsh-1QnI;
	Fri, 06 Nov 2026 13:48:09 +0000
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKIY-0000000CTsH-2ND2
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 13:48:08 +0000
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-91c76540d0bso6088366d6.0
        for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 05:48:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793972885; cv=none;
        d=google.com; s=arc-20260327;
        b=Pj+lbwVkSyr4x5esasrniu2AT0j0A3fFw1+MnZRAvHzTrS4FJnfF3wb5+BAj/1w/8D
         ZEeuUNklQYXJlqtFkJbndHUc6ub1wT1GT2lwIs3dyO4UiNwGgBWwuvEbELbl05B/Tow5
         J4LbzGOWDbqqivCj66bMyBw6+DJ4KPpwucr7l3DaF+HgEhxjy2CkMrXenVLsehz2OKUo
         Wh5Dc8L3L5OcgveSuOU0y0R4B2as3VcXsYRV7JVD023y7BfVts+YDNa+naDHlkP3Xrd8
         iMm1LcsKpc8kAANMhYTv5VsNVnaHMfxU6nV0iyAoNcU97oMH0VkNfVYxcE9UIX6CTQUd
         phtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8jqpwl4T8NAec+YKpbFVjez9aIN63QELEDMAzpK5tE4=;
        fh=8E2AfNSMGkslzTllI5UKT3XEvUWNDQmmDW5PlsELWwc=;
        b=dwIveD2LSMjO/fdVeWLfC5uZSRiQ46pJd9jydb5371alpP5l5fNRybiY3ymQsAqjJD
         DfnLp3A56fB7OXxIUcRQQfrQ9oIZAgrAa+hEyzxWXigG0Ys0WTXx0qHYqsHdBHM0jiUZ
         hQEKhk5kIFWNzh0G4x4Idkh+FcTksEv++H79UN0UrAQXnj7lRkU76dohlPuI4f3+TG4z
         TsWcDPakimqUEA05bxipM6UJIWziRYkAAZQiuz3o/CSaDergh64RviD7BoCqBkq1uD0G
         nCb5omeBdJpJ5A5NPUjvAQbiaD/ZmOU67BiSBptNxvzp4+DCTzrWQJTNZdccEQFSKtZv
         DRfw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stellman-greene-com.20260707.gappssmtp.com; s=20260707; t=1793972885; x=1794577685; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8jqpwl4T8NAec+YKpbFVjez9aIN63QELEDMAzpK5tE4=;
        b=ea/ElQInRnEHpWqaay+JCDNjOF8Hty14U13re9tQaaPlkaWfG1CxTo3vY7fXDY7k3P
         6ZotcrFArfJbk1K1lfSO3xXIqxAR5B7KDWCl3p27rpEXZXeLVXGpkGUvdSnA3aL84cJn
         9AzLQWtWJMChSShXMkKb5ctZF3BV880abj3qNWQ0Qrnl2MBYd781aG3VICZT7Y5448kb
         kxXHGtLwE1wnE3dYISO+cOX1yewOspf4syAAeuqVy2NBsfO3Qh6c44kXjAX3RWvxQaQZ
         cppD0QHi/TeWpq1rEvThtdlQz4eVmLALknbEHg3BtEw4bHrzaofjr5g4a/xb+xuxhiUv
         4jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793972885; x=1794577685;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8jqpwl4T8NAec+YKpbFVjez9aIN63QELEDMAzpK5tE4=;
        b=N21nfxTO+FdnePCa6rYRi18w/eEf3nM0FyuGPEnpnxahPczz6tSQONFh3dOlqbJm4H
         A8jz1MjR3L/jdasgn68UvvcEyRzaiDCvahLUZc5l7fK7rW9EBBbbE5NEVEx0TmuWecUv
         GYKBrmQK+JwPxH75W1Benv2a/y6bYdxkNQp+upWCpyRI/t2ZriNJ/nzW1rSxV7XK/zTj
         e/rvMszHzselo3FYp14fXxBGTcbPwraFJyAbUdF1K76+KxbEO1ToYHXcqVFdLTR5sWoa
         +AUnhhWj5hK1qyFXfXXuYNBgwotebEt5zl868EUAesHYpAI6f195GJ+tAwSoJoqLs3aG
         Pl0A==
X-Gm-Message-State: APuU4Z8+jw/m1876UzdMziA6EQzLmO8kPwdNe+xZFf6FRbAFk1hH7oZs
	0bdk3EJRYZcmfyFY8CTFa1171d9i5xHQjkCK2Pdo5hmImR1NiSKdudHGunSd++wYZeDw8vh9U61
	7LKkJpDheANjW//jQZcOEDpAhxsy4ojc=
X-Gm-Gg: AYBFou3q4hED3+Ry+ERuNVgJUB2tj6RxDnhR5C8Ehfgdrvjj1NsUOL/UqAHOyMLBP1T
	12OZ3FrBnUoPlLihtlRwgLHA6yXfKsdnWxRf7A1NfuB/xcHZmLhKQxOeRYxInZk3R/dSTvanjlI
	5WeNN/JqUimQVORhbbu+n8ZMjTCR0XW37fDoeBVQjJam4L7PPImvV46ACkIRbzGPL7pIY4/e23k
	lb8vhf+NbVQWEnjxuuGvA5NyHJDBJfoci+PoneTJNqhH2Rm6t/LZ4+pj98DLoTfelRMculeQprT
	BiEFK7LNHgGxx7evmClEzVLjmRfQzpmKfqVvegft9liaRAMR5OSbTRPPOLetL2v9iZo0lm0HyJe
	CM8fmZdrzr82WleDQCIesqIeiFL1YVLCbzkjax7dusUnqaz2Um/KRGHid548gVGx5e0hNdYzMvi
	2Ss0IgBdL3NMDeUr/fyN7rTicKOAz1ddr0xvOeP/wzrMJJc6eqOOlJNBJLZPELJoGBrrCsAb6u3
	3IY1TIp2LJ6h9CC
X-Received: by 2002:a05:6214:2b83:b0:91e:a43b:26cd with SMTP id
 6a1803df08f44-91ea95a3fd1mr33712806d6.16.1793972885126; Fri, 06 Nov 2026
 05:48:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106-nvmet-ana-grpid-1-yuehongwu@cmss.chinamobile.com> <20261106-nvmet-ana-grpid-followup-1-yuehongwu@cmss.chinamobile.com>
In-Reply-To: <20261106-nvmet-ana-grpid-followup-1-yuehongwu@cmss.chinamobile.com>
From: Andrew Stellman <astellman@stellman-greene.com>
Date: Fri, 6 Nov 2026 08:47:54 -0500
X-Gm-Features: AclHuK-hfRPakEFQNMVr9rih3D0VIh32QLrrqCOq2352-Ya5dBeXDTdZ4o2gQfk
Message-ID: <CAChPuV9c4VubdZO461MjVb2xb_Fj2+SYJcDc7wOvStdvYSU1NA@mail.gmail.com>
Subject: Re: [PATCH] nvmet: clamp the last ANA group index against the real
 array size
To: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, 
	Maurizio Lombardi <mlombard@redhat.com>, Mohamed Khalfella <mkhalfella@purestorage.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke <hare@suse.de>, 
	Randy Dunlap <rdunlap@infradead.org>, Aurelien Aptel <aaptel@nvidia.com>, 
	Nilay Shroff <nilay@linux.ibm.com>, Jesse Taube <jtaubepe@redhat.com>, 
	Rongzheng Wang <testwrzwrz@gmail.com>, Kees Cook <kees@kernel.org>, Rosen Penev <rosenp@gmail.com>, 
	Guixin Liu <kanie@linux.alibaba.com>, Qing Zhang <diasyzhang@tencent.com>, 
	Eric Biggers <ebiggers@kernel.org>, Julian Sun <sunjunchao@bytedance.com>, 
	Yu Zhang <yuz08559@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_054806_869022_BC69FDA1 
X-CRM114-Status: GOOD (  21.15  )
X-Spam-Score: -1.6 (-)
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
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks, Yuehong. I=E2=80=99ve sent a v2 of my original that answers Sagi=E2=
=80=99s
question and links to your testing:
https://lore.kernel.org/r/20261106134313.34829-1-astellman@stellman-greene.=
com



On Fri, Nov 6, 2026 at 2:04=E2=80=AFAM Yuehong Wu
<wuyuehong@cmss.chinamobile.com> wrote:
>
> I missed that this was already reported: Andrew posted the same two-line
> change on 2026-09-10
>
>   https://lore.kernel.org/linux-nvme/20260910154849.66095-1-astellman@ste=
llman-greene.com/
>
> and Sagi asked in that thread whether it had been tested.  That patch
> reasons the same way, and it also cites the spec wording for a valid ANA
> group identifier (non-zero and <=3D ANAGRPMAX), which mine should have
> quoted as well.
>
> What I can add is the evidence that was asked for.  On
> 7.3.0-next-20261027, with two kernels built from the same tree that
> differ only in these two lines and no instrumentation, the nvme-loop
> transport shows: a group created as ports/1/ana_groups/128 is
> absent from the ANA log page before the patch (ngrps=3D1) and present
> after it (ngrps=3D2); 128 written to a namespace ana_grpid reads back as =
0
> before the patch and as 128 after it, with the namespace accounted to
> group 128; and removing the group again adds a phantom group 128 (state
> inaccessible, 0 namespaces) to the ANA log page only in the unpatched
> kernel.  The exact steps are in the --- section of my patch.
>
> Andrew's patch is against a September tree and no longer applies, which
> is why I sent a rebased version.  If you would rather take his original,
> I have no objection.
>
>
>

