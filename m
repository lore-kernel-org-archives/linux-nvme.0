Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A934C5AC7C
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2026 08:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5DGZ3adUTNNdnyrYP8EgpkUxI7/igCgozDgkhEZeJ5M=; b=dajXVsjBLOqu2E3s7foiQwqSX/
	mmJqVzhlTihlAKYd/xrV4kZ5QkkAIj133TqFvSYPNGA8v5VQ4l/LJGVAHf/oW5QcBPr87pRZ/YBeG
	J0/YZQ582O9a38jTTC5LcT553Kn4jAoT5LrAzdYvGTigBPF1QL3BpaYaqqoLy8iwLuMU/mfziYSVC
	9FgbzL3oQlnixLrt0JQ8l2tARwA0HaUuP/4MesB13kzH6UP+FbwBDmLAJAxPdjFZEVjk6ASfmtBdn
	aPwRPoqDVZxpreGsUOaXYz2ZPHKR7bNkDW0guNCeKtHOvATOKZ5AzHTiJcaARKdZWyYFKqrPHZyW5
	etP01p/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsG0F-00000007QQa-2UYE;
	Fri, 07 Aug 2026 08:32:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsG0E-00000007QQB-2xxV
	for linux-nvme@bombadil.infradead.org;
	Fri, 07 Aug 2026 08:32:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=5DGZ3adUTNNdnyrYP8EgpkUxI7/igCgozDgkhEZeJ5M=; b=j6gqE0P9R9vZbajVaLJqEARRE5
	bkokC4BcxcRWqbY3nWeVpVYA7hC8NGR5hdxc+MPA5GJqAzOwvQ4AmmwpZUdR9DbyxWLmZ/uOjrJI9
	jxJkRYxXdr0FfUvuUttI294ncxlNwp8DiHvQNaDNsvJts6wrY1wZIGZSy2o7XChM0bE4sgrKsoUVP
	qOU9gu7NLTVvdo1u1x5l8klAWy2ysVrZQiaXOGHhk9ecj8e9ojDSIAI0f4MxuaIfJj2mTdQXSFF+U
	kawWgiE0UUNZsAC7ES6PAtj+9EzYa9TICG6G6JhY0fcPStpsuccr4RHQ34uOXjr4KPkZpaJ8AEOlb
	YlADO5qQ==;
Received: from out-171.mta0.migadu.com ([2001:41d0:1004:224b::ab])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wsG0B-0000000CCVn-2LS5
	for linux-nvme@lists.infradead.org;
	Fri, 07 Aug 2026 08:32:29 +0000
Message-ID: <a6c21f02-da8c-42bb-a6b8-4c20d14b2197@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786091542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5DGZ3adUTNNdnyrYP8EgpkUxI7/igCgozDgkhEZeJ5M=;
	b=OixhkmUT0ctp55+XkIpSjanHE3NOmumlI0UuCCcUGqTMs6wsmZycy2CGTZ/DuRcxmvEdJT
	X6EZZQtK6A/+wo/cyoiRuxqcTwJD/jjCVkwMEdMqx/jNvT8C8q/wN3tBaznK+u435mVxCa
	z676yeTPym/E/E4RJIELttOQ/cyUHb8=
Date: Fri, 7 Aug 2026 09:32:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH blktests v2] nvme/068: check module reference count with
 patience
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 John Garry <john.g.garry@oracle.com>
Cc: linux-nvme@lists.infradead.org
References: <20260806033146.2067433-1-shinichiro.kawasaki@wdc.com>
 <57644cf9-ecce-4829-b7eb-82375960946e@oracle.com> <anRtGO3CBTh8Sjxj@shinmob>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Garry <john.garry@linux.dev>
In-Reply-To: <anRtGO3CBTh8Sjxj@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_093227_818570_17C107E6 
X-CRM114-Status: GOOD (  14.92  )
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

On 8/6/26 12:30, Shin'ichiro Kawasaki wrote:
>>> +_check_nvme_core_ref_count() {
>>> +	local refcnt i
>>> +
>>> +	for ((i = 0; i < 10; i++)); do
>>> +		refcnt=$(_module_use_count nvme_core)
>>> +		if [ "$refcnt" == "" ] || [ "$refcnt" -eq "$refcnt_orig" ]; then
>> I thought that refcnt_orig was local to test(), so I am unsure how it is
>> accessible in this function...but it seems to work.
> This is a bash uniqueness. Here I quote a relevant paragraph from the Bash
> manual [*]. Some paragraphs follow and explain how bash handles local variable
> scope.
> 
>    Variables local to the function are declared with the local builtin (local
>    variables). Ordinarily, variables and their values are shared between a
>    function and its caller. These variables are visible only to the function and
>    the commands it invokes. This is particularly important when a shell function
>    calls other functions.
> 
> refcnt_orig was declared as a local variable by the caller of
> _check_nvme_core_ref_count(), then it is visible in _check_nvme_core_ref_count()
> also. I used this feature intentionally, but I understand it looks weird. If you
> like, I will update the patch to pass refcnt_orig as a function argument
> instead.
> 
> [*]https://www.gnu.org/software/bash/manual/bash.html#Shell-Functions

Understood, thanks for the info.

BTW, on another topic, it seems to be a common pattern to loop waiting 
for a condition to be true in the blktests codebase, like:

+_check_nvme_core_ref_count() {
+	local refcnt i
+
+	for ((i = 0; i < 10; i++)); do
+		refcnt=$(_module_use_count nvme_core)
+		if [ "$refcnt" == "" ] || [ "$refcnt" -eq "$refcnt_orig" ]; then
+			return 0
+		fi
+		sleep 1
+	done
+	return 1
+}

In the kernel, we have functions like wait_event_timeout(wq_head, 
condition, timeout), which calls @condition and checks the result to 
break the loop and determine success. Could it be possible to have such 
a helper in blktests? I don't know how...

