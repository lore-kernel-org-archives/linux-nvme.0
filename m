Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C1B606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JNu6enCi;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jkYKV7Yy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=s/sHb0858UNP+iY2wJget1jQLLSF+C1bNh7eAlZHc6g=; b=JNu6enCiEZ+GkrWOBPydBQNX6J
	DDuJ59RWUUnwOJkGb6IJCq05X+fiMOABDkxFe0b9lcFI/EBUXhXQt7Xhaa/d9ed94ULGq5IyrFjfb
	fDENPIOsPMGsTwE0kT26QUECX+wXFJT76yDBCDcgx/8uZ3amtPigsHuHk+HG70rsaHDN2w4eOUQvT
	oB87g3tgK7QCt53nN56QxV35KCZIOqWg8gwq433sI+gOcg9+4VdOwxJQzTTgc3a5tDeynE8QRQ+sH
	Y3rCMUcSOXf0BkQGpli0kC3ndykEkVsDEDy6aip5qdNJCg9Gs6700q6RJ0pMJvBECPIGNVwG9MUrr
	S+GSb4UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5ZJ-00000007NBp-2SUP;
	Wed, 28 Oct 2026 15:28:01 +0000
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5ZG-00000007NBI-0LHj
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:27:59 +0000
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-705cb6ceebaso743618eaf.3
        for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2026 08:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201276; cv=none;
        d=google.com; s=arc-20260327;
        b=LXaiNBgT+V25bPXnk+jdhQcO0Si/dv8NzvTmDLv56VzWQyhtJwSVo/90KJjsgNiU9E
         Jd1leAhLPuyuisdUQBzyaxTZ1N68dfAVIBQJ4RRKb6JDIrrKFQgjicO6x4lXImr2z8rD
         DQ7VJ9n9gdYKnqHf1nT9mnnhNWCjWQ8dkqFwPfv9c+uG/H1uk5BX6Pnu+N75Xx1eiX88
         AV1A3xpQTh5T+DUTj3Yh41uc56ldim31MV8SfCcTQsHokUCGy4AiRq6nSrZ28iZw8ACu
         ssBOZYlRKvg5G/+Ce6LfCHk2yRMNIsY/TXuEs2fcUKiE14S2ceAwMtGfXv4rc1yp+lWH
         l9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=s/sHb0858UNP+iY2wJget1jQLLSF+C1bNh7eAlZHc6g=;
        fh=kYijGUaS87jCOuWCanqhZEQN2HDIKtuVBIX0F26RBeM=;
        b=PqUYbLg4H+LZtzOPO8W469RrfWVrWhagbstF474SeSJbSeSK0C1KQHjaMdx7sI/7Zi
         Huem105LUaInuIRN9kfeRepvdhm6b74b8o2+GTstJYhlQumiNIR0cgj0Uu0+8oL34VRR
         0ylFhV9VzGL8vY4nKiqeCmfWCe8VpAe5YkpygfBCsW61Vz/KkX/RiXBHiNW8/bRoZGKE
         s32Gh9clRGz1C3+rodX9AQUqtAupoU0zDEBBda5FT+oZriLqvWnCXWWgSuDWvlY3KGln
         2LFWNsmUc5337XBNi3JaaNldE4Ox+QAe/ImpcNGGdH3XSG7t/diurpGn3ieNfM1JlBDh
         v66Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793201276; x=1793806076; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/sHb0858UNP+iY2wJget1jQLLSF+C1bNh7eAlZHc6g=;
        b=jkYKV7YyvGd8Cj5Z7EZ6evafG5U0PpLS1+bqd6J+xBz7GWhMT/iVC2cbhuQF7o+uVd
         GLtmcPe9hOQpFKEMjTceRn9mreuLUfDb11hozsF+szMRg1aBVMXPhib288ubmSJzvNhC
         +YobKqWw8pL6UZ8fy/qB8b5o3TW4t+0oQlXLfWw6n+E0n9k9501/xeLKb37pNL2rejlJ
         c6voR6CUrU15lnE8is4YMpjZB8DMX+JDnf1KLT11m/sD614EQviJy3wP7x+YCXo2oOnZ
         xmNaFOxLcd9zimphH5KVtB+quBKqDvAR5KmwdD8iLv5jzUJTvvPQyeiVuEb8XHhxrhUe
         D74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201276; x=1793806076;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s/sHb0858UNP+iY2wJget1jQLLSF+C1bNh7eAlZHc6g=;
        b=LYa/rZfpxztaWywFKsbPDeAPMeRf9HlFf//SyrCMjmwFPrnbnylpnKxLSTYKZDIwzI
         4QsxL8uaG0Qv+bbHEnN6jciFqIjM1ocvoMWQ6lSA35nMGccGoT6soYFDnzwEoClGs/ki
         aLbHy26mVU0TBJRrCeODkMnp3wyXLJxGpQDMmSyNUIiu11KuQmhq2T6L/To2vPEXJSBb
         WmlVqCXvMaYfCpYhlElF+/2rMVxGYMawnI/1IDfG+lAmoGd1xRge2xDJNSNeS6gMAUSS
         Z9aMd/AdToSyxOglI6nTxKE5jTo+OtiU2Il1tALPgW7/3dWw/x6TjTRoanAlnbqD00Xo
         dfgg==
