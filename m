Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83F606A686
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JFEPfr9D;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uLUfOO7M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ykrETQreiYBppW8vVwZgio8KQ+IVfDcttxGfP4v3HPw=; b=JFEPfr9DmHd2Db
	S8FoOK4RA2G/Sjwe/lsyxjvWJjVfqtVCcNwsYt8eLKlJFI6xGtPgsJ0jRWp8qTpAqOPN0DoVcM80t
	truEjcucZ15ULmlib6zmU8TPSOodk3yh3Vzcr44StWJ0S8E9dGmQMcerW5dy1HkTNhBjNp2KyQTFt
	6z27y0gjQ8FrzOn6UoqCXhaXeuE17n2pArXjfeaDWhTQSnvW5xEapnm8sJb4xtJliuN4aJXQxS9TO
	Qn/wFKr6Z+619IyagihwJWBjU3ULEQdDoqMXKBrOFq8IuaRhN8/IRSGnRXAxHaQ6PRjfvZD8ouTWr
	BqIIhjKPWRBiLOHKOKrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW7DZ-00000008pbl-3IQ7;
	Wed, 25 Nov 2026 07:15:01 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW7DW-00000008paj-0MRa
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 07:15:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795590895; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ykrETQreiYBppW8vVwZgio8KQ+IVfDcttxGfP4v3HPw=;
	b=uLUfOO7Mx9yzNqQkFZ0a8h1j8EwRyjKTtG3+UeNfJwO7OVR4IVs8Lk0h0JX7BaEpKNTkSAgBfl17Fshd0gNtFKbBd77X55KVRP85RfgonEXbwGbfqdy7nA9T+RoeK2C8zl71VM1EIAc5XIcf1GDL6dq22Cwmc31miDHwVkl/c2U=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XFQiZhh_1795590894;
Received: from 30.178.67.246(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFQiZhh_1795590894 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 15:14:55 +0800
Message-ID: <c1cc2ed1-1b3b-4462-826f-619f57e7f5c2@linux.alibaba.com>
Date: Wed, 25 Nov 2026 15:14:54 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: zero the reservation report tail beyond NUMD
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261125061453.230238-1-kanie@linux.alibaba.com>
 <sashiko-outbox-232691@kernel.org>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <sashiko-outbox-232691@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_231459_229436_F16251A9 
X-CRM114-Status: GOOD (  16.15  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/25 14:27, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [Critical] nvmet: torn read of rkey in nvmet_pr_update_reg_rkey() [1]
> --
>
> commit 58bea4d71647eb54c1d0685be4714b3cb40c9a6f
> Author: Guixin Liu <kanie@linux.alibaba.com>
>
> nvmet: zero the reservation report tail beyond NUMD
>
> This commit zeroes any remaining bytes in the command SGL beyond the
> requested reservation report size in nvmet_execute_pr_report() so that
> uninitialized kernel memory is not returned to the host.
>
>> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
>> index 8c818f24815bd..63ea607d48646 100644
>> --- a/drivers/nvme/target/pr.c
>> +++ b/drivers/nvme/target/pr.c
>> @@ -900,6 +900,9 @@ static void nvmet_execute_pr_report(struct nvmet_req *req)
>>  
>>  	put_unaligned_le16(num_ctrls, data->regctl);
>>  	status = nvmet_copy_to_sgl(req, 0, data, num_bytes);
>> +	if (!status && req->transfer_len > num_bytes)
>> +		status = nvmet_zero_sgl(req, num_bytes,
>> +					req->transfer_len - num_bytes);
>>  	kfree(data);
>>  out:
>>  	nvmet_req_complete(req, status);
> [Severity: Critical]
> This problem wasn't introduced by this patch, but can RCU readers such as
> nvmet_execute_pr_report() observe a torn 64-bit reg->rkey [1] on
> 32-bit architectures?
>
> When the target registrant is not the current reservation holder,
> nvmet_pr_update_reg_attr() updates the live entry in pr->registrant_list
> in place via nvmet_pr_update_reg_rkey():
>
> drivers/nvme/target/pr.c:nvmet_pr_update_reg_rkey() {
> 	reg->rkey = *(u64 *)attr;
> }
>
> drivers/nvme/target/pr.c:nvmet_pr_update_reg_attr() {
> 	...
> 	if (reg != holder) {
> 		change_attr(reg, attr);
> 		return NVME_SC_SUCCESS;
> 	}
> 	...
> }
>
> On 32-bit systems, the 64-bit store to reg->rkey splits into two 32-bit
> stores, so a concurrent RCU reader can observe half of the old key and
> half of the new key, corrupting the reported key or causing reservation
> validation failures.
>
> [1] https://sashiko.dev/#/bug/linux-b537252d-fab1-48b2-bcc6-de089d7cd907
What Sashiko report is another issue, not the bug this patch introduced.

I will take a look to see if we should fix.

Best Regards,
Guixin Liu
>


