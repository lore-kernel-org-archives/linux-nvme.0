Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B884AC35242
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 22:06:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8AA20675
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 22:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="glhvdLMS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="A61MxXQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8AA20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FnU+2oBCnyqapoJfO9tfYwRQS0VqZLyuVV3iZLCsBQA=; b=glhvdLMSWvD1U+
	+0ZmrrgLUd6X5wZ5Xf8HXEzFYfQtqX23TAm9fOhcQ6AzR8Eani4bW56ePfDpEGVuV5DDH/izBxV5j
	79k4e0livOJ3jkhemgkvVzdPVfRdrEFbIrWEm1qjtqIsim0yMOmlWC0ePHjgVwYCiSiXw99aixbk9
	zXyBSgJZLqlBXt+EEQl9YwPQhKxE90+EwQ4YTcVE9D3dzTE8FfPm2F+egeGR8qhZDzc/gyuPr5MAs
	RCB0n77itjLGCBOdkgFx9C19iEuoE/F9vTWAY6+1ISmMfx4vxuBSxXcAcTCJ8w06CzdK2+iX8S2A8
	tIAv3LKz7P3dDqmvFHgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1dfX-0001C3-In; Tue, 11 Feb 2020 22:06:11 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1dfU-0001BX-Q6
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 22:06:10 +0000
Received: by mail-pg1-x543.google.com with SMTP id w21so72008pgl.9
 for <linux-nvme@lists.infradead.org>; Tue, 11 Feb 2020 14:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=IiHOtEqkxLxGB5XiLWazg4eRRf+uxs2RVq0bp45DM6A=;
 b=A61MxXQOjmtcC3XssK2NzBZbaHBWHW0KQLXfw2SxI9IBnHWl6yMMb3aWrhKfZWCzUG
 B2FJjLGbUApmmkWXfqNREziqpFoTtsWydep5pFw/LqLBcFHf/2Uv/0oHid9qtN+uTzAO
 bAH9nuGqlYx09oLt7Pr/sYGY6zt5e+UCx3ZVP/idaOiv7JnZye+lnapwTPr4c7AT0rov
 GFai3YawQ6nbYcocgyKkkkNuhSoVfZFikUlu7q2Behn7KEUMZd9+eNbimZHakF7KxBnG
 YffbqgE+9OgmSpmWlD6WBfa0SAKGznZvELdYIbaQ3aZpfpVSP+dx7XksS9ouNL3FV5tr
 SjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IiHOtEqkxLxGB5XiLWazg4eRRf+uxs2RVq0bp45DM6A=;
 b=J4MzLqpRjYQx9y/IibVNAIp0q6eoCMPlhPH5Hl0rcRuQO3kzJTYh/H/XMf70JR6IpV
 Y01YN/GVhTTxVft0jbtFkkKqYMSa2EN3kNjYe0nARJ/oM+3UOWwFPZX+mwdqpqSn0XBZ
 tzB6wjApk7CJ47pUm3q4NU4JraOVShrd1nAuFPC5TBFSOT0b/K1FSmJ3druL6EeYrHm4
 Sn839zziP/WFTQr+1OClZDnSjfps4hzTq4Vqa2sELU2DFJQfA1dXmqt9fFKdMtR/7fii
 UfMMXcAgbSPKtcFj+Znpi+Vl2h7fAE7FkQvE8JhFcvF4xb8ngh145xU/0h6agsAERbcJ
 q+9Q==
X-Gm-Message-State: APjAAAWU9YT6BFBJc2d1326T6+IfXpqQxiwokn18MAd19gAj4xOSFW4f
 Iuzk+EbqvESx0cnvw5c7FC3eYjcyuQg=
X-Google-Smtp-Source: APXvYqyVDUpFjyQiBWQu5KUOyTxnIpoNmUJbQ2q3rWg9s/bSe2Tvd2RSDtOYCjbJZxvxlMpuNyEDsQ==
X-Received: by 2002:a63:d441:: with SMTP id i1mr5470131pgj.426.1581458768093; 
 Tue, 11 Feb 2020 14:06:08 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:80ca])
 by smtp.gmail.com with ESMTPSA id c19sm5842425pfc.144.2020.02.11.14.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 14:06:07 -0800 (PST)
