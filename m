Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B070D1815E
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 01:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qlcCM9c/L9Ltc/2G/77Td84iubHBB5fkLEkKeDJVhFE=; b=fbgLBOwqxYpsP5gHGW2wkUsd2C
	xicm7Yh/LEYnRPjI38w2v0yxlGMh+XMbTKEWI3vjtmWPniLfr0aLYZJYO/F+of7VYSS7flEf8fpaP
	0mlIkFoTkOxfvfeEYhelHxeZKxSKWN+gQzu7570Gp2Jg5ODbKQT1Q0ZXdOuX0UfDl+tgJn2UKVySZ
	O5btjt+26s4veYEBL69rIpoTH/p2xJZsj+bG+PMyJ9cznsCbaSOgRqUunu0LbM9FfXXEcD8EFEF1i
	7DGIFwN/fVadhQw04F8VdId3mUKOsTRpBe8VVZNZtPDKCl09e+biHbswrIOGmLsUnFyQw95zpfWRT
	mAWmg7Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0WDi-00000006lFi-0ki1;
	Tue, 15 Oct 2024 01:19:30 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0WDd-00000006lEl-0cz8
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 01:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728955160; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qlcCM9c/L9Ltc/2G/77Td84iubHBB5fkLEkKeDJVhFE=;
	b=qnLj3Zqp9jIGGmaZaYeOM4yUoqsMdsjtfUUs+OTvZ2NLGHcjVZbgcVENeJ4+fShzEGjma3PeW6SrJ5Xg1qSZO5R0Qt6pjSjuk4ECwGP2eFklP0tu4/MZapxcWPVBUKacBDnTfKhB/sIb8T17/+gdXimR4HW4HFe1umwO57QWsdo=
Received: from 30.178.81.198(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHBCQb7_1728955158 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 09:19:19 +0800
Message-ID: <9a14bfe8-320b-468c-aba1-4c57e35fb3da@linux.alibaba.com>
Date: Tue, 15 Oct 2024 09:19:17 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH blktests v4 2/2] nvme: test the nvme reservation feature
To: Daniel Wagner <dwagner@suse.de>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20241014090116.125500-1-kanie@linux.alibaba.com>
 <20241014090116.125500-3-kanie@linux.alibaba.com>
 <a34131bd-3ff8-4531-9131-1dc35843fb36@flourine.local>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <a34131bd-3ff8-4531-9131-1dc35843fb36@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_181926_653282_6FD51A86 
X-CRM114-Status: UNSURE (   7.59  )
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


在 2024/10/14 19:44, Daniel Wagner 写道:
> On Mon, Oct 14, 2024 at 05:01:16PM GMT, Guixin Liu wrote:
>> +resv_report() {
>> +	local test_dev=$1
>> +	local report_arg=$2
>> +
>> +	nvme resv-report "${test_dev}" "${report_arg}" | grep -v "hostid" | \
>> +		grep -E "gen|rtype|regctl|regctlext|cntlid|rcsts|rkey"
> okay, let's see how this goes.
>
>> +test_resv() {
>> +	local nvmedev=$1
>> +	local report_arg="--cdw11=1"
>> +	test_dev="/dev/${nvmedev}n1"
> Please use the namespace lookup helper and don't hardcode the namespace
> id.
>
OK, changed in v5, thanks.

Best Regards,

Guixin Liu

>> +
>> +	if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
>> +		report_arg="--eds"
>> +	fi
>> +
>> +	echo "Register"
>> +	resv_report "${test_dev}" "${report_arg}"
>> +	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
>> +	resv_report "${test_dev}" "${report_arg}"
>> +
>> +	echo "Replace"
>> +	nvme resv-register "${test_dev}" --crkey=4 --nrkey=5 --rrega=2
>> +	resv_report "${test_dev}" "${report_arg}"
>> +
>> +	echo "Unregister"
>> +	nvme resv-register "${test_dev}" --crkey=5 --rrega=1
>> +	resv_report "${test_dev}" "${report_arg}"
>> +
>> +	echo "Acquire"
>> +	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
>> +	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
>> +	resv_report "${test_dev}" "${report_arg}"
>> +
>> +	echo "Preempt"
>> +	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=2 --racqa=1
>> +	resv_report "${test_dev}" "${report_arg}"
>> +
>> +	echo "Release"
>> +	nvme resv-release "${test_dev}" --crkey=4 --rtype=2 --rrela=0
>> +	resv_report "${test_dev}" "${report_arg}"
>> +
>> +	echo "Clear"
>> +	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
>> +	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
>> +	resv_report "${test_dev}" "${report_arg}"
>> +	nvme resv-release "${test_dev}" --crkey=4 --rrela=1
>> +}
>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	_setup_nvmet
>> +
>> +	local nvmedev
>> +	local skipped=false
>> +	local subsys_path=""
>> +	local ns_path=""
>> +
>> +	_nvmet_target_setup --blkdev file --resv_enable
>> +	subsys_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
>> +	ns_path="${subsys_path}/namespaces/1"
> Again here, it's better not to hardcode the nsid.

