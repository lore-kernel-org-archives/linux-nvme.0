Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC15606A329
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jMM4lqtH;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cQS7ljb6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=sB1SE0+x8zWHSF23lZUFMhizy3rFzl0NBN2KJ6cwwgI=; b=jMM4lqtH0bj4AB
	rx+m+T0LBT/IXV0spwul0RgVRWNhMmoJMTQQu1N/YzCeFQMDcs7ltHw5GTCZptXS4q/KjY0yZMY2c
	IeyB73jCAiYzbqOrOu9Cg9K0UbBe+qnBrTdGF2Ljt5ZS9I3YxI2Bzk8lOHREzRZM6Alx2GnJ9/9NE
	75sj9ggBBcGL2T/FXZLzUc2D44nDVWoEcAL7pA7fsW+EM0+zSGHSuegWFnaql7OUIAcI/bUha0458
	A8Aqc3dwVd13x0b9JanoLMFrH/P9vK2nvkY1W23YJfZaR4EsFKj9kYhp0/sjDE7xHk2VtkOH6xH2l
	GZVjxuEf80W83dShYsHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzL0-00000003AiP-03Jm;
	Mon, 16 Nov 2026 16:13:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzKw-00000003Ai1-46L3
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 16:13:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794845621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sB1SE0+x8zWHSF23lZUFMhizy3rFzl0NBN2KJ6cwwgI=;
	b=cQS7ljb6bUvVZlXjlo8lwkxq4U/rK2OdHgWwubZkTYw7fGYPlgNH2EzZO9dr6j+YbO4FIb
	8N4y3yZ6J3wE+FsFs3KqgmcNYckMRqR+uB6m4uieb4/2wlJ9BxMVMvksNSZ0sm4GyQOxhB
	K4ID5sy2mEL/7pRqRreyQ1YPQF6T+z4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-I0nXmlwsPKe_24Y4XRwZfQ-1; Mon, 16 Nov 2026 11:13:39 -0500
X-MC-Unique: I0nXmlwsPKe_24Y4XRwZfQ-1
X-Mimecast-MFC-AGG-ID: I0nXmlwsPKe_24Y4XRwZfQ_1794845618
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-49d8ce126f6so2246660f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794845618; x=1795450418;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sB1SE0+x8zWHSF23lZUFMhizy3rFzl0NBN2KJ6cwwgI=;
        b=oSiyfl+Rb23rAmsNBaEOUEJDJzJ1HHD5mAzGjLgHjkm4Blav31RXaf3vJKHsl0cjGx
         FfeXRhnmQBIdbH+AzdSQmfoJMfrpjwwVFUTfzZyPPQfcn/jz6t408EXgmhWIcjUEbL8z
         tYZ3YY0L4s0kuNCS78pbEiXYS+BZjKMA8c7eBar/cMluQFn7322isW9shzboXzuQOlCL
         QyYengeqML8N3SxZ+hmCOEGSwMT9JAHDHrPJxmxt4Du5B2ERYDEl7Omu5Pq/o0JuB3FE
         v83Kp0+zc/EClgefIbTg4fe1AfSdWdLDcxcc4QIVtzACSakM8eL/pNVBhQSJd+HjuHIL
         Hm8w==
X-Forwarded-Encrypted: i=1; AL+hErGKkBNRHmBNhDcfi23zU4F6av0OosGr/ElowbQli4d0hTv9nxxqVGCXVBAxPu7UEoWrAStFwgY56pUx@lists.infradead.org
X-Gm-Message-State: APuU4Z8HnIVE8owezxY7FY6kJUq0a2arvaggF0wYLnV2QC8BUMdROUVX
	Qit5Q6l9VTTKaIkPEjp1psexOVmUqIz9ftt42/hzB16H0WxGu/abuSD1zkTo5d2CYkeVMS6kNKM
	yxDjXM66ao1NJgsg7XEz3JhNz3YWgG604RgJyyVk0DBzcxnSK0GTopLDG4/qv4znsuaXiXzcUYE
	DXjEXRCuvzWKgbqJiC3dJUODdFrDzUszIVtF5KBXEd/vI=
