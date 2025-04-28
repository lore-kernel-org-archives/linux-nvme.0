Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7521C369D9
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 09:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d/bNeTdvjHYrvtVqneHMpZo6cI8ZgzfDVJVEbW+R4ak=; b=BJPJCnenhF9gWSjJkhnLCqgmDq
	C/hDM41yYj5YevgmWvXlbNd5rzR/PZaeyF65Vuh1YxfMOO9R0/5zSOZ7qkeBXpl4ucduhElFOyFqC
	pSm5QArnAdfE33BaeZ5ehH2SOgTnHCvVXGTd0+9v7zXtfb+ylaElyh8DD6gqpOxtLO0IUiCcu5MPo
	1CqzH3AB80DvGhwrjAV/n3aEsshI76DTZN6YLlpGIGPzHhfDVQJfRCvC25iF+c1NQ/XFRBJaEKX56
	e3yCk2QvnV5plTmAx8ShcTtFfrfzSTRdTOGXknxXdUnjbAzfW94FRuXAeO4UVBDzpCOYtRvDadizt
	rRf4M2yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9KoX-00000005cvd-3vgR;
	Mon, 28 Apr 2025 09:30:13 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9KPs-00000005Xqh-1KfB
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 09:04:46 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ZmHZY5x2gzKHLxh
	for <linux-nvme@lists.infradead.org>; Mon, 28 Apr 2025 17:04:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CB0091A18F0
	for <linux-nvme@lists.infradead.org>; Mon, 28 Apr 2025 17:04:36 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2CiRA9o7nM7Kw--.50307S3;
	Mon, 28 Apr 2025 17:04:36 +0800 (CST)
Message-ID: <a5d847d1-9799-4294-ac8f-e78d73e3733d@huaweicloud.com>
Date: Mon, 28 Apr 2025 17:04:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/3] dm/003: add unmap write zeroes tests
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 hch <hch@lst.de>, "tytso@mit.edu" <tytso@mit.edu>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
 "bmarzins@redhat.com" <bmarzins@redhat.com>,
 "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
 "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
 "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
 "yukuai3@huawei.com" <yukuai3@huawei.com>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
 <20250318072835.3508696-3-yi.zhang@huaweicloud.com>
 <t4vmmsupkbffrp3p33okbdjtf6il2ahp5omp2s5fvuxkngipeo@4thxzp4zlcse>
 <7b0319ac-cad4-4285-800c-b1e18ee4d92b@huaweicloud.com>
 <6p2dh577oiqe7lfaexv4fzct4aqhc56lxrz2ecwwctvbuxrjx3@oual7hmxfiqc>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <6p2dh577oiqe7lfaexv4fzct4aqhc56lxrz2ecwwctvbuxrjx3@oual7hmxfiqc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDHK2CiRA9o7nM7Kw--.50307S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4DXFWxKw1xCw17Xr1kKrg_yoW5KF4kpr
	yfAFyvyrW7KF12qr1jvF1fZr1ayw4rGw17Xw13Jry0y3yDZr1agFZ7KF4Uuas7XrW3uF40
	vay7Wa9I9w15tFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_020444_710939_84E47749 
X-CRM114-Status: GOOD (  20.50  )
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

On 2025/4/28 16:13, Shinichiro Kawasaki wrote:
> On Apr 28, 2025 / 12:32, Zhang Yi wrote:
>> On 2025/4/3 15:43, Shinichiro Kawasaki wrote:
> [...]
>>>> +
>>>> +setup_test_device() {
>>>> +	if ! _configure_scsi_debug "$@"; then
>>>> +		return 1
>>>> +	fi
>>>
>>> In same manner as the 1st patch, I suggest to check /queue/write_zeroes_unmap
>>> here.
>>>
>>> 	if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap ]]; then
>>> 		_exit_scsi_debug
>>> 		SKIP_REASONS+=("kernel does not support unmap write zeroes sysfs interface")
>>> 		return 1
>>> 	fi
>>>
>>> The caller will need to check setup_test_device() return value.
>>
>> Sure.
>>
>>>
>>>> +
>>>> +	local dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
>>>> +	local blk_sz="$(blockdev --getsz "$dev")"
>>>> +	dmsetup create test --table "0 $blk_sz linear $dev 0"
>>>
>>> I suggest to call _real_dev() here, and echo back the device name.
>>>
>>> 	dpath=$(_real_dev /dev/mapper/test)
>>> 	echo ${dpath##*/}
>>>
>>> The bash parameter expansion ${xxx##*/} works in same manner as the basename
>>> command. The caller can receive the device name in a local variable. This will
>>> avoid a bit of code duplication, and allow to avoid _short_dev().
>>>
>>
>> I'm afraid this approach will not work since we may set the
>> SKIP_REASONS parameter. We cannot pass the device name in this
>> manner as it will overlook the SKIP_REASONS setting when the caller
>> invokes $(setup_test_device xxx), this function runs in a subshell.
> 
> Ah, that's right. SKIP_REASONS modification in subshell won't work.
> 
>>
>> If you don't like _short_dev(), I think we can pass dname through a
>> global variable, something like below:
>>
>> setup_test_device() {
>> 	...
>> 	dpath=$(_real_dev /dev/mapper/test)
>> 	dname=${dpath##*/}
>> }
>>
>> if ! setup_test_device lbprz=0; then
>> 	return 1
>> fi
>> umap="$(< "/sys/block/${dname}/queue/write_zeroes_unmap")"
>>
>> What do you think?
> 
> I think global variable is a bit dirty. So my suggestion is to still echo back
> the short device name from the helper, and set the SKIP_REASONS after calling
> the helper, as follows:
> 
> diff --git a/tests/dm/003 b/tests/dm/003
> index 1013eb5..e00fa99 100755
> --- a/tests/dm/003
> +++ b/tests/dm/003
> @@ -20,13 +20,23 @@ device_requries() {
>  }
>  
>  setup_test_device() {
> +	local dev blk_sz dpath
> +
>  	if ! _configure_scsi_debug "$@"; then
>  		return 1

Hmm, if we encounter an error here, the test will be skipped instead of
returning a failure. This is not the expected outcome.

Thanks,
Yi.

>  	fi
>  
> -	local dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
> -	local blk_sz="$(blockdev --getsz "$dev")"
> +        if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap ]]; then
> +		_exit_scsi_debug
> +                return 1
> +        fi
> +
> +	dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
> +	blk_sz="$(blockdev --getsz "$dev")"
>  	dmsetup create test --table "0 $blk_sz linear $dev 0"
> +
> +	dpath=$(_real_dev /dev/mapper/test)
> +	echo ${dpath##*/}
>  }
>  
>  cleanup_test_device() {
> @@ -38,17 +48,21 @@ test() {
>  	echo "Running ${TEST_NAME}"
>  
>  	# disable WRITE SAME with unmap
> -	setup_test_device lbprz=0
> -	umap="$(cat "/sys/block/$(_short_dev /dev/mapper/test)/queue/write_zeroes_unmap")"
> +	local dname
> +	if ! dname=$(setup_test_device lbprz=0); then
> +		SKIP_REASONS+=("kernel does not support unmap write zeroes sysfs interface")
> +		return 1
> +	fi
> +	umap="$(cat "/sys/block/${dname}/queue/zoned")"
>  	if [[ $umap -ne 0 ]]; then
>  		echo "Test disable WRITE SAME with unmap failed."
>  	fi
>  	cleanup_test_device
> 


