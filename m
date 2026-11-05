Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC244606A31B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=f0P0vgUo;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EW41Vo2i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zua2wKISeB6S1byTyWjx24hQmuvknlx4L4ArzH3c8oQ=; b=f0P0vgUouAzvIk
	NfP8PrcP4xcri7G2+SJogpsye6WsCuakZmQ1jFgGuT7hwpBVr/toOh7h718NLX2Kzz4IPmE0thF/P
	Mr/ogTkTkoTWQ0NQlLRK+Y8NpfaeQsjVhUkvxA436C5sbxLDR/YDhxZ8jKYcRR66lcHEzLGRgwduV
	pYUMv4Vg4M3YQpcqQZ0MmPiIDA/95wC475zaRCFNI8PfhgwUlPs7sXxTSq6NXMde6HjQ7nCpuFTkP
	w48O9QJvSvPH2vjq/gbeXHoclhWuUCtzjYOnin4paU2nvr1me82UpbUrkmPoCWn9EllKIQrUMohJq
	b/HMtF9Fh2p3E8M12ytQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmif-00000007WcJ-0Ha6;
	Thu, 05 Nov 2026 01:56:49 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmib-00000007Wbi-1k9X
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 01:56:47 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-36a1947498bso3503431eec.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 17:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793843804; x=1794448604; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zua2wKISeB6S1byTyWjx24hQmuvknlx4L4ArzH3c8oQ=;
        b=EW41Vo2iMN98wqr+Rd3hb7aq6VhOhcxknFW0nCWlhOeB2GYYxuvfDbLb8bZ5lqgdTp
         s78xXxMjJ3ZIiXiYQC8wSLgt5T49TM/aG5N+dqMgT2KyNJTZY2ciUGl2V51Wac2NCuvQ
         Y+M2v6LfcUAm/d1OklUPV2B9R3D9v6UF3RyLXbINDTwZA6s+aZwe+FEpv2DZwaXRGXF6
         gD3ItR6zImtzZLMb+2v1V65xC07c+qzDe+KSbtdRDfTtQPukOQhIzkFrt4mlQhJDM0fo
         j7tUZqKHhNWB5lasDd6k4fpI6BPpHfcpKNa5NOpCkNu3gzCQNGvplFugMeqjeDBI1OvK
         irgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793843804; x=1794448604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zua2wKISeB6S1byTyWjx24hQmuvknlx4L4ArzH3c8oQ=;
        b=COjkfaW/Ou1MIMWwA4nhY/jWUuU9yUrLVlJ4aKUtO7I1ur+zOq6EtHKn2tkLCoRZpS
         cqQpaijRWgPsSLe19BTGSWamgwqSV8AV5qJzyP492QcjOGuEQRlceE9J+ubtFkObKLOA
         9azKp2W5Kwb/as5cnscsYFFd2Y+MtWpvmUIxtbiIQCRuwT7jyG4JW+HMOxrFh/GscG7n
         69E+j6cySIc/kvTF/2A0igCsEBEo9f73sC69xLkNexknwwqGyRzhrZmG8hYcrIhHxf95
         FJARnpAPkDc7gqR8kHbtSDiiHfydBVPPgT3p8cNLIegdQ8NZaDGsCMNCvs6earACpMFH
         lDLA==
X-Forwarded-Encrypted: i=1; AKwUvBxhtJC2/I/zFMqsENETAPA+iIexiEDJrsyPUOt8Ve/7sS6awZAbwZyOCFhFi6Xg6jHLq6baPmKmwLFn@lists.infradead.org
X-Gm-Message-State: APuU4Z+ijZJlHBJHXC8qYKHyqacv1Mx2lic6Nkk88JHYJR4tF+t3N+iG
	MgvoWLe04vkIFLRatxSQk8yiypUqUPFWvvTGXy2dyxpdPJedTGmRDhAD
X-Gm-Gg: AYBFou0QXSG5xmjtUxLeoxUHWhd35guu4HUNtv7Y6kK9TX5+0gudxPI9DqDdPvYsKw8
	gj1YDqAhEGbY/cv+HqK5dGD8kfr05V8LkIMV6Ee9+AjbC459VcFZzHGfkSVXs/RaeGEeiN+8hBu
	FCV5dlXg1OXOrGGuHF9/TGiZ0WPPxiCI26SSpEBoMIqlnSGsO+Hm9XPOORSxja2VHZtQ9sozYuZ
	8e9HiihJoU4orvfK8boo1IxjJ+4cX6O6RyXYDrWz6ZGitVqCJO2RjDefgajAUovMIGsJG79IKDO
	eANETO3abJMWJfm3QUtCasfQb1Pxuyy+SWsfPSMqLTbgdijTYXBmx+ojErY8N3NySpF+sWwIUjC
	hrT4/9vBlrJ2HGvRKhyeNrOKDU4hLlPN6tu1Zm+lvaA7Y2Ghf70uLGU6O8ISuImOXRxj9sj55Bd
	4uc5tnwJ7Du2QnBu4pRFPfbeW2YR0SBecwtiqQsoptDTwMFQoWqtcXnqN3ZefEMxOfBSKA9+CTf
	sDQqHF3qoSuP4P4OgfoXxXZ/0YbymISH0aDn3INyabNqDhzmmYd4gUITVQaWoMzKLBlg/T7EqJU
	yQ42K4QKcjvb12EKJf4r
X-Received: by 2002:a05:7301:2a05:b0:36c:b138:651e with SMTP id 5a478bee46e88-36cb1386818mr7686510eec.22.1793843804409;
        Wed, 04 Nov 2026 17:56:44 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3785430sm16872570eec.3.2026.11.04.17.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 17:56:43 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	=?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Date: Wed,  4 Nov 2026 20:56:38 -0500
Message-ID: <20261105015638.746024-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5b0e7c55-72b1-410a-982c-a62138b9e44c@paulmck-laptop>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com> <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com> <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop> <5b0e7c55-72b1-410a-982c-a62138b9e44c@paulmck-laptop>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_175645_479223_3644F411 
X-CRM114-Status: GOOD (  16.76  )
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 05:46:45PM -0800, Paul E. McKenney wrote:
> On Wed, Nov 04, 2026 at 09:14:13AM -0800, Paul E. McKenney wrote:
> > I am not inalterably opposed to adding a list_splice_init_srcu(),
> > especially if quite a few more users show up, but here is what I was
> > expecting people to do:
> >
> > 	static void synchronize_my_srcu(void)
> > 	{
> > 		synchronize_srcu(&my_srcu);
> > 	}
> >
> > 	...
> >
> > 	list_splice_init_rcu(l, h, synchronize_my_srcu);
> >
> > We need at least six uses of the above idiom to break even on the line
> > of code required for introducing a list_splice_init_srcu().
>
> Given Qiliang's response:
>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thanks, Paul.

Christoph, with that, please disregard my suggestion to take v1
instead; v2 is the one to apply.

Thanks,
Qiliang

