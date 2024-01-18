Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5321C4707B
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bI5N5Csn7/u+JJ8YQL76BcCdfTHy4VofE9xRDwwJyx8=; b=uDSgLpx3exZFmXqtbg61IsmEx8
	qOxxyH0Jz0DbBzz68GUcizDZVJGIR1JfofgM3woEzbl1J63n8CWtywDE/BJURICkH141EiIit/w7F
	xFn+j/QdzO1w1OMQBAq12nGdq4MiD+GaOmEwp5NAVVZOkgixO9wsJ57SdlawaHVn2gQwq6XiISUW1
	/fh2r8I55wvdfEVM4bXoV24Ln5s8CyuE5jSLz0Zx0MW0jyy8gpjVP/D3i4Mdx7WVRv2KykVN+uzgA
	LxzlHpuVIuX/YWrT7v8GLnTmEUlaAMLa/DjuvaduZnWPkvI9CQf22KJdB7m43S9HPHDdUYebr+rfy
	2iObvcOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQSKl-002qEz-2o;
	Thu, 18 Jan 2024 13:21:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQSKj-002qEY-1M
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 13:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705584082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bI5N5Csn7/u+JJ8YQL76BcCdfTHy4VofE9xRDwwJyx8=;
	b=Yy7BeDX0J37qlEdncLrBOwxYKUPgVYytKC3A6XRrpK9pMtql+W3Puef+gS2b4xvZGXZkJq
	fGmv3hpQ8m/yEqOe/fCiVsKA6xYoZzTWNyMzrccCnX+NCZ8j23hR9Tj6KtyQng65NPbY3l
	vkc0M+KXwjWUKwrucbVDPetrCVMIac0=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-2Lg0kXfnNlmRJH7VvVaMnQ-1; Thu, 18 Jan 2024 08:21:15 -0500
X-MC-Unique: 2Lg0kXfnNlmRJH7VvVaMnQ-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7d0aca89b4bso1507498241.1
        for <linux-nvme@lists.infradead.org>; Thu, 18 Jan 2024 05:21:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705584075; x=1706188875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI5N5Csn7/u+JJ8YQL76BcCdfTHy4VofE9xRDwwJyx8=;
        b=o6a3IzJEaf0TVp6r7JPqqMJEHfadMh20ZVnFx/w1muW7mE7BYKSJmGdAw03QPrQnJn
         72iNdt0aUCPlNSPLzTJA9kPjbcNAUyWHAY69OxmUPi2ntwaeiiMlGJhOYjftntEqbG7e
         Hn+AOZ+JVODAuhp6mhKe1eiSiAqVHXQ65P0lY6mtaRG2uy+0ql+fJt86ooiXanCh/oBW
         ErGFnwMhsGQm97MaM4Gnjy3syxSIl0gTycD2wS83fPs/XiVxS6j9Q3RXSzEcrg5pDYP6
         ex8fy9FMVQpO9eyc+wPy6B+o46CqghJWekABKrBr0d8qpDuEsvXQIgmqhSXtdkJKEnxR
         2N7A==
X-Gm-Message-State: AOJu0YyB5BJwo4nFYpKuWk6emyKrYrNFd59T9dTgP7UsvsM8V9jh9nXR
	VFDTEYxl4j/6+gTNrES7+0bjthQsp0etiOU+pi1YYcTywtakXuKzIXpFfqhALpM3gnhDdiJAQJ6
	RDsXFiU5CLqveB/RJPGDTX4BweMQraog5+abdcT74+LwHtUmutckwQf92UPiLmROIInSrk6Yqc2
	c5CiVmw2q/82ZI87HQaRcHD88PtIpZ1sVScsCL4JU=
X-Received: by 2002:a05:6122:3c55:b0:4b6:e71d:362d with SMTP id fv21-20020a0561223c5500b004b6e71d362dmr692410vkb.18.1705584075213;
        Thu, 18 Jan 2024 05:21:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyK3jac46qTFNy3gIvvGNWsZ97krzietq6jYfZ8JGXvgSEyYc8lagKXQjBbKNWVHwyPosnM5HLuuQlRXOsGSk=
X-Received: by 2002:a05:6122:3c55:b0:4b6:e71d:362d with SMTP id
 fv21-20020a0561223c5500b004b6e71d362dmr692403vkb.18.1705584074990; Thu, 18
 Jan 2024 05:21:14 -0800 (PST)
MIME-Version: 1.0
References: <20240118114854.672748-1-mlombard@redhat.com> <3urnhr2hdyn67zbw5a43cscnumbd3h3a2cd63n3ofaslwec2yv@yg3dpb22s2pb>
In-Reply-To: <3urnhr2hdyn67zbw5a43cscnumbd3h3a2cd63n3ofaslwec2yv@yg3dpb22s2pb>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Thu, 18 Jan 2024 14:21:03 +0100
Message-ID: <CAFL455kjiM9=ifcJOLAoKWzTHhuJkWrhPH8n+Me4fFxUAEmF-A@mail.gmail.com>
Subject: Re: [PATCH] nvme-host: fix the updating of the firmware version
To: Daniel Wagner <dwagner@suse.de>
Cc: kbusch@kernel.org, hch@lst.de, Niklas.Cassel@wdc.com, 
	chaitanyak@nvidia.com, linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240118_052125_549514_BD6F1206 
X-CRM114-Status: GOOD (  13.93  )
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

=C4=8Dt 18. 1. 2024 v 13:31 odes=C3=ADlatel Daniel Wagner <dwagner@suse.de>=
 napsal:
>
> Is this not an undefined behavior if it is not in the spec? Just
> saying this is not so clear to me.
>

I don't think it is relevant in this case.
The spec just says that bits 2:0 are the active firmware slot and
bits 6:4 are the next firmware slot, it doesn't say that
they must have different values.

What the spec leaves undefined is what does it mean a "current fw slot"
with value zero, which is invalid.

By the way, I submitted this patch because we have a customer that complain=
ed
that after a firmware update he noticed a discrepancy between the fw
version reported
by the kernel and the one reported by nvme-cli.
He says that this patch fixed the error.

Maurizio


