Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B08D1D486
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jan 2026 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fn/JoGzjgMnLNspl3ck18e3p9KeNwhc/CT4wpLvvEIw=; b=AMB6LwLtHDu/LaV9nOObSx7sZU
	7nfyksWP7NBNn8szZPku/+ttXwYlFZMGJ/oyLpqmDBw+W7Gj6XwhTsVYXz7R2rMxoT4GzxC2Mp+7r
	QGxPfmpuU13gSPQ4q93310T71hoKNygsYTJGLz0R7TDxr0Ff2BoZW8F4fd666ooUPmyLlxH066qui
	/TPIZjlcH8n0qn8QESPFFkLBCfNZFJftLkiVd6Zks3Zcxm6F4m6GeHYSWkXVBeUOJKeSG/Y6ENOnt
	hfiE9y+5V+zT1n4XvWTsml8l7AXdl0bnhZ42yvgx4OGx2WPoKLnWqpD66r7eaSvtf7nL+H5UKRic2
	yoFpGuSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdub5-00000000aLJ-445T;
	Thu, 08 Jan 2026 18:18:59 +0000
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdub2-00000000aKj-40XZ
	for linux-nvme@lists.infradead.org;
	Thu, 08 Jan 2026 18:18:57 +0000
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-5ed0a9cbb3fso1212439137.3
        for <linux-nvme@lists.infradead.org>; Thu, 08 Jan 2026 10:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767896335; x=1768501135; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn/JoGzjgMnLNspl3ck18e3p9KeNwhc/CT4wpLvvEIw=;
        b=MIaHZRn6ZOrOztya8u8JCFLlEammfUxigXc4seBYpGJ8PAVrhzjvCLLgejr4beewu9
         BDGEdNSsbvejQrp4uv4DpoAtHuUtvB685SMrR+1JXbasz9MatovAK9GP7I5GC/N7C/3l
         9NbqnaMUbhjx7QzKr95eJqmJ4mCAAX3DBSDYErOFp3DeIk37cZZ/QFIoRJBM8Jf+q6kV
         9TCyHYSCi6F4jr5oEHgYf1nMvBjYWMgJIhZFyseybnW8OUhfVE92FGTeWJRussqUi5c9
         Et+HbSoL5eSL8t+EvfOzUjQFW4XpoHdcQ6X36vnkJswAP+5DoFIVfHuKqHgFBK3WcXEX
         9+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767896335; x=1768501135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn/JoGzjgMnLNspl3ck18e3p9KeNwhc/CT4wpLvvEIw=;
        b=p4USDTCPo6VzKNHlJ+hBt59YG+bficHQsxMTTKrAUCCaD5lrOHrET7qitA4TyKAd2K
         ux+BH1TYWHA3JjTpsi2yfSxhbs2EbhPXrEpmDuXf8Uolc+nelTtZ8tJgMLMW2qo41o6c
         PA5t7s+zGo0bzqEZ/xxHBmI1a8YdpoRVww4OTGi59zBV4KM2geAHp19U8Hz3wSe99bSN
         LqVFMfxb9quIIRqYMmPtYHnPzubSNfTD9vEQqSXENcNW0FyzmpyosEBp1poYFCm5Tu0U
         TL2RBglYE65kxqLRr2zdLBCwVg3I6sFhDHb0NwRVmeXAYg4ZhY8sz2lQ61vYXYof3TSw
         QCzA==
X-Forwarded-Encrypted: i=1; AJvYcCUREx3ExLy0OLfB5gQvwyaf6V5XIjKarR4W7TFf/3C/ekyGcK552xews2PDr+5jX0H3MGw1Y6Nmy32J@lists.infradead.org
X-Gm-Message-State: AOJu0YylrBhxcMVFn4OJu08wC10X5m3ClB4kvFkmqeMiSvXnmzuutjJG
	CxaKpFzpowet97zK2J5gvg8IVRekge0CINXtI24/QyANhTTzBMAEYgnc4i6wVeF1KX7UwtCRzD+
	IoDdTe6v9lV95C+LcwiSaxGkOJk2oWGc=
X-Gm-Gg: AY/fxX4QyNx12TE7lv9NaYpGzrTrXkpQJ6LKBoBCj2UQ8Q0WZQfGtwb53BpUv+NnPpe
	WwKzQfN3CVvjD1rR363VQcPvM5+Qy+4ZcjrIgiODBHv1UKrBVJpM5+o+n/w/peqr69zW9mNOGnn
	qcvc8ZPvn/VospB72kMNlN+dH11BZqoNRjCUjRNX6bkAvjTFcZvxoFCClIqSI10t4qlylTlTtAX
	yumV5eTMFjMfipWYOkugsn9tgRQXMKUFEsqryrjXJihYoIcGJprpFhgtctQDUFCsTKqNK/mZ1Rz
	nbgCNCXJ6O2MUXfFF0z9Q1++TVjz
X-Google-Smtp-Source: AGHT+IFZDy2QW6KnuIxIEyHkKpqj6MMEJSR/7O9XSRt3iqhghTeDZkCmQR+L8EcADh1b6vUy07gKP1CBUhZxixK3ryE=
X-Received: by 2002:a05:6102:4412:b0:5db:f352:afbe with SMTP id
 ada2fe7eead31-5ecb5cbb3e6mr3294188137.6.1767896333290; Thu, 08 Jan 2026
 10:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com> <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com> <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
 <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com> <CAPqjcqqhFWz0eNGJRW-_PoJhdM7f-yxr=pWN2_AfGSP=-VpyMg@mail.gmail.com>
 <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
In-Reply-To: <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Thu, 8 Jan 2026 21:18:41 +0300
X-Gm-Features: AZwV_Qi1KXJg98wuNlhob-PhKfYxveiRiQnCM2LlNsbeCGFpRxNmbpDflphYfZU
Message-ID: <CAPqjcqoqR8UdC5K-RCjKvQEoA6jnRBVZc53ieR1fjJKz9-V9=w@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_101856_997934_B74728CF 
X-CRM114-Status: UNSURE (   4.12  )
X-CRM114-Notice: Please train this message.
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

Soo, let's remove the 2^N restriction for raw block devices?

