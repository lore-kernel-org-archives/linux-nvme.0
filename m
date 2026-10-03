Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80ACCA5FDD
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Oct 2026 13:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v/KkCnT8DcfgAjdsj7WLPc/noK/t0kZqJiLQcWJITrQ=; b=A4MRs9MResQXUBigJfSax+rMAY
	/m9quAuw6gKswd2TkX8rCsTAghTisQ6K+DmQ1gb/Z9Ljvns9gVtYv1JDMqHagXizUjDXFIQQTHDIr
	fU/8kMFYSBQVi8S9lFDbfu4vF8TTYifZcPDB31kdy98bOuD6oKTI8+wpIrMSgZRH5PbAz0JQWPoWv
	JkGr9QU0emuG3j4nsf1YbgFGsMJyfvqKnO0xbo35neO8fR7Gpnl05RwZ2yw0r6wPgD8etXYUjfw/d
	r1V7DxTzRjn7CK6GTOMK1wtkWGYSplYfdvFCc8KAdRpmKn6KusNk0n6thbOA0RE2NWk9qLEevCQ6/
	F1aZy6Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCzUy-0000000DWL9-3kFt;
	Sat, 03 Oct 2026 13:09:56 +0000
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCzUw-0000000DWKR-0vgb
	for linux-nvme@lists.infradead.org;
	Sat, 03 Oct 2026 13:09:55 +0000
Received: by mail-dy2-x0e.google.com with SMTP id 5a478bee46e88-3511f5f79e0so25129eec.1
        for <linux-nvme@lists.infradead.org>; Sat, 03 Oct 2026 06:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791032993; x=1791637793; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v/KkCnT8DcfgAjdsj7WLPc/noK/t0kZqJiLQcWJITrQ=;
        b=nE7+tCv1SmUOfYpmlZnMwNlLE5uk4jl+xJrhL4WAK4DURGHdZdTzxBiyM0oAha5+1T
         vWtFBxZUsCyAVc1mrqZoa8MO2mz/3y650c/bz6gRIix5ZlKhfrnZQIOKqCjewapzgPvz
         /7vZXcWpoFaQwb78uyoOq3//ksbM3x5qMmtyNNQDrkHSNPIePaSLdlgviq+Tw5l408Mw
         S37gpJJpon6B/o1jJFrIF3ye9fE7XXu3MZp2BJUac+/WgGjooxOfzEkQRlnqhK8vU+5c
         CRjZq3cHhQPhiJHww3/5QNel9HV3lT5Ag9DNHtj3hu5rCbWcpf3cep+XnOEGSRJ00iue
         BFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791032993; x=1791637793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v/KkCnT8DcfgAjdsj7WLPc/noK/t0kZqJiLQcWJITrQ=;
        b=JF2hhPB+WEy10r7ImZ/Zt1eox6y/qnl/jC9iGuIgsqtCa6bCBzA1B5Mnm8V3AyFPng
         0EDAet8nspSC0syCjpmqYCzffx8pV4selvYou9/5YmHPsL7IHI1dMpIUqTjpMQD86G/6
         +wY3nkyy+XWDyA0sF5Cr1h9hv8uOA5hK+CCfYvkkJaU+KBRaAXJJdhbx9MjvPkpzjXrw
         xDd36DkMl3CqHGmR7murb/qTbPZAfjjuMuFFNdh0s5i3ZcRbjC1cCwvxFiXtvjS0bFfa
         8w+xgDwBMOy+jY7ugLDG9rOjzXR3gh/oryfTsOu7ArIb5FzGopz0F3DCYm7aXcm/kHqM
         QmSg==
X-Gm-Message-State: AFuF++lIXz8FzImE9uEgh7q8qADx24+TuMCTopMXwTzDNQWhdUD28FX5
	v++Orsqc/KS+nFJDNGG1ErkPUhdkuZsFgtIRj8fXfdR0S0wlQo2JvX9jpOADx3I+
X-Gm-Gg: AYBFou2Ut3QcuDVkdk5oH+SO5GDw7kdQ8jLz8S2v00xpMNs9nn/gx2S8LpISLEkF9qi
	IwqXG64zNV7tJ49jWvLe4Rn3IA5+DGod7yCBxPwdYwQbNe86lecmMvEBVwsN1r8RUB+PDIZZGK8
	3Mbtc2ljLW9LmqGSlZ283uaDrtEsOHtuBq329aVj+5dNVJolt21EjVQY8kikeB9Z4JWbnHvnprw
	nVCGcjRo2HXQSD+iSP2CvqcylTox8iLHzjVApntgIlXPfqOGAbX3zlw4T0/XFEsQ5sp+ZRulkjc
	1lhRo6LOxDdEv5M1cUfk2AmfNXlyHYVM4W9DIsHmWiWWeg7kwCf6TseZNJZctL5qHenxVQcKUTR
	GGwbcqRHp/Ttx1nZMQpOH/KkSBLL1CUyJfEE/xwwrF6yNLlH6EnlSU0AkAdOhCyl7yDC+fEPqkO
	z41K72x8wNDrxWBwT8sFBy25mzIEgxjU++aIb2+9Du82Yo1g1cvyZsyGDLXw5y6VF9OeNxxKXKv
	JrpWTXXFViAIFCerJc=
X-Received: by 2002:a05:7022:1203:b0:14e:4317:597b with SMTP id a92af1059eb24-14f5bef5549mr6059964c88.18.1791032993088;
        Sat, 03 Oct 2026 06:09:53 -0700 (PDT)
Received: from localhost.localdomain ([103.170.55.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fc39a7d1sm5769868c88.3.2026.10.03.06.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 06:09:52 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de
Subject: Re: [PATCH] nvme: auth: validate DHCHAP secret before stopping authentication
Date: Sat,  3 Oct 2026 13:09:12 +0000
Message-ID: <20261003130912.2410-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0602191a-81ce-4f8a-90d0-b47ba2bc36ac@suse.de>
References: <0602191a-81ce-4f8a-90d0-b47ba2bc36ac@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261003_060954_260150_548D3D89 
X-CRM114-Status: GOOD (  13.38  )
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

Hi Hannes,

Yes, I agree that stopping the currently running authentication when the admin requests a new one is intentional.

The issue I was pointing out is slightly different: if the new key is invalid, we never actually get to the point where the new authentication can be started again. "nvme_auth_stop()" has already stopped the existing authentication, and the parser returns an error before the restart path is reached.

So the question is whether writing an invalid replacement key should leave the previous authentication stopped, or whether the key should first be parsed/validated and only then replace the existing authentication state.

If the intended semantics are that an invalid key write should not disturb an already running authentication, then moving the validation before "nvme_auth_stop()" would make the operation effectively transactional:

validate new key
    -> error: leave existing authentication unchanged
    -> success: stop old authentication and start with new key

If, however, the intended semantics are that any attempted replacement stops the existing authentication even when the replacement is invalid, then I agree that the current behaviour is intentional and the patch doesn't fix a bug.

My concern was specifically the former behaviour, rather than "nvme_auth_stop()" itself.

Cheers,
Sreeraj

