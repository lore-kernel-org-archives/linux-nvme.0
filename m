Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482C606A32E
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=o4F4OLIQ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GoHXQE9m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=; b=o4F4OLIQn8p3KZEWp1pqFLHSD2
	RkHeqZwdmq4TSBQeU3cETOZCw1Nq2TUIBR0qt/E08Vna3/cuAUvfcq1spIbCtzp6Et+uDbNheuhUz
	rnwqYH6hVTLX9tt99ovxFelOwgbTs/7qCaN4dfZZcOS2kVZwaOpr6XXH0Amd0hjs7GJCVra7++zPV
	bpfCj6Qam3gogYbArVw1y/3M5mbfVggyKjGTwzl/NRQNjygWa3mi2M7j/CqH+pCDzJWS48m+0OfQk
	fjqkI5wHvoPJGQHz6S169CjVK4Al41wVecPmgoAuzqf+xZ6UN+9B2FPL4DUPsqaa2CQh4OgfFP8Am
	y/2TCpCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFG-0000000GBDL-1z38;
	Sat, 14 Nov 2026 13:56:42 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSCM7-0000000FvrD-1Wgp
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 11:55:40 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-c50604721c8so370135066b.3
        for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794657337; x=1795262137; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=GoHXQE9mAtg+MMOMsMqZD1C/OwhuTFn1QAhSTkG1p9437iukRp4ad0J7iNERbrMvtL
         KVFy70zMMTGVHiacvcEX4+JjC/01CJokxq9anO83YqWaOCjQUaTYSLi1/dtTrcaW6F5P
         bdKwfJLFrIrEc1SGCI/h4HhgMDDnxa2K01+WrXCjWHXRolofmz8OxdEpKkHvnnNOLw1S
         JIy5eSoKagGt/WuLBdiWQSzTVX62ofzj3Pvqhv+HUpOBdXRKAaF991Lq3uIy54ag5nru
         xEhk7Brhu4GBOCDVvw0K5V7URcBYcEKSiB/8D3+oZJ4Bpzfesu5NlzAmLk0Nnay3Ty2N
         W9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794657337; x=1795262137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=2G0zRd71lKA57fOOtpgrnOrPoT0Y4sWz6XUTh+peFCwn/Cqkpt43bFY6Adc7Yb+i9P
         ggqXF70+pCAmId9nDndtM3EO+KBCQFS871okzVArFuAbJVWSrn225BFv35sfOrgMUiIY
         naMG19yMnTojOKKn2bqMVnpyP1inLf/Uz7JzA6I8oWC5owEX/EcRgXLw9ioc4YP/bXFP
         vv52Z8LaUmGy0fh9lCONLAyD/kSASCyVl7edkWVUb+rB+3ZXuDh+ummcFKJRLZf12CoC
         je0K/8R6pr/hNRdfCzYdz3tND9U58yxFkZVUsgVrUh2h4ARGgT5SyzvYloh9KnQGaZQK
         eKSQ==
X-Forwarded-Encrypted: i=1; AL+hErHv19vt/n+4NJxIVFNOx0fgOht9aZ8rZ7vVyuxcmdlToWaNtq2bogumycW4BQdEdNA//FGo8UAIT+/Z@lists.infradead.org
X-Gm-Message-State: APuU4Z8FDvQ1VqrkE6BnPw3gYJbhIDeqbASQyXQCsewtyH4Nl+pbYs0Q
	N59uzV6boCERAeFxDw6mVpl/uUTsUMqo2QMYU2+D5rS89vpfJy1npAqU
X-Gm-Gg: AYBFou2x753eu/sAVIZ5p8CieflZRDr7wqAV1Ll8YHLXavYjvhBWW+7x5iuL4ieghJl
	hXqrfawEbKc6NxkxJnO1K4dDd9y1IrWA/omZ0BDYHb/f2zvzLCcgF2aqgaZql2OqQ6Wt+thhFb7
	D8BLqZl4iZPRIieMQSN6FN0yGXWwCsxDHbxIx8c5ARyo0xlPBhbX+7Cla297EBLouJieE7RYUYQ
	2sRcZaRp3VXSzeEp79LKCk3Nb1tYf34CoiXOW7lmD4Yerb74daPSeDo3A5rlOZgV9v8Dr9oGpB7
	TDDV4SOHN1VQjYmWC/LI2Tek982FAfZ1f+wsK1EXEb7UYHb/axdbxdGBE7qkUJtdnp96z/0usMz
	LHRczadlB4x7L4aY5ADqnowDXMuWJTtQ1ZqWTGwABN+QxjyRsYgG3/BftZEmYTbA9nyr+adDBgA
	syAcry0twqGQZhoYi8UbkYEW/foCbxqF1apz25RJgcsZpjew1auq7eDAjwtcT989dogWngwf26K
	KzX/zLqgDkeesuBGt3D1VUoZDgpkhRneG2i5LUjkoYZs0y7fL2rovfArOSlZSiz8Q3hweb+Horw
	tk3REiqF3LPyIxw5WLoZKnuiLx41iNc3a91fo311t0gkiCg9oT4uwVKHKaoPOg3ovhpWrawSMhB
	pcUxvWQfNRx4=
X-Received: by 2002:a17:907:3e10:b0:c40:231:6eab with SMTP id a640c23a62f3a-c5096370c31mr441592966b.16.1794657336589;
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b41f44sm206223866b.31.2026.11.14.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Date: Sat, 14 Nov 2026 12:55:35 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Alexander Mikhalitsyn <alex@amutable.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Message-ID: <avhMN39TECaur0sS@amir-ThinkPad-T480>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
 <20261111151202.GA11391@lst.de>
 <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_035539_424090_DB243CD1 
X-CRM114-Status: GOOD (  15.07  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Sat, 14 Nov 2026 05:56:41 -0800
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 11:25:57AM +0100, Alexander Mikhalitsyn wrote:
> Hi Christoph,
> 
> On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> > I've seen setups where people use fuse to mediate access to sysfs
> > sysfs in odd ways.  No idea if that's still around, but if so, this
> > patch will break it.
> 
> 
> Oh, that's painful. Do they use backing files for that?
> It's a relatively new feature in FUSE...
> 

Very unlikely that they use FUSE passthrough and if they did
very unlikely that it would break their filesystem.

The API for fuse passthrough is that the server requests to setup a
backing file before open via ioctl and if ioctl fails (as this patch
does) then server falls back to non-passthrough open.

The ioctl can already fail for many reasons such as MAX_STACK_DEPTH on
procfs as the commit message says, so server needs to cope with the
fall back.

Thanks,
Amir.

