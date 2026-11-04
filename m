Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4AD606A32F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MJq3tnGf;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dgrb96ku
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=dmn1Q3/145xsrJD3bHMxFjskCeqjVe350pnKBSHlWz0=; b=MJq3tnGf9XyOQy
	kZc/pEOhUes0NEJpXODr8SsGq57AYQ1sUegZqFphtAIqJMZKIjynfbubrJ/JYHJkLZbSCLOfOvc+k
	CwuEubIYaktbhAqQshks/WmsAwjWa/NmJ3wLBhBhIkD6gX3YUVUOz8ZKlAMUM9tl9g0COA2qMl8m8
	4DFYO92S+mnvR52AF6tYtTEkZXkHQrF0SSQOArmLBNZt9OcXoFpZdrqLU4Ob4zeCTijhr2/sm4Z5e
	KpJgIMGe1S94vk1aDgkLnHMK7Gu5NYZAK4k0FtiR7ybwLmEY3DW+U6sMmnrzn+FQKNuhNtSuSzT8z
	SClUAziqh0zu8J4FhHcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjxC-00000007Cmf-1KlV;
	Wed, 04 Nov 2026 22:59:38 +0000
Received: from mail-qv2-x08.google.com ([2607:f8b0:4864:33::8])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjxA-00000007Cm6-12x5
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 22:59:37 +0000
Received: by mail-qv2-x08.google.com with SMTP id 6a1803df08f44-91e883d0654so6928426d6.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 14:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833175; x=1794437975; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dmn1Q3/145xsrJD3bHMxFjskCeqjVe350pnKBSHlWz0=;
        b=Dgrb96kue1WNVE5DqdtniAcp6gJ28zuTy0HwWToOCmwU6H+CKlJqq8t+uaNWHGP5D9
         Bx3SDzIVK/jF0iCYZNkyCbag7HBjA7LhlrWCd/NE239Lg0yIyNCWclJTEydEqAXYw+7+
         9DKx7dvQEiLFR+obumWEQqYuL/dmUkIym8cOCL9gPVpIizU5KNdWmWrwE/lvfv4WaoGy
         BfP0tD78VqKsW67QmDU1a44jGD1XS5vkFcN5Z3rtONQOLi2RBpUO2ohrN2rjiUcN80zL
         XE9A5fqOuLmMpRjwVJ67sfrHiX8suHopnSE3tfQjezYaftM3RVXENcfjiIaQ7wo2dDH9
         uMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833175; x=1794437975;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dmn1Q3/145xsrJD3bHMxFjskCeqjVe350pnKBSHlWz0=;
        b=MdyPThe4PGDUi8kU/NbhSaJwLEpbkc2YAbgXbHOUdqwtCHcd164cnDw55HMRgXyzdx
         tAfGym4sbeQ8K0cy5YKmZJL2kPr5Er/8YfZ9ZNTIcM2IZJ9rD7J33RjPO673KmoVN8E/
         3pbp8gMcF8F723e7He2UMT2PRXPhMPvbACvFa3oET2kZA4vick7Bo8f+ZIvjP8/dRpd+
         kg4DEh3Mjumd/hCU/ktnXGzJDi77cTKrm01AcPpd2pJqgOXzR94K158agTPgR/1ZtqVa
         9F1A0CuY1AelLmSlBkd2Ky8KKTAF9s0v8Q9h1km9vVdOzGJHAFUVWhtefHpWJf9MTfTC
         60sw==
X-Gm-Message-State: APuU4Z9LIwE+BOneUbG4qE1Nu3G3yIhO3acqIDipEl3xVMeKflRA0weV
	lWY75eJiVq47//mxB7DTIjTPkG5m4HBFRuheffJnap5tRMbwn5p0XS4AWhGIgiuZvic=
