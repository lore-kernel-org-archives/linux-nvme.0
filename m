Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5D4CCF2E3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 12:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hJuhMMpUoJWJGnzKiPhdetzU4DaZqI5sg9OfkjC2pm4=; b=ifEbUKhtNOzXsHrGz3bPMoyuR+
	CoZPM9awDkijxg9O/E5QHfi7i50oXbLd9Dq/dirv3aE1XjMWnZFpsXzMkT/Pf8m+6T+Ndp47dKyD+
	4aBPLj0Q64LVvxP9MjoXzJ4NR9zOLCVefDcsIkSqkWT/CCUeSTKW+TLz+IBY+AEsa5Fj19EnXSyFR
	OuluIJb2H1aQ90WFn3KB3NJCQasBnPen4boo0F61w6l8/T4vkv5nGfUulaOhdymhoDDt+sonxmAPU
	bnz5NFL1MMoMIAByqWKMmNa21RnRnNrzGeJQgQOa/ZVGnfs4Ih07sNXIxIDKoUsn9gS+mHddukvdG
	QFPd+7qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xImF8-00000007M5p-2hTF;
	Mon, 19 Oct 2026 12:13:30 +0000
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xImF6-00000007M5F-1B7y
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 12:13:29 +0000
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-3514b90bb89so5132992eec.1
        for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792412007; x=1793016807; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hJuhMMpUoJWJGnzKiPhdetzU4DaZqI5sg9OfkjC2pm4=;
        b=lJiszVUOWzuqrjPq80bmxKWbvpgblE4T9yzvPjqXc16Ig7D2urEv/w/KO1Pueagts+
         ic0b8MfMCI6SdL/IqQZfqvkoZhlWI+6nUfUEYguB47y72ddVGOwi8kAlYh+ubzhOao6Y
         Ecj7DhmDACcnQBEAxM98i+8K4IzcWX3gbXgCh5w6hE6yZFarTO++BKwwxuKCQ68hzOeo
         KckwMqPZR1puuraDJOI8NDnPPxy6PxORXkGYBsvQ3JisvvdqxMasow0/Zs80vLwurqg6
         DqdNmUdEUVdDLOaepFffznpUOEK92rG9GYgpAy91gsYMBak+u+ouohFINvM989fKFQBr
         /GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792412007; x=1793016807;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hJuhMMpUoJWJGnzKiPhdetzU4DaZqI5sg9OfkjC2pm4=;
        b=rWHXXJ963cLMVvVs9LSY1k0DfopmP5wcYrWiyzf7a9lc71orwfprJ1ocRhzON8DLc9
         PimhJbYTPYna7FwMVvNFXvbaq+JqAjyNlizXEKpdU7ApKJzQgfmbJYuauwW8KPCEV6B4
         yjbgzUPS29GSE7D0dLjoI08xaWMCICsdvfIbUdNiRcZo7v6JEupEltHzc8Vv3E7KScnl
         LZtxLlKyaiKdT/r/CzZvIb2hZaEhHM7QqLPuhq5JfX0GuezoHJ/OdF6r9f6fzxDI1ll7
         KE++8LT7Wg7kIjFY0K9Rl9g4j2YOsKokFJT32lYTG1jaBPTY3ihY04O+c94zU/L1T7JQ
         r6DQ==
X-Gm-Message-State: AFq9FYLCcNv/H/bjVqk62bDnngxoZvpOxWUdrA2H3URTCzEP0O6g/FxT
	AnfYtQlSTwJipvH+Oo1uB+520hWGbUEyxkD3/8YG8y71NBQPlg78/ZulNK9gM9zr
X-Gm-Gg: AYBFou0JySneQSdQ5LaX+iJAr/Umw8brVBshXhVKvBfO/24Qbeu/1Y6w15gIj3u3Cuq
	F9KWIh4fyv3OAup/DPUB7NaYT6gp1y1vwhueVH/JUsKxPKary46Bs9znC9ydI6mGnzYUDSvhXlX
	0ldpk/FcyN+w2bEzwfmvXU4wNgqcgQhHXcr0O5dsWVGb4of6FtRGe2xvPBRF5LTNk2a02PyhCp2
	XwiRnoorteZivEhzlH5hld4Yo3vJ6aq+iUZvMG0jUlkedhWzyb/rqwsr57irsbwCVb7Nbi1m29N
	T+KPvePen+MYeef+RT4pC5NLcjvSi9O8vftNGZedKB3TYY66Ticxy/t3zXu/gs5+xIhQjqM/qMm
	qKw5BiNAzhiJXVY4Ff/2MXJ9I98cLIJnA2eKo4JRLRm6xpteSfW3h36MsURhvZ2s3uVeU5mc5nX
	lYpbwkOurFzHui/HN9ziKSsTaXAXK3AmGe8jX4Un3NT9TgTXmNFMTUMDzJPYvPSNMbjECHQaCDP
	umEY/rdJoK3YphfwQ==
X-Received: by 2002:a05:693c:4090:b0:33c:16f1:2e11 with SMTP id 5a478bee46e88-361a146def6mr13433205eec.7.1792412006962;
        Mon, 19 Oct 2026 05:13:26 -0700 (PDT)
Received: from [10.0.2.15] ([136.226.242.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm36460343eec.6.2026.10.19.05.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:13:26 -0700 (PDT)
Message-ID: <c4b6b7cfd51a498df8aaa7f5bc5cef9a0605b733.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] nvme: document the service-time iopolicy sysfs
 attributes
From: Martin George <martinus.gpy@gmail.com>
To: Guixin Liu <kanie@linux.alibaba.com>, sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
Date: Mon, 19 Oct 2026 17:43:23 +0530
In-Reply-To: <acd6eee9-dadb-48e3-9a9d-232a268472d8@linux.alibaba.com>
References: <20261019075607.808947-1-kanie@linux.alibaba.com>
	 <20261019075607.808947-4-kanie@linux.alibaba.com>
	 <sashiko-outbox-176783@kernel.org>
	 <acd6eee9-dadb-48e3-9a9d-232a268472d8@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_051328_318107_E8F33479 
X-CRM114-Status: UNSURE (   8.91  )
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

On Mon, 2026-10-19 at 19:13 +0800, Guixin Liu wrote:
> >=20
> > Should "service-time" also be added to the accepted values for
> > /sys/class/nvme-subsystem/nvme-subsysX/iopolicy?
> >=20
> > =D9=87=D8=A7=DB=8C=DB=8C
> Sure, changed in v3.

Not just /sys/class/nvme-subsystem/nvme-subsysX/iopolicy, but this
should be added to the accepted values in /sys/class/nvme-
subsystem/nvme-subsysX/iopolicies as well.

-Martin

