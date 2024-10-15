Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07284CFC267
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 05:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=alOGch4zkJfB39/mcydvV5EYgE69+94ctOo1z8AD8Gk=; b=pXX7Gm42YwGP/F9olS8CQSryva
	2YoV5WSZjy68j4939vr+cE0NoEreKF8rhVh4noAm/g8QkG3pEuA8ZZX7YRaBsCp/r/NRJMPwrKdz5
	QlSiTkUPqMUhZEj/EfjONOJG5K/67UyLIKVhhxeVOYmxfLTgHQklTHgYqxMykcMDs7ZSpQpBHBFa0
	Lenzn49rQsEjKehWkWIDlZvLmBNbEDyO4vfWB49MSwNiey/4zuU4HcZF4+hldxUrzljj42cTGWVeA
	s7uilEX7f7Zt3uCELSfO5DIabkjDc6zhV/mXCsIVdgZBBKd+CNMJ3Vcr0HyZQhQcZEl5SJwfH+fWY
	FF4H04Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0aaA-000000079Yt-17lJ;
	Tue, 15 Oct 2024 05:58:58 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0aa3-000000079Xi-3BKk
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 05:58:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9986621BD9;
	Tue, 15 Oct 2024 05:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728971929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alOGch4zkJfB39/mcydvV5EYgE69+94ctOo1z8AD8Gk=;
	b=gr0eNZrern9+G96Oji6U0l05WMtFEi7aqbcWRUHb54cc68PupLWbQbK1XSKa7vassx5O0n
	5pyGoNcrHnEGALfUxSo6FgbIYB03A6oXjRueJicQCm/DMfD3OBk9nc0WMKuHIwBzQYm+Nh
	SbF5d6Loqf6aUayLGkA+o/fsRmMthug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728971929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alOGch4zkJfB39/mcydvV5EYgE69+94ctOo1z8AD8Gk=;
	b=G2/WHTVsITndJ4q1mwgYdff3YfQWnPszmam/b9iE+RvGLipJf9WYrPk4moKcoEt3Sa6DyE
	S0AnI8TM5PDGcFAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gr0eNZre;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="G2/WHTVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728971929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alOGch4zkJfB39/mcydvV5EYgE69+94ctOo1z8AD8Gk=;
	b=gr0eNZrern9+G96Oji6U0l05WMtFEi7aqbcWRUHb54cc68PupLWbQbK1XSKa7vassx5O0n
	5pyGoNcrHnEGALfUxSo6FgbIYB03A6oXjRueJicQCm/DMfD3OBk9nc0WMKuHIwBzQYm+Nh
	SbF5d6Loqf6aUayLGkA+o/fsRmMthug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728971929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alOGch4zkJfB39/mcydvV5EYgE69+94ctOo1z8AD8Gk=;
	b=G2/WHTVsITndJ4q1mwgYdff3YfQWnPszmam/b9iE+RvGLipJf9WYrPk4moKcoEt3Sa6DyE
	S0AnI8TM5PDGcFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80CA213A53;
	Tue, 15 Oct 2024 05:58:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FnkNHZkEDmfgYgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 15 Oct 2024 05:58:49 +0000
Date: Tue, 15 Oct 2024 07:58:48 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v5 2/2] nvme: test the nvme reservation feature
Message-ID: <6a983a2b-c3ab-4948-8bfd-4d3e2cfde88c@flourine.local>
References: <20241015024350.16271-1-kanie@linux.alibaba.com>
 <20241015024350.16271-3-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015024350.16271-3-kanie@linux.alibaba.com>
X-Rspamd-Queue-Id: 9986621BD9
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_225851_985603_C20093C5 
X-CRM114-Status: GOOD (  16.62  )
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

On Tue, Oct 15, 2024 at 10:43:50AM GMT, Guixin Liu wrote:
> Test the NVMe reservation feature, including register, acquire,
> release and report.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Looks good to me. Thanks!

Reviewed-by: Daniel Wagner <dwagner@suse.de>