X-Gm-Gg: AYBFou2awC4+zGKSwnBIex5S44BbhTr+8HrN9AlOJnkQfI2Xg35Lw9Byi+Vf81RBpyJ
	osgnFBR7NSazq6BOdth7t1E1gNT1A8qRlWDzkUrWdkpjqaPbFCe8P87rshtldTHBim3QVjM9Epu
	YucXe46H3RkPpegOCLgo5bWElDRMECnGiur/V3NeLYTsm/H/LddyymPbvsUU7bjgteEYn3SqWPk
	DurRbPtD0qS96vp3N0bjgonutLcxxtqWq/VIVVyNgOM6IIC+M597/yeXZAZV+lkRzR3y4f4/NdV
	muuazu+6bg37SfXSJxR42a/1ZB6xChM0mKiV4JXytGAevKu9+TruX5jsn8S0RInzbwl3uWv2b6Y
	PLXu5bqoOG/T41WePzy0u2x1QqCOYWt3q6przYVIhQGgqrXfR97mlf7TsRsYKduhI6JYxxwfgYd
	CzjdIeTQIyo6us4llH2E6RY3SarWb1K5Cl4rbnB4fvJeZRNVdJeDceK3JgDHx99VlMcFEdXcEWJ
	OXNLm6wgUZRAWqYDTWIxPqd/QfKP+0ncfiqtX0Px2lwWeyB7xsOO7IFdyMYY8MK44BeAP7wvzHj
	tZtvc4ZB20zyDz1sTPvFuiz44UoGupFr2g==
X-Received: by 2002:ad4:5945:0:b0:91e:9074:19da with SMTP id 6a1803df08f44-91e90741c7emr31183596d6.22.1793833174911;
        Wed, 04 Nov 2026 14:59:34 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfb4201sm31557236d6.10.2026.11.04.14.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 14:59:34 -0800 (PST)
Message-ID: <14067bc2-41fc-40ab-84be-adea737479ab@gmail.com>
Date: Wed, 4 Nov 2026 17:59:33 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/6] tls: send a KeyUpdate at the record limit
 and on request
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261103-keyupdate-rfc-v5-0-de1ab90a88d5@gmail.com>
 <20261103-keyupdate-rfc-v5-5-de1ab90a88d5@gmail.com>
 <sashiko-outbox-198141@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <sashiko-outbox-198141@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_145936_309907_74C7FB85 
X-CRM114-Status: GOOD (  13.11  )
X-Spam-Score: -1.1 (-)
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
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/26 16:43, sashiko-bot@kernel.org wrote:
 > > +   ret = tls_encrypt_async_wait(ctx);
 > > +   if (!ret)
 > > +           ret = tls_keyupdate_rekey(sk, 1);
 >
 > [Severity: Medium]
 > As reported by Sashiko on v4 [1], can tls_tx_key_update() ignore fatal
 > transmission errors and rotate the TX key anyway when 
tls_tx_records() fails
 > with -EPIPE or -ECONNRESET?

Yes, but this is not specific to KeyUpdate. After shutdown(SHUT_WR),
send() on a kTLS socket with no KeyUpdate also returns the full
length. I tested this with TLS 1.3 AES-GCM. As I read the code, the
KeyUpdate record then stays queued and TCP does not send it, so the
peer never sees a record with the next key.

This corrects my note in the v2 changes, "The next call reports the
error". In the same test, the next send() also returned success.

 > [Severity: High]
 > As reported by Sashiko on v4 [2], how is the KeyUpdate state in struct
 > tls_context synchronized when sk_stream_wait_memory() drops lock_sock(sk)
 > during a send or TLS_TX_KEY_UPDATE?

No change, for the reasons in the v4 changes. I checked these points
by reading the code.

Points 1 and 2 need a TLS_TX or TLS_RX setsockopt() during a blocked
sendmsg(), which is an application error.

Point 3: tx_key_update_reply stays set after the update_requested
KeyUpdate, so the reply still goes out before the next Application
Data record.

Point 4: a record that was already being written can go out before
the reply. RFC 9846 section 4.7.3 allows this for records in flight.

Martin

