Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A03C606A328
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1a2BvX//;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=siroHMOk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PtTdxBCaK4IP3IjSC3LwSEdRzZKszREp9Gn/OsemyOU=; b=1a2BvX//VKG9anoQB+/Y1b59Tz
	VGWaS/vUXkMg1g5az/LxNhJWUnMtCRViXOc/sLILnfD81r0JlN679u3WtQeF96ovnxj0eBQJknxW8
	ydTDIBnagVgUlT7pw6IALrYD6OSOko0FOOm4Gsup+on59Jm/sC4vAsXt3uyjE4e++u8P1JMgS5OC0
	Obz4d2DDWlS0D/BLmIaA6Yw/A/KmnSttEkqcqaJsSzmNUuE0JYNBS53Wzy42V8oCa+EJgNz+jA8iX
	/rnWK7A+lgK72b8lweF85W5uWy9tOTrJcK7f7xoEJTKn05dQ5L1VdseZpmXeirQjxC7jJ0rwESnE5
	p2HcryIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJBcL-0000000A2vt-0wqO;
	Tue, 20 Oct 2026 15:19:09 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJBcE-0000000A2uh-1LX9
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 15:19:07 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso6019375e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2026 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509540; x=1793114340; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PtTdxBCaK4IP3IjSC3LwSEdRzZKszREp9Gn/OsemyOU=;
        b=siroHMOkWLZvHNdY23HBUILKc0PMzLw+lT2cTP3HmpIpgthqrZF1CLhTR8CKtqLcAY
         el2xHg2dzALnbrB02JSbHKQ4YpQdcJFQgexKRw1vRgcFf0gVnuMqUvvbEHdmqdoOc3Vx
         vidzAf5lk5d9ephTm43Zh3lT2l/WPbGsv5tPSq+M5AO8emjc/5f/ItlELkwe5EUaxNfz
         gazJyx9wXtSrtfj+PmmvM3dyPpSq3lhLPVdaGxvQBKvIhppk9kXiDCcrQwfy/3/s9cpV
         Wxhk7RRs1DdTx/6wq8XtZoY44+gyOGjeFj2vzrnROiJugDll/pZ14D6DzBY+rRllXsih
         ZUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509540; x=1793114340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PtTdxBCaK4IP3IjSC3LwSEdRzZKszREp9Gn/OsemyOU=;
        b=Xfv/5P6qJv1bOcwtASrzJCJz6H3VSc7Slw3F//YukJX5C+AxY2e0Psc5ckZMiEXE+n
         Rov99PZQYH0pu35nwQi2fEko1AxaW9j6bZT+8AF7/6nwqQqI+uQ87v/vKKnk0TfZSvzO
         4sWDeU8yHW+p0iWMbsLQ4mMNwsJ78oL8AcKw1PiUqx02OsfdR2lip/BkG4u6b1evnMSX
         b9BWlKowJc3/d7kCsnj+8nmfHDGOPT1v3uq9VR3/2Ny9VIMNvaQQ3CyKeFIhelRQSA5y
         XlC3K5G6WDhhnN46k1Ac4PrvUh2eRTfIszo/ch9zbU4h5YhA6S2JUmrFFLdN+LDIgyCc
         JelA==
X-Forwarded-Encrypted: i=1; AKwUvBwxNSd3hEocXWlpTGJvnq+m3y1E9oQf5YT7WKMqbJ4R0Q/5EP0YnsrObuYFKRurv6QcDdEfn2tcWgRL@lists.infradead.org
X-Gm-Message-State: AFq9FYLSMIlNsWchjqfXYAGc83aeLp5NWRT3JunsKeRfR6u1qM5NPu4w
	llheqzJzSK9jWLAkgArj+aRDWHuTywCI2yPI5lkCCMG9pVwsW9D9W/P6
X-Gm-Gg: AYBFou288zitWyNlp2WAm9V1gKH9oy1pYXIafgeg+ssd4zKP8PPDF4PhEFbYXicvCfG
	S/b0QKd1NHPj9nTgfAxLCIp9M7ARlCR1ODSFFTDRMSbb/JpXkdwfgTyKmGFZ75ewqsq89QeLV9O
	bqok2TMO4ge/Frf0SHbOChuQ1e9LfwOJIRZODn1j11q89Q3uugMhG8MfKXjIzlP08jXPQQD2aZb
	Sz5FMvPogHKvCG+qgsGcGOy26MPZG/msf38s3sLPDA1Zs+yIQEaCWoOPHeAWjFqEfxVpyTpEHKC
	eZ+vzbmIZ+zlhqXiEhc0J6Q+TKrkSSTJwOnfOs7d1o/a8VyZ2Nuy1QlcoaNDyP0nF2hRBpgw/Ys
	TiOkLm2AF9ycMPR1G5BTxFqf9tmhp7mYcTIfAcG9+96+d9i5QT/1gf+4oa1qf2EB0e5VjBdAViN
	quYLz8u7he6I1CJ7CnX/GFE1xtT1Sjws0LLuKVeTM2FzCvsmEj4m/A49pCR2nRV1Ir8Cm7P/MhE
	YCvVml2b9rwt6p30JlvEDPcnIjAq/CIyjIh2Ki7dWE=
X-Received: by 2002:a05:600c:8b06:b0:4a1:efbe:529c with SMTP id 5b1f17b1804b1-4a1f4f7fb72mr60920705e9.12.1792509540249;
        Tue, 20 Oct 2026 08:19:00 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d699dasm84574065e9.12.2026.10.20.08.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:18:59 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 0/4] nvme: add nvmet zone report and FC regression tests
Date: Tue, 20 Oct 2026 17:18:52 +0200
Message-ID: <20261020151854.90498-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atdEpM1uAdi7Dnh1@shinmob>
References: <20261014170046.2516-1-parri.andrea@gmail.com> <atdEpM1uAdi7Dnh1@shinmob>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_081902_365232_562C6AF4 
X-CRM114-Status: GOOD (  13.92  )
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 07:41:42PM +0900, Shin'ichiro Kawasaki wrote:
> Andrea, thank you for this series. I ran the new test cases and they work as
> expected. They all failed with the kernel v7.3, and they all passed with the
> kernel fix patch series.
>
> Overall, the patches in this series look good to me. I made some comments for
> further improvement. Please check and see if they make sense for you.

Thanks for testing and reviewing them.  All of your comments make sense
to me, and I'll address them in v2: configure nullb1 without calling
_init_null_blk(), and use _have_null_blk, so that the tests also run
with a built-in null_blk; rename _identify() to issue_identify(); and
drop the namespace read from the Identify test.

nvme/071 has been taken in the meantime, so v2 will also renumber the
tests to nvme/072-074.

Thanks,
Andrea