X-Forwarded-Encrypted: i=1; AKwUvBwv/SpXZzkQbjT38I1UY2Sf90FLc9bKY23Ce5O4J8KgE2B/pDXj5Oy6UgW2/KpS7KAI/QNdwMv2JAL7@lists.infradead.org
X-Gm-Message-State: AFq9FYIEgoKjn/EmgzmP0D7wnql0kYz82SbtVRN+cjtj+Dnv0Cw+f4bF
	O67zNW70zW405gsQpTy0utjFnInkE5W8YfYAbrLSSlsZKTk1rCXq6VpTpR+rxkDtHkrkYu0NbFx
	zMcQdOtRr9G5LEZXYL8JXJlw3LEx6J6o=
X-Gm-Gg: AYBFou3UcXM2FMhMn75U5pB179wjjbrTgtlhrSxxdysa7dc6yLIYQHsw3Rxg0SjqnCY
	amxj6JGIPzL0KsNYr3IEWfSTVcA86vaEESTKT9JrkA6hdV544C18qfTnZmEkFqFdUZLZleMiyAm
	4q4Sc/3vNr6V1RtMLgppY5dOCU6uIkFF8nyh+OvVs6phUSvH+9cd1yl6LgGvZcVBwk0TssS7n8Z
	KkevOjU5n4x7JrJmTJXY1OP35Z7ecy2n7+DzpbTx181E+6MdO2IQ+UW1wbVQzlBTijpg41zMKQE
	i9a9zt4w1X5/tLkC5XleU9br4c9tNAEgEdNVEbF5swENGwZUJyPQ8vnW1b5okvcwstGejJBsFq5
	EBOHYOPM1flii5ybYEM8z75kyhfi6Bx/C1eN/NQ==
X-Received: by 2002:a05:6820:611:b0:70b:8148:94f with SMTP id
 006d021491bc7-714dbac03cbmr369234eaf.76.1793201276554; Wed, 28 Oct 2026
 08:27:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022071934.3818224-1-thnkslprpt@gmail.com> <20261028145743.GB15112@lst.de>
In-Reply-To: <20261028145743.GB15112@lst.de>
From: Avi Weiss <thnkslprpt@gmail.com>
Date: Wed, 28 Oct 2026 17:27:44 +0200
X-Gm-Features: AclHuK-Y3fPbla7R5RhrOUkIubvApAlKdbSBQqTlOTshG_FiHQOgm4YAd0KjML8
Message-ID: <CAKOB7-a3r_YBz+i2zyRvu+3GvzeOpvZtHY0r0Fzs5O3mKj25EQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: wait for in-flight TLS handshake callback
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_082758_144724_86B257B1 
X-CRM114-Status: GOOD (  14.91  )
X-Spam-Score: 0.4 (/)
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
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

It seems relatively independent (and pre-existing) no?
I could address it but I think it's also fine as a separate (future) patch.
Just let me know.
Cheers,
Avi

On Wed, 28 Oct 2026 at 16:57, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Oct 22, 2026 at 10:19:34AM +0300, Avi Weiss wrote:
> > When nvme_tcp_start_tls() times out or is interrupted,
> > tls_handshake_cancel() can return false after handshake_complete()
> > marks the request completed, but before nvme_tcp_tls_done()
> > finishes. Error cleanup can then release the queue while the
> > callback still accesses it.
> >
> > Wait for queue->tls_complete when cancellation loses, before
> > continuing cleanup. Preserve the original timeout or signal error.
>
> Plase take a look at the Sashiko complaint:
>
> https://sashiko.dev/#/patchset/20261022071934.3818224-1-thnkslprpt%40gmail.com
>
> it looks valid from a quick glance.
>