> ---
>  tests/nvme/054     | 101 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/054.out |  68 ++++++++++++++++++++++++++++++
>  2 files changed, 169 insertions(+)
>  create mode 100644 tests/nvme/054
>  create mode 100644 tests/nvme/054.out
> 
> diff --git a/tests/nvme/054 b/tests/nvme/054
> new file mode 100644
> index 0000000..71c625c
> --- /dev/null
> +++ b/tests/nvme/054
> @@ -0,0 +1,101 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Guixin Liu
> +# Copyright (C) 2024 Alibaba Group.
> +#
> +# Test the NVMe reservation feature
> +#
> +. tests/nvme/rc
> +
> +DESCRIPTION="Test the NVMe reservation feature"
> +QUICK=1
> +nvme_trtype="loop"
> +
> +requires() {
> +	_nvme_requires
> +}
> +
> +resv_report() {
> +	local test_dev=$1
> +	local report_arg=$2
> +
> +	nvme resv-report "${test_dev}" "${report_arg}" | grep -v "hostid" | \
> +		grep -E "gen|rtype|regctl|regctlext|cntlid|rcsts|rkey"
> +}
> +
> +test_resv() {
> +	local ns=$1
> +	local report_arg="--cdw11=1"
> +	test_dev="/dev/${ns}"
> +
> +	if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
> +		report_arg="--eds"
> +	fi
> +
> +	echo "Register"
> +	resv_report "${test_dev}" "${report_arg}"
> +	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
> +	resv_report "${test_dev}" "${report_arg}"
> +
> +	echo "Replace"
> +	nvme resv-register "${test_dev}" --crkey=4 --nrkey=5 --rrega=2
> +	resv_report "${test_dev}" "${report_arg}"
> +
> +	echo "Unregister"
> +	nvme resv-register "${test_dev}" --crkey=5 --rrega=1
> +	resv_report "${test_dev}" "${report_arg}"
> +
> +	echo "Acquire"
> +	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
> +	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
> +	resv_report "${test_dev}" "${report_arg}"
> +
> +	echo "Preempt"
> +	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=2 --racqa=1
> +	resv_report "${test_dev}" "${report_arg}"
> +
> +	echo "Release"
> +	nvme resv-release "${test_dev}" --crkey=4 --rtype=2 --rrela=0
> +	resv_report "${test_dev}" "${report_arg}"
> +
> +	echo "Clear"
> +	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
> +	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
> +	resv_report "${test_dev}" "${report_arg}"
> +	nvme resv-release "${test_dev}" --crkey=4 --rrela=1
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	local ns
> +	local skipped=false
> +	local subsys_path=""
> +	local ns_path=""
> +
> +	_nvmet_target_setup --blkdev file --resv_enable
> +	subsys_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
> +	_nvme_connect_subsys
> +
> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
> +	ns_id=$(echo "${ns}" | grep -oE '[0-9]+' | sed -n '2p')
> +	ns_path="${subsys_path}/namespaces/${ns_id}"
> +
> +	if [[ -f "${ns_path}/resv_enable" ]] ; then
> +		test_resv "${ns}"
> +	else
> +		SKIP_REASONS+=("missing reservation feature")
> +		skipped=true
> +	fi
> +
> +	_nvme_disconnect_subsys
> +	_nvmet_target_cleanup
> +
> +	if [[ "${skipped}" = true ]] ; then
> +		return 1
> +	fi
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/054.out b/tests/nvme/054.out
> new file mode 100644
> index 0000000..5adb30d
> --- /dev/null
> +++ b/tests/nvme/054.out
> @@ -0,0 +1,68 @@
> +Running nvme/054
> +Register
> +gen       : 0
> +rtype     : 0
> +regctl    : 0
> +NVME Reservation  success
> +gen       : 1
> +rtype     : 0
> +regctl    : 1
> +regctlext[0] :
> +  cntlid     : ffff
> +  rcsts      : 0
> +  rkey       : 4
> +Replace
> +NVME Reservation  success
> +gen       : 2
> +rtype     : 0
> +regctl    : 1
> +regctlext[0] :
> +  cntlid     : ffff
> +  rcsts      : 0
> +  rkey       : 5
> +Unregister
> +NVME Reservation  success
> +gen       : 3
> +rtype     : 0
> +regctl    : 0
> +Acquire
> +NVME Reservation  success
> +NVME Reservation Acquire success
> +gen       : 4
> +rtype     : 1
> +regctl    : 1
> +regctlext[0] :
> +  cntlid     : ffff
> +  rcsts      : 1
> +  rkey       : 4
> +Preempt
> +NVME Reservation Acquire success
> +gen       : 5
> +rtype     : 2
> +regctl    : 1
> +regctlext[0] :
> +  cntlid     : ffff
> +  rcsts      : 1
> +  rkey       : 4
> +Release
> +NVME Reservation Release success
> +gen       : 5
> +rtype     : 0
> +regctl    : 1
> +regctlext[0] :
> +  cntlid     : ffff
> +  rcsts      : 0
> +  rkey       : 4
> +Clear
> +NVME Reservation  success
> +NVME Reservation Acquire success
> +gen       : 6
> +rtype     : 1
> +regctl    : 1
> +regctlext[0] :
> +  cntlid     : ffff
> +  rcsts      : 1
> +  rkey       : 4
> +NVME Reservation Release success
> +disconnected 1 controller(s)
> +Test complete
> -- 
> 2.43.0
> 

