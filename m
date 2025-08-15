Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6CECA0EE4
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WTJRa8sI7v5qD7Ekf4MDxSZttFcMDPbqHPYi+8DKOlE=; b=cR+wtsueaFqCepOdYR9nksBs+u
	+6QZBeFUpnG3GCZIrlMhdjSqrBoSom/nssa5Cw+Fy6E8W+ZjCbo3+IWjMsbTcr6vs8ATJjxE6UEMr
	RcvXbPZ5K4MvPmF+NLFp/qeSS0QjQRMLmAD/NSAnFmMTGyvOPLuCi+7AnSSMT71cUs76KJgbMCKbM
	T25iDR4zQJAku3sDYXRK2B4PspnINj7Wt0xk38uuBVRZntvOEwIovjaEonHEURzGI+ng0TxTQUw5M
	fuH1ykmRQAbX5yBew+1dHzNWGLFZXEh9CuoYzFQEsOOvkxraQTodqtaV3Rtw9EaXACcYUBhkXBxW8
	6Yvw3EOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umuGN-00000002YBO-2Fkd;
	Fri, 15 Aug 2025 13:14:31 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umrDL-000000028Jm-3CnV
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 09:59:14 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c3Hd62fJ9zYQvB5
	for <linux-nvme@lists.infradead.org>; Fri, 15 Aug 2025 17:59:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F239C1A1125
	for <linux-nvme@lists.infradead.org>; Fri, 15 Aug 2025 17:59:04 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDnrxDlBJ9or8EHDw--.35151S3;
	Fri, 15 Aug 2025 17:59:03 +0800 (CST)
Message-ID: <1428e3fe-ae7a-410d-97b5-7dd0249c41c0@huaweicloud.com>
Date: Fri, 15 Aug 2025 17:59:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xfsprogs v2] xfs_io: add FALLOC_FL_WRITE_ZEROES support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, hch@lst.de,
 tytso@mit.edu, bmarzins@redhat.com, chaitanyak@nvidia.com,
 shinichiro.kawasaki@wdc.com, brauner@kernel.org, martin.petersen@oracle.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250813024250.2504126-1-yi.zhang@huaweicloud.com>
 <20250814165430.GR7942@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250814165430.GR7942@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDnrxDlBJ9or8EHDw--.35151S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4fKFyrGry8tFWkJF4UXFb_yoW5uF17pa
	47XF1jkFW5Xry7uayfKw4kuF98Xws3tF43Gr4xWr10v3Z8ZF1fKF1DGwsY93s7ur1xCa10
	qFn0gFy3C3WSy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CRM114-CacheID: sfid-20250815_025912_114585_5447F3B1 
X-CRM114-Status: GOOD (  17.19  )
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

On 2025/8/15 0:54, Darrick J. Wong wrote:
> On Wed, Aug 13, 2025 at 10:42:50AM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> The Linux kernel (since version 6.17) supports FALLOC_FL_WRITE_ZEROES in
>> fallocate(2). Add support for FALLOC_FL_WRITE_ZEROES support to the
>> fallocate utility by introducing a new 'fwzero' command in the xfs_io
>> tool.
>>
>> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>> v1->v2:
>>  - Minor description modification to align with the kernel.
>>
>>  io/prealloc.c     | 36 ++++++++++++++++++++++++++++++++++++
>>  man/man8/xfs_io.8 |  6 ++++++
>>  2 files changed, 42 insertions(+)
>>
>> diff --git a/io/prealloc.c b/io/prealloc.c
>> index 8e968c9f..9a64bf53 100644
>> --- a/io/prealloc.c
>> +++ b/io/prealloc.c
>> @@ -30,6 +30,10 @@
>>  #define FALLOC_FL_UNSHARE_RANGE 0x40
>>  #endif
>>  
>> +#ifndef FALLOC_FL_WRITE_ZEROES
>> +#define FALLOC_FL_WRITE_ZEROES 0x80
>> +#endif
>> +
>>  static cmdinfo_t allocsp_cmd;
>>  static cmdinfo_t freesp_cmd;
>>  static cmdinfo_t resvsp_cmd;
>> @@ -41,6 +45,7 @@ static cmdinfo_t fcollapse_cmd;
>>  static cmdinfo_t finsert_cmd;
>>  static cmdinfo_t fzero_cmd;
>>  static cmdinfo_t funshare_cmd;
>> +static cmdinfo_t fwzero_cmd;
>>  
>>  static int
>>  offset_length(
>> @@ -377,6 +382,27 @@ funshare_f(
>>  	return 0;
>>  }
>>  
>> +static int
>> +fwzero_f(
>> +	int		argc,
>> +	char		**argv)
>> +{
>> +	xfs_flock64_t	segment;
>> +	int		mode = FALLOC_FL_WRITE_ZEROES;
> 
> Shouldn't this take a -k to add FALLOC_FL_KEEP_SIZE like fzero?
> 

Since allocating blocks with written extents beyond the inode size
is not permitted, the FALLOC_FL_WRITE_ZEROES flag cannot be used
together with the FALLOC_FL_KEEP_SIZE.

Thanks,
Yi.

> (The code otherwise looks fine to me)
> 
> --D
> 
>> +
>> +	if (!offset_length(argv[1], argv[2], &segment)) {
>> +		exitcode = 1;
>> +		return 0;
>> +	}
>> +
>> +	if (fallocate(file->fd, mode, segment.l_start, segment.l_len)) {
>> +		perror("fallocate");
>> +		exitcode = 1;
>> +		return 0;
>> +	}
>> +	return 0;
>> +}
>> +
>>  void
>>  prealloc_init(void)
>>  {
>> @@ -489,4 +515,14 @@ prealloc_init(void)
>>  	funshare_cmd.oneline =
>>  	_("unshares shared blocks within the range");
>>  	add_command(&funshare_cmd);
>> +
>> +	fwzero_cmd.name = "fwzero";
>> +	fwzero_cmd.cfunc = fwzero_f;
>> +	fwzero_cmd.argmin = 2;
>> +	fwzero_cmd.argmax = 2;
>> +	fwzero_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
>> +	fwzero_cmd.args = _("off len");
>> +	fwzero_cmd.oneline =
>> +	_("zeroes space and eliminates holes by allocating and submitting write zeroes");
>> +	add_command(&fwzero_cmd);
>>  }
>> diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
>> index b0dcfdb7..0a673322 100644
>> --- a/man/man8/xfs_io.8
>> +++ b/man/man8/xfs_io.8
>> @@ -550,6 +550,12 @@ With the
>>  .B -k
>>  option, use the FALLOC_FL_KEEP_SIZE flag as well.
>>  .TP
>> +.BI fwzero " offset length"
>> +Call fallocate with FALLOC_FL_WRITE_ZEROES flag as described in the
>> +.BR fallocate (2)
>> +manual page to allocate and zero blocks within the range by submitting write
>> +zeroes.
>> +.TP
>>  .BI zero " offset length"
>>  Call xfsctl with
>>  .B XFS_IOC_ZERO_RANGE
>> -- 
>> 2.39.2
>>
>>


