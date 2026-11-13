Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A53606A327
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nylOsvQN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCHyn3Kg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zcmMf7CdjWjEOEGi6f5urh5nlcuJLov2fndk46rGEyU=; b=nylOsvQNYUX0VgY9uZ/eO6okej
	Qwkt4e0ESwXfRJJ0pp+T/1W0WeESALLvmWkW0oifl9g2JnUWB/R+Fht4f4OFSbGloenraX0ee712i
	iPj11OmVivYKZqOD7Xa6OHf7olY5cZWPza+Mo5hk/BNVIBj8LpPKjqXTF4BeGV/UPqtqj19d1imGZ
	bVUiLx9nTj8sMtdMKWY5tA07VHbAT683dk+W3530/WUTwuTEtVuYqYw3qVjdMHV/lT89XYz/BLQgJ
	xw94Ry8vZgQ8fxVvHQp7v2gUAPTv0gRQaUerIlmh2obA/pkBW2VkeJQdwy4CLUOOBxRbm9WkixdEe
	lFFwiuiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRwwZ-0000000EB9I-00Kg;
	Fri, 13 Nov 2026 19:28:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRwwX-0000000EB8a-0h9B
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 19:28:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5641360EF1;
	Fri, 13 Nov 2026 19:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3E11F000C4;
	Fri, 13 Nov 2026 19:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598092;
	bh=zcmMf7CdjWjEOEGi6f5urh5nlcuJLov2fndk46rGEyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iCHyn3KgB7EDsvkdD9BpTDt5lvYJaasvg2OuhAKHoeTJXHdZyBLs+XQP3DHe+VhvV
	 5y7lLGC5ptOCBmo4D9m8MWXnvqWUsAEELbcpJtYW5pT3aalWcdizl/jwpxEWCzdiHG
	 HdQY060FtlsLd9eJ93jpG2t0mbEb4vxps7B+vafwXW3K4wveLn/t1nwIoHCUk/mw4N
	 3PZiXdHoLGsi3qhujf0u1G6dAHckw6mx0ptpNhWqmXxhjmPgTImaY0sZs+/c4y1pxK
	 hidvOnp+6U7WwVAiZF7TT9TwpWSfQIt69OUcUMEJbw9gR9Tmme3Dje7P1sck3UFxry
	 77kloN2lEjPZA==
Message-ID: <sashiko-outbox-213550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] perf tests: Add NVMe PMU event parsing test
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20261113191234.2509964-4-irogers@google.com>
References: <20261113191234.2509964-1-irogers@google.com>
 <20261113191234.2509964-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:28:11 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf tests: suite__nvme_pmu has NULL test_cases when libnvme is
  disabled
--

commit 606f3f12b454f7dd2fdaeea08ae54a0e801abbdb
Author: Ian Rogers <irogers@google.com>

perf tests: Add NVMe PMU event parsing test

This commit adds a unit test suite for the NVMe tool PMU event parser and
registers a helper to create a test NVMe PMU.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 0b8897fd42cac..fbcdcbf92aded 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -110,6 +110,7 @@ static struct test_suite *generic_tests[] =3D {
>  	&suite__pmu,
>  	&suite__pmu_events,
>  	&suite__hwmon_pmu,
> +	&suite__nvme_pmu,
>  	&suite__tool_pmu,
>  	&suite__dso_data,
>  	&suite__perf_evsel__roundtrip_name_test,
> diff --git a/tools/perf/tests/nvme_pmu.c b/tools/perf/tests/nvme_pmu.c
> new file mode 100644
> index 0000000000000..c3c17ccc9ea0b
> --- /dev/null
> +++ b/tools/perf/tests/nvme_pmu.c

[ ... ]

> +#else
> +
> +struct test_suite suite__nvme_pmu =3D {
> +	.desc =3D "NVMe PMU",
> +	.test_cases =3D NULL,
> +};
> +
> +#endif

[Severity: Low]
When HAVE_LIBNVME_SUPPORT is not defined, does setting
suite__nvme_pmu.test_cases to NULL cause __cmd_test() to silently drop the
suite during execution?

generic_tests[] registers suite__nvme_pmu unconditionally, so perf test
list assigns it a suite number, but __cmd_test() only invokes start_test()
and print_test_result() inside test_suite__for_each_test_case(), which
runs zero iterations when test_cases is NULL.  On builds without libnvme,
perf test skips over that suite number without printing a Skip line,
counting it in the skipped summary, or emitting it in JUnit output.
Providing a stub test case that returns TEST_SKIP with a TEST_CASE_REASON
of "not compiled in" (like tools/perf/tests/pfm.c), or guarding
&suite__nvme_pmu in generic_tests[] with HAVE_LIBNVME_SUPPORT, would keep
the suite list and test runner in sync.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113191234.2509=
964-1-irogers@google.com?part=3D3