Date: Tue, 11 Feb 2020 14:06:07 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 5/5 blktests] nvme: make new testcases backward compatible
Message-ID: <20200211220607.GF100751@vader>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-6-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200129232921.11771-6-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_140608_850373_EAA193D0 
X-CRM114-Status: GOOD (  15.09  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 29, 2020 at 03:29:21PM -0800, Chaitanya Kulkarni wrote:
> This patch makes newly added testcases backward compatible with
> right value setting into the SKIP_REASON variable.

Oh! These should be part of the new tests from the start. Please
reorganize the series.

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/033 | 60 +++++++++++++++++++++++++++-----------------------
>  tests/nvme/034 | 59 ++++++++++++++++++++++++++-----------------------
>  tests/nvme/rc  | 27 +++++++++++++++++------
>  3 files changed, 83 insertions(+), 63 deletions(-)
> 
> diff --git a/tests/nvme/033 b/tests/nvme/033
> index 97eba7f..db5ded3 100755
> --- a/tests/nvme/033
> +++ b/tests/nvme/033
> @@ -9,49 +9,53 @@
>  DESCRIPTION="Test NVMeOF target cntlid[min|max] attributes"
>  QUICK=1
>  
> +PORT=""
> +NVMEDEV=""
> +LOOP_DEV=""
> +FILE_PATH="$TMPDIR/img"
> +SUBSYS_NAME="blktests-subsystem-1"
> +
> +_have_cid_min_max()
> +{
> +	local cid_min=14
> +	local cid_max=15
> +
> +	_setup_nvmet
> +	truncate -s 1G "${FILE_PATH}"
> +	LOOP_DEV="$(losetup -f --show "${FILE_PATH}")"
> +
> +	# we can only know skip reason when we create a subsys
> +	 _create_nvmet_subsystem "${SUBSYS_NAME}" "${LOOP_DEV}" \
> +		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
> +}
> +
>  requires() {
>  	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> -		_have_configfs
> +		_have_configfs && _have_cid_min_max
>  }
>  
>  test() {
>  	echo "Running ${TEST_NAME}"
>  
> -	_setup_nvmet
> -
> -	local port
> -	local nvmedev
> -	local loop_dev
> -	local cid_min=14
> -	local cid_max=15
> -	local file_path="$TMPDIR/img"
> -	local subsys_name="blktests-subsystem-1"
> -
> -	truncate -s 1G "${file_path}"
> -
> -	loop_dev="$(losetup -f --show "${file_path}")"
> -
> -	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
> -		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
> -	port="$(_create_nvmet_port "loop")"
> -	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> +	PORT="$(_create_nvmet_port "loop")"
> +	_add_nvmet_subsys_to_port "${PORT}" "${SUBSYS_NAME}"
>  
> -	nvme connect -t loop -n "${subsys_name}"
> +	nvme connect -t loop -n "${SUBSYS_NAME}"
>  
>  	udevadm settle
>  
> -	nvmedev="$(_find_nvme_loop_dev)"
> -	nvme id-ctrl /dev/${nvmedev}n1 | grep cntlid | tr -s ' ' ' '
> +	NVMEDEV="$(_find_nvme_loop_dev)"
> +	nvme id-ctrl /dev/${NVMEDEV}n1 | grep cntlid | tr -s ' ' ' '
>  
> -	nvme disconnect -n "${subsys_name}"
> +	nvme disconnect -n "${SUBSYS_NAME}"
>  
> -	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> -	_remove_nvmet_subsystem "${subsys_name}"
> -	_remove_nvmet_port "${port}"
> +	_remove_nvmet_subsystem_from_port "${PORT}" "${SUBSYS_NAME}"
> +	_remove_nvmet_subsystem "${SUBSYS_NAME}"
> +	_remove_nvmet_port "${PORT}"
>  
> -	losetup -d "${loop_dev}"
> +	losetup -d "${LOOP_DEV}"
>  
> -	rm "${file_path}"
> +	rm "${FILE_PATH}"
>  
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/034 b/tests/nvme/034
> index 1a55ff9..39d833f 100755
> --- a/tests/nvme/034
> +++ b/tests/nvme/034
> @@ -9,50 +9,53 @@
>  DESCRIPTION="Test NVMeOF target model attribute"
>  QUICK=1
>  
> +PORT=""
> +NVMEDEV=""
> +LOOP_DEV=""
> +FILE_PATH="$TMPDIR/img"
> +SUBSYS_NAME="blktests-subsystem-1"
> +
> +_have_model()
> +{
> +	local model="test~model"
> +
> +	_setup_nvmet
> +	truncate -s 1G "${FILE_PATH}"
> +	LOOP_DEV="$(losetup -f --show "${FILE_PATH}")"
> +
> +	# we can only know skip reason when we create a subsys
> +	 _create_nvmet_subsystem "${SUBSYS_NAME}" "${LOOP_DEV}" \
> +		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" 14 15 \
> +		${model}
> +}
>  requires() {
>  	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> -		_have_configfs
> +		_have_configfs && _have_model
>  }
>  
>  test() {
>  	echo "Running ${TEST_NAME}"
>  
> -	_setup_nvmet
> -
> -	local port
> -	local result
> -	local nvmedev
> -	local loop_dev
> -	local model="test~model"
> -	local file_path="$TMPDIR/img"
> -	local subsys_name="blktests-subsystem-1"
> -
> -	truncate -s 1G "${file_path}"
> -
> -	loop_dev="$(losetup -f --show "${file_path}")"
> -
> -	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
> -		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" 0 100 ${model}
> -	port="$(_create_nvmet_port "loop")"
> -	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> +	PORT="$(_create_nvmet_port "loop")"
> +	_add_nvmet_subsys_to_port "${PORT}" "${SUBSYS_NAME}"
>  
> -	nvme connect -t loop -n "${subsys_name}"
> +	nvme connect -t loop -n "${SUBSYS_NAME}"
>  
>  	udevadm settle
>  
> -	nvmedev="$(_find_nvme_loop_dev)"
> -	nvme list | grep ${nvmedev}n1 | grep -q test~model
> +	NVMEDEV="$(_find_nvme_loop_dev)"
> +	nvme list | grep ${NVMEDEV}n1 | grep -q test~model
>  	result=$?
>  
> -	nvme disconnect -n "${subsys_name}"
> +	nvme disconnect -n "${SUBSYS_NAME}"
>  
> -	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> -	_remove_nvmet_subsystem "${subsys_name}"
> -	_remove_nvmet_port "${port}"
> +	_remove_nvmet_subsystem_from_port "${PORT}" "${SUBSYS_NAME}"
> +	_remove_nvmet_subsystem "${SUBSYS_NAME}"
> +	_remove_nvmet_port "${PORT}"
>  
> -	losetup -d "${loop_dev}"
> +	losetup -d "${LOOP_DEV}"
>  
> -	rm "${file_path}"
> +	rm "${FILE_PATH}"
>  
>  	if [ ${result} -eq 0 ]; then
>  		echo "Test complete"
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 377c7f7..77bafd8 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -128,15 +128,28 @@ _create_nvmet_subsystem() {
>  
>  	mkdir -p "${cfs_path}"
>  	echo 1 > "${cfs_path}/attr_allow_any_host"
> -	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
> -
> -	if [ $# -eq 5 ] && [ -f ${cfs_path}/attr_cntlid_min ]; then
> -		echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
> -		echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
> +	if [ $# -eq 5 ]; then
> +		if [ -f ${cfs_path}/attr_cntlid_min ]; then
> +			echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
> +			echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
> +		else
> +			SKIP_REASON="attr_cntlid_[min|max] not found"
> +			rmdir "${cfs_path}"
> +			return 1
> +		fi
>  	fi
> -	if [ $# -eq 6 ] && [ -f ${cfs_path}/attr_model ]; then
> -		echo ${model} > ${cfs_path}/attr_model
> +	if [ $# -eq 6 ]; then
> +		if [ -f ${cfs_path}/attr_model ]; then
> +			echo ${model} > ${cfs_path}/attr_model
> +		else
> +			SKIP_REASON="attr_cntlid_model not found"
> +			rmdir "${cfs_path}"
> +			return 1
> +		fi
>  	fi
> +	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
> +
> +	return 0
>  }
>  
>  _remove_nvmet_ns() {
> -- 
> 2.22.1
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
