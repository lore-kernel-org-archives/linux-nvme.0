Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D736D16260
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r4YD9TMRMEMXi3tkUSnaRNdtmPQ8SEI9Tx6/UEzhniw=; b=O5p2vLHwteSo8dzAeoJbIy51ze
	i4eha022hgAn9mWLJOETOF/kBofHTBSJOJ0dcx6ZkYdd/sZQ9mHAuZT1zVotu7YQTKwbfdWn3SmTd
	CI086DbC86GXreGNckAAsTvL1tqVQJze1hO/KLL5sfd9JIjpnP+C2gT/x01NhvGkSbXCTqe2hc7A6
	fhTfpwCwJ45xDTCD2HCaNuItxQGU9+tCXGHkKvuCeDHtx9Pj0/9jgXvjS4HV+IlBdsyYh2fsq6431
	lbUuaIpPE4Ip9nyuHBJEFVJHch4KEyC7LpmSLwBrCMFyAVpOW1vM8k/2CsHdrfJztd8OjPZWWD3/4
	V3aL034w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0L6k-00000005GoG-3inu;
	Mon, 14 Oct 2024 13:27:34 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0JUu-00000004yIV-0iuv
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 11:44:44 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D7631FB94;
	Mon, 14 Oct 2024 11:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728906262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4YD9TMRMEMXi3tkUSnaRNdtmPQ8SEI9Tx6/UEzhniw=;
	b=wugMEPB8HIpKfT1fssD8RowZNVaW3JOoBMNgyD+JwyEAJQ6CuBtC2LqRR77aPfXhx3Cxyh
	aouQo/oPhApdiAqpjR85uLi8sRZJ3hJVqnvN+uUeaG7pTSHCXIBmU4O8SfA9TU7FtKnLqA
	xy0RXmnMFFyWp/LNgs7Cd4Psb2qbjr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728906262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4YD9TMRMEMXi3tkUSnaRNdtmPQ8SEI9Tx6/UEzhniw=;
	b=g+zsyniKWEGyuW6KwqLMB4HqKXkMOip5Na2gJDqxnhDwFoIRCKcwv2saZEbNogu68YQCYo
	ZhKJJbwJwsH0CsAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728906262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4YD9TMRMEMXi3tkUSnaRNdtmPQ8SEI9Tx6/UEzhniw=;
	b=wugMEPB8HIpKfT1fssD8RowZNVaW3JOoBMNgyD+JwyEAJQ6CuBtC2LqRR77aPfXhx3Cxyh
	aouQo/oPhApdiAqpjR85uLi8sRZJ3hJVqnvN+uUeaG7pTSHCXIBmU4O8SfA9TU7FtKnLqA
	xy0RXmnMFFyWp/LNgs7Cd4Psb2qbjr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728906262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4YD9TMRMEMXi3tkUSnaRNdtmPQ8SEI9Tx6/UEzhniw=;
	b=g+zsyniKWEGyuW6KwqLMB4HqKXkMOip5Na2gJDqxnhDwFoIRCKcwv2saZEbNogu68YQCYo
	ZhKJJbwJwsH0CsAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6180513A51;
	Mon, 14 Oct 2024 11:44:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8dJhFRYEDWdnMwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 14 Oct 2024 11:44:22 +0000
Date: Mon, 14 Oct 2024 13:44:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v4 2/2] nvme: test the nvme reservation feature
Message-ID: <a34131bd-3ff8-4531-9131-1dc35843fb36@flourine.local>
References: <20241014090116.125500-1-kanie@linux.alibaba.com>
 <20241014090116.125500-3-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014090116.125500-3-kanie@linux.alibaba.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_044424_381614_9E8882A6 
X-CRM114-Status: GOOD (  10.30  )
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

On Mon, Oct 14, 2024 at 05:01:16PM GMT, Guixin Liu wrote:
> +resv_report() {
> +	local test_dev=$1
> +	local report_arg=$2
> +
> +	nvme resv-report "${test_dev}" "${report_arg}" | grep -v "hostid" | \
> +		grep -E "gen|rtype|regctl|regctlext|cntlid|rcsts|rkey"

okay, let's see how this goes.

> +test_resv() {
> +	local nvmedev=$1
> +	local report_arg="--cdw11=1"
> +	test_dev="/dev/${nvmedev}n1"

Please use the namespace lookup helper and don't hardcode the namespace
id.


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
> +	local nvmedev
> +	local skipped=false
> +	local subsys_path=""
> +	local ns_path=""
> +
> +	_nvmet_target_setup --blkdev file --resv_enable
> +	subsys_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
> +	ns_path="${subsys_path}/namespaces/1"

Again here, it's better not to hardcode the nsid.


