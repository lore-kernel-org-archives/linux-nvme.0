Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40725C5B549
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jun 2025 12:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w3fxiq+iwV3pIjcBXMWH0MErnTw8kpcB5r77rQHGdwA=; b=mLiSjZ0ZWrQ63PsDha2aTx1ePr
	5tzvx5n3zJtDbXXrfyXv2czB5sWwkj+GwMMGR7l3zJaCl+2ncT3N4mcneDIHFW+OGzJH0cnwtEhbZ
	Qyh2cRsiF9RR5iZ1Ggy1YPS2F/fqwLnFyF75hfbnJbXUrdIKS5HY8xgdE05x5OAScIlzvvpymabHy
	94tTtWSGj/PseoDxHOu4ssD5SMpn8lcw1RPSCGoUN/ctR3jaPGtg00zVOrAIwrRz5snkxGrKIb9uC
	msEDoDVw/lKCFJ6fKmbWrFKeOTiRJr74e3pArQCNM5MRVi8GvY/mPgatIgMGZt4E5bdgbS9bLZkvA
	vUlzKDWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMnhE-0000000DOOO-2aTf;
	Wed, 04 Jun 2025 12:58:20 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMnf7-0000000DO4i-4AXW
	for linux-nvme@lists.infradead.org;
	Wed, 04 Jun 2025 12:56:11 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4a44b0ed780so57023231cf.3
        for <linux-nvme@lists.infradead.org>; Wed, 04 Jun 2025 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749041768; x=1749646568; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3fxiq+iwV3pIjcBXMWH0MErnTw8kpcB5r77rQHGdwA=;
        b=IOsJD++8yNj558sJDBwOCE2PyRGXA5ABOt+hxRYsomQZ4GiYwIDkh+6R1UHX63XHM/
         MqCQduhXcBjx1iz8kW94BOG1fGeyT4ipFonUVPRb50ynQnc4kVxcdvxi0W8KfOAJdY7V
         9+09Y2F8+oo7kbMFg3hOqi6juYqeZwDAf4ZHMnqCsqc06hF6hCEQEPU6HzrMizSUY1NW
         RC/bvCTvUwXNCkCXwSxgscrnQnYBDgqodvOPKYz/n2ax9YKaL1fAbeV1Zq9exfjRt+A9
         q6C7zg2kTogA4QExBetN4tGwSpK0lei9Zy9FJsuArY260tJhrstJjUdnwVwVokJ9EHFv
         jNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749041768; x=1749646568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3fxiq+iwV3pIjcBXMWH0MErnTw8kpcB5r77rQHGdwA=;
        b=KVEa7TzxPTbOBN6kOCDmjlZP37Rp/t8J2+us3tBX3s21P4JTT95j8Q7q3pIPQZv95Y
         TJaokpMAVmrekgJGDGg7Z0SZkEjPycfWjooWX8apwzSxRRLXM7ke6Qj5kgFE92rKtmP2
         Hqr4VKGvV2SqGdtFTDnai3dVtzvhgjLAD4vnwpfIN5chC/xM9wcjY5AaapRe/5KJQjMV
         EJYLU9hXRDae27k4zYkRPzCz8+CMrk2ldJ07ikiGjA3G8YNwpdZ8475rmKBqAO/FS7co
         v49VC80bDkEZ7IBCcxxIOOEWkH3wBgqfgIlDIaPxspQkyILS1gwEhQJl6MLOkmvFpj2V
         3a5A==
X-Gm-Message-State: AOJu0YxiNXFG7aUQp6/SVPAVSzUqge1sgk2F4q0FFKmkY7BXTBhij446
	/aO3RDx6ytI4rtLuQ2LeuTWqm9U4sr8CbjCZMswBLgvC0ljSPFsNlhNFPbaTb0O7eN6VWGoYs+8
	2WPt9VH6L9UwbwKep1YsMrD+Ct7CPxpZNKNoz2g1T
X-Gm-Gg: ASbGncvYYdlCLJ3D3qmmANHrMFsWxdFtoM+jGY+9YNmp8iMVeNMV11tlyKTnHMSaTX4
	eRwkj8e8W7S4Nj65ku9M2ycx0hRj4wsFTYuhuUdLiAqyJSqhQ28IPjMFYr5Qrh47DM0McyfUax2
	S/Kb2Dre0oRl6qtdBeHgrADTuGLElMdTUiP1mt95Yee70=
X-Google-Smtp-Source: AGHT+IE788UnxluCRBSR+LAkQBjc506hu3vvFW7EuLgv04oUX6C7yoDlYedRbU67Gy6R8Q9Tggh1VoL6gfTWOrjz4HM=
X-Received: by 2002:a05:622a:2c7:b0:4a5:a5df:d1f9 with SMTP id
 d75a77b69052e-4a5a5dfdc42mr42174421cf.43.1749041767672; Wed, 04 Jun 2025
 05:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250430085741.5108-1-aaptel@nvidia.com> <20250430085741.5108-2-aaptel@nvidia.com>
 <CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com>
 <2537c2gzk6x.fsf@nvidia.com> <CANn89iJa+fWdR4jUqeJyhgwHMa5ujZ96WR6jv6iVFUhOXC+jhA@mail.gmail.com>
 <2531psgzo2n.fsf@nvidia.com> <253y0u7y9cj.fsf@nvidia.com>
In-Reply-To: <253y0u7y9cj.fsf@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Jun 2025 05:55:56 -0700
X-Gm-Features: AX0GCFshygdM5kPCn2cK1pkv93U_-omBbSINFfT-gL4d4TszBj6-pmrtv8ACoXY
Message-ID: <CANn89iJ6HROtg3m3z8Ac61e0Ex5HvgOTNavfG_W0j97B0XMZkw@mail.gmail.com>
Subject: Re: [PATCH v28 01/20] net: Introduce direct data placement tcp offload
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org, sagi@grimberg.me, 
	hch@lst.de, kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com, 
	ogerlitz@nvidia.com, yorayz@nvidia.com, galshalom@nvidia.com, 
	mgurtovoy@nvidia.com, tariqt@nvidia.com, gus@collabora.com, pabeni@redhat.com, 
	dsahern@kernel.org, ast@kernel.org, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250604_055610_033571_3E79261D 
X-CRM114-Status: UNSURE (   8.78  )
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

On Wed, Jun 4, 2025 at 5:33=E2=80=AFAM Aurelien Aptel <aaptel@nvidia.com> w=
rote:
>
> Hi Eric,
>
> Any comments on this? Maybe I can clear up something?

Adding one bit in all skbs for such a narrow case is not very convincing to=
 me.

I would prefer a disable/enable bit in the receiving socket, or a
global static key.

