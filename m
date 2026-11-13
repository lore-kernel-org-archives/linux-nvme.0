Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F042E606A323
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0QCP01F8;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=d5+T04kE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=; b=0QCP01F8B8vOxQQlB0d4Tr5kFZ
	av0xGsfunp+QlpNqQhNldna5zp9zr426DxntDXq7cp3v8hjYgRs9XM4TVHsH/RNpVVJUTU1m/taDq
	HPuiyNW2jAlQK0KYJHQbHMEGknNmhQWI2pDlu2PZSl7YZUrmFcC89l64kgdULQEimJ46r8YewSSNA
	z5DHpyaFeJJxo19zkeDF8ehgesv5rzXYkRyQdS71Q7e/FyZ0wWi8WQr8Eew1l/J6jFJmlJaQlDJOt
	6zHNHr3p3IxrgtLLPjPeq0GFu0yXuNqWAjpCvnK6uokzlYgVqq10ETvErPIMUJkqFg4MCLlY/8qcK
	30rcOkjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3e-0000000EDOp-3HrF;
	Fri, 13 Nov 2026 19:35:34 +0000
Received: from mail-wm2-x0b.google.com ([2a00:1450:4864:31::b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoTq-0000000CMIn-0ArA
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:26:03 +0000
Received: by mail-wm2-x0b.google.com with SMTP id 5b1f17b1804b1-49ff9833fedso1224195e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565560; x=1795170360; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=d5+T04kEDWaAlza6KLJa5Fvu/jvmcmnwe3Fj3UCwa67/HB36aq9VaggUoSTarW5UT+
         1E/u7hyJiej+EGcuYUT9gStAvneetd7ErcWckyChIhlP+RKHmVh7jvd7R4Gb+wyhAYvp
         EdTQf3/KkK44dDXt8x+LOHPm9huIgUxMAMvhIgWMWAR1mOfBIZ8AZl0spWCfOxkTOaQY
         ICd6zQ21VesyHo6r2bwW4i1Brnv9RtmRU1mI1lHUmxd4UPi/V4F3cqxN6uwzOW2U8cow
         RwlaWOC7/fZk6bzvIbXTIvHFZfSGak9OQdggOnubnctopk4tKyDl7MX7zyL0/F1HeMxn
         XK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565560; x=1795170360;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=0X8y4lot5Dx9BoLOE5uC6v1+KZPYH0eLVIpTIyNpwtZ65Rwgs5KjH1XtMSSPJOJ2zk
         2z80JL8kNulG3YW17lkB0BbkRe1lpVZtv+L4ydGZ+C/4NFSHRbbjAzwNYzkwl6uU210I
         STGRjuyD1I0LWCIVUh04N4C5Y3i+PzoDiToMHyloCv01mSuGtWIpvIS2irJ8uYGSMybn
         m2HZ7LV+zqAHmnXsTXDrY+Rz8Kry7aVEXvAOjUkpCihnl1At+yhql80gQorUtZVOKFKz
         Vh8Mx7xgWvAYMF0rKmRXG+zW5tAsx4yXUrXG9dHmTqm2LjdtCHa7SiDrQc9Nwi+5Pyke
         zypg==
X-Forwarded-Encrypted: i=1; AL+hErFWsTiwzbn1FsFBh1MHwMl6D+pf31BrbSWC0EquClyrSHTfQHL/reTeMeZ85gC1m0ng1JGiopIrJdX+@lists.infradead.org
X-Gm-Message-State: APuU4Z/Vm3qO+Y0A51AxZcQG8py5OJFhPNQlIiYHeWxDBQrfTyOU02U9
	0mSKvuSKYjHbBm+r0M1pOmYOm0lnYKpag7AiLeDJA/6SetSfiS8zWkKLTTeH/TDQrzLR
X-Gm-Gg: AYBFou1JsJSYdm+MA5CChhsQ99rLehYhjDZF34jqv7Ohu120v6K8ajcxiVFLN8x29tu
	6sx8D5CLfoctXi4YoPWLMKYb3dEfNOWCzPkylYRoPsxcE4haPzVanrOH6BBBcgRjgOgfVeeHNVa
	2cvMJqzi9eisNgnm+yi/V4zuNnN8YVX0K8YzoZ0oDsGVMnTajG8nZhbhlZHhhVmYZ6xmurXZsVo
	uQ+AoIfHh8byOK9pP5QX7iyAWafWFJJYLiqN7MNIQNJuvjwKu1pHe+HPXmop/9Y4RaKV26SvULB
	N5fxVpD0EjwGUMqpDvKF4h0XchSI104lsBS2C0BTh7s3OBPBwC0vdTutHoXbRnEFAyIAx0zwuyF
	81uB/1c97fPecgqAbOUTz8+NnT9zy0Jmk7lm5zbogoAThA+KLQRSWe9gzxgH7sKwgOHhOG7cPbi
	lfG9ZKQAUMjDbDIhmUGTpaO0+P3qoQknRbL54D0VeJsWtDt4Ntzws/ijqBfKG2Y/B3rq+AC/1w2
	5MfSrbR7SyzbZwGjpG/aHcbvkWyQFPPxrbPMOXKNtFciWXR+9gjz2OxtMu3blhQI+5syWZz8cxW
	grTCrEgU5ZlGp2sDJK/nEZGf8WuonzzAAmBw+JZqRAsQ+Ig/5tFda/zUB2U9Xps=
X-Received: by 2002:a05:600c:4e49:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4bb55aa999dmr38995625e9.33.1794565560090;
        Fri, 13 Nov 2026 02:26:00 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm244439965e9.1.2026.11.13.02.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:25:59 -0800 (PST)
Message-ID: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, Chris Mason
	 <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:25:57 +0100
In-Reply-To: <20261111151202.GA11391@lst.de>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
	 <20261111151202.GA11391@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_022602_110267_66E5A6B8 
X-CRM114-Status: UNSURE (   8.05  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Fri, 13 Nov 2026 11:35:09 -0800
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

Hi Christoph,

On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> I've seen setups where people use fuse to mediate access to sysfs
> sysfs in odd ways.=C2=A0 No idea if that's still around, but if so, this
> patch will break it.


Oh, that's painful. Do they use backing files for that?
It's a relatively new feature in FUSE...

Kind regards,
Alex