X-Gm-Gg: AZFdTZdkQaEbOAEVJqaBqJEZzYMoX/hDEQjOgUzvFNIDu2ODDZekOnXW4sfQaYy2vpR
	NTkutl4sZEibp/9m2UB2GY8Lp8SarsSp75vQLn3W72Lsiq2BYHCGkgKuDlO0vOx9SrAsUnozUU7
	7su4VfqG8Od0k5orTPjjRzhpqStt1ZAkf2YLgP6aRnbw+aucPH3VWt41dsLfUzUv/6Szx5Z2Hia
	//3i56U0QmW30ojSw==
X-Received: by 2002:a05:6000:5c7:b0:48d:f996:1814 with SMTP id ffacd0b85a97d-49c7325b40amr21495662f8f.57.1794845618198;
        Mon, 16 Nov 2026 08:13:38 -0800 (PST)
X-Received: by 2002:a05:6000:5c7:b0:48d:f996:1814 with SMTP id
 ffacd0b85a97d-49c7325b40amr21495612f8f.57.1794845617844; Mon, 16 Nov 2026
 08:13:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104173842.2937092-1-jtaubepe@redhat.com> <avWUy2nQQChS7dsu@shinmob>
In-Reply-To: <avWUy2nQQChS7dsu@shinmob>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Mon, 16 Nov 2026 11:13:26 -0500
X-Gm-Features: Aa3M54oatI2uOPy95QX9eiVR4ZGnjUeWcUc7CEQ_hJu_GQvfIawjS5e-k7-pXg8
Message-ID: <CADRr4bdwGdeQsH5Rwhzd0HjRYDuPopK5_6SLi7BKnpg=XOLpbA@mail.gmail.com>
Subject: Re: [blktests] nvme/077: Add ANA log page information leak test
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>, kbusch@kernel.org, kch@nvidia.com, 
	hch@lst.de, sagi@grimberg.me, "Ewan D . Milne" <emilne@redhat.com>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: keT0d0kxmMgpIJnEn1_UfMlv0zQ8YkL3V9n8577T8Bs_1794845618
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_081343_089435_03B82A19 
X-CRM114-Status: GOOD (  21.90  )
X-Spam-Score: -2.8 (--)
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 5:36=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Nov 04, 2026 / 12:38, Jesse Taube wrote:
> > Regression test for reading memory contents beyond valid data when
> > reading ANA log page. The NVMe target must zero-fill the ANA log page
> > response buffer beyond the valid data so that stale kernel memory is
> > not leaked to the host.
> >
> > The helper program (nvme-ana-log), requests the ANA log page,
> > parses the response header to find where valid data ends, and checks
> > that every trailing byte is zero. The check is repeated 64 times becaus=
e
> > leaked data may incidentally be zeroed.
> >
> > Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
> > Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> > ---
> > This test is meant to test:
> > Lore Link: https://lore.kernel.org/linux-nvme/20261104172833.161567-1-e=
milne@redhat.com/
>
> Thank you for the patch. I ran the new test case on the v7.4-rc2 kernel a=
nd
> confirmed it passes. When I reverted the kernel commit 29b8758b470 (" nvm=
et:
> don't return memory contents beyond valid data when reading ANA log page"=
),
> the test case failed. Looks working well.
>
> Overall, this blktests patch looks good. I have three minor comments belo=
w:
>
>  1) src/.gitignore should have "/nvme-ana-log".
>  2) it's the better to note about the kernel commit in the commit log and
>     the test case comment
>  3) I think "--port 0" option of _nvme_connect_subsys call in test() is n=
ot
>     required
>
> Jesee, if you are fine, I will make ammendments based on the comments abo=
ve
> and apply this patch. Or you can respin the patch. Please let me know you=
r
> preference.

Sorry I seem to have missed this. Yes it would be great if you could
make those fixes.
It will be faster than resubmitting and waiting for a review again.

Thanks,
Jesse Taube


