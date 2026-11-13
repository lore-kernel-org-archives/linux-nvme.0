Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6BC60A5BD2
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ScojYI+7;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IZNti01o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DiqKDlWoRYfJLw/7c5NRhzjxzdeVRT6leVSK9UT0flE=; b=ScojYI+7VFY8xsxCGlHwdu78dr
	jKJOtWmudVcLiN19xGzYuWbw3OtD9liF/1wZHEOsSOt1ZAb2oRubneDkr1Qft+aZkLztz0QRfeBuw
	dyOc4KZYjNeOvsn4wJdK5orK8zlL94I32V9iLMGInas262zs+K8eJ+1eU6TSmwKhYrD6HdNWFAvJK
	pI9b6ZM4sQPRsjkFGYRvSCrEkfT67dndAYJtmgEaKJquMPE316Zz0eLTEav43Ge5DG2JQ+mEMChrG
	yXVQfYGOoxt7R4Qji2PhPk47p3XTsJss30FBN+9tQLug+ceSRD5yiUbALDZSvY1/4rgWPkwF25MLA
	nfFqtLxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRt1P-0000000DMsl-42y2;
	Fri, 13 Nov 2026 15:16:59 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRt1O-0000000DMrx-0Vgp
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 15:16:59 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2ee1b65fdbcso2354795ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 07:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794583017; x=1795187817; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DiqKDlWoRYfJLw/7c5NRhzjxzdeVRT6leVSK9UT0flE=;
        b=IZNti01o7qUyH+Up+8U2sKkY0C9733OcosXcGKjwDuqlmUoWgaLGSReiK1SzHdOB+I
         04R11j0tzwMat/MlFWGMP0gRR+O/PqvxnL4u7c9sIrvxi4OEhMvMZM3qtkAp/FPOHPmz
         /PsFqsvx7gLSphlWKce84Fj2MXIhfTkzZTfDTs977xcCavBhXIYiBImOhP/nZBAZvBqF
         vpI5xLCq7olc2pHM8A9WTcRqRi+BzKQyMMI5D99e3tllzBp+T+x53k2VdNbOPsh4VLVf
         4Nrq9ZByVFpObNH/AQzomnIsNXFhBWjEM+jvbZGKi/0SkfwlusDJaB5PCPEAiqu7XC0M
         Jlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583017; x=1795187817;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DiqKDlWoRYfJLw/7c5NRhzjxzdeVRT6leVSK9UT0flE=;
        b=fmPkxLRaHUysUT4wlAFRRjrpnnoFNC1sTb+d4KYshy696S6HGogvY7LP1+nHkVfMfT
         4BxICSPAQAJwmoDsseeLQCUhCCfjp6mdeZJ7QOf/IAZ0NlUSobTZ5mu8I6vBDJ8uV8cI
         zWrhhEi6IjIfftUUfmBRFATnLTKBOLBPztvPjc4KXuY4XNropExBmcy4BPiXJ82yZSAK
         1/sF5X7sKAr6MiqsgBgssF7jMzCEJcpzx8ng4scTlaFlxKv5b9J+WdEAUtl0ePtC3U3J
         qm0AbYKXIG0olnQz4rQowDdt7MmshCPrcdCYNDIGAS9X2NpnYDtuT2/C4K8N8/3PgDUs
         a6ag==
X-Forwarded-Encrypted: i=1; AL+hErFyZaf2JvmUkiENM6tH2DrXgGbWmvbqtcuelG2msu1VbZzgsshg/QWY0dAoAOyeW8+PrSeeVqFIeaC/@lists.infradead.org
X-Gm-Message-State: APuU4Z+qWIyJCTyBj2eKEc9PXYHvH7+XVi1uAs38Az5ai743/5nqVAe4
	owxagYz9eMyXQcUYbPmUwqkrI+AHQIP+dvPh6oYnaT/YRv1LzoF/ZLN+
X-Gm-Gg: AYBFou1s2yVx2RAsQFBFi92DE4MTud7ulkZJ3qhS0vvMVGXQO28mzBUu3YQgzz9Xdmn
	kReebFgL7BvdYL7v4MaBDhfawe0y1KpCA8B7Ha6LJmrw1kVB9n4W5tB8Xm3YM5A8dLyDYrjTr4r
	fZEgtNOo4ZU1oWzMVOGpMyERzAj28VkTuTtEpVUrDdP3iB+Hmi9/LHVKCHzgBZkn0FrXIAg7UFW
	VhcGmn7Ju3MEZjuVXjzC1exBnAkGJulcbkdpbxAIgcCN+JsQXKmcCb8Erd+cuo0QKGrcgLwSHdu
	QUz94iR3+CmBJwxlg/urCrP/On3Uq8wo3goXpLbXPP2eTugGVsZ+Q0ZbYvlTBdthtrJKb9UQj//
	9tAQZt4eKhOJs1Gi3VnhyIwfn6r4IV0gTSufeUB4oExwXFehi6XnCHSpGhXbllpCmsagyGI/PK4
	H4GwY9ID4pRHXk4neFpBWgpv6/vVRvnZ3zY9qqcF8w2H/ri2LZjjDsEtzen4t/abtj8abiF2UNc
	btlIIpVWJfnO+M9OXDyT/kaf4FS87HWGPdiHnZCfRiwuQDK4xA8IdeCDVduqoAjX7IUFvgecmud
	9TaRXVJ59qrsbdPpfPegSC3BRPsJq2NiqZQ5DTaFGbNkz+o=
X-Received: by 2002:a17:902:e94c:b0:2ed:2776:4e5 with SMTP id d9443c01a7336-2ee0dcd18e8mr30042855ad.58.1794583016735;
        Fri, 13 Nov 2026 07:16:56 -0800 (PST)
Received: from [10.0.2.15] ([136.226.242.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7e5055sm11860825ad.39.2026.11.13.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:16:56 -0800 (PST)
Message-ID: <0b2044d4f5f95df1f33b679af07b4c46567c3dc8.camel@gmail.com>
Subject: Re: [PATCH 0/2] nvme-fabrics: bound reconnect_delay and
 keep_alive_tmo
From: Martin George <martinus.gpy@gmail.com>
To: Laurence Oberman <loberman@redhat.com>, linux-nvme@lists.infradead.org, 
	hch@lst.de
Cc: kbusch@kernel.org, sagi@grimberg.me
Date: Fri, 13 Nov 2026 20:46:52 +0530
In-Reply-To: <31da2c0ad81f8d6728f5ccbaedf23fb8148149a2.camel@redhat.com>
References: <20261113100951.17577-1-marting@netapp.com>
	 <31da2c0ad81f8d6728f5ccbaedf23fb8148149a2.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_071658_165901_6851628F 
X-CRM114-Status: GOOD (  18.28  )
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-13 at 08:01 -0500, Laurence Oberman wrote:
> On Fri, 2026-11-13 at 15:39 +0530, Martin George wrote:
> > reconnect_delay and keep_alive_tmo (kato) are accepted in seconds
> > but
> > later multiplied by HZ (and, for kato, by 1000) in 32-bit
> > arithmetic,
> > so=20
> > large values overflow and yield bogus timers. Bound both at
> > parse/store=20
> > time so the conversions can't wrap.
> >=20
> > The target already does this for kato via NVMET_MAX_KATO, and the
> > host=20
> > recently fixed the same class for admin_timeout/io_timeout
> > (4a5aeebf1a00)=20
> > and partly for reconnect_delay (f92fe8dea19c).
> >=20
> > Martin George (2):
> > =C2=A0 nvme-fabrics: bound reconnect_delay to avoid timer overflow
> > =C2=A0 nvme-fabrics: bound keep_alive_tmo to avoid overflow
> >=20
> > =C2=A0drivers/nvme/host/fabrics.c | 4 ++--
> > =C2=A0drivers/nvme/host/sysfs.c=C2=A0=C2=A0 | 2 +-
> > =C2=A02 files changed, 3 insertions(+), 3 deletions(-)
>=20
> For the series:
>=20
> Looks good
>=20
> Reviewed-by: Laurence Oberman <loberman@redhat.com>
>=20
> One thought: fast_io_fail_tmo looks like the same class -- it's
> scheduled as fast_io_fail_tmo * HZ in nvme_start_failfast_work() and
> isn't upper-bounded in the parser or sysfs store. Might be worth
> folding into this series.
>=20

Good catch. fast_io_fail_tmo seems to be arguably worse since it is a
signed int (so "* HZ" is signed overflow). I'll add a 3/3 patch
bounding it at INT_MAX / HZ in the parser and sysfs store.

> Minor nit on 2/2: "1000 >=3D HZ" doesn't hold on every arch (alpha
> allows HZ=3D1024/1200), though kato being unsigned keeps it safe here.

Right, I'll drop that wording. The bound should be fine (INT_MAX / 1000
keeps "kato * 1000" in range, and kato being unsigned keeps "kato * HZ"
from wrapping) - just a changelog reword, no code change.

Thanks for the review comments.

-Martin

